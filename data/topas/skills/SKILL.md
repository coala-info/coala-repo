---
name: topas
description: TOPAS (TOolkit for Processing and Annotating Sequence data) is a Java-based suite of modules designed for the efficient manipulation of genomic data.
homepage: https://github.com/subwaystation/TOPAS
---

# topas

## Overview
TOPAS (TOolkit for Processing and Annotating Sequence data) is a Java-based suite of modules designed for the efficient manipulation of genomic data. It provides a unified interface to perform common bioinformatics tasks such as file validation, sorting, filtering, and indexing across four primary data types: FASTA, FASTQ, GFF, and VCF.

## Command Line Usage

### General Syntax
TOPAS is typically executed as a JAR file. To see all available modules and general help, use:
```bash
java -jar topas.jar -?
```

To get help for a specific module:
```bash
java -jar topas.jar <module_name> -?
```

### Available Modules by Data Type

| Format | Available Modules |
| :--- | :--- |
| **FASTA** | `Validate`, `Correct Format`, `Index`, `Extract`, `Tabulate` |
| **FASTQ** | `Validate`, `Sort` |
| **GFF** | `Validate GFF3`, `Filter`, `Sort` |
| **VCF** | `Index`, `Filter`, `Annotate`, `Analyse`, `GenConS` |

### Consensus Sequence Generation (GenConS)
The `GenConS` module is a specialized tool for creating consensus sequences from a FASTA reference and a GATK Unified Genotyper VCF file.
- **Ancient DNA (aDNA) Support**: It allows users to specify expected DNA damage parameters, which are incorporated into the resulting consensus sequence.
- **Requirements**: Requires a reference FASTA and a corresponding VCF.

## Best Practices
- **Validation First**: Always run the `Validate` module for your specific file type (e.g., `Validate GFF3`) before performing complex filtering or annotation to ensure file integrity.
- **FASTA Standardization**: Use the `Correct FASTA` module to fix formatting issues in reference files that might cause errors in other bioinformatics pipelines.
- **Ancient DNA Workflows**: When working with mammoth or other ancient samples, utilize the `GenConS` module to account for post-mortem DNA degradation patterns that standard consensus tools might misinterpret.

## Reference documentation
- [topas - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_topas_overview.md)
- [TOPAS - TOolkit for Processing and Annotating Sequence data](./references/github_com_subwaystation_TOPAS.md)