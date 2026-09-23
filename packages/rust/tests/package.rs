use quanttide_code::{DOMAIN, VERSION};

#[test]
fn version_matches_manifest() {
    assert_eq!(VERSION, "0.1.0");
}

#[test]
fn domain_name() {
    assert_eq!(DOMAIN, "software-engineering");
}
