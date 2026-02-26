---
name: localhgt
description: This tool manipulates SAM, BAM, and CRAM files. Use when user asks to view, index, sort, merge, or convert sequence alignment files.
homepage: https://github.com/samtools/samtools
---


# localhgt

yaml
name: localhgt
description: Tools for manipulating SAM, BAM, and CRAM files. Use when dealing with next-generation sequencing data formats, particularly for tasks like indexing, viewing, sorting, and converting these files.
```
## Overview
The `localhgt` tool is a command-line utility designed for efficient manipulation of SAM, BAM, and CRAM files, which are standard formats for storing next-generation sequencing data. It provides a suite of functions for common bioinformatics tasks related to these file types.

## Usage Instructions

`localhgt` is part of the samtools suite and is typically used for operations on sequence alignment files.

### Core Commands and Patterns

The primary use of `localhgt` involves interacting with SAM, BAM, and CRAM files. Here are some common and high-utility patterns:

*   **Viewing and Filtering:**
    *   Displaying the content of a BAM/CRAM file:
        ```bash
        localhgt view input.bam
        ```
    *   Filtering alignments based on flags, regions, or other criteria:
        ```bash
        localhgt view -h input.bam  # Show header
        localhgt view -F 4 input.bam # Exclude unmapped reads
        localhgt view input.bam chr1:1000-2000 # View reads in a specific region
        ```

*   **Indexing:**
    *   Creating an index for BAM/CRAM files, which is essential for random access and region-specific queries:
        ```bash
        localhgt index input.bam
        ```
    *   This generates `input.bai` (for BAM) or `input.cram.crai` (for CRAM).

*   **Sorting:**
    *   Sorting BAM/CRAM files, typically by coordinate or by read name. Coordinate sorting is crucial for many downstream analyses and for indexing.
        ```bash
        localhgt sort input.bam -o sorted_input.bam
        localhgt sort -n input.bam -o sorted_by_name.bam # Sort by read name
        ```
    *   The `-o` option specifies the output file. Temporary files are used during sorting, and their location can be influenced by the `TMPDIR` environment variable.

*   **Statistics:**
    *   Generating summary statistics from SAM/BAM/CRAM files. This is invaluable for understanding the quality and characteristics of your sequencing data.
        ```bash
        localhgt stats input.bam
        ```
    *   The output includes metrics like total sequences, mapped/unmapped reads, GC content, etc.

*   **Merging:**
    *   Combining multiple SAM/BAM/CRAM files into a single file.
        ```bash
        localhgt merge output.bam file1.bam file2.bam file3.bam
        ```
    *   Ensure input files are sorted by read name if merging for duplicate marking.

*   **Converting Formats:**
    *   Converting between SAM, BAM, and CRAM formats.
        ```bash
        localhgt view -S input.bam -o output.sam # BAM to SAM
        localhgt view -b input.sam -o output.bam # SAM to BAM
        localhgt view -C input.bam -o output.cram # BAM to CRAM
        localhgt view -b input.cram -o output.bam # CRAM to BAM
        ```

### Expert Tips

*   **Compression Levels:** When converting to BAM or CRAM, you can control the compression level using the `-l` option (e.g., `localhgt view -b -l 9 input.sam -o output.bam` for maximum compression). Higher levels result in smaller files but take longer to compress/decompress.
*   **Multi-threading:** Many `localhgt` commands support multi-threading with the `-@` option, which can significantly speed up processing on multi-core systems. For example: `localhgt view -@ 4 input.bam`.
*   **Header Management:** Be mindful of header information when merging or manipulating files. The `view` command with `-h` can display the header, and options exist to preserve or modify it.
*   **Region Specification:** For large files, querying specific regions (`chr:start-end`) is much faster if the file is indexed.
*   **Temporary Files:** For operations like sorting, `localhgt` uses temporary files. Ensure you have sufficient disk space and that the `TMPDIR` environment variable is set to a suitable location if the default is not adequate.

## Reference documentation
- [Tools (written in C using htslib) for manipulating next-generation sequencing data](./references/github_com_samtools_samtools.md)