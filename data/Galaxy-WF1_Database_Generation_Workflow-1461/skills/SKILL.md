---
name: wf1_database_generation_workflow
description: "This proteomics workflow integrates Human SwissProt, species-specific UniProt, and contaminant databases with MGF mass spectrometry files using FASTA Merge and MetaNovo to generate a refined protein sequence database. Use this skill when you need to reduce a large, redundant protein database into a compact, sample-specific search space to improve the sensitivity and accuracy of peptide identification in complex clinical or microbial samples."
homepage: https://workflowhub.eu/workflows/1461
---

# WF1_Database_Generation_Workflow

## Overview

This Galaxy workflow is designed to generate a streamlined protein database for metaproteomics analysis by reducing a large initial sequence collection into a compact, relevant subset. It integrates multiple protein sources, including the HUMAN SwissProt database, species-specific UniProt FASTA files, and a contaminants (cRAP) database, alongside experimental mass spectrometry data provided as MGF files.

The process begins by merging and filtering the input FASTA files to create a comprehensive starting database of unique sequences. This large database is then processed through [MetaNovo](https://toolshed.g2.bx.psu.edu/repos/galaxyp/metanovo/metanovo/1.9.4+galaxy4), which utilizes the experimental MGF data to identify and retain only the most probable protein sequences, significantly reducing the search space for downstream proteomics searches.

The final outputs include a refined FASTA file containing human, microbial, and contaminant proteins, as well as detailed CSV reports of the identified sequences. This workflow is tagged for use in [clinicalmp](https://github.com/galaxyproteomics) and [GTN](https://training.galaxyproject.org/) contexts and is provided under a [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HUMAN SwissProt Protein Database | data_input |  |
| 1 | Input MGF files (Dataset Collection) | data_collection_input |  |
| 2 | Species_UniProt_FASTA | data_input |  |
| 3 | Contaminants (cRAP) Protein Database | data_input |  |


Ensure all protein databases are provided in FASTA format and the mass spectrometry spectra are uploaded as an MGF Dataset Collection to facilitate batch processing by MetaNovo. Verify that the species-specific, human, and contaminant databases are correctly mapped to their respective input slots to ensure accurate sequence merging and filtering. For comprehensive configuration details and parameter settings, refer to the included README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for streamlined execution and reproducibility.

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
