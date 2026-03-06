# Commit Rules

## Format

Conventional Commits enforced by commitlint.

```text
type(scope): summary
```

- Header max: **76 characters**
- Summary: lowercase, fact-based, no filenames
- Body: Japanese language

See `.claude/agents/commit-message-generator.md` for output format and examples.

---

## Valid Types

`feat`, `fix`, `chore`, `docs`, `test`, `refactor`, `perf`, `ci`,
`config`, `release`, `merge`, `build`, `style`, `deps`

---

## Git Hooks (lefthook)

### pre-commit

Runs in parallel:

- **gitleaks**: scans staged files for secrets
- **secretlint**: scans staged files for credentials

### prepare-commit-msg

- Generates AI commit message via Claude agent

### commit-msg

- Validates format with commitlint (`configs/commitlint.config.js`)
