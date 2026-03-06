---
title: "Design Specification: Greetings"
Based on: requirements.md v1.0
Status: Draft
---

## 1. Overview

### 1.1 Purpose

本仕様書は、`greetings` モジュールの **振る舞いルール** と **意味論** を定義する。
ユーザー名を受け取り、トリム処理後に `"Hello, <name>!"` 形式の挨拶文字列を生成する処理の仕様を記述する。

### 1.2 Scope

本仕様書は `greetings` モジュールの **振る舞いルール** と **分類の意味論** を定義する。

実装の詳細 (関数名・型・パッケージ構造等) は明示的にスコープ外とする。

---

## 2. Design Principles

### 2.1 Classification Philosophy

入力文字列をトリムし、結果を固定フォーマット `"Hello, <trimmed>!"` で返す単一変換処理として設計する。
すべての入力値 (空文字列・空白のみを含む) を有効な入力として扱い、エラーや例外を発生させない。

### 2.2 Design Assumptions

- 入力は任意の Go `string` 値である (nil は存在しない)
- 出力フォーマットは `"Hello, " + trimmed_name + "!"` で不変である
- トリム対象は Unicode 空白文字 (U+0020 等) とする
- 外部パッケージへの依存なし、標準ライブラリのみ使用する

### 2.3 External Design Summary

> **Source**: Derived from the external design dialogue (Phase E) and user-confirmed design direction (Phase D).

#### Feature Decomposition

| Unit                | Responsibility                                           | FR Coverage         |
| ------------------- | -------------------------------------------------------- | ------------------- |
| greeting generation | ユーザー名を受け取り、トリム後に挨拶文字列を生成して返す | FR-01, FR-02, FR-03 |

#### Unit Interaction Map

Units are independent; no ordering constraints.

### 2.4 Non-Goals

> **Derivation**: All items below originate from REQUIREMENTS Section "Out of Scope".

- CLI インターフェースの提供 ← REQ: Out of Scope #1
- HTTP API やサーバー実装 ← REQ: Out of Scope #2
- 外部 BDD フレームワーク (godog 等) の使用 ← REQ: Out of Scope #3
- 出力言語の切り替え機能 (多言語挨拶テンプレート) ← REQ: Out of Scope #4

### 2.5 Behavioral Design Decisions

<!-- markdownlint-disable line-length -->

| ID    | Decision                                       | Rationale                                                              | Affected Rules | Status |
| ----- | ---------------------------------------------- | ---------------------------------------------------------------------- | -------------- | ------ |
| DD-01 | 空文字列・空白のみの入力もエラーなしで処理する | 要件にすべてのエッジケースが明示されており、エラー処理は不要と確認済み | Rule 4.1, 5.x  | Active |

<!-- markdownlint-enable -->

### 2.6 Related Decision Records

> **Reference**: This section lists formal DRs that affect this specification.

No Decision Records currently affect this specification.

### 2.7 DD to DR Promotion Criteria

> **Purpose**: Guidelines for determining when a DD should be promoted to a formal DR.

**Consider promoting a DD when:**

1. **Cross-specification Impact** — 複数の仕様書やモジュールに影響する決定
2. **Architectural Significance** — 将来の設計選択を制約する決定
3. **Non-trivial Alternatives** — 複数の実行可能な選択肢が存在した
4. **Stakeholder Visibility Required** — 外部関係者がレビューすべき決定

**Keep as DD when:**

- 本仕様書のみに閉じたローカルな決定
- 有意な代替案が存在しなかった
- 根拠がコンテキストから自明

> **Action**: To promote, run `/deckrd dr --add` with the DD context,
> then update DD Status to `Promoted → DR-xx`.

---

## 3. Behavioral Specification

### 3.1 Input Domain

- Input Type: 文字列 (任意の Unicode 文字列)
- Assumptions:
  - すべての文字列値が有効な入力として受け入れられる
  - 空文字列および空白のみの文字列も有効な入力である
  - 日本語などのマルチバイト文字を含む文字列も有効な入力である

### 3.2 Output Semantics

- Output Meaning: `"Hello, <trimmed_name>!"` 形式の挨拶文字列
- Possible Outcomes:
  - 通常のユーザー名: `"Hello, Alice!"` (例: 入力 `"Alice"`)
  - 空文字列入力: `"Hello, !"` (入力 `""`)
  - 空白のみ入力: `"Hello, !"` (例: 入力 `"   "`)
  - 前後空白付き入力: トリム後の名前で挨拶 (例: 入力 `"  Alice  "` → `"Hello, Alice!"`)
  - マルチバイト文字入力: そのまま使用 (例: 入力 `"太郎"` → `"Hello, 太郎!"`)

---

## 4. Decision Rules

Evaluation MUST follow this order:

| Step | Condition                                | Outcome                                        |
| ---: | ---------------------------------------- | ---------------------------------------------- |
|    1 | 入力文字列の前後の空白をトリムする       | トリム済み文字列を得る                         |
|    2 | トリム済み文字列を挨拶フォーマットに適用 | `"Hello, " + trimmed + "!"` の文字列を生成する |
|    3 | 生成した挨拶文字列を返す                 | 呼び出し元に挨拶文字列を返す                   |

No reordering is permitted.

---

## 5. Edge Cases

| Input         | Classification    | Rationale                                                   |
| ------------- | ----------------- | ----------------------------------------------------------- |
| `""`          | `"Hello, !"`      | 空文字列のトリムは空文字列のまま; フォーマットを適用する    |
| `"   "`       | `"Hello, !"`      | 空白のみはトリム後に空文字列になる; フォーマットを適用する  |
| `"  Alice  "` | `"Hello, Alice!"` | 前後の空白をトリムし、残った `"Alice"` をフォーマットに適用 |
| `"太郎"`      | `"Hello, 太郎!"`  | マルチバイト文字はトリム対象外; そのままフォーマットに適用  |

---

## 6. Requirements Traceability

| Requirement ID | Covered By                                                                             |
| -------------- | -------------------------------------------------------------------------------------- |
| FR-01          | Section 3.1 (Input Domain), Section 3.2 (Output Semantics), Section 4 (Decision Rules) |
| FR-02          | Section 3.2 (Possible Outcomes), Section 4 (Decision Rules Step 2)                     |
| FR-03          | Section 4 (Decision Rules Step 1), Section 5 (Edge Cases)                              |

---

## 7. Open Questions

> **Status**: COMPLETE

None identified - all requirements are unambiguous.

---

## 8. Change History

| Date       | Version | Description           |
| ---------- | ------- | --------------------- |
| 2026-03-06 | 1.0     | Initial specification |
