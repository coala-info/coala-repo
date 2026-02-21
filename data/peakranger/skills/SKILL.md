---
name: peakranger
description: PeakRanger is a high-performance software suite designed for the analysis of Next-Generation Sequencing (NGS) data, with a primary focus on ChIP-Seq.
homepage: https://github.com/drestion/peakranger
---

# peakranger

## Overview
PeakRanger is a high-performance software suite designed for the analysis of Next-Generation Sequencing (NGS) data, with a primary focus on ChIP-Seq. It provides a collection of specialized tools that handle different aspects of the peak-calling workflow, from quality control (noise estimation and library complexity) to the identification of both narrow and broad enriched regions. The suite is particularly noted for its "ranger" tool, which uses a staged algorithm to find enriched regions and discover summits within them with high sensitivity.

## Tool Selection Guide
Choose the specific sub-tool based on your data type and analysis goal:
- **ranger**: Best for narrow-peak calling (e.g., transcription factor binding sites).
- **ccat**: Optimized for broad-peak calling, specifically histone modification marks.
- **bcp**: An alternative broad-peak caller using a Bayesian change-point method.
- **nr**: Use to estimate the signal-to-noise ratio (indicator of ChIP enrichment).
- **lc**: Use to calculate library complexity (ratio of unique reads to total reads).
- **wig / wigpe**: Use to generate coverage files for genome browser visualization.

## Common CLI Patterns and Parameters

### Narrow Peak Calling (ranger)
The `ranger` tool identifies enriched regions and then searches for summits.
- **Sensitivity (`-r`)**: Controls sub-summit discovery. A smaller value increases the number of summits found.
- **Smoothing (`-b`)**: Adjusts the smoothing bandwidth. Higher values reduce false summits but may degrade summit accuracy.
- **P-value (`-p`)**: Sets the significance threshold for enriched regions based on a binomial distribution.
- **Read Extension (`-l`)**: Extends reads to a specific fragment size (default is 200bp). Adjust this to match your specific library preparation.
- **Annotation (`--report`, `--gene_annot_file`)**: Generates HTML-based annotation reports (requires R environment).

### Broad Peak Calling (ccat and bcp)
- Use **ccat** when you need summit calling for broad peaks.
- Use **bcp** for a Bayesian approach to broad peaks, but note that the current implementation does not support summit calling.

### Quality Control (nr and lc)
- **nr**: Compares the sample and control to estimate how much the data departs from the background noise.
- **lc**: Requires BAM files. Note that `lc` is memory-intensive, requiring approximately 1.7GB of RAM per 10 million aligned reads.

### Visualization (wig and wigpe)
- **wig**: Generates variable step format wiggle files.
- **wigpe**: Generates bedGraph format. It supports spliced alignments, making it the preferred choice for BAM files containing RNA-Seq data or spliced reads.
- **Optimization (`--split`)**: Use this flag to generate one small wiggle file per chromosome, which reduces memory usage when loading data into genome browsers.

## Expert Tips
- **Summit Accuracy**: If your peaks appear too fragmented, increase the smoothing bandwidth (`-b`). If you are missing closely spaced binding sites, decrease the delta-r (`-r`).
- **HTML Reports**: While `ranger` and `ccat` can run without R, the HTML report generation will fail if R is not in the system path.
- **RNA-Seq Coverage**: Even though PeakRanger is a "peak caller," `wigpe` is highly effective for generating coverage tracks for RNA-Seq due to its native support for spliced reads in BAM files.

## Reference documentation
- [PeakRanger Main Documentation](./references/github_com_drestion_peakranger.md)