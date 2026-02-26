---
name: slimm
description: SLIMM is a taxonomic profiling tool that identifies microorganisms in metagenomic samples using alignment files. Use when user asks to perform species-level identification, generate taxonomic profiles from BAM or SAM files, or build custom taxonomic databases.
homepage: https://github.com/seqan/slimm/blob/master/README.md
---


# slimm

## Overview
SLIMM (Species Level Identification of Microbes from Metagenomes) is a taxonomic profiling tool that identifies microorganisms present in metagenomic samples. Unlike tools that work directly with raw reads, SLIMM operates on alignment files (BAM/SAM) produced by read mappers like Bowtie2 or Yara. It uses a unique binning and scoring approach to provide high-resolution taxonomic assignments, typically at the species level, while minimizing false positives.

## Installation
The most reliable way to install SLIMM is via Bioconda:
```bash
conda install -c bioconda slimm
```

## Core Workflow

### 1. Read Mapping (Pre-requisite)
SLIMM requires alignment files that include secondary alignments to resolve ambiguities.
*   **Bowtie2 Pattern**: Use `-k` to report multiple alignments.
    ```bash
    bowtie2 -x reference_index -1 read1.fq -2 read2.fq -k 60 -S output.sam
    ```
*   **Yara Pattern**: Use `-s 2` or `--strata-rate 1`.
    ```bash
    yara_mapper -s 2 -o output.bam reference_index read1.fq read2.fq
    ```

### 2. Running SLIMM
Execute SLIMM on the resulting BAM/SAM file using a SLIMM database (`.sldb`).
```bash
slimm -w 1000 -o output_dir/ database.sldb input.bam
```

### 3. Filtering by Rank
To generate a report for a specific taxonomic level (e.g., species, genus, family):
```bash
slimm -w 1000 -r species -o output_dir/ database.sldb input.bam
```

## Building Custom Databases
If the pre-indexed databases are insufficient, use `slimm_build` to create a custom `.sldb` file. This requires NCBI taxonomy files (`names.dmp`, `nodes.dmp`) and `accession2taxid` mappings.

```bash
slimm_build -v \
  -nm taxdump/names.dmp \
  -nd taxdump/nodes.dmp \
  -o custom_db.sldb \
  reference_genomes.fna \
  *.accession2taxid.gz
```

## Expert Tips and Best Practices
*   **Window Size (`-w`)**: The default window size is often 1000. Adjusting this can impact the sensitivity of identification in conserved regions.
*   **File Formats**: While SLIMM supports SAM, using BAM format is recommended for better I/O performance and reduced storage footprint.
*   **Secondary Alignments**: SLIMM's accuracy depends heavily on the read mapper's ability to provide multiple candidate locations for a read. Always ensure your mapper is configured to output more than just the primary alignment.
*   **Memory Management**: For very large datasets, ensure the system has sufficient RAM to load the `.sldb` database into memory.

## Reference documentation
- [SLIMM Wiki Home](./references/github_com_seqan_slimm_wiki.md)
- [Example Bowtie2 Workflow](./references/github_com_seqan_slimm_wiki_Example-Bowtie2.md)
- [Preparing a Custom Database](./references/github_com_seqan_slimm_wiki_Preparing-a-custom-database.md)