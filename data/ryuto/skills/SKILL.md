---
name: ryuto
description: Ryuto performs fast and exact transcriptome reconstruction and quantification from RNA-Seq data using network flows and splice-graphs. Use when user asks to reconstruct transcriptomes, identify transcript structures, quantify expression levels, or perform multi-sample consensus assembly.
homepage: https://github.com/studla/RYUTO/
---


# ryuto

## Overview
Ryuto is a high-performance bioinformatics tool designed for the exact and fast reconstruction of transcriptomes. By utilizing network flows and an advanced extension of splice-graphs, it identifies transcript structures and quantifies their expression levels. It is particularly effective for processing RNA-Seq datasets where high-quality transcript assembly and multi-sample integration are required.

## Installation
The most efficient way to install Ryuto is via Bioconda:
```bash
conda install bioconda::ryuto
```

## Core Usage
Ryuto requires an output directory, the library type, and at least one input mapping file.

### Basic Command Template
```bash
ryuto -o [output_dir] -l [library_type] <input1.bam> [input2.bam ...]
```

### Library Types (`-l`)
You must specify the correct strandedness based on your RNA-Seq protocol:
- `fr-unstranded`: For non-strand-specific data.
- `fr-firststrand`: For dUTP-based protocols (e.g., TruSeq Stranded).
- `fr-secondstrand`: For specific stranded protocols where the second strand is the one sequenced.

### Common Options
- `-t [INT]`: Number of CPU threads to use (highly recommended for speed).
- `-g [FILE.gtf]`: Provide a reference annotation to guide the reconstruction.
- `--help`: Display the full list of available parameters.

## Best Practices and Workflow
### 1. Input Preparation
- **Mapping**: For optimal results, map your reads using **STAR** with the following flag to ensure proper splice junction handling:
  `--outSAMstrandField intronMotif`
- **Sorting**: Input BAM files **must** be coordinate-sorted.
- **Indexing**: Ensure `.bai` index files are present in the same directory as your BAM files.

### 2. Multi-Sample Assembly
Ryuto can process multiple BAM files simultaneously to create a consensus assembly. This is superior to merging BAM files manually as it allows the tool to track sample-specific signals and disagreements.

### 3. Output Analysis
Ryuto produces three primary files in the specified output directory:
- `transcripts.gtf`: The assembled transcript structures.
- `transcripts.count`: A table containing Gene Name, Transcript Name, Length, and Read Counts for every sample. This is ready for input into differential expression tools like DESeq2.
- `transcripts.errcount`: A "disagreement" table. High values in this file indicate genomic regions where individual samples significantly deviate from the consensus model, which may suggest undetected biological variation or mapping artifacts.

## Expert Tips
- **Performance**: Ryuto is designed for speed; always utilize the `-t` option to match your available hardware cores.
- **Annotation Guidance**: Even if you are looking for novel transcripts, providing a reference GTF via `-g` improves the accuracy of the network flow estimation for known isoforms.
- **Memory Management**: When working with a very large number of samples or extremely high coverage, ensure your system has sufficient RAM, as splice-graph complexity increases with data volume.

## Reference documentation
- [Ryuto GitHub Repository](./references/github_com_studla_RYUTO.md)
- [Bioconda Ryuto Package](./references/anaconda_org_channels_bioconda_packages_ryuto_overview.md)