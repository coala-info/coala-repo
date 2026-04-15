---
name: stableexpression
description: This pipeline aggregates RNA-seq and microarray count datasets from public databases like Expression Atlas and GEO or user-provided samplesheets to identify the most stable genes for a given species. Use when searching for reliable RT-qPCR reference genes across diverse experimental conditions or when downloading and merging large-scale expression data for a specific organism.
homepage: https://github.com/nf-core/stableexpression
---

# stableexpression

## Overview
The nf-core/stableexpression pipeline addresses the challenge of identifying highly stable genes across multiple transcriptomic datasets, which is a critical step for selecting reliable RT-qPCR reference genes. It automates the retrieval of public data, standardizes gene identifiers, and applies robust statistical scoring to rank genes by their expression stability.

In practice, users provide a species name and optional search keywords to automatically fetch data from Expression Atlas and NCBI GEO, or they can supply their own local count matrices. The pipeline produces a ranked list of candidate genes based on stability algorithms like Normfinder and Genorm, alongside interactive visualizations for data exploration.

## Data preparation
The pipeline requires a scientific species name and can optionally incorporate local datasets or specific gene metadata.

*   **Species Name**: Mandatory scientific name (e.g., `--species "Arabidopsis thaliana"` or `--species homo_sapiens`).
*   **Custom Datasets**: A CSV, YAML, or YML file provided via `--datasets` to include local data.
    *   CSV columns: `counts`, `design`, `platform`, `normalised`.
*   **Reference Files**: For TPM normalization, a GFF file (`--gff`) or a gene length CSV (`--gene_length`) with `gene_id` and `length` columns is required.
*   **ID Mapping**: Custom gene ID mappings can be provided via `--gene_id_mapping` (columns: `original_gene_id`, `gene_id`) and metadata via `--gene_metadata` (columns: `gene_id`, `name`, `description`).
*   **Target Genes**: A list of specific genes to focus on can be provided via `--target_genes` (comma-separated) or `--target_gene_file` (one ID per line).

Example `--datasets` CSV structure:
```csv
counts,design,platform,normalised
./data/counts1.csv,./data/design1.csv,rnaseq,false
./data/counts2.csv,./data/design2.csv,microarray,true
```

## How to run
The pipeline is executed using standard Nextflow commands. It is recommended to use a specific version with `-r` and a container profile.

```bash
nextflow run nf-core/stableexpression \
    -r 1.0.0 \
    -profile docker \
    --species "Arabidopsis thaliana" \
    --outdir ./results
```

To include public GEO data (experimental) or skip default Expression Atlas fetching:
```bash
nextflow run nf-core/stableexpression \
    -profile singularity \
    --species "Homo sapiens" \
    --fetch_geo_accessions \
    --skip_fetch_eatlas_accessions \
    --outdir ./results \
    -resume
```

Key parameters for control:
*   `--keywords`: Filter public accessions by specific conditions (e.g., `--keywords 'stress,drought'`).
*   `--accessions`: Provide a comma-separated list of specific EBI/GEO IDs to download.
*   `--normalisation_method`: Choose between `tpm` (default) or `cpm`.

## Outputs
Results are saved in the directory specified by `--outdir`.

*   **MultiQC Report**: A summary report (`multiqc_report.html`) containing pipeline statistics and data quality metrics.
*   **Stability Scores**: Aggregated tables containing stability rankings from Normfinder, Genorm, and coefficient of variation calculations.
*   **Dash Plotly App**: Files prepared for a Dash application to interactively investigate gene and sample counts.
*   **Merged Data**: Standardized and normalized expression matrices used for the final scoring.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/stableexpression/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/configuration.md`](references/docs/configuration.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/troubleshooting.md`](references/docs/troubleshooting.md)
- [`references/docs/usage.md`](references/docs/usage.md)