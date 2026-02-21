---
name: dupre
description: The `dupre` tool provides a robust mathematical framework for estimating the duplication rate of sequencing libraries.
homepage: https://bitbucket.org/genomeinformatics/dupre/
---

# dupre

## Overview
The `dupre` tool provides a robust mathematical framework for estimating the duplication rate of sequencing libraries. Unlike simple heuristic-based estimators, `dupre` utilizes linear programming and the hypergeometric distribution to model library complexity. This allows researchers to make informed decisions about whether to continue sequencing a specific library or to prepare a new one by predicting the yield of unique fragments at higher sequencing depths.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the bioconda channel:
```bash
conda install -c bioconda dupre
```

### Core Workflow
`dupre` typically operates on fragment count distributions (histograms) derived from BAM/SAM files. The general workflow involves:
1. Generating a frequency distribution of duplicates (how many fragments were seen once, twice, etc.).
2. Running `dupre` on this distribution to estimate the total number of unique molecules in the original library.

### Command Line Patterns
While specific flags depend on the version, the standard execution pattern follows:
```bash
dupre [options] <input_histogram>
```

### Best Practices
- **Input Preparation**: Ensure your input histogram is formatted correctly, typically as a two-column text file where the first column is the occurrence count and the second column is the number of distinct fragments seen that many times.
- **Deep Sequencing Prediction**: Use the output estimates to plot a "saturation curve." This helps in identifying the point of diminishing returns where additional sequencing mostly produces redundant data.
- **Library Comparison**: Use `dupre` results to compare different library preparation protocols; a higher estimated total unique molecule count indicates a more complex and higher-quality library.

## Reference documentation
- [dupre - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_dupre_overview.md)
- [dupre Source Repository | Bitbucket](./references/bitbucket_org_genomeinformatics_dupre.md)