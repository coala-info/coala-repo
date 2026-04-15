---
name: molkart
description: This pipeline processes Molecular Cartography data from Resolve Bioscience by taking FISH spot tables and TIFF images to perform image preprocessing, cell segmentation using tools like Cellpose or Mesmer, and spot-to-cell assignment. Use when analyzing combinatorial FISH datasets that require grid-gap filling with Mindagap, automated cell segmentation, and the generation of matched cell-by-transcript matrices and quality control metrics.
homepage: https://github.com/nf-core/molkart
---

# molkart

## Overview
nf-core/molkart is designed for the end-to-end processing of Molecular Cartography data, a combinatorial FISH technology. It addresses the challenge of converting raw image data and transcript spot coordinates into a structured cell-by-gene expression matrix while accounting for technical artifacts like grid patterns.

The pipeline handles image preprocessing to fill gaps, performs cell segmentation using various deep learning or classical methods, and assigns detected transcript spots to individual cells. The final outputs provide researchers with the necessary data for downstream spatial transcriptomics analysis and comprehensive quality metrics.

## Data preparation
The primary input is a CSV samplesheet where each row represents a field-of-view (FOV). The spot table must be a tab-separated file without a header containing columns for x, y, z, and gene.

Example `samplesheet.csv`:
```csv
sample,nuclear_image,spot_locations,membrane_image
sample0,sample0_DAPI.tiff,sample0_spots.txt,sample0_WGA.tiff
```

- `sample`: Unique identifier for the FOV (must not contain spaces).
- `nuclear_image`: Path to the DAPI/nuclear image in `.tif` or `.tiff` format.
- `spot_locations`: Path to the transcript spot table (`.txt` or `.tsv`).
- `membrane_image`: Optional path to an additional staining image (e.g., WGA) to assist segmentation.

The pipeline can also create training subsets for segmentation models using the `--create_training_subset` parameter, which extracts small crops from the input images.

## How to run
Standard execution requires the input samplesheet and an output directory. Users can select segmentation methods via `--segmentation_method` (options include `mesmer`, `cellpose`, `stardist`, or `ilastik`).

```bash
nextflow run nf-core/molkart \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  --segmentation_method mesmer \
  -resume
```

Key parameters include:
- `--segmentation_method`: Comma-separated list of tools (default: `mesmer`).
- `--skip_mindagap`: Use if data does not contain gaps between tiles.
- `--skip_clahe`: Use to skip contrast-limited adaptive histogram equalization.
- `-r`: Pin a specific pipeline release version.

## Outputs
Results are saved to the directory specified by `--outdir`. The primary deliverable is a matched cell-by-transcript table based on deduplicated spots and segmented cell masks.

Key outputs include:
- **MultiQC Report**: Contains pipeline-specific quality metrics such as spot assignment rates, average spots per cell, and segmentation mask size ranges.
- **Preprocessing**: Intermediary files including gap-filled images (Mindagap) and contrast-adjusted TIFFs.
- **Segmentation**: Mask files and optional flow fields (if using Cellpose).
- **Spot Processing**: Deduplicated spot tables and final cell-by-gene matrices.

For more details about the output files and reports, refer to the official [output documentation](https://nf-co.re/molkart/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)