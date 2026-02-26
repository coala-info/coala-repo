---
name: bioconductor-dmrcate
description: DMRcate identifies differentially methylated regions from Illumina BeadChip or bisulfite sequencing data using a kernel-smoothing approach. Use when user asks to identify differentially methylated regions, annotate CpG sites with statistics, or visualize genomic methylation patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/DMRcate.html
---


# bioconductor-dmrcate

## Overview
DMRcate (DNA Methylation Regional Analysis Tool for Enumeration) is a Bioconductor package designed to identify differentially methylated regions using a kernel-smoothing approach. It is platform-agnostic, supporting Illumina BeadChips (450K, EPICv1, EPICv2) and bisulfite sequencing (WGBS, RRBS). The core workflow involves annotating individual CpG sites with statistics (typically from limma or edgeR), smoothing these statistics across the genome, and grouping significant sites into regions based on proximity.

## Core Workflow for Arrays (450K, EPICv1, EPICv2)

### 1. Data Preparation and Filtering
Before calling DMRs, filter probes confounded by SNPs or cross-reactivity.
```R
library(DMRcate)
# For EPICv1/450K: dist=2, mafcut=0.05 are standard
clean_ms <- rmSNPandCH(my_m_values, dist=2, mafcut=0.05)

# For EPICv2: Use rmcrosshyb=FALSE if you intend to remap probes later
clean_ms <- rmSNPandCH(my_m_values, rmcrosshyb = FALSE)
```

### 2. CpG Annotation
Annotate the matrix with differential methylation statistics. This step uses `limma` internally.
```R
# design: model matrix; coef: column index of the contrast
myannotation <- cpg.annotate("array", object = clean_ms, 
                             arraytype = "EPICv1", 
                             analysis.type = "differential", 
                             design = design, coef = 2)

# For EPICv2: Use epicv2Filter ("mean", "sensitivity", or "precision") 
# to handle replicate probes mapping to the same CpG.
myannotation <- cpg.annotate("array", object = clean_ms, 
                             arraytype = "EPICv2", 
                             epicv2Filter = "mean",
                             epicv2Remap = TRUE,
                             design = design, coef = 2)
```

### 3. DMR Calling
Find regions where smoothed FDR-corrected p-values meet the threshold.
```R
# lambda: distance between probes to be aggregated (default 1000)
# C: scaling factor for kernel (default 2)
dmrcoutput <- dmrcate(myannotation, lambda=1000, C=2)
```

### 4. Results and Visualization
Extract results into a `GRanges` object and plot top regions.
```R
# Extract ranges (specify genome: "hg19", "hg38", or "mm10")
results.ranges <- extractRanges(dmrcoutput, genome = "hg38")

# Plot the top DMR (dmr=1)
DMR.plot(ranges = results.ranges, dmr = 1, CpGs = myannotation, 
         what = "Beta", arraytype = "EPICv2", phen.col = cols, genome = "hg38")
```

## Workflow for Bisulfite Sequencing

Sequencing data requires handling methylated and unmethylated counts. Use `edgeR::modelMatrixMeth()` to expand your design matrix.

```R
# 1. Prepare design
methdesign <- edgeR::modelMatrixMeth(standard_design)

# 2. Annotate using sequencing.annotate
# all.cov=TRUE filters for CpGs with coverage in all samples
seq_annot <- sequencing.annotate(bsseq_obj, methdesign, all.cov = TRUE, 
                                 contrasts = TRUE, cont.matrix = cont.mat, 
                                 coef = "my_contrast", fdr = 0.05)

# 3. Call DMRs
dmrcate.res <- dmrcate(seq_annot, C=2, min.cpgs = 5)
```

## Key Parameters and Tips
- **lambda**: The gap (in nucleotides) allowed between probes before a region is split. Smaller lambda results in shorter, more numerous DMRs.
- **C**: The smoothing parameter. Increasing C makes the kernel wider (more smoothing).
- **M-values vs Beta-values**: Always use M-values for the statistical modeling (`cpg.annotate`) as they approximate normality. Use Beta-values for visualization (`DMR.plot`).
- **FDR Thresholds**: If `cpg.annotate` returns 0 significant probes, you can relax the threshold using `changeFDR(myannotation, new_fdr)`.

## Reference documentation
- [Calling DMRs from EPICv1 and 450K data](./references/EPICv1_and_450K.md)
- [DMRcate for EPICv2](./references/EPICv2.md)
- [DMRcate for bisulfite sequencing](./references/sequencing.md)