---
name: plinder
description: PLINDER provides a curated dataset and evaluation framework for protein-ligand interaction modeling and benchmarking. Use when user asks to retrieve protein-ligand systems, perform similarity searches on interaction fingerprints or pockets, filter structures by quality or state, or benchmark docking and binding affinity models using standardized splits and evaluation harnesses.
homepage: https://www.plinder.sh
metadata:
  docker_image: "quay.io/biocontainers/plinder:0.2.26--pyhdfd78af_0"
---

# plinder

## Overview
PLINDER is a specialized resource designed to overcome limitations in protein-ligand interaction datasets by providing a massive, high-quality collection of curated systems. This skill enables the retrieval and processing of over 400,000 protein-ligand systems, including paired unbound (apo) and AlphaFold2 predicted structures. Use this skill to perform similarity searches across interaction fingerprints, pocket structures, and ligands, or to utilize standardized evaluation harnesses for benchmarking docking and binding affinity prediction models.

## Installation and Setup
The package is primarily distributed via Bioconda. Ensure your environment is configured to access the `bioconda` and `conda-forge` channels.

```bash
conda install bioconda::plinder
```

## Core Workflows

### Data Ingestion and Filtering
PLINDER categorizes data across SCOP domains and unique small molecules. When querying the dataset, focus on the 500+ available annotations to refine your subset:
- **Structural State**: Filter by `holo` (bound), `apo` (unbound), or `predicted` (AlphaFold2) to test model robustness.
- **Similarity Metrics**: Use the pre-computed similarity scores (interaction fingerprints, pocket structural similarity) to ensure test sets do not contain leakage from training data.
- **Quality Filters**: Leverage resolution and R-free annotations to select high-confidence structures.

### Using Pre-set Splits
Avoid manual splitting for benchmarking. PLINDER provides standardized train/val/test splits designed to measure generalizability:
- **Novelty Subsets**: Use specific test subsets containing novel proteins or ligands to evaluate out-of-distribution performance.
- **Leakage Prevention**: The splits are pre-calculated using extensive similarity computation (>20B scores) to ensure rigorous evaluation.

### Evaluation Harness
When evaluating prediction models, use the standardized evaluation harness to ensure results are comparable to CASP-CAPRI standards.
- **Metrics**: Focus on interaction-based metrics rather than just RMSD.
- **Cross-Structure Eval**: Always evaluate your model across all three structure types (holo, apo, and predicted) to understand real-world performance drops.

## Expert Tips
- **Interactivity**: For initial exploration of domains or oligomeric states, use the PLINDER web explorer to identify numeric constraints before applying them in your CLI/Python scripts.
- **Data Augmentation**: Look for "Van-Der-Mers" and "Cross-Docking" strategies within the dataset to expand your training coverage beyond native holo structures.
- **Regular Updates**: PLINDER is designed for automated ingestion; always check for the latest version to include newly released PDB structures.

## Reference documentation
- [PLINDER Overview](./references/anaconda_org_channels_bioconda_packages_plinder_overview.md)
- [PLINDER Homepage and Features](./references/www_plinder_sh_index.md)