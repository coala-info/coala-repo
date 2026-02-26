---
name: mango
description: Mango is a high-performance genomic visualization engine designed for low-latency browsing and analysis of large-scale sequencing data. Use when user asks to visualize genomic alignments, inspect variant calls, or browse reference genomes across large cohorts using distributed computing.
homepage: https://github.com/bdgenomics/mango
---


# mango

## Overview
Mango is a high-performance genomic visualization engine designed to handle the scale of modern sequencing data. Unlike traditional genome browsers that struggle with massive datasets, Mango leverages distributed computing patterns to provide low-latency browsing and analysis. It allows researchers to transition seamlessly from high-level data summaries to base-pair resolution across entire cohorts.

## Usage Guidelines

### Environment Setup
Install mango via bioconda to ensure all dependencies (including Java/Scala runtimes) are correctly configured:
```bash
conda install -c bioconda mango
```

### Core Visualization Patterns
Mango can be used as an interactive browser or for programmatic visualization. Focus on these primary data formats:
- **Alignments**: Loading BAM/SAM files for read coverage and mismatch visualization.
- **Variants**: Visualizing VCF files to inspect genotype calls and quality metrics.
- **Reference**: Loading 2bit or FASTA files for genomic context.

### Distributed Execution
When working with massive datasets that exceed local memory:
- Use the Spark-based backend to distribute data processing across a cluster.
- Ensure your input files are indexed (e.g., `.bai` for BAM, `.tbi` for VCF) to allow for efficient random access during zooming and panning.

### Best Practices
- **Memory Management**: When running locally on large files, increase the heap size via standard JVM flags if the browser becomes unresponsive.
- **Data Reduction**: For global views, use Mango's ability to pre-aggregate data to avoid loading individual reads until zooming into specific loci.
- **Integration**: Use Mango in conjunction with the ADAM processing engine for a complete "pipe-to-plot" genomic workflow.

## Reference documentation
- [Mango Overview](./references/anaconda_org_channels_bioconda_packages_mango_overview.md)