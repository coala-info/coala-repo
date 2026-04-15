---
name: ogs
description: Installs and provides guidance for using the OpenGeoSys (OGS) THMC simulator. Use when user asks to install OGS, run THMC simulations, or get guidance on OGS usage.
homepage: https://github.com/OGSR/OGSR-Engine
metadata:
  docker_image: "quay.io/biocontainers/ogs:6.5.3"
---

# ogs

Installs and provides guidance for using the OpenGeoSys (OGS) THMC simulator.
  Use when Claude needs to perform simulations of thermo-hydro-mechanical-chemical processes in porous and fractured media, or when working with OGS installation and basic usage.
body: |
  ## Overview
  The OpenGeoSys (OGS) skill is designed to assist with the installation and fundamental usage of the OGS THMC simulator. This tool is specialized for simulating complex physical and chemical processes in geological formations. Use this skill when you need to set up OGS or understand its basic command-line operations for simulation tasks.

  ## Installation and Usage

  ### Installation via Conda

  The recommended method for installing OGS is through conda-forge.

  To install the latest version:
  ```bash
  conda install conda-forge::ogs
  ```

  ### Basic Usage

  OGS is primarily a command-line tool. The core command is `ogs`. While the provided documentation does not detail specific command-line arguments or common patterns for running simulations, the general workflow involves:

  1.  **Preparing Input Files**: OGS simulations require input files that define the problem geometry, material properties, boundary conditions, and simulation parameters. These are typically in XML format.
  2.  **Running the Simulation**: Execute OGS with the path to your input file.

  **Example (Conceptual - actual command may vary based on OGS version and specific needs):**
  ```bash
  ogs path/to/your/input_file.xml
  ```

  ### Key Information Sources

  For detailed usage, command-line arguments, and advanced features, refer to the official OGS documentation. The provided documentation primarily focuses on the project's existence and GitHub repository structure, rather than specific CLI commands.

  - [OpenGeoSys (OGS) THMC simulator on Anaconda.org](https://anaconda.org/conda-forge/ogs)
  - [OpenGeoSys Official Documentation](https://www.opengeosys.org/docs)
  - [OGSR/OGSR-Engine GitHub Repository](https://github.com/OGSR/OGSR-Engine) (Note: This repository appears to be for a game engine modification, not the core OGS simulator. The Anaconda.org link is the primary source for the simulator itself.)

  ## Best Practices and Tips

  *   **Consult Official Documentation**: Due to the complexity of THMC simulations, always refer to the official OGS documentation for the most accurate and up-to-date information on input file formats, command-line options, and best practices.
  *   **Input File Structure**: Familiarize yourself with the XML input file structure. This is crucial for defining your simulation correctly.
  *   **Version Compatibility**: Ensure your input files and any scripts you use are compatible with the installed version of OGS.

  ## Reference documentation
  - [OpenGeoSys (OGS) THMC simulator on Anaconda.org](./references/anaconda_org_channels_conda-forge_packages_ogs_overview.md)