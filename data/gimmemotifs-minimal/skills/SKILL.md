---
name: gimmemotifs-minimal
description: GimmeMotifs is a suite of tools designed to identify, scan, and analyze transcription factor motifs within genomic sequences. Use when user asks to perform de novo motif discovery, scan sequences for known motifs, identify differentially enriched motifs, or compare motifs against established databases.
homepage: https://github.com/vanheeringen-lab/gimmemotifs
metadata:
  docker_image: "quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0"
---

# gimmemotifs-minimal

## Overview
GimmeMotifs is a specialized suite of tools designed to identify and analyze transcription factor motifs within genomic regions. This skill enables the execution of motif prediction pipelines, the scanning of sequences for known motif occurrences, and the comparison of discovered motifs against established databases. It is particularly effective for processing peak files (BED format) to identify the regulatory drivers of observed biological signals.

## Core CLI Workflows

### De Novo Motif Discovery
The primary entry point for finding new motifs in experimental data (e.g., ChIP-seq peaks).

```bash
# Basic de novo discovery using a FASTA file for the genome
gimme motifs peaks.bed -g /path/to/genome.fa --denovo -n my_results

# Discovery using a genome installed via genomepy
gimme motifs peaks.bed -g hg38 -n my_results
```

### Motif Scanning
Search for known motifs within specific genomic regions.

```bash
# Scan a BED file for motifs and get the best matches
gimme scan peaks.bed -g hg38 > matches.txt

# Use a specific PWM/PFM file for scanning
gimme scan peaks.bed -g hg38 -p custom_motifs.pfm > matches.txt
```

### Differential Motif Enrichment (Maelstrom)
Identify motifs that are differentially enriched between multiple conditions or clusters.

```bash
# Run maelstrom on a table of scores (e.g., fold change or accessibility)
gimme maelstrom input_table.txt hg38 output_dir/
```

### Motif Comparison and Matching
Compare discovered motifs to known databases to identify the transcription factors.

```bash
# Match a motif file against the default database
gimme match my_motifs.pfm -p JASPAR2020
```

## Best Practices and Expert Tips

### Genome Management
GimmeMotifs integrates with `genomepy`. Instead of providing full paths to FASTA files, install genomes directly to simplify commands:
1. Install a genome: `genomepy install hg38 --annotation`
2. Reference it by name: `-g hg38`

### Performance Optimization
*   **Parallelization**: Most `gimme` commands support multi-threading. Use the `-n` or `--ncpus` flag to specify the number of cores.
*   **Memory Management**: For very large BED files, ensure the regions are merged or filtered to avoid excessive memory consumption during the scanning phase.

### Input Requirements
*   **BED Files**: Ensure your BED files are tab-separated and follow standard 3-column (chr, start, end) or 6-column formats.
*   **Sequence Length**: For de novo discovery, motifs are typically found in the center of peaks. Using 200bp windows around peak summits is a common standard for high-quality results.

### Troubleshooting Common Issues
*   **Broadcasting Errors**: If `gimme match` fails with shape errors, verify that your input PWM/PFM file follows the standard 4-column (A, C, G, T) format without trailing spaces or inconsistent headers.
*   **Duplicate Regions**: `gimme maelstrom` may throw uninformative errors if duplicate genomic regions are present in the input. Always deduplicate your BED or score files before running.

## Reference documentation
- [GitHub README and Quick Start](./references/github_com_vanheeringen-lab_gimmemotifs.md)
- [Anaconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gimmemotifs-minimal_overview.md)