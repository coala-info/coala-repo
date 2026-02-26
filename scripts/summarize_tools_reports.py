#!/usr/bin/env python3
"""Parse all data/*/report.md and output a summary table (tool name, homepage, conda, github, total downloads, last updated, validation, skill)."""

import csv
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / "data"
MD_OUTPUT_PATH = DATA_DIR / "tools-summary.md"
CSV_OUTPUT_PATH = ROOT / "tools-summary.csv"


def extract_field(text: str, key: str) -> str:
    """Extract value after '- **Key**: value' or '- **Key**: value (rest)'."""
    # Match - **Key**: value (capture until newline or end)
    pattern = rf"^-\s+\*\*{re.escape(key)}\*\*:\s*(.+?)(?=\n|$)"
    m = re.search(pattern, text, re.MULTILINE | re.DOTALL)
    if m:
        return m.group(1).strip()
    return ""


def parse_report(report_path: Path) -> dict | None:
    tool_name = report_path.parent.name
    try:
        text = report_path.read_text(encoding="utf-8", errors="replace")
    except Exception:
        return None

    # First Metadata block (under ### Metadata) has: Homepage, Conda, GitHub, Total Downloads, Last updated, Validation
    first_meta = re.search(r"### Metadata\s*\n(.*?)(?=###|\n## |\Z)", text, re.DOTALL)
    meta_block = first_meta.group(1) if first_meta else text

    homepage = extract_field(meta_block, "Homepage")
    conda = extract_field(meta_block, "Conda")
    github = extract_field(meta_block, "GitHub")
    total_downloads = extract_field(meta_block, "Total Downloads")
    last_updated = extract_field(meta_block, "Last updated")
    validation = extract_field(meta_block, "Validation")

    # Skill is usually in the last "## Metadata" section
    skill = ""
    for m in re.finditer(r"## Metadata\s*\n(.*?)(?=\n## |\Z)", text, re.DOTALL):
        block = m.group(1)
        s = extract_field(block, "Skill")
        if s:
            skill = s

    # If tool dir has CWL files, validation is PASS regardless of report text
    tool_dir = report_path.parent
    if list(tool_dir.glob("*.cwl")):
        validation = "PASS"

    return {
        "tool": tool_name,
        "homepage": homepage or "—",
        "conda": conda or "—",
        "github": github or "—",
        "total_downloads": total_downloads or "—",
        "last_updated": last_updated or "—",
        "validation": validation or "—",
        "skill": skill or "—",
    }


def main():
    report_files = sorted(DATA_DIR.glob("*/report.md"))
    rows = []
    for p in report_files:
        row = parse_report(p)
        if row:
            rows.append(row)

    # Build markdown table
    headers = ["Tool", "Homepage", "Conda", "GitHub", "Total Downloads", "Last updated", "Validation", "Skill"]
    lines = []
    header_line = "| " + " | ".join(headers) + " |"
    sep_line = "|" + "|".join("-" * (len(h) + 2) for h in headers) + "|"

    lines.append(header_line)
    lines.append(sep_line)

    for r in rows:
        cells = [
            r["tool"],
            r["homepage"][:60] + "…" if len(r["homepage"]) > 60 else r["homepage"],
            r["conda"][:50] + "…" if len(r["conda"]) > 50 else r["conda"],
            r["github"][:50] + "…" if len(r["github"]) > 50 else r["github"],
            r["total_downloads"],
            r["last_updated"],
            r["validation"],
            r["skill"],
        ]
        lines.append("| " + " | ".join(str(c) for c in cells) + " |")

    # Summary stats
    n_pass = sum(1 for r in rows if r["validation"].strip().upper().startswith("PASS"))
    n_fail = len(rows) - n_pass
    n_skill_yes = sum(1 for r in rows if "generated" in r["skill"].lower())
    n_skill_no = len(rows) - n_skill_yes

    summary = f"""# Tools status summary (from data/*/report.md)

| Metric | Count |
|--------|-------|
| **Total tools** | {len(rows)} |
| **Validation PASS** | {n_pass} |
| **Validation FAIL** | {n_fail} |
| **Skill generated** | {n_skill_yes} |
| **Skill not generated** | {n_skill_no} |

"""
    out = summary + "\n".join(lines)
    MD_OUTPUT_PATH.write_text(out, encoding="utf-8")
    print(f"Wrote {len(rows)} rows to {MD_OUTPUT_PATH}")

    # CSV to current folder (workspace root)
    fieldnames = ["tool", "homepage", "conda", "github", "total_downloads", "last_updated", "validation", "skill"]
    with open(CSV_OUTPUT_PATH, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(rows)
    print(f"Wrote {len(rows)} rows to {CSV_OUTPUT_PATH}")


if __name__ == "__main__":
    main()
