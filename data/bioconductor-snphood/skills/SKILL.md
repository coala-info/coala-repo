---
name: bioconductor-snphood
description: SNPhood analyzes and visualizes the molecular phenotype shape and binding patterns in the genomic neighborhood of SNPs or other regions of interest. Use when user asks to investigate allele-specific binding, bin read counts around genomic regions, integrate genotype data with molecular phenotypes, or cluster regions based on their binding profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/SNPhood.html
---

# bioconductor-snphood

## Overview
SNPhood is a Bioconductor package designed to analyze the molecular phenotype (e.g., chromatin marks, TF binding) in the immediate vicinity of genomic regions, typically SNPs. Unlike peak callers that reduce signal to a single value, SNPhood preserves the "shape" of the binding by binning the neighborhood around each ROI. It supports allele-specific analysis (using maternal/paternal read groups), normalization via input DNA or library size, and integration with VCF-based genotype data.

## Core Workflow

### 1. Setup and Parameter Configuration
Every analysis starts with a parameter list. Use `getDefaultParameterList` to initialize settings.

```r
library(SNPhood)
# Define path to BED file (ROI)
roi_file <- "path/to/snps.bed"
# Create default parameters
par.l <- getDefaultParameterList(path_userRegions = roi_file, isPairedEndData = TRUE)

# Common adjustments
par.l$regionSize <- 500      # Extension on each side (Total window = 2*size + 1)
par.l$binSize <- 25         # Resolution of the analysis
par.l$readGroupSpecific <- TRUE # Set TRUE for allele-specific analysis
par.l$poolDatasets <- TRUE  # Combine replicates for more power
```

### 2. Data Collection
Organize your BAM files into a structured data frame. The `collectFiles` function helps automate this.

```r
# Pattern for BAM files
files.df <- collectFiles(patternFiles = "*.bam")

# Manually assign metadata for pooling/genotypes
files.df$individual <- c("Ind1", "Ind1", "Ind2", "Ind2")
```

### 3. Quality Control
Before full processing, check the correlation of raw read counts across your regions to identify outlier datasets.

```r
# Run preliminary correlation check
snphood.qc <- analyzeSNPhood(par.l, files.df, onlyPrepareForDatasetCorrelation = TRUE)
snphood.qc <- plotAndCalculateCorrelationDatasets(snphood.qc)
```

### 4. Main Analysis
Execute the full pipeline to extract reads, bin them, and normalize.

```r
snphood.o <- analyzeSNPhood(par.l, files.df)
```

### 5. Allele-Specific Binding (ASB) Tests
If your BAM files contain read groups (e.g., maternal/paternal), test for significant differences in binding.

```r
snphood.o <- testForAllelicBiases(snphood.o, 
                                 readGroups = c("paternal", "maternal"),
                                 calcBackgroundDistr = TRUE, 
                                 nRepetitions = 100)

# View FDR results
fdr_res <- results(snphood.o, type = "allelicBias", elements = "FDR_results")
```

### 6. Genotype Integration
Associate VCF data with your SNPhood object to investigate genotype-dependent binding patterns.

```r
genotype_map <- data.frame(samples = annotationDatasets(snphood.o),
                           genotypeFile = "path/to/genotypes.vcf.gz",
                           sampleName = c("NA12878", "NA12891"))
snphood.o <- associateGenotypes(snphood.o, genotype_map)
```

### 7. Clustering and Visualization
Cluster regions based on their binding profiles to identify common shapes.

```r
# Cluster based on paternal allele signal
snphood.o <- plotAndClusterMatrix(snphood.o, readGroup = "paternal", nClustersVec = 3)

# Visualize specific bins
plotBinCounts(snphood.o, regions = 1, plotGenotypeRatio = TRUE)

# Overview of allelic bias across a chromosome
plotAllelicBiasResultsOverview(snphood.o, plotChr = "chr21", signThreshold = 0.01)
```

## Key Functions and Objects
- **SNPhood Object**: The central S4 class. Access data using `counts()`, `enrichment()`, `annotationRegions()`, and `parameters()`.
- **Normalization**: Controlled by `normByInput` (requires input DNA BAMs) or `normAmongEachOther` (DESeq2-style library size normalization).
- **Effective Genome Size**: SNPhood automatically estimates mappability based on read length and assembly (hg19, hg38, mm10, etc.).

## Tips for Large Datasets
- **Parallelization**: Increase `par.l$nCores` for faster read extraction.
- **Memory**: Set `keepAllReadCounts = FALSE` when pooling replicates to save RAM.
- **Subsetting**: Use `linesToParse` in the parameter list to run pilot analyses on a subset of SNPs.

## Reference documentation
- [Introduction and Methodological Details](./references/IntroductionToSNPhood.md)
- [Example Workflow](./references/workflow.md)