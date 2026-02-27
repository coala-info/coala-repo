---
name: bioconductor-meal
description: MEAL is an R package designed to analyze Illumina HumanMethylation 450K and EPIC BeadChip data by integrating multiple statistical methods for differential methylation analysis. Use when user asks to identify differentially methylated positions or regions, perform redundancy analysis on genomic ranges, or visualize methylation data using Manhattan and volcano plots.
homepage: https://bioconductor.org/packages/release/bioc/html/MEAL.html
---


# bioconductor-meal

## Overview
MEAL (Methylation Analysis) is an R package designed to streamline the analysis of Illumina Infinium HumanMethylation 450K and EPIC BeadChip data. It provides a unified interface for multiple statistical methods, including limma for mean differences, DiffVar for variance differences, and various DMR detection algorithms (bumphunter, blockFinder, and DMRcate). It also supports integrative analysis with gene expression data and regional analysis via Redundancy Analysis (RDA).

## Core Workflow

### 1. Data Preparation
MEAL works primarily with `GenomicRatioSet` objects from the `minfi` package.

```r
library(MEAL)
library(minfi)

# Convert MethylationSet to GenomicRatioSet
meth <- mapToGenome(ratioConvert(MsetEx))

# Recommended preprocessing: remove SNPs and NAs
meth <- dropMethylationLoci(meth)
meth <- dropLociWithSnps(meth)
meth <- meth[!apply(getBeta(meth), 1, function(x) any(is.na(x))), ]
```

### 2. Running the Analysis Pipeline
The `runPipeline` function is a wrapper that executes multiple analyses (DMP and DMR detection) simultaneously.

```r
# Basic pipeline run
res <- runPipeline(set = meth, variable_names = "status")

# Adjusted model with covariates and specific analyses
resAdj <- runPipeline(set = meth, 
                      variable_names = "status",
                      covariable_names = "age", 
                      analyses = c("DiffMean", "DiffVar"),
                      sva = TRUE) # Run Surrogate Variable Analysis
```

### 3. Extracting Results
Results are stored in a `ResultSet` object. Use `getAssociation` or `getProbeResults` to extract data frames.

```r
# Get top results for a specific analysis
head(getAssociation(resAdj, rid = "DiffMean"))

# Get results with specific annotation columns
head(getProbeResults(resAdj, rid = "DiffMean", coef = 2, fNames = c("chromosome", "start")))

# Get results for CpGs mapped to a specific gene
getGeneVals(resAdj, gene = "ARMS2", genecol = "UCSC_RefGene_Name")
```

### 4. Visualization
MEAL extends the `plot` function for `ResultSet` objects and provides specialized plotting functions.

```r
# Standard plots: "manhattan", "volcano", or "qq"
plot(resAdj, rid = "DiffMean", type = "manhattan")
plot(resAdj, rid = "DiffMean", type = "volcano")

# Plot beta values for a specific CpG
plotFeature(set = meth, feat = "cg09383816", variables = "status")

# Regional plot showing DMRs and DMPs together
targetRange <- GRanges("chrX:13000000-14000000")
plotRegion(resAdj, targetRange)
```

### 5. Redundancy Analysis (RDA)
RDA is used to test if a specific genomic region is differentially methylated as a whole.

```r
targetRange <- GRanges("chrX:13000000-23000000")
resRDA <- runRDA(set = meth, model = ~ status, range = targetRange)

# Get R2 and p-values
getRDAresults(resRDA)

# Visualize RDA biplot
plotRDA(resRDA, pheno = colData(meth)[, "status", drop = FALSE])
```

### 6. Integration with Gene Expression
MEAL can correlate methylation levels with gene expression using `MultiDataSet`.

```r
# Create MultiDataSet
multi <- createMultiDataSet()
multi <- add_genexp(multi, expression_set)
multi <- add_methy(multi, genomic_ratio_set)

# Calculate correlation between CpGs and nearby expression probes (within 250kb)
methExprs <- correlationMethExprs(multi)
```

## Tips and Best Practices
- **SVA**: If your QQ-plots show inflation (lambda != 1), set `sva = TRUE` in `runPipeline` to account for hidden batch effects.
- **M-values vs Betas**: Use `betas = FALSE` in analysis functions to use M-values, which often have better statistical properties for linear modeling, while using Betas for visualization.
- **Memory**: For large datasets, subset your `GenomicRatioSet` to the probes of interest before running complex DMR or RDA analyses to save time and memory.

## Reference documentation
- [Methylation Analysis with MEAL](./references/MEAL.md)
- [Expression and Methylation Analysis Case Example](./references/caseExample.md)