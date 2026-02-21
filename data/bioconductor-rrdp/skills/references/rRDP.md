# rRDP: Interface to the RDP Classifier

#### Michael Hahsler and Anurag Nagar

Abstract

This package installs and interfaces the naive Bayesian classifier for 16S rRNA sequences developed by the Ribosomal Database Project (RDP). With this package the classifier trained with the standard training set can be used or a custom classifier can be trained.

```
library("rRDP")
#> Loading required package: Biostrings
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: XVector
#> Loading required package: Seqinfo
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#> Warning in fun(libname, pkgname): Package 'rRDP' is deprecated and will be removed from Bioconductor
#>   version 3.23
#>
#> Attaching package: 'rRDP'
#> The following object is masked from 'package:generics':
#>
#>     accuracy
set.seed(1234)
```

# Installation and System Requirements

rRDP requires the Bioconductor package Biostrings and R to be configured with Java.

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("Biostrings")
```

Install rRDP and the database used by the default RDP classifier.

```
BiocManager::install("rRDP")
BiocManager::install("rRDPData")
```

RDP uses Java and you need a working installation of the `rJava` package. You need to have a Java JDK installed. On Linux, you can install Open JDK and run in your shell `R CMD javareconf` to configure R for using Jave. On Windows, you can install the latest version of the JDK from <https://www.oracle.com/java/technologies/downloads/> and set the `JAVA_HOME` environment variable in R using (make sure to use the correct location). An example would look like this:

```
Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jdk-20")
```

Note the double backslashes (i.e. escaped slashes) used in the path.

Details can be found at <https://www.rforge.net/rJava/index.html>. To configure R for Java,

## How to cite this package

```
citation("rRDP")
To cite package 'rRDP' in publications use:

  Hahsler M, Nagar A (2020). "rRDP: Interface to the RDP Classifier."
  Bioconductor version: Release (3.19). doi:10.18129/B9.bioc.rRDP
  <https://doi.org/10.18129/B9.bioc.rRDP>, R package version 1.23.3.

A BibTeX entry for LaTeX users is

  @Misc{,
    title = {{rRDP:} Interface to the {RDP} Classifier},
    author = {Michael Hahsler and Annurag Nagar},
    year = {2020},
    doi = {10.18129/B9.bioc.rRDP},
    note = {R package version 1.23.3},
    howpublished = {Bioconductor version: Release (3.19)},
  }
```

# Classification with RDP

The RDP classifier was developed by the Ribosomal Database Project (Cole et al. 2003) which provides various tools and services to the scientific community for data related to 16S rRNA sequences. The classifier uses a Naive Bayesian approach to quickly and accurately classify sequences. The classifier uses 8-mer counts as features (Wang et al. 2007).

RDP is trained with a 16S rRNA training set. The companion data package `rRDPData` currently ships with trained models for the RDP Classifier 2.14 released in August 2023 which contains the bacterial and archaeal taxonomy training set No. 19 (Wang and Cole 2024).

For the following example we load some test sequences shipped with the package.

```
seq <- readRNAStringSet(system.file("examples/RNA_example.fasta",
    package = "rRDP"
))
seq
#> RNAStringSet object of length 5:
#>     width seq                                               names
#> [1]  1481 AGAGUUUGAUCCUGGCUCAGAAC...GGUGAAGUCGUAACAAGGUAACC 1675 AB015560.1 d...
#> [2]  1404 GCUGGCGGCAGGCCUAACACAUG...CACGGUAAGGUCAGCGACUGGGG 4399 D14432.1 Rho...
#> [3]  1426 GGAAUGCUNAACACAUGCAAGUC...AACAAGGUAGCCGUAGGGGAACC 4403 X72908.1 Ros...
#> [4]  1362 GCUGGCGGAAUGCUUAACACAUG...UACCUUAGGUGUCUAGGCUAACC 4404 AF173825.1 A...
#> [5]  1458 AGAGUUUGAUUAUGGCUCAGAGC...UGAAGUCGUAACAAGGUAACCGU 4411 Y07647.2 Dre...
```

Note that the name contains the annotation from the FASTA file. In this case the annotation contains the actual classification information and is encoded in Greengenes format. For convenience, we replace the annotation with just the sequence id.

```
annotation <- names(seq)

names(seq) <- sapply(strsplit(names(seq), " "), "[", 1)
seq
#> RNAStringSet object of length 5:
#>     width seq                                               names
#> [1]  1481 AGAGUUUGAUCCUGGCUCAGAAC...GGUGAAGUCGUAACAAGGUAACC 1675
#> [2]  1404 GCUGGCGGCAGGCCUAACACAUG...CACGGUAAGGUCAGCGACUGGGG 4399
#> [3]  1426 GGAAUGCUNAACACAUGCAAGUC...AACAAGGUAGCCGUAGGGGAACC 4403
#> [4]  1362 GCUGGCGGAAUGCUUAACACAUG...UACCUUAGGUGUCUAGGCUAACC 4404
#> [5]  1458 AGAGUUUGAUUAUGGCUCAGAGC...UGAAGUCGUAACAAGGUAACCGU 4411
```

Next, we apply RDP with the default training set. Note that the data package `rRDPDate` needs to be installed!

```
pred <- predict(rdp(), seq)
pred
#>        domain         phylum               class            order
#> 1675 Bacteria   Nitrospinota         Nitrospinia    Nitrospinales
#> 4399 Bacteria Pseudomonadota Alphaproteobacteria Rhodospirillales
#> 4403 Bacteria Pseudomonadota Alphaproteobacteria Rhodospirillales
#> 4404 Bacteria Pseudomonadota Alphaproteobacteria Rhodospirillales
#> 4411 Bacteria Pseudomonadota Alphaproteobacteria Rhodospirillales
#>                 family          genus
#> 1675    Nitrospinaceae     Nitrospina
#> 4399 Rhodovibrionaceae    Rhodovibrio
#> 4403  Acetobacteraceae    Roseococcus
#> 4404  Acetobacteraceae Sediminicoccus
#> 4411  Acetobacteraceae           <NA>
```

The prediction confidence is supplied as the attribute `"confidence"`.

```
attr(pred, "confidence")
#>      domain phylum class order family genus
#> 1675      1      1     1     1      1  1.00
#> 4399      1      1     1     1      1  1.00
#> 4403      1      1     1     1      1  1.00
#> 4404      1      1     1     1      1  1.00
#> 4411      1      1     1     1      1  0.29
```

To evaluate the classification accuracy we can compare the known classification with the predictions. The known classification was stored in the FASTA file and encoded in Greengenes format. We can decode the annotation using `decode_Greengenes()`.

```
actual <- decode_Greengenes(annotation)
actual
#>    Kingdom         Phylum               Class             Order
#> 1 Bacteria Proteobacteria Deltaproteobacteria Desulfobacterales
#> 2 Bacteria Proteobacteria Alphaproteobacteria  Rhodospirillales
#> 3 Bacteria Proteobacteria Alphaproteobacteria  Rhodospirillales
#> 4 Bacteria Proteobacteria Alphaproteobacteria  Rhodospirillales
#> 5 Bacteria Proteobacteria Alphaproteobacteria  Rhodospirillales
#>                           Family       Genus               Species  Otu
#> 1                 Nitrospinaceae  Nitrospina               unknown 3187
#> 2              Rhodospirillaceae Rhodovibrio Rhodovibrio salinarum 2816
#> 3               Acetobacteraceae Roseococcus               unknown 2785
#> 4               Acetobacteraceae Roseococcus               unknown 2785
#> 5 Acetobacteraceae; Unclassified     unknown               unknown 2752
#>                                                               Org_name   Id
#> 1                            AB015560.1_deep-sea_sediment_clone_BD4-10 1675
#> 2                        D14432.1_Rhodovibrio_salinarum_str._NCIMB2243 4399
#> 3 X72908.1_Roseococcus_thiosulfatophilus_str._RB-3_Yurkov_strain_Drews 4403
#> 4                                    AF173825.1_Antarctic_clone_LB3-94 4404
#> 5                            Y07647.2_Drentse_grassland_soil_clone_vii 4411
```

Now we can compare the prediction with the actual classification by creating a confusion table and calculating the classification accuracy. Here we do this at the Genus level.

```
confusionTable(actual, pred, rank = "genus")
#>                 predicted
#> actual           Nitrospina Rhodovibrio Roseococcus Sediminicoccus unknown <NA>
#>   Nitrospina              1           0           0              0       0    0
#>   Rhodovibrio             0           1           0              0       0    0
#>   Roseococcus             0           0           1              1       0    0
#>   Sediminicoccus          0           0           0              0       0    0
#>   unknown                 0           0           0              0       0    1
#>   <NA>                    0           0           0              0       0    0
accuracy(actual, pred, rank = "genus")
#> [1] 0.6
```

## Training a custom RDP classifier

RDP can be trained using `trainRDP()`. We use an example of training data that is shipped with the package.

```
trainingSequences <- readDNAStringSet(
    system.file("examples/trainingSequences.fasta", package = "rRDP")
)
trainingSequences
#> DNAStringSet object of length 20:
#>      width seq                                              names
#>  [1]  1384 TAGTGGCGGACGGGTGAGTAACG...GAAGTTCGAATTTGGGTCAAGT 13652 Root;Bacter...
#>  [2]  1386 ATCTCACCTCTCAATAGCGGCGG...GCCGTCGAAGGTGGGGTTGGTG 13655 Root;Bacter...
#>  [3]  1440 ATCTCACCTCTCAATAGCGGCGG...GTGCGGCTGGATCACCTCCTTA 13661 Root;Bacter...
#>  [4]  1421 AATAGCGGCGGACGGGTGAGTAA...GCCGTATCGGAAGGTGCGGCTG 13671 Root;Bacter...
#>  [5]  1439 ATCTCACCTCTCAATANCGGCGG...CGGAAGGTGCGGCTGGATCACC 13677 Root;Bacter...
#>  ...   ... ...
#> [16]  1478 TGGCTCAGGACGAACGCTGGCGG...GTAGCCGTATCGGAAGGTGCGG 13763 Root;Bacter...
#> [17]  1507 CCTGGCTCAGGACGAACGCTGGC...AGCCGTATCGGAAGGTGCGGCT 13781 Root;Bacter...
#> [18]  1481 TGGAGAGTTTGATCCTGGCTCAG...NAACCGCAAGGATATAGCCGTC 13797 Root;Bacter...
#> [19]  1463 CGGCGTGCTTGGACCCACCCAAA...AGGAGGGTCCTAAGGTGGGGGC 13799 Root;Bacter...
#> [20]  1389 CGAGTGGCAAACGGGTGAGTAAC...AAACCGCAAGGATGCAGCCGTC 13800 Root;Bacter...
```

Note that the training data needs to have names in a specific RDP format:

`"<ID> <Kingdom>;<Phylum>;<Class>;<Order>;<Family>;<Genus>"`

In the following we show the name for the first sequence. We use here `sprintf` to display only the first 65~characters so the it fits into a single line.

```
sprintf(names(trainingSequences[1]), fmt = "%.65s...")
#> [1] "13652 Root;Bacteria;Firmicutes;Clostridia;Clostridiales;Peptococc..."
```

Now, we can train a the classifier. The model is stored in a directory specified by the parameter `dir`.

```
customRDP <- trainRDP(trainingSequences, dir = "myRDP")
customRDP
#> RDPClassifier
#> Location: /tmp/Rtmpg3h9wC/Rbuild2bbe0529df4456/rRDP/vignettes/myRDP
```

```
testSequences <- readDNAStringSet(
    system.file("examples/testSequences.fasta", package = "rRDP")
)
pred <- predict(customRDP, testSequences)
pred
#>           domain     Phylum      Class         Order
#> 13811 Firmicutes Firmicutes Clostridia Clostridiales
#> 13813 Firmicutes Firmicutes Clostridia Clostridiales
#> 13678 Firmicutes Firmicutes Clostridia Clostridiales
#> 13755 Firmicutes Firmicutes Clostridia Clostridiales
#> 13661 Firmicutes Firmicutes Clostridia Clostridiales
#>                                                  Family                 Genus
#> 13811                                   Veillonellaceae           Selenomonas
#> 13813                                   Veillonellaceae           Selenomonas
#> 13678                                    Peptococcaceae      Desulfotomaculum
#> 13755 Thermoanaerobacterales Family III. Incertae Sedis Thermoanaerobacterium
#> 13661                                    Peptococcaceae      Desulfotomaculum
```

Since the custom classifier is stored on disc it can be recalled anytime using `rdp()`.

```
customRDP <- rdp(dir = "myRDP")
```

To permanently remove the classifier use `removeRDP()`. This will delete the directory containing the classifier files.

```
removeRDP(customRDP)
```

# Session Info

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
#>  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
#>  [3] LC_TIME=en_GB                 LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
#>  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
#> [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] rRDP_1.44.0         Biostrings_2.78.0   Seqinfo_1.0.0
#> [4] XVector_0.50.0      IRanges_2.44.0      S4Vectors_0.48.0
#> [7] BiocGenerics_0.56.0 generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
#>  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 rJava_1.0-11
#>  [9] rmarkdown_2.30    lifecycle_1.0.4   cli_3.6.5         sass_0.4.10
#> [13] jquerylib_0.1.4   compiler_4.5.1    tools_4.5.1       evaluate_1.0.5
#> [17] bslib_0.9.0       yaml_2.3.10       crayon_1.5.3      rlang_1.1.6
#> [21] jsonlite_2.0.0
```

# Acknowledgments

This research is supported by research grant no. R21HG005912 from the National Human Genome Research Institute (NHGRI / NIH).

# References

Cole, J. R., B. Chai, T. L. Marsh, R. J. Farris, Q. Wang, S. A. Kulam, S. Chandra, et al. 2003. “The Ribosomal Database Project (RDP-II): Previewing a New Autoaligner That Allows Regular Updates and the New Prokaryotic Taxonomy.” *Nucleic Acids Research* 31 (1): 442–43. <https://doi.org/10.1093/nar/gkg039>.

Wang, Qiong, and James R. Cole. 2024. “Updated Rdp Taxonomy and Rdp Classifier for More Accurate Taxonomic Classification.” *Microbiology Resource Announcements* 0 (0): e01063–23. <https://doi.org/10.1128/mra.01063-23>.

Wang, Qiong, George M Garrity, James M Tiedje, and James R Cole. 2007. “Naive Bayesian Classifier for Rapid Assignment of rRNA Sequences into the New Bacterial Taxonomy.” *Applied and Environmental Microbiology* 73 (16): 5261–7.