---
name: rbpbench
description: rbpbench is a comprehensive toolkit designed to evaluate genomic regions—typically CLIP-seq peaks—by identifying and analyzing RBP binding motifs.
homepage: https://github.com/michauhl/RBPBench
---

# rbpbench

## Overview
rbpbench is a comprehensive toolkit designed to evaluate genomic regions—typically CLIP-seq peaks—by identifying and analyzing RBP binding motifs. It bridges the gap between raw genomic coordinates and biological insights by providing motif search capabilities (sequence and structure), enrichment statistics, and detailed genomic annotations. Use this skill to automate the identification of RBP binding preferences, visualize motif co-occurrences, and generate interactive HTML reports for CLIP-seq datasets.

## Core Workflows

### 1. Motif Search and Annotation
The `search` mode is the primary entry point for analyzing a set of genomic regions.

```bash
rbpbench search \
  --in peaks.bed \
  --genome hg38.fa \
  --gtf annotations.gtf \
  --out output_dir \
  --rbps PUM2 PUM1 RBFOX2 \
  --ext 10 \
  --regex AATAAA
```

**Key Parameters:**
- `--in`: Genomic regions in BED format.
- `--genome`: Reference genome FASTA file.
- `--gtf`: Gene annotation file (required for region coverage profiles and exon-intron statistics).
- `--rbps`: Space-separated list of RBPs to search against the internal database.
- `--ext`: Extend input regions (e.g., `10` for 10nt both ways; `0,20` for 20nt downstream).
- `--regex`: Search for specific sequence patterns (e.g., polyadenylation signals).

### 2. Database Exploration
Before running a search, verify available RBPs and motifs in the rbpbench database.

```bash
# List all supported RBPs and motif sources
rbpbench info
```

### 3. Visualizing Results
rbpbench generates an interactive HTML report (`report.rbpbench_search.html`). To maximize the utility of these reports:
- Use `--plot-motifs` to include PWM visualizations in the output.
- Use `--enable-upset-plot` to visualize the intersection of motif hits across different RBPs.
- Use `--set-rbp-id` when working with specific isoforms or custom motif sets.

## Expert Tips and Best Practices
- **Region Extension**: CLIP-seq peaks are often narrow. Use `--ext` to include flanking sequences if you suspect the binding motif resides just outside the identified peak boundary.
- **Co-occurrence Analysis**: The tool automatically performs Fisher's exact tests to identify significant RBP motif co-occurrences, which is useful for identifying potential RBP complexes or competitive binding.
- **Structure Motifs**: rbpbench supports structure-aware motifs. Ensure your input data and parameters reflect whether you are searching for sequence-only or sequence-structure patterns.
- **Memory Management**: When processing large BED files (e.g., hundreds of datasets), run searches individually or ensure sufficient RAM for the `upsetplot` and `plotly` visualizations.

## Reference documentation
- [rbpbench Overview](./references/anaconda_org_channels_bioconda_packages_rbpbench_overview.md)
- [RBPBench GitHub Repository](./references/github_com_michauhl_RBPBench.md)