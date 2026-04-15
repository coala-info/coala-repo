---
name: workflow-constructed-from-history-test-dwc-from-pndb-data-pa
description: This workflow integrates marine mammal observation tables and EML metadata using text processing tools like joins, regex replacements, and transpositions to generate Darwin Core compliant datasets. Use this skill when you need to harmonize raw biodiversity survey data and metadata into standardized formats for international data repositories or ecological monitoring programs.
homepage: https://www.pndb.fr/
metadata:
  docker_image: "N/A"
---

# workflow-constructed-from-history-test-dwc-from-pndb-data-pa

## Overview

This Galaxy workflow is designed to process and transform marine mammal observation data from the Kakila database, specifically focusing on datasets from the AGOA sanctuary in the French Antilles. It integrates several relational tabular inputs—including taxa, observers, observations, organizations, and geographic sectors—with an EML metadata file (XML) to prepare the data for standardized biodiversity reporting.

The pipeline employs a series of text processing operations to merge and clean the data. Key steps include multiple [joins](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2) to consolidate information across the various input files, followed by [regex-based find-and-replace](https://toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1) and filtering to ensure data consistency. These transformations are critical for aligning raw database exports with the requirements of the Pôle National de Données de Biodiversité (PNDB).

In the final stages, the workflow utilizes [Datamash Transpose](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0) and tabular filtering to restructure the dataset. By deduplicating records and refining the column structure, the workflow generates outputs consistent with Darwin Core (DwC) annotations, facilitating easier integration into international biodiversity platforms and repositories.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | BDD_Kakila_v2_20210221_taxon.tsv | data_input |  |
| 1 | BDD_Kakila_v2_2021021_observateur.tsv | data_input |  |
| 2 | BDD_Kakila_v2_20210221_observation.tsv | data_input |  |
| 3 | BDD_Kakila_v2_20210221_organisme.tsv | data_input |  |
| 4 | BDD_Kakila_v2_20210221_secteur_geog.tsv | data_input |  |
| 5 | BDD_Kakila_v2_20210221_sortie.tsv | data_input |  |
| 6 | Kakila_database_of_marine_mammal_observation_data_in_the_AGOA_sanctuary_-_French_Antilles.xml | data_input |  |


Ensure all input files are uploaded as tabular TSV datasets and a single XML file for the EML metadata to maintain compatibility with the text processing and join tools. Since this workflow relies on specific relational joins between multiple data tables, verify that each dataset is uploaded individually rather than as a collection. For automated execution and parameter mapping, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on the specific column mappings and annotation requirements for this PNDB data package.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 8 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 9 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 10 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 11 | Select | Grep1 |  |
| 12 | Select | Grep1 |  |
| 13 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 14 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 15 | Regex Replace | toolshed.g2.bx.psu.edu/repos/kellrott/regex_replace/regex_replace/1.0.0 |  |
| 16 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 17 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 18 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 19 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 20 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 21 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 22 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 23 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/2.0.0 |  |
| 24 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 25 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/unique/bg_uniq/0.3 |  |
| 26 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.1.0 |  |
| 27 | Remove beginning | Remove beginning1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | output | output |
| 8 | output | output |
| 9 | output | output |
| 10 | output | output |
| 11 | out_file1 | out_file1 |
| 12 | out_file1 | out_file1 |
| 13 | output | output |
| 14 | output | output |
| 15 | outfile | outfile |
| 16 | output | output |
| 17 | output | output |
| 18 | out_file1 | out_file1 |
| 19 | output | output |
| 20 | output | output |
| 21 | out_file1 | out_file1 |
| 22 | out_file | out_file |
| 23 | output | output |
| 24 | output | output |
| 25 | outfile | outfile |
| 26 | out_file | out_file |
| 27 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_constructed_from_history__test_dwc_from_PNDB_Data_package_EML_DwC_annotations_.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_constructed_from_history__test_dwc_from_PNDB_Data_package_EML_DwC_annotations_.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_constructed_from_history__test_dwc_from_PNDB_Data_package_EML_DwC_annotations_.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_constructed_from_history__test_dwc_from_PNDB_Data_package_EML_DwC_annotations_.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_constructed_from_history__test_dwc_from_PNDB_Data_package_EML_DwC_annotations_.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_constructed_from_history__test_dwc_from_PNDB_Data_package_EML_DwC_annotations_.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)