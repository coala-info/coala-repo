---
name: seqspec
description: The `seqspec` tool provides a standardized framework for defining the architecture of genomic libraries.
homepage: https://github.com/sbooeshaghi/seqspec
---

# seqspec

## Overview
The `seqspec` tool provides a standardized framework for defining the architecture of genomic libraries. It allows researchers to specify the exact sequence of adapters, barcodes, and cDNA/genomic inserts within a read. This skill enables the precise management of these specifications, ensuring that downstream processing tools (like aligners or mappers) receive accurate information about the library's physical structure.

## Core CLI Patterns

### Validation and Inspection
Before using a specification in a pipeline, always validate its syntax and structure.
- **Validate a file**: `seqspec check spec.yaml`
- **Print a summary**: `seqspec info spec.yaml` (provides a high-level overview of the assay and regions)

### Visualization
Visualizing the library structure helps verify that the sequence of elements (barcodes, linkers, etc.) matches the experimental design.
- **Generate a diagram**: `seqspec draw spec.yaml` (creates a visual representation of the library architecture)

### Data Extraction and Formatting
`seqspec` can extract specific sequence information required by other tools.
- **Get sequence patterns**: `seqspec format -f [FORMAT] spec.yaml` (useful for generating input strings for tools like `kb-python` or `starsolo`)
- **Extract specific regions**: Use `seqspec index` to identify the coordinates of specific features within the read structure.

### Modification
- **Update metadata**: Use `seqspec modify` to update fields like the assay name, version, or DOI without manually editing the YAML.

## Expert Tips
- **Standardization**: Always use the `seqspec check` command after manual edits to ensure the YAML schema remains compliant.
- **Pipeline Integration**: Use the output of `seqspec format` to programmatically feed read structures into mapping tools, reducing manual entry errors for complex barcode/UMI arrangements.
- **Version Control**: Treat `.yaml` seqspec files as code; track them in git alongside your analysis scripts to ensure reproducibility of the data processing steps.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pachterlab_seqspec.md)
- [Bioconda Package and Installation](./references/anaconda_org_channels_bioconda_packages_seqspec_overview.md)