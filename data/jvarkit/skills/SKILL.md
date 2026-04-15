---
name: jvarkit
description: jvarkit is a suite of Java-based bioinformatics utilities designed for specialized processing, visualization, and format conversion of NGS data. Use when user asks to visualize alignments as SVG or raster images, lift over BAM files between genome builds, manipulate VCF files, or convert genomic data to XML and JSON formats.
homepage: https://github.com/lindenb/jvarkit
metadata:
  docker_image: "quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2"
---

# jvarkit

## Overview

jvarkit is a comprehensive suite of Java utilities designed for bioinformatics and genomics. It provides a wide array of specialized tools for processing Next-Generation Sequencing (NGS) data. While standard tools like Samtools or GATK handle core workflows, jvarkit excels at "niche" but critical tasks such as generating graphical representations of alignments, calculating complex allele frequencies, lifting over BAM files between genome builds, and converting genomic formats into XML or JSON for downstream processing.

## Core Execution Patterns

### Modern Execution (Recommended)
Since 2023, most tools are bundled into a single executable JAR. Use the following syntax:

```bash
java -jar jvarkit.jar <tool_name> [options] <input_file>
```

### Legacy Execution
Older versions or specific standalone builds may require direct JAR execution:

```bash
java -jar <tool_name>.jar [options] <input_file>
```

## Common Tool Categories and Usage

### 1. Visualization and Graphics
Tools like `bam2svg` and `bam2raster` are used to create visual representations of sequencing reads.
- **Use Case**: Generating publication-quality images of specific genomic regions or troubleshooting alignment issues.
- **Pattern**: `java -jar jvarkit.jar bam2svg -R reference.fa -r "chr1:100-200" input.bam > output.svg`

### 2. VCF Manipulation and Annotation
jvarkit provides advanced VCF filters and annotators that go beyond basic site filtering.
- **VcfGrantham**: Annotates VCF files with Grantham scores for amino acid substitutions.
- **AlleleFrequencyCalculator**: Calculates allele frequencies based on specific population parameters.
- **VcfBed**: Filters or annotates VCF records based on overlaps with BED file regions.

### 3. BAM/SAM Utilities
- **BamLiftOver**: Used to migrate BAM files from one reference assembly to another (e.g., hg19 to hg38).
- **BamStats**: A family of tools (01 through 05) for generating detailed statistics on coverage, read groups, and alignment quality.
- **BamCmpCoverage**: Compares the coverage between two or more BAM files.

### 4. Format Converters
jvarkit is frequently used to bridge the gap between bioinformatics formats and general data formats.
- **gtf2xml / json2xml**: Converts genomic annotations or data structures into XML/JSON.
- **bed2xml**: Converts BED regions into structured XML.

## Expert Tips and Best Practices

- **Memory Management**: As a Java-based suite, jvarkit can be memory-intensive for large BAM or VCF files. Always specify the maximum heap size using the `-Xmx` flag.
  - *Example*: `java -Xmx8g -jar jvarkit.jar ...`
- **Piping and Streams**: Most jvarkit tools are designed to work with Unix pipes. Use `-` to represent stdin or stdout where applicable to avoid creating massive intermediate files.
- **Reference Genomes**: Many tools require a reference genome in FASTA format. Ensure the reference is indexed (`.fai`) and has a dictionary (`.dict`) file in the same directory.
- **Tool Discovery**: To see a full list of available tools within the bundled JAR, run the JAR without a tool name or with a help flag.
- **Chromosome Renaming**: If working with mixed naming conventions (e.g., "chr1" vs "1"), use `BamRenameChromosomes` or `BedRenameChromosomes` before performing comparisons or annotations.



## Subcommands

| Command | Description |
|---------|-------------|
| addlinearindextobed | Add linear index to BED file |
| backlocate | Backlocate sequences to genomic coordinates. |
| bam2raster | Create raster images from BAM files. |
| bam2sql | Convert BAM files to SQL |
| bam2svg | Create SVG images from BAM files. |
| bamcmpcoverage | Calculate coverage statistics for BAM files. |
| bamliftover | LiftOver BAM/SAM/CRAM files to a new reference genome. |
| bammatrix | Create a matrix of read counts per region. |
| jvarkit bamclip2insertion | Clip reads to a given insertion point and output them as BAM. |
| jvarkit_bam2haplotypes | Create haplotypes from BAM files based on variants in a VCF file. |
| jvarkit_bam2xml | Convert BAM to XML |

## Reference documentation
- [GitHub - lindenb/jvarkit](./references/github_com_lindenb_jvarkit.md)
- [jvarkit Wiki Home](./references/github_com_lindenb_jvarkit_wiki.md)
- [Compilation Guide](./references/github_com_lindenb_jvarkit_wiki_Compilation.md)