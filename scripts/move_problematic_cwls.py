#!/usr/bin/env python3
"""
Move all problematic CWL files to back/cwl/, preserving structure:
  data/<tool>/foo.cwl  ->  back/cwl/<tool>/foo.cwl
"""

import shutil
import sys
from pathlib import Path

SCRIPTS_DIR = Path(__file__).resolve().parent
ROOT = SCRIPTS_DIR.parent
BACK_CWL = ROOT / "back" / "cwl"
sys.path.insert(0, str(SCRIPTS_DIR))
from check_cwl_issues import get_problematic_cwl_paths

def main():
    paths = get_problematic_cwl_paths()
    if not paths:
        print("No problematic CWL files found.")
        return 0

    print(f"Moving {len(paths)} problematic CWL files to {BACK_CWL.relative_to(ROOT)}/")
    moved = 0
    errors = []
    for rel in paths:
        src = ROOT / rel
        # data/<tool>/file.cwl -> back/cwl/<tool>/file.cwl
        dest = BACK_CWL / Path(*rel.parts[1:])
        if not src.exists():
            errors.append(f"Skip (missing): {rel}")
            continue
        try:
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(str(src), str(dest))
            moved += 1
            if moved <= 5 or moved % 2000 == 0:
                print(f"  {rel} -> {dest.relative_to(ROOT)}")
        except Exception as e:
            errors.append(f"{rel}: {e}")

    print(f"\nMoved {moved} files.")
    if errors:
        print(f"Errors/skips ({len(errors)}):")
        for e in errors[:20]:
            print(f"  {e}")
        if len(errors) > 20:
            print(f"  ... and {len(errors) - 20} more")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
