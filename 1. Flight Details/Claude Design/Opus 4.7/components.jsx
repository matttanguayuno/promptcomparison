const { useState, useEffect, useRef, useMemo } = React;

// ---------- LOGO ----------
function Logo({ size = 28 }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
      <svg width={size} height={size} viewBox="0 0 40 40" fill="none">
        <circle cx="20" cy="20" r="19" stroke="var(--ink)" strokeWidth="1.2"/>
        <path d="M8 24 L20 8 L32 24 M8 24 L20 20 L32 24 M20 8 L20 32" stroke="var(--ink)" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round"/>
        <circle cx="20" cy="20" r="2" fill="var(--sunset)"/>
      </svg>
      <div style={{ lineHeight: 1 }}>
        <div className="serif italic" style={{ fontSize: 22, letterSpacing: -0.2 }}>Meridian</div>
        <div className="mono caps" style={{ fontSize: 9, marginTop: 2, color: 'var(--ink-faint)' }}>AIR · EST 1962</div>
      </div>
    </div>
  );
}

// ---------- STRIPED DESTINATION PLACEHOLDER ----------
function DestinationPlaceholder({ city, label, hue = 40, height = 180 }) {
  const stripes = `repeating-linear-gradient(135deg, oklch(0.75 0.12 ${hue} / 0.35) 0 10px, oklch(0.85 0.08 ${hue} / 0.3) 10px 20px)`;
  return (
    <div style={{
      position: 'relative', width: '100%', height, borderRadius: 10, overflow: 'hidden',
      background: `linear-gradient(180deg, oklch(0.9 0.05 ${hue}), oklch(0.78 0.1 ${hue}))`,
      border: '1px solid var(--rule)',
    }}>
      <div style={{ position: 'absolute', inset: 0, background: stripes }} />
      <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(180deg, transparent 55%, oklch(0.25 0.04 60 / 0.35))' }}/>
      <div style={{ position: 'absolute', left: 14, right: 14, bottom: 12, color: 'oklch(0.98 0.01 80)' }}>
        <div className="mono caps" style={{ fontSize: 10, opacity: 0.9 }}>{label}</div>
        <div className="serif italic" style={{ fontSize: 26, lineHeight: 1 }}>{city}</div>
      </div>
      <div className="mono" style={{ position: 'absolute', top: 10, right: 12, fontSize: 9, color: 'oklch(0.98 0.01 80)', opacity: 0.7 }}>
        [ photograph placeholder ]
      </div>
    </div>
  );
}

// ---------- DROPDOWN (CITY PICKER) ----------
function CityPicker({ value, onChange, label, exclude }) {
  const [open, setOpen] = useState(false);
  const [q, setQ] = useState('');
  const rootRef = useRef(null);
  const inputRef = useRef(null);

  useEffect(() => {
    const onDoc = e => { if (rootRef.current && !rootRef.current.contains(e.target)) setOpen(false); };
    document.addEventListener('mousedown', onDoc);
    return () => document.removeEventListener('mousedown', onDoc);
  }, []);
  useEffect(() => { if (open) setTimeout(() => inputRef.current?.focus(), 30); }, [open]);

  const filtered = CITIES.filter(c => c.code !== exclude).filter(c => {
    const s = q.trim().toLowerCase();
    if (!s) return true;
    return c.code.toLowerCase().includes(s) || c.city.toLowerCase().includes(s) || c.country.toLowerCase().includes(s);
  });

  const selected = CITIES.find(c => c.code === value);

  return (
    <div ref={rootRef} style={{ position: 'relative' }}>
      <div className="caps" style={{ marginBottom: 8 }}>{label}</div>
      <button
        onClick={() => setOpen(o => !o)}
        className="focus-ring"
        style={{
          display: 'block', width: '100%', textAlign: 'left',
          padding: '6px 0', borderBottom: `1px solid ${open ? 'var(--ink)' : 'var(--rule)'}`,
          transition: 'border-color .15s',
        }}
      >
        {selected ? (
          <div style={{ display: 'grid', gridTemplateColumns: 'auto 1fr auto', alignItems: 'center', columnGap: 12, rowGap: 2 }}>
            <span className="serif" style={{ fontSize: 34, lineHeight: 1, gridRow: '1 / span 2' }}>{selected.code}</span>
            <span style={{ fontSize: 14, color: 'var(--ink)', fontWeight: 500, alignSelf: 'end', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
              {selected.city}
            </span>
            <span className="mono" style={{ fontSize: 11, color: 'var(--ink-faint)', alignSelf: 'end' }}>{selected.tz}</span>
            <span style={{ fontSize: 12, color: 'var(--ink-soft)', alignSelf: 'start', gridColumn: '2 / span 2', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
              {selected.country}
            </span>
          </div>
        ) : (
          <div style={{ padding: '10px 0', color: 'var(--ink-faint)' }} className="serif italic">
            Where are we headed?
          </div>
        )}
      </button>

      {open && (
        <div style={{
          position: 'absolute', top: 'calc(100% + 8px)', left: 0, right: 0, zIndex: 30,
          background: 'var(--paper)', border: '1px solid var(--rule)', borderRadius: 10,
          boxShadow: '0 18px 40px -20px oklch(0.2 0.02 60 / 0.35), 0 2px 6px oklch(0.2 0.02 60 / 0.06)',
          overflow: 'hidden',
        }}>
          <div style={{ padding: '10px 12px', borderBottom: '1px solid var(--rule-soft)', display: 'flex', alignItems: 'center', gap: 8 }}>
            <span style={{ color: 'var(--ink-faint)' }}>⌕</span>
            <input
              ref={inputRef}
              placeholder="Search city, code or country…"
              value={q} onChange={e => setQ(e.target.value)}
              style={{ flex: 1, border: 'none', outline: 'none', background: 'transparent', fontSize: 14 }}
            />
            <span className="mono" style={{ fontSize: 10, color: 'var(--ink-faint)' }}>{filtered.length} results</span>
          </div>
          <div className="scroll" style={{ maxHeight: 280, overflowY: 'auto' }}>
            {filtered.length === 0 && (
              <div style={{ padding: 20, color: 'var(--ink-faint)' }} className="serif italic">No cities match that.</div>
            )}
            {filtered.map(c => (
              <button
                key={c.code}
                onClick={() => { onChange(c.code); setOpen(false); setQ(''); }}
                style={{
                  width: '100%', display: 'grid', gridTemplateColumns: '44px 1fr auto',
                  alignItems: 'center', gap: 10, padding: '10px 14px', textAlign: 'left',
                  background: c.code === value ? 'var(--sunset-wash)' : 'transparent',
                }}
                onMouseEnter={e => { if (c.code !== value) e.currentTarget.style.background = 'var(--bg-warm)'; }}
                onMouseLeave={e => { if (c.code !== value) e.currentTarget.style.background = 'transparent'; }}
              >
                <span className="mono" style={{ fontSize: 13, fontWeight: 600 }}>{c.code}</span>
                <span style={{ display: 'flex', alignItems: 'baseline', gap: 6 }}>
                  <span>{c.emoji}</span>
                  <span style={{ fontWeight: 500 }}>{c.city}</span>
                  <span style={{ color: 'var(--ink-faint)', fontSize: 13 }}>{c.country}</span>
                </span>
                <span className="mono" style={{ fontSize: 10, color: 'var(--ink-faint)' }}>{c.tz}</span>
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

Object.assign(window, { Logo, DestinationPlaceholder, CityPicker });
