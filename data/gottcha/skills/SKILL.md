---
name: gottcha
description: GOTTCHA is a metagenomic tool that performs high-resolution taxonomic profiling using a gene-independent, signature-based method. Use when user asks to profile metagenomic samples, classify taxonomic origins, or identify genomic signatures in FASTQ files.
homepage: https://github.com/poeli/GOTTCHA
---


# gottcha

## Overview

GOTTCHA (Genomic Origin Through Taxonomic CHAllenge) is a specialized metagenomic tool that employs a gene-independent, signature-based method for taxonomic profiling. By utilizing unique genomic signatures rather than universal marker genes, it provides high-resolution classification with significantly lower false discovery rates than many traditional tools. It is designed to be lightweight enough for laptop deployment while remaining robust enough for complex community analysis.

## Installation and Setup

Before running GOTTCHA, ensure the environment has Perl v5.8+ and at least 8GB of RAM.

1.  **Initialization**: Run the installation script to compile dependencies like `splitrim` and check for `bwa`.
    ```bash
    ./INSTALL.sh
    ```
2.  **Binaries**: After installation, all executable scripts are located in the `bin/` directory.
3.  **Database Requirement**: GOTTCHA requires two distinct components to function:
    *   A taxonomic lookup table (`GOTTCHA_lookup.tar.gz`).
    *   A pre-computed signature database (e.g., Bacterial species-level).

## Command Line Usage

The primary interface is the `gottcha.pl` Perl script.

### Basic Profiling
To profile a FASTQ file against a specific database:
```bash
bin/gottcha.pl --input <INPUT_FASTQ> --database <DATABASE_PATH> --outdir <OUTPUT_DIRECTORY>
```

### Common Parameters
*   `--threads <int>`: Set the number of CPU threads (default is usually 1, but 8+ is recommended for speed).
*   `--input <file>`: Path to the input FASTQ file.
*   `--database <path>`: Path to the specific GOTTCHA database (do not include the file extension).
*   `--outdir <path>`: Directory where results will be saved.

### Database Selection Logic
GOTTCHA databases are named based on their composition. Understanding the nomenclature helps in selecting the right one:
*   **k24**: Indicates a 24-mer k-mer size was used.
*   **u30**: Indicates a minimum of 30bp of unique fragments were retained.
*   **xHUMAN3x**: Indicates the database has been masked against three human genomes to reduce false positives in clinical samples.

## Expert Tips and Best Practices

*   **Verification**: Because signature databases are large, always verify downloads using MD5 checksums (`*.md5` files) provided on the download server.
*   **Memory Management**: While 8GB is the minimum, complex databases or large FASTQ files may require more RAM during the BWA-MEM mapping phase.
*   **Plasmid Analysis**: If you require plasmid-relative results, ensure you are using the newer parsed database format (`.parsedGOTTCHA.dmp`). Older databases will report zero for plasmid findings.
*   **Input Quality**: GOTTCHA includes a `splitrim` tool (invoked internally or manually) to handle read trimming. If you encounter segfaults with `splitrim`, ensure your input FASTQ follows standard formatting and does not contain excessively long headers.
*   **Output Interpretation**: The primary output is a `.tsv` file. Focus on the "Relative Abundance" and "Coverage" columns to assess the presence of specific taxa. High coverage across unique signatures provides higher confidence than a high read count on a single signature.

## Reference documentation
- [GOTTCHA Main Documentation](./references/github_com_poeli_GOTTCHA.md)
- [GOTTCHA Issues and Troubleshooting](./references/github_com_poeli_GOTTCHA_issues.md)