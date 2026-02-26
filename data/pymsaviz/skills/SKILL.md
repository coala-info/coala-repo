---
name: pymsaviz
description: "pymsaviz generates customizable, publication-ready visualizations of multiple sequence alignments using matplotlib. Use when user asks to visualize sequence alignments, highlight conservation patterns, or add annotations to multiple sequence alignment plots."
homepage: https://moshi4.github.io/pyMSAviz/
---


# pymsaviz

## Overview

`pymsaviz` is a Python-based visualization tool built on matplotlib specifically for Multiple Sequence Alignments. It transforms sequence data into customizable plots, allowing for the clear communication of evolutionary conservation, structural motifs, or specific sequence features. It is particularly useful for researchers who need to programmatically generate MSA figures with precise control over color schemes, wrapping, and annotations.

## CLI Usage Patterns

The command-line interface is the fastest way to generate standard visualizations.

### Basic Visualization
Generate a standard plot from a FASTA file:
```bash
pymsaviz -i input.fa -o alignment.png
```

### Publication-Ready Formatting
For long alignments, use wrapping and include a consensus identity bar:
```bash
pymsaviz -i input.fa -o alignment.pdf --wrap_length 80 --show_consensus --show_count
```

### Highlighting Conservation
Use the `Identity` color scheme to emphasize residues that match the consensus:
```bash
pymsaviz -i input.fa -o conservation.svg --color_scheme Identity --consensus_color tomato
```

## Python API Best Practices

For complex annotations or dynamic filtering, use the Python API.

### Initialization and Plotting
```python
from pymsaviz import MsaViz

mv = MsaViz("input.fa", wrap_length=60, show_consensus=True)
# Set specific plot parameters for better readability
mv.set_plot_params(ticks_interval=5, x_unit_size=0.2)
mv.savefig("output.png")
```

### Advanced Annotations
You can add markers (like arrows or symbols) and text boxes to specific ranges:
```python
# Add a marker at position 10 and a range from 20-30
mv.add_markers([10, (20, 30)], marker="v", color="red")

# Add a labeled text annotation for a specific domain
mv.add_text_annotation((45, 55), "Active Site", text_color="blue", range_color="blue")
```

### Automated Highlighting
Highlight regions based on conservation percentage:
```python
# Highlight only positions with less than 50% identity
mv.set_highlight_pos_by_ident_thr(min_thr=0, max_thr=50)
```

## Expert Tips

1.  **Format Support**: While FASTA is the default, you can specify others like `clustal`, `phylip`, or `emboss` using the `--format` flag or the `format` parameter in the `MsaViz` constructor.
2.  **Coordinate Systems**: Note that `start` and `end` parameters in `MsaViz` use **one-based** coordinates, matching standard biological numbering.
3.  **Custom Colors**: If standard schemes (Zappo, Taylor, etc.) are insufficient, use `set_custom_color_scheme({"A": "red", "C": "blue"})` to define a mapping for specific residues.
4.  **Vector Graphics**: For publications, always save in `.svg` or `.pdf` format to ensure the alignment remains sharp at any scale.

## Reference documentation
- [CLI Docs](./references/moshi4_github_io_pyMSAviz_cli-docs_pymsaviz.md)
- [API Docs](./references/moshi4_github_io_pyMSAviz_api-docs_msaviz.md)
- [Getting Started](./references/moshi4_github_io_pyMSAviz_getting_started.md)
- [Color Schemes](./references/moshi4_github_io_pyMSAviz_color_schemes.md)