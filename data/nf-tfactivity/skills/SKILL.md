---
name: tfactivity
description: This pipeline identifies differentially active transcription factors by integrating gene expression count matrices with open chromatin data such as ATAC-seq, DNase-seq, or histone modification ChIP-seq peaks. Use when seeking to prioritize condition-specific transcription factors based on target gene affinity, differential expression, and regression-based activity scores.
homepage: https://github.com/nf-core/tfactivity
---

## Overview
nf-core/tfactivity is a bioinformatics pipeline designed to identify and rank transcription factors (TFs) that are most likely responsible for observed differential gene expression between multiple biological conditions. It solves the problem of prioritizing regulatory drivers by integrating chromatin accessibility information with transcriptomic data.

The pipeline calculates affinity scores for TF-target gene combinations using STARE, identifies differentially expressed genes, and employs linear regression (DYNAMITE) to model the relationship between TF binding and expression changes. The final output is a statistical ranking of transcription factors based on a Mann-Whitney U test of their calculated activity scores.

## Data preparation
The pipeline requires three primary input components: chromatin accessibility data, an expression count matrix, and a design matrix.

### Samplesheets
For chromatin data, provide a CSV file via `--input` containing peak files (BED or broadPeak format).
```csv
sample,condition,assay,peak_file
cell1_rep1,control,ATAC,control_rep1.broadPeak
cell1_rep2,control,ATAC,control_rep2.broadPeak
cell2_rep1,treated,ATAC,treated_rep1.broadPeak
```
Alternatively, if predicting enhancer regions via ChromHMM, provide a BAM samplesheet via `--input_bam` containing `sample`, `condition`, `assay`, `signal`, and `control` columns.

### Expression Data
- **Count Matrix (`--counts`)**: A raw count matrix (CSV or TXT) with gene IDs as rows and samples as columns.
- **Design Matrix (`--counts_design`)**: A CSV mapping expression samples to conditions. The `condition` values must match those used in the chromatin samplesheet.
```csv
sample,condition
sample1,control
sample2,control
sample3,treated
```

### Reference Files
Users must specify a reference genome using `--genome` (e.g., `GRCh38`). If not using iGenomes, the pipeline requires `--fasta`, `--gtf`, and `--motifs` (PWMs in JASPAR, MEME, or TRANSFAC format). If `--motifs` is omitted, a `--taxon_id` can be provided to fetch motifs from JASPAR.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a specific version with `-r` and a container profile like `docker` or `singularity`.

```bash
nextflow run nf-core/tfactivity \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --genome GRCh38 \
   --counts expression_counts.csv \
   --counts_design design_matrix.csv \
   --outdir ./results
```

Key parameters include:
- `-resume`: To restart a pipeline from the last successful step.
- `--merge_samples`: To combine technical replicates with the same condition and assay.
- `--skip_chromhmm` / `--skip_rose`: To bypass enhancer prediction if only using provided peaks.

## Outputs
Results are saved in the directory specified by `--outdir`. 

- **TF Rankings**: The primary result is a prioritized list of transcription factors based on their differential activity between conditions.
- **Affinity Scores**: Calculated TF-target gene affinity matrices from STARE.
- **Reports**: A MultiQC report aggregating quality control metrics across the workflow.

For a complete description of the directory structure and file formats, refer to the [official output documentation](https://nf-co.re/tfactivity/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
