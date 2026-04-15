---
name: flexynesis-get-data-from-cbioportal
description: This Galaxy workflow retrieves cancer genomics datasets from cBioPortal and processes them using Flexynesis import tools, Table Compute, and text processing utilities to generate structured training and testing data. Use this skill when you need to automate the acquisition and preprocessing of clinical or molecular profiles from cBioPortal for downstream multi-omic data integration and machine learning model development.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# flexynesis-get-data-from-cbioportal

## Overview

This workflow automates the retrieval and preprocessing of multi-omics data from [cBioPortal](https://www.cbioportal.org/) for use in machine learning pipelines. It utilizes the `flexynesis_cbioportal_import` tool to fetch specific datasets, followed by extraction and sorting steps to organize the raw genomic or clinical information.

Once imported, the data undergoes a series of transformations using `Table Compute` and `Advanced Cut` tools. These steps refine the datasets by filtering columns and performing necessary table manipulations to ensure the features are correctly aligned and formatted for downstream analysis.

The final stage employs `flexynesis_utils` to partition and format the processed data into distinct training and testing sets. This ensures the data is ready for integration into the [Flexynesis](https://github.com/BIMSB-epigenetics/flexynesis) deep learning framework, supporting robust machine learning model development under an MIT license.

## Inputs and data preparation

_None listed._


Ensure the cBioPortal study identifiers and data types are correctly specified as tabular inputs for the initial import tool. Because the workflow utilizes extraction steps, pay close attention to whether your data is organized in collections or as discrete datasets to ensure compatibility with the downstream processing tools. Consult the README.md for exhaustive documentation on parameter mapping and specific data preparation requirements. For streamlined testing and automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Flexynesis cBioPortal import | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_cbioportal_import/flexynesis_cbioportal_import/0.2.20+galaxy1 |  |
| 1 | Extract dataset | __EXTRACT_DATASET__ |  |
| 2 | Extract dataset | __EXTRACT_DATASET__ |  |
| 3 | Extract dataset | __EXTRACT_DATASET__ |  |
| 4 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 5 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy2 |  |
| 6 | Table Compute | toolshed.g2.bx.psu.edu/repos/iuc/table_compute/table_compute/1.2.4+galaxy2 |  |
| 7 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.5+galaxy2 |  |
| 8 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.5+galaxy2 |  |
| 9 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.5+galaxy2 |  |
| 10 | Flexynesis utils | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_utils/flexynesis_utils/0.2.20+galaxy3 |  |
| 11 | Flexynesis utils | toolshed.g2.bx.psu.edu/repos/bgruening/flexynesis_utils/flexynesis_utils/0.2.20+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 11 | test data | test_out |
| 11 | train data | train_out |


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