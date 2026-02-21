# metagenomeFeatures classes and methods.

Nathan D. Olson1

1National Institute of Standards and Technology, Maryland, USA

#### *27 February 2019*

#### Package

metagenomeFeatures 2.2.3

The *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package defines two classes, `MgDb-class` for working with 16S rRNA databases, and `mgFeatures-class` for marker-gene survey feature data.
Both classes are S4 object-oriented classes and contain slots for (1) the sequences themselves,
(2) taxonomic lineage,
and (3) a phylogenetic tree with the evolutionary relationship between features,
and (4) metadata.
This vignette demonstrates how to explore and subset `MgDb-class` objects and create new `mgFeatures-class` objects.

# 1 `MgDb-class` Object

The `MgDb-class` provides a consistent data structure for working with different 16S rRNA databases.
16S rRNA databases contain hundreds of thousands to millions of sequences, therefore an SQLite database is used to store the taxonomic and sequence data.
Using an SQLite database prevents the user from loading the full database into memory.
The database connection is managed using the *[RSQLite](https://CRAN.R-project.org/package%3DRSQLite)* R package, and the taxonomic data are accessed using the *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* and *[dbplyr](https://CRAN.R-project.org/package%3Ddbplyr)* packages.
The *[DECIPHER](https://bioconductor.org/packages/3.8/DECIPHER)* package is used to format the sequence data as an SQLite database and provides functions for working directly with the sequence data in the SQLite database.
The `phylo-class`, from the *[APE](https://CRAN.R-project.org/package%3DAPE)* R package, defines the tree slot.

The following examples utilize `gg85` as the example `MgDb-class` object included in the *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package. `MgDb-class` objects with full databases are in separate Bioconductor Annotation packages such as the *[greengenesMgDb13.5](https://bioconductor.org/packages/3.8/greengenesMgDb13.5)* package.1[ ] 1 Other databases are avilable as [Bioconductor AnnotationData](https://www.bioconductor.org/packages/release/data/annotation/) including; Greengenes Release 13.5: *[greengenesMgDb13.5](https://bioconductor.org/packages/3.8/greengenesMgDb13.5)*, Greengenes Release 13.8 99% OTUs,*[greengenes13.8\_99MgDb](https://bioconductor.org/packages/3.8/greengenes13.8_99MgDb)* Ribosomal Database Project Release 11.5, *[ribosomaldatabaseproject11.5MgDb](https://bioconductor.org/packages/3.8/ribosomaldatabaseproject11.5MgDb)*, and Silva 128.1: *[silva128.1MgDb](https://bioconductor.org/packages/3.8/silva128.1MgDb)*.

After loading the *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)*, the `get_gg13.8_85MgDb()` is use to load the `gg85` database. The taxonomy table is stored in a SQLite database and the taxonomy slot is an open connection to the database.

```
library(metagenomeFeatures)
gg85 <- get_gg13.8_85MgDb()
```

## 1.1 `MgDb-class` Accessor Methods

The *[metagenomeFeatures](https://bioconductor.org/packages/3.8/metagenomeFeatures)* package includes accessor methods for the four slots `mgDb_meta()`, `mgDb_tree()`, `mgDb_taxa()`, `mgDb_seq()`.

Additional accessor methods, `taxa_*()` are provided for different taxonomy table elements.
These accessors are useful in determining appropriate parameters for the `mgDb_select()` (See section [1.2](#mgdb-select)).
The `taxa_keytypes()` accessor returns a vector with taxonomy table column names and the `taxa_columns()` return a vector of taxonomy relevant column names.
The `taxa_keys()` method returns a data frame with all values in a database for specified keytype(s).

```
taxa_keytypes(gg85)
#>  [1] "row_names"   "identifier"  "description" "Keys"        "Kingdom"
#>  [6] "Phylum"      "Class"       "Ord"         "Family"      "Genus"
#> [11] "Species"

taxa_columns(gg85)
#> [1] "Keys"    "Kingdom" "Phylum"  "Class"   "Ord"     "Family"  "Genus"
#> [8] "Species"

head(taxa_keys(gg85, keytype = c("Kingdom")))
#> # A tibble: 6 x 1
#>   Kingdom
#>   <chr>
#> 1 k__Bacteria
#> 2 k__Bacteria
#> 3 k__Bacteria
#> 4 k__Bacteria
#> 5 k__Bacteria
#> 6 k__Bacteria
```

## 1.2 `MgDb-class` Select Methods

The `MgDb-class` select method is used to retrieve database entries for a specified taxonomic group or id list and can return either taxonomic, sequences, phylogenetic tree, or a combinantion of the three.
The `type` argument defines the type of information the database returns.

```
## Only returns taxa
mgDb_select(gg85, type = "taxa",
            keys = c("Vibrionaceae", "Enterobacteriaceae"),
            keytype = "Family")
#> # A tibble: 27 x 8
#>    Keys   Kingdom   Phylum    Class      Ord      Family    Genus   Species
#>    <chr>  <chr>     <chr>     <chr>      <chr>    <chr>     <chr>   <chr>
#>  1 10479… k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  2 818108 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  3 651366 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  4 592303 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__Pro… s__
#>  5 575794 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  6 559954 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  7 368586 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  8 289174 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__Ple… s__shige…
#>  9 268585 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__Cit… s__
#> 10 232927 k__Bacte… p__Prote… c__Gammap… o__Vibr… f__Vibri… g__     s__
#> # … with 17 more rows

## Only returns seq
mgDb_select(gg85, type = "seq",
            keys = c("Vibrionaceae", "Enterobacteriaceae"),
            keytype = "Family")
#>   A DNAStringSet instance of length 27
#>      width seq                                           names
#>  [1]  1366 ATTGAACGCTGGCGGCAGGCC...GGTGAATACGTTCCCGGGCCT 1047956
#>  [2]  1410 ACGGTACACAGAGAGCTTGCT...CTTCGGGAGGGCGCTTACCAC 818108
#>  [3]  1421 ATTGAACGCTGGCGGCAAGCT...CGCCCGTCACACCATGGGAGT 651366
#>  [4]  1453 AGTCGAGCGGTAACAGTGGGA...TCATGACTGGGGGAAGTCGTA 592303
#>  [5]  1419 ATTGAACGCTGGCGGCAAGCT...CGCCCGTCACACCATGGGAGT 575794
#>  ...   ... ...
#> [23]  1383 TGGGAAACTGCCTGATGGAGG...TAACCTTCGGGAGGGCGGTTT 4336809
#> [24]  1443 GGGTGAGTAATGTCTGGGAAA...GGGTTGCAAAAGAAGTAGGTA 656881
#> [25]  1563 AGAGTTTGATCCTGGCTCAGA...TGAAGTCGTAACAAGGTAACC 4371215
#> [26]  1392 GCGGCGGACGGGTGAGTAATG...GTGGGTAGTTTAACCTTCGGG 4375861
#> [27]  1389 TCGTGCGGTAATAGAGGAACA...AAGCAAGTAGTTTAACCTAAA 4443068

## Returns taxa, seq, and tree
mgDb_select(gg85, type = "all",
            keys = c("Vibrionaceae", "Enterobacteriaceae"),
            keytype = "Family")
#> $taxa
#> # A tibble: 27 x 8
#>    Keys   Kingdom   Phylum    Class      Ord      Family    Genus   Species
#>    <chr>  <chr>     <chr>     <chr>      <chr>    <chr>     <chr>   <chr>
#>  1 10479… k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  2 818108 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  3 651366 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  4 592303 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__Pro… s__
#>  5 575794 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  6 559954 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  7 368586 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__     s__
#>  8 289174 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__Ple… s__shige…
#>  9 268585 k__Bacte… p__Prote… c__Gammap… o__Ente… f__Enter… g__Cit… s__
#> 10 232927 k__Bacte… p__Prote… c__Gammap… o__Vibr… f__Vibri… g__     s__
#> # … with 17 more rows
#>
#> $seq
#>   A DNAStringSet instance of length 27
#>      width seq                                           names
#>  [1]  1366 ATTGAACGCTGGCGGCAGGCC...GGTGAATACGTTCCCGGGCCT 1047956
#>  [2]  1410 ACGGTACACAGAGAGCTTGCT...CTTCGGGAGGGCGCTTACCAC 818108
#>  [3]  1421 ATTGAACGCTGGCGGCAAGCT...CGCCCGTCACACCATGGGAGT 651366
#>  [4]  1453 AGTCGAGCGGTAACAGTGGGA...TCATGACTGGGGGAAGTCGTA 592303
#>  [5]  1419 ATTGAACGCTGGCGGCAAGCT...CGCCCGTCACACCATGGGAGT 575794
#>  ...   ... ...
#> [23]  1383 TGGGAAACTGCCTGATGGAGG...TAACCTTCGGGAGGGCGGTTT 4336809
#> [24]  1443 GGGTGAGTAATGTCTGGGAAA...GGGTTGCAAAAGAAGTAGGTA 656881
#> [25]  1563 AGAGTTTGATCCTGGCTCAGA...TGAAGTCGTAACAAGGTAACC 4371215
#> [26]  1392 GCGGCGGACGGGTGAGTAATG...GTGGGTAGTTTAACCTTCGGG 4375861
#> [27]  1389 TCGTGCGGTAATAGAGGAACA...AAGCAAGTAGTTTAACCTAAA 4443068
#>
#> $tree
#>
#> Phylogenetic tree with 27 tips and 26 internal nodes.
#>
#> Tip labels:
#>  4371215, 3728119, 656881, 91649, 1963518, 368586, ...
#>
#> Rooted; includes branch lengths.
```

# 2 `mgFeatures-class` Object

`mgFeatures-class` is used for storing and working with marker-gene survey feature data.
Similar to the `MgDb-class`, the `mgFeatures-class` has four slots for taxonomy, sequences, phylogenetic tree, and metadata.
As the number of features in a marker-gene survey dataset is significantly smaller than the number of sequences in a reference database,
`mgFeatures` uses common Bioconductor data structures,
`DataFrames` and `DNAStringSets` to define the taxonomic and sequence slots.
Similar to `MgDb-class`, a `phylo` class object is used to define the tree slot.
Like the `MgDb-class` there are accessor methods, `mgF_*()`, for the fours slots.

New `mgFeatures-class` objects can be defined directly or from a `MgDb-class` object and user defined values for subsetting the database, including database sequence ids.[^2]
The two approaches are demonstrated below.

```
ve_select <- mgDb_select(gg85, type = "all",
               keys = c("Vibrionaceae", "Enterobacteriaceae"),
               keytype = "Family")

mgFeatures(taxa = ve_select$taxa,
           tree = ve_select$tree,
           seq = ve_select$seq,
           metadata = list("gg85 subset Vibrionaceae and Enterobacteriaceae Family"))
#> mgFeatures with 27 rows and 8 columns
#>            Keys     Kingdom            Phylum                  Class
#>     <character> <character>       <character>            <character>
#> 1       1047956 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 2        818108 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 3        651366 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 4        592303 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 5        575794 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> ...         ...         ...               ...                    ...
#> 23      4336809 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 24       656881 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 25      4371215 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 26      4375861 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 27      4443068 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#>                      Ord                Family          Genus     Species
#>              <character>           <character>    <character> <character>
#> 1   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 2   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 3   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 4   o__Enterobacteriales f__Enterobacteriaceae g__Providencia         s__
#> 5   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> ...                  ...                   ...            ...         ...
#> 23  o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 24  o__Enterobacteriales f__Enterobacteriaceae g__Escherichia     s__coli
#> 25  o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 26        o__Vibrionales       f__Vibrionaceae      g__Vibrio         s__
#> 27  o__Enterobacteriales f__Enterobacteriaceae            g__         s__
```

```
annotateFeatures(gg85, query = ve_select$taxa$Keys)
#> mgFeatures with 27 rows and 8 columns
#>            Keys     Kingdom            Phylum                  Class
#>     <character> <character>       <character>            <character>
#> 1       1047956 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 2        818108 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 3        651366 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 4        592303 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 5        575794 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> ...         ...         ...               ...                    ...
#> 23      4336809 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 24       656881 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 25      4371215 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 26      4375861 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#> 27      4443068 k__Bacteria p__Proteobacteria c__Gammaproteobacteria
#>                      Ord                Family          Genus     Species
#>              <character>           <character>    <character> <character>
#> 1   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 2   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 3   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 4   o__Enterobacteriales f__Enterobacteriaceae g__Providencia         s__
#> 5   o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> ...                  ...                   ...            ...         ...
#> 23  o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 24  o__Enterobacteriales f__Enterobacteriaceae g__Escherichia     s__coli
#> 25  o__Enterobacteriales f__Enterobacteriaceae            g__         s__
#> 26        o__Vibrionales       f__Vibrionaceae      g__Vibrio         s__
#> 27  o__Enterobacteriales f__Enterobacteriaceae            g__         s__
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
#> [1] metagenomeFeatures_2.2.3 Biobase_2.42.0
#> [3] BiocGenerics_0.28.0      BiocStyle_2.10.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.0         pillar_1.3.1       compiler_3.5.2
#>  [4] BiocManager_1.30.4 dbplyr_1.3.0       XVector_0.22.0
#>  [7] tools_3.5.2        zlibbioc_1.28.0    digest_0.6.18
#> [10] bit_1.1-14         tibble_2.0.1       RSQLite_2.1.1
#> [13] evaluate_0.13      memoise_1.1.0      nlme_3.1-137
#> [16] lattice_0.20-38    pkgconfig_2.0.2    rlang_0.3.1
#> [19] cli_1.0.1          DBI_1.0.0          yaml_2.2.0
#> [22] xfun_0.5           stringr_1.4.0      dplyr_0.8.0.1
#> [25] knitr_1.21         Biostrings_2.50.2  S4Vectors_0.20.1
#> [28] IRanges_2.16.0     tidyselect_0.2.5   stats4_3.5.2
#> [31] bit64_0.9-7        grid_3.5.2         glue_1.3.0
#> [34] R6_2.4.0           fansi_0.4.0        rmarkdown_1.11
#> [37] bookdown_0.9       purrr_0.3.0        DECIPHER_2.10.2
#> [40] blob_1.1.1         magrittr_1.5       htmltools_0.3.6
#> [43] assertthat_0.2.0   ape_5.2            utf8_1.1.4
#> [46] stringi_1.3.1      lazyeval_0.2.1     crayon_1.3.4
```