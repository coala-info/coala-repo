---
name: baitfisher
description: BaitFisher is a bioinformatic suite designed to create and optimize hybrid enrichment probes from multiple sequence alignments. Use when user asks to design hybrid enrichment baits, filter baits for specificity and off-target binding, or convert bait designs into formats for synthesis providers.
homepage: https://github.com/cmayer/BaitFisher-package
---


# baitfisher

## Overview

BaitFisher is a specialized bioinformatic suite designed to optimize the creation of hybrid enrichment probes. It focuses on minimizing redundancy by adjusting bait density based on sequence conservation—placing fewer baits in conserved regions and more in variable ones. The package consists of two primary components: **BaitFisher**, which generates the initial bait designs from MSAs, and **BaitFilter**, which refines these designs by checking for off-target binding, filtering by length, and converting results into formats required by synthesis providers.

## Core Workflow

1.  **Preparation**: Ensure your input files are Multiple Sequence Alignments (MSAs) or annotated features within MSAs.
2.  **Design (BaitFisher)**: Generate baits while controlling the bait-to-target distance.
3.  **Refinement (BaitFilter)**: Filter the generated baits for specificity and quality.
4.  **Export**: Convert the final bait set into a vendor-compatible format.

## Command Line Usage

### Basic Commands
Access the built-in help for the specific version installed:
```bash
BaitFisher -h
BaitFilter -h
```

### BaitFisher Best Practices
*   **Tiling Design Length**: If BaitFisher skips an alignment, it is often because the alignment is shorter than the requested tiling design. If you encounter "NOTICE: Skipping alignment since it is too short," decrease the required tiling length.
*   **Redundancy Control**: Use the parameter for allowed distance between baits and sequences to control how many baits are designed in conserved vs. variable regions. A higher allowed distance results in fewer baits.

### BaitFilter Capabilities
Use BaitFilter to perform the following post-processing steps:
*   **Specificity Check**: Determine if baits bind unspecifically to a reference genome.
*   **Length Filtering**: Remove baits that only have partial matches to the target.
*   **Region Optimization**: Identify the "optimal bait region" in an MSA, defined as either the most conserved area or the area with the fewest gaps/ambiguous nucleotides.
*   **Format Conversion**: Prepare the final bait list for upload to commercial bait synthesis companies.

## Troubleshooting Common Issues

*   **Skipped Features**: If a feature is skipped, check the overlap with the transcript. If the overlap is too short, the feature cannot host a tiling design of the required length.
*   **Compilation**: If building from source, ensure system headers like `unistd.h` and `dirent.h` are available (standard on Linux/macOS). Use `make` in the root directory to generate the `BaitFisher-vX.X.X` and `BaitFilter-vX.X.X` executables.

## Reference documentation
- [BaitFisher Package README](./references/github_com_cmayer_BaitFisher-package.md)