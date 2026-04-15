---
name: haphic
description: HapHiC scaffolds fragmented genome contigs into chromosome-scale pseudomolecules using Hi-C proximity ligation data. Use when user asks to scaffold a genome assembly, cluster and orient contigs, generate Hi-C contact maps, or perform reference-based sorting.
homepage: https://github.com/zengxiaofei/HapHiC
metadata:
  docker_image: "quay.io/biocontainers/haphic:1.0.7--hdfd78af_0"
---

# haphic

## Overview

HapHiC is a high-performance bioinformatics tool used to bridge the gap between fragmented genome contigs and full chromosome-scale pseudomolecules. It leverages Hi-C proximity ligation data to cluster, order, and orient sequences. Its primary advantage is being "allele-aware," allowing it to accurately scaffold phased assemblies where traditional tools might struggle with homologous chromosomes. It is highly tolerant of assembly errors, such as chimeric contigs, and is optimized for speed and memory efficiency.

## Core Workflow

### 1. Data Preparation
Before running the scaffolding pipeline, Hi-C reads must be aligned to the assembly. HapHiC requires a BAM file that is **not** sorted by coordinate.

**Recommended Alignment Pattern:**
```bash
# Align, mark duplicates, and filter alignments
bwa index asm.fa
bwa mem -5SP -t 28 asm.fa read1.fq.gz read2.fq.gz | samblaster | samtools view - -@ 14 -S -h -b -F 3340 -o HiC.bam

# Filter for quality (MAPQ >= 1) and edit distance (NM < 3)
haphic/utils/filter_bam HiC.bam 1 --nm 3 --threads 14 | samtools view - -b -@ 14 -o HiC.filtered.bam
```

### 2. Scaffolding Pipeline
The simplest way to run HapHiC is via the `pipeline` command, which executes clustering, reassignment, ordering, and building in one go.

**Basic Command:**
```bash
haphic pipeline <asm.fa> <HiC.filtered.bam> <nchrs>
```
*   `<asm.fa>`: The input assembly (contigs/unitigs).
*   `<HiC.filtered.bam>`: The filtered BAM file from step 1.
*   `<nchrs>`: The expected number of chromosomes.

### 3. Visualization and Curation
After scaffolding, you can generate contact maps to validate the results.

**Generate Plot:**
```bash
haphic plot <asm.fa> <HiC.filtered.bam>
```

## Expert Tips and Best Practices

*   **BAM Sorting:** Never use a coordinate-sorted BAM. If your BAM is already sorted by coordinate, you must resort it by read name using `samtools sort -n`.
*   **Restriction Sites:** The default restriction site is `GATC` (MboI/DpnII). If using a different enzyme (e.g., HindIII), specify it using the `--RE` parameter (e.g., `--RE AAGCTT`).
*   **Chimeric Contigs:** HapHiC has built-in modules to detect and correct chimeric contigs (misjoins). This is handled automatically in the `pipeline` command but can be fine-tuned in step-by-step mode.
*   **Quick View Mode:** If the number of chromosomes is unknown, use the "quick view" mode to estimate the assembly structure before committing to a full run.
*   **Juicebox Integration:** HapHiC produces `.review.assembly` files compatible with Juicebox for manual curation. Since version 1.0.6, manual scale factor adjustments in Juicebox are no longer required.
*   **Reference-Based Sorting:** If a reference genome of a related species is available, use `haphic refsort` to order and orient scaffolds based on synteny.

## Common CLI Patterns

**Check Installation:**
```bash
haphic check
```

**Step-by-Step Execution:**
If the automated pipeline fails or requires manual intervention between stages, run the modules individually:
1.  `haphic cluster`: Group contigs into clusters.
2.  `haphic reassign`: Refine cluster assignments.
3.  `haphic sort`: Order and orient contigs within clusters.
4.  `haphic build`: Generate the final FASTA and AGP files.

## Reference documentation
- [HapHiC Main Documentation](./references/github_com_zengxiaofei_HapHiC.md)