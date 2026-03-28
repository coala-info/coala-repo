---
name: qualimap
description: Qualimap evaluates the quality of alignments from Next Generation Sequencing experiments by processing BAM or SAM files to generate comprehensive QC reports. Use when user asks to perform general alignment quality control, analyze RNA-seq data for gene body coverage and strand specificity, or compare multiple samples to detect batch effects.
homepage: http://qualimap.bioinfo.cipf.es/
---

# qualimap

## Overview

Qualimap is a versatile tool designed to assess the quality of alignments from Next Generation Sequencing (NGS) experiments. It processes alignment files (BAM/SAM) to generate comprehensive reports that help identify potential issues in library preparation, sequencing, or mapping. Use this skill to perform basic alignment QC, specialized RNA-seq analysis (including gene body coverage and strand specificity), and multi-sample comparisons to detect batch effects or outliers in a cohort.

## Common CLI Patterns

### BAM QC (General Alignment Quality Control)
The primary mode for evaluating a single alignment file.
```bash
qualimap bamqc -bam input.bam -outdir ./bamqc_report -nt 4 --java-mem-size=4G
```
- **Key Options**:
  - `-gff` / `-bed`: Restrict analysis to specific genomic regions (e.g., exome targets).
  - `-nt`: Number of threads for parallel processing.
  - `-nw`: Number of windows for coverage calculation (default is 400).
  - `-hm`: Minimum homopolymer size to estimate indels.

### RNA-seq QC
Specialized for transcriptomics data; requires a genome annotation file.
```bash
qualimap rnaseqqc -bam input.bam -gtf annotation.gtf -outdir ./rnaseq_report -p non-strand-specific
```
- **Key Options**:
  - `-p`: Protocol type (`strand-specific-forward`, `strand-specific-reverse`, or `non-strand-specific`).
  - `-a`: Counting algorithm (`proportional` or `uniquely-mapped-reads`).

### Multi-sample BAM QC
Used to compare multiple BAM files simultaneously. Requires a configuration file listing the samples.
```bash
qualimap multi-bamqc -d input_list.txt -outdir ./multi_report
```
- **Input List Format**: The input file should be tab-delimited: `sample_name [tab] path_to_bamqc_results`.

### Counts QC
Evaluates the quality of feature counts (e.g., from HTSeq or featureCounts).
```bash
qualimap counts -c -bam input.bam -gtf annotation.gtf -outdir ./counts_report
```

## Expert Tips and Best Practices

- **Memory Management**: For high-coverage samples or large genomes (like human), always specify `--java-mem-size` (e.g., `8G` or `12G`) to prevent `OutOfMemoryError`.
- **Duplicate Handling**: By default, Qualimap skips marked duplicates. Use the `-sd` (skip duplicates) or `-os` (analyze overlapping paired-end reads) options to fine-tune how reads are counted toward coverage.
- **Headless Environments**: If running on a Linux server without a display, ensure the environment is set up correctly for Java's AWT (often handled by `-Djava.awt.headless=true` in the wrapper script).
- **Region-based Analysis**: When working with Exome or Targeted sequencing, always provide a BED file. This ensures coverage statistics are calculated based on the target space rather than the whole genome, which would otherwise result in misleadingly low average coverage.
- **Output Formats**: Qualimap generates HTML reports by default. Use `-outformat PDF` if a static document is required for documentation or sharing.



## Subcommands

| Command | Description |
|---------|-------------|
| qualimap bamqc | Performs a quality control analysis on BAM files. |
| qualimap clustering | QualiMap v.2.3 |
| qualimap comp-counts | QualiMap v.2.3 |
| qualimap counts | QualiMap v.2.3 |
| qualimap multi-bamqc | Multi-sample BAM quality control analysis |
| qualimap rnaseq | QualiMap v.2.3 |

## Reference documentation
- [Qualimap 2.3 documentation](./references/qualimap_conesalab_org_doc_html_index.html.md)
- [Qualimap Examples and Sample Data](./references/qualimap_conesalab_org_doc_html_samples.html.md)
- [Qualimap Overview and Version History](./references/qualimap_conesalab_org_index.md)