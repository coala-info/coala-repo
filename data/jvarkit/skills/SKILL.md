---
name: jvarkit
description: jvarkit is a suite of Java-based command-line utilities designed for the manipulation, filtering, and visualization of high-throughput sequencing data formats. Use when user asks to process VCF files, visualize BAM alignments as SVG or raster images, convert genomic formats like GTF or BED to XML, and generate alignment statistics.
homepage: https://github.com/lindenb/jvarkit
---


# jvarkit

## Overview

jvarkit is a comprehensive suite of Java-based command-line utilities designed for bioinformatics and high-throughput sequencing data analysis. It provides a vast array of specialized tools that complement standard suites like SAMtools, BCFtools, and Bedtools. Use this skill to navigate the execution of these tools, which are primarily focused on the manipulation, filtering, and visualization of NGS (Next-Generation Sequencing) data formats.

## Execution Patterns

Since 2023, most jvarkit utilities are bundled into a single executable JAR file.

### Modern Execution (Bundled JAR)
The preferred way to run any tool within the suite is:
```bash
java -jar jvarkit.jar <toolname> [options]
```

### Legacy Execution
Older versions or specific standalone builds may use individual JARs:
```bash
java -jar <toolname>.jar [options]
```

## Common Tool Categories

### VCF Manipulation and Annotation
- **vcfcluster**: Cluster overlapping variants.
- **vcfbed**: Intersect VCF files with BED regions.
- **VcfGrantham**: Annotate VCF files with Grantham scores.
- **dict2vcf**: Convert a sequence dictionary to a VCF header.

### BAM/SAM Processing and Visualization
- **Bam2SVG**: Generate SVG graphical representations of BAM alignments.
- **Bam2Raster**: Create raster images of genomic alignments.
- **vcf2bam**: Generate a BAM file from a VCF file.
- **BamStats**: Various tools (BamStats01, BamStats02) for generating alignment statistics.

### Format Conversion and BED Tools
- **gtf2xml**: Convert GTF files to XML format.
- **json2xml**: Convert JSON genomic data to XML.
- **bedstats**: Generate statistics for BED files.
- **bed2xml**: Export BED regions to XML.

## Expert Tips and Best Practices

### Memory Management
As Java-based tools, jvarkit utilities are sensitive to JVM memory settings. For large genomic files, always specify the maximum heap size:
```bash
java -Xmx8g -jar jvarkit.jar <toolname> [options]
```

### Unix Piping
jvarkit tools follow the Unix philosophy and can be integrated into pipelines using standard streams:
```bash
cat input.vcf | java -jar jvarkit.jar vcfbed --bed regions.bed | next_tool
```

### Installation via Conda
The easiest way to manage the jvarkit environment is through Bioconda:
```bash
conda install bioconda::jvarkit
```

### Troubleshooting Tool Names
If a tool name is unknown or the documentation is unclear, running the JAR without arguments or with the tool name and `--help` usually provides the usage instructions:
```bash
java -jar jvarkit.jar --list
java -jar jvarkit.jar <toolname> --help
```

## Reference documentation
- [jvarkit Overview](./references/anaconda_org_channels_bioconda_packages_jvarkit_overview.md)
- [jvarkit GitHub Repository](./references/github_com_lindenb_jvarkit.md)
- [jvarkit Wiki and Tool List](./references/github_com_lindenb_jvarkit_wiki.md)