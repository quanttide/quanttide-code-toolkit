import { readFileSync } from "node:fs";

import { describe, expect, it } from "vitest";

import { DOMAIN, VERSION } from "../src/index.js";

const vector = JSON.parse(
  readFileSync(new URL("../../../tests/contract/package.json", import.meta.url), "utf-8"),
) as { domain: string; version: string };

describe("契约向量", () => {
  it("领域名与向量一致", () => {
    expect(DOMAIN).toBe(vector.domain);
  });

  it("版本与向量一致", () => {
    expect(VERSION).toBe(vector.version);
  });
});
