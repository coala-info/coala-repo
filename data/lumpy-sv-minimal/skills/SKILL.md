---
name: lumpy-sv-minimal
description: LUMPY is a structural variant discovery tool that integrates discordant read pairs and split-read alignments into a probabilistic framework to identify genomic rearrangements. Use when user asks to detect structural variants, run automated lumpyexpress workflows, or perform manual breakpoint detection using BWA-MEM aligned genomic data.
homepage: https://github.com/arq5x/lumpy-sv
metadata:
  docker_image: "quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7"
---

# lumpy-sv-minimal

## Overview

LUMPY is a structural variant discovery tool that integrates multiple signals—including discordant read pairs and split-read alignments—into a single probabilistic framework. This skill focuses on the native command-line interface for LUMPY, specifically the `lumpyexpress` wrapper for automated workflows and the core `lumpy` tool for advanced, customizable breakpoint detection. It is designed for bioinformaticians processing genomic data aligned with BWA-MEM to identify complex genomic rearrangements.

## Core Workflows

### 1. Automated Analysis with lumpyexpress

For standard analyses, use `lumpyexpress`. It automates the extraction of discordant and split reads and runs the LUMPY algorithm with best-practice parameters.

**Single Sample (Basic):**
```bash
lumpyexpress \
    -B sample.bam \
    -S sample.splitters.bam \
    -D sample.discordants.bam \
    -o sample.vcf
```

**Joint Analysis (Multi-sample):**
Supply comma-separated lists for each input type.
```bash
lumpyexpress \
    -B s1.bam,s2.bam \
    -S s1.splitters.bam,s2.splitters.bam \
    -D s1.discordants.bam,s2.discordants.bam \
    -o multi_sample.vcf
```

### 2. Manual Pre-processing

If not using the automated extraction in `lumpyexpress`, you must manually prepare the evidence files using `samtools` and `samblaster`.

**Extract Discordants:**
```bash
samtools view -b -F 1294 sample.bam > sample.discordants.unsorted.bam
```

**Extract Split-reads:**
```bash
samtools view -h sample.bam | extractSplitReads_BwaMem -i stdin | samtools view -Sb - > sample.splitters.unsorted.bam
```

**Sort Evidence:**
```bash
samtools sort sample.discordants.unsorted.bam -o sample.discordants.bam
samtools sort sample.splitters.unsorted.bam -o sample.splitters.bam
```

### 3. Traditional LUMPY Usage

For advanced users requiring specific weights or window sizes.

```bash
lumpy \
    -mw 4 \
    -tt 0 \
    -pe bam_file:sample.discordants.bam,id:sample,histo_file:sample.lib1.histo,mean:300,stdev:50,read_length:101,min_non_overlap:101,discordant_z:3,back_distance:10,weight:1 \
    -sr bam_file:sample.splitters.bam,id:sample,back_distance:10,weight:1 \
    > sample.lumpy.vcf
```

## Expert Tips and Best Practices

- **Input Requirements**: LUMPY expects BWA-MEM aligned BAM files. Ensure your BAM files have proper `@RG` (Read Group) tags, as `lumpyexpress` uses these to parse sample and library information.
- **Exclusion Regions**: Use the `-x` flag with a BED file to exclude telomeres, centromeres, or high-signal regions (e.g., ENCODE blacklisted regions) to reduce false positives and improve runtime.
- **CRAM Support**: While `lumpyexpress` can accept CRAM files as the main input (`-B`), the splitters (`-S`) and discordants (`-D`) must currently be in BAM format.
- **Library Statistics**: When using traditional `lumpy`, the `-pe` (paired-end) parameter requires library statistics (mean and stdev of insert size). Use the `pairend_distro.py` script provided in the LUMPY repository to generate the required `.histo` file and statistics.
- **Minimum Weight**: The `-m` (in `lumpyexpress`) or `-mw` (in `lumpy`) flag controls the minimum evidence weight required to call a variant. The default is 4; increasing this can reduce false positives in high-coverage data.



## Subcommands

| Command | Description |
|---------|-------------|
| lumpy-sv-minimal_lumpy | Find structural variations in various signals. |
| lumpyexpress | Sourcing executables from /usr/local/bin/lumpyexpress.config ... |

## Reference documentation

- [LUMPY: a general probabilistic framework for structural variant discovery](./references/github_com_arq5x_lumpy-sv.md)