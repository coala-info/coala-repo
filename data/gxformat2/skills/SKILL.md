---
name: gxformat2
description: The gxformat2 toolkit provides utilities to validate, visualize, and manage Galaxy Workflow Format 2 files. Use when user asks to lint Galaxy workflows, visualize workflow connections, export abstract workflow versions, or manage human-readable workflow formats.
homepage: https://github.com/jmchilton/gxformat2
---


# gxformat2

## Overview

The `gxformat2` toolkit is designed to manage Galaxy Workflow Format 2, a concise and human-friendly alternative to the traditional native Galaxy `.ga` format. While native Galaxy workflows are often difficult to read or write manually, Format 2 provides a streamlined structure that is easier to version control and edit. This skill focuses on using the core Python-based CLI utilities to ensure workflow integrity and facilitate workflow sharing.

## Installation

The tools can be installed via pip or conda:

```bash
pip install gxformat2
# OR
conda install bioconda::gxformat2
```

## Core CLI Utilities

### Workflow Validation (Linting)
Use `gxwf-lint` to check your workflow files for syntax errors, structural issues, or missing required fields. This is a critical step before attempting to import a workflow into a Galaxy instance.

```bash
gxwf-lint my_workflow.gxwf.yml
```

### Workflow Visualization
Use `gxwf-viz` to generate a visual representation of the workflow logic and tool connections.

```bash
gxwf-viz my_workflow.gxwf.yml
```

### Abstract Export
Use `gxwf-abstract-export` to create an abstract version of a Galaxy workflow, which can be useful for documentation or high-level architectural reviews.

```bash
gxwf-abstract-export my_workflow.gxwf.yml
```

## Best Practices

- **Format Conversion**: Use these tools when transitioning from native `.ga` files to Format 2 to ensure the resulting file remains compatible with Galaxy versions 19.09 and later.
- **CI/CD Integration**: Incorporate `gxwf-lint` into automated testing pipelines to catch workflow errors before they are committed to a repository.
- **Human-Readable Editing**: Prefer Format 2 for workflows that require manual editing or frequent peer reviews, as the structure is significantly more legible than the native JSON-based `.ga` format.

## Reference documentation
- [Galaxy Workflow Format 2](./references/github_com_galaxyproject_gxformat2.md)
- [gxformat2 on Bioconda](./references/anaconda_org_channels_bioconda_packages_gxformat2_overview.md)