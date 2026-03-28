---
name: pbfusion
description: pbfusion identifies fusion genes in long-read Iso-Seq data by analyzing aligned BAM files to detect transcripts spanning multiple genomic loci. Use when user asks to discover gene fusions, serialize GTF files for faster processing, or filter fusion calls based on quality and read support.
homepage: https://github.com/PacificBiosciences/pbfusion
---

# pbfusion

## Overview

pbfusion is a specialized bioinformatic tool developed by Pacific Biosciences for identifying fusion genes in long-read Iso-Seq data. It works by analyzing aligned BAM files to detect transcripts that span multiple genomic loci, indicating a fusion event. This skill should be used when you need to perform fusion discovery, optimize annotation processing via caching, or troubleshoot fusion calling parameters for high-fidelity (HiFi) transcriptomic data.

## Core Workflow

### 1. Reference Preparation (Optional but Recommended)
For repeated analyses using the same reference, serialize the GTF/GFF file into a binary format to significantly reduce startup time.

```bash
pbfusion gff-cache --gtf reference.gtf --gtf-out reference.gtf.bin
```

### 2. Fusion Discovery
The primary command for identifying fusions. It requires aligned, sorted BAM data and a matching GTF annotation.

```bash
pbfusion discover --gtf reference.gtf.bin --output-prefix sample_name input.bam
```

**Input Requirements:**
- **BAM:** Must be aligned with `pbmm2` using the `--preset ISOSEQ` and `--sort` flags.
- **GTF:** Must match the reference genome used for the BAM alignment.

## Command Options and Best Practices

### Quality and Confidence Filtering
pbfusion uses several heuristics to separate true fusions from artifacts. Adjust these based on your specific research needs:

- **Fusion Quality:** Use `--min-fusion-quality` to set the stringency. `MEDIUM` (default) is recommended for most applications, while `LOW` can be used for discovery-heavy exploratory work.
- **Read Support:** Use `--min-coverage` (default: 2) to filter events with low read support. For single-cell data, this also triggers real-cell filtering based on the "rc" tag.
- **Alignment Identity:** Use `--min-mean-identity` (default: 0.93) to ensure the fusion segments are well-aligned to the reference.

### Handling False Positives
Long-read data can occasionally produce artifacts in specific regions. pbfusion provides flags to manage these:

- **Immunological Genes:** By default, immunological genes and pseudogenes are marked low-quality. Use `--allow-immune` to include them.
- **Mitochondrial Genes:** Use `--allow-mito` if you suspect relevant mitochondrial fusion events, though these are typically false positives.
- **Promiscuous Genes:** The `--prom-filter` (default: 8) removes events involving genes that appear to have an implausibly high number of different fusion partners.

### Performance
- **Threading:** By default, pbfusion uses all available logical cores. Manually restrict this in HPC environments using `--threads <int>`.
- **Verbosity:** Use `-v` to generate auxiliary diagnostic files, including unannotated segments and individual transcript breakpoints.

## Output Interpretation
The primary output file is `{prefix}.breakpoints.groups.bed`. This is a **BEDPE** formatted file containing clustered breakpoint calls. 

- **Main Output:** `{prefix}.breakpoints.groups.bed` (Clustered calls for end users).
- **Auxiliary Outputs (with -v):** 
    - `{prefix}.breakpoints.bed`: All raw detected breakpoints.
    - `{prefix}.transcripts`: Plain text list of every transcript containing a breakpoint.
    - `{prefix}.unannotated.bed`: Segments that did not map to known gene annotations.



## Subcommands

| Command | Description |
|---------|-------------|
| pbfusion discover | Identify fusion genes in aligned PacBio Iso-Seq data |
| pbfusion gff-cache | Cache exonic information from a gtf/gff file in binary format for faster `pbfusion discover` invocations. |

## Reference documentation
- [pbfusion README](./references/github_com_PacificBiosciences_pbfusion_blob_master_README.md)