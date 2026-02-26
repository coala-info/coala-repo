---
name: airr
description: The airr tool facilitates the standardized handling, validation, and conversion of immune repertoire data according to AIRR Community schemas. Use when user asks to validate rearrangement files, read or write AIRR-compliant TSV data, or access schema definitions for V(D)J sequence analysis.
homepage: http://docs.airr-community.org
---


# airr

## Overview
The `airr` skill facilitates the standardized handling of immune repertoire data. It focuses on the implementation of the AIRR Community's data schemas, ensuring interoperability between different bioinformatics tools. This skill is essential for researchers performing V(D)J sequence analysis who need to validate data formats, convert between representations, or interface with global AIRR-seq repositories.

## Core Workflows

### Data Validation
The primary utility of the `airr` tool is ensuring data compliance. Use the following patterns to validate Rearrangement TSV files:

- **Command Line Validation**:
  `airr-tools validate rearrangement -i input_data.tsv`
- **Python Validation**:
  ```python
  import airr
  valid = airr.validate_rearrangement('data.tsv')
  ```

### Reading and Writing AIRR Data
Always use the library's native functions to handle the specific TSV formatting requirements (such as header requirements and null value handling) defined by the standard.

- **Python (Reading)**:
  ```python
  import airr
  reader = airr.read_rearrangement('input.tsv')
  for row in reader:
      # Process row as a dictionary
      print(row['sequence_id'])
  ```
- **Python (Writing)**:
  ```python
  import airr
  # data is a list of dictionaries
  airr.write_rearrangement('output.tsv', data)
  ```

### Schema Access
When building custom analysis scripts, reference the schema objects directly to ensure field names and types match the standard.
- Use `airr.load_schema('Rearrangement')` to inspect required fields and definitions.

## Best Practices
- **Field Naming**: Always use the snake_case names defined in the AIRR Schema (e.g., `v_call`, `junction_aa`) rather than tool-specific aliases.
- **Missing Data**: Represent missing values as empty strings in TSV files, which the `airr` library interprets correctly as `None` in Python.
- **Versioning**: When generating new datasets, ensure the `airr_version` is specified in the metadata to maintain compatibility with downstream tools.

## Reference documentation
- [AIRR Standards Documentation](./references/docs_airr-community_org_en_stable.md)
- [Bioconda AIRR Package Overview](./references/anaconda_org_channels_bioconda_packages_airr_overview.md)