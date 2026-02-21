---
name: rnavirhost
description: rnavirhost is a specialized classification framework designed to predict RNA virus hosts based solely on viral genomes.
homepage: https://github.com/GreyGuoweiChen/VirHost.git
---

# rnavirhost

## Overview
rnavirhost is a specialized classification framework designed to predict RNA virus hosts based solely on viral genomes. It operates using a two-layer hierarchical model: Layer 1 classifies viruses into broad groups (Chordata, Invertebrate, Viridiplantae, Fungi, Bacteria), while Layer 2 provides higher resolution for Chordata (class and order levels). The tool is particularly useful for analyzing "viral dark matter" from metagenomic sequencing where host information is unknown.

## Installation
The recommended method is via conda/mamba:
```bash
conda install -c bioconda rnavirhost
```

## Core Workflow
The tool requires viral taxonomic information (specifically the virus order) to function. The process typically involves two steps:

### 1. Generate Taxonomic Information
If you do not have a `.csv` file mapping sequence IDs to virus orders, use the built-in alignment-based classifier:
```bash
rnavirhost classify_order -i input_sequences.fasta -o RVH_taxa.csv
```

### 2. Predict Hosts
Run the prediction engine using the fasta file and the taxonomic mapping:
```bash
rnavirhost predict -i input_sequences.fasta --taxa RVH_taxa.csv -o output_directory
```

## Input Requirements
- **Fasta File**: Complete RNA viral genomes.
- **Taxa CSV**: A two-column file (no header required, but accepted) where:
  - Column 1: Sequence Accession/ID (must match Fasta headers).
  - Column 2: Virus Order (e.g., *Ortervirales*, *Norzivirales*).

## Interpreting Results
The output file contains an `evidence` column which is critical for assessing prediction reliability:
- `pred_high_confidence`: ML model prediction exceeding the score cutoff.
- `pred_low_confidence`: ML model prediction below the score cutoff.
- `assign`: Host assigned based on known host ranges for that virus order (no ML prediction performed).
- `BLASTn`: Used for non-coding sequences where protein-level encoding failed; host is assigned via best alignment hit.
- `unclassified`: Resulted when no order information was provided or found.

## Expert Tips
- **Protein Translation**: rnavirhost uses Prodigal to translate sequences into proteins for its ML features. If a sequence is non-coding, the tool defaults to a BLASTn strategy.
- **Custom Taxa**: If you have high-quality taxonomic assignments from other tools (like Kraken2 or Kaiju), you can manually format them into the required CSV structure to bypass `classify_order`.
- **Chordata Focus**: Note that the second layer of classification (Order/Class level) is currently optimized specifically for the Chordata subtree.

## Reference documentation
- [RNAVirHost GitHub Repository](./references/github_com_GreyGuoweiChen_VirHost.md)