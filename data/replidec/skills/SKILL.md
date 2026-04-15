---
name: replidec
description: Replidec predicts the replication cycle of bacteriophages by classifying them as virulent, temperate, or chronic using a Bayesian classifier and homology searches. Use when user asks to determine phage lifestyles, analyze metagenomic viral contigs, or identify temperate and chronic viruses from genomic or protein sequences.
homepage: https://github.com/deng-lab/Replidec
metadata:
  docker_image: "quay.io/biocontainers/replidec:0.3.5--pyhdfd78af_0"
---

# replidec

## Overview

Replidec (Replication Cycle Decipher for Phages) is a specialized bioinformatics tool designed to predict the lifestyle of bacteriophages. It utilizes a Bayesian classifier combined with homology searches against custom databases to categorize phages into three primary replication cycles: Virulent, Temperate, or Chronic. The tool is particularly useful for researchers working with isolated phage genomes or metagenomic viral contigs who need to understand the ecological role and infection strategy of identified viruses.

## Execution Modes

The `-p` (program) parameter is mandatory and determines how input files are processed. Choosing the correct mode is critical for accurate results:

- **multiSeqEachAsOne**: Use this for metagenomic assemblies or multi-fasta files where **each individual sequence** represents a different virus.
- **multiSeqAsOne**: Use this when you have multiple files or sequences that all belong to **one single virus** (e.g., a fragmented assembly of one isolate).
- **batch**: Use this when you already have **protein files (.faa)** rather than nucleotide sequences.

## Common CLI Patterns

### Analyzing Metagenomic Contigs
To treat every sequence in a fasta file as an independent virus:
```bash
Replidec -p multiSeqEachAsOne -i input_contigs.fasta -w output_dir -t 8
```

### Analyzing a Single Fragmented Genome
Requires a tab-separated index file where the first column is the sample name and the second is the path to the sequence file(s):
```bash
Replidec -p multiSeqAsOne -i genome_index.txt -w output_dir
```

### Analyzing Protein Sequences (Batch Mode)
Requires a tab-separated list where the first column is the sample name and the second is the path to the .faa file:
```bash
Replidec -p batch -i protein_list.txt -w output_dir
```

## Database and Parameter Tuning

- **Automatic Setup**: Replidec downloads its required databases automatically upon first run.
- **Redownloading**: If the database becomes corrupted or needs an update, use the `-d` flag. Note that the old database will be moved to a `discarded_db` folder in your working directory.
- **Sensitivity Control**: You can fine-tune the homology search criteria for different engines:
    - `-c` / `-H`: HMMER criteria and parameters (Integrase/Excisionase detection).
    - `-m` / `-M`: MMseqs2 criteria and parameters (Custom database mapping).
    - `-b` / `-B`: BLASTP criteria and parameters.

## Interpreting Results

The primary output is `BC_predict.summary` within the working directory. Key columns include:

- **pfam_label**: Based on the detection of Integrase or Excisionase.
- **bc_label**: The result of the Bayesian classifier (probability of temperate vs. virulent).
- **final_label**: The definitive prediction. 
    - **Temperate**: Both Pfam and Bayes labels are Temperate.
    - **Chronic**: Innovirus marker genes are detected.
    - **Virulent**: Default if other criteria for Temperate or Chronic are not met.

## Reference documentation
- [Replidec Overview](./references/anaconda_org_channels_bioconda_packages_replidec_overview.md)
- [Replidec GitHub Documentation](./references/github_com_deng-lab_Replidec.md)