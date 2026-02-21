---
name: mamotif
description: The `mamotif` toolkit is a specialized bioinformatics pipeline used to identify transcription factors that drive differential genomic binding.
homepage: https://github.com/shao-lab/MAmotif
---

# mamotif

## Overview
The `mamotif` toolkit is a specialized bioinformatics pipeline used to identify transcription factors that drive differential genomic binding. By comparing two samples of the same protein (or chromatin accessibility profiles) across different cell types or conditions, it pinpoints TFs whose binding motifs are significantly enriched in the cell-type biased peaks. It effectively bridges the gap between quantitative epigenomic variation and sequence-specific motif scanning.

## Installation
The tool can be installed via Conda or Pip:
```bash
# Recommended: Conda installation
conda install -c bioconda mamotif

# Alternative: Pip installation
pip install mamotif
```

## Core Workflow and CLI Patterns
The primary utility of `mamotif` is its ability to automate the integration of `MAnorm` (for peak normalization and comparison) and `Motif-Scan`.

### Basic Command Structure
While specific subcommands depend on the version, the general execution pattern involves providing peak files and alignment data for two conditions:
```bash
mamotif [subcommand] --p1 peaks_sample1.bed --p2 peaks_sample2.bed --r1 reads_sample1.bam --r2 reads_sample2.bam --genome hg38
```

### Key Input Requirements
- **Peak Files**: BED format files representing binding sites or open chromatin regions for both conditions.
- **Read Files**: BAM or BED format files containing the raw sequencing reads used for quantitative normalization.
- **Genome Information**: Specify the reference genome (e.g., hg19, hg38, mm10) to facilitate motif scanning.

### Analysis Steps
1. **Quantitative Comparison**: The tool uses the MAnorm model to calculate M-values (log2 fold change) and A-values (average intensity) for all peaks.
2. **Biased Peak Identification**: It identifies regions that are significantly enriched in one condition over the other.
3. **Motif Scanning**: It scans these biased regions for known TF motifs.
4. **Integrative Association**: It performs statistical tests to find TFs whose motif presence correlates with the observed binding bias.

## Best Practices
- **Sample Consistency**: Ensure that the two samples being compared are of the same protein or assay type (e.g., comparing H3K27ac in Cell Type A vs. Cell Type B).
- **Normalization**: Always provide the raw read files (BAM/BED) rather than just peak lists to allow `mamotif` to perform proper quantitative normalization via MAnorm.
- **Regulatory Elements**: When using histone marks like H3K4me3 or H3K27ac, `mamotif` is particularly effective at identifying regulators of active promoters and enhancers.
- **Motif Selection**: Use the built-in motif databases or provide custom PWMs (Position Weight Matrices) if looking for specific, non-standard regulators.

## Reference documentation
- [MAmotif GitHub Repository](./references/github_com_shao-lab_MAmotif.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mamotif_overview.md)