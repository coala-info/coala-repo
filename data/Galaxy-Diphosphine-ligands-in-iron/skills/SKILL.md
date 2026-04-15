---
name: paper_2_diphosphine-wf
description: This workflow processes X-ray absorption spectroscopy data for iron-diphosphine complexes using Larch Athena for data reduction and Larch Plot for visualization. Use this skill when you need to characterize the local atomic structure and oxidation states of iron-based catalysts or complexes containing diphosphine ligands through XAS analysis.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# paper_2_diphosphine-wf

## Overview

This Galaxy workflow is designed for the automated processing and analysis of X-ray absorption spectroscopy (XAS) data, specifically focusing on iron complexes featuring diphosphine ligands. It streamlines the handling of multiple experimental data collections (labeled A through D and 7a) alongside standard reference materials such as Fe Metal and FeBr.

The pipeline leverages the [Larch](https://xraypy.github.io/xraylarch/) software suite, specifically the `larch_athena` tool, to perform essential data reduction tasks. These steps typically include energy calibration, normalization, and background subtraction, ensuring that the raw spectral data is prepared for high-quality spectroscopic analysis.

Following the data processing phase, the workflow utilizes `larch_plot` to generate visualizations of the resulting spectra. This allows researchers to compare the electronic structures and coordination environments of the various iron-diphosphine complexes, facilitating the interpretation of experimental results as described in the associated research paper.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | A data | data_collection_input |  |
| 1 | B data | data_collection_input |  |
| 2 | C data | data_collection_input |  |
| 3 | D data | data_collection_input |  |
| 4 | Fe Metal | data_collection_input |  |
| 5 | FeBr | data_collection_input |  |
| 6 | 7a | data_collection_input |  |


Ensure all spectral data files are organized into data collections before execution, as the workflow specifically requires collection inputs for each experimental group. Input files should typically be in formats compatible with Larch Athena, such as raw XAS data or pre-processed text files. Refer to the README.md for specific details on the expected column formats and normalization parameters required for the Athena steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated configuration of these multiple collection inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 8 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 9 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 10 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 11 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 12 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 13 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 14 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 15 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 16 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |
| 17 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_plot/larch_plot/0.9.80+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 1967248db44ca916.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 1967248db44ca916.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 1967248db44ca916.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 1967248db44ca916.ga -o job.yml`
- Lint: `planemo workflow_lint 1967248db44ca916.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `1967248db44ca916.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)