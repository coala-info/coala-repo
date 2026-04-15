---
name: ataqv
description: ataqv is a quality control toolkit for ATAC-seq data that quantifies metrics like fragment length distribution and TSS enrichment. Use when user asks to assess ATAC-seq library quality, extract QC metrics from BAM files, or generate an interactive visualization dashboard for experiment results.
homepage: https://parkerlab.github.io/ataqv/
metadata:
  docker_image: "quay.io/biocontainers/ataqv:1.3.1--py310h50a2689_5"
---

# ataqv

## Overview
ataqv is a specialized toolkit designed for the rigorous quality control of ATAC-seq experiments. It helps researchers identify technical variation introduced during library preparation or sequencing by quantifying key metrics such as fragment length distributions (FLD), transcription start site (TSS) enrichment, and mapping quality. Use this skill to execute the core `ataqv` metric extraction and the `mkarv` visualization workflow.

## Core Usage Patterns

### Running ataqv Metrics
The primary command extracts QC metrics from a BAM file. It requires a configuration for the specific organism (to identify autosomal vs. mitochondrial reads).

```bash
# Basic usage
ataqv <organism> <input.bam>

# Common organisms supported out-of-the-box:
# human (hg19/hg38), mouse (mm9/mm10), rat (rn6), fly (dm6)
ataqv human sample_sorted.bam
```

### Generating the Results Viewer (mkarv)
`mkarv` (Make Ataqv Results Viewer) aggregates the JSON outputs from the `ataqv` command into an interactive web dashboard.

```bash
# Create a visualization directory from multiple JSON metric files
mkarv <output_directory> <sample1.json> <sample2.json> ... <sampleN.json>
```

## Expert Tips & Best Practices

- **Fragment Length Distribution (FLD):** Look for the "canonical" ATAC-seq pattern: a sharp peak at <100bp (sub-nucleosomal) followed by periodic peaks representing mono-, di-, and tri-nucleosomes.
- **TSS Enrichment:** High-quality libraries typically show a strong enrichment of transposition events at transcription start sites. Use the TSS enrichment plot in the viewer to validate signal-to-noise ratios.
- **Mitochondrial Contamination:** Monitor the `Mitochondrial, % of all reads` metric. High percentages often indicate poor library quality or inefficient transposition.
- **Comparison Mode:** When using `mkarv`, include a reference JSON file (if available) to compare new experiments against a known "gold standard" library.
- **Library Prep Troubleshooting:** Use the "Distance from reference FLD" plot to identify libraries with shifted periodicity, which often points to over- or under-digestion during the transposition step.

## Reference documentation
- [ataqv Overview](./references/anaconda_org_channels_bioconda_packages_ataqv_overview.md)
- [ataqv Project Home](./references/parkerlab_github_io_ataqv.md)
- [ataqv Results Viewer Demo](./references/parkerlab_github_io_ataqv_demo_index.html.md)