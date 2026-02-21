name: allo
description: Multi-mapped read rescue strategy for gene regulatory analyses (ChIP-seq, ATAC-seq, DNase-seq, and RNA-seq). Use when you need to allocate multi-mapped reads (MMRs) to their most likely genomic origins using neural networks or read-count distributions to improve the sensitivity of peak calling and quantification.

# Allo: Multi-Mapped Read Rescue

Allo rescues multi-mapped reads by allocating them based on local uniquely-mapped read (UMR) distributions and pre-trained Convolutional Neural Networks (CNNs).

## Prerequisites

### 1. Alignment Requirements
Aligners must be configured to report multiple locations (e.g., up to 25).
- **Bowtie1 (SE/PE):** Use `-m 25 -k 25 --best --strata`
- **Bowtie2 (SE/PE):** Use `-k 25`. For PE, add `--no-mixed --no-discordant`
- **BWA (SE only):** Use `bwa mem -a`. (BWA Paired-end is NOT supported)
- **STAR (RNA-seq):** Use `--outSAMmultNmax 25 --outFilterType BySJout`

### 2. Mandatory Sorting
Input files **must** be sorted by read name, not genomic coordinates.
```bash
samtools collate -o input_sorted.bam input_unsorted.bam
```

## Core Usage

Basic command structure:
```bash
allo <input.bam_or.sam> -seq <se|pe> -o <output_prefix> [options]
```

### Peak-Based Applications (ChIP-seq, ATAC-seq, DNase-seq)
Select the appropriate CNN model for your assay:
- **Default (Narrow peaks):** `allo input.bam -seq pe -o output`
- **Histone/Mixed peaks:** Add `--mixed`
- **DNase-seq:** Add `--dnase`
- **ATAC-seq:** Add `--atac`

### RNA-seq Applications
Since CNNs are not trained for RNA-seq, use read-count mode and handle splicing:
```bash
allo input.bam -seq pe -o output --readcount --splice
```

## Expert Tips & Best Practices

### Handling Controls (Input)
For ChIP-seq experiments, run Allo on both the target and the control (Input) files. 
- **Recommendation:** Use the `--random` flag for the control file to balance background noise without over-fitting to specific regions.

### Filtering and Downstream Analysis
Allo adds custom tags to allocated reads in the output BAM:
- `ZA`: Allocated MMR (value = number of mapping locations).
- `ZZ`: Randomly assigned MMR (allocated to regions with 0 UMRs).

**To extract only uniquely mapped reads:**
```bash
samtools view -h output.bam | grep -vE "ZA:|ZZ:" | samtools view -b > unique_only.bam
```

**To filter by mapping multiplicity (e.g., max 10 locations):**
Use the `-max 10` flag during the Allo run to ignore reads mapping to more than 10 locations.

### Performance
- Use `-p <int>` to specify the number of processes for parallel execution.
- If memory is an issue, ensure you are using the latest version (v1.2.0+) which utilizes optimized dictionary window sizes.

## Command Options Summary

| Option | Description |
| :--- | :--- |
| `-seq` | **Required.** Sequencing mode: `se` (single-end) or `pe` (paired-end). |
| `--readcount` | Allocates based on UMR counts only (no CNN). Required for RNA-seq. |
| `--splice` | Removes introns (CIGAR 'N') when calculating UMR density. |
| `--remove-zeros` | Discards MMRs that only map to regions with zero UMRs. |
| `--keep-unmap` | Retains unmapped reads in the output file. |
| `--parser` | Utility to pre-split unique and multi-mapped reads into separate files. |