---
name: voronota
description: Voronota analyzes biological macromolecular structures using Voronoi diagrams to define atomic contacts and surfaces. Use when user asks to calculate interatomic contacts, assess protein model quality, compare structures using CAD-score, detect pockets and cavities, or analyze membrane protein orientations.
homepage: https://www.voronota.com/
---

# voronota

## Overview

Voronota is a specialized toolset for the comprehensive analysis of biological macromolecules through the Voronoi diagram of balls. It treats atoms as spheres with van der Waals radii to define atomic neighborhoods and contact surfaces. This skill provides guidance on using the core `voronota` executable and its specialized wrapper scripts for model quality assessment (VoroMQA), contact area difference scoring (CAD-score), and structural feature identification (pockets, membranes).

## Core CLI Usage

The `voronota` suite consists of a main engine and several high-level wrapper scripts.

### Calculating Contacts and Surfaces
Use the `voronota-contacts` script for a simplified workflow to get interatomic contacts.

```bash
# Calculate all contacts for a PDB file
voronota-contacts < input.pdb > contacts.txt

# Calculate contacts and include solvent-accessible surface area (SASA)
voronota-contacts --include-sas < input.pdb > contacts_with_sas.txt
```

### Model Quality Assessment (VoroMQA)
VoroMQA evaluates the quality of protein structures based on the atom-atom contact probabilities.

```bash
# Get global and local (per-residue) quality scores
voronota-js-voromqa --input model.pdb --output-prefix evaluation_results
```

### Structural Comparison (CAD-score)
CAD-score is used to compare a model structure against a reference structure based on contact area differences.

```bash
# Compare a model to a target reference
voronota-cadscore --target reference.pdb --model model.pdb
```

### Pocket and Cavity Detection
Identify internal voids, channels, and pockets using tessellation vertices.

```bash
# Identify pockets and output them as a PDB file of dummy atoms
voronota-pocket --input protein.pdb --output-pockets pockets.pdb
```

### Membrane Protein Analysis
Fit a protein into a membrane based on surface frustration analysis.

```bash
# Find the optimal membrane orientation
voronota-membrane --input membrane_protein.pdb --output-atoms atoms_in_membrane.pdb
```

## Expert Tips and Best Practices

- **Parallel Processing**: When using the core `voronota` command for large-scale vertex calculations, use the `calculate-vertices-in-parallel` command if the binary was compiled with OpenMP support.
- **Expansion Selection**:
    - Use **Voronota-LT** (Lite) for massive speed increases when only contact areas and SASA are needed, especially for large complexes.
    - Use **Voronota-JS** for complex workflows requiring custom logic or the latest VoroMQA/VoroIF-GNN scoring methods.
- **Input Preparation**: Ensure PDB files are clean. While Voronota is robust, removing non-standard ligands or water molecules (unless specifically analyzing them) can clarify the contact map.
- **Piping**: The core `voronota` tool is designed for Unix-style piping. You can chain `get-balls-from-atoms-file` into `calculate-vertices` and then into `calculate-contacts` for fine-grained control over the tessellation parameters.



## Subcommands

| Command | Description |
|---------|-------------|
| voronota_calculate-contacts | Calculates contacts between balls. |
| voronota_calculate-vertices | Calculates Voronoi vertices from a list of balls. |
| voronota_calculate-vertices-in-parallel | Calculates Voronoi vertices in parallel. |
| voronota_compare-contacts | Compares contacts from two Voronota models. |
| voronota_draw-contacts | Draws contacts in various formats. |
| voronota_expand-descriptors | Expand atom descriptors to 'chainID resSeq iCode serial altLoc resName name' |
| voronota_get-balls-from-atoms-file | Reads atoms from a PDB or mmCIF file and computes Voronoi tessellation balls. |
| voronota_query-balls | Query a list of balls based on various criteria and modify them. |
| voronota_query-balls-clashes | Query Voronota output for ball clashes. |
| voronota_query-contacts | Query contacts based on various criteria and modify them. |
| voronota_run-script | Run a script with Voronota |
| voronota_score-contacts-energy | Calculates contact energies based on Voronota analysis. |
| voronota_score-contacts-potential | Calculates potential values for contacts based on various input files and outputs summary statistics. |
| voronota_score-contacts-quality | Calculates weighted average local score based on atom energy descriptors. |
| voronota_write-balls-to-atoms-file | Writes balls to an atoms file. |

## Reference documentation

- [About Voronota](./references/github_com_kliment-olechnovic_voronota_blob_master_README.md)
- [Voronota-JS Expansion](./references/github_com_kliment-olechnovic_voronota_tree_master_expansion_js.md)
- [Voronota-LT Expansion](./references/github_com_kliment-olechnovic_voronota_tree_master_expansion_lt.md)
- [Command Reference Generation](./references/github_com_kliment-olechnovic_voronota_blob_master_document.bash.md)