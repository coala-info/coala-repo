---
name: workflow-3-classification-galaxy-training-16s-microbial-anal
description: This microbiome workflow classifies cleaned 16S rRNA sequences and count tables against a reference training set using Mothur tools to assign taxonomy and filter unwanted lineages. Use this skill when you need to taxonomically identify microbial species in environmental samples and refine your dataset by removing non-target sequences such as mitochondria or chloroplasts.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# workflow-3-classification-galaxy-training-16s-microbial-anal

## Overview

This workflow represents the third stage of the 16S microbial analysis pipeline using the mothur toolset, as detailed in the [Galaxy Training Network](https://training.galaxyproject.org/) (GTN) curriculum. It is designed to assign taxonomic identities to cleaned sequences by comparing them against a provided reference training set (FASTA and Taxonomy files).

The process begins with the `Classify.seqs` tool, which performs the primary taxonomic assignment. Following classification, the workflow utilizes `Remove.lineage` to filter the dataset. This step is critical for removing sequences belonging to unwanted lineages—such as chloroplasts, mitochondria, or eukaryotes—that may have been amplified during the sequencing process but are not the focus of the bacterial microbiome analysis.

The final stage uses `Summary.seqs` to generate detailed statistical reports on the processed sequences. Key outputs include refined taxonomy files, updated count tables, and summary logs that provide a clear overview of the classification results and the remaining sequence diversity. This workflow is released under an MIT license and is a core component of standardized microbiome bioinformatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Cleaned Sequences | data_input |  |
| 1 | Count Table | data_input |  |
| 2 | Training set FASTA | data_input |  |
| 3 | Training set Taxonomy | data_input |  |


Ensure your input sequences are in FASTA format and paired with a valid mothur count table to maintain sample abundance data throughout the classification process. While individual datasets work for single runs, using a dataset collection for the cleaned sequences and count tables is recommended for scaling this workflow efficiently across multiple samples. Verify that the training set FASTA and taxonomy files are compatible and correctly formatted for the mothur tools to avoid alignment errors. Refer to the README.md for comprehensive details on parameter settings and specific reference database versions. You can use planemo workflow_job_init to generate a job.yml for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Classify.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_classify_seqs/mothur_classify_seqs/1.39.5.0 |  |
| 5 | Remove.lineage | toolshed.g2.bx.psu.edu/repos/iuc/mothur_remove_lineage/mothur_remove_lineage/1.39.5.0 |  |
| 6 | Summary.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_summary_seqs/mothur_summary_seqs/1.39.5.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | taxonomy_out | taxonomy_out |
| 4 | tree_sum | tree_sum |
| 4 | tax_summary | tax_summary |
| 5 | taxonomy_out | taxonomy_out |
| 5 | fasta_out | fasta_out |
| 5 | count_out | count_out |
| 6 | logfile | logfile |
| 6 | out_summary | out_summary |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow3-classification.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow3-classification.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow3-classification.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow3-classification.ga -o job.yml`
- Lint: `planemo workflow_lint workflow3-classification.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow3-classification.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)