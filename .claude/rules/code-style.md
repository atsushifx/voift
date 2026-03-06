# Code Style Rules

## Formatter Tools

- **gofmt**: Go source files only (tab indent)
- **dprint**: JSON, YAML, Markdown (lineWidth=120, space indent)

dprint does NOT cover Go files.

---

## Indentation

| File type        | Indent style | Width |
| ---------------- | ------------ | ----- |
| Go (`.go`)       | tab          | —     |
| Markdown (`.md`) | space        | 2     |
| JSON (`.json`)   | space        | 2     |
| YAML (`.yaml`)   | space        | 2     |
| TOML (`.toml`)   | space        | 2     |

---

## Line Width

- Maximum: **120 characters**
- Enforced by dprint for non-Go files

---

## Newline

- Always **LF** (`\n`)
- Enforced by `.editorconfig` and dprint
