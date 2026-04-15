---
name: visualise-amount-of-objects-in-museum-collection
description: This workflow processes tabular museum collection data and stop words using text mining tools, Datamash, and regex to generate bar charts and word clouds. Use this skill when you need to identify the chronological distribution of museum acquisitions and visualize the most frequent object types within a cultural heritage dataset.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# visualise-amount-of-objects-in-museum-collection

## Overview

This workflow is designed for text mining and visualizing museum collection data provided in tabular format. It processes raw collection records to identify temporal trends and common object types, utilizing a suite of Galaxy tools for data cleaning, transformation, and aggregation.

The pipeline begins by cleaning metadata using [Filter Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1) and [Regex Find And Replace](https://toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3). It then employs [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0) to aggregate the records, allowing users to determine which years produced the highest volume of objects within the collection.

The final outputs provide two distinct visual perspectives: a bar chart generated via gnuplot to show the distribution of objects over time, and a word cloud created using the [wordcloud](https://toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy2) tool. The word cloud highlights frequent terms within the collection descriptions after filtering out common English stop words, helping researchers identify the most prevalent types of items.

Developed as part of the [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) resources, this workflow is particularly useful for cultural heritage data analysis (#4culture). It is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input | data_input | Upload a tsv file with multiple rows and columns to compute on. |
| 1 | stop_words_english | data_input | Upload a list of English stop words in a .txt-format. |


Ensure your primary input is a clean tabular file (CSV or TSV) containing museum metadata, alongside a standard text file for English stop words to refine the word cloud generation. Verify that date columns are consistently formatted to allow the sorting and Datamash tools to correctly aggregate object counts by year. For large-scale analysis, consider using data collections to process multiple museum catalogs simultaneously. Refer to the `README.md` for specific column index requirements and regex patterns used in the text-cleaning steps. You can automate the execution setup by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Cut | Cut1 |  |
| 3 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.1 |  |
| 4 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.3 |  |
| 5 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 6 | Remove beginning | Remove beginning1 |  |
| 7 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 8 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 9 | Bar chart | barchart_gnuplot |  |
| 10 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/9.5+galaxy2 |  |
| 11 | Select first | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_head_tool/9.5+galaxy2 |  |
| 12 | Cut | Cut1 |  |
| 13 | Parse parameter value | param_value_from_file |  |
| 14 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 15 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/9.5+galaxy2 |  |
| 16 | Cut | Cut1 |  |
| 17 | Generate a word cloud | toolshed.g2.bx.psu.edu/repos/bgruening/wordcloud/wordcloud/1.9.4+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | out_file1 | out_file1 |
| 17 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run visualise-amount-of-objects-in-museum-collection.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run visualise-amount-of-objects-in-museum-collection.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run visualise-amount-of-objects-in-museum-collection.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init visualise-amount-of-objects-in-museum-collection.ga -o job.yml`
- Lint: `planemo workflow_lint visualise-amount-of-objects-in-museum-collection.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `visualise-amount-of-objects-in-museum-collection.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)