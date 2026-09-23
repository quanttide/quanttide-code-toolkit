# AGENTS.md - quanttide-code-toolkit

## 项目结构

```
quanttide-code-toolkit/
├── packages/
│   ├── python/           # Python 包（quanttide-code）
│   ├── rust/             # Rust 库（quanttide-code）
│   ├── typescript/       # TypeScript 包（quanttide-code）
│   ├── dart/             # Dart 包（quanttide_code）
│   └── go/               # Go 包（quanttide_code）
├── AGENTS.md
├── CHANGELOG.md
└── README.md
```

## 各语言检查命令

```bash
cd packages/python     && uv sync --locked && uv run pytest
cd packages/rust       && cargo fmt --check && cargo clippy --all-targets -- -D warnings && cargo test --locked
cd packages/typescript && npm ci && npm run typecheck && npm test
cd packages/dart       && dart analyze lib/ test/ && dart test
cd packages/go         && go vet ./... && go test ./...
```

## 提交约定

- 提交信息用中文祈使句，前缀 `feat:`、`fix:`、`docs:`、`chore:`、`refactor:`
- 提交后默认推送到远端
- 语言包内改动在语言包范围提交，仓库级文档改动单独提交

## 评判指标

简洁、生动：能少则少，用真实例子说话。
