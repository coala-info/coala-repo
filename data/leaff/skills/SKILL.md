---
name: leaff
description: Leaff is a specialized diffing utility that analyzes compiled Lean modules to provide a high-level summary of logical changes between project versions. Use when user asks to compare Lean library versions, identify added or removed theorems, detect renamed lemmas, or verify that a refactor preserved the intended logic.
homepage: https://github.com/alexjbest/leaff
metadata:
  docker_image: "biocontainers/leaff:v020150903r2013-6-deb_cv1"
---

# leaff

## Overview

Leaff is a specialized diffing utility designed for the Lean theorem prover environment. Unlike standard line-based text diffs, leaff analyzes compiled Lean modules (typically via `.olean` files) to provide a high-level summary of changes. It identifies added or removed theorems, modifications to types, and renamed lemmas. This allows developers to ensure that refactoring efforts preserve the intended logic and to quickly grasp the impact of changes in large libraries like Mathlib.

## Usage Instructions

### Prerequisites

1.  **Two Project Versions**: You must have two separate checkouts of the Lean project (e.g., using `git worktree`).
2.  **Build Both Versions**: Navigate to each project directory and run `lake build`. Leaff requires the compiled artifacts to perform the comparison.
3.  **Environment Consistency**: Ensure the Lean version used to compile the projects matches the version used by leaff to avoid compatibility errors.

### Basic Command Pattern

Run the tool from the leaff directory using the provided shell script:

```bash
./runleaff.sh <ModuleName> <path/to/old-version/> <path/to/new-version/>
```

*   `<ModuleName>`: The specific module or library name to inspect (e.g., `Mathlib` or `MyLibrary.Data.Logic`).
*   `<path/to/old-version/>`: The root directory of the "before" state.
*   `<path/to/new-version/>`: The root directory of the "after" state.

### Interpreting Output

Leaff uses specific symbols to denote the nature of the change:
*   `+ added`: A new theorem or definition was introduced.
*   `- removed`: An existing theorem or definition was deleted.
*   `! type changed for`: The signature or type of a constant has changed.
*   `! renamed A → B`: A lemma or definition was renamed.
*   `+ attribute added`: A new attribute (like `protected`) was applied to a constant.

## Expert Tips and Best Practices

*   **Targeted Diffs**: On large libraries, running leaff on the entire project (e.g., `Mathlib`) can be slow. If you know which area you modified, provide a specific module path (e.g., `Mathlib.Algebra.Group`) to get faster results.
*   **Refactor Verification**: Use leaff after a refactor to confirm that no theorems were accidentally removed. If the output shows `removed` for a theorem you intended to keep, the refactor may have broken a dependency or changed a name unexpectedly.
*   **Alpha Limitations**: Be aware that leaff is in alpha. It may struggle with extremely large diffs or significant changes in the Lean toolchain between the two versions being compared.
*   **False Positives**: If the tool reports "type changed" for a large number of items where you didn't expect changes, double-check that both versions were built with the exact same Lean toolchain.

## Reference documentation

- [Main README and Usage Guide](./references/github_com_alexjbest_leaff.md)
- [Known Issues and Feature Requests](./references/github_com_alexjbest_leaff_issues.md)