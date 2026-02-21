# Running fedup with a single test set

#### Catherine Ross

This is an R package that tests for enrichment and depletion of user-defined pathways using a Fisher’s exact test. The method is designed for versatile pathway annotation formats (eg. gmt, txt, xlsx) to allow the user to run pathway analysis on custom annotations. This package is also integrated with Cytoscape to provide network-based pathway visualization that enhances the interpretability of the results.

This vignette will explain how to use `fedup` when testing a single set of genes for pathway enrichment and depletion.

# System prerequisites

**R version** ≥ 4.1
**R packages**:

* **CRAN**: openxlsx, tibble, dplyr, data.table, ggplot2, ggthemes, forcats, RColorBrewer
* **Bioconductor**: RCy3

# Installation

Install `fedup` from Bioconductor:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("fedup")
```

Or install the development version from Github:

```
devtools::install_github("rosscm/fedup", quiet = TRUE)
```

Load necessary packages:

```
library(fedup)
library(dplyr)
library(tidyr)
library(ggplot2)
```

# Running the package

## Input data

Load test genes (`geneSingle`) and pathways annotations (`pathwaysGMT`):

```
data(geneSingle)
data(pathwaysGMT)
```

Take a look at the data structure:

```
str(geneSingle)
#> List of 2
#>  $ background   : chr [1:17804] "SLCO4A1" "PGRMC2" "LDLR" "RABL3" ...
#>  $ FASN_negative: chr [1:379] "SLCO4A1" "PGRMC2" "LDLR" "RABL3" ...
str(head(pathwaysGMT))
#> List of 6
#>  $ REGULATION OF PLK1 ACTIVITY AT G2 M TRANSITION%REACTOME%R-HSA-2565942.1          : chr [1:84] "CSNK1E" "DYNLL1" "TUBG1" "CKAP5" ...
#>  $ GLYCEROPHOSPHOLIPID BIOSYNTHESIS%REACTOME%R-HSA-1483206.4                        : chr [1:126] "PCYT1B" "PCYT1A" "PLA2G4D" "PLA2G4B" ...
#>  $ MITOTIC PROPHASE%REACTOME DATABASE ID RELEASE 74%68875                           : chr [1:134] "SETD8" "NUMA1" "NCAPG2" "LMNB1" ...
#>  $ ACTIVATION OF NF-KAPPAB IN B CELLS%REACTOME%R-HSA-1169091.1                      : chr [1:67] "PSMA6" "PSMA3" "PSMA4" "PSMA1" ...
#>  $ CD28 DEPENDENT PI3K AKT SIGNALING%REACTOME DATABASE ID RELEASE 74%389357         : chr [1:22] "CD28" "THEM4" "AKT1" "TRIB3" ...
#>  $ UBIQUITIN-DEPENDENT DEGRADATION OF CYCLIN D%REACTOME DATABASE ID RELEASE 74%75815: chr [1:52] "PSMA6" "PSMA3" "PSMA4" "PSMA1" ...
```

To see more info on this data, run `?geneDouble` or `?pathwaysGMT`. You could also run `example("prepInput", package = "fedup")` or `example("readPathways", package = "fedup")` to see exactly how the data was generated using the `prepInput()` and `readPathways()` functions. `?` and `example()` can be used on any other functions mentioned here to see their documentation and run examples.

The sample `geneSingle` list object contains two vector elements: `background` and `FASN_negative`. The `background` consists of all genes that the test sets (in this case `FASN_negative`) will be compared against. `FASN_negative` consists of genes that form **negative genetic interactions** with the *FASN* gene after CRISPR-Cas9 knockout. If you’re interested in seeing how this data set was constructed, check out the [code](https://github.com/rosscm/fedup/blob/main/inst/script/genes.R). Also, the paper the data was taken from is found [here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7566881/).

Given that [*FASN*](https://www.genecards.org/cgi-bin/carddisp.pl?gene=FASN) is a fatty acid synthase, we would expect to see **enrichment** of the negative interactions for pathways associated with *sensitization* of fatty acid synthesis, as well as **enrichment** of the positive interactions for pathways associated with *suppression* of the function. Conversely, we expect to find **depletion** for pathways not at all involved with *FASN* biology. Let’s see!

## Pathway analysis

Now use `runFedup` on the sample data:

```
fedupRes <- runFedup(geneSingle, pathwaysGMT)
#> Running fedup with:
#>  => 1 test set(s)
#>   + FASN_negative: 379 genes
#>  => 17804 background genes
#>  => 1437 pathway annotations
#> All done!
```

The `fedupRes` output is a list of length `length(which(names(geneSingle) != "background"))`, corresponding to the number of test sets in `geneSingle` (i.e., 1).

View `fedup` results for `FASN_negative` sorted by pvalue:

```
set <- "FASN_negative"
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "enriched"),]))
#>                                                                                                                                          pathway
#>                                                                                                                                           <char>
#> 1:                                                                      ASPARAGINE N-LINKED GLYCOSYLATION%REACTOME DATABASE ID RELEASE 74%446203
#> 2: BIOSYNTHESIS OF THE N-GLYCAN PRECURSOR (DOLICHOL LIPID-LINKED OLIGOSACCHARIDE, LLO) AND TRANSFER TO A NASCENT PROTEIN%REACTOME%R-HSA-446193.1
#> 3:                                                  DISEASES ASSOCIATED WITH N-GLYCOSYLATION OF PROTEINS%REACTOME DATABASE ID RELEASE 74%3781860
#> 4:                                                        INTRA-GOLGI AND RETROGRADE GOLGI-TO-ER TRAFFIC%REACTOME DATABASE ID RELEASE 74%6811442
#> 5:                                                                         RAB REGULATION OF TRAFFICKING%REACTOME DATABASE ID RELEASE 74%9007101
#> 6:                                                                                            DISEASES OF GLYCOSYLATION%REACTOME%R-HSA-3781865.1
#>     size real_frac expected_frac fold_enrichment   status    real_gene
#>    <int>     <num>         <num>           <num>   <char>       <list>
#> 1:   286  8.179420    1.53336329        5.334300 enriched MOGS, DO....
#> 2:    78  3.693931    0.42125365        8.768901 enriched DOLPP1, ....
#> 3:    17  2.110818    0.09548416       22.106472 enriched MOGS, AL....
#> 4:   183  4.749340    0.99415862        4.777246 enriched ARL1, RA....
#> 5:   120  3.693931    0.62345540        5.924933 enriched RAB18, T....
#> 6:   139  3.957784    0.74702314        5.298074 enriched MOGS, AL....
#>          pvalue       qvalue
#>           <num>        <num>
#> 1: 1.596605e-12 2.294321e-09
#> 2: 6.358461e-09 4.568554e-06
#> 3: 3.054616e-08 1.463161e-05
#> 4: 2.516179e-07 9.039372e-05
#> 5: 4.945154e-07 1.421237e-04
#> 6: 7.240716e-07 1.734151e-04
print(head(fedupRes[[set]][which(fedupRes[[set]]$status == "depleted"),]))
#>                                                               pathway  size
#>                                                                <char> <int>
#> 1:                        GPCR LIGAND BINDING%REACTOME%R-HSA-500792.3   454
#> 2: OLFACTORY SIGNALING PATHWAY%REACTOME DATABASE ID RELEASE 74%381753   396
#> 3:       CLASS A 1 (RHODOPSIN-LIKE RECEPTORS)%REACTOME%R-HSA-373076.7   323
#> 4:             NEURONAL SYSTEM%REACTOME DATABASE ID RELEASE 74%112316   379
#> 5:           PEPTIDE LIGAND-BINDING RECEPTORS%REACTOME%R-HSA-375276.5   195
#> 6:             KERATINIZATION%REACTOME DATABASE ID RELEASE 74%6805567   217
#>    real_frac expected_frac fold_enrichment   status    real_gene      pvalue
#>        <num>         <num>           <num>   <char>       <list>       <num>
#> 1: 0.0000000     2.3702539       0.0000000 depleted              0.000318537
#> 2: 0.0000000     1.9096832       0.0000000 depleted              0.001508862
#> 3: 0.0000000     1.6906313       0.0000000 depleted              0.003316944
#> 4: 0.5277045     2.0950348       0.2518834 depleted KCNK2, P.... 0.026904721
#> 5: 0.0000000     1.0166255       0.0000000 depleted              0.057057149
#> 6: 0.0000000     0.8425073       0.0000000 depleted              0.079543380
#>        qvalue
#>         <num>
#> 1: 0.01760530
#> 2: 0.05420587
#> 3: 0.10361845
#> 4: 0.42024004
#> 5: 0.57670567
#> 6: 0.67813171
```

Here we see the strongest enrichment for the `ASPARAGINE N-LINKED GLYCOSYLATION` pathway. Given that *FASN* mutant cells show a strong dependence on lipid uptake, this enrichment for negative interactions with genes involved in glycosylation is expected. We also see significant enrichment for other related pathways, including `DISEASES ASSOCIATED WITH N-GLYCOSYLATION OF PROTEINS` and `DISEASES OF GLYCOSYLATION`. Conversely, we see significant depletion for functions not associated with these processes, such as `OLFACTORY SIGNALING PATHWAY`, `GPCR LIGAND BINDING` and `KERATINIZATION`. Nice!

## Dot plot

Prepare data for plotting via `dplyr` and `tidyr`:

```
fedupPlot <- fedupRes %>%
    bind_rows(.id = "set") %>%
    separate(col = "set", into = c("set", "sign"), sep = "_") %>%
    subset(qvalue < 0.05) %>%
    mutate(log10qvalue = -log10(qvalue)) %>%
    mutate(pathway = gsub("\\%.*", "", pathway)) %>%
    mutate(status = factor(status, levels = c("enriched", "depleted"))) %>%
    as.data.frame()
```

If you’re interested, take a look at `?dplyr::bind_rows` for details on how the output `fedup` results list (`fedupRes`) was bound into a single dataframe and `?tidyr::separate` for how the `sign` column was created.

Plot significant results (qvalue < 0.05) in the form of a dot plot via `plotDotPlot`. Facet points by the `status` column:

```
p <- plotDotPlot(
        df = fedupPlot,
        xVar = "log10qvalue",
        yVar = "pathway",
        xLab = "-log10(qvalue)",
        fillVar = "status",
        fillLab = "Enrichment\nstatus",
        sizeVar = "fold_enrichment",
        sizeLab = "Fold enrichment") +
    facet_grid("status", scales = "free", space = "free") +
    theme(strip.text.y = element_blank())
print(p)
```

![](data:image/png;base64...)

We can also colour in the points via the `sign` column from `fedupPlot`, while still faceting by `status`:

```
p <- plotDotPlot(
        df = fedupPlot,
        xVar = "log10qvalue",
        yVar = "pathway",
        xLab = "-log10(qvalue)",
        fillVar = "sign",
        fillLab = "Genetic interaction",
        fillCol = "#6D90CA",
        sizeVar = "fold_enrichment",
        sizeLab = "Fold enrichment") +
    facet_grid("status", scales = "free", space = "free") +
    theme(strip.text.y = element_blank())
print(p)
```

![](data:image/png;base64...)

Look at all those chick… enrichments! This is a bit overwhelming, isn’t it? How do we interpret these 38 fairly redundant pathways in a way that doesn’t hurt our tired brains even more? Oh I know, let’s use an enrichment map!

## Enrichment map

First, make sure to have [Cytoscape](https://cytoscape.org/download.html) downloaded and and open on your computer. You’ll also need to install the [EnrichmentMap](http://apps.cytoscape.org/apps/enrichmentmap) (≥ v3.3.0) and [AutoAnnotate](http://apps.cytoscape.org/apps/autoannotate) apps.

Then format results for compatibility with EnrichmentMap using `writeFemap`:

```
resultsFolder <- tempdir()
writeFemap(fedupRes, resultsFolder)
#> Wrote out EM-formatted fedup results file to /tmp/RtmpW1lmCa/femap_FASN_negative.txt
```

Prepare a pathway annotation file (gmt format) from the pathway list you passed to `runFedup` using the `writePathways` function (you don’t need to run this function if your pathway annotations are already in gmt format, but it doesn’t hurt to make sure):

```
gmtFile <- tempfile("pathwaysGMT", fileext = ".gmt")
writePathways(pathwaysGMT, gmtFile)
#> Wrote out pathway gmt file to /tmp/RtmpW1lmCa/pathwaysGMT5a82a1922cb78.gmt
```

Cytoscape is open right? If so, run these lines and let the `plotFemap` magic happen:

```
netFile <- tempfile("fedupEM_geneSingle", fileext = ".png")
plotFemap(
    gmtFile = gmtFile,
    resultsFolder = resultsFolder,
    qvalue = 0.05,
    chartData = "NES_VALUE",
    hideNodeLabels = TRUE,
    netName = "fedupEM_geneSingle",
    netFile = netFile
)
```

![](data:image/png;base64...)

After some manual rearrangement of the annotated pathway clusters, this is the resulting enrichment map we get from our `fedup` results. Much better!

This has effectively summarized the 36 pathways from our dot plot into 9 unique biological themes (including 4 unclustered pathways). We can now see clear themes in the data pertaining to negative *FASN* genetic interactions, such as `glycan diseases, glycosylation`, `retrograde golgi transport`, and `Rab regulation trafficking`.

# Session information

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ggplot2_4.0.0 tidyr_1.3.1   dplyr_1.1.4   fedup_1.0.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] devtools_2.4.6      remotes_2.5.0       caTools_1.18.3
#>  [7] processx_3.8.6      callr_3.7.6         vctrs_0.6.5
#> [10] tools_4.5.1         ps_1.9.1            bitops_1.0-9
#> [13] generics_0.1.4      stats4_4.5.1        curl_7.0.0
#> [16] base64url_1.4       tibble_3.3.0        pkgconfig_2.0.3
#> [19] KernSmooth_2.23-26  data.table_1.17.8   RColorBrewer_1.1-3
#> [22] S7_0.2.0            desc_1.4.3          RCy3_2.30.0
#> [25] uuid_1.2-1          graph_1.88.0        lifecycle_1.0.4
#> [28] stringr_1.5.2       compiler_4.5.1      farver_2.1.2
#> [31] gplots_3.2.0        repr_1.1.7          htmltools_0.5.8.1
#> [34] usethis_3.2.1       sass_0.4.10         RCurl_1.98-1.17
#> [37] yaml_2.3.10         pillar_1.11.1       crayon_1.5.3
#> [40] jquerylib_0.1.4     ellipsis_0.3.2      cachem_1.1.0
#> [43] sessioninfo_1.2.3   gtools_3.9.5        zip_2.3.3
#> [46] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7
#> [49] purrr_1.1.0         labeling_0.4.3      ggthemes_5.1.0
#> [52] forcats_1.0.1       RJSONIO_2.0.0       fastmap_1.2.0
#> [55] grid_4.5.1          cli_3.6.5           magrittr_2.0.4
#> [58] base64enc_0.1-3     dichromat_2.0-0.1   XML_3.99-0.19
#> [61] pkgbuild_1.4.8      IRdisplay_1.1       withr_3.0.2
#> [64] scales_1.4.0        backports_1.5.0     IRkernel_1.3.2
#> [67] rmarkdown_2.30      httr_1.4.7          pbdZMQ_0.3-14
#> [70] openxlsx_4.2.8      memoise_2.0.1       evaluate_1.0.5
#> [73] knitr_1.50          rlang_1.1.6         Rcpp_1.1.0
#> [76] glue_1.8.0          BiocGenerics_0.56.0 pkgload_1.4.1
#> [79] jsonlite_2.0.0      R6_2.6.1            fs_1.6.6
```