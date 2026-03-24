---
name: gigascience-iedb-pepquery-neoantigen
description: "This workflow predicts MHC binding affinities from HLA alleles and protein sequences using the IEDB API and validates the resulting candidate neoantigens against MS/MS spectra using PepQuery2. Use this skill when you need to identify and confirm the presence of novel, immunogenic neoantigen peptides in proteogenomic datasets for cancer immunotherapy research."
homepage: https://workflowhub.eu/workflows/1406
---

# GigaScience-IEDB-PepQuery-Neoantigen

## Overview

This Galaxy workflow provides an automated pipeline for neoantigen discovery by integrating MHC binding predictions with mass spectrometry validation. It utilizes the [IEDB API](https://toolshed.g2.bx.psu.edu/repos/iuc/iedb_api/iedb_api/2.15.2) to predict binding affinities between HLA alleles and peptide sequences provided in FASTA format. The workflow is designed to categorize these predictions into strong and weak binders, facilitating a tiered analysis of potential neoantigen candidates.

Following the initial prediction phase, the workflow employs [PepQuery2](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2) to cross-reference the predicted peptides against MS/MS spectrum data. This step is crucial for validating the actual proteomic expression of the predicted neoantigens and ensuring their novelty. The process includes extensive data manipulation steps, such as table pivoting and filtering via [Table Compute](https://toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0) and [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2), to refine the results.

The final outputs consist of validated neoantigen peptide lists and comprehensive peptide-HLA tables for both strong and weak binding categories. This workflow is particularly useful for researchers following [GTN](https://training.galaxyproject.org/) protocols for immunopeptidomics, providing a reproducible path from raw sequence data to high-confidence neoantigen candidates under the GPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | IEDB-optityle-seq2hla-alleles | data_input | A single column tabular file with an HLA per line IEDB format: e.g.  HLA-A*01:01 |
| 1 | FASTA-for-IEDB | data_input | A fasta file of peptides to test for HLA binding, can be from Arriba |
| 2 | MSMS-Spectrum | data_input | MSMS spectrum |


Ensure your input files are correctly formatted, specifically using FASTA for protein sequences, tabular formats for HLA alleles, and MGF or mzML for MS/MS spectra. While individual datasets are used for this workflow, organizing large cohorts into collections can streamline the execution of PepQuery across multiple samples. Refer to the accompanying README.md for specific details on allele nomenclature and database requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | IEDB | toolshed.g2.bx.psu.edu/repos/iuc/iedb_api/iedb_api/2.15.2 | IEDB binding prediction |
| 4 | Filter | Filter1 | anything less than 2 and more than 0.5 percentile rank |
| 5 | Filter | Filter1 | anything less than 0.5 percentile rank |
| 6 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0 | extracting allele results using pivot |
| 7 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy0 | extracting allele results using pivot |
| 8 | Remove beginning | Remove beginning1 | this is to remove header |
| 9 | Remove beginning | Remove beginning1 | removing header |
| 10 | Cut | Cut1 | cutting first column to extract peptides |
| 11 | Cut | Cut1 | cutting first column to extract peptides |
| 12 | PepQuery2 | toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2 | Test if the peptides are novel, and search for peptide in Mass Spec results. |
| 13 | PepQuery2 | toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy2 | Test if the peptides are novel, and search for peptide in Mass Spec results. |
| 14 | Filter | Filter1 | IEDB-Validated-NeoAntigen_Peptides, filtering if the validation column is yes or no |
| 15 | Filter | Filter1 | IEDB-Validated-NeoAntigen_Peptides, filtering if the validation column is yes or no |
| 16 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Remove reference peptides from IeDB Pivot Table |
| 17 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 | Remove reference peptides from IeDB Pivot Table |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | iedb_binding_predictions | output |
| 4 | Weak-Binders | out_file1 |
| 5 | Strong-Binders | out_file1 |
| 6 | iedb_results_pivot_table_weak | table |
| 7 | iedb_results_pivot_table_strong | table |
| 8 | header_removed_for_filter-weak | out_file1 |
| 9 | header removed for filter-strong | out_file1 |
| 10 | Peptide-for-PepQuery-weak | out_file1 |
| 11 | Peptide-for-PepQuery-strong | out_file1 |
| 12 | PepQuery-IEDB-Peptides-weak | psm_rank_txt |
| 12 | PepQuery-IEDB-Peptides-log-weak | log_txt |
| 13 | PepQuery-IEDB-Peptides | psm_rank_txt |
| 13 | PepQuery-IEDB-Peptides-log-strong | log_txt |
| 14 | IEDB-Validated-NeoAntigen_Peptides-weak | out_file1 |
| 15 | IEDB-Validated-NeoAntigen_Peptides-strong | out_file1 |
| 16 | iedb_novel_peptide_x_hla_table-weak | output |
| 16 | iedb_predicted_neoantigens-weak | output1 |
| 17 | iedb_novel_peptide_x_hla_table-strong | output |
| 17 | iedb_predicted_neoantigens-strong | output1 |


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
