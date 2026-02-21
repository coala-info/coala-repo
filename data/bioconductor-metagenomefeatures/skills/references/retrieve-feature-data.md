# Using metagenomeFeatures to Retrieve Feature Data.

Nathan D. Olson1

1National Institute of Standards and Technology, Maryland, USA

#### *27 February 2019*

#### Package

metagenomeFeatures 2.2.3

# 1 Vignette overview

*[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* and associated annotation packages1[ ] 1 Other databases are avilable as [Bioconductor AnnotationData](https://www.bioconductor.org/packages/release/data/annotation/) including; Greengenes Release 13.5: *[greengenesMgDb13.5](https://bioconductor.org/packages/3.8/greengenesMgDb13.5)*, Greengenes Release 13.8 99% OTUs,*[greengenes13.8\_99MgDb](https://bioconductor.org/packages/3.8/greengenes13.8_99MgDb)* Ribosomal Database Project Release 11.5, *[ribosomaldatabaseproject11.5MgDb](https://bioconductor.org/packages/3.8/ribosomaldatabaseproject11.5MgDb)*, and Silva 128.1: *[silva128.1MgDb](https://bioconductor.org/packages/3.8/silva128.1MgDb)*. can be used to obtain phylogentic trees and representative sequences for 16S rRNA marker gene sequence experimental datasets when the reads are clustered using closed reference clustering and a database with an `MgDb` annotation package.
In this vignette we demostrate how to use `metagenomeFeatures` and Greengenes 16S rRNA database version 13.8 85% OTUs to obtain a phylogenetic tree and representative sequences for Rousk et al. (2010),
a soil microbiome study.
We then use the tree and sequence data obtained from the Greengenes `MgDb` to generate a `phyloseq-class` object for community analysis2[ ] 2 The *[phyloseq](https://bioconductor.org/packages/3.8/phyloseq)* package defines the `phyloseq-calss` for working with 16S rRNA experimental data..

# 2 Greengenes 13.8 85% OTU MgDb

The gg 13.8 85% OTU (`gg85`) is provided as part of the *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package.
`gg85` is a `MgDb-class` object with the taxonomic heirarchy, sequence data, and phylogeny for the Greengenes database clustered at the 0.85 similarity threshold.
After loading the *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package `gg85` is loaded using `get_gg13.8_85MgDb()`.3[ ] 3 See the “metagenomeFeatures classes and methods.” vignette, `Vignettes("metagenomeFeatures classes and methods.")` for more information on methods for working with `MgDb-class` and `mgFeatures-class` objects.

```
library(metagenomeFeatures)
gg85 <- get_gg13.8_85MgDb()
```

## 2.1 QIITA Dataset

[QIITA](https://qiita.ucsd.edu) is a public repository for sharing OTU tables and raw sequence data from 16S rRNA marker gene studies, however some of the datasets do not include representative sequences or phylogenetic trees.
For this vignette we are using data from the previously mentioned soil microbiome study, <https://qiita.ucsd.edu/study/description/94> (Rousk et al. 2010).
A BIOM and qiime mapping file for the study can be obtained from QIITA.
A vector of Greengenes ids for the study cluster centers is included in this package for use in this vignette.

```
data(qiita_study_94_gg_ids)
```

## 2.2 Obtaining Representative Sequences and Phylogenetic Tree

A `mgFeatures` object is generated from `gg85` (or any other `MgDb-class` object) using the `annotateFeatures()` function along with a set of database ids or keys.
The resulting `mgFeatures` class object has the taxonomic heirarchy, phylogeny, and sequence data for the study OTUs.4[ ] 4 See the “metagenomeFeatures classes and methods.” vignette, `Vignettes("metagenomeFeatures classes and methods.")` for more information on methods for working with `MgDb-class` and `mgFeatures-class` objects.

```
soil_mgF <- annotateFeatures(gg85, qiita_study_94_gg_ids)
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'

## Taxonomic heirarchy
soil_mgF
#> mgFeatures with 61 rows and 8 columns
#>            Keys     Kingdom            Phylum                   Class
#>     <character> <character>       <character>             <character>
#> 1       1107824 k__Bacteria p__Proteobacteria  c__Gammaproteobacteria
#> 2        824826 k__Bacteria p__Proteobacteria  c__Alphaproteobacteria
#> 3        694268 k__Bacteria          p__WPS-2                     c__
#> 4        579266 k__Bacteria p__Proteobacteria   c__Betaproteobacteria
#> 5        558862 k__Bacteria       p__Chlorobi               c__SJA-28
#> ...         ...         ...               ...                     ...
#> 57      4389227 k__Bacteria  p__Acidobacteria               c__iii1-8
#> 58      4391683 k__Bacteria p__Proteobacteria  c__Alphaproteobacteria
#> 59      4421369 k__Bacteria  p__Acidobacteria c__[Chloracidobacteria]
#> 60      4477112 k__Bacteria            p__WS2              c__SHA-109
#> 61      4479102 k__Bacteria           p__OP11               c__OP11-4
#>                     Ord               Family       Genus     Species
#>             <character>          <character> <character> <character>
#> 1      o__Legionellales      f__Coxiellaceae         g__         s__
#> 2                   o__                  f__         g__         s__
#> 3                   o__                  f__         g__         s__
#> 4    o__Burkholderiales                  f__         g__         s__
#> 5                   o__                  f__         g__         s__
#> ...                 ...                  ...         ...         ...
#> 57             o__32-20                  f__         g__         s__
#> 58  o__Sphingomonadales f__Sphingomonadaceae         g__         s__
#> 59              o__RB41         f__Ellin6075         g__         s__
#> 60                  o__                  f__         g__         s__
#> 61                  o__                  f__         g__         s__

# Sequence data
mgF_seq(soil_mgF)
#>   A DNAStringSet instance of length 61
#>      width seq                                           names
#>  [1]  1502 TAGAGTTTGATCCTGGCTCAG...AAGTCGTAACAAGGTAGCCGT 1107824
#>  [2]  1396 AGAGTTTGATCATGGCTCAGG...AGCCTTGTACACACCGCCCGT 824826
#>  [3]  1424 AACGCTGGCGGCGTGCCTAAC...AGGTAAGGGGGACGAAGTCGT 694268
#>  [4]  1498 AGAGTTTGATCCTGGCTCAGA...AGTCGTAACAAGGTAGCCGTA 579266
#>  [5]  1432 AGAGTTTGATCATGGCTCAGG...CCAGAAGTAGTTAGCCTAACC 558862
#>  ...   ... ...
#> [57]  1378 TGCTTAACACATGCAAGTCGA...CTTGCACACACCGCCCGTCAC 4389227
#> [58]  1606 AGAGTTTGATCCTGGCTCAGA...TGAAGTCGTAACAAGGTAACC 4391683
#> [59]  1496 AGAGTTTGATCCTGGCTCAGA...TGAAGTCGTAACAAGGTAACC 4421369
#> [60]  1403 GAACGCTGGCGGTACGTCTGA...GCGGCCGAAGGTGGAGTCAGT 4477112
#> [61]  1336 GATGAACGCTGGCGGCGTGCC...GCAAAGTTGGGGGCGCCCGAA 4479102

# Tree data
mgF_tree(soil_mgF)
#>
#> Phylogenetic tree with 61 tips and 60 internal nodes.
#>
#> Tip labels:
#>  200762, 206404, 4479102, 113767, 551866, 552576, ...
#>
#> Rooted; includes branch lengths.
```

# 3 Using `mgFeatures-class` object with *[phyloseq](https://bioconductor.org/packages/3.8/phyloseq)*

Finally we use the phyogenetic tree from the `mgFeatures-class` object along with the OTU table for a beta diversity analysis.
After loading the *[phyloseq](https://bioconductor.org/packages/3.8/phyloseq)* package we will load the abundance data from the QITTA biom file, using the *[phyloseq](https://bioconductor.org/packages/3.8/phyloseq)* command `import_biom()`.
Next we will define the `sample_data` slot using a modified version of the mapping file `2301_mapping_file.txt` obtained from QITTA, which only includes sample names and experimental variables pH, carbon/nitrogen ratio, total nitrogen, and total organic carbon.
Future development of a common data structure for working with microbiome data that extends the `SummarizeExperiment-class` is underway.
For this new class the `mgFeatures-class` will define the `rowData` slot.

```
data_dir <- system.file("extdata", package = "metagenomeFeatures")

## Load Biom
biom_file <-  file.path(data_dir, "229_otu_table.biom")
soil_ps <- phyloseq::import_biom(BIOMfilename = biom_file)

## Define sample data
sample_file <- file.path(data_dir, "229_sample_data.tsv")
sample_dat <- read.delim(sample_file)

## Rownames matching sample_names(), required for phyloseq sample_data slot
rownames(sample_dat) <- sample_dat$SampleID
sample_data(soil_ps) <- sample_dat

## Resulting phyloseq object
soil_ps
#> phyloseq-class experiment-level object
#> otu_table()   OTU Table:         [ 2305 taxa and 26 samples ]
#> sample_data() Sample Data:       [ 26 samples by 5 sample variables ]
#> tax_table()   Taxonomy Table:    [ 2305 taxa by 7 taxonomic ranks ]
```

Rousk et al. (2010) clustered the sequences at 97% similarity therefore
`gg85` only contains a subset of the OTUs in the dataset.
To define the tree and sequence slot we need to subset `soil_ps` to only include OTUs in `gg85`.
Samples with no OTUs in `gg85` were also removed for our beta diversity analysis.

```
# Removing OTUs not in `gg85`
soil_tree <- mgF_tree(soil_mgF)
soil_ps_gg85 <- prune_taxa(taxa = soil_tree$tip.label, x = soil_ps)

# Removing samples with no OTUs in `gg85`
samples_to_keep <- sample_sums(soil_ps_gg85) != 0
soil_ps_gg85 <- prune_samples(samples = samples_to_keep, x = soil_ps_gg85)
```

Now `soil_mgF` can be used to to define our `soil_ps` object `refseq` and `tree` slots.

```
## Defining tree slot
phy_tree(physeq = soil_ps_gg85) <- soil_tree
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'
#> Found more than one class "phylo" in cache; using the first, from namespace 'metagenomeFeatures'
#> Also defined by 'tidytree' 'phyloseq'

## Defining seq slot
soil_ps_gg85@refseq <- mgF_seq(soil_mgF)
```

Now that the `tree` slot is defined we can perform microbial community analysis requiring a phylogenetic tree such as phylogenetic beta diversity.
For the subset of features used here, pH is a primary driver for differences in beta diversity between the samples (Figure [1](#fig:betaFig)).
Nearly 30% of the total variation in the data is explained by the first axis and sample pH is correlated with the first axis.
This result is consistent with Rousk et al. (2010) even though we only used a small subset of the study OTUs. The outlier sample (94.PH18) is an artifact of using a small subset of the original dataset, only one `gg85` OTU is observed in the sample and that OTU was not observed in the other samples.

```
soil_ord <- ordinate(physeq = soil_ps_gg85,
                     distance = "wunifrac",
                     method = "PCoA")
plot_ordination(soil_ps_gg85, soil_ord,
                color = "ph",
                type="sample",
                label = "SampleID")
```

![Beta diversity and ordination for a subset of features from Rousk et al. [-@rousk2010soil]. Beta diversity was estimated using Weighted Unifrac and Principal Component Analysis was used for ordination. Sampels are represented as individual point and color indicates soil sample pH.](data:image/png;base64...)

Figure 1: Beta diversity and ordination for a subset of features from Rousk et al
 (2010). Beta diversity was estimated using Weighted Unifrac and Principal Component Analysis was used for ordination. Sampels are represented as individual point and color indicates soil sample pH.

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
#> [1] phyloseq_1.26.1          forcats_0.4.0
#> [3] ggplot2_3.1.0            dplyr_0.8.0.1
#> [5] ggtree_1.14.6            metagenomeFeatures_2.2.3
#> [7] Biobase_2.42.0           BiocGenerics_0.28.0
#> [9] BiocStyle_2.10.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyr_0.8.2        bit64_0.9-7        jsonlite_1.6
#>  [4] splines_3.5.2      foreach_1.4.4      assertthat_0.2.0
#>  [7] BiocManager_1.30.4 rvcheck_0.1.3      highr_0.7
#> [10] stats4_3.5.2       blob_1.1.1         yaml_2.2.0
#> [13] pillar_1.3.1       RSQLite_2.1.1      lattice_0.20-38
#> [16] glue_1.3.0         digest_0.6.18      XVector_0.22.0
#> [19] colorspace_1.4-0   htmltools_0.3.6    Matrix_1.2-15
#> [22] plyr_1.8.4         pkgconfig_2.0.2    bookdown_0.9
#> [25] zlibbioc_1.28.0    purrr_0.3.0        tidytree_0.2.4
#> [28] scales_1.0.0       tibble_2.0.1       mgcv_1.8-27
#> [31] IRanges_2.16.0     ellipsis_0.1.0     withr_2.1.2
#> [34] lazyeval_0.2.1     cli_1.0.1          survival_2.43-3
#> [37] magrittr_1.5       crayon_1.3.4       memoise_1.1.0
#> [40] evaluate_0.13      fansi_0.4.0        nlme_3.1-137
#> [43] MASS_7.3-51.1      vegan_2.5-4        tools_3.5.2
#> [46] data.table_1.12.0  stringr_1.4.0      Rhdf5lib_1.4.2
#> [49] S4Vectors_0.20.1   munsell_0.5.0      cluster_2.0.7-1
#> [52] Biostrings_2.50.2  ade4_1.7-13        compiler_3.5.2
#> [55] rlang_0.3.1        rhdf5_2.26.2       grid_3.5.2
#> [58] iterators_1.0.10   biomformat_1.10.1  igraph_1.2.4
#> [61] labeling_0.3       rmarkdown_1.11     gtable_0.2.0
#> [64] codetools_0.2-16   multtest_2.38.0    DBI_1.0.0
#> [67] reshape2_1.4.3     R6_2.4.0           knitr_1.21
#> [70] bit_1.1-14         utf8_1.1.4         treeio_1.6.2
#> [73] permute_0.9-4      ape_5.2            stringi_1.3.1
#> [76] Rcpp_1.0.0         DECIPHER_2.10.2    dbplyr_1.3.0
#> [79] tidyselect_0.2.5   xfun_0.5
```

# Reference

Rousk, Johannes, Erland B{}{}th, Philip C Brookes, Christian L Lauber, Catherine Lozupone, J Gregory Caporaso, Rob Knight, and Noah Fierer. 2010. “Soil Bacterial and Fungal Communities Across a pH Gradient in an Arable Soil.” *The ISME Journal* 4 (10). Nature Publishing Group:1340.