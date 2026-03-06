# Build Commands

## Common Tasks

```bash
make build          # build binary → bin/voift
make test           # go test ./...
make lint           # golangci-lint run
make fmt            # dprint format (non-Go files)
make release-check  # goreleaser --snapshot --clean
```

---

## Single Test

```bash
go test ./... -run TestFunctionName
```

---

## Tool Versions

| Tool          | Version | Manager |
| ------------- | ------- | ------- |
| Go            | 1.25.0  | mise    |
| golangci-lint | 2.10.1  | mise    |
| goreleaser    | 2.14.1  | mise    |
| dprint        | —       | mise    |

See `.tool-versions` for pinned versions.
