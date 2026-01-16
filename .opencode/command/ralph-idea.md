---
description: Start Discovery Loop
agent: ralph-build
---

# /ralph-idea - Start Discovery Loop

Autonom utforskning av en produktide fran alla vinklar med web research.

## Usage
```
/ralph-idea "Din produktide har"
```

## Instructions

**DU SKA KORA EN AUTONOM DISCOVERY LOOP**

Utforska iden genom att vaxla mellan roller. Anvand WebSearch aktivt for research.
Iterera tills PRD ar komplett och alla fragor besvarade.

---

**FAS 1: INITIAL RESEARCH (Analyst)**

```
ANALYST MODE
```

1. WebSearch: Sok efter liknande produkter/tjanster
2. WebSearch: Sok efter potentiella integrationer (API:er)
3. Identifiera konkurrenter och deras styrkor/svagheter
4. Dokumentera marknadsstorlek om mojligt

Skriv ner findings i sektion: `## Market Research`

---

**FAS 2: ANVANDARE & FLODEN (UX)**

```
UX MODE
```

1. Definiera 2-3 personas (vem ar anvandarna?)
2. Skissa huvudsakliga user flows
3. Identifiera kritiska interaktionspunkter
4. Tank pa onboarding-flodet

Skriv ner i sektioner: `## Target Users & Personas`, `## User Flows`

---

**FAS 3: SCOPE & PRIORITERING (PM)**

```
PM MODE
```

1. Lista alla potentiella features
2. Prioritera: Vad ar MVP? Vad kan vanta?
3. Definiera "done" for MVP
4. Identifiera risker och beroenden

Skriv ner i sektion: `## Core Features (MVP)`, `## Future Features`

---

**FAS 4: TEKNISK DESIGN (Architect)**

```
ARCHITECT MODE
```

1. WebSearch: Sok efter relevanta API:er och dokumentation
2. Valj tech stack baserat pa requirements
3. Lista alla externa integrationer
4. Identifiera tekniska utmaningar

Skriv ner i sektioner: `## Technical Requirements`, `## Integrations Required`

---

**FAS 5: AFFAR & JURIDIK (Business)**

```
BUSINESS MODE
```

1. Definiera affarsmodell (hur tjanar vi pengar?)
2. WebSearch: Sok efter juridiska krav (GDPR, PCI-DSS etc)
3. Identifiera compliance-krav
4. Uppskatta kostnader (API:er, hosting)

Skriv ner i sektioner: `## Business Model`, `## Legal/Compliance`

---

**FAS 6: SYNTES & VALIDERING**

```
VALIDATION MODE
```

1. Las igenom alla sektioner
2. Finns det oppna fragor? → Lagg till i `## Open Questions`
3. Finns det konflikter mellan sektioner? → Los dem
4. Ar tech stack konsistent med requirements? → Verifiera

**ITERERA** om Open Questions inte ar tom:
- Ga tillbaka till relevant roll
- Gor mer research
- Uppdatera sektioner

---

**EXIT CRITERIA**

Loopen ar klar nar:
- [ ] Alla sektioner har meningsfullt innehall
- [ ] `## Open Questions` ar tom eller innehaller endast "nice-to-have"
- [ ] Tech stack ar beslutad och dokumenterad
- [ ] Alla kritiska integrationer ar identifierade
- [ ] MVP scope ar tydligt definierat

---

**OUTPUT**

Skapa `docs/PRD.md` med foljande struktur:

```markdown
# [Produktnamn] - PRD

## Vision & Problem
{Vad loser vi? Varfor behovs detta?}

## Market Research
{Konkurrenter, marknad, mojligheter}

## Target Users & Personas
{Vem ar anvandarna? 2-3 personas}

## User Flows
{Huvudsakliga floden, steg for steg}

## Core Features (MVP)
{Prioriterad lista, vad maste finnas}

## Future Features
{Vad kan vanta till v2?}

## Technical Requirements
{Stack, arkitektur, constraints}

## Integrations Required
{Externa API:er och tjanster}

## Business Model
{Hur tjanar vi pengar?}

## Legal/Compliance
{GDPR, PCI-DSS, andra krav}

## Open Questions
{MASTE VARA TOM for att vara klar}
```

---

**NAR KLAR**

Skriv:
```
DISCOVERY_COMPLETE

PRD sparad till: docs/PRD.md

Nasta steg:
1. Kor /ralph-preflight for att verifiera requirements
2. Kor /ralph-plan for att skapa implementation plan
```
