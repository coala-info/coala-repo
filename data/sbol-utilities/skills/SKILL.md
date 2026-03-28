---
name: sbol-utilities
description: "sbol-utilities provides a toolkit for manipulating, converting, and analyzing SBOL 3 synthetic biology data. Use when user asks to convert between SBOL and other formats, visualize object trees, expand combinatorial designs, calculate sequences, or compare SBOL files."
homepage: https://github.com/SynBioDex/SBOL-utilities
---


# sbol-utilities

## Overview

The `sbol-utilities` package is a specialized toolkit for manipulating and analyzing SBOL 3 data. It provides both a Python API and a set of command-line utilities designed to streamline synthetic biology workflows. Use this skill to transform genetic design data between various standards, visualize object trees, and automate the generation of specific genetic constructs from combinatorial templates.

## Installation and Dependencies

Ensure the package is installed via pip:
```bash
pip install sbol-utilities
```

**External Dependencies:**
- **Graphviz**: Required for `graph-sbol` to render PDF/PNG diagrams.
- **Node.js**: Required for `sbol-converter` to execute local JavaScript-based conversion logic.

## Common CLI Patterns

### Format Conversion
The utility supports bidirectional conversion between SBOL3 and several common formats.

- **General Converter:**
  ```bash
  sbol-converter -i input_file.nt -o output_file.gb
  ```
- **Specific Format Macros:**
  - `sbol2-to-sbol3`: Convert legacy SBOL2 files to the SBOL3 standard.
  - `sbol-to-genbank` / `genbank-to-sbol`: Move between SBOL3 and GenBank.
  - `sbol-to-fasta` / `fasta-to-sbol`: Move between SBOL3 and FASTA.

### Visualization
Generate a visual representation of the SBOL object tree:
```bash
graph-sbol -i design.ttl
```
*Tip: This produces Graphviz source files and a PDF by default.*

### Design Expansion and Calculation
- **Expand Combinatorial Designs**: Generate all possible physical instances from a `CombinatorialDerivation` template.
  ```bash
  sbol-expand-derivations -i template.ttl
  ```
- **Sequence Calculation**: Compute the full DNA sequence for hierarchical components based on their sub-parts.
  ```bash
  sbol-calculate-sequences -i design_no_seq.ttl
  ```
- **Complexity Scoring**: Evaluate the structural complexity of a design.
  ```bash
  sbol-calculate-complexity -i design.ttl
  ```

### Comparison
Compare two SBOL files to identify differences in their object trees:
```bash
sbol-diff file1.ttl file2.ttl
```

## Python API Usage

For integration into automated scripts, use the module-level functions:

```python
import sbol3
from sbol_utilities.graph_sbol import graph_sbol
from sbol_utilities.conversion import sbol2to3

# Load a document
doc = sbol3.Document()
doc.read('my_design.nt')

# Visualize
graph_sbol(doc)

# Convert SBOL2 to SBOL3
sbol3_doc = sbol2to3('legacy_file.xml')
```

## Expert Tips

1. **Excel Integration**: Use the `excel-to-sbol` utility to ingest libraries of parts defined in the standard `sbol_library_template.xlsx`. This is often the fastest way to move from manual lab notes to structured data.
2. **File Formats**: While SBOL3 often uses `.ttl` (Turtle) or `.nt` (N-Triples), the utilities are generally format-agnostic regarding the underlying RDF serialization.
3. **Validation**: Always run `sbol-calculate-sequences` after manually assembling components in a script to ensure the top-level sequence correctly reflects the child components' coordinates.



## Subcommands

| Command | Description |
|---------|-------------|
| excel-to-sbol | Converts an Excel file to SBOL format. |
| graph-sbol | Reads an SBOL file and outputs a graph representation. |
| sbol-calculate-sequences | Calculates sequences for components in an SBOL file. |
| sbol-converter | Converts genetic design files between various formats. |
| sbol-diff | Compares two SBOL files and reports differences. |
| sbol-expand-derivations | Expand derivations in an SBOL file. |

## Reference documentation
- [SBOL-utilities GitHub Repository](./references/github_com_SynBioDex_SBOL-utilities.md)
- [SBOL-utilities README](./references/github_com_SynBioDex_SBOL-utilities_blob_develop_README.md)