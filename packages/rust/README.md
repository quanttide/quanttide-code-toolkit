# quanttide-code Rust 库

软件工程领域 Rust 语言工具包。

## 安装

在 `Cargo.toml` 中添加：

```toml
[dependencies]
quanttide-code = "0.1.0"
```

## 使用

```rust
use quanttide_code::{DOMAIN, VERSION};

println!("{DOMAIN} v{VERSION}");
```

## 测试

```bash
cargo test
```

## 许可

CC-BY-4.0
