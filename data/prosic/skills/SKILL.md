---
name: prosic
description: prosic is a specialized bioinformatics tool designed for the discovery of somatic insertions and deletions.
homepage: https://prosic.github.io
---

# prosic

## Overview
prosic is a specialized bioinformatics tool designed for the discovery of somatic insertions and deletions. It utilizes a Bayesian probabilistic framework to distinguish true somatic variants from sequencing noise and germline variation with high sensitivity. It is particularly effective in clinical and research settings where identifying low-frequency indels in tumor-normal pairs is critical.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. To set up the environment:
```bash
conda install -c bioconda prosic
```

### Core Workflow
While specific command-line arguments depend on the version, the general execution pattern for prosic involves:

1.  **Input Preparation**: Ensure you have coordinate-sorted and indexed BAM files for both the "Tumor" (target) and "Normal" (control) samples.
2.  **Reference Genome**: A FASTA format reference genome (indexed with `samtools faidx`) is required.
3.  **Execution**: Run the caller by specifying the alignment files and the output VCF (Variant Call Format) path.

### Best Practices
- **Alignment Quality**: Use high-quality alignments (e.g., from BWA-MEM). Bayesian callers perform best when mapping qualities are accurate.
- **Base Quality Recalibration**: For optimal sensitivity, use BAM files that have undergone Base Quality Score Recalibration (BQSR).
- **Resource Allocation**: Bayesian calling is computationally intensive. Ensure sufficient CPU threads are allocated for larger genomic regions.

## Reference documentation
- [prosic Overview](./references/anaconda_org_channels_bioconda_packages_prosic_overview.md)