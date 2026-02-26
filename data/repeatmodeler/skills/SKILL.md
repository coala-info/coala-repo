---
name: repeatmodeler
description: RepeatModeler is an automated pipeline for the discovery and de novo identification of repetitive element families in genomic sequences. Use when user asks to identify repetitive elements, generate consensus sequences for repeat families, or build a custom repeat library for a new genome assembly.
homepage: https://www.repeatmasker.org/RepeatModeler
---


# repeatmodeler

## Overview

RepeatModeler is a comprehensive pipeline for the automated discovery of repetitive elements in genomic data. It integrates multiple computational methods—including RECON, RepeatScout, and LTRharvest—to identify, cluster, and generate consensus sequences for repeat families. This tool is essential for researchers working with non-model organisms or newly assembled genomes where a curated repeat library (like RepBase or Dfam) is unavailable or incomplete.

## Core Workflow

The RepeatModeler workflow consists of two primary stages: database preparation and the modeling run.

### 1. Database Preparation
Before running the identification pipeline, you must format your genomic FASTA file into a RepeatModeler-compatible database.

```bash
BuildDatabase -name <db_name> <input_genome.fasta>
```
*   **Tip:** Use a descriptive name for `<db_name>` as all output files will use this prefix.

### 2. Running the Pipeline
Execute the main modeling pipeline using the database created in the previous step.

```bash
RepeatModeler -database <db_name> -threads <number> [options]
```

**Key Parameters:**
*   `-threads`: Highly recommended for large genomes; RepeatModeler is computationally intensive.
*   `-LTRStruct`: Enables the LTRharvest/LTR_retriever pipeline to specifically identify Long Terminal Repeat retrotransposons.
*   `-recoverDir <dir>`: Use this to resume a run that was interrupted.

## Output Interpretation

Upon completion, the tool generates a directory named `RM_[PID].[DATE]`. The most critical output files are:

*   **consensi.fa**: The final library of identified repeat consensus sequences.
*   **consensi.fa.classified**: The consensus sequences with taxonomic classifications (e.g., DNA/TcMar-Mariner, LTR/Copia).
*   **consensi.fa.stk**: A Stockholm format file containing the multiple sequence alignments used to derive the consensuses.

## Expert Tips & Best Practices

*   **Memory Management:** RepeatModeler can be memory-hungry. Ensure your environment has at least 4GB of RAM per thread allocated.
*   **Genome Masking:** The output `consensi.fa.classified` should be used as the input library (`-lib`) for **RepeatMasker** to perform the actual masking of your genome.
*   **Sensitivity vs. Speed:** For very large genomes (>3Gb), consider running on a subset of the genome or increasing threads significantly, as the RECON and RepeatScout phases scale non-linearly with genome size.
*   **Resuming Failed Runs:** If a run fails due to time limits on a cluster, look for the `RM_...` directory and use the `-recoverDir` flag to avoid starting from scratch.

## Reference documentation

- [RepeatModeler Overview](./references/anaconda_org_channels_bioconda_packages_repeatmodeler_overview.md)