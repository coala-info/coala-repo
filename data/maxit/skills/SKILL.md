---
name: maxit
description: Maxit processes and curates macromolecular structure data in PDB and mmCIF formats. Use when user asks to translate formats, perform consistency checks, manipulate coordinates, align residue numbering, reorder/rename atoms, or assign ligand chain IDs.
homepage: https://sw-tools.rcsb.org/apps/MAXIT
metadata:
  docker_image: "quay.io/biocontainers/maxit:11.400--h503566f_0"
---

# maxit

yaml
name: maxit
description: Assists in the processing and curation of macromolecular structure data. Use when Claude needs to work with PDB or mmCIF files for tasks such as: format translation, consistency checks, coordinate manipulation, residue numbering alignment, atom reordering/renaming, and ligand chain ID assignment.
---
## Overview
MAXIT is a powerful command-line tool designed for the processing and curation of macromolecular structure data, primarily focusing on PDB and mmCIF file formats. It excels at tasks requiring data consistency, format conversion, and detailed manipulation of structural information, including coordinates, sequences, and ligand details. Use MAXIT when you need to ensure the integrity of structural data, translate between common formats, or perform intricate adjustments to atom and residue information.

## Usage Instructions

MAXIT is a command-line utility. Its operations typically involve specifying input files, output files, and various flags to control its behavior.

### Core Functionality and Common Operations

MAXIT's primary strength lies in its ability to read, write, and translate between PDB and mmCIF formats.

**1. Format Translation:**
To translate a PDB file to mmCIF format:
```bash
maxit -i input.pdb -o output.cif
```
To translate an mmCIF file to PDB format:
```bash
maxit -i input.cif -o output.pdb
```

**2. Consistency Checks:**
MAXIT can perform various consistency checks on structural data. While specific flags for detailed checks might require consulting the full documentation, a general approach involves running MAXIT with input files to identify potential issues. The output will often highlight discrepancies.

**3. Coordinate and Sequence Alignment:**
Aligning residue numbering between coordinates and sequence:
```bash
maxit -i input.pdb -o aligned.pdb --align-residue-numbering
```
*(Note: The exact flag for this operation might vary. Refer to detailed MAXIT documentation for precise command-line arguments.)*

**4. Atom Reordering and Renaming:**
MAXIT can reorder and rename atoms, especially for non-standard residues and ligands, according to the Chemical Component Dictionary. This is crucial for standardizing data.
```bash
maxit -i input.pdb -o standardized.pdb --standardize-ligands
```
*(Note: The exact flag for this operation might vary. Refer to detailed MAXIT documentation for precise command-line arguments.)*

**5. Ligand Chain ID Assignment:**
Assigning ligands the same chain IDs as adjacent polymers:
```bash
maxit -i input.pdb -o renumbered_ligands.pdb --assign-ligand-chains
```
*(Note: The exact flag for this operation might vary. Refer to detailed MAXIT documentation for precise command-line arguments.)*

### Expert Tips and Best Practices

*   **Always specify input and output:** Use the `-i` flag for input files and `-o` for output files. Explicitly defining these prevents accidental overwrites and clarifies the data flow.
*   **Understand your data:** Before running complex operations, have a clear understanding of your input file format (PDB or mmCIF) and the specific curation or processing task you aim to achieve.
*   **Consult detailed documentation for advanced flags:** The examples above cover common use cases. For specific operations like detailed consistency checks, advanced atom manipulation, or complex merging, refer to the official MAXIT documentation for a comprehensive list of command-line arguments and their precise functions.
*   **Process in stages:** For complex workflows involving multiple MAXIT operations, consider processing your data in stages. Run MAXIT for format conversion, then for consistency checks, and so on, saving intermediate files to track progress and isolate issues.
*   **Error messages are informative:** Pay close attention to any output messages from MAXIT. They often provide valuable clues about data inconsistencies or errors encountered during processing.

## Reference documentation
- [MAXIT Suite source Downloads](./references/sw-tools_rcsb_org_apps_MAXIT_source.html.md)
- [MAXIT Overview](./references/sw-tools_rcsb_org_apps_MAXIT.md)