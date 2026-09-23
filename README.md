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

**实现状态**：五个包目前都是骨架——只导出领域名（`software-engineering`）与版本常量；领域模型就绪后按子领域补。

## 项目结构

```
quanttide-code-toolkit/
├── .github/workflows/    # 各语言发布工作流（release-{语言}.yml）
├── packages/
│   ├── python/           # Python 包（quanttide-code）
│   ├── rust/             # Rust 库（quanttide-code）
│   ├── typescript/       # TypeScript 包（quanttide-code）
│   ├── dart/             # Dart 包（quanttide_code）
│   └── go/               # Go 包（quanttide_code）
├── scripts/contract.sh   # 五语言契约一致性（清单／常量 ↔ 向量）
├── tests/contract/       # 契约向量：各语言共用一份正本
├── AGENTS.md
├── CHANGELOG.md
└── README.md
```

## 契约

[`tests/contract/package.json`](tests/contract/package.json) 是五语言共用的唯一正本，钉住领域名与版本；各语言的契约测试读同一份向量，`scripts/contract.sh` 再把五个清单与常量同向量对一遍。

```bash
sh scripts/contract.sh            # 只查五语言与向量是否一致
sh scripts/contract.sh rust       # 再跑该语言的契约测试（python|rust|typescript|dart|go）
```

改版本号时四处一起改：`pyproject.toml`、`Cargo.toml`、`package.json`、`pubspec.yaml`，以及 Go 的 `pkg/package.go`——`contract.sh` 会把不一致的挑出来。

## 发布自动化

一个语言包一个发布工作流，推 `{语言}/vX.Y.Z` 标签触发：先校验标签、清单版本与 CHANGELOG 三者一致，再跑语言检查、契约测试与打包预检，然后发布到对应仓库，最后在仓库里补一条 GitHub Release（自动生成变更说明，`-alpha.` / `-beta.` / `-rc.` 标预发布）。

| 工作流 | 标签 | 发布目标 |
|---|---|---|
| [`release-python.yml`](.github/workflows/release-python.yml) | `python/vX.Y.Z` | PyPI |
| [`release-rust.yml`](.github/workflows/release-rust.yml) | `rust/vX.Y.Z` | crates.io |
| [`release-typescript.yml`](.github/workflows/release-typescript.yml) | `typescript/vX.Y.Z` | npm |
| [`release-dart.yml`](.github/workflows/release-dart.yml) | `dart/vX.Y.Z` | pub.dev |
| [`release-go.yml`](.github/workflows/release-go.yml) | `go/vX.Y.Z` | 生成模块别名标签 `packages/go/vX.Y.Z` |

发版前把包内 CHANGELOG 的 `[Unreleased]` 落成 `## [X.Y.Z]`，并同步清单版本。也可在 Actions 页面手动派发，指定标签重跑。

工作流只管「发布前验证 + 发布」，不在 push/PR 上单独跑 CI；需要 PR 门禁时，给对应工作流加 `pull_request` 路径触发即可。
