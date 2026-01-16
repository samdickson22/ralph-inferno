---
description: Create Implementation Plan
agent: ralph-build
---

# /ralph-plan - Create Implementation Plan

Analyze PRD and create implementation plan with executable specs.

## Usage
```
/ralph-plan
```

## Prerequisites
- `docs/prd.md` must exist (run `/ralph-discover` first)

## Output
- `docs/IMPLEMENTATION_PLAN.md` - Oversikt med epics och tasks
- `specs/*.md` - Korbara spec-filer for varje task (detta kor Ralph pa VM)

## Instructions

Las `docs/prd.md` och skapa en implementation plan.

**FAS 1: ANALYSERA PRD**
1. Las `docs/prd.md` noggrant
2. Identifiera alla features och krav
3. Gruppera till logiska epics

**FAS 2: SKAPA IMPLEMENTATION_PLAN.md**

Skapa filen med denna struktur:

```markdown
# IMPLEMENTATION_PLAN.md

## Epics Overview

| Epic | Namn | Status |
|------|------|--------|
| E1 | {namn} | pending |
| E2 | {namn} | pending |

## Tasks

### Kritisk (E1: {epic-namn})
- [ ] T1: {Specifik task}
- [ ] T2: {Task}
- [ ] **HARD STOP** - Verifiera grundflode fungerar

### Hog (E2: {epic-namn})
- [ ] T3: {Task}
- [ ] T4: {Task}

### Lag
- [ ] T5: {Task}

---

## Progress

| Datum | Task | Resultat |
|-------|------|----------|

---

## Learnings

| Problem | Lardom |
|---------|--------|

---

## Blocked
```

**FAS 3: SKAPA SPEC-FILER (OBLIGATORISKT)**

Skapa ALLTID korbara spec-filer i `specs/`. Detta ar vad Ralph kor pa VM.

> **Templates:** Se `templates/SPEC-template.md` och `templates/specs/01-project-setup.md`

```
specs/
├── 01-project-setup.md   ← MASTE inkludera Playwright!
├── 02-database-schema.md
├── 03-auth-context.md
├── 04-login-page.md
└── ...
```

**KRITISKT - 01-project-setup MASTE innehalla:**
- Vite + React + TypeScript setup
- Tailwind med design tokens fran PRD
- **Playwright installation** (`npx playwright install`)
- `playwright.config.ts`
- `e2e/smoke.spec.ts`

> Utan Playwright fungerar inte Ralph's test-loop!

**Spec-fil format (MINIMALT for liten context window):**
```markdown
# {Task-namn}

{1-2 meningar vad som ska byggas}

## Krav
- {Konkret krav 1}
- {Konkret krav 2}

## E2E Test
Skriv test i `e2e/{feature}.spec.ts` som verifierar:
- {vad testet ska kolla}

## Klart nar
- [ ] `npm run build` passerar
- [ ] E2E-test passerar
- [ ] {Specifik verifiering}
```

**VIKTIGT - HALL SPECS MINIMALA:**
- MAX 20 rader per spec
- Ingen bakgrund/kontext - Claude laser koden
- Inga implementation-detaljer - Claude vet hur
- Bara VAD, inte HUR
- En spec = en fokuserad uppgift

**EXEMPEL PA BRA SPEC:**
```markdown
# Auth Context

Skapa React context for autentisering med Supabase.

## Krav
- AuthProvider wrappare
- useAuth hook (user, signIn, signOut)
- Automatisk session-refresh

## Klart nar
- [ ] `npm run build` passerar
- [ ] Kan logga in/ut via hook
```

**EXEMPEL PA DALIG SPEC (for lang):**
```markdown
# Auth Context

## Bakgrund
Autentisering ar viktigt for...
[10 rader kontext]

## Implementation
1. Skapa src/contexts/AuthContext.tsx
2. Importera createContext fran react
3. ...
[20 rader implementation-detaljer]
```

**REGLER:**
- En task = en mening utan "och"
- HARD STOP mellan prioritetsnivaer
- Kritiska blockerare forst
- Tasks grupperade under sin epic

**NAR KLAR:**
Skriv:
```
PLANNING_DONE

Nasta: Kor /ralph-deploy for att skicka till VM och starta bygget
```
