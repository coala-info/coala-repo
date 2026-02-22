---
name: palikiss
description: palikiss is a specialized bioinformatics tool designed for comparative RNA structure analysis.
homepage: https://bibiserv.cebitec.uni-bielefeld.de/palikiss
---

# palikiss

## Overview
palikiss is a specialized bioinformatics tool designed for comparative RNA structure analysis. Unlike single-sequence folding tools, it leverages the evolutionary information present in multiple sequence alignments to improve prediction accuracy. Its primary strength lies in its ability to detect complex structural motifs, including various classes of pseudoknots, which are often missed by standard folding algorithms.

## Usage Guidelines

### Input Requirements
- **Alignment Format**: Ensure your input is a valid multiple sequence alignment (typically in Clustal or Stockholm format).
- **Fixed Alignment**: The tool operates on a "fixed" alignment, meaning it will not re-align sequences; the quality of the structural prediction is highly dependent on the quality of the input alignment.

### Command Line Patterns
The basic execution follows this pattern:
```bash
palikiss [options] <alignment_file>
```

### Best Practices
- **Pseudoknot Detection**: Use palikiss specifically when you suspect the presence of non-nested base pairings. It is optimized for the "canonical" pseudoknot shapes.
- **Consensus Scoring**: The tool evaluates the thermodynamic stability combined with covariance signals. High-scoring structures that show compensatory mutations are the most reliable.
- **Pre-processing**: Before running palikiss, remove highly divergent sequences or those with excessive gaps from your alignment, as these can introduce noise into the consensus calculation.

## Reference documentation
- [palikiss Overview](./references/anaconda_org_channels_bioconda_packages_palikiss_overview.md)