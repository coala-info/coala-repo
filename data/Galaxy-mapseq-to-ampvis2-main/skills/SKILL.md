---
name: mapseq-to-ampvis2
description: This Galaxy workflow processes MAPseq OTU tables and metadata using text reformatting tools, Query Tabular, and ampvis2 load to generate structured datasets for microbiome analysis. Use this skill when you need to prepare taxonomic classification data for visualization and statistical analysis of microbial community structures within the ampvis2 ecosystem.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# mapseq-to-ampvis2

## Overview

The MAPseq to ampvis2 workflow is designed to bridge the gap between [MAPseq](https://github.com/jfmz/MAPseq) taxonomic classifications and the [ampvis2](https://github.com/MadsAlbertsen/ampvis2) R package for microbial community analysis. It automates the transformation of raw MAPseq OTU tables and associated metadata into the specific structured formats required for downstream visualization and statistical analysis.

The pipeline utilizes a series of text processing steps, including [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.2) and [AWK reformatting](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.5+galaxy0), to clean and reorganize data collections. It collapses and joins disparate datasets to ensure that taxonomic assignments and sequence counts are correctly aligned with sample metadata.

The final outputs include a formatted OTU table, a dedicated taxonomy table, and a native Ampvis2 R object. These files allow users to immediately perform advanced ecological analyses, such as heatmaps, PCoA plots, and alpha diversity calculations, within the Galaxy environment or a local R session. This workflow is released under the [MIT license](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | MAPseq OTU tables | data_collection_input | A dataset collection containing the tab-separated OTU outputs of MAPseq. |
| 1 | OTU table metadata | data_input | Contextual information associated with the data from the OTU tables. |


Ensure your MAPseq OTU tables are provided as a data collection of tabular files, while the associated metadata should be uploaded as a single tabular dataset. Verify that your metadata file includes sample identifiers that match the collection element names to ensure successful joining during the Query Tabular and Column Join steps. For comprehensive formatting requirements and column specifications, refer to the README.md file. You can streamline the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

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
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)