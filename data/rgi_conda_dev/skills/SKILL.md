---
name: rgi_conda_dev
description: The Resistance Gene Identifier predicts antibiotic resistance genes from genomic and metagenomic data using the Comprehensive Antibiotic Resistance Database. Use when user asks to identify resistomes in assemblies, map raw reads to resistance genes, or predict the pathogen origin of resistance alleles.
homepage: https://card.mcmaster.ca
---


# rgi_conda_dev

## Overview

The Resistance Gene Identifier (RGI) is the primary bioinformatic tool for the Comprehensive Antibiotic Resistance Database (CARD). It provides a standardized method for predicting the "resistome"—the collection of all antibiotic resistance genes—within a given sample. RGI uses curated homology models and SNP maps to identify genes associated with Antibiotic Resistance Ontology (ARO) terms. It is particularly effective for first-pass detection in new pathogens, genomes, and metagenomic assemblies.

## Installation and Setup

Install RGI via the bioconda channel:
```bash
conda install bioconda::rgi
```

Before running analyses, ensure the local CARD database is synchronized with the latest monthly release:
```bash
rgi load --card_json /path/to/card.json --local
```

## Core CLI Usage Patterns

### 1. Analyzing Assemblies or Proteins (RGI Main)
Use `rgi main` for FASTA inputs (contigs, genomes, or proteomes).

*   **Standard Contig Analysis:**
    ```bash
    rgi main --input_sequence input.fasta --output_file results_output --input_type contig --local
    ```
*   **Protein Sequence Analysis:**
    ```bash
    rgi main --input_sequence proteins.faa --output_file results_output --input_type protein --local
    ```

### 2. Analyzing Raw Reads (RGI BWT)
Use `rgi bwt` for FASTQ inputs to map short reads directly to CARD reference sequences using KMA (default).

*   **Paired-end Reads:**
    ```bash
    rgi bwt --read_one R1.fastq --read_two R2.fastq --output_file mapping_results
    ```

### 3. Pathogen and Plasmid Prediction (RGI Kmer)
Use `rgi kmer_query` to predict if a resistance gene is likely chromosomal or plasmid-borne, or to identify its pathogen-of-origin.

*   **K-mer Query:**
    ```bash
    rgi kmer_query --input_sequence alleles.fasta --output_file kmer_results
    ```

## Expert Tips and Best Practices

*   **Understand the Paradigms:**
    *   **Perfect:** Detects 100% identical matches to curated reference sequences. Use this for clinical surveillance of known, high-risk alleles.
    *   **Strict:** Detects previously unknown variants of known AMR genes using curated similarity bitscore cut-offs. Use this for discovering functional homologs and emerging resistance.
*   **Input Types:** Always specify `--input_type` correctly. Using `contig` on a file containing only open reading frames (ORFs) will result in sub-optimal gene prediction.
*   **Metagenomics:** For complex metagenomic samples, `rgi bwt` is preferred over assembly-based `rgi main` as it captures low-abundance resistance genes that may fail to assemble into contigs.
*   **Data Interpretation:** RGI results include ARO accessions. Use these to link hits to specific drug classes (e.g., carbapenems, fluoroquinolones) and resistance mechanisms (e.g., antibiotic inactivation, target alteration).

## Reference documentation
- [RGI Overview](./references/anaconda_org_channels_bioconda_packages_rgi_overview.md)
- [CARD Analysis Tools](./references/card_mcmaster_ca_analyze.md)
- [CARD Download and Software Info](./references/card_mcmaster_ca_download.md)
- [Resistomes and Prevalence](./references/card_mcmaster_ca_prevalence.md)