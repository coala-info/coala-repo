---
name: mirtrace
description: miRTrace is a bioinformatics utility for quality control and taxonomic tracing of small RNA sequencing data. Use when user asks to assess sRNA-Seq quality, determine the biological source of RNA, or identify clade-specific miRNA signatures.
homepage: https://github.com/friedlanderlab/mirtrace
---

# mirtrace

## Overview

miRTrace is a specialized bioinformatics utility tailored for the analysis of small RNA sequencing (sRNA-Seq) data. It provides a dual-purpose workflow: standard quality control (QC) and taxonomic tracing. While the QC mode assesses technical metrics like Phred scores, read lengths, and RNA-type composition (miRNA vs. tRNA/rRNA/artifacts), the Trace mode leverages clade-specific miRNA signatures to determine the biological source of the RNA. This is particularly useful for verifying sample purity, detecting parasitic RNA in host serum, or forensic applications like meat product authentication.

## Common CLI Patterns

### Quality Control (QC Mode)
The `qc` command is the primary entry point for standard library assessment. It supports 219 animal and plant species from miRBase v21.

```bash
# Basic QC run for a human sample
./mirtrace qc --species hsa --adapter TGGAATTCTCGGGTGCCAAGG input.fastq.gz --outdir output_directory

# Processing multiple samples (mirtrace is multi-threaded)
./mirtrace qc --species mmu --adapter TGGAATTCTCGGGTGCCAAGG sample1.fq sample2.fq sample3.fq --outdir qc_results
```

### Taxonomic Tracing (Trace Mode)
Use `trace` when the organismal origin is unknown or when checking for contamination across different clades.

```bash
# Identify the clade origin of a sample
./mirtrace trace input.fastq.gz --outdir trace_results
```

### Resource Management
miRTrace is Java-based and can be memory-intensive for large FASTQ files.

```bash
# Set memory via environment variable for the Python wrapper
export MIRTRACE_HEAP_ALLOCATION="8GB"
./mirtrace qc [parameters]

# Running the JAR directly with specific heap limits
java -Xms4G -Xmx8G -jar mirtrace.jar qc [parameters]
```

## Expert Tips and Best Practices

- **Input Formats**: Always prefer gzipped FASTQ files (`.fastq.gz`) to save disk space and I/O time. miRTrace handles them natively.
- **Adapter Trimming**: Ensure you provide the correct 3' adapter sequence. miRTrace requires this to accurately calculate read length distributions and identify functional miRNAs.
- **Phred Detection**: miRTrace automatically detects Phred score encoding (Sanger/Illumina 1.8+ vs. older formats), so manual specification is usually unnecessary.
- **Custom Databases**: If working with non-standard species or specific contaminants, you can provide custom reference sequences for rRNAs, tRNAs, and artifacts to refine the "RNA Type" analysis.
- **Interactive Reports**: The primary output is an interactive HTML report. Use the `W` and `S` keys within the browser to navigate between plots quickly.
- **Large Batches**: For projects with >50 samples, the HTML report may become slow. Consider using the "compressed mode" in the HTML interface or parsing the `mirtrace-stats-*.json` file for automated downstream analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| mirtrace | The first argument must specify what mode miRTrace should operate in. Available modes: trace miRNA trace mode. Produces a clade report. --species is ignored. qc Quality control mode (full set of reports). --species must be given. |
| mirtrace | miRNA trace mode. Produces a clade report. --species is ignored. |

## Reference documentation
- [miRTrace README](./references/github_com_friedlanderlab_mirtrace_blob_master_README.md)
- [miRTrace Changelog](./references/github_com_friedlanderlab_mirtrace_blob_master_CHANGELOG.md)