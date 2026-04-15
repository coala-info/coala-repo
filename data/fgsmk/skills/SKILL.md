---
name: fgsmk
description: The fgsmk package provides Python-based helper functions to streamline the development and management of Snakemake workflows for genomic data processing. Use when user asks to manage file paths, calculate resource requirements, or simplify command-line construction within Snakemake rules.
homepage: https://pypi.org/project/fgsmk/
metadata:
  docker_image: "quay.io/biocontainers/fgsmk:0.1.2--pyhdfd78af_0"
---

# fgsmk

## Overview
The `fgsmk` package provides a suite of Python-based helper functions designed to streamline the development of Snakemake workflows, particularly those focused on genomic data processing. It simplifies common tasks such as managing temporary directories, resolving file paths, and handling complex command-line string construction within Snakemake rules.

## Usage Guidelines

### Integration in Snakemake
To use `fgsmk` within a Snakemake workflow, import the necessary modules at the top of your `Snakefile`:

```python
import fgsmk
from fgsmk import path_utils, resource_utils
```

### Path Management
Use `path_utils` to ensure consistent file path handling across different execution environments:
- Use `path_utils.find_binary()` to locate executable tools required by your rules.
- Utilize path joining helpers to manage output directory structures dynamically based on wildcards.

### Resource Allocation
`fgsmk` helps in defining resource requirements that scale with input sizes:
- Use `resource_utils` to calculate memory or CPU requirements based on the number of samples or file sizes.
- Implement these functions within the `resources:` block of a Snakemake rule to optimize cluster scheduling.

### Best Practices
- **Environment Consistency**: Always ensure `fgsmk` is listed in your `conda` environment YAML file for the workflow to ensure reproducibility.
- **Modular Rules**: Use `fgsmk` functions to keep your `Snakefile` logic clean; move complex string formatting for shell commands into Python functions supported by `fgsmk`.
- **Error Handling**: Leverage `fgsmk`'s internal logging or validation helpers to check for the existence of required reference files before starting long-running jobs.

## Reference documentation
- [fgsmk PyPI Project Page](./references/pypi_org_project_fgsmk.md)
- [Bioconda fgsmk Overview](./references/anaconda_org_channels_bioconda_packages_fgsmk_overview.md)