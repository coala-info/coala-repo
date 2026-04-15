---
name: jvarkit-wgscoverageplotter
description: This tool generates a visual representation of sequencing depth across an entire genome in SVG format from indexed BAM or CRAM files. Use when user asks to plot whole genome coverage, visualize sequencing depth, or identify large-scale genomic variations like aneuploidies and deletions.
homepage: http://lindenb.github.io/jvarkit/WGSCoveragePlotter.html
metadata:
  docker_image: "quay.io/biocontainers/jvarkit-wgscoverageplotter:20201223--hdfd78af_3"
---

# jvarkit-wgscoverageplotter

## Overview
The `jvarkit-wgscoverageplotter` tool creates a visual representation of sequencing depth across an entire genome. It processes indexed alignment files (BAM/CRAM) and produces a Scalable Vector Graphics (SVG) file. This is particularly useful for a "bird's-eye view" of genomic data, allowing researchers to quickly spot large deletions, aneuploidies, or regions of poor enrichment.

## Usage Guidelines

### Basic Command Structure
The tool is typically invoked via the Java JAR or through a bioconda-installed wrapper.
```bash
jvarkit-wgscoverageplotter -R reference.fasta -o output.svg input.bam
```

### Key Parameters
- **Reference (-R, --reference)**: Required. Must be indexed with `samtools faidx` and have a sequence dictionary (.dict).
- **Max Depth (-C, --max-depth)**: Use `-C -1` to automatically set the Y-axis limit to twice the average depth, which prevents high-coverage outliers from flattening the rest of the plot.
- **Clipping (--clip)**: Use with `--max-depth` to ensure the plot area does not exceed the specified depth limit.
- **Filtering Contigs**:
  - Use `-I` or `--include-contig-regex` to focus on specific chromosomes (e.g., `-I "chr[0-9XY]+"`).
  - Use `-X` or `--skip-contig-regex` to ignore unplaced scaffolds or decoys.
- **Image Size (--dimension)**: Specify the output resolution (e.g., `--dimension 1500x500`).

### Expert Tips
- **Binning Strategy**: The `--percentile` option determines how coverage is calculated for each pixel. While `median` is the default and robust against noise, `min` is excellent for finding absolute coverage gaps, and `max` helps identify repetitive regions or mapping artifacts.
- **Sample Partitioning**: If your BAM contains multiple samples or read groups, use `--partition` (e.g., `--partition sample`) and `--samples` to generate plots for specific subsets of the data.
- **Visual Style**: Use `--points` instead of the default area plot if you prefer a scatter-plot style visualization, which can be clearer when comparing multiple samples or looking for fine-grained variance.

## Common CLI Patterns

### Visualizing a Specific Set of Chromosomes
To plot only the primary autosomes and sex chromosomes while auto-scaling the depth:
```bash
jvarkit-wgscoverageplotter \
  -R human_g1k_v37.fasta \
  --include-contig-regex "(chr)?[0-9XY]+" \
  -C -1 --clip \
  --dimension 2000x600 \
  -o genome_coverage.svg \
  input.bam
```

### High-Resolution Median Coverage
For a detailed view using median coverage to smooth out local spikes:
```bash
jvarkit-wgscoverageplotter \
  -R ref.fa \
  --percentile median \
  --mapq 30 \
  input.bam > coverage.svg
```

## Reference documentation
- [WGSCoveragePlotter Documentation](./references/lindenb_github_io_jvarkit_WGSCoveragePlotter.html.md)