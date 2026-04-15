---
name: genomebaser
description: GenomeBaser synchronizes and organizes bacterial genomic data from NCBI RefSeq into standardized, human-readable directory structures. Use when user asks to download complete bacterial genomes, synchronize local genomic databases using rsync, or organize RefSeq files into genus-species-strain formats for downstream analysis.
homepage: https://github.com/mscook/GenomeBaser
metadata:
  docker_image: "quay.io/biocontainers/genomebaser:0.1.2--py27_1"
---

# genomebaser

## Overview
GenomeBaser is a specialized utility for synchronizing bacterial genomic data from NCBI RefSeq. Unlike generic download tools, it enforces organizational best practices by renaming cryptic RefSeq accessions into a standardized `Genus_species_strain` format using symlinks. It is particularly useful for researchers who need to maintain up-to-date local repositories of specific taxa while ensuring that chromosomal and extrachromosomal (plasmid) elements are clearly partitioned for downstream analysis.

## Core CLI Usage
The primary command structure requires the genus, species, and a target directory for the database.

```bash
GenomeBaser [OPTIONS] GENUS SPECIES OUT_DATABASE_LOCATION
```

### Common Patterns
*   **Initial Download**: To fetch all complete genomes for a specific organism:
    ```bash
    GenomeBaser Klebsiella pneumoniae ~/bio_databases/kpneumoniae
    ```
*   **Database Maintenance**: Run the same command periodically. GenomeBaser uses `rsync` to ensure only new or modified files are downloaded, saving bandwidth and time.
*   **Dependency Verification**: Before running large batches, ensure the environment is ready:
    ```bash
    GenomeBaser --check_deps Klebsiella pneumoniae ~/dbs
    ```

## Expert Tips and Best Practices
*   **Readable Filenames**: GenomeBaser automatically creates symlinks from the standard NCBI RefSeq filenames to a more intuitive `Genus_species_strain.gbk` format. Always use these symlinks for downstream scripts to improve reproducibility and readability.
*   **Data Partitioning**: The tool automatically separates complete chromosomes from plasmids into distinct subdirectories. When performing comparative genomics, check these specific folders to avoid accidental inclusion of plasmid sequences in core-genome alignments.
*   **PROKKA Integration**: One of the tool's primary strengths is generating PROKKA-ready databases. Use the output directory directly as a source for custom PROKKA protein databases to improve annotation consistency across a genus.
*   **File Formats**: By default, the tool provides both GenBank (`.gbk`) and FASTA (`.fna`) formats. This eliminates the need for manual conversion steps before starting annotation or alignment pipelines.

## Reference documentation
- [GenomeBaser Main Repository](./references/github_com_mscook_GenomeBaser.md)