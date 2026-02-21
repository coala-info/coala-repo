# Use case: Amino Acid Metabolites of Dietary Salt Effects on Blood Pressure in Human Urine

Pol Castellano-Escuder1\*

1Duke University

\*polcaes@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load packages](#load-packages)
* [3 Download the data from Metabolomics Workbench](#download-the-data-from-metabolomics-workbench)
  + [3.1 Sumary of the study (ST000629)](#sumary-of-the-study-st000629)
  + [3.2 Download data](#download-data)
* [4 Prepare features and metadata](#prepare-features-and-metadata)
* [5 Statistical analysis with `POMA`](#statistical-analysis-with-poma)
  + [5.1 Create a `SummarizedExperiment` object](#create-a-summarizedexperiment-object)
  + [5.2 Preprocessing](#preprocessing)
  + [5.3 Limma model](#limma-model)
  + [5.4 Convert metabolite names to KEGG identifiers with `MetaboAnalyst` web server](#convert-metabolite-names-to-kegg-identifiers-with-metaboanalyst-web-server)
* [6 Convert KEGG IDs to FOBI IDs](#convert-kegg-ids-to-fobi-ids)
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

We will also need some additional [CRAN](https://cran.r-project.org) and [Bioconductor](https://bioconductor.org) packages for performing tasks such as statistical analysis.

```
# CRAN
library(tidyverse)
library(ggrepel)
library(kableExtra)

# Bioconductor
library(POMA)
library(metabolomicsWorkbenchR)
library(SummarizedExperiment)
```

# 3 Download the data from Metabolomics Workbench

The Metabolomics Workbench, available at <www.metabolomicsworkbench.org>, is a public repository for metabolomics metadata and experimental data spanning various species and experimental platforms, metabolite standards, metabolite structures, protocols, tutorials, and training material and other educational resources. It provides a computational platform to integrate, analyze, track, deposit and disseminate large volumes of heterogeneous data from a wide variety of metabolomics studies including mass spectrometry (MS) and nuclear magnetic resonance spectrometry (NMR) data spanning over 20 different species covering all the major taxonomic categories including humans and other mammals, plants, insects, invertebrates and microorganisms (Sud et al. [2016](#ref-sud2016metabolomics)).

The `metabolomicsWorkbenchR` Bioconductor package allows us to obtain data from the Metabolomics Workbench repository. In this vignette we will use the sample data set [ST000629](https://www.metabolomicsworkbench.org/data/DRCCMetadata.php?Mode=Study&StudyID=ST000629).

## 3.1 Sumary of the study (ST000629)

The objective of the study is to identify changes of urinary metabolite profiles associated with different responses to blood pressure to salt. Subjects are derived from The Dietary approaches to stop hypertension (DASH) diet, Sodium Intake and Blood Pressure Trial (Sacks FM *et al* PMID: 11136953,N Engl J Med. 2001).We choose two groups subjects who meet the following conditions (the two groups are separately named A and B). We chose subjects on the Control diet. These subjects meet the blood pressure criteria described below:Group A subjects conditions: 1) On Control diet. 2) Normotensive subjects: systolic blood pressure from the low sodium visit is less than 140 and the diastolic blood pressure from low sodium visit is less than 90; 3) For group A: Either the systolic blood pressure from the high sodium visit was greater than 10 mmHg higher than the systolic blood pressure from the low sodium visit, or the diastolic blood pressure from the high sodium visit was greater than 10 mmHg higher than the diastolic blood pressure from the low sodium visit; 3) For group B: The systolic blood pressure from the high sodium visit is within 5 mmHg (i.e. +/- 5) from the systolic blood pressure from the low sodium visit, and the diastolic blood pressure from the high sodium visit is within 5 mmHg from the diastolic blood pressure from the low sodium visit. Use gas chromatography/mass spectrometry (GC/MS) analysis, and liquid chromatography/mass spectrometry (LC/MS) analysis to find the differences of metabolic profiles between the high sodium level and the low sodium level, and compare the metabolic profiles of A with the metabolic profiles of B at the low and high sodium level.

## 3.2 Download data

This study includes compounds analyzed via MS analysis and positive ion mode (AN000961). Let’s download it!

```
data <- do_query(
  context = "study",
  input_item = "analysis_id",
  input_value = "AN000961",
  output_item = "SummarizedExperiment")
```

# 4 Prepare features and metadata

Now we have to prepare the metadata and features in order to proceed with the statistical analysis. In this step we assign to each metabolite its chemical name provided in Metabolomics Workbench.

```
## features
features <- assay(data)
rownames(features) <- rowData(data)$metabolite

## metadata
pdata <- colData(data) %>%
  as.data.frame() %>%
  tibble::rownames_to_column("ID") %>%
  relocate(grouping, .before = Sodium.level) %>%
  mutate(grouping = case_when(grouping == "A(salt sensitive)" ~ "A",
                              grouping == "B(salt insensitive)" ~ "B"))
```

# 5 Statistical analysis with `POMA`

`POMA` provides a structured, reproducible and easy-to-use workflow for the visualization, preprocessing, exploration, and statistical analysis of metabolomics and proteomics data. The main aim of this package is to enable a flexible data cleaning and statistical analysis processes in one comprehensible and user-friendly R package. `POMA` uses the standardized `SummarizedExperiment` data structures, to achieve the maximum flexibility and reproducibility and makes `POMA` compatible with other Bioconductor packages (Castellano-Escuder, Andrés-Lacueva, and Sánchez-Pla [2021](#ref-POMA)).

## 5.1 Create a `SummarizedExperiment` object

First, we create a `SummarizedExperiment` object that integrates both metadata and features in the same data structure.

```
data_sumexp <- PomaCreateObject(metadata = pdata, features = t(features))
```

## 5.2 Preprocessing

Second, we perform the preprocessing step. This step includes the missing value imputation using the \(k\)-NN algorithm and log Pareto normalization (transformation and scaling). Once these steps are completed, we can proceed to the statistical analysis of these data.

```
data_preprocessed <- data_sumexp %>%
  PomaImpute(group_by = "grouping") %>%
  PomaNorm()
```

## 5.3 Limma model

We use a limma model (Ritchie et al. [2015](#ref-limma)) to identify those most significant metabolites between the “**A(salt sensitive)**” and “**B(salt insensitive)**” groups.

```
limma_res <- data_preprocessed %>%
  PomaLimma(contrast = "A-B", adjust = "fdr") %>%
  dplyr::rename(ID = feature)

# show the first 10 features
limma_res %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| ID | log2FC | AveExpr | t | pvalue | adj\_pvalue | B |
| --- | --- | --- | --- | --- | --- | --- |
| Methionine | 0.9795655 | 0 | 4.548993 | 0.0000429 | 0.0008338 | 1.9296634 |
| Leucine | 1.1421439 | 0 | 4.496607 | 0.0000507 | 0.0008338 | 1.7702115 |
| Isoleucine | 0.9304794 | 0 | 4.438771 | 0.0000610 | 0.0008338 | 1.5949155 |
| Serine | 1.2143195 | 0 | 4.039486 | 0.0002142 | 0.0021955 | 0.4087225 |
| Asparagine | 0.8621231 | 0 | 3.676917 | 0.0006451 | 0.0052895 | -0.6250585 |
| Valine | 0.7926840 | 0 | 3.480890 | 0.0011498 | 0.0078573 | -1.1633626 |
| Threonine | 0.6877042 | 0 | 2.954335 | 0.0050404 | 0.0295221 | -2.5231755 |
| Phenylalanine | 0.5811203 | 0 | 2.817394 | 0.0072542 | 0.0371778 | -2.8533955 |
| Glutamine | 0.5367078 | 0 | 2.464353 | 0.0177506 | 0.0808637 | -3.6535500 |
| Homocystine | 0.4294865 | 0 | 2.282725 | 0.0273923 | 0.1123085 | -4.0340283 |

## 5.4 Convert metabolite names to KEGG identifiers with `MetaboAnalyst` web server

In many metabolomics studies, the reproducibility of analyses is severely affected by the poor interoperability of metabolite names and their identifiers. For this reason it is important to develop tools that facilitate the process of converting one type of identifier to another. In order to use the `fobitools` package, we need some generic identifier (such as PubChem, KEGG or HMDB) that allows us to obtain the corresponding FOBI identifier for each metabolite. However, unlike vignette “*Use case ST000291*”, the Metabolomics Workbench repository does not provide us with this information for the metabolites quantified in study [ST000629](https://www.metabolomicsworkbench.org/data/show_metabolites_by_study.php?STUDY_ID=ST000629&SEARCH_TYPE=KNOWN&STUDY_TYPE=MS&RESULT_TYPE=1).

In those cases where we do not have other common identifiers, the authors recommend using the powerful conversion tool provided by [MetaboAnalyst](https://www.metaboanalyst.ca/MetaboAnalyst/upload/ConvertView.xhtml). This tool will allow us to move from the metabolite names to other generic identifiers such as KEGG or HMDB, which will later allow us to obtain the FOBI identifier of these metabolites.

In order to use the MetaboAnalyst ID conversion tool, we can copy the result of the following `cat()` command and paste it directly into MetaboAnalyst (Figure [1](#fig:MAconvertID)).

```
cat(limma_res$ID, sep = "\n")
```

![Metabolite names conversion using MetaboAnalyst.](data:image/png;base64...)

Figure 1: Metabolite names conversion using MetaboAnalyst

Then, we can access to the MetaboAnalyst temporary page that is hosting our results (where the following “*XXXXXXX*” will be your guest URL).

```
ST000629_MetaboAnalyst_MapNames <- readr::read_delim("https://www.metaboanalyst.ca/MetaboAnalyst/resources/users/XXXXXXX/name_map.csv", delim = ",")
```

# 6 Convert KEGG IDs to FOBI IDs

Once we have the results of the statistical analysis and generic identifiers recognized in the FOBI ontology (Castellano-Escuder et al. [2020](#ref-castellano2020fobi)), we can proceed to perform one of the main functions provided by the `fobitools` package, the ID conversion. With the `fobitools::id_convert()` command, users can convert different IDs between FOBI, HMDB, KEGG, PubChem, InChIKey, InChICode, ChemSpider, and chemical names. We will then obtain the FOBI IDs from the KEGG IDs (obtained in the previous section via MetaboAnalyst web server) and add them as a new column to the results of the limma model.

```
annotated_limma <- ST000629_MetaboAnalyst_MapNames %>%
  dplyr::rename(ID = Query) %>%
  dplyr::mutate(ID = tolower(ID)) %>%
  dplyr::right_join(limma_res %>%
                      dplyr::mutate(ID = tolower(ID)),
                    by = "ID")

limma_FOBI_names <- annotated_limma %>%
  dplyr::pull("KEGG") %>%
  fobitools::id_convert(to = "FOBI")

# show the ID conversion results
limma_FOBI_names %>%
  head() %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| FOBI | KEGG |
| --- | --- |
| FOBI:030687 | C00386 |
| FOBI:030709 | C00245 |
| FOBI:030701 | C00078 |
| FOBI:030692 | C00079 |
| FOBI:030697 | C00082 |
| FOBI:030688 | C01262 |

```
limma_FOBI_names <- limma_FOBI_names %>%
  dplyr::right_join(annotated_limma, by = "KEGG") %>%
  dplyr::select(FOBI, KEGG, ID, log2FC, pvalue, adj_pvalue) %>%
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

Here, we perform an ORA with the `fobitools` package, where we will use as a universe all the metabolites of the study present in FOBI and as a list those metabolites with a raw p-value < 0.05 in the limma results table.

```
metaboliteList <- limma_FOBI_names$FOBI[limma_FOBI_names$pvalue < 0.05]
metaboliteUniverse <- limma_FOBI_names$FOBI

fobitools::ora(metaboliteList = metaboliteList,
               metaboliteUniverse = metaboliteUniverse,
               pvalCutoff = 1) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| className | classSize | overlap | pval | padj | overlapMetabolites |
| --- | --- | --- | --- | --- | --- |
| Whole grain cereal products | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| dairy food product | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| egg food product | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| legume food product | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| meat food product | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| nut (whole or part) | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| soybean (whole) | 3 | 1 | 0.5 | 0.7142857 | FOBI:030692 |
| Lean meat | 3 | 0 | 1.0 | 1.0000000 |  |
| Red meat | 2 | 0 | 1.0 | 1.0000000 |  |
| fish | 1 | 0 | 1.0 | 1.0000000 |  |

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
  select(FOBI, pvalue) %>%
  filter(!is.na(FOBI)) %>%
  dplyr::arrange(-dplyr::desc(abs(pvalue)))

FOBI_msea <- as.vector(limma_FOBI_msea$pvalue)
names(FOBI_msea) <- limma_FOBI_msea$FOBI

msea_res <- fobitools::msea(FOBI_msea, pvalCutoff = 1)

msea_res %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| className | classSize | log2err | ES | NES | pval | padj | leadingEdge |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Lean meat | 3 | 0.1938133 | 1.00 | 1.648968 | 0.0529471 | 0.5294705 | FOBI:030…. |
| fish | 1 | 0.0640704 | 0.80 | 1.611603 | 0.3366633 | 1.0000000 | FOBI:030688 |
| Red meat | 2 | 0.0580984 | 0.75 | 1.284063 | 0.3816184 | 1.0000000 | FOBI:030…. |
| Whole grain cereal products | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |
| dairy food product | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |
| egg food product | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |
| legume food product | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |
| meat food product | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |
| nut (whole or part) | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |
| soybean (whole) | 3 | 0.0000000 | 0.00 | 0.000000 | 1.0000000 | 1.0000000 | FOBI:030…. |

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