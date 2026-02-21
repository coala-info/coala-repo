---
name: bioconductor-goprofiles
description: The package implements methods to compare lists of genes based on comparing the corresponding 'functional profiles'.
homepage: https://bioconductor.org/packages/release/bioc/html/goProfiles.html
---

# bioconductor-goprofiles

name: bioconductor-goprofiles
description: Statistical analysis and comparison of gene lists using Gene Ontology (GO) functional profiles. Use this skill when you need to project gene lists onto specific GO levels, compare functional profiles between different experiments (e.g., using squared Euclidean distance or Fisher's exact test), and perform equivalence testing to determine if two gene sets are functionally similar.

## Overview

The `goProfiles` package provides a statistical framework for comparing lists of genes by projecting them onto a fixed level of the Gene Ontology (GO) hierarchy. Instead of looking at individual gene enrichment, it creates a "functional profile" (a frequency vector of genes per GO category at a specific level). This allows for quantitative comparison of datasets, visual exploration of functional distributions, and statistical testing for both difference and equivalence.

## Core Workflow

### 1. Data Preparation
The package typically requires Entrez Gene IDs and an appropriate organism annotation package (e.g., `org.Hs.eg.db`).

```r
library(goProfiles)
library(org.Hs.eg.db)
data(prostateIds) # Example data containing Entrez IDs
```

### 2. Creating Functional Profiles
Use `basicProfile` to create a profile for a single list. You must specify the ontology ("MF", "BP", or "CC") and the GO level (usually level 2 or 3).

```r
# Create a profile for Molecular Function at level 2
welsh.MF <- basicProfile(welsh01EntrezIDs[1:100], 
                         onto="MF", 
                         level=2, 
                         orgPackage="org.Hs.eg.db")

# Use onto="ANY" to compute profiles for all three ontologies
welsh.all <- basicProfile(welsh01EntrezIDs[1:100], onto="ANY", level=2, orgPackage="org.Hs.eg.db")
```

### 3. Comparing and Visualizing Profiles
To compare two lists visually, merge their profiles and plot them.

```r
# Merge two profiles
singh.MF <- basicProfile(singh01EntrezIDs[1:100], onto="MF", level=2, orgPackage="org.Hs.eg.db")
merged <- mergeProfilesLists(welsh.MF, singh.MF, profNames=c("Welsh", "Singh"))

# Print and Plot
printProfiles(merged, percentage=TRUE)
plotProfiles(merged, percentage=TRUE, aTitle="Comparison of Welsh vs Singh", legend=TRUE)
```

### 4. Statistical Comparison
To determine if two gene lists are statistically different or equivalent:

**Test for Difference:**
`compareGeneLists` calculates the squared Euclidean distance and provides a p-value.

```r
comp <- compareGeneLists(list1, list2, onto="MF", level=2, orgPackage="org.Hs.eg.db")
print(compSummary(comp))
```

**Fisher's Exact Test per Category:**
Check which specific GO categories contribute to the differences.

```r
# Requires the profiles and the profile of the intersection of the two lists
commonGenes <- intersect(list1, list2)
commProf <- basicProfile(commonGenes, onto="MF", level=2, orgPackage="org.Hs.eg.db")$MF
fisherGOProfiles(welsh.MF$MF, singh.MF$MF, commProf, method="holm")
```

**Equivalence Testing:**
Used to confirm if two lists are functionally similar (e.g., when combining datasets).

```r
# Requires 'expanded' profiles
exp1 <- expandedProfile(list1, onto="MF", level=2, orgPackage="org.Hs.eg.db")
exp2 <- expandedProfile(list2, onto="MF", level=2, orgPackage="org.Hs.eg.db")
expComm <- expandedProfile(commonGenes, onto="MF", level=2, orgPackage="org.Hs.eg.db")

equiv <- equivalentGOProfiles(exp1$MF, exp2$MF, commonExpanded = expComm$MF)
print(equivSummary(equiv))
```

## Tips and Best Practices
- **GO Levels:** Level 2 is standard for a broad overview; Level 3 provides more specificity but may result in many categories with zero counts.
- **Ontology Selection:** "MF" (Molecular Function), "BP" (Biological Process), and "CC" (Cellular Component) can be analyzed individually or together using `onto="ANY"`.
- **Input IDs:** Ensure input IDs are Entrez IDs. If you have Gene Symbols or Ensembl IDs, use `AnnotationDbi` to convert them before profiling.
- **Interpretation:** A low p-value in `compareGeneLists` suggests the functional profiles are significantly different. In `equivalentGOProfiles`, the "Equivalent?" result (1 for yes, 0 for no) indicates if the profiles are within a statistical threshold of similarity.

## Reference documentation
- [goProfiles: Statistical Analysis of Functional Profiles](./references/goProfiles.md)
- [Visual Comparison of Profiles](./references/goProfiles-comparevisual.md)
- [Plotting MF Ontology Profiles](./references/goProfiles-plotProfileMF.md)