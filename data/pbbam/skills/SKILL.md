---
name: pbbam
description: pbbam is a specialized C++ library and toolset designed to process and validate BAM files adhering to the PacBio-specific format. Use when user asks to handle PacBio-specific BAM metadata, manage .bam.pbi index files, or resolve unsupported sequencing chemistry errors.
homepage: https://github.com/PacificBiosciences/pbbam
metadata:
  docker_image: "quay.io/biocontainers/pbbam:2.4.0--h077b44d_2"
---

# pbbam

## Overview
pbbam is a specialized C++ library and toolset designed specifically for PacBio's version of the BAM format. Unlike general-purpose tools like samtools, pbbam enforces strict adherence to PacBio-specific metadata—such as ReadGroups, BindingKits, and SequencingKits—and manages the `.bam.pbi` companion index files. Use this skill to handle PacBio-specific BAM requirements and troubleshoot validation failures during secondary analysis.

## Installation
Install the package via bioconda to ensure all dependencies (like htslib) are correctly linked:

```bash
conda install bioconda::pbbam
```

## Critical Format Constraints
*   **PacBio Only**: pbbam is NOT a general-purpose BAM utility. It is strictly for BAM files adhering to the [PacBio BAM format specification](https://github.com/PacificBiosciences/pbbam).
*   **Exceptions**: Attempting to process non-PacBio BAMs (e.g., standard Illumina-derived BAMs) will cause the tool to throw exceptions and fail.
*   **Companion Files**: pbbam relies on `.bam.pbi` files for fast access to per-read information. Ensure these indices are present or generated for your datasets.

## Handling "Unsupported Sequencing Chemistry Combination"
A common failure occurs when pbbam encounters newer chemistry part numbers (BindingKit or SequencingKit) that are not recognized by the local version of the software.

### Expert Fix: Manual Chemistry Update
If you are not using a managed SMRT Link installation, you must manually provide an updated chemistry mapping file:

1.  **Download the latest mapping**:
    ```bash
    wget https://raw.githubusercontent.com/PacificBiosciences/pbcore/develop/pbcore/chemistry/resources/mapping.xml -O chemistry.xml
    ```
2.  **Set the Environment Variable**:
    Point pbbam to the directory containing the `chemistry.xml` file:
    ```bash
    export SMRT_CHEMISTRY_BUNDLE_DIR="/path/to/directory/containing/xml"
    ```
3.  **Validation**: pbbam will now load the out-of-band `chemistry.xml` to pass internal validation. Note that this allows the tool to run, but downstream software (like Unanimity/Arrow) may still require specific model updates to process the new chemistry.

## Best Practices
*   **Validation First**: pbbam validates all BAM files upon loading. If a script fails immediately, check the ReadGroup headers for missing or malformed PacBio tags.
*   **Environment Management**: Always define `SMRT_CHEMISTRY_BUNDLE_DIR` in your shell profile or workflow environment if working with data from the latest PacBio systems (e.g., Revio) on older software stacks.
*   **Library Usage**: For C++ development, pbbam requires C++14 or newer (as of version 2.0.0).

## Reference documentation
- [PacBio BAM C++ library Overview](./references/anaconda_org_channels_bioconda_packages_pbbam_overview.md)
- [PacificBiosciences/pbbam GitHub README](./references/github_com_PacificBiosciences_pbbam.md)