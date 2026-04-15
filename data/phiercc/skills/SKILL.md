---
name: phiercc
description: pHierCC performs hierarchical clustering of bacterial allelic data to establish stable genomic nomenclature and population structures. Use when user asks to build a new hierarchical clustering scheme from core genome profiles or assign new samples to an existing clustering framework.
homepage: https://github.com/zheminzhou/pHierCC
metadata:
  docker_image: "quay.io/biocontainers/phiercc:1.24--pyhdfd78af_0"
---

# phiercc

## Overview
pHierCC is a specialized tool for analyzing bacterial population structures through hierarchical clustering of allelic data. It implements the HierCC scheme, which provides a stable, multi-level nomenclature for genomic clusters. The tool operates in two primary modes: "Development mode" for establishing a new clustering framework from a set of core genome profiles, and "Production mode" for the consistent assignment of new samples to established clusters using a previously generated reference.

## CLI Usage Patterns

### Development Mode (Building a New Scheme)
To generate a new hierarchical clustering scheme from a set of allelic profiles:
```bash
pHierCC -p profiles.tsv.gz -o output_prefix
```
*   **Input**: A tab-separated table where columns represent loci and rows represent Sequence Types (STs) or individual isolates.
*   **Output**: Generates `output_prefix.npz` (binary data for future runs) and `output_prefix.HierCC.gz` (human-readable cluster assignments).

### Production Mode (Incremental Assignment)
To assign new genomes to an existing scheme without changing the cluster IDs of the original dataset:
```bash
pHierCC -p new_profiles.tsv -a existing_scheme.npz -o incremental_output
```
*   **Note**: The `.npz` file from a previous run is required to maintain consistency in the hierarchical levels.

### Performance and Quality Tuning
*   **Parallelization**: Use the `-n` flag to specify the number of CPU cores. The default is 4.
    ```bash
    pHierCC -p profiles.tsv -o output -n 16
    ```
*   **Missing Data Threshold**: Adjust the `-m` (allowed_missing) parameter if working with lower-quality assemblies. The default is 0.03 (3%).
    ```bash
    pHierCC -p profiles.tsv -o output -m 0.05
    ```

## Best Practices and Expert Tips
*   **Input Formatting**: Ensure the profile file is a tab-separated table. The first column should contain the ST or isolate ID. pHierCC supports GZIPped input files directly, which is recommended for large cgMLST datasets.
*   **Interpreting Levels**: The output `.HierCC.gz` file contains multiple columns labeled HC0, HC1, HC2, etc. Each represents a different distance threshold in the hierarchical tree. HC0 is the most granular level (often representing identical or near-identical profiles).
*   **Environment Constraints**: pHierCC relies on Numba for performance. If encountering installation issues, ensure you are using a compatible Python version (3.6–3.8 is the primary tested range; check for Numba compatibility if using 3.9+).
*   **Memory Management**: For very large datasets (tens of thousands of profiles), ensure the system has sufficient RAM, as the tool builds a minimum-spanning tree of the full dataset.

## Reference documentation
- [pHierCC GitHub Repository](./references/github_com_zheminzhou_pHierCC.md)
- [pHierCC Bioconda Package](./references/anaconda_org_channels_bioconda_packages_phiercc_overview.md)