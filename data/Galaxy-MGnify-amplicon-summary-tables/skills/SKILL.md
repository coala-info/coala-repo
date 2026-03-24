---
name: mgnify-amplicon-summary-tables
description: "This metagenomics workflow processes OTU tables using Query Tabular, awk text reformatting, and column joining to generate comprehensive taxonomic abundance summary tables. Use this skill when you need to aggregate amplicon sequencing results into structured phylum-level and general taxonomic profiles for comparative microbiome analysis."
homepage: https://workflowhub.eu/workflows/1851
---

# MGnify amplicon summary tables

## Overview

This workflow is designed to process results from the [MGnify](https://www.ebi.ac.uk/metagenomics/) amplicon pipeline, transforming raw OTU (Operational Taxonomic Unit) tables into structured taxonomic abundance summaries. It facilitates the transition from raw pipeline outputs to refined datasets suitable for downstream metagenomic analysis and visualization.

The pipeline utilizes a series of data manipulation tools, including `Query Tabular`, `Filter Tabular`, and `tp_awk_tool`, to filter and reformat input data collections. By performing grouping and column joining operations, the workflow aggregates taxonomic information across multiple samples, ensuring consistency and comparability across the dataset.

The final outputs consist of two primary summary tables: a comprehensive taxonomic abundance table and a specific phylum-level summary. These tables provide a high-level overview of microbial community composition, formatted for easy integration into further bioinformatics workflows or reporting tools.

Developed as part of the [microgalaxy](https://github.com/microgalaxy-project) initiative and aligned with [GTN](https://training.galaxyproject.org/) standards, this workflow is licensed under the MIT license. It serves as a key utility for researchers working with amplicon sequencing data within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | OTU tables | data_collection_input | OTU tables. |
| 1 | Taxonomic abundance summary table name | parameter_input | specifies the name of taxonomic summary file. |
| 2 | Phylum level taxonomic abundance summary table name | parameter_input | specifies the name of taxonomic summary file, for phylum level. |


Ensure your input OTU tables are in tabular format and organized into a single data collection to allow the workflow to process multiple samples simultaneously. You should provide descriptive strings for the taxonomic and phylum-level summary table names to clearly identify the resulting outputs. For comprehensive details on file formatting and specific parameter settings, refer to the README.md file. You can also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 4 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 5 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 6 | Group | Grouping1 |  |
| 7 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 8 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 |  |
| 9 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 10 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 11 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 12 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | Taxonomic abundance summary table | outfile |
| 12 | phylum level taxonomic abundance summary table | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mgnify-amplicon-summary-tables.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mgnify-amplicon-summary-tables.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mgnify-amplicon-summary-tables.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mgnify-amplicon-summary-tables.ga -o job.yml`
- Lint: `planemo workflow_lint mgnify-amplicon-summary-tables.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mgnify-amplicon-summary-tables.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
