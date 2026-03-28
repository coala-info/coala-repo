---
name: gapseq
description: gapseq automates the reconstruction of bacterial metabolic models by predicting pathways, transporters, and performing gap-filling. Use when user asks to reconstruct metabolic networks from protein sequences, perform growth simulations on specific media, or execute the comprehensive doall workflow.
homepage: https://github.com/jotech/gapseq
---


# gapseq

## Overview

gapseq is a specialized toolset designed for the automated reconstruction of bacterial metabolic models. It streamlines the process of moving from protein sequences to functional metabolic networks by combining pathway prediction, transporter identification, and multi-step gap-filling. Use this skill to guide the execution of the comprehensive `doall` workflow or to perform targeted metabolic curation and growth simulations on defined media.

## Core CLI Usage

The primary interface for gapseq is the `gapseq` command. If installed via Bioconda, the command is available directly in your PATH. If installed via source, use `./gapseq`.

### The "doall" Workflow
The most common use case is the `doall` command, which executes the entire pipeline: pathway prediction, transporter inference, draft model construction, and gap-filling.

*   **Standard Reconstruction:**
    `gapseq doall input_genome.faa`

*   **Reconstruction with Defined Growth Medium:**
    To ensure the resulting model can simulate growth on a specific medium, provide a medium file (CSV format).
    `gapseq doall -m dat/media/MM_glu.csv input_genome.faa`

### Environment and Validation
Before running large-scale reconstructions, verify the local installation and database integrity.

*   **Quick Test:** Checks if the full model can be constructed locally.
    `gapseq test`

*   **Comprehensive Test:** Performs a full reconstruction of *E. coli*, including all substeps. This typically takes 5-10 minutes.
    `gapseq test-long`

## Expert Tips and Best Practices

### Media Selection
gapseq includes several pre-defined media files located in the `dat/media/` directory. 
*   Use `MM_glu.csv` for minimal media with glucose.
*   Use `gut.csv` for simulations involving the human gut microbiome (includes specialized components like Nickel for archaea).
*   If a model fails to grow during gap-filling, verify that the medium file contains all essential nutrients for the target organism's biomass requirements.

### Modular Execution
While `doall` is convenient, gapseq is modular. You can run specific steps if the `doall` process fails or requires manual intervention:
*   **find-transporter**: Specifically for membrane transport protein inference.
*   **adapt**: Used for adjusting the model to specific growth conditions or Biolog-like test data.

### Input Requirements
*   Input files should be protein sequences in FASTA format (`.faa` or `.faa.gz`).
*   If working with multiple genomes (pan-genome analysis), consider using the `pan-Draft` extension if available in your environment.

### Troubleshooting
*   **Solver Loops**: If the gap-filling process enters an infinite loop, check the consistency of the draft medium and the biomass definition.
*   **RDS Files**: gapseq frequently uses `.RDS` files (R data objects) for internal storage. These can be loaded into R for deeper manual curation using the `sybil` or `COBRA` packages.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/share/gapseq/src/pan-draft.R | Reconstructs a pan-Model from a list of gapseq-Draft-Models. |
| /usr/local/share/gapseq/src/predict_medium.R | Predicts the medium for a given GapSeq model. |
| /usr/local/share/gapseq/src/transporter.sh | Finds transporter proteins in a FASTA file. |
| adapt.R | Extends a gapseq model by adding or removing reactions/pathways, or by enforcing growth/non-growth conditions. |
| gapseq | Informed prediction and analysis of bacterial metabolic pathways and genome-scale networks |
| gapseq_find.sh | Search for pathways or subsystems using keywords or EC numbers in a FASTA file. |
| gf.suite.R | Gapfilling suite for metabolic models. |

## Reference documentation

- [gapseq Main Repository](./references/github_com_jotech_gapseq.md)
- [Version and Test Mode Details](./references/github_com_jotech_gapseq_tags.md)
- [Community Discussions on Sub-commands](./references/github_com_jotech_gapseq_discussions.md)