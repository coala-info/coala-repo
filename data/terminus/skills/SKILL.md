---
name: terminus
description: Terminus is a tool designed to address the uncertainty inherent in transcript-level abundance estimation from RNA-seq data. Use when user asks to run terminus or use its main features.
homepage: https://github.com/COMBINE-lab/terminus
---


# terminus

## Overview
Terminus is a tool designed to address the uncertainty inherent in transcript-level abundance estimation from RNA-seq data. While tools like Salmon provide estimates for individual isoforms, many transcripts are too similar to be distinguished confidently. Terminus analyzes these estimates and collapses transcripts into groups where the total transcriptional output can be estimated more accurately. This data-driven approach ensures that the resolution of the analysis matches the information content of the specific experiment, rather than relying on pre-defined genomic features.

## Installation
The most efficient way to install terminus is via Bioconda:
```bash
conda install -c bioconda terminus
```
Alternatively, it can be built from source using the Rust toolchain:
```bash
cargo build --release
```

## Command Line Usage
Terminus operates primarily through two sub-commands: `group` and `collapse`.

### 1. Identifying Groups
The `group` command identifies which transcripts should be clustered together based on the uncertainty in the Salmon quantification results.
- **Input**: Requires the output directory from a Salmon quantification run.
- **Logic**: It evaluates the posterior distribution of transcript abundances to find groups that can be estimated robustly.

### 2. Collapsing Abundances
The `collapse` command takes the groups identified in the previous step and produces a new set of abundance estimates at the group level.
- **Input**: The original Salmon quantification directory and the group definitions produced by the `group` command.
- **Output**: A set of estimates where the resolution is optimized for accuracy and robustness.

## Best Practices
- **Salmon Compatibility**: Always ensure your RNA-seq data has been processed with Salmon, as terminus is specifically designed to work with Salmon's output format and uncertainty estimates.
- **Resolution Selection**: Use terminus when you find that transcript-level differential expression results are noisy or lack power, but you want to retain more biological detail than a standard gene-level analysis provides.
- **Downstream Analysis**: The collapsed groups produced by terminus can be used in downstream differential expression tools (like DESeq2 or sleuth) by treating the groups as the primary units of interest.

## Reference documentation
- [bioconda / terminus](./references/anaconda_org_channels_bioconda_packages_terminus_overview.md)
- [COMBINE-lab / terminus](./references/github_com_COMBINE-lab_terminus.md)