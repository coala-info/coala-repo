---
name: jupiterplot
description: Jupiterplot is a specialized pipeline designed to generate Circos-based visualizations that compare a draft genome assembly against a reference genome.
homepage: https://github.com/JustinChu/JupiterPlot
---

# jupiterplot

## Overview

Jupiterplot is a specialized pipeline designed to generate Circos-based visualizations that compare a draft genome assembly against a reference genome. It is particularly effective for identifying structural discrepancies such as translocations, inversions, and misassemblies. The resulting "Jupiter plot" provides a qualitative, high-level view of how well an assembly covers a reference, with links representing contiguous alignments. Use this skill when you need to assess assembly quality or visualize genomic synteny without manually configuring complex Circos files.

## Installation

The most reliable way to install jupiterplot and its dependencies (Circos, minimap2, samtools) is via Bioconda:

```bash
conda install bioconda::jupiterplot
```

## Basic Usage

The tool uses a Makefile-based execution. The minimum required arguments are a project name, a reference FASTA, and the assembly FASTA.

```bash
jupiter name=<prefix> ref=<reference.fa> fa=<scaffolds.fa>
```

## Command Line Parameters

### Performance and Filtering
- `t=4`: Set the number of threads for `minimap2` alignment.
- `m=100000`: Minimum reference chromosome size to include in the plot (default is 100kb).
- `ng=75`: Include the largest scaffolds that make up this percentage of the genome. Set to `0` to include all scaffolds.
- `maxScaff=-1`: Limit the plot to a specific number of scaffolds instead of using the `ng` filter.

### Visual Customization
- `labels=ref`: Choose which labels to display: `ref`, `scaf`, or `both`.
- `i=0`: Increment for HSV color shifting (0-360). Values >360 generate random colors.
- `linkAlpha=5`: Set link transparency (1 = 17%, 5 = 83%).
- `g=1`: Minimum gap size in the reference to render (indicated by black lines).

### Alignment Sensitivity
- `minBundleSize=50000`: The minimum size of a contiguous region required to render a link (default 50kb). Increase this to reduce "noise" from small alignments.
- `maxGap=100000`: Maximum alignment gap allowed before a region is no longer considered contiguous.
- `MAPQ=50`: Minimum mapping quality for filtering links.

## Expert Tips and Workflows

### Iterative Chromosome Renaming
If the reference FASTA has long or uninformative headers, you can pause the pipeline to rename them for a cleaner plot:

1. Run the pipeline until the karyotype file is generated:
   ```bash
   jupiter name=my_asm ref=ref.fa fa=scaf.fa my_asm.karyotype
   ```
2. Edit `my_asm.karyotype` (e.g., using `sed` or a text editor) to change the display labels.
3. Resume the pipeline:
   ```bash
   jupiter name=my_asm ref=ref.fa fa=scaf.fa
   ```

### Interpreting Results
- **Twisted Links**: Represent inversions relative to the reference orientation.
- **Black Lines on Reference**: Indicate gaps of 'N's in the reference genome, which often explain missing coverage in telomeric or centromeric regions.
- **SVG vs PNG**: Always prefer the `.svg` output. The Perl modules used by Circos often struggle with transparency in PNG files, leading to cluttered visualizations.

### Troubleshooting "Too Many Ideograms"
If you receive an error stating "maximum [500] ideograms exceeded," your assembly is likely too fragmented for the default settings.
- **Solution A**: Increase the `ng` value (e.g., `ng=90`) or set a strict `maxScaff` limit to focus only on the largest contigs.
- **Solution B**: Modify the `max_ideograms` value in the `etc/housekeeping.conf` file within your Circos installation.

## Reference documentation
- [JupiterPlot GitHub Repository](./references/github_com_JustinChu_JupiterPlot.md)
- [Bioconda Jupiterplot Overview](./references/anaconda_org_channels_bioconda_packages_jupiterplot_overview.md)