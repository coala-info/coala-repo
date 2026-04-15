---
name: cgpbigwig
description: cgpBigWig is a suite of high-performance C utilities for creating, manipulating, and converting genomic alignment data into BigWig files. Use when user asks to convert BAM or CRAM files to BigWig coverage tracks, concatenate multiple BigWig files, generate per-base composition tracks, or convert BedGraph files to BigWig format.
homepage: https://github.com/cancerit/cgpBigWig
metadata:
  docker_image: "quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0"
---

# cgpbigwig

## Overview

cgpBigWig is a suite of high-performance C utilities designed for the efficient creation and manipulation of BigWig files. By leveraging `libBigWig` and `htslib`, it provides a fast alternative for converting genomic alignment data (BAM/CRAM) into signal tracks suitable for visualization in genome browsers or downstream analysis. The toolset is especially effective for handling large-scale sequencing data where speed and memory efficiency are critical, offering specialized functions for coverage generation, file concatenation, and per-base composition analysis.

## Core CLI Programs and Usage

### 1. Generating Coverage (BAM/CRAM to BigWig)
The `bam2bw` tool is the primary utility for creating coverage tracks.

*   **Basic BAM conversion:**
    `bam2bw -i input.bam -o output.bw`
*   **CRAM conversion (requires reference):**
    `bam2bw -i input.cram -r reference.fa -o output.bw`
*   **Filter by region:**
    `bam2bw -i input.bam -c chr1:1000-5000 -o region_output.bw`
*   **Scale output (RPKM/Normalization):**
    `bam2bw -i input.bam -S <float_scale_factor> -o scaled.bw`

### 2. Concatenating BigWig Files
Use `bwjoin` to merge multiple BigWig files (typically split by chromosome) into a single genome-wide file.

*   **Requirement:** Input files must be named `<contig_name>.bw` and located in the same directory.
*   **Command:**
    `bwjoin -f genome.fai -p /path/to/input_dir/ -o combined_output.bw`

### 3. Per-Base Proportion Analysis
`bam2bwbases` generates four separate BigWig files representing the proportion of A, C, G, and T at each position.

*   **Command:**
    `bam2bwbases -i input.bam -o base_proportions`
    *This will produce: A.base_proportions.bw, C.base_proportions.bw, G.base_proportions.bw, and T.base_proportions.bw.*

### 4. Inspecting and Extracting Data
`bwcat` allows you to view the contents of a BigWig file or extract specific regions to standard output.

*   **View specific region:**
    `bwcat -i input.bw -r chr2:500-1000`
*   **Include NA regions:**
    `bwcat -i input.bw -n`

### 5. BedGraph Conversion
If you have signal data in BedGraph format, use `bg2bw` for fast conversion.

*   **Command:**
    `bg2bw -i input.bed -c chrom.list -o output.bw`
    *Note: `chrom.list` should be a TSV with contig names and lengths.*

## Expert Tips and Best Practices

*   **Handle Overlapping Reads:** When processing paired-end data with `bam2bw`, `bam2bwbases`, or `bam2bedgraph`, always use the `-a` or `--overlap` flag. This prevents double-counting coverage in regions where the two reads of a pair overlap.
*   **Filtering Flags:** By default, `bam2bw` filters out reads with SAM flag 4 (unmapped). You can customize this using `-F` (to exclude) or `-f` (to include specific flags).
*   **Zero Coverage:** In `bam2bw`, use the `-z` flag if your downstream analysis requires explicit entries for regions with zero coverage, which are omitted by default to save space.
*   **Input Sorting:** Ensure your BAM/CRAM files are coordinate-sorted and indexed (`.bai` or `.crai`) before processing.
*   **Memory Efficiency:** For extremely large genomes, `bwjoin` is the preferred method for building a full BigWig—process chromosomes in parallel with `bam2bw` first, then join them.

## Reference documentation

- [cgpBigWig GitHub Repository](./references/github_com_cancerit_cgpBigWig.md)
- [cgpbigwig Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cgpbigwig_overview.md)