---
name: haystac
description: haystac is a Bayesian-based pipeline for identifying species and estimating their abundance within complex sequencing datasets. Use when user asks to build reference databases from NCBI, preprocess sequencing reads, or perform species identification and damage pattern analysis for ancient DNA.
homepage: https://github.com/antonisdim/haystac
metadata:
  docker_image: "quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0"
---

# haystac

## Overview

haystac provides a robust, Bayesian-based pipeline for identifying species within complex sequencing datasets. Unlike simple alignment tools, it evaluates the statistical probability that a specific taxon is present given the available reads and a reference database. The tool is modular, covering the entire workflow from automated database construction via NCBI queries to sample preprocessing (including adapter trimming and read collapsing) and final abundance estimation. It is highly optimized for ancient DNA research, offering integrated damage pattern analysis to authenticate ancient sequences.

## Core Workflow

### 1. Database Construction
Build a specialized database of reference genomes. Genus-specific databases are recommended for faster, hypothesis-driven analyses.

*   **Build from NCBI Query**: Use a standard NCBI Nucleotide search string.
    ```bash
    haystac database --mode build --query '"Yersinia"[Organism] AND "complete genome"[All Fields]' --output yersinia_db
    ```
*   **Build from RefSeq**: Use representative prokaryotic species.
    ```bash
    haystac database --mode build --refseq-rep prokaryote_rep --output refseq_db
    ```

### 2. Sample Preparation
Prepare raw sequencing data. haystac automatically identifies and removes adapters.

*   **From SRA**: Download and process directly using an accession code.
    ```bash
    haystac sample --sra ERR1018966 --output ERR1018966
    ```
*   **From Local FASTQ**: Support for single-end or paired-end reads. Use `--collapse True` for ancient DNA to merge overlapping mate pairs.
    ```bash
    haystac sample --fastq-r1 sample_R1.fq.gz --fastq-r2 sample_R2.fq.gz --collapse True --output sample_dir
    ```

### 3. Species Analysis
Calculate the mean posterior abundance of species in the sample against the database.

*   **Standard Abundance Run**:
    ```bash
    haystac analyse --mode abundances --database yersinia_db --sample ERR1018966 --output analysis_results
    ```
*   **With Damage Analysis**: Essential for aDNA to verify the characteristic deamination patterns of ancient molecules.
    ```bash
    haystac analyse --mode abundances --database yersinia_db --sample ERR1018966 --output analysis_results --mapdamage True
    ```

## Best Practices and Tips

*   **Installation**: Always use `mamba` instead of `conda` for installation to ensure faster dependency resolution and better runtime performance.
*   **Database Specificity**: For prokaryotes, building genus-specific databases is significantly faster and often more accurate than searching against the entire RefSeq database.
*   **Interpreting Results**: The primary output is the `*_posterior_abundance.tsv` file located in the `probabilities/` sub-folder. 
    *   **Uniquely Assigned Reads**: Look for high counts of reads assigned uniquely to your target taxon.
    *   **Chi-squared Test**: Check the chi-squared values in the output; a low value indicates reads are spread evenly across the genome, reducing the likelihood of false positives from conserved regions.
*   **Memory Management**: Building large databases (like the full RefSeq representative set) requires significant computational resources and is not recommended for standard laptops.



## Subcommands

| Command | Description |
|---------|-------------|
| haysac_config | Configuration options |
| haystac | The haystac commands are: |
| haystac analyse | Analyse a sample against a database |
| haystac database | Build a database of target species |
| haystac_sample | Prepare a sample for analysis |

## Reference documentation

- [HAYSTAC README](./references/github_com_antonisdim_haystac_blob_master_README.md)
- [Installation and Setup](./references/github_com_antonisdim_haystac_blob_master_setup.py.md)