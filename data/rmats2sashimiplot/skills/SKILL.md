---
name: rmats2sashimiplot
description: rmats2sashimiplot is a specialized visualization tool that produces sashimi plots—diagrams that combine RNA-seq read depth histograms with arcs representing splice junctions.
homepage: https://github.com/Xinglab/rmats2sashimiplot
---

# rmats2sashimiplot

## Overview

rmats2sashimiplot is a specialized visualization tool that produces sashimi plots—diagrams that combine RNA-seq read depth histograms with arcs representing splice junctions. It is the standard tool for visualizing results from the rMATS (multivariate analysis of transcript splicing) pipeline. The tool can either parse rMATS event files directly or plot specific regions based on genomic coordinates and a GFF3 annotation file. It uses a modified RPKM calculation for the y-axis to represent read density across samples.

## Core Workflows

### 1. Plotting from rMATS Event Files
This is the most common use case when you have already run rMATS and want to visualize specific significant events (e.g., Skipped Exons).

```bash
rmats2sashimiplot --b1 ./sample1_rep1.bam,./sample1_rep2.bam \
                  --b2 ./sample2_rep1.bam,./sample2_rep2.bam \
                  --event-type SE \
                  -e SE.MATS.JC.txt \
                  --l1 Control --l2 Treatment \
                  -o output_plots
```

### 2. Plotting by Genomic Coordinates
Use this when you want to visualize a specific region regardless of rMATS output. Note that a GFF3 file is required.

```bash
rmats2sashimiplot --b1 ./s1.bam --b2 ./s2.bam \
                  -c chr16:+:9000:25000:annotation.gff3 \
                  --l1 Sample1 --l2 Sample2 \
                  -o coordinate_output
```

### 3. Grouped Sample Visualization
To compare groups rather than individual replicates, use a grouping file (`.gf`) to calculate average inclusion levels and read depths.

```bash
rmats2sashimiplot --b1 s1_r1.bam,s1_r2.bam --b2 s2_r1.bam,s2_r2.bam \
                  --event-type SE -e SE.MATS.JC.txt \
                  --group-info grouping.gf \
                  -o grouped_output
```
**Grouping File Format (`grouping.gf`):**
```text
GroupA: 1-2
GroupB: 3-4
```
*Note: Indices are one-based and follow the order of files provided in `--b1` followed by `--b2`.*

## Expert Tips and Best Practices

*   **BAM Preparation**: All BAM files must be sorted and indexed (`samtools index`) before running the tool.
*   **Annotation Format**: The tool strictly requires **GFF3**. If you have a GTF file, convert it using `gffread`:
    `gffread --keep-genes input.gtf -o output.gff3`
*   **Performance Optimization**: rmats2sashimiplot is single-threaded. If your rMATS event file (e.g., `SE.MATS.JC.txt`) contains thousands of events, the tool will attempt to plot all of them, which is extremely slow. **Always filter your event file** to include only the top significant events of interest before plotting.
*   **Input File Lists**: For experiments with many replicates, avoid long command lines by passing a text file containing comma-separated paths to `--b1` or `--b2`.
*   **Visual Scaling**: Use `--exon_s` and `--intron_s` to adjust the relative lengths of exons and introns in the plot to make dense regions more readable.
*   **Y-Axis Interpretation**: The y-axis represents a modified RPKM. Read counts are distributed evenly over the length of the read (e.g., a 50bp read adds 1/50 to each coordinate it covers) and then normalized by total library size.

## Reference documentation
- [github_com_Xinglab_rmats2sashimiplot.md](./references/github_com_Xinglab_rmats2sashimiplot.md)
- [anaconda_org_channels_bioconda_packages_rmats2sashimiplot_overview.md](./references/anaconda_org_channels_bioconda_packages_rmats2sashimiplot_overview.md)