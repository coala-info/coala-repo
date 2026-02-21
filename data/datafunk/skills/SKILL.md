---
name: datafunk
description: `datafunk` is a specialized suite of command-line utilities designed for the manipulation and curation of genomic data, primarily focusing on FASTA and SAM file formats.
homepage: https://github.com/cov-ert/datafunk
---

# datafunk

## Overview

`datafunk` is a specialized suite of command-line utilities designed for the manipulation and curation of genomic data, primarily focusing on FASTA and SAM file formats. It is frequently used in viral genomics to standardize sequence headers, filter out low-quality sequences, and prepare datasets for phylogenetic analysis. Use this tool when you need a lightweight, Python-based solution for common bioinformatics "data munging" tasks that go beyond simple sequence editing.

## Installation

The tool is available via Bioconda or can be installed from source:

```bash
# Via Conda
conda install -c bioconda datafunk

# Via Pip (from source)
pip install .
```

## Command Line Usage

`datafunk` uses a subcommand-based architecture. The general syntax is:

```bash
datafunk <subcommand> [options]
```

### Core Subcommands

- **clean_names**: Standardizes sequence names/headers in a FASTA file to ensure compatibility with downstream tools.
- **merge_fasta**: Combines multiple FASTA files into a single output file.
- **remove_fasta**: Filters out specific sequences from a FASTA file.
- **filter_low_coverage**: Removes sequences that do not meet a specific coverage threshold (e.g., too many 'N' characters).
- **sam_2_fasta**: Converts SAM alignment files into FASTA format.
- **process_gisaid_data**: A specialized workflow for handling and reformatting data downloaded from the GISAID database.
- **phylotype_consensus**: Generates consensus sequences based on assigned phylotypes.

### Common Patterns

Most subcommands follow a standard argument pattern for input and output:

```bash
# Example: Filtering low coverage sequences
datafunk filter_low_coverage -i input.fasta -o filtered.fasta --threshold 29000

# Example: Merging multiple files
datafunk merge_fasta -i file1.fasta file2.fasta -o combined.fasta
```

## Best Practices

1. **Help Discovery**: Since `datafunk` is a collection of miscellaneous tools, always check the specific arguments for a subcommand using the `--help` flag:
   ```bash
   datafunk <subcommand> --help
   ```
2. **Input Validation**: Ensure FASTA headers do not contain characters that might break downstream phylogenetic software (like spaces or special symbols) by running `clean_names` early in your pipeline.
3. **GISAID Workflows**: When working with GISAID data, use the dedicated `process_gisaid_data` command rather than generic scripts, as it handles the specific metadata formatting requirements of that database.
4. **Piping**: While `datafunk` commands often expect explicit `-i` and `-o` flags, verify the specific version's support for stdin/stdout if building complex shell pipes.

## Reference documentation

- [datafunk GitHub Repository](./references/github_com_snake-flu_datafunk.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_datafunk_overview.md)