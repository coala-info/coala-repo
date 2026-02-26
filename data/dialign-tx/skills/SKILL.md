---
name: dialign-tx
description: DIALIGN-TX performs multiple sequence alignment by combining greedy and progressive strategies to identify and align highly conserved local segments. Use when user asks to align sequences with isolated regions of similarity, perform local multiple sequence alignment, or handle sequences with significant rearrangements and large insertions.
homepage: https://dialign-tx.gobics.de
---


# dialign-tx

## Overview
DIALIGN-TX is an advanced version of the DIALIGN alignment program that combines greedy and progressive alignment strategies. Unlike traditional global alignment tools that penalize gaps linearly, DIALIGN-TX focuses on finding and aligning highly conserved local segments (fragments). This makes it ideal for sequences that share isolated regions of similarity or have undergone significant rearrangements, as it does not force a global alignment where one does not biologically exist.

## Command Line Usage

The basic syntax for running DIALIGN-TX is:
`dialign-tx [options] <conf_dir> <fasta_file> <out_file>`

### Core Arguments
- `<conf_dir>`: Path to the configuration directory (usually containing substitution matrices like BLOSUM). In many bioconda installations, this is provided by the environment or a specific data path.
- `<fasta_file>`: The input file containing sequences in FASTA format.
- `<out_file>`: The destination path for the resulting alignment.

### Common Options
- `-n`: Specifies that input sequences are nucleic acid (DNA/RNA).
- `-a`: Specifies that input sequences are amino acids (Protein).
- `-w`: Sensitivity mode. Higher values increase sensitivity but increase computation time.
- `-T`: Threshold for segment inclusion. Adjusting this filters out low-scoring local alignments.
- `-L`: Longest fragment length to consider.

## Best Practices
- **Sequence Type**: Always explicitly define the sequence type using `-n` or `-a` to ensure the correct substitution matrix and logic are applied.
- **Local vs. Global**: Use DIALIGN-TX specifically when you suspect your sequences have "islands" of conservation. For sequences known to be homologous across their entire length, global aligners like ClustalW or MAFFT might be faster, though DIALIGN-TX is more robust to large insertions/deletions.
- **Configuration Path**: Ensure the `<conf_dir>` points to the directory containing the `BLOSUM` or `DNA_MAT` files. If the tool fails to start, it is often due to a missing or incorrect path to these scoring matrices.
- **Output Interpretation**: Remember that DIALIGN-TX may leave regions unaligned (represented as lowercase or specific characters) if no significant similarity is found. This is a feature, not a bug, indicating a lack of detectable homology in those segments.

## Reference documentation
- [DIALIGN-TX Overview](./references/anaconda_org_channels_bioconda_packages_dialign-tx_overview.md)