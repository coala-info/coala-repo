---
name: workflow-constructed-from-history-heinz-workflow-trial-sep-1
description: "This transcriptomics workflow processes edge files and dataset collections using DESeq2 and the Heinz suite to perform BUM model fitting, scoring, and optimal subnetwork identification. Use this skill when you need to extract biologically meaningful modules from a large interaction network by prioritizing genes with significant differential expression."
homepage: https://workflowhub.eu/workflows/1677
---

# Workflow Constructed From History 'Heinz Workflow Trial Sep 11'

## Overview

This workflow facilitates advanced transcriptomics network analysis by identifying optimal scoring subnetworks from differential expression data. It is designed to automate the [Heinz](https://toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz/1.0) algorithmic pipeline, a common approach in [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorials for discovering functional biological modules.

The process begins by analyzing input dataset collections using [DESeq2](https://toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.2) to perform differential gene expression analysis. After refining the output with data manipulation tools, the workflow fits a Beta-Uniform Mixture (BUM) model to the resulting p-values. This statistical step is crucial for distinguishing significant biological signals from background noise.

In the final stages, the workflow integrates an edge file to provide network topology. It calculates [Heinz scores](https://toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz_scoring/1.0) for the nodes and executes the Heinz algorithm to extract the most significant subnetwork. The results are then processed through a [visualization tool](https://toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz_visualization/0.1.0) to produce an interpretable map of the identified molecular interactions.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Edge File | data_input | The background network |
| 1 | Input Dataset Collection | data_collection_input |  |
| 2 | Input Dataset Collection | data_collection_input |  |


Ensure the Edge File is provided in a compatible tabular format, while your transcriptomics data should be organized into dataset collections to facilitate batch processing through the DESeq2 and Heinz scoring steps. Using collections is particularly important for managing the multiple replicates required for differential expression analysis before fitting the BUM model. Refer to the included README.md for specific column requirements and detailed parameter settings for the network analysis. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.2 |  |
| 4 | Cut | Cut1 |  |
| 5 | Cut | Cut1 |  |
| 6 | Fit a BUM model | toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz_bum/1.0 |  |
| 7 | Calculate a Heinz score | toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz_scoring/1.0 |  |
| 8 | Identify optimal scoring subnetwork | toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz/1.0 |  |
| 9 | Visualize | toolshed.g2.bx.psu.edu/repos/iuc/heinz/heinz_visualization/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-heinz.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-heinz.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-heinz.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-heinz.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-heinz.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-heinz.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
