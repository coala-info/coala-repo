---
name: umi_tools
description: The `umi_tools` suite provides a robust framework for handling UMIs and cell barcodes, which are critical for accurate molecule quantification in NGS experiments.
homepage: https://github.com/CGATOxford/UMI-tools
---

# umi_tools

## Overview

The `umi_tools` suite provides a robust framework for handling UMIs and cell barcodes, which are critical for accurate molecule quantification in NGS experiments. By incorporating UMI sequences into the deduplication process, the tool can distinguish between identical reads that are true biological duplicates and those that are technical artifacts from PCR. This skill guides the user through the standard pipeline: preparing raw reads, identifying valid cell barcodes, and performing error-aware deduplication or counting using network-based algorithms like the "directional" method.

## Common CLI Workflows

### 1. Pre-alignment: UMI Extraction
Before alignment, UMIs must be moved from the sequence into the read header so that aligners do not treat them as mismatches.

**Basic extraction (UMI at the start of the read):**
```bash
umi_tools extract --extract-umi-method=read_id --bc-pattern=NNNNNNNN --stdin=input.fastq.gz --stdout=processed.fastq.gz
```

**Single-cell extraction (Cell Barcode + UMI):**
```bash
umi_tools extract --bc-pattern=CCCCCCCCCCCCCCCCNNNNNNNNNN --stdin=R1.fastq.gz --read2-in=R2.fastq.gz --stdout=R1_extracted.fastq.gz --read2-out=R2_extracted.fastq.gz
```
*   `C`: Cell barcode position
*   `N`: UMI position

### 2. Single-Cell Whitelisting
For droplet-based scRNA-Seq (e.g., 10X), use `whitelist` to identify "real" cells versus empty droplets.

```bash
umi_tools whitelist --stdin=R1.fastq.gz --bc-pattern=CCCCCCCCCCCCCCCCNNNNNNNNNN --set-cell-number=1000 --log2stderr > whitelist.txt
```

### 3. Post-alignment: Deduplication
After aligning the extracted reads to a reference genome (producing a BAM file), use `dedup` to remove PCR duplicates. The BAM file must be indexed.

```bash
# Sort and index first
samtools sort aligned.bam -o aligned_sorted.bam
samtools index aligned_sorted.bam

# Deduplicate
umi_tools dedup -I aligned_sorted.bam --output-stats=dedup_stats -S deduplicated.bam
```

### 4. Post-alignment: Counting
To generate a gene-level count matrix (common in scRNA-Seq), use `count`.

```bash
umi_tools count --per-gene --gene-tag=XT --per-cell -I aligned_sorted.bam -S counts.tsv.gz
```

## Expert Tips and Best Practices

*   **The "Directional" Method**: Always prefer `--method=directional` (the default). It is a network-based approach that is highly effective at correcting UMI sequencing errors by identifying "parent" UMIs and their likely error-derived "children."
*   **BAM Requirements**: Commands like `dedup`, `group`, and `count` require the input BAM file to be sorted and indexed (`samtools index`).
*   **Memory Management**: For very large datasets, use the `--temp-dir` option to specify a high-capacity disk location for temporary files during sorting/grouping.
*   **Read Identification**: If your UMIs are already in the read headers (e.g., provided by a sequencing facility), use `--extract-umi-method=read_id`.
*   **Paired-End Data**: When running `dedup` on paired-end data, use the `--paired` flag to ensure both ends of the fragment are considered during duplicate identification.

## Reference documentation
- [UMI-tools GitHub Repository](./references/github_com_CGATOxford_UMI-tools.md)
- [Bioconda umi_tools Overview](./references/anaconda_org_channels_bioconda_packages_umi_tools_overview.md)