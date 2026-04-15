---
name: simtext-training-workflow
description: This workflow analyzes the similarity between search queries by retrieving PubMed literature and generating PubTator matrices for interactive visualization using the pubmed_by_queries and simtext_app tools. Use this skill when you need to characterize the functional or thematic relationships between a set of genes or biological concepts based on their shared vocabulary in published research.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# simtext-training-workflow

## Overview

This workflow is designed for text-mining and statistical analysis of biomedical literature, specifically focusing on the similarity between sets of search queries such as genes or diseases. By leveraging the associated vocabulary in [PubMed](https://pubmed.ncbi.nlm.nih.gov/), the pipeline allows researchers to quantify and visualize how closely related different biological entities are based on their mentions in scientific publications.

The process begins by retrieving relevant literature using the **PubMed query** tool, which is then processed through the **PMIDs to PubTator** tool. This step converts PubMed IDs into a structured matrix of biological entities, enabling the comparison of queries based on their co-occurrence and thematic overlap within the literature.

The workflow concludes with the **simtext_app**, an interactive tool that provides a visual environment for inspecting the processed data. This allows for an intuitive exploration of the text-mining results, making it a valuable resource for [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials and comparative literature studies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


The primary input should be a tabular or text file containing a list of search queries, such as gene names or keywords, formatted as a single-column dataset. While individual datasets are standard, utilizing list collections can significantly streamline the workflow when processing multiple distinct query sets in parallel. Please refer to the `README.md` for comprehensive details on query syntax and specific parameter configurations required for the PubMed and PubTator tools. You may also use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution of this text-mining pipeline.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | PubMed query | toolshed.g2.bx.psu.edu/repos/iuc/pubmed_by_queries/pubmed_by_queries/0.0.2 |  |
| 2 | PMIDs to PubTator | toolshed.g2.bx.psu.edu/repos/iuc/pmids_to_pubtator_matrix/pmids_to_pubtator_matrix/0.0.2 |  |
| 3 | simtext_app | interactive_tool_simtext_app |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | output | output |
| 2 | output | output |
| 3 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)