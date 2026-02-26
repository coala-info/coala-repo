---
name: minced
description: "MinCED identifies CRISPR arrays within genomic or metagenomic sequences by detecting direct repeats and spacer sequences. Use when user asks to detect CRISPR loci, find repeats and spacers in environmental contigs, or generate GFF annotations for CRISPR arrays."
homepage: https://github.com/ctSkennerton/minced
---


# minced

## Overview
MinCED (Mining CRISPRs in Environmental Datasets) is a specialized tool for the automated detection of CRISPR arrays. It identifies the characteristic structure of these loci—consisting of multiple short, direct repeats separated by unique spacer sequences—within full genomes or assembled environmental contigs. It is a derivative of the CRISPR Recognition Tool (CRT) but optimized for the scale and variability of metagenomic data.

## CLI Usage and Best Practices

### Basic Command Structure
The standard execution requires a FASTA file as input.
```bash
minced [options] input_file.fa [output_file] [gff_file]
```

### Common CLI Patterns
- **Standard Genome Analysis**: Run with default parameters for finished or high-quality draft genomes.
  ```bash
  minced genome.fna output.txt
  ```
- **Metagenomic/Short Contig Analysis**: When working with environmental data or short contigs (e.g., ~100-200bp), you must lower the minimum number of repeats required to identify an array.
  ```bash
  minced -minNR 2 metagenome.fna metagenome.crisprs
  ```
- **Dual Output Generation**: Generate both the human-readable summary table and a GFF file for downstream genomic annotation pipelines simultaneously.
  ```bash
  minced input.fa out.txt out.gff
  ```

### Parameter Tuning
- `-minNR <int>`: Minimum number of repeats. Default is 3. Set to 2 for fragmented environmental data.
- `-minRL <int>`: Minimum repeat length (default 19).
- `-maxRL <int>`: Maximum repeat length (default 38).
- `-minSL <int>`: Minimum spacer length (default 19).
- `-maxSL <int>`: Maximum spacer length (default 48).
- `-searchWL <int>`: Search window length (default 8).

### Expert Tips
- **Input Limitations**: MinCED is designed for assembled sequences (genomes/contigs). If you are working with raw, unassembled short reads (100-200bp), use a tool like Crass instead.
- **Environment Setup**: Ensure `minced` and `minced.jar` remain in the same directory for the wrapper script to function correctly.
- **Java Dependency**: MinCED requires a Java Runtime Environment. If running in a restricted environment, ensure `JAVA_HOME` is correctly set.
- **GFF Compatibility**: The GFF output is designed to be compatible with NCBI guidelines and includes `rpt_type=direct` tags for CRISPR repeats.

## Reference documentation
- [MinCED Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_minced_overview.md)
- [MinCED GitHub Repository](./references/github_com_ctSkennerton_minced.md)