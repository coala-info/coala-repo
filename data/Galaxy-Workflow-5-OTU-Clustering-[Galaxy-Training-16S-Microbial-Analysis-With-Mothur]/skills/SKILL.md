---
name: workflow-5-otu-clustering-galaxy-training-16s-microbial-anal
description: This microbiome workflow processes 16S rRNA sequences, count tables, and taxonomy data using mothur tools to perform OTU clustering, taxonomic classification, and sample normalization. Use this skill when you need to group processed microbial sequences into operational taxonomic units and generate shared abundance tables for downstream ecological diversity analysis.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-5-otu-clustering-galaxy-training-16s-microbial-anal

## Overview

This workflow represents the fifth stage of the [16S Microbial Analysis with mothur](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/mothur-16s/tutorial.html) pipeline. It is designed to cluster processed 16S rRNA gene sequences into Operational Taxonomic Units (OTUs), a critical step for characterizing microbial community structure and diversity.

The process begins by filtering specific groups and employing the `cluster.split` command, which assigns sequences to OTUs based on genetic distance. This method is optimized for efficiency by splitting the data into taxonomic groups before clustering. Once clustered, the workflow generates a "shared" file (an OTU table) that tracks the distribution and abundance of each OTU across the various samples in the dataset.

To provide biological context, the workflow classifies the resulting OTUs using the `classify.otu` tool and the provided taxonomy metadata. Finally, it performs sequence normalization through subsampling. This ensures that downstream alpha and beta diversity analyses are not biased by uneven sequencing depth across samples.

This technical skill is released under the MIT license and is tagged for Microbiome analysis within the Galaxy Training Network (GTN) framework.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sequences | data_input |  |
| 1 | Count Table | data_input |  |
| 2 | Taxonomy | data_input |  |


Ensure your input sequences, count table, and taxonomy files are in the specific mothur-standard formats (FASTA, count, and tax) generated from previous processing steps. While these inputs are typically handled as individual datasets, ensure they remain synchronized to avoid errors during the cluster split and shared file generation. For automated execution, you can initialize your configuration using `planemo workflow_job_init` to create a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific group handling.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Remove.groups | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_groups/mothur_remove_groups/1.39.5.0 |  |
| 4 | Cluster.split | toolshed.g2.bx.psu.edu/repos/iuc/mothur_cluster_split/mothur_cluster_split/1.39.5.0 |  |
| 5 | Make.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_shared/mothur_make_shared/1.39.5.0 |  |
| 6 | Classify.otu | toolshed.g2.bx.psu.edu/repos/iuc/mothur_classify_otu/mothur_classify_otu/1.39.5.0 |  |
| 7 | Count.groups | toolshed.g2.bx.psu.edu/repos/iuc/mothur_count_groups/mothur_count_groups/1.39.5.0 |  |
| 8 | Sub.sample | toolshed.g2.bx.psu.edu/repos/iuc/mothur_sub_sample/mothur_sub_sample/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | group_out | group_out |
| 3 | phylip_out | phylip_out |
| 3 | count_out | count_out |
| 3 | column_out | column_out |
| 4 | otulist | otulist |
| 4 | rabund | rabund |
| 4 | sensspec | sensspec |
| 4 | sabund | sabund |
| 5 | shared | shared |
| 5 | groupout | groupout |
| 6 | taxonomies | taxonomies |
| 6 | taxsummaries | taxsummaries |
| 7 | summary | summary |
| 7 | grp_count | grp_count |
| 8 | shared_out | shared_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow5-otu-clustering.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow5-otu-clustering.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow5-otu-clustering.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow5-otu-clustering.ga -o job.yml`
- Lint: `planemo workflow_lint workflow5-otu-clustering.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow5-otu-clustering.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)