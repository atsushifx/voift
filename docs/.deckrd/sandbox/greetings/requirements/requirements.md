---
title: "Requirements: Greetings"
Module: "sandbox/greetings"
Status: Draft
Version: 1.0
Created: "2026-03-06"
---

> **Normative Statement**
> This document defines binding requirements.
> Implementations MUST conform to this document.
> RFC 2119 keywords apply to this document only.

## 1. Overview

### 1.1 Purpose

BDD のサンプル実装として、ユーザー名を受け取り `"Hello, <user>!"` 形式の挨拶文字列を返す `greetings` モジュールを Go で作成する。
本モジュールは Go における BDD スタイルのテスト手法の学習・参照用実装を目的とする。

### 1.2 Scope

- Go パッケージ `greetings` の実装
- ユーザー名を受け取り挨拶文字列を返す関数の実装
- BDD スタイルによるテストの実装

**Out of Scope**:

- CLI インターフェース (コマンドライン引数による入力)
- HTTP API やサーバー実装
- 外部 BDD フレームワーク (godog 等) の使用
- 出力言語の切り替え機能 (こんにちは、Bonjour 等の多言語挨拶テンプレート)

## 2. Context

- Target Environment: Go (最新安定版)
- Related Components: `sandbox/greetings` モジュール
- Assumptions:
  - 標準ライブラリのみ使用

## 3. Functional Requirements

- FR-01: 挨拶関数はユーザー名を文字列で受け取り、挨拶文字列を返す SHALL
- FR-02: ユーザー名 `"Alice"` を渡すと `"Hello, Alice!"` を返す SHALL
- FR-03: ユーザー名の前後の空白をトリムする SHALL

## 4. Non-Functional Requirements

### 4.1 Quality

- Maintainability: 関数は単一責務とし、テストと実装を明確に分離する
- Testability: 全ケースを網羅的にテスト可能であること
- Portability: 標準ライブラリのみ使用し、外部依存ゼロとする

### 4.2 Constraints

- Go 標準ライブラリのみ使用 (外部パッケージ禁止)
- パッケージ名: `greetings`

## 5. Change History

| Date       | Version | Description     |
| ---------- | ------- | --------------- |
| 2026-03-06 | 1.0     | Initial release |

## 6. User Stories

| ID    | Role   | Goal                                           | Reason                                      |
| ----- | ------ | ---------------------------------------------- | ------------------------------------------- |
| US-01 | 開発者 | 挨拶関数にユーザー名を渡して挨拶文を取得したい | 挨拶ロジックを再利用可能な形で利用するため  |
| US-02 | 開発者 | 複数パターンを網羅的に検証したい               | BDD スタイルのテストを学ぶため              |
| US-03 | 学習者 | BDD の概念を Go で体験したい                   | 外部フレームワーク不要で BDD を理解するため |

## 7. Acceptance Criteria

```gherkin
Scenario: 通常のユーザー名で挨拶を返す
  Given ユーザー名 "Alice" が指定されている
  When  挨拶関数を "Alice" で呼び出す
  Then  "Hello, Alice!" が返される

Scenario: 別のユーザー名で挨拶を返す
  Given ユーザー名 "Bob" が指定されている
  When  挨拶関数を "Bob" で呼び出す
  Then  "Hello, Bob!" が返される

Scenario: 日本語ユーザー名で挨拶を返す
  Given ユーザー名 "太郎" が指定されている
  When  挨拶関数を "太郎" で呼び出す
  Then  "Hello, 太郎!" が返される

Scenario: 空文字列で空の挨拶を返す
  Given ユーザー名が空文字列 "" である
  When  挨拶関数を "" で呼び出す
  Then  "Hello, !" が返される

Scenario: 前後に空白があるユーザー名はトリムして挨拶を返す
  Given ユーザー名 "  Alice  " が指定されている
  When  挨拶関数を "  Alice  " で呼び出す
  Then  "Hello, Alice!" が返される

Scenario: 空白のみのユーザー名は Hello,! を返す
  Given ユーザー名が空白のみ "   " である
  When  挨拶関数を "   " で呼び出す
  Then  "Hello, !" が返される
```

## 8. Open Questions

| Question                                                                               | Type | Impact Area | Owner  |
| -------------------------------------------------------------------------------------- | ---- | ----------- | ------ |
| 将来的に出力言語の切り替え機能 (Bonjour, こんにちは 等の挨拶テンプレート) を追加するか | 方針 | Scope       | 開発者 |
