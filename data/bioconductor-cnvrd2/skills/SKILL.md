---
name: bioconductor-cnvrd2
description: This tool measures gene copy number and identifies tag variants for copy-number variations using next-generation sequencing data. Use when user asks to measure copy number, assign copy-number genotypes, identify tag SNPs or INDELs for CNVs, and detect polymorphic genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/CNVrd2.html
---

# bioconductor-cnvrd2

name: bioconductor-cnvrd2
description: Measure gene copy number (CN), identify tag SNPs/INDELs for CNVs, and detect polymorphic genomic regions using NGS data (BAM/VCF). Use when analyzing read-depth variation in whole-genome sequencing data to assign discrete copy-number genotypes and calculate linkage disequilibrium with nearby variants.

## Overview

CNVrd2 is a Bioconductor package designed to measure copy number (CN) at specific loci using next-generation sequencing (NGS) data. It utilizes read-depth information from BAM files to segment genomic regions and assign samples to copy-number groups using mixture models or Bayesian clustering. It also integrates VCF data to identify SNPs or INDELs that act as surrogate markers (tag SNPs) for specific copy-number variants.

## Core Workflow

### 1. Object Initialization
Define the genomic region of interest and the directory containing BAM files.
```r
library(CNVrd2)
objectCNVrd2 <- new("CNVrd2", 
                    windows = 1000, 
                    chr = "chr1",
                    st = 161100001, 
                    en = 162100000,
                    dirBamFile = "path/to/bams",
                    genes = c(161592986, 161601753),
                    geneNames = "TargetGene")
```

### 2. Read Counting and Segmentation
Count reads in windows and perform segmentation to obtain segmentation scores (SS).
```r
# Count reads with optional GC correction
readCountMatrix <- countReadInWindow(Object = objectCNVrd2, correctGC = TRUE)

# Perform segmentation
resultSegment <- segmentSamples(Object = objectCNVrd2, stdCntMatrix = readCountMatrix)
sS <- resultSegment$segmentationScores
```

### 3. Copy-Number Genotyping
Cluster segmentation scores into discrete groups. Use `groupCNVs` for standard mixture modeling or `groupBayesianCNVs` for complex/multiallelic loci.
```r
# Standard clustering (e.g., 4 groups)
objectCluster <- new("clusteringCNVs", x = sS[, 1], k = 4, EV = TRUE)
cnGroups <- groupCNVs(Object = objectCluster)

# Access assignments
assignments <- cnGroups$allGroups
```

### 4. Identifying Tag SNPs
Calculate linkage disequilibrium (LD) between assigned CNVs and nearby variants from a VCF file.
```r
# sampleCNV must have columns: SampleName, CN, Population
tagResults <- calculateLDSNPandCNV(sampleCNV = sampleData,
                                   vcfFile = "variants.vcf.gz",
                                   cnvColumn = 2,
                                   population = "MXL",
                                   popColumn = 3,
                                   chr = "1",
                                   st = 161600001, 
                                   en = 161611000)
```

### 5. Detecting Polymorphic Regions
Identify regions with high variability across the population.
```r
polyRegion <- identifyPolymorphicRegion(Object = objectCNVrd2, 
                                        segmentObject = resultSegment)

# Plot the results
plotPolymorphicRegion(Object = objectCNVrd2, 
                      polymorphicRegionObject = polyRegion,
                      typePlot = "SD")
```

## Advanced Usage Tips

- **Complex Loci:** For genes with high copy numbers (e.g., CCL3L1), use a population with clear clusters (like Europeans) to generate prior information (means/SDs) for `groupBayesianCNVs`.
- **Outlier Handling:** Use `rightLimit` or `leftLimit` in `groupCNVs` to force extreme segmentation scores into the highest or lowest genotype groups.
- **VCF Processing:** For large VCF files, use the `nChunkForVcf` parameter in `calculateLDSNPandCNV` to process the file in blocks and save memory.
- **Visualization:** Use `plotCNVrd2` to generate trace plots of standardized read counts for specific samples to visually verify duplications or deletions.

## Reference documentation

- [CNVrd2: Measuring gene copy number and identifying tag SNPs](./references/CNVrd2.md)