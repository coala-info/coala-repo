---
name: piawka
description: `piawka` is a high-performance AWK-based tool for calculating within- and between-population nucleotide diversity statistics.
homepage: https://github.com/novikovalab/piawka
---

# piawka

## Overview

`piawka` is a high-performance AWK-based tool for calculating within- and between-population nucleotide diversity statistics. Unlike many traditional tools, it natively supports polyploid data and provides sensible handling of missing genotypes. It is highly portable, requiring only `gawk` and `tabix`, and is optimized for speed through built-in parallelization.

## Core Usage

The basic execution requires a gzipped, tabixed VCF file and a group definition.

```bash
piawka -g groups.tsv -v input.vcf.gz [OPTIONS]
```

### Group Definitions (`-g`)
The groups file should be a two-column TSV (Sample ID and Group Name). Alternatively, use these keywords:
- `unite`: Treats all samples in the VCF as a single population.
- `divide`: Treats every individual sample as its own separate group.

### Essential Statistics Flags
- **Fst**: Use `-f` for Hudson's Fst or `-F` for Weir and Cockerham's Fst.
- **Tajima's D**: Use `-t` for a version that manages missing data (recommended) or `-T` for the classic calculation.
- **Heterozygosity**: Use `-H` to output only per-sample π (heterozygosity).
- **Dxy**: Calculated by default; use `-D` to disable it if only π is needed.
- **Watterson's Theta**: Use `-w` to include Watterson's θ.

## Advanced CLI Patterns

### Working with Genomic Regions
For targeted analysis, `piawka` supports BED files:
- **Standard BED**: `-b regions.bed` for specific genomic intervals.
- **Targeted BED**: `-B targets.bed` is optimized for speed when processing a very large number of small, disjointed regions.

### Handling Missing Data and Alleles
- **Missing Data Threshold**: Use `-M <0.0-1.0>` to set the maximum allowable share of missing genotypes per group at a site.
- **Multiallelic Sites**: By default, `piawka` focuses on biallelic patterns. Use `-m` to include multiallelic sites in the calculations.

### Performance Optimization
- **Parallelization**: Use `-j <N>` to specify the number of parallel jobs. This significantly speeds up processing on multi-core systems.
- **Quiet Mode**: Use `-q` to suppress progress and warning messages during large-scale batch processing.

## Expert Tips

1. **Dependency Check**: Ensure `gawk` version is 5.0.0 or higher. Standard `awk` or older versions of `gawk` may cause unexpected behavior.
2. **Input Preparation**: Always ensure your VCF is compressed with `bgzip` and indexed with `tabix`. `piawka` relies on `tabix` for efficient data access.
3. **Per-Site Analysis**: Use the `-1` or `--persite` flag to output values for every individual site. This is useful for identifying specific high-diversity SNPs before performing window-based summaries.
4. **Inter-ploidy Comparisons**: When comparing populations with different ploidy levels, use `-r` to output Ronfort's rho, which is specifically designed to be robust for inter-ploidy divergence comparisons.

## Reference documentation
- [piawka Overview](./references/anaconda_org_channels_bioconda_packages_piawka_overview.md)
- [piawka GitHub Repository](./references/github_com_novikovalab_piawka.md)
- [piawka Wiki](./references/github_com_novikovalab_piawka_wiki.md)