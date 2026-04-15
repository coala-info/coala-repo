---
name: curlywhirly
description: CurlyWhirly is a high-performance 3D visualization tool that transforms complex multi-dimensional coordinate data into interactive scatter plots. Use when user asks to visualize biological data in 3D, explore spatial relationships within large datasets, or filter data points based on metadata categories.
homepage: https://ics.hutton.ac.uk/curlywhirly
metadata:
  docker_image: "quay.io/biocontainers/curlywhirly:1.17.08.31--0"
---

# curlywhirly

## Overview
CurlyWhirly is a high-performance 3D visualization tool specifically optimized for biological and genetic data. It transforms complex multi-dimensional coordinate data into interactive 3D scatter plots. It is designed to handle tens of thousands of data points efficiently, providing a hierarchical filtering system based on metadata categories. Use this tool when you need to move beyond static 2D plots to explore the spatial relationships and clusters within your data, or when you need to link specific data points to external genomic databases.

## Data Preparation and Input
To ensure successful data import, structure your input files (typically tab-delimited) according to these functional requirements:

*   **Column Ordering**: The standard format expects a label column, followed by categorical metadata columns, and finally the numerical coordinates (X, Y, Z).
*   **Optional Labels**: Since version 1.19.03.26, the label can be the first column and categories are optional. You no longer need to provide empty category columns if they are not used.
*   **External Linking**: You can include columns containing URLs. CurlyWhirly supports multiple URLs per data point, allowing you to right-click a point in the 3D view to open associated database entries (e.g., in Germinate or other information systems).
*   **File Extension**: Use the `.cw` extension for your data files to enable automatic association and opening with the application.

## Functional Best Practices
*   **Navigation**: 
    *   **Rotate**: Click and drag on the display.
    *   **Zoom**: Use the mouse scroll wheel or keyboard shortcuts.
    *   **Auto-Spin**: Enable the auto-spin feature for presentations; the spin speed can be adjusted in real-time via the UI slider.
*   **Filtering and Selection**:
    *   **Categorical Filtering**: Use the control panel to toggle visibility of specific groups. Deselected points can be rendered as transparent, greyscale, or completely invisible to highlight specific clusters.
    *   **Multi-Selection Sphere**: Right-click a data point to create a selection sphere. Use the slider to adjust the sphere's radius, capturing all points within that 3D volume. This is the most efficient way to isolate local clusters.
    *   **Data Table**: Use the "Data" tab to view a sortable list of points currently active in the display. You can toggle selection states directly from this table.
*   **Performance Optimization**:
    *   For datasets exceeding 50,000 points, go to the control panel and reduce the **Sphere Quality**. This reduces the polygon count per point and significantly improves frame rates on modest hardware.
    *   Monitor the FPS counter in the bottom right to determine if quality adjustments are necessary.

## Exporting Results
*   **Screenshots**: Use the "Capture Screenshot" function to generate high-resolution images. You can optionally include a color key (legend) that maps colors to your metadata categories.
*   **Movies**: For dynamic presentations, use the movie capture support while the auto-spin feature is active.
*   **Data Export**: You can export the currently selected or filtered subset of data. This export includes customized UI colors (background, axes) and any modified category colors.

## Installation
The tool is available via Bioconda for headless or managed environments:
```bash
conda install bioconda::curlywhirly
```

## Reference documentation
- [CurlyWhirly Overview](./references/ics_hutton_ac_uk_curlywhirly.md)
- [CurlyWhirly Release Notes](./references/ics_hutton_ac_uk_curlywhirly_download-curlywhirly_curlywhirly-release-notes.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_curlywhirly_overview.md)