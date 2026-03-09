---
title: "Implementation Plan: Greetings"
Based on: specifications.md v1.1
Status: Draft
---

## 1. Overview

### 1.1 Purpose

`greeting` モジュールの実装計画を記述する。
ユーザー名を受け取り、前後の空白をトリムした後に `"Hello, <name>!"` 形式の挨拶文字列を返す
`Greet` 関数を `internal/greeting/` パッケージに実装する。
実装コミットとテストコミットを分けた 2 コミット構成で進める。

### 1.2 Reference

- Prior Art / Reference PR: none
- Specifications: `specifications/specifications.md`

---

## 2. Package Structure

```
internal/greeting/
    greet.go
    greet_test.go
    tests/
        greet_api_test.go    # package greeting_test
```

---

## 3. Implementation Plan

### Phase 1: Greet Function Implementation

`internal/greeting/` ディレクトリを新規作成し、`Greet` 関数の実装とテストを
2 コミットに分けて追加する。

#### Commit 1: `feat(greeting): implement Greet function`

- `internal/greeting/greet.go` を作成し `Greet(name string) string` を実装する
  - `strings.TrimSpace(name)` で前後空白を除去する
  - `"Hello, " + trimmed + "!"` の形式で挨拶文字列を生成して返す

#### Commit 2: `test(greeting): add unit and api tests for Greet`

- `internal/greeting/greet_test.go` に内部テストを追加する
  - 通常のユーザー名 (`"Alice"` → `"Hello, Alice!"`)
  - 空文字列 (`""` → `"Hello, !"`)
  - 空白のみ (`"   "` → `"Hello, !"`)
  - 前後空白付き (`"  Alice  "` → `"Hello, Alice!"`)
  - マルチバイト文字 (`"太郎"` → `"Hello, 太郎!"`)
  - Unicode 混在文字列 (`" Alice 太郎 "` → `"Hello, Alice 太郎!"`)
- `internal/greeting/tests/greet_api_test.go` に API コントラクトテストを追加する
  - パッケージ: `greeting_test`
  - `import "github.com/<org>/voift/internal/greeting"` として外部パッケージとして使用する
  - 同一エッジケースを公開 API のみで検証する

---

## 4. Change History

| Date       | Version | Description             |
| ---------- | ------- | ----------------------- |
| 2026-03-08 | 1.0     | Initial implementation plan |
