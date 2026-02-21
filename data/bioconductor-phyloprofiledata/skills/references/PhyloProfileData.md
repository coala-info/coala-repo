# Overview of PhyloProfileData

Hannah Mülbaier & Vinh Tran

#### 2025-11-04

#### Package

PhyloProfileData 1.24.0

# Contents

* [1 Introduction](#introduction)
* [2 Phylogenetic profiles of AMPK-TOR pathway](#phylogenetic-profiles-of-ampk-tor-pathway)
* [3 Phylogenetic profiles of BUSCO Arthropoda proteins](#phylogenetic-profiles-of-busco-arthropoda-proteins)
* [4 SessionInfo()](#sessioninfo)
* [5 References](#references)
* **Appendix**

# 1 Introduction

The PhyloProfileData package contains two experimental datasets to illustrate
running and analysing phylogenetic profiles with PhyloProfile pakage
(Tran et al. 2018).

```
library(ExperimentHub)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
eh = ExperimentHub()
myData <- query(eh, "PhyloProfileData")
myData
```

```
## ExperimentHub with 6 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Applied Bioinformatics Dept., Goethe University Frankfurt
## # $species: NA
## # $rdataclass: data.frame, AAStringSet
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2544"]]'
##
##            title
##   EH2544 | Phylogenetic profiles of human AMPK-TOR pathway
##   EH2545 | FASTA sequences for proteins in the phylogenetic profiles of hum...
##   EH2546 | Domain annotations for proteins in the phylogenetic profiles of ...
##   EH2547 | Phylogenetic profiles of BUSCO arthropoda proteins
##   EH2548 | FASTA sequences for proteins in the phylogenetic profiles of BUS...
##   EH2549 | Domain annotations for proteins in the phylogenetic profiles of ...
```

# 2 Phylogenetic profiles of AMPK-TOR pathway

The phylogenetic profiles of 147 human proteins in the AMPK-TOR pathway across
83 species in the three domains of life were taken from the study of Roustan et
al. 2016.

This data set includes 3 files:

* A phylogenetic profile input contains the human protein IDs, the taxaonomy IDs
  of the 83 search species and the corresponding orthologous protein IDs in those
  species, together with two additional values, the forward and backward feature
  architecture similarity (FAS) scores. **FAS approach** is an enhancement of
  **FACT** (Koestler et al. 2010) which give an idea how similar two proteins are
  in term of functional equivalence. These compared protein features can be the
  functional PFAM (Finn et al. 2014) or SMART (Letunic et al. 2012) domains, the
  transmembran domains, secondary structures or low complexity regions of the
  protein. FAS scores have a range between 0 and 1, where 1 is for a protein pair
  that have identical architectures, and 0 in cases that two proteins are
  completely different in their architectures.

```
ampkTorPhyloProfile <- myData[["EH2544"]]
head(ampkTorPhyloProfile)
```

```
##       geneID     ncbiID                                orthoID     FAS_F
## 1 ampk_ACACA ncbi284812     ampk_ACACA|SCHPO@284812@1|P78820|1 0.9884601
## 2 ampk_ACACA ncbi665079     ampk_ACACA|SCLS1@665079@1|A7EM01|1 0.9905497
## 3 ampk_ACACA  ncbi35128      ampk_ACACA|THAPS@35128@1|B5YMF5|0 0.9058650
## 4 ampk_ACACA  ncbi35128      ampk_ACACA|THAPS@35128@1|B8BVD1|1 0.9794378
## 5 ampk_ACACA   ncbi7070       ampk_ACACA|TRICA@7070@1|D2A5X8|1 0.9813494
## 6 ampk_ACACA ncbi237631 ampk_ACACA|USTMA@237631@1|A0A0D1DYD5|1 0.9770244
##       FAS_B
## 1 0.9907436
## 2 0.9906191
## 3 0.8169658
## 4 0.9359992
## 5 0.9843459
## 6 0.9456425
```

* A multiple fasta object contains the FASTA sequences for all the proteins
  present in the data set.

```
ampkTorFasta <- myData[["EH2545"]]
head(ampkTorFasta)
```

```
## AAStringSet object of length 6:
##     width seq                                               names
## [1]   297 VGYPVMLKASWGGGGKGIRKVSS...ALRDCVTVRGEIRTTTDYVLDLL ampk_ACACA|CHLRE@...
## [2]  2156 MLRTVKEYVAAYEGKRVIKRLLL...FATLLTYLDRQRIVRRGWFCFDS ampk_ACACA|MONBE@...
## [3]  2326 MPGHSTTGAAGETTPDTQDMVAQ...HLLSDKDREEAVAALRRGSIFHK ampk_ACACA|PHYRM@...
## [4]  2282 MIEINEYIKKLGGDKNIEKILIA...LLPFISTQQKEFLFESLKKDLNK ampk_ACACA|DICDI@...
## [5]  2168 MKAMQETSSPVGFRYDSMEQLCS...NPAIAKAAKVALDSSACAHSTAE ampk_ACACA|LEIMA@...
## [6]  3367 MINFFLSLLLFVLFFENLVVSIK...KIFKMLSQEQRTEFLNKINSYEN ampk_ACACA|PLAF7@...
```

* A data frame contains the domain annotation for the proteins present in
  the phylogenetic profiles. The protein domain annotations were done using
  different annotation tools and databases, including *PFAM*, *SMART*, *CAST*
  (Promponas et al. 2000), *COILS2* (Lupas et al. 1991), *SEG* (Wootton and
  Federhen 1996), *SignalP* (Armenteros et al. 2019), and *TMHMM* (Krogh et al.
  2001). The annotation types together with their domain name and the
  corresponding start and end positions are stored in this domain data frame.

```
ampkTorDomain <- myData[["EH2546"]]
head(ampkTorDomain)
```

```
##                                        seedID                          orthoID
## 1 ampk_ACACA#ampk_ACACA|ANOGA@7165@1|Q7PQ11|1 ampk_ACACA|ANOGA@7165@1|Q7PQ11|1
## 2 ampk_ACACA#ampk_ACACA|ANOGA@7165@1|Q7PQ11|1 ampk_ACACA|ANOGA@7165@1|Q7PQ11|1
## 3 ampk_ACACA#ampk_ACACA|ANOGA@7165@1|Q7PQ11|1 ampk_ACACA|ANOGA@7165@1|Q7PQ11|1
## 4 ampk_ACACA#ampk_ACACA|ANOGA@7165@1|Q7PQ11|1 ampk_ACACA|ANOGA@7165@1|Q7PQ11|1
## 5 ampk_ACACA#ampk_ACACA|ANOGA@7165@1|Q7PQ11|1 ampk_ACACA|ANOGA@7165@1|Q7PQ11|1
## 6 ampk_ACACA#ampk_ACACA|ANOGA@7165@1|Q7PQ11|1 ampk_ACACA|ANOGA@7165@1|Q7PQ11|1
##   length             feature start  end weight path     acc evalue bitscore
## 1   2323    pfam_CPSase_L_D2   260  462     NA   NA PF02786     NA       NA
## 2   2323   pfam_ATPgrasp_Ter   121  352     NA   NA PF15632     NA       NA
## 3   2323   pfam_ATPgrasp_Ter   367  469     NA   NA PF15632     NA       NA
## 4   2323 pfam_Carboxyl_trans  1644 2198     NA   NA PF01039     NA       NA
## 5   2323 smart_Biotin_carb_C   496  603     NA   NA    <NA>     NA       NA
## 6   2323  pfam_Biotin_carb_N   111  231     NA   NA PF00289     NA       NA
##   pStart pEnd pLen
## 1     NA   NA   NA
## 2     NA   NA   NA
## 3     NA   NA   NA
## 4     NA   NA   NA
## 5     NA   NA   NA
## 6     NA   NA   NA
```

# 3 Phylogenetic profiles of BUSCO Arthropoda proteins

One fundamental step in establishing the phylogenetic profiles is searching
orthologs for the query proteins in different taxa of interest.
**HaMStR-oneseq**, an extended version of **HaMStR** (Ebersberger et al. 2009),
has been shown to be an promising approach for sensitively predicting orthologs
even in the distantly related taxa from the query species, which is required for
the phylogenetic profiling of a broad range of taxa through all domains of the
species tree of life. One main parameter for HaMStR-oneseq is the core ortholog
group, the starting point for the orthology search. In order to set up a
reliable core ortholog set that can be used for further phylogenetic profiling
studies, we made use of the well-known **BUSCO** datasets (Simão et al. 2015).
Here we represent the phylogenetic profiles of 1011 ortholog groups across 88
species, which was calculated from the BUSCO arthropoda dataset downloaded from
<https://busco.ezlab.org/datasets/arthropoda_odb9.tar.gz> in Jan. 2018. The 88
species include 10 arthropoda species (*Ladona fulva*, *Agrilus planipennis*,
*Polypedilum vanderplanki*, *Daphnia magna*, *Harpegnathos saltator*,
*Zootermopsis nevadensis*, *Halyomorpha halys*, *Heliconius melpomene*,
*Stegodyphus mimosarum*, *Drosophila willistoni*) downloaded from orthoDB
version 10 (<https://www.orthodb.org>) and 78 species of the Quest for Ortholog
dataset (Altenhoff et al. 2016).

This dataset includes 3 files:

* A phylogenetic profile input contains 1011 BUSCO ortholog group IDs, the
  taxaonomy IDs of the 88 searched species and the corresponding orthologous
  protein IDs in those species, together with two additional values, the forward
  and backward FAS scores which were described above in the description of the
  AMPK-TOR pathway dataset.

```
arthropodaPhyloProfile <- myData[["EH2547"]]
head(arthropodaPhyloProfile)
```

```
##        geneID     ncbiID                                       orthoID
## 1 97421at6656   ncbi9598             97421at6656|PANTR@9598@1|H2QTF9|1
## 2 97421at6656 ncbi321614           97421at6656|PHANO@321614@1|Q0U682|1
## 3 97421at6656   ncbi3218             97421at6656|PHYPA@3218@1|A9TGR3|1
## 4 97421at6656 ncbi319348 97421at6656|POLVAN@319348@0|319348_0:000e70|1
## 5 97421at6656 ncbi208964           97421at6656|PSEAE@208964@1|Q9HXF1|1
## 6 97421at6656  ncbi10116              97421at6656|RAT@10116@1|D3ZAT9|1
##       FAS_F     FAS_B
## 1 0.6872810 0.9654661
## 2 0.7087412 0.9798884
## 3 0.7544057 0.8727715
## 4 0.8062524 0.9610529
## 5 0.7979757 0.9498075
## 6 0.7340443 0.9492033
```

* A multiple fasta object contains the FASTA sequences for all the proteins
  present in the data set.

```
arthropodaFasta <- myData[["EH2548"]]
head(arthropodaFasta)
```

```
## AAStringSet object of length 6:
##     width seq                                               names
## [1]   484 MATSGAFAGGSPGRGFAPRGRAE...GISKLHQQLLYVDRLMLQLRDYA 42842at6656|MONBE...
## [2]   535 MSTRKQYACDLACRLVQDQYGDA...RVNEVMETSLAHLDQMIAVFNDF 42842at6656|CHLRE...
## [3]   607 MLCCLFGVQIKCALLKLLQHNVL...RSLDRLDRAIIHLDGMLMLYRDF 42842at6656|PHYRM...
## [4]   487 MHFSGFKSVVLSCVEEYFDTTAV...INDQIDLIEPIYIKLVETAMLLF 42842at6656|GIAIC...
## [5]   666 MYEQKVAIDIVKESFGDDVTKVF...RITQTLLTVILNLDNDLLHLYSF 42842at6656|DICDI...
## [6]   579 MNKARGTEVAGFITDAAHIRAAL...KGLDRLDFACLQLDETLMVLKDF 42842at6656|THAPS...
```

* A data frame contains the domain annotation for the proteins present in
  the phylogenetic profiles. The protein domain annotations were done using
  different annotation tools and databases, including *PFAM*, *SMART*, *CAST*,
  *COILS2*, *SEG*, *SignalP*, and *TMHMM*. The annotation types together with
  their domain name and the corresponding start and end positions are stored in
  this domain data frame.

```
arthropodaDomain <- myData[["EH2549"]]
head(arthropodaDomain)
```

```
##                                                       seedID
## 1 136365at6656#136365at6656|AGRPL@224129@0|224129_0:000004|1
## 2 136365at6656#136365at6656|AGRPL@224129@0|224129_0:000004|1
## 3            136365at6656#136365at6656|ANOGA@7165@1|Q7QC64|1
## 4            136365at6656#136365at6656|ANOGA@7165@1|Q7QC64|1
## 5            136365at6656#136365at6656|ANOGA@7165@1|Q7QC64|1
## 6          136365at6656#136365at6656|AQUAE@224324@1|O67650|1
##                                         orthoID length
## 1 136365at6656|AGRPL@224129@0|224129_0:000004|1    142
## 2              136365at6656|DROME@7227@1|Q86BM8    138
## 3            136365at6656|ANOGA@7165@1|Q7QC64|1    142
## 4            136365at6656|ANOGA@7165@1|Q7QC64|1    142
## 5              136365at6656|DROME@7227@1|Q86BM8    138
## 6          136365at6656|AQUAE@224324@1|O67650|1     98
##                      feature start end weight path     acc evalue bitscore
## 1         pfam_Ribosomal_L27    26 106     NA    Y PF01016     NA       NA
## 2         pfam_Ribosomal_L27    22 104      1    Y PF01016     NA       NA
## 3         pfam_Ribosomal_L27    26 106     NA    Y PF01016     NA       NA
## 4 seg_low complexity regions    37  46     NA    Y    <NA>     NA       NA
## 5         pfam_Ribosomal_L27    22 104      1    Y PF01016     NA       NA
## 6         pfam_Ribosomal_L27     2  80     NA    Y PF01016     NA       NA
##   pStart pEnd pLen
## 1     NA   NA   NA
## 2     NA   NA   NA
## 3     NA   NA   NA
## 4     NA   NA   NA
## 5     NA   NA   NA
## 6     NA   NA   NA
```

# 4 SessionInfo()

Here is the output of `sessionInfo()` on the system on which this document was
compiles:

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
## character(0)
##
## other attached packages:
## [1] PhyloProfileData_1.24.0
##
## loaded via a namespace (and not attached):
##  [1] methods_4.5.1        graphics_4.5.1       rappdirs_0.3.3
##  [4] sass_0.4.10          generics_0.1.4       BiocVersion_3.22.0
##  [7] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
## [10] evaluate_1.0.5       grDevices_4.5.1      bookdown_0.45
## [13] fastmap_1.2.0        blob_1.2.4           AnnotationHub_4.0.0
## [16] jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
## [19] BiocManager_1.30.26  httr_1.4.7           purrr_1.1.0
## [22] Biostrings_2.78.0    httr2_1.2.1          jquerylib_0.1.4
## [25] cli_3.6.5            crayon_1.5.3         rlang_1.1.6
## [28] BiocStyle_2.38.0     XVector_0.50.0       dbplyr_2.5.1
## [31] Biobase_2.70.0       bit64_4.6.0-1        withr_3.0.2
## [34] utils_4.5.1          cachem_1.1.0         yaml_2.3.10
## [37] stats_4.5.1          tools_4.5.1          base_4.5.1
## [40] memoise_2.0.1        dplyr_1.1.4          filelock_1.0.3
## [43] ExperimentHub_3.0.0  BiocGenerics_0.56.0  curl_7.0.0
## [46] vctrs_0.6.5          R6_2.6.1             png_0.1-8
## [49] stats4_4.5.1         BiocFileCache_3.0.0  lifecycle_1.0.4
## [52] Seqinfo_1.0.0        KEGGREST_1.50.0      S4Vectors_0.48.0
## [55] IRanges_2.44.0       bit_4.6.0            pkgconfig_2.0.3
## [58] pillar_1.11.1        bslib_0.9.0          glue_1.8.0
## [61] xfun_0.54            tibble_3.3.0         tidyselect_1.2.1
## [64] knitr_1.50           datasets_4.5.1       htmltools_0.5.8.1
## [67] rmarkdown_2.30       compiler_4.5.1
```

# 5 References

# Appendix

1. Armenteros, JJA. et al. (2019) SignalP 5.0 improves signal peptide
   predictions using deep neural networks. Nature Biotechnology, 37, 420–423.
2. Altenhoff, AM. et al. (2016) Standardized benchmarking in the quest for
   orthologs. Nature Methods, 13, 425–430.
3. Ebersberger, I. et al. (2009) HaMStR: profile hidden markov model based
   search for orthologs in ESTs. BMC Evol Biol., 9, 157
4. Finn, RD. (2014) Pfam: The protein families database. Nucleic Acids Res.,
   42, D222-30
5. Koestler, T. et al. (2010) FACT: functional annotation transfer between
   proteins with similar feature architectures. BMC Bioinformatics, 11, 417.
6. Kriventseva, EK. et al.(2018) OrthoDB v10: sampling the diversity of animal,
   plant, fungal, protist, bacterial and viral genomes for evolutionary and
   functional annotations of orthologs. Nucleic Acids Res., 47(D1), D807-D811.
7. Krogh, A. et al. (2001) Predicting transmembrane protein topology with a
   hidden Markov model: application to complete genomes. J Mol Biol., 305(3),
   567-80.
8. Letunic, I. et al. (2012) SMART 7: recent updates to the protein domain
   annotation resource. Nucleic Acids Res., 40, D302-5.
9. Lupas, A. et al. (1991) Predicting Coiled Coils from Protein Sequences.
   Science, 252, 1162-1164.
10. Promponas, VJ. et al. (2000) CAST: an iterative algorithm for the
    complexity analysis of sequence tracts. Bioinformatics, 16(10), 915–922.
11. Roustan, V. et al. (2016) An evolutionary perspective of AMPK–TOR signaling
    in the three domains of life. Journal of Experimental Botany, 67(13), 3897–3907.
12. Simão, F. et al. (2015) BUSCO: assessing genome assembly and annotation
    completeness with single-copy orthologs. Bioinformatics, 31(19), 3210-2.
13. Tran, NV. et al. (2018) PhyloProfile: dynamic visualization and exploration
    of multi-layered phylogenetic profiles. Bioinformatics, 34(17), 3041–3043.
14. Wootton, J. and Federhen, S. (1996) Analysis of compositionally biased
    regions in sequence databases. Methods in Enzymol., 266, 554-571.