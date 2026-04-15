---
name: workflow-to-reproduce-paper-8-exafs-fitting
description: This workflow performs EXAFS fitting for palladium-based catalyst samples using Athena project files and Pd/PdO crystal structures processed through Larch Athena, Feff, and Artemis tools. Use this skill when you need to characterize the local coordination environment and oxidation states of palladium catalysts within gasoline particulate filters to reproduce specific experimental findings.
homepage: https://eurosciencegateway.eu/
metadata:
  docker_image: "N/A"
---

# workflow-to-reproduce-paper-8-exafs-fitting

## Overview

This Galaxy workflow reproduces the EXAFS (Extended X-ray Absorption Fine Structure) fitting analysis described in "paper 8," focusing on the characterization of catalysts within gasoline particulate filters. The process utilizes experimental Athena project files for washcoat and 20g ash samples, along with Pd and PdO crystallographic information (CIF) files to serve as structural references.

The pipeline leverages the [XrayLarch](https://xraypy.github.io/xraylarch/) analysis suite to handle spectroscopic data. It begins by processing the input Athena projects and performing FEFF calculations on the provided CIF files to generate theoretical scattering paths. These paths are essential for modeling the local atomic environment of the palladium species.

In the final stages, the workflow uses the `larch_select_paths` and `larch_artemis` tools to perform multi-shell fitting. By refining the theoretical models against the experimental data, the workflow extracts quantitative structural parameters, ensuring the reproducibility of the results presented in the original study.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Washcoat Athena project file from paper | data_input |  |
| 1 | 20g ash Athena project file from paper | data_input |  |
| 2 | PdO cif file | data_input |  |
| 3 | Pd cif file | data_input |  |


Ensure all input Athena project files and CIF crystal structures are uploaded as individual datasets rather than collections to match the workflow's expected ports. You should verify that the CIF files for Pd and PdO are correctly formatted to allow Larch FEFF to generate the necessary scattering paths for EXAFS fitting. For automated execution and parameter mapping, consider using `planemo workflow_job_init` to generate a `job.yml` file. Detailed configuration settings for the Larch Artemis fitting steps can be found in the accompanying README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.75+galaxy2 |  |
| 5 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_athena/larch_athena/0.9.80+galaxy1 |  |
| 6 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.75+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.75+galaxy0 |  |
| 7 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.75+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_feff/larch_feff/0.9.75+galaxy0 |  |
| 8 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_select_paths/larch_select_paths/0.9.80+galaxy0 |  |
| 9 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 |  |
| 10 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/larch_artemis/larch_artemis/0.9.80+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 0a07785dca20180d.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 0a07785dca20180d.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 0a07785dca20180d.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 0a07785dca20180d.ga -o job.yml`
- Lint: `planemo workflow_lint 0a07785dca20180d.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `0a07785dca20180d.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)