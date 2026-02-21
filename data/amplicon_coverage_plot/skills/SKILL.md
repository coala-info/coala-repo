---
name: amplicon_coverage_plot
description: The `amplicov` tool (part of the `amplicon_coverage_plot` package) provides a specialized workflow for assessing sequencing performance across defined amplicons.
homepage: https://github.com/chienchi/amplicon_coverage_plot
---

# amplicon_coverage_plot

## Overview

The `amplicov` tool (part of the `amplicon_coverage_plot` package) provides a specialized workflow for assessing sequencing performance across defined amplicons. Unlike general coverage tools, it distinguishes between "Whole Amplicon" regions and "Unique" regions (excluding overlaps), which is critical for understanding the true diagnostic or assembly power of a sequencing run. It produces an interactive HTML barplot for visual inspection and a text-based summary that identifies ambiguous "N" sites based on a user-defined coverage threshold.

## Command Line Usage

The primary command for this tool is `amplicov`.

### Basic Execution
To generate a plot from a sorted BAM file and a standard BED6 file:
```bash
amplicov --bed amplicons.bed --bam sorted_alignments.bam -o output_dir -p sample_prefix
```

### Input Requirements
- **Amplicon Definitions**: You must provide either `--bed` (BED6 format) or `--bedpe` (BEDPE format). These are mutually exclusive.
- **Coverage Data**: You must provide either `--bam` (must be sorted) or `--cov` (position-based coverage file). These are mutually exclusive.

### Common CLI Patterns

**Filtering for High-Quality Reads**
For Illumina data, use the `--pp` flag to only process properly paired reads, ensuring that coverage isn't inflated by chimeric or singleton reads.
```bash
amplicov --bed amplicons.bed --bam sorted.bam --pp --mincov 20
```

**Handling Overlapping Amplicons**
When using tiling protocols where amplicons overlap significantly, use the `--count_primer` flag to include primer regions in the unique coverage calculation.
```bash
amplicov --bedpe amplicons.bedpe --bam sorted.bam --count_primer
```

**Adding Functional Context**
Provide a GFF file to include gene or feature annotations in the interactive hover information of the HTML plot.
```bash
amplicov --bed amplicons.bed --bam sorted.bam --gff annotations.gff
```

**Targeting Specific References**
If your BED file contains multiple reference sequences (e.g., a multi-segment genome), use the `-r` or `--refID` flag to specify which reference to process.
```bash
amplicov --bed amplicons.bed --bam sorted.bam --refID "NC_045512.2"
```

## Expert Tips and Best Practices

- **BAM Sorting**: The tool requires a sorted BAM file. If your BAM is unsorted, run `samtools sort input.bam -o sorted.bam` before using `amplicov`.
- **Thresholding**: The `--mincov` parameter (default: 10) determines what the tool reports as an "N" site (ambiguous). Adjust this based on your specific validated threshold for variant calling (e.g., 20x or 50x for clinical samples).
- **Visual Cues**: In the generated HTML plot, the tool automatically color-codes bars: black indicates coverage < 5x, and blue indicates coverage < 20x. This allows for immediate visual identification of failed amplicons.
- **Output Interpretation**:
    - `prefix_amplicon_coverage.html`: The interactive visualization.
    - `prefix_amplicon_coverage.txt`: A tab-delimited table containing:
        - **Whole_Amplicon**: Average coverage across the entire amplicon.
        - **Unique**: Average coverage in the region unique to that amplicon.
        - **Whole_Amplicon_Ns**: Count of positions below the `--mincov` threshold in the whole region.
- **Depth Lines**: Use `--depth_lines` followed by a list of integers to add horizontal reference lines to the plot (e.g., `--depth_lines 10 50 100`).

## Reference documentation
- [amplicon_coverage_plot GitHub Repository](./references/github_com_chienchi_amplicon_coverage_plot.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_amplicon_coverage_plot_overview.md)