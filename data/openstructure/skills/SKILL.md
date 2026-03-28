---
name: openstructure
description: OpenStructure is a modular framework for structural bioinformatics that provides tools for manipulating macromolecular structures, sequences, and density maps. Use when user asks to clean and validate PDB files, calculate lDDT scores, perform structural selections, or automate structural data processing via a Python interface.
homepage: https://openstructure.org
---


# openstructure

## Overview

OpenStructure (OST) is a modular, high-performance framework tailored for structural bioinformatics. It moves beyond simple visualization to provide a comprehensive toolkit for method developers. It excels at handling macromolecular structures (proteins, nucleic acids, ligands), sequences, and density maps through a unified Python interface. Use this skill to automate structural data cleaning, perform superposition-free model evaluations, and manipulate structural entities using a powerful query language.

## Core CLI Usage

The primary entry point for OpenStructure is the `ost` command, which acts as a Python interpreter pre-configured with the OST environment.

- **Run a script**: `ost script.py`
- **Interactive Shell**: `ost` (Launches an interactive Python environment with `ost` modules available).
- **Molecular Checker (Molck)**: Use the `molck` action to clean and validate PDB files.
  ```bash
  ost molck input.pdb
  ```
- **lDDT Scoring**: Calculate the Local Distance Difference Test score via the CLI.
  ```bash
  ost lddt <model> <reference>
  ```
- **Graphical Interface**: Launch the DNG (Dino/DeepView Next Generation) GUI for interactive visualization.
  ```bash
  dng
  ```

## Python API Best Practices

When writing scripts for the `ost` interpreter, follow these patterns for efficiency and reliability.

### Loading Structures
Always consider the quality of your input data. For legacy PDB files with potential errors, use the fault-tolerant loader.
```python
from ost import io

# Standard loading
ent = io.LoadPDB('protein.pdb')

# Loading "crappy" or non-standard PDBs
ent = io.LoadPDB('messy.pdb', fault_tolerant=True)

# Loading mmCIF (preferred for modern structures)
ent = io.LoadPDB('structure.cif')
```

### Selection and Queries
OST uses a dedicated query language to create `EntityView` objects, which are lightweight references to subsets of a structure.
```python
# Select specific chains and residue ranges
view = ent.Select('chain=A and rnum=10:50')

# Select by chemical property
hydrophobic = ent.Select('rname=ALA,ILE,LEU,VAL')

# Select atoms within a radius of a point or another selection
nearby = ent.Select('5 < [chain=L]')
```

### Sequence and Alignment
OST allows tight integration between sequences and 3D coordinates.
```python
from ost import seq

# Load a fasta file
s = io.LoadSequence('seq.fasta')

# Create an alignment
aln = seq.CreateAlignment()
aln.AddSequence(s1)
aln.AddSequence(s2)
```

## Expert Tips

- **Environment Setup**: If using OST as a library in a standard Python environment (outside the `ost` binary), ensure your `PYTHONPATH` includes the `site-packages` directory of your OST installation.
- **Connectivity**: If bonds are missing or incorrect, use the `conop` (Connectivity Optimizer) module to re-assign connectivity based on the compound library.
- **Memory Management**: When working with large trajectories or many structures, prefer `EntityView` over copying `EntityHandle` objects to save memory.
- **Scoring Complex Models**: For oligomeric structures, use the `QS-score` (Quaternary Structure score) to evaluate the interface accuracy between models and references.



## Subcommands

| Command | Description |
|---------|-------------|
| molck | the molecule checker |
| ost | OpenStructure command-line interface |

## Reference documentation
- [OpenStructure documentation](./references/openstructure_org_docs_2.11.md)
- [A gentle introduction to OpenStructure](./references/openstructure_org_docs_2.11_intro.md)
- [Frequently Asked Questions](./references/openstructure_org_faq.md)
- [OpenStructure Features](./references/openstructure_org_features.md)