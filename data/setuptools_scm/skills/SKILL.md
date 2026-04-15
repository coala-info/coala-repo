---
name: setuptools_scm
description: setuptools_scm automates Python package versioning by extracting metadata from source code management systems like Git or Mercurial. Use when user asks to automate versioning, manage package versions using Git tags, or include SCM-tracked files in a source distribution.
homepage: https://github.com/pypa/setuptools-scm
metadata:
  docker_image: "quay.io/biocontainers/setuptools_cython:0.2.1--py27_1"
---

# setuptools_scm

## Overview

`setuptools_scm` is a tool that automates Python versioning by extracting metadata from your SCM (Source Code Management) system. Instead of manually updating a version string in your source code, it calculates the version based on the latest tag and the distance from it. It also ensures that all files tracked by your SCM are automatically included in your source distribution (sdist), reducing the risk of missing files in your package.

## Configuration and Usage

### Basic Configuration (pyproject.toml)
The preferred method for enabling `setuptools_scm` is through `pyproject.toml`. This requires `setuptools` 61 or later.

```toml
[build-system]
requires = ["setuptools>=80", "setuptools-scm>=8"]
build-backend = "setuptools.build_meta"

[project]
dynamic = ["version"]

# Optional: Only needed for customization
[tool.setuptools_scm]
version_file = "your_package/_version.py"
```

### Command Line Interface
You can use the CLI to debug what version string will be generated or to inspect the current state of the repository.

*   **Verify version generation**: Run this in the root of your repository to see the inferred version.
    ```bash
    python -m setuptools_scm
    ```
*   **List available options**:
    ```bash
    python -m setuptools_scm --help
    ```

## Expert Tips and Best Practices

### File Discovery and MANIFEST.in
By default, `setuptools_scm` includes all files tracked by your SCM in the source distribution. 
*   **Exclusion**: If you have development-only files tracked in Git that should not be in the final package, you must explicitly exclude them using a `MANIFEST.in` file.
*   **Git Archive**: The tool respects Git archive settings for file inclusion.

### Runtime Version Access
To make the version available at runtime without requiring the SCM metadata to be present (e.g., after installation), use the `version_file` option in `pyproject.toml`. This writes a file containing the version string into your package.

### Environment Overrides
If you need to force a specific version (e.g., in a restricted CI environment or for packaging in a Linux distribution), use the `SETUPTOOLS_SCM_OVERRIDES_PACKAGE_NAME` environment variable:
```bash
export SETUPTOOLS_SCM_OVERRIDES_YOUR_PACKAGE=1.2.3
```

### Handling Shallow Checkouts
In CI/CD environments (like GitHub Actions), ensure you are not using a shallow clone if you need accurate versioning based on tags. If the latest tag is not reachable in the history, `setuptools_scm` may produce an unexpected version or a "0.0" version.

## Reference documentation
- [setuptools-scm README](./references/github_com_pypa_setuptools-scm.md)