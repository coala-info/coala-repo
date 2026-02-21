---
name: density-fitness
description: `density-fitness` is a structural biology tool designed to quantify the "fitness" of individual residues within a molecular model (PDB or mmCIF) relative to the experimental electron density.
homepage: https://github.com/PDB-REDO/density-fitness
---

# density-fitness

## Overview

`density-fitness` is a structural biology tool designed to quantify the "fitness" of individual residues within a molecular model (PDB or mmCIF) relative to the experimental electron density. It functions as a modern reimplementation of the CCP4 `edstats` program but extends its capabilities by including EDIAm and OPIA scores. The tool is highly flexible, capable of calculating its own maps from MTZ reflection files or processing pre-calculated 2mFo-DFc and mFo-DFc maps. It supports both X-ray and electron scattering factors, making it applicable to a wide range of structural data.

## Usage Instructions

### Basic Command Patterns

The tool supports three primary ways to provide input data:

1.  **MTZ and Coordinates (Positional):**
    ```bash
    density-fitness input.mtz input.pdb output.json
    ```

2.  **MTZ and Coordinates (Flagged):**
    ```bash
    density-fitness --hklin=input.mtz --xyzin=input.cif --output=results.json
    ```

3.  **Pre-calculated Maps:**
    When using map files, you must explicitly provide both the 2mFo-DFc and mFo-DFc maps along with the resolution limits.
    ```bash
    density-fitness --fomap=2fofc.map --dfmap=fofc.map --reslo=20.0 --reshi=2.0 --xyzin=model.pdb
    ```

### Key Metrics Explained

*   **RSR (Real-Space R-factor):** Measures the difference between observed and calculated density.
*   **RSCC (Real-Space Correlation Coefficient):** Measures the similarity in shape between observed and calculated density.
*   **EDIAm:** A per-residue score based on individual atomic electron density support.
*   **OPIA:** The percentage of atoms in a residue with an EDIA score above 0.8.

### Expert Options and Best Practices

*   **Map Recalculation:** If the model coordinates have changed significantly since the MTZ was generated, use the `--recalc` flag to ensure the density maps are updated to match the current model.
    ```bash
    density-fitness --hklin=data.mtz --xyzin=refined.pdb --recalc
    ```
*   **Handling Ligands:** The tool requires a Chemical Component Dictionary (CCD) to understand non-standard residues. Use `--extra-compounds` to provide a CIF file for custom ligands or monomers.
    ```bash
    density-fitness --hklin=data.mtz --xyzin=model.pdb --extra-compounds=ligand_restraints.cif
    ```
*   **Electron Diffraction:** For Cryo-EM or MicroED data, switch the scattering factors using the `--electron-scattering` flag.
*   **Output Formats:** By default, the tool outputs JSON. To generate legacy CCP4-style `.eds` files, use the `.eds` extension for the output file or force it with `--output-format=edstats`.
*   **Identifier Mapping:** When working with mmCIF files, use `--use-auth-ids` if you prefer the author-assigned chain and residue IDs over the standard `label_` IDs in the output.

## Reference documentation

- [density-fitness Overview](./references/github_com_PDB-REDO_density-fitness.md)
- [Bioconda density-fitness Package](./references/anaconda_org_channels_bioconda_packages_density-fitness_overview.md)