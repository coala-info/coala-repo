---
name: infernal
description: Infernal uses profile stochastic context-free grammars to identify and align RNA homologs by accounting for both sequence consensus and secondary structure. Use when user asks to build or calibrate covariance models, search sequence databases for RNA homologs, scan sequences against model libraries, or create structural RNA alignments.
homepage: http://eddylab.org/infernal
---


# infernal

## Overview
Infernal (INFERence of RNA ALignment) implements profile stochastic context-free grammars, known as covariance models, to identify RNA homologs. Unlike standard sequence profiles, Infernal accounts for both sequence consensus and secondary structure, making it significantly more sensitive for identifying non-coding RNAs where structure is more conserved than primary sequence. This skill provides the core command-line workflows for the Infernal suite.

## Core Workflow

### 1. Building and Calibrating Models
Before searching, you must build a model from a structural alignment and calibrate it to ensure statistically significant E-values.

*   **Build a CM**: Create a model from a Stockholm format alignment.
    ```bash
    cmbuild my_model.cm input_alignment.stk
    ```
    *Tip: Use `--consrf` with `--hand` if your alignment has RF (reference) annotation you wish to preserve as the model's consensus.*

*   **Calibrate the CM**: This step is **required** for `cmsearch` and `cmscan`. It fits exponential tails to the score distribution.
    ```bash
    cmcalibrate my_model.cm
    ```
    *Note: This is computationally intensive. Use `--forecast` first to estimate time, or `--memreq` to check RAM needs.*

### 2. Searching and Scanning
*   **Search a Database**: Search a sequence database (FASTA) using a single CM.
    ```bash
    cmsearch my_model.cm database.fa > results.txt
    ```
*   **Scan Sequences**: Search a single sequence against a library of CMs (e.g., Rfam).
    ```bash
    cmscan Rfam.cm query_sequence.fa > results.txt
    ```
    *Tip: Use `--tblout <file>` to get a concise, machine-readable tabular summary of hits.*

### 3. Alignment
*   **Align Sequences**: Align new sequences to an existing CM to create a structural alignment.
    ```bash
    cmalign my_model.cm new_sequences.fa > output.stk
    ```

## Expert Tips & Performance
*   **Parallelization**: Most tools support multi-threading. Use `--cpu <n>` to specify the number of cores. The default is 4 in version 1.1.5.
*   **Memory Management**: For very large models (like SSU rRNA), `cmcalibrate` can be memory-hungry. Use `--cpu 0` to force single-threaded mode if you run out of RAM, as memory scales with the number of worker threads.
*   **Truncated Hits**: If searching for fragments or in metagenomic data, use the `--anytrunc` option in `cmsearch` or `cmscan` to improve sensitivity for hits at sequence ends.
*   **Fragmentary Data**: In `cmbuild`, terminal gaps in sequences annotated as fragments are now treated as missing data rather than deletions, improving model parameters for partial sequences.



## Subcommands

| Command | Description |
|---------|-------------|
| cmbuild | Build covariance models from annotated RNA multiple sequence alignments |
| cmcalibrate | Fit exponential tails for covariance model E-value determination. Note: The provided text contains system error logs rather than help text; arguments are derived from standard tool documentation. |
| cmpress | prepare a covariance model database for cmscan |

## Reference documentation
- [Infernal README](./references/eddylab_org_infernal_README.md)
- [Infernal 1.1.5 Release Notes](./references/eddylab_org_infernal_RELEASE-1.1.5.md)
- [cmcalibrate Help and Optimization](./references/github_com_EddyRivasLab_infernal_wiki_cmcalibrate-help.md)
- [Multi-processor Scaling Guide](./references/github_com_EddyRivasLab_infernal_wiki_How-Infernal-Programs-Scale-On-Multiple-Processors.md)