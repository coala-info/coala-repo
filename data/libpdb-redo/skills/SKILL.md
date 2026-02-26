---
name: libpdb-redo
description: libpdb-redo provides tools for the automated refinement, rebuilding, and validation of macromolecular structure models. Use when user asks to download optimized PDB entries, calculate Ramachandran Z-scores with Tortoize, assign secondary structures using DSSP, or retrieve model validation metrics.
homepage: https://pdb-redo.eu
---


# libpdb-redo

## Overview
The `libpdb-redo` skill provides a specialized interface for macromolecular structure model optimization. It enables the automated refinement and rebuilding of protein structures by combining standard crystallographic software (like REFMAC) with proprietary tools for peptide flipping, loop building, and validation. This skill is essential for researchers looking to improve the quality of PDB entries or validate custom models using standardized metrics like Ramachandran Z-scores.

## Core Functionality and CLI Patterns

### Accessing the PDB-REDO Databank
The databank contains optimized versions of existing PDB entries. You can retrieve specific files using standard web tools or `rsync`.

- **Download optimized PDB/mmCIF**:
  `wget https://pdb-redo.eu/db/[PDBID]/[PDBID]_final.pdb`
  `wget https://pdb-redo.eu/db/[PDBID]/[PDBID]_final.cif`
- **Download MTZ (Map coefficients)**:
  `wget https://pdb-redo.eu/db/[PDBID]/[PDBID]_final.mtz`
- **Bulk Download (rsync)**:
  `rsync -av --exclude=attic rsync://rsync.pdb-redo.eu/pdb-redo/ pdb-redo/`

### Structure Validation with Tortoize
Tortoize is used to calculate Ramachandran Z-scores to identify unlikely stereochemistry.
- Use the `tortoize` command to analyze a coordinate file (PDB/mmCIF).
- It outputs a global Ramachandran Z-score and side-chain Z-scores.

### Secondary Structure Assignment (DSSP)
DSSP standardizes secondary structure assignments based on atomic coordinates.
- **Command**: `dssp -i input.cif -o output.dssp`
- **Note**: For large structures, always prefer the mmCIF format over the legacy PDB format to avoid coordinate overflow errors.

### Data Mining and Statistics
Every PDB-REDO entry includes a `data.json` file containing comprehensive validation scores and crystal parameters.
- **URL**: `https://pdb-redo.eu/db/[PDBID]/data.json`
- **Key Metrics**: Look for `RFACT` (R-factor), `RFREE`, and `Z-scores` for model quality assessment.

## Expert Tips
- **Model States**: PDB-REDO provides three distinct states: `0cyc` (original), `besttls` (re-refined only), and `final` (re-refined and rebuilt). Always use `_final` for the most optimized model.
- **Total B-factors**: If your analysis requires total B-factors (including TLS contributions), specifically download the `_final_tot.pdb` file.
- **Ligand Interactions**: For entries with ligands, check `[PDBID]_ligval.json` for specific ligand validation and interaction data.
- **Local Installation**: For sensitive data or large-scale batch processing, install `libpdb-redo` via bioconda: `conda install bioconda::libpdb-redo`.

## Reference documentation
- [PDB-REDO Databank and Archive](./references/pdb-redo_eu_archive.md)
- [Download and API Guide](./references/pdb-redo_eu_download.md)
- [DSSP Secondary Structure Assignment](./references/pdb-redo_eu_dssp.md)
- [Tortoize Ramachandran Z-scores](./references/pdb-redo_eu_tortoize.md)