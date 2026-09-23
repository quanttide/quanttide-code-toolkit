# Changelog

## [Unreleased]

- 初始化工具箱仓库：Python、Rust、TypeScript、Dart、Go 五个语言包骨架（领域名与版本常量 + 冒烟测试）。
- 加入契约：`tests/contract/package.json` 向量 + 五语言契约测试 + `scripts/contract.sh`（清单与向量一致性）。
- 加入五个发布工作流 `release-{python,rust,typescript,dart,go}.yml`：质量门禁（标签／清单／CHANGELOG 一致 → 语言检查 → 契约 → 打包预检）→ 注册表发布 → 补 GitHub Release。
