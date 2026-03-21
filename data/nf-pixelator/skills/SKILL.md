---
name: pixelator
description: This pipeline processes Proximity Network Assay (PNA) data from FASTQ files using a samplesheet to generate PXL files containing single-cell protein abundance and interactomics data. Use when analyzing single-cell protein-protein interactions or spatial protein information, noting that Molecular Pixelation (MPX) data is only supported in versions 2.3.1 and earlier.
homepage: https://github.com/nf-core/pixelator
---

## Overview
nf-core/pixelator is a bioinformatics pipeline designed for the analysis of Proximity Network Assay (PNA) data. It transforms raw sequencing reads into single-cell protein abundance and interactomics datasets by modeling protein-protein interactions as a graph.

The pipeline produces PXL files which encapsulate the graph-based representation of cells, including spatial information and 3D layouts. These results enable the study of the "proxiome," providing insights into how proteins are organized and interact on the cell surface.

## Data preparation
Input is provided via a samplesheet in CSV, TSV, or YAML format. The samplesheet defines the sample names, experimental design, antibody panels, and paths to the raw sequencing data.

Required columns:
- `sample`: Unique sample name without spaces.
- `design`: Design identifier (e.g., `pna-2`).
- `fastq_1`: Path to the first gzipped FASTQ file.

Optional columns:
- `fastq_2`: Path to the second gzipped FASTQ file.
- `panel`: Panel identifier.
- `panel_file`: Path to a custom panel file (.csv, .tsv, or .yaml).
- `sample_alias`: Alternative sample name.
- `condition`: Experimental condition.

Example `samplesheet.csv`:
```csv
sample,sample_alias,condition,design,panel,fastq_1,fastq_2
sample1,s1,control,pna-2,proxiome-immuno-155-v2,sample1_R1_001.fastq.gz,sample1_R2_001.fastq.gz
```

Note: This pipeline does not support Conda environments; users must use Docker or Singularity.

## How to run
The pipeline is executed using the `nextflow run` command. It is recommended to pin a specific version using `-r` and use `-resume` for incremental runs.

```bash
nextflow run nf-core/pixelator \
   -profile <docker/singularity> \
   -r 2.4.0 \
   --input samplesheet.csv \
   --outdir ./results \
   -resume
```

Key parameters:
- `-profile`: Specifies the software container engine (e.g., `docker`, `singularity`).
- `--input`: Path to the prepared samplesheet.
- `--outdir`: Directory where results will be saved.
- `--skip_denoise`: Optional flag to skip the denoising step.
- `--skip_analysis`: Optional flag to skip spatial analysis.

## Outputs
Results are organized in the directory specified by `--outdir`. The primary deliverables include:

- **PXL Files**: The main data format containing single-cell protein abundance and interactomics data.
- **3D Layouts**: Visualization files for cell graphs (e.g., `wpmds_3d`).
- **Proxiome Experiment Summary**: A summary report generated using PixelatorES.
- **JSON Reports**: Metadata and quality control reports for each processing stage.

For a detailed description of all output files, refer to the official documentation at [https://nf-co.re/pixelator/output](https://nf-co.re/pixelator/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
