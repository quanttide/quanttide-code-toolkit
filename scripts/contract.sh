#!/bin/sh
# 契约：五个语言包声明同一个领域名与版本，且各语言的契约测试与向量一致。
#
# 用法（在工具箱根目录）：
#   sh scripts/contract.sh            # 只查五个清单／常量的一致性
#   sh scripts/contract.sh rust       # 再跑该语言的契约测试（python|rust|typescript|dart|go）
#
# 为什么先查一致性：五个清单各自是事实源，向量是唯一的对表处；
# 一处手滑改了版本，这里就红。

set -e
root=$(cd "$(dirname "$0")/.." && pwd)
lang=${1:-}
vector="$root/tests/contract/package.json"

py_version=$(grep -m1 '^version = ' "$root/packages/python/pyproject.toml" | cut -d'"' -f2)
rs_version=$(grep -m1 '^version = ' "$root/packages/rust/Cargo.toml" | cut -d'"' -f2)
ts_version=$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1]))["version"])' "$root/packages/typescript/package.json")
dart_version=$(awk '/^version:/{print $2; exit}' "$root/packages/dart/pubspec.yaml")
go_version=$(grep -m1 '^const Version' "$root/packages/go/pkg/package.go" | cut -d'"' -f2)

py_domain=$(grep -m1 '^DOMAIN' "$root/packages/python/src/quanttide_code/__init__.py" | cut -d'"' -f2)
rs_domain=$(grep -m1 '^pub const DOMAIN' "$root/packages/rust/src/lib.rs" | cut -d'"' -f2)
ts_domain=$(grep -m1 '^export const DOMAIN' "$root/packages/typescript/src/index.ts" | cut -d'"' -f2)
dart_domain=$(grep -m1 '^const String domain' "$root/packages/dart/lib/quanttide_code.dart" | cut -d"'" -f2)
go_domain=$(grep -m1 '^const Domain' "$root/packages/go/pkg/package.go" | cut -d'"' -f2)

vector_domain=$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1]))["domain"])' "$vector")
vector_version=$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1]))["version"])' "$vector")

echo "— 领域名（向量：$vector_domain）"
printf '  %-12s %s\n' python "$py_domain" rust "$rs_domain" typescript "$ts_domain" dart "$dart_domain" go "$go_domain"
echo "— 版本（向量：$vector_version）"
printf '  %-12s %s\n' python "$py_version" rust "$rs_version" typescript "$ts_version" dart "$dart_version" go "$go_version"

failed=0
for pair in "python:$py_domain:$py_version" "rust:$rs_domain:$rs_version" \
            "typescript:$ts_domain:$ts_version" "dart:$dart_domain:$dart_version" \
            "go:$go_domain:$go_version"; do
  name=${pair%%:*}; rest=${pair#*:}; domain=${rest%%:*}; version=${rest#*:}
  [ "$domain" = "$vector_domain" ] || { echo "  ✗ $name 领域名与向量不一致：$domain" >&2; failed=1; }
  [ "$version" = "$vector_version" ] || { echo "  ✗ $name 版本与向量不一致：$version" >&2; failed=1; }
done

if [ -n "$lang" ]; then
  echo "— $lang 契约测试"
  case "$lang" in
    python)     (cd "$root/packages/python" && uv run pytest tests/test_contract.py) ;;
    rust)       (cd "$root/packages/rust" && cargo test --locked --test contract) ;;
    typescript) (cd "$root/packages/typescript" && npm test -- test/contract.test.ts) ;;
    dart)       (cd "$root/packages/dart" && dart test test/contract_test.dart) ;;
    go)         (cd "$root/packages/go" && go test ./pkg/ -run Contract -count=1) ;;
    *) echo "未知语言：$lang" >&2; exit 2 ;;
  esac
fi

if [ "$failed" -eq 0 ]; then
  echo "五语言契约一致"
else
  echo "契约破了：见上面的 ✗" >&2
fi
exit "$failed"
