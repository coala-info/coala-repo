---
name: workflow-4-mock-otu-clustering-galaxy-training-16s-microbial
description: "This microbiome workflow processes mock sequences and count tables using mothur tools to perform distance calculation, OTU clustering, and rarefaction analysis. Use this skill when you need to evaluate the accuracy of your 16S rRNA gene sequencing pipeline by analyzing a control sample with a known microbial composition."
homepage: https://workflowhub.eu/workflows/1408
---

# Workflow 4: Mock OTU Clustering [Galaxy Training: 16S Microbial Analysis With Mothur]

## Overview

This workflow is the fourth component of the [16S Microbial Analysis with mothur](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/mothur-16s/tutorial.html) suite from the Galaxy Training Network (GTN). It is specifically designed to perform Operational Taxonomic Unit (OTU) clustering on mock community data, providing a standardized method for assessing sequencing quality and error rates by comparing observed results against known community compositions.

The process begins by calculating a distance matrix from mock sequences using the `mothur_dist_seqs` tool. These distances are then processed by `mothur_cluster` to group sequences into OTUs based on genetic similarity. This clustering step is essential for reducing the complexity of the microbiome data into discrete units for ecological and statistical analysis.

In the final stages, the workflow utilizes `mothur_make_shared` to generate a shared file, which acts as an OTU abundance table across samples. It also produces rarefaction curves via `mothur_rarefaction_single`, allowing researchers to evaluate whether the sequencing depth is sufficient to capture the full diversity of the mock community.

This workflow is released under an MIT license and is tagged for Microbiome analysis within the Galaxy ecosystem. It requires a Mock Count Table and Mock Sequences as primary inputs to generate its distance matrices, abundance files, and rarefaction data.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Mock Count Table | data_input |  |
| 1 | Mock Sequences | data_input |  |


Ensure your input files are in the correct mothur-compatible formats, specifically a count table and a FASTA sequence file representing your mock community. While these are typically processed as individual datasets, verify that the sequence IDs in both files match exactly to prevent errors during the distance calculation and clustering stages. Refer to the accompanying README.md for comprehensive details on data preparation and specific parameter requirements for each tool step. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and testing of the workflow.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Dist.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_dist_seqs/mothur_dist_seqs/1.39.5.0 |  |
| 3 | Cluster | toolshed.g2.bx.psu.edu/repos/iuc/mothur_cluster/mothur_cluster/1.39.5.0 |  |
| 4 | Make.shared | toolshed.g2.bx.psu.edu/repos/iuc/mothur_make_shared/mothur_make_shared/1.39.5.0 |  |
| 5 | Rarefaction.single | toolshed.g2.bx.psu.edu/repos/iuc/mothur_rarefaction_single/mothur_rarefaction_single/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | out_dist | out_dist |
| 3 | rabund | rabund |
| 3 | otulist | otulist |
| 3 | sabund | sabund |
| 4 | shared | shared |
| 5 | rarefactioncurves | rarefactioncurves |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow4-mock-otu-clustering.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow4-mock-otu-clustering.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow4-mock-otu-clustering.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow4-mock-otu-clustering.ga -o job.yml`
- Lint: `planemo workflow_lint workflow4-mock-otu-clustering.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow4-mock-otu-clustering.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
