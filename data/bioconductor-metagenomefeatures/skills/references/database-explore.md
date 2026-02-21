# Exploring sequence and phylogenetic diversity for a taxonomic group of interest.

Nathan D. Olson1

1National Institute of Standards and Technology, Maryland, USA

#### *27 February 2019*

#### Package

metagenomeFeatures 2.2.3

# 1 Vignette overview

16S rRNA reference databases are most often used to annotate OTUs or sequence variants from marker-gene survey datasets.
The reference databases are also used to study the diversity of specific taxonomic groups.
As such, `MgDb-class` objects for 16S rRNA sequence reference databases can be used to explore the sequence and phylogenetic diversity of taxonomic groups of interest.
In this vignette, we will explore the 16S rRNA diversity of the Gammaproteobaceria class using the Greengenes 16S rRNA database version 13.8 clustered at 85% similarity.
A `MgDb-class` object with the greengenes database version 13.8 85% similarity OTUs (`gg85`) is included in the *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package.

Other databases are available as [Bioconductor AnnotationData](https://www.bioconductor.org/packages/release/data/annotation/).

* Greengenes Release 13.5: *[greengenesMgDb13.5](https://bioconductor.org/packages/3.8/greengenesMgDb13.5)*
* Ribosomal Database Project Release 11.5: *[ribosomaldatabaseproject11.5MgDb](https://bioconductor.org/packages/3.8/ribosomaldatabaseproject11.5MgDb)*
* Silva 128.1: *[silva128.1MgDb](https://bioconductor.org/packages/3.8/silva128.1MgDb)*

We will first load the `MgDb-class` object, then select the taxa of interest, and finally explore the Gammaproteobaceria class phylogenetic diversity, and taxonomic composition.
In addition to using the *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package, the vignette uses *[tidyverse](https://CRAN.R-project.org/package%3Dtidyverse)* packages *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* and *[tidyr](https://CRAN.R-project.org/package%3Dtidyr)* for data manipulation, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* and for data visualization.
The *[ggtree](https://bioconductor.org/packages/3.8/ggtree)* Bioconductor package is used to plot the phylogenetic tree.

```
library(metagenomeFeatures)
library(dplyr)
library(forcats)
library(ggplot2)
library(ggtree)
```

# 2 Loading and subsetting the database

The `gg85` database is loaded using `get_gg13.8_85MgDb()`.
Next the `mgDb_select()` function is used to subset the database, the `key` arguments is used to define the taxonmic group(s) of interest and `keytype` is used to define the taxonomic level for the group(s) of interest.
With the subsetted database you can analyze the taxonomy, sequences, and phylogeny for the taxonomic group of interest.
The `mgDb_select()` function returns a subset of the database taxonomic, sequence, or phylogenetic data, as well as a named list with any two or all three data types.

```
gg85 <- get_gg13.8_85MgDb()
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree'

gamma_16S <- mgDb_select(gg85,
                          type = "all",
                          keys = "Gammaproteobacteria",
                          keytype = "Class")
```

# 3 Taxonomic Analysis

We want to know how many genera are in the Class Gammaproteobacteria and how many 85% similarity OTUs are in each genera in the Greengenes 13.8 85% database.
We first create a data frame with the desired information then plot the results.

```
## Per genus count data
gamma_df <- gamma_16S$taxa %>%
    group_by(Genus) %>%
    summarise(Count = n()) %>%
    ungroup() %>%
    mutate(Genus = fct_reorder(Genus, Count))

## Count info for text
escherichia_count <- gamma_df$Count[gamma_df$Genus == "g__Escherichia"]

## excluding unassigned genera and genera with only one assigned sequence
gamma_trim_df <- gamma_df %>% filter(Genus != "g__", Count > 1)
```

For the Greengenes database there are a total of 247 OTUs assigned to 56 genera in the Class Gammaproteobacteria.
The number of OTUs assigned to specific genera, range from 9 to 1 (Fig. [1](#fig:generaCount)).
As this database is preclustered to 85% similarity the number of OTUs per genus is more of an indicator of genera diversity than how well a genus is represented in the database.
For example no sequences present in the database are assigned to the genus *Shigella* and only 1 is assigned to *Escherichia*.
OTUs only assigned to the family, `g__`, is the most abundant group, 154.

```
 ggplot(gamma_trim_df) +
    geom_bar(aes(x = Genus, y = Count), stat = "identity") +
    labs(y = "Number of OTUs") +
    coord_flip() +
    theme_bw()
```

![Number of seqeunces assigned to genera in the Class Gammaproteobacteria. Only Genera with more than one assigned sequence are shown.](data:image/png;base64...)

Figure 1: Number of seqeunces assigned to genera in the Class Gammaproteobacteria
 Only Genera with more than one assigned sequence are shown.

# 4 Phylogenetic Diversity

We will use the *[ggtree](https://bioconductor.org/packages/3.8/ggtree)* package to visualize the phylogenetic tree and annotate the tips with Genera information.
Of the genera with more than 3 representative OTUs *Stenotrophomonas* is the only genus with unclassified and other OTUs within the clade (Fig. [2](#fig:annoTree)).

```
genus_lab <- paste0("g__", c("","Stenotrophomonas", "Pseudomonas"))
genus_anno_df <- gamma_16S$taxa %>%
    group_by(Genus) %>%
    mutate(Count = n()) %>%
    ungroup() %>%
    mutate(Genus_lab = if_else(Count > 3, Genus, ""))

ggtree(gamma_16S$tree) %<+%
    genus_anno_df +
    ## Add taxa name for unlabeled Stenotrophomonas branch
    geom_tippoint(aes(color = Genus_lab), size = 3) +
    scale_color_manual(values = c("#FF000000","darkorange", "blue", "green", "tan", "black")) +
    theme(legend.position = "bottom") +
    labs(color = "Genus")
```

![Phylogenetic tree of Gammaproteobacteria class OTU representative sequences.](data:image/png;base64...)

Figure 2: Phylogenetic tree of Gammaproteobacteria class OTU representative sequences

# 5 Sequence Diversity

The `mgDb_select()` function returns the subsetted sequence data as a biostring object.
The sequence data can be used for additional analysis such as, multiple sequencing alignment, primer region extraction, or PCR primer design.
When working with large subsets of the database or the full database, the Bioconductor package *[DECIPHER](https://bioconductor.org/packages/3.8/DECIPHER)* provides functions for analyzing sequences in an SQLite database. The `MgDb-class` uses *[DECIPHER](https://bioconductor.org/packages/3.8/DECIPHER)* to format the sequences as an SQLite database.
The `MgDb-class` sequence slot is a connection to the SQLite database, therefore the *[DECIPHER](https://bioconductor.org/packages/3.8/DECIPHER)* package can be used to analyze the dataset reference sequence data as well.

```
gamma_16S$seq
#>   A DNAStringSet instance of length 247
#>       width seq                                          names
#>   [1]  1503 AGAGTTTGATCCTGGCTCAGA...GGTGAAGTCGTAACAAGGTA 1111561
#>   [2]  1526 AGAGTTTGATCATGGCTCACA...TTTGTAACAAGGTAGCCGTA 1110088
#>   [3]  1502 TAGAGTTTGATCCTGGCTCAG...AGTCGTAACAAGGTAGCCGT 1107824
#>   [4]  1366 ATTGAACGCTGGCGGCAGGCC...GTGAATACGTTCCCGGGCCT 1047956
#>   [5]  1365 TGAACGCTGGCGGCAGGCCTA...GTGAATACGTTCCCGGGCCT 1047401
#>   ...   ... ...
#> [243]  1540 AGAGTTTGATCCTGGCTCAGA...GAAGTCGTAACAAGGTAACC 4466628
#> [244]  1486 ATTGAACCCTGGCGGCAGGCT...GGTGAAGTCGTAACAAGGTA 4472725
#> [245]  1575 GCGGAAACGATGGTAGCTTGC...AGCTTAACCTTCGGGGAGGC 4481079
#> [246]  1501 AGAGTTTGTTCCTGGCTCAGA...GAAGTCGTAACAAGGTAACC 4481801
#> [247]  1508 TGAGTTTGATCCTGGCTCAGA...TGGGGTGAAGTCGTAACAAG 4482291
```

# Session info

```
#> R version 3.5.2 (2018-12-20)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 16.04.5 LTS
#>
#> Matrix products: default
#> BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] parallel  stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] forcats_0.4.0            ggplot2_3.1.0
#> [3] dplyr_0.8.0.1            ggtree_1.14.6
#> [5] metagenomeFeatures_2.2.3 Biobase_2.42.0
#> [7] BiocGenerics_0.28.0      BiocStyle_2.10.0
#>
#> loaded via a namespace (and not attached):
#>  [1] treeio_1.6.2       tidyselect_0.2.5   xfun_0.5
#>  [4] purrr_0.3.0        lattice_0.20-38    colorspace_1.4-0
#>  [7] DECIPHER_2.10.2    htmltools_0.3.6    stats4_3.5.2
#> [10] yaml_2.2.0         utf8_1.1.4         blob_1.1.1
#> [13] rlang_0.3.1        pillar_1.3.1       withr_2.1.2
#> [16] glue_1.3.0         DBI_1.0.0          bit64_0.9-7
#> [19] dbplyr_1.3.0       rvcheck_0.1.3      plyr_1.8.4
#> [22] stringr_1.4.0      zlibbioc_1.28.0    Biostrings_2.50.2
#> [25] munsell_0.5.0      gtable_0.2.0       memoise_1.1.0
#> [28] evaluate_0.13      labeling_0.3       knitr_1.21
#> [31] IRanges_2.16.0     fansi_0.4.0        highr_0.7
#> [34] Rcpp_1.0.0         scales_1.0.0       BiocManager_1.30.4
#> [37] S4Vectors_0.20.1   jsonlite_1.6       XVector_0.22.0
#> [40] bit_1.1-14         digest_0.6.18      stringi_1.3.1
#> [43] bookdown_0.9       grid_3.5.2         cli_1.0.1
#> [46] tools_3.5.2        magrittr_1.5       lazyeval_0.2.1
#> [49] RSQLite_2.1.1      tibble_2.0.1       crayon_1.3.4
#> [52] ape_5.2            tidyr_0.8.2        pkgconfig_2.0.2
#> [55] ellipsis_0.1.0     tidytree_0.2.4     assertthat_0.2.0
#> [58] rmarkdown_1.11     R6_2.4.0           nlme_3.1-137
#> [61] compiler_3.5.2
```