---
name: fsnviz
description: FsnViz is a command-line utility that generates Circos plots to visualize RNA-seq gene fusion events from tabular data. Use when user asks to create genomic maps of gene fusions, visualize STAR-Fusion or FusionCatcher results, or generate SVG plots of chromosomal translocations.
homepage: https://github.com/bow/fsnviz
metadata:
  docker_image: "quay.io/biocontainers/fsnviz:0.3.0--py35_1"
---

# fsnviz

## Overview

FsnViz is a Python-based command-line utility that automates the creation of Circos plots to represent RNA-seq gene fusion events. It acts as a wrapper that parses the output tables from popular fusion-finding algorithms and generates the necessary configuration files to produce SVG visualizations. This skill is essential when you need to move from raw tabular fusion data to a publication-ready genomic map showing translocations and breakpoints across the human genome.

## Command Line Usage

The basic syntax for fsnviz requires specifying the source tool and the path to the result file:

```bash
fsnviz <tool-name> <path-to-result-file>
```

### Supported Input Formats

- **STAR-Fusion**: Use the `star-fusion` command for the `star-fusion.fusion_predictions.tsv` or hits table.
- **FusionCatcher**: Use the `fusioncatcher` command for the `final-list_candidate-fusion-genes.txt` file.

### Common CLI Patterns

**Basic Visualization:**
Generates `fsnviz.svg` in the current directory using hg19 coordinates.
```bash
fsnviz star-fusion path/to/star-fusion.predictions.tsv
```

**Specifying Genome Build and Output:**
Use the `--karyotype` flag to match your alignment reference (hg19 or hg38).
```bash
fsnviz fusioncatcher path/to/fusioncatcher_results.txt \
    --karyotype human.hg38 \
    --output-dir ./visualizations \
    --base-name patient_sample_01
```

**Customizing Plot Appearance:**
If you need to override the default templates (e.g., for specific colors or track layouts), provide a custom Circos configuration.
```bash
fsnviz star-fusion predictions.tsv --circos-conf custom_circos.conf
```

## Expert Tips and Best Practices

- **Circos Dependency**: fsnviz is a wrapper; ensure `circos` (specifically version 0.69-2) is installed and available in your system `$PATH`. The tool will fail if it cannot execute the `circos` binary.
- **Karyotype Matching**: Always verify if your fusion detection was performed against hg19 or hg38. Using the wrong `--karyotype` flag will result in misaligned or empty plots because the genomic coordinates won't match the reference lengths.
- **Output Management**: By default, fsnviz overwrites files named `fsnviz.svg`. When processing multiple samples, always use the `--base-name` flag to prevent data loss.
- **Font Scaling**: If you have a high density of fusion events, the default font sizes might overlap. Use the `--circos-conf` flag to point to a modified configuration with adjusted `label_size` parameters.



## Subcommands

| Command | Description |
|---------|-------------|
| fsnviz fusioncatcher | Plots output of FusionCatcher. |
| fsnviz star-fusion | Plots output of STAR-Fusion. |

## Reference documentation

- [FsnViz README](./references/github_com_bow_fsnviz_blob_master_README.rst.md)
- [FsnViz Changelog](./references/github_com_bow_fsnviz_blob_master_CHANGELOG.rst.md)