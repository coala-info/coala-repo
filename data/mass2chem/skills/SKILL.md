---
name: mass2chem
description: The `mass2chem` library provides low-level utilities for the "mass-to-chemistry" transition in metabolomics and mass spectrometry workflows.
homepage: https://github.com/shuzhao-li/mass2chem
---

# mass2chem

## Overview
The `mass2chem` library provides low-level utilities for the "mass-to-chemistry" transition in metabolomics and mass spectrometry workflows. It is designed for high-resolution data where precision is critical (including electron mass considerations). Use this skill to perform deterministic calculations for chemical formulas, predict adduct masses, and identify common mass spectrometry contaminants or isotopologue patterns.

## Core Functionalities

### Formula and Mass Calculation
`mass2chem` handles chemical formulas with high precision. Unlike general chemistry tools, it focuses on monoisotopic mass rather than average molecular weight.
- **Monoisotopic Mass**: Calculate the exact mass of a formula based on its most abundant isotopes.
- **Adduct Calculation**: Compute expected m/z values for various adducts (e.g., M+H, M+Na, M-H) across different ionization modes.
- **Precision**: Always use the library's internal mass constants to ensure compatibility with high-resolution instruments (Orbitrap, Q-TOF).

### Data Search and Indexing
The tool includes functions to search mass spectrometry data against libraries:
- **Metabolite Libraries**: Search for known biological entities.
- **Contaminant Identification**: Cross-reference peaks against databases of common lab contaminants (e.g., plasticizers, detergents).
- **Mass Differences**: Identify relationships between peaks based on common chemical transformations or isotope spacings.

### Mass Patterns
The library provides specific data for:
- **Isotopologues**: Expected intensity and mass distributions for carbon, nitrogen, and oxygen isotopes.
- **In-Source Fragments (ISF)**: Identification of fragments created within the ion source rather than the collision cell.
- **Instrument-Specific Data**: Access patterns tailored to specific instrument types and ion modes located in `mass2chem/source_data`.

## Usage Best Practices
- **Ionization Modes**: Ensure you specify the correct ion mode (positive or negative) when calculating adducts, as the library uses mode-specific mass shifts.
- **Electron Mass**: For high-resolution metabolomics, ensure the `mass2chem` functions are used to account for the mass of the electron in charged species, as rounding errors in simpler tools can lead to incorrect identifications.
- **Library Integration**: Use the indexing functions to perform fast lookups in large experimental datasets against reference mass lists.

## Reference documentation
- [mass2chem GitHub Repository](./references/github_com_shuzhao-li-lab_mass2chem.md)
- [mass2chem Wiki and Contaminant Resources](./references/github_com_shuzhao-li-lab_mass2chem_wiki.md)