[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/knowYourCG.html)](index.html)

* [Sequencing Data](Sequencing.html)
* [Array Data](Array.html)
* [Continuous Data](Continuous.html)
* [Visualization](visualization.html)

# Functional Analysis of DNAm Array Data

KnowYourCG (KYCG) is a CpG-centered framework designed for the functional interpretation of DNA methylation data. Unlike existing tools that focus on genes or genomic intervals, KnowYourCG directly targets CpG dinucleotides, featuring automated supervised screenings of diverse biological and technical influences, including sequence motifs, transcription factor binding, histone modifications, replication timing, cell-type-specific methylation, and trait associations. KnowYourCG addresses the challenges of data sparsity in various methylation datasets, including low-pass Nanopore sequencing, single-cell DNA methylomes, 5-hydroxymethylation profiles, spatial DNA methylation maps, and array-based datasets for epigenome-wide association studies and epigenetic clocks.

The input to KYCG is a CpG set (query). The CpG sets can represent differential methylation, results from an epigenome-wide association studies, or any sets that may be derived from analysis. If **array experiment**, the preferred format of the query sets is a character vector of cg-numbers, following the standard Infinium array naming nomenclature.

# QUICK START

The following commands prepare the use of knowYourCG. Several database sets are retrieved and caching is performed to enable faster access in future enrichment testing. More information on viewing and accessing available database sets is discussed later on.

```
library(knowYourCG)
library(sesameData)
sesameDataCache(data_titles=c("genomeInfo.hg38","genomeInfo.mm10",
                  "KYCG.MM285.tissueSignature.20211211",
                  "MM285.tissueSignature","MM285.address",
                  "probeIDSignature","KYCG.MM285.designGroup.20210210",
                  "KYCG.MM285.chromHMM.20210210",
                  "KYCG.MM285.TFBSconsensus.20220116",
                  "KYCG.MM285.HMconsensus.20220116",
                  "KYCG.MM285.chromosome.mm10.20210630"
                  ))
```

The following example uses a query of CpGs methylated in mouse primordial germ cells (design group PGCMeth). First get the CG list using the following code.

```
query <- getDBs("MM285.designGroup")[["PGCMeth"]]
head(query)
```

```
## [1] "cg36615889_TC11" "cg36646136_BC21" "cg36647910_BC11" "cg36857173_TC21"
## [5] "cg36877289_BC21" "cg36899653_BC21"
```

Now test the enrichment. By default, KYCG will select all the categorical groups available but we can specify a subset of databases.

```
dbs <- c("KYCG.MM285.chromHMM.20210210",
         "KYCG.HM450.TFBSconsensus.20211013",
         "KYCG.MM285.HMconsensus.20220116",
         "KYCG.MM285.tissueSignature.20211211",
         "KYCG.MM285.chromosome.mm10.20210630",
         "KYCG.MM285.designGroup.20210210")
results_pgc <- testEnrichment(query,databases = dbs,platform="MM285")
head(results_pgc)
```

As expected, the PGCMeth group itself appears on the top of the list. But one can also find histone H3K9me3, chromHMM `Het` and transcription factor `Trim28` binding enriched in this CG group.

# KNOWLEDGEBASES

The curated target features are called the knowledgebase sets. We have curated a variety of knowledgebases that represent different categorical and continuous methylation features such as CpGs associated with chromatin states, technical artifacts, gene association and gene expression correlation, transcription factor binding sites, tissue specific methylation, CpG density, etc.

Array knowledgebases are available as listed in the following tables.

| Array | Link |
| --- | --- |
| MSA | <https://github.com/zhou-lab/KYCG_knowledgebase_MSA> |
| Human (EPICv2) | <https://github.com/zhou-lab/KYCG_knowledgebase_EPICv2> |
| Human (EPIC) | <https://github.com/zhou-lab/KYCG_knowledgebase_EPIC> |
| Human (HM450) | <https://github.com/zhou-lab/KYCG_knowledgebase_HM450> |

![Curated CpG knowledgebases](data:image/png;base64...)

The success of enrichment testing depends on the availability of biologically-relevant databases. To reflect the biological meaning of databases and facilitate selective testing, we have organized our database sets into different groups. Each group contains one or multiple databases. Here is how to find the names of pre-built database groups:

```
listDBGroups("MM285")
```

The `listDBGroups()` function returns a data frame containing information of these databases. The Title column is the accession key one needs for the `testEnrichment` function. With the accessions, one can either directly use them in the `testEnrichment` function or explicitly call the `getDBs()` function to retrieve databases themselves. Caching these databases on the local machine is important, for two reasons: it limits the number of requests sent to the Bioconductor server, and secondly it limits the amount of time the user needs to wait when re-downloading database sets. For this reason, one should run `sesameDataCache()` before loading in any database sets. This will take some time to download all of the database sets but this only needs to be done once per installation. During the analysis the database sets can be identified using these accessions. knowYourCG also does some guessing when a unique substring is given. For example, the string “MM285.designGroup” retrieves the “KYCG.MM285.designGroup.20210210” database. Let’s look at the database group which we had used as the query (query and database are reciprocal) in our first example:

```
dbs <- getDBs("MM285.design")
```

```
## Selected the following database groups:
```

```
## 1. KYCG.MM285.designGroup.20210210
```

In total, 32 datasets have been loaded for this group. We can get the “PGCMeth” as an element of the list:

```
str(dbs[["PGCMeth"]])
```

```
##  chr [1:474] "cg36615889_TC11" "cg36646136_BC21" "cg36647910_BC11" ...
##  - attr(*, "group")= chr "KYCG.MM285.designGroup.20210210"
##  - attr(*, "dbname")= chr "PGCMeth"
```

On subsequent runs of the `getDBs()` function, the database loading can be faster thanks to the sesameData [in-memory caching](https://tinyurl.com/2wh9tyzk), if the corresponding database has been loaded.

# ENRICHMENT TESTING

The main work horse function for testing enrichment of a categorical query against categorical databases is the `testEnrichment` function. This function will perform Fisher’s exact testing of the query against each database set (one-tailed by default, but two-tailed optionally) and reports overlap and enrichment statistics.

> **Choice of universe set:** Universe set is the set of all probes for a given platform. It can either be passed in as an argument called `universeSet` or the platform name can be passed with argument `platform`. If neither of these are supplied, the universe set will be inferred from the probes in the query.

```
library(SummarizedExperiment)

## prepare a query
df <- rowData(sesameDataGet('MM285.tissueSignature'))
query <- df$Probe_ID[df$branch == "fetal_brain" & df$type == "Hypo"]

results <- testEnrichment(query, "TFBS", platform="MM285")
results %>% dplyr::filter(overlap>10) %>% head
```

```
## prepare another query
query <- df$Probe_ID[df$branch == "fetal_liver" & df$type == "Hypo"]
results <- testEnrichment(query, "TFBS", platform="MM285")
results %>% dplyr::filter(overlap>10) %>%
    dplyr::select(dbname, estimate, test, FDR) %>% head
```

The output of each test contains multiple variables including: the estimate (fold enrichment), p-value, overlap statistics, type of test, as well as the name of the database set and the database group. By default, the results are sorted by -log10 of the of p-value and the fold enrichment.

The `nQ` and `nD` columns identify the length of the query set and the database set, respectively. Often, it’s important to examine the extent of overlap between the two sets, so that metric is reported as well in the `overlap` column.

A query set represents probes of interest. It may either be in the form of a character vector where the values correspond to probe IDs or a named numeric vector where the names correspond to probe IDs. The query and database definition is rather arbitrary. One can regard a database as a query and turn a query into a database, like in our first example. In real world scenario, query can come from differential methylation testing, unsupervised clustering, correlation with a phenotypic trait, and many others. For example, we could consider CpGs that show tissue-specific methylation as the query. We are getting the B-cell-specific hypomethylation.

```
df <- rowData(sesameDataGet('MM285.tissueSignature'))
query <- df$Probe_ID[df$branch == "B_cell"]
head(query)
```

```
## [1] "cg32668003_TC11" "cg45118317_TC11" "cg37563895_TC11" "cg46105105_BC11"
## [5] "cg47206675_TC21" "cg38855216_TC21"
```

This query set represents hypomethylated probes in Mouse B-cells from the MM285 platform. This specific query set has 168 probes.

# GENE LINK & ENRICHMENT

A special case of set enrichment is to test whether CpGs are associated with specific genes. Automating the enrichment test process only works when the number of database sets is small. This is important when targeting all genes as there are tens of thousands of genes on each platform. By testing only those genes that overlap with the query set, we can greatly reduce the number of tests. For this reason, the gene enrichment analysis is a special case of these enrichment tests. We can perform this analysis using the `buildGeneDBs()` function.

```
library(knowYourCG)
library(sesameData)
library(SummarizedExperiment)
query <- names(sesameData_getProbesByGene("Dnmt3a", "MM285"))
results <- testEnrichment(query,
    buildGeneDBs(query, max_distance=100000, platform="MM285"),
    platform="MM285")
main_stats <- c("dbname","estimate","gene_name","FDR", "nQ", "nD", "overlap")
results[,main_stats]
```

As expected, we recover our targeted gene (Dnmt3a).

Gene enrichment testing can easily be included with default or user specified database sets by setting include\_genes=TRUE:

```
query <- names(sesameData_getProbesByGene("Dnmt3a", "MM285"))
dbs <- c("KYCG.MM285.chromHMM.20210210","KYCG.HM450.TFBSconsensus.20211013",
         "KYCG.MM285.chromosome.mm10.20210630")
results <- testEnrichment(query,databases=dbs,
                          platform="MM285",include_genes=TRUE)
main_stats <- c("dbname","estimate","gene_name","FDR", "nQ", "nD", "overlap")
results[,main_stats] %>% head()
```

One can get all the genes associated with a probe set and test the Gene Ontology of the probe-associated genes using the `linkProbesToProximalGenes` function, which internally utilizes [g:Profiler2](https://biit.cs.ut.ee/gprofiler/gost) for the enrichment analysis:

```
## prepare query probes
df <- rowData(sesameData::sesameDataGet('MM285.tissueSignature'))
query_probes <- df$Probe_ID[df$branch == "fetal_liver" & df$type == "Hypo"]

## link them to genes
genes <- linkProbesToProximalGenes(query_probes, platform = "MM285")$gene_name

## use gprofiler2 to test enrichment
library(gprofiler2)
gostres <- gprofiler2::gost(genes, organism = "mmusculus")
head(gostres$result[order(gostres$result$p_value),])
```

# GENOMIC PROXIMITY

Sometimes it may be of interest whether a query set of probes share close genomic proximity. Co-localization may suggest co-regulation or co-occupancy in the same regulatory element. KYCG can test for genomic proximity using the `testProbeProximity()`function. Poisson statistics for the expected # of co-localized hits from the given query size (lambda) and the actual co-localized CpG pairs along with the p value are returned:

```
df <- rowData(sesameDataGet('MM285.tissueSignature'))
probes <- df$Probe_ID[df$branch == "fetal_liver" & df$type == "Hypo"]
res <- testProbeProximity(probeIDs=probes)
head(res)
```

```
## $Stats
##   num_query hits_query lambda        p.val
## 1       194          4   0.06 6.164188e-09
##
## $Clusters
##   seqnames     start       end distance
## 1     chr1 165770666 165770667       11
## 2     chr1 165770677 165770678   377829
## 3     chr5  75601915  75601916       29
## 4     chr5  75601944  75601945 73617660
## 5     chr9 110235046 110235047       26
## 6     chr9 110235072 110235073       NA
## 7    chr11  32245638  32245639       95
## 8    chr11  32245733  32245734 63088309
```

# Testing Tissue-specific Methylation Enrichment

# SESSION INFO

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.1        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] sesameData_1.28.0           ExperimentHub_3.0.0
## [11] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [13] dbplyr_2.5.1                BiocGenerics_0.56.0
## [15] generics_0.1.4              knowYourCG_1.6.3
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     dplyr_1.1.4          farver_2.1.2
##  [4] blob_1.2.4           filelock_1.0.3       Biostrings_2.78.0
##  [7] S7_0.2.1             fastmap_1.2.0        digest_0.6.39
## [10] lifecycle_1.0.5      KEGGREST_1.50.0      RSQLite_2.4.5
## [13] magrittr_2.0.4       compiler_4.5.2       rlang_1.1.6
## [16] sass_0.4.10          tools_4.5.2          yaml_2.3.12
## [19] knitr_1.51           S4Arrays_1.10.1      bit_4.6.0
## [22] curl_7.0.0           DelayedArray_0.36.0  plyr_1.8.9
## [25] RColorBrewer_1.1-3   abind_1.4-8          withr_3.0.2
## [28] purrr_1.2.0          grid_4.5.2           wheatmap_0.2.0
## [31] colorspace_2.1-2     ggplot2_4.0.1        scales_1.4.0
## [34] dichromat_2.0-0.1    cli_3.6.5            rmarkdown_2.30
## [37] crayon_1.5.3         otel_0.2.0           httr_1.4.7
## [40] reshape2_1.4.5       tzdb_0.5.0           DBI_1.2.3
## [43] cachem_1.1.0         stringr_1.6.0        AnnotationDbi_1.72.0
## [46] BiocManager_1.30.27  XVector_0.50.0       vctrs_0.6.5
## [49] Matrix_1.7-4         jsonlite_2.0.0       hms_1.1.4
## [52] bit64_4.6.0-1        ggrepel_0.9.6        jquerylib_0.1.4
## [55] glue_1.8.0           stringi_1.8.7        gtable_0.3.6
## [58] BiocVersion_3.22.0   tibble_3.3.0         pillar_1.11.1
## [61] rappdirs_0.3.3       htmltools_0.5.9      R6_2.6.1
## [64] httr2_1.2.2          evaluate_1.0.5       lattice_0.22-7
## [67] readr_2.1.6          png_0.1-8            memoise_2.0.1
## [70] bslib_0.9.0          Rcpp_1.1.0           SparseArray_1.10.8
## [73] xfun_0.55            pkgconfig_2.0.3
```