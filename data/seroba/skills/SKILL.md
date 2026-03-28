---
name: seroba
description: SeroBA identifies Streptococcus pneumoniae serotypes from raw Illumina sequencing reads by analyzing the capsular polysaccharide locus. Use when user asks to predict pneumococcal serotypes, create a k-mer database for serotyping, or summarize serotype results from multiple samples.
homepage: https://github.com/sanger-pathogens/seroba
---

# seroba

## Overview
SeroBA (Serotype By Ariba) is a specialized pipeline designed for the rapid and accurate identification of *Streptococcus pneumoniae* serotypes. By leveraging k-mer based identification of the capsular polysaccharide (cps) locus, it achieves high concordance with traditional methods even at low sequencing coverage (as low as 10x). It is particularly effective for high-throughput processing of raw Illumina reads, capable of handling thousands of samples in a single day on standard server hardware.

## Core Workflows

### 1. Database Initialization
Before running predictions, you must create the local k-mer database. This step downloads references (typically from PneumoCaT) and prepares them for Ariba.

```bash
# Create the database (71 is the recommended k-mer size)
seroba createDBs database_dir 71
```

### 2. Single Sample Prediction
To identify the serotype of a single sample, provide the prepared database and the paired-end fastq files.

```bash
# Run prediction on a sample
seroba run database_dir/ read_1.fastq.gz read_2.fastq.gz output_prefix
```

### 3. Batch Processing
For multiple samples, it is most efficient to run the `run` command in parallel or via a loop. After processing, use the summary script to aggregate results.

```bash
# Summarize results from multiple output directories
seroba summary output_dir_1 output_dir_2 output_dir_3
```

## CLI Reference and Parameters

| Command | Description | Key Arguments |
| :--- | :--- | :--- |
| `createDBs` | Downloads and builds the k-mer database. | `<outdir> <kmer_size>` |
| `run` | Predicts serotype for a sample. | `<db_dir> <read1> <read2> <prefix>` |
| `summary` | Aggregates results into a TSV file. | `<list_of_output_folders>` |
| `getPneumoCaT` | Specifically fetches PneumoCaT references. | `<outdir>` |

## Expert Tips and Best Practices
- **K-mer Selection**: While the default k-mer size is often 71, you may need to adjust this based on read length. Ensure the k-mer size is smaller than your shortest read.
- **Coverage Requirements**: SeroBA is robust down to 10x coverage, but for clinical-grade certainty, 20x-30x is preferred to ensure the cps locus is fully represented in the k-mer set.
- **Database Updates**: Periodically rebuild your database if new serotype references (like 6E, 6F, or 11E) are added to the source repositories to maintain 98%+ concordance.
- **Output Interpretation**: The primary output is a `serotype.txt` file within the output directory. If the tool identifies a "NT" (Non-Typeable) result, check the assembly quality in the Ariba sub-folders to distinguish between a true NT and low-quality data.



## Subcommands

| Command | Description |
|---------|-------------|
| seroba | Seroba command-line tool |
| seroba | Seroba command-line tool |
| seroba | Serotyping analysis tool |
| seroba createDBs | Creates a Database for kmc and ariba |
| seroba getPneumocat | Downlaods PneumoCat and build an tsv formated meta data file out of it |
| seroba runSerotyping | identify serotype of your input data |
| seroba summary | writes all predictions in one tsv file |

## Reference documentation
- [SeroBA GitHub Repository](./references/github_com_sanger-pathogens_seroba_blob_master_README.md)
- [Installation and Dependencies](./references/github_com_sanger-pathogens_seroba_blob_master_install_dependencies.sh.md)
- [Version History and Bug Fixes](./references/github_com_sanger-pathogens_seroba_blob_master_CHANGELOG.md)