---
name: vdjer
description: V'DJer analyzes the B-cell receptor (BCR) repertoire from standard mRNA-Seq data by assembling and filtering reads to identify abundant heavy and light chain contigs. Use when user asks to analyze BCR repertoire, extract immunological insights from transcriptomic data, reconstruct BCR contigs, or perform standard or sensitive BCR reconstruction.
homepage: https://github.com/mozack/vdjer
metadata:
  docker_image: "quay.io/biocontainers/vdjer:0.12--h5ca1c30_8"
---

# vdjer

## Overview
V'DJer is a specialized tool for analyzing the BCR repertoire using standard mRNA-Seq data instead of dedicated long-read sequencing. It extracts relevant reads, performs assembly, and filters rearrangements to identify the most abundant BCR contigs for heavy (IgH) and light (IgK/IgL) chains. The tool is particularly useful for researchers looking to extract immunological insights from existing bulk transcriptomic datasets.

## Installation and Setup
V'DJer is primarily supported on Linux systems.

- **Conda (Recommended)**: `conda install bioconda::vdjer`
- **Source**: Clone the repository and run `make` in the root directory to generate the `vdjer` executable.
- **References**: Download and decompress the pre-built human indices and references (hg38) from the official GitHub releases. Separate reference directories are required for each chain type (IGH, IGK, IGL).

## Input Requirements
V'DJer has strict input formatting requirements:
- **Format**: Sorted and indexed BAM file.
- **Alignment**: Mapped to hg38 (STAR is the recommended aligner).
- **Read Type**: Paired-end reads only; single-end reads are not supported.
- **Unmapped Reads**: The BAM file **must** include unmapped reads. If using STAR, you must include the parameter `--outSAMunmapped Within`.

## Common CLI Patterns

### Standard Reconstruction
To run a standard reconstruction for the heavy chain:
```bash
vdjer --in star.sort.bam --t 8 --ins 175 --chain IGH --ref-dir vdjer_human_references/igh > vdjer.sam 2> vdjer.log
```

### Sensitive Mode
For samples with low BCR expression levels, use sensitive mode to reduce aggressive pruning and filtering. Note that this significantly increases computational cost.
```bash
vdjer --in star.sort.bam --t 8 --ins 175 --chain IGH --ref-dir refs/igh \
  --mq 60 --mf 2 --rs 25 --ms 2 --mcs -5.5 > vdjer.sam
```

## Parameter Reference
- `--in`: Path to the input sorted/indexed BAM.
- `--t`: Number of threads.
- `--ins`: Median insert size of the library.
- `--chain`: The target chain (one of: `IGH`, `IGK`, `IGL`).
- `--ref-dir`: Path to the chain-specific reference directory.

### Tuning Parameters (Sensitive Mode)
- `--mq` and `--mf`: Decrease from defaults for less aggressive graph pruning.
- `--rs` and `--ms`: Decrease for less aggressive coverage-based filtering.
- `--mcs`: Decrease (e.g., to -5.5) for more exhaustive graph traversal.

## Expert Tips
- **Output Files**: The primary output is `vdj_contigs.fa` (created in the working directory), which contains the assembled contigs. Read alignments to these contigs are written to `stdout`.
- **Quantification**: The output SAM file is compatible with downstream quantification tools like RSEM.
- **Memory Management**: Sensitive mode can be extremely memory and CPU intensive on samples with high BCR abundance; only use it when standard runs fail to produce contigs due to low expression.
- **Post-Processing**: Use the `call_isotypes.py` script found in the `post_process` directory of the source code to identify isotypes from the generated contigs.

## Reference documentation
- [V'DJer GitHub Repository](./references/github_com_mozack_vdjer.md)
- [Bioconda vdjer Overview](./references/anaconda_org_channels_bioconda_packages_vdjer_overview.md)