---
name: biotranslator-workflow
description: This BioTranslator workflow processes an input gene list to perform functional annotation and prioritization using the BioTranslator tool. Use this skill when you need to identify enriched Gene Ontology terms, prioritize candidate genes, and generate heatmaps to visualize functional relationships within a specific gene set.
homepage: https://workflowhub.eu/workflows/189
metadata:
  docker_image: "N/A"
---

# biotranslator-workflow

## Overview

The BioTranslator Workflow is designed to automate the functional interpretation of genomic data by mapping gene lists to biological concepts. It accepts a user-provided **Input Gene List** as its primary data source, serving as a streamlined pipeline for Gene Ontology (GO) analysis within the Galaxy ecosystem.

At the core of the workflow is the **biotranslator_lite** tool. This step leverages the BioTranslator framework to perform semantic translation between genes and functional annotations. It evaluates the relationships within the input list to identify significant biological themes and prioritize genes based on their functional relevance.

The workflow generates three primary outputs: **GO Enriched Terms**, **GO Gene Prioritization**, and a **GO Heatmap**. These results provide a comprehensive view of the biological processes involved, offering both statistical summaries and visual representations of the gene-to-term associations for downstream analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Gene List | data_input | The input gene set (gene symbols or ensembl gene ids) in 'txt' format. |


Ensure the input gene list is provided as a tabular or text file containing valid gene identifiers compatible with the BioTranslator tool. While the workflow typically processes individual datasets, you may utilize dataset collections to run the analysis across multiple gene lists simultaneously. For comprehensive details on supported identifier formats and parameter configurations, please consult the `README.md` file. You can also use `planemo workflow_job_init` to create a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | BioTranslator | biotranslator_lite | The algorithm consists of two sequential tasks: 1. Pathway Analysis, using the selected ontology 2. Gene Prioritization on the derived network of the enriched terms  Outputs: 1. The enriched terms 2. The highly prioritized input genes 3. A heatmap which illustrates the association between prioritized genes and semantic clusters |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | GO Enriched Terms | tp |
| 1 | GO Gene Prioritization | gp |
| 1 | GO Heatmap | hm |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-BioTranslator_Workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-BioTranslator_Workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-BioTranslator_Workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-BioTranslator_Workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-BioTranslator_Workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-BioTranslator_Workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)