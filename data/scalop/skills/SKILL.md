---
name: scalop
description: SCALOP provides rapid structural annotation of antibody Complementarity Determining Regions by mapping sequences to known canonical loop clusters. Use when user asks to annotate antibody CDR structures, predict canonical loop clusters from sequences, or perform structural annotation for antibody engineering.
homepage: https://github.com/oxpig/SCALOP
---


# scalop

## Overview
SCALOP (Sequence-based antibody Canonical LOoP structure annotation) is a bioinformatics tool designed for the rapid structural annotation of antibody Complementarity Determining Regions (CDRs). It maps amino acid sequences to known canonical loop clusters, providing structural insights without the need for computationally expensive 3D modeling. This tool is essential for antibody engineering, humanization, and structural bioinformatics workflows.

## Installation
The recommended way to install SCALOP is via bioconda:
```bash
conda install bioconda::scalop
```

## Command Line Usage
The primary interface is the `SCALOP` command. It accepts single sequences, paired heavy/light chain sequences, or FASTA files.

### Basic Syntax
```bash
SCALOP -i <INPUT> --scheme <SCHEME> --definition <DEFINITION>
```

### Input Formats
- **Single Sequence**: Provide a single heavy or light chain sequence.
- **Paired Chains**: Provide heavy and light chain sequences separated by a forward slash (`/`).
  - Example: `VKLLE...VSS/ELVMT...IKR`
- **FASTA File**: Provide the path to a `.fasta` file containing one or more sequences.

### Common Parameters
- `-i`, `--input`: The sequence string or path to a FASTA file.
- `--scheme`: The numbering scheme to use. Common options include `imgt`, `kabat`, or `chothia`.
- `--definition`: The CDR definition to apply. Common options include `north` or `chothia`.

### Example Command
To annotate a paired antibody sequence using the IMGT numbering scheme and North CDR definitions:
```bash
SCALOP -i VKLLEQSGAEVKKPGASVKVSCKASGYSFTSYGLHWVRQAPGQRLEWMGWISAGTGNTKYSQKFRGRVTFTRDTSATTAYMGLSSLRPEDTAVYYCARDPYGGGKSEFDYWGQGTLVTVSS/ELVMTQSPSSLSASVGDRVNIACRASQGISSALAWYQQKPGKAPRLLIYDASNLESGVPSRFSGSGSGTDFTLTISSLQPEDFAIYYCQQFNSYPLTFGGGTKVEIKRTV --scheme imgt --definition north
```

## Python Integration
SCALOP can be used directly within Python scripts for high-throughput processing.

```python
from scalop.predict import assign

# Define input sequence (Heavy/Light)
antibody_seq = 'VKLLE...VSS/ELVMT...IKR'

# Assign canonical loops
prediction = assign(antibody_seq)
print(prediction)
```

## Expert Tips and Best Practices
- **Separator Usage**: Always use the `/` separator when providing both heavy and light chains. This allows SCALOP to correctly identify the interface and number both chains accurately.
- **Dependency Check**: SCALOP relies on HMMER (3.1b2 or later). Ensure `hmmscan` is available in your system PATH before running.
- **Scheme Consistency**: Ensure the `--scheme` and `--definition` parameters match the conventions used in your reference datasets to avoid misaligned CDR boundaries.
- **Large Datasets**: For large-scale sequence analysis, prefer passing a FASTA file over individual CLI calls to reduce overhead.

## Reference documentation
- [SCALOP GitHub Repository](./references/github_com_oxpig_SCALOP.md)
- [SCALOP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scalop_overview.md)