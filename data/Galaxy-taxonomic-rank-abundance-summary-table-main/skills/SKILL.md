---
name: taxonomic-abundance-summary-tables-for-a-specified-taxonomic
description: This metagenomics workflow processes MAPseq OTU table collections using text reformatting, grouping, and column joining tools to generate abundance summary tables for a user-defined taxonomic rank. Use this skill when you need to aggregate amplicon sequencing data to compare the relative abundance of specific taxa across multiple datasets at a consistent taxonomic level.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# taxonomic-abundance-summary-tables-for-a-specified-taxonomic

## Overview

This workflow is designed for metagenomics and amplicon sequencing analysis, specifically within the [microgalaxy](https://github.com/microgalaxy-project) and MGnify frameworks. It automates the generation of consolidated taxonomic abundance summary tables from a collection of OTU tables produced by the MAPseq tool.

The process begins by taking a data collection of OTU tables and a user-specified taxonomic rank as inputs. It utilizes a series of text processing steps, including `awk` reformatting and tabular filtering, to isolate data at the requested taxonomic level. The workflow maps parameter values and groups data before performing a column join to merge results from multiple samples into a single, unified table.

The final output is a comprehensive summary table representing the abundance of taxa at the chosen rank across all input datasets. This streamlined approach is essential for downstream statistical analysis and visualization in microbial ecology studies. This workflow is released under the [MIT License](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | OTU tables | data_collection_input | OTU tables. |
| 1 | Taxonomic rank | parameter_input | Choose a taxonomic rank for a dedicated taxonomic abundance summary table. |


Ensure your input is a dataset collection of tabular OTU tables, specifically those formatted by MAPseq, to allow for successful column joining across all samples. The taxonomic rank parameter must be set to the desired level of aggregation, such as genus or family, to ensure the grouping and filtering tools process the data correctly. For comprehensive details on input formatting and specific parameter constraints, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 3 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 4 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 5 | Group | Grouping1 |  |
| 6 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 |  |
| 7 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 8 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | Taxonomic rank summary table | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run taxonomic-rank-abundance-summary-table.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run taxonomic-rank-abundance-summary-table.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run taxonomic-rank-abundance-summary-table.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init taxonomic-rank-abundance-summary-table.ga -o job.yml`
- Lint: `planemo workflow_lint taxonomic-rank-abundance-summary-table.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `taxonomic-rank-abundance-summary-table.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)