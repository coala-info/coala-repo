---
name: molecular-formula-assignment-and-recalibration-with-mfassign
description: "This metabolomics workflow processes mass spectrometry feature tables using the MFAssignR package to perform noise estimation, mass recalibration, and multi-element molecular formula assignment. Use this skill when you need to improve mass accuracy through recalibration and identify unambiguous molecular formulas in ultrahigh-resolution mass spectra of complex chemical mixtures."
homepage: https://workflowhub.eu/workflows/1351
---

# Molecular formula assignment and recalibration with MFAssignR package.

## Overview

This workflow facilitates the processing of ultrahigh-resolution mass spectrometry data using the [MFAssignR](https://github.com/recetox/MFAssignR) package. It is designed to perform noise estimation, isotopic filtering, and multi-element molecular formula assignment. By integrating recalibration steps, the workflow improves mass accuracy, ensuring more reliable chemical characterization of complex metabolomics samples.

The process begins with noise estimation and signal-to-noise analysis using KMD (Kendrick Mass Defect) and histogram-based methods. After filtering isotopes, the workflow performs an initial assignment of CHO formulas to establish a recalibration series. This series is used to correct mass-to-charge ratios across the spectrum before a final, comprehensive molecular formula assignment is conducted.

The workflow generates several key outputs, including tabular files for ambiguous and unambiguous formula assignments and recalibrated data series. It also produces diagnostic visualizations such as signal-to-noise plots, mass-to-charge error plots, and Van Krevelen diagrams to assist in data quality assessment and chemical interpretation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Feature table | data_input | Input dataframe. First column should be "mass", second "intensity"; third column is optional, can contain retention time. |


Ensure your input feature table is in a tabular format (e.g., .txt or .tsv) containing high-resolution mass spectrometry data with precise mass-to-charge ratios. For large-scale studies, organize your feature tables into a dataset collection to streamline batch processing through the noise estimation and recalibration steps. Refer to the `README.md` for specific column requirements and detailed parameter configurations for CHO and multi-element assignments. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible metadata handling.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MFAssignR KMDNoise | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_kmdnoise/mfassignr_kmdnoise/1.1.2+galaxy0 |  |
| 2 | MFAssignR HistNoise | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_histnoise/mfassignr_histnoise/1.1.2+galaxy0 |  |
| 3 | MFAssignR SNplot | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_snplot/mfassignr_snplot/1.1.2+galaxy1 |  |
| 4 | MFAssignR IsoFiltR | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_isofiltr/mfassignr_isofiltr/1.1.2+galaxy1 |  |
| 5 | MFAssignR MFAssignCHO | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_mfassigncho/mfassignr_mfassignCHO/1.1.2+galaxy1 |  |
| 6 | MFAssignR RecalList | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_recallist/mfassignr_recallist/1.1.2+galaxy0 |  |
| 7 | MFAssignR FindRecalSeries | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_findrecalseries/mfassignr_findRecalSeries/1.1.2+galaxy1 |  |
| 8 | MFAssignR Recal | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_recal/mfassignr_recal/1.1.2+galaxy0 |  |
| 9 | MFAssignR MFAssign | toolshed.g2.bx.psu.edu/repos/recetox/mfassignr_mfassign/mfassignr_mfassign/1.1.2+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | SNplot | SNplot |
| 5 | plots (CHO) | plots |
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
planemo run mfassignr.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run mfassignr.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run mfassignr.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init mfassignr.ga -o job.yml`
- Lint: `planemo workflow_lint mfassignr.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `mfassignr.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
