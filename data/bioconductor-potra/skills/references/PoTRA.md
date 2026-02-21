# **Pathways of Topological Rank Analysis (PoTRA)**

Chaoxing Li1, Li Liu2, Valentin Dinu2\* and Margaret Linan3

1Arizona State University, Tempe, AZ
2College of Health Solutions, Arizona State University, Tempe, AZ
3Icahn School of Medicine at Mount Sinai, New York, NY

\*valentin.dinu@asu.edu

#### February 7, 2019, Revised: April 6, 2019

# **1 Abstract**

The PoTRA analysis is based on topological ranks of genes in biological pathways. PoTRA can be used to detect pathways involved in disease (1). We use PageRank to measure the relative topological ranks of genes in each biological pathway, then select hub genes for each pathway, and use Fishers Exact test to determine if the number of hub genes in each pathway is altered from normal to cancer (1). Alternatively, if the distribution of topological ranks of gene in a pathway is altered between normal and cancer, this pathway might also be involved in cancer (1). Hence, we use the Kolmogorov–Smirnov test to detect pathways that have an altered distribution of topological ranks of genes between two phenotypes (1). PoTRA can be used with the KEGG, Biocarta, Reactome, NCI, SMPDB and PharmGKB databases from the devel graphite library.

# **4 Parameters**

#### Arguements

* mydata - A gene expression dataset (dataframe). Rows represent genes, and columns represent samples (from control to case). A minimum of 50 controls and 50 cases is recommended. Row names must represent gene identifiers (entrez). A minimum of 18,000 genes are recommended.
* genelist - A list of gene names (entrez).
* Number.sample.normal - The number of normal samples.
* Number.sample.case - The number of case samples.
* Pathway.database - The pathway database, such as KEGG, Reactome, Biocarta and PharmGKB.
* PR.quantile - The percentile of PageRank scores as a cutoff for hub genes. A value of 0.95 is recommended.

#### Values

* Fishertest.p.value - The p-value of the Fisher’s exact test.
* KStest.p.value - The p-value of the K.S. test.
* LengthOfPathway - The length of pathways.
* TheNumberOfHubGenes.normal - The number of hub genes for normal samples.
* TheNumberOfHubGenes.case - The number of hub genes for cancer samples.
* TheNumberOfEdges.normal - The number of edges in the network for normal samples.
* TheNumberOfEdges.case - The number of edges in the network for cancer samples.
* Pathways - The list of pathways provided by the specified database (KEGG, Reactome, Biocarta, PharmGKB)

# **5 Using Pathway Databases with PoTRA**

The following examples utilize the KEGG, Reactome, BioCarta and PharmGKB databases. Kanehisa Laboratories developed KEGG and has been updating it since 1995, it is an important resource for signaling and metabolic pathways (3). The BioCarta biotech company supports the BioCarta community forum, also known as the Biocarta database. The scientific community contributes to the forum and constantly updates it with new proteomic information. Reactome is one of the most comprehensive databases for signaling and metabolic molecules and describes how they relate to pathways and processes (4). PharmGKB is a well known comprehensive resource and describes how genetic variants impact drug response. The PharmGKB database primarily serves as a important resource for metabolic data analyses.

#### Example 1: Using PoTRA with KEGG

library(PoTRA)
library(repmis)
options(warn=-1)
library(BiocGenerics)
library(graph)
library(graphite)
library(igraph)

**Download the example dataset**
source\_data(“<https://github.com/GenomicsPrograms/example_data/raw/master/PoTRA-vignette.RData>”)

**Choose your database before running the PoTRA commandline:**

humanKEGG <- pathways(“hsapiens”, “kegg”)
Pathway.database = humanKEGG

**Run the PoTRA program with KEGG:**

results.KEGG <- PoTRA.corN(mydata=mydata, genelist=genelist, Num.sample.normal=113, Num.sample.case=113, Pathway.database=Pathway.database[1:15], PR.quantile=PR.quantile)

```
names(results.KEGG)
```

```
## [1] "Fishertest.p.value"         "KStest.p.value"
## [3] "LengthOfPathway"            "TheNumberOfHubGenes.normal"
## [5] "TheNumberOfHubGenes.case"   "TheNumberOfEdges.normal"
## [7] "TheNumberOfEdges.case"      "PathwayName"
```

```
head(results.KEGG$Fishertest.p.value)
```

```
## [1] 1.0000000 1.0000000 1.0000000 1.0000000 1.0000000 0.1038961
```

```
head(results.KEGG$KStest.p.value)
```

```
## [1] 0.9606052 0.6601010 0.8602552 0.6993742 0.8927783 0.7657632
```

```
head(results.KEGG$LengthOfPathway)
```

```
## [1] 49 23 22 25 24 18
```

```
head(results.KEGG$TheNumberOfHubGenes.normal)
```

```
## [1] 46 22 22 25 23 14
```

```
head(results.KEGG$TheNumberOfHubGenes.case)
```

```
## [1] 47 22 22 25 24 18
```

```
head(results.KEGG$TheNumberOfEdges.normal)
```

```
## [1] 429 189  91  60 147  38
```

```
head(results.KEGG$TheNumberOfEdges.case)
```

```
## [1] 138  89  33  40  41  16
```

```
head(results.KEGG$PathwayName)
```

```
## [1] "Glycolysis / Gluconeogenesis"
## [2] "Citrate cycle (TCA cycle)"
## [3] "Pentose phosphate pathway"
## [4] "Pentose and glucuronate interconversions"
## [5] "Fructose and mannose metabolism"
## [6] "Galactose metabolism"
```

#### Example 2: Using PoTRA with Reactome

library(PoTRA)
library(repmis)
options(warn=-1)
library(BiocGenerics)
library(graph)
library(graphite)
library(igraph)

**Download the example dataset**
source\_data(“<https://github.com/GenomicsPrograms/example_data/raw/master/PoTRA-vignette.RData>”)

**Choose your database before running the PoTRA commandline:**

humanReactome <- pathways(“hsapiens”, “reactome”)
Pathway.database = humanReactome

**Run the PoTRA program with Reactome:**

results.KEGG <- PoTRA.corN(mydata=mydata, genelist=genelist, Num.sample.normal=113, Num.sample.case=113, Pathway.database=Pathway.database[1:15], PR.quantile=PR.quantile)

```
names(results.Reactome)
```

```
## [1] "Fishertest.p.value"         "KStest.p.value"
## [3] "LengthOfPathway"            "TheNumberOfHubGenes.normal"
## [5] "TheNumberOfHubGenes.case"   "TheNumberOfEdges.normal"
## [7] "TheNumberOfEdges.case"      "PathwayName"
```

```
head(results.Reactome$Fishertest.p.value)
```

```
## [1] 1.000000 1.000000 0.499200 0.614207       NA 1.000000
```

```
head(results.Reactome$KStest.p.value)
```

```
## [1] 9.627040e-01 1.654974e-01 9.276716e-06 6.993742e-01           NA
## [6] 1.590389e-01
```

```
head(results.Reactome$LengthOfPathway)
```

```
## [1]   7 116 313  36   1  32
```

```
head(results.Reactome$TheNumberOfHubGenes.normal)
```

```
## [1]   6 115 311  35  NA  32
```

```
head(results.Reactome$TheNumberOfHubGenes.case)
```

```
## [1]   6 115 313  33  NA  32
```

```
head(results.Reactome$TheNumberOfEdges.normal)
```

```
## [1]    14  3709 18262   348    NA   216
```

```
head(results.Reactome$TheNumberOfEdges.case)
```

```
## [1]    6 1573 5247  108   NA   51
```

```
head(results.Reactome$PathwayName)
```

```
## [1] "Interleukin-6 signaling"         "Apoptosis"
## [3] "Hemostasis"                      "Intrinsic Pathway for Apoptosis"
## [5] "PKB-mediated events"             "PI3K Cascade"
```

#### Example 2: Using PoTRA with Biocarta

library(PoTRA)
library(repmis)
options(warn=-1)
library(BiocGenerics)
library(graph)
library(graphite)
library(igraph)

**Download the example dataset**
source\_data(“<https://github.com/GenomicsPrograms/example_data/raw/master/PoTRA-vignette.RData>”)

**Choose your database before running the PoTRA commandline:**

humanBiocarta <- pathways(“hsapiens”, “biocarta”)
Pathway.database = humanBiocarta

**Run the PoTRA program with Biocarta:**

results.Biocarta <- PoTRA.corN(mydata=mydata, genelist=genelist, Num.sample.normal=113, Num.sample.case=113, Pathway.database=Pathway.database[1:15], PR.quantile=PR.quantile)

```
names(results.Biocarta)
```

```
## [1] "Fishertest.p.value"         "KStest.p.value"
## [3] "LengthOfPathway"            "TheNumberOfHubGenes.normal"
## [5] "TheNumberOfHubGenes.case"   "TheNumberOfEdges.normal"
## [7] "TheNumberOfEdges.case"      "PathwayName"
```

```
head(results.Biocarta$Fishertest.p.value)
```

```
## [1] 0.6025974 1.0000000 1.0000000 1.0000000 1.0000000 0.1408669
```

```
head(results.Biocarta$KStest.p.value)
```

```
## [1] 0.4909804 0.6271671 0.3752110 0.8730159 0.9627040 0.1640792
```

```
head(results.Biocarta$LengthOfPathway)
```

```
## [1] 18  8 15  5  7 10
```

```
head(results.Biocarta$TheNumberOfHubGenes.normal)
```

```
## [1] 17  8 14  4  6  9
```

```
head(results.Biocarta$TheNumberOfHubGenes.case)
```

```
## [1] 15  8 15  5  7  5
```

```
head(results.Biocarta$TheNumberOfEdges.normal)
```

```
## [1] 95  7 56  7 10 28
```

```
head(results.Biocarta$TheNumberOfEdges.case)
```

```
## [1] 29  5  9  3 10  9
```

```
head(results.Biocarta$PathwayName)
```

```
## [1] "p38 mapk signaling pathway"
## [2] "lectin induced complement pathway"
## [3] "regulation of eif-4e and p70s6 kinase"
## [4] "rna polymerase iii transcription"
## [5] "tnfr2 signaling pathway"
## [6] "melanocyte development and pigmentation pathway"
```

#### Example 3: Using PoTRA with PharmGKB

library(PoTRA)
library(repmis)
options(warn=-1)
library(BiocGenerics)
library(graph)
library(graphite)
library(igraph)

**Download the example dataset**
source\_data(“<https://github.com/GenomicsPrograms/example_data/raw/master/PoTRA-vignette.RData>”)

**Choose your database before running the PoTRA commandline:**

humanPharmGKB <- pathways(“hsapiens”, “pharmgkb”)
Pathway.database = humanPharmGKB

**Run the PoTRA program with PharmGKB:**

results.PharmGKB <- PoTRA.corN(mydata=mydata, genelist=genelist, Num.sample.normal=113, Num.sample.case=113, Pathway.database=Pathway.database[1:15], PR.quantile=PR.quantile)

```
names(results.PharmGKB)
```

```
## [1] "Fishertest.p.value"         "KStest.p.value"
## [3] "LengthOfPathway"            "TheNumberOfHubGenes.normal"
## [5] "TheNumberOfHubGenes.case"   "TheNumberOfEdges.normal"
## [7] "TheNumberOfEdges.case"      "PathwayName"
```

```
head(results.PharmGKB$Fishertest.p.value)
```

```
## [1] 0.4814815 0.2105263 1.0000000 1.0000000        NA 1.0000000
```

```
head(results.PharmGKB$KStest.p.value)
```

```
## [1] 0.1527843 0.1640792 0.8927783 0.3364049        NA 0.4413066
```

```
head(results.PharmGKB$LengthOfPathway)
```

```
## [1] 14 10  6  9  2  6
```

```
head(results.PharmGKB$TheNumberOfHubGenes.normal)
```

```
## [1] 12  7  6  9 NA  5
```

```
head(results.PharmGKB$TheNumberOfHubGenes.case)
```

```
## [1] 14 10  6  9 NA  6
```

```
head(results.PharmGKB$TheNumberOfEdges.normal)
```

```
## [1] 19 13  2  8 NA  5
```

```
head(results.PharmGKB$TheNumberOfEdges.case)
```

```
## [1]  7  3  2  2 NA  4
```

```
head(results.PharmGKB$PathwayName)
```

```
## [1] "Statin Pathway - Generalized, Pharmacokinetics"
## [2] "Atorvastatin/Lovastatin/Simvastatin Pathway, Pharmacokinetics"
## [3] "Pravastatin Pathway, Pharmacokinetics"
## [4] "Fluvastatin Pathway, Pharmacokinetics"
## [5] "Rosuvastatin Pathway, Pharmacokinetics"
## [6] "Warfarin Pathway, Pharmacodynamics"
```

# **6 Ranking the Pathways**

Using the PharmGKB and the TCGA’s BRCA open-access HTSEQ normalized gene expression data, sample files were joined on their genelists and then randomly sampled to form ten cohorts of normal and case samples. The pre-processed datasets were then analyzed by PoTRA and the results (Fisher Exact Test P-value and Pathway List) were separately sorted (FE p-values least to greatest), additionally, each set of sorted PoTRA results were given a rank column (1:nrow(DF)) and then a single dataframe was created to hold a single column of PharmGKB pathways, each results sorted FE P-values and all of the rank columns.

The FE P-values columns were statistically averaged using the sumlog(x) function from the metap package. Next, the Ranks were averaged using rowMeans from the colr library.

#### Exercise: Ranking the Pathways

**Synthetic Data (Fisher’s Exact Test P-values)**

FPvalues1 <- c(0.01,0.05,1,0.90,0.01,0.05,0.03)
FPvalues2 <- c(0.01,1,1,1,0.94,0.34,0.25)
FPvalues3 <- c(0.01,0.01,0.04,0.07,0.01,0.03,0.40)
FPvalues4 <- c(0.55,0.21,0.01,0.02,0.01,0.01,0.01)

Note: In each results DF from PoTRA, sort the Fisher’s Exact Test P-Values (decreasing = FALSE), so that the pathways for each individual results set,
remains associated with their corresponding Fisher’s Exact Test P-Values.

**PharmGKB Pathways associated with each of the FPvalues**
Pathways <- c(“Statin Pathway - Generalized, Pharmacokinetics”, “Atorvastatin/Lovastatin/Simvastatin Pathway”, “Pharmacokinetics”, “Pravastatin Pathway”, “Pharmacokinetics”, “Fluvastatin Pathway”, “Pharmacokinetics”)

**In the PoTRA results data frame, after sorting by Fisher’s Exact Test P-Values, create a Rank column.**

Ranks <- seq(1,nrow(DF),1)

Repeat this for each set of PoTRA results. The following output is from the dataFrame of combined, sorted and ranked PoTRA results.

```
DF
```

```
##                                         Pathways FPvalues1 FPvalues2
## 1 Statin Pathway - Generalized, Pharmacokinetics      0.01      0.01
## 2    Atorvastatin/Lovastatin/Simvastatin Pathway      0.01      0.25
## 3                               Pharmacokinetics      0.03      0.34
## 4                            Pravastatin Pathway      0.05      0.94
## 5                               Pharmacokinetics      0.05      1.00
## 6                            Fluvastatin Pathway      0.90      1.00
## 7                               Pharmacokinetics      1.00      1.00
##   FPvalues3 FPvalues4 Rank1 Rank2 Rank3 Rank4
## 1      0.01      0.01     1     1     1     1
## 2      0.01      0.01     1     2     1     1
## 3      0.01      0.01     2     3     1     1
## 4      0.03      0.01     3     4     2     1
## 5      0.04      0.02     3     5     3     2
## 6      0.07      0.21     4     5     4     3
## 7      0.40      0.55     5     5     5     4
```

#### Averaging the Fisher’s Exact P-values with SumLog

library(metap)
library(colr)

FE = cgrep(DF, “^FPvalues”)
data\_FE <- as.data.frame(t(FE))

FE\_SumLog <- t(sapply(data\_FE, function(z)
sumlog(z)$p
))

FE\_SumLogs <- data.frame(t(FE\_SumLog))
names(FE\_SumLogs) <- c(“SumLog\_Pval”)

```
FE_SumLogs
```

```
##     SumLog_Pval
## V1 1.230837e-05
## V2 1.793148e-04
## V3 5.585111e-04
## V4 4.325641e-03
## V5 9.419188e-03
## V6 3.726281e-01
## V7 9.325719e-01
```

#### Averaging the PharmGKB Pathway Ranks

Ranks = cgrep(DF, “^Rank”)
data\_Ranks <- Ranks
DF$Average\_Rank <- rowMeans(data\_Ranks, na.rm = TRUE, dims = 1)

```
DF
```

```
##                                         Pathways  SumLog_Pval Average_Rank
## 1 Statin Pathway - Generalized, Pharmacokinetics 1.230837e-05         1.00
## 2    Atorvastatin/Lovastatin/Simvastatin Pathway 1.793148e-04         1.25
## 3                               Pharmacokinetics 5.585111e-04         1.75
## 4                            Pravastatin Pathway 4.325641e-03         2.50
## 5                               Pharmacokinetics 9.419188e-03         3.25
## 6                            Fluvastatin Pathway 3.726281e-01         4.00
## 7                               Pharmacokinetics 9.325719e-01         4.75
```

# **7 Session Info**

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## Random number generation:
##  RNG:     Mersenne-Twister
##  Normal:  Inversion
##  Sample:  Rounding
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] colr_0.1.900         metap_1.1            repmis_0.5
##  [4] PoTRA_1.0.0          graphite_1.30.0      graph_1.62.0
##  [7] igraph_1.2.4.1       org.Hs.eg.db_3.8.2   AnnotationDbi_1.46.0
## [10] IRanges_2.18.0       S4Vectors_0.22.0     Biobase_2.44.0
## [13] BiocGenerics_0.30.0  BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.1         lattice_0.20-38    prettyunits_1.0.2
##  [4] ps_1.3.0           assertthat_0.2.1   rprojroot_1.3-2
##  [7] digest_0.6.18      R6_2.4.0           plyr_1.8.4
## [10] backports_1.1.4    RSQLite_2.1.1      evaluate_0.13
## [13] httr_1.4.0         Rdpack_0.11-0      rlang_0.3.4
## [16] curl_3.3           data.table_1.12.2  callr_3.2.0
## [19] blob_1.1.1         R.utils_2.8.0      R.oo_1.22.0
## [22] checkmate_1.9.1    rmarkdown_1.12     desc_1.2.0
## [25] devtools_2.0.2     stringr_1.4.0      bit_1.1-14
## [28] compiler_3.6.0     xfun_0.6           pkgconfig_2.0.2
## [31] pkgbuild_1.0.3     htmltools_0.3.6    bookdown_0.9
## [34] crayon_1.3.4       withr_2.1.2        R.methodsS3_1.7.1
## [37] rappdirs_0.3.1     grid_3.6.0         DBI_1.0.0
## [40] magrittr_1.5       bibtex_0.4.2       cli_1.1.0
## [43] stringi_1.4.3      fs_1.3.0           remotes_2.0.4
## [46] testthat_2.1.1     tools_3.6.0        bit64_0.9-7
## [49] R.cache_0.13.0     glue_1.3.1         processx_3.3.0
## [52] pkgload_1.0.2      yaml_2.2.0         BiocManager_1.30.4
## [55] sessioninfo_1.1.1  gbRd_0.4-11        memoise_1.1.0
## [58] knitr_1.22         usethis_1.5.0
```

# **8 References**

1. Chaoxing Li, Li Liu and Valentin Dinu. Pathways of Topological Rank Analysis (PoTRA): A Novel Method to Detect Pathways Involved in Cancer, 2018.
2. Linan MK, Dinu V. 2018. Dispersion analysis of PoTRA ranked mRNA mediated dysregulated pathways in Breast Invasive Cancer from a TCGA Pan-Cancer study. PeerJ Preprints 6:e27306v1 <https://doi.org/10.7287/peerj.preprints.27306v1>
3. Ogata H, Goto S, Sato K, Fujibuchi W, Bono H, Kanehisa M. KEGG: Kyoto Encyclopedia of Genes and Genomes. Nucleic Acids Res. 1999 Jan 1;27(1):29-34.
4. Reactome. What is Reactome? <https://reactome.org/what-is-reactome>