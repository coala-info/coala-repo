---
name: infernal
description: Infernal is a suite of tools for searching and aligning RNA sequences using covariance models that capture both sequence and secondary structure consensus. Use when user asks to build or calibrate covariance models, search RNA models against sequence databases, scan sequences against the Rfam database, or create structure-informed multiple sequence alignments.
homepage: http://eddylab.org/infernal
---


# infernal

## Overview
Infernal (INFERence of RNA ALignment) is a specialized suite of tools for RNA homology search and alignment. While standard tools like HMMER focus on primary sequence consensus, Infernal utilizes Covariance Models (CMs) to capture both sequence and secondary structure consensus. This makes it significantly more sensitive for identifying functional RNAs (such as tRNAs, rRNAs, and riboswitches) where the structural fold is the primary evolutionary constraint. It is the underlying engine for the Rfam database.

## Core Workflow and CLI Patterns

### 1. Building and Calibrating Models
Before searching, you must build a model from a structural alignment and calibrate it to ensure statistically valid E-values.

*   **Build a CM**: Create a model from a multiple sequence alignment (Stockholm format) that includes secondary structure annotation.
    ```bash
    cmbuild my_model.cm my_alignment.stk
    ```
*   **Calibrate the CM**: This step is mandatory for `cmsearch` and `cmscan` to provide E-values. It is computationally intensive.
    ```bash
    cmcalibrate --cpu 4 my_model.cm
    ```
    *Tip: Use the `--cpu` flag to utilize multiple cores. For very large models (e.g., SSU rRNA), use `--split` and `--merge` to parallelize across a cluster.*

### 2. Searching Databases
*   **Search a CM against a sequence database**:
    ```bash
    cmsearch --tblout results.tbl my_model.cm genome.fasta
    ```
*   **Search a sequence against a CM database (e.g., Rfam)**:
    ```bash
    # First, press the CM database
    cmpress Rfam.cm
    # Then scan
    cmscan --tblout results.tbl Rfam.cm query.fasta
    ```

### 3. Aligning Sequences
*   **Align sequences to a CM**: Create a structural alignment of new sequences based on a representative model.
    ```bash
    cmalign my_model.cm new_sequences.fasta > new_alignment.stk
    ```

## Expert Tips and Best Practices

*   **Handling Fragments**: In version 1.1.5+, `cmbuild` handles fragmentary sequences better. If your input alignment contains fragments, ensure they are annotated correctly so terminal gaps are treated as missing data rather than deletions.
*   **Metagenomic/Truncated Searches**: When searching fragmented genomic data or metagenomes, use the `--anytrunc` option in `cmsearch` or `cmscan`. This improves sensitivity for hits that are truncated by the end of a sequence record.
*   **Output Parsing**: Always use `--tblout <file>` to generate a space-delimited tabular summary. It is much easier to parse programmatically than the default human-readable output.
*   **Performance Tuning**:
    *   The default CPU count in v1.1.5 is 4. Adjust this with `--cpu <n>` based on your hardware.
    *   If speed is more critical than sensitivity, consider using the HMM-only filters (enabled by default) or adjusting the acceleration pipeline heuristics (e.g., `--F1`, `--F2`, `--F3` thresholds).
*   **Defining Consensus**: Use `--consrf` with `cmbuild --hand` to define the Reference (RF) annotation as the consensus sequence, which leads to cleaner downstream alignments in `cmalign`.

## Reference documentation
- [Infernal README](./references/eddylab_org_infernal_README.md)
- [Infernal 1.1.5 Release Notes](./references/eddylab_org_infernal_RELEASE-1.1.5.md)
- [Infernal Overview](./references/eddylab_org_infernal.md)