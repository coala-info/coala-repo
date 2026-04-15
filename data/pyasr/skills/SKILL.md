---
name: pyasr
description: PyASR is a Python library that provides a modern wrapper for PAML to streamline ancestral sequence reconstruction workflows for protein data. Use when user asks to reconstruct ancestral sequences, run PAML via Python, or manage phylogenetic data using Pandas and DendroPy.
homepage: https://github.com/Zsailer/pyasr
metadata:
  docker_image: "quay.io/biocontainers/pyasr:0.6.1--py_0"
---

# pyasr

## Overview

PyASR is a specialized Python library designed to streamline Ancestral Sequence Reconstruction (ASR) workflows. It acts as a modern wrapper for PAML (Phylogenetic Analysis by Maximum Likelihood), specifically tuned for protein reconstructions. By leveraging the PyData ecosystem—including Pandas, PhyloPandas, and DendroPy—it allows researchers to move from raw sequence data and phylogenetic trees to reconstructed ancestral states without manually managing PAML's complex input and output files.

## Installation and Environment Setup

Before using PyASR, ensure that PAML is installed on your system and that the `codeml` and `baseml` executables are available in your `$PATH`.

```bash
# Install via Bioconda
conda install bioconda::pyasr

# Or install via pip
pip install pyasr
```

## Core Workflow

The primary interface for PyASR is the `reconstruct` function. The workflow typically involves loading a sequence alignment and a tree, then executing the reconstruction.

### 1. Data Preparation
PyASR expects sequences in a format compatible with `phylopandas` and trees compatible with `dendropy`.

```python
import phylopandas as pd
import dendropy as d
import pyasr

# Load sequences (FASTA)
df_seqs = pd.read_fasta('alignment.fasta')

# Load phylogenetic tree (Newick)
tree = d.Tree.get(path='tree.newick', schema='newick')
```

### 2. Executing Reconstruction
The `reconstruct` function handles the interaction with PAML.

```python
# Perform reconstruction
# alpha: The gamma shape parameter for rate variation among sites
tree, df_seqs, df_anc = pyasr.reconstruct(
    df_seqs, 
    tree, 
    working_dir='asr_results', 
    alpha=1.235
)
```

### 3. Handling Results
The function returns three objects:
- **tree**: The DendroPy tree object updated with ancestral node information.
- **df_seqs**: The original sequence DataFrame.
- **df_anc**: A DataFrame containing the reconstructed ancestral sequences and their posterior probabilities.

```python
# Export ancestors to CSV for further analysis
df_anc.to_csv('ancestors.csv')
```

## Best Practices and Expert Tips

- **Protein Limitation**: Currently, PyASR is optimized for and primarily supports protein sequence reconstructions. Do not use it for nucleotide-only workflows without verifying compatibility with the latest version.
- **Working Directory Management**: Always specify a `working_dir`. PAML generates several intermediate files (e.g., `rub`, `lnf`, `rst`). Using a dedicated directory prevents cluttering your project root and allows for easier debugging of the PAML execution.
- **Alpha Parameter**: The `alpha` parameter is critical for the Gamma model of rate heterogeneity. If you have previously calculated the alpha value using a tool like ProtTest or ModelFinder, ensure you pass it to the `reconstruct` function to improve accuracy.
- **Visualization**: For interactive analysis, PyASR results integrate well with `ToyTree` inside JupyterLab, allowing you to map reconstructed sequences directly onto tree nodes visually.
- **Dependency Check**: If you encounter `ImportError`, verify your Biopython version. Recent versions of Biopython have removed `Bio.Alphabet`, which may affect older versions of PyASR and PhyloPandas.

## Reference documentation
- [PyASR GitHub Repository](./references/github_com_Zsailer_pyasr.md)
- [PyASR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyasr_overview.md)