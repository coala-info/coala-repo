---
name: dna_features_viewer
description: The `dna_features_viewer` skill enables the programmatic generation of clear and readable DNA sequence maps.
homepage: https://github.com/Edinburgh-Genome-Foundry/DnaFeaturesViewer
---

# dna_features_viewer

## Overview
The `dna_features_viewer` skill enables the programmatic generation of clear and readable DNA sequence maps. It automatically manages label placement to prevent overlaps and integrates seamlessly with the Matplotlib and Biopython ecosystems. Use this skill to create static figures (PNG, SVG, PDF) or interactive browser-based plots for genomic data analysis and presentation.

## Core Usage Patterns

### 1. Manual Record Creation
For custom annotations without a source file, use `GraphicFeature` and `GraphicRecord`.

```python
from dna_features_viewer import GraphicFeature, GraphicRecord

features = [
    GraphicFeature(start=5, end=20, strand=+1, color="#ffd700", label="Feature 1"),
    GraphicFeature(start=15, end=50, strand=-1, color="#ffcccc", label="Feature 2")
]
record = GraphicRecord(sequence_length=100, features=features)
record.plot(figure_width=5)
```

### 2. Circular Plots
To visualize plasmids or circular genomes, simply swap the record class.

```python
from dna_features_viewer import CircularGraphicRecord
# Use the same features list as above
circular_record = CircularGraphicRecord(sequence_length=100, features=features)
circular_record.plot(figure_width=5)
```

### 3. Parsing GenBank and GFF Files
The `BiopythonTranslator` is the standard way to convert biological files into graphical records.

```python
from dna_features_viewer import BiopythonTranslator

# Load from GenBank
graphic_record = BiopythonTranslator().translate_record("sequence.gb")
ax, _ = graphic_record.plot(figure_width=10)

# For GFF files (requires bcbio-gff)
# graphic_record = BiopythonTranslator().translate_record("sequence.gff")
```

### 4. Sequence and Translation Overlays
You can plot the actual nucleotides or amino acid translations beneath the feature map, typically after cropping to a region of interest.

```python
cropped = graphic_record.crop((400, 450))
ax, _ = cropped.plot(figure_width=8)
cropped.plot_sequence(ax)
cropped.plot_translation(ax, location=(408, 423), fontdict={'weight': 'bold'})
```

### 5. Multi-line and Multi-page Plots
For long sequences, use multi-line or multi-page outputs to maintain readability.

```python
# Multi-line
graphic_record.plot_on_multiple_lines(nucl_per_line=100)

# Multi-page PDF
graphic_record.plot_on_multiple_pages("output.pdf", nucl_per_line=70, lines_per_page=7)
```

## Expert Tips and Best Practices

*   **Label Management**: Use the `strand_in_label_threshold` parameter in `plot()` to control when arrows are drawn inside labels. A value of ~7 pixels is often a good starting point for small features.
*   **Custom Themes**: Inherit from `BiopythonTranslator` to create custom logic for feature colors and labels based on feature types (e.g., coloring all 'CDS' blue and 'promoters' red).
*   **Subplot Integration**: Since the library uses Matplotlib, you can pass an existing `ax` to `record.plot(ax=ax1)` to combine sequence maps with other data like GC content or coverage tracks.
*   **Interactive Plots**: Use `record.plot_with_bokeh()` for interactive, zoomable maps in Jupyter notebooks or web applications (requires `bokeh` and `pandas`).

## Reference documentation
- [dna_features_viewer Overview](./references/anaconda_org_channels_bioconda_packages_dna_features_viewer_overview.md)
- [DnaFeaturesViewer GitHub Documentation](./references/github_com_Edinburgh-Genome-Foundry_DnaFeaturesViewer.md)