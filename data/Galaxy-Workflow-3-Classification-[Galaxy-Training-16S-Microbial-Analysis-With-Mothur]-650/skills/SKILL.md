---
name: workflow-3-gucfg2galaxy-classification-galaxy-training-16s-m
description: "This metagenomics workflow processes cleaned 16S sequences and count tables using Mothur tools to assign taxonomic classifications against a reference training set and filter out unwanted lineages. Use this skill when you need to taxonomically classify microbial sequences and refine your dataset by removing specific lineages to focus on relevant bacterial populations."
homepage: https://workflowhub.eu/workflows/650
---

# Workflow 3 [gucfg2galaxy]: Classification [Galaxy Training: 16S Microbial Analysis With Mothur]

## Overview

This workflow represents the third stage of a 16S microbial analysis pipeline, following the methodology outlined in the [Galaxy Training Network](https://training.galaxyproject.org/) tutorial for Mothur. Its primary purpose is to assign taxonomic identities to 16S rRNA gene sequences and refine the dataset by removing non-target lineages.

The process begins with the `Classify.seqs` tool, which compares cleaned sequences against a provided reference training set (FASTA and Taxonomy) to determine their microbial classification. Subsequently, the `Remove.lineage` tool is used to filter the results, allowing researchers to exclude sequences identified as chloroplasts, mitochondria, eukaryotes, or other undesirable taxa that may interfere with bacterial community analysis.

The workflow requires four inputs: cleaned sequences, a corresponding count table, and the reference training files. It generates several key outputs, including a comprehensive taxonomic summary, a classification tree, and filtered FASTA and count files that are optimized for downstream OTU clustering and diversity assessments.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Cleaned Sequences | data_input |  |
| 1 | Count Table | data_input |  |
| 2 | Training set FASTA | data_input |  |
| 3 | Training set Taxonomy | data_input |  |


Ensure all input sequences and training sets are in FASTA format, while the count table must strictly follow the mothur-specific tabular format to maintain sample-to-sequence mapping. For high-throughput analysis, organizing your cleaned sequences into dataset collections is highly recommended to streamline the classification of multiple samples simultaneously. Please consult the README.md for comprehensive details on selecting compatible reference taxonomy versions and specific parameter settings for the classification tools. You may also use `planemo workflow_job_init` to create a `job.yml` for structured execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Classify.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_classify_seqs/mothur_classify_seqs/1.39.5.0 |  |
| 5 | Remove.lineage | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_lineage/mothur_remove_lineage/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | taxonomy_out | taxonomy_out |
| 4 | tree_sum | tree_sum |
| 4 | tax_summary | tax_summary |
| 5 | taxonomy_out | taxonomy_out |
| 5 | fasta_out | fasta_out |
| 5 | count_out | count_out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Workflow_3_[gucfg2galaxy]__Classification_[Galaxy_Training__16S_Microbial_Analysis_With_Mothur].ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Workflow_3_[gucfg2galaxy]__Classification_[Galaxy_Training__16S_Microbial_Analysis_With_Mothur].ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Workflow_3_[gucfg2galaxy]__Classification_[Galaxy_Training__16S_Microbial_Analysis_With_Mothur].ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Workflow_3_[gucfg2galaxy]__Classification_[Galaxy_Training__16S_Microbial_Analysis_With_Mothur].ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Workflow_3_[gucfg2galaxy]__Classification_[Galaxy_Training__16S_Microbial_Analysis_With_Mothur].ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Workflow_3_[gucfg2galaxy]__Classification_[Galaxy_Training__16S_Microbial_Analysis_With_Mothur].ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
