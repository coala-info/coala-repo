---
name: proteomics-maxquant-workflow
description: This proteomics workflow performs label-free protein quantification by processing mass spectrometry samples and a protein database using MaxQuant followed by data filtering and statistical visualization. Use this skill when you need to identify and quantify proteins in complex biological samples to compare protein expression levels across different experimental conditions without using isotopic labels.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# proteomics-maxquant-workflow

## Overview

This workflow provides a standardized pipeline for label-free proteomics data analysis using [MaxQuant](https://toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.10.43+galaxy3). It is designed to process mass spectrometry samples against a protein database to identify and quantify proteins and peptides, following best practices established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

The process begins with the core MaxQuant engine, which generates comprehensive identification and quantification tables. Following the primary analysis, the workflow executes several downstream data refinement steps, including filtering, text manipulation (grep, cut, and sort), and column-based computations to restructure the output for easier interpretation.

The final outputs include detailed protein groups, peptide lists, and the MaxQuant parameter file (mqpar). To ensure data reliability, the workflow generates a [PTXQC](https://github.com/cbielow/PTXQC) quality control report and a histogram visualization, allowing researchers to assess the distribution and quality of their label-free proteomics results immediately.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Protein_database | data_input |  |
| 1 | Sample1 | data_input |  |
| 2 | Sample2 | data_input |  |


Ensure your protein database is in FASTA format and your mass spectrometry samples are uploaded as Thermo .raw or converted .mzXML files. While the workflow accepts individual datasets for Sample1 and Sample2, organizing large cohorts into a dataset collection can streamline the MaxQuant configuration. Refer to the accompanying README.md for specific parameter settings and experimental design requirements. You can automate the job configuration by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MaxQuant | toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.10.43+galaxy3 |  |
| 4 | Filter | Filter1 |  |
| 5 | Select | Grep1 |  |
| 6 | Cut | Cut1 |  |
| 7 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 8 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 9 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 10 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 11 | Cut | Cut1 |  |
| 12 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.3.0 |  |
| 13 | Histogram | toolshed.g2.bx.psu.edu/repos/devteam/histogram/histogram_rpy/1.0.4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | peptides | peptides |
| 3 | ptxqc_report | ptxqc_report |
| 3 | proteinGroups | proteinGroups |
| 3 | mqpar | mqpar |
| 4 | out_file1 | out_file1 |
| 5 | out_file1 | out_file1 |
| 6 | out_file1 | out_file1 |
| 7 | outfile | outfile |
| 8 | out_file1 | out_file1 |
| 9 | outfile | outfile |
| 10 | out_file1 | out_file1 |
| 11 | out_file1 | out_file1 |
| 12 | out_file1 | out_file1 |
| 13 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run maxquant-label-free.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run maxquant-label-free.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run maxquant-label-free.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init maxquant-label-free.ga -o job.yml`
- Lint: `planemo workflow_lint maxquant-label-free.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `maxquant-label-free.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)