---
name: grz-check
description: The grz-check tool validates the structural and syntactical correctness of genomic data submission packages for the German healthcare system. Use when user asks to validate submission files, troubleshoot schema errors, or install the tool via Bioconda.
homepage: https://github.com/BfArM-MVH/grz-tools/packages/grz-check
metadata:
  docker_image: "quay.io/biocontainers/grz-check:0.2.1--h3ec5717_0"
---

# grz-check

## Overview
The `grz-check` tool is a specialized validator designed for the German healthcare system's genomic medicine initiative. It serves as the first line of defense for data submitters, ensuring that submission packages are structurally and syntactically correct before they are encrypted and uploaded to a Genomrechenzentrum (GRZ). Use this skill to troubleshoot validation errors, understand installation requirements via Bioconda, and execute the primary validation workflows.

## Installation and Setup
The tool is distributed via the Bioconda channel. Ensure your environment is configured to access Bioconda before installation.

```bash
# Install grz-check using conda
conda install bioconda::grz-check

# Alternatively, using mamba for faster resolution
mamba install bioconda::grz-check
```

## Core Usage Patterns
The primary function of `grz-check` is the validation of submission files against predefined Pydantic models and schemas.

### Validating Submissions
Run the check command against your local submission directory or specific metadata files.
- **Input**: Files intended for §64e submission.
- **Process**: The tool checks for schema compliance, required fields, and file integrity.
- **Output**: Validation reports indicating success or specific error locations in the metadata.

### Integration with grz-cli
While `grz-check` can function as a standalone validator, it is often used as a component of the broader `grz-cli` suite. 
- Use `grz-check` for rapid, iterative validation during data preparation.
- Use `grz-cli` when you are ready to move from validation to encryption (crypt4gh) and final upload.

## Expert Tips
- **Version Alignment**: Ensure your `grz-check` version matches the requirements of the specific GRZ you are submitting to, as schemas for §64e may update periodically.
- **Pre-encryption Check**: Always run `grz-check` *before* encrypting files with `crypt4gh`. Validating encrypted blobs is not supported; the tool must inspect the raw metadata and file structures.
- **Environment Isolation**: Install `grz-check` in a dedicated conda environment to avoid dependency conflicts with other bioinformatics tools, particularly those involving Pydantic or Rust-based extensions.

## Reference documentation
- [grz-check Overview](./references/anaconda_org_channels_bioconda_packages_grz-check_overview.md)
- [GRZ Tools Monorepo](./references/github_com_BfArM-MVH_grz-tools.md)