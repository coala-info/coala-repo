---
name: opsin
description: OPSIN parses systematic IUPAC chemical names to generate corresponding chemical structures in formats such as SMILES or InChI. Use when user asks to convert chemical names to SMILES, generate InChI keys from IUPAC nomenclature, or translate systematic names into structural representations.
homepage: https://bitbucket.org/dan2097/opsin/
---


# opsin

## Overview
The Open Parser for Systematic IUPAC Nomenclature (OPSIN) is a specialized Java-based library designed to interpret organic chemical names and generate their corresponding chemical structures. It is particularly effective for handling complex IUPAC nomenclature that follows standard organic chemistry rules. Use this skill to automate the bridge between human-readable chemical names and computational formats like SMILES strings or InChI keys.

## Usage Guidelines

### Basic Conversion
The primary use case for OPSIN is converting a string name into a structural format. While typically used as a library, it is often invoked via a CLI wrapper or through conda-managed environments.

- **Input**: Systematic IUPAC names (e.g., "2-acetoxybenzoic acid").
- **Output Formats**: 
    - **SMILES**: Best for general informatics and quick visualization.
    - **InChI/InChIKey**: Best for database indexing and unique identification.
    - **CML (Chemical Markup Language)**: Best for detailed structural data including atom coordinates.

### Best Practices
- **Name Cleaning**: Ensure names are free of non-standard formatting or typos before processing, as OPSIN relies on strict adherence to nomenclature rules.
- **Batch Processing**: When dealing with large datasets, process names in batches to leverage the library's efficiency.
- **Version Compatibility**: This skill targets version 2.4.0+, which requires Java 1.6 or higher.

### Common Patterns
If using the standalone JAR or the bioconda installation, the typical workflow involves:
1. Providing the IUPAC name as a string input.
2. Specifying the desired output format (defaulting usually to SMILES).
3. Handling cases where a name is "uninterpretable" by checking for null or error returns, which indicates the name does not follow supported IUPAC conventions.

## Reference documentation
- [OPSIN Overview](./references/anaconda_org_channels_bioconda_packages_opsin_overview.md)