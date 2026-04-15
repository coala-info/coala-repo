---
name: fastani
description: FastANI calculates the Average Nucleotide Identity between genome pairs using a high-throughput MinHash-based sequence mapping engine. Use when user asks to calculate ANI between microbial genomes, perform pairwise or batch genome comparisons, generate a similarity matrix for phylogenomic analysis, or visualize conserved regions between two genomes.
homepage: https://github.com/ParBLiSS/FastANI
metadata:
  docker_image: "quay.io/biocontainers/fastani:1.34--h4dfc31f_4"
---

# fastani

## Overview

FastANI is a high-throughput tool designed for microbial genomics to calculate the Average Nucleotide Identity (ANI) between genome pairs without the computational overhead of traditional alignment methods like BLAST. It uses a MinHash-based sequence mapping engine (Mashmap) to estimate orthologous mappings. It is optimized for genomes with >80% identity and is significantly faster than BLAST-based methods while maintaining comparable accuracy.

## Usage Patterns

### Basic Pairwise Comparison (One-to-One)
To compare a single query genome against a single reference genome:
`fastANI -q [QUERY_GENOME] -r [REFERENCE_GENOME] -o [OUTPUT_FILE]`

### Batch Processing (One-to-Many or Many-to-Many)
When dealing with multiple genomes, use list files containing absolute or relative paths to the genome files (one path per line).

**One-to-Many:**
`fastANI -q [QUERY_GENOME] --rl [REFERENCE_LIST] -o [OUTPUT_FILE]`

**Many-to-Many:**
`fastANI --ql [QUERY_LIST] --rl [REFERENCE_LIST] -o [OUTPUT_FILE]`

### Generating a Similarity Matrix
To produce a phylip-formatted lower triangular matrix of identity values (useful for downstream phylogenomic analysis):
`fastANI --ql [QUERY_LIST] --rl [REFERENCE_LIST] --matrix -o [OUTPUT_FILE]`

### Visualization of Conserved Regions
To generate a mapping file for visualization between two genomes:
1. Run FastANI with the visualize flag:
   `fastANI -q [GENOME_A] -r [GENOME_B] --visualize -o [OUTPUT_FILE]`
2. Use the provided R script to plot (requires `genoPlotR`):
   `Rscript scripts/visualize.R [GENOME_A] [GENOME_B] [OUTPUT_FILE].visual`

## Tool-Specific Best Practices

### Input Requirements
* **Format**: Supports fasta, multi-fasta, and gzip-compressed fasta files.
* **Quality**: For reliable results, ensure input genome assemblies have an N50 ≥ 10 Kbp.
* **Identity Threshold**: FastANI does not report values for genome pairs with ANI significantly below 80%. For more distant relationships, consider amino acid level comparisons.

### Performance Optimization
* **Multi-threading**: Use the `-t` or `--threads` parameter to specify the number of CPU cores.
* **Large Databases**: For extremely large reference sets, manually split the reference list into chunks and run parallel FastANI processes to scale beyond a single node.

### Interpreting Results
* **Output Format**: The default output is a tab-delimited file containing:
  1. Query genome path
  2. Reference genome path
  3. ANI value
  4. Count of bidirectional fragment mappings
  5. Total query fragments
* **Alignment Fraction**: Calculate this by dividing the count of bidirectional fragment mappings (column 4) by the total query fragments (column 5).
* **Asymmetry**: FastANI results can be slightly asymmetric (ANI of A vs B may differ from B vs A). The `--matrix` option automatically averages these values for the final output.

## Reference documentation
- [FastANI GitHub Repository](./references/github_com_ParBLiSS_FastANI.md)
- [Bioconda FastANI Overview](./references/anaconda_org_channels_bioconda_packages_fastani_overview.md)