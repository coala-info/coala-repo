---
name: reportho
description: This pipeline fetches and summarizes orthology predictions from multiple public databases using UniProt IDs or FASTA sequences to generate consensus ortholog lists with agreement statistics. Use when you need to consolidate ortholog predictions for query proteins across OMA, PANTHER, EggNOG, and OrthoInspector into a single human-readable HTML report.
homepage: https://github.com/nf-core/reportho
---

# reportho

## Overview
nf-core/reportho addresses the challenge of inconsistent orthology predictions across different bioinformatics databases by aggregating results into a unified consensus. It identifies synonymous identifiers through sequence identity and calculates agreement statistics to provide a confidence-ranked list of orthologs for specific query proteins.

The pipeline accepts either UniProt identifiers or protein FASTA files as input and produces detailed comparative reports. These outputs help researchers understand the reliability of ortholog assignments and provide a clean, summarized view of evolutionary relationships across multiple databases.

## Data preparation
Users must provide a CSV samplesheet via the `--input` parameter. The file requires an `id` column (no spaces allowed) and either a `query` (UniProt ID) or a `fasta` (path to protein sequence) column. If both a FASTA file and a UniProt ID are provided for the same entry, the UniProt ID takes precedence.

Example `samplesheet.csv`:
```csv
id,query,fasta
BicD2,Q8TD16,
HBB,,data/hbb.fasta
```

Constraints and requirements:
- **id**: Unique identifier for the query protein; must not contain spaces.
- **query**: UniProt ID of the protein.
- **fasta**: Path to a protein FASTA file (must end in `.fa` or `.fasta`).
- **Local Databases**: If running in offline mode or using local snapshots, paths to OMA, PANTHER, EggNOG, or OrthoInspector databases must be provided via parameters like `--oma_path` or `--panther_path`.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use a container profile such as Docker or Singularity for reproducibility.

```bash
nextflow run nf-core/reportho \
  -profile docker \
  --input samplesheet.csv \
  --outdir ./results
```

Key execution parameters:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`, `test`).
- `--use_all`: Enable all available ortholog search methods.
- `--local_databases`: Use local database snapshots instead of API calls.
- `--min_score`: Set the minimum agreement score (default: 2) for the consensus list.
- `--skip_merge`: Skip the identification of synonymous identifiers based on sequence identity.
- `-resume`: Restart a pipeline run from the last cached successful step.

## Outputs
Results are saved to the directory specified by the `--outdir` parameter. The primary deliverable is an interactive HTML report that summarizes the orthology predictions and agreement statistics.

Key output locations:
- `report/`: Contains the human-readable HTML analysis report.
- `consensus/`: Contains the final consensus ortholog lists and agreement matrices.
- `multiqc/`: Quality control summary of the pipeline execution.
- `pipeline_info/`: Reports on resource usage and pipeline configuration.

For a comprehensive description of all output files, refer to the [official output documentation](https://nf-co.re/reportho/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)