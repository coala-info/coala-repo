---
name: wally
description: wally is a high-performance visualization tool for aligned sequencing reads and genomic variants. Use when user asks to visualize genomic regions, compare multiple samples, inspect structural variants, highlight breakpoints, visualize translocations, or trace long-read alignments.
homepage: https://github.com/tobiasrausch/wally
---


# wally

## Overview

wally is a high-performance visualization tool designed for aligned sequencing reads and genomic variants. It provides a command-line interface to render read-level evidence, making it particularly effective for validating structural variants (SVs), comparing tumor-normal pairs, and inspecting long-read alignment chains. It transforms complex alignment data into interpretable plots, supporting both single-region inspections and large-scale batch processing.

## Core Workflows

### Visualizing Genomic Regions

Use the `region` subcommand to plot specific coordinates. This requires a sorted and indexed BAM/CRAM file and a matching reference genome.

*   **Basic Plotting**: Generate a plot for a single region.
    `wally region -r chr1:1000-2000 -g reference.fa input.bam`
*   **Custom Plot Names**: Append a name to the region string using a colon.
    `wally region -r chr1:1000-2000:my_variant_plot -g reference.fa input.bam`
*   **Multi-Sample Comparison**: Provide multiple BAM files to view them in a stacked "wallpaper" format (e.g., tumor vs. control).
    `wally region -r chr17:7573900-7574000 -g reference.fa tumor.bam control.bam`

### Batch Processing with BED Files

For large-scale visualization (e.g., plotting all candidates from a VCF), use a BED file.

*   **Execute Batch**: Use `-R` to specify the BED file. The 4th column of the BED file is used as the plot name.
    `wally region -R regions.bed -g reference.fa input.bam`
*   **VCF to BED Conversion**: Prepare regions from a VCF using `bcftools` and `awk` before running wally.
    `bcftools query -f "%CHROM\t%POS\n" input.vcf.gz | awk '{print $1"\t"($2-50)"\t"($2+50)"\tid"NR;}' > regions.bed`

### Structural Variant (SV) Inspection

wally includes specialized modes for identifying and validating SVs.

*   **Paired-End View**: Use `-p` to color-code reads based on insert size and orientation (e.g., blue for inversions, red for deletions).
    `wally region -p -r chrA:100-500 -g reference.fa input.bam`
*   **Breakpoint Highlighting**: Combine `-c` (clipped reads) and `-u` (supplementary alignments) to visualize exact breakpoints.
    `wally region -cup -r chrA:100-500 -g reference.fa input.bam`
*   **Split View**: Use `-s` to concatenate different genomic regions horizontally. This is essential for visualizing translocations or distal rearrangements.
    `wally region -s 2 -r chrA:100-200,chrB:500-600 -g reference.fa input.bam`

### Long-Read and Contig Matches

Use the `matches` subcommand to visualize how a long sequence (read or assembled contig) aligns across the genome.

*   **Single Read Match**: Trace the path of a specific read.
    `wally matches -r read_name_id -g reference.fa input.bam`
*   **Batch Read Matches**: Provide a list of read names in a file.
    `wally matches -R reads.lst -g reference.fa input.bam`

## Advanced Configuration

### Gene Annotations

To display gene models or custom annotations, provide a bgzipped and tabix-indexed BED file.

*   **Add Annotations**: Use the `-b` flag.
    `wally region -b annotations.bed.gz -r chr1:1000-2000 -g reference.fa input.bam`
*   **Custom Colors**: wally reads Hex color codes from the 5th column of the BED file (e.g., `0xFF0000` for red).

### Image Scaling

*   **Adjust Dimensions**: Control the output image size using `-x` (width) and `-y` (height).
    `wally region -x 2048 -y 1024 -r chr1:1000-2000 -g reference.fa input.bam`

## Best Practices

*   **Coordinate Consistency**: Ensure chromosome naming (e.g., "chr1" vs "1") is identical across the reference FASTA, BAM files, and BED annotations. wally does not perform fuzzy matching on contig names.
*   **Index Requirements**: Always ensure BAM/CRAM files are indexed (`.bai`/`.crai`) and the reference FASTA is indexed (`.fai`).
*   **Memory Management**: When creating "wallpapers" with hundreds of samples, increase the vertical Y-dimension (`-y`) to ensure each sample track has sufficient pixel height.
*   **Tabix Indexing**: For any annotation BED file, always run `bgzip` followed by `tabix -p bed <file>.gz` before passing it to wally.

## Reference documentation
- [Wally: Visualization of aligned sequencing reads and contigs](./references/github_com_tobiasrausch_wally.md)
- [wally - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_wally_overview.md)