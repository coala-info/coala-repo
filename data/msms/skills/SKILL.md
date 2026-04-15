---
name: msms
description: The MSMS tool computes molecular surfaces from molecular structures. Use when user asks to compute molecular surfaces, generate solvent excluded surfaces, or generate solvent accessible surfaces.
homepage: https://github.com/MotorolaMobilityLLC/kernel-msm
metadata:
  docker_image: "quay.io/biocontainers/msms:2.6.1--h9ee0642_3"
---

# msms

---
## Overview
The MSMS tool is designed to compute molecular surfaces from molecular structures. It's a C-based program that generates surface representations, which are crucial for various analyses in fields like computational chemistry and structural biology.

## Usage Instructions

MSMS is a command-line tool. The primary function is to generate surface files from a PDB (Protein Data Bank) file.

### Basic Surface Generation

The most common usage involves providing an input PDB file and specifying output filenames for the surface and surface properties.

```bash
msms -i input.pdb -o output_surface -p output_properties
```

- `-i <input.pdb>`: Specifies the input PDB file containing the molecular coordinates.
- `-o <output_surface>`: Specifies the base name for the output surface file (e.g., `output_surface.xyz`).
- `-p <output_properties>`: Specifies the base name for the output file containing surface properties (e.g., `output_properties.prop`).

### Advanced Options

MSMS offers several options to customize the surface generation:

*   **Probe Radius (`-r`)**: Controls the radius of the probe sphere used to define the molecular surface. A smaller radius will result in a more detailed surface that can penetrate smaller cavities.
    ```bash
    msms -i input.pdb -o output_surface -p output_properties -r 1.4
    ```
    (Default is typically 1.4 Angstroms)

*   **Surface Type (`-s`)**: Specifies the type of surface to compute.
    *   `SES` (Solvent Excluded Surface): The default, representing the surface that a solvent molecule cannot occupy.
    *   `SAS` (Solvent Accessible Surface): The surface traced by the center of the solvent probe.
    ```bash
    msms -i input.pdb -o output_surface -p output_properties -s SAS
    ```

*   **Surface Resolution (`-d`)**: Determines the density of surface points. Higher values lead to a more detailed surface but increase computation time and file size.
    ```bash
    msms -i input.pdb -o output_surface -p output_properties -d 5.0
    ```
    (A value of 5.0 is often a good balance.)

*   **Chain Separation (`-c`)**: When dealing with multi-chain proteins, this option can be used to control how surfaces are computed for individual chains.
    ```bash
    msms -i input.pdb -o output_surface -p output_properties -c
    ```

*   **Output Format (`-f`)**: Specifies the output format for the surface file. Common options include `xyz` (default) and `off`.
    ```bash
    msms -i input.pdb -o output_surface -p output_properties -f off
    ```

### Example Workflow

To generate a solvent-excluded surface with a probe radius of 1.5 Angstroms and save it as `my_protein_ses.xyz` and `my_protein_ses.prop`:

```bash
msms -i my_protein.pdb -o my_protein_ses -p my_protein_ses -r 1.5 -s SES
```

## Expert Tips

*   **Input PDB Quality**: Ensure your input PDB file is clean and correctly formatted. Missing atoms or incorrect residue numbering can lead to errors or inaccurate surfaces.
*   **Probe Radius Selection**: The choice of probe radius (`-r`) is critical. For general purposes, the default is often suitable. For analyzing binding pockets or internal cavities, a smaller radius might be necessary. For analyzing the overall molecular shape, a larger radius could be used.
*   **Surface Type Choice**: Understand the difference between SES and SAS. SES is generally preferred for analyzing molecular interfaces and buried surfaces, while SAS can be useful for understanding accessibility to the molecule.
*   **Output File Handling**: The `.xyz` file contains vertex and face information for the surface mesh, while the `.prop` file contains associated properties (like area, curvature, etc.) for each vertex. These files are often used by visualization software (e.g., PyMOL, VMD) or for further computational analysis.
*   **Performance**: For very large molecules, surface generation can be computationally intensive. Experiment with the `-d` (density) and `-r` (probe radius) parameters to balance detail and performance.

## Reference documentation
- [MSMS Overview (bioconda)](./references/anaconda_org_channels_bioconda_packages_msms_overview.md)