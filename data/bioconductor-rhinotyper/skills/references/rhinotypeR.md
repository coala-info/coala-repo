# Introduction to rhinotypeR

Martha Luka\*, Ruth Nanjala, Wafaa Rashed, Winfred Gatua and Olaitan Awe

\*marthaluka20@gmail.com

#### 30 October 2025

# Contents

* [0.1 Background](#background)
* [0.2 Installing the package](#installing-the-package)
* [0.3 Load rhinotypeR](#load-rhinotyper)
* [0.4 Input expectations](#input-expectations)
  + [0.4.1 Option A: Align externally](#option-a-align-externally)
  + [0.4.2 Option B: Align in R](#option-b-align-in-r)
* [0.5 Assign types](#assign-types)
* [0.6 Plot results](#plot-results)
* [0.7 Distances and summaries](#distances-and-summaries)
* [0.8 SNP and amino acid views](#snp-and-amino-acid-views)
* [0.9 Quality and troubleshooting](#quality-and-troubleshooting)
* [0.10 Conclusion](#conclusion)
* [0.11 Session info](#session-info)

## 0.1 Background

The `rhinotypeR` package is designed to automate the genotyping of rhinoviruses using the VP4/2 genomic region. Having worked on rhinoviruses for a few years, I noticed that assigning genotypes after sequencing was particularly laborious, and needed several manual interventions. We, therefore, developed this package to address this challenge by streamlining the process.

It provides:

* Distance computation (`pairwiseDistances()`, `overallMeanDistance()`)
* Genotype assignment (`assignTypes()`)
* Visualization (`plotFrequency()`, `plotDistances()`, `plotTree()`, `SNPeek()`, `plotAA()`)
* Data helpers (`alignToRefs()` for optional alignment in R; `deleteMissingDataSites()` for global gap deletion)
* Prototype references (`getPrototypeSeqs()` if you prefer to align externally)

This vignette walks through two practical workflows:

**A. Align externally** (Your tool of choice) with `getPrototypeSeqs()` → merge with new data, align with tool of choice → import → `assignTypes()`.

**B. Align in R** (with packaged prototypes) using `alignToRefs()` → `assignTypes()`.

**Tip:** Genotype assignment relies on distances to prototype strains and requires that those prototypes are present in the alignment you pass to `assignTypes()`. The `alignToRefs()` helper makes this easy by appending packaged prototypes and aligning jointly.

## 0.2 Installing the package

You can install rhinotypeR from Bioconductor using:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rhinotypeR")
```

## 0.3 Load rhinotypeR

```
# Load package
library(rhinotypeR)

# Load example data
data(rhinovirusVP4, package = "rhinotypeR")
```

## 0.4 Input expectations

* **Format:** FASTA (DNA for VP4/2; AA only for `plotAA()`)
* **Region:** VP4/2; sequences should be homologous
* **Length/QC:** We recommend ≥350 bp (typical ~420 bp) and careful trimming to the target region
* **Alignment:** Required before genotype assignment. Do it either in R (`alignToRefs()`) or outside R and then import (e.g., with `Biostrings::readDNAStringSet()`)

### 0.4.1 Option A: Align externally

Prefer your own alignment tool? Use `getPrototypeSeqs()` to export the packaged prototypes to your local device. These should then be combined with the newly generated sequences, aligned using suitable software, curated and imported into R. There are a multitude of existing alignment software including [MAFFT](https://mafft.cbrc.jp/alignment/server/) and [MUSCLE](https://www.ebi.ac.uk/jdispatcher/).

For example, to download to the Desktop directory:

```
getPrototypeSeqs("~/Desktop")

# You will get "~/Desktop/RVRefs.fasta"
# 2) Combine RVRefs.fasta with your new sequences and align in your tool (e.g., MAFFT).
# 3) Manually curate (trim to VP4/2 span, resolve poor columns), then save as FASTA.
```

Use the Biostrings package to read the curated alignment FASTA file into R:

```
aln_curated <- Biostrings::readDNAStringSet(
  system.file("extdata", "input_aln.fasta", package = "rhinotypeR")
)
```

### 0.4.2 Option B: Align in R

Use this when you want a fully scripted path in R. `alignToRefs()` appends packaged references and runs `msa::msa()` using ClustalW/ClustalOmega/MUSCLE. It can optionally crop the final alignment to the non-gap span of a chosen prototype (`trimToRef = TRUE`, default; anchor with `refName`).

```
# Use package dataset: rhinovirusVP4
# Align user sequences + prototypes in R (choose method)
aln <- alignToRefs(
  seqData   = rhinovirusVP4,
  method    = "ClustalW",           # or "ClustalOmega", "Muscle"
  trimToRef = TRUE,                 # crop to reference non-gap span
  refName   = "JN855971.1_A107"     # default anchor; change if desired
)

aln
```

**Why trimming and gap handling matter:**

* `trimToRef = TRUE` crops the alignment to the exact span covered by a chosen prototype — helpful when user reads spill over the target region
* `deleteGapsGlobally()` performs global deletion (drop any column with a gap in any sequence). This is different from pairwise deletion used within distance calculations. Use with care — this modifies the alignment

## 0.5 Assign types

```
# Input A
res <- assignTypes(aln_curated, model = "IUPAC", deleteGapsGlobally = FALSE, threshold = 0.105)
```

```
##
Computing: [=======                                 ] 17%  (~4s remaining)
Computing: [================                        ] 39%  (~3s remaining)
Computing: [==============================          ] 75%  (~0s remaining)
Computing: [========================================] 100% (done)
```

```
head(res)
```

```
##        query assignedType   distance       reference
## 1 MT177836.1   unassigned 0.11190476  AY040242.1_B97
## 2 MT177837.1   unassigned 0.11190476  AY040242.1_B97
## 3 MT177838.1          B99 0.08809524  AF343652.1_B99
## 4 MT177793.1          B42 0.07380952  AY016404.1_B42
## 5 MT177794.1         B106 0.05617978 KP736587.1_B106
## 6 MT177795.1         B106 0.05912596 KP736587.1_B106
```

```
# OR similarly for input B
res <- assignTypes(aln, model = "IUPAC", deleteGapsGlobally = FALSE, threshold = 0.105)
head(res)
```

**Assigning types: rules and outputs**

`assignTypes()` compares each query to prototypes and returns:

* `query` (sequence ID)
* `assignedType` (or “unassigned”)
* `distance` (to nearest prototype — always reported, even if unassigned)
* `reference` (prototype accession/name used)

**Thresholds:** We default to `threshold = 0.105` (~10.5%) in line with common practice for VP4/2 (A/C) and close to B; adjust per your analysis or species.

## 0.6 Plot results

```
plotFrequency(res)
```

![](data:image/png;base64...)

## 0.7 Distances and summaries

```
# Distances among all sequences
d <- pairwiseDistances(
  fastaData = rhinovirusVP4,
  model = "IUPAC",
  deleteGapsGlobally = FALSE   # set TRUE to apply global deletion inside the function
)
```

```
##
Computing: [==========================              ] 64%  (~0s remaining)
Computing: [========================================] 100% (done)
```

The distance matrix looks like:

```
##            MT177836.1 MT177837.1 MT177838.1 MT177793.1 MT177794.1 MT177795.1
## MT177836.1  0.0000000  0.0000000  0.2380952  0.2119048  0.1938202  0.2113022
## MT177837.1  0.0000000  0.0000000  0.2380952  0.2119048  0.1938202  0.2113022
## MT177838.1  0.2380952  0.2380952  0.0000000  0.1476190  0.2191011  0.2260442
## MT177793.1  0.2119048  0.2119048  0.1476190  0.0000000  0.2050562  0.2186732
## MT177794.1  0.1938202  0.1938202  0.2191011  0.2050562  0.0000000  0.0000000
##            MT177796.1
## MT177836.1 0.21190476
## MT177837.1 0.21190476
## MT177838.1 0.22380952
## MT177793.1 0.21666667
## MT177794.1 0.01404494
```

To visualize the pairwise distances using a heatmap or a phylogenetic tree:

```
# Mean distance (overall diversity)
overallMeanDistance(rhinovirusVP4, model = "IUPAC")
```

```
##
Computing: [==========================              ] 65%  (~0s remaining)
Computing: [========================================] 100% (done)
```

```
## [1] 0.3077591
```

```
# Visual summaries
## Heatmap
plotDistances(d)
```

![](data:image/png;base64...)

```
## Simple tree (from distances)
sampled_distances <- d[1:30, 1:30]
plotTree(sampled_distances, hang = -1, cex = 0.6,
         main = "A simple tree", xlab = "", ylab = "Genetic distance")
```

![](data:image/png;base64...)

## 0.8 SNP and amino acid views

The `SNPeek()` function visualizes single nucleotide polymorphisms (SNPs) in the sequences, with a selected sequence acting as the reference. To specify the reference sequence, move it to the bottom of the alignment before importing into R. Substitutions are color-coded by nucleotide:

* A = green
* T = red
* C = blue
* G = yellow

`SNPeek()` (nucleotide) and `plotAA()` (protein) support zooming and highlighting. To show all sequence names, increase the plotting device height (RStudio plot pane or `png(height=...)`).

```
# SNP view (nucleotide)
SNPeek(rhinovirusVP4)
```

![](data:image/png;base64...)

```
# AA view (requires an AAStringSet)

## Option 1 -- read an aligned amino acid sequence
aa_seq <- Biostrings::readAAStringSet(system.file("extdata", "test_translated.fasta", package = "rhinotypeR"))
plotAA(aa_seq)
```

![](data:image/png;base64...)

```
## Option 2 -- translating DNA
# Remove gaps before translate()
aln_no_gaps <- Biostrings::DNAStringSet(
  gsub("-", "", as.character(rhinovirusVP4))
)
#translate
aa <- Biostrings::translate(aln_no_gaps)
aa_aln <- msa::msa(aa)  # align as plotAA expects equal width
aa_aln <- as(aa_aln, "AAStringSet") # transform to AAStringSet
plotAA(aa_aln)
```

**Tip:** `show_only_highlighted = TRUE` focuses on chosen rows while keeping mismatch context relative to the reference.

## 0.9 Quality and troubleshooting

* **Prototypes missing?** `assignTypes()` will error if prototypes are not present in your alignment. Use Option A (`alignToRefs()`) or Option B (`getPrototypeSeqs()` + external align).
* **Misaligned region?** Use `trimToRef = TRUE` and select an appropriate `refName` that spans your intended VP4/2 region.
* **Gaps distort distances?** Consider `deleteMissingDataSites()` (global deletion), or use a pairwise deletion model where appropriate in distance routines.
* **SNP/AA plots truncated?** Increase device height or use the `highlight_*` options and `show_only_highlighted = TRUE`.

## 0.10 Conclusion

The `rhinotypeR` package simplifies the process of genotyping rhinoviruses and analyzing their genetic data. By automating various steps and providing visualization tools, it enhances the efficiency and accuracy of rhinovirus epidemiological studies.

## 0.11 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] rhinotypeR_1.4.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyr_1.3.1          sass_0.4.10          generics_0.1.4
##  [4] stringi_1.8.7        lattice_0.22-7       digest_0.6.37
##  [7] magrittr_2.0.4       evaluate_1.0.5       grid_4.5.1
## [10] bookdown_0.45        iterators_1.0.14     fastmap_1.2.0
## [13] seqinr_4.2-36        foreach_1.5.2        doParallel_1.0.17
## [16] jsonlite_2.0.0       ape_5.8-1            tinytex_0.57
## [19] BiocManager_1.30.26  purrr_1.1.0          Biostrings_2.78.0
## [22] codetools_0.2-20     jquerylib_0.1.4      ade4_1.7-23
## [25] cli_3.6.5            rlang_1.1.6          crayon_1.5.3
## [28] XVector_0.50.0       cachem_1.1.0         yaml_2.3.10
## [31] tools_4.5.1          parallel_4.5.1       dplyr_1.1.4
## [34] BiocGenerics_0.56.0  msa_1.42.0           vctrs_0.6.5
## [37] R6_2.6.1             magick_2.9.0         stats4_4.5.1
## [40] lifecycle_1.0.4      pwalign_1.6.0        Seqinfo_1.0.0
## [43] stringr_1.5.2        S4Vectors_0.48.0     IRanges_2.44.0
## [46] MASS_7.3-65          pkgconfig_2.0.3      bslib_0.9.0
## [49] pillar_1.11.1        glue_1.8.0           Rcpp_1.1.0
## [52] xfun_0.53            tibble_3.3.0         GenomicRanges_1.62.0
## [55] tidyselect_1.2.1     knitr_1.50           htmltools_0.5.8.1
## [58] nlme_3.1-168         rmarkdown_2.30       compiler_4.5.1
## [61] MSA2dist_1.14.0
```