---
name: samap
description: SAMap integrates single-cell gene expression data across evolutionarily distant species by mapping manifolds through a gene-cell graph. Use when user asks to integrate cross-species single-cell datasets, run reciprocal BLAST for gene mapping, or identify conserved cell types across divergent organisms.
homepage: https://github.com/atarashansky/SAMap
---


# samap

## Overview
SAMap (Self-Assembling Manifold mapping) is a computational framework designed to integrate single-cell gene expression data from species separated by hundreds of millions of years of evolution. Unlike standard integration methods that rely on one-to-one orthologs, SAMap utilizes reciprocal BLAST results to create a "gene-cell graph." This allows the algorithm to account for complex paralogy and evolutionary divergence. Use this skill to guide the multi-step process of preparing sequence data, running BLAST alignments, and executing the manifold mapping algorithm in Python.

## Installation and Environment Setup
SAMap requires specific bioinformatics dependencies, most notably NCBI BLAST+.

- **Conda Installation**:
  ```bash
  conda install -c bioconda samap
  ```
- **Pip Installation**:
  ```bash
  pip install sc-samap
  ```
- **External Dependency**: NCBI BLAST+ (version 2.9.0+ recommended) must be installed and available in your system `PATH`.

## Core Workflow

### 1. BLAST Mapping
Before running the manifold alignment, you must generate reciprocal BLAST tables between the transcriptomes/proteomes of the species being compared.

- **Script**: Use `map_genes.sh` provided in the repository to automate the BLAST process.
- **Input**: FASTA files for each species.
- **Execution**:
  ```bash
  # Example logic for running BLAST mapping
  ./map_genes.sh species1.fasta species2.fasta
  ```
- **Note**: This step is computationally intensive and can take several hours depending on the number of cores and the size of the fasta files.

### 2. Manifold Mapping in Python
Once BLAST results are generated, use the `SAMAP` object to integrate the `AnnData` objects.

```python
from samap.mapping import SAMAP
from samap.utils import ad_to_matrix

# Load your AnnData objects (e.g., adata1, adata2)
adatas = {'sp1': adata1, 'sp2': adata2}

# Define paths to the BLAST mapping tables generated in step 1
f_maps = 'path/to/maps/'

# Initialize and run SAMap
sm = SAMAP(adatas, f_maps = f_maps)
samap_dict = sm.run()
```

## Expert Tips and Best Practices
- **Data Preparation**: Ensure gene symbols in your `AnnData` objects match the headers in your FASTA files used for BLAST. Discrepancies here are the most common cause of mapping failures.
- **Memory Management**: For large datasets, SAMap can be memory-intensive. Ensure your environment has sufficient RAM, especially during the graph construction phase.
- **Parallelization**: When running the BLAST step, utilize the maximum number of available CPU cores to reduce the 4+ hour processing time.
- **Version Pinning**: If encountering `Numba` or `Leiden` errors, ensure `numpy` is at version `1.23.5` and `h5py` is at `3.8.0`, as these are known stable versions for the current SAMap implementation.
- **Visualization**: Use the `SAMGUI` or `display_heatmap()` functions within the package to inspect the resulting cell-type mappings and gene correlations.

## Reference documentation
- [SAMap GitHub Repository](./references/github_com_atarashansky_SAMap.md)
- [Bioconda SAMap Overview](./references/anaconda_org_channels_bioconda_packages_samap_overview.md)