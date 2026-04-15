---
name: telosearchlr
description: TeloSearchLR scans the terminal regions of long sequencing reads to identify and rank tandemly repeated telomeric motifs. Use when user asks to discover telomere repeat motifs, perform exhaustive motif searches, or verify specific motifs in long-read sequencing data.
homepage: https://github.com/gchchung/TeloSearchLR
metadata:
  docker_image: "quay.io/biocontainers/telosearchlr:1.0.1--pyhdfd78af_0"
---

# telosearchlr

## Overview
TeloSearchLR is a specialized tool designed to scan the terminal regions of long sequencing reads to identify tandemly repeated motifs characteristic of telomeres. It ranks motifs based on their frequency and spatial distribution (occupancy) at the 5' and 3' ends of reads. This skill provides the necessary command-line patterns to perform motif discovery, exhaustive searches, and targeted motif verification.

## Installation and Setup
The tool is primarily distributed via Bioconda. Note that `python-kaleido` may need to be installed manually for plotting functionality.

```bash
# Recommended installation
conda create -n telosearchlr-env -c bioconda -c conda-forge telosearchlr python-kaleido
conda activate telosearchlr-env
```

## Core CLI Patterns

### 1. Standard Telomere Discovery
To find and rank repeat motifs between 4 and 20 nucleotides long within the terminal 1000 bp of reads:

```bash
python TeloSearchLR.py -f input.fasta -k 4 -K 20 -t 1000 -m 1 -M 100 -n 6000
```
*   `-f`: Input FASTA file.
*   `-k` / `-K`: Minimum and maximum motif period to search.
*   `-t`: The size of the terminal region to scan (default 1000).
*   `-m` / `-M`: The rank range of motifs to generate plots for (e.g., top 1 to 100).
*   `-n`: The number of nucleotides from the read ends to plot for occupancy analysis.

### 2. Searching for Long or ALT-like Motifs
For organisms with unusually long telomeric repeats (e.g., those using Alternative Lengthening of Telomeres), increase the terminal search window. The `-t` value must be at least twice the maximum period `-K`.

```bash
# Searching for motifs up to 1000bp
python TeloSearchLR.py -f input.fasta -k 21 -K 1000 -t 2000 -n 8000 -m 1 -M 50
```

### 3. Exhaustive Search Mode
Use the `-e` flag to sort discovered motifs by their repeat period first, then by occupancy. This is useful when you have a specific period size in mind and want to see all candidates of that length.

```bash
python TeloSearchLR.py -f input.fasta -k 4 -K 20 -e -m 1 -M 100
```

### 4. Verifying a Specific Motif
If you suspect a specific motif (e.g., `TTAGGG`), use the single-motif mode. This requires a TideHunter tabular output file (`*TideHunterTable.txt`) from a previous run or an independent TideHunter search.

```bash
python TeloSearchLR.py -f input.fasta -s TTAGGG -T input_TideHunterTable.txt -n 6000
```

## Expert Tips
*   **Input Format**: TeloSearchLR requires FASTA. If you have FASTQ data, convert it using `sed -n '1~4s/^@/>/p;2~4p' library.fastq > library.fasta`.
*   **Output Interpretation**: Results are stored in a `*.results` folder. Look for motifs that show high occupancy at one end of the read and their reverse complement at the other end; this is the hallmark of a true telomeric repeat.
*   **Memory/Time**: For very large libraries, consider subsampling your FASTA file if you only need to identify the primary repeat motif, as telomeric reads are usually abundant enough to be captured in a subset.

## Reference documentation
- [TeloSearchLR GitHub README](./references/github_com_gchchung_TeloSearchLR_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_telosearchlr_overview.md)