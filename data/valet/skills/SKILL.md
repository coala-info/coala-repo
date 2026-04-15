---
name: valet
description: VALET identifies structural errors in metagenomic assemblies by analyzing read alignments. Use when user asks to validate metagenomic assemblies, identify structural errors in metagenomic assemblies, or compare multiple metagenomic assemblies.
homepage: https://github.com/marbl/VALET
metadata:
  docker_image: "quay.io/biocontainers/valet:1.0--3"
---

# valet

## Overview

VALET (metagenomic assembly VALidation Tool) is a diagnostic pipeline designed to identify structural errors in metagenomic assemblies. It functions by aligning raw sequencing reads back to candidate assemblies and analyzing the resulting data for signatures of mis-assembly, specifically focusing on depth-of-coverage variations and breakpoint signatures. It is particularly effective for distinguishing between true biological variation and assembly artifacts in complex microbial communities.

## Installation and Environment

VALET is available via Bioconda. It requires a Python 2.7 environment and several bioinformatics dependencies.

```bash
# Installation via Conda
conda install bioconda::valet

# Manual setup (requires bowtie2, samtools, bedtools, numpy, and scipy)
git clone https://github.com/marbl/VALET.git
export VALET=`pwd`/VALET/src/py/
```

## Core CLI Usage

The primary interface is `valet.py`. It requires at least one assembly file and a set of paired-end reads.

### Basic Command Pattern
```bash
valet.py -a assembly.fna -1 reads_R1.fastq -2 reads_R2.fastq --assembly-names my_assembly
```

### Comparing Multiple Assemblies
VALET can process multiple assemblies simultaneously to generate comparative plots. Use comma-separated lists for both the file paths and the display names.
```bash
valet.py -a asm1.fna,asm2.fna -1 R1.fq -2 R2.fq --assembly-names version1,version2
```

### Key Arguments
- `-a`: Path to assembly FASTA file(s). Multiple files must be comma-separated.
- `-1` / `-2`: Forward and reverse paired-end read files.
- `--assembly-names`: Labels used in output directories and plots.
- `--skip-reapr`: Disables the REAPR-based error detection step. Use this if you encounter Perl dependency issues or want to speed up the pipeline.
- `-o`: Specify a custom output directory (default is `output/`).

## Output Interpretation

VALET produces several key files within the `[OUTPUT_DIR]/[ASSEMBLY_NAME]/` directory:

1.  **`summary.bed`**: A BED-formatted file containing all flagged regions and the specific signature that triggered the flag (e.g., `Low_coverage`, `Breakpoint_finder`).
2.  **`suspicious.bed`**: Contains regions where multiple mis-assembly signatures overlap, indicating a high probability of error.
3.  **`summary.tsv`**: A tabular breakdown of each contig, including its length, abundance, and the number of base pairs affected by different error types.
4.  **`comparison_plots.pdf`**: A visual summary (generated via Rscript) showing how different assemblies accumulate errors as a function of contig abundance and length.

## Expert Tips

- **Contig Filtering**: By default, VALET filters out contigs shorter than 1000 bp. If your assembly contains many short, high-confidence contigs, you may need to check the `filtered_assembly.fasta` in the output folder to see what was excluded.
- **Memory Management**: The pipeline uses `samtools mpileup` and `bowtie2`. Ensure your environment has sufficient threads and memory for these tools, especially when working with large metagenomes.
- **Breakpoint Analysis**: The `Breakpoint_finder` signature is highly sensitive to unaligned read clusters. If you see an excessive number of breakpoints, verify the quality of your input reads.
- **Visualizing Results**: Since the output is in BED format, you can load `summary.bed` or `suspicious.bed` directly into IGV (Integrative Genomics Viewer) alongside your assembly and BAM files to manually inspect flagged regions.

## Reference documentation
- [VALET GitHub Repository](./references/github_com_marbl_VALET.md)
- [Bioconda VALET Package](./references/anaconda_org_channels_bioconda_packages_valet_overview.md)