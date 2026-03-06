# CLAUDE.md

## Project

`voift` is a CLI tool that merges YAML/JSON/TOML configuration files using a layered override model.
Designed for CI pipelines. Deterministic, minimal, predictable.

**Current status**: Source code not yet implemented. Specs and architecture are complete.
Implementing `cmd/voift/` or `internal/` requires reading docs first.

## Tech Stack

- Go: 1.25.0 (managed via mise, see `.tool-versions`)
- golangci-lint: 2.10.1
- goreleaser: 2.14.1
- dprint: formatter for JSON/YAML/MD (lineWidth=120)
- lefthook: git hooks manager

## Directory Layout

```text
cmd/voift/          # CLI entry point (planned)
internal/           # merge engine (planned)
docs/system/
  specs/            # CLI specification
  architecture/     # merge engine design
.claude/
  rules/            # AI collaboration rules
  agents/           # Claude agent definitions
configs/            # tool configs (lint, hooks, secretlint)
```

## Code Style

Go: tab indent. Non-Go: 2-space indent. Line width: 120. Newline: LF.

See `.claude/rules/code-style.md` for full rules.

## Build Commands

```bash
make build    # build binary → bin/voift
make test     # go test ./...
make lint     # golangci-lint run
make fmt      # dprint format (non-Go files)
```

Single test: `go test ./... -run TestFunctionName`

See `.claude/rules/build-commands.md` for full list.

## Test Strategy

Two-layer test structure. See `.claude/rules/testing.md` for full rules.

| Layer              | Location                                           | Purpose                |
| ------------------ | -------------------------------------------------- | ---------------------- |
| Internal tests     | same dir as implementation (`*_test.go`)           | logic, private helpers |
| API contract tests | `tests/` subdir (`*_api_test.go`, package `tests`) | public API stability   |

## Merge Behavior

Files processed left to right; later files override earlier files.

| Value type    | Behavior        |
| ------------- | --------------- |
| scalar        | overwrite       |
| object        | recursive merge |
| array         | replace         |
| type conflict | later wins      |

## Commit Messages

Conventional Commits: `type(scope): summary` — max **76 characters**. Body: Japanese.

See `.claude/rules/commit-rules.md` for types, body rules, and Git hooks.

## References

| Document              | Path                                                    |
| --------------------- | ------------------------------------------------------- |
| Code style            | `.claude/rules/code-style.md`                           |
| Build commands        | `.claude/rules/build-commands.md`                       |
| Commit rules          | `.claude/rules/commit-rules.md`                         |
| Test rules            | `.claude/rules/testing.md`                              |
| CLI spec              | `docs/system/specs/voift-cli.spec.md`                   |
| Merge engine design   | `docs/system/architecture/merge-engine.architecture.md` |
| Commit message format | `.claude/agents/commit-message-generator.md`            |
