# Contents

* [1 Introduction](#introduction)
  + [1.1 Preparing GO to gene mappings](#preparing-go-to-gene-mappings)
  + [1.2 Setting up the parameter object](#setting-up-the-parameter-object)
  + [1.3 Preparing KEGG to gene mappings](#preparing-kegg-to-gene-mappings)

# 1 Introduction

This vignette is meant as an extension of what already exists in the
[GOstatsHyperG](GOstatsHyperG.html) vignette. It is intended to explain how a
user can run hypergeometric testing on GO terms or KEGG terms when the organism
in question is not supported by an annotation package. The 1st thing for a user
to determine then is whether or not their organism is supported by an organism
package through *[AnnotationForge](https://bioconductor.org/packages/3.22/AnnotationForge)*. In order to do that, they need
only to call the available.dbschemas() method from *[AnnotationForge](https://bioconductor.org/packages/3.22/AnnotationForge)*.

```
library("AnnotationForge")
available.dbschemas()
```

```
##  [1] "ARABIDOPSISCHIP_DB" "BOVINECHIP_DB"      "BOVINE_DB"
##  [4] "CANINECHIP_DB"      "CANINE_DB"          "CHICKENCHIP_DB"
##  [7] "CHICKEN_DB"         "ECOLICHIP_DB"       "ECOLI_DB"
## [10] "FLYCHIP_DB"         "FLY_DB"             "GO_DB"
## [13] "HUMANCHIP_DB"       "HUMANCROSSCHIP_DB"  "HUMAN_DB"
## [16] "INPARANOIDDROME_DB" "INPARANOIDHOMSA_DB" "INPARANOIDMUSMU_DB"
## [19] "INPARANOIDRATNO_DB" "INPARANOIDSACCE_DB" "KEGG_DB"
## [22] "MALARIA_DB"         "MOUSECHIP_DB"       "MOUSE_DB"
## [25] "PFAM_DB"            "PIGCHIP_DB"         "PIG_DB"
## [28] "RATCHIP_DB"         "RAT_DB"             "WORMCHIP_DB"
## [31] "WORM_DB"            "YEASTCHIP_DB"       "YEAST_DB"
## [34] "ZEBRAFISHCHIP_DB"   "ZEBRAFISH_DB"
```

If the organism that you are using is listed here, then your organism is
supported. If not, then you will need to find a source or GO (org KEGG) to gene
mappings. One source for GO to gene mappings is the blast2GO project. But you
might also find such mappings at Ensembl or NCBI. If your organism is not a
typical model organism, then the GO terms you will find are probably going to be
predictions based on sequence similarity measures instead of direct
measurements. This is something that you might want to bear in mind when you
draw conclusions later.

In preparation for our subsequent demonstrations, lets get some data to work
with by borrowing from an organism package. We will assume that you will use
something like `read.table` to load your own annotation packages into a
data.frame object. The starting object needs to be a data.frame with the GO Id’s
in the 1st col, the evidence codes in the 2nd column and the gene Id’s in the
3rd.

```
library("org.Hs.eg.db")
frame = toTable(org.Hs.egGO)
goframeData = data.frame(frame$go_id, frame$Evidence, frame$gene_id)
head(goframeData)
```

```
##   frame.go_id frame.Evidence frame.gene_id
## 1  GO:0002764            IBA             1
## 2  GO:0001869            IDA             2
## 3  GO:0048863            IEA             2
## 4  GO:0006805            TAS             9
## 5  GO:0006805            TAS            10
## 6  GO:0006953            IEA            12
```

## 1.1 Preparing GO to gene mappings

When using GO mappings, it is important to consider the data structure of the GO
ontologies. The terms are organized into a directed acyclic graph. The structure
of the graph creates implications about the mappings of less specific terms to
genes that are mapped to more specific terms. The *[Category](https://bioconductor.org/packages/3.22/Category)* and
*[GOstats](https://bioconductor.org/packages/3.22/GOstats)* packages normally deal with this kind of complexity by
using a special GO2All mapping in the annotation packages. You won’t have one of
those, so instead you will have to make one. *[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)*
provides some simple tools to represent your GO term to gene mappings so that
this process will be easy. First you need to put your data into a GOFrame
object. Then the simple act of casting this object to a GOAllFrame object will
tap into the GO.db package and populate this object with the implicated GO2All
mappings for you.

```
goFrame=GOFrame(goframeData,organism="Homo sapiens")
goAllFrame=GOAllFrame(goFrame)
```

In an effort to standardize the way that we pass this kind of custom
information around, we have chosen to support geneSetCollection objects
from *[GSEABase](https://bioconductor.org/packages/3.22/GSEABase)* package. You can generate one of these objects
in the following way:

```
library("GSEABase")
gsc <- GeneSetCollection(goAllFrame, setType = GOCollection())
```

## 1.2 Setting up the parameter object

Now we can make a parameter object for *[GOstats](https://bioconductor.org/packages/3.22/GOstats)* by using a special
constructor function. For the sake of demonstration, I will just use all the EGs
as the universe and grab some arbitrarily to be the geneIds tested. For your
case, you need to make sure that the gene IDs you use are unique and that they
are the same type for both the universe, the geneIds and the IDs that are part
of your geneSetCollection.

```
library("GOstats")
universe = Lkeys(org.Hs.egGO)
genes = universe[1:500]
params <- GSEAGOHyperGParams(name="My Custom GSEA based annot Params",
                             geneSetCollection=gsc,
                             geneIds = genes,
                             universeGeneIds = universe,
                             ontology = "MF",
                             pvalueCutoff = 0.05,
                             conditional = FALSE,
                             testDirection = "over")
```

And finally we can call `hyperGTest` in the same way we always have before.

```
Over <- hyperGTest(params)
head(summary(Over))
```

```
##       GOMFID       Pvalue OddsRatio    ExpCount Count Size
## 1 GO:0042626 1.279580e-32 25.617147   2.2439717    35   99
## 2 GO:0019829 1.913574e-30 45.989899   1.2239846    27   54
## 3 GO:0003824 2.109777e-27  2.938043 127.0223985   233 5604
## 4 GO:0043168 5.079674e-24  3.206887  55.7819633   135 2461
## 5 GO:0015399 5.791247e-24 12.373965   3.7852856    35  167
## 6 GO:0015662 7.328976e-23 95.420874   0.5666595    17   25
##                                                                  Term
## 1                   ATPase-coupled transmembrane transporter activity
## 2 ATPase-coupled monoatomic cation transmembrane transporter activity
## 3                                                  catalytic activity
## 4                                                       anion binding
## 5                   primary active transmembrane transporter activity
## 6                                     P-type ion transporter activity
```

## 1.3 Preparing KEGG to gene mappings

This is much the same as what you did with the GO mappings except for two
important simplifications. First of all you will no longer need to track
evidence codes, so the object you start with only needs to hold KEGG Ids and
gene IDs. Seconly, since KEGG is not a directed graph, there is no need for a
KEGG to All mapping. Once again I will borrow some data to use as an example.
Notice that we have to put the KEGG Ids in the left hand column of our initial
two column data.frame.

```
frame = toTable(org.Hs.egPATH)
keggframeData = data.frame(frame$path_id, frame$gene_id)
head(keggframeData)
```

```
##   frame.path_id frame.gene_id
## 1         04610             2
## 2         00232             9
## 3         00983             9
## 4         01100             9
## 5         00232            10
## 6         00983            10
```

```
keggFrame=KEGGFrame(keggframeData,organism="Homo sapiens")
```

The rest of the process should be very similar.

```
gsc <- GeneSetCollection(keggFrame, setType = KEGGCollection())
universe = Lkeys(org.Hs.egGO)
genes = universe[1:500]
kparams <- GSEAKEGGHyperGParams(name="My Custom GSEA based annot Params",
                               geneSetCollection=gsc,
                               geneIds = genes,
                               universeGeneIds = universe,
                               pvalueCutoff = 0.05,
                               testDirection = "over")
kOver <- hyperGTest(params)
head(summary(kOver))
```

```
##       GOMFID       Pvalue OddsRatio    ExpCount Count Size
## 1 GO:0042626 1.279580e-32 25.617147   2.2439717    35   99
## 2 GO:0019829 1.913574e-30 45.989899   1.2239846    27   54
## 3 GO:0003824 2.109777e-27  2.938043 127.0223985   233 5604
## 4 GO:0043168 5.079674e-24  3.206887  55.7819633   135 2461
## 5 GO:0015399 5.791247e-24 12.373965   3.7852856    35  167
## 6 GO:0015662 7.328976e-23 95.420874   0.5666595    17   25
##                                                                  Term
## 1                   ATPase-coupled transmembrane transporter activity
## 2 ATPase-coupled monoatomic cation transmembrane transporter activity
## 3                                                  catalytic activity
## 4                                                       anion binding
## 5                   primary active transmembrane transporter activity
## 6                                     P-type ion transporter activity
```

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
##  [1] GOstats_2.76.0         Category_2.76.0        Matrix_1.7-4
##  [4] GO.db_3.22.0           GSEABase_1.72.0        graph_1.88.0
##  [7] annotate_1.88.0        XML_3.99-0.19          org.Hs.eg.db_3.22.0
## [10] AnnotationForge_1.52.0 AnnotationDbi_1.72.0   IRanges_2.44.0
## [13] S4Vectors_0.48.0       Biobase_2.70.0         BiocGenerics_0.56.0
## [16] generics_0.1.4         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10           bitops_1.0-9          lattice_0.22-7
##  [4] RSQLite_2.4.3         digest_0.6.37         evaluate_1.0.5
##  [7] grid_4.5.1            genefilter_1.92.0     bookdown_0.45
## [10] fastmap_1.2.0         blob_1.2.4            jsonlite_2.0.0
## [13] DBI_1.2.3             survival_3.8-3        BiocManager_1.30.26
## [16] httr_1.4.7            Rgraphviz_2.54.0      Biostrings_2.78.0
## [19] jquerylib_0.1.4       cli_3.6.5             rlang_1.1.6
## [22] crayon_1.5.3          XVector_0.50.0        splines_4.5.1
## [25] bit64_4.6.0-1         cachem_1.1.0          yaml_2.3.10
## [28] tools_4.5.1           memoise_2.0.1         curl_7.0.0
## [31] vctrs_0.6.5           R6_2.6.1              png_0.1-8
## [34] matrixStats_1.5.0     lifecycle_1.0.4       KEGGREST_1.50.0
## [37] Seqinfo_1.0.0         RBGL_1.86.0           bit_4.6.0
## [40] pkgconfig_2.0.3       bslib_0.9.0           xfun_0.53
## [43] MatrixGenerics_1.22.0 knitr_1.50            xtable_1.8-4
## [46] htmltools_0.5.8.1     rmarkdown_2.30        compiler_4.5.1
## [49] RCurl_1.98-1.17
```