---
name: plasmidseeker
description: PlasmidSeeker identifies known plasmids and estimates their copy number in raw sequencing reads using k-mer frequency analysis. Use when user asks to detect plasmids in whole-genome sequencing data, estimate plasmid copy number, or screen isolates for plasmids without performing de novo assembly.
homepage: https://github.com/bioinfo-ut/PlasmidSeeker
---


# plasmidseeker

## Overview
PlasmidSeeker is a k-mer based tool designed to identify known plasmids within raw sequencing reads without the need for de novo assembly. By analyzing the k-mer frequency distribution of a WGS sample and comparing it to both a plasmid database and a related reference bacterium, it can estimate plasmid presence and copy number. This approach is particularly useful for rapid screening of isolates and avoiding assembly-related biases.

## Installation and Setup
PlasmidSeeker requires Perl, R, and the GenomeTester4 binaries.
1. Ensure `gdistribution`, `glistcompare`, `glistquery`, and `glistmaker` are located in a `GenomeTester4/` directory within the PlasmidSeeker folder.
2. Download a pre-built database or build a custom one using `database_builder.pl`.

## Building a Custom Database
To create a database from a multi-FASTA file containing plasmid sequences:
```bash
perl database_builder.pl -i [all_plasmids.fna] -d [database_dir] -t [threads] -w [k-mer_length]
```
*   **Default k-mer length (-w)**: 20.
*   **Threads (-t)**: Defaults to 32; adjust based on your hardware.

## Detecting Plasmids
The primary workflow requires the raw FASTQ reads of your isolate and a FASTA file of the closest available reference bacterium.

### Basic Command
```bash
perl plasmidseeker.pl -i sample.fastq -b reference_bacterium.fna -d plasmid_db/ -o results.txt
```

### Key Options
*   **-f [int]**: Minimum threshold for the fraction of unique k-mers found (default: 80). Lower this if you suspect highly diverged plasmids.
*   **-a [0-100]**: Allowed coverage variation. Increase this if the bacterial and plasmid sequences have significantly different GC content or sequencing bias.
*   **-k**: Keep temporary files and generate distribution graphs (PNG). Highly recommended for manual verification of results.
*   **--ponly**: Use this flag if the input reads are known to contain only plasmid sequences (e.g., from a plasmid extraction).

## Interpreting Results
*   **Clusters**: Plasmids sharing >80% k-mers are grouped into clusters. Usually, only the top hit in a cluster is actually present.
*   **High P-Value Plasmids**: These are plasmids with copy numbers very similar to the host chromosome. They may represent false positives or plasmids integrated into the chromosome.
*   **Visual Verification**: If `-k` is used, check the red (plasmid) vs. blue (bacterium) distribution curves. A true positive should show a clear plasmid k-mer peak that fits the expected distribution model.

## Reference documentation
- [PlasmidSeeker Main Documentation](./references/github_com_bioinfo-ut_PlasmidSeeker.md)