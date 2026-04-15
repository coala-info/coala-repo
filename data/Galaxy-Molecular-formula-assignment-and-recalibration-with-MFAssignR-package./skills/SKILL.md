---
name: molecular-formula-assignment-and-recalibration-with-mfassign
description: This workflow processes feature tables from ultrahigh-resolution mass spectrometry using the MFAssignR package to perform noise estimation, mass recalibration, and multi-element molecular formula assignment. Use this skill when you need to accurately identify chemical compositions in complex metabolomics samples by correcting mass measurement errors and filtering out noise based on Kendrick mass defects.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# molecular-formula-assignment-and-recalibration-with-mfassign

## Overview

This workflow utilizes the [MFAssignR](https://github.com/psu-mcl/MFAssignR) package to assign multi-element molecular formulas to ultrahigh-resolution mass spectrometry data. Starting from a feature table, the process begins with noise estimation and filtering using Kendrick Mass Defect (KMD) and histogram-based methods (`KMDNoise`, `HistNoise`). It also includes isotopic filtering (`IsoFiltR`) and signal-to-noise visualization (`SNplot`) to ensure high data quality before the assignment phase.

A central feature of this workflow is the integrated recalibration process. It initially assigns CHO-only formulas to establish a baseline, then identifies recalibration series (`RecalList`, `FindRecalSeries`) to correct mass errors across the spectrum. After applying the recalibration (`Recal`), the workflow performs a comprehensive multi-element formula assignment (`MFAssign`), categorizing results into unambiguous and ambiguous assignments.

The workflow generates several diagnostic outputs, including SNplots, MZplots, and detailed tables of assigned formulas. It is particularly suited for metabolomics and complex mixture analysis where high mass accuracy is critical. This toolset is licensed under the [MIT license](https://opensource.org/licenses/MIT) and is tagged for [Metabolomics](https://training.galaxyproject.org/training-material/topics/metabolomics/) and formula assignment tasks within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Feature table | data_input | Input dataframe. First column should be "mass", second "intensity"; third column is optional, can contain retention time. |


Ensure your input feature table is in a supported tabular format such as CSV or TSV, containing essential columns for m/z values and peak intensities. For high-throughput analysis of multiple mass spectra, organize your inputs into a dataset collection to facilitate batch processing through the MFAssignR tool suite. Consult the `README.md` for detailed requirements regarding specific column naming conventions and noise estimation parameters. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MFAssignR KMDNoise | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_kmdnoise/mfassignr_kmdnoise/1.1.1+galaxy0 |  |
| 2 | MFAssignR HistNoise | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_histnoise/mfassignr_histnoise/1.1.1+galaxy0 |  |
| 3 | MFAssignR SNplot | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_snplot/mfassignr_snplot/1.1.1+galaxy0 |  |
| 4 | MFAssignR IsoFiltR | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_isofiltr/mfassignr_isofiltr/1.1.1+galaxy0 |  |
| 5 | MFAssignR MFAssignCHO | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_mfassigncho/mfassignr_mfassignCHO/1.1.1+galaxy0 |  |
| 6 | MFAssignR RecalList | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_recallist/mfassignr_recallist/1.1.1+galaxy0 |  |
| 7 | MFAssignR FindRecalSeries | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_findrecalseries/mfassignr_findRecalSeries/1.1.2+galaxy1 |  |
| 8 | MFAssignR Recal | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_recal/mfassignr_recal/1.1.1+galaxy0 |  |
| 9 | MFAssignR MFAssign | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_mfassign/mfassignr_mfassign/1.1.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | SNplot | SNplot |
| 5 | plots | plots |
| 6 | recal_series | recal_series |
| 7 | final_series | final_series |
| 8 | MZplot | MZplot |
| 9 | None | None |
| 9 | Ambig | Ambig |
| 9 | Unambig | Unambig |
| 9 | plots | plots |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)