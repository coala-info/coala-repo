---
name: atel-follow-up-photometric-data-legacy-survey-photo-z
description: This Galaxy workflow processes astronomical telegram text and IDs using tools like analyse-short-astro-text, DESI Legacy Survey, and PhotoZ_Euclid to extract photometric data and calculate redshifts. Use this skill when you need to automatically retrieve photometric information from the DESI Legacy Survey and estimate photometric redshifts for astronomical sources identified in short text reports or telegrams.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# atel-follow-up-photometric-data-legacy-survey-photo-z

## Overview

This workflow automates the follow-up analysis of astronomical events reported via The Astronomer's Telegram (ATel). By taking a Text ID and raw text as input, the pipeline extracts relevant astrophysical metadata to facilitate rapid characterization of transient or variable sources.

The process begins with the [analyse-short-astro-text](https://toolshed.g2.bx.psu.edu/repos/astroteam/analyse_short_astro_text_astro_tool) tool, which parses telegram content for key information. The workflow then utilizes a series of text-processing steps—including file splitting, tail selection, and advanced cutting—to isolate specific coordinates or identifiers. These values are converted into parameters used to query external databases.

In the final stages, the pipeline integrates with the [DESI Legacy Survey](https://toolshed.g2.bx.psu.edu/repos/astroteam/desi_legacy_survey_astro_tool) to retrieve photometric data for the identified targets. This data is then processed through the PhotoZ_Euclid tool to calculate photometric redshifts (Photo-z), providing essential distance estimates for the astronomical objects under study.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Text ID | parameter_input |  |
| 1 | Text | parameter_input |  |


To prepare your data, ensure the Text ID and Text inputs are provided as simple text parameters or single-line text files containing the relevant astronomical telegram identifiers and content. While this workflow primarily processes string inputs, any supplementary tabular data should be in CSV or FITS format to remain compatible with the conversion and parsing steps. If you are processing multiple telegrams, consider organizing them into a dataset collection to streamline the splitting and cutting operations. For automated testing and execution, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the `README.md` for comprehensive details on parameter specifications and tool-specific requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | analyse-short-astro-text | toolshed.g2.bx.psu.edu/repos/astroteam/analyse_short_astro_text_astro_tool/analyse_short_astro_text_astro_tool/0.0.1+galaxy0 |  |
| 3 | astropy fits2csv | toolshed.g2.bx.psu.edu/repos/astroteam/astropy_fits2csv/astropy_fits2csv/0.1.0+galaxy0 |  |
| 4 | Split file | toolshed.g2.bx.psu.edu/repos/bgruening/split_file_to_collection/split_file_to_collection/0.5.2 |  |
| 5 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/9.3+galaxy1 |  |
| 6 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 |  |
| 7 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 |  |
| 8 | Advanced Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/9.3+galaxy2 |  |
| 9 | Parse parameter value | param_value_from_file |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | Parse parameter value | param_value_from_file |  |
| 12 | DESI Legacy Survey | toolshed.g2.bx.psu.edu/repos/astroteam/desi_legacy_survey_astro_tool/desi_legacy_survey_astro_tool/0.0.1+galaxy0 |  |
| 13 | PhotoZ_Euclid (PR 157) | photoz_euclid_astro_tool_pr157 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ATel_Follow-up_Photometric_data_Legacy_Survey_Photo-z.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)