---
name: deepmodeloptim
description: This pipeline facilitates the development and optimization of deep learning models for genomics by processing input data CSVs, Python model files, and configuration YAMLs to perform task-specific training and hyperparameter tuning. Use when seeking to augment biological data for optimal training sets or when performing hyperparameter searches using Ray Tune specifications for PyTorch-based genomic models.
homepage: https://github.com/nf-core/deepmodeloptim
---

# deepmodeloptim

## Overview
nf-core/deepmodeloptim is an end-to-end pipeline designed to facilitate the testing and development of deep learning models for genomics. It addresses the principle that model performance is largely driven by training data quality and quantity, providing a framework to augment biological data towards an optimal task-specific training set.

The pipeline integrates data preprocessing, model training, and hyperparameter tuning. Users provide their own PyTorch model architectures and data configurations, allowing for flexible experimentation across different genomic modalities and prediction tasks.

## Data preparation
The primary input is a CSV file where header columns follow a specific `name:type:class` format. The `name` is user-defined, `type` must be "input", "meta", or "label", and `class` defines the data encoding (e.g., "dna" or "float").

A mandatory `experiment_config` (JSON or YAML) defines data manipulation parameters, while a `model_config` YAML specifies hyperparameter directives and Ray Tune specs. The Python model file must contain exactly one class starting with `Model` and include a `batch` function for training and evaluation steps.

Example CSV structure:
```csv
mouse_dna:input:dna,mouse_rnaseq:label:float
ACTAGGCATGCTAGTCG,0.53
ACTGGGGCTAGTCGAA,0.23
```

The pipeline also supports a standard nf-core samplesheet format for FASTQ data if required by the specific preprocessing configuration.

## How to run
Run the pipeline using the `nextflow run` command, specifying the required data, model, and configuration paths. Use `-profile` to select the container engine (e.g., docker, singularity) and `-r` to pin a specific version.

```bash
nextflow run nf-core/deepmodeloptim \
   -profile docker \
   --data data.csv \
   --data_config data_config.json \
   --model model.py \
   --model_config model_config.yaml \
   --outdir ./results
```

Key parameters include `--tune_replicates` for multiple tuning runs, `--max_gpus` to limit hardware resources, and `--save_data` to export transformed CSV data. Use `-resume` to continue a previous run from the last successful step.

## Outputs
Results are saved to the directory specified by `--outdir`, which contains subdirectories unique to each pipeline run. Key deliverables include:

*   **Tuning Results:** Hyperparameter optimization logs and best-performing model parameters.
*   **Transformed Data:** If `--save_data` is set, the pipeline exports the processed CSV data used for training.
*   **Model Weights:** Initial and trained weights for the PyTorch models.

For more details about the output files and reports, refer to the official [output documentation](https://nf-co.re/deepmodeloptim/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)