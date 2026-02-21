# multiGSEA: an example workflow

Sebastian Canzler1 and Jörg Hackermüller1

1Helmholtz-Centre for Environmental Research - UFZ, Leipzig, Germany

#### Jan 06, 2025

#### Package

multiGSEA 1.20.0

# 1 Introduction

The `multiGSEA` package was designed to run a robust GSEA-based pathway
enrichment for multiple omics layers. The enrichment is calculated for each
omics layer separately and aggregated p-values are calculated afterwards to
derive a composite multi-omics pathway enrichment.

Pathway definitions can be downloaded from up to eight different pathway
databases by means of the `graphite` Bioconductor package (Sales, Calura, and Romualdi [2018](#ref-graphite:2018)).
Feature mapping for transcripts and proteins is supported towards Entrez Gene
IDs, Uniprot, Gene Symbol, RefSeq, and Ensembl IDs. The mapping is accomplished
through the `AnnotationDbi` package (Pagès et al. [2019](#ref-AnnotationDbi:2019)) and currently
supported for 11 different model organisms including human, mouse, and rat. ID
conversion of metabolite features to Comptox Dashboard IDs (DTXCID, DTXSID),
CAS-numbers, Pubchem IDs (CID), HMDB, KEGG, ChEBI, Drugbank IDs, or common
metabolite names is accomplished through the AnnotationHub package
`metabliteIDmapping`. This package provides a comprehensive ID mapping for more
than 1.1 million entries.

This vignette covers a simple example workflow illustrating how the `multiGSEA`
package works. The omics data sets that will be used throughout the example
were originally provided by Quiros *et al.* (Quirós et al. [2017](#ref-Quiros:2017)). In their publication
the authors analyzed the mitochondrial response to four different toxicants,
including Actinonin, Diclofenac, FCCB, and Mito-Block (MB), within the
transcriptome, proteome, and metabolome layer. The transcriptome data can be
downloaded from [NCBI
GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE84631), the proteome
data from the [ProteomeXchange
Consortium](http://proteomecentral.proteomexchange.org/cgi/GetDataset?ID=PXD006293),
and the non-targeted metabolome raw data can be found in the online supplement.
Please note, this vignette focuses solely on the Actinonin data set.

## 1.1 Installation

There are two different ways to install the `multiGSEA` package.

First, the `multiGSEA` package is part of
[Bioconductor](https://bioconductor.org/packages/devel/bioc/html/multiGSEA.html).
Hence, the best way to install the package is via `BiocManager`. Start R
(>=4.0.0) and run the following commands:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# The following initializes usage of Bioc devel
BiocManager::install(version = "devel")

BiocManager::install("multiGSEA")
```

Alternatively, the `multiGSEA` package is hosted on our github page
<https://github.com/yigbt/multiGSEA> and can be installed via the
`devtools` package:

```
install.packages("devtools")
devtools::install_github("https://github.com/yigbt/multiGSEA")
```

Once installed, just load the `multiGSEA` package with:

```
library(multiGSEA)
```

# 2 Example workflow

A common workflow which is exemplified in this vignette is typically separated
in the following steps:

1. Load required libraries, including the `multiGSEA` package, and omics data sets.
2. Create data structure for enrichment analysis.
3. Download and customize the pathway definitions.
4. Run the pathway enrichment for each omics layer.
5. Calculate the aggregated pathway enrichment.

## 2.1 Load libraries and omics data

At first, we need to load the necessary packages to run the multi-omics
enrichment analysis. In our example data we have to deal with omics data that
has been measured in human cell lines. We therefore need the `org.Hs.eg.db`
package (Carlson [2019](#ref-CarlsonHs:2019)[a](#ref-CarlsonHs:2019)) for transcript and protein mapping. In case the
omics data was measured in mouse or rat, we would need the packages
`org.Mm.eg.db` (Carlson [2019](#ref-CarlsonMm:2019)[b](#ref-CarlsonMm:2019)) and `org.Rn.eg.db` (Carlson [2019](#ref-CarlsonRn:2019)[c](#ref-CarlsonRn:2019)),
respectively.

```
library("org.Hs.eg.db")
```

In principle, `multiGSEA` is able to deal with 11 different model organisms.
A summary of supported organisms, their naming format within `multiGSEA` and
their respective `AnnotationDbi` package is shown in Table
[1](#tab:organismsTable).

Table 1: Supported organisms, their abbreviations being used in `multiGSEA`,
and mapping database that are needed for feature conversion.
Supported abbreviations can be seen with `getOrganisms()`

| Organisms | Abbreviations | Mapping |
| --- | --- | --- |
| Human | hsapiens | org.Hs.eg.db |
| Mouse | mmusculus | org.Mm.eg.db |
| Rat | rnorvegicus | org.Rn.eg.db |
| Dog | cfamiliaris | org.Cf.eg.db |
| Cow | btaurus | org.Bt.eg.db |
| Pig | sscrofa | org.Ss.eg.db |
| Chicken | ggallus | org.Gg.eg.db |
| Zebrafish | drerio | org.Xl.eg.db |
| Frog | xlaevis | org.Dr.eg.db |
| Fruit Fly | dmelanogaster | org.Dm.eg.db |
| C.elegans | celegans | org.Ce.eg.db |

To run the analysis of this vignette, load the installed version of
`multiGSEA`.

```
library(multiGSEA)
library(magrittr)
```

Load the omics data for each layer where an enrichment should be
calculated. The example data is provided within the package and
already preprocessed such that we have log2 transformed fold changes
and their associated p-values. As mentioned previously, the vignette
covers the Actinonin-treated data set from Quiros *et al.* (Quirós et al. [2017](#ref-Quiros:2017)).

```
# load transcriptomic features
data(transcriptome)

# load proteomic features
data(proteome)

# load metabolomic features
data(metabolome)
```

### 2.1.1 Cautionary note

This example involves preprocessed omics data from public
repositories, which means that the data might look different when you
download and pre-process it with your own workflow. Therefore, we put
our processed data as an example data in the R package. We here sketch
out the pipeline described in the `multiGSEA` paper. We will not focus
on the pre-processing steps and how to derive the necessary input
format for the multi-omics pathway enrichment in terms of
differentially expression analysis, since this is highly dependent on
your experiment and analysis workflow.

However, the required input format is quite simple and exactly the
same for each input omics layer: A data frame with 3 mandatory columns,
including feature IDs, the log2-transformed fold change (logFC), and
the associated p-value.

The header of the data frame can be seen in Table [2](#tab:omicsTable):

Table 2: Structure of the necessary omics data
For each layer
(here: transcriptome), feature IDs, log2FCs, and p-values
are needed.

| Symbol | logFC | pValue | adj.pValue |
| --- | --- | --- | --- |
| A2M | -0.1615651 | 0.0000060 | 0.0002525 |
| A2M-AS1 | 0.2352903 | 0.2622606 | 0.4594253 |
| A4GALT | -0.0384392 | 0.3093539 | 0.5077487 |
| AAAS | 0.0170947 | 0.5407324 | 0.7126172 |
| AACS | -0.0260510 | 0.4034970 | 0.5954772 |
| AADAT | 0.0819910 | 0.2355455 | 0.4285059 |

## 2.2 Create data structure

`multiGSEA` works with nested lists where each sublist represents an
omics layer. The function `rankFeatures` calculates the pre-ranked
features, that are needed for the subsequent calculation of the
enrichment score. `rankFeatures` calculates the a local statistic `ls`
based on the direction of the fold change and the magnitude of its
significance:

\[\begin{equation}
ls = sign( log\_2(FC)) \* log\_{10}( p-value)
\end{equation}\]

Please note, that any other rank metric will work as well and the
choice on which one to chose is up to the user. However, as it was
shown by Zyla *et al.* (Joanna Zyla and Polanska [2017](#ref-Zyla:2017)), the choice of the applied metric
might have a big impact on the outcome of your analysis.

```
# create data structure
omics_data <- initOmicsDataStructure(layer = c(
  "transcriptome",
  "proteome",
  "metabolome"
))

## add transcriptome layer
omics_data$transcriptome <- rankFeatures(
  transcriptome$logFC,
  transcriptome$pValue
)
names(omics_data$transcriptome) <- transcriptome$Symbol

## add proteome layer
omics_data$proteome <- rankFeatures(proteome$logFC, proteome$pValue)
names(omics_data$proteome) <- proteome$Symbol

## add metabolome layer
## HMDB features have to be updated to the new HMDB format
omics_data$metabolome <- rankFeatures(metabolome$logFC, metabolome$pValue)
names(omics_data$metabolome) <- metabolome$HMDB
names(omics_data$metabolome) <- gsub(
  "HMDB", "HMDB00",
  names(omics_data$metabolome)
)
```

The first elements of each omics layer are shown below:

```
omics_short <- lapply(names(omics_data), function(name) {
  head(omics_data[[name]])
})
names(omics_short) <- names(omics_data)
omics_short
```

```
## $transcriptome
##     STC2     ASNS     PCK2  FAM129A    NUPR1     ASS1
## 13.43052 12.69346 12.10931 11.97085 11.81069 11.61673
##
## $proteome
##     IFRD1   FAM129A     FDFT1      ASNS       CTH      PCK2
## 10.818222 10.108260 -9.603185  9.327082  8.914447  8.908938
##
## $metabolome
## HMDB0000042 HMDB0003344 HMDB0000820 HMDB0000863 HMDB0006853 HMDB0013785
##   -1.404669   -1.404669   -3.886828   -3.886828   -3.130641   -3.130641
```

## 2.3 Download and customize pathway definitions

Now we have to select the databases we want to query and the omics
layer we are interested in before pathway definitions are downloaded
and features are mapped to the desired format.

```
databases <- c("kegg", "reactome")
layers <- names(omics_data)

pathways <- getMultiOmicsFeatures(
  dbs = databases, layer = layers,
  returnTranscriptome = "SYMBOL",
  returnProteome = "SYMBOL",
  returnMetabolome = "HMDB",
  useLocal = FALSE
)
```

The first two pathway definitions of each omics layer are shown below:

```
pathways_short <- lapply(names(pathways), function(name) {
  head(pathways[[name]], 2)
})
names(pathways_short) <- names(pathways)
pathways_short
```

```
## $transcriptome
## $transcriptome$`(KEGG) Glycolysis / Gluconeogenesis`
##  [1] "AKR1A1"  "ADH1A"   "ADH1B"   "ADH1C"   "ADH4"    "ADH5"    "ADH6"
##  [8] "GALM"    "ADH7"    "LDHAL6A" "DLAT"    "DLD"     "ENO1"    "ENO2"
## [15] "ENO3"    "ALDH2"   "ALDH3A1" "ALDH1B1" "FBP1"    "ALDH3B1" "ALDH3B2"
## [22] "ALDH9A1" "ALDH3A2" "ALDOA"   "ALDOB"   "ALDOC"   "G6PC1"   "GAPDH"
## [29] "GAPDHS"  "GCK"     "GPI"     "HK1"     "HK2"     "HK3"     "ENO4"
## [36] "LDHA"    "LDHB"    "LDHC"    "PGAM4"   "ALDH7A1" "PCK1"    "PCK2"
## [43] "PDHA1"   "PDHA2"   "PDHB"    "PFKL"    "PFKM"    "PFKP"    "PGAM1"
## [50] "PGAM2"   "PGK1"    "PGK2"    "PGM1"    "PKLR"    "PKM"     "PGM2"
## [57] "ACSS2"   "G6PC2"   "BPGM"    "TPI1"    "HKDC1"   "ADPGK"   "ACSS1"
## [64] "FBP2"    "LDHAL6B" "G6PC3"   "MINPP1"
##
## $transcriptome$`(KEGG) Citrate cycle (TCA cycle)`
##  [1] "CS"     "DLAT"   "DLD"    "DLST"   "FH"     "IDH1"   "IDH2"   "IDH3A"
##  [9] "IDH3B"  "IDH3G"  "MDH1"   "MDH2"   "ACLY"   "ACO1"   "OGDH"   "ACO2"
## [17] "PC"     "PDHA1"  "PDHA2"  "PDHB"   "OGDHL"  "SDHA"   "SDHB"   "SDHC"
## [25] "SDHD"   "SUCLG2" "SUCLG1" "SUCLA2" "PCK1"   "PCK2"
##
##
## $proteome
## $proteome$`(KEGG) Glycolysis / Gluconeogenesis`
##  [1] "AKR1A1"  "ADH1A"   "ADH1B"   "ADH1C"   "ADH4"    "ADH5"    "ADH6"
##  [8] "GALM"    "ADH7"    "LDHAL6A" "DLAT"    "DLD"     "ENO1"    "ENO2"
## [15] "ENO3"    "ALDH2"   "ALDH3A1" "ALDH1B1" "FBP1"    "ALDH3B1" "ALDH3B2"
## [22] "ALDH9A1" "ALDH3A2" "ALDOA"   "ALDOB"   "ALDOC"   "G6PC1"   "GAPDH"
## [29] "GAPDHS"  "GCK"     "GPI"     "HK1"     "HK2"     "HK3"     "ENO4"
## [36] "LDHA"    "LDHB"    "LDHC"    "PGAM4"   "ALDH7A1" "PCK1"    "PCK2"
## [43] "PDHA1"   "PDHA2"   "PDHB"    "PFKL"    "PFKM"    "PFKP"    "PGAM1"
## [50] "PGAM2"   "PGK1"    "PGK2"    "PGM1"    "PKLR"    "PKM"     "PGM2"
## [57] "ACSS2"   "G6PC2"   "BPGM"    "TPI1"    "HKDC1"   "ADPGK"   "ACSS1"
## [64] "FBP2"    "LDHAL6B" "G6PC3"   "MINPP1"
##
## $proteome$`(KEGG) Citrate cycle (TCA cycle)`
##  [1] "CS"     "DLAT"   "DLD"    "DLST"   "FH"     "IDH1"   "IDH2"   "IDH3A"
##  [9] "IDH3B"  "IDH3G"  "MDH1"   "MDH2"   "ACLY"   "ACO1"   "OGDH"   "ACO2"
## [17] "PC"     "PDHA1"  "PDHA2"  "PDHB"   "OGDHL"  "SDHA"   "SDHB"   "SDHC"
## [25] "SDHD"   "SUCLG2" "SUCLG1" "SUCLA2" "PCK1"   "PCK2"
##
##
## $metabolome
## $metabolome$`(KEGG) Glycolysis / Gluconeogenesis`
##  [1] "HMDB0001586" "HMDB0001206" "HMDB0001294" "HMDB0001270" "HMDB0000122"
##  [6] "HMDB0003498" "HMDB0003391" "HMDB0060180" "HMDB0003904" "HMDB0000108"
## [11] "HMDB0000223" "HMDB0000243" "HMDB0000042" "HMDB0000190" "HMDB0000990"
## [16] "HMDB0001473" "HMDB0003345" "HMDB0000263" "HMDB0001112" "HMDB0000124"
##
## $metabolome$`(KEGG) Citrate cycle (TCA cycle)`
##  [1] "HMDB0001206" "HMDB0003974" "HMDB0001022" "HMDB0006744" "HMDB0003904"
##  [6] "HMDB0000094" "HMDB0000134" "HMDB0000223" "HMDB0000243" "HMDB0000254"
## [11] "HMDB0000208" "HMDB0000263" "HMDB0000156" "HMDB0000072" "HMDB0000193"
```

## 2.4 Run the pathway enrichment

At this stage, we have the ranked features for each omics layer and the
extracted and mapped features from external pathway databases. In the following
step we can use the `multiGSEA` function to calculate the enrichment for all
omics layer separately.

```
# use the multiGSEA function to calculate the enrichment scores
# for all omics layer at once.
enrichment_scores <- multiGSEA(pathways, omics_data)
```

The enrichment score data structure is a list containing sublists named
`transcriptome`, `proteome`, and `metabolome`. Each sublist represents the
complete pathway enrichment for this omics layer.

## 2.5 Calculate the aggregated p-values

Making use of the Stouffers Z-method to combine multiple p-values that have been
derived from independent tests that are based on the same null hypothesis. The
function `extractPvalues` creates a simple data frame where each row represents
a pathway and columns represent omics related p-values and adjusted p-values.
This data structure can then be used to calculate the aggregated p-value. The
subsequent calculation of adjusted p-values can be achieved by the function
`p.adjust`.

`multiGSEA` provided three different methods to aggregate p-values. These
methods differ in their way how they weight either small or large p-values. By
default, `combinePvalues` will apply the Z-method or Stouffer’s method
(Stouffer et al. [1949](#ref-Stouffer:1949)) which has no bias towards small or large p-values. The widely
used Fisher’s combined probability test (Fisher [1932](#ref-Fisher:1932)) can also be applied but
is known for its bias towards small p-values. Edgington’s method goes the
opposite direction by favoring large p-values (Edgington [1972](#ref-Edgington:1972)). Those methods
can be applied by setting the parameter `method` to “fisher” or “edgington”.

```
df <- extractPvalues(
  enrichmentScores = enrichment_scores,
  pathwayNames = names(pathways[[1]])
)

df$combined_pval <- combinePvalues(df)
df$combined_padj <- p.adjust(df$combined_pval, method = "BH")

df <- cbind(data.frame(pathway = names(pathways[[1]])), df)
```

**Please note:** In former versions of `multiGSEA`, adjusted p-values of
individual omics-layers have been combined. The correction for multiple testing
prior to the p-value combination will, however, violate the assumptions about
p-values of certain combination methods (e.g., Fisher’s combined probability
test).

Therefore, **multiGSEA uses p-values for combination from RELEASE 3.18**.
To keep previous results reproducible, we introduced the `col_pattern` parameter
which can be set to `padj` to use adjusted p-values.

Finally, print the pathways sorted based on their combined adjusted p-values.
For displaying reasons, only the adjusted p-values are shown in Table
[3](#tab:resultTable).

Table 3: Table summarizing the top 15 pathways where we can calculate an
enrichment for all three layers . Pathways from KEGG, Reactome,
and BioCarta are listed based on their aggregated adjusted p-value.
Corrected p-values are displayed for each omics layer separately and
aggregated by means of the Stouffer’s Z-method.

| pathway | transcriptome\_padj | proteome\_padj | metabolome\_padj | combined\_pval |
| --- | --- | --- | --- | --- |
| (KEGG) Metabolic pathways | 0.2286967 | 0.0000000 | 0.0000001 | 0 |
| (REACTOME) Cell Cycle | 0.0000000 | 0.0000000 | 0.7307926 | 0 |
| (REACTOME) Cell Cycle, Mitotic | 0.0000000 | 0.0000025 | 0.7307926 | 0 |
| (REACTOME) Amino acid and derivative metabolism | 0.0004619 | 0.0000000 | 0.2156050 | 0 |
| (REACTOME) Metabolism | 0.1281442 | 0.0000000 | 0.0018390 | 0 |
| (KEGG) Carbon metabolism | 0.0815646 | 0.0000024 | 0.0004852 | 0 |
| (REACTOME) Selenocysteine synthesis | 0.0071907 | 0.0000001 | 0.1563759 | 0 |
| (KEGG) Biosynthesis of amino acids | 0.0014679 | 0.0000001 | 0.2958294 | 0 |
| (REACTOME) Cholesterol biosynthesis | 0.0000000 | 0.0004162 | 0.6345626 | 0 |
| (REACTOME) Selenoamino acid metabolism | 0.0032695 | 0.0000000 | 0.4564624 | 0 |
| (KEGG) Steroid biosynthesis | 0.0000002 | 0.0001066 | 0.5166451 | 0 |
| (REACTOME) M Phase | 0.0000000 | 0.0064487 | 0.7307926 | 0 |
| (REACTOME) Signaling Pathways | 0.0000000 | 0.0010857 | 0.4668829 | 0 |
| (REACTOME) RHO GTPase Effectors | 0.0000000 | 0.0001616 | 0.7967762 | 0 |
| (REACTOME) Glutathione synthesis and recycling | 0.0647041 | 0.0000227 | 0.1003331 | 0 |

# 3 Customizable gene sets

In principle, `multiGSEA` can also be run as single/multi omics analysis on
custom gene sets.

The `pathways` object storing the pathway features across multiple omics layers
is a nested list, and hence can be designed manually to fit ones purposes.

In the following example, HALLMARK gene sets are retrieved from `MSigDB` and
used to create a transcriptomics input list:

```
library(msigdbr)
library(dplyr)

hallmark <- msigdbr(species = "Rattus norvegicus", category = "H") %>%
  dplyr::select(gs_name, ensembl_gene) %>%
  dplyr::filter(!is.na(ensembl_gene)) %>%
  unstack(ensembl_gene ~ gs_name)

pathways <- list("transcriptome" = hallmark)
```

**Please note**, feature sets across multiple omics layers have to be in the
same order and their names have to be identical, see the example presented above.

# 4 Session Information

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] magrittr_2.0.4       multiGSEA_1.20.0     org.Hs.eg.db_3.22.0
##  [4] AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0
##  [7] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Rdpack_2.6.4              DBI_1.2.3
##  [3] mnormt_2.1.1              httr2_1.2.1
##  [5] sandwich_3.1-1            rlang_1.1.6
##  [7] multcomp_1.4-29           qqconf_1.3.2
##  [9] compiler_4.5.1            RSQLite_2.4.3
## [11] dir.expiry_1.18.0         png_0.1-8
## [13] vctrs_0.6.5               pkgconfig_2.0.3
## [15] crayon_1.5.3              fastmap_1.2.0
## [17] dbplyr_2.5.1              XVector_0.50.0
## [19] rmarkdown_2.30            graph_1.88.0
## [21] purrr_1.1.0               bit_4.6.0
## [23] xfun_0.53                 cachem_1.1.0
## [25] graphite_1.56.0           jsonlite_2.0.0
## [27] blob_1.2.4                BiocParallel_1.44.0
## [29] parallel_4.5.1            R6_2.6.1
## [31] bslib_0.9.0               RColorBrewer_1.1-3
## [33] mutoss_0.1-13             jquerylib_0.1.4
## [35] numDeriv_2016.8-1.1       Rcpp_1.1.0
## [37] Seqinfo_1.0.0             bookdown_0.45
## [39] knitr_1.50                zoo_1.8-14
## [41] Matrix_1.7-4              splines_4.5.1
## [43] tidyselect_1.2.1          dichromat_2.0-0.1
## [45] yaml_2.3.10               codetools_0.2-20
## [47] curl_7.0.0                lattice_0.22-7
## [49] tibble_3.3.0              withr_3.0.2
## [51] KEGGREST_1.50.0           S7_0.2.0
## [53] evaluate_1.0.5            metaboliteIDmapping_1.0.0
## [55] survival_3.8-3            BiocFileCache_3.0.0
## [57] Biostrings_2.78.0         pillar_1.11.1
## [59] BiocManager_1.30.26       filelock_1.0.3
## [61] sn_2.1.1                  mathjaxr_1.8-0
## [63] BiocVersion_3.22.0        ggplot2_4.0.0
## [65] scales_1.4.0              TFisher_0.2.0
## [67] glue_1.8.0                tools_4.5.1
## [69] metap_1.12                AnnotationHub_4.0.0
## [71] data.table_1.17.8         fgsea_1.36.0
## [73] mvtnorm_1.3-3             fastmatch_1.1-6
## [75] cowplot_1.2.0             grid_4.5.1
## [77] plotrix_3.8-4             rbibutils_2.3
## [79] cli_3.6.5                 rappdirs_0.3.3
## [81] dplyr_1.1.4               gtable_0.3.6
## [83] sass_0.4.10               digest_0.6.37
## [85] TH.data_1.1-4             farver_2.1.2
## [87] memoise_2.0.1             htmltools_0.5.8.1
## [89] multtest_2.66.0           lifecycle_1.0.4
## [91] httr_1.4.7                bit64_4.6.0-1
## [93] MASS_7.3-65
```

# References

Carlson, Marc. 2019a. *Org.Hs.eg.db: Genome Wide Annotation for Human*.

———. 2019b. *Org.Mm.eg.db: Genome Wide Annotation for Mouse*.

———. 2019c. *Org.Rn.eg.db: Genome Wide Annotation for Rat*.

Edgington, Eugene S. 1972. “An Additive Method for Combining Probability Values from Independent Experiments.” *The Journal of Psychology* 80 (2): 351–63.

Fisher, S R A. 1932. *Statistical Methods for Research Workers - Revised and Enlarged*. Edinburgh, London.

Joanna Zyla, January Weiner, Michal Marczyk, and Joanna Polanska. 2017. “Ranking Metrics in Gene Set Enrichment Analysis: Do They Matter?” *BMC Bioinformatics* 18 (256). [https://doi.org/https://doi.org/10.1186/s12859-017-1674-0](https://doi.org/https%3A//doi.org/10.1186/s12859-017-1674-0).

Pagès, Hervé, Marc Carlson, Seth Falcon, and Nianhua Li. 2019. *AnnotationDbi: Manipulation of Sqlite-Based Annotations in Bioconductor*.

Quirós, P M, M A Prado, N Zamboni, D D’Amico, R W Williams, D Finley, S P Gygi, and J Auwerx. 2017. “Multi-Omics Analysis Identifies ATF4 as a Key Regulator of the Mitochondrial Stress Response in Mammals.” *J Cell Biol* 216 (7): 2027–45. <https://doi.org/10.1083/jcb.201702058>.

Sales, Gabriele, Enrica Calura, and Chiara Romualdi. 2018. “metaGraphite - a New Layer of Pathway Annotation to Get Metabolite Networks.” *Bioinformatics*. <https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/bty719/5090451>.

Stouffer, Samuel A, Edward A Suchman, Leland C DeVinney, Shirley A Star, and Robin M Williams Jr. 1949. “The American Soldier: Adjustment During Army Life.(studies in Social Psychology in World War Ii), Vol. 1.”