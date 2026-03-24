---
name: workflow-constructed-from-history-hsp90-mdanalysis
description: "This computational chemistry workflow processes GROMACS structure and trajectory files using Bio3D, MDAnalysis, and VMD to perform comprehensive molecular dynamics analysis. Use this skill when you need to evaluate protein stability, structural fluctuations, and principal component motions from molecular dynamics simulations."
homepage: https://workflowhub.eu/workflows/1689
---

# Workflow constructed from history 'Hsp90-MDAnalysis'

## Overview

This Galaxy workflow is designed for the high-throughput analysis of molecular dynamics (MD) simulations, specifically optimized for studying the Hsp90 protein. It processes standard GROMACS output files, requiring a structure file (.gro) and a trajectory file (.xtc) as primary inputs to perform a comprehensive evaluation of protein stability and conformational changes.

The pipeline utilizes a suite of specialized tools to characterize protein dynamics. It performs Root Mean Square Deviation (RMSD) and Root Mean Square Fluctuation (RMSF) calculations using [Bio3D](https://toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsd/bio3d_rmsd/2.3.4) to assess structural stability and residue-level flexibility. Additionally, the workflow includes Principal Component Analysis (PCA) to identify dominant motions within the trajectory, complemented by PCA visualization and cosine content analysis to evaluate the quality of the simulation sampling.

Beyond basic structural metrics, the workflow integrates [VMD](https://toolshed.g2.bx.psu.edu/repos/chemteam/vmd_hbonds/vmd_hbonds/1.9.3) for detailed hydrogen bond analysis and [MDTraj](https://toolshed.g2.bx.psu.edu/repos/chemteam/md_converter/md_converter/1.9.3.2) for necessary file conversions. These steps allow researchers to gain deeper insights into the chemical interactions and conformational transitions occurring during the simulation, making it a robust resource for [computational chemistry](https://training.galaxyproject.org/training-material/topics/computational-chemistry/) research and Galaxy Training Network (GTN) tutorials.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Galaxy30-[GROMACS_simulation_on_data_28,_data_15,_and_data_26].gro | data_input |  |
| 1 | Galaxy31-[GROMACS_simulation_on_data_28,_data_15,_and_data_26].xtc | data_input |  |


Ensure your input files are correctly formatted as GROMACS structure (.gro) and trajectory (.xtc) files to maintain compatibility with the MDTraj and Bio3D analysis components. While this workflow accepts individual datasets, organizing multiple simulation runs into collections can significantly improve efficiency when scaling your analysis across the various tool steps. Please consult the `README.md` for exhaustive details on specific tool parameters and data requirements. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined execution and input management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | GROMACS structure configuration | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_editconf/gmx_editconf/2019.1.4 |  |
| 3 | MDTraj file converter | toolshed.g2.bx.psu.edu/repos/chemteam/md_converter/md_converter/1.9.3.2 |  |
| 4 | RMSD Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsd/bio3d_rmsd/2.3.4 |  |
| 5 | RMSF Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsf/bio3d_rmsf/2.3.4 |  |
| 6 | PCA | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_pca/bio3d_pca/2.3.4 |  |
| 7 | Cosine Content | toolshed.g2.bx.psu.edu/repos/chemteam/mdanalysis_cosine_analysis/mdanalysis_cosine_analysis/0.20 |  |
| 8 | PCA visualization | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_pca_visualize/bio3d_pca_visualize/2.3.4 |  |
| 9 | Hydrogen Bond Analysis using VMD | toolshed.g2.bx.psu.edu/repos/chemteam/vmd_hbonds/vmd_hbonds/1.9.3 |  |
| 10 | RMSD Analysis | toolshed.g2.bx.psu.edu/repos/chemteam/bio3d_rmsd/bio3d_rmsd/2.3.4 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run analysis-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run analysis-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run analysis-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init analysis-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint analysis-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `analysis-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
