---
name: rangeland
description: This pipeline processes satellite imagery from Landsat or Sentinel-2 alongside digital elevation models, water vapor databases, and endmember definitions to generate atmospherically corrected images and vegetation trend files. Use when performing long-term geographical analysis of rangeland systems to produce level 3 time series data, mosaics, and pyramid visualizations for land-cover change monitoring.
homepage: https://github.com/nf-core/rangeland
---

# rangeland

## Overview
nf-core/rangeland is a geographical analysis pipeline designed for processing remotely sensed imagery to monitor land-cover changes. It solves the problem of scaling complex Earth Observation workflows by integrating atmospheric correction, linear spectral unmixing, and time series analysis into a single automated framework.

The pipeline transforms raw satellite data into "Analysis Ready Data" (Level 2) and subsequently into trend-based "Level 3" products. Users receive standardized vegetation indices, trend files, and multi-resolution visualizations suitable for assessing ecological dynamics over large temporal and spatial scales.

## Data preparation
The pipeline requires several specific input datasets and directory structures as defined by the FORCE (Framework for Operational Radiometric Correction for Environmental monitoring) standard:

*   **Satellite Imagery (`--input`)**: A root directory or tarball containing satellite data. The structure must match the format of data downloaded via `force-level1-csd`.
*   **Digital Elevation Model (`--dem`)**: A directory containing a subdirectory of tile-wise `.tif` files and a corresponding `.vrt` virtual dataset file.
*   **Water Vapor Database (`--wvdb`)**: A directory containing global water vapor text files and a `.coo` coordinate reference file.
*   **Datacube Definition (`--data_cube`)**: A single `.prj` file describing the projection and reference grid.
*   **Area of Interest (`--aoi`)**: A vector file in `.gpkg` or `.shp` format specifying the spatial extent.
*   **Endmember Specification (`--endmember`)**: A `.txt` file where rows correspond to satellite bands and columns correspond to endmembers (reflectance values separated by spaces).

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use `-profile` for software containerization (e.g., docker or singularity) and `-r` to pin a specific version.

```bash
nextflow run nf-core/rangeland \
   -profile docker \
   --input ./path/to/satellite_data/ \
   --dem ./path/to/dem/ \
   --wvdb ./path/to/wvdb/ \
   --data_cube ./path/to/cube.prj \
   --aoi ./path/to/area.gpkg \
   --endmember ./path/to/endmembers.txt \
   --outdir ./results/
```

Key parameters for controlling output depth include `--save_ard` to publish Level 2 analysis-ready data and `--save_tsa` to publish Level 3 time series analysis results. Use `-resume` to restart a run from the last successful step if interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

*   **Visualizations**: Mosaic and pyramid files (if `--mosaic_visualization` or `--pyramid_visualization` are enabled) for easy viewing of trends.
*   **Trend Files**: Level 3 data products derived from time series analysis of vegetation dynamics.
*   **Analysis Ready Data**: Level 2 atmospherically corrected images (if `--save_ard` is set).
*   **Reports**: A MultiQC report summarizing processing statistics and software versions.

For a comprehensive list of output files and directory structures, refer to the [official output documentation](https://nf-co.re/rangeland/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)