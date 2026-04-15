---
name: tecount
description: TEcount quantifies bulk RNA-seq reads aligned to transposable elements at the subfamily, family, and class levels. Use when user asks to count reads mapping to transposable elements, quantify TE expression from BAM files, or analyze TE activation across different hierarchical levels.
homepage: https://github.com/bodegalab/tecount
metadata:
  docker_image: "quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0"
---

# tecount

## Overview

TEcount is a specialized bioinformatics tool designed for bulk RNA-seq analysis. It quantifies reads aligned to transposable elements (TEs) at three hierarchical levels: subfamily, family, and class. It is particularly useful for researchers studying TE activation or regulation, as it handles the complexities of multi-mapping reads by ensuring each alignment is counted only once per feature type. The tool supports both single-end and paired-end data and can account for library strandedness.

## Usage Guidelines

### Core Requirements

To use TEcount effectively, ensure your input files meet the following specifications:
- **BAM File**: Must be sorted by coordinates.
- **Reference BED File**: Must be in `bed6+3` format. Specifically, columns 7, 8, and 9 must contain the TE Subfamily, Family, and Class respectively.
- **Dependencies**: `samtools` (>=1.14) and `bedtools` (>=2.30.0) must be available in your system PATH.

### Common CLI Patterns

**Basic Quantification**
Run the standard counting workflow with a sorted BAM and a RepeatMasker (rmsk) BED file:
```bash
TEcount -b sorted_alignments.bam -r rmsk_reference.bed
```

**Strand-Specific Counting**
If your RNA-seq library is stranded, specify the protocol to ensure accurate TE quantification:
```bash
# For stranded data, use the -s flag (check --help for specific orientation options)
TEcount -b sorted_alignments.bam -r rmsk_reference.bed -s
```

**Filtering by Overlap**
To increase the stringency of what constitutes a "hit" on a TE, adjust the minimum overlap requirement:
```bash
# Example: require a specific overlap threshold
TEcount -b sorted_alignments.bam -r rmsk_reference.bed -o <float>
```

### Expert Tips

1. **Multi-mapping Strategy**: TEcount is designed to handle reads aligning to multiple TE loci by counting only one alignment occurrence for each feature level (subfamily, family, or class). This prevents over-inflation of counts due to the repetitive nature of TEs.
2. **Reference Preparation**: The most common source of errors is an incorrectly formatted BED file. Ensure your RepeatMasker BED file has the TE hierarchy in the extra columns (7-9).
3. **Environment Management**: It is highly recommended to run TEcount within a dedicated Conda environment to manage the specific versions of `samtools` and `bedtools` required for stable performance.
4. **Output Handling**: TEcount generates separate output files for each hierarchy level. Ensure your downstream differential expression tools (like DESeq2 or EdgeR) are pointed to the specific level (e.g., subfamily) relevant to your biological question.



## Subcommands

| Command | Description |
|---------|-------------|
| TEcount | Count reads mapping on Transposable Elements subfamilies, families and classes. |
| samtools | Tools for alignments in the SAM format |

## Reference documentation
- [TEcount README](./references/github_com_bodegalab_tecount_blob_main_README.md)
- [TEcount Configuration and Metadata](./references/github_com_bodegalab_tecount_blob_main_setup.cfg.md)