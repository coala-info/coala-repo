---
name: fragbuilder
description: FragBuilder is a Python toolkit that automates the generation of 3D peptide structures and the preparation of quantum mechanical calculation input files. Use when user asks to generate peptide models from sequences, sample backbone or side-chain torsion angles, and create Gaussian 09 input files for geometry optimization or NMR shielding calculations.
homepage: https://github.com/jensengroup/fragbuilder
---


# fragbuilder

## Overview
FragBuilder is a Python-based toolkit designed to automate the setup and analysis of quantum mechanical (QM) calculations for peptides. It provides a high-level interface to generate 3D peptide structures from sequences, manipulate their dihedral angles, and prepare input files for Gaussian 09. It is particularly useful for researchers performing conformational scans or NMR shielding calculations where high-throughput model generation is required.

## Core Usage Patterns

### Initializing Peptides
The primary entry point is the `fragbuilder.Peptide` class. It handles the construction of the molecular model.
```python
import fragbuilder
# Create a peptide from a sequence
peptide = fragbuilder.Peptide("ALA-GLY-VAL")
```

### Conformational Sampling
FragBuilder integrates the BASILISK library to sample realistic backbone and side-chain torsion angles.
- **Backbone Sampling**: Use `peptide.sample_bb_angles()` to generate realistic phi/psi distributions.
- **Side-chain Sampling**: Use `peptide.sample_chi_angles()` to sample rotamers.
- **Manual Adjustment**: You can manually set dihedral angles to explore specific regions of the Ramachandran plot.

### Generating Gaussian 09 Input Files
FragBuilder provides specialized wrappers to create input files for various QM tasks:
- `fragbuilder.G09_opt`: For geometry optimizations.
- `fragbuilder.G09_energy`: For single-point energy calculations.
- `fragbuilder.G09_NMR`: For NMR shielding constant calculations.

Example pattern:
```python
# Setup a geometry optimization for Gaussian 09
opt_calc = fragbuilder.G09_opt(peptide)
opt_calc.write_input("opt_job.com")
```

### PDB Analysis
The `fragbuilder.PDB` class allows you to extract structural data from existing PDB files to use as a basis for QM models.
- Use it to read backbone and side-chain torsion angles.
- Useful for "cleaning" or preparing experimental structures for theoretical refinement.

## Expert Tips and Best Practices

- **Python Version**: FragBuilder is designed for Python 2.x. Ensure your environment is configured correctly, as it may not be compatible with Python 3.x without manual porting.
- **Open Babel Dependency**: FragBuilder relies heavily on Open Babel. If you encounter inaccuracies in dihedral angle settings, ensure you are using a version of Open Babel where the dihedral bug is fixed (typically versions compiled with the latest Python bindings).
- **Environment Setup**: If not installed via Conda, you must manually add the fragbuilder directory to your `PYTHONPATH` to ensure the module is importable.
- **Numerical Stability**: When performing large-scale scans, verify the cross-product functions if you encounter geometry errors, as older versions had known numerical instabilities in specific coordinate transformations.
- **Citations**: When using the sampling features, remember that BASILISK and FragBuilder are separate citations.

## Reference documentation
- [FragBuilder GitHub Repository](./references/github_com_jensengroup_fragbuilder.md)
- [Bioconda FragBuilder Overview](./references/anaconda_org_channels_bioconda_packages_fragbuilder_overview.md)