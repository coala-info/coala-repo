#!/usr/bin/env python3
"""
Find all bioconductor SKILL.md files where the "Reference documentation" section
does not contain any markdown links to files (e.g. [text](references/foo.md) or [text](./references/foo.md)).
These are placeholder refs like "See files in `references/` for vignettes and tutorials." with no actual links.
"""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / "data"

# Markdown link to a file: [text](path) where path looks like references/..., ./references/..., or *.md
REF_LINK_PATTERN = re.compile(
    r"\[([^\]]*)\]\(\s*(?:\./)?references/[^\s)]+\.(?:md|html?)\s*\)",
    re.IGNORECASE,
)


def get_reference_section(text: str) -> str:
    """Extract the content from ## Reference documentation to the next ## or end."""
    match = re.search(
        r"^##\s+Reference documentation\s*\n(.*?)(?=^##\s|\Z)",
        text,
        re.MULTILINE | re.DOTALL,
    )
    return match.group(1).strip() if match else ""


def has_linked_files_in_ref_section(text: str) -> bool:
    """Return True if the Reference documentation section contains at least one link to a file in references/."""
    section = get_reference_section(text)
    return bool(REF_LINK_PATTERN.search(section))


def main() -> None:
    skill_files = sorted(DATA_DIR.glob("bioconductor-*/skills/SKILL.md"))
    without_links: list[Path] = []

    for skill_path in skill_files:
        try:
            text = skill_path.read_text(encoding="utf-8", errors="replace")
        except Exception:
            continue
        if not has_linked_files_in_ref_section(text):
            without_links.append(skill_path)

    # Output package name only (e.g. bioconductor-s4vectors)
    for p in without_links:
        print(p.parent.parent.name)  # skills/SKILL.md -> bioconductor-*

    print(f"\nTotal: {len(without_links)} bioconductor SKILL.md with no linked files in Reference documentation (of {len(skill_files)} bioconductor skills)", file=__import__("sys").stderr)


if __name__ == "__main__":
    main()
