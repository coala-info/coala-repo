---
name: seroba
description: SeroBA is a k-mer based pipeline that identifies Streptococcus pneumoniae serotypes directly from raw Illumina paired-end sequencing data. Use when user asks to identify capsular types, run serotyping on pneumococcal reads, or summarize serotype predictions from multiple samples.
homepage: https://github.com/sanger-pathogens/seroba
---


# seroba

## Overview
SeroBA (Serotype By Ariba) is a high-throughput k-mer based pipeline designed to identify serotypes directly from raw Illumina paired-end sequencing data. It is primarily used for identifying the capsular type of *Streptococcus pneumoniae* by targeting the *cps* locus. The tool is highly efficient, capable of processing large sample sets rapidly, and maintains high accuracy even at low sequencing coverage (down to 10x).

## Core Workflow

### 1. Database Preparation
Before running serotyping, you must initialize and index a reference database.

*   **Download PneumoCaT references**:
    ```bash
    seroba getPneumocat <database_dir>
    ```
*   **Index the database**:
    Use a k-mer size of 71 (recommended for optimal sensitivity and specificity).
    ```bash
    seroba createDBs <database_dir> 71
    ```

### 2. Running Serotyping
Execute the serotyping pipeline on paired-end reads.

```bash
seroba runSerotyping <database_dir> <read_1.fastq.gz> <read_2.fastq.gz> <output_prefix>
```

**Key Options:**
*   `--coverage <int>`: Set the threshold for k-mer coverage of the reference sequence (default is 20).
*   `--noclean`: Keep intermediate files, such as local assemblies and Ariba reports, which is useful for troubleshooting "untypable" results.

### 3. Summarizing Results
After processing multiple samples, aggregate the findings into a single report.

```bash
seroba summary <directory_containing_output_folders>
```
This generates a `summary.tsv` file containing Sample ID, predicted serotype, and relevant comments.

## Output Interpretation
Each run produces an output folder named after your `<output_prefix>` containing:
*   **pred.tsv**: The primary prediction file containing the identified serotype.
*   **detailed_serogroup_info.txt**: Contains granular data on SNPs, genes, and alleles detected in the reads.
*   **untypable**: If a sample does not match any known reference in the database, it is labeled as "untypable" (in versions 0.1.3+).

## Expert Tips & Best Practices
*   **Low Coverage Samples**: While SeroBA works at 10x, if you receive "untypable" results on known samples, try lowering the `--coverage` threshold to 10 or 15.
*   **Custom Serotypes**: You can extend the database by adding custom reference sequences to the `references.fasta` file within the database folder before running `seroba createDBs`.
*   **Disk Space**: SeroBA generates significant intermediate data. Unless you are debugging, avoid using `--noclean` to save storage space.
*   **Input Validation**: Ensure read pairs are properly matched; SeroBA will fail if the forward and reverse read headers do not correspond.

## Reference documentation
- [SeroBA GitHub Repository](./references/github_com_sanger-pathogens_seroba.md)
- [SeroBA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seroba_overview.md)