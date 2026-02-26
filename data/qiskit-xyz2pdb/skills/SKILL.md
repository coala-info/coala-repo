---
name: qiskit-xyz2pdb
description: This tool converts XYZ coordinate outputs from quantum protein folding simulations into the standard Protein Data Bank (PDB) format. Use when user asks to transform simulation results for visualization, convert alpha carbon coordinates to PDB files, or prepare quantum folding data for structural biology workflows.
homepage: https://github.com/thepineapplepirate/qiskit-xyz2pdb
---


# qiskit-xyz2pdb

## Overview
The `qiskit-xyz2pdb` tool is a specialized utility designed to transform raw XYZ coordinate outputs from quantum protein folding simulations into the standard Protein Data Bank (PDB) format. Since Qiskit's protein folding results typically represent the positions of alpha carbons ($\text{C}_\alpha$), this tool provides the necessary formatting to make those results compatible with traditional bioinformatics software. It offers two distinct output modes: one optimized for immediate connectivity visualization and another for downstream structural research.

## Installation
The tool can be installed via PyPI or Conda:
```bash
pip install qiskit-xyz2pdb
# OR
conda install bioconda::qiskit-xyz2pdb
```

## Command Line Usage

### 1. Visualization Mode (Hetero Atom Format)
Use this mode for quick visual inspection of the protein chain. It uses the `HETATM` format and generates `CONECT` records to explicitly define the bonds between consecutive residues.
*   **Best for:** NGL viewer, PyMOL, or other tools where you want to see a continuous line representing the backbone immediately.
*   **Assumption:** Assumes a single continuous chain with no side chains.

```bash
qiskit-xyz2pdb --in-xyz input.xyz --out-pdb output.pdb --hetero-atoms
```

### 2. Research Mode (Alpha Carbon Trace)
Use this mode for structural biology workflows. It produces a conventional PDB format where each coordinate is treated as an alpha carbon ($\text{C}_\alpha$) in the protein sequence.
*   **Best for:** Reconstructing full backbones/sidechains, adding force fields, or performing molecular dynamics (MD) simulations.

```bash
qiskit-xyz2pdb --in-xyz input.xyz --out-pdb output.pdb --alpha-c-traces
```

## Expert Tips and Best Practices
*   **Coordinate Mapping:** Remember that in both output modes, every set of coordinates in your input XYZ file is mapped to the alpha carbon of a residue. Ensure your XYZ file does not contain non-protein atoms or side-chain atoms unless they are intended to be treated as $\text{C}_\alpha$ positions.
*   **Visualization Constraints:** When using `--hetero-atoms`, the tool assumes the XYZ coordinates are ordered consecutively. If your simulation output is not ordered by sequence, the `CONECT` records will create a "tangled" visualization.
*   **Downstream Processing:** If you intend to use the output for MD simulations, choose `--alpha-c-traces`. You will likely need to follow this step with a tool like Modeller or Pulchra to reconstruct the full-atom backbone and side chains from the $\text{C}_\alpha$ trace.

## Reference documentation
- [qiskit-xyz2pdb GitHub Repository](./references/github_com_thepineapplepirate_qiskit-xyz2pdb.md)
- [qiskit-xyz2pdb Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_qiskit-xyz2pdb_overview.md)