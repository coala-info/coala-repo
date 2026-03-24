---
name: spipoll-mmos-gapars-crowdsourcing-results
description: "This workflow processes crowdsourced pollinator observation data from SPIPOLL and MMOS by cleaning, concatenating, and grouping classification CSV files using regex and text manipulation tools. Use this skill when you need to aggregate and filter large volumes of citizen science classification results to identify consensus in insect species observations."
homepage: https://workflowhub.eu/workflows/660
---

# SPIPOLL MMOS GAPARS crowdsourcing results

## Overview

This Galaxy workflow is designed to process and analyze crowdsourcing results from the SPIPOLL (Suivi Photographique des Insectes POLLinisateurs) project, specifically focusing on data integrated through MMOS and GAPARS. It automates the ingestion of raw classification data, typically provided in fragmented CSV formats, to streamline the evaluation of citizen science pollinator observations.

The pipeline begins with data cleaning and structural standardization. It utilizes text processing tools to remove headers, select specific data segments, and concatenate multiple datasets into a unified format. Regular expressions are applied through "Regex Find And Replace" steps to normalize strings and ensure consistency across the crowdsourced entries.

In the final stages, the workflow performs data aggregation and filtering. It uses grouping operations to summarize classification results and employs multiple "Select" (Grep) steps to isolate specific subsets of data. This structured approach allows researchers to efficiently extract meaningful insights from large-scale crowdsourcing inputs.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |
| 1 | classifications-000312899389-000316591628.csv.part_00000 | data_input |  |


Ensure your crowdsourcing classification data is formatted as CSV or tabular files to match the text-processing requirements of the workflow. Input [0] must be provided as a dataset collection for batch processing, while Input [1] requires a single CSV part file. Consult the `README.md` for specific details on the expected column structures and regex patterns used in the filtering steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Remove beginning | Remove beginning1 |  |
| 3 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/1.1.0 |  |
| 4 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 5 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 6 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 7 | Concatenate datasets | cat1 |  |
| 8 | Group | Grouping1 |  |
| 9 | Group | Grouping1 |  |
| 10 | Select | Grep1 |  |
| 11 | Select | Grep1 |  |
| 12 | Select | Grep1 |  |
| 13 | Select | Grep1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-SPIPOLL_MMOS_GAPARS_crowdsourcing_results.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-SPIPOLL_MMOS_GAPARS_crowdsourcing_results.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-SPIPOLL_MMOS_GAPARS_crowdsourcing_results.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-SPIPOLL_MMOS_GAPARS_crowdsourcing_results.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-SPIPOLL_MMOS_GAPARS_crowdsourcing_results.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-SPIPOLL_MMOS_GAPARS_crowdsourcing_results.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
