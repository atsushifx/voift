---
title: "Architecture: Merge Engine"
version: 0.0.1
update: 2026-03-05
author: atsushifx
status: Draft
---

## voift Merge Specification

<!-- textlint-disable ja-technical-writing/sentence-length -->

## Overview

`voift` merges configuration files using a **layered override model**.

The tool is designed for configuration composition in CI pipelines, where later configuration layers override earlier ones.

Example:

```bash
voift base.yaml user.yaml local.yaml
```

Priority:

```bash
local > user > base
```

Later files always override earlier files.

## Merge Model

The merge operation follows this sequence:

```bash
result = file1

for file in files[2..n]:
    result = merge(result, file)
```

Each file layer is applied sequentially.

## Conflict Resolution Rules

When the same key appears in multiple layers, behavior depends on the value type.

| Type          | Behavior         |
| ------------- | ---------------- |
| scalar        | overwrite        |
| object        | recursive merge  |
| array         | replace          |
| type conflict | later value wins |

### Scalar Merge

Scalar values are overwritten by later layers.

Example:

Base

```yaml
timeout: 30
```

Override

```yaml
timeout: 60
```

Result

```yaml
timeout: 60
```

### Object Merge

Objects are merged recursively.

Example:

Base

```yaml
server:
  host: localhost
  port: 8080
```

Override

```yaml
server:
  port: 9090
```

Result

```yaml
server:
  host: localhost
  port: 9090
```

Object keys that do not conflict remain unchanged.

### Array Merge

Arrays are **not merged**.

The later array replaces the earlier one.

Example:

Base

```yaml
plugins:
  - auth
  - log
```

Override

```yaml
plugins:
  - metrics
```

Result

```yaml
plugins:
  - metrics
```

Reason:

Array merge semantics are ambiguous and often produce unexpected results in configuration systems.
Replacing arrays ensures deterministic behavior.

### Type Conflict

If the value types differ, the later value replaces the earlier value completely.

Example:

Base

```yaml
a: 1
```

Override

```yaml
a:
  b: 2
```

Result

```yaml
a:
  b: 2
```

## Merge Algorithm (Pseudo Code)

```bash
function merge(base, override):

    for key in override:

        if key not in base:
            base[key] = override[key]
            continue

        baseValue = base[key]
        overrideValue = override[key]

        if both objects:
            base[key] = merge(baseValue, overrideValue)

        else:
            base[key] = overrideValue

    return base
```

## Design Principles

The merge model prioritizes:

- deterministic behavior
- CI safety
- minimal complexity
- predictable override semantics

The algorithm intentionally avoids advanced behaviors such as:

- array append
- array deduplication
- schema-aware merging

These features introduce ambiguity and are outside the scope of `voift`.
