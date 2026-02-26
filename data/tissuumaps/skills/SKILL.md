---
name: tissuumaps
description: TissUUmaps is a browser-based tool for interactive exploration and visualization of spatial biological data. Use when user asks to explore spatial datasets, overlay point data on images, prepare data for visualization, launch the viewer, open a project, convert images, save configurations, or share interactive slides.
homepage: https://tissuumaps.research.it.uu.se/
---



# tissuumaps

## Overview
TissUUmaps is a lightweight, browser-based tool designed for the interactive exploration of massive biological datasets. It excels at overlaying high-density point data (such as transcripts from In Situ Sequencing or MerFISH) onto multi-resolution background images (TIF, SVS, or other pyramidal formats). This skill provides the necessary patterns to prepare data and launch the viewer for spatial biology workflows.

## Data Preparation and Usage
TissUUmaps requires two primary components: a background image (usually a pyramidal TIF) and a CSV/H5AD file containing spatial coordinates.

### Common CLI Patterns
To launch the TissUUmaps graphical interface or process files via the command line:

```bash
# Launch the TissUUmaps GUI
tissuumaps

# Open a specific project file (.tmap)
tissuumaps path/to/project.tmap

# Convert a folder of images to a TissUUmaps-compatible pyramidal format
tissuumaps --convert input_folder/ output_folder/
```

### Input Data Requirements
- **Images**: Use `.tif` or `.tiff` files. For optimal performance with large slides, ensure they are converted to OME-TIFF or pyramidal TIFF.
- **Point Data**: CSV files must contain at least `X` and `Y` columns. Additional columns for gene names, quality scores, or cluster IDs can be mapped to marker colors and shapes within the viewer.

### Expert Tips for Visualization
- **Marker Scaling**: When dealing with millions of points, use the "Global marker size" setting to prevent occlusion of the underlying tissue morphology.
- **Project Files (.tmap)**: Always save your configuration (layers, colors, and filters) as a `.tmap` file. This JSON-based file allows for instant reloading of the session and sharing with collaborators.
- **Web Deployment**: TissUUmaps generates static HTML/JS. You can host the output folder on any standard web server (GitHub Pages, Apache, Nginx) to share interactive slides without requiring the recipient to install software.

## Reference documentation
- [TissUUmaps Overview](./references/anaconda_org_channels_bioconda_packages_tissuumaps_overview.md)
- [TissUUmaps Research Documentation](./references/user_it_uu_se__chrav452_tissuumaps.md)