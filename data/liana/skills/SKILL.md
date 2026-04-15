---
name: liana
description: LIANA+ is a framework for decoding cell-cell communication by providing a unified interface to multiple inference methods for single-cell and spatial transcriptomics. Use when user asks to infer ligand-receptor interactions, perform spatial bivariate analysis, compare multi-sample communication patterns via tensor factorization, or visualize intercellular connectivity.
homepage: https://liana-py.readthedocs.io
metadata:
  docker_image: "quay.io/biocontainers/liana:1.7.1--pyhdfd78af_0"
---

# liana

## Overview
LIANA+ is a versatile and scalable framework designed to decode the complex language of cell-cell communication. Rather than being a single algorithm, it serves as a unified portal to multiple established CCC inference methods (such as CellPhoneDB, CellChat, and NATMI). It is deeply integrated with the `scverse` ecosystem, utilizing `AnnData` and `MuData` objects to handle single-cell and spatially-resolved transcriptomics. Use this skill to navigate the selection of methods based on data modality—whether you are performing steady-state inference, spatial bivariate analysis, or multi-sample tensor factorization.

## Usage and Best Practices

### Method Selection Logic
Choose the appropriate LIANA+ method based on your data's characteristics:
- **Single-Cell RNA-seq (Non-spatial):** Use `liana.method.rank_aggregate` to combine results from multiple methods for robust ligand-receptor (LR) inference.
- **Spatial Transcriptomics (Spot-based):** Use `liana.method.bivariate` for local or global metrics to identify co-localized LR pairs.
- **Spatial Transcriptomics (Single-cell resolution):** Use `Inflow` scores to account for spatial proximity.
- **Multi-sample/Condition Comparisons:** Use `liana.multi.to_tensor_c2c` for Tensor-cell2cell factorization or `liana.multi.nmf` for intercellular context decomposition.
- **Unsupervised Spatial Relationships:** Use `MISTy` (Multi-view learning) to model how different spatial views (e.g., intra-view vs. juxta-view) explain marker expression.

### Core Workflow Patterns
1. **Resource Management:**
   Always check available ligand-receptor resources before starting. Use `liana.resource.show_resources()` to see options like Consensus, CellPhoneDB, or Guide2Pharma. Select one using `liana.resource.select_resource`.

2. **Running Inference:**
   Most methods are called directly on an `AnnData` object.
   ```python
   import liana
   # Basic rank aggregate approach
   liana.method.rank_aggregate(adata, groupby='cell_type', resource='consensus')
   ```

3. **Handling Complexes:**
   LIANA+ automatically handles heteromeric complexes. If you need to inspect the underlying subunits, use `liana.resource.explode_complexes`.

4. **Spatial Neighbors:**
   For spatial workflows, ensure the spatial neighbor graph is computed using `liana.utils.spatial_neighbors` before running bivariate or MISTy methods.

### Visualization Tips
- **Dotplots:** Use `liana.plotting.dotplot` to visualize the magnitude and specificity of interactions across cell-type pairs.
- **Connectivity:** Use `liana.plotting.connectivity` to generate chord diagrams or heatmaps showing the global "who-talks-to-whom" summary.
- **Factor Loadings:** When using Tensor-cell2cell or MOFAcellular, use `liana.utils.get_variable_loadings` to identify which LR pairs drive specific intercellular contexts.

### Expert Tips
- **Permutations:** For large datasets, avoid excessive permutations if using `rank_aggregate`, as the consensus approach provides robust ranking without high computational overhead.
- **Metabolite-mediated CCC:** LIANA+ can infer communication mediated by metabolites by using specialized resources that link metabolic enzymes to receptors.
- **Data Normalization:** Ensure your `AnnData` object contains log-normalized counts in `adata.X` or a specified layer, as most CCC methods assume normalized expression levels.

## Reference documentation
- [LIANA+ Overview](./references/anaconda_org_channels_bioconda_packages_liana_overview.md)
- [LIANA+ Documentation and API](./references/liana-py_readthedocs_io_en_latest.md)