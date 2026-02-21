---
name: tagore
description: tagore is a specialized bioinformatics visualization tool designed to render genomic features onto human chromosome ideograms.
homepage: https://github.com/jordanlab/tagore
---

# tagore

## Overview
tagore is a specialized bioinformatics visualization tool designed to render genomic features onto human chromosome ideograms. It allows for the creation of "chromosome painting" diagrams by mapping data from a BED-like format into graphical shapes—rectangles, circles, triangles, or lines—positioned precisely on the chromosomal structure. It is particularly useful for displaying somatic mutations, population genetics data (like RFMix outputs), and general genomic landmarks across the 23 pairs of human chromosomes.

## CLI Usage and Patterns

### Basic Command
The primary interface is the `tagore` command. At minimum, it requires an input file.
```bash
tagore --input features.bed --prefix output_name
```

### Core Arguments
- `-i, --input`: Path to the BED-like input file (required).
- `-p, --prefix`: Prefix for the output files (default: "out").
- `-b, --build`: Specify the human genome build. Supports `hg38` (default) and `hg37`.
- `-f, --force`: Overwrite existing output files.
- `-v, --verbose`: Enable detailed logging of the drawing process.

### Input File Format
The input file must be a tab-separated BED-like file with exactly seven columns. Each row represents a single feature to be drawn on a specific chromosome copy.

| Column | Name | Description |
| :--- | :--- | :--- |
| 1 | **chr** | Chromosome name (e.g., `chr1`, `chrX`). |
| 2 | **start** | Start position in base pairs. |
| 3 | **stop** | Stop position in base pairs. |
| 4 | **feature** | Shape type: `0` (Rectangle), `1` (Circle), `2` (Triangle), `3` (Line). |
| 5 | **size** | Horizontal width of the feature (range: `0` to `1`). |
| 6 | **color** | Hexadecimal color code (e.g., `#FF0000` for red). |
| 7 | **chrCopy** | Which chromosome copy to draw on: `1` or `2`. |

## Expert Tips and Best Practices

### Visualizing Diploid Data
tagore renders two copies for each chromosome. To display a homozygous feature or a feature present on both homologs, you must provide two separate entries in the input file: one with `chrCopy` set to `1` and another with `chrCopy` set to `2`.

### Choosing Feature Shapes
- **Rectangles (0)**: Best for representing blocks of ancestry, CNVs, or large genomic regions.
- **Circles (1)**: Ideal for single nucleotide variants (SNVs) or specific point mutations.
- **Triangles (2)**: Often used to denote polymorphisms (SNPs) or specific directional markers.
- **Lines (3)**: Useful for marking precise boundaries or INDEL sites.

### Ancestry Painting (RFMix)
If working with ancestry inference data, use the included helper script `rfmix2tagore` to convert RFMix outputs into the tagore-compatible BED format before running the main visualization.

### Output Formats
While tagore primarily generates SVG files for web and vector editing, it supports PDF output if the system has the appropriate `RSVG` libraries installed. SVG is generally preferred for further manual refinement in tools like Adobe Illustrator or Inkscape.

## Reference documentation
- [tagore GitHub Repository](./references/github_com_jordanlab_tagore.md)
- [tagore Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tagore_overview.md)