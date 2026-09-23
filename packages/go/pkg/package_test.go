package quanttide_code_test

import (
	"testing"

	quanttide_code "github.com/quanttide/quanttide-code-toolkit/packages/go/pkg"
)

func TestDomain(t *testing.T) {
	if quanttide_code.Domain != "software-engineering" {
		t.Fatalf("领域英文名不符：%s", quanttide_code.Domain)
	}
}

func TestVersion(t *testing.T) {
	if quanttide_code.Version != "0.1.0" {
		t.Fatalf("包版本不符：%s", quanttide_code.Version)
	}
}
