---
name: rrmscorer
description: RRMScorer predicts the binding affinity between RNA Recognition Motifs and single-stranded RNA. Use when user asks to predict RRM-RNA binding scores or find best RNA binders for an RRM.
homepage: https://bio2byte.be/rrmscorer/
metadata:
  docker_image: "quay.io/biocontainers/rrmscorer:1.0.11--pyhdfd78af_0"
---

# rrmscorer

rrmscorer/SKILL.md
```yaml
name: rrmscorer
description: Predicts the likelihood of an RRM (RNA Recognition Motif) binding to single-stranded RNA (ssRNA). Use when analyzing RRM-RNA interactions, predicting binding affinity, or exploring potential RNA binders for a given RRM.
```
## Overview
RRMScorer is a command-line tool designed to predict the binding affinity between RNA Recognition Motifs (RRMs) and single-stranded RNA (ssRNA). It leverages a scoring system derived from analyzed interaction patterns in RRM-RNA complexes. This tool is useful for researchers investigating protein-RNA interactions, particularly those involving RRMs, by providing a quantitative measure of binding likelihood.

## Usage Instructions

RRMScorer can be used to calculate binding scores for specific RRM and RNA sequences, for a set of RRM sequences provided in a FASTA file, or to identify the best RNA binders for a given RRM.

### Core Functionality

The primary command-line interface for RRMScorer involves specifying the input sequences and the desired mode of operation.

#### 1. Predicting binding score for a specific RRM and RNA sequence:

```bash
rrmscorer score --rrm <rrm_sequence> --rna <rna_sequence>
```

*   `--rrm`: The amino acid sequence of the RRM.
*   `--rna`: The nucleotide sequence of the ssRNA.

#### 2. Predicting binding scores for a set of RRM sequences in a FASTA file:

```bash
rrmscorer score --rrm_fasta <path_to_rrm_fasta_file> --rna <rna_sequence>
```

*   `--rrm_fasta`: Path to a FASTA file containing multiple RRM sequences.
*   `--rna`: The nucleotide sequence of the ssRNA to test against each RRM.

#### 3. Exploring best RNA binders for a given RRM:

This mode allows you to provide a set of potential RNA binders and identify which ones are predicted to bind best with a given RRM.

```bash
rrmscorer best_binders --rrm <rrm_sequence> --rna_fasta <path_to_rna_fasta_file>
```

*   `--rrm`: The amino acid sequence of the RRM.
*   `--rna_fasta`: Path to a FASTA file containing multiple ssRNA sequences.

### Expert Tips

*   **Sequence Format**: Ensure your input sequences are in the correct format (amino acids for RRM, nucleotides for RNA).
*   **FASTA Files**: When using FASTA files, ensure they are properly formatted with sequence headers.
*   **Output Interpretation**: The output will typically be a numerical score. Higher scores generally indicate a higher likelihood of binding. Refer to the RRMScorer publication for detailed interpretation of scoring.
*   **Installation**: RRMScorer is available via bioconda. Use `conda install bioconda::rrmscorer` for installation.

## Reference documentation
- [RRMScorer Overview](./references/anaconda_org_channels_bioconda_packages_rrmscorer_overview.md)
- [RRMScorer Website](./references/bio2byte_be_rrmscorer.md)