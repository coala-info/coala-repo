---
name: samplot
description: Samplot is a command-line utility that transforms complex genomic alignment data into intuitive visual representations of structural variants.
homepage: https://github.com/ryanlayer/samplot
---

# samplot

## Overview

Samplot is a command-line utility that transforms complex genomic alignment data into intuitive visual representations of structural variants. While general-purpose genome browsers show all data, Samplot focuses specifically on the evidence supporting an SV, such as changes in coverage or anomalous library inserts. It is highly effective for rapid manual curation of variant calls and supports a wide range of sequencing technologies, including Illumina short-reads, linked-reads (10X Genomics), and long-reads (Oxford Nanopore and PacBio).

## Command Line Usage and Patterns

### Basic Structural Variant Plotting
The core command is `samplot plot`. You must provide the genomic coordinates, the variant type, and at least one alignment file.

```bash
samplot plot \
    --chrom chr4 \
    --start 115928726 \
    --end 115931880 \
    --sv_type DEL \
    --bams sample.bam \
    --output_file deletion_plot.png
```

### Multi-Sample Comparison (Trios/Cohorts)
To compare multiple samples, provide a space-delimited list of BAM files and corresponding titles. This is essential for identifying de novo variants or checking inheritance patterns.

```bash
samplot plot \
    -n Proband Mother Father \
    -b proband.bam mother.bam father.bam \
    -c chr1 -s 10000 -e 20000 -t DEL \
    -o trio_comparison.png
```

### Working with CRAM Files
When using CRAM files, you must specify the reference genome used for alignment to allow for decompression.

```bash
samplot plot -c chr1 -s 5000 -e 6000 -t DUP \
    -b sample.cram \
    -r reference.fasta \
    -o plot.png
```

### Visualizing Long-Read Data (ONT/PacBio)
For long-read data, use the `--long_read` flag to adjust how Samplot handles alignments (default threshold is 1000bp).

```bash
samplot plot -c chr2 -s 20000 -e 25000 -t INV \
    -b long_read_sample.bam \
    --long_read 1000 \
    -o long_read_inversion.png
```

### Adding Context with Annotations and Transcripts
You can overlay gene models (GFF3) or genomic features (BED) to see if an SV overlaps with exons or known repeats.

```bash
samplot plot -c chr1 -s 1000 -e 5000 -t DEL -b sample.bam \
    --transcript_file genes.gff3 \
    --annotation_files repeats.bed.gz \
    --annotation_filenames "Repeats"
```

## Expert Tips and Best Practices

- **Manage Plot Clutter**: In high-depth regions, individual reads can make the plot unreadable. Use `--coverage_only` to hide reads and only show the depth profile, or use `-d` (max_depth) to downsample the number of normal reads plotted.
- **Breakpoint Focus**: For very large SVs, use `--zoom` (default 500bp) to show only the regions immediately surrounding the start and end coordinates. This saves time and makes the evidence at the breakpoints clearer.
- **Publication Quality**: Increase the resolution for papers using `--dpi` (e.g., `--dpi 300`). You can also change the output format by changing the extension of the `-o` flag (e.g., `.pdf` or `.svg` for vector graphics).
- **Translocations (BND)**: For interchromosomal events or translocations, you can provide multiple chromosomes, starts, and ends.
- **Automated Batching**: If you have a VCF file of calls, use the `samplot vcf` command to generate plots for every variant in the file automatically.
- **MAPQ Filtering**: Use `-q` to set a minimum mapping quality. This is helpful for filtering out reads in repetitive regions that might obscure true SV signals.

## Reference documentation
- [Samplot GitHub README](./references/github_com_ryanlayer_samplot.md)
- [Samplot Wiki](./references/github_com_ryanlayer_samplot_wiki.md)