---
name: bioconductor-cpvsnp
description: This tool performs gene set analysis for GWAS data by aggregating individual SNP p-values into pathway-level statistics. Use when user asks to perform gene set enrichment analysis on GWAS results, calculate gene set statistics using GLOSSI or VEGAS, or map SNPs to gene sets for association testing.
homepage: https://bioconductor.org/packages/release/bioc/html/cpvSNP.html
---


# bioconductor-cpvsnp

name: bioconductor-cpvsnp
description: Gene set analysis for GWAS data using SNP p-values. Use this skill to combine individual SNP association p-values into gene-set level statistics using GLOSSI (for independent SNPs) or VEGAS (accounting for LD correlation).

## Overview
The `cpvSNP` package provides methods to test the association of gene sets (pathways) with a phenotype by aggregating SNP-level p-values. It implements two primary algorithms:
1. **GLOSSI**: Best for independent SNPs (e.g., after LD pruning). It uses a Chi-squared distribution based on Fisher's transformation.
2. **VEGAS**: Best for correlated SNPs. It uses a simulation-based approach that incorporates a correlation (Linkage Disequilibrium) matrix to account for the dependency structure between SNPs.

## Typical Workflow

### 1. Data Preparation
Convert GWAS results into a `GRanges` object and map gene sets to specific SNPs.

```R
library(cpvSNP)
library(GSEABase)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Create GRanges from a data frame of GWAS results
# Required columns: p-value, SNP ID, Chromosome, Position
arrayDataGR <- createArrayData(my_gwas_df, positionName="Position")

# Map GeneSetCollection (Entrez IDs) to SNP IDs using a transcript database
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
genesHg19 <- genes(txdb)
snpsGSC <- geneToSNPList(myGeneSetCollection, arrayDataGR, genesHg19)
```

### 2. Running GLOSSI (Independent SNPs)
Use this method if you have performed LD pruning (e.g., via PLINK).

```R
# Subset to independent SNPs only
pvals <- arrayDataGR$P[is.element(arrayDataGR$SNP, indep_snp_vector)]
names(pvals) <- arrayDataGR$SNP[is.element(arrayDataGR$SNP, indep_snp_vector)]

# Run GLOSSI
gRes <- glossi(pvals, snpsGSC)

# Extract results
pValue(gRes)
statistic(gRes)
degreesOfFreedom(gRes)
```

### 3. Running VEGAS (Correlated SNPs)
Use this method when SNPs are in Linkage Disequilibrium. Requires a square, symmetric correlation matrix.

```R
# ldMat should be a correlation matrix (R-squared) for the SNPs
vRes <- vegas(snpsGSC, arrayDataGR, ldMat)

# Extract results
pValue(vRes)
statistic(vRes)
simulatedStats(vRes) # View the null distribution statistics
```

### 4. Visualization
`cpvSNP` provides two main plotting functions:

```R
# Plot gene set p-values vs. number of SNPs in the set
plotPvals(gRes, main="GLOSSI Results")

# Compare distribution of p-values in a specific set vs. all GWAS p-values
# Useful for identifying sets with a significant shift in association
assocPvalBySetPlot(all_gwas_pvals, snpsGSC[[1]])
```

## Tips and Best Practices
- **Genome Builds**: Ensure the `TxDb` object used in `geneToSNPList` matches the genome build (e.g., hg19 vs hg38) of your GWAS SNP positions.
- **LD Matrix**: For VEGAS, the `ldMat` must contain all SNPs present in the gene sets being tested. Missing SNPs in the correlation matrix will cause errors.
- **Quiet Mode**: `geneToSNPList` has a `quiet=TRUE` default. Set to `FALSE` if you suspect mapping issues or missing overlaps.
- **Multiple Testing**: Always apply `p.adjust()` to the resulting gene-set p-values before interpreting biological significance.

## Reference documentation
- [Combining SNP P-Values in Gene Sets: the cpvSNP Package](./references/cpvSNP.md)