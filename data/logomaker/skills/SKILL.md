---
name: logomaker
description: Logomaker is a Python library that creates highly customizable sequence logos from sequence alignments, energy matrices, or saliency maps using matplotlib. Use when user asks to generate sequence logos, visualize Shannon information, create enrichment logos from count matrices, or style character-based vector graphics.
homepage: http://logomaker.readthedocs.io
---


# logomaker

## Overview

Logomaker is a Python library designed to create highly customizable sequence logos. It transforms sequence alignments, energy matrices, or saliency maps into vector graphics rendered within matplotlib Axes objects. This skill enables the generation of standard logos (like Shannon information) as well as specialized visualizations such as contribution scores or enrichment logos, providing fine-grained control over character styling and layout.

## Implementation Guide

### Core Workflow
1. **Prepare Data**: Input data must be a pandas DataFrame where columns represent characters (e.g., A, C, G, T) and rows represent sequence positions.
2. **Initialize Logo**: Pass the DataFrame to `logomaker.Logo()`.
3. **Refine Aesthetics**: Use built-in methods to adjust colors, fonts, and axis styling.
4. **Export**: Since logos are matplotlib objects, use `plt.show()` or `fig.savefig()`.

### Matrix Preparation
Use Logomaker's utility functions to convert raw data into the required DataFrame format:
- `logomaker.alignment_to_matrix(sequences)`: Converts a list of equal-length sequences into a count matrix.
- `logomaker.transform_matrix(df, from_type='counts', to_type='information')`: Converts counts to Shannon information, probability, or weight matrices.
- `logomaker.saliency_to_matrix(values, sequence)`: Formats neural network saliency scores for visualization.

### Common Patterns
- **Basic Information Logo**:
  ```python
  import logomaker
  import matplotlib.pyplot as plt

  # Create a logo object
  logo = logomaker.Logo(df, color_scheme='classic')
  
  # Style the axes
  logo.style_spines(visible=False)
  logo.style_spines(spines=['left', 'bottom'], visible=True)
  plt.show()
  ```
- **Enrichment Logo**: Use a center-stacked logo to show both positive and negative enrichment (e.g., for energy matrices).
  ```python
  logo = logomaker.Logo(df, center_values=True)
  ```

### Expert Tips
- **Color Schemes**: Use `color_scheme` parameters like 'classic', 'grays', or 'skylines'. Custom dictionaries mapping characters to hex codes are also supported.
- **Glyph Styling**: Access individual characters via `logo.style_glyphs()` to highlight specific positions or residues.
- **Matplotlib Integration**: Because `logomaker.Logo` accepts an `ax` argument, you can easily embed logos into complex multi-panel subplots.
- **Validation**: Always run `logomaker.validate_matrix(df)` if manually constructing DataFrames to ensure compatibility with the Logo class.

## Reference documentation
- [Logomaker Documentation](./references/logomaker_readthedocs_io_en_latest.md)
- [Bioconda Logomaker Overview](./references/anaconda_org_channels_bioconda_packages_logomaker_overview.md)