---
name: cgview
description: Generates high-quality, zoomable maps of circular genomes. Use when user asks to create visual representations of genomic data for sequence annotation pipelines or web-based visualization.
homepage: http://wishart.biology.ualberta.ca/cgview/
metadata:
  docker_image: "quay.io/biocontainers/cgview:1.0--py35pl5.22.0_1"
---

# cgview

yaml
name: cgview
description: Generates high-quality, zoomable maps of circular genomes. Use when you need to create visual representations of genomic data for sequence annotation pipelines or web-based visualization.
```

## Overview

The CGView tool is designed to create visually appealing and interactive maps of circular genomes. It's particularly useful as a component within bioinformatics pipelines, allowing for the generation of output suitable for web display. If you have genomic sequence data and need to visualize it in a circular format, CGView is the tool for the job.

## Usage Instructions

CGView is a Java package. To use it, you will typically invoke it from the command line.

### Basic Usage

The fundamental command structure involves specifying input files and output options.

```bash
cgview [options] -i <input_file> -o <output_directory>
```

### Key Options

*   `-i <input_file>`: Specifies the input file containing the genomic data. This is often in a format like GenBank or GFF.
*   `-o <output_directory>`: The directory where the generated map files will be saved.
*   `--format <format>`: Specifies the output format. Common formats include `html` for interactive web maps and `png` for static images.
*   `--config <config_file>`: Allows you to provide a configuration file to customize various aspects of the map, such as colors, labels, and feature visibility.
*   `--title <title>`: Sets the title for the genome map.

### Expert Tips

*   **Configuration is Key**: For detailed customization, create a `.conf` file. This allows fine-grained control over the appearance of your genome map, including feature colors, label styles, and the display of different data tracks. Refer to the CGView documentation for the full range of configuration options.
*   **Input Data Formats**: Ensure your input data is in a supported format. GenBank (`.gbk`, `.gb`) and GFF (`.gff`, `.gff3`) are commonly used.
*   **Interactive HTML Output**: When generating HTML output, CGView creates zoomable and pannable maps, which are excellent for web-based exploration of genomic data.
*   **Batch Processing**: For generating maps for multiple genomes, consider scripting your CGView calls using a shell script or workflow manager.

## Reference documentation

- [CGView Overview](./references/anaconda_org_channels_bioconda_packages_cgview_overview.md)