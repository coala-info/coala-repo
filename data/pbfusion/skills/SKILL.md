---
name: pbfusion
description: pbfusion identifies fusion gene events and precise breakpoints from PacBio long-read Iso-Seq data. Use when user asks to detect gene fusions, identify transcript breakpoints, or process aligned Iso-Seq BAM files for fusion discovery.
homepage: https://github.com/PacificBiosciences/pbfusion
---


# pbfusion

## Overview

pbfusion is a specialized tool designed to identify fusion gene events from PacBio long-read Iso-Seq data. It processes aligned BAM files to detect breakpoints where transcripts span multiple genomic loci. By leveraging the full-length nature of Iso-Seq reads, it provides high-confidence fusion calls with precise breakpoint resolution, distinguishing true fusions from alignment artifacts or read-through events.

## Usage Workflows

### 1. Pre-processing Annotations (Recommended)
The GTF parsing step is computationally expensive. If running pbfusion multiple times against the same reference, generate a binary cache first.

```bash
pbfusion gff-cache --gtf reference.gtf --gtf-out reference.gtf.bin
```

### 2. Fusion Discovery
Run the discovery subcommand on aligned Iso-Seq data.

```bash
pbfusion discover \
    --gtf reference.gtf.bin \
    --output-prefix sample_name \
    --threads 8 \
    aligned_isoseq.bam
```

## Input Requirements

*   **BAM Files**: Must be aligned using `pbmm2` with the `--preset ISOSEQ` and `--sort` flags. The tool accepts both raw Iso-Seq reads and polished transcripts (output from `isoseq3 cluster`).
*   **GTF/GFF**: Must match the reference genome used for the BAM alignment.
*   **Binary Cache**: If using a cached file from `gff-cache`, the filename must end in `.bin` (or `.bin.xz`/`.bin.gz`) for pbfusion to recognize it.

## Expert Tips and Best Practices

*   **Quality Filtering**: The default `--min-fusion-quality` is `MEDIUM`. If you are getting too few results in a discovery phase, you can set it to `LOW`, but be prepared for higher false-positive rates.
*   **Single-Cell Data**: When working with single-cell Iso-Seq data, use the `--min-coverage` (default 2) and `--real-cell-filtering` flags. Reads with a zero "rc" (real cell) tag value will be filtered out.
*   **Reducing False Positives**:
    *   **Read-throughs**: Adjust `--max-readthrough` (default 100,000). Events spanning two genes closer than this distance are often marked as low quality.
    *   **Promiscuous Genes**: Use `--prom-filter` (default 8) to filter out genes that appear in an unusually high number of different fusion partners, which often indicates mapping artifacts.
    *   **Immune/Mito Genes**: By default, pbfusion marks fusions involving mitochondrial or immunological genes as low quality. Use `--allow-immune` or `--allow-mito` to permit these if they are relevant to your specific research.
*   **Output Interpretation**: The primary file for end-users is `{prefix}.breakpoints.groups.bed`. This is a BEDPE format file containing the clustered breakpoint calls.

## Reference documentation
- [pbfusion README](./references/github_com_PacificBiosciences_pbfusion_blob_master_README.md)
- [pbfusion Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pbfusion_overview.md)