---
name: jvarkit-bam2wig
description: This tool converts BAM alignment files into Wiggle or BedGraph formats to visualize genomic coverage and alignment metrics. Use when user asks to generate coverage tracks, convert BAM to Wiggle or BedGraph, visualize read clipping and indels, or calculate coverage ratios between samples.
homepage: http://lindenb.github.io/jvarkit/Bam2Wig.html
metadata:
  docker_image: "quay.io/biocontainers/jvarkit-bam2wig:201904251722--0"
---

# jvarkit-bam2wig

## Overview
The `jvarkit-bam2wig` tool is a specialized Java utility for transforming sequence alignment data (BAM) into continuous value tracks suitable for genome browsers like UCSC or IGV. Unlike simple depth calculators, it parses CIGAR strings to provide granular metrics including base clipping and indel frequencies. It is particularly useful for creating fixed-step wiggle files with customizable window sizes and shifts, though it can also output standard BedGraph formats.

## Usage Patterns

### Basic Coverage Generation
To generate a standard Wiggle file with default settings (100bp window, 25bp shift):
```bash
java -jar dist/jvarkit.jar bam2wig input.bam > output.wig
```

### Generating BedGraph Output
For a more compressed format that only reports genomic intervals with data, use the `-bg` flag:
```bash
java -jar dist/jvarkit.jar bam2wig -bg input.bam > output.bedgraph
```

### High-Resolution Analysis
For base-pair resolution (window size 1, no shift), which is useful for identifying precise breakpoints or small indels:
```bash
java -jar dist/jvarkit.jar bam2wig -w 1 -s 1 input.bam
```

### Advanced Metric Aggregation
Change the `--display` parameter to visualize specific alignment artifacts instead of raw coverage:
*   **CLIPPING**: Visualize where reads are being soft/hard clipped (useful for structural variant detection).
*   **INSERTION/DELETION**: Track the frequency of gaps or insertions relative to the reference.
*   **CASE_CTRL**: Calculate the ratio of median coverage between cases and controls (requires a `--pedigree` file).

### Filtering and Precision
*   **Map Quality**: By default, the tool filters `mapq < 1`. To change this or add filters (e.g., keep duplicates), use the `--filter` expression.
*   **Value Formatting**: Use `-f "%.0f"` to output integers for raw counts, or scientific notation with `"%e"`.
*   **Region Limiting**: Use `--region chrom:start-end` to process specific loci and save memory/time.

## Expert Tips
*   **Memory Management**: This tool is memory-intensive as it allocates an integer array the size of the longest chromosome. Ensure your JVM has enough heap space (e.g., `java -Xmx8G -jar ...`) when working with large mammalian genomes.
*   **Header Customization**: Use the `-t` flag to generate a UCSC track header. You can pipe the output to `sed` to instantly name your track:
    ```bash
    java -jar dist/jvarkit.jar bam2wig -t input.bam | sed '/^track/s/__REPLACE_WIG_NAME__/My_Sample_Coverage/'
    ```
*   **Input Flexibility**: The tool accepts a single BAM, multiple BAMs, or a `.list` file containing paths to BAM files. If using multiple files, the data is merged into a single track unless using `--partition`.

## Reference documentation
- [Bam2Wig | jvarkit](./references/lindenb_github_io_jvarkit_Bam2Wig.html.md)