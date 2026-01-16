---
description: Verify Requirements Before Dev
agent: ralph-build
---

# /ralph-preflight - Verify Requirements Before Dev

Generera och verifiera preflight checklist innan development startar.

## Usage
```
/ralph-preflight
/ralph-preflight --check    # Verifiera befintlig PREFLIGHT.md
```

## Prerequisites
- `docs/PRD.md` maste finnas (kor `/ralph-idea` eller `/ralph-discover` forst)

## Instructions

**STEG 1: LAS PRD**

Las `docs/PRD.md` och identifiera:
1. Alla externa integrationer
2. Alla API:er som behovs
3. Teknisk stack och hosting
4. Compliance-krav

**STEG 2: GENERERA PREFLIGHT.md**

Baserat pa PRD, skapa `docs/PREFLIGHT.md` med:

1. **Accounts Required**
   - Lista alla externa tjanster
   - Inkludera signup-URLs

2. **API Keys Needed**
   - Lista alla miljovariabler
   - Instruktioner for hur man far dem

3. **Environment Setup**
   - VM requirements
   - GitHub setup
   - Local config

4. **Manual Setup Steps**
   - Webhooks som behover konfigureras
   - OAuth redirect URLs
   - DNS om det behovs

5. **Cost Estimate**
   - Manadskostnad per tjanst

**STEG 3: VISA FOR ANVANDAREN**

Presentera checklistan och be anvandaren bekrafta varje punkt:

```
PREFLIGHT CHECKLIST

Foljande maste vara klart innan Ralph kan bygga:

ACCOUNTS:
  [ ] Stripe test account
  [ ] Printful developer account
  [ ] Supabase project

API KEYS:
  [ ] STRIPE_SECRET_KEY
  [ ] PRINTFUL_API_KEY
  [ ] SUPABASE_URL
  [ ] SUPABASE_ANON_KEY

MANUAL SETUP:
  [ ] Stripe webhook URL configured
  [ ] Test products in Printful

---

Ar allt ovan klart? (ja/nej)
```

**STEG 4: GATE CHECK**

Om anvandaren svarar "ja":
```
PREFLIGHT COMPLETE

docs/PREFLIGHT.md uppdaterad med STATUS: READY FOR DEV

Nasta steg:
  /ralph-plan    - Skapa specs
  /ralph-deploy  - Starta bygget
```

Om anvandaren svarar "nej":
```
PREFLIGHT INCOMPLETE

Vanligen slutfor foljande innan du fortsatter:
{lista saknade items}

Kor /ralph-preflight --check nar du ar klar.
```

**VIKTIGT:**
- STOPPA INTE om preflight inte ar klar
- Anvandaren maste aktivt bekrafta
- `/ralph-deploy` ska vagra kora om PREFLIGHT inte ar READY
