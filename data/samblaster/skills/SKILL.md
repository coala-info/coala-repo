---
name: samblaster
description: "samblaster marks duplicate reads and extracts discordant or split read pairs from read-id grouped SAM files. Use when user asks to mark duplicates, extract discordant read pairs, or isolate split-read mappings for structural variant analysis."
homepage: https://github.com/GregoryFaust/samblaster
---


# samblaster

## Overview
samblaster is a high-performance tool designed for bioinformatics pipelines to handle duplicate marking and read extraction in a single pass. It operates on read-id grouped SAM files, making it ideal for streaming data directly from aligners. Beyond marking duplicates, it is a standard tool for preparing data for structural variant callers by isolating discordant and split reads.

## Common CLI Patterns

### Standard Duplicate Marking in a Pipeline
The most efficient way to use samblaster is by piping output directly from an aligner like `bwa mem`.
```bash
bwa mem <index> read1.fq read2.fq | samblaster | samtools view -Sb - > output.bam
```

### Structural Variant (SV) Read Extraction
To extract discordant pairs and split reads into separate files while marking duplicates in the main stream:
```bash
bwa mem <index> r1.fq r2.fq | samblaster -e -d discordant.sam -s splitters.sam | samtools view -Sb - > output.bam
```
*   `-d`: Output discordant read pairs (pairs where the mapping distance or orientation is unexpected).
*   `-s`: Output split-read mappings (chimeric reads).
*   `-e`: Exclude reads marked as duplicates from the discordant and splitter files.

### Compatibility with BWA MEM -M
If using the `-M` flag in `bwa mem` (to mark shorter split hits as secondary for Picard compatibility), you must also use the `-M` flag in samblaster.
```bash
bwa mem -M <index> r1.fq r2.fq | samblaster -M | samtools view -Sb - > output.bam
```

### Processing Existing BAM Files
To pull SV reads from a BAM file that already has duplicate marks:
```bash
samtools view -h input.bam | samblaster -a -e -d disc.sam -s split.sam -o /dev/null
```
*   `-a`: Accept existing duplicate marks (0x400 flag) instead of re-calculating.
*   `-o /dev/null`: Discard the main SAM stream if only the extracted files are needed.

### Handling Long Reads or Singletons
For singleton long reads (e.g., ONT or PacBio) where you want to extract split or unmapped reads:
```bash
samtools view -h input.bam | samblaster --ignoreUnmated --maxReadLength 100000 -s split.sam -u unmapped.fastq | samtools view -Sb - > output.bam
```
*   `--ignoreUnmated`: Suppresses errors when the tool encounters reads without a pair.
*   `--maxReadLength`: Increases the buffer for long-read sequences (default is 500).

## Expert Tips and Best Practices

*   **Input Requirements**: samblaster requires the input SAM file to be **read-id grouped** (all alignments for a specific QNAME must be adjacent). Aligners naturally produce this order. If your file is coordinate-sorted, you must sort it by name (`samtools sort -n`) before using samblaster.
*   **Memory Management**: samblaster is memory-efficient, requiring approximately 20MB of RAM per 1 million read pairs.
*   **Duplicate Removal**: By default, samblaster marks duplicates with the 0x400 flag. To completely remove them from the output stream, use the `--removeDups` option.
*   **Adding Mate Tags**: Use `--addMateTags` to add `MC` (mate CIGAR) and `MQ` (mate mapping quality) tags to paired-end SAM lines, which is helpful for downstream tools that require mate information without looking up the mate record.
*   **Unmapped/Clipped Reads**: The `-u` (or `--unmappedFile`) option can output unmapped or heavily clipped reads into a FASTQ file, which is useful for re-aligning "difficult" reads to a different reference or using them in de novo assembly of insertion sequences.

## Reference documentation
- [samblaster GitHub Repository](./references/github_com_GregoryFaust_samblaster.md)
- [samblaster Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_samblaster_overview.md)