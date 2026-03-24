---
name: dia_lib_osw
description: "This proteomics workflow processes DDA data, FASTA sequences, and experimental design files using MaxQuant and OpenMS tools to generate a spectral library for DIA analysis. Use this skill when you need to build a high-quality, decoy-enhanced assay library from DDA experiments to enable targeted peptide quantification in subsequent DIA-MS workflows."
homepage: https://workflowhub.eu/workflows/1421
---

# DIA_lib_OSW

## Overview

This workflow is designed for proteomics research, specifically for generating Data-Independent Acquisition (DIA) spectral libraries using training data from HEK and E. coli samples. It follows methodologies established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) to transform Data-Dependent Acquisition (DDA) data and FASTA sequences into high-quality targeted assay libraries.

The pipeline begins by processing DDA data collections and protein sequences through [MaxQuant](https://toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.10.43+galaxy3), producing comprehensive outputs including evidence, peptides, and protein groups. These results undergo rigorous filtering to ensure that only high-confidence identifications are used for the subsequent library construction phases.

In the final stages, the workflow utilizes [diapysef](https://toolshed.g2.bx.psu.edu/repos/galaxyp/diapysef/diapysef/0.3.5.0) for library generation, followed by a suite of OpenMS tools. [OpenSwathAssayGenerator](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_openswathassaygenerator/OpenSwathAssayGenerator/2.5+galaxy0) and [OpenSwathDecoyGenerator](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_openswathdecoygenerator/OpenSwathDecoyGenerator/2.5+galaxy0) create the necessary targeted assays and decoys, which are then formatted for downstream DIA analysis using the TargetedFileConverter.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | HEK_Ecoli_exp_design.txt | data_input |  |
| 1 | iRTassays.tsv | data_input |  |
| 2 | FASTA collection | data_collection_input |  |
| 3 | DDA_data collection | data_collection_input |  |


Ensure your DDA mass spectrometry data and FASTA sequences are organized into Galaxy collections to facilitate batch processing, while the experimental design and iRT assay files should be uploaded as individual tabular datasets. Verify that the experimental design file follows the specific formatting required by MaxQuant and OpenSwath to ensure proper metadata mapping across the workflow. For comprehensive instructions on parameter configuration and data preparation, refer to the detailed README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined input management and automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | MaxQuant | toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/1.6.10.43+galaxy3 |  |
| 5 | Filter | Filter1 |  |
| 6 | Filter | Filter1 |  |
| 7 | diapysef library generation | toolshed.g2.bx.psu.edu/repos/galaxyp/diapysef/diapysef/0.3.5.0 |  |
| 8 | OpenSwathAssayGenerator | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_openswathassaygenerator/OpenSwathAssayGenerator/2.5+galaxy0 |  |
| 9 | OpenSwathDecoyGenerator | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_openswathdecoygenerator/OpenSwathDecoyGenerator/2.5+galaxy0 |  |
| 10 | TargetedFileConverter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_targetedfileconverter/TargetedFileConverter/2.5+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | proteinGroups | proteinGroups |
| 4 | msms | msms |
| 4 | evidence | evidence |
| 4 | peptides | peptides |
| 4 | mqpar | mqpar |
| 4 | ptxqc_report | ptxqc_report |
| 5 | out_file1 | out_file1 |
| 6 | out_file1 | out_file1 |
| 7 | output_pdf | output_pdf |
| 7 | output_tabular | output_tabular |
| 8 | out | out |
| 9 | out | out |
| 10 | out | out |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-dia-lib-training-hek-ecoli-3-eg-data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-dia-lib-training-hek-ecoli-3-eg-data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-dia-lib-training-hek-ecoli-3-eg-data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-dia-lib-training-hek-ecoli-3-eg-data.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-dia-lib-training-hek-ecoli-3-eg-data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-dia-lib-training-hek-ecoli-3-eg-data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
