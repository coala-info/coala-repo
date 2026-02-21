---
name: bamutil
description: The `bamutil` suite provides a comprehensive set of tools for processing high-throughput sequencing data in SAM/BAM formats.
homepage: http://genome.sph.umich.edu/wiki/BamUtil
---

# bamutil

## Overview
The `bamutil` suite provides a comprehensive set of tools for processing high-throughput sequencing data in SAM/BAM formats. It is particularly effective for post-alignment processing tasks such as soft-clipping adapters, merging multiple BAM files, and generating detailed alignment statistics. Use this skill to construct efficient command-line strings for the `bam` executable, ensuring proper handling of read groups, quality scores, and coordinate sorting.

## Common Command Patterns

### File Manipulation and Merging
*   **Merge BAMs**: Combine multiple BAM files into one while maintaining header integrity.
    `bam merge --in file1.bam --in file2.bam --out merged.bam`
*   **Split by Chromosome**: Extract specific regions from a BAM file.
    `bam splitChrom --in input.bam --out prefix`

### Quality Control and Validation
*   **Validate BAM**: Check for file corruption or formatting errors.
    `bam validate --in input.bam`
*   **Alignment Statistics**: Generate a summary of mapping quality and coverage.
    `bam stats --in input.bam --basic`

### Read Processing
*   **Clip Adapters**: Soft-clip overlapping reads or known adapter sequences.
    `bam clipOverlap --in input.bam --out clipped.bam`
*   **Filter Reads**: Remove reads based on specific flags or mapping quality.
    `bam filter --in input.bam --out filtered.bam --mapQual 30`

### Conversion and Indexing
*   **BAM to SAM**: Convert binary format to human-readable text.
    `bam convert --in input.bam --out output.sam`
*   **Index BAM**: Create a `.bai` index for rapid coordinate-based access.
    `bam index --in input.bam`

## Expert Tips
*   **Single Executable**: Remember that all sub-commands are accessed via the primary `bam` command (e.g., `bam <subcommand>`).
*   **Piping**: Many `bamutil` commands support streaming via stdin/stdout using `-` as a filename, which is useful for complex pipelines to avoid intermediate disk I/O.
*   **Memory Management**: When merging large numbers of files, monitor open file handles; you may need to increase `ulimit -n` or merge in batches.
*   **Soft-Clipping**: Use `clipOverlap` specifically for paired-end data where reads overlap to prevent double-counting of evidence in variant calling.

## Reference documentation
- [bamutil Overview](./references/anaconda_org_channels_bioconda_packages_bamutil_overview.md)