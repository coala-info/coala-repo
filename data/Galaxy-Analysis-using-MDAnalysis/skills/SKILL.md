---
name: analysis-using-mdanalysis
description: This computational chemistry workflow processes DCD and PDB trajectory files using MDAnalysis tools to generate radial distribution functions, cosine content, Ramachandran plots, and various distance or dihedral time series. Use this skill when you need to characterize protein backbone stability, analyze atomic spatial distributions, or evaluate the convergence and conformational sampling of molecular dynamics simulations.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# analysis-using-mdanalysis

## Overview

This workflow facilitates the post-processing and analysis of Molecular Dynamics (MD) trajectories using the [MDAnalysis](https://www.mdanalysis.org/) library within the Galaxy framework. It is designed to take a trajectory file (DCD) and a corresponding topology file (PDB) as inputs to perform a suite of standard structural and dynamical evaluations.

The pipeline executes several key analyses, including the calculation of Radial Distribution Functions (RDF) to study atomic distributions and the evaluation of Cosine Content to assess the quality of conformational sampling. It also generates Ramachandran plots to visualize protein backbone dihedral angles, providing insights into the structural stability and secondary structure of the protein.

Additionally, the workflow monitors specific atomic distances and dihedral angles over the course of the simulation. Each tool step produces both graphical plots for immediate visualization and raw data files for further downstream processing. This resource is tagged for [Computational-chemistry](https://galaxyproject.org/use/computational-chemistry/) and follows [GTN](https://training.galaxyproject.org/) training standards under an MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | DCD input | data_input | DCD input |
| 1 | PDB input | data_input | PDB input |


Ensure your trajectory is in DCD format and your topology is a PDB file, as these are the primary inputs required for the MDAnalysis tools. While individual datasets work for single runs, consider using collections if you are processing multiple trajectories simultaneously to streamline the analysis. Refer to the README.md for comprehensive details on parameter settings and specific atom selection syntax. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing or execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | RDF Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/mdanalysis_rdf/mdanalysis_rdf/0.19 |  |
| 3 | Cosine Content | toolshed.g2.bx.psu.edu/repos/chemteam/mdanalysis_cosine_analysis/mdanalysis_cosine_analysis/0.19 |  |
| 4 | Ramachandran Plots | toolshed.g2.bx.psu.edu/repos/chemteam/mdanalysis_ramachandran_plot/mdanalysis_ramachandran_plot/0.1.3 |  |
| 5 | Distance Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/mdanalysis_distance/mdanalysis_distance/0.19 |  |
| 6 | Dihedral Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/mdanalysis_dihedral/mdanalysis_dihedral/0.19 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | RDF Analysis plot | rdf_plot |
| 2 | RDF Analysis raw data | output |
| 3 | Cosine Content raw data | output |
| 3 | Cosine Content plot | cosout |
| 4 | Ramachandran Plot | ramachandran_plot |
| 4 | Ramachandran Plot raw data | output |
| 5 | Distance Analysis raw data | output |
| 5 | Distance Analysis plot | distance_plot |
| 6 | Dihedral Analysis plot | dihedral_plot |
| 6 | Dihedral Analysis raw data | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run advanced-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run advanced-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run advanced-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init advanced-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint advanced-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `advanced-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)