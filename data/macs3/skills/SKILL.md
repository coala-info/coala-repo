---
name: macs3
description: "MACS3 identifies protein-DNA interaction sites and enrichment regions from next-generation sequencing data like ChIP-Seq and ATAC-Seq. Use when user asks to call narrow or broad peaks, generate signal tracks for visualization, or perform differential binding analysis between conditions."
homepage: https://pypi.org/project/MACS3/
---


# macs3

## Overview

MACS3 (Model-based Analysis of ChIP-Seq) is a powerful suite of tools designed to identify protein-DNA interaction sites from next-generation sequencing data. It improves spatial resolution by empirically modeling fragment lengths and uses a dynamic Poisson distribution to account for local genomic biases. Beyond standard ChIP-Seq, MACS3 supports ATAC-Seq analysis, paired-end data, and differential enrichment detection between conditions.

## Core CLI Patterns

### Standard Peak Calling
The most common entry point is the `callpeak` command.

```bash
# Basic narrow peak calling (Human genome, q-value cutoff 0.05)
macs3 callpeak -t treatment.bam -c control.bam -f BAM -g hs -n experiment_out -q 0.05

# Broad peak calling (e.g., for histone marks like H3K36me3)
macs3 callpeak -t treatment.bam -c control.bam --broad -g hs -n experiment_broad

# Paired-end data (automatically handles fragment size)
macs3 callpeak -t treatment.bam -c control.bam -f BAMPE -g hs -n experiment_pe
```

### Signal Track Generation
To create tracks for visualization (e.g., in IGV), use the `-B` flag in `callpeak` followed by `bdgcmp`.

```bash
# 1. Generate bedGraph files during peak calling
macs3 callpeak -t ChIP.bam -c Input.bam -B --SPMR -g hs -n sample

# 2. Calculate Fold Enrichment (FE) track
macs3 bdgcmp -t sample_treat_pileup.bdg -c sample_control_lambda.bdg -o sample_FE.bdg -m FE

# 3. Calculate log10 Likelihood Ratio (logLR) track
macs3 bdgcmp -t sample_treat_pileup.bdg -c sample_control_lambda.bdg -o sample_logLR.bdg -m logLR -p 0.00001
```

### Differential Binding Analysis
To find regions with significant differences between two conditions (Condition 1 vs Condition 2).

```bash
# Step 1: Generate pileup for both conditions (do not use --SPMR)
macs3 callpeak -B -t cond1_ChIP.bam -c cond1_Ctrl.bam -n cond1 --nomodel --extsize 147
macs3 callpeak -B -t cond2_ChIP.bam -c cond2_Ctrl.bam -n cond2 --nomodel --extsize 147

# Step 2: Call differential regions
# Note: -d1 and -d2 are the total non-redundant reads (found in callpeak logs)
macs3 bdgdiff --t1 cond1_treat_pileup.bdg --c1 cond1_control_lambda.bdg \
              --t2 cond2_treat_pileup.bdg --c2 cond2_control_lambda.bdg \
              --d1 15000000 --d2 18000000 -g 60 -l 120 --o-prefix diff_out
```

## Expert Tips and Best Practices

*   **Effective Genome Size (`-g`)**: Always provide the correct genome size. Shortcuts include `hs` (human: 2.7e9), `mm` (mouse: 1.87e9), `ce` (C. elegans: 9e7), and `dm` (Drosophila: 1.2e8). For other organisms, provide the actual number.
*   **Duplicate Reads**: By default, MACS3 keeps only one read per exact genomic location (`--keep-dup 1`). For high-depth libraries or specific assays, you may use `--keep-dup all` or `auto`.
*   **Fragment Size Prediction**: If the model fails to build, use `--nomodel` and manually specify `--extsize` (the expected fragment length) and `--shift` (usually 0 for ChIP-Seq, or negative for specific assays).
*   **ATAC-Seq**: For ATAC-Seq, use the `hmmratac` subcommand which is specifically designed to handle the unique signal distribution of open chromatin assays.
*   **Output Formats**:
    *   `.narrowPeak` / `.broadPeak`: BED6+4 format for genomic browsers.
    *   `.xls`: Contains peak information and the specific parameters used for the run.
    *   `_summits.bed`: Precise point of highest enrichment; ideal for motif discovery.



## Subcommands

| Command | Description |
|---------|-------------|
| bdgbroadcall | MACS3 tool to call broad peaks from bedGraph score tracks |
| bdgcmp | Deduct noise by comparing treatment and control bedGraph files using various methods. |
| bdgdiff | Differential peak detection based on paired bedGraph files |
| bdgopt | Modify the score column of a bedGraph file using various methods. |
| bdgpeakcall | Call peaks from bedGraph output of MACS3 |
| callpeak | Model-based Analysis of ChIP-Seq (MACS) for identifying transcript factor binding sites. |
| callvar | Call variants from ChIP-seq/ATAC-seq treatment and optional control BAM files within peak regions. |
| cmbreps | Combine scores from replicates using different methods such as Fisher's, max, or mean. |
| filterdup | MACS3 filterdup tool to remove duplicate reads at the same location based on binomial distribution. |
| hmmratac | HMMRATAC is a dedicated tool specifically designed for processing ATAC-seq data, utilizing a Hidden Markov Model to learn the nucleosome structure around open chromatin regions. |
| pileup | Create a bedGraph file by piling up alignment files with a given extension size. |
| predictd | Predict d or fragment size from alignment files |
| randsample | Randomly sample tags from alignment files to a specified percentage or number. |
| refinepeak | Refine peak summits and compute enrichment scores using MACS3 |

## Reference documentation
- [Advanced: Call peaks using MACS2 subcommands](./references/github_com_macs3-project_MACS_wiki_Advanced_-Call-peaks-using-MACS2-subcommands.md)
- [Build Signal Track](./references/github_com_macs3-project_MACS_wiki_Build-Signal-Track.md)
- [Call differential binding events](./references/github_com_macs3-project_MACS_wiki_Call-differential-binding-events.md)
- [MACS3 Documentation Overview](./references/macs3-project_github_io_MACS.md)