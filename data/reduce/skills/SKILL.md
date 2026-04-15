---
name: reduce
description: The reduce tool adds and corrects hydrogen atoms in Protein Data Bank files. Use when user asks to add hydrogens to a PDB file or correct hydrogens in a PDB file.
homepage: https://github.com/rlabduke/reduce
metadata:
  docker_image: "quay.io/biocontainers/reduce:4.15--py39h2de1943_4"
---

# reduce

yaml
name: reduce
description: |
  Tool for adding and correcting hydrogens in Protein Data Bank (PDB) files.
  Use when preparing protein structures for computational biology, molecular modeling,
  or simulations, specifically when hydrogen atoms need to be added or adjusted
  to PDB files.
```
## Overview
The `reduce` tool is designed to add and correct hydrogen atoms within Protein Data Bank (PDB) files. This is a crucial step in preparing molecular structures for various computational analyses, such as simulations and modeling, by ensuring accurate representation of hydrogen placement.

## Usage Instructions

The `reduce` tool is primarily used via its command-line interface. The basic syntax involves specifying the input PDB file and optionally an output file.

### Basic Usage

To add/correct hydrogens in a PDB file and print the output to standard output:

```bash
reduce input.pdb
```

To save the modified PDB file to a new file:

```bash
reduce input.pdb > output.pdb
```

### Key Options and Patterns

*   **Adding Hydrogens**: By default, `reduce` adds hydrogens to molecules where they are missing.
*   **Correcting Hydrogens**: It also corrects the positions and orientations of existing hydrogens based on chemical and physical principles.
*   **Handling Different Protonation States**: `reduce` can handle various protonation states of titratable residues.
*   **Output Control**: The output can be directed to standard output or a specified file.

### Expert Tips

*   **Always review the output**: While `reduce` is powerful, it's good practice to visually inspect the modified PDB file, especially for complex or unusual structures, to ensure the added/corrected hydrogens are chemically reasonable.
*   **Consider `reduce2` for newer workflows**: The documentation mentions `reduce2` as a successor integrated into the CCTBX project, which may offer enhanced features and support for newer file formats like CIF. If you encounter issues or require advanced functionality, exploring `reduce2` might be beneficial.
*   **Installation**: `reduce` can be installed via conda (`conda install bioconda::reduce`) or Homebrew (`brew tap brewsci/bio && brew install reduce`). Ensure your PATH environment variable is set correctly after installation to run the `reduce` command.

## Reference documentation
- [Overview of Reduce Tool](./references/anaconda_org_channels_bioconda_packages_reduce_overview.md)
- [Reduce GitHub Repository](./references/github_com_rlabduke_reduce.md)