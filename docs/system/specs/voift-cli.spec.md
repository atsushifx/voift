---
title: "Spec: voift CLI"
version: 0.0.1
update: 2026-03-05
author: atsushifx
status: Draft
---

## voift CLI Specification (v0.1 Draft)

## Overview

`voift` is a CLI tool for merging configuration files and outputting the result in a specified format.
Designed primarily for CI pipelines and machine‑readable workflows.

### Command

```bash
voift [FILES...]
```

If FILES are not specified, input is read from stdin.

### Supported Formats

- yaml
- json
- toml

Extensions:

- .json
- .yaml
- .yml
- .toml

All input files must use the same format.

### Options

```bash
-i, --input-format <fmt>   Input format
-f, --format <fmt>         Output format
-o, --output <file>        Output file (default stdout)
-s, --skip-missing         Skip missing files
-q, --quiet                Suppress non‑error messages
-v, --verbose              Verbose logging
-h, --help                 Show help
-V, --version              Show version
```

## Input Rules

FILES specified → read files
FILES omitted → read stdin

stdin usage requires:
--input-format

```bash
cat config.yaml | voift -i yaml
```

## Output Rules

Priority:

1. --format
2. output file extension
3. default json

Examples:

```bash
voift base.yaml local.yaml
# → stdout json

voift base.yaml local.yaml -o merged.yaml
# → yaml

voift base.yaml local.yaml -o config.yaml -f json
# → json
```

## Merge Behavior

Files processed in order.

```bash
voift base.yaml user.yaml local.yaml
```

Priority:
local > user > base

Rules:

scalar → overwritten
object → recursive merge
array → replaced
type conflict → later wins

## File Resolution

FILES must be regular files.

Unsupported:
directories
recursive search

Glob expansion handled by shell.

Example:

```bash
voift configs/*.yaml
```

## skip-missing

Without flag:
error → exit 2

With flag:
warning → stderr
exit 0

## Logging

Modes:
quiet
normal
verbose

stdout → merged data
stderr → logs/warnings/errors

## Exit Codes

0 success
1 runtime error
2 input error
3 parse error
4 merge error
5 output error

Warnings do not change exit code.

## Help

Minimal CLI help only.
Detailed information belongs in README/docs.

## Version

```bash
voift <version>
voift 0.1.0
```
