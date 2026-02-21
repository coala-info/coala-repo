# mastR: Markers Automated Screening Tool in R

Jinjin Chen1,2\*, Ahmed Mohamed1\*\* and Chin Wee Tan1\*\*\*

1Bioinformatics Division, Walter and Eliza Hall Institute of Medical Research, Parkville, VIC 3052, Australia
2Department of Medical Biology, University of Melbourne, Parkville, VIC 3010, Australia

\*chen.j@wehi.edu.au
\*\*mohamed.a@wehi.edu.au
\*\*\*cwtan@wehi.edu.au

#### 26 Jan 2026

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Step 1. Build Markers Pool](#step-1.-build-markers-pool)
  + [3.1 Generate Markers from Sources](#generate-markers-from-sources)
    - [3.1.1 i) Leukocyte gene signature Matrix (LM)](#i-leukocyte-gene-signature-matrix-lm)
    - [3.1.2 ii) MSigDB](#ii-msigdb)
    - [3.1.3 iii) PanglaoDB](#iii-panglaodb)
    - [3.1.4 iv) Customized gene list](#iv-customized-gene-list)
  + [3.2 Pool Markers from Sources](#pool-markers-from-sources)
* [4 Step 2. Signature Identification for Target Group](#step-2.-signature-identification-for-target-group)
  + [4.1 a) data processing](#process)
  + [4.2 b) signature selection based on differential expression](#selection)
  + [4.3 c) constrain signature within markers pool](#intersect-pool)
* [5 Step 3. Signature Refinement by Background Expression in Tissue](#step-3.-signature-refinement-by-background-expression-in-tissue)
  + [5.1 I) data subsetting](#i-data-subsetting)
  + [5.2 II) data filtration](#ii-data-filtration)
  + [5.3 III) markers pool refinement](#iii-markers-pool-refinement)
  + [5.4 use CCLE as background data (optional)](#use-ccle-as-background-data-optional)
  + [5.5 IV) combination with Signature](#iv-combination-with-signature)
* [6 Step 4. Visualization of Final Results](#step-4.-visualization-of-final-results)
  + [6.1 Heatmap](#heatmap)
  + [6.2 Signature Score Boxplot](#signature-score-boxplot)
  + [6.3 Signature Abundance Scatter Plot](#signature-abundance-scatter-plot)
  + [6.4 Signature GSEA plot](#signature-gsea-plot)
* [7 Working with Extension Data Input](#working-with-extension-data-input)
  + [7.1 Multiple Datasets](#multi-data)
  + [7.2 Single Cell RNA-sequencing Data](#single-cell-rna-sequencing-data)
* [8 Applications](#applications)
  + [8.1 Score](#score)
  + [8.2 Deconvolution](#deconvolution)
  + [8.3 Annotation](#annotation)
* [9 Session Info](#session-info)

# 1 Introduction

---

**Why do we need group markers**

In biological and clinical research, the identification of biomarkers specific to a disease, tissue, or cell type is a critical step in advancing our understanding and application of this knowledge.

Specific biomarkers can be identified through various methods, such as transcriptomics, proteomics, or metabolomics, which can provide a global view of the molecular landscape of the system being studied.

To denote these biomarkers, we use the term “group markers” in a generic sense, referring to any molecular feature that is specific to a particular group or condition of interest.

Such markers can provide insight into disease diagnosis, prognosis, and treatment options, and can help to differentiate between diseased and healthy states. Thus the identification of the group markers is crucial in various biological and medical applications, as it allows us to distinguish between different cell types or disease states.

For example, in cancer research, identifying marker genes that are differentially expressed between cancer cells and normal cells can help diagnose and monitor the progression of the disease, as well as identify potential therapeutic targets. Similarly, in developmental biology, identifying marker genes that are specific to certain cell types or stages can help us understand the underlying mechanisms of differentiation and development.

Furthermore, marker genes can also be used in diagnostic assays to detect specific diseases or monitor treatment responses. For instance, the presence of certain marker genes in a patient’s blood or tissue sample can indicate the presence or progression of a disease.

**Importance of immune cells signature in tumor micro-environment (TME)**

In this demo, we will be using the example of immune cell signature in the context of the TME as a practical case study to showcase the application of our approach.

TME is made up of a diverse range of cell types (fibroblasts, epithelial cells, endothelial cells, and immune cells) as well as various extracellular components (collagens, growth factors, hormones, cytokines, etc.). Tumor immune micro-environment (TIME) is reported to be highly associated with prognosis and various treatment response to many kinds of cancers.

Recent studies have highlighted the role of immune components in the TME in modulating tumor progression, making them attractive therapeutic targets. These components make up TIME, which is a subset of the TME. Subsequently, it’s proved that tumor infiltrating lymphocytes (TILs) play an essential role in tumor progression, metastasis and treatment response.

This drives TILs to be a strong prognostic indicator for better precision therapy of cancer patients. The identification of these TILs are the subject of extensive research interest due to the roles of specific subset of immune cells acting on different tissues types.

Identification of these cell types are based on flow cytometry in the past, which has limited granularity. But now with the advance of single cell RNA-seq and spatial transcriptomics technologies, more detailed and novel cell types or subtypes can be identified. One of the key advantages of scRNA-seq and spatial technologies is the ability to investigate cell types in the TIME and understand cellular heterogeneity in the TME.

To quantify TILs infiltration (in bulk), estimate cellular composition (in bulk), annotate single cell types (in scRNA) or identify sample states/activities, many computational methods like cell deconvolution (CIBERSORTx), marker based annotation (CelliD) and sample scoring (singscore) are developed. But to distinguish between closely related cell types, estimate cell composition and states, a refined signature is required which typically requires manual curation by domain expert. With the increasing large amount of data and cell types, this is gradually getting to be untenable and will require a different approach to automatically screen such signatures.

`mastR` is a software package specifically designed to automatically screen signatures of interest for particular research questions. This automated process saves significant time and effort that would otherwise be required for manual labor.

**What this package does**

**mastR**, **M**arkers **A**utomated **S**creening **T**ool in **R**, is a package to automatically derive signature for specific group of interest in specific tissue.

With `mastR`, users can simply input their expression data containing the groups of interest, along with group labels, to obtain a list of marker genes (signature) for the target group.

While there are many tools available for generating cell type-specific markers, they are primarily designed for scRNA-seq data and often rely on machine learning algorithms to select relevant features for classification. However, these methods may lack robustness and consistency across datasets when compared to using statistical methods like empirical Bayesian in *[limma](https://bioconductor.org/packages/3.22/limma)*. Furthermore, some of these tools may return a signature even when the data does not contain any, leading to potential inaccuracies.

Although differential expression (DE) analysis can also be done on scRNA data, like `Seurat::FindMarkers()`, it’s reported that DE analysis done on pseudo-bulk scRNA data is more robust and reliable than directly done on scRNA data.

Thus, `mastR` is designed to generate a more refined list of signature genes from multiple group comparisons based on the results from *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* and *[limma](https://bioconductor.org/packages/3.22/limma)* DE analysis workflow. The final signature is selected by rank product score test for picking up genes with high ranks in the most of comparisons. The rank can be ordered by any gene statistic generated by *[limma](https://bioconductor.org/packages/3.22/limma)* analysis. Signature can be further refined by keeping the top n DEGs in the specified comparison(s), which can help to improve the discrimination between fairly similar cell types.

Another unique advantage of `mastR` is that it takes into account the background expression of tissue-specificity, which is often ignored by other marker generation tools. Unlike most tools that only consider the genes’ contribution to the classification, `mastR` also offers a background expression removal function. This function is designed to remove parts of the marker genes that are highly expressed in specific tissues or cancer cells. These signals from the background, regarded as background expression, can cause potential ambiguity when applying the markers to specific tissues due to background or sample purity issues. This feature makes `mastR` apart and enhances the accuracy and specificity of the generated markers.

Furthermore, `mastR` allows users to build a markers pool before signature screening, which might contain the potential markers of interest to the users. The final signature will be integrated with this pool (by intersection), which can help to constrain the final signature within the interested pathway-related genes or functional gene-sets. People can borrow the published knowledge to build this.

The motivation of this package arises from the importance and necessity of identifying specific genes that are differentially expressed in different groups or tissues, as these genes can serve as biomarkers for diagnosis, prognosis, and therapeutic targeting. However, identifying marker genes can be a challenging and time-consuming task, and the presence of background expression can lead to erroneous results. Our package simplifies and streamlines this process, allowing researchers to focus on their analyses and interpretations without the burden of manual marker gene selection and background expression removal.

This report demonstrates the main functions and applications of `mastR` 1.10.2.

This report demonstrates the signature screening workflow of NK cells in colorectal cancer (CRC), assessing the results by using in-built visualization functions.

**mastR screen the signature using the following 3 key steps:**

step 1. build markers pool

**Applications**

* score samples
* estimate cellular proportion
* single cell annotation

# 2 Installation

---

`mastR` R package can be installed from Bioconductor or [GitHub](https://github.com/DavisLaboratory/mastR).

The most updated version of `mastR` is hosted on GitHub and can be installed using `devtools::install_github()` function provided by [devtools](https://cran.r-project.org/package%3Ddevtools).

```
# if (!requireNamespace("devtools", quietly = TRUE)) {
#   install.packages("devtools")
# }
# if (!requireNamespace("mastR", quietly = TRUE)) {
#   devtools::install_github("DavisLaboratory/mastR")
# }

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
if (!requireNamespace("mastR", quietly = TRUE)) {
  BiocManager::install("mastR")
}
packages <- c(
  "BiocStyle",
  "clusterProfiler",
  "ComplexHeatmap",
  "depmap",
  "enrichplot",
  "ggrepel",
  "gridExtra",
  "jsonlite",
  "knitr",
  "rmarkdown",
  "RobustRankAggreg",
  "rvest",
  "singscore",
  "UpSetR"
)
for (i in packages) {
  if (!requireNamespace(i, quietly = TRUE)) {
    install.packages(i)
  }
  if (!requireNamespace(i, quietly = TRUE)) {
    BiocManager::install(i)
  }
}
```

```
library(mastR)
library(edgeR)
library(ggplot2)
library(GSEABase)
```

# 3 Step 1. Build Markers Pool

---

The first step is to define the original markers pool this analysis will be based on.

The final signature will only be the intersected genes with this markers pool. The whole gene list of the data will be regarded as the markers pool if no preliminary result or interested genes are provided.

***Note:*** `markers = NULL` won’t keep any special genes if they fail the filtration by *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*.

If users have any preliminary knowledge about the target group type (cell type), they can build the markers pool of interest from the available datasets or build from MSigDB, PanglaoDB or LM7/LM22 using our in-built functions. All genes in the pool will be reserved for DE analysis even even if they are filtered out during the filtration of *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*.

The standard pool building process involves the following:

1. generate from sources
   1. LM7/22 signature matrix for CIBERSORT
   2. MSigDB
   3. PanglaoDB
   4. Customized gene list
2. merge gene-sets together

`mastR` allows the following markers to be conveniently loaded:

* `lm7` and `lm22`: CIBERSORT (LM22) and Tosolini et al. (LM7) gene sets for leukocytes, get more details using `?mastR::lm7` or `?mastR::lm22`.
* `msigdb_gobp_nk`: a `GeneSetCollection` object, containing gene sets with gene-set name matched to ‘NATURAL\_KILLER’ in GO:BP MSigDB v7.4 database. More details `?mastR::msigdb_gobp_nk`.
* `nk_markers`: a combination of CIBERSORT LM7, LM22 and Huntington gene list with 114 genes. ([Cursons et al. 2019](https://cancerimmunolres.aacrjournals.org/content/7/7/1162.long)).

All markers generation functions will return `GeneSet` or `GeneSetCollection` object.

## 3.1 Generate Markers from Sources

To generate the immune cell signatures, firstly users need to define a pool of markers of interest. `mastR` allows users to build markers pool from multiple resources.

In this demo, we will load some some publicly available example datasets.

### 3.1.1 i) Leukocyte gene signature Matrix (LM)

`lm7/lm22` are immune cells signature matrices from CIBERSORT, contains 7 or 22 immune cell types.

Users can use function `get_lm_sig()` to generate immune cells markers from LM7 and/or lm22.

```
data("lm7", "lm22")

## collect both LM7 and LM22
LM <- get_lm_sig(lm7.pattern = "^NK", lm22.pattern = "NK cells")
LM
#> GeneSetCollection
#>   names: LM7, LM22 (2 total)
#>   unique identifiers: CD244, FASLG, ..., ZNF135 (92 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: NullCollection (1 total)
```

Function `gsc_plot()` allows visualization of an *[UpSetR](https://CRAN.R-project.org/package%3DUpSetR)* plot across all gene-sets.

```
## show upset diagram
gsc_plot(LM)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the UpSetR package.
#>   Please report the issue to the authors.
#> This warning is displayed once per session.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the UpSetR package.
#>   Please report the issue to the authors.
#> This warning is displayed once per session.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the UpSetR package.
#>   Please report the issue to the authors.
#> This warning is displayed once per session.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

### 3.1.2 ii) MSigDB

The Molecular Signatures Database ([**MSigDB**](https://www.gsea-msigdb.org/gsea/msigdb/)) is a database of annotated gene sets, typically used for pathway analysis.

Users can use `get_gsc_sig()` to generate a collection of gene sets for the biological subjects of interest.

In this case, NK cell relevant gene-sets from `msigdb_gobp_nk` are collected.

```
data("msigdb_gobp_nk")
MSig <- get_gsc_sig(
  gsc = msigdb_gobp_nk,
  pattern = "NATURAL_KILLER_CELL_MEDIATED"
)
MSig
#> GeneSetCollection
#>   names: GOBP_NATURAL_KILLER_CELL_MEDIATED_IMMUNITY, GOBP_NATURAL_KILLER_CELL_MEDIATED_CYTOTOXICITY_DIRECTED_AGAINST_TUMOR_CELL_TARGET, ..., GOBP_POSITIVE_REGULATION_OF_NATURAL_KILLER_CELL_MEDIATED_CYTOTOXICITY (18 total)
#>   unique identifiers: AP1G1, ARRB2, ..., KLRC4-KLRK1 (67 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

***Note***: `data = "msigdb"` allows searching of MsigDB without loading into the environment. `species` or `version` are optional parameters.

Similarly, using `gsc_plot()` users can visualize the overlapping gene sets.

As the gene-set names are too long, for better visualization the gene-set names are replaced with letters and shown below.

```
## cut gene set name within 11 characters
gsn <- setNames(names(MSig), LETTERS[seq_along(MSig)])
for (i in seq_along(MSig)) {
  setName(MSig[[i]]) <- LETTERS[i]
}

## show upset diagram of collected gene-sets
gsc_plot(MSig)
```

![](data:image/png;base64...)

```
gsn[c("A", "M", "D")] ## show gene-set names of top 3
#>                                                          A
#>               "GOBP_NATURAL_KILLER_CELL_MEDIATED_IMMUNITY"
#>                                                          M
#>           "GOBP_NATURAL_KILLER_CELL_MEDIATED_CYTOTOXICITY"
#>                                                          D
#> "GOBP_REGULATION_OF_NATURAL_KILLER_CELL_MEDIATED_IMMUNITY"
```

There are 18 gene-sets in `MSig`, which is too many for visualization. Thus, we use function `merge_markers()` to merge all gene-sets into one `GeneSet` object. (*Note*: Users can directly use the un-merged object for subsequent analyses.)

```
## merge all gene sets into one
MSig <- merge_markers(MSig)
setName(MSig) <- "MSigDB"
```

### 3.1.3 iii) PanglaoDB

[PanglaoDB](https://panglaodb.se/) is a database of single cell RNA sequencing experiments with cell type markers.

Users can use `get_panglao_sig()` to generate markers based on the required organs and cell types.

Functions `list_panglao_organs()` and `list_panglao_types()` show all available organs and cell types in PanglaoDB.

***Note:*** This requires real-time connection to PanglaoDB, thus not run in this demo.

```
## show available organs on PanglaoDB
list_panglao_organs()

## show available cell types of interest organ on PanglaoDB
list_panglao_types(organ = "Immune system")

## collect all "NK cells" markers from PanglaoDB website
Panglao <- get_panglao_sig(type = "NK cells")

Panglao
```

### 3.1.4 iv) Customized gene list

Customized markers can be imported as a `GeneSet` object.

Here we demonstrate this by loading the in-built `nk_markers` markers dataset and convert it into `GeneSet` object.

```
## show what nk_markers looks like:
data("nk_markers")
nk_markers
#> # A tibble: 114 × 4
#>    HGNC_Symbol LM22  LM7   Huntington
#>    <chr>       <chr> <chr> <chr>
#>  1 APOBEC3G    TRUE  -     -
#>  2 APOL6       TRUE  -     -
#>  3 AZU1        TRUE  -     -
#>  4 BPI         TRUE  -     -
#>  5 CAMP        TRUE  -     -
#>  6 CCL4        TRUE  -     -
#>  7 CCL5        TRUE  -     TRUE
#>  8 CCND2       TRUE  -     -
#>  9 CD160       TRUE  -     -
#> 10 CD2         TRUE  -     -
#> # ℹ 104 more rows

## convert NK markers into `GeneSet` object
nk_m <- GeneSet(nk_markers$HGNC_Symbol,
  geneIdType = SymbolIdentifier(),
  setName = "NK_markers"
)
```

## 3.2 Pool Markers from Sources

With multiple lists of markers from different sources, use `merge_markers()` to merge them into one `GeneSet` object.

```
gsc <- GeneSetCollection(c(nk_m, LM, MSig)) ## add Panglao if you run it
Markers <- merge_markers(gsc)

## upset plot
gsc_plot(gsc)
```

![](data:image/png;base64...)

```
Markers
#> setName: merged_markers_pool
#> geneIds: APOBEC3G, APOL6, ..., KLRC4-KLRK1 (total: 167)
#> geneIdType: Symbol
#> collectionType: Computed
#> details: use 'details(object)'
```

The summary of the merged list is saved as `longDescription` in the output.

```
## to show the table summary of merged list
head(jsonlite::fromJSON(GSEABase::longDescription(Markers)))
#>       Gene NK_markers LM7 LM22 MSigDB
#> 1    AP1G1          -   -    -   TRUE
#> 2 APOBEC3G       TRUE   - TRUE      -
#> 3    APOL6       TRUE   - TRUE      -
#> 4    ARRB2          -   -    -   TRUE
#> 5     AZU1       TRUE   - TRUE      -
#> 6      BPI       TRUE   - TRUE      -
```

Now with a merged markers pool, we refine the signature genes for group specificity and tissue background removal.

# 4 Step 2. Signature Identification for Target Group

---

For group specificity, there are 3 main steps:

1. differential expression (DE) analysis: filtration, normalization, sample weighting and linear model fit;
2. feature selection: select differentially expressed genes based on rank product score;
3. constrain selected genes within the markers pool.

***Note***: External data is accepted in different formats (e.g. `DGEList`, `eSet`, `matrix`). Input data must be raw counts or log-transformed expression data.

In this demo, we use the imported example data `im_data_6` from [GSE60424](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60424) (Download using `GEOquery::getGEO()`), consisting of immune cells from healthy individuals.

`im_data_6` is a `eSet` object, containing RNA-seq TMM normalized counts data of 6 sorted immune cell types each with 4 samples. More details in `?mastR::im_data_6`.

```
data("im_data_6")
im_data_6
#> ExpressionSet (storageMode: lockedEnvironment)
#> assayData: 50045 features, 24 samples
#>   element names: exprs
#> protocolData: none
#> phenoData
#>   sampleNames: GSM1479438 GSM1479439 ... GSM1479525 (24 total)
#>   varLabels: title geo_accession ... years since diagnosis:ch1 (66
#>     total)
#>   varMetadata: labelDescription
#> featureData: none
#> experimentData: use 'experimentData(object)'
#>   pubMedIds: 25314013
#> Annotation: GPL15456
```

## 4.1 a) data processing

To screen signature for the group specificity, the data needs to be pre-processed.

`process_data()` in `mastR` does the ‘End-to-End’ differential expression analysis using *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* and *[limma](https://bioconductor.org/packages/3.22/limma)* pipeline as a single function call.

Processes under the hood:

* Filter data by the given cutoff, genes with low expression will be removed by *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*.
* If data is raw counts (`normalize = TRUE`), normalize data by ‘TMM’ and fit it using `limma::voom()`. Otherwise apply `trend` of *[limma](https://bioconductor.org/packages/3.22/limma)* on normalized data.
* Fit linear model.
* Compute gene statistic for differential expression analysis using `limma::treat()`.

`im_data_6` has 6 immune cell types:

```
table(im_data_6$`celltype:ch1`)
#>
#>     B-cells         CD4         CD8   Monocytes          NK Neutrophils
#>           4           4           4           4           4           4
```

`process_data()` requires an expression matrix and group labels of the samples. This returns a `DGEList` object with processed data.

To keep consistent with `Markers`, use param `gene_id` to convert ENSEMBL IDs of `im_data_6` to SYMBOLs for intersection.

Refer to `help(proc_data)` for optional parameters.

```
proc_data <- process_data(
  data = im_data_6,
  group_col = "celltype:ch1",
  target_group = "NK",
  markers = geneIds(Markers),
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)
#> 'select()' returned 1:many mapping between keys and columns
#>        NK-Neutrophils NK-Monocytes NK-B.cells NK-CD4 NK-CD8
#> Down             4015         3947       3146   2702   2155
#> NotSig           1488         2695       4425   4994   6201
#> Up               4946         3807       2878   2753   2093

attributes(proc_data)
#> $names
#> [1] "counts"          "samples"         "original_counts" "vfit"
#> [5] "tfit"
#>
#> $class
#> [1] "DGEList"
#> attr(,"package")
#> [1] "edgeR"
```

For ease of process later in this demo, add the expression matrix `E` fitted by `limma::voom()` as ‘voomE’ into `proc_data`.

```
## add voom fitted expression as a new list of proc_data for use
proc_data$voomE <- proc_data$vfit$E
```

***Note:***

`mastR` provides visualization functions to compare the data before and after `process_data()` and assess the quality control (QC) by using `plot_diagnostics()` and `plot_mean_var()`.

To assess the removal of the low quality genes, use `plot_diagnostics()` to show the expression distribution, RLE and MDS plots.

## 4.2 b) signature selection based on differential expression

For selection of group specific signature, pass `proc_data` to `select_sig()` function. Genes with high rank product score in DE results are selected.

`mastR` automatically determines if feature selection is required, the default approach (`feature_selection = "auto"`) performs rank product scoring to select genes. But if the numbers of the result are < 5, no feature selection will be conducted (switch to `feature_selection = "none"`).

```
## get the same result as there's permutation test for rank product
set.seed(123)
sig_ct <- select_sig(proc_data, feature_selection = "auto")

head(sig_ct)
#> GeneSetCollection
#>   names: UP, DOWN (2 total)
#>   unique identifiers: ENSG00000149294, ENSG00000173068, ..., ENSG00000115561 (100 total)
#>   types in collection:
#>     geneIdType: NullIdentifier (1 total)
#>     collectionType: NullCollection (1 total)
```

***Note:***

`mastR` also implements a feature to further optimize the discriminative power of the signature between fairly similar groups by using params `keep.top` and `keep.group`. More details in `help(select_sig)`.

***Tips:***

All above steps from [4.1](#process) to [4.2](#selection) for refining group signature can be done using an integrated function `get_degs()`.

It will return a list of a processed data `proc_data` and a `GeneSetCollection` `DEGs` with `UP` and `DOWN` regulated genes.

QC plots can also be shown by setting optional param `plot = TRUE`.

## 4.3 c) constrain signature within markers pool

To constrain the final signature within the interested gene list, intersect the signature genes `sig_ct` with the markers pool `Markers`. In this demo, only the `UP` regulated genes are kept.

For consistency with `Markers` type, convert ENSEMBL IDs of `im_data_6` to gene SYMBOLs.

```
## convert ensembl IDs into symbols to match markers pool
deg_up <- mapIds(
  org.Hs.eg.db::org.Hs.eg.db,
  geneIds(sig_ct[["UP"]]),
  "SYMBOL", "ENSEMBL"
)
#> 'select()' returned 1:many mapping between keys and columns
deg_up <- na.omit(deg_up)
## markers specific for NK cells
m_ct <- intersect(geneIds(Markers), deg_up)
names(m_ct) <- names(deg_up)[match(m_ct, deg_up)] ## set ensembl ID as names for downstream visualization

head(m_ct)
#> ENSG00000122223 ENSG00000198821 ENSG00000172543 ENSG00000145649 ENSG00000197540
#>         "CD244"         "CD247"          "CTSW"          "GZMA"          "GZMM"
#> ENSG00000100385
#>         "IL2RB"
```

Users can use `pca_matrix_plot()` to assess the group separation.

Looking at the variance of PC1 shown below, it’s clear the intersected genes explain more variance in PC1 compared with all `UP` DEGs.

```
## PCA shows clear separation of NK cells
## after intersection
pca_matrix_plot(proc_data,
  features = m_ct,
  group_by = "celltype.ch1",
  slot = "voomE",
  n = 3,
  gene_id = "ENSEMBL"
) +
  patchwork::plot_annotation("Intersected UP DEGs")
#> 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

```
## before intersection
pca_matrix_plot(proc_data,
  features = as.vector(deg_up),
  group_by = "celltype.ch1",
  slot = "voomE",
  n = 3,
  gene_id = "ENSEMBL"
) +
  patchwork::plot_annotation("All UP DEGs")
#> 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

***Note***:

Wrapper function `filter_subset_sig()` can complete all processes in Step 2 using a single function. The result would be the same.

`filter_subset_sig()` is helpful when users have multiple datasets (more details in Section [7.1](#multi-data)). It can output the final signature after aggregating signature lists from all datasets.

# 5 Step 3. Signature Refinement by Background Expression in Tissue

---

Further refinement can be achieved by eliminating genes with strong signal in the cancer cells or tissues, regarded as background expression.

`mastR` utilizes a signal-to-noise ratio (SNR) approach to filter out genes with low SNR values that have low discriminative power between the group of interest and the background. This removes tumor purity as a factor in the identified signature markers.

Here the signal is the expression of the signature in signal data and the noise is the expression of the signature in background data.

Two input datasets are required:

* signal data (`proc_data` from Step 2)
* background data (target context)

***Note***: Both of signal data and background data must be log-normalized.

The signal data should be the result generated by `process_data()` function.

The refinement consists of:

1. data subset
2. data filtration
3. markers removal
4. combination with the signature

## 5.1 I) data subsetting

To remove genes with background expression, subset the samples based on the context. In this demo, we are looking to remove CRC-specific signal.

Here we choose to load in-built `ccle_crc_5` as the background data. The CRC adherent cell lines data is extracted (`bg_mat`).

The signal data is in `voomE` of `proc_data` and NK cells data is extracted (`sig_mat`).

```
data("ccle_crc_5")

## subset CRC cell lines of bg data
bg_mat <- ccle_crc_5$counts[, ccle_crc_5$samples$cancer == "CRC"]
## subset all NK cells of sig data
sig_mat <- proc_data$voomE[, proc_data$samples$celltype.ch1 == "NK"]
```

***Note:***

`ccle_crc_5` is a `DGEList` object contains 5 CRC cell line samples from [CCLE](https://depmap.org/portal/download/). More details for `help(ccle_crc_5)`.

[DepMap CCLE](https://depmap.org/portal/download/) is a large database containing RSEM quantified TPM data of more than 1,000 cancer cell lines.

## 5.2 II) data filtration

Because SNR is computed using scaled expression across genes, low-expression genes must be removed.

In this case, `sig_mat` from `proc_data` has already been filtered, therefore background data (`bg_mat`) needs to be filtered.

`bg_mat` has only 5 samples, genes with logTPM > 1 within more than 2 samples are kept.

```
keep <- rowSums(bg_mat > 1, na.rm = TRUE) > 2
bg_mat <- bg_mat[keep, ]
```

## 5.3 III) markers pool refinement

To refine the markers pool, use `remove_bg_exp_mat()` to keep genes from `Markers` with high expression in `sig_mat` and low expression in `bg_mat`.

This ensures the specificity of the markers minimizing the context effect.

Similarly, use `gene_id` to convert gene IDs of input to the same type (SYMBOL). As `sig_mat` uses ENSEMBL IDs, `gene_id` types have to be defined in the order: `sig_mat`, `bg_mat`.

```
m_ccl <- remove_bg_exp_mat(
  sig_mat = sig_mat,
  bg_mat = bg_mat,
  markers = geneIds(Markers),
  gene_id = c("ENSEMBL", "SYMBOL")
)
#> 'select()' returned 1:many mapping between keys and columns
#> Warning in remove_bg_exp_mat(sig_mat = sig_mat, bg_mat = bg_mat, markers = geneIds(Markers), : Gene CCL4 is not in the sig_mat! So remove it!
#> Gene CCL5 is not in the sig_mat! So remove it!
#> Gene KIR2DL2 is not in the sig_mat! So remove it!
#> Gene KIR2DL5A is not in the sig_mat! So remove it!
#> Gene KIR2DS2 is not in the sig_mat! So remove it!
#> Gene KIR2DS5 is not in the sig_mat! So remove it!
#> Gene KLRA1P is not in the sig_mat! So remove it!
#> Gene LOC653757 is not in the sig_mat! So remove it!
#> Gene MGC24103 is not in the sig_mat! So remove it!
#> Gene TRDC is not in the sig_mat! So remove it!
#> Gene MGC61571 is not in the sig_mat! So remove it!
#> Gene PIK3R6 is not in the sig_mat! So remove it!

head(m_ccl)
#> [1] "RAB27B" "RAB27A" "TXK"    "TTC38"  "UNC13D" "GZMB"
```

## 5.4 use CCLE as background data (optional)

Users can also use [CCLE](https://depmap.org/portal/download/) downloaded by `depmap::depmap_TPM()` for the refinement.

The entire CCLE data is quite large, thus use `ccle_crc_5` to construct a small pseudo-CCLE data `ccle` with similar format.

```
ccle <- data.frame(ccle_crc_5$counts,
  gene_name = rownames(ccle_crc_5),
  primary_disease = "CRC"
) |>
  tidyr::pivot_longer(-c(gene_name, primary_disease),
    names_to = "depmap_id",
    values_to = "rna_expression"
  )

ccle
#> # A tibble: 95,885 × 4
#>    gene_name primary_disease depmap_id                 rna_expression
#>    <chr>     <chr>           <chr>                              <dbl>
#>  1 TSPAN6    CRC             SNU283_LARGE_INTESTINE             4.91
#>  2 TSPAN6    CRC             TGBC18TKB_LARGE_INTESTINE          6.05
#>  3 TSPAN6    CRC             SW837_LARGE_INTESTINE              5.26
#>  4 TSPAN6    CRC             SNU1040_LARGE_INTESTINE            5.16
#>  5 TSPAN6    CRC             HT29_LARGE_INTESTINE               4.40
#>  6 TNMD      CRC             SNU283_LARGE_INTESTINE             0.176
#>  7 TNMD      CRC             TGBC18TKB_LARGE_INTESTINE          0
#>  8 TNMD      CRC             SW837_LARGE_INTESTINE              0.333
#>  9 TNMD      CRC             SNU1040_LARGE_INTESTINE            0.465
#> 10 TNMD      CRC             HT29_LARGE_INTESTINE               0
#> # ℹ 95,875 more rows
```

Because `ccle` is a long data, subsetting needs to be done before converting it into matrix.

In this demo, we still extract CRC adherent cell lines data from it.

```
## subset CRC cell lines of bg data
ccle <- ccle[ccle$primary_disease == "CRC", ]
```

As `remove_bg_exp_mat()` can only accept matrix in wide format, users can use `ccle_2_wide()` to convert `ccle` into wide matrix.

```
ccle <- ccle_2_wide(ccle = ccle)

ccle[1:3, 1:3]
#>        SNU283_LARGE_INTESTINE TGBC18TKB_LARGE_INTESTINE SW837_LARGE_INTESTINE
#> TSPAN6              4.9140861                  6.045923             5.2570106
#> TNMD                0.1763228                  0.000000             0.3334237
#> DPM1                6.9468478                  6.724105             6.9242187
```

The same filtration cutoff used in `bg_mat` above is used for `ccle`.

```
keep <- rowSums(ccle > 1, na.rm = TRUE) > 2
ccle <- ccle[keep, ]
```

Use `remove_bg_exp_mat()` to refine the markers pool based on `ccle`. As we use `ccle_crc_5` to construct `ccle`, the result should be the same.

```
m_ccl <- remove_bg_exp_mat(
  sig_mat = sig_mat,
  bg_mat = ccle,
  markers = geneIds(Markers),
  gene_id = c("ENSEMBL", "SYMBOL")
)
#> 'select()' returned 1:many mapping between keys and columns
#> Warning in remove_bg_exp_mat(sig_mat = sig_mat, bg_mat = ccle, markers = geneIds(Markers), : Gene CCL4 is not in the sig_mat! So remove it!
#> Gene CCL5 is not in the sig_mat! So remove it!
#> Gene KIR2DL2 is not in the sig_mat! So remove it!
#> Gene KIR2DL5A is not in the sig_mat! So remove it!
#> Gene KIR2DS2 is not in the sig_mat! So remove it!
#> Gene KIR2DS5 is not in the sig_mat! So remove it!
#> Gene KLRA1P is not in the sig_mat! So remove it!
#> Gene LOC653757 is not in the sig_mat! So remove it!
#> Gene MGC24103 is not in the sig_mat! So remove it!
#> Gene TRDC is not in the sig_mat! So remove it!
#> Gene MGC61571 is not in the sig_mat! So remove it!
#> Gene PIK3R6 is not in the sig_mat! So remove it!

head(m_ccl)
#> [1] "RAB27B" "RAB27A" "TXK"    "TTC38"  "UNC13D" "GZMB"
```

***Note:***

Wrapper function `remove_bg_exp()` can complete Step 3. I) II) III) all using one single function.

Users can use the entire CCLE data from DepMap without loading it by using param `bg_data = 'CCLE'`. More details in `help(remove_bg_exp)`.

## 5.5 IV) combination with Signature

To get the final signature with high group specificity and low background expression, intersect the result `m_ccl` with the signature `m_ct` we get from Step 2.

```
sig_NK_CRC <- intersect(m_ct, m_ccl)
head(sig_NK_CRC)
#> [1] "CD244" "CD247" "CTSW"  "GZMA"  "GZMM"  "IL2RB"
```

Here, if we directly use `m_ct` instead of `Markers` as input `markers` for `remove_bg_exp_mat()` or `remove_bg_exp()`, `m_ccl` will already be the intersection result of the original `m_ccl` and `m_ct`, then we can skip this.

# 6 Step 4. Visualization of Final Results

---

To assess how well the refined signature can discriminate our target group from others, `mastR` provides the following visualization functions for different purposes:

* `pca_matrix_plot()`: matrix of PCA plots with top n PCs.
  Show if the target group can be separated from other groups and how well the separation is. Users can also know how much variance has been explained by PC1 with the signature.
* `sig_heatmap()`: signature heatmap across groups and its comparison with un-refined markers pool.
  Validate if the signature shows clear and differential expression pattern between the target group and others. Show if the pattern is clearer and cleaner after the refinement compared with un-refined markers pool.
* `sig_rankdensity_plot()`: rank density distribution of signature genes across groups.
  Show if the signature genes are highly expressed within each sample of the target group while lowly expressed in others.
* `sig_boxplot()`: boxplot of signature expression or singscore across groups.
  Test the overall performance of the whole signature when applying it for scoring, singscore is used to compute the rank score using the whole signature. The boxplot across groups can be used to test if the whole signature is powerful enough to distinguish the target group from others. Median expression of each signature gene can also be plotted.
* `sig_scatter_plot()`: scatter plot of signature scaled expression of the target group vs all other groups respectively.
  Visualize the correlation of the signature between the target and other groups, the row-scaled gene expression is computed to make the scatter plot. Based on it, the co-expression correlation and signature’s specificity can be assessed.
* `sig_gseaplot()`: gene set enrichment analysis (GSEA) result display.
  Validate the enrichment significance of signature in our target group compared with other groups, using `clusterProfiler::GSEA()` analysis. Users can display `dotplot` or `gseaplot`.

## 6.1 Heatmap

Use `sig_heatmap()` function to compare the expression pattern between the original markers pool and the final signature in `proc_data`.

* `sigs`: final signature (or list of multiple signatures).
* `markers`: original markers pool (optional).

```
sig_heatmap(
  data = proc_data,
  sigs = sig_NK_CRC,
  group_col = "celltype.ch1",
  markers = geneIds(Markers),
  gene_id = "ENSEMBL",
  slot = "voomE",
  scale = "row",
  show_column_den = FALSE,
  show_row_den = FALSE,
  show_column_names = FALSE,
  show_row_names = FALSE
)
#> 'select()' returned 1:many mapping between keys and columns
#> Gene CCL4 is not in data.
#> Gene CCL5 is not in data.
#> Gene KIR2DL2 is not in data.
#> Gene KIR2DL5A is not in data.
#> Gene KIR2DS2 is not in data.
#> Gene KIR2DS5 is not in data.
#> Gene KLRA1P is not in data.
#> Gene LOC653757 is not in data.
#> Gene MGC24103 is not in data.
#> Gene TRDC is not in data.
#> Gene MGC61571 is not in data.
#> Gene PIK3R6 is not in data.
#> 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

The expression pattern of the signature is more distinguishable in NK cells.

## 6.2 Signature Score Boxplot

To see if the final signature can distinguish NK cells from other immune cells, use `sig_boxplot()` function to make a boxplot of NK scores using `sig_NK_CRC`. Scores are calculated by *[singscore](https://bioconductor.org/packages/3.22/singscore)* package.

***Note***:

Boxplot of median expression of each gene can be plotted using param `type = "expression"`.

```
sig_boxplot(
  data = proc_data,
  sigs = sig_NK_CRC,
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE"
)
#> 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

It’s clear that the signature shows significantly higher score level in NK cells.

## 6.3 Signature Abundance Scatter Plot

To validate the specificity of the final signature to NK cells, use `sig_scatter_plot()` function to make the scatter plot of the signature z-scored expression in `proc_data`.

If the signature is highly specific to NK cells, most of the signature genes should appear in top left region (scaled expression > 1 in NK, < 1 in others). The genes in top right region should represent the co-expression in both groups.

```
## before refinement
sig_scatter_plot(
  data = proc_data,
  sigs = geneIds(Markers),
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE"
) + ggtitle("Before Refinement")
#> 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

```
## after refinement
sig_scatter_plot(
  data = proc_data,
  sigs = sig_NK_CRC,
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE"
) + ggtitle("After Refinement")
#> 'select()' returned 1:many mapping between keys and columns
```

![](data:image/png;base64...)

Almost all of non-specific genes are filtered by `mastR`.

Further optimization can be performed by removing signature genes present in the bottom right or bottom left region based on the scatter plot.

## 6.4 Signature GSEA plot

To assess the enrichment significance of the final signature in NK cells, use `sig_gseaplot()` function to display GSEA result. Dotplot can be plotted by using `method = "dotplot"`.

```
## gseaplot
sig_gseaplot(
  data = proc_data,
  sigs = list(sig = sig_NK_CRC, markers = geneIds(Markers)),
  group_col = "celltype.ch1",
  target_group = "NK",
  gene_id = "ENSEMBL",
  slot = "voomE",
  method = "gseaplot"
)
```

![](data:image/png;base64...)

The refined signature is enriched in all comparisons and `mastR` successfully removed the trailing tail from the markers pool.

# 7 Working with Extension Data Input

## 7.1 Multiple Datasets

---

The standard workflow of `mastR` usage is as described above.

The above is a show case of single dataset, `mastR` can also be applied to multiple datasets.

After the Step 2c (Section [4.3](#intersect-pool)), for:

1. single dataset
   Returns the final result as the signature.
2. multiple datasets
   After Step 2c, choose one combination method (`union` default) to aggregate signature lists generated from different datasets. The method Robust Rank Aggregation (“RRA”) can also be selected in `mastR`, which detects genes that are ranked consistently better than expected under null hypothesis of uncorrelated inputs and assigns a significance score for each gene.

Instead of integrating datasets into one larger dataset and fit it into one linear model, `mastR` refines signature in each dataset independently and the aggregation method can be defined using param `comb` (e.g. `comb = "RRA"`).

The advantage of this is that it avoids over-normalizing or mis-correcting when carrying out data integration. More robust and conserved signature across datasets can be obtained. In some cases, it’s better than using “Remove Batch Effect”.

Simple combination methods like “union” and “intersect” are also supported (e.g. `comb = union`).

It’s recommended to use `union` when only a few genes are refined for each dataset, while `RRA` is better for robust gene selection from large DEG lists, `intersect` is proper for highly overlapping gene lists.

***Note:***

All signature visualization functions in `mastR` support multiple datasets. More details in `help()`.

To demonstrate the usage on multiple datasets, `im_data_6` is used as an example.

```
## In the demo, we just repeatedly use im_data_6 as a show case
set.seed(123)
m_ct_m <- filter_subset_sig(
  data = list(A = im_data_6, B = im_data_6),
  markers = geneIds(Markers),
  group_col = "celltype:ch1",
  target_group = "NK",
  feature_selection = "auto",
  dir = "UP", ## specify to keep "UP" or "DOWN" regulated genes
  gene_id = "ENSEMBL",
  comb = union,
  summary = FALSE
)
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
```

The signature `m_ct_m` is the same as `m_ct` as `union` is set as combination method.

```
## we will get exactly the same list
## if we choose 'union' or 'intersect' as combination
setequal(m_ct_m, m_ct)
#> [1] TRUE
```

By using `comb = "RRA"`, only the genes at the top rank across signature lists are kept. The cutoff of `RRA` can be set with param `s_thres`.

```
## but we will only get the genes appear at top rank across gene lists
## if we choose 'RRA', s_thres is to determine the threshold for ranking score
set.seed(123)
m_ct_m <- filter_subset_sig(
  data = list(A = im_data_6, B = im_data_6),
  markers = geneIds(Markers),
  group_col = "celltype:ch1",
  target_group = "NK",
  feature_selection = "auto",
  dir = "UP", ## specify to keep "UP" or "DOWN" regulated genes
  gene_id = "ENSEMBL",
  comb = "RRA", ## change this to use different strategy, default is "union"
  s_thres = 0.5, ## only work when comb = "RRA", set a threshold for ranking score
  summary = FALSE
)
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns
#> 'select()' returned 1:many mapping between keys and columns

## fewer signature genes this time
m_ct_m
#> [1] "NCAM1"  "PTGDR"  "CD247"  "ZAP70"  "IL2RB"  "KLRF1"  "SH2D1B" "KLRC1"
```

## 7.2 Single Cell RNA-sequencing Data

---

Although `mastR` is designed for bulk RNA-seq data, in order to support usage of abundant scRNA resources, `mastR` provides `pseudo_samples()` function to help convert scRNA-seq data into pseudo-bulk data, which can then be used in `mastR` workflow.

`pseudo_samples()` aggregates cells into pseudo-bulk samples according to the factor(s) provided using param `by`. Then use `filter_subset_sig()` to get the signature from scRNA-seq data.

```
## create a test scRNA object of 100 genes x 100 cells
counts <- matrix(abs(rpois(10000, 10)), 100)
rownames(counts) <- 1:100
colnames(counts) <- 1:100
meta <- data.frame(
  subset = rep(c("A", "B"), 50),
  level = rep(1:4, each = 25)
)
rownames(meta) <- 1:100
pb <- pseudo_samples(counts, by = meta)

pb <- edgeR::DGEList(counts = pb, group = gsub("\\..*", "", colnames(pb)))

filter_subset_sig(pb, group_col = "group", target_group = "A")
#>        A-B
#> Down     0
#> NotSig 100
#> Up       0
#> character(0)

## Seurat or SCE object are also accepted
# scRNA <- SeuratObject::CreateSeuratObject(counts = counts, meta.data = meta)
# pseudo_samples(scRNA, by = c("subset","level"))
```

# 8 Applications

Users can apply the signature in multiple ways. In this short demo, we will show 3 simple applications.

***Note:***

These examples are not run in this demo.

Firstly, simulate a scRNA data using *[splatter](https://bioconductor.org/packages/3.22/splatter)* package.

Markers list for each group can be obtained from the simulated scRNA data.

```
markers_list <- lapply(
  rowData(data_sim)[, paste0("DEFacGroup", 1:4)],
  \(x) rownames(data_sim[x > 1])
)
```

Use `pseudo_samples()` to get pseudo-bulk data and create a `DGEList` object.

```
## aggregate into pseudo-bulk samples
pb <- pseudo_samples(data_sim,
  by = c("Batch", "Group"),
  min.cells = 50, max.cells = 100
)
dge <- edgeR::DGEList(
  counts = pb,
  samples = data.frame(
    group = gsub(".*\\.(.*)_.*", "\\1", colnames(pb)),
    Batch = gsub("(.*)\\..*", "\\1", colnames(pb)),
    sampleID = gsub("(.*)_.*", "\\1", colnames(pb))
  )
)
```

Use `mastR` wrapper function `filter_subset_sig()` to get the signature for each group. In this case, there are no markers pool of interest and no background.

```
set.seed(123)
sig_ls <- lapply(paste0("Group", 1:4), \(x) {
  filter_subset_sig(
    data = dge,
    markers = NULL,
    group_col = "group",
    target_group = x
  )
})
#>        Group1-Group2 Group1-Group3 Group1-Group4
#> Down              16            16            15
#> NotSig           942           942           943
#> Up                21            21            21
#>        Group2-Group1 Group2-Group3 Group2-Group4
#> Down              21            15            16
#> NotSig           942           949           948
#> Up                16            15            15
#>        Group3-Group1 Group3-Group2 Group3-Group4
#> Down              21            15            15
#> NotSig           942           949           949
#> Up                16            15            15
#>        Group4-Group1 Group4-Group2 Group4-Group3
#> Down              21            15            15
#> NotSig           943           948           949
#> Up                15            16            15
names(sig_ls) <- paste0("Group", 1:4)
```

Show the overlap of the signature lists generated by `mastR` and the markers lists from the simulation.

```
if (!requireNamespace("ggvenn", quietly = TRUE)) {
  # install.packages("ggvenn")
  stop("Install 'ggvenn'!")
}

## venn plot
p <- lapply(1:4, \(i) ggvenn::ggvenn(
  list(
    sig = sig_ls[[i]],
    marker = markers_list[[i]]
  ),
  show_percentage = FALSE
) +
  ggtitle(names(sig_ls)[i]))
patchwork::wrap_plots(p)
```

![](data:image/png;base64...)

Use `sig_heatmap()` to compare the expression of signatures and markers lists.

```
## heatmap
sig_heatmap(
  edgeR::cpm(dge, log = TRUE),
  sigs = c(sig_ls, list("TP53")), ## add a real gene to pass gene check
  group_col = dge$samples$group,
  scale = "row",
  show_column_den = FALSE,
  show_row_den = FALSE,
  cluster_column_slices = FALSE,
  cluster_row_slices = FALSE
)
#> Gene TP53 is not in data.
```

![](data:image/png;base64...)

Randomly aggregate scRNA data to generate pseudo bulk data for scoring and deconvolution.

Cellular proportion can be added into the random pseudo bulk data.

As shown in the following three applications, the `mastR` signatures outperform or match the simulated markers list in various metrics. In terms of score and deconvolution, `mastR` signatures exhibit high agreement with the true cell type proportions.

## 8.1 Score

Multiple scores are calculated by *[singscore](https://bioconductor.org/packages/3.22/singscore)* package using signatures and markers lists. Make scatter plot to compare the correlation between the score and the actual cellular proportion.

For signatures generated by `mastR`:

```
library(singscore)

rank_data <- rankGenes(edgeR::cpm(dge_r, log = TRUE))

## score based on sig_ls
scores <- multiScore(rank_data, upSetColc = gls2gsc(sig_ls))

tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
  -Sample,
  names_to = "Group", values_to = "Prop"
)

tmp <- t(scores$Scores) |>
  data.frame(Sample = colnames(scores$Scores)) |>
  pivot_longer(-Sample, names_to = "Group", values_to = "Score") |>
  left_join(tmp)
#> Joining with `by = join_by(Sample, Group)`

ggplot(tmp, aes(x = Prop, y = Score, col = Group)) +
  geom_point() +
  facet_wrap(~Group, scales = "free") +
  ggpubr::stat_cor() +
  theme_classic()
```

![](data:image/png;base64...)

For markers list from simulation:

```
## score based on markers_list
scores <- multiScore(rank_data, upSetColc = gls2gsc(markers_list))

tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
  -Sample,
  names_to = "Group", values_to = "Prop"
)
tmp$Group <- paste0("DEFac", tmp$Group)

tmp <- t(scores$Scores) |>
  data.frame(Sample = colnames(scores$Scores)) |>
  pivot_longer(-Sample, names_to = "Group", values_to = "Score") |>
  left_join(tmp)
#> Joining with `by = join_by(Sample, Group)`

ggplot(tmp, aes(x = Prop, y = Score, col = Group)) +
  geom_point() +
  facet_wrap(~Group, scales = "free") +
  ggpubr::stat_cor() +
  theme_classic()
```

![](data:image/png;base64...)

## 8.2 Deconvolution

Use the *[BisqueRNA](https://CRAN.R-project.org/package%3DBisqueRNA)* package for cellular deconvolution.

Cellular proportion can be estimated from this.

```
if (!requireNamespace("BisqueRNA", quietly = TRUE)) {
  # install.packages("BisqueRNA")
  stop("Install 'BisqueRNA'!")
}

bulk_eset <- ExpressionSet(edgeR::cpm(dge_r, log = TRUE))

## deconv on sig_ls
mark_d <- stack(sig_ls)
colnames(mark_d) <- c("gene", "cluster")

res_sig <- BisqueRNA::MarkerBasedDecomposition(
  bulk.eset = bulk_eset,
  markers = mark_d
)

## deconv on markers_ls
mark_d <- stack(markers_list)
colnames(mark_d) <- c("gene", "cluster")

res_mar <- BisqueRNA::MarkerBasedDecomposition(
  bulk.eset = bulk_eset,
  markers = mark_d
)
rownames(res_mar$bulk.props) <- gsub("DEFac", "", rownames(res_mar$bulk.props))
```

Similarly, use scatter plot to visualize the correlation between estimated proportions and actual proportions.

```
tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
  -Sample,
  names_to = "Group", values_to = "Prop"
)

tmp <- t(res_sig$bulk.props) |>
  data.frame(Sample = colnames(res_sig$bulk.props)) |>
  pivot_longer(-Sample, names_to = "Group", values_to = "Estimate") |>
  left_join(tmp)

ggplot(tmp, aes(x = Prop, y = Estimate, col = Group)) +
  geom_point() +
  facet_wrap(~Group, scales = "free") +
  ggpubr::stat_cor() +
  theme_classic()
```

```
tmp <- pivot_longer(cbind(Sample = colnames(dge_r), dge_r$samples[, 6:9]),
  -Sample,
  names_to = "Group", values_to = "Prop"
)

tmp <- t(res_mar$bulk.props) |>
  data.frame(Sample = colnames(res_mar$bulk.props)) |>
  pivot_longer(-Sample, names_to = "Group", values_to = "Estimate") |>
  left_join(tmp)

ggplot(tmp, aes(x = Prop, y = Estimate, col = Group)) +
  geom_point() +
  facet_wrap(~Group, scales = "free") +
  ggpubr::stat_cor() +
  theme_classic()
```

## 8.3 Annotation

Use *[singscore](https://bioconductor.org/packages/3.22/singscore)* as a marker-based annotation method. Calculate the scores based on the signatures and markers lists, then assign each cell with the cell type having the highest score. Compare the results.

Using signatures:

```
if (!requireNamespace("scuttle", quietly = TRUE)) {
  # BiocManager::install("scuttle")
  stop("Install 'scuttle'!")
}
library(singscore)
## normalization
data_sim <- scuttle::computePooledFactors(data_sim, clusters = data_sim$Group)
#> Warning in .guessMinMean(x, min.mean = min.mean, BPPARAM = BPPARAM): assuming
#> UMI data when setting 'min.mean'
data_sim <- scuttle::logNormCounts(data_sim)
## use singscore for annotation
rank_data <- rankGenes(logcounts(data_sim))

## score using sig_ls
scores <- multiScore(rank_data, upSetColc = gls2gsc(sig_ls))
data_sim$Pred <- paste0("Group", apply(scores$Scores, 2, which.max))
table(data_sim$Pred == data_sim$Group)
#>
#> FALSE  TRUE
#>  1463  1537
```

Using markers lists:

```
## score using markers_list
scores <- multiScore(rank_data, upSetColc = gls2gsc(markers_list))
data_sim$Pred <- paste0("Group", apply(scores$Scores, 2, which.max))
table(data_sim$Pred == data_sim$Group)
#>
#> FALSE  TRUE
#>  1514  1486
```

# 9 Session Info

---

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] singscore_1.30.0            tidyr_1.3.2
#>  [3] dplyr_1.1.4                 splatter_1.34.0
#>  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [7] GenomicRanges_1.62.1        Seqinfo_1.0.0
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] GSEABase_1.72.0             graph_1.88.1
#> [13] annotate_1.88.0             XML_3.99-0.20
#> [15] AnnotationDbi_1.72.0        IRanges_2.44.0
#> [17] S4Vectors_0.48.0            Biobase_2.70.0
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] ggplot2_4.0.1               edgeR_4.8.2
#> [23] limma_3.66.0                mastR_1.10.2
#> [25] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.2           ggplotify_0.1.3         tibble_3.3.1
#>   [4] R.oo_1.27.1             polyclip_1.10-7         lifecycle_1.0.5
#>   [7] rstatix_0.7.3           doParallel_1.0.17       MASS_7.3-65
#>  [10] globals_0.18.0          lattice_0.22-7          backports_1.5.0
#>  [13] magrittr_2.0.4          sass_0.4.10             rmarkdown_2.30
#>  [16] jquerylib_0.1.4         yaml_2.3.12             otel_0.2.0
#>  [19] ggtangle_0.1.1          spam_2.11-3             sp_2.2-0
#>  [22] ggvenn_0.1.19           cowplot_1.2.0           DBI_1.2.3
#>  [25] RColorBrewer_1.1-3      abind_1.4-8             purrr_1.2.1
#>  [28] R.utils_2.13.0          yulab.utils_0.2.3       tweenr_2.0.3
#>  [31] rappdirs_0.3.4          gdtools_0.4.4           circlize_0.4.17
#>  [34] enrichplot_1.30.4       ggrepel_0.9.6           listenv_0.10.0
#>  [37] tidytree_0.4.7          parallelly_1.46.1       codetools_0.2-20
#>  [40] DelayedArray_0.36.0     scuttle_1.20.0          ggforce_0.5.0
#>  [43] DOSE_4.4.0              tidyselect_1.2.1        shape_1.4.6.1
#>  [46] aplot_0.2.9             farver_2.1.2            jsonlite_2.0.0
#>  [49] GetoptLong_1.1.0        progressr_0.18.0        Formula_1.2-5
#>  [52] RobustRankAggreg_1.2.1  iterators_1.0.14        systemfonts_1.3.1
#>  [55] foreach_1.5.2           tools_4.5.2             ggnewscale_0.5.2
#>  [58] treeio_1.34.0           Rcpp_1.1.1              glue_1.8.0
#>  [61] gridExtra_2.3           SparseArray_1.10.8      xfun_0.56
#>  [64] qvalue_2.42.0           withr_3.0.2             BiocManager_1.30.27
#>  [67] fastmap_1.2.0           digest_0.6.39           R6_2.6.1
#>  [70] gridGraphics_0.5-1      colorspace_2.1-2        GO.db_3.22.0
#>  [73] Cairo_1.7-0             dichromat_2.0-0.1       RSQLite_2.4.5
#>  [76] R.methodsS3_1.8.2       UpSetR_1.4.0            utf8_1.2.6
#>  [79] fontLiberation_0.1.0    data.table_1.18.0       htmlwidgets_1.6.4
#>  [82] msigdb_1.18.0           httr_1.4.7              S4Arrays_1.10.1
#>  [85] scatterpie_0.2.6        pkgconfig_2.0.3         gtable_0.3.6
#>  [88] blob_1.3.0              ComplexHeatmap_2.26.0   S7_0.2.1
#>  [91] XVector_0.50.0          clusterProfiler_4.18.4  htmltools_0.5.9
#>  [94] fontBitstreamVera_0.1.1 carData_3.0-5           dotCall64_1.2
#>  [97] bookdown_0.46           fgsea_1.36.2            clue_0.3-66
#> [100] SeuratObject_5.3.0      scales_1.4.0            png_0.1-8
#> [103] ggfun_0.2.0             knitr_1.51              reshape2_1.4.5
#> [106] rjson_0.2.23            checkmate_2.3.3         nlme_3.1-168
#> [109] org.Hs.eg.db_3.22.0     cachem_1.1.0            GlobalOptions_0.1.3
#> [112] stringr_1.6.0           parallel_4.5.2          pillar_1.11.1
#> [115] grid_4.5.2              vctrs_0.7.1             ggpubr_0.6.2
#> [118] tidydr_0.0.6            car_3.1-3               beachmat_2.26.0
#> [121] xtable_1.8-4            cluster_2.1.8.1         evaluate_1.0.5
#> [124] tinytex_0.58            magick_2.9.0            cli_3.6.5
#> [127] locfit_1.5-9.12         compiler_4.5.2          rlang_1.1.7
#> [130] crayon_1.5.3            future.apply_1.20.1     ggsignif_0.6.4
#> [133] labeling_0.4.3          plyr_1.8.9              fs_1.6.6
#> [136] ggiraph_0.9.3           stringi_1.8.7           BiocParallel_1.44.0
#> [139] Biostrings_2.78.0       lazyeval_0.2.2          fontquiver_0.2.1
#> [142] GOSemSim_2.36.0         Matrix_1.7-4            patchwork_1.3.2
#> [145] bit64_4.6.0-1           future_1.69.0           KEGGREST_1.50.0
#> [148] statmod_1.5.1           igraph_2.2.1            broom_1.0.11
#> [151] memoise_2.0.1           bslib_0.10.0            ggtree_4.0.4
#> [154] fastmatch_1.1-8         bit_4.6.0               gson_0.1.0
#> [157] ape_5.8-1
```