---
name: workflow7-beta-diversity-galaxy-training-16s-microbial-analy
description: This 16S microbial analysis workflow processes shared OTU files and subsampled data using Mothur tools to calculate distance matrices and generate beta diversity visualizations. Use this skill when you need to compare microbial community composition between different samples or groups through distance-based clustering, heatmaps, and Venn diagrams.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow7-beta-diversity-galaxy-training-16s-microbial-analy

## Overview

This workflow is a specialized component of the [Galaxy Training Network](https://training.galaxyproject.org/training-material/topics/metagenomics/tutorials/mothur-16s/tutorial.html) suite for 16S microbial analysis using mothur. It focuses on beta diversity, allowing researchers to compare microbial community composition across different samples or experimental groups to identify patterns of similarity and divergence.

The process begins by taking shared OTU (Operational Taxonomic Unit) files and subsampled data as primary inputs. It utilizes the `mothur_dist_shared` tool to calculate distance matrices, which quantify the ecological distance between samples. These calculations form the basis for all subsequent comparative analyses and visualizations within the pipeline.

To visualize these relationships, the workflow generates several key outputs: a similarity heatmap via `Heatmap.sim`, a Newick-formatted cluster dendrogram using `Tree.shared` (rendered by `Newick Display`), and Venn diagrams to illustrate shared OTUs between specific groups. These tools provide a comprehensive overview of how microbial communities cluster and differ across the dataset.

Licensed under the MIT license and tagged for Microbiome and GTN applications, this workflow streamlines the transition from processed OTU tables to publication-ready diversity metrics. It ensures a standardized approach to ecological clustering and community comparison in 16S rRNA gene sequencing studies.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Shared file from Make.shared | data_input |  |
| 1 | Sub.sample shared | data_collection_input |  |


Ensure you have the `.shared` file generated from previous mothur steps, as this workflow requires both a single dataset and a sub-sampled collection to calculate distance matrices and diversity metrics. Use a dataset collection for the sub-sampled shared files to allow the workflow to process multiple groups or iterations simultaneously through tools like `Dist.shared`. Refer to the `README.md` for specific parameter configurations and detailed descriptions of the expected input formats. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Dist.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_dist_shared/mothur_dist_shared/1.39.5.0 |  |
| 3 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 4 | Heatmap.sim | toolshed.g2.bx.psu.edu/repos/iuc/mothur_heatmap_sim/mothur_heatmap_sim/1.39.5.0 |  |
| 5 | Tree.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_tree_shared/mothur_tree_shared/1.39.5.0 |  |
| 6 | Venn | toolshed.g2.bx.psu.edu/repos/iuc/mothur_venn/mothur_venn/1.39.5.0 |  |
| 7 | Newick Display | toolshed.g2.bx.psu.edu/repos/iuc/newick_utils/newick_display/1.6+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |
| 4 | heatmap | heatmap |
| 5 | tre | tre |
| 6 | svgs_out | svgs_out |
| 7 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow7-beta-diversity.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow7-beta-diversity.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow7-beta-diversity.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow7-beta-diversity.ga -o job.yml`
- Lint: `planemo workflow_lint workflow7-beta-diversity.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow7-beta-diversity.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)