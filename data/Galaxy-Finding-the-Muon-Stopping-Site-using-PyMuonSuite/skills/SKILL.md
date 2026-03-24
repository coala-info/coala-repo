---
name: finding-the-muon-stopping-site-pymuon-suite-in-galaxy
description: "This Galaxy workflow identifies muon stopping sites in crystalline materials using CASTEP structure and density files processed through PyMuonSuite AIRSS UEP optimization and clustering tools. Use this skill when you need to determine the most probable implantation sites of muons within a solid-state system to accurately interpret experimental muon spectroscopy measurements."
homepage: https://workflowhub.eu/workflows/757
---

# Finding the Muon Stopping Site: pymuon-suite in Galaxy

## Overview

This workflow facilitates the identification of muon stopping sites within a host material using the [pymuon-suite](https://github.com/muon-spectroscopy-computational-project/pymuon-suite) toolset integrated into Galaxy. It utilizes Ab Initio Random Structure Searching (AIRSS) combined with Unperturbed Electrostatic Potential (UEP) methods to predict the most probable locations for muons in a crystal lattice, a critical step in interpreting muon spin resonance ($\mu$SR) experiments.

The pipeline processes structural and electronic density data, specifically requiring `.cell`, `.den_fmt`, and `.castep` files as primary inputs. The first stage employs the **PyMuonSuite AIRSS UEP Optimise** tool to perform potential energy surface calculations and identify candidate sites. These results are then processed by the **PyMuonSuite AIRSS Cluster** tool, which groups the candidates into symmetry-equivalent sets to determine the final stopping positions.

The final output provides a detailed mapping of all identified muon sites within the host material. This automated workflow streamlines the complex computational task of site determination, ensuring reproducibility and ease of use for researchers in the field of computational muon spectroscopy. The project is distributed under the [MIT license](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Copper-out.cell | data_input | CASTEP structural file for the relaxed host material |
| 1 | Copper.den_fmt | data_input | CASTEP charge density file |
| 2 | Copper.castep | data_input | main CASTEP output file |


Ensure you have the `.cell`, `.den_fmt`, and `.castep` files ready, as these provide the structural and electronic density data required for the AIRSS UEP optimization. These inputs should be uploaded as individual datasets rather than collections to ensure the workflow correctly maps the specific geometry and density files to the optimization tool. For comprehensive instructions on preparing these CASTEP-specific files and configuring the optimization parameters, refer to the `README.md`. You can automate the setup of these inputs for testing by using `planemo workflow_job_init` to generate a `job.yml` file.

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
planemo run Finding the muon stopping site with pymuon-suite in Galaxy.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Finding the muon stopping site with pymuon-suite in Galaxy.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Finding the muon stopping site with pymuon-suite in Galaxy.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Finding the muon stopping site with pymuon-suite in Galaxy.ga -o job.yml`
- Lint: `planemo workflow_lint Finding the muon stopping site with pymuon-suite in Galaxy.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Finding the muon stopping site with pymuon-suite in Galaxy.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
