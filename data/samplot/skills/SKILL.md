---
name: samplot
description: Samplot creates visual representations of genomic structural variants by plotting alignment data and coverage depth from multiple sequencing technologies. Use when user asks to visualize structural variants, plot BAM or CRAM files, or generate images of genomic regions from a VCF file.
homepage: https://github.com/ryanlayer/samplot
metadata:
  docker_image: "quay.io/biocontainers/samplot:1.3.0--pyh5e36f6f_1"
---

# samplot

## Overview
Samplot is a specialized visualization tool designed to provide clear, multi-sample evidence for structural variants. By plotting alignment data (reads, split-reads, and discordantly mapped pairs) alongside coverage depth, it allows researchers to visually confirm or reject SV candidates. It supports diverse sequencing technologies, including Illumina short-reads, Oxford Nanopore (ONT), Pacific Biosciences (PacBio), and 10X Genomics.

## Core CLI Usage

### Basic Plotting
To visualize a specific genomic region across multiple samples:
```bash
samplot plot \
    -n Sample1 Sample2 \
    -b sample1.bam sample2.bam \
    -c chr4 -s 115928726 -e 115931880 \
    -t DEL \
    -o output_deletion.png
```
*   `-c`, `-s`, `-e`: Chromosome, start, and end coordinates.
*   `-b`: Space-delimited list of BAM/CRAM files.
*   `-t`: SV type (e.g., DEL, DUP, INV, BND).

### Working with CRAM Files
CRAM files require the reference genome for decompression:
```bash
samplot plot -r reference.fasta -b sample.cram -c chr1 -s 1000 -e 2000 -o plot.png
```

### Visualizing from a VCF
To automate plotting for many variants found in a VCF file:
```bash
samplot vcf \
    --vcf input.vcf \
    -b sample1.bam sample2.bam \
    -o output_directory
```

## Advanced Visualization Tips

### Handling Large Variants (Zoom)
For variants over 1Mb, use `--zoom` to focus on the breakpoints while maintaining a connection between them. This prevents the plot from becoming unreadable due to scale.
```bash
samplot plot --zoom 1000 -c chr1 -s 1000000 -e 2000000 -b sample.bam -o zoomed.png
```

### Adding Genomic Context
*   **Transcripts**: Use `-T` with a GFF3/GTF file to show gene models at the bottom of the plot.
*   **Annotations**: Use `-A` with tabixed BED files (e.g., repeats, mappability) to identify if a variant falls in a repetitive region.
```bash
samplot plot -T genes.gff3 -A repeats.bed.gz ...
```

### Long-Read Optimization
When using ONT or PacBio data, samplot automatically handles long-read CIGAR strings. You can adjust the threshold for what is considered a "long read" or a "significant event" within a read:
*   `--long_read`: Minimum length to treat as long-read (default 1000).
*   `--min_event_size`: Minimum CIGAR event size to plot (default 100).

### Depth and Quality Control
*   **Downsampling**: Use `-d` to limit the number of "normal" (concordant) reads plotted, which speeds up rendering and reduces file size without losing the SV signal.
*   **Mapping Quality**: Use `-q` to filter out low-quality alignments (default is 1).
*   **Coverage Scales**: Use `--same_yaxis_scales` when comparing multiple samples to ensure the coverage tracks are visually comparable.



## Subcommands

| Command | Description |
|---------|-------------|
| samplot_plot | Plot BAM/CRAM files |
| samplot_vcf | Plots structural variants from VCF and BAM/CRAM files. |

## Reference documentation
- [Basic Options](./references/github_com_ryanlayer_samplot_wiki_Basic-Options.md)
- [Advanced Options](./references/github_com_ryanlayer_samplot_wiki_Advanced-Options.md)
- [Plotting ONT, PacBio, and 10X Data](./references/github_com_ryanlayer_samplot_wiki_Plotting-ONT_-PacBio_-and-10X-Data.md)
- [Plotting Variants from a VCF](./references/github_com_ryanlayer_samplot_wiki_Plotting-Variants-from-a-VCF.md)