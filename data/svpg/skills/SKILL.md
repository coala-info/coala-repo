---
name: svpg
description: SVPG is a computational framework that identifies structural variations by leveraging the topological and path transition features of pangenome graphs. Use when user asks to call germline structural variants, perform graph-based de novo variant discovery, or identify somatic variants using tumor-normal paired analysis.
homepage: https://github.com/coopsor/SVPG
---

# svpg

## Overview

SVPG (Structural Variant detection based on Pangenome Graph) is a computational framework designed to identify structural variations by leveraging the topological and path transition features of pangenome graphs. It excels at high-precision germline calling and provides a reference-bias-free approach for discovering low-frequency or somatic variants. The tool supports two primary workflows: a pangenome-guided mode for standard alignments and a graph-based mode for direct reads-to-graph alignments.

## Installation and Requirements

SVPG requires Python 3.10+ and several external dependencies. Ensure the following are in your system PATH:
- **Core Tools**: `minigraph` (>= 0.21), `mappy` (>= 2.28)
- **Processing Tools**: `bcftools` (>= 1.20), `truvari` (>= 3.1.0)

Install via pip or conda:
```bash
pip install svpg
# or
conda install -c bioconda svpg
```

## Common CLI Patterns

### 1. Pangenome-Guided SV Detection
Use this mode when you have reads already mapped to a linear reference genome (BAM format).

```bash
svpg call --working_dir output_dir/ \
          --bam sample.bam \
          --ref reference.fa \
          --gfa pangenome.gfa \
          --read [ont|hifi] \
          -t 16
```

### 2. Graph-Based SV Detection
Use this mode for de novo SV discovery. This requires a GAF file (Read-to-Graph alignment).

**Step A: Generate GAF with minigraph**
```bash
minigraph -cx lr --vc -t 64 pangenome.gfa sample.fasta > sample.gaf
```
*Note: Always use the `--vc` option in minigraph to ensure compatibility with SVPG.*

**Step B: Call SVs with SVPG**
```bash
svpg graph-call --working_dir output_dir/ \
                --ref reference.fa \
                --gfa pangenome.gfa \
                --gaf sample.gaf \
                --read [ont|hifi] \
                -s 3
```

### 3. Tumor/Normal Paired Analysis
To identify somatic (tumor-specific) variants, run the samples separately and use the integration script.

```bash
# 1. Call Tumor
svpg graph-call --working_dir tumor_out/ --ref ref.fa --gfa pan.gfa --gaf tumor.gaf --read hifi -s 3

# 2. Call Normal (use lower support to ensure high-confidence filtering)
svpg graph-call --working_dir normal_out/ --ref ref.fa --gfa pan.gfa --gaf normal.gaf --read hifi -s 1

# 3. Extract specific variants
python scripts/vcf_specific.py tumor_out/variants.vcf normal_out/variants.vcf tumor_specific.vcf
```

## Expert Tips and Best Practices

### Optimizing Read Support (`-s` / `--min_support`)
The default support is 2 reads. Adjust this based on your sequencing depth to balance precision and recall:

| Depth | ONT Support | HiFi Support |
|-------|-------------|--------------|
| <10x  | 2           | 1            |
| 10-20x| 3           | 2            |
| 20-50x| 4           | 3            |
| >50x  | 10          | 4            |

### Performance Tuning
- **Threads**: SVPG uses 16 threads by default. Use `-t` to scale based on your hardware.
- **High Confidence Sets**: In pangenome-guided mode, filter the output VCF for `FILTER=PASS` to obtain the most reliable germline variants.
- **Graph Compatibility**: SVPG is optimized for HPRC (Human Pangenome Reference Consortium) graphs (v3.1 and v4.1).



## Subcommands

| Command | Description |
|---------|-------------|
| svpg_augment | Augment a pangenome graph with SV calls from sequencing reads. |
| svpg_call | Call structural variants using SVPG |
| svpg_graph-call | Call structural variants (SVs) on a pangenome graph. |

## Reference documentation
- [SVPG GitHub README](./references/github_com_coopsor_SVPG_blob_master_README.md)
- [SVPG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_svpg_overview.md)