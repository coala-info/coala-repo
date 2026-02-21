---
name: bcov
description: The bcov skill enables the prediction of beta-sheet topology, a critical component of protein tertiary structure.
homepage: http://biocomp.unibo.it/savojard/bcov/index.html
---

# bcov

## Overview
The bcov skill enables the prediction of beta-sheet topology, a critical component of protein tertiary structure. It processes amino acid sequences to identify how beta-strands are organized, including their adjacency and directionality (parallel vs. anti-parallel). This tool is particularly useful for structural bioinformaticians working on protein folding, homology modeling, or de novo structure prediction where experimental data is unavailable.

## Installation
The package is distributed via Bioconda. Ensure your environment is configured with the bioconda and conda-forge channels.

```bash
conda install bioconda::bcov
```

## Usage Guidelines
bcov is designed to bridge the gap between primary sequence and 3D topology.

### Input Requirements
- **Sequence Data**: Provide the amino acid sequence in standard FASTA format or as a raw string depending on the specific CLI implementation.
- **Strand Definitions**: The tool typically requires knowledge of where the beta-strands are located within the sequence (often derived from secondary structure predictors like PSIPRED).

### Common Workflow
1. **Identify Strands**: Use a secondary structure predictor to locate beta-strands.
2. **Run bcov**: Execute the prediction to determine the most likely topology.
3. **Analyze Output**: Review the predicted strand pairings and orientations.

### Best Practices
- **Combine with Secondary Structure**: bcov performs best when provided with high-confidence beta-strand assignments.
- **Sequence Length**: Be aware that complex topologies in very large proteins may increase computational complexity.
- **Integration**: Use bcov as a filtering step in structural modeling pipelines to narrow down the conformational search space.

## Reference documentation
- [bcov Overview](./references/anaconda_org_channels_bioconda_packages_bcov_overview.md)
- [Biocomputing Group - University of Bologna](./references/biocomp_unibo_it_index.md)