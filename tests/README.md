# Tests

## Test Structure

```
tests/
├── unit/           # Fast, isolated tests (no external dependencies)
├── integration/    # Tests that use real databases, APIs
└── e2e/            # End-to-end tests (full system)
```

## Running Tests

```bash
# All tests
make test

# Unit tests only
cd apps/api && pytest tests/ -v

# With coverage report
cd apps/api && pytest tests/ -v --cov=. --cov-report=html
```

## Test Philosophy

- Unit tests run in CI on every push (fast feedback)
- Integration tests run before merge to main
- E2E tests run after deployment to staging
