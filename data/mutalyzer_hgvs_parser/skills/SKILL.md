---
name: mutalyzer_hgvs_parser
description: "Parses HGVS variant descriptions into a structured dictionary model. Use when user asks to parse HGVS variant descriptions."
homepage: The package home page
---


# mutalyzer_hgvs_parser

yaml
name: mutalyzer_hgvs_parser
description: |
  Parses HGVS variant descriptions into a structured dictionary model.
  Use this skill when you need to programmatically analyze, validate, or extract information from HGVS variant strings.
  This is particularly useful for bioinformatics pipelines, variant annotation, or data processing where HGVS nomenclature needs to be understood and manipulated.
```
## Overview
The `mutalyzer_hgvs_parser` tool is designed to take Human Genome Variation Society (HGVS) variant descriptions and convert them into a structured dictionary format. This allows for easier programmatic access to the details of a variant, such as its reference sequence, coordinate system, and the specific changes described. It's ideal for tasks requiring automated parsing and interpretation of genetic variations.

## Usage Instructions

The `mutalyzer_hgvs_parser` can be used both as a command-line tool and as a Python library.

### Command Line Interface (CLI)

The primary CLI command is `mutalyzer_hgvs_parser`.

**Basic Parsing:**

To parse a single HGVS description and output its model representation:

```bash
mutalyzer_hgvs_parser -c "NG_012337.1:c.20del"
```

This command will output a JSON-like dictionary representing the parsed variant.

**Key Options:**

*   `-c` or `--description`: Specifies the HGVS variant description string to parse.

### Python Library Usage

The `to_model()` function from the `mutalyzer_hgvs_parser` library can be used within Python scripts.

**Example:**

```python
from mutalyzer_hgvs_parser import to_model

hgvs_description = "NG_012337.1:c.20del"
parsed_model = to_model(hgvs_description)

# Accessing information from the model
reference_id = parsed_model['reference']['id']
coordinate_system = parsed_model['coordinate_system']
variant_type = parsed_model['variants'][0]['type']

print(f"Reference: {reference_id}")
print(f"Coordinate System: {coordinate_system}")
print(f"Variant Type: {variant_type}")
```

### Expert Tips

*   **Multiple Variants:** The parser can handle HGVS descriptions with multiple variants, though the CLI example focuses on a single variant for clarity. The output model will reflect all variants present.
*   **Deviations:** The tool supports common deviations from strict HGVS guidelines, making it robust for real-world data.
*   **Programmatic Access:** The dictionary output is designed for easy integration into bioinformatics pipelines. You can iterate through the `variants` list to process each described change.
*   **Error Handling:** Be prepared to handle potential parsing errors if the input HGVS string is malformed or ambiguous. The library or CLI will typically indicate such issues.

## Reference documentation
- [Mutalyzer HGVS variant description parser Overview](./references/anaconda_org_channels_bioconda_packages_mutalyzer_hgvs_parser_overview.md)
- [HGVS variant description parser](./references/github_com_mutalyzer_hgvs-parser.md)