---
name: mgkit
description: MGKit is a modular bioinformatics framework designed for processing functional annotations, sequence data, and count tables. Use when user asks to extract sequence statistics, manipulate count tables, transform mapping files, or analyze SNP and variant data.
homepage: https://github.com/frubino/mgkit
---

# mgkit

## Overview
MGKit (Metagenomics Framework) is a collection of modular tools designed to simplify the construction of bioinformatics pipelines. It excels at processing functional annotations and sequence data, providing specialized utilities for count tables, genomic features (GFF), and variant calls (VCF). Use this skill to leverage its command-line interface for efficient data transformation and statistics.

## Installation and Setup
Install mgkit via bioconda to ensure all dependencies (like pysam and numpy) are correctly resolved:
```bash
conda install -c bioconda mgkit
```

## Core Command-Line Utilities

### Sequence Analysis (fasta-utils)
Use `fasta-utils` to extract information from FASTA files.
- **Get sequence statistics**: `fasta-utils info <input.fasta>`
- **Calculate GC content**: Add the `--gc-content` flag to the info command to include genomic composition metrics.

### Count Table Manipulation (count-utils)
`count-utils` is used for managing and transforming abundance or count data.
- **Merge tables**: Use `count-utils cat` to concatenate multiple count files.
- **Export to CSV**: Use `count-utils to_csv` to convert internal formats or parquet outputs to standard spreadsheets.
- **Map data**: Use `count-utils` to map count tables against other metadata or functional information.

### Dictionary and Data Transformation (dict-utils)
For manipulating mapping files or key-value data:
- **Reverse mappings**: `dict-utils reverse <input_dict>`
- **Randomize output**: Use the `--randomise` flag with the reverse command to shuffle entries, which is useful for certain statistical permutations.

### Variant and SNP Analysis
- **SNP Parsing**: Use `snp_parser` for analyzing variants. Note that this requires `HTSeq` to be installed in the environment.
- **VCF Processing**: MGKit supports parsing VCF files, including the ability to handle multiple VCF files simultaneously to aggregate total SNP information.

## Best Practices and Expert Tips
- **Citing the Tool**: Every mgkit script supports the `--cite` flag. Use this to generate the correct citation for your methods section or use `mgkit.cite()` within Python scripts.
- **Memory Management**: When parsing large GFF files, use specific attributes like `uid` or `gene_id` to filter annotations early and reduce the memory footprint.
- **Output Formats**: For large datasets, prefer Parquet output to improve performance and reduce disk usage. You can later convert these to CSV using `count-utils` if human readability is required.
- **Python Integration**: Beyond the CLI, mgkit is a library. You can integrate its modules (like `mgkit.gff` or `mgkit.vcf`) directly into custom Python scripts for more complex logic.



## Subcommands

| Command | Description |
|---------|-------------|
| count-utils | Main function for count-utils, providing utilities to combine, map, and convert count tables. |
| dict-utils | Main function for dictionary utility commands |
| fasta-utils | Main function for FASTA file utilities |
| snp_parser | DEPRECATED, use `pnps-gen vcf` SNPs analysis, requires a vcf file |

## Reference documentation
- [MGKit GitHub Overview](./references/github_com_frubino_mgkit.md)
- [Bioconda MGKit Package](./references/anaconda_org_channels_bioconda_packages_mgkit_overview.md)