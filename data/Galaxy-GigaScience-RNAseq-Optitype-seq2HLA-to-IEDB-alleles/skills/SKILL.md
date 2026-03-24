---
name: gigascience-rnaseq-optitype-seq2hla-to-iedb-alleles
description: "This workflow processes paired-end RNA-seq FASTQ files to perform high-resolution HLA typing using OptiType and seq2HLA, outputting allele calls formatted for compatibility with the Immune Epitope Database. Use this skill when you need to identify HLA genotypes from transcriptomic data to support neoantigen discovery and downstream immune epitope binding predictions."
homepage: https://workflowhub.eu/workflows/1794
---

# GigaScience-RNAseq-Optitype-seq2HLA-to-IEDB-alleles

## Overview

This Galaxy workflow is designed for the automated prediction and verification of HLA alleles from paired-end RNA-seq data. By processing raw R1 and R2 FASTQ files, the pipeline facilitates the identification of MHC Class I and Class II alleles, which is a critical step in neoantigen discovery and immunogenetics research.

The workflow integrates two primary HLA typing tools to ensure comprehensive results: [OptiType](https://toolshed.g2.bx.psu.edu/repos/iuc/optitype/optitype/1.3.5+galaxy0) for high-resolution Class I typing and [seq2HLA](https://toolshed.g2.bx.psu.edu/repos/iuc/seq2hla/seq2hla/2.3+galaxy0) for both Class I and Class II inference. This dual-tool approach allows for cross-verification of HLA candidates and provides a more robust profile of the sample's immune landscape.

Following the typing phase, the workflow utilizes text reformatting and [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) to standardize the raw outputs. These steps generate 4-digit genotypes and coverage plots, specifically formatting the final allele lists for direct compatibility with the [IEDB](https://www.iedb.org/) (Immune Epitope Database) for downstream peptide-binding affinity predictions.

Licensed under GPL-3.0-or-later, this tool is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) protocols for neoantigen analysis. It streamlines the transition from raw sequencing reads to verified HLA alleles ready for epitope prediction.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | R1.fastq | data_input | Paired RNAseq forward reads. |
| 1 | R2.fastq | data_input | Paired RNAseq reverse reads. |


Ensure your input files are in FASTQ format, ideally provided as paired-end reads (R1 and R2) to ensure the highest accuracy for HLA typing tools like OptiType and seq2HLA. While individual datasets are supported, organizing large cohorts into paired-end list collections will significantly streamline the execution of this workflow across multiple samples. Refer to the included README.md for comprehensive details on parameter settings and specific allele nomenclature requirements. You can automate the setup of your execution environment and input parameters using `planemo workflow_job_init` to generate a `job.yml` file.

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
