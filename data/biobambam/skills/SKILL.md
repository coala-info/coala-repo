---
name: biobambam
description: Biobambam is a suite of high-performance tools designed for the efficient manipulation, sorting, and duplicate marking of biological alignment files. Use when user asks to mark or remove duplicates, sort BAM files, convert between BAM and FastQ formats, or validate and repair alignment files.
homepage: https://gitlab.com/german.tischler/biobambam2
metadata:
  docker_image: "quay.io/biocontainers/biobambam:2.0.185--h85de650_1"
---

# biobambam

## Overview

biobambam2 is a suite of high-performance tools designed for the efficient manipulation of biological alignment files. It is primarily used in Next-Generation Sequencing (NGS) pipelines for tasks that occur immediately after alignment, such as marking PCR and optical duplicates, sorting reads by various criteria, and converting between BAM and FastQ formats. The suite is optimized for speed and memory efficiency, often providing faster alternatives to similar functions in Picard or Samtools.

## Core Tools and Usage Patterns

Biobambam tools typically use a `Key=Value` command-line syntax rather than standard POSIX flags.

### Duplicate Marking
- **bammarkduplicatesopt**: The standard tool for marking or removing duplicates.
  - `I=input.bam`: Input file.
  - `O=output.bam`: Output file.
  - `rmdup=1`: Set to 1 to remove duplicate reads from the output; 0 to only mark them in the BAM flags.
  - `optminpixeldif=100`: Minimum pixel distance for optical duplicate detection.
- **bamsormadup**: Performs sorting and duplicate marking in a single pass, which is more IO-efficient for raw alignments.

### Sorting
- **bamsort**: Used for sorting BAM files.
  - `index=1`: Create a BAM index during sorting.
  - `level=9`: Set output compression level (0-9).
  - `sort=tagonly`: A specialized sort option for sorting by specific tags.

### Format Conversion
- **bamtofastq**: Extracts sequences from BAM files into FastQ format.
  - Useful for re-aligning data to a different reference genome.
- **fastqtobam2**: Converts FastQ files to unaligned BAM.
  - `clipslashid=1`: Clips `/1` or `/2` suffixes from read IDs.
  - `patchne=1`: Applies specific patches for read name encoding.

### Validation and Utility
- **bamvalidate**: Checks the integrity of a BAM file. It reports the last valid alignment line in case of failure.
- **bamadapterhistogram**: Counts the names of detected adapters in a BAM file.
- **bamsalvage**: Attempts to recover data from corrupted BAM files.
- **bamfastcat**: Efficiently concatenates multiple BAM files. Use `O=output.bam` to specify the destination.

## Expert Tips

- **Compression**: When storage space is a concern or for final archival, always use `level=9` in tools like `bamsort` or `bammarkduplicatesopt`.
- **Memory Management**: Biobambam tools are designed to be memory-efficient, but for very large datasets, monitor the `MemUsage` reports in the standard error output to ensure the system is not swapping.
- **Piping**: Many biobambam tools support input from stdin and output to stdout using `/dev/stdin` and `/dev/stdout` or specific tool-defined defaults, allowing them to be chained without intermediate file writes.
- **Optical Duplicates**: If working with patterned flowcells (e.g., NovaSeq), ensure `optminpixeldif` is tuned to the specific platform's recommendations to avoid over-calling optical duplicates.



## Subcommands

| Command | Description |
|---------|-------------|
| bamauxmerge | Merges BAM files. |
| biobambam2 | Mark duplicates in BAM files. |
| biobambam2 | Validate BAM/CRAM files and perform conversions. |
| biobambam_bamsormadup | Sorts and marks duplicate reads in BAM files. |
| biobambam_bamsort | Sorts BAM/SAM/CRAM files. |
| biobambam_bamtofastq | Convert BAM/SAM/CRAM to FASTQ format. |

## Reference documentation
- [biobambam2 Project Overview](./references/gitlab_com_german.tischler_biobambam2.md)
- [biobambam2 README](./references/gitlab_com_german.tischler_biobambam2_-_blob_master_README.md)
- [biobambam2 ChangeLog](./references/gitlab_com_german.tischler_biobambam2_-_blob_master_ChangeLog.md)