---
name: targqc
description: targqc evaluates the coverage quality of targeted sequencing experiments by processing alignment files against specific genomic regions. Use when user asks to assess sequencing depth, identify coverage cold spots in capture assays, or generate quality control reports for targeted genomic data.
homepage: https://github.com/vladsaveliev/TargQC
---


# targqc

## Overview
targqc is a specialized utility for evaluating the coverage quality of targeted sequencing experiments. It processes alignment files to determine how well specific genomic regions (defined in a BED file) have been sequenced. The tool is particularly useful for identifying "cold spots" in capture assays, calculating the percentage of bases covered at specific depth thresholds (e.g., 10x, 30x, 100x), and generating both human-readable HTML reports and machine-parsable TSV data for downstream analysis.

## Core CLI Patterns

### Basic Coverage Analysis
To run a standard QC analysis on BAM files using a target BED file and a reference genome:
```bash
targqc *.bam --bed targets.bed -g hg19 -o qc_results
```
*Note: `-g` accepts `hg19`, `hg38`, or a full path to a reference FASTA file.*

### Processing Raw Reads (FastQ)
targqc can perform alignment via BWA before running QC. This requires a BWA-indexed reference:
```bash
targqc *.fastq --bed targets.bed -g hg19 --bwa-prefix /path/to/bwa_index -o qc_results
```

### Performance and Parallelization
For large datasets or multiple samples, use the threading or cluster scheduling options:
- **Local Multithreading**: `-t <threads>`
- **Cluster Execution**: Use `-s` to specify the scheduler (`slurm`, `sge`, `lsf`, or `torque`) and `-q` for the queue name.
```bash
targqc *.bam --bed targets.bed -g hg38 -o qc_results -t 8 -s slurm -q work_queue
```

### Rapid Estimation (Downsampling)
By default, the tool downsamples FastQ inputs to 500,000 read pairs for quick estimation. 
- To change the limit: `--downsample-to 1e6`
- To process all reads: `--downsample-to off`

## Interpreting Outputs

- **summary.html**: Visual dashboard for sample-level statistics.
- **summary.tsv**: Tabular version of sample-level metrics.
- **regions.tsv**: Detailed breakdown of coverage per BED region.

### Analyzing Region Coverage
The `regions.tsv` file includes specific overlap metrics that are highly useful for clinical or exome sequencing:
- **trx_overlap / exome_overlap / cds_overlap**: Percentage of the region overlapping transcripts, exons, or coding sequences.
- **atNx**: The percentage of the region covered at least N-fold (e.g., `at100x` shows the fraction of the target with 100x depth or more).

## Expert Tips
- **Reference Indices**: When running from BAM files, targqc only requires the `.fai` index of the reference genome; the actual large FASTA file does not need to be present if the path is correctly specified.
- **Filtering**: Coverage calculations automatically exclude duplicated, quality-failed, secondary, and supplementary alignments to ensure the QC reflects high-quality usable data.
- **Data Querying**: Use `bioawk` to quickly extract specific metrics from the `regions.tsv` output:
  ```bash
  cat regions.tsv | bioawk -tc hdr '{ print $chr, $start, $end, $gene, $avg_depth, $at100x }'
  ```

## Reference documentation
- [TargQC GitHub Repository](./references/github_com_vladsavelyev_TargQC.md)