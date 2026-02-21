---
name: viewbs
description: ViewBS is a powerful toolkit designed for the graphical representation of DNA methylation data.
homepage: https://github.com/xie186/ViewBS
---

# viewbs

## Overview
ViewBS is a powerful toolkit designed for the graphical representation of DNA methylation data. It transforms genome-wide cytosine methylation reports into interpretable visualizations, ranging from broad genomic trends to high-resolution views of specific loci. It is particularly useful for researchers needing to compare methylation profiles across different samples or experimental conditions (e.g., Wild Type vs. Mutant) within specific sequence contexts (CG, CHG, CHH).

## Input Requirements
ViewBS requires specific input formats to function correctly:
- **Cytosine Report**: A genome-wide report (standard Bismark format) containing: `<chromosome> <position> <strand> <count methylated> <count unmethylated> <C-context> <trinucleotide context>`.
- **Tabix Indexing**: Input files must be compressed with `bgzip` and indexed with `tabix` for rapid data retrieval.
  ```bash
  bgzip input.cytosine_report
  tabix -p vcf input.cytosine_report.gz
  ```
- **Regions of Interest**: For region-based commands, provide genomic coordinates in BED format or specific strings (e.g., `chr:start-end`).

## Common CLI Patterns

### Visualizing a Single Locus
Use `MethOneRegion` to inspect methylation levels at a specific genomic coordinate across multiple samples.
```bash
ViewBS MethOneRegion \
  --region chr5:19497000-19499600 \
  --sample sample1.tab.gz,WT \
  --sample sample2.tab.gz,mutant \
  --context CG \
  --outdir ./output \
  --prefix my_region
```

### Analyzing Functional Regions
Use `MethOverRegion` to plot the average methylation profile over a set of features (e.g., all genes or TEs).
```bash
ViewBS MethOverRegion \
  --region genes.bed \
  --sample sample1.tab.gz,WT \
  --context CG \
  --outdir ./output
```

### Global Methylation Reports
Generate summary statistics and distributions to assess the overall quality and methylation state of the library.
- **Global Levels**: `ViewBS GlobalMethLev --sample sample1.tab.gz,WT`
- **Distribution**: `ViewBS MethLevDist --sample sample1.tab.gz,WT`
- **Coverage**: `ViewBS MethCoverage --sample sample1.tab.gz,WT`

## Expert Tips
- **Sample Labeling**: Always use the `--sample file,label` format. The label provided after the comma is what will appear in the plot legends.
- **Context Filtering**: DNA methylation in plants occurs in CG, CHG, and CHH contexts. Use the `--context` flag to isolate the specific biological signal you are investigating.
- **Non-Bismark Data**: If using tools like `bwa-meth`, use `MethylDackel` with the `--cytosine_report` flag to generate compatible input files for ViewBS.
- **Merging Figures**: ViewBS outputs individual plots. To combine multiple analyses into a single publication-quality figure, use the internal R scripts provided in the `lib/` directory of the ViewBS installation.

## Reference documentation
- [ViewBS Main Documentation](./references/github_com_xie186_ViewBS.md)
- [ViewBS Wiki and Usage Guides](./references/github_com_xie186_ViewBS_wiki.md)