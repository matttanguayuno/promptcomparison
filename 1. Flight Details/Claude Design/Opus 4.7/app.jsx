const { useState: useStateApp, useEffect: useEffectApp, useMemo: useMemoApp } = React;

// ---------- TRIP TYPE TABS ----------
function TripTypeTabs({ value, onChange }) {
  const tabs = [
    { id: 'round',  label: 'Round trip' },
    { id: 'oneway', label: 'One way' },
    { id: 'multi',  label: 'Multi-city' },
  ];
  return (
    <div style={{ display: 'inline-flex', padding: 4, background: 'var(--bg-warm)', borderRadius: 999, border: '1px solid var(--rule)' }}>
      {tabs.map(t => {
        const active = value === t.id;
        return (
          <button
            key={t.id}
            onClick={() => onChange(t.id)}
            style={{
              padding: '7px 16px', borderRadius: 999, fontSize: 13, fontWeight: 500,
              background: active ? 'var(--paper)' : 'transparent',
              color: active ? 'var(--ink)' : 'var(--ink-soft)',
              boxShadow: active ? '0 1px 2px oklch(0.2 0.02 60 / 0.08)' : 'none',
              transition: 'all .15s',
            }}
          >{t.label}</button>
        );
      })}
    </div>
  );
}

// ---------- BOARDING PASS SUMMARY ----------
function BoardingPass({ origin, dest, depart, ret, cabin, pax, price, discount, total, tripType }) {
  const o = CITIES.find(c => c.code === origin);
  const d = CITIES.find(c => c.code === dest);
  const cab = CABINS.find(c => c.id === cabin);

  const seat = useMemoApp(() => {
    if (!o || !d) return '—';
    const rows = { economy: 32, premium: 22, business: 8, first: 3 }[cabin] || 30;
    const row = ((o.code.charCodeAt(0) + d.code.charCodeAt(0)) % rows) + 1;
    const letter = 'ABCDEF'[((o.code.charCodeAt(1) + d.code.charCodeAt(1)) % 6)];
    return `${row}${letter}`;
  }, [o, d, cabin]);

  const flightNo = useMemoApp(() => {
    if (!o || !d) return 'MR ——';
    const n = ((o.code.charCodeAt(2) * 17 + d.code.charCodeAt(2) * 13) % 900) + 100;
    return `MR ${n}`;
  }, [o, d]);

  return (
    <div style={{
      position: 'relative',
      background: 'var(--paper)',
      borderRadius: 14,
      border: '1px solid var(--rule)',
      boxShadow: '0 20px 50px -30px oklch(0.2 0.02 60 / 0.45), 0 2px 6px oklch(0.2 0.02 60 / 0.04)',
      overflow: 'hidden',
    }}>
      {/* perforated divider circles */}
      <div style={{
        position: 'absolute', left: -10, top: 'calc(66% - 10px)', width: 20, height: 20, borderRadius: '50%',
        background: 'var(--bg)', border: '1px solid var(--rule)', zIndex: 2,
      }}/>
      <div style={{
        position: 'absolute', right: -10, top: 'calc(66% - 10px)', width: 20, height: 20, borderRadius: '50%',
        background: 'var(--bg)', border: '1px solid var(--rule)', zIndex: 2,
      }}/>

      {/* TOP: route */}
      <div style={{ padding: '22px 24px 18px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 18 }}>
          <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>Boarding pass · preview</div>
          <div className="mono" style={{ fontSize: 11, color: 'var(--sunset-deep)', fontWeight: 600 }}>{flightNo}</div>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr auto 1fr', alignItems: 'center', gap: 12 }}>
          <div>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>From</div>
            <div className="serif" style={{ fontSize: 52, lineHeight: 0.95, letterSpacing: -1 }}>
              {o ? o.code : '—'}
            </div>
            <div style={{ fontSize: 13, color: 'var(--ink-soft)', marginTop: 4 }}>
              {o ? `${o.city}, ${o.country}` : <span className="italic">Origin</span>}
            </div>
          </div>

          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '0 6px' }}>
            <svg width="80" height="30" viewBox="0 0 80 30" fill="none">
              <line x1="4" y1="15" x2="70" y2="15" stroke="var(--ink-faint)" strokeWidth="1" strokeDasharray="2 3"/>
              <path d="M55 6 L72 15 L55 24 L60 15 Z" fill="var(--sunset)" stroke="var(--sunset-deep)" strokeWidth="0.5"/>
            </svg>
            <div className="mono" style={{ fontSize: 9, color: 'var(--ink-faint)', marginTop: 2 }}>
              {tripType === 'round' ? 'RT' : tripType === 'oneway' ? 'OW' : 'MC'}
            </div>
          </div>

          <div style={{ textAlign: 'right' }}>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>To</div>
            <div className="serif" style={{ fontSize: 52, lineHeight: 0.95, letterSpacing: -1 }}>
              {d ? d.code : '—'}
            </div>
            <div style={{ fontSize: 13, color: 'var(--ink-soft)', marginTop: 4 }}>
              {d ? `${d.city}, ${d.country}` : <span className="italic">Destination</span>}
            </div>
          </div>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 10, marginTop: 22, paddingTop: 18, borderTop: '1px solid var(--rule-soft)' }}>
          <div>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>Depart</div>
            <div style={{ fontSize: 14, fontWeight: 500, marginTop: 4 }}>{depart ? fmtDate(depart) : '—'}</div>
          </div>
          <div>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>Return</div>
            <div style={{ fontSize: 14, fontWeight: 500, marginTop: 4 }}>{ret ? fmtDate(ret) : '—'}</div>
          </div>
          <div>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>Cabin</div>
            <div style={{ fontSize: 14, fontWeight: 500, marginTop: 4 }}>{cab?.name || '—'}</div>
          </div>
          <div>
            <div className="mono caps" style={{ color: 'var(--ink-faint)' }}>Seat</div>
            <div style={{ fontSize: 14, fontWeight: 500, marginTop: 4 }} className="mono">{seat}</div>
          </div>
        </div>
      </div>

      {/* perforation line */}
      <div style={{
        borderTop: '1px dashed var(--rule)',
        margin: '0 10px',
      }}/>

      {/* BOTTOM: price + action */}
      <div style={{ padding: '16px 24px 20px', background: 'linear-gradient(180deg, transparent, oklch(0.96 0.02 60 / 0.5))' }}>
        {price > 0 && (
          <div style={{ marginBottom: 14 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: 12, color: 'var(--ink-soft)', marginBottom: 4 }}>
              <span>{cab?.name} × {pax}</span>
              <span className="mono">${price.toLocaleString()}</span>
            </div>
            {discount > 0 && (
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: 12, color: 'var(--success)', marginBottom: 4 }}>
                <span>Promo discount</span>
                <span className="mono">−${discount.toLocaleString()}</span>
              </div>
            )}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', marginTop: 10, paddingTop: 10, borderTop: '1px solid var(--rule-soft)' }}>
              <span className="caps">Total fare</span>
              <span className="serif" style={{ fontSize: 32, lineHeight: 1 }}>
                ${total.toLocaleString()}<span className="mono" style={{ fontSize: 11, color: 'var(--ink-faint)', marginLeft: 4 }}>USD</span>
              </span>
            </div>
          </div>
        )}

        <button
          disabled={!o || !d || !depart}
          onClick={() => {
            const btn = event.currentTarget;
            btn.textContent = '✓  Reserved — hold expires in 24h';
            btn.style.background = 'var(--success)';
            setTimeout(() => {
              btn.innerHTML = 'Continue to passengers &nbsp;→';
              btn.style.background = '';
            }, 2200);
          }}
          style={{
            width: '100%', padding: '14px 18px', borderRadius: 10, fontSize: 14, fontWeight: 500,
            background: (!o || !d || !depart) ? 'var(--rule)' : 'var(--ink)',
            color: (!o || !d || !depart) ? 'var(--ink-faint)' : 'var(--paper)',
            cursor: (!o || !d || !depart) ? 'not-allowed' : 'pointer',
            transition: 'all .2s',
            letterSpacing: '0.01em',
          }}
          onMouseEnter={e => { if (o && d && depart) e.currentTarget.style.background = 'var(--sunset-deep)'; }}
          onMouseLeave={e => { if (o && d && depart) e.currentTarget.style.background = 'var(--ink)'; }}
        >Continue to passengers &nbsp;→</button>
      </div>
    </div>
  );
}

// ---------- NAV ----------
function Nav() {
  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '22px 40px', borderBottom: '1px solid var(--rule-soft)' }}>
      <Logo />
      <nav style={{ display: 'flex', gap: 28, fontSize: 13 }}>
        {['Book', 'Manage trip', 'Check in', 'Atlas Club'].map((l, i) => (
          <button key={l} style={{ color: i === 0 ? 'var(--ink)' : 'var(--ink-soft)', fontWeight: i === 0 ? 500 : 400 }}
            onMouseEnter={e => e.currentTarget.style.color = 'var(--ink)'}
            onMouseLeave={e => e.currentTarget.style.color = i === 0 ? 'var(--ink)' : 'var(--ink-soft)'}
          >{l}</button>
        ))}
      </nav>
      <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
        <button className="mono caps" style={{ fontSize: 10, color: 'var(--ink-soft)' }}>EN · USD</button>
        <div style={{ width: 34, height: 34, borderRadius: '50%', background: 'var(--sunset-wash)', display: 'grid', placeItems: 'center', fontSize: 13, border: '1px solid var(--rule)' }} className="serif italic">A</div>
      </div>
    </div>
  );
}

// ---------- APP ----------
function App() {
  const [tripType, setTripType] = useStateApp('round');
  const [origin, setOrigin] = useStateApp('JFK');
  const [dest, setDest] = useStateApp('CDG');
  const [depart, setDepart] = useStateApp(() => {
    const d = new Date(); d.setDate(d.getDate() + 14); return toISO(d);
  });
  const [ret, setRet] = useStateApp(() => {
    const d = new Date(); d.setDate(d.getDate() + 21); return toISO(d);
  });
  const [cabin, setCabin] = useStateApp('economy');
  const [pax, setPax] = useStateApp(1);
  const [promo, setPromo] = useStateApp(null);

  const swap = () => { setOrigin(dest); setDest(origin); };

  useEffectApp(() => {
    if (tripType === 'oneway') setRet(null);
  }, [tripType]);

  const cabinDef = CABINS.find(c => c.id === cabin);
  const basePrice = useMemoApp(() => {
    return priceFor(origin, dest, cabinDef.mult, daysFromToday(depart), pax);
  }, [origin, dest, cabin, depart, pax]);

  const roundMult = tripType === 'round' && ret ? 1.85 : 1;
  const price = Math.round(basePrice * roundMult);
  const discount = promo ? Math.round(price * promo.def.pct / 100) : 0;
  const total = price - discount;

  const destCity = CITIES.find(c => c.code === dest);
  const originCity = CITIES.find(c => c.code === origin);

  return (
    <div>
      <Nav />

      {/* HERO */}
      <div style={{ padding: '48px 40px 28px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', gap: 40, flexWrap: 'wrap' }}>
        <div style={{ maxWidth: 640 }}>
          <div className="mono caps" style={{ color: 'var(--sunset-deep)', marginBottom: 14 }}>◦ Spring timetable · 2026</div>
          <h1 className="serif" style={{ fontSize: 72, lineHeight: 0.98, margin: 0, letterSpacing: -1.5 }}>
            Somewhere the <span className="italic">sun is rising.</span>
          </h1>
          <p style={{ fontSize: 16, color: 'var(--ink-soft)', maxWidth: 520, marginTop: 18, lineHeight: 1.55 }}>
            Where would you like to wake up tomorrow? Meridian flies to 84 cities across six continents — pick two, and we'll handle the sky between.
          </p>
        </div>
        <div style={{ display: 'flex', gap: 10 }}>
          <div style={{ width: 150 }}>
            <DestinationPlaceholder
              city={originCity?.city || 'Here'}
              label={`${originCity?.code || '—'} · ORIGIN`}
              hue={originCity?.hue || 40}
              height={140}
            />
          </div>
          <div style={{ width: 180 }}>
            <DestinationPlaceholder
              city={destCity?.city || 'Anywhere'}
              label={`${destCity?.code || '—'} · DESTINATION`}
              hue={destCity?.hue || 310}
              height={170}
            />
          </div>
        </div>
      </div>

      {/* MAIN SEARCH PANEL */}
      <div style={{ padding: '0 40px 60px', display: 'grid', gridTemplateColumns: '1.4fr 1fr', gap: 36, alignItems: 'start' }}>
        <div style={{
          background: 'var(--paper)',
          border: '1px solid var(--rule)',
          borderRadius: 16,
          padding: 32,
          boxShadow: '0 24px 60px -40px oklch(0.2 0.02 60 / 0.4)',
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 28 }}>
            <TripTypeTabs value={tripType} onChange={setTripType}/>
            <button
              onClick={swap}
              className="mono caps"
              style={{ display: 'flex', alignItems: 'center', gap: 6, color: 'var(--ink-soft)', padding: '6px 10px', borderRadius: 999, border: '1px solid var(--rule)' }}
              onMouseEnter={e => { e.currentTarget.style.color = 'var(--ink)'; e.currentTarget.style.borderColor = 'var(--ink)'; }}
              onMouseLeave={e => { e.currentTarget.style.color = 'var(--ink-soft)'; e.currentTarget.style.borderColor = 'var(--rule)'; }}
            >
              <svg width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M2 4h8M2 4l2-2M2 4l2 2M10 8H2M10 8l-2-2M10 8l-2 2" stroke="currentColor" strokeWidth="1.2" strokeLinecap="round"/></svg>
              Swap
            </button>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 32, marginBottom: 32 }}>
            <CityPicker label="Departing from" value={origin} onChange={setOrigin} exclude={dest}/>
            <CityPicker label="Arriving at" value={dest} onChange={setDest} exclude={origin}/>
          </div>

          <div style={{ marginBottom: 32 }}>
            <DateRangePicker
              depart={depart}
              ret={tripType === 'oneway' ? null : ret}
              onChange={(d, r) => { setDepart(d); if (tripType !== 'oneway') setRet(r); }}
              label={tripType === 'oneway' ? 'Departure date' : 'Travel dates'}
            />
          </div>

          <div style={{ marginBottom: 32 }}>
            <CabinSelector value={cabin} onChange={setCabin}/>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1.4fr', gap: 28 }}>
            <PaxStepper value={pax} onChange={setPax}/>
            <PromoField
              applied={promo}
              onApply={(code, def) => setPromo({ code, def, label: def.label })}
              onClear={() => setPromo(null)}
            />
          </div>
        </div>

        {/* SIDE: BOARDING PASS */}
        <div style={{ position: 'sticky', top: 20 }}>
          <BoardingPass
            origin={origin} dest={dest} depart={depart} ret={tripType !== 'oneway' ? ret : null}
            cabin={cabin} pax={pax}
            price={price} discount={discount} total={total}
            tripType={tripType}
          />
          <div style={{ marginTop: 16, display: 'flex', justifyContent: 'space-between', padding: '0 4px', fontSize: 11, color: 'var(--ink-faint)' }}>
            <span className="mono">Fare locked for 15:00 min</span>
            <span className="mono">✓ Free cancellation · 24h</span>
          </div>
        </div>
      </div>

      {/* FOOTER STRIP */}
      <div style={{ padding: '24px 40px', borderTop: '1px solid var(--rule-soft)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', color: 'var(--ink-faint)', fontSize: 11 }}>
        <span className="mono caps">© 2026 Meridian Air Cooperative · fleet of 112 · since 1962</span>
        <span className="mono caps">Terms · Privacy · Carbon report</span>
      </div>
    </div>
  );
}

ReactDOM.createRoot(document.getElementById('root')).render(<App/>);
