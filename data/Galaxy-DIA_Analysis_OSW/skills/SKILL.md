---
name: dia_analysis_osw
description: This proteomics workflow processes mass spectrometry data collections using msconvert, OpenSwathWorkflow, and the PyProphet suite to perform Data-Independent Acquisition (DIA) analysis guided by spectral libraries and experimental design annotations. Use this skill when you need to identify and quantify peptides and proteins from complex biological mixtures while maintaining rigorous false discovery rate control at both the peptide and protein levels.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# dia_analysis_osw

## Overview

This workflow provides a comprehensive pipeline for analyzing Data-Independent Acquisition (DIA) proteomics data, specifically optimized for training scenarios using HEK and E. coli datasets. It automates the transition from raw mass spectrometry data to statistically validated peptide and protein quantifications by integrating the OpenMS and PyProphet ecosystems within Galaxy.

The process begins with [msconvert](https://toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.19052.1) for data preparation, followed by [OpenSwathWorkflow](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_openswathworkflow/OpenSwathWorkflow/2.5+galaxy0), which utilizes a spectral library and iRT assays to extract ion chromatograms. The workflow then employs a rigorous statistical validation sequence using [PyProphet](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_score/pyprophet_score/2.1.4.2) to merge results, calculate scores, and perform False Discovery Rate (FDR) estimation at both the peptide and protein levels.

Final outputs include detailed scoring reports, visualization plots, and exported data files formatted for downstream differential expression analysis. This pipeline is a key resource for [GTN](https://training.galaxyproject.org/) proteomics training, ensuring a reproducible and standardized approach to DIA data processing.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input exp. design annotation | data_input |  |
| 1 | iRTassays.tsv | data_input |  |
| 2 | Spectral library | data_input |  |
| 3 | "Input Dataset Collection" | data_collection_input |  |


Ensure your raw mass spectrometry files are grouped into a dataset collection to facilitate batch processing through OpenSwathWorkflow, while the experimental design, iRT assays, and spectral library should be uploaded as individual TSV or PQP datasets. Verify that your spectral library matches the format required by OpenMS tools and that the experimental design file correctly maps to your collection's element identifiers. For automated job configuration and testing, you can use `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on parameter settings and specific data requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | msconvert | toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.19052.1 |  |
| 5 | OpenSwathWorkflow | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_openswathworkflow/OpenSwathWorkflow/2.5+galaxy0 |  |
| 6 | PyProphet merge | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_merge/pyprophet_merge/2.1.4.0 |  |
| 7 | PyProphet score | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_score/pyprophet_score/2.1.4.2 |  |
| 8 | PyProphet peptide | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_peptide/pyprophet_peptide/2.1.4.0 |  |
| 9 | PyProphet peptide | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_peptide/pyprophet_peptide/2.1.4.0 |  |
| 10 | PyProphet protein | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_protein/pyprophet_protein/2.1.4.0 |  |
| 11 | PyProphet protein | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_protein/pyprophet_protein/2.1.4.0 |  |
| 12 | PyProphet export | toolshed.g2.bx.psu.edu/repos/galaxyp/pyprophet_export/pyprophet_export/2.1.4.1 |  |
| 13 | Select | Grep1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | output | output |
| 5 | out_osw | out_osw |
| 5 | ctd_out | ctd_out |
| 6 | output | output |
| 7 | score_report | score_report |
| 7 | output | output |
| 8 | output | output |
| 8 | peptide_plots | peptide_plots |
| 9 | output | output |
| 9 | peptide_plots | peptide_plots |
| 10 | output | output |
| 10 | protein_plots | protein_plots |
| 11 | protein_plots | protein_plots |
| 11 | output | output |
| 12 | msstats_input | msstats_input |
| 12 | summary | summary |
| 12 | export_file | export_file |
| 12 | peptide_signal | peptide_signal |
| 12 | protein_signal | protein_signal |
| 13 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow--dia-training-using-hek-ecoli-3-eg-data-.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow--dia-training-using-hek-ecoli-3-eg-data-.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow--dia-training-using-hek-ecoli-3-eg-data-.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow--dia-training-using-hek-ecoli-3-eg-data-.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow--dia-training-using-hek-ecoli-3-eg-data-.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow--dia-training-using-hek-ecoli-3-eg-data-.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)