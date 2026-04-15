---
name: skyline2isocor
description: The skyline2isocor tool converts Skyline transition results into the specific tab-delimited format required for IsoCor metabolic flux analysis. Use when user asks to reformat Skyline exports for isotope natural abundance correction, convert peak area data for IsoCor, or automate metabolic flux data preparation.
homepage: https://pypi.org/project/skyline2isocor/
metadata:
  docker_image: "quay.io/biocontainers/skyline2isocor:1.0.0--pyhdfd78af_0"
---

# skyline2isocor

## Overview
The `skyline2isocor` tool serves as a specialized data converter for metabolic flux analysis. It automates the reformatting of Skyline's transition results—which typically contain peak areas and precursor/product ion information—into the structured tab-delimited format that IsoCor expects. This eliminates the need for manual spreadsheet manipulation and reduces errors in isotope natural abundance correction.

## Usage Guidelines

### Data Preparation in Skyline
Before using this tool, ensure your Skyline export contains the necessary columns. The converter typically expects:
- Molecule Name / Compound
- Isotope Label Type
- Precursor Mz
- Product Mz
- Retention Time
- Area / Peak Area

### Basic Command Line Execution
Run the converter by specifying the input file exported from Skyline and the desired output path for IsoCor:

```bash
skyline2isocor input_skyline_file.csv output_isocor_file.tsv
```

### Best Practices
- **File Formats**: While Skyline often exports to `.csv`, IsoCor generally prefers `.tsv`. Ensure your output extension matches your downstream configuration.
- **Column Mapping**: If the tool fails to recognize headers, verify that your Skyline export settings use the "Standard" column naming convention rather than custom aliases.
- **Isotope Patterns**: Ensure all isotopologues (M+0, M+1, etc.) for a given metabolite are exported together to allow IsoCor to perform accurate distributional corrections.

## Reference documentation
- [skyline2isocor Project Overview](./references/pypi_org_project_skyline2isocor.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_skyline2isocor_overview.md)