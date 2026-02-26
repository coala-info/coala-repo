#!/usr/bin/env python3
"""
Find all CWL files and report those that:
- have no inputs (inputs: [] or empty), or
- have "container runtime error" in the doc section.
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / "data"

# Try to use PyYAML for reliable parsing; fall back to regex if not available
try:
    import yaml
    HAS_YAML = True
except ImportError:
    HAS_YAML = False

DOC_ERROR_PATTERN = re.compile(r"container\s+runtime\s+error", re.IGNORECASE)


def has_empty_inputs_yaml(data: dict) -> bool:
    """Return True if inputs is missing or empty (list or dict)."""
    inputs = data.get("inputs")
    if inputs is None:
        return True
    if isinstance(inputs, list) and len(inputs) == 0:
        return True
    if isinstance(inputs, dict) and len(inputs) == 0:
        return True
    return False


def get_doc_yaml(data: dict) -> str:
    """Get doc string from CWL (root or under CommandLineTool)."""
    doc = data.get("doc")
    if doc is not None:
        return str(doc) if not isinstance(doc, list) else "\n".join(str(d) for d in doc)
    # $graph / nested tool
    for node in data.get("$graph", [data]):
        if isinstance(node, dict):
            doc = node.get("doc")
            if doc is not None:
                return str(doc) if not isinstance(doc, list) else "\n".join(str(d) for d in doc)
    return ""


def has_container_runtime_error_in_doc_yaml(data: dict) -> bool:
    return bool(DOC_ERROR_PATTERN.search(get_doc_yaml(data)))


def check_with_regex(content: str) -> tuple[bool, bool]:
    """Fallback: detect empty inputs and doc containing 'container runtime error' via regex."""
    empty_inputs = bool(re.search(r"^inputs:\s*\[\]\s*$", content, re.MULTILINE))
    # doc can be "doc: \"...\" or doc: | or doc: >, then multi-line; look in first 8k for doc block
    doc_match = re.search(r"^doc:\s*(?:\|\s*\n)?(?:\s*.+\n)*", content, re.MULTILINE)
    doc_block = doc_match.group(0) if doc_match else content[:8192]
    has_error = bool(DOC_ERROR_PATTERN.search(doc_block))
    return empty_inputs, has_error


def check_cwl(path: Path) -> tuple[bool, bool]:
    """
    Return (no_inputs, container_runtime_error_in_doc).
    """
    try:
        content = path.read_text(encoding="utf-8", errors="replace")
    except Exception:
        return False, False

    if HAS_YAML:
        try:
            data = yaml.safe_load(content)
            if data is None:
                return False, False
            no_inputs = has_empty_inputs_yaml(data)
            has_error = has_container_runtime_error_in_doc_yaml(data)
            return no_inputs, has_error
        except Exception:
            pass
    # Fallback
    return check_with_regex(content)


def get_problematic_cwl_paths():
    """Return list of Paths (relative to ROOT) for all CWL files with issues."""
    cwl_files = sorted(DATA_DIR.rglob("*.cwl"))
    out = []
    for p in cwl_files:
        no_inputs, doc_error = check_cwl(p)
        if no_inputs or doc_error:
            out.append(p.relative_to(ROOT))
    return out


def main():
    cwl_files = sorted(DATA_DIR.rglob("*.cwl"))
    no_inputs_list = []
    doc_error_list = []
    both_list = []

    for p in cwl_files:
        no_inputs, doc_error = check_cwl(p)
        rel = p.relative_to(ROOT)
        if no_inputs and doc_error:
            both_list.append(rel)
        elif no_inputs:
            no_inputs_list.append(rel)
        elif doc_error:
            doc_error_list.append(rel)

    # Report
    def report(label: str, paths: list):
        if paths:
            print(f"\n{label} ({len(paths)}):")
            for x in paths:
                print(f"  {x}")

    print("CWL issues report")
    print("=================")
    report("No inputs AND 'container runtime error' in doc", both_list)
    report("No inputs only (inputs: [])", no_inputs_list)
    report("'container runtime error' in doc only", doc_error_list)

    total_issues = len(no_inputs_list) + len(doc_error_list) + len(both_list)
    print(f"\nTotal CWL files scanned: {len(cwl_files)}")
    print(f"Total with at least one issue: {total_issues}")

    # Write problematic tool names only (folder under data/), unique, sorted
    all_problematic_paths = both_list + no_inputs_list + doc_error_list
    tool_names = sorted(set(p.parts[1] for p in all_problematic_paths))  # data/<tool>/... -> tool
    list_path = ROOT / "cwl_problematic_tools.txt"
    list_path.write_text("\n".join(tool_names) + "\n", encoding="utf-8")
    print(f"\nProblematic tools list ({len(tool_names)} tools) written to: {list_path}")

    if total_issues > 0:
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    main()
