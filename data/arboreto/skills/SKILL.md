---
name: arboreto
description: Arboreto is a high-performance framework for inferring gene regulatory networks from expression matrices. Use when user asks to reconstruct gene regulatory networks, infer regulatory links between transcription factors and target genes, or run GRNBoost2 and GENIE3.
homepage: https://github.com/tmoerman/arboreto
---


# arboreto

## Overview
Arboreto is a high-performance framework designed to reconstruct gene regulatory networks from expression matrices. It addresses the computational intensity of GRN inference by leveraging Dask for parallelized execution across single machines or multi-node clusters. It is a core component of the pySCENIC pipeline but can be used independently to identify regulatory links between transcription factors and target genes.

## Core Algorithms
The tool provides two primary algorithms for regression-based network inference:
- **GRNBoost2**: A fast, modern algorithm utilizing Stochastic Gradient Boosting Machines (SGBM) with early-stopping regularization. It is generally preferred for its speed and performance on large datasets.
- **GENIE3**: The classic GRN inference algorithm using Random Forest (RF) or ExtraTrees (ET) regression.

## Installation and Setup
Arboreto is primarily distributed via Bioconda.
```bash
conda install bioconda::arboreto
```

## Usage Patterns
Arboreto can be used as a Python library or via command-line scripts. The workflow typically requires:
1.  **Expression Matrix**: A CSV or TSV file (or a Parquet/H5AD file when using the library) where rows are cells/samples and columns are genes.
2.  **Transcription Factors List**: A text file containing the gene symbols of the regulators to be tested.

### Command Line Interface (CLI)
While specific CLI flags vary by version, the standard entry points for the algorithms are:
- `arboreto_with_multiprocessing.py`: For local execution on a single machine.
- `arboreto_with_dask.py`: For distributed execution on a cluster.

### Expert Tips
- **Dask Scheduling**: Arboreto uses Dask's distributed scheduler even on a single machine to manage memory and CPU threads efficiently. Ensure your environment has sufficient scratch space for Dask worker spills if working with very large matrices.
- **Input Orientation**: Ensure your expression matrix is correctly oriented. Arboreto typically expects genes as columns for the regression tasks.
- **Algorithm Selection**: Use **GRNBoost2** for single-cell RNA-seq data with tens of thousands of cells, as it is significantly faster than the Random Forest implementation in GENIE3.
- **Sparse Matrix Support**: For high-dimensional single-cell data, use sparse matrix formats (like CSR) to reduce the memory footprint during the Dask graph construction.

## Reference documentation
- [Arboreto Overview](./references/anaconda_org_channels_bioconda_packages_arboreto_overview.md)
- [GitHub Repository](./references/github_com_tmoerman_arboreto.md)