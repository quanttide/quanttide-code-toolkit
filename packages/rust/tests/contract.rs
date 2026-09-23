use std::fs;

use quanttide_code::{DOMAIN, VERSION};

#[test]
fn contract_matches_vector() {
    // cargo test 的工作目录是包根（packages/rust），向量在工具箱根下
    let raw = fs::read_to_string("../../tests/contract/package.json")
        .expect("契约向量 tests/contract/package.json 应存在");
    let vector: serde_json::Value = serde_json::from_str(&raw).expect("契约向量应是合法 JSON");

    assert_eq!(DOMAIN, vector["domain"].as_str().unwrap());
    assert_eq!(VERSION, vector["version"].as_str().unwrap());
}
