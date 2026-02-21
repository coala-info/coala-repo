---
name: vitessce-python
description: The `vitessce-python` library is the Pythonic interface for Vitessce, a visual analytics framework tailored for multimodal and spatially resolved single-cell experiments.
homepage: https://vitessce.io/
---

# vitessce-python

## Overview
The `vitessce-python` library is the Pythonic interface for Vitessce, a visual analytics framework tailored for multimodal and spatially resolved single-cell experiments. It enables the creation of complex, linked-view dashboards directly from data structures like AnnData or SpatialData. This skill focuses on the object-oriented configuration API to build layouts, coordinate views, and handle large-scale spatial datasets efficiently.

## Installation and Setup
Install the package via bioconda:
```bash
conda install bioconda::vitessce-python
```

## Core Workflow Patterns

### 1. Using EasyVitessce for Rapid Prototyping
For users familiar with Scanpy or SpatialData-Plot, `EasyVitessce` provides a high-level wrapper to generate configurations with minimal code.
- Use `EasyVitessce(dataset=sdata, port=8888)` to quickly visualize a SpatialData object.
- It leverages existing plotting syntax to infer appropriate view types.

### 2. Manual Configuration with VitessceConfig
For custom layouts, use the `VitessceConfig` class:
- **Initialize**: `vc = VitessceConfig(schema_version="1.0.15", name="My Dashboard")`
- **Add Data**: Use wrappers like `AnnDataWrapper` or `SpatialDataWrapper`.
  - `dataset = vc.add_dataset(name='Data').add_object(SpatialDataWrapper(sdata))`
- **Define Views**: Add specific visualization components.
  - `spatial = vc.add_view(cm.SPATIAL, dataset=dataset)`
  - `lc = vc.add_view(cm.LAYER_CONTROLLER, dataset=dataset)`
- **Layout**: Arrange views in a grid.
  - `vc.layout(spatial | lc)`
- **Display**: `vc.widget()`

### 3. Handling SpatialData Elements
Vitessce supports the five core SpatialData elements: tables, points, shapes, labels, and images.
- **Tables**: Map to `obsFeatureMatrix`, `obsSets`, and `obsEmbedding`.
- **Points**: Map to `obsPoints`.
- **Labels**: Map to `obsSegmentations` (bitmasks).
- **Shapes**: Map to `obsSegmentations` (polygons) or `obsSpots` (circles).

## Expert Tips and Optimization

### Visualizing Large Point Sets (e.g., Xenium)
When dealing with tens of millions of transcripts, Vitessce requires a tiling approach to prevent browser memory crashes.
- **Morton Order**: Use the utility functions in `vitessce-python` to sort the Points dataframe in Morton order (Z-order curve). This enables efficient spatial indexing and viewport-based loading.
- **Tiling**: Ensure the data is prepared to allow Vitessce to load only the subset of points within the current viewport.

### Visium HD and Rasterization
For high-resolution Visium HD data:
- Use `rasterize_bins` and `rasterize_bins_link_table_to_labels` from the `spatialdata` package before wrapping the object for Vitessce. This converts dense bin data into a format optimized for web rendering.

### Coordination and Linking
- **link_views_by_object**: Use this method to automatically coordinate multiple views (e.g., linking zoom and pan across two different spatial views).
- **Multi-level Coordination**: For complex setups (like per-channel segmentation bitmasks), use `add_coordination` to control properties like opacity or visibility independently for different layers.

## Reference documentation
- [Vitessce Python Overview](./references/anaconda_org_channels_bioconda_packages_vitessce-python_overview.md)
- [Vitessce Documentation](./references/vitessce_io_docs.md)
- [SpatialData Support Blog](./references/vitessce_io_blog.md)