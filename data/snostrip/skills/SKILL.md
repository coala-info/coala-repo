---
name: snostrip
description: snostrip is a bioinformatics workflow for the discovery, characterization, and annotation of snoRNAs in genomic sequences. Use when user asks to annotate snoRNAs, search for conserved motifs, or predict interactions with target RNAs.
homepage: http://snostrip.bioinf.uni-leipzig.de/help.py
---


# snostrip

## Overview
snostrip is a specialized bioinformatics workflow designed to streamline the discovery and characterization of snoRNAs. It automates the process of searching genomic data for conserved snoRNA motifs, secondary structures, and potential base-pairing interactions with target RNAs. It is particularly effective for annotating newly sequenced genomes or refining existing non-coding RNA annotations by leveraging homology-based searches and thermodynamic stability filters.

## Usage Guidelines

### Core Workflow
The pipeline typically requires a genomic sequence (FASTA) and, optionally, a set of known target sequences to predict interactions.

- **Annotation**: Use the tool to scan genomic regions for the characteristic boxes (C, D, C', D' for box C/D; H and ACA for box H/ACA).
- **Target Prediction**: The tool calculates the complementarity between the antisense elements of the snoRNA and the target sequences (rRNA/snRNA) to identify methylation or pseudouridylation sites.
- **Comparative Analysis**: If multiple related genomes are provided, snostrip can use synteny and sequence conservation to increase the confidence of snoRNA predictions.

### Best Practices
- **Input Quality**: Ensure genomic FASTA headers are concise, as long headers can sometimes interfere with downstream mapping tools used by the pipeline.
- **Target Databases**: For the most accurate target prediction, provide high-quality rRNA and snRNA sequences specific to the organism being studied.
- **Filtering**: Review the confidence scores provided in the output. Candidates with weak box motifs or low thermodynamic stability in their guide-target duplexes should be treated as provisional.

## Reference documentation
- [snostrip Overview](./references/anaconda_org_channels_bioconda_packages_snostrip_overview.md)