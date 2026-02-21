---
name: pdbfixer
description: PDBFixer is a specialized tool for structural biology that automates the "cleaning" process required before a protein structure can be used in a simulation.
homepage: https://github.com/openmm/pdbfixer
---

# pdbfixer

## Overview
PDBFixer is a specialized tool for structural biology that automates the "cleaning" process required before a protein structure can be used in a simulation. Raw PDB files often contain gaps in the sequence, missing side-chain atoms, or non-standard chemical entities that force fields cannot recognize. This skill provides the procedural knowledge to use PDBFixer's command-line interface to resolve these issues, ensuring structural integrity and compatibility with simulation engines like OpenMM.

## Command Line Usage
PDBFixer can be used in both interactive and automated modes.

### Basic Repair Workflow
To fix a structure using default settings (adding missing atoms and replacing non-standard residues):
`pdbfixer input.pdb --output=fixed.pdb`

### Common CLI Flags
- `--add-atoms=[all|heavy|hydrogen|none]`: Specify which missing atoms to add. Adding 'all' is standard for MD preparation.
- `--replace-nonstandard`: Automatically converts non-standard residues (e.g., MSE to MET) to their standard equivalents.
- `--keep-heterogens=[all|none|water]`: Controls which non-protein/non-nucleic acid molecules are kept. Use `none` to strip everything but the protein.
- `--ph=[value]`: When adding hydrogens, specify the pH to determine the protonation state of residues (default is 7.0).
- `--add-solvent`: Adds a water box around the protein. Use with `--boxx`, `--boxy`, `--boxz` to define dimensions.

## Expert Tips & Best Practices
- **Loop Building**: PDBFixer can attempt to build missing loops if the PDB header contains the `SEQRES` records. If loops are very long, the resulting coordinates may be unphysical and require extensive equilibration.
- **Hydrogen Optimization**: Use the hydrogen optimization functionality (triggered during atom addition) to ensure the hydrogen network is energetically favorable.
- **Chain Selection**: If a PDB contains multiple models or unwanted chains (like a crystal contact), use `--keep-chains` to specify only the relevant biological assembly.
- **Non-standard Residues**: Always verify the conversion of non-standard residues. While PDBFixer handles common ones like Selenomethionine, rare modifications might require manual inspection.
- **Cysteine Bridges**: PDBFixer generally handles disulfide bonds based on distance; ensure your input file has correct `SSBOND` records if the automatic detection fails.
- **Interactive Mode**: If you run `pdbfixer` without an output file specified, it enters an interactive mode that guides you through each step (selecting chains, deleting heterogens, etc.), which is useful for complex structures.

## Reference documentation
- [PDBFixer Main Repository](./references/github_com_openmm_pdbfixer.md)
- [PDBFixer Development History](./references/github_com_openmm_pdbfixer_commits_master.md)