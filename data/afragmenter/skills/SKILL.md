---
name: afragmenter
description: AFragmenter is a schema-free segmentation tool that uses AlphaFold PAE values and Leiden clustering to partition protein structures into structural domains. Use when user asks to segment proteins into domains, identify structural clusters from PAE data, or chop protein sequences based on positional confidence.
homepage: https://github.com/sverwimp/AFragmenter
---


# afragmenter

## Overview

AFragmenter is a "schema-free" segmentation tool, meaning it does not rely on pre-defined domain libraries like CATH or SCOP. Instead, it treats a protein as a network where residues are nodes and edges are weighted by AlphaFold's PAE values. By applying the Leiden clustering algorithm, it identifies clusters of residues that have high mutual positional confidence, effectively "chopping" the protein into structural domains. The tool is highly tunable, allowing users to adjust the granularity of the segmentation to match specific biological contexts.

## Installation

Install via bioconda or pip:

```bash
conda install -c conda-forge -c bioconda afragmenter
# OR
pip install afragmenter
```

## Core Workflow

### 1. Data Acquisition
AFragmenter can fetch data directly from the AlphaFold Database (AFDB) using a UniProt ID or load local files.

```python
from afragmenter import AFragmenter, fetch_afdb_data

# Fetch from AFDB
pae, structure = fetch_afdb_data('P15807')

# Or load local PAE JSON
model = AFragmenter('path/to/pae.json')
```

### 2. Clustering and Tuning
The `cluster()` method is the primary interface. Two parameters are critical for success:

*   **Threshold**: The PAE contrast threshold (default is 2). It distinguishes between intra-domain (low PAE) and inter-domain (high PAE) regions.
*   **Resolution**: Controls the coarseness of the domains.
    *   **Higher (> 1.0)**: Produces more, smaller domains.
    *   **Lower (< 0.5)**: Produces fewer, larger domains.

```python
# Standard clustering
result = model.cluster(resolution=0.7, threshold=2)

# Fine-grained segmentation for complex proteins
result_fine = model.cluster(resolution=1.2)
```

### 3. Exporting Results
Once a satisfactory segmentation is found, export the domain boundaries or sequences.

```python
# Print a summary table of domains and residue ranges
result.print_result()

# Save domain sequences to a FASTA file (requires structure object)
result.save_fasta(structure, 'output_domains.fasta')

# Save boundaries to CSV
result.save_result('segmentation.csv')
```

## Expert Tips and Best Practices

*   **Handling High-Confidence Models**: For proteins with uniformly low PAE (very high confidence throughout), the algorithm may struggle to find contrast. In these cases, **lower the threshold** (e.g., to 1.5 or 1.0) to force the algorithm to recognize subtle differences in confidence as domain boundaries.
*   **Visual Validation**: Always use `result.plot_result()` or `result.py3Dmol(structure)` in a Jupyter environment to verify that the segments align with visual structural boundaries before proceeding with downstream analysis.
*   **Minimum Size Filter**: Use the `min_size` parameter in `cluster()` to ignore small fragments (e.g., disordered loops) that the algorithm might otherwise classify as independent domains.
*   **Iterative Refinement**: Domain definition is often subjective. It is recommended to run a sweep of resolution values (e.g., 0.2, 0.5, 1.0) to see how the protein hierarchy decomposes.

## Reference documentation
- [AFragmenter GitHub README](./references/github_com_sverwimp_AFragmenter.md)
- [Bioconda AFragmenter Overview](./references/anaconda_org_channels_bioconda_packages_afragmenter_overview.md)