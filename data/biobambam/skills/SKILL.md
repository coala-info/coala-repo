---
name: biobambam
description: Biobambam2 is a specialized suite of tools designed for the efficient processing of biological alignment files, primarily in BAM and SAM formats.
homepage: https://gitlab.com/german.tischler/biobambam2
---

# biobambam

## Overview
Biobambam2 is a specialized suite of tools designed for the efficient processing of biological alignment files, primarily in BAM and SAM formats. This skill enables the management of common post-alignment tasks such as duplicate marking, coordinate or tag-based sorting, and format interconversion. It is optimized for speed and low memory footprints, making it a standard choice for high-throughput sequencing workflows where early-stage data hygiene is critical.

## Core CLI Patterns and Tools

### Duplicate Marking
Biobambam2 provides several tools for duplicate marking, with `bammarkduplicatesopt` being the most advanced for handling both PCR and optical duplicates.

*   **bammarkduplicatesopt**: Use this for marking or removing duplicates with optical duplicate detection.
    *   `bammarkduplicatesopt I=input.bam O=output.bam rmdup=1`
    *   **Optical Duplicates**: Control the pixel distance for optical duplicate detection using `optminpixeldif` (default is often 100).
*   **bamsormadup**: Use this to perform sorting and duplicate marking in a single pass, which is more IO-efficient than running them separately.
    *   `bamsormadup I=input.bam O=output.bam`

### Format Conversion
*   **bamtofastq**: Converts BAM files back to FASTQ format.
    *   `bamtofastq I=input.bam F=output_R1.fastq F2=output_R2.fastq`
*   **fastqtobam2**: Converts FASTQ files to BAM format.
    *   `fastqtobam2 I=input_R1.fastq I2=input_R2.fastq O=output.bam`
    *   **Key Flags**: Use `clipslashid=1` to handle read IDs ending in `/1` or `/2` and `patchne=1` for specific metadata adjustments.

### Sorting and Validation
*   **bamsort**: High-performance sorting of BAM files.
    *   `bamsort I=input.bam O=output.bam sort=coordinate`
    *   **Tag Sorting**: Use `tagonly=1` if you need to sort specifically by tags rather than coordinates or names.
*   **bamvalidate**: Checks the integrity of a BAM file.
    *   `bamvalidate I=input.bam`
    *   If a file is corrupt, it will report the last valid alignment line to help locate the error.

### Utility Tools
*   **bamadapterhistogram**: Generates a histogram of detected adapter sequences.
*   **bamauxmerge**: Merges auxiliary information from one BAM file into another, useful when merging mapped reads with their original unmapped metadata.
*   **bamaddne**: Adds or modifies metadata tags in an existing BAM file.
*   **bamsalvage**: Attempts to recover data from corrupted BAM files.

## Best Practices
*   **Memory Management**: Biobambam tools are generally memory-efficient, but for very large datasets, monitor the `MemUsage` reports in the standard error output.
*   **Input/Output Syntax**: Most tools use the `I=input` and `O=output` syntax rather than standard Unix redirection or positional arguments.
*   **Compression**: You can control output compression levels using the `level` parameter (e.g., `level=9` for maximum compression).
*   **Piping**: Biobambam tools can often read from standard input or write to standard output by omitting the `I` or `O` parameters or setting them to `/dev/stdin` or `/dev/stdout`, facilitating tool chaining.

## Reference documentation
- [biobambam Overview](./references/anaconda_org_channels_bioconda_packages_biobambam_overview.md)
- [biobambam2 GitLab Repository](./references/gitlab_com_german.tischler_biobambam2.md)
- [biobambam2 ChangeLog](./references/gitlab_com_german.tischler_biobambam2_-_blob_master_ChangeLog.md)