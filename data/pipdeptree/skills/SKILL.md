---
name: pipdeptree
description: pipdeptree visualizes and analyzes Python package dependencies by transforming flat pip lists into a hierarchical tree structure. Use when user asks to visualize dependency trees, identify version conflicts, perform reverse lookups to find why a package is installed, or generate requirements files.
homepage: https://github.com/tox-dev/pipdeptree
metadata:
  docker_image: "biocontainers/pipdeptree:v0.13.2-1-deb-py3_cv1"
---

# pipdeptree

## Overview
The `pipdeptree` skill enables the analysis of Python environments by transforming the flat list of packages provided by `pip freeze` into a structured dependency tree. This tool is vital for "dependency hell" scenarios where you need to identify which installed packages are causing version mismatches or to prune unnecessary sub-dependencies. It supports global environments, virtualenvs, and can even generate output suitable for lockfiles or visualization tools.

## Core Usage Patterns

### Visualizing the Environment
To see the full dependency tree of the current environment:
```bash
pipdeptree
```

To inspect a specific virtual environment without activating it:
```bash
pipdeptree --python /path/to/venv/bin/python
# Or attempt auto-detection
pipdeptree --python auto
```

### Dependency Auditing and Debugging
**Find why a package is installed (Reverse Lookup):**
If you want to know which top-level packages required a specific library (e.g., `six` or `requests`):
```bash
pipdeptree --reverse --packages <package_name>
```

**Identify Conflicts:**
By default, `pipdeptree` prints warnings to stderr about version mismatches. To make this actionable in CI/CD pipelines:
```bash
pipdeptree --warn fail
```

**Filter the Tree:**
To focus on specific packages and their dependencies:
```bash
pipdeptree --packages flask,sqlalchemy
```

To exclude "noise" packages (like pip, setuptools, or wheel) from the output:
```bash
pipdeptree --exclude pip,setuptools,wheel,pipdeptree
```

### Generating Requirements Files
To create a `requirements.txt` containing only top-level packages (those not depended on by any other package):
```bash
pipdeptree --warn silence | grep -E '^\w+' > requirements.txt
```

To create a "human-friendly" lockfile that shows the hierarchy but uses `pip freeze` formatting:
```bash
pipdeptree --freeze > requirements-tree.txt
```

## Expert Tips
- **CI/CD Integration**: Use `pipdeptree --warn fail` as a linting step to ensure no conflicting dependencies are merged into your environment.
- **Dependency Pruning**: Use `pipdeptree --exclude-dependencies <package>` to identify what can be safely removed when a specific top-level package is no longer needed.
- **Path Customization**: If you have packages installed in non-standard locations, use the `--path` argument to include them in the tree analysis.
- **Output Formats**: For large projects, the text output can be overwhelming. Use `--output json` for programmatic analysis or use the Graphviz integration (if installed) to generate visual diagrams.

## Reference documentation
- [Main README and Usage Guide](./references/github_com_tox-dev_pipdeptree.md)
- [Feature Updates and Version History](./references/github_com_tox-dev_pipdeptree_tags.md)