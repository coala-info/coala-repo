---
name: circos
description: Generates circular visualizations of data for genomics, bioinformatics, and other scientific fields. Use when Claude needs to create complex, circular plots to represent relationships, genomic data, or network structures.
homepage: http://circos.ca
metadata:
  docker_image: "quay.io/biocontainers/circos:0.69.9--hdfd78af_0"
---

# circos

Generates circular visualizations of data for genomics, bioinformatics, and other scientific fields.
  Use when Claude needs to create complex, circular plots to represent relationships, genomic data, or network structures.
  This skill is specifically for the Circos command-line tool.
---
## Overview

The Circos tool is designed for creating sophisticated circular visualizations of data. It's particularly powerful for representing genomic data, such as gene locations, rearrangements, and comparative genomics, as well as network structures and other relational data in a visually intuitive circular format. This skill focuses on guiding you through the command-line usage of Circos to generate these specialized plots.

## Usage Instructions

Circos is primarily configured and run via a configuration file. The general workflow involves preparing your data files and then invoking the `circos` command with your configuration.

### Core Concepts

1.  **Configuration File (`.conf`)**: This is the heart of Circos. It defines the layout, data sources, visual elements, and styling of your circular plot.
2.  **Data Files**: Circos reads data from various text-based file formats (e.g., tab-delimited, space-delimited) that you specify in the configuration file.
3.  **Image Output**: Circos generates output as image files (e.g., SVG, PNG).

### Basic Command Structure

The fundamental command to run Circos is:

```bash
circos -conf <your_config_file.conf> -outputfile <output_image_name.svg>
```

### Key Configuration Elements (Common Patterns)

While the full configuration can be extensive, here are some common and essential elements you'll encounter:

*   **`karyotype`**: Defines the main circular ideograms (e.g., chromosomes). You'll need a karyotype file that lists the chromosomes and their sizes.
    *   **Example**: `karyotype = data/karyotype/karyotype.human.txt`
*   **`chromosomes_units`**: Sets the units for chromosome lengths (e.g., `bands` for ideogram bands, `mm` for millimeters).
    *   **Example**: `chromosomes_units = bands`
*   **`chromosomes`**: Specifies the order and display of chromosomes.
    *   **Example**: `chromosomes = hs1;hs2;hs3;hs4;hs5;hs6;hs7;hs8;hs9;hs10;hs11;hs12;hs13;hs14;hs15;hs16;hs17;hs18;hs19;hs20;hs21;hs22;X;Y`
*   **`<ideogram>` block**: Controls the appearance of the chromosome ideograms.
    *   **Example**:
        ```conf
        <ideogram>
            <spacing>
                gap = 0.025r
            </spacing>
            thickness = 20p
            fill_color = blue
        </ideogram>
        ```
*   **`<table>` blocks**: Define data tracks (e.g., links, heatmaps, scatter plots) that overlay the ideograms. Each table block specifies the data file, its format, and how it should be rendered.
    *   **Example for links**:
        ```conf
        <links>
            file = data/links/example.txt
            radius = 0.85r
            bezier_radius = 0.2r
            color = vdred
            stroke_thickness = 1
            <link>
                file = data/links/example.txt
                ribbon_radius = 0.85r
                bezier_radius = 0.2r
                color = blue
                stroke_thickness = 1
            </link>
        </links>
        ```
*   **`show_legend`**: Controls whether a legend is displayed.
    *   **Example**: `show_legend = yes`

### Expert Tips

*   **Start with Examples**: Circos comes with many example configuration files and data. Study these (`examples/` directory) to understand how different plot types are constructed.
*   **Data Preparation is Crucial**: Ensure your input data files are correctly formatted and aligned with the expectations of your configuration. Common issues arise from incorrect delimiters, missing columns, or inconsistent chromosome naming.
*   **Incremental Configuration**: Build your configuration file incrementally. Start with a basic karyotype, then add one data track at a time, testing the output at each stage.
*   **Units (`r`, `p`, `u`)**: Understand the different units used in Circos configuration:
    *   `r`: Relative to the radius of the plot.
    *   `p`: Pixels.
    *   `u`: User-defined units (often used for specific data scales).
*   **Debugging**: If your plot doesn't render as expected, check:
    *   The `circos` command's error output.
    *   The syntax of your `.conf` file (typos are common).
    *   The format and content of your data files.
    *   The `debug` option in the configuration (e.g., `debug = yes`) can sometimes provide more verbose output.

## Reference documentation

*   [Circos Homepage](http://circos.ca)
*   [Anaconda.org Circos Overview](./references/anaconda_org_channels_bioconda_packages_circos_overview.md)