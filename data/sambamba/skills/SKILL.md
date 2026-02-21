---
name: sambamba
description: Sambamba is a high-performance toolset designed for the efficient manipulation of SAM (Sequence Alignment/Map) and BAM (Binary Alignment/Map) files.
homepage: https://github.com/biod/sambamba
---

# sambamba

## Overview

Sambamba is a high-performance toolset designed for the efficient manipulation of SAM (Sequence Alignment/Map) and BAM (Binary Alignment/Map) files. Written in the D programming language, it excels in multi-core environments by parallelizing BAM reading and writing operations. It serves as a faster alternative to many samtools and Picard functions, making it particularly useful for large-scale genomic data processing where speed and resource efficiency are paramount.

## Core CLI Usage and Patterns

### High-Performance Viewing and Filtering
Use `sambamba view` to convert between formats or filter reads. It is significantly faster than samtools for large datasets.

*   **Convert BAM to SAM (Parallel):**
    `sambamba view -t 8 input.bam > output.sam`
*   **Filter by Region (using index):**
    `sambamba view input.bam chr1:100-200`
*   **Filter using expressions:**
    `sambamba view -F "mapping_quality >= 30 and not (unmapped or secondary_alignment)" input.bam`
*   **Extract reads in a BED file:**
    `sambamba view -L regions.bed input.bam` (Utilizes the index to skip unrelated chunks).

### Efficient Sorting
`sambamba sort` is optimized for machines with large amounts of RAM.

*   **Standard Coordinate Sort:**
    `sambamba sort -t 8 -m 4G -o sorted.bam input.bam`
*   **Automatic Indexing:**
    Sambamba automatically creates a `.bai` index when writing a coordinate-sorted file, saving a separate indexing step.

### Marking Duplicates
`sambamba markdup` provides a fast implementation of the Picard duplicate-marking algorithm.

*   **Mark Duplicates (Parallel):**
    `sambamba markdup -t 8 input.bam output.bam`
*   **Remove Duplicates:**
    `sambamba markdup -r input.bam output.bam`

### Coverage Depth Analysis
The `depth` tool allows for rapid calculation of coverage metrics.

*   **Base-level coverage:**
    `sambamba depth base input.bam`
*   **Region-level coverage:**
    `sambamba depth region -L regions.bed input.bam`

### Slicing and Merging
*   **Quick Extraction:**
    `sambamba slice input.bam chr1:1000-2000` (Quickly extracts a region into a new file by tweaking only the boundary chunks).
*   **Merging Files:**
    `sambamba merge output.bam input1.bam input2.bam input3.bam`

## Expert Tips and Best Practices

*   **Thread Allocation:** Always specify the number of threads with `-t` or `--nthreads`. Sambamba scales well, but over-allocating threads beyond physical cores can lead to diminishing returns due to I/O bottlenecks.
*   **Memory Management:** For `sort`, use the `-m` flag to allocate sufficient memory. On machines with 120GB+ RAM, Sambamba can be up to 2x faster than samtools.
*   **Piping:** Sambamba supports standard Unix piping. Use `/dev/stdin` or `/dev/stdout` as filenames to integrate into complex command-line strings.
*   **Filter Syntax:** Familiarize yourself with the filter expression syntax (e.g., `[XS] == ".."`, `cigar =~ /^100M/`). This allows for complex read filtering without writing custom scripts.
*   **CRAM Support:** Note that as of version 0.8, CRAM support was removed. Use samtools for CRAM-to-BAM conversion before processing with Sambamba.

## Reference documentation
- [github_com_biod_sambamba.md](./references/github_com_biod_sambamba.md)
- [github_com_biod_sambamba_wiki.md](./references/github_com_biod_sambamba_wiki.md)
- [anaconda_org_channels_bioconda_packages_sambamba_overview.md](./references/anaconda_org_channels_bioconda_packages_sambamba_overview.md)