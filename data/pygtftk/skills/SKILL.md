---
name: pygtftk
description: pygtftk is a high-performance toolkit for manipulating Gene Transfer Format files and performing genomic overlap statistics. Use when user asks to handle GTF files, extract transcript sequences, convert genomic formats, or perform Monte Carlo simulations for overlap analysis.
homepage: http://github.com/dputhier/pygtftk
---


# pygtftk

## Overview

The Python GTF toolkit (`pygtftk`) is a high-performance suite designed to streamline the handling of Gene Transfer Format (GTF) files. Built upon a C-based core library (`libgtftk`), it provides a comprehensive command-line interface (`gtftk`) for atomic operations such as data extraction, format conversion, and complex genomic overlap statistics. It is specifically optimized for GFF2.0/GTF standards and is a go-to tool for bioinformaticians working with Ensembl-style annotations who need to validate genomic region enrichments using Monte Carlo simulations.

## Core CLI Usage and Best Practices

### Getting Started and Discovery
The primary entry point is the `gtftk` command. 
- **List all tools**: Run `gtftk -h` to see the available subcommands.
- **Plugin Information**: Use `gtftk -p` to view functional tests and plugin-specific details.
- **Access Example Data**: Use the built-in downloader to retrieve test datasets:
  ```bash
  # List help for example downloader
  gtftk get_example -h
  
  # Download all files from the 'simple' dataset
  gtftk get_example -d simple -f "*"
  ```

### Working with GTF Files
- **Format Compatibility**: Ensure your input is GTF or GFF2.0. Note that `pygtftk` **does not support GFF3**.
- **Memory Management**: For large genomes (e.g., Human Ensembl releases), ensure the environment has at least 16GB of RAM, especially when piping multiple `gtftk` commands.
- **Sequence Extraction**: Use `gtftk get_tx_seq` to extract transcript sequences. Ensure your FASTA chromosome names match the GTF chromosome names exactly to avoid "No genes found" errors.

### OLOGRAM (Overlap Analysis)
OLOGRAM is used to compute overlap statistics between user-supplied BED regions and GTF-derived annotations (exons, promoters, etc.).
- **Monte Carlo Simulations**: It uses Monte Carlo shifts to determine if overlaps are statistically significant.
- **N-wise Combinations**: Use the latest version of OLOGRAM to find correlation groups (e.g., enrichment of A+B or A+B+C combinations).
- **Custom Keys**: You can use custom keys/values within the GTF (like gene biotypes or discretized numeric values) to define the regions for overlap analysis.

### Common Workflow Patterns
1. **Filtering**: Use atomic tools to filter GTF files by specific attributes (e.g., `gene_biotype`) before performing downstream analysis.
2. **Conversion**: Convert between genomic formats while preserving specific GTF attributes.
3. **Validation**: Always run `gtftk -h` after a new installation to allow the tool to initialize plugins in the `~/.gtftk` directory.

## Expert Tips
- **Conda Preference**: Always prefer installation via Conda (`conda install bioconda::pygtftk`) to ensure all C-library dependencies and external tools like `bedtools` and `graphviz` are correctly linked.
- **Chromosome Naming**: If you encounter errors regarding multiple chromosomes for a single gene ID, ensure you are using non-ambiguous identifiers (like Ensembl IDs) rather than common gene symbols.
- **Parallel Testing**: If developing or validating an installation, use `make test_para -j <cores>` to run functional tests in parallel.

## Reference documentation
- [Main Repository and Documentation](./references/github_com_dputhier_pygtftk.md)
- [Installation and Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pygtftk_overview.md)
- [Developer Wiki and Release Notes](./references/github_com_dputhier_pygtftk_wiki.md)