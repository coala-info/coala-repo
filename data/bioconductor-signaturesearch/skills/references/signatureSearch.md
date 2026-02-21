Code

* Show All Code
* Hide All Code

# *signatureSearch*: Environment for Gene Expression Searching Combined with Functional Enrichment Analysis

#### Authors: Yuzhu Duan, Brendan Gongol, Dan S. Evans, Richard A. Miller, Nicholas J. Schork, Steven R. Cummings and Thomas Girke

#### Last update: 30 October, 2025

# 1 Introduction

## 1.1 Background

The *signatureSearch* package implements algorithms and data structures for performing gene expression signature (GES) searches, and subsequently interpreting the results functionally with specialized enrichment methods (Duan et al. 2020). These utilities are useful for studying the effects of genetic, chemical and environmental perturbations on biological systems. Specifically, in drug discovery they can be used for identifying novel modes of action (MOA) of bioactive compounds from reference databases such as LINCS containing the genome-wide GESs from tens of thousands of drug and genetic perturbations (Subramanian et al. 2017). A typical GES search (GESS) workflow can be divided into two major steps (Figure 1). First, GESS methods are used to identify perturbagens such as drugs that induce GESs similar to a query GES of interest. The queries can be drug-, disease- or phenotype-related GESs. Since the MOAs of most drugs in the corresponding reference databases are known, the resulting associations are useful to gain insights into pharmacological and/or disease mechanisms, and to develop novel drug repurposing approaches. Second, specialized functional enrichment analysis (FEA) methods using annotations systems, such as Gene Ontologies (GO), pathways or Disease Ontologies (DO), have been developed and implemented in this package to efficiently interpret GESS results. The latter are usually composed of lists of perturbagens (*e.g.* drugs) ranked by the similarity metric of the corresponding GESS method. Finally, network reconstruction functionalities are integrated for visualizing the final results, *e.g.* in form of drug-target networks. Figure 1 illustrates the major steps of a typical signature search workflow. For each GESS and FEA step, several alternative methods have been implemented in *signatureSearch* to allow users to choose the best possible workflow configuration for their research application. The individual search and enrichment methods are introduced in the corresponding sections of this vignette.

![](data:image/png;base64...)

**Figure 1:** Overview of GESS and FEA methods. GES queries are used to search a perturbation-based GES reference database for perturbagens such as drugs inducing GESs similar to the query. To interpret the results, the GESS results are subjected to functional enrichment analysis (FEA) including drug set and target set enrichment analyses (DSEA, TSEA). Both identify functional categories (*e.g.* GO terms or KEGG pathways) over-represented in the GESS results. Subsequently, drug-target networks are reconstructed for visualization and interpretation.

## 1.2 Motivation and Design

Integrating the above described GESS and FEA methods into an R/Bioconductor package has several advantages. First, it simplifies the development of automated end-to-end workflows for conducting signature searches for many application areas. Second, it consolidates an extendable number of GESS and FEA algorithms into a single environment that allows users to choose the best selection of methods and parameter settings for a given research question. Third, the usage of generic data objects and classes improves maintainability and reproducibility of the provided functionalities, while the integration with the existing R/Bioconductor ecosystem maximizes their extensibility and reusability for other data analysis applications. Fourth, it provides access to several community perturbation reference databases along with options to build custom databases with support for most common gene expression profiling technologies (*e.g.* microarrays and RNA-Seq).

Figure 2 illustrates the design of the package with respect to its data containers and methods used by the individual signature search workflow steps. Briefly, expression profiles from genome-wide gene expression profiling technologies (*e.g.* RNA-Seq or microarrays) are used to build a reference database stored as HDF5 file. Commonly, a pre-built database can be used here that is provided by the associated *signatureSearchData* package. A search with a query signature against a reference database is initialized by declaring all parameter settings in a *qSig* search object. Users can choose here one of five different search algorithms implemented by *signatureSearch*. The nature of the query signature along with a chosen search method defines the type of expression data used for searching. For instance, a search with a query up/down gene set combined with the LINCS search method will be performed on sorted gene expression scores (see left panel in Figure 1). To minimize memory requirements and improve time performance, large reference databases are searched in batches with user-definable chunk sizes. The search results are stored in a *gessResult* object. The latter contains all information required to be processed by the downstream functional enrichment analysis (FEA) methods, here drug set and target set enrichment analysis (TSEA and DSEA) methods. The obtained functional enrichment results are stored as *feaResult* object that can be passed on to various drug-target network construction and visualization methods implemented in *signatureSearch*.

![](data:image/png;base64...)

**Figure 2:** Design of *signatureSearch*. Gene expression profiles are stored in a reference database (here HDF5 file). Prebuilt databases for community GES collections, such as CMAP2 and LINCS, are provided by the affiliated *signatureSearchData* package. The GESS query parameters are defined in a *qSig* search object where users can choose among over five GESS methods (CMAP, LINCS, gCMAP, Fisher, and various correlation methods). Signature search results are stored in a *gessResult* object that can be functionally annotated with different TSEA (*dup\_hyperG*, *mGSEA*, *mabs*) and DSEA (*hyperG*, *GSEA*) methods. The enrichment results are stored as `feaResult` object that can be used for drug target-networks analysis and visualization.

## 1.3 History of GES Databases

Lamb et al. (2006) generated one of the first GES databases called CMAP. Initially, it included GESs for 164 drugs screened against four mammalian cell lines (Lamb et al. 2006). A few years later CMAP was extended to CMAP2 containing GESs for 1,309 drugs and eight cell lines. More recently, a much larger GES database was released by the Library of Network-Based Cellular Signatures (LINCS) Consortium (Subramanian et al. 2017). In its initial release, the LINCS database contained perturbation-based GESs for 19,811 drugs tested on up to 70 cancer and non-cancer cell lines along with genetic perturbation experiments for several thousand genes. The number of compound dosages and time points considered in the assays has also been increased by 10-20 fold. The CMAP/CMAP2 databases use Affymetrix Gene Chips as expression platform. To scale from a few thousand to many hundred thousand GESs, the LINCS Consortium uses now the more economic L1000 assay. This bead-based technology is a low cost, high-throughput reduced representation expression profiling assay. It measures the expression of 978 landmark genes and 80 control genes by detecting fluorescent intensity of beads after capturing the ligation-mediated amplification products of mRNAs (Peck et al. 2006). The expression of 11,350 additional genes is imputed from the landmark genes by using as training data a collection of 12,063 Affymetrix gene chips (Edgar, Domrachev, and Lash 2002). The substantial scale-up of the LINCS project provides now many new opportunities to explore MOAs for a large number of known drugs and experimental drug-like small molecules. In 2020, the LINCS 2017 database is expanded to the beta release, here refer to as LINCS2. It contains >80k perturbations and >200 cell lines and over 3M gene expression profiles. This represents roughly a 3-fold expansion on the LINCS 2017 database. The datasets can be accessed at <https://clue.io/releases/data-dashboard>.

## 1.4 Terminology

In the following text the term Gene Expression Signatures (GESs) can be composed of gene sets (GSs), such as the identifier sets of differentially expressed genes (DEGs), or various types of quantitative gene expression profiles (GEPs) for a subset or all genes measured by a gene expression profiling technology. Some publications refer with the term GES mainly to GSs, or use as extended terminology “qualitative and quantitative GESs” (Chang et al. 2011). For clarity and consistency, this vignette defines GES as a generic term that comprises both GSs and GEPs (Lamb et al. 2006). This generalization is important, because several GESS algorithms are introduced here that depend on reference databases containing GSs in some and GEPs in the majority of cases generated with various statistical methods. To also distinguish the queries (Q) from the entries in the reference databases (DB), they will be referred to as GES-Q and GES-DB entries in general descriptions, and as GS-Q or GEP-Q, and as GS-DB or GEP-DB in specific cases, respectively.

Depending on the extent the expression data have been pre-processed, the following distinguishes four major levels, where the first three and fourth belong into the GEP and GS categories, respectively. These four levels are: (1) normalized intensity or count values from hybridization- and sequencing-based technologies, respectively; (2) log fold changes (LFC) usually with base 2, Z-scores or p-values obtained from analysis routines of DEGs; (3) rank transformed versions of the GEPs obtained from the results of level 1 or 2; and (4) GSs extracted from the highest and lowest ranks under level 3. Typically, the corresponding GSs are the most up- or down-regulated DEGs observed among two biological states, such as comparisons among untreated *vs.* drug treatment or disease state. The order the DEG identifier labels are stored may reflect their ranks or have no meaning. When unclear, the text specifies which of the four pre-processing levels were used along with additional relevant details.

# 2 Getting Started

## 2.1 Package Install

As Bioconductor package `signatureSearch` can be installed with the `BiocManager::install()` function.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("signatureSearch")
BiocManager::install("girke-lab/signatureSearch", build_vignettes=FALSE)  # Installs from github
```

Next the package needs to be loaded into a user’s R session.

```
library(signatureSearch)
```

The following lists essential help files and opens the vignette of the package.

```
library(help="signatureSearch")  # Lists package info
browseVignettes("signatureSearch")  # Opens vignette
```

## 2.2 Reference Databases

The helper package *signatureSearchData* provides access to pre-built GES databases, including CMAP2, LINCS and LINCS2, that are stored on Bioconductor’s `ExperimentHub` as HDF5 files. Users can download these databases as follows.

```
library(ExperimentHub); library(rhdf5)
eh <- ExperimentHub()
cmap <- eh[["EH3223"]]; cmap_expr <- eh[["EH3224"]]
lincs <- eh[["EH3226"]]; lincs_expr <- eh[["EH3227"]]
lincs2 <- eh[["EH7297"]]
h5ls(lincs2)
```

This will store the paths to the downloaded database files in the corresponding variables. The reference databases store the following information: (1) `lincs` contains moderated z-scores from differential expression (DE) analysis of 12,328 genes from 8,140 compound treatments of 30 cell lines corresponding to a total of 45,956 signatures; (2) `lincs_expr` contains gene expression intensity values from 5,925 compound treatments of 30 cell lines corresponding to a total of 38,824 signatures; (3) `cmap` contains \(log\_2\) fold changes of 12,437 genes from 1,281 compound treatments of 5 cell lines corresponding to a total of 3,478 signatures; (4) `cmap_expr` contains mean expression values from 1,309 drug treatments of 4 cell lines corresponding to a total of 3,587 signatures. To minimize redundancy in the `lincs` and `lincs_expr` databases, they were assembled from GESs corresponding to a compound dosage and treatment time of 10\(\mu\)M and 24h, respectively. If necessary one can create here easily database instances for all LINCS measurements. However, this will make the search results overwhelmingly complex which we wanted to avoid here; (5) `lincs2` contains moderated z-scores from DE analysis of 12,328 genes from 30,456 compound treatments of 58 cell lines corresponding to a total of 136,460 signatures. To minimize redundancy of perturbagens having many signatures in different dosage and treatment time within the same cell line, the ‘exemplar’ signature for each perturbagen in each cell line was assembled. These signatures are annotated from CLUE group and are generally picked based on TAS (Transcriptional Activity Score), such that the signature with the highest TAS is chosen as exemplar. The LINCS2 database is exactly the same as the reference database used for the Query Tool in CLUE website.

For details how the CMAP2, LINCS and LINCS2 databases were constructed, please refer to the vignette of the `signatureSearchData` package. The command `browseVignettes("signatureSearchData")` will open this vignette from R.

Custom databases can be built with the `build_custom_db` function. Here the user provides custom genome-wide gene expression data (*e.g.* for drug, disease or genetic perturbations) in a `data.frame` or `matrix`. The gene expression data can be most types of the pre-processed gene expression values described under section 1.4.

# 3 Signature Searches (GESS)

This tutorial section introduces the GESS algorithms implemented in *signatureSearch*. Currently, this includes five search algorithms, while additional ones will be added in the future. Based on the data types represented in the query and database, they can be classified into set- and correlation-based methods (see Figure 1). The first 4 methods described below are set-based, whereas the last one is a correlation-based method. We refer to a search method as set-based if at least one of the two data components (query and/or database) is composed of an identifier set (*e.g.* gene labels) that may be ranked or unranked. In contrast to this, correlation-based methods require quantitative values, usually of the same type such as normalized intensities, for both the query and the database entries. An advantage of the set-based methods is that their queries can be the highest and lowest ranking gene sets derived from a genome-wide profiling technology that may differ from the one used to generate the reference database. However, the precision of correlation methods often outperforms set-based methods. On the other hand, due to the nature of the expected input, correlation-based methods are usually only an option when both the query and database entries are based on the same or at least comparable technologies. In other words, set-based methods are more technology agnostic than correlation-based methods, but may not provide the best precision performance.

## 3.1 Test Query and Database

To minimize the run time of the following test code, a small toy database has been assembled from the LINCS database containing a total of 100 GESs from human SKB (muscle) cells. Of the 100 GESs in this toy database, 95 were random sampled and 5 were cherry-picked. The latter five are GESs from HDAC inhibitor treatments including the known drugs: vorinostat, rhamnetin, trichostatin A, pyroxamide, and HC toxin. To further reduce the size of the toy database, the number of its genes was reduced from 12,328 to 5,000 by random sampling. The query signature used in the sample code below is the vorinostat GES drawn from the toy database. For simplicity and to minimize the build time of this vignette, the following sample code uses a pre-generated instance of this toy database stored under the `extdata` directory of this package. The detailed code for generating the toy database and other custom instances of the LINCS database is given in the Supplementary Material section of this vignette.

The following imports the toy GES database into a `SummarizedExperiment` container (here `sample_db`). In addition, the test query set of up/down DEGs (here `upset` and `downset`) is extracted from the vorinostat GES entry in the database.

```
db_path <- system.file("extdata", "sample_db.h5", package = "signatureSearch")
# Load sample_db as `SummarizedExperiment` object
library(SummarizedExperiment); library(HDF5Array)
sample_db <- SummarizedExperiment(HDF5Array(db_path, name="assay"))
rownames(sample_db) <- HDF5Array(db_path, name="rownames")
colnames(sample_db) <- HDF5Array(db_path, name="colnames")
# get "vorinostat__SKB__trt_cp" signature drawn from toy database
query_mat <- as.matrix(assay(sample_db[,"vorinostat__SKB__trt_cp"]))
query <- as.numeric(query_mat); names(query) <- rownames(query_mat)
upset <- head(names(query[order(-query)]), 150)
head(upset)
```

```
## [1] "230"  "5357" "2015" "2542" "1759" "6195"
```

```
downset <- tail(names(query[order(-query)]), 150)
head(downset)
```

```
## [1] "22864" "9338"  "54793" "10384" "27000" "10161"
```

## 3.2 CMAP Search Method

Lamb et al. (2006) introduced the gene expression-based search method known as Connectivity Map (CMap) where a GES database is searched with a query GES for similar entries (Lamb et al. 2006). Specifically, the GESS method from Lamb et al. (2006), here termed as *CMAP*, uses as query the two label sets of the most up- and down-regulated genes from a genome-wide expression experiment, while the reference database is composed of rank transformed expression profiles (*e.g.* ranks of LFC or z-scores). The actual GESS algorithm is based on a vectorized rank difference calculation. The resulting Connectivity Score expresses to what degree the query up/down gene sets are enriched on the top and bottom of the database entries, respectively. The search results are a list of perturbagens such as drugs that induce similar or opposing GESs as the query. Similar GESs suggest similar physiological effects of the corresponding perturbagens. As discussed in the introduction, these GES associations can be useful to uncover novel MOAs of drugs or treatments for diseases. Although several variants of the *CMAP* algorithm are available in other software packages including Bioconductor, the implementation provided by `signatureSearch` follows the original description of the authors as closely as possible. This allows to reproduce in our tests the search results from the corresponding CMAP2 web service of the Broad Institute.

In the following code block, the `qSig` function is used to generate a `qSig` object by defining (i) the query signature, (ii) the GESS method and (iii) the path to the reference database. Next, the query signature is used to search the reference database with the chosen GESS method. The type of the query signature and the reference database needs to meet the requirement of the search algorithm. In the chosen example the GESS method is *CMAP*, where the query signature needs to be the labels of up and down regulated genes, and the reference database contains rank transformed genome-wide expression profiles. Alternatively, the database can contain the genome-wide profiles themselves. In this case they will be transformed to gene ranks during the search. Note, in the given example the `db_path` variable stores the path to the toy database containing 100 GESs composed of z-scores.

```
qsig_cmap <- qSig(query = list(upset=upset, downset=downset),
                  gess_method="CMAP", refdb=db_path)
```

```
## 150 / 150 genes in up set share identifiers with reference database
```

```
## 150 / 150 genes in down set share identifiers with reference database
```

```
cmap <- gess_cmap(qSig=qsig_cmap, chunk_size=5000, workers=1, addAnnotations = TRUE)
result(cmap)
```

```
## # A tibble: 100 × 11
##    pert      cell  type  trend raw_score scaled_score N_upset N_downset t_gn_sym
##    <chr>     <chr> <chr> <chr>     <dbl>        <dbl>   <int>     <int> <chr>
##  1 vorinost… SKB   trt_… up        1.94         1         150       150 HDAC1; …
##  2 rescinna… SKB   trt_… down     -0.295       -1         150       150 ACE
##  3 zuclopen… SKB   trt_… down     -0.287       -0.972     150       150 ADRA1A;…
##  4 evoxine   SKB   trt_… down     -0.244       -0.828     150       150 <NA>
##  5 scouleri… SKB   trt_… down     -0.242       -0.821     150       150 ADRA1D
##  6 ganglios… SKB   trt_… down     -0.239       -0.809     150       150 <NA>
##  7 warfarin  SKB   trt_… down     -0.234       -0.794     150       150 ARSE; C…
##  8 trichost… SKB   trt_… up        1.50         0.775     150       150 HDAC1; …
##  9 endecaph… SKB   trt_… down     -0.224       -0.760     150       150 <NA>
## 10 HC-toxin  SKB   trt_… up        1.44         0.745     150       150 HDAC1
## # ℹ 90 more rows
## # ℹ 2 more variables: MOAss <chr>, PCIDss <chr>
```

The search result is stored in a `gessResult` object (here named `cmap`) containing the following components: search result table, query signature, name of the GESS method and path to the reference database. The `result` accessor function can be used to extract the search result table from the `gessResult` object. This table contains the search results for each perturbagen (here drugs) in the reference database ranked by their signature similarity to the query. For the *CMAP* method, the similarity metrics are `raw_score` and `scaled_score`. The raw score represents the bi-directional enrichment score (Kolmogorov-Smirnov statistic) for a given up/down query signature. Under the `scaled_score` column, the `raw_score` has been scaled to values from 1 to -1 by dividing positive scores and negative scores with the maximum positive score and the absolute value of the minimum negative score, respectively. The remaining columns in the search result table contain the following information. `pert`: name of perturbagen (*e.g.* drug) in the reference database; `cell`: acronym of cell type; `type`: perturbation type, *e.g.* compound treatment is `trt_cp`; `trend`: up or down when reference signature is positively or negatively connected with the query signature, respectively; `N_upset` or `N_downset`: number of genes in the query up or down sets, respectively; `t_gn_sym`: gene symbols of the corresponding drug targets.

## 3.3 LINCS Search Method

Subramanian et al. (2017) introduced a more complex GESS algorithm, here referred to as *LINCS*. While related to *CMAP*, there are several important differences among the two approaches. First, *LINCS* weights the query genes based on the corresponding differential expression scores of the GEPs in the reference database (*e.g.* LFC or z-scores). Thus, the reference database used by *LINCS* needs to store the actual score values rather than their ranks. Another relevant difference is that the *LINCS* algorithm uses a bi-directional weighted Kolmogorov-Smirnov enrichment statistic (ES) as similarity metric. To the best of our knowledge, the `LINCS` search functionality in `signatureSearch` provides the first downloadable standalone software implementation of this algorithm.

In the following example the `qSig` object for the *LINCS* method is initialized the same way as the corresponding *CMAP* object above with the exception that “LINCS” needs to be specified under the `gess_method` argument.

```
qsig_lincs <- qSig(query=list(upset=upset, downset=downset),
                   gess_method="LINCS", refdb=db_path)
```

```
## 150 / 150 genes in up set share identifiers with reference database
```

```
## 150 / 150 genes in down set share identifiers with reference database
```

```
lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=FALSE, workers=1,
                    addAnnotations = TRUE, GeneType = "reference")
result(lincs)
```

```
## # A tibble: 100 × 14
##    pert          cell  type  trend   WTCS WTCS_Pval WTCS_FDR   NCS NCSct N_upset
##    <chr>         <chr> <chr> <chr>  <dbl>     <dbl>    <dbl> <dbl> <dbl>   <int>
##  1 vorinostat    SKB   trt_… up     1       0       0         2.57  2.57     150
##  2 trichostatin… SKB   trt_… up     0.863   5.96e-6 0.000180  2.22  2.22     150
##  3 HC-toxin      SKB   trt_… up     0.857   6.22e-6 0.000180  2.20  2.20     150
##  4 pyroxamide    SKB   trt_… up     0.625   1.63e-5 0.000180  1.60  1.60     150
##  5 zuclopenthix… SKB   trt_… down  -0.321   8.29e-5 0.000319 -1.19 -1.19     150
##  6 rescinnamine  SKB   trt_… down  -0.319   9.60e-5 0.000356 -1.18 -1.18     150
##  7 APHA-compoun… SKB   trt_… up     0.445   2.42e-5 0.000180  1.14  1.14     150
##  8 epothilone    SKB   trt_… down  -0.308   2.40e-4 0.000801 -1.14 -1.14     150
##  9 scopolamine-… SKB   trt_… up     0.416   2.54e-5 0.000180  1.07  1.07     150
## 10 I-070759      SKB   trt_… up     0.408   2.58e-5 0.000180  1.05  1.05     150
## # ℹ 90 more rows
## # ℹ 4 more variables: N_downset <int>, t_gn_sym <chr>, MOAss <chr>,
## #   PCIDss <chr>
```

The `gess_*` functions also support appending the compound annotation table (if provided) to the GESS result for the `pert` column (`pert_id` column if `refdb` is set as `lincs2`) that stores compounds in the `drug` slot of `<drug>__<cell>__<factor>` format of treatments in the reference database. The following uses LINCS method searching against the newest LINCS2 database and passing the LINCS2 compound information table as an example.

```
data("lincs_pert_info2")
qsig_lincs2 <- qSig(query=list(upset=upset, downset=downset),
                   gess_method="LINCS", refdb="lincs2")
# When the compound annotation table is not provided
lincs2 <- gess_lincs(qsig_lincs2, tau=FALSE, sortby="NCS", workers=2)
# When the compound annotation table is provided
lincs2 <- gess_lincs(qsig_lincs2, tau=TRUE, sortby="NCS", workers=1,
                     cmp_annot_tb=lincs_pert_info2, by="pert_id",
                     cmp_name_col="pert_iname") # takes about 15 minutes
result(lincs2) %>% print(width=Inf)
```

The search results are stored in a `gessResult` object as under the *CMAP* example above. The similarity scores stored in the *LINCS* result table are summarized here. `WTCS`: Weighted Connectivity Score; `WTCS_Pval`: nominal p-value of WTCS; `WTCS_FDR`: false discovery rate of `WTCS_Pval`; `NCS`: normalized connectivity score; `NCSct`: NCS summarized across cell types; `Tau`: enrichment score standardized for a given database. The latter is only included in the result table if `tau=TRUE` in a `gess_lincs` function call. The example given is run with `tau=FALSE`, because the tau values are only meaningful when the complete LINCS database is used which is not the case for the toy database. `TauRefSize`: size of reference perturbations for computing Tau.

The following provides a more detailed description of the similarity scores computed by the *LINCS* method. Additional details are available in the Supplementary Material Section of the Subramanian et al. (2017) paper.

`WTCS`: The Weighted Connectivity Score is a bi-directional ES for an up/down query set. If the ES values of an up set and a down set are of different signs, then WTCS is (ESup-ESdown)/2, otherwise, it is 0. WTCS values range from -1 to 1. They are positive or negative for signatures that are positively or inversely related, respectively, and close to zero for signatures that are unrelated.

`WTCS_Pval` and `WTCS_FDR`: The nominal p-value of the WTCS and the corresponding false discovery rate (FDR) are computed by comparing the WTCS against a null distribution of WTCS values obtained from a large number of random queries (*e.g.* 1000).

`NCS`: To make connectivity scores comparable across cell types and perturbation types, the scores are normalized. Given a vector of \(WTCS\) values \(w\) resulting from a query, the values are normalized within each cell line \(c\) and perturbagen type \(t\) to obtain the Normalized Connectivity Score (\(NCS\)) by dividing the \(WTCS\) value by the signed mean of the \(WTCS\) values within the subset of signatures in the reference database corresponding to \(c\) and \(t\).

`NCSct`: The NCS is summarized across cell types as follows. Given a vector of \(NCS\) values for perturbagen \(p\), relative to query \(q\), across all cell lines \(c\) in which \(p\) was profiled, a cell-summarized connectivity score is obtained using a maximum quantile statistic. It compares the 67 and 33 quantiles of \(NCSp,c\) and retains whichever is of higher absolute magnitude.

`Tau`: The standardized score Tau compares an observed \(NCS\) to a large set of \(NCS\) values that have been pre-computed for a specific reference database. The query results are scored with Tau as a standardized measure ranging from 100 to -100. A Tau of 90 indicates that only 10% of reference perturbations exhibit stronger connectivity to the query. This way one can make more meaningful comparisons across query results.

## 3.4 gCMAP Search Method

The Bioconductor *gCMAP* (Sandmann et al. 2014) package provides access to a related but not identical implementation of the original *CMAP* algorithm proposed by Lamb et al. (2006). It uses as query a rank transformed GEP and the reference database is composed of the labels of up and down regulated DEG sets. This is the opposite situation of the *CMAP* method, where the query is composed of the labels of up and down regulated DEGs and the database contains rank transformed GESs.

In case of the *gCMAP* GESS method, the GEP-Q is a matrix with a single column representing gene ranks from a biological state of interest, here vorinostat treatment in SKB cells. The corresponding gene labels are stored in the row name slot of the matrix. Instead of ranks one can provide scores (*e.g.* z-scores) as in the example given below. In such a case the scores will be internally transformed to ranks. The reference database consists of gene label sets that were extracted from the toy databases by applying a `higher` and `lower` filter, here set to `1` and `-1`, respectively.

```
qsig_gcmap <- qSig(query = query_mat, gess_method = "gCMAP", refdb = db_path)
gcmap <- gess_gcmap(qsig_gcmap, higher=1, lower=-1, workers=1, addAnnotations = TRUE)
result(gcmap)
```

```
## # A tibble: 100 × 11
##    pert       cell  type  trend effect  nSet nFound signed t_gn_sym MOAss PCIDss
##    <chr>      <chr> <chr> <chr>  <dbl> <dbl>  <dbl> <lgl>  <chr>    <chr> <chr>
##  1 vorinostat SKB   trt_… up     1      1098   1098 TRUE   HDAC1; … HDAC… 5311
##  2 warfarin   SKB   trt_… down  -1       114    114 TRUE   ARSE; C… Vita… 54678…
##  3 D-609      SKB   trt_… down  -0.715   125    125 TRUE   <NA>     <NA>  45479…
##  4 TC-2559    SKB   trt_… down  -0.685   377    377 TRUE   CHRNA4   Acet… 98231…
##  5 rescinnam… SKB   trt_… down  -0.609   726    726 TRUE   ACE      ACE … 52809…
##  6 amiodarone SKB   trt_… down  -0.584   706    706 TRUE   ABCG2; … Pota… 2157
##  7 trichosta… SKB   trt_… up     0.576  1430   1430 TRUE   HDAC1; … CDK … 444732
##  8 zuclopent… SKB   trt_… down  -0.554   483    483 TRUE   ADRA1A;… Dopa… 53115…
##  9 progester… SKB   trt_… down  -0.553   242    242 TRUE   AKR1C1;… Prog… 5994
## 10 evoxine    SKB   trt_… down  -0.533   461    461 TRUE   <NA>     Furo… 673465
## # ℹ 90 more rows
```

As in the other search methods, the *gCMAP* results are stored in a `gessResult` object. The columns in the corresponding search result table, that are specific to the *gCMAP* method, contain the following information. `effect`: scaled bi-directional enrichment score corresponding to the `scaled_score` under the *CMAP* result; `nSet`: number of genes in the reference gene sets after applying the higher and lower cutoff; `nFound`: number of genes in the reference gene sets that are present in the query signature; `signed`: whether the gene sets in the reference database have signs, *e.g.* representing up and down regulated genes when computing scores.

## 3.5 Fisher Search Method

Fisher’s exact test (Graham J. G. Upton 1992) can also be used to search a GS-DB for entries that are similar to a GS-Q. In this case both the query and the database are composed of gene label sets, such as DEG sets.

In the following example, both the `query` and the `refdb` used under the `qSig` call are genome-wide GEPs, here z-scores. The actual gene sets required for the Fisher’s exact test are obtained by setting the `higher` and `lower` cutoffs to 1 and -1, respectively.

```
qsig_fisher <- qSig(query = query_mat, gess_method = "Fisher", refdb = db_path)
fisher <- gess_fisher(qSig=qsig_fisher, higher=1, lower=-1, workers=1, addAnnotations = TRUE)
result(fisher)
```

```
## # A tibble: 100 × 14
##    pert        cell  type  trend      pval      padj effect     LOR  nSet nFound
##    <chr>       <chr> <chr> <chr>     <dbl>     <dbl>  <dbl>   <dbl> <dbl>  <dbl>
##  1 vorinostat  SKB   trt_… over  0         0          37.5  Inf      1098   1098
##  2 trichostat… SKB   trt_… over  2.81e-177 1.41e-175  28.4    2.06   1430    705
##  3 HC-toxin    SKB   trt_… over  1.73e-132 5.77e-131  24.5    1.74   1804    746
##  4 SPB02303    SKB   trt_… under 3.18e- 25 7.94e- 24 -10.4   -1.05    963     99
##  5 MDL-28170   SKB   trt_… under 2.67e- 24 5.33e- 23 -10.2   -0.767  1823    260
##  6 clofibric-… SKB   trt_… under 2.10e- 19 3.49e- 18  -9.01  -0.660  1943    300
##  7 pyroxamide  SKB   trt_… over  2.27e- 16 3.24e- 15   8.21   0.770   641    225
##  8 TUL-XX023   SKB   trt_… under 3.03e- 13 3.79e- 12  -7.29  -0.731   885    116
##  9 formoterol  SKB   trt_… under 1.68e- 12 1.87e- 11  -7.06  -0.496  2238    389
## 10 I-070759    SKB   trt_… over  2.18e- 12 2.18e- 11   7.02   0.537  1222    359
## # ℹ 90 more rows
## # ℹ 4 more variables: signed <lgl>, t_gn_sym <chr>, MOAss <chr>, PCIDss <chr>
```

The columns in the result table specific to the *Fisher* method include the following information. `pval`: p-value of the Fisher’s exact test; `padj`: p-value adjusted for multiple hypothesis testing using R’s `p.adjust` function with the Benjamini & Hochberg (BH) method; `effect`: z-score based on the standard normal distribution; `LOR`: log odds ratio.

If the `query` contains the labels of up and down regulated genes then the two sets can be provided as a list. Internally, they will be combined into a single unsigned set, while the reference database is processed the same way as in the previous example.

```
qsig_fisher2 <- qSig(query = list(upset=upset, downset=downset),
                     gess_method = "Fisher", refdb = db_path)
fisher2 <- gess_fisher(qSig=qsig_fisher2, higher=1, lower=-1, workers=1, addAnnotations = TRUE)
result(fisher2)
```

## 3.6 Correlation-based Search Method

Correlation-based similarity metrics, such as Spearman or Pearson coefficients, can also be used as GESS methods. As non-set-based methods, they require quantitative gene expression values for both the query and the database entries, that usually need to be of the same type to obtain meaningful results, such as normalized intensities or read counts from microarrays or RNA-Seq experiments, respectively. For correlation searches to work, it is important that both the query and reference database contain the same type of gene identifiers. The expected data structure of the query is a matrix with a single numeric column and the gene labels (*e.g.* Entrez Gene IDs) in the row name slot. For convenience, the correlation-based searches can either be performed with the full set of genes represented in the database or a subset of them. The latter can be useful to focus the computation for the correlation values on certain genes of interest such as a DEG set or the genes in a pathway of interest. For comparing the performance of different GESS methods, it can also be advantageous to subset the genes used for a correlation-based search to same set used in a set-based search, such as the up/down DEGs used in a *LINCS* GESS. This way the search results of correlation- and set-based methods can be more comparable because both are provided with equivalent information content.

### 3.6.1 CORall

The following example runs a correlation-based search with the Spearman method using all genes present in the reference database. The GESs used for both the `query` and `refdb` are z-scores. The `gess_cor` function also supports Pearson and Kendall correlation coefficients by assigning the corresponding names to the `method` argument. For details, users want to consult the help file of the `gess_cor` function.

```
qsig_sp <- qSig(query=query_mat, gess_method="Cor", refdb=db_path)
sp <- gess_cor(qSig=qsig_sp, method="spearman", workers=1, addAnnotations = TRUE)
result(sp)
```

```
## # A tibble: 100 × 8
##    pert                cell  type   trend cor_score t_gn_sym        MOAss PCIDss
##    <chr>               <chr> <chr>  <chr>     <dbl> <chr>           <chr> <chr>
##  1 vorinostat          SKB   trt_cp up        1     HDAC1; HDAC10;… HDAC… 5311
##  2 trichostatin-a      SKB   trt_cp up        0.702 HDAC1; HDAC10;… CDK … 444732
##  3 HC-toxin            SKB   trt_cp up        0.634 HDAC1           HDAC… 3571
##  4 pyroxamide          SKB   trt_cp up        0.325 HDAC1; HDAC3; … HDAC… 4996
##  5 APHA-compound-8     SKB   trt_cp up        0.152 HDAC8           HDAC… 10379…
##  6 benzonatate         SKB   trt_cp up        0.151 SCN5A           Loca… 7699
##  7 rescinnamine        SKB   trt_cp down     -0.136 ACE             ACE … 52809…
##  8 evoxine             SKB   trt_cp down     -0.134 <NA>            Furo… 673465
##  9 scopolamine-n-oxide SKB   trt_cp up        0.125 <NA>            <NA>  30006…
## 10 warfarin            SKB   trt_cp down     -0.123 ARSE; CYP2C8; … Vita… 54678…
## # ℹ 90 more rows
```

The column specific to the correlation-based search methods contains the following information. `cor_score`: correlation coefficient based on the method defined in the `gess_cor` function call.

### 3.6.2 CORsub

To perform a correlation-based search on a subset of genes represented in the database, one can simply provide the chosen gene subset in the query. During the search the database entries will be subsetted to the genes provided in the query signature. The given example uses a query GES that is subsetted to the genes with the 150 highest and lowest z-scores.

```
# Subset z-scores of 150 up and down gene sets from
# "vorinostat__SKB__trt_cp" signature.
query_mat_sub <- as.matrix(query_mat[c(upset, downset),])
qsig_spsub <- qSig(query = query_mat_sub, gess_method = "Cor", refdb = db_path)
spsub <- gess_cor(qSig=qsig_spsub, method="spearman", workers=1, addAnnotations = TRUE)
result(spsub)
```

```
## # A tibble: 100 × 8
##    pert                cell  type   trend cor_score t_gn_sym        MOAss PCIDss
##    <chr>               <chr> <chr>  <chr>     <dbl> <chr>           <chr> <chr>
##  1 vorinostat          SKB   trt_cp up        1     HDAC1; HDAC10;… HDAC… 5311
##  2 trichostatin-a      SKB   trt_cp up        0.885 HDAC1; HDAC10;… CDK … 444732
##  3 HC-toxin            SKB   trt_cp up        0.856 HDAC1           HDAC… 3571
##  4 pyroxamide          SKB   trt_cp up        0.646 HDAC1; HDAC3; … HDAC… 4996
##  5 APHA-compound-8     SKB   trt_cp up        0.442 HDAC8           HDAC… 10379…
##  6 benzonatate         SKB   trt_cp up        0.333 SCN5A           Loca… 7699
##  7 MD-040              SKB   trt_cp up        0.307 <NA>            <NA>  73707…
##  8 K784-3187           SKB   trt_cp up        0.297 <NA>            <NA>  36894…
##  9 scopolamine-n-oxide SKB   trt_cp up        0.297 <NA>            <NA>  30006…
## 10 fasudil             SKB   trt_cp up        0.288 CDC42BPB; MYLK… Rho … 3547
## # ℹ 90 more rows
```

## 3.7 Summary of Search Results

Although the toy database is artificially small, one can use the above search results for a preliminary performance assessment of the different GESS methods in ranking drugs based on known modes of action (MOA). Four of the five cherry-picked HDAC inhibitors (vorinostat, trichostatin-a, HC-toxin, pyroxamide) were ranked among the top 10 ranking drugs in the search results of the LINCS, Fisher and Spearman correlation methods. If generalizable, this result implies a promising performance of these search methods for grouping drugs by their MOA categories. In addition, the LINCS and Spearman methods were able to rank another HDAC inhibitor, APHA-compound-8, at the top of their search results, indicating a better sensitivity of these two methods compared to the other methods.

## 3.8 GESS Result Visualization

The `gess_res_vis` function allows to summarize the ranking scores of selected perturbagens for GESS results across cell types along with cell type classifications, such as normal and tumor cells. In the following plot (Figure 3) the perturbagens are drugs (along x-axis) and the ranking scores are LINCS’ NCS values (y-axis). For each drug the NCS values are plotted for each cell type as differently colored dots, while their shape indicates the cell type class. Note, the code for generating the plot is not evaluated here since the toy database used by this vignette contains only treatments for one cell type (here SKB cells). This would result in a not very informative plot. To illustrate the full potential of the `gess_res_vis` function, the following code section applies to a search where the `vorinostat` signature was used to query with the `gess_lincs` method the full LINCS database. Subsequently, the search result is processed by the `gess_res_vis` function to generate the plot shown in Figure 3.

```
vor_qsig_full <- qSig(query = list(upset=upset, downset=downset),
                   gess_method="LINCS", refdb="lincs")
vori_res_full <- gess_lincs(qSig=vor_qsig_full, sortby="NCS", tau=TRUE)
vori_tb <- result(vori_res_full)
drugs_top10 <- unique(result(lincs)$pert)[1:10]
drugs_hdac <- c("panobinostat","mocetinostat","ISOX","scriptaid","entinostat",
      "belinostat","HDAC3-selective","tubastatin-a","tacedinaline","depudecin")
drugs = c(drugs_top10, drugs_hdac)
gess_res_vis(vori_tb, drugs = drugs, col = "NCS")
```

![](data:image/png;base64...)

Figure 3: Summary of NCS scores across cell types (y-axis) for selected drugs (x-axis). The plot shown here is based on a search result where the vorinostat signature was used to query the entire LINCS database with the `gess_lincs` method. The drugs included here are the 10 top ranking drugs of the search result plus 10 cherry-picked drugs that are all HDAC inhibitors. Additional details are provided in the text of this sub-section.

The `cellNtestPlot` function allows to summarize the number of perturbagens tested in cell types along with cell type primary site information, such as blood or muscle. The following bar plot (Figure 4) show the number of tested compounds (along x-axis) in 30 cell types (y-axis), the text in the strips show the primary sites of cells in the LINCS database.

```
# cellNtestPlot(refdb="lincs")
# ggsave("vignettes/images/lincs_cell_ntest.png", width=6, height=8)
knitr::include_graphics("images/lincs_cell_ntest.png")
```

![](data:image/png;base64...)

Figure 4: Number of tested compounds (along x-axis) in 30 cell types (y-axis) in LINCS database. The text in the strips show the primary sites of cells.

The following table shows the LINCS cell information

```
data("cell_info")
library(DT)
datatable(cell_info)
```

## 3.9 Batch Processing of GESSs

The above 5 GESS methods support searching reference database parallelly by defining the `workers` parameter, the default is 1. It means that when submitting one query, the parallelization happens on the GES database level where one splits up a single query process into searching several chunks of the database in parallel. Multiple GES queries can also be processed sequentially or in parallel mode. Parallel evaluations can substantially reduce processing times. The parallelization techniques covered in this vignette, are based on utilities of the `BiocParallel` and `batchtools` packages. For demonstration purposes the following example uses a small batch query containing several GESs. First, this batch query is processed sequentially without any parallelization using a simple `lapply` loop. Next, the same query is processed in parallel mode using multiple CPU cores of a single machine. The third option demonstrates how this query can be processed in parallel mode on multiple machines of a computer cluster with a workload management (queueing) system (*e.g.* Slurm or Torque).

### 3.9.1 Sequential Processing

The following processes a small toy batch query with the `LINCS` method sequentially in an `lapply` loop. The object `batch_queries` is a list containing the two sample GESs `q1` and `q2` that are composed of entrez gene identifiers. The search results are written to tab-delimited tabular files under a directory called `batch_res`. The name and path of this directory can be changed as needed.

```
library(readr)
batch_queries <- list(q1=list(upset=c("23645", "5290"), downset=c("54957", "2767")),
                      q2=list(upset=c("27101","65083"), downset=c("5813", "84")))
refdb <- system.file("extdata", "sample_db.h5", package="signatureSearch")
gess_list <- lapply(seq_along(batch_queries), function(i){
    qsig_lincs <- qSig(query = batch_queries[[i]],
                   gess_method="LINCS", refdb=refdb)
    lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=TRUE)
    if(!dir.exists("batch_res")){
        dir.create("batch_res")
    }
    write_tsv(result(lincs), paste0("batch_res/lincs_res_", i, ".tsv"))
    return(result(lincs))
})
```

### 3.9.2 Parallelization with Multiple CPU Cores

The GESSs from the previous example can be accelerated by taking advantage of multiple CPU cores available on a single computer system. The parallel evaluation happens in the below `bplapply` loop defined by the `BiocParallel` package. For this approach, all processing instructions are encapsulated in a function named `f_bp` that will be executed in the `bplapply` loop. As before, the search results are written to tab-delimited tabular files under a directory called `batch_res`. The name and path of this directory can be changed as needed. For more background information on this and the following parallelization options, users want to consult the vignette of the `BiocParallel` package.

```
library(BiocParallel)
f_bp <- function(i){
    qsig_lincs <- qSig(query = batch_queries[[i]],
                   gess_method="LINCS", refdb=refdb)
    lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=TRUE)
    if(!dir.exists("batch_res")){
        dir.create("batch_res")
    }
    write_tsv(result(lincs), paste0("batch_res/lincs_res_", i, ".tsv"))
    return(result(lincs))
}
gess_list <- bplapply(seq_along(batch_queries), f_bp, BPPARAM = MulticoreParam(workers = 2))
```

### 3.9.3 Parallelization with Multiple Computer Systems

In addition to utilizing multiple CPU cores of a single machine, one can further accelerate the processing by taking advantage of multiple computer systems (nodes) available on a computer cluster, where a queueing systems takes care of the load balancing.

In the following example, `Njobs` sets the number of independent processes to be run on the cluster, and `ncpus` defines the number of CPU cores to be used by each process. The chosen example will run 2 processes each utilizing 4 CPU cores. If `batch_queries` contains sufficient GESs and the corresponding computing resources are available on a cluster, then the given example process will utilize in total 8 CPU cores. Note, the given sample code will work on most queueing systems as it is based on utilities from the `batchtools` package. The latter supports template files (`*.tmpl`) for defining the run parameters of different schedulers. To run this code, one needs to have both a `conf` file (see `.batchtools.conf.R` samples [here](https://mllg.github.io/batchtools/)) and a `template` file (see `*.tmpl` samples [here](https://github.com/mllg/batchtools/tree/master/inst/templates)) for the queueing system available on a cluster. The following example uses the sample `conf` and `template` files for the Slurm scheduler.

For additional details on parallelizing computations on clusters, users want to consult the vignettes of the `batchtools` and `BiocParallel` packages.

```
library(batchtools)
batch_queries <- list(q1=list(upset=c("23645", "5290"), downset=c("54957", "2767")),
                      q2=list(upset=c("27101","65083"), downset=c("5813", "84")))
refdb <- system.file("extdata", "sample_db.h5", package="signatureSearch")

f_bt <- function(i, batch_queries, refdb){
    library(signatureSearch)
    library(readr)
    qsig_lincs <- qSig(query = batch_queries[[i]],
                   gess_method="LINCS", refdb=refdb)
    lincs <- gess_lincs(qsig_lincs, sortby="NCS", tau=TRUE)
    if(!dir.exists("batch_res")){
        dir.create("batch_res")
    }
    write_tsv(result(lincs), paste0("batch_res/lincs_res_", i, ".tsv"))
    return(result(lincs)) # or return()
}
```

Copy the `conf` and `template` files for Slurm to current working directory.

```
file.copy(system.file("extdata", ".batchtools.conf.R", package="signatureSearch"), ".")
file.copy(system.file("extdata", "slurm.tmpl", package="signatureSearch"), ".")
```

Create the registry and submit jobs.

```
reg <- makeRegistry(file.dir="reg_batch", conf.file=".batchtools.conf.R")
# reg <- loadRegistry(file.dir="reg_batch", conf.file=".batchtools.conf.R", writeable=TRUE)
Njobs <- 1:2
ids <- batchMap(fun=f_bt, Njobs, more.args = list(
          batch_queries=batch_queries, refdb=refdb))
submitJobs(ids, reg=reg, resources=list(
      partition="intel", walltime=120, ntasks=1, ncpus=4, memory=10240))
getStatus()
waitForJobs() # Wait until all jobs are completed
res1 <- loadResult(1)
unlink(c(".batchtools.conf.R", "slurm.tmpl"))
```

# 4 Functional Enrichment (FEA)

GESS results are lists of perturbagens (here drugs) ranked by their signature similarity to a GES-Q of interest. Interpreting these search results with respect to the cellular networks and pathways affected by the top ranking drugs is difficult. To overcome this challenge, the knowledge of the target proteins of the top ranking drugs can be used to perform functional enrichment analysis (FEA) based on community annotation systems, such as Gene Ontologies (GO), pathways (e.g. KEGG, Reactome), drug MOAs or Pfam domains. For this, the ranked drug sets are converted into target gene/protein sets to perform Target Set Enrichment Analysis (TSEA) based on a chosen annotation system. Alternatively, the functional annotation categories of the targets can be assigned to the drugs directly to perform Drug Set Enrichment Analysis (DSEA). Although TSEA and DSEA are related, their enrichment results can be distinct. This is mainly due to duplicated targets present in the test sets of the TSEA methods, whereas the drugs in the test sets of DSEA are usually unique. Additional reasons include differences in the universe sizes used for TSEA and DSEA.

Importantly, the duplications in the test sets of the TSEA are due to the fact that many drugs share the same target proteins. Standard enrichment methods would eliminate these duplications since they assume uniqueness in the test sets. Removing duplications in TSEA would be inappropriate since it would erase one of the most important pieces of information of this approach. To solve this problem, we have developed and implemented in the `signatureSearch` package a weighting method for duplicated targets, where the weighting is proportional to the frequency of the targets in the test set.

To perform TSEA and DSEA, drug-target annotations are essential. They can be obtained from several sources, including DrugBank, ChEMBL, STITCH, and the [Touchstone](https://clue.io/) dataset from the LINCS project (Wishart et al. 2018; Gaulton et al. 2017; Kuhn et al. 2010; Subramanian et al. 2017). Most drug-target annotations provide UniProt identifiers for the target proteins. They can be mapped, if necessary via their encoding genes, to the chosen functional annotation categories, such as GO or KEGG. To minimize bias in TSEA or DSEA, often caused by promiscuous binders, it can be beneficial to remove drugs or targets that bind to large numbers of distinct proteins or drugs, respectively. To conduct TSEA and DSEA efficiently, `signatureSearch` and its helper package `signatureSearchData` provide several convenience utilities along with drug-target lookup resources for automating the mapping from *drug sets* to *target sets* to *functional categories*.

Note, most FEA tests involving proteins in their test sets are performed on the gene level in `signatureSearch`. This way one can avoid additional duplications due to many-to-one relationships among proteins and their encoding genes. For this, the corresponding functions in `signatureSearch` will usually translate target protein sets into their encoding gene sets using identifier mapping resources from R/Bioconductor, such as the `org.Hs.eg.db` annotation package. Because of this as well as simplicity, the text in the vignette and help files of this package will refer to the targets of drugs almost interchangeably as proteins or genes, even though the former are the direct targets and the latter only the indirect targets of drugs.

## 4.1 TSEA

The following introduces how to perform TSEA on drug-based GESS results using as functional annotation systems GO, KEGG and Reactome pathways. The enrichment tests are performed with three widely used algorithms that have been modified in `signatureSearch` to take advantage of duplication information present in the test sets used for TSEA. The relevance of these target duplications is explained above. The specialized enrichment algorithms include *Duplication Adjusted Hypergeometric Test* (`dup_hyperG`), *Modified Gene Set Enrichment Analysis* (`mGSEA`) and *MeanAbs* (`mabs`).

### 4.1.1 Hypergeometric Test

The classical hypergeometric test assumes uniqueness in its gene/protein test sets. Its p-value is calculated according to equation

\[\begin{equation}
p=\sum\_{k=x}^{n} \frac {{D \choose k}{{N-D} \choose {n-k}}}{{N \choose n}}.
\end{equation}\]

In case of GO term enrichment analysis the individual variables are assigned the following components. \(N\) is the total number of genes/proteins contained in the entire annotation universe; \(D\) is the number of genes annotated at a specific GO node; \(n\) is the total number of genes in the test set; and \(x\) is the number of genes in the test set annotated at a specific GO node. To maintain the duplication information in the test sets used for TSEA, the values of \(n\) and \(x\) in the above equation are adjusted by the frequency of the target proteins in the test set. Effectively, the approach removes the duplications, but maintains their frequency information in form of weighting values.

#### 4.1.1.1 With GO

The following example code uses the \(n\) top ranking drugs (here \(n=10\)) from the LINCS GESS result as input to the `tsea_dup_hyperG` method. Internally, the latter converts the drug set to a target set, and then computes for it enrichment scores for each MF GO term based on the hypergeometric distribution. The enrichment results are stored in a `feaResult` object. It contains the organism information of the annotation system, and the ontology type of the GO annotation system. If the annotation system is KEGG, the latter will be “KEGG”. The object also stores the input drugs used for the enrichment test, as well as their target information.

```
drugs <- unique(result(lincs)$pert[1:10])
dup_hyperG_res <- tsea_dup_hyperG(drugs=drugs, universe="Default",
                                  type="GO", ont="MF", pvalueCutoff=0.05,
                                  pAdjustMethod="BH", qvalueCutoff=0.1,
                                  minGSSize=10, maxGSSize=500)
dup_hyperG_res
```

```
## #
## # Functional Enrichment Analysis
## #
## #...@organism     Homo sapiens
## #...@ontology     MF
## #...@drugs    chr [1:10] "vorinostat" "trichostatin-a" "hc-toxin" "pyroxamide" ...
## #...@targets      chr [1:41] "HDAC1" "HDAC10" "HDAC11" "HDAC2" "HDAC3" "HDAC4" "HDAC5" ...
## #...71 enriched terms found
## # A tibble: 71 × 10
##    ont   ID      Description GeneRatio BgRatio   pvalue p.adjust   qvalue itemID
##    <chr> <chr>   <chr>       <chr>     <chr>      <dbl>    <dbl>    <dbl> <chr>
##  1 MF    GO:001… NAD-depend… 26/41     16/193… 0        0        0        HDAC1…
##  2 MF    GO:003… histone de… 26/41     11/193… 0        0        0        HDAC1…
##  3 MF    GO:003… NAD-depend… 26/41     11/193… 0        0        0        HDAC1…
##  4 MF    GO:003… NAD-depend… 26/41     17/193… 0        0        0        HDAC1…
##  5 MF    GO:000… histone de… 26/41     44/193… 9.55e-63 1.65e-60 5.49e-61 HDAC1…
##  6 MF    GO:003… protein de… 26/41     45/193… 2.26e-62 3.41e-60 1.14e-60 HDAC1…
##  7 MF    GO:001… deacetylas… 26/41     58/193… 2.03e-58 2.72e-56 9.08e-57 HDAC1…
##  8 MF    GO:001… hydrolase … 26/41     89/193… 1.85e-52 1.86e-50 6.20e-51 HDAC1…
##  9 MF    GO:001… hydrolase … 26/41     147/19… 4.54e-46 3.42e-44 1.14e-44 HDAC1…
## 10 MF    GO:004… histone de… 20/41     112/19… 7.39e-35 5.24e-33 1.75e-33 HDAC1…
## # ℹ 61 more rows
## # ℹ 1 more variable: Count <int>
```

The `result` accessor function can be used to extract a tabular result from the `feaResult` object. The rows of this result table contain the functional categories (*e.g.* GO terms or KEGG pathways) ranked by the corresponding enrichment statistic.

```
result(dup_hyperG_res)
```

```
## # A tibble: 71 × 10
##    ont   ID      Description GeneRatio BgRatio   pvalue p.adjust   qvalue itemID
##    <chr> <chr>   <chr>       <chr>     <chr>      <dbl>    <dbl>    <dbl> <chr>
##  1 MF    GO:001… NAD-depend… 26/41     16/193… 0        0        0        HDAC1…
##  2 MF    GO:003… histone de… 26/41     11/193… 0        0        0        HDAC1…
##  3 MF    GO:003… NAD-depend… 26/41     11/193… 0        0        0        HDAC1…
##  4 MF    GO:003… NAD-depend… 26/41     17/193… 0        0        0        HDAC1…
##  5 MF    GO:000… histone de… 26/41     44/193… 9.55e-63 1.65e-60 5.49e-61 HDAC1…
##  6 MF    GO:003… protein de… 26/41     45/193… 2.26e-62 3.41e-60 1.14e-60 HDAC1…
##  7 MF    GO:001… deacetylas… 26/41     58/193… 2.03e-58 2.72e-56 9.08e-57 HDAC1…
##  8 MF    GO:001… hydrolase … 26/41     89/193… 1.85e-52 1.86e-50 6.20e-51 HDAC1…
##  9 MF    GO:001… hydrolase … 26/41     147/19… 4.54e-46 3.42e-44 1.14e-44 HDAC1…
## 10 MF    GO:004… histone de… 20/41     112/19… 7.39e-35 5.24e-33 1.75e-33 HDAC1…
## # ℹ 61 more rows
## # ℹ 1 more variable: Count <int>
```

The columns in the result table, extracted from the `feaResult` object, contain the following information. Note, some columns are only present in the result tables of specific FEA methods. `ont`: in case of GO one of BP, MF, CC, or ALL; `ID`: GO or KEGG IDs; `Description`: description of functional category; `pvalue`: raw p-value of enrichment test; `p.adjust`: p-value adjusted for multiple hypothesis testing based on method specified under `pAdjustMethod`; `qvalue`: q value calculated with R’s `qvalue` function to control FDR; `itemID`: IDs of items (genes for TSEA, drugs for DSEA) overlapping among test and annotation sets; `setSize`: size of the functional category; `GeneRatio`: ratio of genes in the test set that are annotated at a specific GO node or KEGG pathway; `BgRatio`: ratio of background genes that are annotated at a specific GO node or KEGG pathway. `Count`: number of overlapped genes between the test set and the specific functional annotation term.

#### 4.1.1.2 With KEGG

The same enrichment test can be performed for KEGG pathways as follows.

```
dup_hyperG_k_res <- tsea_dup_hyperG(drugs=drugs, universe="Default", type="KEGG",
                                    pvalueCutoff=0.5, pAdjustMethod="BH", qvalueCutoff=0.5,
                                    minGSSize=10, maxGSSize=500)
result(dup_hyperG_k_res)
```

```
## # A tibble: 46 × 9
##    ID      Description GeneRatio BgRatio   pvalue p.adjust   qvalue itemID Count
##    <chr>   <chr>       <chr>     <chr>      <dbl>    <dbl>    <dbl> <chr>  <int>
##  1 hsa050… Alcoholism  27/41     191/94… 6.55e-37 3.34e-35 1.38e-35 3065/…    27
##  2 hsa046… Neutrophil… 26/41     196/94… 1.35e-34 3.45e-33 1.42e-33 3065/…    26
##  3 hsa052… Viral carc… 26/41     205/94… 4.64e-34 7.89e-33 3.26e-33 3065/…    26
##  4 hsa045… Gap juncti… 12/41     92/9497 2.05e-15 2.61e-14 1.08e-14 1812/…    12
##  5 hsa050… Huntington… 17/41     311/94… 2.76e-15 2.82e-14 1.16e-14 3065/…    17
##  6 hsa041… Phagosome   11/41     159/94… 4.20e-11 3.57e-10 1.47e-10 7846/…    11
##  7 hsa050… Amyotrophi… 14/41     371/94… 2.04e-10 1.49e- 9 6.13e-10 10013…    14
##  8 hsa048… Motor prot… 11/41     197/94… 4.25e-10 2.71e- 9 1.12e- 9 7846/…    11
##  9 hsa051… Pathogenic… 11/41     203/94… 5.85e-10 3.32e- 9 1.37e- 9 7846/…    11
## 10 hsa050… Parkinson … 12/41     271/94… 8.64e-10 4.41e- 9 1.82e- 9 1812/…    12
## # ℹ 36 more rows
```

```
## Mapping 'itemID' column in the FEA enrichment result table from Entrez ID to gene Symbol
set_readable(result(dup_hyperG_k_res))
```

```
## # A tibble: 46 × 9
##    ID      Description GeneRatio BgRatio   pvalue p.adjust   qvalue itemID Count
##    <chr>   <chr>       <chr>     <chr>      <dbl>    <dbl>    <dbl> <chr>  <int>
##  1 hsa050… Alcoholism  27/41     191/94… 6.55e-37 3.34e-35 1.38e-35 HDAC1…    27
##  2 hsa046… Neutrophil… 26/41     196/94… 1.35e-34 3.45e-33 1.42e-33 HDAC1…    26
##  3 hsa052… Viral carc… 26/41     205/94… 4.64e-34 7.89e-33 3.26e-33 HDAC1…    26
##  4 hsa045… Gap juncti… 12/41     92/9497 2.05e-15 2.61e-14 1.08e-14 DRD1/…    12
##  5 hsa050… Huntington… 17/41     311/94… 2.76e-15 2.82e-14 1.16e-14 HDAC1…    17
##  6 hsa041… Phagosome   11/41     159/94… 4.20e-11 3.57e-10 1.47e-10 TUBA1…    11
##  7 hsa050… Amyotrophi… 14/41     371/94… 2.04e-10 1.49e- 9 6.13e-10 HDAC6…    14
##  8 hsa048… Motor prot… 11/41     197/94… 4.25e-10 2.71e- 9 1.12e- 9 TUBA1…    11
##  9 hsa051… Pathogenic… 11/41     203/94… 5.85e-10 3.32e- 9 1.37e- 9 TUBA1…    11
## 10 hsa050… Parkinson … 12/41     271/94… 8.64e-10 4.41e- 9 1.82e- 9 DRD1/…    12
## # ℹ 36 more rows
```

The content of the columns extracted from the `feaResult` object is described under section 4.1.1.1.

#### 4.1.1.3 With Reactome

The same enrichment test can be performed for Reactome pathways as follows.

```
dup_rct_res <- tsea_dup_hyperG(drugs=drugs, type="Reactome",
                               pvalueCutoff=0.5, qvalueCutoff=0.5, readable=TRUE)
result(dup_rct_res)
```

```
## # A tibble: 211 × 9
##    ID      Description GeneRatio BgRatio   pvalue p.adjust   qvalue itemID Count
##    <chr>   <chr>       <chr>     <chr>      <dbl>    <dbl>    <dbl> <chr>  <int>
##  1 R-HSA-… STAT3 nucl… 9/35      8/10173 0        0        0        HDAC1…     9
##  2 R-HSA-… Notch-HLH … 17/35     21/101… 7.26e-41 7.74e-39 4.97e-40 HDAC1…    17
##  3 R-HSA-… NOTCH1 Int… 17/35     39/101… 6.01e-34 4.27e-32 2.74e-33 HDAC1…    17
##  4 R-HSA-… Signaling … 17/35     49/101… 7.53e-32 2.00e-30 1.29e-31 HDAC1…    17
##  5 R-HSA-… Signaling … 17/35     49/101… 7.53e-32 2.00e-30 1.29e-31 HDAC1…    17
##  6 R-HSA-… Constituti… 17/35     49/101… 7.53e-32 2.00e-30 1.29e-31 HDAC1…    17
##  7 R-HSA-… Signaling … 17/35     49/101… 7.53e-32 2.00e-30 1.29e-31 HDAC1…    17
##  8 R-HSA-… Constituti… 17/35     49/101… 7.53e-32 2.00e-30 1.29e-31 HDAC1…    17
##  9 R-HSA-… Signaling … 17/35     62/101… 8.38e-30 1.98e-28 1.27e-29 HDAC1…    17
## 10 R-HSA-… Aggrephagy  13/35     41/101… 1.23e-23 2.63e-22 1.69e-23 HDAC6…    13
## # ℹ 201 more rows
```

### 4.1.2 mGSEA Method

The original GSEA method proposed by Subramanian et al. (2005) uses predefined gene sets \(S\) defined by functional annotation systems such as GO and KEGG. The goal is to determine whether the genes in \(S\) are randomly distributed throughout a ranked test gene list \(L\) (*e.g.* all genes ranked by LFC) or enriched at the top or bottom of the test list. This is expressed by an Enrichment Score (\(ES\)) reflecting the degree to which a set \(S\) is overrepresented at the extremes of \(L\).

For TSEA, the query is a target set where duplicated entries need to be maintained. To perform GSEA with duplication support, here referred to as mGSEA, the target set is transformed to a score ranked target list \(L\_{tar}\) of all targets provided by the corresponding annotation system. For each target in the query target set, its frequency is divided by the number of targets in the target set, which is the weight of that target. For targets present in the annotation system but absent in the target test set, their scores are set to 0. Thus, every target in the annotation system will be assigned a score and then sorted decreasingly to obtain \(L\_{tar}\).

In case of TSEA, the original GSEA method cannot be used directly since a large portion of zeros exists in \(L\_{tar}\). If the scores of the genes in set \(S\) are all zeros, \(N\_R\) (sum of scores of genes in set \(S\)) will be zero, which cannot be used as the denominator. In this case, \(ES\) is set to -1. If only some genes in set \(S\) have scores of zeros then \(N\_R\) is set to a larger number to decrease the weight of the genes in \(S\) that have non-zero scores.

\[\begin{equation}
N\_R=\sum\_{g\_j\in S}|r\_j|^p+min(r\_j | r\_j > 0)\*\sum\_{g\_j\in S}I\_{r\_j=0}
\end{equation}\]

 \(r\_j\): score of gene \(j\) in \(L\_{tar}\); \(p=1\)

The reason for this modification is that if only one gene in gene set \(S\) has a non-zero score and this gene ranks high in \(L\_{tar}\), the weight of this gene will be 1 resulting in an \(ES(S)\) close to 1. Thus, the original GSEA method will score the gene set \(S\) as significantly enriched. However, this is undesirable because in this example only one gene is shared among the target set and the gene set \(S\). Therefore, giving small weights to genes in \(S\) that have scores of zero would decrease the weight of the genes in \(S\) that have scores other than zero, thereby decreasing the false positive rate. To favor truly enriched GO terms and KEGG pathways (gene set \(S\)) at the top of \(L\_{tar}\), only gene sets with positive \(ES\) are selected.

#### 4.1.2.1 With GO

The following performs TSEA with the *mGSEA* method using the same drug test set as in the above `tsea_dup_hyperG` function call. The arguments of the `tsea_mGSEA` function are explained in its help file that can be opened from R with `?tsea_mGSEA`.

```
mgsea_res <- tsea_mGSEA(drugs=drugs, type="GO", ont="MF", exponent=1,
                        nPerm=1000, pvalueCutoff=1, minGSSize=5)
result(mgsea_res)
```

```
## # A tibble: 93 × 11
##    ont   ID    Description setSize enrichmentScore   NES pvalue p.adjust qvalues
##    <chr> <chr> <chr>         <int>           <dbl> <dbl>  <dbl>    <dbl>   <dbl>
##  1 MF    GO:0… histone de…      11           1.000 3.85   0.002    0.710   0.710
##  2 MF    GO:0… NAD-depend…      11           1.000 3.85   0.002    0.710   0.710
##  3 MF    GO:0… NAD-depend…      16           0.839 3.80   0.02     0.710   0.710
##  4 MF    GO:0… NAD-depend…      17           0.812 3.75   0.021    0.710   0.710
##  5 MF    GO:0… histone de…      44           0.441 2.52   0.055    0.710   0.710
##  6 MF    GO:0… protein de…      45           0.433 2.46   0.058    0.710   0.710
##  7 MF    GO:0… deacetylas…      58           0.356 2.03   0.073    0.710   0.710
##  8 MF    GO:0… NF-kappaB …      28           0.265 1.41   0.048    0.710   0.710
##  9 MF    GO:0… hydrolase …      89           0.250 1.27   0.116    0.710   0.710
## 10 MF    GO:0… potassium …      10           0.182 0.671  0.433    0.710   0.710
## # ℹ 83 more rows
## # ℹ 2 more variables: leadingEdge <chr>, ledge_rank <chr>
```

The content of the columns extracted from the `feaResult` object is described under section 4.1.1.1. The additional columns specific to the GSEA algorithm are described here.

`enrichmentScore`: \(ES\) from the GSEA algorithm (Subramanian et al. 2005). The score is calculated by walking down the gene list \(L\), increasing a running-sum statistic when we encounter a gene in \(S\) and decreasing when it is not. The magnitude of the increment depends on the gene scores. The \(ES\) is the maximum deviation from zero encountered in the random walk. It corresponds to a weighted Kolmogorov-Smirnov-like statistic.

`NES`: Normalized enrichment score. The positive and negative enrichment scores are normalized separately by permutating the composition of the gene list \(L\) `nPerm` times, and dividing the enrichment score by the mean of the permutation \(ES\) with the same sign.

`pvalue`: The nominal p-value of the \(ES\) is calculated using a permutation test. Specifically, the composition of the gene list \(L\) is permuted and the \(ES\) of the gene set is recomputed for the permutated data generating a null distribution for the ES. The p-value of the observed \(ES\) is then calculated relative to this null distribution.

`leadingEdge`: Genes in the gene set S (functional category) that appear in the ranked list \(L\) at, or before, the point where the running sum reaches its maximum deviation from zero. It can be interpreted as the core of a gene set that accounts for the enrichment signal.

`ledge_rank`: Ranks of genes in ‘leadingEdge’ in gene list \(L\).

#### 4.1.2.2 With KEGG

The same enrichment test can be performed for KEGG pathways as follows.

```
mgsea_k_res <- tsea_mGSEA(drugs=drugs, type="KEGG", exponent=1,
                          nPerm=1000, pvalueCutoff=1, minGSSize=2)
result(mgsea_k_res)
```

```
## # A tibble: 51 × 10
##    ID       Description    setSize enrichmentScore   NES pvalue p.adjust qvalues
##    <chr>    <chr>            <int>           <dbl> <dbl>  <dbl>    <dbl>   <dbl>
##  1 hsa05034 Alcoholism         191          0.130  0.287  0.417    0.839   0.839
##  2 hsa04540 Gap junction        92          0.129  0.417  0.27     0.839   0.839
##  3 hsa04613 Neutrophil ex…     196          0.122  0.262  0.431    0.839   0.839
##  4 hsa05203 Viral carcino…     205          0.117  0.247  0.442    0.839   0.839
##  5 hsa05031 Amphetamine a…      69          0.0944 0.338  0.415    0.839   0.839
##  6 hsa04213 Longevity reg…      62          0.0905 0.339  0.457    0.839   0.839
##  7 hsa04330 Notch signali…      62          0.0905 0.339  0.457    0.839   0.839
##  8 hsa05220 Chronic myelo…      77          0.0736 0.247  0.509    0.839   0.839
##  9 hsa04919 Thyroid hormo…     122          0.0700 0.197  0.495    0.839   0.839
## 10 hsa03083 Polycomb repr…      83          0.0685 0.226  0.525    0.839   0.839
## # ℹ 41 more rows
## # ℹ 2 more variables: leadingEdge <chr>, ledge_rank <chr>
```

The content of the columns extracted from the `feaResult` object is described under sections 4.1.1.1 and 4.1.2.1.

#### 4.1.2.3 With Reactome

The same enrichment test can be performed for Reactome pathways as follows.

```
mgsea_rct_res <- tsea_mGSEA(drugs=drugs, type="Reactome", pvalueCutoff=1,
                            readable=TRUE)
result(mgsea_rct_res)
```

```
## # A tibble: 213 × 10
##    ID          Description setSize enrichmentScore   NES pvalue p.adjust qvalues
##    <chr>       <chr>         <int>           <dbl> <dbl>  <dbl>    <dbl>   <dbl>
##  1 R-HSA-9701… STAT3 nucl…       8           0.643  2.16 0.019     0.695   0.695
##  2 R-HSA-3500… Notch-HLH …      21           0.547  2.45 0.052     0.695   0.695
##  3 R-HSA-1908… Microtubul…      20           0.498  2.22 0.048     0.695   0.695
##  4 R-HSA-1908… Transport …      21           0.475  2.12 0.052     0.695   0.695
##  5 R-HSA-3899… Post-chape…      23           0.433  1.97 0.057     0.695   0.695
##  6 R-HSA-9022… Loss of ME…       5           0.428  1.20 0.124     0.695   0.695
##  7 R-HSA-9005… Loss of fu…      12           0.412  1.59 0.0460    0.695   0.695
##  8 R-HSA-9005… Pervasive …      12           0.412  1.59 0.0460    0.695   0.695
##  9 R-HSA-9697… Disorders …      12           0.412  1.59 0.0460    0.695   0.695
## 10 R-HSA-9022… MECP2 regu…       7           0.4    1.27 0.092     0.695   0.695
## # ℹ 203 more rows
## # ℹ 2 more variables: leadingEdge <chr>, ledge_rank <chr>
```

### 4.1.3 MeanAbs Method

The input for the *MeanAbs* method is \(L\_{tar}\), the same as for *mGSEA*. In this enrichment statistic, \(mabs(S)\), of a gene set \(S\) is calculated as mean absolute scores of the genes in \(S\) (Fang, Tian, and Ji 2012). In order to adjust for size variations in gene set \(S\), 1000 random permutations of \(L\_{tar}\) are performed to determine \(mabs(S,\pi)\). Subsequently, \(mabs(S)\) is normalized by subtracting the median of the \(mabs(S,\pi)\) and then dividing by the standard deviation of \(mabs(S,\pi)\) yielding the normalized scores \(Nmabs(S)\). Finally, the portion of \(mabs(S,\pi)\) that is greater than \(mabs(S)\) is used as nominal p-value. The resulting nominal p-values are adjusted for multiple hypothesis testing using the Benjamini-Hochberg method (Benjamini and Hochberg 1995).

#### 4.1.3.1 With GO

The following performs TSEA with the *mabs* method using the same drug test set as the examples given under the *dup\_hyperG* and *tsea\_mGSEA* sections. The arguments of the `tsea_mabs` function are explained in its help file that can be opened from R with `?tsea_mabs`.

```
mabs_res <- tsea_mabs(drugs=drugs, type="GO", ont="MF", nPerm=1000,
                      pvalueCutoff=0.05, minGSSize=5)
result(mabs_res)
```

```
## # A tibble: 84 × 10
##    ont   ID     Description setSize    mabs Nmabs pvalue p.adjust qvalues itemID
##    <chr> <chr>  <chr>         <int>   <dbl> <dbl>  <dbl>    <dbl>   <dbl> <chr>
##  1 MF    GO:00… histone de…      11 0.0576  30.7   0       0      0       HDAC1…
##  2 MF    GO:00… NAD-depend…      11 0.0576  30.7   0       0      0       HDAC1…
##  3 MF    GO:00… NAD-depend…      16 0.0396  30.2   0       0      0       HDAC1…
##  4 MF    GO:00… NAD-depend…      17 0.0373  30.2   0       0      0       HDAC1…
##  5 MF    GO:00… histone de…      44 0.0144  28.1   0       0      0       HDAC1…
##  6 MF    GO:00… protein de…      45 0.0141  28.1   0       0      0       HDAC1…
##  7 MF    GO:00… deacetylas…      58 0.0109  27.2   0       0      0       HDAC1…
##  8 MF    GO:00… NF-kappaB …      28 0.00784 20.1   0       0      0       HDAC1…
##  9 MF    GO:00… hydrolase …      89 0.00713 26.1   0       0      0       HDAC1…
## 10 MF    GO:00… potassium …      10 0.00488  9.16  0.004   0.0118 0.00235 HDAC4
## # ℹ 74 more rows
```

The content of the columns extracted from the `feaResult` object is explained under section 4.1.1.1. The columns specific to the *mabs* algorithm are described below.

`mabs`: Given a scored ranked gene list \(L\), \(mabs(S)\) represents the mean absolute score of the genes in set \(S\).

`Nmabs`: \(mabs(S)\) normalized.

#### 4.1.3.2 With KEGG

The same enrichment test can be performed for KEGG pathways as follows.

```
mabs_k_res <- tsea_mabs(drugs=drugs, type="KEGG", nPerm=1000,
                        pvalueCutoff=0.2, minGSSize=5)
result(mabs_k_res)
```

```
## # A tibble: 48 × 9
##    ID       Description     setSize    mabs Nmabs pvalue p.adjust qvalues itemID
##    <chr>    <chr>             <int>   <dbl> <dbl>  <dbl>    <dbl>   <dbl> <chr>
##  1 hsa05034 Alcoholism          191 0.00345 17.9   0      0       0       10013…
##  2 hsa04613 Neutrophil ext…     196 0.00324 16.9   0      0       0       10013…
##  3 hsa04540 Gap junction         92 0.00318 12.5   0      0       0       10376…
##  4 hsa05203 Viral carcinog…     205 0.00309 17.3   0      0       0       10013…
##  5 hsa05031 Amphetamine ad…      69 0.00247  9.75  0      0       0       1812/…
##  6 hsa04213 Longevity regu…      62 0.00236  7.81  0.001  0.00189 7.41e-4 3065/…
##  7 hsa04330 Notch signalin…      62 0.00236  7.66  0      0       0       3065/…
##  8 hsa05220 Chronic myeloi…      77 0.00190  7.05  0      0       0       3065/…
##  9 hsa04919 Thyroid hormon…     122 0.00180  8.36  0      0       0       3065/…
## 10 hsa03083 Polycomb repre…      83 0.00176  6.92  0.001  0.00189 7.41e-4 3065/…
## # ℹ 38 more rows
```

#### 4.1.3.3 With Reactome

The same enrichment test can be performed for Reactome pathways as follows.

```
mabs_rct_res <- tsea_mabs(drugs=drugs, type="Reactome", pvalueCutoff=1,
                          readable=TRUE)
result(mabs_rct_res)
```

```
## # A tibble: 213 × 9
##    ID            Description setSize   mabs Nmabs pvalue p.adjust qvalues itemID
##    <chr>         <chr>         <int>  <dbl> <dbl>  <dbl>    <dbl>   <dbl> <chr>
##  1 R-HSA-9701898 STAT3 nucl…       8 0.0274  22.6      0        0       0 HDAC1…
##  2 R-HSA-350054  Notch-HLH …      21 0.0197  24.6      0        0       0 HDAC6…
##  3 R-HSA-9022537 Loss of ME…       5 0.0146  13.4      0        0       0 HDAC3
##  4 R-HSA-9005891 Loss of fu…      12 0.0142  19.0      0        0       0 HDAC1…
##  5 R-HSA-9005895 Pervasive …      12 0.0142  19.0      0        0       0 HDAC1…
##  6 R-HSA-9697154 Disorders …      12 0.0142  19.0      0        0       0 HDAC1…
##  7 R-HSA-9022702 MECP2 regu…       7 0.0139  12.5      0        0       0 HDAC1
##  8 R-HSA-4641265 Repression…       7 0.0139  17.0      0        0       0 HDAC1
##  9 R-HSA-190840  Microtubul…      20 0.0122  20.4      0        0       0 TUBA1…
## 10 R-HSA-190872  Transport …      21 0.0116  20.1      0        0       0 TUBA1…
## # ℹ 203 more rows
```

## 4.2 DSEA

Instead of translating ranked lists of drugs into target sets, as for TSEA, the functional annotation categories of the targets can be assigned to the drugs directly to perform Drug Set Enrichment Analysis (DSEA) instead. Since the
drug lists from GESS results are usually unique, this strategy overcomes the duplication problem of the TSEA approach. This way classical enrichment methods, such as GSEA or tests based on the hypergeometric distribution, can be readily applied without major modifications to the underlying statistical methods. As explained above, TSEA and DSEA performed with the same enrichment statistics are not expected to generate identical results. Rather they often complement each other’s strengths and weaknesses.

### 4.2.1 Hypergeometric Test

The following performs DSEA with `signatureSearch's` hypergeometric test function called `dsea_hyperG` using the same drug test set as the examples given under in the TSEA section. The arguments are explained in its help file that can be opened from R with `?dsea_hyperG`.

#### 4.2.1.1 With GO

As functional annotation system the following DSEA example uses GO.

```
drugs <- unique(result(lincs)$pert[1:10])
hyperG_res <- dsea_hyperG(drugs=drugs, type="GO", ont="MF")
result(hyperG_res)
```

```
## # A tibble: 51 × 10
##    ont   ID       Description GeneRatio BgRatio   pvalue p.adjust  qvalue itemID
##    <chr> <chr>    <chr>       <chr>     <chr>      <dbl>    <dbl>   <dbl> <chr>
##  1 MF    GO:0035… Krueppel-a… 4/8       27/225… 1.13e-10  5.89e-8 1.73e-8 vorin…
##  2 MF    GO:0031… histone de… 5/8       199/22… 2.78e- 9  3.04e-7 8.93e-8 vorin…
##  3 MF    GO:0032… NAD-depend… 5/8       199/22… 2.78e- 9  3.04e-7 8.93e-8 vorin…
##  4 MF    GO:0017… NAD-depend… 5/8       261/22… 1.08e- 8  3.38e-7 9.93e-8 vorin…
##  5 MF    GO:0034… NAD-depend… 5/8       266/22… 1.19e- 8  3.38e-7 9.93e-8 vorin…
##  6 MF    GO:0031… nucleosoma… 4/8       88/225… 1.49e- 8  3.88e-7 1.14e-7 vorin…
##  7 MF    GO:0001… core promo… 4/8       94/225… 1.95e- 8  4.61e-7 1.35e-7 vorin…
##  8 MF    GO:0004… histone de… 5/8       318/22… 2.91e- 8  6.11e-7 1.79e-7 vorin…
##  9 MF    GO:0033… protein de… 5/8       323/22… 3.15e- 8  6.11e-7 1.79e-7 vorin…
## 10 MF    GO:0031… nucleosome… 4/8       106/22… 3.17e- 8  6.11e-7 1.79e-7 vorin…
## # ℹ 41 more rows
## # ℹ 1 more variable: Count <int>
```

#### 4.2.1.2 With KEGG

The same DSEA test can be performed for KEGG pathways as follows.

```
hyperG_k_res <- dsea_hyperG(drugs = drugs, type = "KEGG",
                            pvalueCutoff = 1, qvalueCutoff = 1,
                            minGSSize = 10, maxGSSize = 2000)
result(hyperG_k_res)
```

```
## # A tibble: 46 × 9
##    ID       Description  GeneRatio BgRatio  pvalue p.adjust  qvalue itemID Count
##    <chr>    <chr>        <chr>     <chr>     <dbl>    <dbl>   <dbl> <chr>  <int>
##  1 hsa03082 ATP-depende… 4/8       134/20… 1.13e-7  3.68e-6 2.36e-6 vorin…     4
##  2 hsa04330 Notch signa… 4/8       146/20… 1.60e-7  3.68e-6 2.36e-6 vorin…     4
##  3 hsa03083 Polycomb re… 4/8       198/20… 5.43e-7  7.51e-6 4.81e-6 vorin…     4
##  4 hsa05034 Alcoholism   6/8       1131/2… 6.53e-7  7.51e-6 4.81e-6 vorin…     6
##  5 hsa04110 Cell cycle   5/8       815/20… 4.65e-6  4.28e-5 2.74e-5 vorin…     5
##  6 hsa05031 Amphetamine… 5/8       916/20… 8.25e-6  6.32e-5 4.05e-5 vorin…     5
##  7 hsa05203 Viral carci… 5/8       1175/2… 2.78e-5  1.67e-4 1.07e-4 vorin…     5
##  8 hsa05016 Huntington … 5/8       1185/2… 2.90e-5  1.67e-4 1.07e-4 vorin…     5
##  9 hsa04613 Neutrophil … 5/8       1237/2… 3.57e-5  1.74e-4 1.12e-4 vorin…     5
## 10 hsa04213 Longevity r… 4/8       578/20… 3.79e-5  1.74e-4 1.12e-4 vorin…     4
## # ℹ 36 more rows
```

The content of the columns extracted from the feaResult object is described under section 4.1.1.1.

### 4.2.2 GSEA Method

The following performs DSEA with the *GSEA* method using as test set drug labels combined with scores. Instead of using only the drug labels in the test set, the *GSEA* method requires the labels as well as the scores used for ranking the drug list in the GESS result. The scores are usually the similarity metric used to rank the results of the corresponding GESS method, here the NCS values from the LINCS method. The arguments of the `dsea_GSEA` function are explained in its help file that can be opened from R with `?dsea_GSEA`.

#### 4.2.2.1 With GO

As functional annotation system the following DSEA example uses GO.

```
dl <- abs(result(lincs)$NCS); names(dl) <- result(lincs)$pert
dl <- dl[dl>0]
dl <- dl[!duplicated(names(dl))]
gsea_res <- dsea_GSEA(drugList=dl, type="GO", ont="MF", exponent=1, nPerm=1000,
                      pvalueCutoff=0.2, minGSSize=5)
```

```
##   |                                                                              |                                                                      |   0%  |                                                                              |======================================================================| 100%
```

```
result(gsea_res)
```

```
## # A tibble: 55 × 11
##    ont   ID         Description   setSize enrichmentScore   NES  pvalue p.adjust
##    <chr> <chr>      <chr>           <int>           <dbl> <dbl>   <dbl>    <dbl>
##  1 MF    GO:0004407 histone deac…       5           0.951  2.94 9.99e-4   0.0149
##  2 MF    GO:0016811 hydrolase ac…       5           0.951  2.94 9.99e-4   0.0149
##  3 MF    GO:0017136 NAD-dependen…       5           0.951  2.94 9.99e-4   0.0149
##  4 MF    GO:0019213 deacetylase …       5           0.951  2.94 9.99e-4   0.0149
##  5 MF    GO:0031078 histone deac…       5           0.951  2.94 9.99e-4   0.0149
##  6 MF    GO:0032041 NAD-dependen…       5           0.951  2.94 9.99e-4   0.0149
##  7 MF    GO:0033558 protein deac…       5           0.951  2.94 9.99e-4   0.0149
##  8 MF    GO:0034979 NAD-dependen…       5           0.951  2.94 9.99e-4   0.0149
##  9 MF    GO:0003714 transcriptio…       5           0.931  2.88 9.99e-4   0.0149
## 10 MF    GO:0002039 p53 binding         5           0.913  2.82 9.99e-4   0.0149
## # ℹ 45 more rows
## # ℹ 3 more variables: qvalues <dbl>, leadingEdge <chr>, ledge_rank <chr>
```

#### 4.2.2.2 With KEGG

The same DSEA test can be performed for KEGG pathways as follows.

```
gsea_k_res <- dsea_GSEA(drugList=dl, type="KEGG", exponent=1, nPerm=1000,
                        pvalueCutoff=1, minGSSize=5)
```

```
##   |                                                                              |                                                                      |   0%  |                                                                              |======================================================================| 100%
```

```
result(gsea_k_res)
```

```
## # A tibble: 74 × 10
##    ID       Description   setSize enrichmentScore   NES  pvalue p.adjust qvalues
##    <chr>    <chr>           <int>           <dbl> <dbl>   <dbl>    <dbl>   <dbl>
##  1 hsa03083 Polycomb rep…       5           0.913  2.73 9.99e-4   0.0123 0.00999
##  2 hsa05031 Amphetamine …       8           0.785  2.66 9.99e-4   0.0123 0.00999
##  3 hsa05169 Epstein-Barr…       6           0.838  2.64 9.99e-4   0.0123 0.00999
##  4 hsa04613 Neutrophil e…       7           0.807  2.64 2.00e-3   0.0123 0.00999
##  5 hsa04110 Cell cycle          7           0.803  2.62 2.00e-3   0.0123 0.00999
##  6 hsa04350 TGF-beta sig…       6           0.832  2.62 9.99e-4   0.0123 0.00999
##  7 hsa05034 Alcoholism         10           0.731  2.60 9.99e-4   0.0123 0.00999
##  8 hsa05202 Transcriptio…       7           0.772  2.52 2.00e-3   0.0123 0.00999
##  9 hsa04213 Longevity re…       7           0.762  2.49 2.00e-3   0.0123 0.00999
## 10 hsa05016 Huntington d…       8           0.718  2.43 2.00e-3   0.0123 0.00999
## # ℹ 64 more rows
## # ℹ 2 more variables: leadingEdge <chr>, ledge_rank <chr>
```

Since the annotation system are drug-to-functional category mappings, the “leadingEdge” column contains identifiers of drugs instead of targets.

## 4.3 Comparing FEA Results

The `comp_fea_res` function re-ranks the functional categories across the different FEA methods by using the mean rank of each functional category across the 5 FEA methods. Here the functional categories are re-ranked by their mean rank values in increasing order. Since the functional categories are not always present in all enrichment results, the mean rank of a functional category is corrected by an adjustment factor that is the number of enrichment result methods used divided by the number of occurrences of a functional category. For instance, if a functional category is only present in the result of one method, its mean rank will be increased accordingly. The following plots use the `pvalue` column in the result tables for this ranking approach. Alternative columns can be chosen under the `rank_stat` argument. After re-ranking only the top ranking functional categories are shown, here 20. Their number can be changed under the `Nshow` argument.

```
table_list = list("dup_hyperG" = result(dup_hyperG_res),
                  "mGSEA" = result(mgsea_res),
                  "mabs" = result(mabs_res),
                  "hyperG" = result(hyperG_res),
                  "GSEA" = result(gsea_res))
comp_fea_res(table_list, rank_stat="pvalue", Nshow=20)
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the signatureSearch package.
##   Please report the issue at
##   <https://github.com/yduan004/signatureSearch/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the signatureSearch package.
##   Please report the issue at
##   <https://github.com/yduan004/signatureSearch/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Figure 5: Ranking comparison of top GO terms across FEA methods. The dots in the plot represent the p-values of the 20 top ranking MF GO terms (y-axis) with heat color coding according to the color gradient in the legend on the right. The GO terms have been ordered from the top to the bottom of the plot by increasing mean rank values calculated for each GO term across the 5 FEA methods (x-axis).

```
table_list = list("dup_hyperG" = result(dup_hyperG_k_res),
                  "mGSEA" = result(mgsea_k_res),
                  "mabs" = result(mabs_k_res),
                  "hyperG" = result(hyperG_k_res),
                  "GSEA" = result(gsea_k_res))
comp_fea_res(table_list, rank_stat="pvalue", Nshow=20)
```

![](data:image/png;base64...)

Figure 6: Ranking comparison among top KEGG pathways across FEA methods. The plot depicts the same information as the previous plot but using KEGG pathways instead of GO terms as functional annotation system.

## 4.4 Summary of FEA Results

The enrichment rankings of the functional categories (GO and KEGG) show a reasonable degree of agreement among the five FEA methods. For instance, all five showed a high degree of enrichment for histone deacetylase pathways that are indeed targeted by one of the query drugs, here vorinostat. Since each method has its strengths and weaknesses, the usage of a consensus approach could be considered by combining the rankings of functional categories from all or several FEA methods.

# 5 Drug-Target Network Visualization

Functional modules of the above GESS and FEA results can be rendered as interactive drug-target networks using the `dtnetplot` function from `signatureSearch`. For this, a character vector of drug names along with an identifier of a chosen functional category are passed on to the `drugs` and `set` arguments, respectively. The resulting plot depicts the corresponding drug-target interaction network. Its interactive features allow the user to zoom in and out of the network, and to select network components in the drop-down menu located in the upper left corner of the plot.

## 5.1 With GO

The following example demonstrates how to construct a drug-target network for two GO categories that are enriched in the results obtained in the FEA section of this vignette. This way one can visualize drug sets in the context of the cellular networks and pathways they affect.

Network for *NAD-dependent histone deacetylase activity* (GO:0032041)

```
dtnetplot(drugs = drugs(dup_hyperG_res), set = "GO:0032041", ont = "MF",
          desc="NAD-dependent histone deacetylase activity (H3-K14 specific)")
```

```
## No targets found in all databases for 2 drugs:
## scopolamine-n-oxide / i-070759
```

Figure 7: Drug-target network for *NAD-dependent histone deacetylase activity*. The given network graph illustrates the interactions among drugs and their target proteins in the chosen pathway. Only drugs with at least one target protein are included. The nodes in the network represent drugs and targets depicted as squares and circles, respectively. The interactions among drugs and targets are indicated by non-weighted lines (yes/no relationship). The color of the nodes is defined by the number of their connections to other nodes.

Network for *NF-kappaB binding* (GO:0051059)

```
dtnetplot(drugs = drugs(dup_hyperG_res), set = "GO:0051059", ont = "MF",
          desc="NF-kappaB binding")
```

```
## No targets found in all databases for 2 drugs:
## scopolamine-n-oxide / i-070759
```

Figure 8: Drug-target network for *NF-kappaB binding*. The details of the plot are given in the legend of Figure 7.

## 5.2 With KEGG

The same drug-target network plots can be rendered for KEGG pathways as follows.

Network for KEGG pathway: *Alcoholism* (hsa05034)

```
dtnetplot(drugs = drugs(dup_hyperG_k_res), set = "hsa05034",
          desc="Alcoholism")
```

```
## No targets found in all databases for 2 drugs:
## scopolamine-n-oxide / i-070759
```

Figure 9: Drug-target network for *Alcoholism*. The details of the plot are given in the legend of Figure 7.

Network for KEGG pathway: *Longevity regulating pathway* (hsa04213)

```
dtnetplot(drugs = drugs, set = "hsa04213",
          desc="Longevity regulating pathway - multiple species")
```

```
## No targets found in all databases for 2 drugs:
## scopolamine-n-oxide / i-070759
```

Figure 10: Drug-target network for *Longevity regulating pathway*. The details of the plot are given in the legend of Figure 7.

# 6 Run Workflow

The `runWF` function supports running the entire GESS/FEA workflow automatically when providing the query drug and cell type, as well as selecting the reference database (e.g. `lincs` or path to the custom reference database), defining the specific GESS and FEA methods. When the query drug and cell type were provided, the query GES was internally drawn from the reference database. The N (defined by the `N_gess_drugs` argument) top ranking hits in the GESS tables were then used for FEA where three different annotation systems were used: GO Molecular Function (GO MF), GO Biological Process (GO BP) and KEGG pathways.

The GESS/FEA results will be stored in a list object in R session. A working environment named by the use case will be created under users current working directory or under other directory defined by users. This environment contains a folder where the GESS/FEA result tables were written to. The working environment also contains a template Rmd vignette as well as a rendered HTML report, users could make modifications on the Rmd vignette as they need and re-render it to generate their HTML report by running `rmarkdown::render("GESS_FEA_report.Rmd")` in R session or `Rscript -e "rmarkdown::render('GESS_FEA_report.Rmd')"` from bash commandline.

```
drug <- "vorinostat"; cell <- "SKB"
refdb <- system.file("extdata", "sample_db.h5", package="signatureSearch")
env_dir <- tempdir()
wf_list <- runWF(drug, cell, refdb, gess_method="LINCS",
    fea_method="dup_hyperG", N_gess_drugs=10, env_dir=env_dir, tau=FALSE)
```

# 7 Additional Databases

## 7.1 Gene Set Databases

The GES-DB introduced above store quantitative gene expression profiles. For the different GESS methods, these profiles are either used in their quantitative form or converted to non-quantitative gene sets. Additionally, *signatureSearch* can be used to search GES databases containing gene sets, or to use their gene set entries as queries for searching quantitative GES databases. Two examples of gene set databases are the [Molecular signatures database (MSigDB)](https://www.gsea-msigdb.org/gsea/msigdb/index.jsp) and the [Gene Set Knowledgebase (GSKB)](http://ge-lab.org/#/data) (Liberzon et al. 2011, 2015; Culhane et al. 2012; Lai et al. 2016). MSigDB contains well-annotated gene sets representing the universe of the biological processes in human. Version 7.1 of MSigDB contains 25,724 gene sets that are divided into 8 collections. GSKB is a gene set database for pathway analysis in mouse (Lai et al. 2016). It includes more than 40,000 pathways and gene sets compiled from 40 sources, such as Gene Ontology, KEGG, GeneSetDB, and others. The following introduces how to work with these gene set databases in *signatureSearch*.

### 7.1.1 Overview

*signatureSearch* provides utilities to import gene sets in *gmt* format from MSigDB, GSKB and related gene set-based resources. The imported gene sets can be used either as set-based queries or reference databases, or both. As queries these gene sets can be used in combination with the *CMAP*, *LINCS* or *Fisher* GESSs. In addition, as set databases they can be used with the *Fisher* and *gCMAP* GESSs. The following examples illustrate how to import and search *gmt* files in *signatureSearch* using sample data from MSigDB and GSKB. First, examples are provided how to use the gene sets from both resources as queries (here Entrez IDs from human) to search the CMAP2 and LINCS databases. Next, several examples are provided where the MSigDB and GSKB collections serve as reference databases for queries with compatible GESS methods.

### 7.1.2 Gene Sets as Queries

The *gmt* files can be downloaded from MSigDB ([here](https://www.gsea-msigdb.org/gsea/downloads.jsp#msigdb)), and then imported into a user’s R session with the `read_gmt` function.

```
msig <- read_gmt("msigdb.v7.1.entrez.gmt") # 25,724
db_path <- system.file("extdata", "sample_db.h5", package = "signatureSearch")
```

Subsequently, an imported gene set can be used as query for searching a reference database with the `CMAP`, `LINCS` or `Fisher` methods. The following example is for unlabeled query gene sets that lack information about up- or down-regulation.

```
gene_set <- msig[["GO_GROWTH_HORMONE_RECEPTOR_BINDING"]]
# CMAP method
cmap_qsig <- qSig(query=list(upset=gene_set), gess_method="CMAP", refdb=db_path)
cmap_res <- gess_cmap(cmap_qsig, workers=1)
# LINCS method
lincs_qsig <- qSig(query=list(upset=gene_set), gess_method="LINCS", refdb=db_path)
lincs_res <- gess_lincs(lincs_qsig, workers=1)
# Fisher methods
fisher_qsig <- qSig(query=list(upset=gene_set), gess_method="Fisher", refdb=db_path)
fisher_res <- gess_fisher(fisher_qsig, higher=1, lower=-1, workers=1)
```

Alternatively, query gene sets with up and down labels can be used as shown below.

```
gene_set_up <- msig[["GSE17721_0.5H_VS_24H_POLYIC_BMDC_UP"]]
gene_set_down <- msig[["GSE17721_0.5H_VS_24H_POLYIC_BMDC_DN"]]
# CMAP method
cmap_qsig <- qSig(query=list(upset=gene_set_up, downset=gene_set_down),
                  gess_method="CMAP", refdb=db_path)
cmap_res <- gess_cmap(cmap_qsig, workers=1)
# LINCS method
lincs_qsig <- qSig(query=list(upset=gene_set_up, downset=gene_set_down),
                   gess_method="LINCS", refdb=db_path)
lincs_res <- gess_lincs(lincs_qsig, workers=1)
# Fisher methods
fisher_qsig <- qSig(query=list(upset=gene_set_up, downset=gene_set_down),
                    gess_method="Fisher", refdb=db_path)
fisher_res <- gess_fisher(fisher_qsig, higher=1, lower=-1, workers=1)
```

### 7.1.3 Gene Sets as Database

#### 7.1.3.1 MSigDB

The gene sets stored in the *gmt* file can also be used as reference database. The following examples uses the MSigDB combined with the `gCMAP` and `Fisher` GESS methods. For simplicity and compatibility with both GESS methods, unlabeled gene sets are provided to the `gmt2h5` function for generating the reference database. To cap the memory requirements, this function supports reading and writing the gene sets in batches by defining the `by_nset` parameter. Since the example uses the full database, the generation of the HDF5 file takes some time, but this needs to be done only once. Please note that for the *gCMAP* method, this is a specialty case for the sake of having a simple gene set database that can be used for both methods. The *gCMAP* method also supports labeled gene sets represented as 0, 1, -1 matrix.

```
gmt2h5(gmtfile="./msigdb.v7.1.entrez.gmt", dest_h5="./msigdb.h5", by_nset=1000,
       overwrite=TRUE)

# gCMAP method
query_mat <- getSig(cmp="vorinostat", cell="SKB", refdb=db_path)
gcmap_qsig2 <- qSig(query=query_mat, gess_method="gCMAP", refdb="./msigdb.h5")
gcmap_res2 <- gess_gcmap(gcmap_qsig2, higher=1, workers=1, chunk_size=2000)

# Fisher method
msig <- read_gmt("msigdb.v7.1.entrez.gmt")
gene_set <- msig[["GO_GROWTH_HORMONE_RECEPTOR_BINDING"]]
fisher_qsig2 <- qSig(query=list(upset=gene_set), gess_method="Fisher",
                    refdb="./msigdb.h5")
fisher_res2 <- gess_fisher(fisher_qsig2, higher=1, workers=1, chunk_size=2000)
```

#### 7.1.3.2 GSKB

To use the GSKB database from mouse, the corresponding *gmt* file needs to be downloaded from [here](http://ge-lab.org/#/data). The following `gCMAP` GESS uses Entrez IDs from mouse for both the query and the reference database. Since the example uses the full database, the generation of the HDF5 file takes some time, but this needs to be done only once. Please note that for the *gCMAP* method, this is a specialty case for the sake of having a simple gene set database that can be used for both methods. The *gCMAP* method also supports labeled gene sets represented as 0, 1, -1 matrix.

```
gmt2h5(gmtfile="./mGSKB_Entrez.gmt", dest_h5="./mGSKB.h5", by_nset=1000,
       overwrite=TRUE)

# gCMAP method
## Construct a toy query (here matrix)
gskb <- read_gmt("mGSKB_Entrez.gmt") # 41,546
mgenes <- unique(unlist(gskb))
ranks <- rev(seq_along(mgenes))
mquery <- matrix(ranks, ncol=1)
rownames(mquery) <- mgenes; colnames(mquery) <- "MAKE_UP"
gcmap_qsig3 <- qSig(query=mquery, gess_method="gCMAP",
                    refdb="./mGSKB.h5")
gcmap_res3 <- gess_gcmap(gcmap_qsig3, higher=1, workers=1, chunk_size=2000)

# Fisher method
gene_set <- gskb[["LIT_MM_HOFFMANN_PRE-BI_VS_LARGE-PRE-BII-CELL_DIFF_Entrez"]]
fisher_qsig3 <- qSig(query=list(upset=gene_set), gess_method="Fisher",
                    refdb="./mGSKB.h5")
fisher_res3 <- gess_fisher(fisher_qsig3, higher=1, workers=1, chunk_size=2000)
```

# 8 Supplemental Material

## 8.1 Construction of Toy Database

Access to the LINCS database is provided via the associated *signatureSearchData* package hosted on Bioconductor’s `ExperimentHub`. The following provides the code for constructing the toy database used by the sample code of this vignette. To save time building this vignette, the evaluated components of its sample code use a pre-generated instance of the toy database that is stored in the `extdata` directory of the `signatureSearch` package. Thus, the following code section is not evaluated. It also serves as an example how to construct other custom instances of the LINCS database. Additional details on this topic are provided in the vignette of the `signatureSearchData` package.

```
library(rhdf5)
eh <- ExperimentHub::ExperimentHub()
lincs <- eh[["EH3226"]]
hdacs <- c("vorinostat","trichostatin-a","pyroxamide","HC-toxin","rhamnetin")
hdacs_trts <- paste(hdacs, "SKB", "trt_cp", sep="__")
all_trts <- drop(h5read(lincs, "colnames"))
# Select treatments in SKB cell and not BRD compounds
all_trts2 <- all_trts[!grepl("BRD-", all_trts) & grepl("__SKB__", all_trts)]
set.seed(11)
rand_trts <- sample(setdiff(all_trts2, hdacs_trts), 95)
toy_trts <- c(hdacs_trts, rand_trts)
library(SummarizedExperiment); library(HDF5Array)
toy_db <- SummarizedExperiment(HDF5Array(lincs, name="assay"))
rownames(toy_db) <- HDF5Array(db_path, name="rownames")
colnames(toy_db) <- HDF5Array(db_path, name="colnames")
toy_db <- round(as.matrix(assay(toy_db)[,toy_trts]),2)
set.seed(11)
gene_idx <- sample.int(nrow(toy_db),5000)
toy_db2 <- toy_db[gene_idx,]
# The sample_db is stored in the current directory of user's R session
getwd()
createEmptyH5("sample_db.h5", level=9, delete_existing=TRUE)
append2H5(toy_db2, "sample_db.h5")
h5ls("sample_db.h5")
```

# 9 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] DT_0.34.0                   signatureSearchData_1.23.0
##  [3] HDF5Array_1.38.0            h5mread_1.2.0
##  [5] rhdf5_2.54.0                DelayedArray_0.36.0
##  [7] SparseArray_1.10.0          S4Arrays_1.10.0
##  [9] abind_1.4-8                 Matrix_1.7-4
## [11] ggplot2_4.0.0               signatureSearch_1.24.0
## [13] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
## [15] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [17] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [19] IRanges_2.44.0              S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0         generics_0.1.4
## [23] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [25] Rcpp_1.1.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3      jsonlite_2.0.0          magrittr_2.0.4
##   [4] ggtangle_0.0.7          farver_2.1.2            rmarkdown_2.30
##   [7] fs_1.6.6                vctrs_0.6.5             memoise_2.0.1
##  [10] ggtree_4.0.0            htmltools_0.5.8.1       AnnotationHub_4.0.0
##  [13] curl_7.0.0              Rhdf5lib_1.32.0         gridGraphics_0.5-1
##  [16] sass_0.4.10             bslib_0.9.0             htmlwidgets_1.6.4
##  [19] plyr_1.8.9              httr2_1.2.1             cachem_1.1.0
##  [22] igraph_2.2.1            lifecycle_1.0.4         pkgconfig_2.0.3
##  [25] gson_0.1.0              R6_2.6.1                fastmap_1.2.0
##  [28] digest_0.6.37           aplot_0.2.9             enrichplot_1.30.0
##  [31] patchwork_1.3.2         ExperimentHub_3.0.0     crosstalk_1.2.2
##  [34] RSQLite_2.4.3           labeling_0.4.3          filelock_1.0.3
##  [37] httr_1.4.7              compiler_4.5.1          withr_3.0.2
##  [40] bit64_4.6.0-1           fontquiver_0.2.1        S7_0.2.0
##  [43] BiocParallel_1.44.0     DBI_1.2.3               R.utils_2.13.0
##  [46] rappdirs_0.3.3          tools_4.5.1             ape_5.8-1
##  [49] R.oo_1.27.1             glue_1.8.0              nlme_3.1-168
##  [52] GOSemSim_2.36.0         rhdf5filters_1.22.0     grid_4.5.1
##  [55] reshape2_1.4.4          fgsea_1.36.0            gtable_0.3.6
##  [58] tzdb_0.5.0              preprocessCore_1.72.0   R.methodsS3_1.8.2
##  [61] tidyr_1.3.1             hms_1.1.4               data.table_1.17.8
##  [64] utf8_1.2.6              XVector_0.50.0          ggrepel_0.9.6
##  [67] BiocVersion_3.22.0      pillar_1.11.1           stringr_1.5.2
##  [70] limma_3.66.0            yulab.utils_0.2.1       splines_4.5.1
##  [73] dplyr_1.1.4             treeio_1.34.0           BiocFileCache_3.0.0
##  [76] lattice_0.22-7          bit_4.6.0               annotate_1.88.0
##  [79] tidyselect_1.2.1        fontLiberation_0.1.0    GO.db_3.22.0
##  [82] Biostrings_2.78.0       reactome.db_1.94.0      knitr_1.50
##  [85] fontBitstreamVera_0.1.1 xfun_0.53               statmod_1.5.1
##  [88] visNetwork_2.1.4        stringi_1.8.7           lazyeval_0.2.2
##  [91] ggfun_0.2.0             yaml_2.3.10             evaluate_1.0.5
##  [94] codetools_0.2-20        gdtools_0.4.4           tibble_3.3.0
##  [97] qvalue_2.42.0           BiocManager_1.30.26     graph_1.88.0
## [100] affyio_1.80.0           ggplotify_0.1.3         cli_3.6.5
## [103] systemfonts_1.3.1       xtable_1.8-4            jquerylib_0.1.4
## [106] dichromat_2.0-0.1       dbplyr_2.5.1            png_0.1-8
## [109] XML_3.99-0.19           parallel_4.5.1          readr_2.1.5
## [112] blob_1.2.4              clusterProfiler_4.18.0  DOSE_4.4.0
## [115] tidytree_0.4.6          GSEABase_1.72.0         ggiraph_0.9.2
## [118] affy_1.88.0             scales_1.4.0            purrr_1.1.0
## [121] crayon_1.5.3            rlang_1.1.6             cowplot_1.2.0
## [124] fastmatch_1.1-6         KEGGREST_1.50.0
```

# 10 Funding

This project is funded by NIH grants [U19AG02312](https://www.longevityconsortium.org/) and [U24AG051129](https://www.longevitygenomics.org/) awarded by the National Institute on Aging (NIA). Subcomponents of the environment are based on methods developed by projects funded by NSF awards ABI-1661152 and PGRP-1810468. The High-Performance Computing (HPC) resources used for testing and optimizing the code of this project were funded by NIH and NSF grants 1S10OD016290-01A1 and MRI-1429826, respectively.

# References

Benjamini, Y, and Y Hochberg. 1995. “Controlling the false discovery rate - a practical and powerful approach to multiple testing.” *J. R. Stat. Soc. Series B Stat. Methodol.* 57: 289–300.

Chang, Jeffrey T, Michael L Gatza, Joseph E Lucas, William T Barry, Peyton Vaughn, and Joseph R Nevins. 2011. “SIGNATURE: A Workbench for Gene Expression Signature Analysis.” *BMC Bioinformatics* 12 (November): 443. <http://dx.doi.org/10.1186/1471-2105-12-443>.

Culhane, Aedı́n C, Markus S Schröder, Razvan Sultana, Shaita C Picard, Enzo N Martinelli, Caroline Kelly, Benjamin Haibe-Kains, et al. 2012. “GeneSigDB: a manually curated database and resource for analysis of gene expression signatures.” *Nucleic Acids Res.* 40 (Database issue): D1060–6. <https://doi.org/10.1093/nar/gkr901>.

Duan, Yuzhu, Daniel S Evans, Richard A Miller, Nicholas J Schork, Steven R Cummings, and Thomas Girke. 2020. “SignatureSearch: Environment for Gene Expression Signature Searching and Functional Interpretation.” *Nucleic Acids Res.*, October. <http://dx.doi.org/10.1093/nar/gkaa878>.

Edgar, Ron, Michael Domrachev, and Alex E Lash. 2002. “Gene Expression Omnibus: NCBI Gene Expression and Hybridization Array Data Repository.” *Nucleic Acids Res.* 30 (1): 207–10. <https://www.ncbi.nlm.nih.gov/pubmed/11752295>.

Fang, Zhaoyuan, Weidong Tian, and Hongbin Ji. 2012. “A Network-Based Gene-Weighting Approach for Pathway Analysis.” *Cell Res.* 22 (3): 565–80. <http://dx.doi.org/10.1038/cr.2011.149>.

Gaulton, Anna, Anne Hersey, Michał Nowotka, A Patrı́cia Bento, Jon Chambers, David Mendez, Prudence Mutowo, et al. 2017. “The ChEMBL database in 2017.” *Nucleic Acids Res.* 45 (D1): D945–D954. <https://doi.org/10.1093/nar/gkw1074>.

Graham J. G. Upton. 1992. “Fisher’s Exact Test.” *J. R. Stat. Soc. Ser. A Stat. Soc.* 155 (3): 395–402. <http://www.jstor.org/stable/2982890>.

Kuhn, Michael, Damian Szklarczyk, Andrea Franceschini, Monica Campillos, Christian von Mering, Lars Juhl Jensen, Andreas Beyer, and Peer Bork. 2010. “STITCH 2: An Interaction Network Database for Small Molecules and Proteins.” *Nucleic Acids Res.* 38 (Database issue): D552–6. <http://dx.doi.org/10.1093/nar/gkp937>.

Lai, Liming, Jason Hennessey, Valerie Bares, Eun Woo Son, Yuguang Ban, Wei Wang, Jianli Qi, Gaixin Jiang, Arthur Liberzon, and Steven Xijin Ge. 2016. “GSKB: A Gene Set Database for Pathway Analysis in Mouse.” *bioRxiv*. <https://www.biorxiv.org/content/10.1101/082511v1>.

Lamb, Justin, Emily D Crawford, David Peck, Joshua W Modell, Irene C Blat, Matthew J Wrobel, Jim Lerner, et al. 2006. “The Connectivity Map: Using Gene-Expression Signatures to Connect Small Molecules, Genes, and Disease.” *Science* 313 (5795): 1929–35. <http://dx.doi.org/10.1126/science.1132939>.

Liberzon, Arthur, Chet Birger, Helga Thorvaldsdóttir, Mahmoud Ghandi, Jill P Mesirov, and Pablo Tamayo. 2015. “The Molecular Signatures Database (MSigDB) hallmark gene set collection.” *Cell Syst* 1 (6): 417–25. <https://doi.org/10.1016/j.cels.2015.12.004>.

Liberzon, Arthur, Aravind Subramanian, Reid Pinchback, Helga Thorvaldsdóttir, Pablo Tamayo, and Jill P Mesirov. 2011. “Molecular Signatures Database (MSigDB) 3.0.” *Bioinformatics* 27 (12): 1739–40. <http://dx.doi.org/10.1093/bioinformatics/btr260>.

Peck, David, Emily D Crawford, Kenneth N Ross, Kimberly Stegmaier, Todd R Golub, and Justin Lamb. 2006. “A Method for High-Throughput Gene Expression Signature Analysis.” *Genome Biol.* 7 (7): R61. <http://dx.doi.org/10.1186/gb-2006-7-7-r61>.

Sandmann, Thomas, Sarah K Kummerfeld, Robert Gentleman, and Richard Bourgon. 2014. “gCMAP: User-Friendly Connectivity Mapping with R.” *Bioinformatics* 30 (1): 127–28. <http://dx.doi.org/10.1093/bioinformatics/btt592>.

Subramanian, Aravind, Rajiv Narayan, Steven M Corsello, David D Peck, Ted E Natoli, Xiaodong Lu, Joshua Gould, et al. 2017. “A Next Generation Connectivity Map: L1000 Platform and the First 1,000,000 Profiles.” *Cell* 171 (6): 1437–1452.e17. <http://dx.doi.org/10.1016/j.cell.2017.10.049>.

Subramanian, Aravind, Pablo Tamayo, Vamsi K Mootha, Sayan Mukherjee, Benjamin L Ebert, Michael A Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proc. Natl. Acad. Sci. U. S. A.* 102 (43): 15545–50. <http://dx.doi.org/10.1073/pnas.0506580102>.

Wishart, David S, Yannick D Feunang, An C Guo, Elvis J Lo, Ana Marcu, Jason R Grant, Tanvir Sajed, et al. 2018. “DrugBank 5.0: A Major Update to the DrugBank Database for 2018.” *Nucleic Acids Res.* 46 (D1): D1074–D1082. <http://dx.doi.org/10.1093/nar/gkx1037>.