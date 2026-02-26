---
name: cramtools
description: cramtools is a Java-based suite used for the compression, conversion, and manipulation of genomic sequence data between BAM and CRAM formats. Use when user asks to convert BAM to CRAM, restore CRAM to BAM, index genomic files, merge sequence data, or apply lossy quality score compression models.
homepage: https://github.com/enasequence/cramtools
---


# cramtools

## Overview

cramtools is a Java-based suite designed for the efficient compression and manipulation of genomic sequence read data. It serves as a bridge between the standard BAM format and the highly compressed CRAM format. You should use this skill to reduce the storage footprint of sequencing data by leveraging reference-based compression and customizable lossy models for quality scores. While the project is archived in favor of htslib/samtools, it remains a specific requirement for legacy pipelines and Java-based environments requiring direct CRAM 3.0 support.

## Core CLI Usage

All commands are executed via the runnable JAR file.

### BAM to CRAM Conversion
To convert a BAM file to CRAM, you must provide a reference fasta file.
```bash
java -jar cramtools-3.0.jar cram \
  --input-bam-file <input.bam> \
  --reference-fasta-file <reference.fasta> \
  --output-cram-file <output.cram>
```

### CRAM to BAM Conversion
To restore a BAM file from a CRAM archive:
```bash
java -jar cramtools-3.0.jar bam \
  --input-cram-file <input.cram> \
  --reference-fasta-file <reference.fasta> \
  --output-bam-file <output.bam>
```

### Indexing and Utilities
*   **Index**: Generate a `.crai` or `.bai` index for a CRAM file.
    `java -jar cramtools-3.0.jar index --input-file <file.cram>`
*   **Merge**: Combine multiple SAM/BAM/CRAM files.
    `java -jar cramtools-3.0.jar merge --input-file <file1> --input-file <file2> --output-file <merged.cram>`
*   **Fastq**: Dump reads into FASTQ format.
    `java -jar cramtools-3.0.jar fastq --input-cram-file <file.cram>`
*   **QStat**: Generate quality score statistics.
    `java -jar cramtools-3.0.jar qstat --input-cram-file <file.cram>`

## Lossy Compression Models

cramtools allows for significant space savings by selectively degrading quality scores using the `--lossy-model` flag. The model string uses selectors and quality treatments (binning or full precision).

### Selector Keys
*   `R`: Bases matching the reference.
*   `N`: Mismatched bases.
*   `U`: Unmapped reads.
*   `D`: Positions flanking a deletion.
*   `Mn`: Mapping quality higher than *n*.
*   `mn`: Mapping quality lower than *n*.
*   `*`: All bases/reads.

### Treatment Keys
*   `40`: Preserve full precision (40 values).
*   `8`: Apply Illumina 8-binning scheme.

### Common Patterns
*   **Preserve mismatches, bin others**: `N40-*8` (Full precision for mismatches, 8-binning for everything else).
*   **Preserve low mapping quality**: `m5` (Keep full quality for reads with MapQ < 5).
*   **Bin all**: `*8` (Apply 8-binning to every quality score in the file).

## Expert Tips and Best Practices

*   **Reference Integrity**: Ensure your reference fasta has a corresponding `.fai` index (created via `samtools faidx`). cramtools relies heavily on the reference for coordinate-sorted data.
*   **Reference Discovery**: If the local reference path is not provided, cramtools attempts to download sequences from the ENA reference registry using MD5 checksums found in the SAM header.
*   **Environment Variables**: Use `REF_PATH` and `REF_CACHE` to manage local reference caches, similar to htslib behavior, to avoid redundant downloads.
*   **Header Fixes**: If a CRAM file has incorrect MD5 checksums in the header, use the `fixheader` command to resolve reference alignment issues without re-compressing the entire file.

## Reference documentation
- [cramtools Main Documentation](./references/github_com_enasequence_cramtools.md)
- [Known Issues and Troubleshooting](./references/github_com_enasequence_cramtools_issues.md)