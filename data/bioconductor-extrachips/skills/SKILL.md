---
name: bioconductor-extrachips
description: This tool provides functions for differential binding and signal analysis of ChIP-seq data using sliding window or fixed-width approaches. Use when user asks to perform dual filtering of genomic windows, merge overlapping ranges using harmonic mean p-values, map peaks to genes via HiC or enhancers, and create specialized visualizations like HFGC plots or profile heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/extraChIPs.html
---

# bioconductor-extrachips

name: bioconductor-extrachips
description: Expert guidance for using the extraChIPs R package for differential binding and signal analysis of ChIP-seq data. Use this skill when performing sliding window or fixed-width window analyses, merging overlapping genomic ranges, mapping peaks to genes (incorporating HiC, promoters, and enhancers), and creating specialized visualizations like profile heatmaps, HFGC plots, and overlap diagrams.

# bioconductor-extrachips

## Overview

The `extraChIPs` package extends the capabilities of `csaw` and `edgeR` for ChIP-seq analysis. It is specifically designed for the GRAVI workflow but is broadly applicable to any genomic interval analysis. Its core strengths lie in:
1. **Dual Filtering**: Using consensus peaks to guide the filtering of sliding windows.
2. **Variable Width Merging**: Merging dependent windows into variable-width regions using harmonic mean p-values or representative signal.
3. **Complex Mapping**: Assigning peaks to genes using a hierarchical approach that considers HiC interactions, promoters, and enhancers.
4. **Advanced Visualization**: Streamlined plotting of coverage tracks (HFGC), profile heatmaps, and UpSet/Venn diagrams for range overlaps.

## Core Workflows

### 1. Sliding Window Analysis
This is the preferred method for histone marks (e.g., H3K27ac) where signal width varies.

```r
library(extraChIPs)
library(csaw)

# 1. Count reads in windows
rp <- readParam(pe = "none", dedup = TRUE, restrict = "chr10")
wincounts <- windowCounts(bam_files, spacing = 40, width = 120, ext = 200, param = rp)

# 2. Dual filtering using guide/consensus peaks
# Retains windows with signal above input and within likely peak regions
filtcounts <- dualFilter(x = wincounts, bg = "input_sample_name", ref = guide_peaks, q = 0.5)

# 3. Statistical testing (Quasi-Likelihood)
X <- model.matrix(~condition, data = colData(filtcounts))
fit_gr <- fitAssayDiff(filtcounts, design = X, fc = 1.2, asRanges = TRUE)

# 4. Merge windows using Harmonic Mean P-value (HMP)
results_gr <- mergeByHMP(fit_gr, merge_within = 120) %>% addDiffStatus()
```

### 2. Fixed-Width Peak Analysis
Commonly used for Transcription Factors (TFs) using MACS2 peak calls.

```r
# 1. Import and clean peaks
peaks <- importPeaks(peak_files, seqinfo = sq, blacklist = omit_ranges)

# 2. Create consensus peaks (e.g., present in 2/3 replicates)
consensus <- makeConsensus(peaks, p = 2/3)

# 3. Define fixed-width windows around peak centres
centred_peaks <- consensus %>% 
  mutate(centre = resize(granges(.), width = 1, fix = "center")) %>%
  mutate(window = resize(centre, width = 500, fix = "center")) %>%
  colToRanges("window")

# 4. Count and test
se <- regionCounts(bam_files, centred_peaks, ext = 200)
res <- fitAssayDiff(se, design = X, norm = "TMM", asRanges = TRUE)
```

### 3. Mapping Peaks to Genes
`mapByFeature` uses a priority-based assignment:
1. HiC Interactions (if provided)
2. Promoter overlaps
3. Enhancer proximity
4. Nearest Gene

```r
mapped_res <- mapByFeature(
  results_gr, 
  genes = gencode_genes, 
  prom = promoters_gr,
  enh = enhancers_gr, # Optional
  gi = hic_interactions # Optional (GInteractions)
)
```

## Visualization Tips

### Profile Heatmaps
Visualizes signal density around peak centers.
```r
# Get smoothed data
pd <- getProfileData(bw_files, regions_gr)
# Plot with facets by status (Increased/Decreased)
plotProfileHeatmap(pd, "profile_data", facetY = "status") +
  scale_fill_viridis_c()
```

### HFGC Plots (HiC, Features, Genes, Coverage)
A wrapper for `Gviz` to create publication-ready track plots.
```r
plotHFGC(
  region_gr, 
  hic = hic_data, 
  features = GRangesList(Promoters = prom_gr),
  genes = gene_models, 
  coverage = bw_file_list,
  zoom = 1.2
)
```

### Overlap Analysis
Quickly compare replicates or different peak callers.
```r
# Venn (1-3 sets) or UpSet (3+ sets)
plotOverlaps(peaks_grl, type = "upset", var = "score", f = "max")
```

## Key Functions Reference
- `dualFilter()`: Filters windows based on reference peaks and background (input) signal.
- `fitAssayDiff()`: Unified interface for `edgeR` QLF or `limma-trend` testing.
- `mergeByHMP()` / `mergeByCol()`: Combines sliding windows into merged regions.
- `makeConsensus()`: Generates consensus peak sets from replicates.
- `colToRanges()`: Swaps the active GRanges in a metadata-rich object.
- `plotAssayRle()` / `plotAssayPCA()`: Standard QC plots for SummarizedExperiment objects.

## Reference documentation
- [Differential Binding Analysis](./references/differential_binding.Rmd)
- [Differential Signal Using Fixed-Width Windows](./references/differential_signal_fixed.md)
- [Differential Signal Using Sliding Windows](./references/differential_signal_sliding.md)
- [Range-Based Functions and Mapping](./references/range_based_functions.Rmd)
- [Range-Based Functions Overview](./references/range_based_functions.md)