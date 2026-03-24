---
name: clinical-metaproteomics-quantitation
description: "This Galaxy workflow performs quantitative metaproteomics by processing raw mass spectrometry data and protein databases using MaxQuant to measure protein and peptide abundance. Use this skill when you need to identify biomarkers, conduct differential expression studies, or analyze the functional roles of microbial proteins within complex clinical samples."
homepage: https://workflowhub.eu/workflows/1177
---

# Clinical Metaproteomics Quantitation

## Overview

This workflow performs quantitative analysis of clinical metaproteomics data using [MaxQuant](https://training.galaxyproject.org/training-material/topics/proteomics/tutorials/clinical-mp-4-quantitation/tutorial.html). It is designed to measure and compare protein and peptide levels across biological samples, facilitating biomarker discovery and differential expression studies. By integrating raw MS/MS datasets with specific experimental designs and protein databases, the process ensures accurate data normalization and validation of protein identifications.

The pipeline processes raw data collections through MaxQuant to generate initial quantitative metrics based on user-defined parameters such as peptide length and variable modifications. Subsequent steps utilize `Select`, `Cut`, and `Group` tools to extract specific microbial proteins and peptides while consolidating duplicate entries. The final outputs provide comprehensive lists of quantified proteins and peptides, which are essential for downstream hypothesis testing and systems biology applications in clinical research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Quantitation_Database-For-MaxQuant | data_input | Input protein database |
| 1 | Experimental-Design Discovery MaxQuant | data_input | design file |
| 2 | Input Raw-files | data_collection_input | MSMS data |


For this workflow, ensure your raw mass spectrometry data is organized into a dataset collection, while the protein database must be in FASTA format and the experimental design in a tabular file. Verify that the experimental design file correctly maps your raw files to their respective groups to ensure accurate MaxQuant processing. For comprehensive configuration details and parameter settings, refer to the provided README.md file. You can streamline the setup of your execution environment by using `planemo workflow_job_init` to generate a `job.yml` file. These inputs are essential for the subsequent extraction and grouping of microbial proteins and peptides.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | MaxQuant | toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/2.0.3.0+galaxy0 | Database searching |
| 4 | Select | Grep1 | extracting microbial Proteins |
| 5 | Select | Grep1 | extracting microbial Peptides |
| 6 | Cut | Cut1 | extract proteins |
| 7 | Cut | Cut1 | extract peptides |
| 8 | Group | Grouping1 | Quantified-Proteins |
| 9 | Group | Grouping1 | Quantified-Peptides |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | Quantified-Proteins | out_file1 |
| 9 | Quantified-Peptides | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run iwc-clinicalmp-quantitation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run iwc-clinicalmp-quantitation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run iwc-clinicalmp-quantitation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init iwc-clinicalmp-quantitation.ga -o job.yml`
- Lint: `planemo workflow_lint iwc-clinicalmp-quantitation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `iwc-clinicalmp-quantitation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
