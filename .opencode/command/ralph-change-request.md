---
description: Create Change Request from Testing
agent: ralph-build
---

# /ralph-change-request - Create Change Request from Testing

Document bugs and issues found during testing, generate new specs for Ralph to fix.

## Usage
```
/ralph-change-request
```

## Prerequisites
- App has been built by Ralph (`/ralph-deploy` completed)
- Testing has been done (`/ralph-review` completed)
- Issues/bugs have been identified

## Output
- `docs/CHANGE_REQUEST.md` - Dokumentation av problem
- `specs/CR-*.md` - Nya spec-filer for fixes

## Instructions

**FAS 1: SAMLA IN PROBLEM**

Fraga anvandaren:
```
Change Request

Beskriv problemen du hittade under testning:
1. Vad fungerade inte som forvantat?
2. Vilka features saknas eller ar ofullstandiga?
3. Nagra UI/UX-problem?

Klistra in dina observationer:
```

Vanta pa anvandarens input.

**FAS 2: KATEGORISERA PROBLEM**

Analysera input och kategorisera:

1. **BUGS** - Saker som ar trasiga/fel
2. **INCOMPLETE** - Paborjat men inte klart
3. **MISSING** - Saknas helt trots att det var i spec
4. **ENHANCEMENT** - Forbattringar utover original-spec

**FAS 3: SKAPA CHANGE_REQUEST.md**

Skapa `docs/CHANGE_REQUEST.md`:

```markdown
# Change Request - [DATUM]

## Sammanfattning
{1-2 meningar om vad som hittades}

## Kategorier

### Bugs
| # | Problem | Paverkar | Prioritet |
|---|---------|----------|-----------|
| B1 | {beskrivning} | {feature} | HIGH/MED/LOW |

### Incomplete
| # | Feature | Status | Saknas |
|---|---------|--------|--------|
| I1 | {feature} | {%} | {vad} |

### Missing
| # | Feature | Spec-referens |
|---|---------|---------------|
| M1 | {feature} | {original-spec} |

### Enhancements (Optional)
| # | Forslag | Varde |
|---|---------|-------|
| E1 | {forslag} | {varde} |

---

## Ursprungliga Specs
{Lista vilka specs som kordes}

## Testing Done
{Sammanfattning av testning}
```

**FAS 4: GENERERA NYA SPECS**

Skapa nya spec-filer for varje problem:

```
specs/
├── CR-01-fix-{bug}.md
├── CR-02-complete-{feature}.md
└── CR-03-add-{missing}.md
```

**Spec-format for fixes:**
```markdown
# CR-XX: {Kortfattad beskrivning}

{Problem}: {Vad som ar fel}
{Fix}: {Vad som ska goras}

## Krav
- {Konkret krav 1}
- {Konkret krav 2}

## Klart nar
- [ ] `npm run build` passerar
- [ ] {Specifik verifiering av fix}
- [ ] Regression: {existerande funktionalitet fungerar}
```

**VIKTIGT:**
- Hall specs MINIMALA (max 15 rader)
- En spec = ett problem
- Inkludera regression-test i "Klart nar"
- CR-specs kors EFTER original-specs

**FAS 5: UPPDATERA IMPLEMENTATION_PLAN.md**

Lagg till CR-tasks i `docs/IMPLEMENTATION_PLAN.md`:

```markdown
## Change Request Tasks

### CR-Fixes (Prioritet: Kritisk)
- [ ] CR-01: {fix}
- [ ] CR-02: {fix}
- [ ] **HARD STOP** - Verifiera alla CR-fixes

### CR-Enhancements (Prioritet: Lag)
- [ ] CR-03: {enhancement}
```

**NAR KLAR:**
```
CHANGE_REQUEST_DONE

Skapade:
- docs/CHANGE_REQUEST.md
- X nya specs i specs/CR-*.md

Nasta: Kor /ralph-deploy for att skicka CR-specs till VM
```
