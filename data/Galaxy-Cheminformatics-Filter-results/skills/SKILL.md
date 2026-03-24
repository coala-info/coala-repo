---
name: covid-19-cheminformatics-5-filter-results
description: "This cheminformatics workflow processes Mpro docking poses and Fragment Network data using Open Babel, JQ, and text processing tools to filter and rank potential inhibitors. Use this skill when you need to select the most promising lead compounds for chemical synthesis and experimental validation based on docking scores and structural network analysis."
homepage: https://workflowhub.eu/workflows/17
---

# COVID-19 - Cheminformatics [5] Filter results

## Overview

This workflow represents the fifth stage in a COVID-19 cheminformatics pipeline focused on the Main protease (Mpro). Its primary objective is the selection of compounds for synthesis by filtering and prioritizing docking results. It processes high-scoring docking poses alongside structural data from fragment networks to refine the candidate pool.

The technical process involves extracting chemical properties and scores from SD-files using [OpenBabel](https://openbabel.org/wiki/Main_Page) and [SDF to Tab](https://toolshed.g2.bx.psu.edu/view/bgruening/sdf_to_tab). It integrates external JSON data via [JQ](https://stedolan.github.io/jq/) and utilizes [Datamash](https://www.gnu.org/software/datamash/) for data aggregation. These steps allow the workflow to evaluate compounds based on both their docking performance and their relationship to known fragment hits.

In the final stages, the workflow joins, sorts, and filters the aggregated data to isolate a user-defined number of top hits. The resulting curated list provides prioritized chemical candidates, facilitating the transition from computational virtual screening to experimental validation and synthesis in COVID-19 drug discovery efforts.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Mpro final scored docking poses | data_collection_input |  |
| 1 | Top N hits | parameter_input |  |
| 2 | Json file from the Fragment Network | data_input |  |


Ensure your input docking poses are provided as a dataset collection of SDF files to maintain metadata, while the Fragment Network data must be in JSON format for proper parsing. Use the "Top N hits" parameter to define the specific threshold for compound selection based on your scoring criteria. For automated execution and testing, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on specific filtering parameters and scoring thresholds used in this selection process.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Change title | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_change_title/openbabel_change_title/2.4.2.1.1 |  |
| 4 | JQ | toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0 |  |
| 5 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 6 | Extract values from an SD-file | toolshed.g2.bx.psu.edu/repos/bgruening/sdf_to_tab/sdf_to_tab/2019.03.1.1 |  |
| 7 | Filter | Filter1 |  |
| 8 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 9 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 10 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.2 |  |
| 11 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 12 | Cut | Cut1 |  |
| 13 | Remove beginning | Remove beginning1 |  |
| 14 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/1.1.0 |  |
| 15 | Filter | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_filter/openbabel_filter/2.4.2.1.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | output | output |
| 7 | out_file1 | out_file1 |
| 8 | output | output |
| 9 | out_file | out_file |
| 11 | outfile | outfile |
| 14 | outfile | outfile |
| 15 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Cheminformatics-5-Filter_results.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Cheminformatics-5-Filter_results.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Cheminformatics-5-Filter_results.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Cheminformatics-5-Filter_results.ga -o job.yml`
- Lint: `planemo workflow_lint Cheminformatics-5-Filter_results.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Cheminformatics-5-Filter_results.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
