---
name: biskit
description: Biskit is an object-oriented Python platform designed to streamline structural bioinformatics research.
homepage: http://biskit.pasteur.fr
---

# biskit

## Overview
Biskit is an object-oriented Python platform designed to streamline structural bioinformatics research. It acts as a high-level wrapper and integration layer, combining the numerical power of NumPy with established external tools like Xplor, Amber, and Modeller. Use this skill to automate complex structural workflows, such as quasiharmonic entropy calculations, conformal sampling, and parallelized analysis of macromolecular complexes.

## Core Capabilities
- **Structure Manipulation**: Advanced handling of PDB models and protein complexes via the `PDBModel` and `ComplexList` classes.
- **Trajectory Analysis**: Efficient processing of molecular dynamics data using the `Trajectory` class.
- **Workflow Integration**: Automated interfaces for external software including DSSP (secondary structure), T-Coffee (alignment), and TMAlign (structural comparison).
- **Modeling & Docking**: Support for automated homology modeling and multi-model protein-protein docking.

## Usage Best Practices
- **NumPy Integration**: Leverage Biskit's tight integration with NumPy for "number crunching" tasks to ensure performance when handling large atomic coordinate sets.
- **External Tool Setup**: Ensure that external dependencies (e.g., Modeller, Amber, or DSSP) are correctly installed in the environment path, as Biskit functions as a coordinator for these engines.
- **Parallelization**: Use Biskit's built-in support for PVM (Parallel Virtual Machine) when scaling structural workflows across multiple processors.
- **Object-Oriented Workflow**: Prefer using the high-level classes (`PDBModel`, `PDBDope`) rather than manual parsing to maintain data integrity across different structural formats.

## Installation & Environment
- **Conda**: `conda install bioconda::biskit`
- **Pip**: `pip install biskit`
- **Platform Note**: While the latest versions are `noarch`, specific legacy support for `linux-64` and `macos-64` is maintained in versions 2.4.3 and earlier.

## Reference documentation
- [Biskit Pasteur Home](./references/biskit_pasteur_fr_index.md)
- [Bioconda Biskit Package Overview](./references/anaconda_org_channels_bioconda_packages_biskit_overview.md)