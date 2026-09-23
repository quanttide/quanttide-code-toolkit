import json
from pathlib import Path

from quanttide_code import DOMAIN, __version__

VECTOR = Path(__file__).resolve().parents[3] / "tests" / "contract" / "package.json"


def test_contract_matches_vector():
    vector = json.loads(VECTOR.read_text(encoding="utf-8"))
    assert DOMAIN == vector["domain"]
    assert __version__ == vector["version"]
