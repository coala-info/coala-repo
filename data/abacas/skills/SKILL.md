---
name: abacas
description: ABACAS rapidly organizes, orients, and orders assembled contigs by mapping them to a related reference genome to create a consensus pseudomolecule. Use when user asks to order and orient contigs, map assembly to a reference genome, or generate a pseudomolecule for gap closure and visualization.
homepage: http://abacas.sourceforge.net/
---


# abacas

## Overview

ABACAS (Algorithm Based Automatic Contiguation of Assembled Sequences) is a tool designed to rapidly organize assembled contigs by mapping them to a related reference genome. It automates the process of contig orientation and ordering, identifies overlaps, and generates a consensus pseudomolecule. This skill provides the necessary command-line patterns to execute the alignment using MUMmer and prepare files for downstream visualization and gap closure.

## Usage Instructions

### Basic Command Syntax
The core functionality is invoked via the Perl script. You must provide a reference genome and your assembled contigs in FASTA format.

```bash
perl abacas.pl -r <reference.fasta> -q <contigs.fasta> -p <nucmer|promer> [options]
```

### Key Parameters
- `-r`: Path to the reference genome file (FASTA).
- `-q`: Path to the query contigs file (FASTA).
- `-p`: Alignment program selection.
    - `nucmer`: Use for closely related sequences (DNA level).
    - `promer`: Use for more divergent sequences (Protein level).
- `-m`: Generate a primer file for gap closing (optional).
- `-b`: Use if you want to keep the bin file containing unmapped contigs.

### Workflow and Best Practices
1. **Alignment Selection**: Use `nucmer` by default for same-species comparisons. Switch to `promer` if the identity is low or if you are comparing across different species where only protein conservation remains.
2. **MUMmer Dependency**: Ensure MUMmer is in your PATH. If ABACAS cannot find it, it will prompt for the location; you can often avoid this by setting the environment variable or providing the full path to the MUMmer binaries.
3. **Output Interpretation**:
    - **Pseudomolecule**: The primary output is a FASTA file representing the ordered contigs with 'N's representing gaps.
    - **Comparison File**: A `.crunch` or comparison file is generated for use in ACT (Artemis Comparison Tool).
    - **The Bin**: Check the `<query>.bin` file. This contains contigs that were either unmapped or mapped to multiple locations, which may require manual intervention.
4. **Visualization**: To inspect the results, load the reference, the generated pseudomolecule, and the comparison file into ACT. This allows you to see the red bars representing synteny and identify where the assembly might be misaligned.

### Expert Tips
- **Repetitive Regions**: If gaps appear frequently, load the reference repeat plot in ACT (`Graph` -> `Add User Plot` -> `<reference>.Repeats.plot`) to determine if the gaps are caused by repetitive elements that the assembler couldn't resolve.
- **Contig Naming**: Ensure your FASTA headers are simple and unique to prevent parsing errors during the generation of the feature table (`.tab` file).

## Reference documentation
- [ABACAS Documentation](./references/abacas_sourceforge_net_documentation.html.md)
- [ABACAS Home](./references/abacas_sourceforge_net_index.html.md)