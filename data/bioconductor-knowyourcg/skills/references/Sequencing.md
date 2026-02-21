[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/knowYourCG.html)](index.html)

* [Sequencing Data](Sequencing.html)
* [Array Data](Array.html)
* [Continuous Data](Continuous.html)
* [Visualization](visualization.html)

# Functional Analysis of DNAm Sequencing Data

KnowYourCG (KYCG) is a supervised learning framework designed for the functional analysis of DNA methylation data. Unlike existing tools that focus on genes or genomic intervals, KnowYourCG directly targets CpG dinucleotides, featuring automated supervised screenings of diverse biological and technical influences, including sequence motifs, transcription factor binding, histone modifications, replication timing, cell-type-specific methylation, and trait associations. KnowYourCG addresses the challenges of data sparsity in various methylation datasets, including low-pass Nanopore sequencing, single-cell DNA methylomes, 5-hydroxymethylation profiles, spatial DNA methylation maps, and array-based datasets for epigenome-wide association studies and epigenetic clocks.

The input to KYCG is a CpG set (query). The CpG sets can represent differential methylation, results from an epigenome-wide association studies, or any sets that may be derived from analysis. If analyzing **sequencing data**, the preferred format is a YAME-compressed binary vector of 0 and 1 to indicate whether the CpG is in set. This format assume a specific order of CpGs following the genomic coordinates. Since it’s a coordinate-free approach, the reference coordinate is critical. Please refer to the YAME documentation for details. <https://zhou-lab.github.io/YAME/>.

![KYCG workflow](data:image/png;base64...)

# QUICK START

```
# Code that should run only on non-Windows systems
library(knowYourCG)

# Download query and knowledgebase datasets:
temp_dir <- tempdir()
knowledgebase <- file.path(temp_dir, "ChromHMM.20220414.cm")
query <- file.path(temp_dir, "mm10_f3_10cells.cg")
knowledgebase_url <- "https://zenodo.org/records/18175656/files/ChromHMM.20220414.cm"
query_url <- "https://zenodo.org/records/18176004/files/mm10_f3_10cells.cg"
download.file(knowledgebase_url, destfile = knowledgebase)
download.file(query_url, destfile = query)

# test enrichment (require YAME installed in shell)
res = testEnrichment(query, knowledgebase)
KYCG_plotDot(res, short_label=TRUE)
```

![](data:image/png;base64...)

# KNOWLEDGEBASES

The curated target features are called the knowledgebase sets. We have curated a variety of knowledgebases that represent different categorical and continuous methylation features such as CpGs associated with chromatin states, technical artifacts, gene association and gene expression correlation, transcription factor binding sites, tissue specific methylation, CpG density, etc.

Whole-genome knowledgebases are available as listed in the following tables.

| Assembly | Link |
| --- | --- |
| human (hg38) | <https://zenodo.org/records/18175838> |
| mouse (mm10) | <https://zenodo.org/records/18175656> |

![Curated CpG knowledgebases](data:image/png;base64...)

# INPUT FORMAT

For non-array data, CpG sets (query, knowledgebase, and universe) should be formated using YAME. YAME supports binary representation of a set (format “b”) and optionally with a universe (format “d”). Format “d” can be created from format “b” using the `yame mask` function.

If you have a BED-formated data, you can pack it to YAME-“b” format using the following pipeline. This pipeline requires [BEDTools](https://bedtools.readthedocs.io/en/latest/content/installation.html) and a reference coordinate file (YAME-“r”) available below:

| Assembly | Link |
| --- | --- |
| human (hg38) | <https://zenodo.org/records/18175838/files/cpg_nocontig.cr> |
| mouse (mm10) | <https://zenodo.org/records/18175656/files/cpg_nocontig.cr> |

```
yame unpack cpg_nocontig.cr | bedtools intersect -a - -b [your_input.bed] -c -sorted |
  cut -f4 | yame pack -fb - > [your_input.cg]
```

The above assumes your input is already sorted. Check out the [bedtools instersect](https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html) if you encounter any problems at this step.

# ENRICHMENT TESTING

Then we simply run [`yame summary`](%7B%25%20link%20docs/summarize.markdown%20%25%7D) with `-m` feature file for enrichment testing. We have provided comprehensive enrichment feature files, and you can download them from Zenodo [mm10](https://zenodo.org/records/18175656)/[hg38](https://zenodo.org/records/18175838). You can also create your own feature file with [`yame pack`](%7B%25%20link%20docs/pack_unpack.markdown%20%25%7D).

```
yame summary -m feature.cm yourfile.cg > yourfile.txt
```

Detailed information of the output columns can be found on the [`yame summary`](%7B%25%20link%20docs/summarize.markdown%20%25%7D) page. Basically, a higher log2oddsratio indicates a stronger association between the feature being tested and the query set. Generally, a large log2 odds ratio is typically considered to be around 2 or greater, with values between 1 and 2 often being viewed as potentially important and worthy of further investigation, while values around 0.5 might be considered a small effect size. For significance testing, [seasame](https://www.bioconductor.org/packages/release/bioc/html/sesame.html) R package provided the testEnrichmentFisherN function, which is also provided in the yame github R page. The four input parameters correspond to the four columns from yame summary output.

```
ND = N_mask
NQ = N_query
NDQ = N_overlap
NU = N_universe
```

We can create a coarse differential methylation datasets the following way

```
yame pairwise -H 1 -c 10 sample1.cg sample2.cg -o output.cg
```

-H controls directionality and -c controls minimum coverage.

The output is a query CG sets with proper universe background. Selecting the appropriate background for enrichment testing is crucial because it can significantly impact the interpretation of the results. Usually, we use the background set that is measured in the experiment under different conditions.

```
yame mask -c query.cg universe.cg | yame summary -m feature.cm - > yourfile.txt
```

The following is an analysis example in R that explicitly call `yame` in R.

```
df = tibble(read.table(text=system("yame summary -m ~/references/mm10/KYCGKB_mm10/stranded/kmer10.20231201.cm /mnt/isilon/zhou_lab/projects/20230727_all_public_WGBS/mm10_stranded/20231201_neuron_MeCP2.cg", intern=TRUE), head=T))
```

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
##  [1] sesame_1.28.1               knitr_1.51
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.1        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] sesameData_1.28.0           ExperimentHub_3.0.0
## [13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [15] dbplyr_2.5.1                BiocGenerics_0.56.0
## [17] generics_0.1.4              knowYourCG_1.6.3
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      dplyr_1.1.4           farver_2.1.2
##  [4] blob_1.2.4            filelock_1.0.3        Biostrings_2.78.0
##  [7] S7_0.2.1              fastmap_1.2.0         digest_0.6.39
## [10] lifecycle_1.0.5       KEGGREST_1.50.0       RSQLite_2.4.5
## [13] magrittr_2.0.4        compiler_4.5.2        rlang_1.1.6
## [16] sass_0.4.10           tools_4.5.2           yaml_2.3.12
## [19] labeling_0.4.3        S4Arrays_1.10.1       bit_4.6.0
## [22] curl_7.0.0            DelayedArray_0.36.0   plyr_1.8.9
## [25] RColorBrewer_1.1-3    BiocParallel_1.44.0   abind_1.4-8
## [28] withr_3.0.2           purrr_1.2.0           grid_4.5.2
## [31] preprocessCore_1.72.0 wheatmap_0.2.0        colorspace_2.1-2
## [34] ggplot2_4.0.1         scales_1.4.0          dichromat_2.0-0.1
## [37] cli_3.6.5             rmarkdown_2.30        crayon_1.5.3
## [40] otel_0.2.0            httr_1.4.7            reshape2_1.4.5
## [43] tzdb_0.5.0            DBI_1.2.3             cachem_1.1.0
## [46] stringr_1.6.0         parallel_4.5.2        AnnotationDbi_1.72.0
## [49] BiocManager_1.30.27   XVector_0.50.0        vctrs_0.6.5
## [52] Matrix_1.7-4          jsonlite_2.0.0        hms_1.1.4
## [55] bit64_4.6.0-1         ggrepel_0.9.6         fontawesome_0.5.3
## [58] jquerylib_0.1.4       glue_1.8.0            codetools_0.2-20
## [61] stringi_1.8.7         gtable_0.3.6          BiocVersion_3.22.0
## [64] tibble_3.3.0          pillar_1.11.1         rappdirs_0.3.3
## [67] htmltools_0.5.9       R6_2.6.1              httr2_1.2.2
## [70] evaluate_1.0.5        lattice_0.22-7        readr_2.1.6
## [73] png_0.1-8             memoise_2.0.1         bslib_0.9.0
## [76] Rcpp_1.1.0            SparseArray_1.10.8    xfun_0.55
## [79] pkgconfig_2.0.3
```