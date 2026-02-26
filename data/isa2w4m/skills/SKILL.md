---
name: isa2w4m
description: "Converts ISA study metadata into the 3 TSV file format required by Workflow4Metabolomics. Use when user asks to convert ISA metadata to Workflow4Metabolomics format."
homepage: https://github.com/workflow4metabolomics/isa2w4m
---


# isa2w4m

Converts ISA (Investigation, Study, Assay) study metadata into the 3 TSV file format required by Workflow4Metabolomics (W4M).
  Use this skill when you have ISA-compliant metadata files (typically in JSON or XML format) and need to transform them into the specific TSV structure expected by W4M for downstream analysis.
  This is particularly useful for metabolomics studies that follow the ISA-TAB standard.
---
## Overview

The `isa2w4m` tool is designed to bridge the gap between ISA-compliant metadata and the specific input requirements of Workflow4Metabolomics (W4M). It takes ISA study metadata, which can be in various formats like JSON or XML, and converts it into the three essential TSV (Tab-Separated Values) files that W4M uses for data processing and analysis. This is crucial for researchers working with metabolomics data who need to ensure their experimental metadata is correctly formatted for W4M pipelines.

## Usage Instructions

The `isa2w4m` tool is primarily used via its command-line interface. The core functionality involves specifying the input ISA metadata file and the desired output directory.

### Basic Conversion

To convert an ISA study into the W4M TSV format, use the following command structure:

```bash
isa2w4m --input <path_to_isa_metadata_file> --output <path_to_output_directory>
```

-   `--input`: Specifies the path to your ISA metadata file. This can be an ISA-JSON file or an ISA-XML file.
-   `--output`: Specifies the directory where the three W4M TSV files (usually `samples.tsv`, `assays.tsv`, and `investigation.tsv`) will be generated.

### Example

If your ISA metadata is in a file named `study.json` and you want the output TSV files in a directory called `w4m_output`, you would run:

```bash
isa2w4m --input study.json --output w4m_output
```

### Important Notes:

*   **Input Formats**: Ensure your input file adheres to the ISA-tab or ISA-JSON specification. The tool is designed to parse these formats.
*   **Output Files**: The tool will generate three TSV files within the specified output directory. These files are essential for W4M.
*   **Error Handling**: If the input file is malformed or not in a recognized ISA format, `isa2w4m` will likely produce an error message. Review the error output to identify and correct issues with your input metadata.
*   **Dependencies**: Ensure that `isa2w4m` and its dependencies (like `isatools`) are correctly installed in your environment.

## Reference documentation

- [README](./references/github_com_workflow4metabolomics_isa2w4m.md)