---
name: rgi_conda_dev
description: The Resistance Gene Identifier predicts the antibiotic resistome from molecular data by comparing sequences against the Comprehensive Antibiotic Resistance Database. Use when user asks to identify antibiotic resistance genes, analyze genomes or assemblies for resistance markers, map raw sequencing reads to resistance references, or predict pathogen-of-origin using k-mers.
homepage: https://card.mcmaster.ca
metadata:
  docker_image: "quay.io/biocontainers/rgi_conda_dev:3.1.2--py27_1"
---

# rgi_conda_dev

## Overview
The Resistance Gene Identifier (RGI) is the primary bioinformatic engine for the Comprehensive Antibiotic Resistance Database (CARD). It provides a standardized method for predicting the "resistome" (the collection of all antibiotic resistance genes) from molecular data. The tool utilizes curated homology cut-offs, SNP maps, and various detection models (protein homolog, protein variant, and rRNA mutation models) to categorize hits based on the degree of certainty.

## Tool Modules and Input Requirements
RGI is organized into three primary functional modules based on the nature of the input data:

*   **RGI Main**: Used for protein sequences, genomes, or genome assemblies.
    *   **Input**: FASTA format.
    *   **Method**: Homology and SNP-based prediction.
*   **RGI BWT**: Used for short sequencing reads.
    *   **Input**: FASTQ format.
    *   **Method**: Read mapping against CARD reference sequences (typically using KMA).
*   **RGI Kmer**: Used for rapid identification and predicting the pathogen-of-origin or plasmid-association.
    *   **Input**: Short reads or complete alleles.
    *   **Method**: K-mer based query against CARD reference sets.

## Common CLI Patterns and Best Practices

### 1. Database Management
Before running analyses, ensure the local CARD database is initialized and up to date.
*   Use `rgi load` to import the CARD JSON data and reference sequences.
*   Regularly synchronize with the latest monthly releases from CARD to ensure detection models include the most recent AMR gene discoveries (e.g., new beta-lactamases or M. tuberculosis mutations).

### 2. Running RGI Main (Assemblies/Genomes)
When analyzing contigs or complete genomes, use the `main` command.
*   **Standard Pattern**: `rgi main --input_sequence [FILE.fasta] --output_file [BASENAME] [OPTIONS]`
*   **Data Type**: Specify `--input_type` (contig, protein, or genome) to optimize the underlying prediction models.
*   **Alignment Tool**: RGI typically defaults to BLAST or DIAMOND; DIAMOND is recommended for large datasets or metagenomic contigs to improve speed.

### 3. Running RGI BWT (Raw Reads)
For metagenomic or WGS raw reads where assembly is not performed, use the `bwt` module.
*   **Standard Pattern**: `rgi bwt --read_one [R1.fastq] --read_two [R2.fastq] --output_file [BASENAME]`
*   **Mapping**: Ensure the mapping tool (e.g., KMA) is in the system PATH.

### 4. Interpreting Hit Criteria
RGI categorizes results into three tiers of confidence. Understanding these is critical for reporting:
*   **Perfect**: 100% identity over the entire length of the reference sequence. Use this for clinical diagnostics or high-confidence identification of known alleles.
*   **Strict**: Hits that fall within the curated bitscore cut-offs of the AMR detection models. These are highly likely to be functional ARGs.
*   **Loose**: Hits that fall outside the strict cut-offs but show some homology. Use these for discovery of novel resistance genes, but treat with caution as they may include false positives.

### 5. Expert Tips
*   **Metagenomics**: For complex environmental samples, use `rgi bwt` or `rgi kmer` to capture low-abundance resistance determinants that might fail to assemble into contigs.
*   **Pathogen Context**: Use the `kmer` module to determine if a detected ARG is likely located on a plasmid or associated with a specific pathogen of origin.
*   **Fungal AMR**: For fungal datasets, refer to the FungAMR data within CARD, though note that integration with the standard RGI workflow is ongoing.



## Subcommands

| Command | Description |
|---------|-------------|
| rgi | Resistance Gene Identifier - Version 3.1.2 |
| rgi | Resistance Gene Identifier - Version 3.1.2 |
| rgi | Resistance Gene Identifier - Version 3.1.2 |
| rgi | Resistance Gene Identifier - Version 3.1.2 |

## Reference documentation
- [Analyze - RGI Module Descriptions](./references/card_mcmaster_ca_analyze.md)
- [Download - Database and Software Updates](./references/card_mcmaster_ca_download.md)
- [About - CARD and RGI Overview](./references/card_mcmaster_ca_about.md)
- [Home - Database Statistics and Capabilities](./references/card_mcmaster_ca_home.md)