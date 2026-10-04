#!/usr/bin/env python3
"""Build the terminal downstream proof for a managed release (Gitea #3382).

The central coordinator dispatches 'terraphim-release' with a client_payload
containing schema_version, release_tag, manifest_sha256, correlation_id,
channel and assets[{name, sha256}]. A downstream channel must return a proof
artifact named terraphim-release-proof-<correlation_id>-<channel> whose
proof.json is bound to exactly that frozen release:

    schema_version, channel, release_tag, manifest_sha256, correlation_id,
    outcome == "success", and the sorted asset {name, sha256} set.

This script builds that file deterministically so the workflow step is trivial
and the contract is unit-testable.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

SCHEMA_VERSION = "1.0.0"


def normalize_assets(assets: object) -> list[dict[str, str]]:
    if assets is None:
        assets = []
    if not isinstance(assets, list):
        raise SystemExit("assets must be a JSON array")
    seen: set[str] = set()
    out: list[dict[str, str]] = []
    for entry in assets:
        if not isinstance(entry, dict):
            raise SystemExit("every asset must be an object")
        name = str(entry.get("name", ""))
        sha = str(entry.get("sha256", ""))
        if not name or len(sha) != 64:
            raise SystemExit(f"invalid asset entry: {entry!r}")
        if name in seen:
            raise SystemExit(f"duplicate asset name: {name}")
        seen.add(name)
        out.append({"name": name, "sha256": sha})
    return sorted(out, key=lambda a: a["name"])


def build(
    channel: str,
    release_tag: str,
    manifest_sha256: str,
    correlation_id: str,
    assets: object,
    outcome: str,
) -> dict:
    if not channel:
        raise SystemExit("channel is required")
    if not release_tag:
        raise SystemExit("release_tag is required")
    if len(manifest_sha256) != 64 or len(correlation_id) != 64:
        raise SystemExit("manifest_sha256 and correlation_id must be 64 hex characters")
    if outcome not in ("success", "failure"):
        raise SystemExit("outcome must be success or failure")
    return {
        "schema_version": SCHEMA_VERSION,
        "channel": channel,
        "release_tag": release_tag,
        "manifest_sha256": manifest_sha256,
        "correlation_id": correlation_id,
        "outcome": outcome,
        "assets": normalize_assets(assets),
    }


def self_test() -> None:
    a = {"name": "b.tar.gz", "sha256": "b" * 64}
    b = {"name": "a.tar.gz", "sha256": "a" * 64}
    proof = build("homebrew_tap_pr", "v1.2.3", "c" * 64, "d" * 64, [a, b], "success")
    assert [x["name"] for x in proof["assets"]] == ["a.tar.gz", "b.tar.gz"]
    try:
        build("x", "v1", "short", "d" * 64, [], "success")
    except SystemExit:
        pass
    else:
        raise AssertionError("short digests must be rejected")
    print("build-release-proof self-test OK")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--channel")
    parser.add_argument("--release-tag")
    parser.add_argument("--manifest-sha256")
    parser.add_argument("--correlation-id")
    parser.add_argument("--assets-json", default="[]")
    parser.add_argument("--outcome", default="success")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args(argv)
    if args.self_test:
        self_test()
        return 0
    for required in ("channel", "release_tag", "manifest_sha256", "correlation_id", "output"):
        if getattr(args, required) in (None, ""):
            parser.error(f"--{required.replace('_', '-')} is required")
    try:
        assets = json.loads(args.assets_json)
    except json.JSONDecodeError as exc:
        raise SystemExit(f"--assets-json is not valid JSON: {exc}") from exc
    proof = build(args.channel, args.release_tag, args.manifest_sha256,
                  args.correlation_id, assets, args.outcome)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(proof, indent=2, sort_keys=True) + "\n")
    print(args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
