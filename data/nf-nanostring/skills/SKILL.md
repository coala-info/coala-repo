---
name: nanostring
description: This pipeline analyzes NanoString nCounter data by accepting a CSV samplesheet and RCC files to perform quality control, normalization using GEO or GLM methods, and gene score computation. Use when processing NanoString gene expression data to generate normalized count tables, heatmaps, and MultiQC reports for experimental quality assessment.
homepage: https://github.com/nf-core/nanostring
---

# nanostring

## Overview
The nf-core/nanostring pipeline provides a standardized workflow for the analysis of NanoString nCounter data. It addresses the need for reproducible quality control and normalization of raw count data, transforming individual RCC files into integrated datasets suitable for downstream biological interpretation.

Users provide raw RCC files and associated metadata to generate normalized expression matrices. The pipeline handles technical variations through established normalization algorithms and provides visual summaries of the data distribution and sample relationships.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file must contain paths to the raw RCC files and unique identifiers for each sample.

Required columns:
- `SAMPLE_ID`: Unique name for the sample (no spaces).
- `RCC_FILE`: Full path to the `.RCC` file.
- `RCC_FILE_NAME`: The filename of the RCC file.

Optional columns for metadata and filtering:
- `TIME`, `TREATMENT`, `INCLUDE` (0 or 1), and `OTHER_METADATA`.

Example `samplesheet.csv`:
```csv
RCC_FILE,RCC_FILE_NAME,SAMPLE_ID
/path/to/sample1.RCC,sample1.RCC,sample1
/path/to/sample2.RCC,sample2.RCC,sample2
```

Additional configuration files can be provided for gene score computation (`--gene_score_yaml`) or to filter genes for heatmap generation (`--heatmap_genes_to_filter`).

## How to run
Execute the pipeline using the `nextflow run` command. It is recommended to use `-profile` for containerization (e.g., docker or singularity) and `-r` to specify a pipeline version.

```bash
nextflow run nf-core/nanostring \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results
```

Key parameters include:
- `--normalization_method`: Choose between `GEO` (default) or `GLM`.
- `--gene_score_method`: Algorithm for computing gene scores (default: `plage.dir`).
- `--skip_heatmap`: Set to `true` to bypass heatmap generation.
- `-resume`: Use this Nextflow flag to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include normalized count tables, gene score calculations, and a MultiQC report summarizing the run statistics and quality metrics.

If not skipped, the pipeline also produces heatmaps based on the `SAMPLE_ID` or a custom `heatmap_id_column`. For a detailed description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/nanostring/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)