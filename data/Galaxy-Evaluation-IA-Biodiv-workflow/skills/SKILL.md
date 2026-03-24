---
name: evaluation-ia-biodiv-workflow
description: "This Galaxy workflow processes participant results and reference attribute files from the IA-Biodiv challenge using an interactive JupyterLab notebook to calculate performance scores for each consortium. Use this skill when you need to assess the accuracy of biodiversity identification models or generate standardized evaluation metrics for competitive AI benchmarks."
homepage: https://workflowhub.eu/workflows/1181
---

# Evaluation IA-Biodiv workflow

## Overview

This Galaxy workflow is designed to evaluate the performance of participants in the IA-Biodiv challenge. It automates the scoring process by comparing submitted results against reference datasets for specific biodiversity tasks, facilitating a standardized assessment of AI models.

The workflow requires two primary inputs: a TSV file containing the participant's predictions (such as `IABiodiv_DryRun_participant_v.tsv`) and a corresponding reference attribute file (`Tn_attributes_REF.tsv`). These datasets are fed into an [Interactive JupyterLab Notebook](https://jupyter.org/) environment integrated directly within the Galaxy interface.

Inside the Jupyter environment, the workflow executes scripts to calculate performance metrics and generate final scores for each participating consortium. This approach provides a flexible yet reproducible framework for evaluating complex data science tasks in the context of biodiversity research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | IABiodiv_DryRun_participant_v.tsv | data_input | AI submission file, participants results to evaluate |
| 1 | Tn_attributes_REF.tsv | data_input | AI evaluation reference file |


Ensure all input files are provided in TSV format, specifically matching the expected schema for participant submissions and reference attributes. While the workflow accepts individual datasets, utilizing dataset collections is recommended if you need to evaluate multiple challenge tasks in a single run. Refer to the `README.md` for precise details on required column headers and data formatting to ensure the Jupyter notebook executes correctly. For automated testing or command-line execution, use `planemo workflow_job_init` to create a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Interactive JupyterLab Notebook | interactive_tool_jupyter_notebook |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Evaluation_IA-Biodiv_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Evaluation_IA-Biodiv_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Evaluation_IA-Biodiv_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Evaluation_IA-Biodiv_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Evaluation_IA-Biodiv_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Evaluation_IA-Biodiv_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
