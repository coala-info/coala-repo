---
name: novae
description: Novae is a graph-based foundation model for spatial domain assignment and representation learning in spatial omics data. Use when user asks to perform zero-shot spatial domain inference, fine-tune models on specific tissue datasets, or integrate H&E staining with spatial transcriptomics.
homepage: https://mics-lab.github.io/novae/
metadata:
  docker_image: "quay.io/biocontainers/novae:1.0.2--pyhdfd78af_0"
---

# novae

## Overview
Novae is a graph-based foundation model designed for spatial domain assignment in spatial omics. It transforms raw spatial data into meaningful biological regions by leveraging self-supervised learning on cell-connectivity graphs. This skill enables users to perform zero-shot inference using pretrained models, fine-tune models on specific datasets, and integrate multimodal information like H&E staining to refine spatial analysis.

## Core Workflow

### 1. Data Preparation
Novae operates on `AnnData` objects. Ensure your data includes spatial coordinates in `adata.obsm["spatial"]`.

```python
import novae
# Load example data or your own AnnData
adata = novae.load_dataset(tissue="colon", species="human")[0]
```

### 2. Spatial Graph Construction
The foundation of Novae is the spatial connectivity graph. Use `spatial_neighbors` to define how cells/spots relate to one another.

*   **Single-cell resolution:** Use a radius (e.g., 80 microns) to prune long edges.
*   **Spot resolution (Visium):** The tool automatically handles grid-based neighbors.

```python
# For single-cell data, set a radius in microns
novae.spatial_neighbors(adata, radius=80)

# Quality control: Check if too many cells are isolated (red nodes)
novae.plot.connectivities(adata)
```

### 3. Model Inference
Load a pretrained model suitable for your species (e.g., `novae-human-0` or `novae-mouse-0`).

```python
# Load pretrained foundation model
model = novae.Novae.from_pretrained("MICS-Lab/novae-human-0")

# Option A: Zero-shot inference (fast)
model.compute_representations(adata, zero_shot=True)

# Option B: Fine-tuning (recommended for specific tissues)
model.fine_tune(adata, accelerator="cuda") # Use GPU if available
model.compute_representations(adata)
```

### 4. Domain Assignment and Visualization
Novae uses a hierarchical approach to domains. You can assign domains at different "levels" of granularity.

```python
# Assign domains at a specific resolution level
model.assign_domains(adata, level=7)

# Visualize the results
novae.plot.domains(adata)

# View the hierarchical relationship between domains
model.plot_domains_hierarchy()
```

## Advanced Usage

### Multimodal Integration (H&E)
If H&E images are available, Novae can incorporate morphology via the `sopa` and `spatialdata` backends.

1.  Compute patch embeddings using a vision model (e.g., CONCH).
2.  Assign these embeddings to cells using `compute_histo_pca`.
3.  Initialize the Novae model with the multimodal `AnnData`.

### Batch Effect Correction
When working with multiple slides or technologies, use Novae's native correction to align representations before domain assignment.

```python
# Correct representations across multiple AnnData objects
novae.batch_effect_correction(adatas, obs_key="novae_domains_7")
```

## Expert Tips
*   **Coordinate Systems:** Always verify if your spatial coordinates are in microns or pixels. For pixel-based systems (common in proteomics), the `radius` in `spatial_neighbors` must be significantly higher.
*   **GPU Acceleration:** For datasets >100k cells, always pass `accelerator="cuda"` and `num_workers > 0` to `fine_tune` and `compute_representations`.
*   **Memory Management:** If memory is an issue, Novae supports `AnnData` in backed mode or using Dask arrays for `adata.X`.
*   **Protein Data:** When using Novae for proteomics, skip the pretrained transcriptomics models and train a model from scratch using `model.fit(adata)`.

## Reference documentation
- [Main Usage Tutorial](./references/mics-lab_github_io_novae_tutorials_main_usage.md)
- [Novae Model API](./references/mics-lab_github_io_novae_api_Novae.md)
- [Input Modes Guide](./references/mics-lab_github_io_novae_tutorials_input_modes.md)
- [H&E Multimodal Tutorial](./references/mics-lab_github_io_novae_tutorials_he_usage.md)
- [Proteomics Tutorial](./references/mics-lab_github_io_novae_tutorials_proteins.md)