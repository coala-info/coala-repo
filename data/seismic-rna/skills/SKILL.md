---
name: seismic-rna
description: SEISMIC-RNA identifies multiple co-existing RNA structural conformations from DMS-MaPseq or SHAPE-MaP data by analyzing correlated mutation patterns. Use when user asks to identify RNA structural ensembles, perform DREEM-based clustering, or analyze and visualize correlated mutations in RNA sequences.
homepage: https://github.com/rouskinlab/seismic-rna
metadata:
  docker_image: "quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0"
---

# seismic-rna

## Overview

SEISMIC-RNA (Structure Ensemble Inference by Sequencing, Mutation Identification, and Clustering of RNA) is a specialized bioinformatics toolkit developed by the Rouskin Lab. It is designed to process data from experiments like DMS-MaPseq and SHAPE-MaP. The tool's primary function is to identify multiple co-existing RNA structural conformations (ensembles) within a single sample by detecting correlated mutation patterns and applying an optimized implementation of the DREEM algorithm.

## Installation and Setup

Install the package via Bioconda:
```bash
conda install bioconda::seismic-rna
```
Note: Recent versions (v0.24.0+) require Python 3.11 or higher, with the latest updates supporting Python 3.13.

## Common CLI Patterns

The primary entry point for the software is the `seismic` command.

### Verification and Testing
To verify the installation and run the internal test suite:
```bash
seismic --log "" --exit-on-error test -vv
```

### Correlation Analysis (poscorr)
Use the `poscorr` subcommand to identify correlated mutations between different positions in the RNA sequence, which is the basis for structural clustering.
- **Key Parameter**: Use `--min-gap` to define the minimum distance between positions for masking and clustering datasets.

### Visualizing Correlations
To generate confusion matrices and graphical representations of correlated positions:
```bash
seismic graph poscorr
```
This command can output module coordinates to CSV files and display them in a graph to help identify structural domains.

### Ensemble Inference
Use the `ensembles` subcommand to perform the core DREEM-based clustering.
- **Clustering Logic**: Recent versions have transitioned from sliding window clustering to regions defined by correlated mutations.
- **Length Control**: Use `--max-cluster-length` to limit the genomic span of a single cluster.

## Expert Tips and Best Practices

- **Handling Low Read Counts**: The clustering algorithm is designed to be robust; if 0 reads are provided, it is programmed to return 1 default cluster rather than failing.
- **False Positive Reduction**: The tool utilizes internal functions (`_calc_modules_from_pairs` and `_calc_null_span_per_pos`) to reduce sensitivity to false positive correlations.
- **Performance**: For large datasets, ensure `pandas` is restricted to versions `< 3.0` as per current compatibility requirements.
- **Logging**: If you encounter issues with CLI argument parsing in automated environments, you can disable specific logging behaviors using the `LOGISTRO_DISABLE_CLI` environment variable.

## Reference documentation
- [SEISMIC-RNA GitHub Repository](./references/github_com_rouskinlab_seismic-rna.md)
- [SEISMIC-RNA Commit History and CLI Usage](./references/github_com_rouskinlab_seismic-rna_commits_main.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_seismic-rna_overview.md)