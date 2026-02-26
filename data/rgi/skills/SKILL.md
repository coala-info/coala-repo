---
name: rgi
description: The Resistance Gene Identifier (RGI) predicts antibiotic resistance genes and mutations from genomic assemblies or raw sequencing reads using the Antibiotic Resistance Ontology. Use when user asks to identify AMR genes in contigs, map reads to resistance databases, or predict the pathogen-of-origin for resistance determinants.
homepage: https://card.mcmaster.ca
---


# rgi

## Overview
The Resistance Gene Identifier (RGI) is the primary computational tool for predicting antibiotic resistance genes and mutations from molecular data. It utilizes the Antibiotic Resistance Ontology (ARO) and curated detection models to identify "Perfect," "Strict," or "Loose" matches in genomic assemblies or raw sequencing reads. This skill assists in selecting the correct RGI module (main, bwt, or kmer) and configuring parameters for accurate AMR annotation.

## Core Modules and Usage

### 1. RGI Main (Genomes and Assemblies)
Use `rgi main` for protein sequences, contigs, or complete genome assemblies. It uses homology and SNP models to predict the resistome.

*   **Input**: FASTA file.
*   **Key Command**:
    ```bash
    rgi main --input_sequence /path/to/genome.fasta --output_file results_prefix --local --clean
    ```
*   **Alignment Tools**: Use `--alignment_tool diamond` for significantly faster processing compared to BLAST, especially for large datasets.
*   **Data Input Type**: Specify `--input_type contig` for assemblies or `--input_type protein` for amino acid sequences.

### 2. RGI BWT (Raw Reads)
Use `rgi bwt` for short sequencing reads (metagenomics or clinical isolates) to map reads directly against CARD reference sequences.

*   **Input**: FASTQ files (paired or single-end).
*   **Key Command**:
    ```bash
    rgi bwt --read_one forward.fastq --read_two reverse.fastq --output_file amr_reads --aligner kma
    ```
*   **Default Aligner**: KMA is the default and recommended aligner for read mapping in RGI.

### 3. RGI Kmer (Pathogen & Plasmid Prediction)
Use `rgi kmer_query` to predict the pathogen-of-origin or plasmid association for identified AMR genes.

*   **Purpose**: Distinguishing if a resistance gene is likely chromosomal or mobile (plasmid-borne).
*   **Key Command**:
    ```bash
    rgi kmer_query --input_sequence amr_genes.fasta --output_file kmer_results
    ```

## Best Practices and Interpretation

### Match Paradigms
*   **Perfect**: 100% identity over the entire length of the reference. Use for clinical confirmation of known alleles.
*   **Strict**: Detects previously unknown variants of known AMR genes using curated bitscore cut-offs. This is the standard for most research applications.
*   **Loose**: Lowers stringency to find distant homologs. Use only for discovery of highly divergent genes; expect high false-positive rates.

### Database Management
Always ensure the local CARD database is synchronized before analysis:
```bash
rgi load --card_json card.json --active_lib
```

### Output Analysis
*   **JSON**: The primary output format containing all metadata.
*   **TXT/TSV**: A tab-delimited summary of hits, including ARO Accession, Drug Class, and Resistance Mechanism.
*   **Heatmaps**: Use `rgi heatmap` to visualize results across multiple samples.

## Reference documentation
- [RGI Overview and Installation](./references/anaconda_org_channels_bioconda_packages_rgi_overview.md)
- [RGI Analysis Modules (Main, BWT, Kmer)](./references/card_mcmaster_ca_analyze.md)
- [CARD Database and ARO Information](./references/card_mcmaster_ca_about.md)
- [Resistome Prediction Paradigms](./references/card_mcmaster_ca_prevalence.md)