---
name: samshee
description: Samshee is a schema-agnostic parser and writer for Illumina Sample Sheet v2 and similar sectioned CSV documents. Use when user asks to validate sample sheet formatting, programmatically update run metadata, or check barcode index distances.
homepage: https://github.com/lit-regensburg/samshee
metadata:
  docker_image: "quay.io/biocontainers/samshee:0.2.13--pyhdfd78af_0"
---

# samshee

## Overview
Samshee is a schema-agnostic parser and writer designed specifically for Illumina Sample Sheet v2 and similar sectioned documents. It bridges the gap between raw CSV manipulation and strict Illumina compliance by providing a structured way to handle "Header", "Reads", and "Application" sections (like BCLConvert). Use this skill to ensure sample sheets are formatted correctly before sequencing runs, to programmatically update run metadata, or to perform complex validations like checking minimal Hamming distance between barcodes.

## CLI Usage and Best Practices

### Validation and Linting
The simplest way to use samshee is as a linter to verify that a sample sheet adheres to Illumina's v2 specifications.
```bash
# Validate a sample sheet and see the normalized output
python -m samshee SampleSheet.csv

# Format and normalize a sample sheet (standardizes quoting and section headers)
python -m samshee SampleSheet.csv > SampleSheet_normalized.csv
```

### Error Handling
If a sample sheet is invalid, samshee will raise a `SamsheeValidationException`. Common triggers include:
- Missing required fields in the `[Header]` section.
- Incorrectly formatted `[Reads]` settings.
- Index collisions or insufficient distance in `[BCLConvert_Data]`.

## Python API Integration

### Reading and Modifying Sheets
For programmatic updates (e.g., changing a Run Name or adding samples), use the `samplesheetv2` module.

```python
from samshee.samplesheetv2 import read_samplesheetv2

# Load the sheet
sheet = read_samplesheetv2("SampleSheet.csv")

# Modify Header metadata
sheet.header['RunName'] = 'New_Project_Alpha'

# Access Application data (e.g., BCLConvert)
# Data sections are handled as lists of dictionaries
for row in sheet.applications['BCLConvert']['data']:
    if row['Sample_ID'] == 'Sample1':
        row['Index'] = 'ATGCATGC'

# Write back to file
with open("SampleSheet_updated.csv", "w") as fh:
    sheet.write(fh)
```

### Advanced Validation Logic
Samshee allows for custom validation functions. This is highly recommended for core facility pipelines to enforce internal naming conventions or specific index distance requirements.

```python
import samshee.validation
from samshee.samplesheetv2 import read_samplesheetv2

# Load with standard Illumina logic plus a custom index distance check (e.g., distance of 3)
validators = [
    samshee.validation.illuminasamplesheetv2schema,
    samshee.validation.illuminasamplesheetv2logic,
    lambda doc: samshee.validation.check_index_distance(doc, 3)
]

try:
    sheet = read_samplesheetv2("SampleSheet.csv", validation=validators)
except samshee.validation.SamsheeValidationException as e:
    print(f"Validation failed: {e}")
```

## Expert Tips
- **SectionedSheet vs SampleSheetV2**: Use `SectionedSheet` for generic ini-like CSV files that don't follow Illumina specs. Use `SampleSheetV2` for standard Illumina files to benefit from built-in application logic.
- **Application Sections**: Remember that in v2, sections like `[BCLConvert_Settings]` and `[BCLConvert_Data]` are grouped under the "BCLConvert" application.
- **Index Normalization**: Samshee handles the conversion of indices to uppercase and validates UMIs within index fields automatically in recent versions.
- **Minimal Quoting**: The tool uses minimal quoting by default for better compatibility with various Illumina software versions.

## Reference documentation
- [Samshee GitHub Repository](./references/github_com_lit-regensburg_samshee.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_samshee_overview.md)