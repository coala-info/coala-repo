---
name: pbsv
description: pbsv identifies structural variants from PacBio long-read data by discovering signatures and calling genotypes. Use when user asks to discover structural variant signatures, call and genotype variants from SVSIG files, or perform joint calling on multiple samples.
homepage: https://github.com/PacificBiosciences/pbsv
metadata:
  docker_image: "quay.io/biocontainers/pbsv:2.11.0--h9ee0642_0"
---

# pbsv

## Overview

The `pbsv` suite is designed specifically for PacBio long-read data to identify structural variants including insertions, deletions, inversions, duplications, and translocations. It is optimized for variants ranging from 20 bp up to 100 kb (and larger for translocations). This skill helps navigate the transition from raw reads to a final VCF, ensuring that sample metadata is preserved and sensitivity is maximized through the use of tandem repeat annotations.

## Core Workflow

### 1. Alignment (Pre-requisite)
Before using `pbsv`, reads must be aligned using `pbmm2`. Ensure the `--sample` tag is used to associate reads with a specific sample name, which is critical for joint calling.

*   **CCS/HiFi Data:** `pbmm2 align ref.fa movie.ccs.bam aligned.bam --sort --preset CCS --sample sample1`
*   **Subreads:** `pbmm2 align ref.fa movie.subreads.bam aligned.bam --sort --median-filter --sample sample1`

### 2. Discover Signatures
Identify SV signatures from aligned BAM files. This step generates `.svsig.gz` files.

```bash
pbsv discover --tandem-repeats human_GRCh38.trf.bed aligned.bam sample1.svsig.gz
```

**Expert Tips:**
*   **Tandem Repeats:** Always provide a tandem repeat annotation file (`.bed`) via `--tandem-repeats` to significantly improve sensitivity and recall in repetitive regions.
*   **Indexing:** Use `tabix -c '#' -s 3 -b 4 -e 4 file.svsig.gz` to enable random access, which is required if you plan to use the `-r/--region` flag during the calling stage.

### 3. Call and Genotype
Generate the final VCF from one or more signature files.

```bash
# For CCS/HiFi data, always include the --ccs flag
pbsv call --ccs ref.fa sample1.svsig.gz sample2.svsig.gz output.vcf
```

**Expert Tips:**
*   **Joint Calling:** You can pass multiple `.svsig.gz` files to `pbsv call` to perform multi-sample joint calling.
*   **Thread Management:** Use `-j` to specify the number of threads for faster processing.

## Parallel Processing by Chromosome
For large genomes or high coverage, process chromosomes independently to save time and manage memory.

1.  **Discover per region:**
    ```bash
    pbsv discover --region chr1 aligned.bam sample1.chr1.svsig.gz
    ```
2.  **Call globally:**
    ```bash
    pbsv call -j 8 ref.fa sample1.*.svsig.gz output.vcf
    ```

## Advanced Parameter Tuning

| Parameter | Tool | Purpose | Default |
| :--- | :--- | :--- | :--- |
| `-k, --max-skip-split` | discover | Max distance between split alignments | 100 bp |
| `--cluster-max-ref-pos-diff` | call | Max distance to cluster signatures | 200 bp |
| `--max-ins-length` | call | Upper limit for insertion size | 15k |
| `-x, --max-consensus-coverage` | call | Max reads used for consensus | 20 |



## Subcommands

| Command | Description |
|---------|-------------|
| pbsv call | Call structural variants from SV signatures and assign genotypes (SVSIG to VCF). |
| pbsv discover | Find structural variant (SV) signatures in read alignments (BAM to SVSIG). |

## Reference documentation
- [Official pbsv README](./references/github_com_PacificBiosciences_pbsv_blob_master_README.md)
- [Human GRCh38 Tandem Repeat Annotations](./references/github_com_PacificBiosciences_pbsv_blob_master_annotations_human_GRCh38_no_alt_analysis_set.trf.bed.md)
- [Human hg19/hs37d5 Tandem Repeat Annotations](./references/github_com_PacificBiosciences_pbsv_blob_master_annotations_human_hs37d5.trf.bed.md)