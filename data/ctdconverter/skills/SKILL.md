---
name: ctdconverter
description: The ctdconverter tool transforms CTD files into functional wrappers for workflow platforms like Galaxy. Use when user asks to convert CTD files to Galaxy XML wrappers, perform batch conversion of tool definitions, or generate tool configuration files.
homepage: https://github.com/WorkflowConversion/CTDConverter
---


# ctdconverter

## Overview
The `ctdconverter` skill enables the transformation of CTD files—which describe the inputs, outputs, and parameters of a tool—into functional wrappers for workflow platforms. This process eliminates the need to manually write complex XML wrappers for Galaxy. By leveraging this tool, you can ensure that tool definitions remain consistent across different execution environments while automating the generation of necessary configuration files like `tool_conf.xml`.

## Installation and Environment
To ensure proper XML validation and dependency management, use a dedicated Conda environment:

```bash
conda create --name ctd-converter
source activate ctd-converter
conda install --channel workflowconversion ctdopts
conda install lxml
conda install --channel conda-forge ruamel.yaml
# Specific version required for reliable XML schema validation
conda install libxml2=2.9.2
```

## Core CLI Usage
The primary entry point is `convert.py`. The basic syntax requires specifying the target format followed by input and output parameters.

### Converting a Single File
To convert one CTD file into a Galaxy XML wrapper:
```bash
python convert.py galaxy -i input_tool.ctd -o output_wrapper.xml
```

### Batch Conversion
When processing multiple files, the output destination must be an existing directory. The tool will automatically name the output files based on the input filenames.
```bash
# Using explicit file lists
python convert.py galaxy -i tool1.ctd tool2.ctd -o ./converted_wrappers/

# Using wildcard expansion
python convert.py galaxy -i ./ctds/*.ctd -o ./wrappers/
```

## Galaxy-Specific Features
When using the `galaxy` format, the tool provides additional functionality for managing tool integration:

- **Tool Configuration**: Only the Galaxy converter supports the generation of a `tool_conf.xml` file to help organize the converted tools within the Galaxy interface.
- **Validation**: It is highly recommended to validate input CTDs against their schema during conversion to prevent malformed wrappers.

## Best Practices
- **Output Consistency**: Always ensure the output directory exists before running batch conversions, as the script expects a valid path for multiple inputs.
- **Fail Policy**: Be aware that the converter uses a "fail-fast" policy. If one CTD in a batch is invalid or missing a support file, the entire process will terminate with an error code.
- **Dependency Versioning**: If you encounter XML validation errors, verify that `libxml2` is at version 2.9.2, as newer versions (like 2.9.4) have known bugs regarding schema validation.

## Reference documentation
- [CTDConverter Main Documentation](./references/github_com_WorkflowConversion_CTDConverter.md)