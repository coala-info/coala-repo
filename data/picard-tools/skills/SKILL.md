---
name: picard-tools
description: Picard-tools is a Java-based toolkit for processing and manipulating high-throughput sequencing data formats like SAM, BAM, CRAM, and VCF. Use when user asks to mark duplicates, validate alignment files, sort SAM or BAM files, or manage read group information in genomic data.
homepage: http://broadinstitute.github.io/picard/
---


# picard-tools

## Overview
Picard is the industry-standard toolkit for handling Next-Generation Sequencing (NGS) data formats. It provides robust, Java-based implementations for processing alignment files (SAM/BAM/CRAM) and variant files (VCF). This skill enables the precise execution of genomic workflows, ensuring data adheres to strict specifications required by downstream analysis pipelines like GATK.

## Core Command Syntax
Picard tools are executed via a single JAR file. The tool name must be the first argument following the JAR path.

```bash
java [jvm-args] -jar picard.jar ToolName OPTION1=value1 OPTION2=value2
```

### Standard JVM Arguments
*   **Memory Allocation**: Most tools require at least 2GB. Use `-Xmx2g` or higher for large files.
*   **Garbage Collection**: To prevent the JVM from consuming all available CPU cores for GC, use `-XX:ParallelGCThreads=1`.

## Essential Workflows

### 1. Quality Control and Validation
Always validate files before processing to catch header errors or truncated data.
*   **ValidateSamFile**: Use `MODE=SUMMARY` for a quick check or `MODE=VERBOSE` for detailed error lists.
*   **CollectAlignmentSummaryMetrics**: Generates comprehensive stats on mapping rates, mismatch rates, and indel rates. Requires a `REFERENCE_SEQUENCE`.

### 2. Duplicate Marking
Identifying PCR or optical duplicates is critical for variant calling accuracy.
*   **MarkDuplicates**: Use `REMOVE_DUPLICATES=false` (default) to flag reads with the 0x400 bit, or `true` to delete them.
*   **Optimization**: For large datasets, increase `MAX_RECORDS_IN_RAM` (e.g., 500000) to reduce disk I/O.

### 3. Header and Read Group Management
Many tools require specific Read Group (`@RG`) information.
*   **AddOrReplaceReadGroups**: Use this to assign a single read group to all reads in a file. Required fields: `RGID`, `RGLB`, `RGPL` (e.g., illumina), `RGPU`, and `RGSM`.
*   **ReplaceSamHeader**: Useful for fixing incorrect sequence dictionaries or sort orders without re-aligning.

### 4. Sorting and Conversion
*   **SortSam**: Converts between `queryname` (for name-sorted tasks like `SamToFastq`) and `coordinate` (for most downstream analysis).
*   **SamFormatConverter**: Efficiently converts between SAM and BAM formats.

## Expert Tips & Best Practices
*   **Validation Stringency**: If a tool fails due to minor formatting issues (e.g., MAPQ for unmapped reads), use `VALIDATION_STRINGENCY=LENIENT`. Use `SILENT` only if performance is critical and the data is known to be clean.
*   **Piping Data**: Use `/dev/stdin` and `/dev/stdout` for streaming. Add `QUIET=true` to prevent status messages from corrupting the output stream.
*   **Indexing**: Set `CREATE_INDEX=true` when running `SortSam` or `MarkDuplicates` on coordinate-sorted data to generate `.bai` files automatically.
*   **Temporary Files**: For large sorts, specify `TMP_DIR` to a high-performance scratch disk to avoid filling up the system `/tmp` partition.

## Reference documentation
- [Command Line Overview](./references/broadinstitute_github_io_picard_command-line-overview.html.md)
- [Frequently Asked Questions](./references/broadinstitute_github_io_picard_faq.html.md)
- [Picard Metrics Definitions](./references/broadinstitute_github_io_picard_picard-metric-definitions.html.md)
- [SAM Differences in Picard](./references/broadinstitute_github_io_picard_sam-differences.html.md)