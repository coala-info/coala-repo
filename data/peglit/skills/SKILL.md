---
name: peglit
description: peglit identifies optimal linker sequences for engineered pegRNAs to prevent internal base-pairing interference using simulated annealing. Use when user asks to identify linkers for epegRNAs, score existing epegRNA designs, or perform batch processing of pegRNA sequences.
homepage: https://github.com/sshen8/peglit/
metadata:
  docker_image: "quay.io/biocontainers/peglit:1.1.0--pyh7cba7a3_0"
---

# peglit

## Overview
peglit (pegRNA Linker Identification Tool) is a computational utility designed to optimize the design of engineered pegRNAs (epegRNAs). In prime editing, adding a structural motif to the 3' end of a pegRNA can protect it from degradation, but the linker between the pegRNA and the motif must be carefully chosen to avoid internal base-pairing that could disrupt the spacer, scaffold, or primer binding site (PBS). This skill provides the necessary commands and parameters to identify these linkers using simulated annealing.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install bioconda::peglit
```
*Note for Apple Silicon users: peglit requires an Intel-based environment. Use `CONDA_SUBDIR=osx-64 conda create -n peglit_env` followed by `conda activate peglit_env` before installing.*

## Command Line Usage

### Single Sequence Identification
To find a linker for a specific pegRNA, provide the five required subsequences separated by commas (no spaces).
**Order: spacer,scaffold,template,PBS,motif**

```bash
peglit ATGC...,ATGC...,ATGC...,ATGC...,ATGC...
```

### Batch Processing
For high-throughput design, use a CSV file. The file must contain a header row with the following exact column names: `spacer`, `scaffold`, `template`, `PBS`, and `motif`.

```bash
peglit --batch sequences.csv
```
The output will be saved as `sequences_linker_designs.csv`.

## Python API Integration
For custom pipelines, use the `peglit` module directly.

### Identifying New Linkers
```python
import peglit
linkers = peglit.pegLIT(
    seq_spacer="ATGC...",
    seq_scaffold="ATGC...",
    seq_template="ATGC...",
    seq_pbs="ATGC...",
    seq_motif="ATGC...",
    linker_pattern="NNNNNNNN" # Default 8nt linker
)
# Returns a list of recommended linker sequences
```

### Scoring Existing Designs
To evaluate the base-pairing interference of an existing epegRNA design:
```python
import peglit
# Returns a tuple of subscores (PBS, spacer, template, scaffold)
# Scores range 0-1; higher is better (less interference)
subscores = peglit.score(
    seq_spacer="...", 
    seq_scaffold="...", 
    seq_template="...", 
    seq_pbs="...", 
    seq_linker="..."
)
```

## Expert Parameters and Best Practices

### Linker Constraints
- **linker_pattern**: Use IUPAC degenerate base symbols (e.g., `NNNNVNNN`) to restrict the search space or enforce specific nucleotides.
- **ac_thresh**: (Default: 0.5) Minimum fraction of A or C bases allowed. Increasing this can help avoid G/U-rich sequences that might cause structural issues.
- **u_thresh**: (Default: 3) Maximum consecutive U bases allowed to prevent premature Pol III termination.

### Optimization Tuning
- **epsilon**: (Default: 0.01) The algorithm prioritizes components in this order: **PBS > spacer > template > scaffold**. Increasing epsilon makes the algorithm less sensitive to minor score differences, potentially allowing more diversity in results.
- **topn**: (Default: 100) Number of candidate linkers kept before the final bottlenecking/clustering step.
- **bottleneck**: (Default: 1) The number of final, distinct linker recommendations to return.

## Reference documentation
- [peglit GitHub README](./references/github_com_sshen8_peglit.md)
- [Bioconda peglit Overview](./references/anaconda_org_channels_bioconda_packages_peglit_overview.md)