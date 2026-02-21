---
name: taxmapper
description: Taxmapper is a specialized bioinformatics pipeline optimized for the identification and classification of microeukaryotes within metagenomic datasets.
homepage: https://bitbucket.org/dbeisser/taxmapper
---

# taxmapper

## Overview
Taxmapper is a specialized bioinformatics pipeline optimized for the identification and classification of microeukaryotes within metagenomic datasets. While many metagenomic tools focus on prokaryotic signatures, this tool provides a streamlined workflow for mapping reads against reference databases to resolve complex eukaryotic community structures.

## Command Line Usage
The tool is typically invoked via the `taxmapper` command. Ensure the environment is activated via conda before execution.

### Basic Execution
To run a standard analysis on paired-end data:
```bash
taxmapper -1 forward_reads.fastq -2 reverse_reads.fastq -db reference_database -o output_directory
```

### Key Parameters
- `-1`, `-2`: Paths to the forward and reverse FASTQ files.
- `-db`: Path to the formatted reference database (e.g., PR2, SILVA, or custom eukaryotic sets).
- `-o`: The directory where mapping results and taxonomic tables will be stored.
- `-t`: Number of threads to utilize for alignment (default is usually 1). Increase this for faster processing on HPC nodes.

## Best Practices
- **Database Selection**: For microeukaryotic studies, ensure your reference database includes comprehensive 18S rRNA sequences.
- **Quality Control**: Pre-process raw reads with tools like FastP or Trimmomatic before running taxmapper to improve mapping accuracy and reduce noise from adapter contamination.
- **Memory Management**: Mapping against large eukaryotic databases can be memory-intensive. Monitor RAM usage when running on large datasets.

## Reference documentation
- [Taxmapper Bitbucket Repository](./references/bitbucket_org_dbeisser_taxmapper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_taxmapper_overview.md)