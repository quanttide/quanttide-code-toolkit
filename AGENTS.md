# AGENTS.md - quanttide-code-toolkit

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
├── scripts/contract.sh   # 五语言契约一致性
├── tests/contract/       # 契约向量（各语言共用一份正本）
├── AGENTS.md
├── CHANGELOG.md
└── README.md
```

## 契约

`tests/contract/package.json` 钉住五个语言包共同的领域名与版本；各语言在 `test/`（Go 在 `pkg/`）下有读该向量的契约测试。**改版本或领域名时清单与向量一起改**，`contract.sh` 会把漏改的挑出来。

契约测试读向量的路径按各语言的工作目录写（`cargo test` / `dart test` 的工作目录是包根，`go test` 是包目录），移动向量位置时五个测试一起改。

## 各语言检查命令

```bash
sh scripts/contract.sh            # 只查五语言与向量一致
sh scripts/contract.sh rust       # 再跑 Rust 契约测试

cd packages/python     && uv sync --locked && uv run pytest
cd packages/rust       && cargo fmt --check && cargo clippy --all-targets -- -D warnings && cargo test --locked
cd packages/typescript && npm ci && npm run typecheck && npm test
cd packages/dart       && dart pub get && dart analyze lib/ test/ && dart test
cd packages/go         && go vet ./... && go test ./...
```

## 发布约定

- 一个语言包一个工作流：`release-{语言}.yml`，标签 `{语言}/vX.Y.Z`
- 质量门禁顺序：标签 ↔ 清单版本 ↔ CHANGELOG 一致 → 语言检查（格式、测试、静态检查）→ 契约 → 打包预检
- 注册表发布成功后补 GitHub Release；`-alpha.` / `-beta.` / `-rc.` 自动标预发布
- 发版前把包内 CHANGELOG 的 `[Unreleased]` 落成 `## [X.Y.Z]` 并同步清单版本，否则工作流在校验步失败
- 需要四个仓库密钥：`PYPI_API_TOKEN`、`CRATES_API_TOKEN`、`NPM_API_TOKEN`、`PUBDEV_CREDENTIAL_JSON`

## 提交约定

- 提交信息用中文祈使句，前缀 `feat:`、`fix:`、`docs:`、`chore:`、`refactor:`
- 提交后默认推送到远端
- 语言包内改动在语言包范围提交，仓库级文档改动单独提交

## 评判指标

简洁、生动：能少则少，用真实例子说话。
