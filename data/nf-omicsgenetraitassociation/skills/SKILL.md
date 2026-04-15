---
name: omicsgenetraitassociation
description: This pipeline performs meta-analysis of trait associations by integrating GWAS summary statistics, gene-trait association phenotype files, and additional omic p-values to produce gene-level aggregations and enrichment reports. Use when analyzing correlated omics studies with hidden non-independencies from overlapping samples to identify gene-trait associations, module enrichments, and gene ontology terms.
homepage: https://github.com/nf-core/omicsgenetraitassociation
---

# omicsgenetraitassociation

## Overview
nf-core/omicsgenetraitassociation is designed to perform meta-analysis of trait associations while accounting for correlations across omics studies. These correlations often arise from hidden non-independencies, such as overlapping or related samples, which can bias standard meta-analysis approaches if not properly addressed.

The pipeline integrates multiple data streams to provide a comprehensive view of gene-trait relationships. It processes input association data through gene-level aggregation and correlated meta-analysis, ultimately delivering downstream results including module enrichment and gene ontology (GO) enrichment analyses to help interpret the biological significance of the findings.

## Data preparation
The pipeline requires a samplesheet in CSV format to define the input datasets and their relationships. Each row in the samplesheet represents a single correlated meta-analysis run.

**Samplesheet columns:**
- `sample`: Unique identifier for the sample (no spaces).
- `trait`: The trait being analyzed (no spaces).
- `pascal`: Path to a GWAS summary statistics CSV file for gene-level aggregation.
- `twas`: Path to a gene-trait association phenotype CSV file.
- `additional_sources`: (Optional) Path to a `.txt` file listing paths to additional omic association p-values.

**Example `samplesheet.csv`:**
```csv
sample,trait,pascal,twas,additional_sources
llfs_fhshdl,fhshdl,data/llfs/fhshdl/gwas.csv,data/llfs/fhshdl/twas.csv,data/llfs/additional_sources.txt
fhs_lnTG,lnTG,data/fhs/lnTG/gwas.csv,data/fhs/lnTG/twas.csv,
```

The pipeline also allows for fine-tuning via parameters such as `--gene_col_name` (default: `markname`) and `--pval_col_name` (default: `meta_p`) for enrichment analyses, as well as specific column indices for PASCAL and MMAP inputs.

## How to run
Run the pipeline using the standard Nextflow command. It is recommended to test the setup with the `test` profile before using production data.

```bash
nextflow run nf-core/omicsgenetraitassociation \
  -r 1.0.0 \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results
```

Key flags include:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`, or an institutional profile).
- `--input`: Path to the CSV samplesheet.
- `--outdir`: The directory where results will be saved.
- `-resume`: Use this to restart a run from the last cached step if it was interrupted.

## Outputs
Results are organized within the directory specified by `--outdir`. The primary deliverables include:

- **Meta-analysis results**: Correlated meta-analysis statistics for gene-trait associations.
- **Enrichment Reports**: Module enrichment analysis (MEA) and Gene Ontology (GO) enrichment results.
- **Aggregated Data**: Gene-level p-values and statistics generated from GWAS summary data.

For a detailed description of all output files and how to interpret the reports, refer to the [official output documentation](https://nf-co.re/omicsgenetraitassociation/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)