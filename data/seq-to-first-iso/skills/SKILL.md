---
name: seq-to-first-iso
description: This tool predicts the isotopic distribution and theoretical mass of peptides under natural abundance and 12C-enriched metabolic labeling conditions. Use when user asks to predict M0 and M1 isotopologue intensities, calculate peptide masses for SLIM-labeling experiments, or account for auxotrophic amino acids in isotopic simulations.
homepage: https://github.com/pierrepo/seq-to-first-iso
---


# seq-to-first-iso

## Overview

The `seq-to-first-iso` tool is a specialized proteomics utility used to predict the isotopic distribution of peptides under specific metabolic labeling conditions. It calculates the theoretical mass and the intensities of the M0 and M1 isotopologues for both natural abundance and 12C-enriched environments. This is particularly useful for researchers performing SLIM-labeling (Simple Light Isotope Metabolic labeling) who need to account for auxotrophic amino acids—those that do not incorporate the label and maintain their natural isotopic abundance.

## Installation

Install the tool via Bioconda or pip:

```bash
# Via Conda
conda install -c bioconda seq-to-first-iso

# Via Pip
pip install seq-to-first-iso
```

## Command Line Usage

The primary interface is a CLI script that processes text files containing peptide sequences.

### Basic Command
```bash
seq-to-first-iso peptides.txt
```
By default, this generates a file named `peptides_stfi.tsv`.

### Handling Auxotrophies (Unlabeled Amino Acids)
Use the `-n` flag to specify amino acids that should retain their natural isotopic abundance (i.e., they are not labeled with 12C).
```bash
seq-to-first-iso peptides.txt -n V,W,L
```

### Customizing Output
```bash
seq-to-first-iso peptides.txt -o experimental_results.tsv
```

## Input File Format

The tool accepts a simple text file with one peptide sequence per line.
- **Standard Input**: A list of sequences (e.g., `YAQEISR`).
- **Annotated Input**: You can include annotations before the sequence, separated by a tab. The tool will preserve these in the output.
- **PTM Support**: Supports X!Tandem style Post-Translational Modifications.

## Output Data Reference

The resulting TSV file contains the following key columns:
- `sequence`: The peptide sequence.
- `mass`: The monoisotopic mass.
- `formula`: The chemical formula.
- `M0_NC` / `M1_NC`: Intensities of M0 and M1 at Natural Carbon abundance.
- `M0_12C` / `M1_12C`: Intensities of M0 and M1 under 12C enrichment (99.99%).

## Best Practices

- **Batch Processing**: For large datasets, provide a single file with all sequences rather than running the tool multiple times to minimize overhead.
- **Validation**: Ensure sequences only contain standard amino acid one-letter codes unless using supported PTM notations.
- **Auxotrophy Simulation**: When working with yeast or cell lines that are auxotrophic for specific amino acids (like Lysine or Arginine), always use the `-n` flag to ensure the predicted M0/M1 ratios match the experimental reality.

## Reference documentation
- [Seq-to-first-iso GitHub Repository](./references/github_com_pierrepo_seq-to-first-iso.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_seq-to-first-iso_overview.md)