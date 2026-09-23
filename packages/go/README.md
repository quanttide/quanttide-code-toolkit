# quanttide-code Go 包

软件工程工具箱（Go 包）——软件工程领域的共享能力。

## 安装

```bash
go get github.com/quanttide/quanttide-code-toolkit/packages/go@v0.1.0
```

## 使用

```go
import quanttide_code "github.com/quanttide/quanttide-code-toolkit/packages/go/pkg"

fmt.Println(quanttide_code.Domain, quanttide_code.Version)
```

## 开发

```bash
go test ./...
go vet ./...
```

## 许可

[CC BY 4.0](../../LICENSE)
