---
name: gromacswrapper
description: GromacsWrapper provides a Python interface for GROMACS command-line tools to enable the creation of automated molecular dynamics workflows. Use when user asks to run GROMACS commands from Python, automate simulation setup, or build reproducible molecular dynamics pipelines.
homepage: https://github.com/Becksteinlab/GromacsWrapper
---


# gromacswrapper

## Overview
GromacsWrapper transforms GROMACS command-line tools into Python classes, allowing for robust, modular, and reproducible molecular dynamics pipelines. By wrapping system calls, it provides better error handling, logging of all commands to a history file, and access to Python's advanced data structures. It is particularly useful for complex setup procedures, high-throughput simulation management, and integrating GROMACS into larger scientific Python environments.

## Core Usage Patterns

### Basic Tool Execution
GROMACS tools are available as functions within the `gromacs` module. Command-line flags are passed as keyword arguments (omitting the leading dash).

```python
import gromacs

# Equivalent to: gmx pdb2gmx -f protein.pdb -o processed.gro -ff oplsaa -water tip3p
gromacs.pdb2gmx(f="protein.pdb", o="processed.gro", p="topol.top", ff="oplsaa", water="tip3p")

# Handling multi-word flags or standard input
# For tools requiring interactive input, use the 'input' keyword
gromacs.editconf(f="processed.gro", o="boxed.gro", bt="dodecahedron", d=1.5, princ=True, input="Protein")
```

### Simulation Setup Workflow
A standard setup sequence typically follows this pattern:

1.  **Structure Preparation**: `gromacs.pdb2gmx(...)`
2.  **Box Definition**: `gromacs.editconf(...)`
3.  **Solvation**: `gromacs.solvate(cp="boxed.gro", cs="tip4p", p="topol.top", o="solvated.gro")`
4.  **Preprocessing**: `gromacs.grompp(f="emin.mdp", c="solvated.gro", p="topol.top", o="emin.tpr")`
5.  **Execution**: `gromacs.mdrun(v=True, deffnm="emin")`

### Using the Cook Book (cbook)
The `gromacs.cbook` module contains high-level recipes for common tasks that often require multiple GROMACS steps.

*   **Adding MDP includes**: Use `gromacs.cbook.add_mdp_includes()` to manage topology includes.
*   **System manipulation**: Check `cbook` for helper functions that automate ion addition or complex box setups.

## Expert Tips and Best Practices

*   **Check GROMACS Version**: Verify the detected GROMACS version using `print(gromacs.release)`.
*   **Logging**: GromacsWrapper automatically logs all commands, warnings, and errors. Review the log file (usually `gromacs.log`) to debug failed steps in a pipeline.
*   **Keyword Arguments**: If a GROMACS flag contains a character that is invalid in Python (like a dot or dash), GromacsWrapper usually maps them, but prefer using the standard keyword mapping (e.g., `deffnm="name"` for `-deffnm`).
*   **Error Handling**: Unlike shell scripts, GromacsWrapper will raise Python exceptions if a GROMACS tool returns a non-zero exit code, allowing you to use `try...except` blocks for robust automation.
*   **Environment Management**: If GROMACS is not in your PATH, you may need to source the GROMACS `GMXRC` file before starting the Python session or use the `gromacs.config` module to point to specific executables.

## Reference documentation
- [GromacsWrapper GitHub README](./references/github_com_Becksteinlab_GromacsWrapper.md)
- [GromacsWrapper Wiki Home](./references/github_com_Becksteinlab_GromacsWrapper_wiki.md)