# Testing Rules

## Test Layers

This project separates tests into two layers.

### Internal Tests

Location:
same directory as implementation

Example:

internal/greetings/
greet.go
greet_test.go

Purpose:
validate internal logic and private helpers.

---

### API Contract Tests

Location:
tests/ subdirectory

Example:

internal/greetings/
greet.go
tests/
greet_api_test.go

Rules:

- filename: `<function>_api_test.go`
- package: `tests`
- import module as external package
- only public APIs may be used

Purpose:

- enforce stable API behavior
- support BDD-style verification
- prevent tests from coupling with implementation
