---
name: cif-tools
description: The `cif-tools` suite is a collection of high-performance C++ utilities designed to handle the complexities of mmCIF and PDB data formats.
homepage: https://github.com/PDB-REDO/cif-tools
---

# cif-tools

## Overview

The `cif-tools` suite is a collection of high-performance C++ utilities designed to handle the complexities of mmCIF and PDB data formats. This skill enables the efficient use of specialized binaries to ensure structural data adheres to PDBx/mmCIF dictionaries, identify differences between structural models, and extract specific data points using a query language. It is particularly useful for structural biologists and bioinformaticians performing quality control or automated data processing on protein structures.

## Core Tool Usage

The suite consists of several specialized programs. Below are the primary tools and their common application patterns.

### Validating mmCIF Files
Use `cif-validate` to check if an mmCIF file conforms to the standard PDBx/mmCIF dictionary or a custom dictionary.

*   **Standard Validation**: Run the tool against a target file to identify syntax errors or dictionary violations.
*   **PDBx Validation**: The tool supports validation against the PDBx dictionary to ensure compatibility with the Protein Data Bank.
*   **Stripping Data**: Use the `--strip` option when you need to remove specific data categories or items during the validation process.
*   **Multi-dictionary Support**: Note that while the tool is designed for dictionary-based validation, ensure you are targeting the correct dictionary file for the specific data items (e.g., ligands vs. polymer chains).

### Comparing Structural Files
Use `cif-diff` to identify differences between two CIF files. This is essential for tracking changes during refinement or comparing different versions of a structural model.

*   **Structural Comparison**: Compare the coordinates and metadata of two files to see what has been modified.
*   **Order Sensitivity**: Be aware that `cif-diff` handles the order of data items; use it to ensure that data reordering hasn't introduced unintended changes.

### Querying Data with mmCQL
For complex data extraction, use `mmCQL` (macromolecular Crystallographic Query Language).

*   **Data Extraction**: Use mmCQL commands to select specific rows or columns from mmCIF categories without writing custom parsers.
*   **Filtering**: Apply filters to structural data to isolate specific residues, chains, or experimental metadata.

### Sequence Reconstruction
The suite includes functionality for reconstructing sequences from structural data, which is useful when the `_entity_poly_seq` and `_atom_site` data need to be synchronized or verified.

## Best Practices

*   **Dictionary Consistency**: Always validate against the most recent PDBx/mmCIF dictionary to ensure your files meet current deposition standards.
*   **PDB to mmCIF Transition**: Prefer using these tools on mmCIF files rather than legacy PDB files whenever possible, as mmCIF is the native format for `libcif++` (the underlying library).
*   **Pipeline Integration**: Use these tools as pre-processing steps in structural bioinformatics pipelines to catch malformed data before it reaches downstream analysis tools.

## Reference documentation

- [cif-tools Overview](./references/anaconda_org_channels_bioconda_packages_cif-tools_overview.md)
- [cif-tools GitHub Repository](./references/github_com_PDB-REDO_cif-tools.md)
- [cif-tools Issues and Tool Details](./references/github_com_PDB-REDO_cif-tools_issues.md)
- [cif-tools Commit History and Features](./references/github_com_PDB-REDO_cif-tools_commits_trunk.md)