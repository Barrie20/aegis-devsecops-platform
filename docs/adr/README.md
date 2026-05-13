# Architecture Decision Records (ADRs)

## What are ADRs?

Architecture Decision Records document important technical decisions made during the project. They capture:
- **Context** — What situation prompted the decision?
- **Decision** — What did we choose?
- **Consequences** — What are the trade-offs?

## Why ADRs Matter

- New team members understand WHY things are built a certain way
- Prevents re-debating settled decisions
- Creates an audit trail of architectural evolution
- Shows hiring managers you think like a senior engineer

## ADR Index

| ID | Title | Status | Date |
|----|-------|--------|------|
| [001](001-use-fastapi-framework.md) | Use FastAPI as Web Framework | Accepted | 2024-01-15 |

## Template

Use this template for new ADRs:

```markdown
# ADR-XXX: [Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Date
[YYYY-MM-DD]

## Context
[What is the issue that we're seeing that is motivating this decision?]

## Options Considered
[What options did we evaluate?]

## Decision
[What is the change that we're proposing and/or doing?]

## Consequences
[What becomes easier or more difficult to do because of this change?]
```
