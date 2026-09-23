from quanttide_code import DOMAIN, __version__


def test_version():
    assert __version__ == "0.1.0"


def test_domain():
    assert DOMAIN == "software-engineering"
