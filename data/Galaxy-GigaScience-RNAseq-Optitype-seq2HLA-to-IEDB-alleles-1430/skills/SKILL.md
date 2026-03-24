---
name: gigascience-rnaseq-optitype-seq2hla-to-iedb-alleles
description: "This Galaxy workflow processes paired-end RNA-seq FASTQ files to perform high-resolution HLA typing using OptiType and seq2HLA, formatting the resulting alleles for compatibility with IEDB binding prediction tools. Use this skill when you need to accurately identify human leukocyte antigen genotypes from transcriptomic data to support neoantigen discovery and immunogenetic profiling."
homepage: https://workflowhub.eu/workflows/1430
---

# GigaScience-RNAseq-Optitype-seq2HLA-to-IEDB-alleles

## Overview

This Galaxy workflow is designed for the prediction of HLA binding by identifying HLA alleles from RNA-seq data. It processes paired-end FASTQ files to perform high-resolution HLA typing, a critical step in neoantigen discovery and immunological research.

The pipeline utilizes two primary tools for HLA calling: [OptiType](https://toolshed.g2.bx.psu.edu/repos/iuc/optitype/optitype/1.3.5+galaxy0) and [seq2HLA](https://toolshed.g2.bx.psu.edu/repos/iuc/seq2hla/seq2hla/2.3+galaxy0). OptiType provides accurate 4-digit typing for Class I HLA, while seq2HLA complements this by providing genotype information across a broader range of loci.

Following the typing steps, the workflow employs text reformatting via AWK and tabular querying to standardize the results. The final outputs include 4-digit genotypes and coverage plots, specifically formatted as IEDB-compatible alleles to facilitate downstream binding affinity predictions in the Immune Epitope Database.

This [GTN](https://training.galaxyproject.org/) associated workflow is licensed under GPL-3.0-or-later and serves as a robust utility for researchers automating neoantigen identification pipelines within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | R1.fastq | data_input | Paired RNAseq forward reads. |
| 1 | R2.fastq | data_input | Paired RNAseq reverse reads. |


Ensure your input R1 and R2 FASTQ files are in the fastqsanger format to maintain compatibility with the OptiType and seq2HLA tools. While the workflow accepts individual datasets, organizing paired-end reads into dataset collections is recommended for more efficient batch processing. For comprehensive instructions on parameter settings and reference data, please consult the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | OptiType | toolshed.g2.bx.psu.edu/repos/iuc/optitype/optitype/1.3.5+galaxy0 | HLA genotyping output |
| 3 | seq2HLA | toolshed.g2.bx.psu.edu/repos/iuc/seq2hla/seq2hla/2.3+galaxy0 | HLA genotyping output |
| 4 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 | reformatting the data to make it easy to interpret |
| 5 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | extract IEDB alleles |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | OptiType_on_input_datasets_result | result |
| 2 | OptiType_on_input_datasets_coverage_plot | coverage_plot |
| 3 | seq2HLA_genotype_4digits | c1_genotype4digits |
| 4 | Reformated-Optitype-Data | outfile |
| 5 | IEDB_Optitype_alleles | output1 |
| 5 | IEDB-Optitype-seq2HLA-alleles | output |
| 5 | IEDB_seq2HLA_alleles | output2 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
