---
name: metapep
description: This pipeline predicts MHC/HLA-affinity for peptides derived from metagenomic inputs including assemblies, bins, or taxa provided in a CSV samplesheet. Use when screening microbiome data for immunogenic potential across different conditions using specific HLA alleles and prediction methods like SYFPEITHI, MHCflurry, or MHCnuggets.
homepage: https://github.com/nf-core/metapep
---

## Overview
nf-core/metapep addresses the challenge of identifying immunogenic peptides within complex microbial communities by streamlining the transition from metagenomic sequences to epitope predictions. It automates the extraction of protein sequences from various microbiome data formats and evaluates their binding affinity to specific MHC or HLA alleles.

The pipeline produces standardized prediction tables and visual summaries, allowing researchers to compare the epitope landscape across different experimental conditions or taxonomic compositions. It is designed for processed metagenomic data rather than raw sequencing reads.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. The file must contain a header and the following columns:

*   `condition`: A unique name for the experimental group (no spaces).
*   `type`: The input data category, which must be `bins`, `assembly`, or `taxa`.
*   `microbiome_path`: The absolute path to the FASTA file (for assembly/bins) or a text file (for taxa).
*   `alleles`: A space-separated string of HLA/MHC alleles (e.g., "A*02:01 A*01:01").
*   `weights_path`: (Optional) Path to a file containing weights for the samples.

Example `samplesheet.csv`:
```csv
condition,type,microbiome_path,alleles
control,assembly,./data/sample1.fasta,"A*02:01 A*01:01"
treatment,taxa,./data/taxa_list.txt,"B*07:02"
```

For `taxa` inputs, the pipeline automatically downloads protein sequences from Entrez. For `assembly` or `bins`, it uses Prodigal to predict proteins before generating peptides.

## How to run
Run the pipeline using the `nextflow run` command. You must specify a compute profile (such as `docker`, `singularity`, or `conda`) and the output directory.

```bash
nextflow run nf-core/metapep \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    --pred_method syfpeithi \
    --min_pep_len 9 \
    --max_pep_len 11
```

Key parameters include:
*   `--pred_method`: Choose from `syfpeithi`, `mhcflurry`, `mhcnuggets-class-1`, or `mhcnuggets-class-2`.
*   `--min_pep_len` / `--max_pep_len`: Define the range of peptide lengths to generate (default 9-11).
*   `--show_supported_models`: Use this flag to list all supported alleles for the available prediction methods and exit.
*   `-resume`: Use this Nextflow flag to restart a run from the last completed step.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

*   **Epitope Predictions**: Tables containing predicted binding affinities for the specified alleles.
*   **Visualizations**: Boxplots and other figures comparing epitope distributions across conditions.
*   **MultiQC Report**: A summary report located in the `multiqc/` folder that aggregates statistics from the run.
*   **Intermediate Files**: Processed protein sequences and peptide chunks used during the prediction phase.

For a detailed description of the directory structure and file formats, refer to the [official output documentation](https://nf-co.re/metapep/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/images/datamodel/Datamodel.txt`](references/docs/images/datamodel/Datamodel.txt)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
