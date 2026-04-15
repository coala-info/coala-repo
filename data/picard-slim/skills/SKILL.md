---
name: picard-slim
description: The picard-slim tool provides a streamlined version of the Picard toolkit for performing high-throughput sequencing data manipulation tasks like marking duplicates and sorting BAM files. Use when user asks to mark duplicates, sort SAM or BAM files, validate alignment files, or add and replace read groups.
homepage: http://broadinstitute.github.io/picard/
metadata:
  docker_image: "quay.io/biocontainers/picard-slim:3.4.0--hdfd78af_0"
---

# picard-slim

## Overview
The `picard-slim` package is a streamlined version of the Picard toolkit, specifically designed to reduce the installation footprint by removing R dependencies. While this makes it ideal for containerized environments and cloud workflows, it means that any tool attempting to generate R-based plots (such as certain metrics tasks) will fail. This skill provides the necessary command-line patterns and optimization strategies for using Picard's core Java-based functionality effectively.

## Core Command Syntax
Picard tools are invoked via a single Java executable. The general structure is:

```bash
java [jvm-args] -jar picard.jar [ToolName] [OPTION1=value1] [OPTION2=value2] ...
```

### Standard JVM Arguments
*   **Memory Allocation**: Most tools require at least 2GB. Use `-Xmx2g`. For large files or `MarkDuplicates`, increase this as needed.
*   **Garbage Collection**: To prevent Picard from consuming all available CPU cores for GC, use `-XX:ParallelGCThreads=1` or `-XX:+UseSerialGC`.

## Essential Tool Patterns

### 1. MarkDuplicates
Identifies and tags duplicate reads. This is memory-intensive.
```bash
java -Xmx4g -jar picard.jar MarkDuplicates \
      I=input.bam \
      O=marked_duplicates.bam \
      M=marked_dup_metrics.txt \
      CREATE_INDEX=true
```
*Note: In picard-slim, the metrics file is generated, but any associated PDF plots will not be created.*

### 2. SortSam
Sorts a SAM or BAM file by coordinate or queryname.
```bash
java -Xmx2g -jar picard.jar SortSam \
      I=input.bam \
      O=sorted.bam \
      SORT_ORDER=coordinate
```

### 3. ValidateSamFile
Crucial for troubleshooting files from non-standard aligners.
```bash
java -jar picard.jar ValidateSamFile \
      I=input.bam \
      MODE=SUMMARY
```

### 4. AddOrReplaceReadGroups
Assigns all reads in a file to a single new read group.
```bash
java -jar picard.jar AddOrReplaceReadGroups \
      I=input.bam \
      O=output.bam \
      RGID=1 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=sample1
```

## Expert Tips and Best Practices

### Handling Validation Errors
Many aligners (like BWA) produce outputs that Picard considers "invalid" (e.g., MAPQ should be 0 for unmapped reads). 
*   **Lenient Processing**: Use `VALIDATION_STRINGENCY=LENIENT` to turn errors into warnings.
*   **Silent Processing**: Use `VALIDATION_STRINGENCY=SILENT` to ignore validation entirely for a performance boost.

### Performance Optimization
*   **RAM Management**: Set `MAX_RECORDS_IN_RAM`. A rule of thumb for 100bp reads is 250,000 records per GB of heap space.
*   **Temporary Files**: For large sorts, specify a high-performance disk for temporary data: `TMP_DIR=/path/to/fast/scratch`.
*   **Compression**: When piping output to another tool, use `COMPRESSION_LEVEL=0` to save CPU cycles.

### Piping with Stdin/Stdout
Picard can read from and write to pipes using the `/dev` interface:
*   **Read**: `I=/dev/stdin`
*   **Write**: `O=/dev/stdout QUIET=true` (Note: Picard defaults to BAM format when writing to stdout).

## Reference documentation
- [Picard Command Line Overview](./references/broadinstitute_github_io_picard_command-line-overview.html.md)
- [Picard FAQ](./references/broadinstitute_github_io_picard_faq.html.md)
- [SAM Differences in Picard](./references/broadinstitute_github_io_picard_sam-differences.html.md)
- [Picard Metrics Definitions](./references/broadinstitute_github_io_picard_picard-metric-definitions.html.md)