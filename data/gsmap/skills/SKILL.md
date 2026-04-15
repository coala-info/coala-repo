---
name: gsmap
description: The gsmap tool projects human complex trait information onto spatial transcriptomic maps to identify where specific traits are biologically active within a tissue. Use when user asks to perform genetically informed spatial mapping, run spatial LDSC analyses, calculate gene specificity scores, or visualize trait-tissue associations from summary statistics.
homepage: https://github.com/LeonSong1995/gsMap
metadata:
  docker_image: "quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0"
---

# gsmap

## Overview

The `gsmap` (genetically informed spatial mapping) tool is a specialized bioinformatics pipeline designed to bridge the gap between genetic association studies and spatial biology. It allows researchers to project human complex trait information onto spatial transcriptomic maps, providing a high-resolution view of where specific traits are biologically active within a tissue. 

This skill enables the execution of both the streamlined "Quick Mode" for standard analyses and the "Step-by-Step" mode for customized workflows involving specific genomic windows, enhancer-gene linking, or biological replicates.

## Core Workflows

### 1. Quick Mode Execution
Use `quick_mode` for a streamlined pipeline using pre-calculated weights and standard reference panels.

```bash
gsmap quick_mode \
    --workdir './output' \
    --sample_name 'sample_id' \
    --gsMap_resource_dir 'path/to/resources' \
    --hdf5_path 'data.h5ad' \
    --annotation 'obs_column_name' \
    --data_layer 'count' \
    --sumstats_file 'trait.sumstats.gz' \
    --trait_name 'TraitName' \
    --homolog_file 'homologs.txt' # Required if ST data is non-human
```

### 2. Step-by-Step Customization
For advanced control, execute the pipeline stages individually:

1.  **Latent Representation**: `gsmap run_find_latent_representations` (Generates `latent_GVAE` embeddings).
2.  **Gene Specificity Scores (GSS)**: `gsmap run_latent_to_gene` (Aggregates info from homogeneous spots).
3.  **LD Score Generation**: `gsmap run_generate_ldscore` (Assigns GSS to SNPs).
4.  **Spatial LDSC**: `gsmap run_spatial_ldsc` (The core association step).
5.  **Cauchy Combination**: `gsmap run_cauchy_combination` (Aggregates spot p-values into regions/cell types).
6.  **Reporting**: `gsmap run_report` (Generates HTML visualizations).

### 3. Data Preparation Utilities
*   **GWAS Formatting**: Convert raw summary stats to the required format (SNP, A1, A2, Z, N).
    ```bash
    gsmap format_sumstats --sumstats 'raw_file' --out 'formatted_name'
    ```
*   **Biological Replicates**: Calculate a uniform slice mean across multiple samples for consistency.
    ```bash
    gsmap create_slice_mean --sample_name_list S1 S2 --h5ad_list S1.h5ad S2.h5ad --slice_mean_output_file 'mean.parquet'
    ```

## Expert Tips and Best Practices

*   **Memory Management**: The `run_generate_ldscore` and `run_spatial_ldsc` steps are memory-intensive. If you encounter OOM (Out of Memory) errors, reduce the `--spots_per_chunk` parameter (default is often 1000, requiring ~40GB RAM).
*   **SNP-to-Gene Linking**: You have three strategies for LD score generation:
    *   **TSS Only**: Use `--gene_window_size` (e.g., 50000).
    *   **Enhancer Only**: Use `--enhancer_annotation_file` and `--gene_window_enhancer_priority 'enhancer_only'`.
    *   **Hybrid**: Use both, prioritizing one via `--gene_window_enhancer_priority`.
*   **Species Mapping**: When working with mouse or macaque data, always provide the `--homolog_file`. The first column must be the ST species gene names, and the second column must be the human (GWAS) gene names.
*   **Annotation-Free Runs**: `gsmap` can run without prior cell type annotations. You can leave the `--annotation` parameter unset or use spatial clustering results (e.g., from SpaGCN) as the annotation input.
*   **Conditional Analysis**: To adjust for other functional annotations, use the `--additional_baseline_annotation` flag during the LD score generation step.



## Subcommands

| Command | Description |
|---------|-------------|
| gsMap create_slice_mean | Calculates the mean expression for each slice across specified samples. |
| gsMap run_find_latent_representations | Find latent representations using GAT. |
| gsMap run_generate_ldscore | Generate LD scores for a given sample, chromosome, and genotype data. |
| gsmap | gsMap: error: argument subcommand: invalid choice: 'Generate' (choose from quick_mode, run_find_latent_representations, run_latent_to_gene, run_generate_ldscore, run_spatial_ldsc, run_cauchy_combination, run_report, format_sumstats, create_slice_mean) |
| gsmap_format_sumstats | Format GWAS summary statistics for use with gsMap. |
| gsmap_quick_mode | Performs a quick mode analysis with gsMap. |
| gsmap_run_cauchy_combination | Combines Cauchy results for multiple samples. |
| gsmap_run_latent_to_gene | Converts latent representations to gene expression. |
| gsmap_run_report | Generate a report for a GWAS analysis. |
| gsmap_run_spatial_ldsc | Run spatial LDSC analysis |

## Reference documentation
- [Mouse Embryo (Quick Mode)](./references/yanglab_westlake_edu_cn_gps_data_website_docs_html_quick_mode.html.md)
- [Mouse Embryo (Step by Step)](./references/yanglab_westlake_edu_cn_gps_data_website_docs_html_step_by_step.html.md)
- [gsMap Advanced Usage](./references/yanglab_westlake_edu_cn_gps_data_website_docs_html_advanced_usage.html.md)
- [Data Format Requirements](./references/yanglab_westlake_edu_cn_gps_data_website_docs_html_data_format.html.md)