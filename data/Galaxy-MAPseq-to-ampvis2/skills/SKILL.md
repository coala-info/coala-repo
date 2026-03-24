---
name: mapseq-to-ampvis2
description: "This microbiome workflow processes MAPseq OTU tables and metadata using Query Tabular and text reformatting tools to generate structured datasets for ampvis2 analysis. Use this skill when you need to transform raw MAPseq taxonomic assignments into a standardized format for downstream visualization and statistical analysis of microbial community diversity."
homepage: https://workflowhub.eu/workflows/1855
---

# MAPseq to ampvis2

## Overview

This workflow is designed to bridge the gap between MAPseq taxonomic assignments and the [ampvis2](https://toolshed.g2.bx.psu.edu/repos/iuc/ampvis2_load/ampvis2_load/2.8.9+galaxy0) R package for microbiome visualization. It takes a collection of MAPseq OTU tables and a corresponding metadata file as primary inputs to generate structured data suitable for community analysis.

The pipeline utilizes a series of text processing tools, including [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) and [AWK reformatting](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0), to restructure raw taxonomic data. By collapsing collections and joining columns, the workflow ensures that abundance counts and taxonomic hierarchies are correctly aligned and formatted.

The final stage of the workflow generates a specialized Ampvis2 object along with refined OTU and taxonomy tables. These outputs allow researchers to perform high-level microbiome visualizations, such as heatmaps and ordination plots, directly within the [Galaxy](https://galaxyproject.org/) environment. This workflow is particularly useful for GTN-based microbiome tutorials and standardized bioinformatics pipelines under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | MAPseq OTU tables | data_collection_input | A dataset collection containing the tab-separated OTU outputs of MAPseq. |
| 1 | OTU table metadata | data_input | Contextual information associated with the data from the OTU tables. |


Ensure your MAPseq OTU tables are organized into a list collection of tabular files, while the metadata should be provided as a single tabular dataset with sample identifiers matching the collection keys. Verify that the metadata file includes a header row and that sample names correspond exactly to the collection labels to ensure successful merging in the downstream processing steps. For comprehensive details on column specifications and formatting requirements, refer to the `README.md` file. You can also use `planemo workflow_job_init` to create a `job.yml` for streamlined input configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 3 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 4 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 5 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 6 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |
| 7 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 8 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0 |  |
| 9 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2 |  |
| 10 | ampvis2 load | toolshed.g2.bx.psu.edu/repos/iuc/ampvis2_load/ampvis2_load/2.8.9+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | OTU table | outfile |
| 9 | Taxonomy table | output |
| 10 | Ampvis2 object | ampvis |
| 10 | Ampvis2 metadata table | metadata_list_out |
| 10 | Ampvis2 taxonomy table | taxonomy_list_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run mapseq-to-ampvis2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mapseq-to-ampvis2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mapseq-to-ampvis2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mapseq-to-ampvis2.ga -o job.yml`
- Lint: `planemo workflow_lint mapseq-to-ampvis2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mapseq-to-ampvis2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
