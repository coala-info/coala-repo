---
name: sbml2metexplorejsongraph
description: Converts Systems Biology Markup Language (SBML) files into a JSON graph format compatible with MetExploreJS. Use when user asks to convert SBML to MetExploreJS JSON or visualize SBML models in MetExploreJS.
homepage: https://github.com/bmerlet90/tool-SBML2MetexploreJsonGraph
metadata:
  docker_image: "biocontainers/sbml2metexplorejsongraph:phenomenal-v1.2_cv1.1.7"
---

# sbml2metexplorejsongraph

Converts Systems Biology Markup Language (SBML) files into a JSON graph format compatible with MetExploreJS.
  Use this skill when you have an SBML model and need to visualize or analyze it using MetExploreJS, or when you need to convert SBML to a graph-based JSON representation for other tools.
---
## Overview

This skill provides a command-line tool to convert Systems Biology Markup Language (SBML) files into a JSON graph format. This JSON output is specifically designed to be compatible with MetExploreJS, a JavaScript library for visualizing and interacting with biological networks. Use this tool when you need to transform your SBML models into a format suitable for web-based visualization and analysis within the MetExplore ecosystem.

## Usage Instructions

The `sbml2metexplorejsongraph` tool is designed for command-line execution. It takes an SBML file as input and outputs a JSON file representing the metabolic network.

### Basic Conversion

The most common usage involves specifying the input SBML file and the desired output JSON file.

```bash
sbml2metexplorejsongraph -i <input_sbml_file.xml> -o <output_json_file.json>
```

**Arguments:**

*   `-i` or `--input`: Path to the input SBML file.
*   `-o` or `--output`: Path where the generated JSON file will be saved.

### Advanced Options

The tool offers additional options to customize the conversion process.

#### Including Flux Data

By default, the tool may convert flux data into reaction mappings. If you wish to control this behavior, use the following argument:

```bash
sbml2metexplorejsongraph -i <input_sbml_file.xml> -o <output_json_file.json> --convertFluxData <true|false>
```

*   `--convertFluxData`: Set to `true` to include flux data in reaction mappings, or `false` to exclude it. The default behavior might vary based on the tool's version or specific SBML content. It's recommended to explicitly set this if you have specific requirements.

### Expert Tips

*   **File Paths:** Ensure that the input SBML file path and the output directory for the JSON file are correctly specified. Relative or absolute paths are acceptable.
*   **SBML Version Compatibility:** While the tool aims for broad compatibility, very old or non-standard SBML files might require pre-processing or may not convert perfectly. Refer to the tool's documentation or GitHub repository for supported SBML levels and versions if you encounter issues.
*   **Error Handling:** If the conversion fails, check the console output for specific error messages. Common issues include incorrect file paths, malformed SBML, or unsupported SBML features.
*   **Output Verification:** After conversion, it's good practice to inspect the generated JSON file to ensure it contains the expected network structure and data before loading it into MetExploreJS.

## Reference documentation
- [GitHub Repository](https://github.com/bmerlet90/tool-SBML2MetexploreJsonGraph)