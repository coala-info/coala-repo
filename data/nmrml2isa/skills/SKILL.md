---
name: nmrml2isa
description: The nmrml2isa tool converts nmrML files into the ISA-Tab metadata format by extracting experimental parameters and metadata. Use when user asks to generate ISA-Tab studies from nmrML files, extract metadata from NMR data, or convert nmrML to ISA-Tab format.
homepage: http://github.com/ISA-tools/nmrml2isa
---


# nmrml2isa

## Overview

The `nmrml2isa` tool is a specialized parser designed to bridge the gap between the nmrML (Nuclear Magnetic Resonance Markup Language) format and the ISA-Tab (Investigation/Study/Assay) metadata standard. It extracts experimental parameters and metadata from .nmrML files to automatically generate the structural files required for an ISA-Tab investigation. This provides a standardized backbone that can be further refined using ISA-Tab editors like the ISA Creator.

## Installation

The tool is primarily distributed via Bioconda:

```bash
conda install bioconda::nmrml2isa
```

## Command Line Usage

### Standard Study Generation
To generate an ISA-Tab study from a directory of nmrML files, use the following pattern:

```bash
nmrml2isa -i /path/to/nmrml_files/ -o /path/to/out_folder -s study_identifier
```

### Adding Custom Metadata
You can inject additional user metadata during the parsing process using the `-m` flag. This accepts either a path to a JSON file or a raw JSON string:

```bash
# Using a JSON file
nmrml2isa -i ./data -o ./isa_out -s MyStudy -m ./metadata.json

# Using a JSON string
nmrml2isa -i ./data -o ./isa_out -s MyStudy -m '{"author": "John Doe", "institution": "University X"}'
```

### Metadata Extraction (JSON Only)
If you only need to inspect the metadata extracted from an nmrML file without generating the full ISA-Tab structure, run the module directly:

```bash
python -m nmrml2isa.nmrml /path/to/file.nmrML
```
This outputs a JSON dictionary containing all extracted metadata to the console.

### Quiet Mode
For use in automated pipelines where console output should be minimized:

```bash
nmrml2isa -i ./data -o ./isa_out -s MyStudy --quiet
```

## Python API Integration

For more complex workflows, `nmrml2isa` can be imported as a Python module.

### Full Parsing
```python
from nmrml2isa import parsing

in_dir = "/path/to/nmrml_files/"
out_dir = "/path/to/out_folder/"
study_id = "my_study_01"

parsing.full_parse(in_dir, out_dir, study_id)
```

### Direct Metadata Access
To access metadata as a Python dictionary for programmatic manipulation:

```python
from nmrml2isa import nmrml

nmrml_path = "/path/to/file.nmrML"
nmrml_meta = nmrml.nmrMLmeta(nmrml_path)

# Access as Python dictionary
print(nmrml_meta.meta)

# Access as JSON string
print(nmrml_meta.meta_json)
```

## Expert Tips
- **Directory Structure**: Ensure the input directory contains only valid .nmrML files to avoid parsing errors.
- **Study Identifiers**: Choose unique study identifiers (`-s`) to prevent overwriting existing ISA-Tab investigations in the output folder.
- **Post-Processing**: The generated ISA-Tab files are a "backbone." Always validate and supplement them with experimental details (like factor values or protocols) that may not be present in the raw nmrML files.

## Reference documentation
- [nmrml2isa GitHub Repository](./references/github_com_ISA-tools_nmrml2isa.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nmrml2isa_overview.md)