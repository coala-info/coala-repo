---
name: bin2cell
description: bin2cell is a specialized tool for the analysis of high-resolution Visium HD spatial transcriptomics data.
homepage: https://github.com/Teichlab/bin2cell
---

# bin2cell

## Overview

bin2cell is a specialized tool for the analysis of high-resolution Visium HD spatial transcriptomics data. While standard workflows often aggregate data into 8um bins, bin2cell utilizes the 2um resolution to reconstruct individual cells more accurately. It achieves this by grouping bins based on segmentation masks derived from morphology images (H&E or DAPI) or gene expression visualizations. The tool also includes specific algorithms to correct for technical "striping" effects caused by variable bin dimensions, resulting in a cleaner cell-by-gene matrix for downstream single-cell analysis.

## Usage Instructions

### Installation and Environment
To use the full suite of bin2cell features, including automated segmentation, ensure the correct dependencies are installed:

- **Standard install**: `pip install bin2cell`
- **With segmentation support**: `pip install bin2cell[stardist]`
- **Requirement**: TensorFlow is required for StarDist-based segmentation. The CPU version is typically sufficient for standard Visium HD slides.

### Core Workflow Patterns

1. **Segmentation**:
   Use `b2c.stardist()` to perform nuclear segmentation on the high-resolution morphology image. This creates the masks used to assign 2um bins to specific cells.

2. **Bin-to-Cell Assignment**:
   The primary function `b2c.bin_to_cell()` maps the transcriptomic data from the 2um bins to the segmented objects. This step transforms the data from a grid-based bin format to a cell-based AnnData object.

3. **Technical Effect Correction**:
   Visium HD data often exhibits a "striping" effect due to hardware-related variations in bin dimensions. Apply `b2c.destripe()` to the expression data to normalize these artifacts before performing clustering or cell-type annotation.

4. **Quality Control and Visualization**:
   - Use `b2c.view_labels()` to overlay segmentation masks on morphology images to verify accuracy.
   - Check the overlap between spatial bin coordinates and source image dimensions to ensure proper alignment.

### Expert Tips

- **Resolution Choice**: Always start with the 2um bin data. Aggregating from 2um to cells provides higher biological fidelity than using the pre-aggregated 8um bins provided by SpaceRanger.
- **Memory Management**: Visium HD datasets are large. When working with `bin_to_cell`, ensure you have sufficient RAM or process the slide in tiles if necessary.
- **R Compatibility**: If downstream analysis is required in R (e.g., Seurat), export the final object as an `.h5ad` file and use the `schard` package to read it into an R environment.
- **Segmentation Alternatives**: While StarDist is the default, you can import segmentation masks from other tools like QuPath or CellPose, provided they are formatted as label images compatible with the bin coordinates.

## Reference documentation
- [bin2cell GitHub Repository](./references/github_com_Teichlab_bin2cell.md)
- [bin2cell Overview](./references/anaconda_org_channels_bioconda_packages_bin2cell_overview.md)