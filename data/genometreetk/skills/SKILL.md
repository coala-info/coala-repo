---
name: genometreetk
description: This toolbox is for working with genome trees. Use when user asks to build, edit, query, or visualize genome trees.
homepage: http://pypi.python.org/pypi/genometreetk/
---


# genometreetk

genometreetk/SKILL.md
```yaml
name: genometreetk
description: A toolbox for working with genome trees. Use when Claude needs to perform operations related to phylogenetic tree manipulation, analysis, or visualization for genomic data. This includes tasks like building, editing, or querying genome trees.
```
## Overview
This skill provides a command-line interface (CLI) toolbox for manipulating and analyzing genome trees. It is designed for bioinformatics tasks involving phylogenetic trees derived from genomic data.

## Usage Instructions

The `genometreetk` tool is a command-line utility. Its primary function is to facilitate operations on genome trees. While specific subcommands and their detailed options are not provided in the available documentation, general usage patterns for such bioinformatics tools typically involve:

1.  **Specifying an input tree file**: Most operations will require you to provide the path to your genome tree file (e.g., in Newick or NEXUS format).
2.  **Selecting a subcommand**: The tool likely has various subcommands for different tasks (e.g., `build`, `edit`, `query`, `visualize`).
3.  **Providing necessary arguments**: Each subcommand will have its own set of arguments, such as output file paths, parameters for analysis, or specific nodes/taxa to target.

**Common CLI Patterns to Expect:**

*   **Help command**: To understand available subcommands and options, use `genometreetk --help` or `genometreetk <subcommand> --help`.
*   **Input/Output redirection**: You may be able to use standard input/output redirection (`<`, `>`) for piping data between `genometreetk` and other tools, or for handling large files.
*   **File formats**: Be aware of the supported input and output file formats for genome trees (e.g., Newick, NEXUS, PhyloXML).

**Expert Tips:**

*   **Consult the help documentation**: Always start by exploring the tool's built-in help (`--help`) to understand its full capabilities and the correct syntax for commands.
*   **Start with simple operations**: If you are new to `genometreetk`, begin with basic tasks like reading a tree or performing a simple query to familiarize yourself with its behavior.
*   **Check version compatibility**: If you encounter unexpected behavior, ensure your `genometreetk` version is compatible with the input tree file format and any associated data.

Due to the limited detail in the provided documentation regarding specific commands and their arguments, it is highly recommended to consult the tool's official documentation or its help messages for precise usage instructions.

## Reference documentation
- [genometreetk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_genometreetk_overview.md)
- [genometreetk · PyPI](./references/pypi_org_project_genometreetk.md)