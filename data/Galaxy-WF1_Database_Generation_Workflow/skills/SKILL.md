---
name: wf1_database_generation_workflow
description: This Galaxy workflow processes Human SwissProt, species-specific FASTA files, and MGF mass spectrometry data using FASTA Merge and MetaNovo to generate a compact, sample-specific protein database. Use this skill when you need to reduce the search space for metaproteomic analysis by filtering large protein databases down to the sequences most likely present in your specific clinical or biological samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# wf1_database_generation_workflow

## Overview

This Galaxy workflow is designed to generate and refine protein databases for metaproteomics analysis. It streamlines the process of taking large, comprehensive sequence collections and reducing them into a compact, high-confidence database tailored to specific experimental data. The workflow is tagged under [clinicalmp](https://training.galaxyproject.org/) and follows [GTN](https://training.galaxyproject.org/) standards for reproducible bioinformatics.

The process begins by merging several input sources, including the HUMAN SwissProt database, species-specific UniProt FASTA files, and a contaminants (cRAP) protein database. These sequences are filtered for uniqueness before being processed alongside mass spectrometry data (MGF files) using [MetaNovo](https://toolshed.g2.bx.psu.edu/repos/galaxyp/metanovo/metanovo/1.9.4+galaxy4). MetaNovo performs a targeted reduction to ensure the final database is optimized for the specific microbial and human proteins present in the sample.

The primary outputs include a refined FASTA file and a corresponding CSV report. The final consolidated database contains a combination of Human UniProt sequences, microbial proteins identified by MetaNovo, and common contaminants, providing a streamlined resource for subsequent protein identification steps. This workflow is released under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HUMAN SwissProt Protein Database | data_input |  |
| 1 | Input MGF files (Dataset Collection) | data_collection_input |  |
| 2 | Species_UniProt_FASTA | data_input |  |
| 3 | Contaminants (cRAP) Protein Database | data_input |  |


Ensure all protein databases are provided in FASTA format, while mass spectrometry data must be uploaded as an MGF dataset collection to facilitate batch processing through MetaNovo. It is essential to verify that reference datasets like SwissProt and cRAP are correctly assigned as individual inputs to the merging tools to ensure sequence uniqueness. For comprehensive instructions on parameter settings and metadata requirements, refer to the `README.md` file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution and input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 5 | MetaNovo | toolshed.g2.bx.psu.edu/repos/galaxyp/metanovo/metanovo/1.9.4+galaxy4 |  |
| 6 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Human UniProt Microbial Proteins cRAP for MetaNovo | output |
| 5 | output_fasta | output_fasta |
| 5 | output_csv | output_csv |
| 6 | Human UniProt Microbial Proteins (from MetaNovo) and cRAP  | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf1-database-generation-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf1-database-generation-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf1-database-generation-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf1-database-generation-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint wf1-database-generation-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf1-database-generation-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)