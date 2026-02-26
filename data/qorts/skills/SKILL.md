---
name: qorts
description: QoRTs is a high-performance toolkit designed to process aligned RNA-Seq reads into quality control metrics, count files, and visualization tracks. Use when user asks to perform quality control on RNA-Seq data, generate count files for statistical analysis, merge technical replicates, or create wiggle tracks for genomic visualization.
homepage: http://hartleys.github.io/QoRTs/
---


# qorts

## Overview

QoRTs (Quality of RNA-Seq Toolset) is a high-performance toolkit designed to manage the transition from aligned RNA-Seq reads to statistical analysis. It provides a comprehensive battery of quality control metrics to detect artifacts, errors, and biases in high-throughput sequencing data. Use this skill to execute the Java-based data processing pipeline, handle aligner-specific formatting requirements, and generate count files or wiggle tracks for visualization.

## Execution Patterns and Best Practices

### Memory Management
QoRTs processes large genomic files and often requires significant heap space. Always specify memory allocation to avoid `OutOfMemoryExceptions`.
- Use `-Xmx8G` or higher for standard human/mouse datasets.
- Example: `java -Xmx8G -jar QoRTs.jar QC ...`

### Primary QC Workflow
The `QC` command is the standard entry point for processing a single BAM or SAM file. It requires a coordinate-sorted BAM and a matching GTF annotation.
- **Basic Syntax**: `java -jar QoRTs.jar QC [options] input.bam annotation.gtf.gz /output/dir/`
- **Paired-end data**: QoRTs assumes paired-end data by default. For single-end data, you must specify `--singleEnd`.

### Aligner-Specific MAPQ Settings
Different aligners use different conventions for the MAPQ field to denote uniquely mapped reads. You must adjust the `--minMAPQ` parameter based on your aligner:
- **RNA-STAR / TopHat1**: No special options needed (default works).
- **TopHat2**: Set `--minMAPQ 50`.
- **GSNAP**: Set `--minMAPQ 20`.
- **Novoalign (DNA)**: Use `--DNA --minMAPQ 0 --checkForAlignmentBlocks`.

### Handling Phred Quality Scores
If you encounter `ArrayIndexOutOfBoundsException` related to quality scores:
- **Newer Illumina (Phred > 41)**: Use `--maxPhredScore 45` (or the specific maximum of the platform).
- **Older Illumina (v1.3-1.7, Phred+64)**: Use `--adjustPhredScore 31` to convert to Phred+33.

### Merging Replicates
- **Technical Replicates**: Use `mergeCounts` to combine data from multiple runs of the same library.
- **Dataset-wide Merging**: Use `mergeAllCounts` with a replicate decoder file to automate the merging of all technical replicates into sample-wise counts.

### Generating Visualization Tracks
- **Wiggle Files**: Use `bamToWiggle` to create depth-of-coverage tracks.
- **Splice Junctions**: Use `makeJunctionTrack` to compile splice junction counts across multiple samples into a BED file for the UCSC Genome Browser.
- **Novel Junctions**: Use `mergeNovelSplices` to filter low-coverage novel junctions across a cohort and generate JunctionSeq-ready count files.

### Troubleshooting and Metadata
- Use the `--verbose` flag when debugging to maximize log output.
- Access the full manual for any sub-utility using: `java -jar QoRTs.jar [utilname] --man`.

## Reference documentation
- [QoRTs Main Documentation](./references/hartleys_github_io_QoRTs_index.html.md)
- [QoRTs FAQ and Aligner Settings](./references/hartleys_github_io_QoRTs_FAQ.html.md)
- [Java Utility Command Reference](./references/hartleys_github_io_QoRTs_jarHtml_index.html.md)