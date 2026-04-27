// City & flight data
const CITIES = [
  { code: 'JFK', city: 'New York',     country: 'United States', tz: 'EST', emoji: '🗽', hue: 40 },
  { code: 'LHR', city: 'London',       country: 'United Kingdom', tz: 'GMT', emoji: '🎡', hue: 120 },
  { code: 'CDG', city: 'Paris',        country: 'France',        tz: 'CET', emoji: '🗼', hue: 310 },
  { code: 'NRT', city: 'Tokyo',        country: 'Japan',         tz: 'JST', emoji: '🏯', hue: 0 },
  { code: 'DXB', city: 'Dubai',        country: 'UAE',           tz: 'GST', emoji: '🕌', hue: 55 },
  { code: 'SIN', city: 'Singapore',    country: 'Singapore',     tz: 'SGT', emoji: '🌴', hue: 160 },
  { code: 'SYD', city: 'Sydney',       country: 'Australia',     tz: 'AEDT', emoji: '🎭', hue: 210 },
  { code: 'IST', city: 'Istanbul',     country: 'Türkiye',       tz: 'TRT', emoji: '🕌', hue: 20 },
  { code: 'GRU', city: 'São Paulo',    country: 'Brazil',        tz: 'BRT', emoji: '⚽', hue: 140 },
  { code: 'HKG', city: 'Hong Kong',    country: 'SAR China',     tz: 'HKT', emoji: '🏙️', hue: 340 },
  { code: 'BCN', city: 'Barcelona',    country: 'Spain',         tz: 'CET', emoji: '⛪', hue: 30 },
  { code: 'CPT', city: 'Cape Town',    country: 'South Africa',  tz: 'SAST', emoji: '⛰️', hue: 180 },
  { code: 'YYZ', city: 'Toronto',      country: 'Canada',        tz: 'EST', emoji: '🍁', hue: 10 },
  { code: 'MEX', city: 'Mexico City',  country: 'Mexico',        tz: 'CST', emoji: '🌮', hue: 50 },
  { code: 'BKK', city: 'Bangkok',      country: 'Thailand',      tz: 'ICT', emoji: '🛺', hue: 90 },
  { code: 'AMS', city: 'Amsterdam',    country: 'Netherlands',   tz: 'CET', emoji: '🌷', hue: 280 },
];

const CABINS = [
  { id: 'economy',   name: 'Economy',        tag: 'ECO', mult: 1.0,  perk: 'Essentials only' },
  { id: 'premium',   name: 'Premium Economy', tag: 'PEY', mult: 1.6,  perk: '+Extra legroom' },
  { id: 'business',  name: 'Business',       tag: 'BIZ', mult: 3.2,  perk: 'Lie-flat seat, lounge' },
  { id: 'first',     name: 'First',          tag: 'FST', mult: 5.4,  perk: 'Private suite, chef menu' },
];

const PROMOS = {
  'MERIDIAN10':  { pct: 10, label: '10% off — welcome fare' },
  'SUNSET25':    { pct: 25, label: '25% off — sunset sale' },
  'LOYAL50':     { pct: 50, label: '50% off — Atlas Club member' },
  'FRIENDS15':   { pct: 15, label: '15% off — friends & family' },
};

// Deterministic price from origin, dest, cabin, and days-out
function priceFor(origin, dest, cabinMult, daysOut, pax) {
  if (!origin || !dest) return 0;
  const hash = (origin.charCodeAt(0)*31 + origin.charCodeAt(1)*17 + origin.charCodeAt(2)*7 +
                dest.charCodeAt(0)*29 + dest.charCodeAt(1)*13 + dest.charCodeAt(2)*5);
  const base = 210 + (hash % 480);
  const advance = daysOut >= 21 ? 0.9 : daysOut >= 7 ? 1.0 : 1.25;
  return Math.round(base * cabinMult * advance) * pax;
}

Object.assign(window, { CITIES, CABINS, PROMOS, priceFor });
