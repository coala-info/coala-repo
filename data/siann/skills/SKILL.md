---
name: siann
description: SIANN performs high-resolution taxonomic classification to achieve strain-level differentiation of bacterial or viral genomes. Use when user asks to build a custom strain-level database, perform strain-level identification, or analyze sequencing reads for specific microbial lineages.
homepage: https://github.com/signaturescience/siann/wiki
---


# siann

## Overview

SIANN (Strain-level Identification and Analysis of Nucleic acids) is a specialized bioinformatics tool designed for high-resolution taxonomic classification. While general metagenomic classifiers (like METSCALE or Kraken) typically stop at the genus or species level, SIANN allows you to build a targeted local database of specific bacterial or viral genomes to achieve strain-level differentiation. It is particularly useful when you have already identified a species of interest in a sample and need to determine the specific lineage or strain present.

## Database Construction

SIANN requires a custom-built database. The workflow involves organizing raw genomes and running a formatting script.

1.  **Organize Genomes**: Place all reference genomes in a specific directory structure. Files must follow the naming convention `Genus_Species_Strain.fasta`.
    ```bash
    mkdir -p data/db/raw_genomes
    # Move your .fasta files here
    ```

2.  **Download References (NCBI)**:
    *   For species with < 1000 isolates: Use `lftp` to mirror the RefSeq directory.
    *   For species with > 1000 isolates: Parse the `assembly_summary.txt` to select a representative subset (e.g., the first 50) to keep database generation time manageable.

3.  **Format the Database**:
    ```bash
    cd data/db/raw_genomes/../../
    make_database.sh
    ```

## Running Analysis

Once the database is prepared, use `siann.py` to process your sequencing reads.

### Basic Command
```bash
siann.py -d data/db --reads data/reads/sample.fastq.gz --out output_prefix -t 20
```

### Common Parameters
- `-d, --db`: Path to the constructed reference database.
- `-r, --reads`: Input FASTQ/FASTA file.
- `-p, --paired`: Path to the second set of reads if using paired-end data.
- `-t, --threads`: Number of threads for alignment (defaults to all available).
- `--out`: Prefix for all generated output files.
- `--reads_out`: Optional flag to output specific reads that mapped to species or strains.
- `--keep_sam`: Optional flag to retain the intermediate SAM alignment files.

## Best Practices

- **Pre-classification**: Use SIANN as a secondary tool. First, use a broad classifier to identify the dominant species, then build a SIANN database specifically for that species to get strain-level resolution.
- **Genome Naming**: Ensure your FASTA files are named correctly (`Genus_Species_Strain.fasta`) before running `make_database.sh`, as the tool relies on this metadata for reporting.
- **Environment**: Always run the tool within its dedicated Conda environment to ensure Python 2.7 dependencies are met.
    ```bash
    conda activate siann
    ```

## Reference documentation
- [Getting Started](./references/github_com_signaturescience_siann_wiki_Getting-Started.md)
- [Install and Setup](./references/github_com_signaturescience_siann_wiki_Install-and-Setup.md)