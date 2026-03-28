---
name: gromacs_mddb
description: gromacs_mddb is a molecular dynamics suite that simulates biochemical systems and exports binary topology files into a structured JSON format. Use when user asks to perform molecular dynamics simulations, convert TPR files to JSON, or preprocess and analyze biochemical system trajectories.
homepage: https://www.gromacs.org/
---

# gromacs_mddb

## Overview
The `gromacs_mddb` package is a specialized development version of the GROMACS molecular dynamics suite. While it functions as a high-performance engine for simulating Newtonian equations of motion for biochemical systems (proteins, lipids, nucleic acids), its primary differentiator is the integration of MDDB-specific features. The most significant addition is the capability to export `.tpr` files—which contain the complete system topology, parameters, and starting coordinates—into a structured JSON format. This allows for easier programmatic access to simulation parameters that are otherwise locked in a binary format.

## Installation and Setup
To ensure you are using the version with MDDB JSON support, install via Bioconda:

```bash
conda install bioconda::gromacs_mddb
```

## Core CLI Usage and Patterns

### TPR to JSON Export
The primary unique feature of this tool is the conversion of binary run files. This is typically handled through the `dump` module or a specialized export flag added to this distribution.

*   **Exporting Topology to JSON**: Use this to inspect simulation parameters or upload metadata to a database.
    ```bash
    gmx dump -s topol.tpr -json out.json
    ```
    *(Note: In this specific fork, the `-json` flag is the key addition to the standard `gmx dump` command.)*

### Standard Simulation Workflow
Since `gromacs_mddb` is built on GROMACS 2025, use the standard `gmx` wrapper for all operations:

1.  **Preprocessing**: Generate the binary run file.
    ```bash
    gmx grompp -f pme.mdp -c conf.gro -p topol.top -o topol.tpr
    ```
2.  **Execution**: Run the simulation (supports GPU acceleration and MPI).
    ```bash
    gmx mdrun -s topol.tpr -deffnm simulation_output
    ```
3.  **Analysis**: Use standard tools for trajectory processing.
    ```bash
    gmx trjconv -s topol.tpr -f traj.xtc -o fixed_traj.xtc -pbc mol -center
    ```

## Expert Tips for MDDB Integration
*   **Metadata Validation**: Before submitting to a data bank, use the JSON export to verify that the `.mdp` parameters (like cut-offs, ensemble types, and force field versions) were correctly compiled into the `.tpr`.
*   **Hardware Endianness**: Like standard GROMACS, the `.tpr` and trajectory files produced by `gromacs_mddb` are hardware-independent. You can generate the JSON export on a different architecture than the one used for the simulation.
*   **Lossy Compression**: When preparing data for MDDB, use `gmx trjconv` with the `-ndec` flag to select the appropriate decimal precision for coordinate storage to balance file size and accuracy.



## Subcommands

| Command | Description |
|---------|-------------|
| gmx | GROMACS command-line tool |
| gmx dump | Reads a run input file (.tpr), a trajectory (.trr/.xtc/tng), an energy file (.edr), a checkpoint file (.cpt) or topology file (.top) and prints that to standard output in a readable format. This program is essential for checking your run input file in case of problems. |
| gmx grompp | reads a molecular topology file, checks the validity of the file, expands the topology from a molecular description to an atomic description. The topology file contains information about molecule types and the number of molecules, the preprocessor copies each molecule as needed. There is no limitation on the number of molecule types. Bonds and bond-angles can be converted into constraints, separately for hydrogens and heavy atoms. Then a coordinate file is read and velocities can be generated from a Maxwellian distribution if requested. gmx grompp also reads parameters for gmx mdrun (eg. number of MD steps, time step, cut-off). Eventually a binary file is produced that can serve as the sole input file for the MD program. |
| gmx mdrun | gmx mdrun is the main computational chemistry engine within GROMACS. Obviously, it performs Molecular Dynamics simulations, but it can also perform Stochastic Dynamics, Energy Minimization, test particle insertion or (re)calculation of energies. Normal mode analysis is another option. In this case mdrun builds a Hessian matrix from single conformation. For usual Normal Modes-like calculations, make sure that the structure provided is properly energy-minimized. The generated matrix can be diagonalized by gmx nmeig. |
| gmx trjconv | gmx trjconv can convert trajectory files in many ways: |

## Reference documentation
- [anaconda_org_channels_bioconda_packages_gromacs_mddb_overview.md](./references/anaconda_org_channels_bioconda_packages_gromacs_mddb_overview.md)
- [www_gromacs_org_about.html.md](./references/www_gromacs_org_about.html.md)
- [www_gromacs_org_index.md](./references/www_gromacs_org_index.md)