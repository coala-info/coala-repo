---
name: mummer2circos
description: mummer2circos generates circular genomic visualizations by wrapping MUMmer and Circos to compare multiple query genomes against a reference. Use when user asks to create circular alignment plots, visualize sequencing depth tracks, or overlay functional annotations and protein labels onto genomic comparisons.
homepage: https://github.com/metagenlab/mummer2circos
metadata:
  docker_image: "quay.io/biocontainers/mummer2circos:1.4.2--pyhdfd78af_0"
---

# mummer2circos

## Overview

mummer2circos is a specialized tool designed to bridge the gap between genome alignment and high-quality circular visualization. It acts as a wrapper for MUMmer and Circos, allowing researchers to compare multiple query genomes against a single reference. Beyond simple alignments, it can overlay functional annotations from GenBank files, protein-of-interest labels via Best Bidirectional Hits (BBH), and sequencing depth tracks. This skill provides the necessary command-line patterns and data preparation requirements to produce publication-ready SVG and PNG genomic plots.

## Core CLI Usage

### Basic Circular Plot
To generate a standard circular plot comparing a reference to one or more query genomes:
```bash
mummer2circos -l -r reference.fna -q query1.fna query2.fna
```
*Note: The `-l` flag is mandatory for building circular plots.*

### Alignment Methods
Choose the alignment algorithm based on the evolutionary distance of your sequences using the `-a` parameter:
*   **nucmer** (Default): Best for closely related DNA sequences.
*   **promer**: Best for divergent sequences as it aligns based on six-frame translations.
*   **megablast**: Useful for rapid nucleotide searches.

Example using promer:
```bash
mummer2circos -l -a promer -r reference.fna -q query.fna
```

### Adding Functional Tracks
To include gene tracks, provide a GenBank file. **Critical**: The header of the reference FASTA file must match the `LOCUS` accession in the GenBank file.
```bash
mummer2circos -l -r reference.fna -q query.fna -gb reference.gbk
```

### Visualizing Sequencing Depth
You can display mapping depth (e.g., from samtools depth). Regions with depth >2x the median are colored green; regions <0.5x the median are colored red.
```bash
mummer2circos -l -r reference.fna -q query.fna -s sample.depth
```

## Advanced Labeling and Highlighting

### Labeling Specific Proteins (BBH)
If you have a FASTA file of proteins of interest (e.g., virulence factors), the tool can label their Best Bidirectional Hits on the plot. The FASTA headers are used as labels.
```bash
mummer2circos -l -r reference.fna -q query.fna -b proteins.faa
```

### Custom Coordinate Labels
To add labels at specific coordinates, use a tab-delimited text file with the structure: `LOCUS start stop label`.
```bash
mummer2circos -l -r reference.fna -q query.fna -lf labels.txt
```
*Constraint: Labels in the text file cannot contain spaces.*

### Condensed Tracks
If comparing many genomes, use the `-c` flag to condense tracks and save space:
```bash
mummer2circos -l -c -r reference.fna -q genomes/*.fna
```

## Expert Tips & Troubleshooting

1.  **Header Consistency**: The most common cause of failure is a mismatch between the FASTA header and the GenBank/Depth/Label file identifiers. Ensure they are identical.
2.  **Track Order**: Genome tracks are rendered in the order they are provided in the `-q` argument.
3.  **Large Genomes**: For very large genomes or many queries, the SVG generation may be slow. Ensure your environment has sufficient memory for the Circos rendering engine.
4.  **Output Formats**: The tool automatically generates both SVG (vector) and PNG (raster) files. Use the SVG for publication-quality edits in tools like Inkscape or Illustrator.

## Reference documentation
- [mummer2circos GitHub Repository](./references/github_com_metagenlab_mummer2circos.md)
- [mummer2circos Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mummer2circos_overview.md)