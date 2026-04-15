---
name: workflow-0
description: This Galaxy workflow processes GenBank fragments to evaluate their manufacturability and saves the resulting annotated sequences and reports into a relational database. Use this skill when you need to determine the synthetic feasibility of genetic parts and systematically store validated sequence data for large-scale DNA assembly or metabolic engineering projects.
homepage: https://parisbiofoundry.org/the-asu-biofoundry/
metadata:
  docker_image: "N/A"
---

# workflow-0

## Overview

This workflow automates the evaluation and storage of genetic fragments. It takes a collection of GenBank files as input and processes them to determine their suitability for synthesis while simultaneously managing the integration of this data into a structured database.

The pipeline first utilizes the [Evaluate Manufacturability](https://toolshed.g2.bx.psu.edu/repos/tduigou/evaluate_manufacturability/evaluate_manufacturability/0.1.0+galaxy0) tool to analyze the input fragments. This step generates annotated GenBank files along with comprehensive manufacturability reports in both TSV and PDF formats, providing a clear assessment of whether the sequences can be successfully produced.

In the final stage, the workflow employs the [Save Sequence Data In DB](https://toolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.2.0+galaxy1) tool to upload the sequence and annotation data. Users can configure specific database parameters, such as the DB URI, table names, and column mappings, allowing for seamless synchronization between the analysis results and an external sequence database.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Fragments GenBank | data_collection_input |  |
| 1 | DB Table Name | parameter_input |  |
| 2 | DB Column Contains Sequence For gb Files | parameter_input |  |
| 3 | DB Column Contains Annotation For gb Files | parameter_input |  |
| 4 | DB IDs Column Name | parameter_input | column contains fragments names |
| 5 | DB URI | parameter_input |  |
| 6 | Enable save to DB | parameter_input |  |


Ensure the primary input is provided as a GenBank collection (.gb or .gbk) to allow the workflow to batch-process multiple fragments through the manufacturability evaluation and database upload steps. You must provide a valid SQL URI and matching column names to ensure the sequence data and annotations are correctly committed to your database. Consult the README.md file for specific database schema requirements and detailed parameter definitions. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Evaluate Manufacturability | toolshed.g2.bx.psu.edu/repos/tduigou/evaluate_manufacturability/evaluate_manufacturability/0.1.0+galaxy0 |  |
| 8 | Save Sequence Data In DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Evaluate Manufacturability (gb) | annotated_gb |
| 7 | Manufacturability Report (tsv) | report_tsv |
| 7 | Manufacturability Report (PDF) | report_pdf |
| 8 | saving report | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-0.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-0.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-0.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-0.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-0.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-0.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)