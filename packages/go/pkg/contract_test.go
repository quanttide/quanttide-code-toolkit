package quanttide_code_test

import (
	"encoding/json"
	"os"
	"testing"

	quanttide_code "github.com/quanttide/quanttide-code-toolkit/packages/go/pkg"
)

type contractVector struct {
	Domain  string `json:"domain"`
	Version string `json:"version"`
}

func TestContractMatchesVector(t *testing.T) {
	raw, err := os.ReadFile("../../../tests/contract/package.json")
	if err != nil {
		t.Fatalf("契约向量读取失败：%v", err)
	}

	var vector contractVector
	if err := json.Unmarshal(raw, &vector); err != nil {
		t.Fatalf("契约向量不是合法 JSON：%v", err)
	}

	if quanttide_code.Domain != vector.Domain {
		t.Fatalf("领域名与向量不一致：%s / %s", quanttide_code.Domain, vector.Domain)
	}
	if quanttide_code.Version != vector.Version {
		t.Fatalf("版本与向量不一致：%s / %s", quanttide_code.Version, vector.Version)
	}
}
