const { useState: useStateCtrl, useEffect: useEffectCtrl, useRef: useRefCtrl, useMemo: useMemoCtrl } = React;

// ---------- DATE PICKER ----------
function fmtDate(iso) {
  if (!iso) return '';
  const d = new Date(iso + 'T00:00:00');
  return d.toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric' });
}
function toISO(d) {
  return d.toISOString().slice(0, 10);
}
function daysBetween(a, b) {
  if (!a || !b) return 0;
  return Math.round((new Date(b) - new Date(a)) / 86400000);
}
function daysFromToday(iso) {
  if (!iso) return 0;
  return Math.max(0, Math.round((new Date(iso) - new Date(toISO(new Date()))) / 86400000));
}

function MonthGrid({ year, month, depart, ret, onPick, min }) {
  const first = new Date(year, month, 1);
  const startDay = first.getDay(); // 0=Sun
  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const cells = [];
  for (let i = 0; i < startDay; i++) cells.push(null);
  for (let d = 1; d <= daysInMonth; d++) cells.push(d);

  const monthName = first.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
  const minDate = new Date(min + 'T00:00:00');

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '4px 6px 10px', borderBottom: '1px solid var(--rule-soft)' }}>
        <span className="serif italic" style={{ fontSize: 18 }}>{monthName}</span>
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: 2, marginTop: 10 }}>
        {['S','M','T','W','T','F','S'].map((d,i) => (
          <div key={i} className="mono caps" style={{ textAlign: 'center', fontSize: 9, color: 'var(--ink-faint)', padding: '2px 0' }}>{d}</div>
        ))}
        {cells.map((d, i) => {
          if (d == null) return <div key={i} />;
          const dt = new Date(year, month, d);
          const iso = toISO(dt);
          const isPast = dt < minDate;
          const isDepart = iso === depart;
          const isReturn = iso === ret;
          const inRange = depart && ret && iso > depart && iso < ret;
          const endpoint = isDepart || isReturn;
          return (
            <button
              key={i}
              disabled={isPast}
              onClick={() => onPick(iso)}
              style={{
                aspectRatio: '1', borderRadius: 6,
                background: endpoint ? 'var(--ink)' : inRange ? 'var(--sunset-wash)' : 'transparent',
                color: endpoint ? 'var(--paper)' : isPast ? 'var(--ink-faint)' : 'var(--ink)',
                opacity: isPast ? 0.4 : 1,
                fontSize: 13, fontWeight: endpoint ? 600 : 400,
                cursor: isPast ? 'not-allowed' : 'pointer',
                transition: 'background .12s',
              }}
              onMouseEnter={e => { if (!endpoint && !inRange && !isPast) e.currentTarget.style.background = 'var(--bg-warm)'; }}
              onMouseLeave={e => { if (!endpoint && !inRange && !isPast) e.currentTarget.style.background = 'transparent'; }}
            >{d}</button>
          );
        })}
      </div>
    </div>
  );
}

function DateRangePicker({ depart, ret, onChange, label }) {
  const [open, setOpen] = useStateCtrl(false);
  const [viewDate, setViewDate] = useStateCtrl(() => {
    const d = depart ? new Date(depart + 'T00:00:00') : new Date();
    return new Date(d.getFullYear(), d.getMonth(), 1);
  });
  const rootRef = useRefCtrl(null);
  const today = toISO(new Date());

  useEffectCtrl(() => {
    const onDoc = e => { if (rootRef.current && !rootRef.current.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', onDoc);
    return () => document.removeEventListener('mousedown', onDoc);
  }, []);

  const pick = iso => {
    if (!depart || (depart && ret)) {
      onChange(iso, null);
    } else {
      if (iso < depart) onChange(iso, null);
      else onChange(depart, iso);
    }
  };

  const nights = daysBetween(depart, ret);
  const nextMonth = new Date(viewDate.getFullYear(), viewDate.getMonth() + 1, 1);

  return (
    <div ref={rootRef} style={{ position: 'relative' }}>
      <div className="caps" style={{ marginBottom: 8 }}>{label}</div>
      <button
        onClick={() => setOpen(o => !o)}
        className="focus-ring"
        style={{
          display: 'block', width: '100%', textAlign: 'left',
          padding: '6px 0', borderBottom: `1px solid ${open ? 'var(--ink)' : 'var(--rule)'}`,
        }}
      >
        <div style={{ display: 'flex', alignItems: 'baseline', gap: 14, flexWrap: 'wrap' }}>
          <div>
            <div className="mono caps" style={{ fontSize: 9, color: 'var(--ink-faint)' }}>DEPART</div>
            <div className="serif" style={{ fontSize: 24, lineHeight: 1.1 }}>
              {depart ? fmtDate(depart) : <span className="italic" style={{ color: 'var(--ink-faint)' }}>Pick a day</span>}
            </div>
          </div>
          <div style={{ fontSize: 18, color: 'var(--ink-faint)' }}>→</div>
          <div>
            <div className="mono caps" style={{ fontSize: 9, color: 'var(--ink-faint)' }}>RETURN</div>
            <div className="serif" style={{ fontSize: 24, lineHeight: 1.1 }}>
              {ret ? fmtDate(ret) : <span className="italic" style={{ color: 'var(--ink-faint)' }}>One-way?</span>}
            </div>
          </div>
          {nights > 0 && (
            <span className="mono" style={{ marginLeft: 'auto', fontSize: 11, color: 'var(--sunset-deep)' }}>
              {nights} night{nights > 1 ? 's' : ''}
            </span>
          )}
        </div>
      </button>

      {open && (
        <div style={{
          position: 'absolute', top: 'calc(100% + 8px)', left: 0, zIndex: 30, width: 620,
          maxWidth: 'calc(100vw - 40px)',
          background: 'var(--paper)', border: '1px solid var(--rule)', borderRadius: 12,
          boxShadow: '0 24px 50px -20px oklch(0.2 0.02 60 / 0.35), 0 2px 6px oklch(0.2 0.02 60 / 0.06)',
          padding: 18,
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
            <button
              onClick={() => setViewDate(new Date(viewDate.getFullYear(), viewDate.getMonth() - 1, 1))}
              style={{ padding: '6px 10px', borderRadius: 6, fontSize: 14 }}
              onMouseEnter={e => e.currentTarget.style.background = 'var(--bg-warm)'}
              onMouseLeave={e => e.currentTarget.style.background = 'transparent'}
            >←</button>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>Select a range</div>
            <button
              onClick={() => setViewDate(new Date(viewDate.getFullYear(), viewDate.getMonth() + 1, 1))}
              style={{ padding: '6px 10px', borderRadius: 6, fontSize: 14 }}
              onMouseEnter={e => e.currentTarget.style.background = 'var(--bg-warm)'}
              onMouseLeave={e => e.currentTarget.style.background = 'transparent'}
            >→</button>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 24 }}>
            <MonthGrid year={viewDate.getFullYear()} month={viewDate.getMonth()} depart={depart} ret={ret} onPick={pick} min={today}/>
            <MonthGrid year={nextMonth.getFullYear()} month={nextMonth.getMonth()} depart={depart} ret={ret} onPick={pick} min={today}/>
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 16, paddingTop: 12, borderTop: '1px solid var(--rule-soft)' }}>
            <button
              onClick={() => onChange(null, null)}
              className="mono caps" style={{ color: 'var(--ink-soft)' }}
            >Clear</button>
            <button
              onClick={() => setOpen(false)}
              className="mono caps"
              style={{ background: 'var(--ink)', color: 'var(--paper)', padding: '8px 14px', borderRadius: 6 }}
            >Done</button>
          </div>
        </div>
      )}
    </div>
  );
}

// ---------- CABIN SELECTOR ----------
function CabinSelector({ value, onChange }) {
  return (
    <div>
      <div className="caps" style={{ marginBottom: 10 }}>Cabin class</div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 8 }}>
        {CABINS.map(c => {
          const active = value === c.id;
          return (
            <button
              key={c.id}
              onClick={() => onChange(c.id)}
              className="focus-ring"
              style={{
                textAlign: 'left', padding: '12px 12px 14px', borderRadius: 10,
                background: active ? 'var(--ink)' : 'var(--paper)',
                color: active ? 'var(--paper)' : 'var(--ink)',
                border: `1px solid ${active ? 'var(--ink)' : 'var(--rule)'}`,
                transition: 'all .15s',
              }}
              onMouseEnter={e => { if (!active) e.currentTarget.style.borderColor = 'var(--ink-faint)'; }}
              onMouseLeave={e => { if (!active) e.currentTarget.style.borderColor = 'var(--rule)'; }}
            >
              <div className="mono caps" style={{ fontSize: 9, opacity: active ? 0.7 : 0.55 }}>{c.tag}</div>
              <div className="serif" style={{ fontSize: 19, lineHeight: 1.1, marginTop: 2 }}>{c.name}</div>
              <div style={{ fontSize: 11, marginTop: 6, opacity: active ? 0.85 : 0.7 }}>{c.perk}</div>
            </button>
          );
        })}
      </div>
    </div>
  );
}

// ---------- PASSENGER STEPPER ----------
function PaxStepper({ value, onChange }) {
  return (
    <div>
      <div className="caps" style={{ marginBottom: 10 }}>Passengers</div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 14, padding: '6px 0', borderBottom: '1px solid var(--rule)' }}>
        <button
          onClick={() => onChange(Math.max(1, value - 1))}
          style={{
            width: 34, height: 34, borderRadius: '50%', border: '1px solid var(--rule)',
            fontSize: 16, background: 'var(--paper)',
          }}
          onMouseEnter={e => e.currentTarget.style.borderColor = 'var(--ink)'}
          onMouseLeave={e => e.currentTarget.style.borderColor = 'var(--rule)'}
        >−</button>
        <div style={{ flex: 1, textAlign: 'center' }}>
          <div className="serif" style={{ fontSize: 28, lineHeight: 1 }}>{value}</div>
          <div className="mono caps" style={{ fontSize: 9, color: 'var(--ink-faint)', marginTop: 3 }}>
            {value === 1 ? 'traveler' : 'travelers'}
          </div>
        </div>
        <button
          onClick={() => onChange(Math.min(9, value + 1))}
          style={{
            width: 34, height: 34, borderRadius: '50%', border: '1px solid var(--rule)',
            fontSize: 16, background: 'var(--paper)',
          }}
          onMouseEnter={e => e.currentTarget.style.borderColor = 'var(--ink)'}
          onMouseLeave={e => e.currentTarget.style.borderColor = 'var(--rule)'}
        >+</button>
      </div>
    </div>
  );
}

// ---------- PROMO CODE ----------
function PromoField({ applied, onApply, onClear }) {
  const [v, setV] = useStateCtrl('');
  const [err, setErr] = useStateCtrl('');

  const submit = () => {
    const code = v.trim().toUpperCase();
    if (!code) return;
    const p = PROMOS[code];
    if (!p) { setErr('That code isn\u2019t valid — try MERIDIAN10'); return; }
    setErr('');
    onApply(code, p);
    setV('');
  };

  if (applied) {
    return (
      <div>
        <div className="caps" style={{ marginBottom: 8 }}>Promo code</div>
        <div style={{
          display: 'flex', alignItems: 'center', gap: 10,
          padding: '10px 12px', borderRadius: 8,
          background: 'oklch(0.95 0.04 150)', border: '1px dashed var(--success)',
        }}>
          <span style={{ color: 'var(--success)', fontSize: 16 }}>✓</span>
          <div style={{ flex: 1 }}>
            <div className="mono" style={{ fontSize: 13, fontWeight: 600 }}>{applied.code}</div>
            <div style={{ fontSize: 12, color: 'var(--ink-soft)' }}>{applied.label}</div>
          </div>
          <button onClick={onClear} className="mono caps" style={{ color: 'var(--ink-soft)', fontSize: 10 }}>Remove</button>
        </div>
      </div>
    );
  }

  return (
    <div>
      <div className="caps" style={{ marginBottom: 8 }}>Promo code</div>
      <div style={{ display: 'flex', gap: 8 }}>
        <input
          value={v}
          onChange={e => { setV(e.target.value.toUpperCase()); setErr(''); }}
          onKeyDown={e => e.key === 'Enter' && submit()}
          placeholder="e.g. SUNSET25"
          className="mono focus-ring"
          style={{
            flex: 1, padding: '8px 10px', border: '1px solid var(--rule)', borderRadius: 6,
            background: 'var(--paper)', fontSize: 13, letterSpacing: '0.08em',
          }}
        />
        <button
          onClick={submit}
          className="mono caps"
          style={{
            padding: '0 14px', borderRadius: 6, fontSize: 10,
            background: 'var(--ink)', color: 'var(--paper)',
          }}
        >Apply</button>
      </div>
      {err ? (
        <div style={{ fontSize: 11, color: 'var(--error)', marginTop: 6 }}>{err}</div>
      ) : (
        <div style={{ fontSize: 11, color: 'var(--ink-faint)', marginTop: 6 }}>
          Try <span className="mono">MERIDIAN10</span>, <span className="mono">SUNSET25</span>, or <span className="mono">LOYAL50</span>
        </div>
      )}
    </div>
  );
}

Object.assign(window, { DateRangePicker, CabinSelector, PaxStepper, PromoField, fmtDate, daysBetween, daysFromToday, toISO });
