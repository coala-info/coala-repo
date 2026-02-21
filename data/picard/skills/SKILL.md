---
name: picard
description: Asserts the validity for specified Illumina basecalling data. This tool will check that the basecall directory and the internal files are available, exist, and are reasonably sized for every tile and cycle.
homepage: http://broadinstitute.github.io/picard/
---

# picard

## Overview

Picard is a comprehensive suite of Java-based utilities designed for the manipulation and analysis of high-throughput sequencing (HTS) data. It is the industry standard for tasks such as marking PCR duplicates, validating file integrity against the SAM specification, and generating detailed alignment and library metrics. Use this skill to construct correct command-line invocations, optimize Java Virtual Machine (JVM) performance for large genomic datasets, and troubleshoot common validation errors encountered during bioinformatics pipelines.

## Command Syntax and Standard Options

Picard tools are invoked via the Java executable. The tool name must be the first argument after the JAR file path.

**Basic Pattern:**
`java [jvm-args] -jar picard.jar ToolName OPTION1=value1 OPTION2=value2`

### Essential JVM Arguments
*   **Memory Allocation**: Most tools require significant RAM. Use `-Xmx` to set the heap size.
    *   Example: `java -Xmx4g -jar picard.jar ...`
*   **Thread Control**: Java's Garbage Collection (GC) can consume all available cores. Limit this with:
    *   `-XX:ParallelGCThreads=2` or `-XX:+UseSerialGC`

### High-Utility Standard Options
*   **VALIDATION_STRINGENCY**: Controls how strictly Picard enforces the SAM format specification.
    *   `STRICT` (Default): Stops execution on any error.
    *   `LENIENT`: Logs errors but continues. Useful for aligners (like BWA) that produce non-standard MAPQ or CIGAR values.
    *   `SILENT`: Suppresses all validation messages.
*   **MAX_RECORDS_IN_RAM**: Controls when records spill to disk during sorting.
    *   *Expert Tip*: Set to ~250,000 records per 1GB of allocated JVM heap.
*   **CREATE_INDEX**: Set to `true` to automatically generate a `.bai` index when writing coordinate-sorted BAM files.

## Common CLI Patterns

### Marking Duplicates
Identifies and tags duplicate reads (PCR or optical) in a BAM/SAM file.
```bash
java -Xmx4g -jar picard.jar MarkDuplicates \
      I=input.bam \
      O=marked_duplicates.bam \
      M=marked_dup_metrics.txt \
      REMOVE_DUPLICATES=false
```

### Adding Read Groups
Required for downstream tools like GATK.
```bash
java -jar picard.jar AddOrReplaceReadGroups \
      I=input.bam \
      O=output.bam \
      RGID=4 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=sample1
```

### Validating SAM/BAM Files
The first step in troubleshooting "corrupt" or "invalid" files.
```bash
java -jar picard.jar ValidateSamFile \
      I=input.bam \
      MODE=SUMMARY
```

### Sorting Files
```bash
java -jar picard.jar SortSam \
      I=input.bam \
      O=sorted.bam \
      SORT_ORDER=coordinate
```

## Expert Tips and Best Practices

*   **Piping and I/O**: Most Picard tools can read from `stdin` and write to `stdout`.
    *   Read: `I=/dev/stdin`
    *   Write: `O=/dev/stdout QUIET=true`
    *   *Note*: Picard defaults to BAM format for stdout. Use `COMPRESSION_LEVEL=0` when piping to another tool to save CPU cycles.
*   **Handling "CIGAR M operator maps off end of reference"**: This common error occurs when reads align past the end of a contig. Use `CleanSam` to soft-clip these reads before further processing.
*   **MarkDuplicates vs Samtools rmdup**: Always prefer Picard `MarkDuplicates` for library-level analysis, as it handles inter-chromosomal duplicates which `samtools rmdup` typically ignores.
*   **Temporary Files**: For large sorts, Picard creates many temp files. Use `TMP_DIR=/path/to/large_disk` to avoid filling up the `/tmp` partition.
*   **Assume Sorted**: If you know your input is already sorted but the header is missing the `SO:coordinate` tag, use `ASSUME_SORTED=true` to skip redundant sorting in tools like `MarkDuplicates`.

## Reference documentation
- [Command Line Overview](./references/broadinstitute_github_io_picard_command-line-overview.html.md)
- [Frequently Asked Questions](./references/broadinstitute_github_io_picard_faq.html.md)
- [SAM Differences in Picard](./references/broadinstitute_github_io_picard_sam-differences.html.md)
- [Picard Metrics Definitions](./references/broadinstitute_github_io_picard_picard-metric-definitions.html.md)