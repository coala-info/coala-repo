---
name: finding-the-muon-stopping-site-pymuon-suite-in-galaxy
description: This Galaxy workflow identifies muon stopping sites in crystalline materials using CASTEP cell and density files processed through the PyMuonSuite AIRSS UEP optimization and clustering tools. Use this skill when you need to determine the most probable equilibrium positions of implanted muons within a host material to accurately interpret experimental muon spin resonance data.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# finding-the-muon-stopping-site-pymuon-suite-in-galaxy

## Overview

This workflow identifies potential muon stopping sites within a crystal structure using the [pymuon-suite](https://github.com/muon-spectroscopy-computational-project/pymuon-suite) toolset integrated into Galaxy. It implements the Ab Initio Random Structure Searching (AIRSS) method, specifically utilizing the Unperturbed Electrostatic Potential (UEP) approach to predict where muons will reside in a host material based on its electronic charge density.

The process requires three primary inputs: a structural `.cell` file, a density format file (`.den_fmt`), and a CASTEP output file. The **PyMuonSuite AIRSS UEP Optimise** tool first performs an optimization of muon positions by searching for minima in the electrostatic potential of the unperturbed host system. This allows for a computationally efficient estimation of stopping sites without the need for full DFT relaxation of every candidate position.

In the final stage, the **PyMuonSuite AIRSS Cluster** tool groups the resulting positions into symmetry-equivalent sets. This clustering identifies the unique, physically distinct stopping sites within the material. The workflow concludes by outputting a detailed mapping of all identified muon sites, providing essential data for interpreting Muon Spin Resonance (µSR) experiments. This resource is part of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is licensed under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Copper-out.cell | data_input | CASTEP structural file for the relaxed host material |
| 1 | Copper.den_fmt | data_input | CASTEP charge density file |
| 2 | Copper.castep | data_input | main CASTEP output file |


Ensure you have the `.cell`, `.den_fmt`, and `.castep` files from your CASTEP calculations uploaded as individual datasets to your Galaxy history. While this workflow processes these as discrete inputs, maintaining them in a dedicated history ensures the structural and electronic density data remain synchronized. Consult the `README.md` for comprehensive details on parameter settings and the underlying AIRSS UEP optimization logic. For automated execution or testing, consider using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | PyMuonSuite AIRSS UEP Optimise | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/pm_uep_opt/pm_uep_opt/0.3.0+galaxy1 | Galaxy tool used to: load the CASTEP files; complete the Generation parameters to set up the creation of randomly populated muonated structures; and complete the Optimisation parameters to set up the relaxation the electrostatic forces of the muon in each of the randomly populated muonated structures. |
| 4 | PyMuonSuite AIRSS Cluster | toolshed.g2.bx.psu.edu/repos/muon-spectroscopy-computational-project/pm_muairss_read/pm_muairss_read/0.3.0+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | All muons in host material | allpos_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run muairss-uep.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run muairss-uep.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run muairss-uep.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init muairss-uep.ga -o job.yml`
- Lint: `planemo workflow_lint muairss-uep.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `muairss-uep.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)