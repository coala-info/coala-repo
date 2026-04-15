---
name: proteinfold
description: This pipeline predicts protein 3D structures using AlphaFold2, ColabFold, or ESMFold from input FASTA files and a samplesheet, supporting both monomer and multimer presets. Use when performing high-throughput protein folding analysis on various compute infrastructures, though it requires significant database setup or API access for MSA generation.
homepage: https://github.com/nf-core/proteinfold
---

# proteinfold

## Overview
nf-core/proteinfold is a bioinformatics best-practice analysis pipeline for Protein 3D structure prediction. It provides a unified interface to run several state-of-the-art folding algorithms including AlphaFold2, ColabFold, and ESMFold, handling the complex environment and database requirements for each.

The pipeline accepts protein sequences in FASTA format and produces predicted 3D structure models (PDB files) along with quality metrics. It is designed to be portable and reproducible, utilizing Docker or Singularity containers to manage the heavy computational dependencies required for structural biology workflows.

## Data preparation
The pipeline requires a CSV samplesheet and the corresponding protein FASTA files. The samplesheet must contain two columns: `sequence` (a unique identifier) and `fasta` (the path to the FASTA file).

**Samplesheet example (`samplesheet.csv`):**
```csv
sequence,fasta
protein_1,data/protein_1.fasta
protein_2,data/protein_2.fasta
```

The pipeline also requires large database files and model parameters for AlphaFold2, ColabFold, or ESMFold. These can be downloaded automatically by the pipeline or provided via local paths using parameters like `--alphafold2_db`, `--colabfold_db`, or `--esmfold_db`. If using AlphaFold2, users can choose between the full BFD database or a reduced version using `--full_dbs true/false`.

## How to run
Run the pipeline using the `nextflow run` command. You must specify a execution profile (e.g., `docker`, `singularity`, or `conda`) and the prediction mode.

**AlphaFold2 mode:**
```bash
nextflow run nf-core/proteinfold \
    -profile <docker/singularity> \
    --input samplesheet.csv \
    --outdir ./results \
    --mode alphafold2 \
    --alphafold2_model_preset monomer \
    --use_gpu true
```

**ColabFold mode (using webserver):**
```bash
nextflow run nf-core/proteinfold \
    -profile <docker/singularity> \
    --input samplesheet.csv \
    --outdir ./results \
    --mode colabfold \
    --colabfold_server webserver
```

**ESMFold mode:**
```bash
nextflow run nf-core/proteinfold \
    -profile <docker/singularity> \
    --input samplesheet.csv \
    --outdir ./results \
    --mode esmfold \
    --esmfold_model_preset monomer
```

Key parameters include `-r` for pinning a specific version, `-resume` for restarting a failed or updated run, and `--use_gpu` to enable hardware acceleration for model inference.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary outputs include:

*   **Predicted Structures:** PDB files containing the 3D coordinates of the predicted protein models.
*   **MultiQC Report:** A summary report (`multiqc_report.html`) found in the `multiqc/` folder that aggregates quality metrics and run statistics.
*   **Pipeline Info:** Execution logs and resource usage reports.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/proteinfold/output). Example results from full-sized test runs are available on the [nf-core website](https://nf-co.re/proteinfold/results).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)