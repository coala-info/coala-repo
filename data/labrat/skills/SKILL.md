---
name: labrat
description: LABRAT analyzes alternative 3' end usage in transcriptomic data by quantifying transcript abundances to calculate a psi value for each gene. Use when user asks to quantify alternative polyadenylation, analyze 3' UTR shifts, or calculate psi values from bulk or single-cell RNA-seq data.
homepage: https://github.com/TaliaferroLab/LABRAT
---


# labrat

## Overview

LABRAT (Lightweight Alignment-Based Reckoning of Alternative Three-prime ends) is a specialized tool for analyzing alternative 3' end usage in transcriptomic data. Unlike traditional methods that rely on standard read counting, LABRAT utilizes the kmer-based quasi-mapping of `salmon` to accurately quantify transcript abundances even when 3' UTR sequences overlap significantly. It produces a "psi" ($\psi$) value for each gene, where 0 represents exclusive usage of the most proximal APA site and 1 represents exclusive usage of the most distal site.

## Core Workflow

### 1. Environment and Dependencies
Ensure the environment is correctly configured. LABRAT relies on specific versions of bioinformatics tools.
- Use `conda` to install the environment: `conda install -c bioconda labrat`.
- Note: Documentation suggests `salmon` versions < 1.0.0 for maximum compatibility with the indexing strategy, though newer versions may be supported in updated releases.

### 2. Annotation and Indexing
LABRAT requires a genome annotation (GFF/GTF) to define "terminal fragments" (the last two exons of a transcript).
- Provide a high-quality GFF3 or GTF file.
- The tool will automatically index the GFF using `gffutils` to create a `.db` file.
- Use species-specific scripts if working with model organisms like Zebrafish (`LABRAT_danRer.py`), Drosophila (`LABRAT_dm6annotation.py`), or Rat (`LABRAT_rn6annotation.py`).

### 3. Quantifying APA with LABRAT.py
Run the primary script to process bulk RNA-seq data.
- Input: RNA-seq FASTQ files and a reference genome/transcriptome.
- Output: A table of $\psi$ values and statistical comparisons between conditions.
- Use the `--gff` flag to specify your annotation and `--fasta` for the genomic sequence.

### 4. Single-Cell Analysis
For single-cell data, use `LABRATsc.py`.
- This version is optimized for the sparsity of single-cell libraries.
- It often integrates with `alevin` (Salmon's single-cell processing tool) output.

## Best Practices and Tips

- **Terminal Fragment Length**: LABRAT filters out transcripts where the terminal fragment (last two exons) is shorter than 200 nucleotides. Ensure your annotation includes full-length 3' UTRs.
- **Protein Coding Focus**: By default, the tool focuses on protein-coding genes. If analyzing non-coding RNAs, ensure the `gene_type` or `biotype` attributes in your GFF match the expected "protein_coding" string or modify the filter logic in the script.
- **Interpreting Psi ($\psi$)**:
    - **Increase in $\psi$**: Indicates a shift toward **distal** (longer) 3' UTRs.
    - **Decrease in $\psi$**: Indicates a shift toward **proximal** (shorter) 3' UTRs.
- **Replicates**: Always use experimental replicates. LABRAT uses statistical models (like linear regression or Chi-squared tests depending on the specific script version) to identify significant APA shifts, which require variance information from replicates.
- **Salmon Indexing**: When creating the Salmon index, ensure you are using the transcriptome generated or expected by LABRAT to maintain the mapping between kmers and terminal fragments.



## Subcommands

| Command | Description |
|---------|-------------|
| LABRAT.py | LABRAT.py |
| LABRAT_danRer.py | A Python script for analyzing RNA sequencing data, specifically focusing on transcript quantification and differential splicing analysis. |
| LABRAT_dm6annotation.py | LABRAT_dm6annotation.py |
| LABRAT_rn6annotation.py | LABRAT_rn6annotation.py |
| LABRATsc.py | How to perform tests? Either compare psi values of individual cells or subsample cells from clusters. |

## Reference documentation
- [LABRAT Main README](./references/github_com_TaliaferroLab_LABRAT_blob_master_README.md)
- [Bulk RNA-seq Script (LABRAT.py)](./references/github_com_TaliaferroLab_LABRAT_blob_master_LABRAT.py.md)
- [Single-Cell Script (LABRATsc.py)](./references/github_com_TaliaferroLab_LABRAT_blob_master_LABRATsc.py.md)
- [Conda Environment Config](./references/github_com_TaliaferroLab_LABRAT_blob_master_labratenv.yml.md)