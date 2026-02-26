---
name: xpore
description: xPore identifies and quantifies differential RNA modifications from Nanopore direct RNA sequencing data. Use when user asks to identify and quantify differential RNA modifications, prepare Nanopore direct RNA sequencing data, or perform differential modification analysis.
homepage: https://github.com/GoekeLab/xpore
---


# xpore

## Overview
xPore is a statistical framework designed to identify and quantify differential RNA modifications from Nanopore direct RNA sequencing data. It operates by modeling the raw signal (current) distributions of k-mers to detect shifts caused by modifications. Unlike some other tools, xPore can estimate modification rates and identify differential sites even when a completely unmodified control sample is not available, making it highly versatile for comparative transcriptomics.

## Installation
Install xPore using either pip or conda:
```bash
# Via PyPI
pip install xpore

# Via Bioconda
conda install -c bioconda xpore
```

## Core Workflow

### 1. Data Preparation
Before using xPore, you must align your Nanopore reads and run Nanopolish `eventalign`. Once you have the eventalign output, use `xpore-dataprep` to format the data.

- **Command**: `xpore-dataprep`
- **Input**: Nanopolish `eventalign` output files.
- **Function**: This utility parses the raw signal data and organizes it by transcript coordinates, creating the necessary index files for the modeling step.
- **Tip**: Ensure your transcript IDs in the eventalign file match your reference transcriptome exactly to avoid empty outputs.

### 2. Differential Modification Analysis
The primary analysis is performed using the `diffmod` sub-command.

- **Command**: `xpore diffmod`
- **Logic**: It compares the signal intensity distributions between two or more conditions.
- **Key Outputs**:
    - **Modification Rates**: Estimated proportion of modified molecules at specific sites.
    - **P-values/Z-scores**: Statistical significance of the difference in signal between conditions.
    - **Log Likelihood Ratio (LLR)**: Used to rank the confidence of modification sites.

## Expert Tips and Best Practices

- **GFF Annotation**: In version 2.1+, you can utilize GFF options to improve coordinate mapping. This is particularly useful when moving between genomic and transcriptomic coordinates.
- **Filtering**: Always perform post-filtering on the output table. Focus on sites with sufficient coverage (typically >20-50 reads) to ensure the statistical modeling of the signal distribution is robust.
- **Handling NAs**: If you see `NA` in the `mod_rate` column, it often indicates insufficient coverage or signal variance that prevents the mixture model from converging at that specific site.
- **Multiple Conditions**: xPore supports pairwise comparisons across multiple conditions. When setting up comparisons, ensure your experimental design clearly defines the "control" vs "treated" groups to correctly interpret the direction of the modification rate change.
- **K-mer Context**: Remember that xPore identifies modifications within a k-mer context (typically 5-mers). A significant result indicates a modification within that specific k-mer, most commonly at the central position (e.g., the 'A' in a DRACH motif).

## Reference documentation
- [xpore GitHub Repository](./references/github_com_GoekeLab_xpore.md)
- [Bioconda xpore Overview](./references/anaconda_org_channels_bioconda_packages_xpore_overview.md)
- [xPore Discussions and Troubleshooting](./references/github_com_GoekeLab_xpore_discussions.md)