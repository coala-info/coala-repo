---
name: macs2
description: MACS2 identifies protein-DNA interaction sites and calls peaks from ChIP-seq data. Use when user asks to call narrow or broad peaks, perform differential binding analysis, generate signal tracks, or analyze paired-end sequencing data.
homepage: https://pypi.org/project/MACS2/
---


# macs2

## Overview

MACS2 (Model-based Analysis of ChIP-Seq) is a powerful suite of tools designed to identify protein-DNA interaction sites. It improves the spatial resolution of binding sites by empirically modeling the length of sequenced ChIP fragments and uses a dynamic Poisson distribution to account for local genomic biases. This skill provides the procedural knowledge to execute standard peak calling, perform differential analysis, and generate high-quality signal tracks using both the main `callpeak` function and specialized subcommands.

## Core Workflows

### 1. Standard Peak Calling (Narrow Peaks)
Use this for transcription factor (TF) datasets where binding sites are discrete and well-defined.

```bash
macs2 callpeak -t treatment.bam -c control.bam -f BAM -g hs -n experiment_name -q 0.01
```
*   `-g`: Genome size (e.g., `hs` for human, `mm` for mouse, `ce` for C. elegans, `dm` for fruit fly).
*   `-q`: The q-value (minimum FDR) cutoff for peak detection (default is 0.05).

### 2. Broad Peak Calling
Use this for histone modifications (e.g., H3K36me3) or markers that cover wider genomic regions.

```bash
macs2 callpeak -t treatment.bam -c control.bam --broad -g hs --broad-cutoff 0.1
```

### 3. Paired-End Data
For paired-end sequencing, MACS2 can use the actual insertion length of each library fragment rather than modeling it.

```bash
macs2 callpeak -t treatment.bam -c control.bam -f BAMPE -g hs -n pe_experiment
```

### 4. Generating Signal Tracks (FE and logLR)
To create tracks for visualization (e.g., BigWig conversion), use the `-B` and `--SPMR` (Signal Per Million Reads) flags.

```bash
# Step 1: Generate bedGraph files
macs2 callpeak -t treatment.bam -c control.bam -B --SPMR -g hs -n experiment

# Step 2: Calculate Fold Enrichment (FE)
macs2 bdgcmp -t experiment_treat_pileup.bdg -c experiment_control_lambda.bdg -o experiment_FE.bdg -m FE

# Step 3: Calculate log10 Likelihood Ratio (logLR)
macs2 bdgcmp -t experiment_treat_pileup.bdg -c experiment_control_lambda.bdg -o experiment_logLR.bdg -m logLR -p 0.00001
```

### 5. Differential Binding Analysis
To find regions significantly different between two conditions (Condition 1 vs Condition 2).

```bash
# Step 1: Generate pileup for both conditions without SPMR
macs2 callpeak -t cond1_ChIP.bam -c cond1_Ctrl.bam -B -n cond1 --nomodel --extsize 147
macs2 callpeak -t cond2_ChIP.bam -c cond2_Ctrl.bam -B -n cond2 --nomodel --extsize 147

# Step 2: Call differential regions (d1 and d2 are total non-redundant reads)
macs2 bdgdiff --t1 cond1_treat_pileup.bdg --c1 cond1_control_lambda.bdg \
              --t2 cond2_treat_pileup.bdg --c2 cond2_control_lambda.bdg \
              --d1 12914669 --d2 14444786 -g 60 -l 120 --o-prefix diff_out
```

## Expert Tips and Best Practices

*   **Duplicate Reads**: By default, MACS2 keeps only one read per genomic position (`--keep-dup 1`). For high-depth libraries or ATAC-Seq, consider using `--keep-dup all` or `--keep-dup auto` if you have high confidence in library complexity.
*   **Fragment Size**: If the model fails (common in low-enrichment samples), use `--nomodel` and manually specify the fragment size with `--extsize`.
*   **Effective Genome Size**: If working with a non-standard organism, provide the actual number of mappable bases to `-g` (e.g., `-g 1.2e8`).
*   **ATAC-Seq**: For ATAC-Seq, it is common to use `macs2 callpeak -f BAMPE --nomodel --shift -100 --extsize 200` to center the signal on the transposase insertion site.
*   **Subcommand Pipelines**: For highly customized analysis (e.g., DNAse-Seq), decompose `callpeak` into `filterdup` -> `predictd` -> `pileup` -> `bdgcmp` -> `bdgpeakcall`.



## Subcommands

| Command | Description |
|---------|-------------|
| bdgbroadcall | MACS2 subtool to call broad peaks from bedGraph score tracks. |
| bdgcmp | Deduct noise by comparing treatment and control bedGraph files from MACS2 |
| bdgdiff | Differential peak detection based on paired bedGraph files |
| bdgopt | Modify the score column of a bedGraph file using various methods like multiply, add, max, min, or p2q conversion. |
| bdgpeakcall | Call peaks from bedGraph output of MACS2 |
| callpeak | Model-based Analysis of ChIP-Seq (MACS2) for identifying transcript factor binding sites. |
| cmbreps | Combine scores from replicates in bedGraph format using various methods like Fisher's, max, or mean. |
| filterdup | Filter duplicate reads from alignment files based on a binomial distribution test or a fixed threshold. |
| pileup | Create a pileup bedGraph file from alignment files |
| predictd | Predict fragment size from ChIP-seq alignment files using MACS2 |
| randsample | Randomly sample alignment files to a specific number or percentage of tags. |
| refinepeak | Refine peak summits and give a score measuring the balance of Watson and Crick tags. MACS2 refinepeak is used to take a candidate peak list and alignment files to refine the peak summits. |

## Reference documentation
- [Advanced: Call peaks using MACS2 subcommands](./references/github_com_macs3-project_MACS_wiki_Advanced_3A-Call-peaks-using-MACS2-subcommands.md)
- [Build Signal Track](./references/github_com_macs3-project_MACS_wiki_Build-Signal-Track.md)
- [Call differential binding events](./references/github_com_macs3-project_MACS_wiki_Call-differential-binding-events.md)
- [MACS2 callpeak documentation](./references/macs3-project_github_io_MACS_docs_callpeak.html.md)