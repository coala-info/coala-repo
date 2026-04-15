---
name: bioconductor-rvs
description: This tool performs Rare Variant Sharing (RVS) analysis to test associations between rare genetic variants and phenotypes in family-based studies. Use when user asks to calculate sharing probabilities for relatives, perform gene-based joint analysis, or conduct partial sharing tests for complex pedigrees.
homepage: https://bioconductor.org/packages/release/bioc/html/RVS.html
---

# bioconductor-rvs

name: bioconductor-rvs
description: Rare Variant Sharing (RVS) analysis for family-based genetic studies. Use this skill to calculate the probability of relatives sharing rare variants under the null hypothesis of no linkage/association. It supports single-variant tests, multiple-family aggregation, gene-based joint analysis, and partial sharing tests for complex pedigrees.

## Overview
The `RVS` package provides statistical tools to test associations between rare genetic variants and dichotomous phenotypes (e.g., disease status) in multiplex families. It calculates exact sharing probabilities based on pedigree structures, which can be interpreted as p-values for rare variants.

## Core Workflows

### 1. Pedigree Setup and Visualization
RVS uses `pedigree` objects (often from the `kinship2` package).
```r
library(RVS)
library(kinship2)
data(samplePedigrees)

# Access a specific pedigree
ped <- samplePedigrees$secondCousinTriple
# Plot to verify structure
plot(ped)
```

### 2. Calculating Sharing Probabilities
The primary function is `RVsharing`. By default, it calculates the probability that all "final descendants" (those without children) share a variant, given at least one has it.

*   **Single Family:** `p <- RVsharing(ped)`
*   **Custom Carriers:** Use `carriers` to specify a subset of subjects and `useAffected=TRUE` to restrict the conditioning set to affected individuals.
    ```r
    p <- RVsharing(ped, carriers=c(15, 16), useAffected=TRUE)
    ```
*   **Multiple Families (Single Variant):**
    ```r
    fams <- list(fam1, fam2)
    probs <- RVsharing(fams)
    # Compute p-value for a specific sharing pattern (TRUE = shared, FALSE = not)
    pattern <- c(SF_A=TRUE, SF_B=FALSE)
    multipleFamilyPValue(probs, pattern)
    ```

### 3. Multi-Variant and Gene-Based Analysis
For analyzing multiple variants across a genomic region or gene:

*   **SnpMatrix Input:** Use `multipleVariantPValue` with `snpStats` objects.
    ```r
    # result contains pvalues and potential_pvalues (lower bounds)
    result <- multipleVariantPValue(genotypes, fam_data, sharingProbs)
    ```
*   **Gene-based Test:** Use `RVgene` for joint analysis of variants within a gene, which handles the lack of independence between variants in the same family.
    ```r
    RVgene(SnpMatrix.list, ped.obj.list, sites)
    ```

### 4. Advanced Adjustments
*   **Population MAF:** If the Minor Allele Frequency is known, provide it to improve accuracy: `RVsharing(ped, alleleFreq=0.01)`.
*   **Related Founders:** If founders are related, provide a kinship coefficient: `RVsharing(ped, kinshipCoeff=0.02)`.
*   **Monte Carlo Simulation:** For non-standard founder distributions or complex pedigrees: `RVsharing(ped, nSim=1e5, founderDist=myDistFunc)`.

### 5. Partial Sharing Test
When phenocopies or heterogeneity are suspected, use the partial sharing test to account for variants shared by only a subset of affected relatives.
1.  Precompute probabilities for all possible carrier subsets using `RVsharing(ped, splitPed=TRUE)`.
2.  Pass these lists to `RVgene` to calculate the partial sharing p-value.

## Tips for Success
*   **Potential P-values:** Use the `filter='bonferroni'` option in `multipleVariantPValue` to prune variants that cannot possibly reach significance, saving computation time.
*   **Data Formats:** RVS integrates with `snpStats` (SnpMatrix) and `VariantAnnotation` (VCF). Convert VCFs using `genotypeToSnpMatrix` before analysis.
*   **Memory Management:** For very large pedigrees, `RVsharing` uses a junction tree algorithm. If the pedigree is too complex, consider using the Monte Carlo (`nSim`) approach.

## Reference documentation
- [The RVS (Rare Variant Sharing) Package](./references/RVS.md)