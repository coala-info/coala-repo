---
name: fsnviz
description: "fsnviz automates the creation of Circos plots to visualize gene fusion events from genomic data. Use when user asks to visualize gene fusions, generate Circos plots for fusion-calling results, or map genomic rearrangements from STAR-Fusion or FusionCatcher output."
homepage: https://github.com/bow/fsnviz
---


# fsnviz

## Overview
`fsnviz` is a Python-based utility that automates the creation of Circos plots to represent gene fusion events. It acts as a bridge between fusion-calling software and the Circos visualization engine, parsing complex hit tables and generating high-quality SVG images that map fusions across the genome. This skill should be used when you need to provide a visual summary of genomic rearrangements or validate fusion candidates in a spatial context.

## Installation and Requirements
Before running `fsnviz`, ensure the environment has the necessary dependencies:
- **Circos**: Must be installed separately and available in the system PATH.
- **Python**: Compatible with versions 3.5 and 3.6.
- **Installation**: Use `conda install -c bioconda fsnviz` or `pip install fsnviz`.

## Command Line Usage
The tool uses a subcommand structure based on the input source.

### Basic Execution
To generate a plot from a STAR-Fusion or FusionCatcher result file:

```bash
# For STAR-Fusion hits table
fsnviz star-fusion path/to/star-fusion.fusion_predictions.abridged.tsv

# For FusionCatcher final table
fsnviz fusioncatcher path/to/final-list_candidate-fusion-genes.txt
```

### Common Configuration Flags
- `--output-dir <dir>`: Specifies where to save the generated files. The directory will be created if it does not exist.
- `--base-name <name>`: Sets the prefix for output files (default is `fsnviz`).
- `--karyotype <type>`: Defines the reference genome. Currently supports `human.hg19` (default) and `human.hg38`.
- `--circos-conf <file>`: Allows the use of a custom Circos configuration file to override default styling.

## Expert Tips and Best Practices
- **Karyotype Matching**: Always ensure the `--karyotype` flag matches the reference genome used during the alignment/fusion-calling step (e.g., use `human.hg38` if STAR-Fusion was run against GRCh38).
- **Output Management**: By default, `fsnviz` writes to the current directory. Use `--output-dir` to prevent cluttering your workspace, as Circos generates several intermediate configuration files during the plotting process.
- **Custom Styling**: If the default plot labels are too large or small, you can provide a modified template via the `--circos-conf` flag. The tool's default label sizes were optimized in version 0.3.0, but high-density fusion samples may still require manual adjustment.
- **Dependency Check**: If the tool fails to produce an SVG, verify that the `circos` command is executable from your terminal, as `fsnviz` wraps this external binary.

## Reference documentation
- [fsnviz GitHub Repository](./references/github_com_bow_fsnviz.md)
- [Bioconda fsnviz Overview](./references/anaconda_org_channels_bioconda_packages_fsnviz_overview.md)