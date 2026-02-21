---
name: mirtrace
description: miRTrace is a specialized quality control and taxonomic tracing tool designed specifically for small RNA sequencing (sRNA-Seq) data.
homepage: https://github.com/friedlanderlab/mirtrace
---

# mirtrace

## Overview

miRTrace is a specialized quality control and taxonomic tracing tool designed specifically for small RNA sequencing (sRNA-Seq) data. Unlike general-purpose QC tools, it characterizes samples by profiling miRNA complexity and distinguishing miRNAs from undesirable sequences like tRNAs, rRNAs, and sequencing artifacts. Its standout feature is the ability to resolve the taxonomic origins of sRNA-Seq data based on clade-specific miRNA compositions, allowing researchers to detect exogenous sequences or cross-species contamination.

## Installation and Setup

The most efficient way to install miRTrace is via Bioconda:

```bash
conda install -c bioconda mirtrace
```

The tool requires Java 1.7 or higher. If using the standalone JAR file, ensure your environment's `java -version` meets this requirement.

## Core Usage Patterns

miRTrace operates in two primary modes: `qc` (comprehensive quality control) and `trace` (organismal origin detection).

### Quality Control Mode (mirtrace qc)
Use this mode for standard sRNA-Seq processing. It generates an interactive HTML report covering Phred scores, read length distribution, RNA type analysis, and miRNA complexity.

```bash
# Basic QC command
mirtrace qc --species hsa --adapter TGGAATTCTCGGGTGCCAAGG input_sample.fastq.gz --output-dir output_qc/
```

### Trace Mode (mirtrace trace)
Use this mode when the primary goal is to discern the organismal origin or detect contamination without the full QC suite.

```bash
mirtrace trace --species hsa input_sample.fastq.gz --output-dir output_trace/
```

## Resource Management

miRTrace can be memory-intensive when processing large FASTQ files.

*   **Memory Allocation**: The `mirtrace` wrapper script defaults to using half of the system's RAM. To override this, use the `MIRTRACE_HEAP_ALLOCATION` environment variable.
    ```bash
    MIRTRACE_HEAP_ALLOCATION="16GB" mirtrace qc ...
    ```
*   **Direct Java Execution**: If running the JAR directly, set the heap size using standard Java flags.
    ```bash
    java -jar -Xmx12G mirtrace.jar qc ...
    ```
*   **Multi-threading**: miRTrace uses one thread per FASTQ file. Ensure your memory allocation scales with the number of concurrent files being processed.

## Expert Tips and Best Practices

*   **Input Formats**: Always prefer gzipped FASTQ files (`.fastq.gz`) to save disk space and I/O time. miRTrace handles these natively.
*   **Species Selection**: The tool supports 219 animal and plant species from miRBase v21. Ensure you use the correct three-letter species code (e.g., `hsa` for human, `mmu` for mouse).
*   **Report Navigation**: The interactive HTML report supports keyboard shortcuts. Use `W` and `S` keys to navigate between different plots quickly.
*   **Contamination Detection**: If you suspect parasitic or exogenous miRNA, check the "Contamination" section of the report, which utilizes clade-specific miRNA families to identify non-host sequences.
*   **Custom Databases**: For specialized research, you can provide custom reference sequences for rRNAs, tRNAs, or artifacts to tailor the RNA type analysis to your specific organism.

## Reference documentation

- [miRTrace Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mirtrace_overview.md)
- [miRTrace GitHub Repository and Manual](./references/github_com_friedlanderlab_mirtrace.md)