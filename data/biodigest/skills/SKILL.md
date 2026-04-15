---
name: biodigest
description: Biodigest validates the biological significance of gene sets, clusters, and subnetworks by comparing them against known disease associations and functional annotations. Use when user asks to validate gene sets against disease libraries, evaluate clustering algorithm results, or assess the functional coherence of protein-protein interaction subnetworks.
homepage: http://pypi.python.org/pypi/biodigest/
metadata:
  docker_image: "quay.io/biocontainers/biodigest:0.2.16--pyhdfd78af_2"
---

# biodigest

## Overview
The `biodigest` tool (DIGEST) provides a computational framework for validating biological hypotheses derived from high-throughput data. It is specifically designed to evaluate the significance of gene sets, clusters, or subnetworks by comparing them against known disease associations and functional annotations. This skill assists in executing the DIGEST workflow to determine if identified gene modules are statistically relevant to specific biological contexts or pathologies.

## Installation and Setup
The tool is primarily distributed via Bioconda and PyPI.
- **Conda**: `conda install -c bioconda biodigest`
- **Pip**: `pip install biodigest`

## Core Usage Patterns
The tool is typically invoked via the `digest` command. It requires input gene sets (in GMT or TXT format) and reference background distributions.

### Validating Gene Sets
To validate a specific list of genes against disease libraries:
```bash
digest validate --input genes.txt --database disgenet --output results/
```

### Clustering Validation
When evaluating the output of a clustering algorithm (e.g., Louvain or WGCNA):
```bash
digest cluster-eval --input clusters.csv --metrics enrichment significance --organism hsa
```

### Subnetwork Analysis
To assess the functional coherence of a protein-protein interaction (PPI) subnetwork:
```bash
digest network --sif network.sif --nodes genes.txt --permute 1000
```

## Expert Tips
- **Background Selection**: Always define a custom background population (e.g., all genes expressed in your specific tissue) rather than using the whole genome to avoid inflated significance scores.
- **Permutation Counts**: For publication-quality results, use at least 1,000 permutations (`--permute 1000`) to stabilize p-values, though 100 is sufficient for initial exploratory runs.
- **Organism Support**: Ensure the `--organism` flag matches your data (default is usually 'hsa' for human), as gene identifier mapping is sensitive to this setting.

## Reference documentation
- [biodigest on PyPI](./references/pypi_org_project_biodigest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biodigest_overview.md)