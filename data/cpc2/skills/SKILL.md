---
name: cpc2
description: CPC2 predicts the coding potential of RNA sequences to distinguish between protein-coding and non-coding transcripts. Use when user asks to identify coding capacity, classify transcripts as coding or non-coding, or extract predicted peptide sequences.
homepage: https://github.com/gao-lab/CPC2_standalone
---


# cpc2

## Overview
CPC2 (Coding Potential Calculator 2) is a fast, species-neutral tool used to identify the coding capacity of RNA sequences. Unlike homology-based methods, CPC2 utilizes four sequence-intrinsic features—ORF length, ORF integrity, Fickett score, and isoelectric point—to predict whether a transcript is coding or non-coding. This makes it particularly effective for large-scale datasets and for identifying long non-coding RNAs (lncRNAs) without the computational overhead of alignment-based searches.

## Usage Instructions

### Basic Coding Potential Prediction
To run the standard classification on a FASTA file:
```bash
CPC2.py -i input_sequences.fa -o results_table.txt
```

### Extracting Predicted Peptide Sequences
If you require the amino acid sequences of the predicted ORFs, use the dedicated peptide output script:
```bash
CPC2_output_peptide.py -i input_sequences.fa -o results_prefix --ORF
```

### Interpreting the Output
The output is a tab-delimited table containing the following columns:
1. **#ID**: Sequence identifier from the FASTA file.
2. **peptide_length**: Length of the predicted protein/peptide.
3. **Fickett_score**: A measure of base composition periodicity.
4. **isoelectric_point**: The calculated pI of the predicted peptide.
5. **ORF_integrity**: Boolean (0 or 1) indicating if the ORF starts with an ATG and ends with a stop codon.
6. **coding_probability**: A score from 0 to 1 indicating the likelihood of being protein-coding.
7. **coding_label**: The final classification ("coding" or "noncoding").

## Best Practices and Tips
- **Input Quality**: Ensure your input FASTA files do not contain non-IUPAC characters, as these can interfere with feature calculation.
- **Species Neutrality**: Because CPC2 relies on intrinsic features rather than homology, you do not need to specify a model for different organisms; the same command works for human, plant, or animal transcripts.
- **Large Datasets**: CPC2 is optimized for speed. For very large files, ensure you have sufficient disk space for the tab-delimited output, which can grow significantly with thousands of transcripts.
- **ORF Selection**: By default, CPC2 identifies the longest ORF within the transcript to calculate its features.

## Reference documentation
- [CPC2 Overview](./references/anaconda_org_channels_bioconda_packages_cpc2_overview.md)
- [CPC2 Standalone GitHub Repository](./references/github_com_gao-lab_CPC2_standalone.md)