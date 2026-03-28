---
name: bamkit
description: Bamkit is a suite of Python utilities designed for specialized BAM file transformations, header cleaning, and alignment flag corrections. Use when user asks to clean BAM headers, convert secondary alignments to supplementary, fix bitwise flags, filter by read group, or convert BAM files to FASTQ.
homepage: https://github.com/hall-lab/bamkit
---

# bamkit

## Overview

`bamkit` is a specialized suite of Python-based utilities designed to handle common but specific BAM file transformations that are often required before structural variant calling or complex genomic analyses. While `samtools` provides general-purpose manipulation, `bamkit` focuses on procedural tasks like cleaning headers of non-standard tags, converting secondary alignments to supplementary alignments, and ensuring bitwise flags are consistent across read pairs.

## Tool-Specific Best Practices

### Header Management
*   **Cleaning Headers**: Use `bamcleanheader.py` to remove extraneous tags or non-standard formatting from BAM headers. This is often necessary when merging files from different sources that cause compatibility issues with strict parsers.
    *   *Note*: Recent versions support multiple input BAM files as positional arguments rather than using the `-i` flag.
*   **Read Group Injection**: Use `bamheadrg.py` to modify or add Read Group (`@RG`) information directly to the header, ensuring downstream tools can correctly attribute reads to specific samples or libraries.

### Flag and Alignment Correction
*   **Secondary to Supplementary**: Use `sectosupp` to convert secondary alignment flags to supplementary flags. This is a critical step for certain structural variant callers that rely on the supplementary flag to identify split-reads.
*   **Flag Fixing**: Use `bamfixflags.py` to repair inconsistent bitwise flags, particularly after manual BAM filtering or custom processing that may have left paired-end information in an invalid state.

### Data Extraction and Conversion
*   **BAM to FASTQ**: Use `bamtofastq.py` for a streamlined conversion process. This is preferred when you need to re-align data starting from an existing BAM file while preserving original read metadata.
*   **Library Identification**: Use `bamlibs.py` to quickly extract and list the library identifiers present within a BAM file's read groups.

### Filtering and Grouping
*   **Read Group Filtering**: Use `bamfilterrg.py` to create a new BAM file containing only reads belonging to a specific Read Group ID.
*   **Read Grouping**: Use `bamgroupreads.py` to organize or tag reads based on shared metadata, useful for custom QC or pre-processing workflows.

## Expert Tips
*   **Pysam Dependency**: Ensure `pysam` is installed in the environment, as the majority of these tools are Python wrappers around the `pysam` library.
*   **Pipe Compatibility**: Most `bamkit` tools are designed to work with standard streams. You can often pipe `samtools view -h` output into these scripts to avoid creating intermediate files.
*   **Python 3 Transition**: While originally developed for Python 2.7, ensure you are using the updated versions (often found in the master branch or specific PRs) if working in a Python 3 environment.



## Subcommands

| Command | Description |
|---------|-------------|
| bamgroupreads.py | Group BAM file by read IDs without sorting |
| bamheadrg.py | Inject readgroup info |
| bamkit_bamcleanheader.py | remove illegal and malformed fields from a BAM file's header |
| bamkit_bamfilterrg.py | Filter BAM files by read group. |
| bamlibs.py | output comma delimited string of read group IDs for each library |
| bamtofastq.py | Convert a coordinate sorted BAM file to FASTQ (ignores unpaired reads) |

## Reference documentation
- [hall-lab/bamkit GitHub Repository](./references/github_com_hall-lab_bamkit.md)
- [bamkit Commits and Version History](./references/github_com_hall-lab_bamkit_commits_master.md)