---
name: fgap
description: fgap improves the continuity of draft genome assemblies by closing gaps using BLAST+ alignments against provided datasets. Use when user asks to close gaps in a draft assembly, fill positive gaps with new sequences, or join overlapping contigs.
homepage: https://github.com/pirovc/fgap
metadata:
  docker_image: "quay.io/biocontainers/fgap:1.8.1--hdfd78af_2"
---

# fgap

## Overview

fgap (Fine Gap) is a specialized bioinformatics tool designed to improve the continuity of draft genome assemblies. It identifies gaps within a draft sequence and attempts to close them by aligning the flanking sequences of each gap against one or more "dataset" files using BLAST+. The tool is highly versatile, capable of handling positive gaps (where new sequence is inserted), zero gaps (where contigs are joined directly), and negative gaps (where contigs actually overlap). It is particularly useful in the final stages of a genome project to reduce the number of scaffolds and improve the overall assembly quality.

## Usage Instructions

### Basic Command Structure
The primary way to run fgap is through the command line, providing a draft file and at least one dataset file.

```bash
# Standard Bioconda/CLI usage
FGAP -d draft.fasta -a dataset.fasta -o output_directory
```

### Handling Multiple Datasets
You can provide multiple datasets (e.g., different libraries or assemblies) by separating them with commas.
```bash
FGAP -d draft.fasta -a 'reads.fasta,other_assembly.fasta' -t 4 -o multi_data_results
```

### Closing Different Gap Types
By default, fgap focuses on positive gaps. You can enable other types depending on your assembly state:
*   **Positive Gaps (`-p 1`)**: Default. Fills gaps with new bases.
*   **Zero Gaps (`-z 1`)**: Closes gaps where contigs meet exactly.
*   **Negative Gaps (`-g 1`)**: Closes gaps where contig ends overlap.

### Tuning Alignment Sensitivity
If the default settings are not closing enough gaps, adjust the BLAST thresholds:
*   **Identity (`-i`)**: Default is 70. Increase to 95+ for same-strain data to avoid misassemblies; decrease for cross-species gap filling.
*   **Min Score (`-s`)**: Default is 25. Increase to reduce false positives in repetitive regions.
*   **Max E-value (`-e`)**: Default is 1e-7.

### Flanking Region Control
*   **Contig End Length (`-C`)**: Default is 300bp. This is the length of the sequence flanking the gap used for BLAST. Increase this (e.g., to 500 or 1000) if working with highly repetitive genomes to improve alignment uniqueness.
*   **Edge Trim Length (`-T`)**: Use this to ignore a specific number of bases at the very edge of the contigs if you suspect the ends are low quality or contain adapter sequences.

## Expert Tips

1.  **Memory Management**: When working with very large datasets, ensure your system has sufficient RAM for the BLAST+ processes, as fgap spawns these internally.
2.  **Thread Optimization**: Use the `-t` parameter to match your CPU core count. Gap closing is an embarrassingly parallel task and scales well.
3.  **Output Analysis**: Use the `-m 1` flag to generate additional output files. This provides the gap regions before and after closing, which is essential for manual verification of critical gaps.
4.  **Preprocessing**: Ensure your dataset files (`-a`) are in FASTA format. If you have FASTQ reads, convert them to FASTA first using tools like `seqtk` or `awk`.
5.  **Recursive Closing**: For complex assemblies, consider running fgap in multiple rounds, using the output of the first round as the draft for the second, potentially with different datasets or stricter parameters.



## Subcommands

| Command | Description |
|---------|-------------|
| blastn | Nucleotide-Nucleotide BLAST 2.16.0+ |
| makeblastdb | Application to create BLAST databases, version 2.16.0+ |

## Reference documentation
- [FGAP GitHub README](./references/github_com_pirovc_fgap_blob_master_README.md)
- [FGAP Source Code (fgap.m)](./references/github_com_pirovc_fgap_blob_master_fgap.m.md)