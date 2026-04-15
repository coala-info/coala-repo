---
name: k-slam
description: k-SLAM is a high-performance metagenomic tool that performs rapid k-mer based alignment and taxonomic classification using the Smith-Waterman algorithm. Use when user asks to perform taxonomic profiling, align metagenomic reads to a reference database, generate SAM files, or identify gene overlaps.
homepage: https://github.com/aindj/k-SLAM
metadata:
  docker_image: "quay.io/biocontainers/k-slam:1.0--1"
---

# k-slam

## Overview
k-SLAM (k-mer based Smith-Waterman Local Alignment for Metagenomics) is a high-performance tool designed to bridge the gap between fast k-mer classifiers and sensitive sequence aligners. It utilizes a k-mer based technique to rapidly identify candidate alignments, which are then rigorously validated using the Smith-Waterman algorithm. By chaining these alignments into a pseudo-assembly, k-SLAM increases taxonomic specificity. It is an ideal choice for researchers needing to process millions of reads per minute while requiring detailed outputs like SAM files, gene overlaps, and Lowest Common Ancestor (LCA) taxonomic profiles.

## Installation
The recommended method for installation is via Bioconda:
```bash
conda install bioconda::k-slam
```

## Database Management
k-SLAM requires a formatted database to function.

### Standard NCBI Database
Use the provided installation script to download the latest NCBI RefSeq genomes and taxonomy:
```bash
install_slam_new_db.sh <database_directory> bacteria viruses
```
*Note: This process is memory-intensive and requires significant disk space.*

### Custom Database Creation
To build a database from your own GenBank or FASTA files:
1. **Parse Taxonomy:**
   ```bash
   SLAM --parse-taxonomy names.dmp nodes.dmp --output-file <tax_db_name>
   ```
2. **Parse GenBank Files:**
   ```bash
   SLAM --output-file <db_name> --parse-genbank file1.gbk file2.gbk
   ```
3. **Parse FASTA Files (Alignment only):**
   ```bash
   SLAM --output-file <db_name> --parse-fasta file1.fa file2.fa
   ```
   *Note: Databases built from FASTA files must be run with the `--just-align` flag.*

## Common CLI Patterns

### Metagenomic Profiling (Paired-End)
The standard command for taxonomic classification of paired-end data:
```bash
SLAM --db=/path/to/database --output-file=results.xml sample_R1.fastq sample_R2.fastq
```

### Alignment-Only Mode
To generate SAM files without performing taxonomic LCA classification:
```bash
SLAM --db=/path/to/database --just-align --sam-file=output.sam sample.fastq
```

### Memory Optimization
k-SLAM typically requires ~50GB of RAM for large bacterial databases. If your system has lower memory, use the chunking parameter:
```bash
SLAM --db=/path/to/database --num-reads-at-once=1000000 --output-file=results.xml sample.fastq
```

## Expert Tips and Best Practices
- **Hardware Allocation:** k-SLAM is designed for parallel execution. For maximum throughput (up to 5 million reads per minute), ensure the environment provides at least 8 CPU cores.
- **Alignment Sensitivity:** Adjust the `--score-fraction-threshold` (default 0.95). Lowering this value allows more divergent alignments to be considered for the LCA calculation, while raising it increases stringency.
- **SAM Output:** To keep SAM files manageable, use the `--sam-xa` flag. This outputs only the primary alignment line for each read and puts secondary alignments into the `XA` tag, similar to BWA.
- **Pseudo-Assembly:** The default pseudo-assembly behavior significantly improves specificity for metagenomic datasets. Only use `--no-pseudo-assembly` if you are performing basic alignment where read chaining is not biologically relevant.
- **XML Parsing:** The XML output contains detailed gene information. Be aware that gene annotations in the XML use entity references (e.g., `&amp;` for `&`) to maintain valid XML structure.

## Reference documentation
- [k-SLAM Overview](./references/anaconda_org_channels_bioconda_packages_k-slam_overview.md)
- [k-SLAM GitHub Repository](./references/github_com_aindj_k-SLAM.md)