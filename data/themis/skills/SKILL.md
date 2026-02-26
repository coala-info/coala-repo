---
name: themis
description: Themis is a metagenomic profiler for analyzing microbial community composition. Use when user asks to identify and quantify microbial species within a given sample.
homepage: https://github.com/xujialupaoli/Themis
---


# themis

yaml
name: themis
description: Metagenomic profiler for analyzing microbial community composition. Use when Claude needs to identify and quantify microbial species within a given sample, typically from sequencing data.
```
## Overview
Themis is a metagenomic profiler designed to analyze microbial community composition. It helps in identifying and quantifying the different microbial species present in a sample, which is crucial for understanding the functional roles and interactions within a microbial ecosystem.

## Usage Instructions

Themis is a command-line tool. The primary function involves profiling a metagenomic sample against a reference database.

### Basic Usage

The core command structure for Themis is as follows:

```bash
themis -f <input_fasta_file> -r <reference_database_directory> -o <output_directory>
```

-   `-f <input_fasta_file>`: Specifies the input FASTA file containing your metagenomic reads or contigs.
-   `-r <reference_database_directory>`: Points to the directory containing the pre-built Themis reference database.
-   `-o <output_directory>`: Designates the directory where Themis will save its output files.

### Key Options and Considerations

*   **Reference Database**: Ensure you have a properly indexed Themis reference database. The creation and indexing of this database are separate steps and are critical for Themis's performance. Refer to the Themis documentation for database preparation.
*   **Output Files**: The output directory will contain various files, including abundance tables and taxonomic summaries. The exact files generated may depend on the Themis version and specific parameters used.
*   **Performance**: For large datasets, consider the computational resources required. Themis can be resource-intensive.

### Expert Tips

*   **Database Indexing**: The efficiency of Themis heavily relies on the quality and indexing of the reference database. Always ensure your database is correctly built and indexed before running profiling.
*   **Parameter Tuning**: While the basic usage is straightforward, explore additional parameters if available in the specific Themis version for fine-tuning sensitivity, specificity, or output format. Consult the tool's help (`themis --help`) for advanced options.

## Reference documentation
- [Themis Overview](./references/anaconda_org_channels_bioconda_packages_themis_overview.md)