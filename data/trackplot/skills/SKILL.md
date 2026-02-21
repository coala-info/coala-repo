---
name: trackplot
description: `trackplot` is a versatile command-line utility designed for the high-resolution visualization of genomic datasets.
homepage: https://github.com/ygidtu/trackplot
---

# trackplot

## Overview

`trackplot` is a versatile command-line utility designed for the high-resolution visualization of genomic datasets. It transforms raw sequencing data—such as BAM, BigWig, and Bed files—into sophisticated figures suitable for scientific journals. The tool excels at representing complex transcriptomic features, including strand-aware coverage, splice junction counts, and protein domain architectures. Use this skill to construct precise CLI commands for plotting specific genomic regions, managing single-cell barcode demultiplexing, and customizing track aesthetics.

## Core CLI Usage

The primary command is `trackplot`. It requires a genomic event (region) and a reference annotation to function.

### Basic Plotting Pattern
```bash
trackplot \
  -e <chrom>:<start>-<end>:<strand> \
  -r <reference.gtf.gz> \
  --density <density_list.tsv> \
  -o <output.pdf>
```

### Key Arguments
- `-e, --event`: The genomic region to plot (e.g., `chr1:1000-2000:+`).
- `-r, --reference`: Path to a sorted and indexed GTF file for gene models.
- `--density`: A TSV file listing paths to BAM or BigWig files to be plotted as coverage tracks.
- `--heatmap`: A TSV file for generating heatmaps or Hi-C diagrams.
- `--igv`: A TSV file to display tracks in an IGV-like format.
- `-o, --output`: Output filename (supports .pdf, .png, .jpg).

## Advanced Visualization Features

### Highlighting and Annotation
- **Focus Regions**: Use `--focus start1-end1:start2-end2` to highlight specific genomic intervals with vertical shading.
- **Custom Strokes**: Use `--stroke start-end@color` (e.g., `1275656-1277656@blue`) to outline specific areas.
- **Marking Sites**: Use `--sites 1271656,1272656` to place markers at specific nucleotide positions.
- **Protein Domains**: Add `--domain` to visualize protein domains based on the provided GTF.

### Data Normalization and Processing
- **Normalization**: Use `--normalize-format cpm` to normalize coverage tracks by Counts Per Million.
- **Splicing**: Use `--show-junction-num` to display the number of reads supporting splice junctions (Sashimi plot style).
- **Single-Cell**: Provide a `--barcode` TSV to demultiplex BAM files into cell populations based on barcodes.
- **Duplicates**: Use `--remove-duplicate-umi` when working with UMI-tagged data to ensure accurate quantification.

### Output Customization
- **Dimensions**: Control the figure size with `--width` and `--height`.
- **Resolution**: Set `--dpi` (e.g., `300`) for high-quality image exports.
- **Scaling**: Adjust `--annotation-scale` to change the relative size of the gene model tracks.

## Expert Tips

- **Performance**: Use `-p <threads>` to enable multiprocessing. If you encounter "segment fault" errors on certain systems, revert to `-p 1`.
- **Platform Compatibility**: On Apple Silicon (M1/M2/M3) or Windows, `trackplot` may face library dependency issues (pysam/pyBigWig). Using the official Docker image (`ygidtu/trackplot`) is the recommended workaround for these environments.
- **Input Lists**: The TSV files for `--density`, `--interval`, and `--heatmap` should generally follow a format of `path\tlabel\tcolor`.
- **Web Interface**: For interactive exploration, you can start a local web server using `trackplot --start-server --plots ./plots_dir`.

## Reference documentation
- [trackplot GitHub Repository](./references/github_com_ygidtu_trackplot.md)
- [trackplot Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_trackplot_overview.md)