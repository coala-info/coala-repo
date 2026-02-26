---
name: sbol-utilities
description: The sbol-utilities tool provides a suite of utilities for managing, converting, and analyzing SBOL biological design data. Use when user asks to convert between SBOL and other formats like GenBank or FASTA, visualize design trees, compare document differences, calculate sequence complexity, or expand combinatorial designs.
homepage: https://github.com/SynBioDex/SBOL-utilities
---


# sbol-utilities

## Overview

The sbol-utilities skill provides a suite of tools for managing biological design data. It bridges the gap between high-level design specifications (like Excel templates) and standard bioinformatic formats. Use this skill to automate the processing of SBOL documents, perform structural comparisons between designs, and validate the synthesizability of DNA sequences through external API integrations.

## Installation and Dependencies

Before using the command-line tools, ensure the package is installed:
```bash
pip3 install sbol-utilities
```

**External Dependencies:**
- **graph-sbol**: Requires `Graphviz` installed on the system to render PDF diagrams.
- **sbol-converter**: Requires `node.js` to execute the underlying conversion logic.

## Common CLI Patterns

### Format Conversion
The `sbol-converter` is the primary tool for moving between SBOL3, SBOL2, GenBank, and FASTA.

- **General Conversion**:
  `sbol-converter -i input_file.gb -o output_file.nt`
- **Specific Macros**:
  - `sbol-to-genbank -i design.nt -o design.gb`
  - `sbol3-to-sbol2 -i sbol3_doc.nt -o sbol2_doc.xml`
  - `fasta-to-sbol -i sequence.fasta -o design.nt`

### Visualization and Analysis
- **Graphing**: Generate a visual object tree of an SBOL document.
  `graph-sbol -i my_design.ttl`
- **Structural Diff**: Compare two SBOL3 documents to identify differences in components or attributes.
  `sbol-diff document1.nt document2.nt`
- **Complexity Scoring**: Calculate the synthesis complexity of sequences using the IDT gBlock API (requires an IDT account).
  `sbol-calculate-complexity -i library.nt`

### Design Expansion
- **Combinatorial Expansion**: Search for `CombinatorialDerivation` objects and generate all possible specific genetic constructs.
  `sbol-expand-derivations -i template.nt -o expanded_library.nt`
- **Sequence Calculation**: Automatically populate the sequences of parent components based on the sequences of their sub-components.
  `sbol-calculate-sequences -i design_nodes.nt`

### Excel Integration
- **Template Conversion**: Convert a standardized Excel library (based on `sbol_library_template.xlsx`) into an SBOL3 document.
  `excel-to-sbol -i parts_list.xlsx -o library.nt`

## Expert Tips

- **File Formats**: While SBOL3 often uses `.nt` (N-Triples) or `.ttl` (Turtle), the utilities generally detect the format based on the file content or extension.
- **Namespace Management**: When converting from Excel or FASTA, ensure your environment or input parameters specify the desired URI namespace to avoid default or conflicting identifiers.
- **Complexity Limits**: The `sbol-calculate-complexity` tool is optimized for sequences between 125 and 3000 bp. Sequences outside this range will return a score of 0. A score $\ge 10$ typically indicates the sequence is not synthesizable by standard services.
- **Python Integration**: For complex workflows, these utilities can be imported as Python modules. For example, use `from sbol_utilities.graph_sbol import graph_sbol` to integrate visualization directly into a script.

## Reference documentation
- [SBOL-utilities GitHub Overview](./references/github_com_SynBioDex_SBOL-utilities.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sbol-utilities_overview.md)