---
name: metaxa
description: Metaxa identifies and taxonomically classifies ribosomal RNA sequences and other genetic markers within genomic datasets. Use when user asks to identify rRNA fragments, classify sequences to taxonomic groups, process paired-end metagenomic data, or build custom marker databases.
homepage: http://microbiology.se/software/metaxa2/
---


# metaxa

## Overview
Metaxa2 is a specialized bioinformatics pipeline designed to identify ribosomal RNA sequences within large genomic datasets. It uses Hidden Markov Models (HMMs) to detect rRNA fragments and a robust classifier to assign them to taxonomic groups. This skill provides the necessary command-line patterns for running the core pipeline, managing paired-end data, and utilizing the database builder for non-rRNA markers.

## Core Usage Patterns

### Basic rRNA Identification
To identify and classify rRNA sequences from a single FASTA or FASTQ file:
```bash
metaxa2 -i input.fasta -o output_prefix --plus T
```
*   `-i`: Input file (FASTA/FASTQ).
*   `-o`: Prefix for all output files.
*   `--plus T`: Enables an extra BLAST-based classification step for higher accuracy.

### Paired-End Metagenomic Data
For paired-end reads, provide both files. Metaxa2 will automatically synchronize them:
```bash
metaxa2 -1 forward.fastq -2 reverse.fastq -o output_prefix
```

### Targeting Specific Subunits
By default, Metaxa2 looks for SSU rRNA. Use the `-g` flag to specify the target:
*   `SSU`: Small Subunit (16S/18S)
*   `LSU`: Large Subunit (23S/28S)
*   `12S`: Mitochondrial 12S rRNA

```bash
metaxa2 -i input.fasta -g LSU -o lsu_results
```

### Using VSEARCH for Speed
For large datasets, use VSEARCH instead of BLAST for the classification phase to significantly reduce runtime:
```bash
metaxa2 -i input.fasta -o fast_results --search_engine vsearch
```

## Advanced Tools

### Metaxa2 Database Builder
If you need to classify sequences using a marker other than rRNA (e.g., COI, rpoB, or ITS), use the database builder:
```bash
metaxa2_dbb -a sequences.fasta -t taxonomy.txt -n custom_db_name
```
Once built, use the custom database in the main pipeline:
```bash
metaxa2 -i input.fasta -d custom_db_name -o custom_results
```

### Diversity Analysis
After running the main pipeline, use the diversity tools to generate rarefaction data or summary statistics:
```bash
metaxa2_dc -i output_prefix.taxonomy.txt -o diversity_summary
```

## Expert Tips
*   **Memory Management**: If running on a machine with limited RAM, ensure you are using version 2.1.2 or later, which includes enhanced memory efficiency.
*   **CPU Scaling**: Use the `-cpu` flag to specify the number of threads. Metaxa2 scales well across multiple cores during the HMMER and BLAST/VSEARCH phases.
*   **Reliability**: Always check the `.summary.txt` file first to see the distribution of identified taxa across the three domains of life and organelles.

## Reference documentation
- [Metaxa2: Improved Identification and Taxonomic Classification](./references/microbiology_se_software_metaxa2.md)
- [Bioconda Metaxa Package Overview](./references/anaconda_org_channels_bioconda_packages_metaxa_overview.md)