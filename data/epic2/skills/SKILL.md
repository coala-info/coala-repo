---
name: epic2
description: "epic2 is a high-performance tool for identifying broad peaks and diffuse domains in ChIP-Seq data. Use when user asks to call broad peaks, identify enriched domains, or perform differential enrichment analysis between conditions."
homepage: http://github.com/endrebak/epic2
---


# epic2

## Overview
epic2 is an ultraperformant reimplementation of the SICER algorithm, optimized for speed and low memory consumption. It is the preferred tool for identifying diffuse "broad" peaks in ChIP-Seq data where traditional peak callers like MACS2 may struggle. It supports a wide range of built-in UCSC genomes and provides a dedicated utility for differential enrichment analysis (epic2-df).

## Core CLI Usage

### Standard Peak Calling
To find enriched domains using a treatment and control (input) file:
```bash
epic2 --treatment treatment.bam --control control.bam --genome hg38 > peaks.txt
```

### Peak Calling Without Control
If no input/control library is available, epic2 can run using only the treatment file:
```bash
epic2 -t treatment.bed.gz -gn mm10 > peaks.txt
```

### Differential Enrichment (epic2-df)
To find regions that are differentially enriched between two conditions (e.g., Wildtype vs. Knockout):
```bash
epic2-df -tk knockout.bam -tw wildtype.bam -ok ko_results.txt -ow wt_results.txt > differential_peaks.txt
```

## Parameter Optimization

| Parameter | Flag | Default | Guidance |
|-----------|------|---------|----------|
| Bin Size | `--bin-size` | 200 | The window size for scanning the genome. Increase for very broad marks. |
| Gaps Allowed | `--gaps-allowed` | 3 | Number of non-enriched bins allowed between enriched bins to merge them into one domain. |
| FDR Cutoff | `--fdr` | 0.05 | False Discovery Rate threshold for reported islands. |
| Fragment Size | `--fragment-size` | 150 | For single-end reads, reads are extended by half this value. |
| Map Quality | `--mapq` | None | Use to filter reads by mapping quality (e.g., `--mapq 30`). |

## Expert Tips and Best Practices

- **Duplicate Reads**: By default, epic2 removes duplicates. If you have high-complexity libraries or specific reasons to keep them, use the `--keep-duplicates` flag.
- **Custom Genomes**: If working with a non-standard assembly, provide the chromosome sizes and effective genome fraction manually:
  ```bash
  epic2 -t treatment.bam -cs custom_chrom.sizes -egf 0.85
  ```
- **Input Formats**: epic2 natively supports `.bam`, `.sam`, `.bed`, and `.bedpe` (including gzipped versions). You can mix formats in the same command if necessary.
- **Paired-End Data**: While epic2 handles single-end by default, use the `--guess-bampe` flag to enable better support for paired-end BAM/SAM files.
- **Effective Genome Fraction**: This value (between 0 and 1) represents the mappable portion of the genome. If unknown for a custom genome, 0.7-0.9 is a common range for most eukaryotes.

## Reference documentation
- [epic2 GitHub Repository](./references/github_com_biocore-ntnu_epic2.md)