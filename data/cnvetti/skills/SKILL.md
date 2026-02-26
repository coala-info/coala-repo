---
name: cnvetti
description: CNVetti is a bioinformatics suite designed for clinical copy number variation calling through coverage extraction, normalization, and statistical modeling. Use when user asks to calculate read depth from alignment files, normalize sequencing biases, merge multi-sample coverage data, or call germline and somatic variants.
homepage: https://github.com/bihealth/cnvetti
---


# cnvetti

## Overview
CNVetti is a specialized bioinformatics suite designed for robust and efficient clinical CNV calling. It transforms raw sequencing alignments into copy number insights through a multi-stage process involving coverage extraction, bias normalization, and statistical modeling. It supports both germline and somatic experimental designs and is optimized for Linux environments.

## Installation
Install CNVetti via Bioconda:
```bash
conda install -c bioconda cnvetti
```

## Core CLI Usage Patterns

CNVetti uses a subcommand-based interface categorized into low-level commands (`cmd`) and streamlined workflows (`quick`).

### 1. Coverage Extraction
The first step in any CNVetti workflow is generating coverage profiles from alignment files.
- **Command**: `cnvetti cmd coverage`
- **Purpose**: Processes BAM/CRAM files to calculate read depth across genomic windows or targets.

### 2. Data Normalization
To account for sequencing biases (such as GC content), use the normalization module.
- **Command**: `cnvetti cmd normalize`
- **Purpose**: Applies log2-transformation and corrects coverage values to ensure comparability across regions and samples.

### 3. Multi-Sample Processing
For cohorts or tumor-normal pairs, coverage data must be merged.
- **Command**: `cnvetti cmd merge-cov`
- **Purpose**: Aggregates individual coverage files into a single matrix for joint analysis.

### 4. Model Building and Calling (WIS Workflow)
The "WIS" (Window-Informed Segment) approach is a primary method for discovery.
- **Model Building**: `cnvetti quick wis-build-model` or `cnvetti cmd build-model-wis`
- **Variant Calling**: `cnvetti quick wis-call`
- **Best Practice**: Use the `quick` subcommands for standard clinical workflows to ensure consistent parameter application.

### 5. Visualization
CNVetti provides utilities to convert internal coverage formats for manual inspection.
- **Command**: `cnvetti cov-to-igv`
- **Purpose**: Generates tracks compatible with the Integrative Genomics Viewer (IGV) for visual validation of called CNVs.

## Expert Tips
- **Log2 Transformation**: CNVetti writes out log2-transformed coverage values to `.COV2` files during the `mod-cov` or `normalize` steps.
- **Masking**: The tool supports masking of off-target reads in exome processing and masking of regions with rare GC values to reduce false positives.
- **Workspace Structure**: When running complex analyses, CNVetti often operates within a workspace structure; ensure your input directories are organized by sample ID.

## Reference documentation
- [cnvetti Overview](./references/anaconda_org_channels_bioconda_packages_cnvetti_overview.md)
- [GitHub Repository and README](./references/github_com_bihealth_cnvetti.md)
- [Commit History and Command Evolution](./references/github_com_bihealth_cnvetti_commits_master.md)