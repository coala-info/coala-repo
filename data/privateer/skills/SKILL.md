---
name: privateer
description: Privateer validates carbohydrate structures in 3D models by checking stereochemistry and consistency with experimental electron density. Use when user asks to validate sugar molecules, detect errors in carbohydrate modeling, generate SNFG vector diagrams, or produce torsion restraints for refinement.
homepage: https://github.com/glycojones/privateer
metadata:
  docker_image: "quay.io/biocontainers/privateer:MKV--py311h8d1dbc1_0"
---

# privateer

## Overview

Privateer (the Swiss Army knife for carbohydrate structures) is a specialized utility for glycobiologists and structural biologists. It automates the tedious process of verifying that sugar molecules in a 3D model (PDB/mmCIF) are stereochemically correct and consistent with experimental electron density. You should use this skill to detect errors in carbohydrate modeling, generate high-quality vector diagrams for publications, and produce unimodal torsion restraints that prevent sugars from being distorted into high-energy conformations during refinement.

## Installation and Environment

Privateer is typically distributed via Bioconda or as part of the CCP4/CCP-EM suites.

```bash
# Installation via Conda
conda install bioconda::privateer
```

**Critical Requirement:** Privateer relies on CCP4 environment variables. Before execution, ensure the environment is initialized:
```bash
source /path/to/ccp4/bin/ccp4.envsetup-sh
```

## Common CLI Patterns

### Basic Structure Validation
To perform a standard validation of a carbohydrate model against its experimental data:
```bash
privateer -pdbin model.pdb -mtzin data.mtz
```
This command will output assignments for ring conformation, anomeric form, and absolute configuration, along with correlation coefficients to the electron density.

### Comprehensive Analysis with Database Support
For a more thorough check using the internal carbohydrate database and GlyTouCan integration:
```bash
privateer -pdbin model.pdb \
          -mtzin data.mtz \
          -databasein privateer_database.json \
          -glytoucan \
          -all_permutations \
          -debug_output
```

### Generating Refinement Restraints
If a sugar is in an incorrect or high-energy conformation, use Privateer to generate a chemical dictionary with unimodal torsion restraints to guide refinement software (like Phenix or REFMAC) toward the correct lowest-energy state.

### Graphical Analysis
Privateer automatically produces vector diagrams in **SNFG (Symbol Nomenclature for Glycans)** format.
- Look for `.svg` files in the output directory.
- These diagrams are annotated with validation metadata (e.g., highlighting conformation or anomer issues).

## Expert Tips

- **Omit Maps**: Privateer computes omit mFo-DFc maps automatically. Use these to verify if the sugar atoms are truly supported by the density or if the model is overfitted.
- **Coot Integration**: The tool produces Scheme and Python scripts specifically for Coot. Load these scripts in Coot to visualize Privateer's validation hits directly on the 3D model.
- **Torsional Analysis**: For N-glycans, pay close attention to the linkage torsion analysis. Privateer can flag "unnatural" terminations or high-energy linkages that are often missed by general-purpose validation tools.
- **Programmatic Access**: If the binary is insufficient, Privateer provides Python bindings (`import privateer`) within its virtual environment for custom validation scripts.

## Reference documentation
- [Privateer Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_privateer_overview.md)
- [Privateer GitHub Repository and Usage](./references/github_com_glycojones_privateer.md)