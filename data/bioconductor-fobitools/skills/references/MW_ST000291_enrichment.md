# Use case: LC-MS Based Approaches to Investigate Metabolomic Differences in the Urine of Young Women after Drinking Cranberry Juice or Apple Juice

Pol Castellano-Escuder1\*

1Duke University

\*polcaes@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load packages](#load-packages)
* [3 Download the data from Metabolomics Workbench](#download-the-data-from-metabolomics-workbench)
  + [3.1 Sumary of the study (ST000291)](#sumary-of-the-study-st000291)
  + [3.2 Download data](#download-data)
  + [3.3 Scraping metabolite names and identifiers with `rvest`](#scraping-metabolite-names-and-identifiers-with-rvest)
* [4 Prepare features and metadata](#prepare-features-and-metadata)
* [5 Statistical analysis with `POMA`](#statistical-analysis-with-poma)
  + [5.1 Create a `SummarizedExperiment` object](#create-a-summarizedexperiment-object)
  + [5.2 Preprocessing](#preprocessing)
  + [5.3 Limma model](#limma-model)
* [6 Convert PubChem IDs to FOBI IDs](#convert-pubchem-ids-to-fobi-ids)
* [7 Enrichment analysis](#enrichment-analysis)
  + [7.1 Over representation analysis (ORA)](#over-representation-analysis-ora)
  + [7.2 MSEA](#msea)
    - [7.2.1 MSEA plot with `ggplot2`](#msea-plot-with-ggplot2)
    - [7.2.2 Network of metabolites found in MSEA](#network-of-metabolites-found-in-msea)
* [8 Limitations](#limitations)
* [9 Session Information](#session-information)
* [References](#references)

**Compiled date**: 2025-10-30

**Last edited**: 2024-10-17

**License**: GPL-3

# 1 Installation

Run the following code to install the Bioconductor version of the package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("fobitools")
```

# 2 Load packages

```
library(fobitools)
```

We will also need some additional [CRAN](https://cran.r-project.org) and [Bioconductor](https://bioconductor.org) packages for performing tasks such as statistical analysis and web scraping.

```
# CRAN
library(tidyverse)
library(rvest)
library(ggrepel)
library(kableExtra)

# Bioconductor
library(POMA)
library(metabolomicsWorkbenchR)
library(SummarizedExperiment)
```

# 3 Download the data from Metabolomics Workbench

The Metabolomics Workbench, available at <www.metabolomicsworkbench.org>, is a public repository for metabolomics metadata and experimental data spanning various species and experimental platforms, metabolite standards, metabolite structures, protocols, tutorials, and training material and other educational resources. It provides a computational platform to integrate, analyze, track, deposit and disseminate large volumes of heterogeneous data from a wide variety of metabolomics studies including mass spectrometry (MS) and nuclear magnetic resonance spectrometry (NMR) data spanning over 20 different species covering all the major taxonomic categories including humans and other mammals, plants, insects, invertebrates and microorganisms (Sud et al. [2016](#ref-sud2016metabolomics)).

The `metabolomicsWorkbenchR` Bioconductor package allows us to obtain data from the Metabolomics Workbench repository. In this vignette we will use the sample data set [ST000291](https://www.metabolomicsworkbench.org/data/DRCCMetadata.php?Mode=Study&StudyID=ST000291).

## 3.1 Sumary of the study (ST000291)

Eighteen healthy female college students between 21-29 years old with a normal BMI of 18.5-25 were recruited. Each subject was provided with a list of foods that contained significant amount of procyanidins, such as **cranberries, apples, grapes, blueberries, chocolate and plums**. They were advised to avoid these foods during the 1-6th day and the rest of the study. On the morning of the 7th day, a first-morning baseline urine sample and blood sample were collected from all human subjects after overnight fasting. **Participants were then randomly allocated into two groups (n=9) to consume cranberry juice or apple juice**. Six bottles (250 ml/bottle) of juice were given to participants to drink in the morning and evening of the 7th, 8th, and 9th day. On the morning of 10th day, all subjects returned to the clinical unit to provide a first-morning urine sample after overnight fasting. The blood sample was also collected from participants 30 min later after they drank another bottle of juice in the morning. After two-weeks of wash out period, participants switched to the alternative regimen and repeated the protocol. One human subject was dropped off this study because she missed part of her appointments. Another two human subjects were removed from urine metabolomics analyses because they failed to provide required urine samples after juice drinking.The present study aimed to investigate overall metabolic changes caused by procyanidins concentrates from cranberries and apples using a global LCMS based metabolomics approach. All plasma and urine samples were stored at -80ºC until analysis.

## 3.2 Download data

This study is composed of two complementary MS analyses, the positive mode (AN000464) and the negative mode (AN000465). Let’s download them both!

```
data_negative_mode <- do_query(
  context = "study",
  input_item = "analysis_id",
  input_value = "AN000465",
  output_item = "SummarizedExperiment")

data_positive_mode <- do_query(
  context = "study",
  input_item = "analysis_id",
  input_value = "AN000464",
  output_item = "SummarizedExperiment")
```

## 3.3 Scraping metabolite names and identifiers with `rvest`

In many metabolomics studies, the reproducibility of analyses is severely affected by the poor interoperability of metabolite names and their identifiers. For this reason it is important to develop tools that facilitate the process of converting one type of identifier to another. In order to use the `fobitools` package, we need some generic identifier (such as PubChem, KEGG or HMDB) that allows us to obtain the corresponding FOBI identifier for each metabolite. The Metabolomics Workbench repository provides us with this information for many of the metabolites quantified in study [ST000291](https://www.metabolomicsworkbench.org/data/show_metabolites_by_study.php?STUDY_ID=ST000291&SEARCH_TYPE=KNOWN&STUDY_TYPE=MS&RESULT_TYPE=1) (Figure [1](#fig:metabolitenames)). In order to easily obtain this information, we will perform a web scraping operation using the `rvest` package.

![Metabolite identifiers of the ST000291 Metabolomics Workbench study.](data:image/png;base64...)

Figure 1: Metabolite identifiers of the ST000291 Metabolomics Workbench study

Below we obtain the PubChem and KEGG identifiers of the metabolites analyzed in the positive and negative mode directly from the Metabolomics Workbench website. We will then remove those duplicate identifiers.

```
metaboliteNamesURL <- "https://www.metabolomicsworkbench.org/data/show_metabolites_by_study.php?STUDY_ID=ST000291&SEARCH_TYPE=KNOWN&STUDY_TYPE=MS&RESULT_TYPE=1"
metaboliteNames <- metaboliteNamesURL %>%
  read_html() %>%
  html_nodes(".datatable")

metaboliteNames_negative <- metaboliteNames %>%
  .[[1]] %>%
  html_table() %>%
  dplyr::select(`Metabolite Name`, PubChemCompound_ID, `Kegg Id`)

metaboliteNames_positive <- metaboliteNames %>%
  .[[2]] %>%
  html_table() %>%
  dplyr::select(`Metabolite Name`, PubChemCompound_ID, `Kegg Id`)

metaboliteNames <- bind_rows(metaboliteNames_negative, metaboliteNames_positive) %>%
  dplyr::rename(names = 1, PubChem = 2, KEGG = 3) %>%
  mutate(KEGG = ifelse(KEGG == "-", "UNKNOWN", KEGG),
         PubChem = ifelse(PubChem == "-", "UNKNOWN", PubChem)) %>%
  filter(!duplicated(PubChem))
```

# 4 Prepare features and metadata

Now we have to prepare the metadata and features in order to proceed with the statistical analysis. In this step we assign to each metabolite its PubChem identifier obtained in the previous step.

```
## negative mode features
features_negative <- assay(data_negative_mode) %>%
  dplyr::slice(-n())
rownames(features_negative) <- rowData(data_negative_mode)$metabolite[1:(length(rowData(data_negative_mode)$metabolite)-1)]

## positive mode features
features_positive <- assay(data_positive_mode) %>%
  dplyr::slice(-n())
rownames(features_positive) <- rowData(data_positive_mode)$metabolite[1:(length(rowData(data_positive_mode)$metabolite)-1)]

## combine positive and negative mode and set PubChem IDs as feature names
features <- bind_rows(features_negative, features_positive) %>%
  tibble::rownames_to_column("names") %>%
  right_join(metaboliteNames, by = "names") %>%
  select(-names, -KEGG) %>%
  tibble::column_to_rownames("PubChem")

## metadata
pdata <- colData(data_negative_mode) %>% # or "data_positive_mode". They are equal
  as.data.frame() %>%
  tibble::rownames_to_column("ID") %>%
  mutate(Treatment = case_when(Treatment == "Baseline urine" ~ "Baseline",
                               Treatment == "Urine after drinking apple juice" ~ "Apple",
                               Treatment == "Urine after drinking cranberry juice" ~ "Cranberry"))
```

# 5 Statistical analysis with `POMA`

`POMA` provides a structured, reproducible and easy-to-use workflow for the visualization, preprocessing, exploration, and statistical analysis of metabolomics and proteomics data. The main aim of this package is to enable a flexible data cleaning and statistical analysis processes in one comprehensible and user-friendly R package. `POMA` uses the standardized `SummarizedExperiment` data structures, to achieve the maximum flexibility and reproducibility and makes `POMA` compatible with other Bioconductor packages (Castellano-Escuder, Andrés-Lacueva, and Sánchez-Pla [2021](#ref-POMA)).

## 5.1 Create a `SummarizedExperiment` object

First, we create a `SummarizedExperiment` object that integrates both metadata and features in the same data structure.

```
data_sumexp <- PomaCreateObject(metadata = pdata, features = t(features))
```

## 5.2 Preprocessing

Second, we perform the preprocessing step. This step includes the missing value imputation unsing the \(k\)-NN algorithm and log Pareto normalization (transformation and scaling). Once these steps are completed, we can proceed to the statistical analysis of these data.

```
data_preprocessed <- data_sumexp %>%
  PomaImpute(group_by = "Treatment") %>%
  PomaNorm()
```

## 5.3 Limma model

We use a limma model (Ritchie et al. [2015](#ref-limma)) to identify those most significant metabolites between the “**Baseline urine**” and “**Urine after drinking cranberry juice**” groups. With this analysis we expect to find metabolites related to cranberry intake.

```
limma_res <- data_preprocessed %>%
  PomaLimma(contrast = "Baseline-Cranberry", adjust = "fdr") %>%
  dplyr::rename(PubChemCID = feature) %>%
  dplyr::mutate(PubChemCID = gsub("X", "", PubChemCID))

# show the first 10 features
limma_res %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| PubChemCID | log2FC | AveExpr | t | pvalue | adj\_pvalue | B |
| --- | --- | --- | --- | --- | --- | --- |
| 54678503 | -2.916890 | 0 | -6.446862 | 1.0e-07 | 0.0000847 | 8.108057 |
| 71485 | -3.267987 | 0 | -5.853017 | 5.0e-07 | 0.0003289 | 6.194381 |
| 94214 | -2.180373 | 0 | -5.691638 | 8.0e-07 | 0.0003817 | 5.676529 |
| 5378303 | -2.414795 | 0 | -5.543843 | 1.4e-06 | 0.0004030 | 5.203836 |
| 3037 | -3.179669 | 0 | -5.463171 | 1.8e-06 | 0.0004030 | 4.946595 |
| 10178 | -3.331534 | 0 | -5.454885 | 1.9e-06 | 0.0004030 | 4.920207 |
| 443071 | -3.615367 | 0 | -5.402912 | 2.3e-06 | 0.0004030 | 4.754851 |
| 5486800 | 1.784212 | 0 | 5.388792 | 2.4e-06 | 0.0004030 | 4.709975 |
| 17531 | -2.262358 | 0 | -5.318449 | 3.0e-06 | 0.0004550 | 4.486739 |
| 3035199 | -1.970513 | 0 | -5.048492 | 7.5e-06 | 0.0010196 | 3.635733 |

# 6 Convert PubChem IDs to FOBI IDs

Once we have the results of the statistical analysis and generic identifiers recognized in the FOBI ontology (Castellano-Escuder et al. [2020](#ref-castellano2020fobi)), we can proceed to perform one of the main functions provided by the `fobitools` package, the ID conversion. With the `fobitools::id_convert()` command, users can convert different IDs between FOBI, HMDB, KEGG, PubChem, InChIKey, InChICode, ChemSpider, and chemical names. We will then obtain the FOBI IDs from the PubChem IDs (obtained in the previous sections) and add them as a new column to the results of the limma model.

```
limma_FOBI_names <- limma_res %>%
  dplyr::pull("PubChemCID") %>%
  fobitools::id_convert()

# show the ID conversion results
limma_FOBI_names %>%
  head() %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| FOBI | PubChemCID | ChemSpider |
| --- | --- | --- |
| FOBI:030415 | 91 | 89 |
| FOBI:030711 | 1145 | 1113 |
| FOBI:030555 | 5280445 | 4444102 |
| FOBI:030709 | 1123 | 10675782 |
| FOBI:030625 | 7533 | 15484224 |
| FOBI:030397 | 1794427 | 1405788 |

```
limma_FOBI_names <- limma_FOBI_names %>%
  dplyr::right_join(limma_res, by = "PubChemCID") %>%
  dplyr::arrange(-dplyr::desc(pvalue))
```

# 7 Enrichment analysis

Enrichment analysis denotes any method that benefits from biological pathway or network information to gain insight into a biological system (Creixell et al. [2015](#ref-creixell2015pathway)). In other words, these type of analyses integrate the existing biological knowledge (from different biological sources such as databases and ontologies) and the statistical results of *omics* studies, obtaining a deeper understanding of biological systems.

In most metabolomics studies, the output of statistical analysis is usually a list of features selected as statistically significant or statistically relevant according to a pre-defined statistical criteria. Enrichment analysis methods use these selected features to explore associated biologically relevant pathways, diseases, etc., depending on the nature of the input feature list (genes, metabolites, etc.) and the source used to extract the biological knowledge (GO, KEGG, **FOBI**, etc.).

Here, we present a tool that uses the FOBI information to perform different types of enrichment analyses. Therefore, the presented methods allow researchers to move from lists of metabolites to chemical classes and food groups associated with those lists, and consequently, to the study design.

Currently, the most popular used approaches for enrichment analysis are the over representation analysis (ORA) and the gene set enrichment analysis (GSEA), with its variants for other fields such as the metabolite set enrichment analysis (MSEA) (Xia and Wishart [2010](#ref-xia2010msea)).

## 7.1 Over representation analysis (ORA)

ORA is one of the most used methods to perform enrichment analysis in metabolomics studies due to its simplicity and easy understanding. This method statistically evaluates the fraction of metabolites in a particular pathway found among the set of metabolites statistically selected. Thus, ORA is used to test if certain groups of metabolites are represented more than expected by chance given a feature list.

However, ORA has a number of limitations. The most important one is the need of using a certain threshold or criteria to select the feature list. This means that metabolites do not meet the selection criteria must be discarded. The second big limitation of ORA is that this method assumes independence of sets and features. In ORA, is assumed that each feature is independent of the other features and each set is independent of the other sets.

Here, we perform an ORA with the `fobitools` package, where we will use as a universe all the metabolites of the study present in FOBI and as a list those metabolites with a raw p-value < 0.01 in the limma results table.

```
metaboliteList <- limma_FOBI_names$FOBI[limma_FOBI_names$pvalue < 0.01]
metaboliteUniverse <- limma_FOBI_names$FOBI

fobitools::ora(metaboliteList = metaboliteList,
               metaboliteUniverse = metaboliteUniverse,
               pvalCutoff = 0.5) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| className | classSize | overlap | pval | padj | overlapMetabolites |
| --- | --- | --- | --- | --- | --- |
| soft drink (dietetic) | 2 | 1 | 0.1362126 | 1 | FOBI:030627 |
| cocoa | 5 | 1 | 0.3164249 | 1 | FOBI:050272 |
| coffee based beverage product | 17 | 2 | 0.3416255 | 1 | FOBI:030…. |
| coffee (liquid drink) | 7 | 1 | 0.4214407 | 1 | FOBI:050272 |

As we can see, due to the limitations of this methodology and the small number of metabolites that meet the set statistical criterion, the results do not show a clear and obvious relationship with the design of the study, as the food groups that appear in the ORA results do not correspond to those foods administered in the intervention.

## 7.2 MSEA

Gene Set Enrichment Analysis (GSEA) methodology was proposed for the first time in 2005, with the aim of improving the interpretation of gene expression data. The main purpose of GSEA is to determine whether members of a gene set \(S\) tend to occur toward the top (or bottom) of the gene list \(L\), in which case the gene set is correlated with the phenotypic class distinction (Subramanian et al. [2005](#ref-subramanian2005gene)).

This type of analysis basically consists of three key steps (Subramanian et al. [2005](#ref-subramanian2005gene)):

The first step consists on the calculation of an enrichment score (\(ES\)). This value indicates the degree to which a set \(S\) is overrepresented at the extremes (top or bottom) of the entire ranked gene list \(L\). The \(ES\) is calculated by walking down the list \(L\), increasing a running-sum statistic when a gene is found in \(S\) and decreasing it when a gene is not found in \(S\). The magnitude of the increment depends on the correlation of the gene with the phenotype. The \(ES\) is the maximum deviation from zero encountered in the random walk.

The second step is the estimation of significance level of \(ES\). The statistical significance (nominal p-value) of the \(ES\) is estimated by using an empirical phenotype-based permutation test that preserves the complex correlation structure of the gene expression data. The phenotype labels (\(L\)) are permuted and the \(ES\) of the \(S\) is recomputed for the permuted data, which generates a null distribution for the \(ES\). The empirical, nominal p-value of the observed \(ES\) is then calculated relative to this null distribution. The permutation of class labels (groups) preserves gene-gene correlations and, thus, provides a more biologically reasonable assessment of significance than would be obtained by permuting genes.

Finally, the third step consist on the adjustment for multiple hypothesis testing. When an entire database of gene sets is evaluated, the estimated significance level is adjusted for multiple hypothesis testing. First, the \(ES\) is normalized for each gene set to account for the size of the set, yielding a normalized enrichment score (NES). Then, the proportion of false positives is controlled by calculating the FDR corresponding to each NES.

In 2010, a modification of the GSEA methodology was presented for metabolomics studies. This method was called Metabolite Set Enrichment Analysis (MSEA) and its main aim was to help researchers identify and interpret patterns of human and mammalian metabolite concentration changes in a biologically meaningful context (Xia and Wishart [2010](#ref-xia2010msea)). MSEA is currently widely used in the metabolomics community and it is implemented and freely available at the known [MetaboAnalyst](https://www.metaboanalyst.ca) web-based tool (Xia and Wishart [2010](#ref-xia2010msea)).

As can be seen, GSEA approach is more complex than the ORA methodology, both in terms of methodological aspects and understanding of the method.

The `fobitools` package provides a function to perform MSEA using the FOBI information. This function requires a ranked list. Here, we will use the metabolites obtained in the limma model ranked by raw p-values.

```
limma_FOBI_msea <- limma_FOBI_names %>%
  dplyr::select(FOBI, pvalue) %>%
  dplyr::filter(!is.na(FOBI)) %>%
  dplyr::arrange(-dplyr::desc(abs(pvalue)))

FOBI_msea <- as.vector(limma_FOBI_msea$pvalue)
names(FOBI_msea) <- limma_FOBI_msea$FOBI

msea_res <- fobitools::msea(FOBI_msea, pvalCutoff = 0.06)

msea_res %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| className | classSize | log2err | ES | NES | pval | padj | leadingEdge |
| --- | --- | --- | --- | --- | --- | --- | --- |
| berry (whole, raw) | 1 | 0.2572065 | 1 | 2.021796 | 0.030969 | 0.8891762 | FOBI:030590 |
| butter | 1 | 0.2572065 | 1 | 2.021796 | 0.030969 | 0.8891762 | FOBI:030590 |
| peanut butter | 1 | 0.2572065 | 1 | 2.021796 | 0.030969 | 0.8891762 | FOBI:030590 |

As we can see, the enrichment analysis with the MSEA method seems to be much more accurate than the ORA method, since the two classes that head the results table (“*grape (whole, raw)*” and “*grapefruit (whole, raw)*”) are clearly within the FOBI food group (set) “*plant fruit food product*”, which is aligned with the study intervention, cranberry juice intake.

```
fobi_graph(terms = c("FOODON:03301123", "FOODON:03301702"),
           get = "anc",
           labels = TRUE,
           labelsize = 6)
```

![](data:image/png;base64...)

### 7.2.1 MSEA plot with `ggplot2`

```
ggplot(msea_res, aes(x = -log10(pval), y = NES, color = NES, size = classSize, label = className)) +
  xlab("-log10(P-value)") +
  ylab("NES (Normalized Enrichment Score)") +
  geom_point() +
  ggrepel::geom_label_repel(color = "black", size = 7) +
  theme_bw() +
  theme(legend.position = "top",
        text = element_text(size = 22)) +
  scale_color_viridis_c() +
  scale_size(guide = "none")
```

![](data:image/png;base64...)

### 7.2.2 Network of metabolites found in MSEA

```
FOBI_terms <- msea_res %>%
  unnest(cols = leadingEdge)

fobitools::fobi %>%
  filter(FOBI %in% FOBI_terms$leadingEdge) %>%
  pull(id_code) %>%
  fobi_graph(get = "anc",
             labels = TRUE,
             legend = TRUE,
             labelsize = 6,
             legendSize = 20)
```

![](data:image/png;base64...)

# 8 Limitations

The FOBI ontology is currently in its first release version, so it does not yet include information on many metabolites and food relationships. All future efforts will be directed at expanding this ontology, leading to a significant increase in the number of metabolites and metabolite-food relationships. The `fobitools` package provides the methodology for easy use of the FOBI ontology regardless of the amount of information it contains. Therefore, future FOBI improvements will also have a direct impact on the `fobitools` package, increasing its utility and allowing to perform, among others, more accurate, complete and robust enrichment analyses.

# 9 Session Information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
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
#>  [1] SummarizedExperiment_1.40.0   Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0          Seqinfo_1.0.0
#>  [5] IRanges_2.44.0                S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0           generics_0.1.4
#>  [9] MatrixGenerics_1.22.0         matrixStats_1.5.0
#> [11] metabolomicsWorkbenchR_1.20.0 POMA_1.20.0
#> [13] ggrepel_0.9.6                 rvest_1.0.5
#> [15] kableExtra_1.4.0              lubridate_1.9.4
#> [17] forcats_1.0.1                 stringr_1.5.2
#> [19] dplyr_1.1.4                   purrr_1.1.0
#> [21] readr_2.1.5                   tidyr_1.3.1
#> [23] tibble_3.3.0                  ggplot2_4.0.0
#> [25] tidyverse_2.0.0               fobitools_1.18.0
#> [27] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              MultiAssayExperiment_1.36.0
#>   [5] magrittr_2.0.4              magick_2.9.0
#>   [7] farver_2.1.2                rmarkdown_2.30
#>   [9] vctrs_0.6.5                 memoise_2.0.1
#>  [11] tinytex_0.57                BiocBaseUtils_1.12.0
#>  [13] S4Arrays_1.10.0             htmltools_0.5.8.1
#>  [15] curl_7.0.0                  qdapRegex_0.7.10
#>  [17] tictoc_1.2.1                SparseArray_1.10.0
#>  [19] sass_0.4.10                 parallelly_1.45.1
#>  [21] bslib_0.9.0                 impute_1.84.0
#>  [23] RecordLinkage_0.4-12.5      cachem_1.1.0
#>  [25] igraph_2.2.1                lifecycle_1.0.4
#>  [27] pkgconfig_2.0.3             Matrix_1.7-4
#>  [29] R6_2.6.1                    fastmap_1.2.0
#>  [31] future_1.67.0               selectr_0.4-2
#>  [33] digest_0.6.37               syuzhet_1.0.7
#>  [35] ps_1.9.1                    textshaping_1.0.4
#>  [37] RSQLite_2.4.3               labeling_0.4.3
#>  [39] timechange_0.3.0            abind_1.4-8
#>  [41] httr_1.4.7                  polyclip_1.10-7
#>  [43] compiler_4.5.1              proxy_0.4-27
#>  [45] bit64_4.6.0-1               withr_3.0.2
#>  [47] S7_0.2.0                    BiocParallel_1.44.0
#>  [49] viridis_0.6.5               DBI_1.2.3
#>  [51] ggforce_0.5.0               MASS_7.3-65
#>  [53] lava_1.8.1                  DelayedArray_0.36.0
#>  [55] textclean_0.9.3             tools_4.5.1
#>  [57] chromote_0.5.1              otel_0.2.0
#>  [59] future.apply_1.20.0         nnet_7.3-20
#>  [61] glue_1.8.0                  promises_1.4.0
#>  [63] grid_4.5.1                  fgsea_1.36.0
#>  [65] gtable_0.3.6                lexicon_1.2.1
#>  [67] tzdb_0.5.0                  class_7.3-23
#>  [69] websocket_1.4.4             data.table_1.17.8
#>  [71] hms_1.1.4                   XVector_0.50.0
#>  [73] tidygraph_1.3.1             xml2_1.4.1
#>  [75] pillar_1.11.1               limma_3.66.0
#>  [77] vroom_1.6.6                 later_1.4.4
#>  [79] splines_4.5.1               tweenr_2.0.3
#>  [81] lattice_0.22-7              survival_3.8-3
#>  [83] bit_4.6.0                   tidyselect_1.2.1
#>  [85] knitr_1.50                  gridExtra_2.3
#>  [87] bookdown_0.45               svglite_2.2.2
#>  [89] xfun_0.53                   graphlayouts_1.2.2
#>  [91] statmod_1.5.1               stringi_1.8.7
#>  [93] yaml_2.3.10                 evaluate_1.0.5
#>  [95] codetools_0.2-20            evd_2.3-7.1
#>  [97] ggraph_2.2.2                BiocManager_1.30.26
#>  [99] cli_3.6.5                   ontologyIndex_2.12
#> [101] rpart_4.1.24                xtable_1.8-4
#> [103] systemfonts_1.3.1           struct_1.22.0
#> [105] processx_3.8.6              jquerylib_0.1.4
#> [107] dichromat_2.0-0.1           Rcpp_1.1.0
#> [109] globals_0.18.0              parallel_4.5.1
#> [111] blob_1.2.4                  ff_4.5.2
#> [113] listenv_0.9.1               viridisLite_0.4.2
#> [115] ipred_0.9-15                scales_1.4.0
#> [117] prodlim_2025.04.28          e1071_1.7-16
#> [119] crayon_1.5.3                clisymbols_1.2.0
#> [121] rlang_1.1.6                 ada_2.0-5
#> [123] cowplot_1.2.0               fastmatch_1.1-6
```

# References

Castellano-Escuder, Pol, Cristina Andrés-Lacueva, and Alex Sánchez-Pla. 2021. *POMA: User-Friendly Workflow for Pre-Processing and Statistical Analysis of Mass Spectrometry Data*. <https://github.com/pcastellanoescuder/POMA>.

Castellano-Escuder, Pol, Raúl González-Domı́nguez, David S Wishart, Cristina Andrés-Lacueva, and Alex Sánchez-Pla. 2020. “FOBI: An Ontology to Represent Food Intake Data and Associate It with Metabolomic Data.” *Database* 2020.

Creixell, Pau, Jüri Reimand, Syed Haider, Guanming Wu, Tatsuhiro Shibata, Miguel Vazquez, Ville Mustonen, et al. 2015. “Pathway and Network Analysis of Cancer Genomes.” *Nature Methods* 12 (7): 615.

Ritchie, Matthew E, Belinda Phipson, Di Wu, Yifang Hu, Charity W Law, Wei Shi, and Gordon K Smyth. 2015. “limma Powers Differential Expression Analyses for RNA-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47. <https://doi.org/10.1093/nar/gkv007>.

Subramanian, Aravind, Pablo Tamayo, Vamsi K Mootha, Sayan Mukherjee, Benjamin L Ebert, Michael A Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proceedings of the National Academy of Sciences* 102 (43): 15545–50.

Sud, Manish, Eoin Fahy, Dawn Cotter, Kenan Azam, Ilango Vadivelu, Charles Burant, Arthur Edison, et al. 2016. “Metabolomics Workbench: An International Repository for Metabolomics Data and Metadata, Metabolite Standards, Protocols, Tutorials and Training, and Analysis Tools.” *Nucleic Acids Research* 44 (D1): D463–D470.

Xia, Jianguo, and David S Wishart. 2010. “MSEA: A Web-Based Tool to Identify Biologically Meaningful Patterns in Quantitative Metabolomic Data.” *Nucleic Acids Research* 38 (suppl\_2): W71–W77.