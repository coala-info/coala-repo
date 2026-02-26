---
name: ped_parser
description: ped_parser parses, validates, and converts pedigree files into structured formats like JSON or Madeline2. Use when user asks to validate pedigree consistency, convert PED files to JSON or Madeline2 format, or identify family relationships like trios.
homepage: https://github.com/moonso/ped_parser
---


# ped_parser

## Overview
The `ped_parser` tool is a Python-based utility designed to handle pedigree data structures. It transforms flat pedigree files into structured family and individual objects, allowing for rigorous validation of family trees. It checks for consistent family bindings, verifies parental genders, and identifies relationships like siblings and trios. Beyond validation, it serves as a conversion bridge for Madeline2 (a pedigree drawing tool) and JSON-based workflows.

## CLI Usage and Patterns

### Basic Validation
To check a pedigree file for consistency and errors (such as incorrect genders for parents or missing mandatory values), run the tool directly on the input file:
```bash
ped_parser input.ped
```

### Format Conversion
`ped_parser` is frequently used to prepare data for visualization or web-based applications.

*   **Madeline2 Conversion**: Generates a file compatible with Madeline2 for drawing pedigree trees.
    ```bash
    ped_parser input.ped --to_madeline -o output_madeline.txt
    ```
*   **JSON Conversion**: Outputs a structured JSON representation of families and individuals.
    ```bash
    ped_parser input.ped --to_json -o output.json
    ```

### Handling Alternative PED Formats
If the input file contains extra columns or non-standard headers (starting with `#`), use the `alt` family type:
```bash
ped_parser input.ped --family_type alt
```

## Data Standards and Validation

### Standard PED Columns
The tool expects the first six columns to follow the standard PED format:
1.  **Family ID**
2.  **Individual ID**
3.  **Paternal ID** (0 or . for unknown)
4.  **Maternal ID** (0 or . for unknown)
5.  **Sex** (1=male; 2=female; 0/.=unknown)
6.  **Phenotype** (1=unaffected; 2=affected; 0/-9/.=missing)

### Special Metadata Columns
When using alternative formats or preparing for Madeline2, `ped_parser` recognizes specific column names in the header:
*   **InheritanceModel**: A semicolon-separated list (e.g., `AR;AD`).
*   **Proband**: 'Yes', 'No', or 'Unknown'.
*   **Consultand**: 'Yes', 'No', or 'Unknown'.
*   **Alive**: 'Yes', 'No', or 'Unknown'.

## Expert Tips
*   **Automated Checks**: The parser automatically raises exceptions if the number of columns differs between individuals or if a parent's gender is biologically inconsistent with their role (e.g., a father marked as female).
*   **Trio Identification**: Use the tool to automatically identify all trios (mother-father-child) or duos within a large pedigree file.
*   **Python Integration**: For complex workflows, the `Family` and `Individual` classes can be imported directly into Python scripts to build pedigrees programmatically before exporting them to `.ped` or `.json`.

## Reference documentation
- [ped_parser GitHub Repository](./references/github_com_moonso_ped_parser.md)
- [ped_parser Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ped_parser_overview.md)