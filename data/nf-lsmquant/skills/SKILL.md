---
name: lsmquant
description: This pipeline processes raw 2D single-channel 16-bit TIF images from directories or zip archives using a samplesheet and sample-specific parameter CSVs to perform 3D reconstruction, tile stitching, and optional nuclei quantification or Allen Reference Atlas registration. Use when analyzing light-sheet microscopy data from tissue-cleared samples, specifically for whole-brain imaging or cellular phenotyping based on the NuMorph toolbox.
homepage: https://github.com/nf-core/lsmquant
---

# lsmquant

## Overview
nf-core/lsmquant is designed for the preprocessing and analysis of large-scale light-sheet microscopy images from tissue-cleared samples, such as whole brains. It automates the transition from raw 2D image tiles to a reconstructed 3D volume, enabling high-throughput morphometric analysis.

The pipeline addresses common challenges in light-sheet data, including intensity adjustment and tile stitching. By integrating the NuMorph toolbox, it provides specialized workflows for quantifying cell nuclei and registering images to the Allen Reference Atlas for anatomical context.

## Data preparation
Users must provide a CSV samplesheet via the `--input` parameter. Each row represents a sample and requires three columns:
*   `sample_id`: Unique identifier for the sample (cannot contain spaces).
*   `img_directory`: Path to a folder or zip archive containing 2D single-channel 16-bit `tif` files.
*   `parameter_file`: Path to a sample-specific CSV containing processing parameters.

A template for the sample-specific parameter file is located in the `assets/params_template_lsmquant.csv` file within the pipeline repository.

Example `samplesheet.csv`:
```csv
sample_id,img_directory,parameter_file
TEST1,path/to/image-files,path/to/parameter/file.csv
```

## How to run
The pipeline requires a mandatory `--stage` parameter to define the reconstruction workflow. Available stages include `int_align_stitch` (intensity adjustment, alignment, and stitching), `int_stitch` (intensity adjustment and stitching), or `stitch_only`.

```bash
nextflow run nf-core/lsmquant \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results \
  --stage int_align_stitch \
  --nuclei_quantification \
  --ara_registration
```

Use `-r` to specify a pipeline version and `-resume` to restart a run from the last successful step. Optional analysis steps like `--nuclei_quantification` and `--ara_registration` can be enabled as needed. If performing nuclei quantification, a pre-trained model can be specified via `--model_file`.

## Outputs
Results are saved to the directory specified by `--outdir`. Primary outputs include:
*   Reconstructed 3D image volumes.
*   Cell nuclei segmentation masks and quantification results (if enabled).
*   Transformed images and registration data for the Allen Reference Atlas (if enabled).
*   A MultiQC report summarizing pipeline metrics and quality control.

For a comprehensive description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/lsmquant/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)