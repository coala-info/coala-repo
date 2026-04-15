---
name: nf-core-differentialabundance
description: This pipeline performs differential abundance analysis on data matrices from RNA-seq, Affymetrix microarrays, or proteomics, requiring a samplesheet, a contrasts file, and either an abundance matrix or raw CEL files. Use when comparing groups of biological observations to identify significant changes in feature abundance across experimental conditions.
homepage: https://github.com/nf-core/differentialabundance
---

# nf-core-differentialabundance

## Overview
The pipeline analyzes data represented as matrices to compare groups of observations and generate differential statistics. It supports various modalities including RNA-seq (counts), Affymetrix arrays (.CEL files), and proteomics data (MaxQuant), producing both static HTML reports and interactive Shiny applications for data exploration.

Users provide experimental metadata and specific contrasts to drive the statistical modeling. The workflow handles feature annotation, consistency checking between matrices and metadata, and downstream functional analysis such as Gene Set Enrichment Analysis (GSEA) or pathway enrichment via gprofiler2.

## Data preparation
The pipeline requires several input files depending on the data type and analysis goals:

*   **Samplesheet (`--input`):** A CSV file containing information about the samples. It must include a primary identifier column (defaulting to `sample`).
*   **Contrasts (`--contrasts`):** A CSV file defining the comparisons to be made. It must contain the columns `variable` (a column name from the samplesheet), `reference`, `target`, and `blocking` (a colon-separated list of additional variables or an empty string).
*   **Abundance Matrix (`--matrix`):** A TSV-format matrix where columns correspond to samples in the samplesheet. For RNA-seq, raw counts or length-scaled counts are preferred.
*   **Affymetrix Data:** Instead of a matrix, users can provide a compressed archive of raw CEL files using `--affy_cel_files_archive`.
*   **Reference Annotation:** For RNA-seq, a GTF file (`--gtf`) is required to derive feature annotations unless a custom features table is provided via `--features`.

Example contrasts CSV:
```csv
variable,reference,target,blocking
condition,control,treatment,batch
```

## How to run
Run the pipeline using `nextflow run`. You must specify a profile for your environment (e.g., `docker` or `singularity`) and a study profile (`rnaseq` or `affy`).

**RNA-seq analysis:**
```bash
nextflow run nf-core/differentialabundance \
    -profile rnaseq,docker \
    --input samplesheet.csv \
    --contrasts contrasts.csv \
    --matrix gene_counts.tsv \
    --gtf genome.gtf \
    --outdir ./results
```

**Affymetrix microarray analysis:**
```bash
nextflow run nf-core/differentialabundance \
    -profile affy,docker \
    --input samplesheet.csv \
    --contrasts contrasts.csv \
    --affy_cel_files_archive cel_files.tar.gz \
    --outdir ./results
```

Key parameters include `-r` to pin a specific pipeline release, `-resume` to continue a previous execution, and `--study_name` to identify results in the output directory.

## Outputs
Results are placed in the directory specified by `--outdir`.

*   **HTML Report:** The primary output is an interactive HTML report produced from an R Markdown template, featuring PCA plots, heatmaps, and volcano plots.
*   **Shiny App:** If `--shinyngs_build_app` is true, the pipeline generates an R script and data files to launch an interactive Shiny application for data mining.
*   **Differential Statistics:** Tabular results for each contrast, including log2 fold changes and adjusted p-values (e.g., from DESeq2 or Limma).
*   **GSEA/Enrichment:** Results from gene set enrichment analysis if `--gsea_run` or `--gprofiler2_run` are enabled.

For a detailed description of the output structure, refer to the official [output documentation](https://nf-co.re/differentialabundance/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)