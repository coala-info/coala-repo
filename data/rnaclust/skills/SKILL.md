---
name: rnaclust
description: `rnaclust` is a specialized pipeline designed for structural RNA bioinformatics.
homepage: http://www.bioinf.uni-leipzig.de/~kristin/Software/RNAclust/
---

# rnaclust

## Overview
`rnaclust` is a specialized pipeline designed for structural RNA bioinformatics. Unlike simple sequence-based clustering, it incorporates base-pair probability matrices (via RNAfold) and sequence-structure alignments (via LocARNA) to group RNAs that share common folding patterns. It is particularly effective for discovering functional RNA families where secondary structure is more conserved than the primary sequence.

## Usage Guidelines

### Input Requirements
- **Format**: Multiple FASTA file containing the RNA sequences to be clustered.
- **Sequence Length**: Since LocARNA is computationally intensive, ensure sequences are of comparable length or pre-processed to focus on specific regions of interest.

### Core Workflow
The tool automates a multi-stage bioinformatic pipeline:
1. **Folding**: Calculates base-pair probability matrices for each input sequence.
2. **Alignment**: Performs pairwise sequence-structure alignments for all combinations.
3. **Clustering**: Applies the WPGMA (Weighted Pair Group Method with Arithmetic Mean) algorithm to the alignment distance matrix.
4. **Output**: Produces a hierarchical tree in Newick format and calculates the optimal number of clusters.

### Common CLI Patterns
While specific flags vary by version, the standard execution follows this pattern:
```bash
# Basic execution with a multi-FASTA file
rnaclust -i input_sequences.fa

# Specifying output directory or prefix (if supported by the perl wrapper)
rnaclust -i input_sequences.fa -p project_name
```

### Best Practices
- **Environment**: Install via Bioconda (`conda install bioconda::rnaclust`) to ensure all dependencies like `ViennaRNA` and `LocARNA` are correctly linked in the path.
- **Visualization**: The resulting Newick tree can be visualized using standard phylogenetic tools (e.g., FigTree, iTOL) or the specialized Java viewer mentioned in the documentation.
- **Computational Cost**: Pairwise structural alignment is $O(n^2)$ relative to the number of sequences and $O(L^4)$ relative to sequence length. For large datasets, consider subsetting or using sequence-based pre-clustering.

## Reference documentation
- [RNAclust Overview](./references/anaconda_org_channels_bioconda_packages_rnaclust_overview.md)
- [RNAclust Software Page](./references/www_bioinf_uni-leipzig_de__kristin_Software_RNAclust.md)