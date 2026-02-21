# An introduction to biodbKegg

Pierrick Roger

#### 26 October 2021

#### Package

biodbKegg 1.0.0

# 1 Introduction

biodbKegg is a *biodb* extension package that implements a connector to
KEGG Compound database (Kanehisa and Goto 2000).

# 2 Installation

Install using Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('biodbKegg')
```

# 3 Initialization

The first step in using *biodbKegg*, is to create an instance of the biodb
class `BiodbMain` from the main *biodb* package. This is done by calling the
constructor of the class:

```
mybiodb <- biodb::newInst()
```

During this step the configuration is set up, the cache system is initialized
and extension packages are loaded.

We will see at the end of this vignette that the *biodb* instance needs to be
terminated with a call to the `terminate()` method.

# 4 Creating a connector to KEGG Compound database

In *biodb* the connection to a database is handled by a connector instance that
you can get from the factory.
biodbKegg implements a connector to a remote database.
Here is the code to instantiate a connector:

```
kegg.comp.conn <- mybiodb$getFactory()$createConn('kegg.compound')
```

```
## Loading required package: biodbKegg
```

# 5 Accessing entries

To retrieve entries, use:

```
entries <- kegg.comp.conn$getEntry(c('C00133', 'C00751'))
entries
```

```
## [[1]]
## Biodb KEGG Compound entry instance C00133.
##
## [[2]]
## Biodb KEGG Compound entry instance C00751.
```

To convert a list of entries into a dataframe, run:

```
x <- mybiodb$entriesToDataframe(entries, compute=FALSE)
x
```

```
##   accession monoisotopic.mass formula molecular.mass
## 1    C00133           89.0477 C3H7NO2        89.0932
## 2    C00751          410.3913  C30H50       410.7180
##                                      name   cas.id ncbi.pubchem.comp.id
## 1 D-Alanine;D-2-Aminopropionic acid;D-Ala 338-69-2                 3433
## 2             Squalene;Spinacene;Supraene 111-02-4                 4013
##   chebi.id
## 1    15570
## 2    15440
##                                                                                                                kegg.reaction.id
## 1 R00399;R00401;R01147;R01148;R01149;R01150;R01225;R01344;R02718;R04369;R04611;R05861;R07651;R08850;R09588;R09595;R11965;R12557
## 2                                    R02872;R02874;R02875;R02876;R06223;R07322;R07323;R08535;R09712;R10167;R10169;R11401;R12355
##                                                                                                                         kegg.enzyme.id
## 1 1.4.3.3;1.4.3.19;2.1.2.7;2.3.1.263;2.3.2.14;2.6.1.21;3.1.1.103;3.4.13.22;3.4.17.8;5.1.1.1;6.1.1.13;6.1.2.1;6.3.2.4;6.3.2.16;6.3.2.35
## 2                                    1.3.1.96;1.14.14.17;1.14.19.-;1.17.8.1;2.1.1.262;2.5.1.21;4.2.1.123;4.2.1.129;5.4.99.17;5.4.99.37
##                                                           kegg.pathway.id
## 1                   map00470;map00550;map01100;map01502;map01503;map04742
## 2 map00100;map00909;map01060;map01062;map01066;map01070;map01100;map01110
##   kegg.compound.id lipidmaps.structure.id
## 1           C00133                   <NA>
## 2           C00751         LMPR0106010002
```

# 6 Search for compounds of a certain mass

```
ids <- kegg.comp.conn$searchForEntries(list(monoisotopic.mass=list(value=64, delta=2.0)), max.results=10)
entries <- mybiodb$getFactory()$getEntry('kegg.compound', ids)
```

# 7 Add information to a data frame containing KEGG Compound IDs

If you have a data frame containing a column with KEGG Compound IDs, you can
add information such as associated KEGG Enzymes, associated KEGG Pathways and
KEGG Modules to your data frame, for a specific organism.

For the example we use the list of compound IDs we already have, to construct a
data frame:

```
kegg.comp.ids <- c('C06144', 'C06178', 'C02659')
mydf <- data.frame(kegg.ids=kegg.comp.ids)
```

Using the `addInfo()` method of `KeggCompoundConn` class, we add information
about pathways, enzymes and modules for these compounds:

```
kegg.comp.conn$addInfo(mydf, id.col='kegg.ids', org='mmu')
```

```
##   kegg.ids               kegg.enzyme.id
## 1   C06144                     4.2.1.27
## 2   C06178                     1.4.3.21
## 3   C02659 1.14.14.41|2.4.1.63|3.2.1.21
##                                                 kegg.reaction.id
## 1                                                  R01611;R01367
## 2                                           R01853;R02382;R02529
## 3 R10030;R10034;R11597|R03625;R04948;R10037|R00026;R00306;R02558
##     kegg.pathway.id
## 1 mmu00650|mmu01100
## 2 mmu00760|mmu01100
## 3          mmu01100
##                                                                                         kegg.pathway.name
## 1                   Butanoate metabolism - Mus musculus (mouse)|Metabolic pathways - Mus musculus (mouse)
## 2 Nicotinate and nicotinamide metabolism - Mus musculus (mouse)|Metabolic pathways - Mus musculus (mouse)
## 3                                                               Metabolic pathways - Mus musculus (mouse)
##                           kegg.pathway.pathway.class       kegg.module.id
## 1              Metabolism;Carbohydrate metabolism|NA M00027|M00001|M00002
## 2 Metabolism;Metabolism of cofactors and vitamins|NA M00912|M00001|M00002
## 3                                               <NA> M00001|M00002|M00003
##                                                                                                                                                        kegg.module.name
## 1                   GABA (gamma-Aminobutyrate) shunt|Glycolysis (Embden-Meyerhof pathway), glucose => pyruvate|Glycolysis, core module involving three-carbon compounds
## 2 NAD biosynthesis, tryptophan => quinolinate => NAD|Glycolysis (Embden-Meyerhof pathway), glucose => pyruvate|Glycolysis, core module involving three-carbon compounds
## 3       Glycolysis (Embden-Meyerhof pathway), glucose => pyruvate|Glycolysis, core module involving three-carbon compounds|Gluconeogenesis, oxaloacetate => fructose-6P
```

Note that, by default, the number of values for each field is limited to 3.
Please see the help page of `KeggCompoundConn` for more information about
`addInfo()`, and a description of all parameters.

The list of organisms is available at
<https://www.genome.jp/kegg/catalog/org_list.html>.

# 8 Getting pathways related to compounds using KEGG databases

In this example we will look for pathways related to specified compounds, count
to how many pathways each compound is related, build a pathway graph, and
create a decorated pathway graph picture.

For that we will start from a given list of KEGG compound IDs, and explore KEGG
to find to which organisms they can be related and try to discover links
between them through KEGG pathways.

As an example, we will start from a predefined list of KEGG compound IDs, and
focus on one organism, the mouse.

## 8.1 Look for pathways related to specified compounds

Given a list of compounds and an organism, we can look for related pathways in
a single command:

```
kegg.comp.ids <- c('C06144', 'C06178', 'C02659')
pathways <- kegg.comp.conn$getPathwayIds(kegg.comp.ids, 'mmu')
pathways
```

```
## [1] "mmu00650" "mmu01100" "mmu00760"
```

## 8.2 Count to how many pathways each compound is related

With another function we can get the pathways found for each compound:

```
path.per.comp <- kegg.comp.conn$getPathwayIdsPerCompound(kegg.comp.ids, 'mmu')
fct <- function(i) {
    if (i %in% names(path.per.comp)) length(path.per.comp[[i]]) else 0
}
nb_mmu_gene_pathways <- vapply(kegg.comp.ids, fct, FUN.VALUE=0)
names(nb_mmu_gene_pathways) <- kegg.comp.ids
```

Here, in the final table, we list the number of pathways for each KEGG
compound:

```
nb_mmu_gene_pathways
```

```
## C06144 C06178 C02659
##      2      2      1
```

## 8.3 Build a pathway graph

To build a pathway graph, we need a connector to the KEGG Pathway database:

```
kegg.path.conn <- mybiodb$getFactory()$getConn('kegg.pathway')
```

Building list of edges and vertices for pathways is done by calling
buildPathwayGraph():

```
kegg.path.conn$buildPathwayGraph(pathways[[1]])
```

```
## $vertices
##      name     type     id
## 1  C00025 compound C00025
## 2  C00334 compound C00334
## 3  C00011 compound C00011
## 4  R00261 reaction R00261
## 6  C00026 compound C00026
## 7  C00232 compound C00232
## 9  R01648 reaction R01648
## 11 C00022 compound C00022
## 13 C00041 compound C00041
## 14 R10178 reaction R10178
## 16 C00003 compound C00003
## 17 C00001 compound C00001
## 18 C00042 compound C00042
## 19 C00004 compound C00004
## 20 C00080 compound C00080
## 21 R00713 reaction R00713
## 23 C00006 compound C00006
## 26 C00005 compound C00005
## 28 R00714 reaction R00714
##
## $edges
##      from     to
## 1  C00025 R00261
## 2  R00261 C00334
## 3  R00261 C00011
## 4  C00334 R01648
## 5  C00026 R01648
## 6  R01648 C00232
## 7  R01648 C00025
## 8  C00334 R10178
## 9  C00022 R10178
## 10 R10178 C00232
## 11 R10178 C00041
## 12 C00232 R00713
## 13 C00003 R00713
## 14 C00001 R00713
## 15 R00713 C00042
## 16 R00713 C00004
## 17 R00713 C00080
## 18 C00232 R00714
## 19 C00006 R00714
## 20 C00001 R00714
## 21 R00714 C00042
## 22 R00714 C00005
## 23 R00714 C00080
```

The object returned is a list whose names are the pathway IDs submitted, and
the values are lists containing two data frames (edges and vertices).

We can also get an igraph object for the a pathway (or a list of pathways):

```
ig <- kegg.path.conn$getPathwayIgraph(pathways[[1]])
```

And we plot it:

```
vert <- igraph::as_data_frame(ig, 'vertices')
shapes <- vapply(vert[['type']], function(x) if (x == 'reaction') 'rectangle'
                 else 'circle', FUN.VALUE='', USE.NAMES=FALSE)
colors <- vapply(vert[['type']], function(x) if (x == 'reaction') 'yellow' else
    'red', FUN.VALUE='', USE.NAMES=FALSE)
plot(ig, vertex.shape=shapes, vertex.color=colors, vertex.label.dist=1,
     vertex.size=4, vertex.size2=4)
```

![](data:image/png;base64...)

## 8.4 Create a decorated pathway graph picture

We will now use a KEGG pathway picture and highlight some of the enzymes and
compounds on it.

For this, we first get the enzymes related to the compounds:

```
kegg.enz.ids <- mybiodb$entryIdsToSingleFieldValues(kegg.comp.ids,
                                                    db='kegg.compound',
                                                    field='kegg.enzyme.id')
kegg.enz.ids
```

```
## [1] "4.2.1.27"   "1.4.3.21"   "1.14.14.41" "2.4.1.63"   "3.2.1.21"
## [6] "4.1.2.46"   "4.1.2.47"
```

define the colors we want to apply:

```
color2ids <- list(yellow=kegg.enz.ids, red=kegg.comp.ids)
```

Then we call the method that builds the highlighted image and print it:

```
kegg.path.conn$getDecoratedGraphPicture(pathways[[1]],
    color2ids=color2ids)
```

![](data:image/png;base64...)

# 9 Terminate the biodb instance

When done with your *biodb* instance you have to terminate it, in order to
ensure release of resources (file handles, database connection, etc):

```
mybiodb$terminate()
```

```
## INFO  [16:55:59.631] Closing BiodbMain instance...
## INFO  [16:55:59.633] Connector "kegg.compound" deleted.
## INFO  [16:55:59.640] Connector "kegg.enzyme" deleted.
## INFO  [16:55:59.642] Connector "kegg.pathway" deleted.
## INFO  [16:55:59.643] Connector "kegg.module" deleted.
## INFO  [16:55:59.644] Connector "kegg.reaction" deleted.
```

# 10 Session information

```
sessionInfo()
```

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodbKegg_1.0.0  BiocStyle_2.22.0
##
## loaded via a namespace (and not attached):
##  [1] progress_1.2.2      tidyselect_1.1.1    xfun_0.27
##  [4] bslib_0.3.1         purrr_0.3.4         vctrs_0.3.8
##  [7] generics_0.1.1      htmltools_0.5.2     BiocFileCache_2.2.0
## [10] yaml_2.2.1          utf8_1.2.2          blob_1.2.2
## [13] XML_3.99-0.8        rlang_0.4.12        jquerylib_0.1.4
## [16] pillar_1.6.4        withr_2.4.2         glue_1.4.2
## [19] DBI_1.1.1           rappdirs_0.3.3      bit64_4.0.5
## [22] dbplyr_2.1.1        lifecycle_1.0.1     plyr_1.8.6
## [25] stringr_1.4.0       memoise_2.0.0       evaluate_0.14
## [28] knitr_1.36          fastmap_1.1.0       curl_4.3.2
## [31] fansi_0.5.0         highr_0.9           biodb_1.2.0
## [34] Rcpp_1.0.7          openssl_1.4.5       filelock_1.0.2
## [37] BiocManager_1.30.16 cachem_1.0.6        magick_2.7.3
## [40] jsonlite_1.7.2      bit_4.0.4           hms_1.1.1
## [43] chk_0.7.0           askpass_1.1         digest_0.6.28
## [46] stringi_1.7.5       bookdown_0.24       dplyr_1.0.7
## [49] bitops_1.0-7        tools_4.1.1         magrittr_2.0.1
## [52] sass_0.4.0          RCurl_1.98-1.5      RSQLite_2.2.8
## [55] tibble_3.1.5        crayon_1.4.1        pkgconfig_2.0.3
## [58] ellipsis_0.3.2      prettyunits_1.1.1   assertthat_0.2.1
## [61] rmarkdown_2.11      httr_1.4.2          lgr_0.4.3
## [64] R6_2.5.1            igraph_1.2.7        compiler_4.1.1
```

# References

Kanehisa, Minoru, and Susumu Goto. 2000. “KEGG: Kyoto Encyclopedia of Genes and Genomes.” *Nucleic Acids Research* 28 (1): 27–30. <https://doi.org/10.1093/nar/28.1.27>.