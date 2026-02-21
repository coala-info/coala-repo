# The transcriptogramer user’s guide

Diego Morais1\* and Rodrigo Dalmolin1,2\*\*

1Bioinformatics Multidisciplinary Environment, Federal University of Rio Grande do Norte, Natal, RN, Brazil
2Department of Biochemistry, Federal University of Rio Grande do Norte, Natal, RN, Brazil

\*vinx@ufrn.edu.br
\*\*rodrigo.dalmolin@imd.ufrn.br

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
  + [2.1 Topological analysis](#topological-analysis)
  + [2.2 Transcriptogram](#transcriptogram)
  + [2.3 Gene Ontology enrichment analysis](#gene-ontology-enrichment-analysis)
* [3 Frequently asked questions](#frequently-asked-questions)
* [4 Session info](#session-info)
* [References](#references)

**Version**: 1.32.0

![](data:image/png;base64...)

# 1 Overview

The transcriptogramer package (Morais [2019](#ref-Morais2019)) is designed for transcriptional analysis
based on transcriptograms,
a method to analyze transcriptomes that projects
expression values on a set of
ordered proteins, arranged such that the probability that gene products
participate
in the same metabolic pathway exponentially decreases with the increase of
the distance between two proteins of the ordering. Transcriptograms are,
hence, genome wide gene expression profiles that provide a global view for
the cellular metabolism, while indicating gene sets whose expression are
altered (da Silva [2014](#ref-Silva2014); Rybarczyk-Filho [2011](#ref-Filho2011); de Almeida [2016](#ref-Almeida2016); Ferrareze [2017](#ref-Ferrareze2017); Xavier [2017](#ref-Xavier2017)).

Methods are provided to analyze topological properties of a
Protein-Protein Interaction (PPI) network, to generate transcriptograms, to detect and to display
differentially expressed gene clusters, and to perform a Gene Ontology
Enrichment Analysis on these clusters.

As a set of ordered proteins is required in order to run the methods,
datasets are available for four species (*Homo sapiens*, *Mus musculus*,
*Saccharomyces cerevisiae* and *Rattus norvegicus*). Each species has three
datasets, originated from [STRINGdb](https://string-db.org/) release 11.0
protein network data, with combined scores greater than or equal to 700, 800
and 900 (see **Hs900**, **Hs800**, **Hs700**, **Mm900**, **Mm800**, **Mm700**,
**Sc900**, **Sc800**, **Sc700**, **Rn900**, **Rn800** and **Rn700** datasets).
Custom sets of ordered proteins can be generated from protein network data using
[The transcriptogramer](https://lief.if.ufrgs.br/pub/biosoftwares/transcriptogramer/)
on Windows, or [an implementation of the seriation algorithm](https://github.com/arthurvinx/seriation)
on Linux.

# 2 Quick start

The first step is to create a Transcriptogram object by running the
`transcriptogramPreprocess()` method. This example uses a subset of the
*Homo sapiens* protein network data, from STRINGdb release 11.0, containing only
associations of proteins of combined score greater than or equal to 900
(see **Hs900** and **association** datasets).

```
library(transcriptogramer)
t <- transcriptogramPreprocess(association = association, ordering = Hs900)
```

## 2.1 Topological analysis

There are two methods to perform topological analysis,
`connectivityProperties()` calculates average graph properties as function
of node connectivity, and `orderingProperties()` calculates graph
properties projected on the ordered proteins. Some methods, such as
orderingProperties(), uses a window, region of n (radius \* 2 + 1) proteins
centered at a protein, whose radius changes the output. The Transcriptogram
object has a **radius** slot that can be setted during, or after, its
preprocessing (see **Transcriptogram-class** documentation).

```
## during the preprocessing

## creating the object and setting the radius as 0
t <- transcriptogramPreprocess(association = association, ordering = Hs900)

## creating the object and setting the radius as 80
t <- transcriptogramPreprocess(association = association, ordering = Hs900,
                               radius = 80)
```

```
## after the preprocessing

## modifying the radius of an existing Transcriptogram object
radius(object = t) <- 50

## getting the radius of an existing Transcriptogram object
r <- radius(object = t)
```

As window related metrics are affected by the radius, the output of the orderingProperties() method changes depending on the content of
the radius slot. A window modularity value close to 1 indicates dense connections between the genes inside the window, as well as sparse connections between these genes and the other genes in the network. Note that the sum of the window modularity increased using the radius 80.

```
oPropertiesR50 <- orderingProperties(object = t, nCores = 1)

## slight change of radius
radius(object = t) <- 80

## this output is partially different comparing to oPropertiesR50
oPropertiesR80 <- orderingProperties(object = t, nCores = 1)

sum(oPropertiesR50$windowModularity)
```

```
[1] 3346.246
```

```
sum(oPropertiesR80$windowModularity)
```

```
[1] 4249.471
```

However, the connectivityProperties() method does not use a window, thus, its output is not
affected by the radius slot.

```
cProperties <- connectivityProperties(object = t)
```

## 2.2 Transcriptogram

A transcriptogram is generated in two steps and requires expression values,
from microarray or RNA-Seq assays (log2-counts-per-million), and a dictionary. This example uses the
datasets **GSE9988**,
which contains normalized expression values of 3 cases and 3 controls (GSM252443, GSM252444, GSM252445, GSM252465, GSM252466 and GSM252467 respectively),
and **GPL570**, a mapping
between ENSEMBL Peptide ID and Affymetrix Human Genome U133 Plus 2.0 Array
probe identifier.

The methods to generate a transcriptogram are `transcriptogramStep1()` and
`transcriptogramStep2()`. The transcriptogramStep1() assigns to each protein,
of each transcriptome sample, the average of the expression values of all the
identifiers related to it.

```
t <- transcriptogramStep1(object = t, expression = GSE9988,
                          dictionary = GPL570, nCores = 1)
t2 <- t
```

To each position of the ordering, the transcriptogramStep2() method assigns a
value equal to the average of the expression values inside a window, which
considers periodic boundary conditions to deal with proteins near the ends of
the ordering, in order to reduce random noise.

```
t <- transcriptogramStep2(object = t, nCores = 1)
```

The Transcriptogram object has slots to store the outputs of the
transcriptogramStep1() and transcriptogramStep2() methods, called
transcriptogramS1 and transcriptogramS2 respectively. As the output of some
methods are affected by the content of the transcriptogramS2 slot, it can be
recalculated using the content of the transcriptogramS1 slot.

```
radius(object = t2) <- 50
t2 <- transcriptogramStep2(object = t2, nCores = 1)
```

## 2.3 Gene Ontology enrichment analysis

As nearby genes of a transcriptogram have a high probability to interact with
each other, gene sets whose expression are altered can be identified using the
*[limma](https://bioconductor.org/packages/3.22/limma)* package. The `differentiallyExpressed()` method uses the
limma package to identify differentially expressed genes (the approaches voom and trend are supported for RNA-Seq), for the contrast
“case-control”, grouping as a cluster
a set of genes which positions are within a radius range specified by the
content of the radius slot.

For this example, the p-value threshold for false
discovery rate will be set as 0.01. If a species name is provided, the
*[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* package is used to translate the
ENSEMBL Peptide ID to Symbol (Gene Name), alternatively, a data.frame with such
content can be provided.
The levels argument classify the columns of
the transcriptogramS2 slot referring to samples, as there are 6 columns (see
dataset **GSE9988**), is created a logical vector that uses TRUE to label the
columns referring to controls samples, and FALSE to label the
columns referring to case samples.

```
## trend = FALSE for microarray data or voom log2-counts-per-million
## the default value for trend is FALSE
levels <- c(rep(FALSE, 3), rep(TRUE, 3))
t <- differentiallyExpressed(object = t, levels = levels, pValue = 0.01,
                             trend = FALSE, title = "radius 80")
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the transcriptogramer package.
##   Please report the issue at
##   <https://github.com/arthurvinx/transcriptogramer/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## the radius 50 will affect the output significantly
t2 <- differentiallyExpressed(object = t2, levels = levels, pValue = 0.01,
                             species = DEsymbols, title = "radius 50")
```

```
## using the species argument to translate ENSEMBL Peptide IDs to Symbols
## Internet connection is required for this command
t <- differentiallyExpressed(object = t, levels = levels, pValue = 0.01,
                             species = "Homo sapiens", title = "radius 80")

## translating ENSEMBL Peptide IDs to Symbols using the DEsymbols dataset
t <- differentiallyExpressed(object = t, levels = levels, pValue = 0.01,
                             species = DEsymbols, title = "radius 80")
```

This method also produces a plot referring to its output. Each cluster detected is represented by a color. The genes
that are above the horizontal black line are upregulated, and the genes that
are below are downregulated.

![](data:image/png;base64...)

![](data:image/png;base64...)

The differentially expressed genes identified by this method are stored in the
DE slot of the Transcriptogram object, its content can be obtained using the
DE method. By default, the p-values are adjusted by the Benjamini-Hochberg
procedure. Note that the differential expression on the object of radius 80 detected less clusters, but there are more windows centers significantly altered on it, thus, the clusters are more consistent. Therefore, the next methods will be performed only on the object of radius 80.

```
DE <- DE(object = t)
DE2 <- DE(object = t2)
nrow(DE)
```

```
[1] 393
```

```
nrow(DE)/length(unique(DE$ClusterNumber))
```

```
[1] 78.6
```

```
nrow(DE2)
```

```
[1] 421
```

```
nrow(DE2)/length(unique(DE2$ClusterNumber))
```

```
[1] 30.07143
```

The `clusterVisualization()` method uses the *[RedeR](https://bioconductor.org/packages/3.22/RedeR)* package to
display graphs of the differentially expressed clusters and returns an
object of the RedPort Class, allowing interactions through methods
of the RedeR package. This method requires the Java Runtime Environment
(>= 6).

```
rdp <- clusterVisualization(object = t)
```

![](data:image/png;base64...)

The `clusterEnrichment()` method performs a Gene Ontology enrichment analysis
using the *[topGO](https://bioconductor.org/packages/3.22/topGO)* package. By default, the universe is composed by
all the proteins present in the ordering slot, the ontology is setted
to biological process, the algorithm is setted to classic, the statistic is
setted to fisher, and the p-values are adjusted by the Benjamini-Hochberg
procedure. For this example, the p-value threshold for false
discovery rate will be set as 0.005. This method uses the biomaRt package to
build a Protein2GO data.frame using the given species name, or data.frame.

```
## using the HsBPTerms dataset to create the Protein2GO data.frame
t <- clusterEnrichment(object = t, species = HsBPTerms,
                           pValue = 0.005, nCores = 1)
```

```
## using the species argument to create the Protein2GO data.frame
## Internet connection is required for this command
t <- clusterEnrichment(object = t, species = "Homo sapiens",
                           pValue = 0.005, nCores = 1)
```

```
head(Terms(t))
```

```
       GO.ID                                        Term Annotated Significant
1 GO:0006357 regulation of transcription by RNA polym...      1809         315
2 GO:0006366          transcription by RNA polymerase II      1937         315
3 GO:0006355 regulation of transcription, DNA-templat...      2427         344
4 GO:1903506 regulation of nucleic acid-templated tra...      2472         345
5 GO:2001141      regulation of RNA biosynthetic process      2480         345
6 GO:0006351                transcription, DNA-templated      2575         345
  Expected pValue         pAdj ClusterNumber
1    81.52  1e-30 4.076053e-28             1
2    87.29  1e-30 4.076053e-28             1
3   109.37  1e-30 4.076053e-28             1
4   111.40  1e-30 4.076053e-28             1
5   111.76  1e-30 4.076053e-28             1
6   116.04  1e-30 4.076053e-28             1
```

```
enrichmentPlot(t)
```

![](data:image/png;base64...)

# 3 Frequently asked questions

> How does transcriptogramer deal in cases where Protein-Protein Interactions (PPIs) for expressed proteins are missing?

The `transcriptogramStep1()` method removes rows from the expression data which are not present in the set of ordered proteins. As the association and ordering arguments of the `transcriptogramPreprocess()` method must contain the same proteins, if a row of the expression data cannot be mapped to one of these proteins, it will be discarded.

---

> How does transcriptogramer deal in cases where there’s no expression data for some PPIs in the network?

When there is no expression data related to a given protein of the set of ordered proteins, this protein expression value is treated as a missing value. In this case, the sliding window will discard missing values, sum the remaining ones, and divide this value by `radius * 2 + 1` while running the `transcriptogramStep2()` method.

---

> Does the transcriptogramer accept/convert protein/gene IDs other than the ones used in the vignette?

This is not possible in the current transcriptogramer version. The transcriptogramer is only able to automatically convert ENSEMBL Peptide IDs to Symbols. As this can be done by the biomaRt package, arguments will be added in the future to allow the automatic conversion of other IDs, such as ENTREZ to ENSEMBL Gene ID. This change will be reported here and in the package NEWS.

# 4 Session info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] transcriptogramer_1.32.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     dplyr_1.1.4          farver_2.1.2
##  [4] blob_1.2.4           filelock_1.0.3       Biostrings_2.78.0
##  [7] S7_0.2.0             fastmap_1.2.0        BiocFileCache_3.0.0
## [10] digest_0.6.37        lifecycle_1.0.4      topGO_2.62.0
## [13] statmod_1.5.1        KEGGREST_1.50.0      RSQLite_2.4.3
## [16] magrittr_2.0.4       compiler_4.5.1       rlang_1.1.6
## [19] sass_0.4.10          progress_1.2.3       doSNOW_1.0.20
## [22] tools_4.5.1          igraph_2.2.1         yaml_2.3.10
## [25] data.table_1.17.8    knitr_1.50           prettyunits_1.2.0
## [28] bit_4.6.0            curl_7.0.0           RColorBrewer_1.1-3
## [31] withr_3.0.2          purrr_1.1.0          BiocGenerics_0.56.0
## [34] grid_4.5.1           stats4_4.5.1         GO.db_3.22.0
## [37] ggplot2_4.0.0        scales_1.4.0         iterators_1.0.14
## [40] dichromat_2.0-0.1    biomaRt_2.66.0       tinytex_0.57
## [43] cli_3.6.5            rmarkdown_2.30       crayon_1.5.3
## [46] generics_0.1.4       httr_1.4.7           DBI_1.2.3
## [49] cachem_1.1.0         stringr_1.5.2        parallel_4.5.1
## [52] AnnotationDbi_1.72.0 BiocManager_1.30.26  XVector_0.50.0
## [55] matrixStats_1.5.0    vctrs_0.6.5          jsonlite_2.0.0
## [58] SparseM_1.84-2       bookdown_0.45        IRanges_2.44.0
## [61] hms_1.1.4            S4Vectors_0.48.0     bit64_4.6.0-1
## [64] magick_2.9.0         foreach_1.5.2        limma_3.66.0
## [67] jquerylib_0.1.4      tidyr_1.3.1          snow_0.4-4
## [70] glue_1.8.0           codetools_0.2-20     stringi_1.8.7
## [73] gtable_0.3.6         tibble_3.3.0         pillar_1.11.1
## [76] rappdirs_0.3.3       htmltools_0.5.8.1    Seqinfo_1.0.0
## [79] graph_1.88.0         R6_2.6.1             dbplyr_2.5.1
## [82] httr2_1.2.1          evaluate_1.0.5       Biobase_2.70.0
## [85] lattice_0.22-7       png_0.1-8            memoise_2.0.1
## [88] RedeR_3.6.0          bslib_0.9.0          Rcpp_1.1.0
## [91] xfun_0.53            pkgconfig_2.0.3
```

```
warnings()
```

# References

da Silva, S. R. M. et al. 2014. “Reproducibility Enhancement and Differential Expression of Non Predefined Functional Gene Sets in Human Genome.” *BMC Genomics*. <https://doi.org/10.1186/1471-2164-15-1181>.

de Almeida, R. M. C. et al. 2016. “Transcriptome Analysis Reveals Manifold Mechanisms of Cyst Development in Adpkd.” *Human Genomics* 10 (1): 1–24. <https://doi.org/10.1186/s40246-016-0095-x>.

Ferrareze, P. A. G. et al. 2017. “Transcriptional Analysis Allows Genome Reannotation and Reveals That Cryptococcus Gattii Vgii Undergoes Nutrient Restriction During Infection.” *Microorganisms* 5 (3). <https://doi.org/10.3390/microorganisms5030049>.

Morais, D. A. A. et al. 2019. “Transcriptogramer: An R/Bioconductor Package for Transcriptional Analysis Based on Protein–Protein Interaction.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/btz007>.

Rybarczyk-Filho, J. L. et al. 2011. “Towards a Genome-Wide Transcriptogram: The Saccharomyces Cerevisiae Case.” *Nucleic Acids Research* 39 (8): 3005–16. <https://doi.org/10.1093/nar/gkq1269>.

Xavier, S. R. M. et al. 2017. “Analysis of Genome Instability Biomarkers in Children with Non-Syndromic Orofacial Clefts.” *Mutagenesis*. <https://doi.org/10.1093/mutage/gew068>.