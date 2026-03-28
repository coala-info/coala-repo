---
name: peakranger
description: PeakRanger is a high-performance software suite designed to analyze ChIP-Seq data by identifying enriched genomic regions and discovering precise summits. Use when user asks to call narrow or broad peaks, estimate library complexity, calculate signal-to-noise ratios, or generate wiggle files for visualization.
homepage: https://anaconda.org/channels/bioconda/packages/peakranger/overview
---


# peakranger

## Overview
PeakRanger is a high-performance software suite designed for the analysis of next-generation sequencing (NGS) data, specifically ChIP-Seq. It excels at identifying enriched genomic regions and discovering precise summits within those regions. The suite is versatile, offering specialized algorithms for narrow peaks (ranger) and broad peaks (ccat, bcp), as well as utility tools for quality control and visualization.

## Core Tools and Usage

### Peak Calling
*   **ranger**: Optimized for narrow peaks. Uses an FDR-based adaptive thresholding algorithm.
    *   `peakranger ranger <data.bam> <control.bam> <output_prefix>`
    *   **Key Parameters**:
        *   `-l <int>`: Read extension length (default: 200). Adjust based on your fragment size.
        *   `-r <float>`: Delta-r sensitivity for summit searching. Smaller values generate more summits.
        *   `-b <int>`: Smoothing bandwidth. Higher values reduce false summits but may degrade accuracy.
        *   `-p <float>`: P-value threshold for binomial distribution significance.
*   **ccat**: Specifically tuned for broad peaks, such as histone modification marks.
*   **bcp**: A Bayesian Change-Point method for broad peak calling. Note: Unlike `ranger` and `ccat`, the current implementation of `bcp` does not support summit calling.

### Quality Control
*   **nr (Noise Rate)**: Estimates the signal-to-noise ratio by comparing data to control.
*   **lc (Library Complexity)**: Calculates the ratio of unique reads to total reads.
    *   **Requirement**: Only accepts BAM files.
    *   **Memory**: Requires approximately 1.7GB RAM per 10 million aligned reads.

### Visualization (Wiggle Generation)
*   **wig**: Generates variable step format wiggle files.
*   **wigpe**: Generates bedGraph format files. Supports spliced alignments (useful for RNA-Seq) and requires BAM input.
    *   Use `--split` to generate individual files per chromosome for faster loading in genome browsers.

## Expert Tips and Best Practices

### Post-Processing with wigReg
PeakRanger's native wiggle output often uses an initial span of 1 for every interval. This can cause visualization issues in genome browsers and interfere with downstream comparison tools.
*   Use the **wigReg** utility to regulate these files.
*   **Command**: `wigReg -p PR -f 200 -s 10 input.wig output.wig`
*   This extends singleton features and manages resolution (e.g., setting a 10bp space) to reduce file size and memory overhead.

### HTML Annotation Reports
Both `ranger` and `ccat` can generate HTML-based annotation reports using the `--report` and `--gene_annot_file` flags.
*   **Dependency**: Requires the R programming environment to be installed on the system to generate the final report.
*   **Performance**: Large peak sets may result in very large HTML files that are slow for web browsers to parse.

### Read Extension
Always verify your fragment size. The default extension of 200bp (`-l 200`) is a standard heuristic, but if your library preparation differs significantly, peak height and summit accuracy will be affected.



## Subcommands

| Command | Description |
|---------|-------------|
| bcp | Peakranger BCP (Broadly Conserved Peaks) tool for identifying conserved peaks. |
| ccat | ccat 1.18 |
| lc | PeakRanger LC |
| nr | Not enough command options. |
| ranger | Peak calling tool for ChIP-seq data |
| wig | Converts various genomic data formats to WIG format. |
| wigpe | WigPE 1.18 |

## Reference documentation
- [PeakRanger GitHub README](./references/github_com_drestion_peakranger.md)
- [wigReg Documentation](./references/github_com_fnaumenko_wigReg_blob_master_README.md)