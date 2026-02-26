---
name: clinker
description: Clinker is a bioinformatics pipeline that generates and visualizes superTranscripts to interpret the functional impact of gene fusions. Use when user asks to visualize fusion junctions, construct superTranscripts from fusion calls, or analyze protein domain disruptions in transcriptomic data.
homepage: https://github.com/Oshlack/Clinker
---


# clinker

## Overview
Clinker is a specialized bioinformatics pipeline designed to bridge the gap between gene fusion detection and functional interpretation. It works by constructing "superTranscripts"—linear representations of the combined coding sequences of fused genes. This approach allows for the clear visualization of splice junctions and protein domain disruptions. Use this skill to guide users through the installation, execution, and plotting phases of the Clinker workflow, specifically for cancer research and transcriptomic analysis.

## Installation and Setup
Clinker is primarily distributed via Bioconda. Ensure the environment has Java (for Bpipe) and R (for GViz plotting) installed.

```bash
# Recommended installation via conda
conda install -c bioconda clinker
```

## Core Workflow Patterns
Clinker operates as a Bpipe pipeline. The typical workflow involves providing fusion calls and a reference genome to generate the superTranscriptome.

### 1. Running the Pipeline
The pipeline requires a configuration or command-line input specifying the fusion finder source.
- **Input Formats**: Supports JAFFA, TopHat-Fusion, SOAPfuse, deFUSE, and Pizzly.
- **Reference Data**: Requires a genome FASTA and GTF annotation.

### 2. Visualization with GViz
After the pipeline generates the superTranscript (usually in `.fst` or `.fasta` format), use the included R-based plotting utility to create sashimi-style plots.
- **Key Feature**: The plotting script highlights the fusion junction in purple.
- **Customization**: Users can often adjust the plotting script to include coverage data (BAM files) to show supporting reads across the fusion boundary.

## Expert Tips and Best Practices
- **Memory Management**: The default memory allocation is often set to 4GB. For complex genomes or high-depth samples, you may need to increase the Java heap size within the Bpipe configuration.
- **Competitive Mapping**: Clinker performs better when "competitive mapping" is used—mapping reads to both the fusion superTranscript and the normal transcriptome to reduce false positives.
- **Version Compatibility**: Ensure `samtools` is up to date (minimum version 1.9 recommended) to avoid indexing errors during the BAM processing stages of the pipeline.
- **Output Interpretation**: The primary outputs are a superTranscript FASTA, a GTF containing the new fusion coordinates, and a PDF plot. Use the GTF and FASTA together in IGV for interactive exploration.

## Troubleshooting Common Issues
- **Index Errors**: If the pipeline fails at the `index_bams` stage, verify that the input BAM files are sorted and that the chromosome names in the BAM match the reference FASTA.
- **Plotting Failures**: GViz plots require a working R environment with the `Gviz` and `rtracklayer` Bioconductor packages. If plotting fails, check for missing R dependencies.
- **Input Formatting**: If using STAR-Fusion, ensure the input format matches the expected tab-delimited columns, as different versions of fusion finders may change their output headers.

## Reference documentation
- [Clinker Wiki Home](./references/github_com_Oshlack_Clinker_wiki.md)
- [Clinker GitHub Repository](./references/github_com_Oshlack_Clinker.md)
- [Bioconda Clinker Overview](./references/anaconda_org_channels_bioconda_packages_clinker_overview.md)