---
name: mi-pimento
description: mi-pimento is a toolkit for inferring and recovering missing primer information from sequencing reads using known libraries or base-conservation analysis. Use when user asks to recover missing primers, match reads against standard primer libraries, predict primer cutoffs, or verify the presence of primers in FASTQ files.
homepage: https://github.com/EBI-Metagenomics/PIMENTO
---


# mi-pimento

## Overview

mi-pimento (PIMENTO) is a specialized toolkit for primer inference. It helps researchers recover missing primer information from sequencing reads using two primary strategies: matching against a library of known standard primers using fuzzy regex, or predicting primer cutoffs by analyzing base-conservation patterns at the start and end of reads. This tool is essential for processing metabarcoding data where the specific amplification primers are unknown or unrecorded.

## Installation

Install the toolkit via Conda or Pip:

```bash
# Bioconda (Recommended)
conda install -c bioconda mi-pimento

# PyPI
pip install mi-pimento
```

## Core Workflows

### 1. Standard Primer Matching
Use this when you suspect the reads contain common primers (e.g., 16S, 18S, ITS).

```bash
pimento std -i <input.fastq.gz> -o <output_prefix> --merged
```

*   **Key Argument**: Use `--merged` for single-end reads or merged paired-end reads. This allows the tool to correctly identify reverse-orientation primers.
*   **Custom Libraries**: Use `-p <directory>` to point to a custom FASTA library. Ensure primer names end in `F` for forward or `R` for reverse (e.g., `>341F`).

### 2. Automated Primer Inference (Cutoff Strategy)
Use this when primers are unknown or non-standard. It analyzes base conservation to find where the biological sequence begins.

```bash
pimento auto -i <input.fastq.gz> -st FR -o <output_prefix>
```

*   **Strand Selection (`-st`)**: Choose `F` (forward), `R` (reverse), or `FR` (both).
*   **Process**: The `auto` command is a wrapper that sequentially runs `gen_bcv` (base-conservation vector), `find_cutoffs`, and `choose_primer_cutoff`.

### 3. Primer Presence Verification
Use this as a quick check to see if primers are still present in the file before running full analysis.

```bash
pimento are_there_primers -i <input.fastq.gz> -o <output_prefix>
```

## Expert Tips and Best Practices

*   **Paired-End Handling**: PIMENTO processes one end at a time. For unmerged paired-end reads, run the tool separately on the R1 and R2 files.
*   **Fuzzy Matching**: The standard strategy (`std`) allows for minor sequencing errors (up to 2 mismatches) in the primer sequence to ensure robust detection in real-world data.
*   **Output Interpretation**: 
    *   `*_std_primers.fasta`: Contains the best-matching primer sequences found.
    *   `*_general_primer_out.txt`: A simple boolean check (1 or 0) for primer presence on forward and reverse strands.
*   **Performance**: For very large FASTQ files, the tool uses a `MAX_READS` threshold to speed up the standard strategy without sacrificing accuracy in primer identification.

## Reference documentation
- [PIMENTO GitHub Repository](./references/github_com_EBI-Metagenomics_PIMENTO.md)
- [mi-pimento Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mi-pimento_overview.md)