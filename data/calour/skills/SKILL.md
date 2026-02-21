---
name: calour
description: Calour is a Python-based toolset designed for the interactive exploration and statistical analysis of microbiome and metabolome data.
homepage: https://biocore.github.io/calour/
---

# calour

## Overview

Calour is a Python-based toolset designed for the interactive exploration and statistical analysis of microbiome and metabolome data. It centers around the `Experiment` class, which synchronizes a data matrix (samples vs. features) with corresponding metadata for both samples and features. This skill enables the processing of high-throughput biological data through a workflow of normalization, filtering, clustering, and differential abundance testing, with a particular emphasis on visualizing results through heatmaps that interface with external biological databases.

## Core Usage Patterns

### 1. Loading Data
Calour supports various formats including BIOM, QIIME2, and metabolomics tables.

```python
import calour as ca

# Load microbiome data with Total Sum Scaling (TSS) normalization
# normalize=10000 scales each sample to 10k reads
# min_reads=1000 drops samples with low sequencing depth
exp = ca.read_amplicon('data.biom', 'metadata.txt', normalize=10000, min_reads=1000)
```

### 2. Data Manipulation
Always filter and sort your data to make patterns visible in heatmaps.

*   **Filtering**: Remove low-abundance or rare features to reduce noise.
    *   `exp.filter_abundance(10)`: Keep features with >10 total reads.
    *   `exp.filter_prevalence(0.5)`: Keep features present in >50% of samples.
*   **Sorting**: Organize samples by metadata to see group differences.
    *   `exp.sort_samples('DiseaseState')`
*   **Clustering**: Group similar features together.
    *   `exp.cluster_features()`: Uses hierarchical clustering (perform after filtering for speed).

### 3. Normalization Strategies
*   **TSS (Default)**: Standardizes read counts per sample.
*   **Compositional**: Use `exp.normalize_compositional()` if a few highly abundant features are driving artificial changes in others.
*   **Subset**: Use `exp.normalize_by_subset_features()` to normalize based on a specific set of "stable" features.

### 4. Differential Abundance (dsFDR)
Calour uses Discrete False Discovery Rate (dsFDR) which is more powerful for sparse microbiome data than standard BH-FDR.

```python
# Find features different between 'Control' and 'Patient' in the 'Subject' column
# Returns a new Experiment object containing only significant features
diff_exp = exp.diff_abundance('Subject', 'Control', 'Patient', random_seed=2018)
```

### 5. Visualization
Heatmaps are the primary way to interact with Calour.

```python
# In a Jupyter notebook
%matplotlib notebook
exp.plot(sample_field='Subject', gui='jupyter', barx_fields=['Sex'])
```
*   **Interactive Controls**: Use `SHIFT+UP/DOWN` to zoom features and `SHIFT+LEFT/RIGHT` to zoom samples.
*   **Database Integration**: Clicking a feature in the heatmap will automatically query databases like **dbBact** for known annotations.

## Expert Tips

*   **Reproducibility**: `diff_abundance` relies on permutations. Always provide a `random_seed` to ensure the same features are identified across runs.
*   **Logging**: Use `ca.set_log_level(11)` to see informative messages about how many samples/features are being filtered or processed.
*   **Memory Management**: Calour can handle sparse or dense matrices. Use `exp.to_sparse()` for large, sparse microbiome datasets to save memory.
*   **Database Enrichment**: After finding differentially abundant features, use `plot_diff_abundance_enrichment()` to find which biological terms (e.g., "feces", "high fat diet") are statistically enriched in your results.

## Reference documentation
- [Microbiome experiment step-by-step analysis](./references/biocore_github_io_calour_notebooks_microbiome_step_by_step.html.md)
- [Microbiome differential abundance tutorial](./references/biocore_github_io_calour_notebooks_microbiome_diff_abundance.html.md)
- [Microbiome data manipulation tutorial](./references/biocore_github_io_calour_notebooks_microbiome_manipulation.html.md)
- [Microbiome data normalization tutorial](./references/biocore_github_io_calour_notebooks_microbiome_normalization.html.md)
- [Calour Experiment class tutorial](./references/biocore_github_io_calour_notebooks_microbiome_internal_structure.html.md)