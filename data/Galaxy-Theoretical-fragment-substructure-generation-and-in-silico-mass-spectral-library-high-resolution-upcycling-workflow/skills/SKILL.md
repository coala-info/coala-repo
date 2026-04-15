---
name: msfinder-workflow-golm-imported-from-uploaded-file
description: This metabolomics workflow processes spectral library files using MSMetaEnhancer, matchms, and RECETOX MsFinder to perform metadata enrichment and in silico fragment annotation. Use this skill when you need to upcycle mass spectral libraries or generate theoretical fragment substructures to improve the accuracy of metabolite identification.
homepage: https://www.recetox.muni.cz/en/services/data-services-2/spectrometric-data-processing-and-analysis
metadata:
  docker_image: "N/A"
---

# msfinder-workflow-golm-imported-from-uploaded-file

## Overview

This Galaxy workflow is designed for the high-resolution "upcycling" of mass spectral libraries, specifically optimized for processing data such as the GOLM metabolome database. It begins by taking a spectral library file and performing extensive metadata enrichment using [MSMetaEnhancer](https://github.com/RECETOX/MSMetaEnhancer) to ensure chemical identifiers like SMILES and InChIKeys are complete and standardized.

The middle stage of the pipeline focuses on rigorous data cleaning and curation. It utilizes a suite of [matchms](https://github.com/matchms/matchms) tools for metadata filtering, key management, and subsetting. Additionally, the workflow includes specialized steps to remove coordination complexes and perform text-based replacements to ensure the structural data is consistent and ready for in silico fragmentation.

In the final stage, the processed data is passed to [RECETOX MsFinder](https://github.com/RECETOX/recetox-msfinder) for theoretical fragment and substructure generation. The workflow concludes by applying theoretical m/z values to the annotations, resulting in a high-quality, upcycled spectral library. The primary outputs include the converted library, the MsFinder analysis results, and the final annotated data with theoretical mass values.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Spectral library file | data_input |  |


Ensure the input spectral library is provided in a standard format such as MSP or MGF to ensure compatibility with the MSMetaEnhancer and matchms processing steps. While individual files are standard, you may use Galaxy dataset collections to batch process multiple spectral libraries through the pipeline. Please consult the `README.md` for exhaustive documentation on metadata field requirements and specific tool configurations. For automated execution, you can use `planemo workflow_job_init` to create a `job.yml` file for managing workflow parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MSMetaEnhancer | toolshed.g2.bx.psu.edu/repos/recetox/msmetaenhancer/msmetaenhancer/0.4.0+galaxy1 |  |
| 2 | MSMetaEnhancer | toolshed.g2.bx.psu.edu/repos/recetox/msmetaenhancer/msmetaenhancer/0.4.0+galaxy1 |  |
| 3 | MSMetaEnhancer | toolshed.g2.bx.psu.edu/repos/recetox/msmetaenhancer/msmetaenhancer/0.4.0+galaxy1 |  |
| 4 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 5 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 6 | matchms filtering | toolshed.g2.bx.psu.edu/repos/recetox/matchms_filtering/matchms_filtering/0.24.0+galaxy2 |  |
| 7 | matchms metadata export | toolshed.g2.bx.psu.edu/repos/recetox/matchms_metadata_export/matchms_metadata_export/0.24.0+galaxy1 |  |
| 8 | Convert CSV to tabular | csv_to_tabular |  |
| 9 | Remove columns | toolshed.g2.bx.psu.edu/repos/iuc/column_remove_by_header/column_remove_by_header/1.0 |  |
| 10 | Convert tabular to CSV | tabular_to_csv |  |
| 11 | Remove coordination complexes | toolshed.g2.bx.psu.edu/repos/recetox/rem_complex/rem_complex/1.0.0+galaxy2 |  |
| 12 | matchms subsetting | toolshed.g2.bx.psu.edu/repos/recetox/matchms_subsetting/matchms_subsetting/0.24.0+galaxy5 |  |
| 13 | matchms remove key | toolshed.g2.bx.psu.edu/repos/recetox/matchms_remove_key/matchms_remove_key/0.24.0+galaxy0 |  |
| 14 | matchms remove key | toolshed.g2.bx.psu.edu/repos/recetox/matchms_remove_key/matchms_remove_key/0.24.0+galaxy0 |  |
| 15 | matchms remove key | toolshed.g2.bx.psu.edu/repos/recetox/matchms_remove_key/matchms_remove_key/0.25.0+galaxy0 |  |
| 16 | matchms add key | toolshed.g2.bx.psu.edu/repos/recetox/matchms_add_key/matchms_add_key/0.24.0+galaxy1 |  |
| 17 | matchms add key | toolshed.g2.bx.psu.edu/repos/recetox/matchms_add_key/matchms_add_key/0.24.0+galaxy1 |  |
| 18 | matchms filtering | toolshed.g2.bx.psu.edu/repos/recetox/matchms_filtering/matchms_filtering/0.25.0+galaxy1 |  |
| 19 | matchms convert | toolshed.g2.bx.psu.edu/repos/recetox/matchms_convert/matchms_convert/0.24.0+galaxy0 |  |
| 20 | RECETOX MsFinder | toolshed.g2.bx.psu.edu/repos/recetox/recetox_msfinder/recetox_msfinder/v3.5.2+galaxy4 |  |
| 21 | use theoretical m/z values | toolshed.g2.bx.psu.edu/repos/recetox/use_theoretical_mz_annotations/use_theoretical_mz_annotations/1.0.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 19 | converted_library | converted_library |
| 20 | output | output |
| 21 | output_data | output_data |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy_Workflow_MsFinder_Workflow_GOLM_V2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy_Workflow_MsFinder_Workflow_GOLM_V2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy_Workflow_MsFinder_Workflow_GOLM_V2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy_Workflow_MsFinder_Workflow_GOLM_V2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy_Workflow_MsFinder_Workflow_GOLM_V2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy_Workflow_MsFinder_Workflow_GOLM_V2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)