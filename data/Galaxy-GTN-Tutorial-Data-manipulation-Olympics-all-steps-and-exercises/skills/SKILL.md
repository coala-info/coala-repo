---
name: gtn-tutorial-data-manipulation-olympics-all-steps-and-exerci
description: "This workflow processes Olympic Games datasets using a comprehensive suite of tabular data tools including filtering, sorting, joining, and Datamash operations. Use this skill when you need to perform complex data cleaning, multi-file merging, and statistical aggregation on large tabular datasets to derive insights from historical or sports-related records."
homepage: https://workflowhub.eu/workflows/1601
---

# GTN Tutorial: Data manipulation Olympics - all steps and exercises

## Overview

This Galaxy workflow is designed as a comprehensive practical exercise for the [GTN tutorial: Data manipulation Olympics](https://training.galaxyproject.org/training-material/topics/introduction/tutorials/data-manipulation-olympics/tutorial.html). It provides a structured environment to master essential data processing skills using historical Olympic Games datasets. By working through various tabular data challenges, users learn how to clean, transform, and analyze complex datasets within the Galaxy ecosystem.

The pipeline utilizes a wide array of text processing tools to perform sophisticated data transformations. Key operations include filtering records based on specific criteria, sorting data, and performing arithmetic computations on columns. The workflow also demonstrates advanced techniques such as using regular expressions for find-and-replace tasks, joining disparate datasets (e.g., merging Olympic results with country information), and splitting files based on column values.

For data aggregation and summarization, the workflow heavily employs **Datamash** and counting tools. These steps allow users to generate statistics, group data by specific attributes, and collapse information to find unique entries. The final stages involve concatenating datasets and refining outputs to produce concise reports, such as identifying top-performing nations or calculating medal tallies across different years.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | olympics.tsv | data_input |  |
| 1 | country-information.tsv | data_input |  |
| 2 | olympics_2022.tsv | data_input |  |


Ensure all input files are uploaded as tabular (TSV) format to maintain column integrity for the subsequent filtering, sorting, and joining operations. Since this workflow processes individual datasets rather than collections, verify that each file is assigned the correct metadata upon import. For automated testing or batch execution, you can initialize a job configuration using `planemo workflow_job_init`. Refer to the README.md for comprehensive details on specific column indices and expected values for each exercise.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Line/Word/Character count | wc_gnu |  |
| 4 | tabular-to-csv | tabular_to_csv |  |
| 5 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 6 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 7 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 8 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 9 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 10 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 11 | Filter | Filter1 |  |
| 12 | Filter | Filter1 |  |
| 13 | Count | Count1 |  |
| 14 | Count | Count1 |  |
| 15 | Count | Count1 |  |
| 16 | Count | Count1 |  |
| 17 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 18 | Count | Count1 |  |
| 19 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0 |  |
| 20 | Filter | Filter1 |  |
| 21 | Filter | Filter1 |  |
| 22 | Filter | Filter1 |  |
| 23 | Filter | Filter1 |  |
| 24 | Filter | Filter1 |  |
| 25 | Filter | Filter1 |  |
| 26 | Filter | Filter1 |  |
| 27 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 28 | Compute | toolshed.g2.bx.psu.edu/repos/devteam/column_maker/Add_a_column1/1.6 |  |
| 29 | Cut | Cut1 |  |
| 30 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 31 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 32 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 33 | Cut | Cut1 |  |
| 34 | Cut | Cut1 |  |
| 35 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 36 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 37 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 38 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 39 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 40 | Count | Count1 |  |
| 41 | Column Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regexColumn1/1.0.1 |  |
| 42 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_on_column/tp_split_on_column/0.4 |  |
| 43 | Join two Datasets | join1 |  |
| 44 | Remove beginning | Remove beginning1 |  |
| 45 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 46 | Filter | Filter1 |  |
| 47 | Cut | Cut1 |  |
| 48 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |
| 49 | Count | Count1 |  |
| 50 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.1.0+galaxy2 |  |
| 51 | Concatenate datasets | cat1 |  |
| 52 | Filter | Filter1 |  |
| 53 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 54 | Remove beginning | Remove beginning1 |  |
| 55 | Select first | Show beginning1 |  |
| 56 | Sort | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sort_header_tool/1.1.1 |  |
| 57 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.1.0 |  |
| 58 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 59 | Join two Datasets | join1 |  |
| 60 | Cut | Cut1 |  |
| 61 | Line/Word/Character count | wc_gnu |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run data-manipulation-olympics-with-exercises.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run data-manipulation-olympics-with-exercises.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run data-manipulation-olympics-with-exercises.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init data-manipulation-olympics-with-exercises.ga -o job.yml`
- Lint: `planemo workflow_lint data-manipulation-olympics-with-exercises.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `data-manipulation-olympics-with-exercises.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
