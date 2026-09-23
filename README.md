# quanttide-code-toolkit

量潮软件工程工具箱 — 软件工程领域的共享库与工具集（独立仓库，挂载于 quanttide-code/packages）。

## 概述

承载软件工程领域的纯逻辑与共享能力，按语言拆分为独立包：

| 包 | 语言 | 包名 | 说明 |
|---|---|---|---|
| [`packages/python`](packages/python) | Python | `quanttide-code` | 软件工程 Python 包 |
| [`packages/rust`](packages/rust) | Rust | `quanttide-code` | 软件工程 Rust 库 |
| [`packages/typescript`](packages/typescript) | TypeScript | `quanttide-code` | 软件工程 TypeScript 包 |
| [`packages/dart`](packages/dart) | Dart | `quanttide_code` | 软件工程 Dart 包 |
| [`packages/go`](packages/go) | Go | `quanttide_code` | 软件工程 Go 包 |

新增语言包时在 `packages/{语言}/` 下独立发布，互不依赖。

## 发布自动化

待补充——语言包就绪后，由 tag 触发的发布工作流承担。
