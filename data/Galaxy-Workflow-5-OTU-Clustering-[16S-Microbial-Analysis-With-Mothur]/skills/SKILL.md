---
name: workflow-5-gucfg2galaxy-otu-clustering-16s-microbial-analysi
description: This metagenomics workflow processes 16S rRNA sequences, count tables, and taxonomy data using Mothur tools to perform OTU clustering, taxonomic classification, and sample normalization. Use this skill when you need to group processed microbial sequences into taxonomic clusters and generate shared files for comparing community composition across different environmental or clinical samples.
homepage: https://www.qcif.edu.au/
metadata:
  docker_image: "N/A"
---

# workflow-5-gucfg2galaxy-otu-clustering-16s-microbial-analysi

## Overview

This workflow is designed for the Operational Taxonomic Unit (OTU) clustering phase of 16S rRNA microbial analysis using the [Mothur](https://mothur.org/) toolset. It processes refined sequences, count tables, and taxonomy assignments to group sequences into OTUs based on genetic similarity, a critical step in characterizing microbial community structures.

The pipeline utilizes the `cluster.split` method to efficiently assign sequences to OTUs, followed by the `make.shared` tool to generate a shared file (OTU table) that tracks OTU abundance across different samples. It further refines these results by assigning consensus taxonomy to each cluster using `classify.otu`, allowing researchers to identify the organisms represented within the dataset.

To ensure statistical comparability between samples with varying sequencing depths, the workflow incorporates `count.groups` and `sub.sample` steps for data normalization. The final outputs include taxonomic summaries, rarefied shared files, and detailed OTU lists, providing a standardized dataset for downstream [metagenomics](https://galaxyproject.org/use/metagenomics/) analysis and diversity estimation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sequences | data_input |  |
| 1 | Count Table | data_input |  |
| 2 | Taxonomy | data_input |  |


Ensure your input files are correctly formatted as Mothur-specific types, specifically `.fasta` for sequences, `.count_table` for abundance data, and `.taxonomy` for classification strings. While these inputs are typically handled as individual datasets, ensure they are properly synchronized from previous processing steps to avoid metadata mismatches during clustering. Refer to the `README.md` for exhaustive details on distance thresholds and specific tool parameters. You can use `planemo workflow_job_init` to generate a `job.yml` for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Cluster.split | toolshed.g2.bx.psu.edu/repos/iuc/mothur_cluster_split/mothur_cluster_split/1.39.5.0 |  |
| 4 | Make.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_shared/mothur_make_shared/1.39.5.0 |  |
| 5 | Classify.otu | toolshed.g2.bx.psu.edu/repos/iuc/mothur_classify_otu/mothur_classify_otu/1.39.5.0 |  |
| 6 | Count.groups | toolshed.g2.bx.psu.edu/repos/iuc/mothur_count_groups/mothur_count_groups/1.39.5.0 |  |
| 7 | Sub.sample | toolshed.g2.bx.psu.edu/repos/iuc/mothur_sub_sample/mothur_sub_sample/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | sensspec | sensspec |
| 3 | sabund | sabund |
| 3 | otulist | otulist |
| 3 | rabund | rabund |
| 4 | groupout | groupout |
| 4 | shared | shared |
| 5 | taxsummaries | taxsummaries |
| 5 | taxonomies | taxonomies |
| 6 | summary | summary |
| 6 | grp_count | grp_count |
| 7 | shared_out | shared_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_5_[gucfg2galaxy]__OTU_Clustering_[16S_Microbial_Analysis_With_Mothur].ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_5_[gucfg2galaxy]__OTU_Clustering_[16S_Microbial_Analysis_With_Mothur].ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_5_[gucfg2galaxy]__OTU_Clustering_[16S_Microbial_Analysis_With_Mothur].ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_5_[gucfg2galaxy]__OTU_Clustering_[16S_Microbial_Analysis_With_Mothur].ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_5_[gucfg2galaxy]__OTU_Clustering_[16S_Microbial_Analysis_With_Mothur].ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_5_[gucfg2galaxy]__OTU_Clustering_[16S_Microbial_Analysis_With_Mothur].ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)