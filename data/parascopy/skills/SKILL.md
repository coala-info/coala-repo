---
name: parascopy
description: Parascopy is a bioinformatics suite designed to analyze duplicated genomic regions by distinguishing between paralogous sequences. Use when user asks to build homology tables, estimate aggregate or paralog-specific copy numbers, and call variants in complex duplicated regions.
homepage: https://github.com/tprodanov/parascopy
---

# parascopy

## Overview

Parascopy is a specialized bioinformatics suite designed to resolve the complexities of duplicated genomic regions. While standard tools often struggle with "dead zones" caused by paralogous sequences, Parascopy uses a multi-locus approach to distinguish between different copies of a gene. It provides workflows for building homology tables, calculating background depth, estimating copy numbers (both aggregate and paralog-specific), and calling variants in these challenging regions.

## Core Workflow

### 1. Homology Table Construction
Before analysis, you must define the duplications in the reference genome.
```bash
# Step A: Identify duplications
parascopy pretable -f genome.fa -o pretable.bed.gz

# Step B: Construct the formal homology table
parascopy table -i pretable.bed.gz -f genome.fa -o table.bed.gz
```
*Note: The reference genome must be indexed with `samtools faidx` and `bwa index`.*

### 2. Copy Number Estimation
This is a two-step process involving depth normalization followed by CN estimation.

**Calculate Background Depth:**
```bash
parascopy depth -I input.list -g hg38 -f genome.fa -o depth_dir
```

**Estimate agCN and psCN:**
```bash
parascopy cn -I input.list -t table.bed.gz -f genome.fa -R regions.bed -d depth_dir -o output_dir
```

### 3. Variant Calling
Variant calling is performed as an extension of a completed copy number analysis.
```bash
parascopy call -p output_dir -f genome.fa -t table.bed.gz
```

## Expert Tips and Best Practices

### Input Handling
- **Sample Naming**: You can override sample names in the input list using the format `path/to/file.bam::SampleName`.
- **File Formats**: Both BAM and CRAM are supported, but they must be sorted and indexed.

### Handling Sex Chromosomes
By default, Parascopy treats X and Y as regular autosomes. For accurate results in males (1 copy of X/Y) or females (2 copies of X, 0 of Y), use the `--modify-ref` flag with a BED file:
```text
# Example modify-ref.bed
chrX    0    inf    MaleSample1,MaleSample2    1
chrY    0    inf    MaleSample1,MaleSample2    1
chrY    0    inf    FemaleSample1              0
```

### Reusing Model Parameters
If analyzing new samples using the same sequencing protocol, you can speed up the process by using parameters from a previous run:
```bash
parascopy cn-using previous_analysis/model -I new_samples.list -t table.bed.gz -f genome.fa -d new_depth -o new_analysis
```

### Interpreting Output
- **res.samples.bed.gz**: The primary output for copy number. Look at `agCN` for total copies and `psCN` for the breakdown per paralog.
- **variants.vcf.gz**: Contains paralog-specific genotypes. The `pos2` INFO field is critical as it lists all homologous positions for that variant.
- **overlPSV**: In the VCF, this field indicates if a variant overlaps a Paralogous Sequence Variant (PSV), which can affect calling confidence.



## Subcommands

| Command | Description |
|---------|-------------|
| parascopy | A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call. |
| parascopy | A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call. |
| parascopy | A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, and call. |
| parascopy | A tool for analyzing paralogous genes and their copy number variations. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, and call. |
| parascopy | A tool for analyzing paralogous sequence copies. Valid commands include help, version, cite, pretable, table, depth, cn, cn-using, pool, view, msa, psvs, examine, call. |
| parascopy call | Call variants in duplicated regions. |
| parascopy cn | Find aggregate and paralog-specific copy number for given unique and duplicated regions. |
| parascopy cn-using | Find aggregate and paralog-specific copy number for given unique and duplicated regions. |
| parascopy depth | Calculate read depth and variance in given genomic windows. |
| parascopy examine | Split input regions by reference copy number. |
| parascopy msa | Visualize multiple sequence alignment of homologous regions. |
| parascopy pool | Pool reads from various copies of a duplication. |
| parascopy pretable | Create homology pre-table. This command aligns genomic regions back to the genome to find homologous regions. |
| parascopy psvs | Output PSVs (paralogous-sequence variants) between homologous regions. |
| parascopy table | Convert homology pre-table into homology table. This command combines overlapping homologous regions into longer duplications. |
| parascopy view | View and filter homology table. |

## Reference documentation
- [Main README](./references/github_com_tprodanov_parascopy_blob_main_README.md)
- [Copy Number Output Details](./references/github_com_tprodanov_parascopy_blob_main_docs_cn_output.md)
- [Variant Calling Output Details](./references/github_com_tprodanov_parascopy_blob_main_docs_call_output.md)