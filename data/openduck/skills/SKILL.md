---
name: openduck
description: Openduck performs Dynamic Undocking simulations using Steered Molecular Dynamics to calculate the work required to break specific protein-ligand interactions. Use when user asks to evaluate binding mode stability, filter docking poses based on undocking work, or perform steered molecular dynamics to test interaction strength.
homepage: https://github.com/galaxycomputationalchemistry/duck
metadata:
  docker_image: "quay.io/biocontainers/openduck:0.1.2--py_0"
---

# openduck

## Overview

The `openduck` tool is an open-source library designed for Dynamic Undocking (DUck) simulations. Unlike traditional docking which provides a static score, DUck uses Steered Molecular Dynamics (SMD) to calculate the work necessary to break a specific protein-ligand interaction (typically a key hydrogen bond). This allows researchers to evaluate the stability of a binding mode by simulating the physical process of undocking. The tool is primarily used to filter docking poses or to identify which ligands have the highest resistance to being pulled out of a pocket.

## Installation and Environment

The most reliable way to use `openduck` is via Conda or Docker to ensure all dependencies (OpenMM, RDKit, etc.) are correctly configured.

### Conda Setup
Install the package from the Bioconda channel:
```bash
conda install bioconda::openduck
```

### Docker Execution
For environments where GPU drivers are pre-configured in containers:
```bash
docker pull abradle/duck
docker run -it -v $PWD:/data abradle/duck /bin/bash -c "frag_duck /data/run.yaml"
```

## Command Line Usage

The primary entry point for the tool is the `frag_duck` command. It requires a configuration file (typically in YAML format, though the tool parses the parameters internally) to define the simulation parameters.

### Basic Execution
```bash
frag_duck <configuration_file>
```

### Configuration Parameters
When preparing the input for `frag_duck`, ensure the following parameters are defined:

*   **prot_code**: The PDB ID or identifier for the protein.
*   **prot_int**: The specific protein interaction point (e.g., 'A_ASP_156_OD2'). This defines the "anchor" for the undocking simulation.
*   **lig_id**: The residue name or ID of the ligand in the input file.
*   **mol_file**: The path to the ligand file (e.g., .mol or .sdf).
*   **apo_pdb_file**: The path to the protein structure file in PDB format.
*   **gpu_id**: The index of the GPU to be used for the OpenMM simulation.
*   **num_smd_cycles**: The number of Steered Molecular Dynamics pulls to perform (higher numbers increase statistical significance).
*   **md_len**: The length of the equilibration or MD phase in nanoseconds.
*   **distance**: The distance (in Angstroms) the ligand will be pulled during the SMD phase.

## Expert Tips and Best Practices

*   **Interaction Selection**: The `prot_int` parameter is critical. DUck is designed to test the strength of a specific interaction. If the ligand does not form a stable hydrogen bond with the specified atom, the undocking work values will be low and potentially uninformative.
*   **GPU Acceleration**: `openduck` relies on OpenMM. Ensure that `cudatoolkit` is correctly installed and matches your driver version to avoid "Platform not found" errors.
*   **Equilibration**: For complex systems, ensure `md_len` is sufficient to relax the system before the pulling phase begins.
*   **Analysis**: Use the `collect_analysis.py` script (found in the source repository) to aggregate results from multiple SMD cycles to calculate the Work (W) values and identify the "Work to reach 1.0A" metric, which is a standard benchmark in DUck.

## Reference documentation
- [openduck - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_openduck_overview.md)
- [GitHub - galaxycomputationalchemistry/duck](./references/github_com_galaxycomputationalchemistry_duck.md)