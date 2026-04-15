---
name: generate-a-clinical-metaproteomics-database
description: This Galaxy workflow integrates human, microbial, and contaminant protein databases with tandem mass spectrometry data using MetaNovo to generate a refined, compact FASTA database. Use this skill when you need to characterize the metaproteome of clinical samples where abundant host proteins might otherwise obscure the detection of disease-causing microorganisms.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# generate-a-clinical-metaproteomics-database

## Overview

This Galaxy workflow facilitates the generation of a specialized protein database for clinical metaproteomics. Analyzing clinical samples is often challenging due to the high abundance of host (human) proteins which can mask microbial signals. This workflow addresses this by integrating human, microbial, and contaminant protein sequences to create a comprehensive search space for tandem mass spectrometry (MS/MS) data analysis.

The process begins by merging protein sequences from the Human SwissProt database, specific microbial species from UniProt, and common contaminants (cRAP). These sequences are combined with MS/MS datasets and processed through the [MetaNovo](https://toolshed.g2.bx.psu.edu/repos/galaxyp/metanovo/metanovo/1.9.4+galaxy4) tool. MetaNovo performs a targeted search to refine the initial large database into a compact, relevant dataset containing only the proteins most likely to be present in the clinical sample.

The final outputs include a compact FASTA database and a corresponding CSV file, optimized for downstream metaproteomic identification. This workflow is part of a larger clinical metaproteomics suite, and detailed training materials are available via the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/training-material/topics/proteomics/tutorials/clinical-mp-1-database-generation/tutorial.html).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Human SwissProt Protein Database | data_input | Human SwissProt Protein Database |
| 1 | Tandem Mass Spectrometry (MS/MS) datasets | data_collection_input | Tandem Mass Spectrometry (MS/MS) datasets |
| 2 | Species UniProt Protein Database | data_input | Species UniProt Protein Database |
| 3 | Contaminants cRAP Protein Database | data_input | Contaminants cRAP Protein Database |


Ensure all protein databases are provided in FASTA format and your tandem mass spectrometry (MS/MS) data is uploaded as MGF files. The MS/MS files must be organized into a dataset collection to be processed correctly by the MetaNovo tool, while the protein databases are handled as individual datasets. Refer to the README.md for specific configuration values regarding peptide length and variable modifications required for the MetaNovo step. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 | Merging FASTA files |
| 5 | MetaNovo | toolshed.g2.bx.psu.edu/repos/galaxyp/metanovo/metanovo/1.9.4+galaxy4 | Generating Customized Database |
| 6 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 | Merge all FASTA |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | Human UniProt Microbial Proteins cRAP for MetaNovo | output |
| 5 | Metanovo Compact database | output_fasta |
| 5 | Metanovo Compact CSV database | output_csv |
| 6 | Human UniProt Microbial Proteins from MetaNovo cRAP | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run iwc-clinicalmp-database-generation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run iwc-clinicalmp-database-generation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run iwc-clinicalmp-database-generation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init iwc-clinicalmp-database-generation.ga -o job.yml`
- Lint: `planemo workflow_lint iwc-clinicalmp-database-generation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `iwc-clinicalmp-database-generation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)