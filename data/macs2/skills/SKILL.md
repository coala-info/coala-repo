---
name: macs2
description: MACS2 identifies transcription factor binding sites and histone modification enrichments from ChIP-Seq data. Use when user asks to call narrow or broad peaks, generate signal tracks for visualization, or perform differential binding analysis between conditions.
homepage: https://pypi.org/project/MACS2/
---

# macs2

## Overview
MACS2 is a powerful toolset for identifying transcript factor binding sites or histone modification enrichments from ChIP-Seq data. It improves spatial resolution by modeling fragment lengths and uses a dynamic Poisson distribution to account for local genomic biases. Beyond standard peak calling, it provides subcommands for signal track comparison, duplicate filtering, and differential binding analysis between two conditions.

## Core Workflows

### 1. Standard Peak Calling (Narrow Peaks)
Use `callpeak` for transcription factors or narrow histone marks (e.g., H3K4me3).
```bash
macs2 callpeak -t treatment.bam -c control.bam -f BAM -g hs -n experiment_name -B -q 0.01
```
- `-g`: Effective genome size (e.g., `hs` for human, `mm` for mouse, `ce` for C. elegans).
- `-B`: Generates bedGraph files (required for signal tracks).
- `-q`: FDR (q-value) cutoff; default is 0.05.

### 2. Broad Peak Calling
Use for broad histone marks (e.g., H3K36me3, H3K27me3).
```bash
macs2 callpeak -t treatment.bam -c control.bam --broad -g hs --broad-cutoff 0.1
```

### 3. Generating Signal Tracks (FE and logLR)
To visualize enrichment in genome browsers, use `bdgcmp` on the bedGraph files produced by `callpeak`.
```bash
# Calculate Fold Enrichment (FE)
macs2 bdgcmp -t treat_pileup.bdg -c control_lambda.bdg -o out_FE.bdg -m FE

# Calculate log10 Likelihood Ratio (logLR)
macs2 bdgcmp -t treat_pileup.bdg -c control_lambda.bdg -o out_logLR.bdg -m logLR -p 0.00001
```

### 4. Differential Binding Analysis
Identify regions with significant differences between two conditions.
```bash
# Step 1: Run callpeak for both conditions with -B and without --SPMR
macs2 callpeak -B -t cond1_ChIP.bam -c cond1_Ctrl.bam -n cond1 --nomodel --extsize 147
macs2 callpeak -B -t cond2_ChIP.bam -c cond2_Ctrl.bam -n cond2 --nomodel --extsize 147

# Step 2: Run bdgdiff using the depths (d1, d2) from the callpeak logs
macs2 bdgdiff --t1 cond1_treat_pileup.bdg --c1 cond1_control_lambda.bdg \
              --t2 cond2_treat_pileup.bdg --c2 cond2_control_lambda.bdg \
              --d1 12914669 --d2 14444786 -o-prefix diff_out
```

## Expert Tips & Best Practices
- **Paired-end Data**: Use `-f BAMPE`. MACS2 will use the actual insert sizes from the fragments instead of modeling them.
- **Duplicate Reads**: By default, MACS2 keeps only one read per position (`--keep-dup 1`). For high-depth experiments, consider `--keep-dup auto`.
- **Fragment Size**: If the model fails, use `--nomodel --extsize [L]` where L is your expected fragment length (e.g., 147 for nucleosomes).
- **Normalization**: Use `--SPMR` (Signal Per Million Reads) during `callpeak` only if you intend to compare tracks visually; do NOT use it for `bdgdiff`.
- **Subcommand Pipeline**: For highly customized analysis, you can manually run `filterdup` -> `predictd` -> `pileup` -> `bdgcmp` -> `bdgpeakcall`.



## Subcommands

| Command | Description |
|---------|-------------|
| macs2 bdgbroadcall | MACS2 subtool to call broad peaks from bedGraph score tracks. |
| macs2 bdgcmp | Deduct noise by comparing treatment and control bedGraph files from MACS2 |
| macs2 bdgdiff | Differential peak detection based on paired bedGraph files |
| macs2 bdgopt | Modify the score column of a bedGraph file using various methods like multiply, add, max, min, or p2q conversion. |
| macs2 bdgpeakcall | Call peaks from bedGraph output of MACS2 |
| macs2 callpeak | Model-based Analysis of ChIP-Seq (MACS2) for identifying transcript factor binding sites. |
| macs2 cmbreps | Combine scores from replicates in bedGraph format using various methods like Fisher's, max, or mean. |
| macs2 filterdup | Filter duplicate reads from alignment files based on a binomial distribution test or a fixed threshold. |
| macs2 pileup | Create a pileup bedGraph file from alignment files |
| macs2 predictd | Predict fragment size from ChIP-seq alignment files using MACS2 |
| macs2 randsample | Randomly sample alignment files to a specific number or percentage of tags. |
| macs2 refinepeak | Refine peak summits and give a score measuring the balance of Watson and Crick tags. MACS2 refinepeak is used to take a candidate peak list and alignment files to refine the peak summits. |

## Reference documentation
- [Advanced: Call peaks using MACS2 subcommands](./references/github_com_macs3-project_MACS_wiki_Advanced_3A-Call-peaks-using-MACS2-subcommands.md)
- [Build Signal Track](./references/github_com_macs3-project_MACS_wiki_Build-Signal-Track.md)
- [Call differential binding events](./references/github_com_macs3-project_MACS_wiki_Call-differential-binding-events.md)
- [MACS2 callpeak documentation](./references/macs3-project_github_io_MACS_docs_callpeak.html.md)