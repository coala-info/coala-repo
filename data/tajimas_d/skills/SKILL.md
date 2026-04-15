---
name: tajimas_d
description: The tajimas_d tool calculates Tajima's D and other genetic diversity estimators to test the neutrality of DNA sequence evolution. Use when user asks to calculate Tajima's D, compute the Pi-Estimator, or determine the Watterson-Estimator from aligned DNA sequences.
homepage: https://github.com/not-a-feature/tajimas_d
metadata:
  docker_image: "quay.io/biocontainers/tajimas_d:2.0.4--pyhdfd78af_0"
---

# tajimas_d

## Overview

The `tajimas_d` tool is a specialized bioinformatics utility used to test the neutrality of DNA sequence evolution. By comparing different estimates of genetic diversity, it allows researchers to infer demographic history. A negative Tajima's D suggests population expansion or purifying selection (excess of rare variants), while a positive value suggests population bottlenecks or balancing selection (excess of intermediate variants). Values exceeding +2 or falling below -2 are typically considered statistically significant.

## Installation

The tool can be installed via pip or conda:

```bash
pip install tajimas_d
# OR
conda install -c bioconda tajimas_d
```

## Command Line Interface (CLI)

The standalone version requires a FASTA file containing multiple aligned sequences.

### Basic Usage
By default, the tool calculates Tajima's D:
```bash
tajimas_d -f sequences.fasta
```

### Specific Estimators
You can request specific statistics using the following flags:
- `-t, --tajima`: Compute Tajima's D (default).
- `-p, --pi`: Compute the Pi-Estimator ($\theta_\pi$).
- `-w, --watterson`: Compute the Watterson-Estimator ($\theta_W$).

Example calculating all three:
```bash
tajimas_d -f sequences.fasta -p -t -w
```

## Python API Usage

For integration into bioinformatics pipelines, use the Python module directly.

```python
from tajimas_d import tajimas_d, watterson_estimator, pi_estimator

# Input must be a list of strings (sequences)
sequences = [
    "ATGCATGC",
    "ATGCATGT",
    "ATGCATTT",
    "ATGCATTT"
]

# Calculate statistics
d_stat = tajimas_d(sequences)
pi_stat = pi_estimator(sequences)
w_stat = watterson_estimator(sequences)

print(f"Tajima's D: {d_stat}")
```

## Interpretation Guide

| Value | Interpretation | Genetic Signal |
|-------|----------------|----------------|
| $D < 0$ | Population Expansion | Excess of rare variants (low-frequency polymorphisms) |
| $D > 0$ | Population Contraction | Excess of intermediate variants (high-frequency polymorphisms) |
| $D \approx 0$ | Neutrality | Mutation-drift equilibrium |
| $|D| > 2$ | Significant | Strong evidence for non-neutral evolution or demographic shift |

## Best Practices
- **Sequence Alignment**: Ensure all input sequences are properly aligned and of equal length.
- **Sample Size**: Tajima's D sensitivity increases with the number of sequences; very small samples may not yield reliable results.
- **Standalone Requirements**: The CLI version requires `miniFasta >= 2.2` to be installed in the environment to parse FASTA files.

## Reference documentation
- [Overview of tajimas_d on Anaconda](./references/anaconda_org_channels_bioconda_packages_tajimas_d_overview.md)
- [GitHub Repository and README](./references/github_com_not-a-feature_tajimas_d.md)