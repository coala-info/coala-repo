---
name: mgnify-amplicon-summary-tables
description: "This metagenomics workflow utilizes Query Tabular and column joining tools to transform OTU table collections into standardized taxonomic abundance summary tables. Use this skill when you need to synthesize amplicon sequencing data into phylum-level and multi-level taxonomic profiles to compare microbial community compositions across multiple datasets."
homepage: https://workflowhub.eu/workflows/1269
---

# MGnify amplicon summary tables

## Overview

This workflow generates comprehensive taxonomic abundance summary tables from [MGnify](https://www.ebi.ac.uk/metagenomics/) amplicon pipeline results. It processes a collection of OTU tables to produce consolidated reports at both the phylum level and across all taxonomic ranks, facilitating downstream comparative analysis of metagenomic datasets.

The pipeline utilizes a series of data transformation steps, including [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) and [AWK-based text reformatting](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0), to clean and structure the raw data. It then employs column joining and grouping tools to aggregate abundance counts from multiple samples into unified tabular outputs.

Users can specify custom names for the resulting summary tables via parameter inputs. This workflow is part of the [microgalaxy](https://github.com/microgalaxy-project) suite and is released under the MIT license. For detailed information on input preparation and file structures, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | OTU tables | data_collection_input | OTU tables. |
| 1 | Taxonomic abundance summary table name | parameter_input | specifies the name of taxonomic summary file. |
| 2 | Phylum level taxonomic abundance summary table name | parameter_input | specifies the name of taxonomic summary file, for phylum level. |


Ensure your input OTU tables are organized within a dataset collection to allow the workflow to aggregate results across multiple samples into single summary tables. These files should be in tabular format, typically following the standard output structure of the MGnify amplicon pipeline. For automated execution and testing, you can define your input parameters and collection paths using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on file formatting and specific naming conventions for the output abundance tables.

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
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
