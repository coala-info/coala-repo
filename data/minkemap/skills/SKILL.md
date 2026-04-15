---
name: minkemap
description: minkemap is a command-line utility that generates circular genome visualizations by aligning sequencing reads or assemblies against a reference genome. Use when user asks to create circular genome plots, visualize sequence alignments as concentric rings, or export coverage metrics from FASTA and FASTQ data.
homepage: https://github.com/erinyoung/MinkeMap
metadata:
  docker_image: "quay.io/biocontainers/minkemap:0.1.0--pyhdfd78af_0"
---

# minkemap

## Overview
minkemap is a command-line utility designed for rapid circular genome visualization, drawing inspiration from tools like BRIG. It leverages `minimap2` (via the `mappy` wrapper) to align sequencing reads or assemblies against a reference genome. The tool automatically generates concentric rings representing different samples, scaling track widths and gaps dynamically. Beyond visualization, it provides data transparency by exporting raw coverage metrics in BED and CSV formats, making it a bridge between raw alignment data and polished figures.

## Core Workflows

### Basic Visualization
To create a standard circular plot using a GenBank reference and FASTA assemblies:
```bash
minkemap -r reference.gbk -i sample1.fasta sample2.fasta --outdir results
```

### Handling FASTQ Data
Direct input via `-i` only supports FASTA. For FASTQ files (Illumina, Nanopore, PacBio), you must use a manifest CSV file with the `-f` flag.

**Manifest Format (manifest.csv):**
`sample,read1,read2,type`
`SampleA,data/s1_R1.fq.gz,data/s1_R2.fq.gz,illumina`
`SampleB,data/s2.fastq,,nanopore`

**Command:**
```bash
minkemap -r reference.gbk -f manifest.csv --outdir results
```

### Customizing Annotations and Highlights
*   **Annotations (`--annotations`):** Adds labels to the outermost ring. Requires a CSV with: `reference,start,stop,label,color`.
*   **Highlights (`--highlights`):** Adds semi-transparent "wedges" behind all tracks to mark regions of interest. Requires a CSV with: `start,end,color,label`.

```bash
minkemap -r reference.gbk -i samples/*.fasta \
  --annotations custom_regions.csv \
  --highlights wedges.csv
```

## Expert Tips and Best Practices

### Filtering for Quality
Use identity and coverage filters to remove noise from the visualization, especially when working with raw long-read data:
*   `--min-identity 90`: Only show alignment blocks with at least 90% identity.
*   `--min-coverage 50`: Only include reads/contigs that cover at least 50% of the query length.

### Aesthetic Refinement
*   **Palettes:** Use `--palette` with presets like `viridis`, `plasma`, or `whale`, or provide a custom list of hex codes (e.g., `#ff0000,#0000ff`).
*   **Clean Layouts:** Use `--no-backbone` to remove the central black reference axis for a more modern look.
*   **Gene Filtering:** If the gene track is cluttered, use `--exclude-genes "hypothetical,putative"` to hide specific keywords.
*   **Vector Output:** For publication, always specify a vector format in the output name: `-o figure.svg` or `-o figure.pdf`.

### Interpreting Outputs
minkemap produces more than just an image. Always check the `--outdir` (default: `minkemap_results`) for:
*   `summary.csv`: Contains coverage percentages, average depth, and gene counts per track.
*   `*.bed` / `*.coverage.csv`: Raw data for downstream analysis or custom plotting.
*   `minkemap.log`: Essential for troubleshooting alignment issues.

## Reference documentation
- [MinkeMap GitHub Repository](./references/github_com_erinyoung_MinkeMap.md)
- [MinkeMap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_minkemap_overview.md)