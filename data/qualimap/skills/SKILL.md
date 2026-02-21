---
name: qualimap
description: Qualimap is a Java-based tool designed to evaluate the quality of high-throughput sequencing alignment data.
homepage: http://qualimap.bioinfo.cipf.es/
---

# qualimap

## Overview
Qualimap is a Java-based tool designed to evaluate the quality of high-throughput sequencing alignment data. It processes SAM, BAM, and GFF files to detect biases in sequencing or mapping, providing both visual reports and raw statistics. It is particularly useful for assessing genome coverage, nucleotide distribution, and transcriptomic saturation.

## Core Commands and Workflows

### 1. BAM Quality Control (BAM QC)
The primary mode for evaluating a single alignment file. It calculates coverage, GC content, mapping quality, and insert size.

```bash
qualimap bamqc -bam input.bam -outdir ./bamqc_report -nt 8 --java-mem-size=4G
```
- `-nt`: Number of threads.
- `-gff`: (Optional) Provide a genomic features file to restrict analysis to specific regions (e.g., exome targets).
- `--java-mem-size`: Essential for large BAM files to prevent OutOfMemory errors.

### 2. RNA-seq QC
Specialized mode for transcriptomics that computes genomic origin of reads (exonic, intronic, intergenic) and coverage bias along the gene body.

```bash
qualimap rnaseq -bam input.bam -gtf annotations.gtf -outdir ./rnaseq_report -p strand-specific-reverse
```
- `-gtf`: Required annotation file.
- `-p`: Sequencing protocol (non-strand-specific, strand-specific-forward, or strand-specific-reverse).

### 3. Multi-sample Comparison
Used to aggregate results from multiple `bamqc` runs to identify outliers or batch effects across a cohort.

```bash
# First, create a metadata file (sample_list.txt) with:
# sample1_name /path/to/bamqc_results_1
# sample2_name /path/to/bamqc_results_2

qualimap multi-bamqc -d sample_list.txt -outdir ./multi_report
```

### 4. Counts QC
Analyzes the output of feature counting tools (like HTSeq or featureCounts) to estimate sequencing saturation and expression distribution.

```bash
qualimap counts -c -input counts.txt -outdir ./counts_report
```

## Expert Tips
- **Memory Management**: For human WGS data, always increase the Java heap size using `--java-mem-size=12G` or higher.
- **Headless Environments**: If running on a server without a display, Qualimap handles the lack of X11 automatically in newer versions, but ensure `java-common` is installed.
- **Validation**: Use the `-c` flag in `bamqc` to paint the chromosome names in the report, which helps verify if the BAM header matches the expected reference.
- **Performance**: When analyzing specific regions (like Exome-seq), always provide the `-gff` or `-bed` file. This significantly speeds up the process by ignoring off-target reads.

## Reference documentation
- [Qualimap Home and Features](./references/qualimap_conesalab_org_index.md)
- [Bioconda Qualimap Overview](./references/anaconda_org_channels_bioconda_packages_qualimap_overview.md)