---
name: cdk-inchi-to-svg
description: This tool converts InChI strings into SVG images to provide visual representations of chemical structures. Use when user asks to render chemical structures from InChI strings, generate SVG files for metabolites, or create high-resolution chemical diagrams for publications.
homepage: https://github.com/ipb-halle/cdk-inchi-to-svg
---


# cdk-inchi-to-svg

## Overview

The `cdk-inchi-to-svg` tool is a specialized Java-based utility that leverages the Chemistry Development Kit (CDK) to render chemical structures. It provides a lightweight, command-line interface for converting complex InChI strings into scalable vector graphics (SVG). This tool is particularly valuable for researchers who need to programmatically generate visual representations of metabolites or chemical compounds for publications, web interfaces, or database records.

## Installation

The most reliable way to install the tool is via Bioconda:

```bash
conda install bioconda::cdk-inchi-to-svg
```

## Command Line Usage

### Basic Syntax
The tool requires the InChI string as the first argument and the desired output filename as the second.

```bash
java -jar cdk-inchi-to-svg-0.9-SNAPSHOT-jar-with-dependencies.jar '<InChI_String>' <output_file.svg>
```

### Docker Execution
If Java is not locally configured, use the official Docker container. Ensure you mount the current working directory to allow the container to write the output file.

```bash
docker run -v $(pwd):$(pwd) -w $(pwd) -ti ipb-halle/cd-inchi-to-svg '<InChI_String>' <output_file.svg>
```

## Best Practices and Expert Tips

- **Quote InChI Strings**: Always wrap InChI strings in single quotes (`'`). InChI strings contain characters like `/`, `=`, and `;` which can be misinterpreted by the shell as path delimiters or command separators.
- **Batch Processing**: For large datasets, use a shell loop to process multiple identifiers. Since the tool is a JAR file, the JVM startup overhead exists; for massive batches, consider grouping identifiers if using a wrapper script.
- **SVG Advantages**: Use the SVG output for high-resolution needs. Unlike PNG or JPEG, SVG files can be scaled infinitely without losing clarity, making them ideal for academic posters and responsive web design.
- **Validation**: Before conversion, ensure the InChI string is valid. The tool relies on the CDK library; if an InChI is malformed, the rendering may fail or produce an empty/error graphic.
- **Environment**: When using the JAR directly, ensure you have a Java Runtime Environment (JRE) installed. The "with-dependencies" version of the JAR is preferred as it includes the necessary CDK libraries.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cdk-inchi-to-svg_overview.md)
- [GitHub Repository and Usage Guide](./references/github_com_ipb-halle_cdk-inchi-to-svg.md)