---
name: create-gro-and-top-complex-files
description: This Galaxy workflow parameterizes a protein-ligand complex from PDB and SDF inputs using GROMACS, AnteChamber, and ACPYPE to generate compatible topology and structure files. Use this skill when you need to prepare a biological system for molecular dynamics simulations by generating unified topology and coordinate files for a protein bound to a small molecule ligand.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# create-gro-and-top-complex-files

## Overview

This workflow automates the parameterization of protein-ligand complexes for molecular dynamics simulations using GROMACS. It serves as a foundational subworkflow for more advanced MD pipelines, such as MMGBSA and dcTMD, by preparing the necessary structural and topology files from raw input data.

The pipeline processes an apoprotein PDB and a ligand SDF file based on user-defined parameters including pH, water model, and force field. It utilizes [OpenBabel](https://toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0) for compound conversion and [AmberTools](https://toolshed.g2.bx.psu.edu/repos/chemteam/ambertools_acpype/ambertools_acpype/21.10+galaxy0) (AnteChamber and acpype) to generate small molecule topologies compatible with GROMACS.

The final stage merges the individual protein and ligand components into a unified system. The primary outputs include the complex structure file (.gro), the system topology (.top), and a position restraints file, providing all the essential components required for subsequent equilibration and production MD runs. This workflow is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | pH | parameter_input | pH for protonating the ligand. Set to -1.0 to skip. |
| 1 | Ligand SDF | data_input | SD-file for the input ligand |
| 2 | Apoprotein PDB | data_input | PDB file for the protein (without ligand, cofactor, waters) |
| 3 | Water model | parameter_input | Model for water molecules (relevant for subsequent solvation) |
| 4 | Force field | parameter_input | Force field for protein modelling. GAFF is used for the ligand. |


Ensure your input protein is in PDB format and the ligand is provided as an SDF file, as these are essential for correct parameterization via AnteChamber and GROMACS setup. Verify that the pH and force field parameters match your experimental design to ensure consistent topology generation. For automated execution, you can use `planemo workflow_job_init` to generate a `job.yml` template for these inputs. Refer to the `README.md` for comprehensive details on file preparation and specific water model requirements. Use individual datasets for the protein and ligand to maintain clear mapping during the topology merging step.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Compound conversion | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_compound_convert/openbabel_compound_convert/3.1.1+galaxy0 |  |
| 6 | Descriptors | toolshed.g2.bx.psu.edu/repos/bgruening/ctb_rdkit_descriptors/ctb_rdkit_descriptors/2020.03.4+galaxy1 |  |
| 7 | GROMACS initial setup | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_setup/gmx_setup/2021.3+galaxy0 |  |
| 8 | Search in textfiles | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_grep_tool/1.1.1 |  |
| 9 | Cut | Cut1 |  |
| 10 | Parse parameter value | param_value_from_file |  |
| 11 | AnteChamber | toolshed.g2.bx.psu.edu/repos/chemteam/ambertools_antechamber/ambertools_antechamber/21.10+galaxy0 |  |
| 12 | Generate MD topologies for small molecules | toolshed.g2.bx.psu.edu/repos/chemteam/ambertools_acpype/ambertools_acpype/21.10+galaxy0 |  |
| 13 | Merge GROMACS topologies | toolshed.g2.bx.psu.edu/repos/chemteam/gmx_merge_topology_files/gmx_merge_topology_files/3.4.3+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | Position restraints file | output3 |
| 13 | Complex topology | complex_top |
| 13 | Complex GRO | complex_gro |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run protein-ligand-complex-parameterization.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run protein-ligand-complex-parameterization.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run protein-ligand-complex-parameterization.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init protein-ligand-complex-parameterization.ga -o job.yml`
- Lint: `planemo workflow_lint protein-ligand-complex-parameterization.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `protein-ligand-complex-parameterization.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)