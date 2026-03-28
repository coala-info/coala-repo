---
name: rnavirhost
description: RNAVirHost is a machine learning tool that identifies the natural hosts of RNA viruses based on their genomic sequences. Use when user asks to predict viral host groups, classify virus orders, or identify host taxa for RNA viral genomes.
homepage: https://github.com/GreyGuoweiChen/VirHost.git
---


# rnavirhost

## Overview
RNAVirHost is a machine learning-based bioinformatics tool designed to identify the natural hosts of RNA viruses solely from their genomic sequences. It addresses the limitations of traditional alignment-based methods, which often struggle with the high genetic diversity of RNA viruses. The tool employs a two-layer hierarchical classification framework: Layer 1 categorizes viruses into five major host groups (Chordata, Invertebrate, Viridiplantae, Fungi, and Bacteria), while Layer 2 provides higher-resolution predictions (class and order level) for viruses infecting Chordata.

## Usage Guidelines

### 1. Taxonomic Pre-processing
RNAVirHost requires viral taxonomic information (specifically the virus order) to perform host predictions. If you do not have this information, use the built-in alignment-based classifier first.

**Command:**
```bash
rnavirhost classify_order -i input_sequences.fasta -o viral_taxa.csv
```

*   **Input:** FASTA file containing complete RNA viral genomes.
*   **Output:** A CSV file with two columns: sequence ID and the predicted virus order.

### 2. Host Prediction
Once the taxonomic information is ready, run the prediction engine.

**Command:**
```bash
rnavirhost predict -i input_sequences.fasta --taxa viral_taxa.csv -o results_dir
```

*   **--taxa:** The CSV file generated in the previous step (or a custom file following the same format).
*   **-o:** The directory where results will be stored (defaults to `RVH_result`).

### 3. Interpreting Results
The output table includes several key columns:
*   **pred|L1:** Kingdom/Phylum level host prediction.
*   **pred|L2:** Class/Order level host prediction (primarily for Chordata).
*   **evidence:** Indicates the method and confidence of the prediction.

**Evidence Labels:**
*   `pred_high_confidence`: ML model prediction exceeding the built-in score cutoff.
*   `pred_low_confidence`: ML model prediction below the score cutoff.
*   `assign`: Host assigned based on known host ranges for that virus order.
*   `BLASTn`: Host assigned via best alignment hit (used for non-coding sequences).
*   `unclassified`: No order information was provided or found.

## Best Practices and Tips
*   **Complete Genomes:** For the highest accuracy, provide complete or near-complete RNA viral genomes rather than short fragments.
*   **Non-coding Sequences:** If a sequence does not contain open reading frames (ORFs), RNAVirHost automatically falls back to a BLASTn-based alignment strategy to provide a "best guess" host.
*   **Custom Taxonomy:** If you have high-quality taxonomic assignments from other tools (like ICTV-based classifiers), you can manually create the `--taxa` CSV file to improve the downstream host prediction accuracy.
*   **Environment Management:** Ensure `prodigal` and `blast` are in your system PATH, as the tool relies on them for protein translation and homology searches.



## Subcommands

| Command | Description |
|---------|-------------|
| rnavirhost classify_order | Classifier query viruses at order level |
| rnavirhost predict | Predict hosts of the query viruses |

## Reference documentation
- [RNAVirHost GitHub Repository](./references/github_com_GreyGuoweiChen_VirHost_blob_main_README.md)
- [RNAVirHost Environment Setup](./references/github_com_GreyGuoweiChen_VirHost_blob_main_environment.yml.md)