---
name: pathoscope
description: PathoScope is a modular framework that transforms raw metagenomic sequencing reads into detailed taxonomic profiles by identifying target genomes and estimating their relative abundance. Use when user asks to construct genomic libraries, align reads to reference genomes while filtering host sequences, resolve ambiguous read mappings for strain identification, or generate taxonomic reports.
homepage: https://github.com/PathoScope/PathoScope
---

# pathoscope

## Overview
PathoScope 2.0 is a modular framework for sequencing-based metagenomic profiling. It transforms raw, unassembled sequencing reads into a detailed taxonomic profile by identifying which target genomes are present and estimating their relative abundance. The tool is specifically designed to handle the ambiguity of reads that map to multiple genomes, providing high-resolution strain attribution that distinguishes it from general metagenomic classifiers.

## Core Workflow and CLI Patterns

PathoScope operates through several core modules. The standard execution follows the sequence: LIB -> MAP -> ID -> REP.

### 1. PathoLib (LIB): Library Construction
Use this module to extract specific target or filter (host) genome libraries from a local copy of the NCBI nucleotide database.

*   **Basic Library Extraction:**
    ```bash
    python pathoscope.py LIB -genomeFile nt.fasta -taxonIds 10239 --subTax -outPrefix virus
    ```
    *   `-taxonIds`: The NCBI Taxonomy ID (e.g., 10239 for viruses).
    *   `--subTax`: Includes all descendant taxa in the taxonomy tree.
*   **Memory Management:** Searching the full `nt` database is memory-intensive (~6GB+ RAM). For repeated runs, it is more efficient to use a pre-indexed `nt_ti.fa` file where TaxIDs are already prepended to headers.

### 2. PathoMap (MAP): Read Alignment and Filtering
This module aligns reads to your target library and removes reads that match the "filter" (host) library. It typically uses Bowtie2 as the underlying aligner.

*   **Standard Mapping:**
    ```bash
    python pathoscope.py MAP -1 reads_1.fastq -2 reads_2.fastq -target target_ref.fasta -filter host_ref.fasta -outDir output_map
    ```
*   **Key Tip:** Ensure your reference fasta files are indexed by the aligner (e.g., `bowtie2-build`) before running PathoMap if the module does not trigger it automatically.

### 3. PathoID (ID): Strain Identification
This is the statistical core of PathoScope. It applies a Bayesian reassignment algorithm to resolve reads that map to multiple reference genomes.

*   **Executing Identification:**
    ```bash
    python pathoscope.py ID -i input_alignment.sam -outDir output_id
    ```
*   **Expert Tip:** PathoID is critical when your sample contains closely related strains where reads are not unique to a single genome.

### 4. PathoReport (REP): Result Generation
Generates the final human-readable and machine-parseable reports.

*   **Generating Reports:**
    ```bash
    python pathoscope.py REP -i pathoid_output.xml -outPrefix sample_report
    ```
*   **Outputs:**
    *   `.tsv`: A summary table containing read counts and proportions for each identified genome.
    *   `.xml`: A detailed report including coverage information and read assignments.

## Expert Tips and Best Practices
*   **Pre-processing:** Always run `PathoQC` or a similar tool (like Fastp or Trimmomatic) before PathoMap to remove low-quality bases and adapter sequences, as high error rates can interfere with accurate strain attribution.
*   **Database Setup:** For high-throughput environments, set up a local MySQL database to store taxonomy information. This significantly speeds up the `PathoLib` module compared to remote NCBI queries.
*   **PhiX Filtering:** Always include the PhiX174 genome in your filter library to remove common Illumina sequencing controls.
*   **Strain Resolution:** If PathoScope reports multiple strains of the same species, check the "Unique Reads" column in the TSV report. High total counts but zero unique reads for a strain may indicate a false positive driven by shared genomic regions.



## Subcommands

| Command | Description |
|---------|-------------|
| pathoscope LIB | PathoScope LIB module for creating reference libraries and mapping gi to taxonomy ids. |
| pathoscope MAP | PathoScope MAP module for mapping reads to target and filter reference genomes using Bowtie2 |
| pathoscope REP | PathoScope REP module for generating reports from SAM alignment files, including optional MySQL database integration for taxonomy mapping. |
| pathoscope id | PathoScope ID: Identification and quantification of microbes from sequencing data |

## Reference documentation
- [PathoScope Wiki Home](./references/github_com_PathoScope_PathoScope_wiki.md)
- [Building Library Module](./references/github_com_PathoScope_PathoScope_wiki_Building-Library.md)
- [PathoID Module](./references/github_com_PathoScope_PathoScope_wiki_PathoID.md)
- [PathoMap Module](./references/github_com_PathoScope_PathoScope_wiki_PathoMap.md)
- [PathoReport Module](./references/github_com_PathoScope_PathoScope_wiki_PathoReport.md)