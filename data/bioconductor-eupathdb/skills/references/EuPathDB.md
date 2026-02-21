# Accessing EuPathDB Resources using AnnotationHub

**Authors**: V. Keith Hughitt
 **Modified:** 2018-11-13 11:26:16
 **Compiled**: Wed Nov 14 14:19:21 2018

# Overview

This tutorial describes how to query and make use of annotations retrieved from [EuPathDB : The Eukaryotic Pathogen Genomics Resource](http://eupathdb.org/eupathdb/) using [AnnotationHub](http://bioconductor.org/packages/release/bioc/html/AnnotationHub.html).

For more information on using AnnotationHub, check out the AnnotationHub vignettes:

* [AnnotationHub: Access the AnnotationHub Web Service](http://bioconductor.org/packages/release/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub-HOWTO.html)
* [AnnotationHub How-To’s](http://bioconductor.org/packages/release/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub-HOWTO.html)

The resources described in this tutorial were generating using GFF files and web API requests made to the various EuPathDB databases (TriTrypDB, ToxoDB, etc.) Only organisms with annotated genomes (those for which GFF files are available) are accessible through AnnotationHub.

The two main resources provided are:

* [OrgDb](https://www.bioconductor.org/help/workflows/annotation/annotation/#OrgDb)
* [GRanges](http://bioconductor.org/packages/release/bioc/html/GenomicRanges.html)

OrgDb objects for an organism include basic gene-level information such as:

* Gene ID
* Gene description
* Chromosome number
* GO terms associated with gene
* KEGG Pathways associated with gene
* Etc.

For some organisms, [InterPro](https://www.ebi.ac.uk/interpro/) protein domain information is also available (in some cases, however, even though InterPro domain information is available through EuPathDB, it is too large to be included in the current AnnotationHub resources).

For more information about working with Bioconductor annotation resources, see:

* [Genomic Annotation Resources in Bioconductor](https://www.bioconductor.org/help/workflows/annotation/annotation/)

# Installation

If you don’t already have AnnotationHub installed on your system, use `BiocManager::install` to install the package:

```
install.packages("BiocManager")
BiocManager::install("AnnotationHub")
```

# Getting started

To begin, let’s create a new `AnnotationHub` connection and use it to query AnnotationHub for all EuPathDB resources.

```
library('AnnotationHub')
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colMeans, colSums, colnames,
##     dirname, do.call, duplicated, eval, evalq, get, grep, grepl,
##     intersect, is.unsorted, lapply, lengths, mapply, match, mget,
##     order, paste, pmax, pmax.int, pmin, pmin.int, rank, rbind,
##     rowMeans, rowSums, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which, which.max, which.min
```

```
# create an AnnotationHub connection
ah <- AnnotationHub()
```

```
## updating metadata:
```

```
## snapshotDate(): 2018-10-24
```

```
# search for all EuPathDB resources
meta <- query(ah, "EuPathDB")

length(meta)
```

```
## [1] 530
```

```
head(meta)
```

```
## AnnotationHub with 6 records
## # snapshotDate(): 2018-10-24
## # $dataprovider: FungiDB, TriTrypDB, MicrosporidiaDB
## # $species: Aspergillus sydowii, Aspergillus versicolor, Edhazardia aed...
## # $rdataclass: OrgDb
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass,
## #   tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH65001"]]'
##
##             title
##   AH65001 | Edhazardia aedis USNM 41457 genome wide annotations
##   AH65002 | Aspergillus versicolor CBS 583.65 genome wide annotations
##   AH65003 | Aspergillus sydowii CBS 593.65 genome wide annotations
##   AH65004 | Phytophthora cinnamomi var. cinnamomi CBS 144.22 genome wid...
##   AH65005 | Trypanosoma vivax Y486 genome wide annotations
##   AH65006 | Trypanosoma congolense IL3000 genome wide annotations
```

```
# types of EuPathDB data available
table(meta$rdataclass)
```

```
##
## GRanges   OrgDb
##     265     265
```

```
# distribution of resources by specific databases
table(meta$dataprovider)
```

```
##
##        AmoebaDB        CryptoDB         FungiDB       GiardiaDB
##              22              26             228               2
## MicrosporidiaDB    PiroplasmaDB        PlasmoDB          ToxoDB
##              60              18              54              52
##       TriTrypDB         TrichDB
##              66               2
```

```
# list of organisms for which resources are available
length(unique(meta$species))
```

```
## [1] 196
```

```
head(unique(meta$species))
```

```
## [1] "Edhazardia aedis"       "Aspergillus versicolor"
## [3] "Aspergillus sydowii"    "Phytophthora cinnamomi"
## [5] "Trypanosoma vivax"      "Trypanosoma congolense"
```

# Working with EuPathDB OrgDb resources

Next, we will see how you can query AnnotationHub for EuPathDB OrgDb resources.

To begin, create an AnnotationHub connection, if you have not already done so, as shown in the section above.

You can now use the `query` function to search for your organism of interest and store the result as follows:

```
res <- query(ah, c('Leishmania major strain Friedlin', 'OrgDb', 'EuPathDB'))
res
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2018-10-24
## # names(): AH65089
## # $dataprovider: TriTrypDB
## # $species: Leishmania major
## # $rdataclass: OrgDb
## # $rdatadateadded: 2018-10-15
## # $title: Leishmania major strain Friedlin genome wide annotations
## # $description: TriTrypDB 39 genome annotations for Leishmania major st...
## # $taxonomyid: 347515
## # $genome: TriTrypDB-39_LmajorFriedlin
## # $sourcetype: GFF
## # $sourceurl: http://TriTrypDB.org/common/downloads/Current_Release/Lma...
## # $sourcesize: NA
## # $tags:
## #   c("Annotation,EuPathDB,Eukaryote,Pathogen,Parasite,Trypanosome,Kinetoplastid,Leishmania",
## #   "EuPathDB")
## # retrieve record with 'object[["AH65089"]]'
```

The result includes a single record, “AH56967”. The record can be accessed from the result variable using list-like indexing:

```
orgdb <- res[['AH65089']]
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
##     '/Users/da42327_ca//.AnnotationHub/71835'
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: stats4
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:AnnotationHub':
##
##     cache
```

```
## Loading required package: IRanges
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:base':
##
##     expand.grid
```

```
class(orgdb)
```

```
## [1] "OrgDb"
## attr(,"package")
## [1] "AnnotationDbi"
```

We can see that we now have an OrgDb instance, and as such, we can use the usual methods available for working this OrgDb objects, including:

* `columns()`
* `keys()`
* `select()`

```
# list available fields to retrieve
columns(orgdb)
```

```
##  [1] "CHR"                   "EVIDENCE_CODE"
##  [3] "GENEDESCRIPTION"       "GENESOURCE"
##  [5] "GENETYPE"              "GID"
##  [7] "GO_ID"                 "GO_TERM_NAME"
##  [9] "INTERPRO_DESC"         "INTERPRO_END_MIN"
## [11] "INTERPRO_E_VALUE"      "INTERPRO_FAMILY_ID"
## [13] "INTERPRO_NAME"         "INTERPRO_PRIMARY_ID"
## [15] "INTERPRO_SECONDARY_ID" "INTERPRO_START_MIN"
## [17] "ONTOLOGY"              "PATHWAY"
## [19] "PATHWAY_SOURCE"        "PATHWAY_SOURCE_ID"
## [21] "SOURCE"                "TRANSCRIPT_IDS"
## [23] "TYPE"
```

```
# create a vector containing all gene ids for the organism
gids <- keys(orgdb, keytype='GID')
head(gids)
```

```
## [1] "LmjF.24.0370" "LmjF.34.2180" "LmjF.36.2890" "LmjF.28.0420"
## [5] "LmjF.16.0980" "LmjF.22.0730"
```

```
# retrieve the chromosome, description, and biotype for each gene
dat <- select(orgdb, keys=gids, keytype='GID', columns=c('CHR', 'TYPE', 'GENEDESCRIPTION'))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
head(dat)
```

```
##            GID     CHR           TYPE
## 1 LmjF.24.0370 LmjF.24 protein coding
## 2 LmjF.34.2180 LmjF.34 protein coding
## 3 LmjF.36.2890 LmjF.36 protein coding
## 4 LmjF.28.0420 LmjF.28 protein coding
## 5 LmjF.16.0980 LmjF.16 protein coding
## 6 LmjF.22.0730 LmjF.22 protein coding
##                                                GENEDESCRIPTION
## 1                         aspartate aminotransferase, putative
## 2                              hypothetical protein, conserved
## 3 ATP-binding cassette protein subfamily G, member 6, putative
## 4                 hypothetical protein, conserved (pseudogene)
## 5                              hypothetical protein, conserved
## 6                    cytoskeleton associated protein, putative
```

```
table(dat$TYPE)
```

```
##
## non protein coding     protein coding      rRNA encoding
##                 83               8402                 63
##     snRNA encoding    snoRNA encoding      tRNA encoding
##                  6                741                 83
```

```
table(dat$CHR)
```

```
##
## LmjF.01 LmjF.02 LmjF.03 LmjF.04 LmjF.05 LmjF.06 LmjF.07 LmjF.08 LmjF.09
##      85     136      97     130     159     135     130     136     182
## LmjF.10 LmjF.11 LmjF.12 LmjF.13 LmjF.14 LmjF.15 LmjF.16 LmjF.17 LmjF.18
##     150     148     142     170     159     192     177     162     219
## LmjF.19 LmjF.20 LmjF.21 LmjF.22 LmjF.23 LmjF.24 LmjF.25 LmjF.26 LmjF.27
##     179     276     233     181     229     246     322     495     385
## LmjF.28 LmjF.29 LmjF.30 LmjF.31 LmjF.32 LmjF.33 LmjF.34 LmjF.35 LmjF.36
##     319     300     408     346     430     424     500     615     781
```

```
# create a gene / GO term mapping
gene_go_mapping <- select(orgdb, keys=gids, keytype='GID', columns=c('GO_ID', 'GO_TERM_NAME', 'ONTOLOGY'))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
head(gene_go_mapping)
```

```
##            GID      GO_ID                GO_TERM_NAME           ONTOLOGY
## 1 LmjF.24.0370 GO:0009058        biosynthetic process Biological Process
## 2 LmjF.24.0370 GO:0005737                   cytoplasm Cellular Component
## 3 LmjF.24.0370 GO:0031981               nuclear lumen Cellular Component
## 4 LmjF.24.0370 GO:0097014               ciliary plasm Cellular Component
## 5 LmjF.24.0370 GO:0030170 pyridoxal phosphate binding Molecular Function
## 6 LmjF.34.2180 GO:0005488                     binding Molecular Function
```

```
# retrieve KEGG, etc. pathway annotations
gene_pathway_mapping <- select(orgdb, keys=gids, keytype='GID', columns=c('PATHWAY', 'PATHWAY_SOURCE'))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
table(gene_pathway_mapping$PATHWAY_SOURCE)
```

```
##
##       KEGG   LeishCyc    MetaCyc TrypanoCyc
##      15803       2367      66680       2475
```

```
head(gene_pathway_mapping)
```

```
##            GID                                                   PATHWAY
## 1 LmjF.24.0370                  L-asparagine degradation III (mammalian)
## 2 LmjF.24.0370                                 L-aspartate degradation I
## 3 LmjF.24.0370                                    aspartate biosynthesis
## 4 LmjF.24.0370                                  L-aspartate biosynthesis
## 5 LmjF.24.0370                                    aspartate biosynthesis
## 6 LmjF.24.0370 superpathway of L-aspartate and L-asparagine biosynthesis
##   PATHWAY_SOURCE
## 1        MetaCyc
## 2        MetaCyc
## 3       LeishCyc
## 4        MetaCyc
## 5     TrypanoCyc
## 6        MetaCyc
```

# Working with EuPathDB GRanges resources

In addition to retrieving gene annotations, AnnotationHub can also be used to query GenomicRange (GRange) objects containing information about gene and transcript structure.

```
# query AnnotationHub
res <- query(ah, c('Leishmania major strain Friedlin', 'GRanges', 'EuPathDB'))
res
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2018-10-24
## # names(): AH65354
## # $dataprovider: TriTrypDB
## # $species: Leishmania major
## # $rdataclass: GRanges
## # $rdatadateadded: 2018-10-15
## # $title: Leishmania major strain Friedlin transcript information
## # $description: TriTrypDB 39 transcript information for Leishmania majo...
## # $taxonomyid: 347515
## # $genome: TriTrypDB-39_LmajorFriedlin
## # $sourcetype: GFF
## # $sourceurl: http://TriTrypDB.org/common/downloads/Current_Release/Lma...
## # $sourcesize: NA
## # $tags:
## #   c("Annotation,EuPathDB,Eukaryote,Pathogen,Parasite,Trypanosome,Kinetoplastid,Leishmania",
## #   "EuPathDB")
## # retrieve record with 'object[["AH65354"]]'
```

```
# retrieve a GRanges instance associated with the result record
gr <- res[['AH65354']]
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
##     '/Users/da42327_ca//.AnnotationHub/72100'
```

```
## require("GenomicRanges")
```

```
gr
```

```
## GRanges object with 37311 ranges and 9 metadata columns:
##           seqnames        ranges strand |   source     type     score
##              <Rle>     <IRanges>  <Rle> | <factor> <factor> <numeric>
##       [1]  LmjF.24 117748-119043      + | EuPathDB     gene      <NA>
##       [2]  LmjF.24 117748-119043      + | EuPathDB     mRNA      <NA>
##       [3]  LmjF.24 117748-119043      + | EuPathDB     exon      <NA>
##       [4]  LmjF.24 117748-119043      + | EuPathDB      CDS      <NA>
##       [5]  LmjF.34 961963-966600      - | EuPathDB     gene      <NA>
##       ...      ...           ...    ... .      ...      ...       ...
##   [37307]  LmjF.11 425050-425856      + | EuPathDB      CDS      <NA>
##   [37308]  LmjF.27 718772-719071      - | EuPathDB     gene      <NA>
##   [37309]  LmjF.27 718772-719071      - | EuPathDB     mRNA      <NA>
##   [37310]  LmjF.27 718772-719071      - | EuPathDB     exon      <NA>
##   [37311]  LmjF.27 718772-719071      - | EuPathDB      CDS      <NA>
##               phase                        ID
##           <integer>               <character>
##       [1]      <NA>              LmjF.24.0370
##       [2]      <NA>         LmjF.24.0370:mRNA
##       [3]      <NA>      exon_LmjF.24.0370-E1
##       [4]         0 LmjF.24.0370:mRNA-p1-CDS1
##       [5]      <NA>              LmjF.34.2180
##       ...       ...                       ...
##   [37307]         0 LmjF.11.1030:mRNA-p1-CDS1
##   [37308]      <NA>              LmjF.27.1740
##   [37309]      <NA>         LmjF.27.1740:mRNA
##   [37310]      <NA>      exon_LmjF.27.1740-E1
##   [37311]         0 LmjF.27.1740:mRNA-p1-CDS1
##                                      description            Parent
##                                      <character>   <CharacterList>
##       [1]   aspartate aminotransferase, putative              <NA>
##       [2]   aspartate aminotransferase, putative      LmjF.24.0370
##       [3]                                   <NA> LmjF.24.0370:mRNA
##       [4]                                   <NA> LmjF.24.0370:mRNA
##       [5]        hypothetical protein, conserved              <NA>
##       ...                                    ...               ...
##   [37307]                                   <NA> LmjF.11.1030:mRNA
##   [37308] hypothetical protein, unknown function              <NA>
##   [37309] hypothetical protein, unknown function      LmjF.27.1740
##   [37310]                                   <NA> LmjF.27.1740:mRNA
##   [37311]                                   <NA> LmjF.27.1740:mRNA
##                                       Note    protein_source_id
##                            <CharacterList>          <character>
##       [1]                             <NA>                 <NA>
##       [2] 2.6.1.1 (Aspartate transaminase)                 <NA>
##       [3]                             <NA>                 <NA>
##       [4]                             <NA> LmjF.24.0370:mRNA-p1
##       [5]                             <NA>                 <NA>
##       ...                              ...                  ...
##   [37307]                             <NA> LmjF.11.1030:mRNA-p1
##   [37308]                             <NA>                 <NA>
##   [37309]                             <NA>                 <NA>
##   [37310]                             <NA>                 <NA>
##   [37311]                             <NA> LmjF.27.1740:mRNA-p1
##   -------
##   seqinfo: 36 sequences from TriTrypDB-39_LmajorFriedlin genome; no seqlengths
```

The resulting `GRanges` object can then be interacted with using the [standard GRanges functions](https://bioconductor.org/packages/3.7/bioc/vignettes/GenomicRanges/inst/doc/GenomicRangesIntroduction.pdf), including:

* seqnames
* strand
* width

```
# chromosome names
seqnames(gr)
```

```
## factor-Rle of length 37311 with 9006 runs
##   Lengths:       4       4       4       4 ...       4       4       4
##   Values : LmjF.24 LmjF.34 LmjF.36 LmjF.28 ... LmjF.04 LmjF.11 LmjF.27
## Levels(36): LmjF.01 LmjF.02 LmjF.03 LmjF.04 ... LmjF.34 LmjF.35 LmjF.36
```

```
# strand information
strand(gr)
```

```
## factor-Rle of length 37311 with 4630 runs
##   Lengths:  4 12  4  4  4  4  3  4 31  4 ...  8  8  4  4  4  4  4 23  4  4
##   Values :  +  -  +  -  +  -  +  -  +  - ...  +  -  +  -  +  -  +  -  +  -
## Levels(3): + - *
```

```
# feature widths
width(gr)
```

```
##     [1]  1296  1296  1296  1296  4638  4638  4638  4638  2007  2007  2007
##    [12]  2007  1368  1368  1368  1368  3462  3462  3462  3462  1320  1320
##    [23]  1320  1320  1236  1236  1236  1236  1095  1095  1095  1095    74
##    [34]    74    74  2556  2556  2556  2556  2598  2598  2598  2598   104
##    [45]   104   104   906   906   906   906  1488  1488  1488  1488  2427
##    [56]  2427  2427  2427  1185  1185  1185  1185  3192  3192  3192  3192
##    [67]  1851  1851  1851  1851  3912  3912  3912  3912   120   120   120
##    [78]  1809  1809  1809  1809  1026  1026  1026  1026   303   303   303
##    [89]   303  6609  6609  6609  6609   447   447   447   447  2484  2484
##   [100]  2484  2484  1525  1525  1525  1218  1218  1218  1218  3069  3069
##   [111]  3069  3069  1080  1080  1080  1080   102   102   102    90    90
##   [122]    90  5403  5403  5403  5403  2592  2592  2592  2592   747   747
##   [133]   747   747   345   345   345   345   844   844   480   363   480
##   [144]   363  2115  2115  2115  2115   447   447   447   447   684   684
##   [155]   684   684    70    70    70  4434  4434  4434  4434  2586  2586
##   [166]  2586  2586  2204  2204  2204  1710  1710  1710  1710   645   645
##   [177]   645   645  2445  2445  2445  2445   606   606   606   606  1806
##   [188]  1806  1806  1806  3916  3916  1482   504   834  1091  1482   504
##   [199]   834  1089     2   807   807   807   807  1557  1557  1557  1557
##   [210]  1971  1971  1971  1971  1554  1554  1554  1554  1992  1992  1992
##   [221]  1992   900   900   900   900   405   405   405   405   104   104
##   [232]   104    62    62    62  1989  1989  1989  1989   129   129   129
##   [243]  4890  4890  4890  4890   453   453   453   453    92    92    92
##   [254]  5856  5856  5856  5856   711   711   711   711  1404  1404  1404
##   [265]  1404   789   789   789   789  1860  1860  1860  1860   324   324
##   [276]   324   324   774   774   774   774  3555  3555  3555  3555 11388
##   [287] 11388 11388 11388   348   348   348   348   573   573   573   573
##   [298]  3078  3078  3078  3078  2019  2019  2019  2019  2073  2073  2073
##   [309]  2073   474   474   474   474   960   960   960   960  1833  1833
##   [320]  1833  1833    92    92    92  2676  2676  2676  2676   483   483
##   [331]   483   483  1086  1086  1086  1086  2055  2055  2055  2055  1533
##   [342]  1533  1533  1533   285   285   285   285  1686  1686  1686  1686
##   [353]  4146  4146  4146  4146  1806  1806  1806  1806  3418  1299  3418
##   [364]  1299  3418  1155  1785   144  1633  1041  1041  1041  1041   104
##   [375]   104   104  1704  1704  1704  1704    70    70    70  1098  1098
##   [386]  1098  1098  2145  2145  2145  2145   861   861   861   861   453
##   [397]   453   453   453  1443  1443  1443  1443  1935  1935  1935  1935
##   [408]  2568  2568  2568  2568  1536  1536  1536  1536  1662  1662  1662
##   [419]  1662  1221  1221  1221  1221  1890  1890  1890  1890   600   600
##   [430]   600   600  3465  3465  3465  3465  1533  1533  1533  1533   540
##   [441]   540   540   540   486   486   486   486  1827  1827  1827  1827
##   [452]   435   435   435   435  1749  1749  1749  1749  4347  4347  4347
##   [463]  4347    73    73    73   675   675   675   675   119   119   119
##   [474]    66    66    66   366   366   366   366   768   768   768   768
##   [485]  1938  1938  1938  1938  1863  1863  1863  1863   582   582   582
##   [496]   582    90    90    90  1515  1515  1515  1515  1239  1239  1239
##   [507]  1239  1374  1374  1374  1374    70    70    70  2709  2709  2709
##   [518]  2709  1227  1227  1227  1227  1209  1209  1209  1209  7305  7305
##   [529]  7305  7305   939   939   939   939  3465  3465  3465  3465   912
##   [540]   912   912   912   570   570   570   570  3915  3915  3915  3915
##   [551]    91    91    91  1476  1476  1476  1476    66    66    66   606
##   [562]   606   606   606  4803  4803  4803  4803   585   585   585   585
##   [573]  1419  1419  1419  1419  1356  1356  1356  1356  5454  5454  5454
##   [584]  5454  2199  2199  2199  2199    94    94    94  2343  2343  2343
##   [595]  2343   375   375   375   375   702   702   702   702   267   267
##   [606]   267   267  3123  3123  3123  3123  1485  1485  1485  1485   612
##   [617]   612   612   612  2514  2514  2514  2514  1860  1860  1860  1860
##   [628]  1752  1752  1752  1752  1383  1383  1383  1383   300   300   300
##   [639]   300   474   474   474   474  1386  1386  1386  1386   119   119
##   [650]   119   131   131   131   573   573   573   573  1089  1089  1089
##   [661]  1089  1002  1002  1002  1002  5487  5487  5487  5487  3270  3270
##   [672]  3270  3270   384   384   384   384   882   882   882   882    72
##   [683]    72    72  1020  1020  1020  1020  1923  1923  1923  1923  2181
##   [694]  2181  2181  2181  1521  1521  1521  1521  1887  1887  1887  1887
##   [705]   807   807   807   807   825   825   825   825  3966  3966  3966
##   [716]  3966  1017  1017  1017  1017  1794  1794  1794  1794  1746  1746
##   [727]  1746  1746    89    89    89  2520  2520  2520  2520   753   753
##   [738]   753   753   576   576   576   576  1035  1035  1035  1035   816
##   [749]   816   816   816   522   522   522   522  2628  2628  2628  2628
##   [760]   906   906   906   906  2865  2865  2865  2865   336   336   336
##   [771]   336   990   990   990   990   978   978   978   978  3357  3357
##   [782]  3357  3357    90    90    90  3183  3183  3183  3183   735   735
##   [793]   735   735  3009  3009  3009  3009  1515  1515  1515  1515  2133
##   [804]  2133  2133  2133  2067  2067  2067  2067  8718  8718  8718  8718
##   [815]  8070  8070  8070  8070   672   672   672   672  6792  6792  6792
##   [826]  6792  8682  8682  8682  8682    91    91    91   455   455   455
##   [837]  2349  2349  2349  2349  4185  4185  4185  4185   804   804   804
##   [848]   804  2205  2205  2205  2205 12498 12498 12498 12498  1525  1525
##   [859]  1525  2586  2586  2586  2586  1224  1224  1224  1224  2907  2907
##   [870]  2907  2907  1332  1332  1332  1332   354   354   354   354  2439
##   [881]  2439  2439  2439  7356  7356  7356  7356  4125  4125  4125  4125
##   [892]  1032  1032  1032  1032  2325  2325  2325  2325  1734  1734  1734
##   [903]  1734  2058  2058  2058  2058   504   504   504   504  3675  3675
##   [914]  3675  3675   449   449   449  2013  2013  2013  2013  1391  1391
##   [925]   585   180   624   585   180   624  2292  2292  2292  2292  1485
##   [936]  1485  1485  1485  3264  3264  3264  3264    78    78    78  1266
##   [947]  1266  1266  1266  5730  5730  5730  5730  1734  1734  1734  1734
##   [958]  2193  2193  2193  2193  3597  3597  3597  3597  1434  1434  1434
##   [969]  1434  1656  1656  1656  1656  1440  1440  1440  1440   609   609
##   [980]   609   609  1536  1536  1536  1536  2343  2343  2343  2343   119
##   [991]   119   119  2574  2574  2574  2574  1374  1374  1374  1374  4446
##  [1002]  4446  4446  4446  1515  1515  1515  1515  3582  3582  3582  3582
##  [1013]  2682  2682  2682  2682   765   765   765   765  1686  1686  1686
##  [1024]  1686   528   528   528   528   567   567   567   567   831   831
##  [1035]   831   831   174   174   174   174   891   891   891   891   843
##  [1046]   843   843   843  1095  1095  1095  1095  2409  2409  2409  2409
##  [1057]  1065  1065  1065  1065  1953  1953  1953  1953  2187  2187  2187
##  [1068]  2187  1011  1011  1011  1011   312   312   312   312   657   657
##  [1079]   657   657  2619  2619  2619  2619  2571  2571  2571  2571    73
##  [1090]    73    73  2757  2757  2757  2757   540   540   540   540  1718
##  [1101]   326  1718   326  1718   300   549    26  1169  2406  2406  2406
##  [1112]  2406 14391 14391 14391 14391   681   681   681   681   825   825
##  [1123]   825   825  2274  2274  2274  2274  1260  1260  1260  1260  1083
##  [1134]  1083  1083  1083   906   906   906   906   252   252   252   252
##  [1145]   801   801   801   801  2331  2331  2331  2331  3012  3012  3012
##  [1156]  3012   498   498   498   498  2898  2898  2898  2898  1932  1932
##  [1167]  1932  1932   327   327   327   327  1155  1155  1155  1155   573
##  [1178]   573   573   573  1041  1041  1041  1041   753   753   753   753
##  [1189]  1041  1041  1041  1041  1333  1333   234   606   102   387   234
##  [1200]   606   102   387  1203  1203  1203  1203    68    68    68  3255
##  [1211]  3255  3255  3255   528   528   528   528  1500  1500  1500  1500
##  [1222]  1905  1905  1905  1905    72    72    72  1335  1335  1335  1335
##  [1233]  1023  1023  1023  1023    89    89    89  1140   587  1140  1140
##  [1244]   587   729   405   411   182  1605  1605  1605  1605  1092  1092
##  [1255]  1092  1092  1608  1608  1608  1608   693   693   693   693    73
##  [1266]    73    73  1194  1194  1194  1194  2748  2748  2748  2748   455
##  [1277]   455   455  1602  1602  1602  1602  1467  1467  1467  1467  1050
##  [1288]  1050  1050  1050  3810  3810  3810  3810   174   174   174   174
##  [1299]   507   507   507   507   101   101   101   822   822   822   822
##  [1310]  3027  3027  3027  3027  2490  2490  2490  2490  1188  1188  1188
##  [1321]  1188    78    78    78  2154  2154  2154  2154  4050  4050  4050
##  [1332]  4050   468   468   468   468  1305  1305  1305  1305   666   666
##  [1343]   666   666   906   906   906   906   792   792   792   792  2883
##  [1354]  2883  2883  2883   273   273   273   273    69    69    69  3078
##  [1365]  3078  3078  3078   888   888   888   888   570   570   570   570
##  [1376]   951   951   951   951  1641  1641  1641  1641  1143  1143  1143
##  [1387]  1143  7041  7041  7041  7041  2625  2625  2625  2625  1068  1068
##  [1398]  1068  1068  1905  1905  1905  1905  2029  1868  2029  2029  1868
##  [1409]  1923  1845   106    23   417   417   417   417  1056  1056  1056
##  [1420]  1056  1086  1086  1086  1086  2478  2478  2478  2478    69    69
##  [1431]    69   840   840   840   840   597   597   597   597   504   504
##  [1442]   504   504  2403  2403  2403  2403  1995  1995  1995  1995   972
##  [1453]   972   972   972  3345  3345  3345  3345  3030  3030  3030  3030
##  [1464]  8247  8247  8247  8247  1527  1527  1527  1527  2805  2805  2805
##  [1475]  2805  1041  1041  1041  1041  1455  1455  1455  1455  2967  2967
##  [1486]  2967  2967  1374  1374  1374  1374  2598  2598  2598  2598  2508
##  [1497]  2508  2508  2508   933   933   933   933  2790  2790  2790  2790
##  [1508]  2106  2106  2106  2106  1542  1542  1542  1542   114   114   114
##  [1519]  1314  1314  1314  1314   663   663   663   663  3690  3690  3690
##  [1530]  3690   393   393   393   393   651   651   651   651   630   630
##  [1541]   630   630  1792  1792   453   687   648   453   687   648    90
##  [1552]    90    90   573   573   573   573  4197  4197  4197  4197    74
##  [1563]    74    74   696   696   696   696    95    95    95  1941  1941
##  [1574]  1941  1941    78    78    78  1911  1911  1911  1911  3426  3426
##  [1585]  3426  3426   531   531   531   531   777   777   777   777  2244
##  [1596]  2244  2244  2244  4374  4374  4374  4374  2118  2118  2118  2118
##  [1607] 11895 11895 11895 11895  1089  1089  1089  1089   924   924   924
##  [1618]   924   771   771   771   771   678   678   678   678  1962  1962
##  [1629]  1962  1962  1281  1281  1281  1281   705   705   705   705  1344
##  [1640]  1344  1344  1344  2664  2664  2664  2664  2967  2967  2967  2967
##  [1651]   324   324   324   324  1818  1818  1818  1818  1830  1830  1830
##  [1662]  1830  3420  3420  3420  3420  2424  2424  2424  2424  1341  1341
##  [1673]  1341  1341  2370  2370  2370  2370  8313  8313  8313  8313  1023
##  [1684]  1023  1023  1023  1251  1251  1251  1251   618   618   618   618
##  [1695]   861   861   861   861   459   459   459   459  3183  3183  3183
##  [1706]  3183  1780  1780  1780   825   825   825   825   837   837   837
##  [1717]   837  7377  7377  7377  7377  5730  5730  5730  5730  1506  1506
##  [1728]  1506  1506  3573  3573  3573  3573  1533  1533  1533  1533  1413
##  [1739]  1413  1413  1413  1707  1707  1707  1707   906   906   906   906
##  [1750]  2775  2775  2775  2775   858   858   858   858   660   660   660
##  [1761]   660  1557  1557  1557  1557  3909  3909  3909  3909  3021  3021
##  [1772]  3021  3021    91    91    91  1347  1347  1347  1347  1050  1050
##  [1783]  1050  1050  3948  3948  3948  3948  1707  1707  1707  1707    68
##  [1794]    68    68  1650  1650  1650  1650  1491  1491  1491  1491  3873
##  [1805]  3873  3873  3873   594   594   594   594    85    85    85  2603
##  [1816]  2603  2603  2499   104   306   306   306   306  1161  1161  1161
##  [1827]  1161  1062  1062  1062  1062  2859  2859  2859  2859  1770  1770
##  [1838]  1770  1770  1200  1200  1200  1200  2676  2676  2676  2676    85
##  [1849]    85    85  3444  3444  3444  3444   627   627   627   627   114
##  [1860]   114   114  2355  2355  2355  2355  1062  1062  1062  1062  4431
##  [1871]  4431  4431  4431  1725  1725  1725  1725  5943  5943  5943  5943
##  [1882]  1890  1890  1890  1890  2890  2606  2890  2890  2606  2622  2526
##  [1893]   268    80  1113  1113  1113  1113   354   354   354   354  1800
##  [1904]  1800  1800  1800  1473  1473  1473  1473  2880  2880  2880  2880
##  [1915]   978   978   978   978  1527  1527  1527  1527   450   450   450
##  [1926]  1506  1506  1506  1506   879   879   879   879   438   438   438
##  [1937]   438  1422  1422  1422  1422  4515  4515  4515  4515  1209  1209
##  [1948]  1209  1209   378   378   378   378   705   705   705   705   825
##  [1959]   825   825   103   103   103   894   894   894   894   651   651
##  [1970]   651   651  8640  8640  8640  8640  2295  2295  2295  2295   525
##  [1981]   525   525   525   921   921   921   921    90    90    90  1722
##  [1992]  1722  1722  1722  1059  1059  1059  1059  1086  1086  1086  1086
##  [2003]  2472  2472  2472  2472  1299  1299  1299  1299  1938  1938  1938
##  [2014]  1938  1479  1479  1479  1479   399   399   399   399  3282  3282
##  [2025]  3282  3282  1857  1857  1857  1857   723   723   723   723  1062
##  [2036]  1062  1062  1062  1797  1797  1797  1797   459   459   459   459
##  [2047]  5529  5529  5529  5529  2853  2853  2853  2853  1554  1554  1554
##  [2058]  1554  2610  2610  2610  2610   576   576   576   576  2106  2106
##  [2069]  2106  2106   654   654   654   654  1362  1362  1362  1362  1101
##  [2080]  1101  1101  1101   642   642   642   642  1332  1332  1332  1332
##  [2091]  1515  1515  1515  1515   324   324   324   324  2316  2316  2316
##  [2102]  2316  2253  2253  2253  2253  1842  1842  1842  1842  2538  2538
##  [2113]  2538  2538  1122  1122  1122  1122  1050  1050  1050  1050  4629
##  [2124]  4629  4629  4629   966   966   966   966   477   477   477   477
##  [2135]  1485  1485  1485  1485   116   116   116   474   474   474   474
##  [2146]  1296  1296  1296  1296    82    82    82   448   448   448   855
##  [2157]   855   855   855  5070  5070  5070  5070  1194  1194  1194  1194
##  [2168]  2097  2097  2097  2097  1035  1035  1035  1035  2883  2883  2883
##  [2179]  2883  1101  1101  1101  1101   474   474   474   474  1293  1293
##  [2190]  1293  1293  4326  4326  4326  4326   594   594   594   594  1989
##  [2201]  1989  1989  4878  4878  4878  4878  2502  2502  2502  2502  1050
##  [2212]  1050  1050  1050  2256  2256  2256  2256  1374  1374  1374  1374
##  [2223]  3525  3525  3525  3525  1581  1581  1581  1581  1254  1254  1254
##  [2234]  1254  1863  1863  1863  1863   552   552   552   552  1308  1308
##  [2245]  1308  1308  1443  1443  1443  1443  2634  2634  2634  2634  1911
##  [2256]  1911  1911  1911  2793  2793  2793  2793   645   645   645   645
##  [2267]  1527  1527  1527  1527  1866  1866  1866  1866  1458  1458  1458
##  [2278]  1458  1458  1458  1458  1458   372   372   372   372  1023  1023
##  [2289]  1023  1023   600   600   600   600   846   846   846   846  1086
##  [2300]  1086  1086  1086   444   444   444   444   789   789   789   789
##  [2311]   558   558   558   558   876   876   876   876  2151  2151  2151
##  [2322]  2151  1185  1185  1185  1185  1170  1170  1170  1170   936   936
##  [2333]   936   936   999   999   999   999   447   447   447   447  1971
##  [2344]  1971  1971  1971   924   924   924   924   909   909   909   909
##  [2355]   993   993   993   993    68    68    68   660   660   660   660
##  [2366]  1299  1299  1299  1299   423   423   423   423   915   915   915
##  [2377]   915    72    72    72  5622  5622  5622  5622  1620  1620  1620
##  [2388]  1620    74    74    74  3237  3237  3237  3237  3222  3222  3222
##  [2399]  3222  2121  2121  2121  2121  1332  1332  1332  1332  1839  1839
##  [2410]  1839  1839  2589  2589  1346  2589  1346  1503  1278    68  1086
##  [2421]   843   843   843   843  2778  2778  2778  2778  3957  3957  3957
##  [2432]  3957  1194  1194  1194  1194  4584  4584  4584  4584  1224  1224
##  [2443]  1224  1224  3171  3171  3171  3171   372   372   372   372  2118
##  [2454]  2118  2118  2118  1560  1560  1560  1560  1119  1119  1119  1119
##  [2465]  1477  1477  1474  1477  1474  1095   855   382   619  2151  2151
##  [2476]  2151  2151  4014  4014  4014  4014   639   639   639   639  7155
##  [2487]  7155  7155  7155   885   885   885   885  1164  1164  1164  1164
##  [2498]    99    99    99  2376  2376  2376  2376  7299  7299  7299  7299
##  [2509]  1362  1362  1362  1362   894   894   894   894  1701  1701  1701
##  [2520]  1701  1056  1056  1056  1056  7848  7848  7848  7848  1779  1779
##  [2531]  1779  1779  1062  1062  1062  1062  3090  3090  3090  3090  2676
##  [2542]  2676  2676  2676    99    99    99  2007  2007  2007  2007  6041
##  [2553]  6041  3647  6041  3647  3885  3534  2156   113   324   324   324
##  [2564]   324  4170  4170  4170  4170   624   624   624   624  7692  7692
##  [2575]  7692  7692  1992  1992  1992  1992   381   381   381   381   888
##  [2586]   888   888   888  1092  1092  1092  1092  5127  5127  2426  5127
##  [2597]  2426  2922  2337    89  2205    93    93    93  2937  2937  2937
##  [2608]  2937  2937  2937  2937  2937   446   446   446   687   687   687
##  [2619]   687  2400  2400  2400  2400  5865  5865  5865  5865  2196  2196
##  [2630]  2196  2196  1662  1662  1662  1662  2790  2790  2790  2790   543
##  [2641]   543   543   543  2116  2116   321  1725   321  1725   270   270
##  [2652]   270   270   504   504   504   504  4170  4170  4170  4170  1110
##  [2663]  1110  1110  1110  4317  4317  4317  4317   723   723   723   723
##  [2674]   360   360   360   360  4749  4749  4749  4749  1794  1794  1794
##  [2685]  1794  1830  1830  1830  1830  2610  2610  2610  2610  1050  1050
##  [2696]  1050  1050  1437  1437  1437  1437  1704  1704  1704  1704  1698
##  [2707]  1698  1698  1698    92    92    92   516   516   516   516  1299
##  [2718]  1299  1299  1299    72    72    72  1596  1596  1596  1596  3555
##  [2729]  3555  3555  3555   116   116   116   453   453   453   453   591
##  [2740]   591   591   591  4932  4932  4932  4932   909   909   909   909
##  [2751]    76    76    76   435   435   435   435  2241  2241  2241  2241
##  [2762]   663   663   663   663   615   615   615   615  1983  1983  1983
##  [2773]  1983  1410  1410  1410  1410  2832  2832  2832  2832  3243  3243
##  [2784]  3243  3243  1116  1116  1116  1116  2817  2817  2817  2817   744
##  [2795]   744   744   744  1896  1896  1896  1896  1440  1440  1440  1440
##  [2806]  2982  2982  2982  2982   582   582   582   582   936   936   936
##  [2817]   936  1164  1164  1164  1164  1569  1569  1569  1569  1866  1866
##  [2828]  1866  1866   783   783   783   783   240   240   240   240   561
##  [2839]   561   561   561  3174  3174  3174  3174  1083  1083  1083  1083
##  [2850]  3120  3120  3120  3120  1572  1572  1572  1572   945   945   945
##  [2861]   945    81    81    81  2454  2454  2454  2454  1835  1835  1805
##  [2872]  1805  1835  1803  1752    53    32   612   612   612   612  1245
##  [2883]  1245  1245  1245   975   975   975   975    99    99    99  1716
##  [2894]  1716  1716  1716   375   375   375   375  1535  1535   723   810
##  [2905]   723   810   906   906   906   906  1662  1662  1662  1662  3669
##  [2916]  3669  3669  3669  5790  5790  5790  5790   104   104   104  4410
##  [2927]  4410  4410  4410  2685  2685  2685  2685   861   861   861   861
##  [2938]    81    81    81   966   966   966   966  8141  8141  7539  8141
##  [2949]  7539  7572  7335   569   204    73    73    73  2751  2751  2751
##  [2960]  2751  1272  1272  1272  1272  2256  2256  2256  2256  6840  6840
##  [2971]  6840  6840  3645  3645  3645  3645  1113  1113  1113  1113  1692
##  [2982]  1692  1692  1692  2079  2079  2079  2079   921   921   921   921
##  [2993]  2541  2541  2541  2541  3330  3330  3330  3330  3948  3948  3948
##  [3004]  3948  2319  2319  2319  2319  1755  1755  1755  1755   642   642
##  [3015]   642   642  1579  1474  1579  1579  1474  1473  1275   106   199
##  [3026]    85    85    85  1449  1449  1449  1449   840   840   840   840
##  [3037] 10338 10338 10338 10338  3702  3702  3702  3702  1815  1815  1815
##  [3048]  1815  1665  1665  1665  1665  1788  1788  1788  1788   103   103
##  [3059]   103  1995  1995  1995  1995   975   975   975   975  3399  3399
##  [3070]  3399  3399  1611  1611  1611  1611  1818  1818  1818  1818  2991
##  [3081]  2991  2991  2991  2370  2370  2370  2370    72    72    72  2124
##  [3092]  2124  2124  2124  2250  2250  2250  2250  1782  1782  1782  1782
##  [3103]   396   396   396   396  2781  2781  2781  2781  1254  1254  1254
##  [3114]  1254  1215  1215  1215  1215  7263  7263  7263  7263   693   693
##  [3125]   693   693  3210  3210  3210  3210  5361  5361  5361  5361   330
##  [3136]   330   330   330  1116  1116  1116  1116  2067  2067  2067  2067
##  [3147]  4872  4872  4872  4872  5625  5625  5625  5625  2706  2706  2706
##  [3158]  2706  1800  1800  1800  1800  3387  3387  3387  3387  1071  1071
##  [3169]  1071  1071    76    76    76   690   690   690   690    90    90
##  [3180]    90   162   162   162   162   657   657   657   657   102   102
##  [3191]   102  5919  5919  5919  5919  5502  5502  5502  5502   933   933
##  [3202]   933   933   702   702   702   702   555   555   555   555    71
##  [3213]    71    71  1287  1287  1287  1287   927   927   927   927    70
##  [3224]    70    70   588   588   588   588  3534  3534  3534  3534   312
##  [3235]   312   312   312  2181  2181  1053   948   177  1053   948   177
##  [3246]  1809  1809  1809  1809  1248  1248  1248  1248  2877  2877  2877
##  [3257]  2877   630   630   630   630  2103  2103  2103  2103    70    70
##  [3268]    70   339   339   339   339  1926  1926  1926  1926    81    81
##  [3279]    81  3429  3429  3429  3429   966   966   966   966   912   912
##  [3290]   912   912  1008  1008  1008  1008  1176  1176  1176  1176  1506
##  [3301]  1506  1506  1506   570   570   570   570  2751  2751  2751  2751
##  [3312]   657   657   657   657  2058  2058  2058  2058   720   720   720
##  [3323]   720   666   666   666   666  2151  2151  2151  2151   705   705
##  [3334]   705   705   738   738   738   738    81    81    81   459   459
##  [3345]   459   459  1131  1131  1131  1131  1476  1476  1476  1476   116
##  [3356]   116   116  1218  1218  1218  1218   501   501   501   501  1500
##  [3367]  1500  1500  1500   735   735   735   735  3276  3276  3276  3276
##  [3378]   573   573   573   573  1695  1695  1695  1695  1776  1776  1776
##  [3389]  1776  1029  1029  1029  1029   948   948   948   948  1758  1758
##  [3400]  1758  1758  3951  3951  3951  3951   564   564   564   564   936
##  [3411]   936   936   936   366   366   366   366   449   449   449  1326
##  [3422]  1326  1326  1326    82    82    82  1440  1440  1440  1440  2238
##  [3433]  2238  2238  2238   432   432   432   432  1030  1030   378   552
##  [3444]   378   552   990   990   990   990  4659  4659  4659  4659  1263
##  [3455]  1263  1263  1263  3438  3438  3438  3438  1644  1644  1644  1644
##  [3466]  7626  7626  7626  7626   702   702   702   702  2397  2397  2397
##  [3477]  2397   274   274   208    65   208    65  1201  1201   603   597
##  [3488]   603   597    68    68    68    78    78    78  1959  1959  1959
##  [3499]  1959   131   131   131    93    93    93  1788  1788  1788  1788
##  [3510]  1590  1590  1590  1590  1110  1110  1110  1110  1128  1128  1128
##  [3521]  1128  1179  1179  1179  1179  1548  1548  1548  1548   762   762
##  [3532]   762   762  2118  2118  2118  2118  1125  1125  1125  1125   303
##  [3543]   303   303   303  1917  1917  1917  1917   795   795   795   795
##  [3554]  7251  7251  7251  7251  1020  1020  1020  1020   498   498   498
##  [3565]   498  2250  2250  2250  2250   567   567   567   567   399   399
##  [3576]   399   399   930   930   930   930  1161  1161  1161  1161  1236
##  [3587]  1236  1236  1236  3150  3150  3150  3150   444   444   444   444
##  [3598]  1197  1197  1197  1197  1116  1116  1116  1116   396   396   396
##  [3609]   396  2007  2007  2007  2007  3870  3870  3870  3870   768   768
##  [3620]   768   768  1419  1419  1419  1419  2187  2187  2187  2187   933
##  [3631]   933   933   933   252   252   252   252  1380  1380  1380  1380
##  [3642]  1452  1452  1452  1452   708   708   708   708  1437  1437  1437
##  [3653]  1437  1140  1140  1140  1140  2277  2277  2277  2277   453   453
##  [3664]   453   453   615   615   615   615   567   567   567   567   795
##  [3675]   795   795   795   621   621   621   621  1266  1266  1266  1266
##  [3686]   309   309   309   309  1077  1077  1077  1077  1608  1608  1608
##  [3697]  1608    90    90    90  2094  2094  2094  2094  1680  1680  1680
##  [3708]  1680  2193  2193  2193  2193  1005  1005  1005  1005  1566  1566
##  [3719]  1566  1566  2589  2589  2589  2589   915   915   915   915  2928
##  [3730]  2928  2928  2928  1878  1878  1878  1878  3072  3072  3072  3072
##  [3741]  1038  1038  1038  1038   774   774   774   774  4545  4545  4545
##  [3752]  4545  1215  1215  1215  1215  1179  1179  1179  1179   783   783
##  [3763]   783   783  1482  1482  1482  1482  1500  1500  1500  1500   375
##  [3774]   375   375   375    70    70    70   414   414   414   414  2304
##  [3785]  2304  2304  2304    66    66    66  2862  2862  2862  2862   465
##  [3796]   465   465   465   339   339   339   339  1080  1080  1080  1080
##  [3807]    90    90    90   594   594   594   594  1485  1485  1485  1485
##  [3818]  1683  1683  1683  1683  2371  2371   263  1240   263  1240  3834
##  [3829]  3834  3834  3834  5289  5289  5289  5289  2430  2430  2430  2430
##  [3840]   825   825   825   825  1812  1812  1812  1812   285   285   285
##  [3851]   714   714   714   714    81    81    81   666   666   666   666
##  [3862]  1335  1335  1335  1335  1605  1605  1605  1605  1071  1071  1071
##  [3873]  1071  3495  3495  3495  3495   840   840   840   840   318   318
##  [3884]   318   318  2376  2376  2376  2376  1878  1878  1878  1878   636
##  [3895]   636   636   636   666   666   666   666  2040  2040  2040  2040
##  [3906]   717   717   717   717  1323  1323  1323  1323    95    95    95
##  [3917]  2100  2100  2100  2100  1449  1449  1449  1449  1551  1551  1551
##  [3928]  1551  1026  1026  1026  1026  5220  5220  5220  5220  1128  1128
##  [3939]  1128  1128  1185  1185  1185  1185    76    76    76    69    69
##  [3950]    69  3213  3213  3213  3213  4956  4956  4956  4956  3855  3855
##  [3961]  3855  3855  3309  2077  3309  3309  2077  2094  1962  1215   115
##  [3972]  2037  2037  2037  2037  2088  2088  2088  2088  6372  6372  6372
##  [3983]  6372  1641  1641  1641  1641  1746  1746  1746  1746  2238  2238
##  [3994]  2238  2238  2508  2508  2508  2508  1455  1455  1455  1455  1800
##  [4005]  1800  1800  1800  2016  2016  2016  2016  3141  3141  3141  3141
##  [4016]   900   900   900   900  1212  1212  1212  1212  1332  1332  1332
##  [4027]  1332  2196  2196  2196  2196  3342  3342  3342  3342   540   540
##  [4038]   540   540   342   342   342   342  4838  4838  1617  3219  1617
##  [4049]  3219  1608  1608  1608  1608  1581  1581  1581  1581  3405  3405
##  [4060]  3405  3405  1107  1107  1107  1107   897   897   897   897  2625
##  [4071]  2625  2625  2625  2541  2541  2541  2541   789   789   789   789
##  [4082]  1053  1053  1053  1053  1074  1074  1074  1074   549   549   549
##  [4093]   549  2163  2163  2163  2163  2088  2088  2088  2088   852   852
##  [4104]   852   852  2673  2673  2673  2673   939   939   939   939  4230
##  [4115]  4230  4230  4230  1842  1842  1842  1842   606   606   606   606
##  [4126]   705   705   705   705  3537  3537  3537  3537  1521  1521  1521
##  [4137]  1521  1371  1371  1371  1371   477   477   477   477  1884  1884
##  [4148]  1884  1884   831   831   831   831  1527  1527  1527  1527  2739
##  [4159]  2739  2739  2739    74    74    74   753   753   753   753  7201
##  [4170]  5580  7201  7201  5580  5952  5415  1249   165  1770  1770  1770
##  [4181]  1770   789   789   789   789   939   939   939   939   129   129
##  [4192]   129  1905  1905  1905  1905   576   576   576   576   762   762
##  [4203]   762   762    85    85    85  2220  2220  2220  2220   963   963
##  [4214]   963   963  1656  1656  1656  1656  1929  1929  1929  1929  3078
##  [4225]  3078  3078  3078  2031  2031  2031  2031  1532   625  1532   625
##  [4236]  1532   585   726    40   806  1707  1707  1707  1707    78    78
##  [4247]    78   243   243   243   243   519   519   519   519  1998  1998
##  [4258]  1998  1998  1584  1584  1584  1584   762   762   762   762   442
##  [4269]   442   442   963   963   963   963  2544  2544  2544  2544  3831
##  [4280]  3831  3831  3831  2013  2013  2013  2013  1455  1455  1455  1455
##  [4291]  1206  1206  1206  1206  1290  1290  1290  1290  1401  1401  1401
##  [4302]  1401  2505  2505  2505  2505  1467  1467  1467  1467  2262  2262
##  [4313]  2262  2262  2673  2673  2673  2673  2076  2076  2076  2076  2130
##  [4324]  2130  2130  2130   501   501   501   501  1383  1383  1383  1383
##  [4335]  4368  4368  4368  4368  1776  1776  1776  1776  1716  1716  1716
##  [4346]  1716  1395  1395  1395  1395  2439  2439  2439  2439  2325  2325
##  [4357]  2325  2325  3558  3558  3558  3558  1758  1758  1758  1758  1243
##  [4368]  1243   192  1050   192  1050   900   900   900   900  1509  1509
##  [4379]  1509  1509  2178  2178  2178  2178   990   990   990   990  1410
##  [4390]  1410  1410  1410  1887  1887  1887  1887  2871  2871  2871  2871
##  [4401]  2757  2757  2757  2757  1122  1122  1122  1122   978   978   978
##  [4412]   978   378   378   378   378  4026  4026  4026  4026    99    99
##  [4423]    99   906   906   906   906   525   525   525   525  3546  3546
##  [4434]  3546  3546    72    72    72  1101  1101  1101  1101  1884  1884
##  [4445]  1884  1884  3069  3069  3069  3069  1188  1188  1188  1188   348
##  [4456]   348   348   348  1467  1467  1467  1467   702   702   702   702
##  [4467]    66    66    66  2259  2259  2259  2259    91    91    91    85
##  [4478]    85    85   936   936   936   936    78    78    78  1713  1713
##  [4489]  1713  1713  5553  5553  5553  5553  1104  1104  1104  1104  1122
##  [4500]  1122  1122  1122  1455  1455  1455  1455  2775  2775  2775  2775
##  [4511]    85    85    85   867   867   867   867    73    73    73    75
##  [4522]    75    75  4293  4293  4293  4293  1638  1638  1638  1638  2106
##  [4533]  2106  2106  2106    73    73    73   972   972   972   972  2559
##  [4544]  2559  2559  2559   801   801   801   801 21585 21585 21585 21585
##  [4555]    90    90    90  3051  3051  3051  3051  5454  5454  5454  5454
##  [4566]    74    74    74   717   717   717   717  1218  1218  1218  1218
##  [4577]   657   657   657   657  1683  1683  1683  1683   732   732   732
##  [4588]   732  1257  1257  1257  1257  1284  1284  1284  1284  1206  1206
##  [4599]  1206  1206  1236  1236  1236  1236   579   579   579   579  1320
##  [4610]  1320  1320  1320  1923  1923  1923  1923   783   783   783   783
##  [4621]  1197  1197  1197  1197   131   131   131   990   990   990   990
##  [4632]  1278  1278  1278  1278  2013  2013  2013  2013  2040  2040  2040
##  [4643]  2040   921   921   921   921  1596  1596  1596  1596   651   651
##  [4654]   651   651  1206  1206  1206  1206   753   753   753   753    84
##  [4665]    84    84   690   690   690   690   672   672   672   672    66
##  [4676]    66    66  2982  2982  2982  2982  1515  1515  1515  1515  1599
##  [4687]  1599  1599  1599  1017  1017  1017  1017  2691  2691  2691  2691
##  [4698]   792   792   792   792  2001  2001  2001  2001  1194  1194  1194
##  [4709]  1194  2664  2664  2664  2664   648   648   648   648   663   663
##  [4720]   663   663  3858  3858  3858  3858  4758  4758  4758  4758   339
##  [4731]   339   339   339  2721  2721  2721  2721  1767  1767  1767  1767
##  [4742]   579   579   579   579  1692  1692  1692  1692  1014  1014  1014
##  [4753]  1014  1530  1530  1530  1530  1515  1515  1515  1515  1434  1434
##  [4764]  1434  1434   867   867   867  4035  4035  4035  4035    66    66
##  [4775]    66  1479  1479  1479  1479  1371  1371  1371  1371    78    78
##  [4786]    78   561   561   561  1995  1995  1995  1995  7278  7278  7278
##  [4797]  7278  2436  2436  2436  2436  1668  1668  1668  1668  1605  1605
##  [4808]  1605  1605  3906  3906  3906  3906  1131  1131  1131  1131  2355
##  [4819]  2355  2355  2355   774   774   774   774  1908  1908  1908  1908
##  [4830]  2283  2283  2283  2283  1476  1476  1476  1476  1827  1827  1827
##  [4841]  1827    89    89    89  1578  1578  1578  1578  3456  3456  3456
##  [4852]  3456  2721  2721  2721  2721  1887  1887  1887  1887   450   450
##  [4863]   450   450    78    78    78   609   609   609   609  2061  2061
##  [4874]  2061  2061  1362  1362  1362  1362   474   474   474   474  1527
##  [4885]  1527  1527  1527    69    69    69  5886  5886  5886  5886  3240
##  [4896]  3240  3240  3240 14547 14547 14547 14547  1356  1356  1356  1356
##  [4907]  1041  1041  1041  1041  1746  1746  1746  1746  1998  1998  1998
##  [4918]  1998  2487  2487  2487  2487  1134  1134  1134  1134  3249  3249
##  [4929]  3249  3249  3156  3156  3156  3156   222   222   222   222  4848
##  [4940]  4848  4848  4848  1374  1374  1374  1374  1017  1017  1017  1017
##  [4951]  1119  1119  1119  1119  2724  2724  2724  2724 12558 12558 12558
##  [4962] 12558   807   807   807   807   582   582   582   582  1710  1710
##  [4973]  1710  1710   837   837   837   837  1017  1017  1017  1017  1092
##  [4984]  1092  1092  1092   762   762   762   762  2596  2596   615  1980
##  [4995]   615  1980   119   119   119   303   303   303   303  1155  1155
##  [5006]  1155  1155   183   183   183  1369  1324  1369  1369  1324  1254
##  [5017]  1341    70    28  1281  1281  1281  1281  1077  1077  1077  1077
##  [5028]   684   684   684   684  1095  1095  1095  1095   348   348   348
##  [5039]   348  1257  1257  1257  1257   978   978   978   978  2316  2316
##  [5050]  2316  2316   249   249   249   249    82    82    82  1116  1116
##  [5061]  1116  1116  2730  2730  2730  2730   984   984   984   984  1599
##  [5072]  1599  1599  1599  1626  1626  1626  1626  2256  2256  2256  2256
##  [5083]  1437  1437  1437  1437   522   522   522   522  1179  1179  1179
##  [5094]  1179  1011  1011  1011  1995  1995  1995  1995  1215  1215  1215
##  [5105]  1215  1095  1095  1095  1095   978   978   978   978  2784  2784
##  [5116]  2784  2784  1218  1218  1218  1218    72    72    72   528   528
##  [5127]   528   528  2058  2058  2058  2058  1317  1317  1317  1317   438
##  [5138]   438   438   438   594   594   594   594  1923  1923  1923  1923
##  [5149]  1203  1203  1203  1203  1866  1866  1866  1866  3684  3684  3684
##  [5160]  3684  1263  1263  1263  1263   102   102   102   600   600   600
##  [5171]   600   696   696   696   696  2820  2820  2820  2820  1056  1056
##  [5182]  1056  1056   948   948   948   948  1002  1002  1002  1002  1146
##  [5193]  1146  1146  1146  2595  2595  2595  2595  2823  2823  2823  2823
##  [5204]   495   495   495   495   876   876   876   876   288   288   288
##  [5215]   288  2016  2016  2016  2016  1263  1263  1263  1263   801   801
##  [5226]   801   801  1416  1416  1416  1416   897   897   897   897  4021
##  [5237]  3046  4021  4021  3046  2601  3045   445   976  1071  1071  1071
##  [5248]  1071  2220  2220  2220  2220   104   104   104  1455  1455  1455
##  [5259]  1455   573   573   573   573  1962  1962  1962  1962  1128  1128
##  [5270]  1128  1128  2049  2049  2049  2049  1656  1656  1656  1656   822
##  [5281]   822   822   822  1107  1107  1107  1107    90    90    90   108
##  [5292]   108   108  1485  1485  1485  1485   831   831   831   831  2204
##  [5303]  2204  2204  1098  1098  1098  1098  4707  4707  4707  4707   774
##  [5314]   774   774   774    99    99    99   696   696   696   696  1683
##  [5325]  1683  1683  1683   213   213   213    90    90    90   873   873
##  [5336]   873   873  1719  1719  1719  1719   927   927   927   927  2526
##  [5347]  2526  2526  2526    92    92    92   936   936   936   936  1584
##  [5358]  1584  1584  1584  1422  1422  1422  1422  1494  1494  1494  1494
##  [5369]    96    96    96  1494  1494  1494  1494   564   564   564   564
##  [5380]  2931  2931  2931  2931  1323  1323  1323  1323   458   458   458
##  [5391]  1281  1281  1281  1281  2316  2316  2316  2316   432   432   432
##  [5402]   432   446   446   446  1779  1779  1779  1779  1386  1386  1386
##  [5413]  1386   300   300   300   300  2013  2013  2013  2013  1791  1791
##  [5424]  1791  1791   573   573   573   573   579   579   579   579  1440
##  [5435]  1440  1440  1440  1995  1995  1995  1995  1521  1521  1521  1521
##  [5446]  1044  1044  1044  1044  2883  2883  2883  2883  2283  2283  2283
##  [5457]  2283  1092  1092  1092  1092  2352  2352  2352  2352  2298  2298
##  [5468]  2298  2298  1290  1290  1290  1290  1359  1359  1359  1359   507
##  [5479]   507   507   507  1233  1233  1233  1233  1779  1779  1779  1779
##  [5490]    91    91    91  1389  1389  1389  1389  1158  1158  1158  1158
##  [5501]  1788  1788  1788  1788   621   621   621   621    91    91    91
##  [5512]  2552  2552  1846  2552  1846  2052  1704   500   142   714   714
##  [5523]   714   714  3189  3189  3189  3189  1110  1110  1110  1110   513
##  [5534]   513   513   513   957   957   957   957   591   591   591   591
##  [5545]   924   924   924   924   828   828   828   828   525   525   525
##  [5556]   525  2430  2430  2430  2430   237   237   237   237  1686  1686
##  [5567]  1686  1686   213   213   213    93    93    93   678   678   678
##  [5578]   678  1750  1719  1750  1750  1719  1728  1401    22   318  8361
##  [5589]  8361  8361  8361  2574  2574  2574  2574   107   107   107   449
##  [5600]   449   449  1137  1137  1137  1137  1995  1995  1995  1995  1032
##  [5611]  1032  1032  1032  1992  1992  1992  1992    90    90    90  2166
##  [5622]  2166  2166  2166  3249  3249  3249  3249  5385  5385  5385  5385
##  [5633]   483   483   483   483  3408  3408  3408  3408  2406  2406  2406
##  [5644]  2406  5883  5883  5883  5883    99    99    99  2865  2865  2865
##  [5655]  2865   342   342   342   342  1089  1089  1089  1089  1200  1200
##  [5666]  1200  1200   702   702   702   702  1653  1653  1653  1653  1317
##  [5677]  1317  1317  1317   951   951   951   951   366   366   366   366
##  [5688]  1956  1956  1956   591   591   591   591  6360  6360  6360  6360
##  [5699]    70    70    70  1824  1824  1824  1824   900   900   900   900
##  [5710]   501   501   501   501   567   567   567   567    71    71    71
##  [5721]  1227  1227  1227  1227   243   243   243   243  2052  2052  2052
##  [5732]  2052   540   540   540   540  5937  5937  5937  5937  1902  1902
##  [5743]  1902  1902    69    69    69  1419  1419  1419  1419  3036  3036
##  [5754]  3036  3036   408   408   408   408  2637  2637  2637  2637   288
##  [5765]   288   288   288    92    92    92  1236  1236  1236  1236  1569
##  [5776]  1569  1569  1569   921   921   921   921   621   621   621   621
##  [5787]   984   984   984   984  3033  3033  3033  3033  1611  1611  1611
##  [5798]  1611  1233  1233  1233  1233   446   446   446   714   714   714
##  [5809]   714  4728  4728  4728  4728  4587  4587  4587  4587 18783 18783
##  [5820] 18783 18783  1572  1572  1572  1572  2340  2340  2340  2340  2727
##  [5831]  2727  2727  2727  1620  1620  1620  1620  1554  1554  1554  1554
##  [5842]  2013  2013  2013  2013  2460  2460  2460  2460   780   780   780
##  [5853]   780   288   288   288   288  1905  1905  1905  1905   909   909
##  [5864]   909   909  2559  2559  2559  2559   663   663   663   663  1152
##  [5875]  1152  1152  1152   921   921   921   921   591   591   591   591
##  [5886]  5985  5985  5985  5985  1905  1905  1905  1905  1158  1158  1158
##  [5897]  1158   327   327   327   327  2889  2889  2889  2889  2502  2502
##  [5908]  2502  2502  3195  3195  3195  3195   519   519   519   519  1242
##  [5919]  1242  1242  1242  1332  1332  1332  1332  2583  2583  2583  2583
##  [5930]   948   948   948   948   906   906   906   906  1332  1332  1332
##  [5941]  1332   999   999   999   999   276   276   276   276  1056  1056
##  [5952]  1056  1056   114   114   114  2109  2109  2109  2109   612   612
##  [5963]   612   612  2649  2649  2649  2649   663   663   663   663   561
##  [5974]   561   561   561    66    66    66   498   498   498   498  2253
##  [5985]  2253  2253  2253  2172  2172  2172  2172  1740  1740  1740  1740
##  [5996]  3961  3961   814   814  3961  1032   804    10  2929  5478  5478
##  [6007]  5478  5478    68    68    68  1698  1698  1698  1698   972   972
##  [6018]   972   972   579   579   579   579  3069  3069  3069  3069  1857
##  [6029]  1857  1857  1857   483   483   483   483  2076  2076  2076  2076
##  [6040]    81    81    81  1401  1401  1401  1401   813   813   813   813
##  [6051]  2061  2061  2061  2061  2730  2730  2730  2730   894   894   894
##  [6062]   894   837   837   837   837   540   540   540   540  6354  6354
##  [6073]  6354  6354  1437  1437  1437  1437  1056  1056  1056  1056  1716
##  [6084]  1716  1716  1716   702   702   702   702  2298  2298  2298  2298
##  [6095]   813   813   813   813    89    89    89   336   336   336   336
##  [6106]  1212  1212  1212  1212    74    74    74  2007  2007  2007  2007
##  [6117]   261   261   261   261   690   690   690   690  1608  1608  1608
##  [6128]  1608  5085  5085  5085  5085  1713  1713  1713  1713  1152  1152
##  [6139]  1152  1152   549   549   549   549   378   378   378   378  3270
##  [6150]  3270  3270  3270    85    85    85   726   726   726   726 16911
##  [6161] 16911 16911 16911   597   597   597  1428  1428  1428  1428  1476
##  [6172]  1476  1476  1476  2088  2088  2088  2088   375   375   375   375
##  [6183]  1923  1923  1923  1923 16929 16929 16929 16929   489   489   489
##  [6194]   489  3300  3300  3300  3300  1332  1332  1332  1332  1410  1410
##  [6205]  1410  1410   630   630   630   630  1332  1332  1332  1332  2787
##  [6216]  2787  2787  2787  1419  1419  1419  1419   678   678   678   678
##  [6227]  1542  1542  1542  1542  1755  1755  1755  1755  2934  2934  2934
##  [6238]  2934   116   116   116  1395  1395  1395  1395   996   996   996
##  [6249]   996  1440  1440  1440  1440   954   954   954   954   474   474
##  [6260]   474   474  1032  1032  1032  1032  2619  2619  2619  2619   498
##  [6271]   498   498   498  3018  3018  3018  3018  2136  2136  2136  2136
##  [6282]  1350  1350  1350  1350  1710  1710  1710  1710  2232  2232  2232
##  [6293]  2232  2877  2877  2877  2877   828   828   828   828  2010  2010
##  [6304]  2010  2010   618   618   618   618   399   399   399   399   573
##  [6315]   573   573   573  5286  5286  5286  5286  2721  2721  2721  2721
##  [6326]  2442  2442  2442  2442  1458  1458  1458  1458  2037  2037  2037
##  [6337]  2037  1161  1161  1161  1161  2370  2370  2370  2370   462   462
##  [6348]   462   462  6150  6150  6150  6150  1209  1209  1209  1209   666
##  [6359]   666   666   666  2847  2847  2847  2847  1242  1242  1242  1242
##  [6370]  1443  1443  1443  1443  2469  2469  2469  2469  1305  1305  1305
##  [6381]  1305   306   306   306   306    78    78    78   846   846   846
##  [6392]   846  2181  2181  2181  2181  2052  2052  2052  2052  1269  1269
##  [6403]  1269  1269  3021  3021  3021  3021  1098  1098  1098  1098   945
##  [6414]   945   945   945  3591  3591  3591  3591  2184  2184  2184  2184
##  [6425]   414   414   414   414   819   819   819   819  2445  2445  2445
##  [6436]  2445   849   849   849   849   618   618   618   618  2499  2499
##  [6447]  2499  2499  1821  1821  1821  1821  1614  1614  1614  1614  1275
##  [6458]  1275  1275  1275  1443  1443  1443  1443  1419  1419  1419  1419
##  [6469]   609   609   609   609  2538  2538  2538  2538  3030  3030  3030
##  [6480]  3030  1785  1785  1785  1785  1947  1947  1947  1947  1239  1239
##  [6491]  1239  1239   252   252   252   252  2016  2016  2016  2016   723
##  [6502]   723   723   723  2289  2289  2289  2289   423   423   423   423
##  [6513]  1212  1212  1212  1212  1041  1041  1041  1041  5424  5424  5424
##  [6524]  5424   870   870   870   870   567   567   567   567  2157  2157
##  [6535]  2157  2157  1953  1953  1953  1953   714   714   714   714  1422
##  [6546]  1422  1422  1422  6189  6189  6189  6189  1320  1320  1320  1320
##  [6557]  1086  1086  1086  1086   945   945   945   945  1884  1884  1884
##  [6568]  1884   288   288   288   288  1092  1092  1092  1092    78    78
##  [6579]    78   537   537   537   537    70    70    70   630   630   630
##  [6590]   630   321   321   321   321   591   591   591   591  1203  1203
##  [6601]  1203  1203   435   435   435   435  3873  3873  3873  3873  5598
##  [6612]  5598  5598  5598   711   711   711   711  1896  1896  1896  1896
##  [6623]   849   849   849   849   927   927   927   927  3702  3702  3702
##  [6634]  3702  1071  1071  1071  1071   876   876   876   876  2622  2622
##  [6645]  2622  2622  1107  1107  1107  1107  1893  1893  1893  1893   390
##  [6656]   390   390   390   303   303   303   303  1080  1080  1080  1080
##  [6667]  1065  1065  1065  1065   831   831   831   831  2367  2367  2367
##  [6678]  2367  1314  1314  1314  1314  1800  1800  1800  1800  5154  5154
##  [6689]  5154  5154   861   861   861   861  1692  1692  1692  1692  7347
##  [6700]  7347  7347  7347   348   348   348   348  3843  3843  3843  3843
##  [6711]  3075  3075  3075  3075  1041  1041  1041  1041  1536  1536  1536
##  [6722]  1536   468   468   468   468  1602  1602  1602  1602  2862  2862
##  [6733]  2862  2862  3297  3297  3297  3297  1353  1353  1353  1353  1134
##  [6744]  1134  1134  1134   468   468   468   468   663   663   663   663
##  [6755]   765   765   765   765  1872  1872  1872  1872  3387  3387  3387
##  [6766]  3387  2709  2709  2709  2709  4602  4602  4602  4602   843   843
##  [6777]   843   843    72    72    72  2094  2094  2094  2094   987   987
##  [6788]   987   987   243   243   243   243    72    72    72  1071  1071
##  [6799]  1071  1071  1968  1968  1968  1968   978   978   978   978  1071
##  [6810]  1071  1071  1071   738   738   738   738   783   783   783   783
##  [6821]  3723  3723  3723  3723  2010  2010  2010  2010  2616  2616  2616
##  [6832]  2616   387   387   387   387  1713  1713  1713  1713  2556  2556
##  [6843]  2556  2556   411   411   411   411  2478  2478  2478  2478  1698
##  [6854]  1698  1698  1698   966   966   966   966  1023  1023  1023  1023
##  [6865]  1794  1794  1794  1794  1074  1074  1074  1074   276   276   276
##  [6876]   276  1385  1385  1068   315  1068   315  4263  4263  4263  4263
##  [6887]   888   888   888   888   828   828   828   828  1524  1524  1524
##  [6898]  1524  2694  2694  2694  2694  1173  1173  1173  1173  4239  4239
##  [6909]  4239  4239   939   939   939   939   303   303   303   303  6915
##  [6920]  6915  6915  6915  1365  1365  1365  1365   834   834   834   834
##  [6931]  2829  2829  2829  2829   507   507   507   507   804   804   804
##  [6942]   804  1299  1299  1299  1299  1359  1359  1359  1359  1884  1884
##  [6953]  1884  1884  8352  8352  8352  8352    69    69    69   537   537
##  [6964]   537   537   426   426   426   426  3321  3321  3321  3321  4476
##  [6975]  4476  4476  4476   924   924   924   924  2325  2325  2325  2325
##  [6986]  2340  2340  2340  2340  1821  1821  1821  1821  2928  2928  2928
##  [6997]  2928  1257  1257  1257  1257  1647  1647  1647  1647   513   513
##  [7008]   513   513  1449  1449  1449  1449  3735  3735  3735  3735   873
##  [7019]   873   873   873  2205  2205  2205  2205  1533  1533  1533  1533
##  [7030]   969   969   969   969  2412  2412  2412  2412   651   651   651
##  [7041]   651  1482  1482  1482  1482  1071  1071  1071  1071   990   990
##  [7052]   990   990  1890  1890  1890  1890  3255  3255  3255  3255    89
##  [7063]    89    89   402   402   402   402  3321  3321  3321  3321  1803
##  [7074]  1803  1803  1803   243   243   243   243   705   705   705   705
##  [7085]    83    83    83  4935  4935  4935  4935    79    79    79  2562
##  [7096]  2562  2562  2562  2733  2733  2733  2733  1101  1101  1101  1101
##  [7107]   822   822   822   822  2889  2889  2889  2889  1572  1572  1572
##  [7118]  1572  1047  1047  1047  1047   947   837   947   837   947   834
##  [7129]   855     3    92   750   750   750   750  6906  6906  6906  6906
##  [7140]   813   813   813   813  7629  7629  7629  7629  1314  1314  1314
##  [7151]  1314  2229  2229  2229  2229   999   999   999   999    83    83
##  [7162]    83   954   954   954   954  1026  1026   933   933  1026  1014
##  [7173]   864    69    12  1368  1368  1368  1368   834   834   834   834
##  [7184]   795   795   795   795  7767  7767  7767  7767   363   363   363
##  [7195]   363 16077 16077 16077 16077  1203  1203  1203  1203  4476  4476
##  [7206]  4476  4476   996   996   996   996   519   519   519   519  1185
##  [7217]  1185  1185  1185   927   927   927   927  6936  6936  6936  6936
##  [7228]   762   762   762   762  1170  1129  1170  1129  1170  1098  1152
##  [7239]    31    18  1056  1056  1056  1056   891   891   891   891  1599
##  [7250]  1599  1599  1599    68    68    68  2238  2238  2238  2238  1107
##  [7261]  1107  1107  1107  2496  2496  2496  2496   690   690   690   690
##  [7272]   759   759   759   759   888   888   888   888  2253  2253  2253
##  [7283]  2253   104   104   104  1059  1059  1059  1059  1266  1266  1266
##  [7294]  1266   303   303   303   303   612   612   612   612  1644  1644
##  [7305]  1644  1644   969   969   969   969  1116  1116  1116  1116  4098
##  [7316]  4098  4098  4098   846   846   846   846    90    90    90   294
##  [7327]   294   294   294  5100  5100  5100  5100  1587  1587  1587  1587
##  [7338]  1104  1104  1104  1104  1710  1710  1710  1710  3087  3087  3087
##  [7349]  3087  1908  1908  1908  1908  2928  2928  2928  2928  3468  3468
##  [7360]  3468  3468   726   726   726   726  2553  2553  2553  2553  7197
##  [7371]  7197  7197  7197   789   789   789   789  1101  1101  1101  1101
##  [7382]  1383  1383  1383  1383  1134  1134  1134  1134    86    86    86
##  [7393]    78    78    78  1635  1635  1635  1635    79    79    79   861
##  [7404]   861   861   861    91    91    91   831   831   831   831    89
##  [7415]    89    89  3189  3189  3189  3189    69    69    69   807   807
##  [7426]   807   807    81    81    81  3018  3018  3018  3018  1017  1017
##  [7437]  1017  1017  1650  1650  1650  1650  2511  2511  2511  2511  1515
##  [7448]  1515  1515  1515    93    93    93   714   714   714   714  2301
##  [7459]  2301  2301  2301  1977  1977  1977  1977   753   753   753   753
##  [7470] 16446 16446 16446 16446  1257  1257  1257  1257  1638  1638  1638
##  [7481]  1638  1620  1620  1620  1620  2361  2361  2361  2361  2772  2772
##  [7492]  2772  2772   621   621   621   621   291   291   291   291   264
##  [7503]   264   264   264  1506  1506  1506  1506   576   576   576   576
##  [7514]  3729  3729  3729  3729    65    65    65  3135  3135  3135  3135
##  [7525]    91    91    91  2571  2571  2571  2571   429   429   429   429
##  [7536]  1566  1566  1566  1566   156   156   156   156  1929  1929  1929
##  [7547]  1929   103   103   103   384   384   384   384  2976  2976  2976
##  [7558]  2976   510   510   510   510  1350  1350  1350  1350  1971  1971
##  [7569]  1971  1971   507   507   507   507  1773  1773  1773  1773  7065
##  [7580]  7065  7065  7065   648   648   648   648  1296  1296  1296  1296
##  [7591]  1392  1392  1392  1392    99    99    99  4104  4104  4104  4104
##  [7602]  1362  1362  1362  1362    74    74    74  1392  1392  1392  1392
##  [7613]  1224  1224  1224  1224  1305  1305  1305  1305   570   570   570
##  [7624]   570    70    70    70   900   900   900   900   831   831   831
##  [7635]   831  2118  2118  2118  2118  1089  1089  1089  1089  1722  1722
##  [7646]  1722  1722   933   933   933   933   681   681   681   681  1632
##  [7657]  1632  1632  1632  1272  1272  1272  1272   342   342   342   342
##  [7668]  2232  2232  2232  2232  1869  1869  1869  1869   693   693   693
##  [7679]   693    93    93    93    89    89    89  1578  1578  1578  1578
##  [7690]  1128  1128  1128  1128  2190  2190  2190  2190   678   678   678
##  [7701]   678   984   984   984   984  3726  3726  3726  3726  1356  1356
##  [7712]  1356  1356   561   561   561   561   924   924   924   924    78
##  [7723]    78    78  4344  4344  4344  4344  2322  2322  2322  2322  1323
##  [7734]  1323  1323  1323  1052  1032  1052  1052  1032  1029  1038     3
##  [7745]    14  5331  5331  5331  5331  1926  1926  1926  1926  1641  1641
##  [7756]  1641  1641    99    99    99   723   723   723   723   468   468
##  [7767]   468   468   449   449   449   456   456   456   456  2472  2472
##  [7778]  2472  2472  3678  3678  3678  3678  7824  7824  7824  7824  1638
##  [7789]  1638  1638  1638   339   339   339   339  2127  2127  2127  2127
##  [7800]  5631  5631  5631  5631  2157  2157  2157  2157  2466  2466  2466
##  [7811]  2466   894   894   894   894   876   876   876   876  1773  1773
##  [7822]  1773  1773   903   903   903   903 12726 12726 12726 12726  3006
##  [7833]  3006  3006  3006   444   444   444   444  4110  4110  4110  4110
##  [7844]  2520  2520  2520  2520  7515  7515  7515  7515 11304 11304 11304
##  [7855] 11304  2178  2178  2178  2178   357   357   357   357 11646 11646
##  [7866] 11646 11646  2034  2034  2034  2034    99    99    99    95    95
##  [7877]    95  1107  1107  1107  1107   636   636   636   636    98    98
##  [7888]    98  1923  1923  1923  1923  1878  1878  1878  1878  1539  1539
##  [7899]  1539  1539  2118  2118  2118  2118  1422  1422  1422  1422  1440
##  [7910]  1440  1440  1440   942   942   942   942   690   690   690   690
##  [7921]  3042  3042  3042  3042   751   751   741   751   741   747   717
##  [7932]     4    24  1125  1125  1125  1125  1653  1653  1653  1653  4476
##  [7943]  4476  4476  4476   522   522   522   522  1857  1857  1857  1857
##  [7954]  2529  2529  2529  2529   360   360   360   360  1761  1761  1761
##  [7965]  1761  2808  2808  2808  2808   471   471   471   471  4104  4104
##  [7976]  4104  4104  1761  1761  1761  1761  3630  3630  3630  3630  3393
##  [7987]  3393  3393  3393  1461  1461  1461  1461   501   501   501   501
##  [7998]  4062  4062  4062  4062  2538  2538  2538  2538    99    99    99
##  [8009]   816   816   816   816    69    69    69  2126  2126   657  1467
##  [8020]   657  1467    74    74    74    81    81    81  2937  2937  2937
##  [8031]  2937  3297  3297  3297  3297  1218  1218  1218  1218  1029  1029
##  [8042]  1029  1029   885   885   885   885  1347  1347  1347  1347  3684
##  [8053]  3684  3684  3684   528   528   528   528  2613  2613  2613  2613
##  [8064]   414   414   414   414   564   564   564   564  1896  1896  1896
##  [8075]  1896  1140  1140  1140  1140  1215  1215  1215  1215  1620  1620
##  [8086]  1620  1620   339   339   339   339    72    72    72   879   879
##  [8097]   879   879  1740  1740  1740  1740  9651  9651  9651  9651  3309
##  [8108]  3309  3309  3309  1362  1362  1362  1362    68    68    68   987
##  [8119]   987   987   987  1215  1215  1215  1215  4116  4116  4116  4116
##  [8130]  1299  1299  1299  2121  2121  2121  2121  2280  2280  2280  2280
##  [8141]   549   549   549   549    72    72    72  2463  2463  2463  2463
##  [8152]  2817  2817  2817  2817  2520  2520  2520  2520  1971  1971  1971
##  [8163]  1971  1336  1236  1336  1236  1336  1164  1245    72    91  1371
##  [8174]  1371  1371  1371  5352  5352  5352  5352   498   498   498   498
##  [8185]   669   669   669   669   921   921   921   921  4446  4446  4446
##  [8196]  4446   846   846   846   846  1749  1749  1749  1749  1155  1155
##  [8207]  1155  1155  2514  2514  2514  2514   312   312   312   312  1437
##  [8218]  1437  1437  1437   393   393   393   393   981   981   981   981
##  [8229]  2813  2813   537   288   687  1296   537   288   687  1296  5466
##  [8240]  5466  5466  5466  1980  1980  1980  1980  5265  5265  5265  5265
##  [8251]  2388  2388  2388  2388  1794  1794  1794  1794  1008  1008  1008
##  [8262]  1008   783   783   783   783  1089  1089  1089  1089  1098  1098
##  [8273]  1098  1098   573   573   573   573   104   104   104   774   774
##  [8284]   774   774  2436  2436  2436  2436  3252  3252  3252  3252  3882
##  [8295]  3882  3882  3882   132   132   132  2883  2883  2883  2883   116
##  [8306]   116   116  1827  1827  1827  1827   555   555   555   555  1134
##  [8317]  1134  1134  1134  1404  1404  1404  1404   291   291   291   291
##  [8328]   558   558   558   558    68    68    68  1836  1836  1836  1836
##  [8339]  1683  1683  1683  1683  1404  1404  1404  1404  4299  4299  4299
##  [8350]  4299  1011  1011  1011  1011  1539  1539  1539  1539  1572  1572
##  [8361]  1572  1572   119   119   119  4503  4503  4503  4503  3213  3213
##  [8372]  3213  3213    72    72    72  2181  2181  2181  2181   143   143
##  [8383]   143  2892  2892  2892  2892  1995  1995  1995  1995    78    78
##  [8394]    78   104   104   104  3006  3006  3006  3006  4752  4752  4752
##  [8405]  4752   588   588   588   588  1059  1059  1059  1059  1029  1029
##  [8416]  1029  1029  1047  1047  1047  1047  1008  1008  1008  1008  1635
##  [8427]  1635  1635  1635  1713  1713  1713  1713  1770  1770  1770  1770
##  [8438]   924   924   924   924  2199  2199  2199  2199    85    85    85
##  [8449]   213   213   213   327   327   327   327  1941  1941  1941  1941
##  [8460]   690   690   690   690   330   330   330   330  2379  2379  2379
##  [8471]  2379   612   612   612   612  1602  1602  1602  1602  5307  5307
##  [8482]  5307  5307  1473  1473  1473  1473  3558  3558  3558  3558  2001
##  [8493]  2001  2001  2001  1521  1521  1521  1521  1266  1266  1266  1266
##  [8504]   669   669   669   669   648   648   648   648   336   336   336
##  [8515]   336  1500  1500  1500  1500  3690  3690  3690  3690  1107  1107
##  [8526]  1107  1107   702   702   702   702  2106  2106  2106  2106   840
##  [8537]   840   840   840   750   750   750   750  2361  2361  2361  2361
##  [8548]  1437  1437  1437  1437  1446  1446   480   459   504   480   459
##  [8559]   504   678   678   678   678  2904  2904  2904  2904   975   975
##  [8570]   975   975  2601  2601  2601  2601  1788  1788  1788  1788   648
##  [8581]   648   648   648  2130  2130  2130  2130  1428  1428  1428  1428
##  [8592]  3849  3849  3849  3849  1872  1872  1872  1872   753   753   753
##  [8603]   753  3495  3495  3495  3495  2568  2568  2568  2568  1716  1716
##  [8614]  1716  1716  3048  3048  3048  3048   405   405   405   405  2007
##  [8625]  2007  2007  2007    81    81    81  2261  2261  1535  1535  2261
##  [8636]  1617  1515    20   644    85    85    85  4608  4608  4608  4608
##  [8647]  3774  3774  3774  3774  2328  2328  2328  2328   336   336   336
##  [8658]   336  3501  3501  3501  3501  2742  2742  2742  2742   423   423
##  [8669]   423   423  2292  2292  2292  2292  3426  3426  3426  3426  2013
##  [8680]  2013  2013  2013  2532  2532  2532  2532  4308  4308  4308  4308
##  [8691]   948   948   948   948   903   903   903   903  2775  2775  2775
##  [8702]  2775  1596  1596  1596  1596  1410  1410  1410  1410  3687  3687
##  [8713]  3687  3687   900   900   900   900   216   216   216   216  2655
##  [8724]  2655  2655  2655  4449  4449  4449  4449  1617  1617  1617  1617
##  [8735]  2355  2355  2355  2355   936   936   936   936   501   501   501
##  [8746]   501  1344  1344  1344  1344  1254  1254  1254  1254  6696  6696
##  [8757]  6696  6696  1050  1050  1050  1050  3057  3057  3057  3057  1389
##  [8768]  1389  1389  1389  6402  6402  6402  6402  1317  1317  1317  1317
##  [8779]  4311  4311  4311  4311   519   519   519   519   131   131   131
##  [8790]  3888  3888  3888  3888   393   393   393   393  1575  1575  1575
##  [8801]  1575  2004  2004  2004  2004  1563  1563  1563  1563  1422  1422
##  [8812]  1422  1422  3396  3396  3396  3396  6822  6822  6822  6822  1965
##  [8823]  1965  1965  1965    78    78    78  1821  1821  1821  1821  2361
##  [8834]  2361  2361  2361  6924  6924  6924  6924   987   987   987   987
##  [8845]  4929  4929  4929  4929  1008  1008  1008  1008   828   828   828
##  [8856]   828   252   252   252   252   378   378   378   378  1134  1134
##  [8867]  1134  1134   777   777   777   777  1860  1860  1860  1860  1800
##  [8878]  1800  1800  1800  1059  1059  1059  1059   849   849   849   849
##  [8889] 12819 12819 12819 12819  1347  1347  1347  1347   786   786   786
##  [8900]   786   489   489   489   489  2760  2760  2760  2760    78    78
##  [8911]    78  5679  5679  5679  5679  3270  3270  3270  3270   837   837
##  [8922]   837   837 14478 14478 14478 14478  3933  3933  3933  3933    69
##  [8933]    69    69   894   894   894   894  1584  1584  1584  1584  1425
##  [8944]  1425  1425  1425   114   114   114  1968  1968  1968  1968   300
##  [8955]   300   300   300  1347  1347  1347  1347  1776  1776  1776  1776
##  [8966]  1944  1944  1944  1944  5499  5499  5499  5499  1263  1263  1263
##  [8977]  1263  7785  7785  7785  7785  1356  1356  1356  1356    73    73
##  [8988]    73   588   588   588   588  9129  9129  9129  9129  3156  3156
##  [8999]  3156  3156   954   954   954   954  1707  1707  1707  1707  1743
##  [9010]  1743  1743  1743  1353  1353  1353  1353  4173  4173  4173  4173
##  [9021]  3237  3237  3237  3237  1163   590  1163  1163   590   771   441
##  [9032]   392   149  3003  3003  3003  3003  2217  2217  2217  2217   393
##  [9043]   393   393   393   915   915   915   915  3945  3945  3945  3945
##  [9054]  1617  1617  1617  1617   924   924   924   924  1308  1308  1308
##  [9065]  1308    93    93    93    78    78    78   446   446   446  1053
##  [9076]  1053  1053  1053   525   525   525   525  2001  2001  2001  2001
##  [9087]  1299  1299  1299  1299   765   765   765   765  1650  1650  1650
##  [9098]  1650   717   717   717   717  1233  1233  1233  1233    92    92
##  [9109]    92    68    68    68  1284  1284  1284  1284   993   993   993
##  [9120]   993   732   732   732   732  1323  1323  1323  1323    70    70
##  [9131]    70  1749  1749  1749  1749  1953  1953  1953  1953   399   399
##  [9142]   399   399  1116  1116  1116  1116  2643  2643  2643  2643  1548
##  [9153]  1548  1548  1548    96    96    96   534   534   534   534    69
##  [9164]    69    69   816   816   816   816  1335  1335  1335  1335  4224
##  [9175]  4224  4224  4224  1632  1632  1632  1632   777   777   777   777
##  [9186]  1494  1494  1494  1494  2960  2078  2960  2078  2960  2004  2673
##  [9197]    74   287  2343  2343  2343  2343   750   750   750   750  4122
##  [9208]  4122  4122  4122   549   549   549   549  2028  2028  2028  2028
##  [9219]  4458  4458  4458  4458   405   405   405   405  1077  1077  1077
##  [9230]  1077   603   603   603   603  1335  1335  1335  1335  4044  4044
##  [9241]  4044  4044  1995  1995  1995  1995   750   750   750   750  1299
##  [9252]  1299  1299  1299  4953  4953  4953  4953  3669  3669  3669  3669
##  [9263]  1923  1923  1923  1923  1221  1221  1221  1221  2646  2646  2646
##  [9274]  2646   903   903   903   903   345   345   345   345  1173  1173
##  [9285]  1173  1173  2313  2313  2313  2313  1371  1371  1371  1371   546
##  [9296]   546   546   546   279   279   279   279    78    78    78  1659
##  [9307]  1659  1659  1659   393   393   393   393  2613  2613  2613  2613
##  [9318]  6585  6585  6585  6585  3159  3159  3159  3159   813   813   813
##  [9329]   813  4773  4773  4773  4773  1467  1467  1467  1467  1421  1421
##  [9340]  1331  1331  1421  1404  1143   188    17   582   582   582   582
##  [9351]  2556  2556  2556  2556  2856  2856  2856  2856  1749  1749  1749
##  [9362]  1749   771   771   771   771   777   777   777   777  1866  1866
##  [9373]  1866  1866  1626  1626  1626  1626  1653  1653  1653  1653  1314
##  [9384]  1314  1314  1314    78    78    78  2667  2667  2667  2667   942
##  [9395]   942   942   942  4767  4767  4767  4767  1107  1107  1107  1107
##  [9406]  1515  1515  1515  1515  1356  1356  1356  1356  3114  3114  3114
##  [9417]  3114  1113  1113  1113  1113    86    86    86   102   102   102
##  [9428]  1641  1641  1641  1641  1161  1161  1161  1161  1728  1728  1728
##  [9439]  1728  1026  1026  1026  1026  2364  2364  2364  2364   930   930
##  [9450]   930   930   148   148   148  2892  2892  2892  2892  1224  1224
##  [9461]  1224  1224  2052  2052  2052  2052  5715  5715  5715  5715  1113
##  [9472]  1113  1113  1113   915   915   915   915  2247  2247  2247  2247
##  [9483]    94    94    94  8166  8166  8166  8166  2034  2034  2034  2034
##  [9494]  2334  2334  2334  2334    65    65    65  1548  1548  1548  1548
##  [9505]   720   720   720   720  2082  2082  2082  2082  1449  1449  1449
##  [9516]  1449  1269  1269  1269  1269  4770  4770  4770  4770  1032  1032
##  [9527]  1032  1032   657   657   657   657  1332  1332  1332  1332  4740
##  [9538]  4740  4740  4740  2676  2676  2676  2676  1053  1053  1053  1053
##  [9549]  3159  3159  3159  3159  1641  1641  1641  1641   174   174   174
##  [9560]   174  1881  1881  1881  1881  7215  7215  7215  7215   690   690
##  [9571]   690   690  1701  1701  1701  1701  1782  1782  1782  1782  3684
##  [9582]  3684  3684  3684   918   918   918   918  1809  1809  1809  1809
##  [9593]  2643  2643  2643  2643  1113  1113  1113  1113   615   615   615
##  [9604]   615  5877  5877  5877  5877  1923  1923  1923  1923  1137  1137
##  [9615]  1137  1137  2319  2319  2319  2319  1071  1071  1071  1071   357
##  [9626]   357   357   357  1905  1905  1905  1905   669   669   669   669
##  [9637]  1140  1140  1140  1140  1785  1785  1785  1785  1050  1050  1050
##  [9648]  1050  1203  1203  1203  1203    90    90    90 10380 10380 10380
##  [9659] 10380    56    56    56    81    81    81  1308  1308  1308  1308
##  [9670]  1041  1041  1041  1041  1977  1977  1977  1977  3219  3219  3219
##  [9681]  3219  1780  1780  1780  3333  3333  3333  3333   399   399   399
##  [9692]   399  4083  4083  4083  4083   399   399   399   399   714   714
##  [9703]   714   714   321   321   321   321   531   531   531   531   615
##  [9714]   615   615   615   873   873   873   873  1425  1425  1425  1425
##  [9725]  1344  1344  1344  1344  1047  1047  1047  1047  1704  1704  1704
##  [9736]  1704  4515  4515  4515  4515   648   648   648   648   423   423
##  [9747]   423   423  1170  1170  1170  1170   162   162   162   162  4662
##  [9758]  4662  4662  4662    66    66    66  1161  1161  1161  1161  1449
##  [9769]  1449  1449  1449    74    74    74  1080  1080  1080  1080   774
##  [9780]   774   774   774   822   822   822   822  1890  1890  1890  1890
##  [9791]   726   726   726   726   954   954   954   954  1416  1416  1416
##  [9802]  1416   372   372   372   372    89    89    89   609   609   609
##  [9813]   609  1935  1935  1935  1935   975   975   975   975  1476  1476
##  [9824]  1476  1476  3807  3807  3807  3807   768   768   768   768  5595
##  [9835]  5595  5595  5595   876   876   876   876  5196  5196  5196  5196
##  [9846]  3594  3594  3594  3594  4188  4188  4188  4188   652   442   652
##  [9857]   652   442   348   579    94    73  1878  1878  1878  1878   393
##  [9868]   393   393   393  1059  1059  1059  1059  5316  5316  5316  5316
##  [9879]  2817  2817  2817  2817  2172  2172  2172  2172   999   999   999
##  [9890]   999  1014  1014  1014  1014   285   285   285   285  3837  3837
##  [9901]  3837  3837   537   537   537   537   561   561   561   561   990
##  [9912]   990   990   990  6081  6081  6081  6081   738   738   738   651
##  [9923]   651   651   651  2850  2850  2850  2850  3120  3120  3120  3120
##  [9934]  1014  1014  1014  1014   744   744   744   744  1503  1503  1503
##  [9945]  1503  1650  1650  1650  1650  1347  1347  1347  1347  1482  1482
##  [9956]  1482  1482  1710  1710  1710  1710   579   579   579   579  1878
##  [9967]  1878  1878  1878  1146  1146  1146  1146  1515  1515  1515  1515
##  [9978]    99    99    99   294   294   294   294  2391  2391  2391  2391
##  [9989]  2166  2166  2166  2166  2076  2076  2076  2076  3021  3021  3021
## [10000]  3021  4647  4647  4647  4647  9429  9429  9429  9429  1434  1434
## [10011]  1434  1434  3069  3069  3069  3069   597   597   597   597  2286
## [10022]  2286  2286  2286   342   342   342   342   429   429   429   429
## [10033]  1824  1824  1824  1824  4341  4341  4341  4341  1479  1479  1479
## [10044]  1479   954   954   954   954   633   633   633   633   828   828
## [10055]   828   828   552   552   552   552   591   591   591   591   456
## [10066]   456   456   456  1434  1434  1434  1434  1875  1875  1875  1875
## [10077]   993   993   993   993  1542  1542  1542  1542  1146  1146  1146
## [10088]  1146   528   528   528   528  1350  1350  1350  1350   801   801
## [10099]   801   801  1551  1551  1551  1551    66    66    66  1953  1953
## [10110]  1953  1953    74    74    74   681   681   681   681  5160  5160
## [10121]  5160  5160    85    85    85   243   243   243   243  2469  2469
## [10132]  2469  2469  1968  1968  1968  1968  1941  1941  1941  1941   108
## [10143]   108   108  7158  7158  7158  7158  4758  4758  4758  4758  2151
## [10154]  2151  2151  2151  2334  2334  2334  2334  1836  1836  1836  1836
## [10165]   678   678   678   678   116   116   116  1233  1233  1233  1233
## [10176]  1704  1704  1704  1704  3708  3708  3708  3708  2421  2421  2421
## [10187]  2421   477   477   477   477  1239  1239  1239  1239  1998  1998
## [10198]  1998  1998  3768  3768  3768  3768  2022  2022  2022  2022   840
## [10209]   840   840   840  1617  1617  1617  1617    93    93    93   423
## [10220]   423   423   423  4275  4275  4275  4275  1359  1359  1359  1359
## [10231]  3126  3126  1902  3126  1902  2040  1743  1086   159  5169  5169
## [10242]  5169  5169  1482  1482  1482  1482  2204  2204  2204  1188  1188
## [10253]  1188  1188  1248  1248  1248  1248   540   540   540   540   282
## [10264]   282   282   282   930   930   930   930  5619  5619  5619  5619
## [10275]  1851  1851  1851  1851  1725  1725  1725  1725    78    78    78
## [10286]   819   819   819   819    82    82    82   615   615   615   615
## [10297]  2715  2715  2715  2715  2781  2781  2781  2781  2157  2157  2157
## [10308]  2157  1311  1311  1311  1311  2907  2907  2907  2907  1248  1248
## [10319]  1248  1248  2268  2268  2268  2268    73    73    73   684   684
## [10330]   684   684    92    92    92  3642  3642  3642  3642  1761  1761
## [10341]  1761  1761  4812  4812  4812  4812  2589  2589  2589  2589  6087
## [10352]  6087  6087  6087  1329  1329  1329  1329  3198  3198  3198  3198
## [10363]   627   627   627   627  1047  1047  1047  1047  1638  1638  1638
## [10374]  1638   978   978   978   978  2709  2709  2709  2709  1653  1653
## [10385]  1653  1653  3498  3498  3498  3498  1545  1545  1545  1545   624
## [10396]   624   624   624   375   375   375   375   948   948   948   948
## [10407]   114   114   114   435   435   435   435  3966  3966  3966  3966
## [10418]  1737  1737  1737  1737    70    70    70  1377  1377  1377  1377
## [10429]  4209  4209  4209  4209  1107  1107  1107  1107  2085  2085  2085
## [10440]  2085   975   975   975   975  1431  1431  1431  1431   669   669
## [10451]   669   669   387   387   387   387  2634  2634  2634  2634  1476
## [10462]  1476  1476  1476  1977  1977  1977  1977   825   825   825   825
## [10473]   618   618   618   618   240   240   240   240   600   600   600
## [10484]   600  1941  1941  1941  1941  1095  1095  1095  1095   552   552
## [10495]   552   552   252   252   252   252  1809  1809  1809  1809   912
## [10506]   912   912   912   837   837   837   837  1341  1341  1341  1341
## [10517]  1701  1701  1701  1701   942   942   942   942  1038  1038  1038
## [10528]  1038  5193  5193  5193  5193    64    64    64   123   123   123
## [10539]  1896  1896  1896  1896  1707  1707  1707  1707  3069  3069  3069
## [10550]  3069  1185  1185  1185  1185   405   405   405   405  1191  1191
## [10561]  1191  1191   486   486   486   486  3501  3501  3501  3501  1191
## [10572]  1191  1191  1191    81    81    81   258   258   258   258  1272
## [10583]  1272  1272  1272   104   104   104   132   132   132  3576  3576
## [10594]  3576  3576  1491  1491  1491  1491  1818  1818  1818  1818  2833
## [10605]  2833  2833  2268   565   417   417   417   417  3769  3291  3769
## [10616]  3291  3769  2883  3360   408   409  1785  1785  1785  1785  4698
## [10627]  4698  4698  4698    73    73    73   585   585   585   585   396
## [10638]   396   396   396  4656  4656  4656  4656  1308  1308  1308  1308
## [10649]  1881  1881  1881  1881  1227  1227  1227  1227  5601  5601  5601
## [10660]  5601   843   843   843   843   399   399   399   399    91    91
## [10671]    91  6636  6636  6636  6636  5064  5064  5064  5064  1125  1125
## [10682]  1125  1125   814   726   814   814   726   633   798    93    16
## [10693]  3567  3567  3567  3567  1707  1707  1707  1707  1413  1413  1413
## [10704]  1413   564   564   564   564  2325  2325  2325  2325   831   831
## [10715]   831   831   378   378   378   378  4776  4776  4776  4776  3507
## [10726]  3507  3507  3507   954   954   954   954   759   759   759   759
## [10737]  1282  1282   645   636   645   636  1143  1143  1143  1143  4125
## [10748]  4125  4125  4125   129   129   129   339   339   339   339  1077
## [10759]  1077  1077  1077  1578  1578  1578  1578  1926  1926  1926  1926
## [10770]  1344  1344  1344  1344  1812  1812  1812  1812  1011  1011  1011
## [10781]  1011   420   420   420   420  2169  2169  2169  2169  1890  1890
## [10792]  1890  1890   798   798   798   798   900   900   900   900   102
## [10803]   102   102   102   732   732   732   732   549   549   549   549
## [10814]   984   984   984   984  1203  1203  1203  1203  1167  1167  1167
## [10825]  1167  3063  3063  3063  3063  1119  1119  1119  1119  9849  9849
## [10836]  9849  9849  2559  2559  2559  2559  3690  3690  3690  3690  1752
## [10847]  1752  1752  1752   678   678   678   678  1254  1254  1254  1254
## [10858]  1488  1488  1488  1488  2292  2292  2292  2292  3735  3735  3735
## [10869]  3735  2724  2724  2724  2724   441   441   441   441  2043  2043
## [10880]  2043  2043   285   285   285   285  1800  1800  1800  1800  1525
## [10891]  1525  1525   561   561   561   561  1086  1086  1086  1086  1044
## [10902]  1044  1044  1044   783   783   783   783    89    89    89   336
## [10913]   336   336   336    70    70    70  1959  1959  1959  1959  2244
## [10924]  2244  2244  2244    69    69    69  1917  1917  1917  1917   804
## [10935]   804   804   804  2640  2640  2640  2640  3387  1390  3387  3387
## [10946]  1390  1452  1356  1935    34  1845  1845  1845  1845   645   645
## [10957]   645   645  4047  4047  4047  4047    70    70    70  1308  1308
## [10968]  1308  1308  2217  2217  2217  2217  1059  1059  1059  1059    62
## [10979]    62    62  2214  2214  2214  2214  2340  2340  2340  2340   966
## [10990]   966   966   966  1008  1008  1008  1008  1065  1065  1065  1065
## [11001]  1034   642  1034  1034   642   663   426   371   216  1028  1028
## [11012]   303   723   303   723   654   654   654   654  1956  1956  1956
## [11023]  1956   624   624   624   624   780   780   780   780  1398  1398
## [11034]  1398  1398  1878  1878  1878  1878   207   207   207   207    69
## [11045]    69    69   945   945   945   945  1017  1017  1017  1017    93
## [11056]    93    93  3594  3594  3594  3594  1557  1557  1557  1557   384
## [11067]   384   384   384  1179  1179  1179  1179  1611  1611  1611  1611
## [11078]  1101  1101  1101  1101   699   699   699   699  3804  3804  3804
## [11089]  3804  1533  1533  1533  1533  1884  1884  1884  1884  5049  5049
## [11100]  5049  5049   666   666   666   666    72    72    72   456   456
## [11111]   456   456  3979  3979  3813   165  3813   165   480   480   480
## [11122]   480  1653  1653  1653  1653  3264  3264  3264  3264    83    83
## [11133]    83  1473  1473  1473  1473  1557  1557  1557  1557  1524  1524
## [11144]  1524  1524  2628  2628  2628  2628  2265  2265  2265  2265   720
## [11155]   720   720   720    92    92    92  3270  3270  3270  3270   873
## [11166]   873   873   873  1995  1995  1995  1995  1017  1017  1017  1017
## [11177]   498   498   498   498  3453  3453  3453  3453  8607  8607  8607
## [11188]  8607  4455  4455  4455  4455   339   339   339   339  3048  3048
## [11199]  3048  3048   621   621   621   621   855   855   855   855   837
## [11210]   837   837   837  3324  3324  3324  3324   807   807   807   807
## [11221]  2367  2367  2367  2367   606   606   606   606   453   453   453
## [11232]   453  2244  2244  2244  2244  2436  2436  2436  2436  1365  1365
## [11243]  1365  1365    78    78    78  1275  1275  1275  1275   738   738
## [11254]   738   738  3726  3726  3726  3726   636   636   636   636  1794
## [11265]  1794  1794  1794   636   636   636   636    83    83    83   131
## [11276]   131   131  4749  4749  4749  4749  3498  3498  3498  3498   442
## [11287]   442   442  2076  2076  2076  2076  1329  1329  1329  1329   666
## [11298]   666   666   666  2349  2349  2349  2349  2142  2142  2142  2142
## [11309]  1986  1986  1986  1986  4050  4050  4050  4050   213   213   213
## [11320]  3249  3249  3249  3249   840   840   840   840    83    83    83
## [11331]    73    73    73  3897  3897  3897  3897  3933  3933  3933  3933
## [11342]   183   183   183   669   669   669   669  1158  1158  1158  1158
## [11353]  1920  1920  1920  1920  3480  3480  3480  3480  2184  2184  2184
## [11364]  2184  1332  1332  1332  1332    72    72    72  1317  1317  1317
## [11375]  1317    90    90    90  1131  1131  1131  1131   183   183   183
## [11386]  2487  2487  2487  2487   426   426   426   426   420   420   420
## [11397]   420   113   113   113   330   330   330   330   849   849   849
## [11408]   849  1722  1722  1722  1722  1896  1896  1896  1896  1299  1299
## [11419]  1299  1299   594   594   594   594  4653  4653  4653  4653  4968
## [11430]  4968  4968  4968   351   351   351   351   123   123   123   579
## [11441]   579   579   579  2025  2025  2025  2025  1299  1299  1299  1299
## [11452]  2901  2901  2901  2901  1893  1893  1893  1893   129   129   129
## [11463]  1077  1077  1077  1077  1890  1890  1890  1890  2673  2673  2673
## [11474]  2673  5175  5175  5175  5175  2169  2169  2169  2169  7374  7374
## [11485]  7374  7374   711   711   711   711  2379  2379  2379  2379  2856
## [11496]  2856  2856  2856   939   939   939   939  1737  1737  1737  1737
## [11507]  5568  5568  5568  5568   459   459   459   459  2535  2535  2535
## [11518]  2535  1350  1350  1350  1350   960   960   960   960  1833  1833
## [11529]  1833  1833    68    68    68    78    78    78  1731  1731  1731
## [11540]  1731   948   948   948   948  1212  1212  1212  1212  3480  3480
## [11551]  3480  3480  2556  2556  2556  2556  5574  5574  5574  5574  1254
## [11562]  1254  1254  1254  2523  2523  2523  2523  1059  1059  1059  1059
## [11573]   498   498   498   498  2358  2358  2358  2358   747   747   747
## [11584]   747   134   134   134  2226  2226  2226  2226   915   915   915
## [11595]   915   318   318   318   318  1146  1146  1146  1146   789   789
## [11606]   789   789   793   793   793   792     1  9468  9468  9468  9468
## [11617]  1659  1659  1659  1659  1467  1467  1467  1467  1587  1587  1587
## [11628]  1587  1425  1425  1425  1425   774   774   774   774  2526  2526
## [11639]  2526  2526  7890  7890  7890  7890  6198  6198  6198  6198  1683
## [11650]  1683  1683  1683  1476  1476  1476  1476   951   951   951   951
## [11661]   966   966   966   966  1020  1020  1020  1020   454   454   454
## [11672]   612   612   612   612  1284  1284  1284  1284  1947  1947  1947
## [11683]  1947   360   360   360   360   393   393   393   393  1776  1776
## [11694]  1776  1776  2430  2430  2430  2430  1965  1965  1965  1965   114
## [11705]   114   114   666   666   666   666  2850  2850  2850  2850  4677
## [11716]  4677  4677  4677    78    78    78  2772  2772  2772  2772  2901
## [11727]  2901  2901  2901  1611  1611  1611  1611  2043  2043  2043  2043
## [11738]   684   684   684   684    99    99    99  1332  1332  1332  1332
## [11749]  3066  3066  3066  3066  2094  2094  2094  2094  3273  3273  3273
## [11760]  3273  5691  5691  5691  5691   321   321   321   321  2340  2340
## [11771]  2340  2340   528   528   528   528   951   951   951   951   984
## [11782]   984   984   984   585   585   585   585  1635  1635  1635  1635
## [11793]  1098  1098  1098  1098   888   888   888   888   636   636   636
## [11804]   636   615   615   615   615  1341  1341  1341  1341    69    69
## [11815]    69  1038  1038  1038  1038    68    68    68  1356  1356  1356
## [11826]  1356   687   687   687   687  1728  1728  1728  1728   453   453
## [11837]   453   453   681   681   681   681   131   131   131    90    90
## [11848]    90  1947  1947  1947  1947  1878  1878  1878  1878    81    81
## [11859]    81   446   446   446  2871  2871  2871  2871  1595  1595  1209
## [11870]   384  1209   384  2778  2778  2778  2778  3138  3138  3138  3138
## [11881]   384   384   384   384  1455  1455  1455  1455   924   924   924
## [11892]   924  1095  1095  1095  1095  1950  1950  1950  1950  1767  1767
## [11903]  1767  1767   888   888   888   888  1194  1194  1194  1194  1263
## [11914]  1263  1263  1263   708   708   708   708  3015  3015  3015  3015
## [11925]  2208  2208  2208  2208    76    76    76   104   104   104  2679
## [11936]  2679  2679  2679   438   438   438   438   213   213   213  2574
## [11947]  2574  2574  2574  1608  1608  1608  1608  1032  1032  1032  1032
## [11958]  3198  3198  3198  3198  2204  2204  2204  1176  1176  1176  1176
## [11969]   402   402   402   402  5151  5151  5151  5151  1590  1590  1590
## [11980]  1590  1350  1350  1350  1350  2648  2648  1157  2648  1157  1347
## [11991]  1053   104  1301  1959  1959  1959  1959   447   447   447   447
## [12002]   642   642   642   642    89    89    89  1719  1719  1719  1719
## [12013]  1854  1854  1854  1854    84    84    84   570   570   570   570
## [12024]   285   285   285   951   951   951   951   501   501   501   501
## [12035]  1131  1131  1131  1131   672   672   672   672   918   918   918
## [12046]   918  1119  1119  1119  1119  1248  1248  1248  1248   116   116
## [12057]   116   786   786   786   786   348   348   348   348  1008  1008
## [12068]  1008  1008  1011  1011  1011  1011  1974  1974  1974  1974   954
## [12079]   954   954   954  3711  3711  3711  3711  2988  2988  2988  2988
## [12090]   122   122   122  1641  1641  1641  1641    78    78    78  5178
## [12101]  5178  5178  5178   813   813   813   813   777   777   777   777
## [12112]  1437  1437  1437  1437  1608  1608  1608  1608   879   879   879
## [12123]   879  1644  1644  1644  1644  2481  2481  2481  2481  1422  1422
## [12134]  1422  1422   291   291   291   291  1047  1047  1047  1047    85
## [12145]    85    85  2106  2106  2106  2106  1302  1302  1302  1302  1431
## [12156]  1431  1431  1431  2718  2718  2718  2718  2084  2084  1143   939
## [12167]  1143   939   828   828   828   828  1152  1152  1152  1152  5529
## [12178]  5529  4213  5529  4213  4428  4065  1101   148    70    70    70
## [12189]  3069  3069  3069  3069  1653  1653  1653  1653  2559  2559  2559
## [12200]  2559  1227  1227  1227  1227  1641  1641  1641  1641   492   492
## [12211]   492   492    86    86    86   489   489   489   489 12525 12525
## [12222] 12525 12525  5082  5082  5082  5082  3513  3513  3513  3513   897
## [12233]   897   897   897  3096  3096  3096  3096  1626  1626  1626  1626
## [12244]  5112  5112  5112  5112  2955  2955  2955  2955  2193  2193  2193
## [12255]  2193  1332  1332  1332  1332  4038  4038  4038  4038   669   669
## [12266]   669   669  2763  2763  2763  2763   789   789   789   789  1227
## [12277]  1227  1227  1227  1692  1692  1692  1692   453   453   453   453
## [12288]   765   765   765   765    73    73    73   573   573   573   573
## [12299]  2010  2010  2010  2010  3768  3768  3768  3768  2614  1212  2614
## [12310]  2614  1212  1140  1581    72  1033  1959  1959  1959  1959  1296
## [12321]  1296  1296  1296    73    73    73  1047  1047  1047  1047  1302
## [12332]  1302  1302  1302   885   885   885   885  1197  1197  1197  1197
## [12343]  1314  1314  1314  1314  1392  1392  1392  1392  1425  1425  1425
## [12354]  1425  2268  2268  2268  2268   954   954   954   954    86    86
## [12365]    86  4005  4005  4005  4005   543   543   543   543   879   879
## [12376]   879   879   995   995   315   678   315   678   360   360   360
## [12387]   360  2322  2322  2322  2322  6438  6438  6438  6438  1428  1428
## [12398]  1428  1428  1086  1086  1086  1086  1446  1446  1446  1446    68
## [12409]    68    68    72    72    72   276   276   276   276  1035  1035
## [12420]  1035  1035  4278  4278  4278  4278    91    91    91  1260  1260
## [12431]  1260  1260  3213  3213  3213  3213  4065  4065  4065  4065  1698
## [12442]  1698  1698  1698   324   324   324   324  4050  4050  4050  4050
## [12453]  1077  1077  1077  1077  1467  1467  1467  1467  1404  1404  1404
## [12464]  1404  3243  3243  3243  3243  2139  2139  2139  2139   618   618
## [12475]   618   618  1875  1875  1875  1875   486   486   486   486   693
## [12486]   693   693   693  1158  1158  1158  1158  1995  1995  1995  1995
## [12497]  2826  2826  2826  2826  2532  2532  2532  2532  5727  5727  5727
## [12508]  5727  1398  1398  1398  1398   663   663   663   663   729   729
## [12519]   729   729    78    78    78  2286  2286  2286  2286   276   276
## [12530]   276   276  1303  1303  1278  1303  1278  1293  1020    10   258
## [12541]   119   119   119   972   972   972   972   180   180   180   180
## [12552]  1113  1113  1113  1113  1227  1227  1227  1227  1188  1188  1188
## [12563]  1188  1299  1299  1299  1299    71    71    71   201   201   201
## [12574]   201    87    87    87   417   417   417   417  4026  4026  4026
## [12585]  4026  1290  1290  1290  1290   291   291   291   291  1464  1464
## [12596]  1464  1464    99    99    99    99   270   270   270   270  1194
## [12607]  1194  1194  1194  3477  3477  3477  3477  3175  1684  3175  3175
## [12618]  1684  1569  1794   115  1381   876   876   876   876   684   684
## [12629]   684   684   615   615   615   615    69    69    69   567   567
## [12640]   567   567  7635  7635  7635  7635    96    96    96  1620  1620
## [12651]  1620  1620  2808  2808  2808  2808  1050  1050  1050  1050    85
## [12662]    85    85  2034  2034  2034  2034   570   570   570   570  1239
## [12673]  1239  1239  1239  3219  3219  3219  3219  1629  1629  1629  1629
## [12684]  1386  1386  1386  1386   465   465   465   465    66    66    66
## [12695]  2451  2451  2451  2451  1239  1239  1239  1239  2106  2106  2106
## [12706]  2106  2052  2052  2052  2052  1164  1164  1164  1164  1425  1425
## [12717]  1425  1425   870   870   870   870   576   576   576   576  1047
## [12728]  1047  1047  1047   753   753   753   753  1575  1575  1575  1575
## [12739]  2901  2901  2901  2901  3618  3618  3618  3618  2214  2214  2214
## [12750]  2214  3291  3291  3291  3291   771   771   771   771   312   312
## [12761]   312   312    78    78    78   909   909   909   909   455   455
## [12772]   455    99    99    99  2220  2220  2220  2220  3438  3438  3438
## [12783]  3438   543   543   543   543   903   903   903   903  2169  2169
## [12794]  2169  2169  1386  1386  1386  1386   390   390   390   390   888
## [12805]   888   888   888    73    73    73  1125  1125  1125  1125   501
## [12816]   501   501   501   426   426   426   426  1404  1404  1404  1404
## [12827]  1440  1440  1440  1440    99    99    99  2286  2286  2286  2286
## [12838]   363   363   363   363  2559  2559  2559  2559  1695  1695  1695
## [12849]  1695  2463  2463  2463  2463  2367  2367  2367  2367  1026  1026
## [12860]  1026  2796  2796  2796  2796  2019  2019  2019  2019  4824  4824
## [12871]  4824  4824  1320  1320  1320  1320    74    74    74  3123  3123
## [12882]  3123  3123  1617  1617  1617  1617   417   417   417   417  1458
## [12893]  1458  1458  1458  2910  2910  2910  2910  1086  1086  1086  1086
## [12904]   402   402   402   402   804   804   804   804   597   597   597
## [12915]   597  1839  1839  1839  1839  1797  1797  1797  1797  1743  1743
## [12926]  1743  1743   119   119   119  1149  1149  1149  1149  1068  1068
## [12937]  1068  1068  2064  2064  2064  2064   462   462   462   462   390
## [12948]   390   390   390    81    81    81    95    95    95  1350  1350
## [12959]  1350  1350  3396  3396  3396  3396  4440  4440  4440  4440  1968
## [12970]  1968  1968  1968    85    85    85  4800  4800  4800  4800 13935
## [12981] 13935 13935 13935  1554  1554  1554  1554   579   579   579   579
## [12992]   975   975   975   975  1269  1269  1269  1269  1686  1686  1686
## [13003]  1686  1758  1758  1758  1758  1590  1590  1590  1590  1131  1131
## [13014]  1131  1131   990   990   990   990  3891  3891  3891  3891   849
## [13025]   849   849   849  3954  3954  3954  3954   666   666   666   666
## [13036]  5298  5298  5298  5298   954   954   954   954  2142  2142  2142
## [13047]  2142  1140  1140  1140  1140  1569  1569  1569  1569  1587  1587
## [13058]  1587  1587   354   354   354   354  1218  1218  1218  1218    90
## [13069]    90    90  1023  1023  1023  1023    75    75    75  1785  1785
## [13080]  1785  1785    68    68    68  3438  3438  3438  3438  2745  2745
## [13091]  2745  2745  1095  1095  1095  1095  3174  3174  3174  3174  1521
## [13102]  1521  1521  1521  1956  1956  1956  1956  2079  2079  2079  2079
## [13113]  1209  1209  1209  1209  1413  1413  1413  1413  1761  1761  1761
## [13124]  1761   429   429   429   429  9600  9600  9600  9600  2889  2889
## [13135]  2889  2889  1734  1734  1734  1734  1101  1101  1101  1101  1254
## [13146]  1254  1254  1254  1674  1674  1674  1674   858   858   858   858
## [13157]  1686  1686  1686  1686  1818  1818  1818  1818  2157  2157  2157
## [13168]  2157  1233  1233  1233  1233  2958  2958  2958  2958  1668  1668
## [13179]  1668  1668   102   102   102  4416  4416  4416  4416   576   576
## [13190]   576   576  1959  1959  1959  1959   861   861   861   861  2508
## [13201]  2508  2508  2508  1023  1023  1023  1023   345   345   345   345
## [13212]  2169  2169  2169  2169  2292  2292  2292  2292  4104  4104  4104
## [13223]  4104  4224  4224  4224  4224  5994  5994  5994  5994  1734  1734
## [13234]  1734  1734    75    75    75   705   705   705   705  3171  3171
## [13245]  3171  3171  1689  1689  1689  1689   426   426   426   426   363
## [13256]   363   363   363   372   372   372   372  4674  4674  4674  4674
## [13267]   465   465   465   465  1236  1236  1236  1236  5916  5916  5916
## [13278]  5916  1116  1116  1116  1116  3150  3150  3150  3150   516   516
## [13289]   516   516  1149  1149  1149  1149   642   642   642   642  1344
## [13300]  1344  1344  1344  1209  1209  1209  1209  2928  2928  2928  2928
## [13311]  2094  2094  2094  2094  5700  5700  5700  5700   283   283   283
## [13322]   591   591   591   591   618   618   618   618   957   957   957
## [13333]   957  1767  1767  1767  1767   468   468   468   468  2355  2355
## [13344]  2355  2355  3564  3564  3564  3564  1332  1332  1332  1332   603
## [13355]   603   603   603  1800  1800  1800  1800  1005  1005  1005  1005
## [13366]  2862  2862  2862  2862   888   888   888   888  1809  1809  1809
## [13377]  1809 14889 14889 14889 14889  1887  1887  1887  1887  1425  1425
## [13388]  1425  1425  4860  4860  4860  4860  3360  3360  3360  3360   603
## [13399]   603   603   603   681   681   681   681    83    83    83   552
## [13410]   552   552   552    82    82    82  3363  3363  3363  3363  2889
## [13421]  2889  2889  2889    78    78    78  3720  3720  3720  3720   627
## [13432]   627   627   627   774   774   774   774  1846  1846   373  1846
## [13443]   373   924   177   922   196   132   132   132  1995  1995  1995
## [13454]  1995  1953  1953  1953  1953  2172  2172  2172  2172   765   765
## [13465]   765   765    83    83    83   642   642   642   642  1476  1476
## [13476]  1476  1476  1251  1251  1251  1251  5907  5907  5907  5907   447
## [13487]   447   447   447  1107  1107  1107  1107   765   765   765   765
## [13498]  7671  7671  7671  7671   573   573   573   573  3267  3267  3267
## [13509]  3267  1866  1866  1866  1866  1125  1125  1125  1125  1212  1212
## [13520]  1212  1212    74    74    74   591   591   591   591  1746  1746
## [13531]  1746  1746  1293  1293  1293  1293  1575  1575  1575  1575  1995
## [13542]  1995  1995  1995  1644  1644  1644  1644   507   507   507   507
## [13553]  2610  2610  2610  2610  7797  7797  7797  7797  1557  1557  1557
## [13564]  1557   732   732   732   732   324   324   324   324  1338  1338
## [13575]  1338  1338   912   912   912   912  5187  5187  5187  5187   384
## [13586]   384   384   384   804   804   804   804  1374  1374  1374  1374
## [13597]  2022  2022  2022  2022   795   795   795   795  1980  1980  1980
## [13608]  1980  1494  1494  1494  1494  4494  4494  4494  4494   927   927
## [13619]   927   927  4758  4758  4758  4758  2922  2922  2922  2922   378
## [13630]   378   378   378  1293  1293  1293  1293  2217  2217  2217  2217
## [13641]  4116  4116  4116  4116  4755  4755  4755  4755   903   903   903
## [13652]   903  1071  1071  1071  1071  2283  2283  2283  2283  1434  1434
## [13663]  1434  1434  1086  1086  1086  1086  4494  4494  4494  4494    81
## [13674]    81    81  7350  7350  7350  7350  3717  3717  3717  3717  2706
## [13685]  2706  2706  2706  1098  1098  1098  1098  1185  1185  1185  1185
## [13696]  2400  2400  2400  2400  2172  2172  2172  2172 18495 18495 18495
## [13707] 18495  1194  1194  1194  1194  1038  1038  1038  1038  1041  1041
## [13718]  1041  1041    68    68    68  1137  1137  1137  1137  2256  2256
## [13729]  2256  2256  3567  3567  3567  3567  1026  1026  1026  1026  2742
## [13740]  2742  2742  2742  1788   582  1788   582  1788   426   750   156
## [13751]  1038  1821  1821  1821  1821  2109  2109  2109  2109   660   660
## [13762]   660   660   492   492   492   492   828   828   828   828   948
## [13773]   948   948   948   336   336   336   336   900   900   900   900
## [13784]  3018  3018  3018  3018  3639  3639  3639  3639    93    93    93
## [13795]   966   966   966   966   477   477   477   477  1482  1482  1482
## [13806]  1482  1224  1224  1224  1224    73    73    73  3066  3066  3066
## [13817]  3066  1749  1749  1749  1749   579   579   579   579   213   213
## [13828]   213   213  2232  2232  2232  2232   480   480   480   480   765
## [13839]   765   765   765   249   249   249   249   762   762   762   762
## [13850]  2055  2055  2055  2055    81    81    81 13188 13188 13188 13188
## [13861]  1431  1431  1431  1431  1989  1989  1989  1989  2418  2418  2418
## [13872]  2418  8517  2939  8517  8517  2939  4599  2748  3918   191    81
## [13883]    81    81   915   915   915   915    99    99    99  3234  3234
## [13894]  3234  3234  1089  1089  1089  1089  1389  1389  1389  1389   894
## [13905]   894   894   894  2055  2055  2055  2055  1437  1437  1437  1437
## [13916]  1395  1395  1395  1395  2381  2381  1756  2381  1756  1869  1554
## [13927]   202   512  3414  3414  3414  3414   498   498   498   498  2016
## [13938]  2016  2016  2016   501   501   501   501   450   450   450   450
## [13949]   720   720   720   720  1251  1251  1251  1251   372   372   372
## [13960]   372  4200  4200  4200  4200  1692  1692  1692  1692   750   750
## [13971]   750   750   411   411   411   411   585   585   585   585  1350
## [13982]  1350  1350  1350  1855  1855  1855  3021  3021  3021  3021   104
## [13993]   104   104   543   543   543   543  1914  1914  1914  1914  3723
## [14004]  3723  3723  3723  1842  1842  1842  1842  1815  1815  1815  1815
## [14015]  2013  2013  2013  2013    99    99    99  3573  3573  3573  3573
## [14026]   840   840   840   840  1257  1257  1257  1257   909   909   909
## [14037]   909    97    97    97  1413  1413  1413  1413  1323  1323  1323
## [14048]  1323  1806  1806  1806  1806  1836  1836  1836  1836  2265  2265
## [14059]  2265  2265   966   966   966   966  3042  3042  3042  3042   708
## [14070]   708   708   708   912   912   912   912  1020  1020  1020  1020
## [14081]  3711  3711  3711  3711   114   114   114  1344  1344  1344  1344
## [14092]  1581  1581  1581  1581  1158  1158  1158  1158   927   927   927
## [14103]   927  2139  2139  2139  2139  2244  2244  2244  2244  2832  2832
## [14114]  2832  2832  1995  1995  1995  1995  1158  1158  1158  1158  1017
## [14125]  1017  1017  1017  1761  1761  1761  1761   750   750   750   750
## [14136]  3201  3201  3201  3201   921   921   921   921  2469  2469  2469
## [14147]  2469  1481  1399  1481  1481  1399  1419  1119    62   280  3054
## [14158]  3054  3054  3054  1176  1176  1176  1176  1515  1515  1515  1515
## [14169]  1692  1692  1692  1692  2097  2097  2097  2097   387   387   387
## [14180]   387  1080  1080  1080  1080  1161  1161  1161  1161  4716  4716
## [14191]  4716  4716  2361  2361  2361  2361  1515  1515  1515  1515    72
## [14202]    72    72  1206  1206  1206  1206  1260  1260  1260  1260  1530
## [14213]  1530  1530  1530  1761  1761  1761  1761  2667  2667  2667  2667
## [14224]  3009  3009  3009  3009   116   116   116   723   723   723   723
## [14235]  1098  1098  1098  1098   454   454   454  1146  1146  1146  1146
## [14246]  1780  1780  1780   489   489   489   489   441   441   441   441
## [14257]  1077  1077  1077  1077  1143  1143  1143  1143   798   798   798
## [14268]   798  3126  3126  3126  3126   774   774   774   774  1617  1617
## [14279]  1617  1617   825   825   825   825   765   765   765   765  2133
## [14290]  2133  2133  2133  2028  2028  2028  2028   369   369   369   369
## [14301]   666   666   666   666  1461  1461  1461  1461   567   567   567
## [14312]   567  3036  3036  3036  3036  1356  1356  1356  1356  1059  1059
## [14323]  1059  1059  2400  2400  2400  2400  2706  2706  2706  2706  3402
## [14334]  3402  3402  3402  1086  1086  1086  1086  2913  2913  2913  2913
## [14345]  1389  1389  1389  1389  1668  1668  1668  1668   390   390   390
## [14356]   390   600   600   600   600  1635  1635  1635  1635   696   696
## [14367]   696   696  2403  2403  2403  2403  3474  3474  3474  3474  4989
## [14378]  4989  4989  4989  2778  2778  2778  2778  1071  1071  1071  1071
## [14389]  1098  1098  1098  1098  1914  1914  1914  1914  1503  1503  1503
## [14400]  1503    96    96    96  1209  1209  1209  1209  1596  1596  1596
## [14411]  1596   834   834   834   834  1203  1203  1203  1203  2226  2226
## [14422]  2226  2226   690   690   690   690  1275  1275  1275  1275  1128
## [14433]  1128  1128  1128   873   873   873   873  1545  1545  1545  1545
## [14444]  1386  1386  1386  1386  1449  1449  1449  1449   387   387   387
## [14455]   387  3045  3045  3045  3045  1707  1707  1707  1707  1770  1770
## [14466]  1770  1770  4320  4320  4320  4320   429   429   429   429    92
## [14477]    92    92  2322  2322  2322  2322  2187  2187  2187  2187  1245
## [14488]  1245  1245  1245   657   657   657   657  1110  1110  1110  1110
## [14499]  1830  1830  1830  1830  1167  1167  1167  1167  8076  8076  8076
## [14510]  8076  1302  1302  1302  1302   442   442   442  1107  1107  1107
## [14521]  1107  9291  9291  9291  9291  2172  2172  2172  2172  2544  2544
## [14532]  2544  2544  1332  1332  1332  1332  1338  1338  1338  1338  1182
## [14543]  1182  1182  1182  1338  1338  1338  1338  1800  1800  1800  1800
## [14554]  1797  1797  1797  1797  4103  3436  4103  4103  3436  3300  3684
## [14565]   136   419  1050  1050  1050  1050  2196  2196  2196  2196  2664
## [14576]  2664  2664  2664  2985  2985  2985  2985   327   327   327   327
## [14587]   366   366   366   366  2799  2799  2799  2799  1707  1707  1707
## [14598]  1707   663   663   663   663  3255  3255  3255  3255   579   579
## [14609]   579   579  1407  1407  1407  1407    57    57    57   762   762
## [14620]   762   762  2382  2382  2382  2382    89    89    89  1869  1869
## [14631]  1869  1869   288   288   288   288  1692  1692  1692  1692  6507
## [14642]  6507  6507  6507  1137  1137  1137  1137   699   699   699   699
## [14653]  4110  4110  4110  4110  1908  1908  1908  1908  3501  3501  3501
## [14664]  3501  2562  2562  2562  2562   615   615   615   615   732   732
## [14675]   732   732  2538  2538  2538  2538  2817  2817  2817  2817  1158
## [14686]  1158  1158  1158   510   510   510   510  1314  1314  1314  1314
## [14697]  2013  2013  2013  2013   456   456   456   456  1218  1218  1218
## [14708]  1218   849   849   849   849  2562  2562  2562  2562  2268  2268
## [14719]  2268  2268  1047  1047  1047  1047  2193  2193  2193  2193  2127
## [14730]  2127  2127  2127  1068  1068  1068  1068  2541  2541  2541  2541
## [14741]  5313  5313  5313  5313  2088  2088  2088  2088  1299  1299  1299
## [14752]  1299  4785  4785  4785  4785    68    68    68  2544  2544  2544
## [14763]  2544   321   321   321   321   849   849   849   849  1917  1917
## [14774]  1917  1917   354   354   354   354  1065  1065  1065  1065  2709
## [14785]  2709  2709  2709   777   777   777   777    76    76    76  1995
## [14796]  1995  1995  1995    71    71    71  2640  2640  2640  2640  5442
## [14807]  5442  5442  5442  2763  2763  2763  2763   714   714   714   714
## [14818]   639   639   639   639 16146 16146 16146 16146  1344  1344  1344
## [14829]  1344  2586  2586  2586  2586  1188  1188  1188  1188  2547  2547
## [14840]  2547  2547  1191  1191  1191  1191  2115  2115  2115  2115    69
## [14851]    69    69  3642  3642  3642  3642  1794  1794  1794  1794  3312
## [14862]  3312  3312  3312  1320  1320  1320  1320   882   882   882   882
## [14873]  2112  2112  2112  2112   387   387   387   387  1335  1335  1335
## [14884]  1335  1707  1707  1707  1707   588   588   588   588  1089  1089
## [14895]  1089  1089  1431  1431  1431  1431  1890  1890  1890  1890   675
## [14906]   675   675   675    72    72    72  3090  3090  3090  3090  1092
## [14917]  1092  1092  1092    78    78    78  4410  4410  4410  4410  1026
## [14928]  1026  1026  1026  2289  2289  2289  2289  5445  5445  5445  5445
## [14939]  1284  1284  1284  1284  1239  1239  1239  1239  1188  1188  1188
## [14950]  1188   513   513   513   513  3492  3492  3492  3492  1395  1395
## [14961]  1395  1395   564   564   564   564  2826  2826  2826  2826  3207
## [14972]  3207  3207  3207   387   387   387   387   918   918   918   918
## [14983]   723   723   723   723   813   813   813   813  1779  1779  1779
## [14994]  1779  1641  1641  1641  1641  2502  2502  2502  2502   990   990
## [15005]   990   990   321   321   321   321  1716  1716  1716  1716  3315
## [15016]  3315  3315  3315   480   480   480   480  3099  3099  3099  3099
## [15027]   903   903   903   903  2931  2931  2931  2931  2460  2460  2460
## [15038]  2460   324   324   324   324   411   411   411   411  4851  4851
## [15049]  4851  4851   909   909   909   909   465   465   465   465   615
## [15060]   615   615   615  1077  1077  1077  1077  1722  1722  1722  1722
## [15071]   723   723   723   723  1899  1899  1899  1899  3741  3741  3741
## [15082]  3741   129   129   129   315   315   315   315   516   516   516
## [15093]   516   597   597   597   597  1179  1179  1179  1179   882   882
## [15104]   882   882  2322  2322  2322  2322  1851  1851  1851  1851  1455
## [15115]  1455  1455  1455   342   342   342   342  6657  6657  6657  6657
## [15126]  1398  1398  1398  1398  4410  4410  4410  4410   429   429   429
## [15137]   429  4941  4941  4941  4941  2016  2016  2016  2016  1251  1251
## [15148]  1251  1251  2442  2442  2442  2442   288   288   288   288   969
## [15159]   969   969   969  1422  1422  1422  1422   480   480   480   480
## [15170]  1341  1341  1341  1341   768   768   768   768  2664  2664  2664
## [15181]  2664  3285  3285  3285  3285  1479  1479  1479  1479  2862  2862
## [15192]  2862  2862  1233  1233  1233  1233  3837  3837  3837  3837  1188
## [15203]  1188  1188  1188  1134  1134  1134  1134    93    93    93  1888
## [15214]  1888   880  1007   880  1007   945   945   945   945  2097  2097
## [15225]  2097  2097  2067  2067  2067  2067   933   933   933   933  5643
## [15236]  5643  5643  5643  6579  6579  6579  6579   906   906   906   906
## [15247]  1116  1116  1116  1116  1164  1164  1164  1164  1113  1113  1113
## [15258]  1113    69    69    69  1656  1656  1656  1656    91    91    91
## [15269]  2211  2211  2211  2211  3708  3708  3708  3708    66    66    66
## [15280]   816   816   816   816  3411  3411  3411  3411  1812  1812  1812
## [15291]  1812   927   927   927   927  1269  1269  1269  1269  2541  2541
## [15302]  2541  2541  1596  1596  1596  1596  3594  3594  3083  3594  3083
## [15313]  3150  2982   444   101  4083  4083  4083  4083  3786  3786  3786
## [15324]  3786   678   678   678   678    70    70    70   477   477   477
## [15335]   477   852   852   852   852   702   702   702   702  1560  1560
## [15346]  1560  1560  1350  1350  1350  1350    73    73    73   978   978
## [15357]   978   978  1488  1488  1488  1488   498   498   498   498  2523
## [15368]  2523  2523  2523    94    94    94 13113 13113 13113 13113  5991
## [15379]  5991  5991  5991  1044  1044  1044  1044    83    83    83   417
## [15390]   417   417   417   708   708   708   708  2532  2532  1071   822
## [15401]   636  1071   822   636  1845  1845  1845  1845  2811  2811  2811
## [15412]  2811  1920  1920  1920  1920  1578  1578  1578  1578  3567  3567
## [15423]  3567  3567   963   963   963   963   450   450   450   450  1203
## [15434]  1203  1203  1203   810   810   570   810   570   693   522   117
## [15445]    48  1236  1236  1236  1236  2724  2724  2724  2724   828   828
## [15456]   828   828  1887  1887  1887  1887   723   723   723   723   516
## [15467]   516   516   516  1770  1770   963   348   456   963   348   456
## [15478]  1464  1464  1464  1464  2703  2703  2703  2703  6990  6990  4913
## [15489]  6990  4913  5475  4713  1515   200    66    66    66   945   945
## [15500]   945   945  2373  2373  2373  2373   909   909   909   909  2358
## [15511]  2358  2358  2358  4245  4245  4245  4245  2073  2073  2073  2073
## [15522]    75    75    75   264   264   264   264  5163  5163  5163  5163
## [15533]  3447  3447  3447  3447   129   129   129   381   381   381   381
## [15544]   633   633   633   633  1665  1665  1665  1665   104   104   104
## [15555]   465   465   465   465   702   702   702   702   471   471   471
## [15566]   471  2667  2667  2667  2667  3678  3678  3678  3678  2496  2496
## [15577]  2496  2496  2232  2232  2232  2232  3387  3387  3387  3387  1890
## [15588]  1890  1890  1890   282   282   282   282   119   119   119  1368
## [15599]  1368  1368  1368   438   438   438   438  2106  2106  2106  2106
## [15610]   477   477   477   477   780   780   780   780  1215  1215  1215
## [15621]  1215   693   693   693   693   843   843   843   843  1380  1380
## [15632]  1380  1380   474   474   474   474  1890  1890  1890  1890  6537
## [15643]  6537  6537  6537    73    73    73   972   972   972   972  2973
## [15654]  2973  2973  2973   456   456   456   456  1083  1083  1083  1083
## [15665]  1032  1032  1032  1032  3933  3933  3933  3933   283   283   283
## [15676]   119   119   119  3339  3339  3339  3339   375   375   375   375
## [15687]   405   405   405   405   116   116   116  2487  2487  2487  2487
## [15698]  2229  2229  2229  2229  2793  2793  2793  2793  1284  1284  1284
## [15709]  1284  2082  2082  2082  2082  2733  2733  2733  2733  9834  9834
## [15720]  9834  9834  1131  1131  1131  1131  2172  2172  2172  2172  2994
## [15731]  2994  2994  2994   771   771   771   771   375   375   375   375
## [15742]  4935  4935  4935  4935  1314  1314  1314  1314   984   984   984
## [15753]   984   104   104   104   336   336   336   336   101   101   101
## [15764]  1806  1806  1806  1806  2553  2553  2553  2553  1836  1836  1836
## [15775]  1836   867   867   867   867  1461  1461  1461  1461   447   447
## [15786]   447   447  2895  2895  2895  2895   104   104   104   675   675
## [15797]   675   675  1587  1587  1587  1587  2772  2772  2772  2772  1857
## [15808]  1857  1857  1857  4011  4011  4011  4011  2589  2589  2589  2589
## [15819]  2025  2025  2025  2025  1869  1869  1869  1869  1779  1779  1779
## [15830]  1779  2805  2805  2805  2805  4716  4716  4716  4716  1965  1965
## [15841]  1965  1965  1869  1869  1869  1869  2019  2019  2019  2019   906
## [15852]   906   906   906   279   279   279   279   453   453   453   453
## [15863]  1602  1602  1602  1602  1347  1347  1347  1347   318   318   318
## [15874]   318  3426  3426  3426  3426  1839  1839  1839  1839  3843  3843
## [15885]  3843  3843  2406  2406  2406  2406   936   936   936   936  3279
## [15896]  3279  3279  3279  2547  2547  2547  2547   282   282   282   282
## [15907]  2691  2691  2691  2691  1110  1110  1110  1110   936   936   936
## [15918]   936  2034  2034  2034  2034   453   453   453   453   813   813
## [15929]   813   813   972   972   972   972  3837  3837  3837  3837  1218
## [15940]  1218  1218  1218  3189  3189  3189  3189  3498  3498  3498  3498
## [15951]  1029  1029  1029  1029  1905  1905  1905  1905  4662  4662  4662
## [15962]  4662  1551  1551  1551  1551  9831  9831  9831  9831  3012  3012
## [15973]  3012  3012  2400  2400  2400  2400  1041  1041  1041  1041   732
## [15984]   732   732   732   561   561   561   561   816   816   816   816
## [15995]  1962  1962  1962  1962  1860  1860  1860  1860  1071  1071  1071
## [16006]  1071   693   693   693   693  1458  1458  1458  1458  2481  2481
## [16017]  2481  2481 16908 16908 16908 16908  2097  2097  2097  2097   363
## [16028]   363   363   363  3885  3885  3885  3885  1170  1170  1170  1170
## [16039]   621   621   621   621  2130  2130  2130  2130  1053  1053  1053
## [16050]  1053  1602  1602  1602  1602  3615  3615  3615  3615   984   984
## [16061]   984   984  6036  6036  6036  6036  1443  1443  1443  1443    89
## [16072]    89    89  2259  2259  2259  2259  1392  1392  1392  1392   780
## [16083]   780   780   780  1525  1525  1525   591   591   591   591   351
## [16094]   351   351   351  1782  1782  1782  1782   234   234   234   234
## [16105]  1740  1740  1740  1740  2973  2973  2973  2973  1428  1428  1428
## [16116]  1428  1233  1233  1233  1233   795   795   795   795  2541  2541
## [16127]  2541  2541    91    91    91  3741  3741  3741  3741   867   867
## [16138]   867   867   501   501   501   501  1716  1716  1716  1716  1920
## [16149]  1920  1920  1920   717   717   717   717  5640  5640  5640  5640
## [16160]   582   582   582   582  1167  1167  1167  1167  1050  1050  1050
## [16171]  1050  2454  2454  2454  2454   600   600   600   600  1731  1731
## [16182]  1731  1731  1992  1992  1992  1992   579   579   579   579   351
## [16193]   351   351   351   480   480   480   480  1320  1320  1320  1320
## [16204]  1734  1734  1734  1734  1218  1218  1218  1218   705   705   705
## [16215]   705   966   966   966   966   864   864   864   864  1467  1467
## [16226]  1467  1467  1056  1056  1056  1056  1128  1128  1128  1128  1068
## [16237]  1068  1068  1068   390   390   390   390  1125  1125  1125  1125
## [16248]   801   801   801   801  4581  4581  4581  4581 12678 12678 12678
## [16259] 12678   101   101   101  2535  2535  2535  2535  1335  1335  1335
## [16270]  1335   834   834   834   834   393   393   393   393  4299  4299
## [16281]  4299  4299  1824  1824  1824  1824  1098  1098  1098  1098    90
## [16292]    90    90  1326  1326  1326  1326  1149  1149  1149  1149   442
## [16303]   442   442  1659  1659  1659  1659   459   459   459   459   864
## [16314]   864   864   864  5661  5661  5661  5661   924   924   924   924
## [16325]  2319  2319  2319  2319  1158  1158  1158  1158  1611  1611  1611
## [16336]  1611  2157  2157  2157  2157   603   603   603   603  2451  2451
## [16347]  2451  2451  1179  1179  1179  1179    81    81    81  1662  1662
## [16358]  1662  1662  1515  1515  1515  1515  2379  2379  2379  2379  1287
## [16369]  1287  1287  1287  1272  1272  1272  1272  1185  1185  1185  1185
## [16380]  1297  1297   309   978   309   978   735   735   735   735  1116
## [16391]  1116  1116  1116   660   660   660   660  1911  1911  1911  1911
## [16402]    72    72    72   615   615   615   615  1653  1653  1653  1653
## [16413]    72    72    72   717   717   717   717   726   726   726   726
## [16424]  1299  1299  1299  1299   654   654   654   654   894   894   894
## [16435]   894   282   282   282   282  3531  3531  3531  3531  1332  1332
## [16446]  1332  1332  1236  1236  1236  1236    70    70    70   861   861
## [16457]   861   861  5337  5337  5337  5337  1632  1632  1632  1632  1356
## [16468]  1356  1356  1356  1788  1788  1788  1788  6573  6573  6573  6573
## [16479]  1689  1689  1689  1689  2352  2352  2352  2352   918   918   918
## [16490]   918   285   285   285  1332  1332  1332  1332   210   210   210
## [16501]   210  5949  5949  5949  5949   762   762   762   762  1440  1440
## [16512]  1440  1440    70    70    70  1152  1152  1152  1152  1725  1725
## [16523]  1725  1725   405   405   405   405  1647  1647  1647  1647  2760
## [16534]  2760  2760  2760  1503  1503  1503  1503  2172  2172  2172  2172
## [16545]  1608  1608  1608  1608  2493  2493  2493  2493   855   855   855
## [16556]   855  1470  1470  1470  1791  1791  1791  1791  2748  1013  2748
## [16567]  2748  1013   924  1203    89  1545  2823  2823  2823  2823   783
## [16578]   783   783   783   516   516   516   516   450   450   450   450
## [16589]   414   414   414   414  1839  1839  1839  1839   762   762   762
## [16600]   762   432   432   432   432   420   420   420   420   119   119
## [16611]   119  2295  2295  2295  2295   453   453   453   453  1167  1167
## [16622]  1167  1167   669   669   669   669  1026  1026  1026  1026  1407
## [16633]  1407  1407  1407  5169  5169  5169  5169  1335  1335  1335  1335
## [16644]   633   633   633   633  1524  1524  1524  1524  7560  7560  7560
## [16655]  7560   888   888   888   888  1782  1782  1782  1782   585   585
## [16666]   585   585    75    75    75  2934  2934  2934  2934  2805  2805
## [16677]  2805  2805   900   900   900   900   402   402   402   402  2175
## [16688]  2175  2175  2175   918   918   918   918   429   429   429   429
## [16699]   852   852   852   852 10077 10077 10077 10077  1260  1260  1260
## [16710]  1260    66    66    66  1890  1890  1890  1890  1998  1998  1998
## [16721]  1998  3273  3273  3273  3273    85    85    85   480   480   480
## [16732]   480  9504  9504  9504  9504  2553  2553  2553  2553  1503  1503
## [16743]  1503  1503  1050  1050  1050  1050    69    69    69   636   636
## [16754]   636   636  4935  4935  4935  4935    99    99    99  3999  3999
## [16765]  3999  3999  1518  1518  1518  1518  2013  2013  2013  2013   954
## [16776]   954   954   954   879   879   879   879  3990  3990  3990  3990
## [16787] 15225 15225 15225 15225   106   106   106   732   732   732   732
## [16798]   429   429   429   429  1719  1719  1719  1719  2028  2028  2028
## [16809]  2028  2838  2838  2838  2838  1005  1005  1005  1005  1116  1116
## [16820]  1116  1116  3435  3435  3435  3435   852   852   852   852  1332
## [16831]  1332  1332  1332   312   312   312   312  1146  1146  1146  1146
## [16842]  1005  1005  1005  1005  1845  1845  1845  1845  2403  2403  2403
## [16853]  2157   246  1515  1515  1515  1515    78    78    78  1320  1320
## [16864]  1320  1320  2532  2532  2532  2532  3120  3120  3120  3120   279
## [16875]   279   279   279   357   357   357   357   495   495   495   495
## [16886]  2034  2034  2034  2034  1749  1749  1749  1749  1728  1728  1728
## [16897]  1728  2073  2073  2073  2073  1029  1029  1029  1029   456   456
## [16908]   456   456  1818  1818  1818  1818  1302  1302  1302  1302  5970
## [16919]  5970  5970  5970   129   129   129  3849  3849  3849  3849  1041
## [16930]  1041  1041  1041  1260  1260  1260  1260  5622  5622  5622  5622
## [16941]   732   732   732   732  2298  2298  2298  2298   729   729   729
## [16952]   729   318   318   318   318  1482  1482  1482  1482  3531  3531
## [16963]  3531  3531  1569  1569  1569  1569   537   537   537   537   738
## [16974]   738   738   738   498   498   498   498  1197  1197  1197  1197
## [16985]  1248  1248  1248  1248  1221  1221  1221  1221   372   372   372
## [16996]   372  1611  1611  1611  1611   327   327   327   327  1170  1170
## [17007]  1170  1170   327   327   327   327  1296  1296  1296  1296  1245
## [17018]  1245  1245  1245   567   567   567   567  3090  3090  3090  3090
## [17029]  2820  2820   567  1428   822   567  1428   822  1440  1440  1440
## [17040]  1440   600   600   600   600  5679  5679  5679  5679   588   588
## [17051]   588   588  1245  1245  1245  1245  6762  6762  6762  6762  1092
## [17062]  1092  1092  1092   873   873   873   873  1185  1185  1185  1185
## [17073]  1455  1455  1455  1455  1071  1071  1071  1071  6141  6141  6141
## [17084]  6141  1122  1122  1122  1122    94    94    94   825   825   825
## [17095]   825  3222  3222  3222  3222   366   366   366   366   789   789
## [17106]   789   789  4281  4281  4281  4281  3150  3150  3150  3150 13662
## [17117] 13662 13662 13662  1803  1803  1803  1803   960   960   960   960
## [17128]   492   492   492   492  2478  2478  2478  2478   870   870   870
## [17139]   870   615   615   615   615  1119  1119  1119  1119  2385  2385
## [17150]  2385  2385   342   342   342   342  1818  1818  1818  1818 14277
## [17161] 14277 14277 14277   453   453   453   453  1017  1017  1017  1017
## [17172]   858   858   858   858  1692  1692  1692  1692   414   414   414
## [17183]   414  4290  4290  4290  4290    99    99    99  2403  2403  2403
## [17194]  2403   297   297   297   297   663   663   663   663   405   405
## [17205]   405   405    68    68    68  2346  2346  2346  2346    78    78
## [17216]    78   402   402   402   402   131   131   131  1767  1767  1767
## [17227]  1767    92    92    92   336   336   336   336  2139  2139  2139
## [17238]  2139  1245  1245  1245  1245   348   348   348   348  1311  1311
## [17249]  1311  1311   366   366   366   366  1803  1803  1803  1803  1191
## [17260]  1191  1191  1437  1437  1437  1437  1413  1413  1413  1413   114
## [17271]   114   114  3699  3699  3699  3699   702   702   702   702  1665
## [17282]  1665  1665  1665   615   615   615   615    69    69    69  3417
## [17293]  3417  3417  3417  1474  1416  1474  1474  1416  1302  1431   114
## [17304]    43  2067  2067  2067  2067   549   549   549   549   546   546
## [17315]   546   546  1026  1026  1026  1026  1206  1206  1206  1206   480
## [17326]   480   480   480   612   612   612   612  1409  1346  1409  1409
## [17337]  1346  1356   648    53   698  2676  2676  2676  2676   663   663
## [17348]   663   663  1125  1125  1125  1125    78    78    78   651   651
## [17359]   651   651   495   495   495   495  3066  3066  3066  3066  8214
## [17370]  8214  8214  8214  1740  1740  1740  1740   417   417   417   417
## [17381]   495   495   495   495   561   561   561   561   942   942   942
## [17392]   942  3447  3447  3447  3447   357   357   357   357   840   840
## [17403]   840   840   426   426   426   426  1155  1155  1155  1155   558
## [17414]   558   558   558   597   597   597   597    78    78    78  2649
## [17425]  2649  2649  2649  1347  1347  1347  1347  1014  1014  1014  1014
## [17436]  1836  1836  1836  1836  3192  3192  3192  3192  2823  2823  2823
## [17447]  2823   366   366   366   366  3966  3966  3966  3966  1362  1362
## [17458]  1362  1362   252   252   252   252   732   732   732   732   564
## [17469]   564   564   564   591   591   591   591  3426  3426  3426  3426
## [17480]  1314  1314  1314  1314    73    73    73  1506  1506  1506  1506
## [17491]  2184  2184  2184  2184  1278  1278  1278  1278   591   591   591
## [17502]   591    57    57    57  3501  3501  3501  3501   264   264   264
## [17513]   264   591   591   591   591    78    78    78   283   283   283
## [17524]  1101  1101  1101  1101  1800  1800  1800  1800   103   103   103
## [17535]  1161  1161  1161  1161   336   336   336   336   120   120   120
## [17546]  8865  8865  8865  8865    69    69    69   666   666   666   666
## [17557]  2289  2289  2289  2289    73    73    73  2046  2046  2046  2046
## [17568]   978   978   978   978  1077  1077  1077  1077  1365  1365  1365
## [17579]  1365  3813  3813  1683   957  1170  1683   957  1170   455   455
## [17590]   455    74    74    74  5943  5943  5943  5943  1212  1212  1212
## [17601]  1212  1281  1281  1281  1281  1770  1770  1770  1770    91    91
## [17612]    91  4815  4815  4815  4815  3786  3786  3786  3786  1371  1371
## [17623]  1371  1371    83    83    83  3099  3099  3099  3099  2040  2040
## [17634]  2040  2040  1014  1014  1014  1014    72    72    72  1803  1803
## [17645]  1803  1803  1053  1053  1053  1053  1692  1692  1692  1692  1665
## [17656]  1665  1665  1665  1614  1614  1614  1614   645   645   645   645
## [17667]   744   744   744   744  1161  1161  1161  1161  2304  2304  2304
## [17678]  2304    99    99    99  1998  1998  1998  1998  1551  1551  1551
## [17689]  1551  4626  4626  4626  4626  1260  1260  1260  1260  2133  2133
## [17700]  2133  2133  1833  1833  1833  1833   446   446   446  2550  2550
## [17711]  2550  2550  2031  2031  2031  2031  3294  3294  3294  3294   816
## [17722]   816   816   816  2265  2265  2265  2265  1173  1173  1173  1173
## [17733]  4134  4134  4134  4134   429   429   429   429  3663  3663  3663
## [17744]  3663   273   273   273   273   957   957   957   957  1287  1287
## [17755]  1287  1287  1020  1020  1020  1020 13248 13248 13248 13248   810
## [17766]   810   810   810   462   462   462   462  1824  1824  1824  1824
## [17777]  3816  3816  3816  3816  1800  1800  1800  1800   954   954   954
## [17788]   954    78    78    78  1347  1347  1347  1347  2079  2079  2079
## [17799]  2079  1389  1389  1389  1389   699   699   699   699   729   729
## [17810]   729   729  5535  5535  5535  5535   690   690   690   690   999
## [17821]   999   999   999   999   999   999   999   927   927   927   927
## [17832]   666   666   666   666  1839  1839  1839  1839   324   324   324
## [17843]   324  1017  1017  1017  1017  1431  1431  1431  1431  2589  2589
## [17854]  2589  2589  1022  1022   159   327   534   159   327   534   258
## [17865]   258   258   258  1092  1092  1092  1092   342   342   342   342
## [17876]   360   360   360   360   780   780   780   780  2292  2292  2292
## [17887]  2292  1185  1185  1185  1185  3435  3435  3435  3435   807   807
## [17898]   807   807  1713  1713  1713  1713  1998  1998  1998  1998   930
## [17909]   930   930   930  3156  3156  3156  3156  1335  1335  1335  1335
## [17920]  2814  2814  2814  2814    68    68    68   972   972   972   972
## [17931]  1131  1131  1131  1131   993   993   993   993   699   699   699
## [17942]   699   442   442   442  2289  2289  2289  2289  4020  4020  4020
## [17953]  4020  1272  1272  1272    83    83    83   471   471   471   471
## [17964]   972   972   972   972  1710  1710  1710  1710  1715  1715   594
## [17975]  1119   594  1119  2976  2976  2976  2976  1032  1032  1032  1032
## [17986]   449   449   449   561   561   561   561   882   882   882   882
## [17997]   633   633   633   633   449   449   449   446   446   446  1152
## [18008]  1152  1152  1152   945   945   945   945   798   798   798   798
## [18019]  1314  1314  1314  1314   636   636   636   636   627   627   627
## [18030]   627  3339  3339  3339  3339  1611  1611  1611  1611   648   648
## [18041]   648   648  2604  2604  2604  2604   612   612   612   612   567
## [18052]   567   567   567   342   342   342   342    72    72    72  1920
## [18063]  1920  1920  1920  2103  2103  2103  2103  2337  2337  2337  2337
## [18074]  1488  1488  1488  1488  1347  1347  1347  1347  1422  1422  1422
## [18085]  1422  2004  2004  2004  2004  7578  7578  7578  7578   894   894
## [18096]   894   894  3423  3423  3423  3423  3912  3912  3912  3912  3126
## [18107]  3126  3126  3126 12447 12447 12447 12447    99    99    99  4407
## [18118]  4407  4407  4407  4584  4584  4584  4584   792   792   792   792
## [18129]  1305  1305  1305  1305  1200  1200  1200  1200  2106  2106  2106
## [18140]  2106  1338  1338  1338  1338  1854  1854  1854  1854   294   294
## [18151]   294   294  4536  4536  4536  4536  1536  1536  1536  1536  7986
## [18162]  7986  7986  7986  1083  1083  1083  1083  1995  1995  1995  1995
## [18173]  1230  1230  1230  1230  1833  1833  1833  1833   783   783   783
## [18184]   783   566   566   566   564     2   438   438   438   438  2238
## [18195]  2238  2238  2238  1102  1102   763  1102   763   990   603   112
## [18206]   160  1203  1203  1203  1203   471   471   471   471  3300  3300
## [18217]  3300  3300  1404  1404  1404  1404   270   270   270   270  1698
## [18228]  1698  1698  1698   738   738   738   738  6984  6984  6984  6984
## [18239]   966   966   966   966  1218  1218  1218  1218  1917  1917  1917
## [18250]  1917  1641  1641  1641  1641  1245  1245  1245  1245   873   873
## [18261]   873   873  2877  2877  2877  2877    91    91    91  3465  3465
## [18272]  3465  3465  2796  2796  2796  2796   357   357   357   357    83
## [18283]    83    83    85    85    85    74    74    74  3453  3453  3453
## [18294]  3453   942   942   942   942  1986  1986  1986  1986    72    72
## [18305]    72    95    95    95    90    90    90   270   270   270   270
## [18316]  5328  5328  5328  5328   918   918   918   918  2862  2862  2862
## [18327]  2862  1596  1596  1596  1596  1356  1356  1356  1356  1308  1308
## [18338]  1308  1308  1908  1908  1908  1908  1386  1386  1386  1386  2973
## [18349]  2973  2973  2973  1473  1473  1473  1473    81    81    81   405
## [18360]   405   405   405   972   972   972   972  1200  1200  1200  1200
## [18371]  2073  2073  2073  2073  7971  7971  7971  7971  1074  1074  1074
## [18382]  1074  4500  4500  4500  4500  1653  1653  1653  1653   918   918
## [18393]   918   918  1812  1812  1812  1812  1635  1635  1635  1635  1413
## [18404]  1413  1413  1413  1809  1809  1809  1809  1074  1074  1074  1074
## [18415]  3804  3804  3804  3804  3141  3141  3141  3141   693   693   693
## [18426]   693  1488  1488  1488  1488   705   705   705   705  1299  1299
## [18437]  1299  1299    85    85    85  1485  1485  1485  1485  1857  1857
## [18448]  1857  1857  1023  1023  1023  1023  2427  2427  2427  2427  2229
## [18459]  2229  2229  2229  1098  1098  1098  1098  3675  3675  3675  3675
## [18470]  1383  1383  1383  1383  1149  1149  1149  1149  3564  3564  3564
## [18481]  3564  1611  1611  1611  1611  4356  4356  4356  4356  5481  5481
## [18492]  5481  5481   438   438   438   438  4851  4851  4851  4851  2115
## [18503]  2115  2115  2115  2877  2877  2877  2877   597   597   597   597
## [18514]   984   984   984   984   390   390   390   348    42  1926  1926
## [18525]  1926  1926  1044  1044  1044  1044  1008  1008  1008  1008  1713
## [18536]  1713  1713  1713  1917  1917  1917  1917  1926  1926  1926  1926
## [18547]  2127  2127  2127  2127  1791  1791  1791  1791    68    68    68
## [18558]   546   546   546   546  5784  5784  5784  5784  1947  1947  1947
## [18569]  1947  1455  1455  1455  1455  3369  3369  3369  3369   753   753
## [18580]   753   753    69    69    69    68    68    68   894   894   894
## [18591]   894  3000  3000  3000  3000 15288 15288 15288 15288  3104  3104
## [18602]   778   778  3104   906   459   319  2198   861   861   861   861
## [18613]  5553  5553  5553  5553  1734  1734  1734  1734  3552  3552  3552
## [18624]  3552   753   753   753   753  1596  1596  1596  1596   489   489
## [18635]   489   489  1659  1659  1659  1659  2502  2502  2502  2502  1359
## [18646]  1359  1359  1359   978   978   978   978  5091  5091  5091  5091
## [18657]   555   555   555   555   954   954   954   954  1296  1296  1296
## [18668]  1296   672   672   672   672  2235  2235  2235  2235   445   445
## [18679]   445  3423  3423  3423  3423  1752  1752  1752  1752  2850  2850
## [18690]  2850  2850   564   564   564   564   804   804   804   804   432
## [18701]   432   432   432   687   687   687   687    82    82    82  2115
## [18712]  2115  2115  2115   123   123   123  2286  2286  2286  2286  1089
## [18723]  1089  1089  1089   324   324   324   324   420   420   420   420
## [18734]   468   468   468   468  1920  1920  1920  1920  1440  1440  1440
## [18745]  1440    70    70    70  1848  1848  1848  1848  2049  2049  2049
## [18756]  2049  1740  1740  1740  1740  2160  2160  2160  2160   834   834
## [18767]   834   834  1428  1428  1428  1428    73    73    73  2073  2073
## [18778]  2073  2073   132   132   132  2874  2874  2874  2874  2676  2676
## [18789]  2676  2676  3303  3303  3303  3303  1830  1830  1830  1830  3360
## [18800]  3360  3360  3360   867   867   867   867  6192  6192  6192  6192
## [18811]  3978  3978  3978  3978  3081  3081  3081  3081   645   645   645
## [18822]   645  1464  1464  1464  1464  2757  2757  2757  2757  2568  2568
## [18833]  1246  2568  1246  1587  1146   981   100    72    72    72    99
## [18844]    99    99   588   588   588   588   261   261   261   261  3783
## [18855]  3783  3783  3783  2316  2316  2316  2316   801   801   801   801
## [18866]   615   615   615   615   402   402   402   402    72    72    72
## [18877]   390   390   390   390   570   570   570   570   741   741   741
## [18888]   741   279   279   279   279  1839  1839  1839  1839   987   987
## [18899]   987   987  1059  1059  1059  1059  3411  3411  3411  3411    81
## [18910]    81    81  1440  1440  1440  1440  1211  1211  1208  1208  1211
## [18921]  1206  1083   125     5   498   498   498   498  1179  1179  1179
## [18932]  1179  3369  3369  3369  3369  1356  1356  1356  1356   795   795
## [18943]   795   795    72    72    72 22656 22656 22656 22656   771   771
## [18954]   771   771 13017 13017 13017 13017  2394  2394  2394  2394   116
## [18965]   116   116  2424  2424  2424  2424  5181  5181  5181  5181  1065
## [18976]  1065  1065  1065   600   600   600   600   831   831   831   831
## [18987]   945   945   945   945  1571  1571   667  1571   667   936   552
## [18998]   115   635   312   312   312   312  6030  6030  6030  6030  1530
## [19009]  1530  1530  1530  2838  2838  2838  2838   561   561   561   561
## [19020]  1320  1320  1320  1320  2853  2853  2853  2853   951   951   951
## [19031]   951  3078  3078  3078  3078  1191  1191  1191  1191   642   642
## [19042]   642   642  1266  1266  1266  1266    69    69    69  3405  3405
## [19053]  3405  3405  2451  2451  2451  2451  4824  4824  4824  4824  1233
## [19064]  1233  1233  1233  1356  1356  1356  1356  1635  1635  1635  1635
## [19075]    71    71    71   564   564   564   564   912   912   912   912
## [19086] 11322 11322 11322 11322   119   119   119   978   978   978   978
## [19097]  1041  1041  1041  1041  1797  1797  1797  1797   573   573   573
## [19108]   573  1788  1788  1788  1788   792   792   792   792  1827  1827
## [19119]  1827  1827   600   600   600   600  3036  3036  3036  3036   999
## [19130]   999   999   999   708   708   708   708   234   234   234   234
## [19141]  3711  3711  3711  3711  1446  1446  1446  1446  1362  1362  1362
## [19152]  1362  1452  1452  1452  1452  1824  1824  1824  1824   663   663
## [19163]   663   663  1095  1095  1095  1095  1683  1683  1683  1683  5745
## [19174]  5745  5745  5745   951   951   951   951  2802  2802  2802  2802
## [19185]  1158  1158  1158  1158   744   744   744   744 16686 16686 16686
## [19196] 16686  1968  1968  1968  1968  4716  4716  4716  4716  2019  2019
## [19207]  2019  2019  1716  1716  1716  1716  3789  3789  3789  3789  2505
## [19218]  2505  2505  2505  2718  2718  2718  2718  1779  1779  1779  1779
## [19229]  1023  1023  1023  1023  3879  3879  3879  3879   777   777   777
## [19240]   777  3597  3597  3597  3597  1089  1089  1089  1089   978   978
## [19251]   978   978  1809  1809  1809  1809  1167  1167  1167  1167  1122
## [19262]  1122  1122  1122  8248  8248  4515  8248  4515  4743  4371   144
## [19273]  3505    68    68    68  1758  1758  1758  1758   258   258   258
## [19284]   258 12807 12807 12807 12807  1677  1677  1677  1677  1695  1695
## [19295]  1695  1695  5457  5457  5457  5457  1077  1077  1077  1077  1866
## [19306]  1866  1866  1866  1884  1884  1884  1884    99    99    99   999
## [19317]   999   999   999  1506  1506  1506  1506  2328  2328  2328  2328
## [19328]  1851  1851  1851  1851  1278  1278  1278  1278   675   675   675
## [19339]   675  2994  2994  2994  2994   810   810   810   810   432   432
## [19350]   432   432  1083  1083  1083  1083    96    96    96    96  1467
## [19361]  1467  1467  1467    99    99    99  1353  1353  1353  1353  3129
## [19372]  3129  3129  3129    91    91    91  6333  6333  6333  6333  1185
## [19383]  1185  1185  1185  3225  3225  3225  3225   561   561   561   561
## [19394]   645   645   645   645  3024  3024  3024  3024  1431  1431  1431
## [19405]  1431  1377  1377  1377  1377  1911  1911  1911  1911  2136  2136
## [19416]  2136  2136  4626  4626  4626  4626    74    74    74  2715  2715
## [19427]  2715  2715  1221  1221  1221  1221  1872  1872  1872  1872  3553
## [19438]  3553  1779  3553  1779  1890  1758  1663    21    69    69    69
## [19449]   915   915   915   915  4824  4824  4824  4824  7269  7269  7269
## [19460]  7269   825   825   825   825    89    89    89   372   372   372
## [19471]   372   131   131   131  1902  1902  1902  1902  1014  1014  1014
## [19482]  1014   633   633   633   633  2877  2877  2877  2877  9741  9741
## [19493]  9741  9741  1950  1950  1064  1950  1064  1419   903   161   531
## [19504]  1470  1470  1470  1470   747   747   747   747  6357  6357  6357
## [19515]  6357   657   657   657   657  1023  1023  1023  1023  1638  1638
## [19526]  1638  1638  2301  2301  2301  2301  1146  1146  1146  1146   222
## [19537]   222   222   222  1236  1236  1236  1236  1908  1908  1908  1908
## [19548]   540   540   540   540  1200  1200  1200  1200  3018  3018  3018
## [19559]  3018    71    71    71  2454  2454  2454  2454  3039  3039  3039
## [19570]  3039   330   330   330   330  2976  2976  2976  2976   981   981
## [19581]   981   981   663   663   663   663  1761  1761  1761  1761  1950
## [19592]  1950  1950  1950  1689  1689  1689  1689  8868  8868  8868  8868
## [19603]  1995  1995  1995  1995  2091  2091  2091  2091    70    70    70
## [19614]    93    93    93  5004  5004  5004  5004  1725  1725  1725  1725
## [19625]  2781  2781  2781  2781  1560  1560  1560  1560   867   867   867
## [19636]   867  2196  2196  2196  2196   381   381   381   381   891   891
## [19647]   891   891  2109  2109  2109  2109  1833  1833  1833  1833  3138
## [19658]  3138  3138  3138  2271  2271  2271  2271  1713  1713  1713  1713
## [19669]   615   615   615   615   603   603   603   603   633   633   633
## [19680]   633   564   564   564   564   615   615   615   615  1941  1941
## [19691]  1941  1941   449   449   449   228   228   228   228   831   831
## [19702]   831   831  1560  1560  1560  1560  1245  1245  1245  1245  6186
## [19713]  6186  6186  6186  2268  2268  2268  2268   678   678   678   678
## [19724]  2316  2316  2316  2316  2697  2697  2697  2697   918   918   918
## [19735]   918   273   273   273   273  5367  5367  5367  5367  1215  1215
## [19746]  1215  1215  2190  2190  2190  2190  2541  2541  2541  2541   201
## [19757]   201   201   201  1257  1257  1257  1257   450   450   450   450
## [19768]   771   771   771   771   429   429   429   429   360   360   360
## [19779]   360    95    95    95   720   720   720   720   330   330   330
## [19790]   330  1479  1479  1479  1479   873   873   873   873  3243  3243
## [19801]  3243  3243  2496  2496  2496  2496    85    85    85   510   510
## [19812]   510   510  2061  2061  2061  2061   816   816   816   816  3438
## [19823]  3438  3438  3438  1893  1893  1893  1893   930   930   930   930
## [19834]  7578  7578  7578  7578   744   744   744   744  1023  1023  1023
## [19845]  1023  1344  1344  1344  1344  7989  7989  7989  7989    72    72
## [19856]    72  2922  2922  2922  2922   351   351   351   351    83    83
## [19867]    83  2973  2973  2973  2973   585   585   585   585   978   978
## [19878]   978   978  2106  2106  2106  2106  4233  4233  4233  4233    78
## [19889]    78    78   660   660   660   660  1356  1356  1356  1356   834
## [19900]   834   834   834   255   255   255   255   315   315   315   315
## [19911]  1377  1377  1377  1377  2292  2292  2292  2292   119   119   119
## [19922]   768   768   768   768  1866  1866  1866  1866  7977  7977  7977
## [19933]  7977   855   855   855   855  1170  1170  1170  1170  3849  3849
## [19944]  3849  3849  1449  1449  1449  1449    81    81    81   103   103
## [19955]   103   354   354   354   354  1251  1251  1251  1251   843   843
## [19966]   843   843  2616  2616  2616  2616  1980  1980  1980  1980   339
## [19977]   339   339   339   444   444   444   444   747   747   747   747
## [19988]  1125  1125  1125  1125  1980  1980  1980  1980    81    81    81
## [19999]  1455  1455  1455  1455   534   534   534   534    99    99    99
## [20010]  2994  2994  2994  2994  1455  1455  1455  1455   816   816   816
## [20021]   816   954   954   954   954  1242  1242  1242  1242  1812  1812
## [20032]  1812  1812  2412  2412  2412  2412  1773  1773  1773  1773  1749
## [20043]  1749  1749  1749   768   768   768   768   716   716   300   414
## [20054]   300   414  2037  2037  2037  2037  4029  4029  4029  4029   102
## [20065]   102   102   486   486   486   486    90    90    90  2991  2991
## [20076]  2991  2991  2343  2343  2343  2343    68    68    68   285   285
## [20087]   285   285  1008  1008  1008  1008  2526  2526  2526  2526  1968
## [20098]  1968  1968  1968  2208  2208  2208  2208   459   459   459   459
## [20109]  1173  1173  1173  1173  1845  1845  1845  1845    78    78    78
## [20120]  4983  4983  4983  4983  1236  1236  1236  1236  1149  1149  1149
## [20131]  1149   795   795   795   795   741   741   741   741   918   918
## [20142]   918   918  2952  2952  2952  2952  2445  2445  2445  2445  2667
## [20153]  2667  2667  2667   285   285   285  4878  4878  4878  4878  1836
## [20164]  1836  1836  1836  1434  1434  1434  1434  1782  1782  1782  1782
## [20175]   480   480   480   480  2223  2223  2223  2223  5532  5532  5532
## [20186]  5532   894   894   894   894  9837  9837  9837  9837   339   339
## [20197]   339   339  1704  1704  1704  1704   840   840   840   840   255
## [20208]   255   255   255    81    81    81  3447  3447  3447  3447  1200
## [20219]  1200  1200  1200  2217  2217  2217  2217   498   498   498   498
## [20230]   969   969   969   969  3627  3627  3627  3627    76    76    76
## [20241]  1476  1476  1476  1476   438   438   438   438   891   891   891
## [20252]   891  3336  3336  3336  3336  1824  1824  1824  1824   567   567
## [20263]   567   567  2445  2445  2445  2445  2826  2826  2826  2826  2103
## [20274]  2103  2103  2103   570   570   570   570  1545  1545  1545  1545
## [20285]  7092  7092  7092  7092  3867  3867  3867  3867  2535  2535  2535
## [20296]  2535  3057  3057  3057  3057  3639  3639  3639  3639  1449  1449
## [20307]  1449  1449    74    74    74  1995  1995  1995  1995  3315  3315
## [20318]  3315  3315  2175  2175  2175  2175   222   222   222   222  4134
## [20329]  4134  4134  4134   735   735   735   735   375   375   375   375
## [20340]   849   849   849   849  5076  5076  5076  5076  2196  2196  2196
## [20351]  2196  1278  1278  1278  1278   741   741   741   741   963   963
## [20362]   963   963   342   342   342   342  4449  4449  4449  4449  2094
## [20373]  2094  2094  2094  3441  3441  3441  3441   691   691    78   239
## [20384]   370    78   239   370  2508  2508  2508  2508  2871  2871  2871
## [20395]  2871  1230  1230  1230  1230    91    91    91  1110  1110  1110
## [20406]  1110  1512  1512  1512  1512  2352  2352  2352  2352  3327  3327
## [20417]  3327  3327   903   903   903   903  1095  1095  1095  1095  2088
## [20428]  2088  2088  2088   408   408   408   408   798   798   798   798
## [20439]   104   104   104   552   552   552   552   131   131   131   840
## [20450]   840   840   840  1620  1620  1620  1620  2940  2940  2940  2940
## [20461]  1512  1512  1512  1512   477   477   477   477  7842  7842  7842
## [20472]  7842  1629  1629  1629  1629   960   960   960   960   894   894
## [20483]   894   894  3273  3273  3273  3273  2064  2064  2064  2064   936
## [20494]   936   936   936   300   300   300   300  3678  3678  3678  3678
## [20505]    91    91    91  1236  1236  1236  1236    78    78    78   954
## [20516]   954   954   954  1383  1383  1383  1383   897   897   897   897
## [20527]   534   534   534   534   972   972   972   972    90    90    90
## [20538]  3114  3114  3114  3114  1380  1380  1380  1380  1851  1851  1851
## [20549]  1851   531   531   531   531   525   525   525   525  1401  1401
## [20560]  1401  1401  1890  1890  1890  1890  2979  2979  2979  2979  1422
## [20571]  1422  1422  1422  1146  1146  1146  1146  2268  2268  2268  2268
## [20582]   663   663   663   663    86    86    86  1467  1467  1467  1467
## [20593]  2925  2925  2925  2925   966   966   966   966   345   345   345
## [20604]   345   837   837   837   837   984   984   984   984  2100  2100
## [20615]  2100  2100  1626  1626  1626  1626   276   276   276   276   267
## [20626]   267   267   267  2910  2910  2910  2910  3135  3135  3135  3135
## [20637]    70    70    70  2307  2307  2307  2307  2043  2043  2043  2043
## [20648]   786   786   786   786  2124  2124  2124  2124    70    70    70
## [20659]    73    73    73  2304  2304  2304  2304  1074  1074  1074  1074
## [20670]   116   116   116    85    85    85    74    74    74   975   975
## [20681]   975   975  1152  1152  1152  1152   455   455   455  1515  1515
## [20692]  1515  1515  3954  3954  3954  3954  3126  3126  3126  3126   609
## [20703]   609   609   609  2196  2196  2196  2196  1284  1284  1284  1284
## [20714]   849   849   849   849    70    70    70  3590  3590  3469  3590
## [20725]  3469  3468  3228   241   122    92    92    92  1098  1098  1098
## [20736]  1098  3633  3633  3633  3633   366   366   366   366   579   579
## [20747]   579   579   876   876   876   876  1485  1485  1485  1485  4344
## [20758]  4344  4344  4344    82    82    82    85    85    85  1677  1677
## [20769]  1677  1677  2979  2979  2979  2979    66    66    66  1956  1956
## [20780]  1956  1956  2778  2778  2778  2778  2544  2544  2544  2544    70
## [20791]    70    70  4347  4347  4347  4347  1413  1413  1413  1413  2022
## [20802]  2022  2022  2022    70    70    70  1119  1119  1119  1119  1911
## [20813]  1911  1911  1911  3831  3831  3831  3831   582   582   582   582
## [20824]  1515  1515  1515  1515  1560  1560  1560  1560  1296  1296  1296
## [20835]  1296  5583  5583  5583  5583  1323  1323  1323  1323  3099  3099
## [20846]  3099  3099   444   444   444   444   891   891   891   891  2337
## [20857]  2337  2337  2337  1446  1446  1446  1446  6906  6906  6906  6906
## [20868]  1974  1974  1974  1974   684   684   684   684  2124  2124  2124
## [20879]  2124   717   717   717   717  1560  1560  1560  1560  1059  1059
## [20890]  1059  1059   930   930   930   930  5196  5196  5196  5196  1437
## [20901]  1437  1437  1437  1656  1656  1656  1656  1200  1200  1200  1200
## [20912]    69    69    69  2700  2700  2700  2700  1659  1659  1659  1659
## [20923]  6156  6156  6156  6156  5745  5745  5745  5745  3942  3942  3942
## [20934]  3942  1347  1347  1347  1347  1560  1560  1560  1560  4074  4074
## [20945]  4074  4074    78    78    78  3114  3114  3114  3114  1339  1339
## [20956]   590  1339   590   930   450   140   409  1740  1740  1740  1740
## [20967]  3279  3279  3279  3279  3399  3399  3399  3399  2760  2760  2760
## [20978]  2760  1464  1464  1464  1464  1227  1227  1227  1227  2865  2865
## [20989]  2865  2865   999   999   999   999  1506  1506  1506  1506  1059
## [21000]  1059  1059  1059   537   537   537   537  1500  1500  1500  1500
## [21011]  1923  1923  1923  1923  2574  2574  2574  2574  1314  1314  1314
## [21022]  1314   663   663   663   663  1689  1689  1689  1689  4416  4416
## [21033]  4416  4416   915   915   915   915   615   615   615   615   996
## [21044]   996   996   996  2499  2499  2499  2499  2166  2166  2166  2166
## [21055]   129   129   129  3548  1201  3548  3548  1201  2559   531   989
## [21066]   670  2790  2790  2790  2790   426   426   426   426  3921  3921
## [21077]  3921  3921   104   104   104  4206  4206  4206  4206  1503  1503
## [21088]  1503  1503  2805  2805  2805  2805  1527  1527  1527  1527  5925
## [21099]  5925  5925  5925  1734  1734  1734  1734  2031  2031  2031  2031
## [21110]  1410  1410  1410  1410  1824  1824  1824  1824  2040  2040  2040
## [21121]  2040  1497  1497  1497  1497  1593  1593  1593  1593  2106  2106
## [21132]  2106  2106   843   843   843   843  1575  1575  1575  1575  4077
## [21143]  4077  4077  4077  2115  2115  2115  2115   735   735   735   735
## [21154]  1242  1242  1242  1242  1893  1893  1893  1893  1299  1299  1299
## [21165]  1299   951   951   951   951   411   411   411   411  1419  1419
## [21176]  1419  1419   417   417   417   417   768   768   768   768   104
## [21187]   104   104   516   516   516   516   921   921   921   921  1137
## [21198]  1137  1137  1137  2154  2154  2154  2154   981   981   981   981
## [21209]  1086  1086  1086  1086   990   990   990   990  2790  2790  2790
## [21220]  2790    85    85    85    70    70    70  1839  1839  1839  1839
## [21231]  1368  1368  1368  1368  2181  2181  2181  2181   459   459   459
## [21242]   459  1002  1002  1002  1002  2022  2022  2022  2022   942   942
## [21253]   942   942  2613  2613  2613  2613    90    90    90  1047  1047
## [21264]  1047  1047  1077  1077  1077  1077  1530  1530  1530  1530   339
## [21275]   339   339   339  1476  1476  1476  1476  1119  1119  1119  1119
## [21286]   891   891   891   891   738   738   738   738  2217  2217  2217
## [21297]  2217  1980  1980  1980  1980  2004  2004  2004  2004  2676  2676
## [21308]  2676  2676   927   927   927   927  4731  4731  4731  4731  2658
## [21319]  2658  2658  2658   321   321   321   321  1611  1611  1611  1611
## [21330]  5214  5214  5214  5214   777   777   777   777 12354 12354 12354
## [21341] 12354  1602  1602  1602  1602   120   120   120   834   834   834
## [21352]   834  1059  1059  1059  1059   690   690   690   690  6018  6018
## [21363]  6018  6018  3765  3765  3765  3765  2100  2100  2100  2100  6027
## [21374]  6027  6027  6027   345   345   345   345  1089  1089  1089  1089
## [21385]  1059  1059  1059  1059    84    84    84   954   954   954   954
## [21396]  1863  1863  1863  1863  2781  2781  2781  2781   942   942   942
## [21407]   942  5685  5685  5685  5685  1071  1071  1071  1071  2103  2103
## [21418]  2103  2103  2595  2595  2595  2595  1326  1326  1326  1326   951
## [21429]   951   951   951    72    72    72   684   684   684   684  2148
## [21440]  2148  2148  2148    90    90    90   119   119   119  1167  1167
## [21451]  1167  1167  2130  2130  2130  2130   810   810   810   810   234
## [21462]   234   234   234  1413  1413  1413  1413  2175  2175  2175  2175
## [21473]  2172  2172  2172  2172  1356  1356  1356  1356   351   351   351
## [21484]   351  2283  2283  2283  2283   351   351   351   351   780   780
## [21495]   780   780   606   606   606   606    94    94    94  1452  1452
## [21506]  1452  1452   131   131   131   441   441   441   441  1962  1962
## [21517]  1962  1962  1491  1491  1491  1491    99    99    99   918   918
## [21528]   918   918    92    92    92  8447  1186  8447  8447  1186  1143
## [21539]  1404    43  7043  1878  1878  1878  1878   351   351   351   351
## [21550]   423   423   423   423   588   588   588   588  1587  1587  1587
## [21561]  1587  2334  2334  2334  2334  1525  1525  1525   330   330   330
## [21572]   330   840   840   840   840    73    73    73  1392  1392  1392
## [21583]  1392  2313  2313  2313  2313   381   381   381   381  2139  2139
## [21594]  2139  2139  2631  2631  2631  2631  1995  1995  1995  1995   804
## [21605]   804   804   804   459   459   459   459   846   846   846   846
## [21616]  2232  2232  2232  2232  3000  3000  3000  3000  1233  1233  1233
## [21627]  1233  2412  2412  2412  2412  5049  5049  5049  5049   822   822
## [21638]   822   822  2211  2211  2211  2211   639   639   639   639   510
## [21649]   510   510   510  1989  1989  1989  1989  4854  4854  4854  4854
## [21660]  1320  1320  1320  1320   405   405   405   405  1824  1824  1824
## [21671]  1824  2547  2547  2547  2547    83    83    83  3042  3042  3042
## [21682]  3042  4479  4479  4479  4479  2580  2580  2580  2580   504   504
## [21693]   504   504  1200  1200  1200  1200  1062  1062  1062  1062  1230
## [21704]  1230  1230  1230   789   789   789   789  5898  5898  5898  5898
## [21715]  2898  2898  2898  2898  1380  1380  1380  1380  1323  1323  1323
## [21726]  1323  1563  1563  1563  1563  5526  5526  5526  5526   444   444
## [21737]   444   444   327   327   327   327  2580  2580  2580  2580  3315
## [21748]  3315  3315  3315   963   963   963   963  1698  1698  1698  1698
## [21759]  4476  4476  4476  4476   999   999   999   999  1305  1305  1305
## [21770]  1305  2256  2256  2256  2256  3759  3759  3759  3759   780   780
## [21781]   780   780   446   446   446   336   336   336   336    78    78
## [21792]    78  1890  1890  1890  1890   864   864   864   864  1122  1122
## [21803]  1122  1122 14718 14718 14718 14718  1542  1542  1542  1542  1392
## [21814]  1392  1392  1392  1251  1251  1251  1251  5829  5829  5829  5829
## [21825] 13308 13308 13308 13308  1584  1584  1584  1584  1992  1992  1992
## [21836]  1992  3660  3660  3660  3660  1746  1746  1746  1746  1545  1545
## [21847]  1545  1545  3021  3021  3021  3021  4140  4140  4140  4140   405
## [21858]   405   405   405  2106  2106  2106  2106  1923  1923  1923  1923
## [21869]  1794  1794  1794  1794   446   446   446  1224  1224  1224  1224
## [21880]  3387  3387  3387  3387   852   852   852   852  2778  2778  2778
## [21891]  2778  1627   566  1627  1627   566   435   675   131   952  2520
## [21902]  2520  2520  2520   498   498   498   498  1476  1476  1476  1476
## [21913]   591   591   591   591  1617  1617  1617  1617   594   594   594
## [21924]   594  1398  1398  1398  1398  2565  2565  2565  2565  1731  1731
## [21935]  1731  1731  1047  1047  1047  1047   387   387   387   387  3156
## [21946]  3156  3156  3156  2121  2121  2121  2121   339   339   339   339
## [21957]  1026  1026  1026  1026  1074  1074  1074  1074  2751  2751  2751
## [21968]  2751 12816 12816 12816 12816  3165  3165  3165  3165  2394  2394
## [21979]  2394  2394   201   201   201   201  1171  1111  1171  1171  1111
## [21990]  1134   741    37   370  2118  2118  2118  2118  2571  2571  2571
## [22001]  2571  3441  3441  3441  3441   570   570   570   570  1050  1050
## [22012]  1050  1050   927   927   927   927  1482  1482  1482  1482  1077
## [22023]  1077  1077  1077  8811  8811  8811  8811  5634  5634  5634  5634
## [22034]  9138  9138  9138  9138  2844  2844  2844  2844   104   104   104
## [22045]  1442  1442   968  1442   968  1065   933    35   377  2886  2886
## [22056]  2886  2886  2037  2037  2037  2037    66    66    66  7125  7125
## [22067]  7125  7125  1575  1575  1575  1575  1119  1119  1119  1119   131
## [22078]   131   131    91    91    91   909   909   909   909  1272  1272
## [22089]  1272  1272  3012  3012  3012  3012   564   564   564   564   504
## [22100]   504   504   504  2334  2334  2334  2334   711   711   711   711
## [22111]  1569  1569  1569  1569  2718  2718  2718  2718  6345  6345  6345
## [22122]  6345  5058  5058  5058  5058   303   303   303   303  2544  2544
## [22133]  2544  2544    73    73    73  2085  2085  2085  2085  1038  1038
## [22144]  1038  1038  4497  4497  4497  4497  2136  2136  2136  2136  2790
## [22155]  2790  2790  2790  1155  1155  1155  1155  2859  2859  2859  2859
## [22166]   951   951   951   951  1905  1905  1905  1905   369   369   369
## [22177]   369  2457  2457  2457  2457   606   606   606   606  3666  3666
## [22188]  3666  3666   807   807   807   807  2391  2391  2391  2391   534
## [22199]   534   534   534  1041  1041  1041  1041  2190  2190  2190  2190
## [22210]  2430  2430  2430  2430  1008  1008  1008  1008   459   459   459
## [22221]   459   573   573   573   573  2445  2445  2445  2445  1092  1092
## [22232]  1092  1092   417   417   417   417    90    90    90   702   702
## [22243]   702   702    68    68    68    73    73    73   570   570   570
## [22254]   570  1185  1185  1185  1185  2919  2919  2919  2919  3441  3441
## [22265]  3441  3441  1494  1494  1494  1494    69    69    69  1617  1617
## [22276]  1617  1617  1476  1476  1476  1476  5874  5874  5874  5874  1341
## [22287]  1341  1341  1341  2396   829  2396  2396   829   537  2367   292
## [22298]    29  1086  1086  1086  1086  2088  2088  2088  2088  2181  2181
## [22309]  2181  2181  2550  2550  2550  2550  1557  1557  1557  1557  1779
## [22320]  1779  1779  1779   990   990   990   990   711   711   711   711
## [22331]   942   942   942   942  1497  1497  1497  1497   828   828   828
## [22342]   828  2094  2094  2094  2094  3381  3381  3381  3381    78    78
## [22353]    78  2253  2253  2253  2253   630   630   630   630    74    74
## [22364]    74  6039  6039  6039  6039   876   876   876   876    99    99
## [22375]    99  6123  6123  6123  6123   321   321   321   321  4986  4986
## [22386]  4986  4986   999   999   999   999  5268  5268  5268  5268  3936
## [22397]  3936  3936  3936   576   576   576   576   582   582   582   582
## [22408]  1599  1599  1599  1599  5319  5319  5319  5319  1116  1116  1116
## [22419]  1116  7662  7662  7662  7662  2229  2229  2229  2229   903   903
## [22430]   903   903  2118  2118  2118  2118  1350  1350  1350  1350  1140
## [22441]  1140  1140  1140   492   492   492   492  2603  2603  2603  2499
## [22452]   104  2115  2115  2115  2115  7689  7689  7689  7689   448   448
## [22463]   448   861   861   861   861  4311  4311  4311  4311  1164  1164
## [22474]  1164  1164   783   783   783   783  3195  3195  3195  3195  1614
## [22485]  1614  1614  1614  2475  2475  2475  2475   879   879   879   879
## [22496]   849   849   849   849   897   897   897   897  2190  2190  2190
## [22507]  2190  3186  3186  3186  3186  1332  1332  1332  1332  2598  2598
## [22518]  2598  2598  1617  1617  1617  1617   864   864   864   864  3987
## [22529]  3987  3987  3987   957   957   957   957   579   579   579   579
## [22540]   873   873   873   873   657   657   657   657   675   675   675
## [22551]   675  1365  1365  1365  1365  2274  2274  2274  2274  2226  2226
## [22562]  2226  2226    81    81    81  1215  1215  1215  1215  4542  4542
## [22573]  4542  4542    70    70    70   753   753   753   753   993   993
## [22584]   993   993  1242  1242  1242  1242   765   765   765   765  1929
## [22595]  1929  1929  1929  1437  1437  1437  1437   309   309   309   309
## [22606]  1230  1230  1230  1230   780   780   780   780  1992  1992  1992
## [22617]  1992  2685  2685  2685  2685   693   693   693   693  1980  1980
## [22628]  1980  1980  3048  3048  3048  3048  1545  1545  1545  1545   567
## [22639]   567   567   567  1083  1083  1083  1083   549   549   549   549
## [22650]   600   600   600   600  2061  2061  2061  2061  1641  1641  1641
## [22661]  1641   705   705   705   705    92    92    92  2970  2970  2970
## [22672]  2970    90    90    90    76    76    76  1569  1569  1569  1569
## [22683]  1137  1137  1137  1137   798   798   798   798  1131  1131  1131
## [22694]  1131   591   591   591   591  1812  1812  1812  1812  1191  1191
## [22705]  1191  1191   870   870   870   870  2979  2979  2979  2979  2250
## [22716]  2250  2250  2250   489   489   489   489    68    68    68  2958
## [22727]  2958  2958  2958 11436 11436 11436 11436 10023 10023 10023 10023
## [22738]   119   119   119  1632  1632  1632  1632  1002  1002  1002  1002
## [22749]  1743  1743  1743  1743   603   603   603   603    78    78    78
## [22760]  1164  1164  1164  1164   462   462   462   462   912   912   912
## [22771]   912   549   549   549   549  2628  2628  2628  2628    73    73
## [22782]    73   711   711   711   711   690   690   690   690  2994  2994
## [22793]  2994  2994  3033  3033  3033  3033   702   702   702   702  1887
## [22804]  1887  1887  1887  1302  1302  1302  1302  1233  1233  1233  1233
## [22815]  1578  1578  1578  1578   408   408   408   408   459   459   459
## [22826]   459   579   579   579   579  3771  3771  3771  3771  1059  1059
## [22837]  1059  1059  1203  1203  1203  1203   455   455   455  3225  3225
## [22848]  3225  3225   555   555   555   555  1652  1652  1652  1650     2
## [22859]   408   408   408   408  1452  1452  1452  1452  2550  2550  2550
## [22870]  2550  1608  1608  1608  1608  2913  2913  2913  2913   384   384
## [22881]   384   384  1485  1485  1485  1485  1503  1503  1503  1503  1125
## [22892]  1125  1125  1125   879   879   879   879   873   873   873   873
## [22903]   435   435   435   435  2745  2745  2745  2745   432   432   432
## [22914]   432  2076  2076  2076  2076  1794  1794  1794  1794  2469  2469
## [22925]  2469  2469  1689  1689  1689  1689   840   840   840   840  1482
## [22936]  1482  1482  1482  1161  1161  1161  1161   651   651   651   651
## [22947]  2040  2040  2040  2040  1326  1326  1326  1326  1023  1023  1023
## [22958]  1023   939   939   939   939  2286  2286  2286  2286  2526  2526
## [22969]  2526  2526   984   984   984   984   720   720   720   720  1110
## [22980]  1110  1110  1110   699   699   699   699 19875 19875 19875 19875
## [22991]   996   996   996   996    89    89    89  1572  1572  1572  1572
## [23002]   339   339   339   339   609   609   609   609  2112  2112  2112
## [23013]  2112  2337  2337  2337  2337  4338  4338  4338  4338  1185  1185
## [23024]  1185  1185  1722  1722  1722  1722   456   456   456   456  1608
## [23035]  1608  1608  1608  8469  8469  8469  8469  3918  3918  3918  3918
## [23046]   543   543   543   543  1170  1170  1170  1170   390   390   390
## [23057]   390  4746  4746  4746  4746   442   442   442  1161  1161  1161
## [23068]  1161  6132  6132  6132  6132  1053  1053  1053  1053   921   921
## [23079]   921   921  1368  1368  1368  1368   837   837   837   837  4203
## [23090]  4203  4203  4203   903   903   903   903  1179  1179  1179  1179
## [23101]  1572  1572  1572  1572   449   449   449  1103   793  1103  1103
## [23112]   793  1056   771    47    22  1482  1482  1482  1482  1818  1818
## [23123]  1818  1818  4437  4437  4437  4437   345   345   345   345   528
## [23134]   528   528   528  1131  1131  1131  1131  4551  4551  4551  4551
## [23145]  2277  2277  2277  2277    95    95    95    91    91    91   453
## [23156]   453   453   453   561   561   561   561  2439  2439  2439  2439
## [23167]   891   891   891   891  3762  3762  3762  3762  4671  4671  4671
## [23178]  4671   399   399   399   399  2391  2391  2391  2391   963   963
## [23189]   963   963   807   807   807   807  1173  1173  1173  1173   114
## [23200]   114   114  1014  1014  1014  1014  1764  1764  1764  1764   846
## [23211]   846   846   846  1983  1983  1983  1983  6126  6126  6126  6126
## [23222]    73    73    73  3921  3921  3921  3921  1764  1764  1764  1764
## [23233]  6117  6117  6117  6117    99    99    99  3483  3483  3483  3483
## [23244]  2184  2184  2184  2184  1698  1698  1698  1698   669   669   669
## [23255]   669  4185  4185  4185  4185  2445  2445  2445  2445   951   951
## [23266]   951   951  1770  1770  1770  1770   867   867   867   867   103
## [23277]   103   103  1089  1089  1089  1089   663   663   663   663   663
## [23288]   663   663   663  1353  1353  1353  1353   957   957   957   957
## [23299]  1593  1593  1593  1593    90    90    90  1398  1398  1398  1398
## [23310]   102   102   102  2721  2721  2721  2721  3765  3765  3765  3765
## [23321]   354   354   354   354   510   510   510   510   648   648   648
## [23332]   648  2796  2796  2796  2796   627   627   627   627  3840  3840
## [23343]  3840  3840  3198  3198  3198  3198  1140  1140  1140  1140   507
## [23354]   507   507   507  3906  3906  3906  3906    72    72    72  1581
## [23365]  1581  1581  1581   104   104   104   116   116   116   678   678
## [23376]   678   678   441   441   441   441   396   396   396   396   981
## [23387]   981   981   981   567   567   567   567   960   960   960   960
## [23398]   444   444   444   444  1317  1317  1317  1317   576   576   576
## [23409]   576  2406  2406  2406  2406  1191  1191  1191  1191  1233  1233
## [23420]  1233  1233  5367  5367  5367  5367  2979  2979  2979  2979  3699
## [23431]  3699  3699  3699    86    86    86   663   663   663   663  2376
## [23442]  2376  2376  2376   324   324   324   324  4110  4110  4110  4110
## [23453]  2799  2799  2799  2799  1653  1653  1653  1653  1440  1440  1440
## [23464]  1440   495   495   495   495   519   519   519   519  1461  1461
## [23475]  1461  1461   816   816   816   816  2310  2310  2310  2310  1701
## [23486]  1701  1701  1701  2688  2688  2688  2688   717   717   717   717
## [23497]  1968  1968  1968  1968  1902  1902  1902  1902  1107  1107  1107
## [23508]  1107   330   330   330   330    70    70    70  1158  1158  1158
## [23519]  1158    80    80    80  3321  3321  3321  3321    81    81    81
## [23530]  1899  1899  1899  1899  3165  3165  3165  3165   918   918   918
## [23541]   918  4230  4230  4230  4230   414   414   414   414  2538  2538
## [23552]  2538  2538   104   104   104  2439  2439  2439  2439  1035  1035
## [23563]  1035  1035  2016  2016  2016  2016  1274  1274   381   405   486
## [23574]   381   405   486   855   855   855   855  8625  8625  8625  8625
## [23585]  2406  2406  2406  2406  1848  1848  1848  1848    65    65    65
## [23596]    93    93    93 16830 16830 16830 16830  2724  2724  2724  2724
## [23607]  1635  1635  1635  1635   103   103   103   825   825   825   825
## [23618]   855   855   855   855   891   891   891   891  5430  5430  5430
## [23629]  5430  2517  2517  2517  2517    99    99    99  2784  2784  2784
## [23640]  2784  1236  1236  1236  1236  1206  1206  1206  1206  4044  4044
## [23651]  4044  4044  1890  1890  1890  1890   240   240   240   240  1239
## [23662]  1239  1239  1239  1209  1209  1209  1209  2154  2154  2154  2154
## [23673]  1251  1251  1251  1251  1776  1776  1776  1776    81    81    81
## [23684]  1686  1686  1686  1686   447   447   447   447  1641  1641  1641
## [23695]  1641  2850  2850  2850  2850  3054  3054  3054  3054   318   318
## [23706]   318   318   116   116   116  2757  2757  2757  2757  1518  1518
## [23717]  1518  1518    74    74    74   855   855   855   855   804   804
## [23728]   804   804  2583  2583  2583  2583   459   459   459   459   993
## [23739]   993   993   993   348   348   348   348  1326  1326  1326  1326
## [23750]  2001  2001  2001  2001   831   831   831   831  2235  2235  2235
## [23761]  2235   906   906   906   906   192   192   192   192  4278  4278
## [23772]  4278  4278  1632  1632  1632  1632    83    83    83  1296  1296
## [23783]  1296  1296  3096  3096  3096  3096  2595  2595  2595  2595   618
## [23794]   618   618   618  1380  1380  1380  1380   936   936   936   936
## [23805]    89    89    89  2513  2513  1512   999  1512   999  1395  1395
## [23816]  1395  1395   429   429   429   429   519   519   519   519  8088
## [23827]  8088  8088  8088  1839  1839  1839  1839   528   528   528   528
## [23838]   585   585   585   585    83    83    83  3051  3051  3051  3051
## [23849]  1437  1437  1437  1437  1458  1458  1458  1458   663   663   663
## [23860]   663  4383  4383  4383  4383  7905  7905  7905  7905   897   897
## [23871]   897   897  3573  3573  3573  3573  1395  1395  1395  1395  1335
## [23882]  1335  1335  1335   840   840   840   840   213   213   213   213
## [23893]  2340  2340  2340  2340  1602  1602  1602  1602   375   375   375
## [23904]   375  1146  1146  1146  1146   492   492   492   492  1785  1785
## [23915]  1785  1785  6471  6471  6471  6471  4056  4056  4056  4056  2406
## [23926]  2406  2406  2406  3876  3876  3876  3876  1512  1512  1512  1512
## [23937]  2319  2319  2319  2319   387   387   387   387  4059  3301  4059
## [23948]  3301  4059  3063  3375   238   684  1356  1356  1356  1356  1095
## [23959]  1095  1095  1095   744   744   744   744  4896  4896  4896  4896
## [23970]  2067  2067  2067  2067  6477  6477  6477  6477  4413  4413  4413
## [23981]  4413  3144  3144  3144  3144  1882  1858  1882  1882  1858  1872
## [23992]  1422    10   436  1209  1209  1209  1209    89    89    89  2151
## [24003]  2151  2151  2151  2019  2019  2019  2019  4431  4431  4431  4431
## [24014]  3705  3705  3705  3705  5034  5034  5034  5034  4944  4944  4944
## [24025]  4944  2559  2559  2559  2559  1230  1230  1230  1230   402   402
## [24036]   402   402    95    95    95   780   780   780   780    99    99
## [24047]    99  4038  4038  4038  4038   684   684   684   684  3405  3405
## [24058]  3405  3405   453   453   453   453   993   993   993   993  2115
## [24069]  2115  2115  2115  4308  4308  4308  4308  1299  1299  1299  1299
## [24080]  1095  1095  1095  1095  2841  2841  2841  2841   894   894   894
## [24091]   894    68    68    68   486   486   486   486  3189  3189  3189
## [24102]  3189  2130  2130  2130  2130  1458  1458  1458  1458  1185  1185
## [24113]  1185  1185   750   750   750   750   732   732   732   732  1581
## [24124]  1581  1581  1581  5844  5844  5844  5844   900   900   900   900
## [24135]  1449  1449  1449  1449  1779  1779  1779  1779  1806  1806  1806
## [24146]  1806   855   855   855   855  1164  1164  1164  1164  1320  1320
## [24157]  1320  1320  2928  2928  2928  2928  1110  1110  1110  1110    74
## [24168]    74    74  1974  1974  1974  1974  1140  1140  1140  1140  1794
## [24179]  1794  1794  1794  1317  1317  1317  1317  1215  1215  1215  1215
## [24190]  2856  2856  2856  2856  1497  1497  1497  1497  2457  2457  2457
## [24201]  2457   600   600   600   600  2190  2190  2190  2190  1644  1644
## [24212]  1644  1644   882   882   882   882   447   447   447   447  1704
## [24223]  1704  1704  1704  2437  2437  2345  2437  2345  2379  2268    58
## [24234]    77    85    85    85   213   213   213   213    90    90    90
## [24245]   867   867   867   867  4689  4689  4689  4689    89    89    89
## [24256]   906   906   906   906  2043  2043  2043  2043    70    70    70
## [24267]   807   807   807   807    99    99    99  1179  1179  1179  1179
## [24278]   702   702   702   702    83    83    83 12375 12375 12375 12375
## [24289]   573   573   573   573  2688  2688  2688  2688  3441  3441  3441
## [24300]  3441  2001  2001  2001  2001  4371  4371  4371  4371   405   405
## [24311]   405   405  4023  4023  4023  4023  1587  1587  1587  1587  1670
## [24322]  1670   717   951   717   951   663   663   663   663  8301  8301
## [24333]  8301  8301  9828  9828  9828  9828   927   927   927   927  1320
## [24344]  1320  1320  1320  4167  4167  4167  4167   579   579   579   579
## [24355]   513   513   513   513  1167  1167  1167  1167   318   318   318
## [24366]   318   993   993   993   993  2106  2106  2106  2106   690   690
## [24377]   690  1995  1995  1995  1995  1065  1065  1065  1065  1968  1968
## [24388]  1968  1968  1299  1299  1299  1299  1815  1815  1815  1815  1749
## [24399]  1749  1749  1749  1914  1914  1914  1914   996   996   996   996
## [24410]  2223  2223  2223  2223    78    78    78  3627  3627  3627  3627
## [24421]  4467  4467  4467  4467   579   579   579   579  2121  2121  2121
## [24432]  2121  2523  2523  2523  2523   918   918   918   918   132   132
## [24443]   132   369   369   369   369  1065  1065  1065  1065  1254  1254
## [24454]  1254  1254  1356  1356  1356  1356    69    69    69  3885  3885
## [24465]  3885  3885  2085  2085  2085  2085  1908  1908  1908  1908  1200
## [24476]  1200  1200  1200  1176  1176  1176  1176  9543  9543  9543  9543
## [24487]  1560  1560  1560  1560  1671  1671  1671  1671   999   999   999
## [24498]   999  2355  2355  2355  2355   858   858   858   858  1806  1806
## [24509]  1806  1806   549   549   549   549  1113  1113  1113  1113   522
## [24520]   522   522   522  1329  1329  1329  1329  2790  2790  2790  2790
## [24531]    70    70    70  1668  1668  1668  1668  4356  4356  4356  4356
## [24542]   116   116   116  1869  1869  1869  1869  2091  2091  2091  2091
## [24553]  3276  3276  3276  3276  1356  1356  1356  1356   969   969   969
## [24564]   969  1179  1179  1179  1179    85    85    85    90    90    90
## [24575]  1572  1572  1572  1572  1452  1452  1452  1452  3294  3294  3294
## [24586]  3294  1416  1416  1416  1416   528   528   528   528   759   759
## [24597]   759   759  2925  2925  2925  2925   288   288   288   288  5973
## [24608]  5973  5973  5973  2226  2226  2226  2226   465   465   465   465
## [24619]    73    73    73  1215  1215  1215  1215  1515  1515  1515  1515
## [24630]  2163  2163  2163  2163   996   996   996   996   744   744   744
## [24641]   744  2151  2151  2151  2151    57    57    57  1542  1542  1542
## [24652]  1542   708   708   708   708   735   735   735   735  1737  1737
## [24663]  1737  1737  1158  1158  1158  1158  1860  1860  1860  1860  5685
## [24674]  5685  5685  5685  1767  1767  1767  1767  5283  5283  5283  5283
## [24685]  3234  3234  3234  3234   882   882   882   882  1422  1422  1422
## [24696]  1422   816   816   816   816  1797  1797  1797  1797  1284  1284
## [24707]  1284  1284  1581  1581  1581  1581   444   444   444   444 21063
## [24718] 21063 21063 21063   621   621   621   621   651   651   651   651
## [24729]  1440  1440  1440  1440   438   438   438   438   106   106   106
## [24740]  1662  1662  1662  1662   915   915   915   915  1944  1944  1944
## [24751]  1944   546   546   546   546  2922  2922  2922  2922  1569  1569
## [24762]  1569  1569   672   672   672   672  1200  1200  1200  1200   315
## [24773]   315   315   315  1761  1761  1761  1761   921   921   921   921
## [24784]  1341  1341  1341  1341  4848  4848  4848  4848  1851  1851  1851
## [24795]  1851  1500  1500  1500  1500   588   588   588   588   150   150
## [24806]   150   150    95    95    95  1059  1059  1059  1059  2292  2292
## [24817]  2292  2292   474   474   474   474  1815  1815  1815  1815  1683
## [24828]  1683  1683  1683  1671  1671  1671  1671  3348  3348  3348  3348
## [24839]  1794  1794  1794  1794  1095  1095  1095  1095  3462  3462  3462
## [24850]  3462  4476  4476  4476  4476    68    68    68  1608  1608  1608
## [24861]  1608  1854  1854  1854  1854  2802  2802  2802  2802  2011  2011
## [24872]   449  2011   449   642   255  1369   194   765   765   765   765
## [24883]  1071  1071  1071  1071  1206  1206  1206  1206   432   432   432
## [24894]   432  4734  4734  4734  4734   831   831   831   831  2172  2172
## [24905]  2172  2172  1116  1116  1116  1116  2718  2718  2718  2718   114
## [24916]   114   114   432   432   432   432   651   651   651   651   900
## [24927]   900   900   900  2217  2217  2217  2217   897   897   897   897
## [24938]  1230  1230  1230  1230   264   264   264   264  2748  2748  2748
## [24949]  2748  2949  2949  2949  2949   987   987   987   987  3819  3819
## [24960]  3819  3819   969   969   969   969   804   804   804   804  1146
## [24971]  1146  1146  1146    82    82    82  1215  1215  1215  1215    95
## [24982]    95    95  3912  3912  3912  3912  2049  2049  2049  2049    68
## [24993]    68    68  2544  2544  2544  2544    69    69    69    81    81
## [25004]    81  2559  2559  2559  2559   119   119   119   954   954   954
## [25015]   954  1128  1128  1128  1128   132   132   132  1794  1794  1794
## [25026]  1794  3108  3108  3108  3108   116   116   116    74    74    74
## [25037]  1764  1764  1764  1764  2796  2796  2796  2796  2352  2352  2352
## [25048]  2352    72    72    72  1299  1299  1299  1299    85    85    85
## [25059]  1959  1959  1959  1959  1812  1812  1812  1812   279   279   279
## [25070]   279  1239  1239  1239  1239  1335  1335  1335  1335   678   678
## [25081]   678   678   651   651   651   651  1260  1260  1260  1260  1963
## [25092]  1963  1963  1881    82  2106  2106  2106  2106  2178  2178  2178
## [25103]  2178   528   528   528   528  3471  3471  3471  3471   438   438
## [25114]   438   438  2034  2034  2034  2034  1359  1359  1359  1359  1896
## [25125]  1896  1896  1896  2007  2007  2007  2007   453   453   453   453
## [25136]   534   534   534   534  2283  2283  2283  2283   444   444   444
## [25147]   444  1029  1029  1029  1029  1908  1908  1908  1908  7887  7887
## [25158]  7887  7887  7851  7851  7851  7851  2124  2124  2124  2124  2814
## [25169]  2814  2814  2814  1755  1755  1755  1755   864   864   864   864
## [25180]   978   978   978   978  1065  1065  1065  1065   756   756   756
## [25191]   756  1059  1059  1059  1059  1014  1014  1014  1014  1203  1203
## [25202]  1203  1203  4758  4758  4758  4758  2838  2838  2838  2838   756
## [25213]   756   756   756  4488  4488  4488  4488  1194  1194  1194  1194
## [25224]   450   450   450   450  2781  2781  2781  2781    66    66    66
## [25235]  1119  1119  1119  1119   342   342   342   342  3033  3033  3033
## [25246]  3033   618   618   618   618    74    74    74  1788  1788  1788
## [25257]  1788   429   429   429   429  1629  1629  1629  1629   870   870
## [25268]   870   870   543   543   543   543  2076  2076  2076  2076    73
## [25279]    73    73  1128  1128  1128  1128  2037   849  2037   849  2037
## [25290]   783  1782    66   255  1029  1029  1029  1029   246   246   246
## [25301]   246  1464  1464  1464  1464  1332  1332  1332  1332   759   759
## [25312]   759   759  3000  3000  3000  3000   693   693   693   693   987
## [25323]   987   987   987    81    81    81   489   489   489   489   131
## [25334]   131   131  1788  1788  1788  1788  2517  2517  2517  2517  1176
## [25345]  1176  1176  1176  2334  2334  2334  2334  2745  2745  2745  2745
## [25356]  5382  5382  5382  5382  3873  3873  3873  3873    69    69    69
## [25367]  1689  1689  1689  1689  1116  1116  1116  1116   576   576   576
## [25378]   576   594   594   594   594    78    78    78  2556  2556  2556
## [25389]  2556  1380  1380  1380  1380    85    85    85  4386  4386  4386
## [25400]  4386  3201  3201  3201  3201    78    78    78   663   663   663
## [25411]   663   936   936   936   936   828   828   828   828  1539  1539
## [25422]  1539  1539  1833  1833  1833  1833   234   234   234   234  1458
## [25433]  1458  1458  1458  1344  1344  1344  1344  2781  2781  2781  2781
## [25444]  3624  3624  3624  3624  1947  1947  1947  1947   543   543   543
## [25455]   543  3006  3006  3006  3006   978   978   978   978 12498 12498
## [25466] 12498 12498  1380  1380  1380  1380  5070  5070  5070  5070    74
## [25477]    74    74   594   594   594   594   131   131   131  2022  2022
## [25488]  2022  2022  1734  1734  1734  1734  1056  1056  1056  1056  1113
## [25499]  1113  1113  1113   696   696   696   696  1356  1356  1356  1356
## [25510]  2103  2103  2103  2103  1470  1470  1470  1470  1848  1848  1848
## [25521]  1848  1539  1539  1539  1539  2397  2397  2397  2397  1866  1866
## [25532]  1866  1866  1596  1596  1596  1596   951   951   951   951   744
## [25543]   744   744   744   852   852   852   852   996   996   996   996
## [25554]  3540  3540  3540  3540   552   552   552   552   420   420   420
## [25565]   420   951   951   951   951   112   112   112   522   522   522
## [25576]   522   540   540   540   540   327   327   327   327  1485  1485
## [25587]  1485  1485   780   780   780   780   837   837   837   837   669
## [25598]   669   669   669  1572  1572  1572  1572  1707  1707  1707  1707
## [25609]   450   450   450   450  1164  1164  1164  1164   855   855   855
## [25620]   855  3285  3285  3285  3285  1230  1230  1230  1230  3048  3048
## [25631]  3048  3048  3147  3147  3147  3147  1599  1599  1599  1599   573
## [25642]   573   573   573  2151  2151  2151  2151  1974  1974  1974  1974
## [25653]  1737  1737  1737  1737   480   480   480   480 10335 10335 10335
## [25664] 10335  1083  1083  1083  1083  2814  2814  2814  2814    99    99
## [25675]    99  2355  2355  2355  2355   759   759   759   759  2931  2931
## [25686]  2931  2931   438   438   438   438  2571  2571  2571  2571   450
## [25697]   450   450   450  2316  2316  2316  2316    78    78    78   336
## [25708]   336   336   336  1791  1791  1791  1791  1521  1521  1521  1521
## [25719]  2106  2106  2106  2106   609   609   609   609  2835  2835  2835
## [25730]  2835   324   324   324   324   705   705   705   705  2424  2424
## [25741]  2424  2424   540   540   540   540   642   642   642   642    69
## [25752]    69    69  4131  4131  4131  4131    68    68    68  1911  1911
## [25763]  1911  1911   108   108   108  1494  1494  1494  1494  2778  2778
## [25774]  2778  2778  2433  2433  2433  2433   741   741   741   741   119
## [25785]   119   119  2514  2514  2514  2514  1032  1032  1032  1032  1611
## [25796]  1611  1611  1611  4662  4662  4662  4662    90    90    90   990
## [25807]   990   990   990  4416  4416  4416  4416  1074  1074  1074   738
## [25818]   738   738   738   678   678   678   678   435   435   435   435
## [25829]   369   369   369   369  4056  4056  4056  4056  4743  4743  4743
## [25840]  4743  1986  1986  1986  1986  2655  2655  2655  2655  2886  2886
## [25851]  2886  2886  3486  3486  3486  3486   897   897   897   897    93
## [25862]    93    93  3933  3933  3933  3933  1368  1368  1368  1368  1230
## [25873]  1230  1230  1230  1755  1755  1755  1755    78    78    78   792
## [25884]   792   792   792   507   507   507   507  2451  2451  2451  2451
## [25895]   119   119   119  2766  2766  1023  1284   450  1023  1284   450
## [25906]  1660  1660   883   883  1660   978   834    49   682   954   954
## [25917]   954   954  1764  1764  1764  1764  3405  3405  3405  3405  2364
## [25928]  2364  2364  2364   978   978   978   978  1611  1611  1611  1611
## [25939]  1974  1974  1974  1974  1872  1872  1872  1872   750   750   750
## [25950]   750  1071  1071  1071  1071  2607  2607  2607  2607  2481  2481
## [25961]  2481  2481  1755  1755  1755  1755   446   446   446    72    72
## [25972]    72  1089  1089  1089  1089  2865  2865  2865  2865    72    72
## [25983]    72  1848  1848  1848  1848    89    89    89  2202  2202  2202
## [25994]  2202  1431  1431  1431  1431   579   579   579   579   446   446
## [26005]   446   561   561   561   561  2367  2367  2367  2367   918   918
## [26016]   918   918   953   953   321   297   333   321   297   333  2247
## [26027]  2247  2247  2247  1278  1278  1278  1278  1158  1158  1158  1158
## [26038]    72    72    72   312   312   312   312   183   183   183   330
## [26049]   330   330   330   363   363   363   363  2628  2628  2628  2628
## [26060]  3063  3063  3063  3063  1818  1818  1818  1818   579   579   579
## [26071]   579  1533  1533  1533  1533   921   350   921   921   350   564
## [26082]   222   357   128  1038  1038  1038  1038    72    72    72  2436
## [26093]  2436  2436  2436    66    66    66  2634  2634  2634  2634  1944
## [26104]  1944  1944  1944   420   420   420   420  2034  2034  2034  2034
## [26115]  1773  1773  1773  1773  4428  4428  4428  4428   449   449   449
## [26126]  1962  1962  1962  1962  5049  2025  5049  2025  5049  1839  4689
## [26137]   186   360  2631  2631  2631  2631  1737  1737  1737  1737  2031
## [26148]  2031  2031  2031  5883  5883  5883  5883  2097  2097  2097  2097
## [26159]  3438  3438  3438  3438  1716  1716  1716  1716   585   585   585
## [26170]   585   837   837   837   837    78    78    78  3075  3075  3075
## [26181]  3075   666   666   666   666  1041  1041  1041  1041   360   360
## [26192]   360   360  3345  3345  3345  3345  1626  1626  1626  1626   442
## [26203]   442   442   768   768   768   768   675   675   675   675  3609
## [26214]  3609  3609  3609  7476  7476  7476  7476  4887  4887  4887  4887
## [26225]   675   675   675   675  1620  1620  1620  1620  1419  1419  1419
## [26236]  1419   357   357   357   357  1788  1788  1788  1788   765   765
## [26247]   765   765  4278  4278  4278  4278    66    66    66  2472  2472
## [26258]  2472  2472  2622  2622  2622  2622   978   978   978   978  1398
## [26269]  1398  1398  1398   342   342   342   342  1572  1572  1572  1572
## [26280]  1977  1977  1977  1977   933   933   933   933  1617  1617  1617
## [26291]  1617  1245  1245  1245  1245    70    70    70    69    69    69
## [26302]  1659  1659  1659  1659  3195  3195  3195  3195   327   327   327
## [26313]   327    62    62    62   366   366   366   366  2244  2244  2244
## [26324]  2244  1203  1203  1203  1203   975   975   975   975   321   321
## [26335]   321   321  1212  1212  1212  1212  1944  1944  1944  1944    73
## [26346]    73    73   828   828   828   828  1356  1356  1356  1356  1068
## [26357]  1068  1068  1068  1890  1890  1890  1890  6849  6849  6849  6849
## [26368]  2013  2013  2013  2013  2394  2394  2394  2394   681   681   681
## [26379]   681   792   792   792   792    81    81    81  1536  1536  1536
## [26390]  1536  2091  2091  2091  2091  1164  1164  1164  1164  2922  2922
## [26401]  2922  2922   453   453   453   453  1566  1566  1566  1566   402
## [26412]   402   402   402   816   816   816   816   750   750   750   750
## [26423]   897   897   897   897  1683  1683  1683  1683    69    69    69
## [26434]  2100  2100  2100  2100  1281  1281  1281  1281   837   837   837
## [26445]   837   561   561   561   561   720   720   720   720   351   351
## [26456]   351   351  1884  1884  1884  1884  2946  2946  2946  2946  1686
## [26467]  1686  1686  1686  1671  1671  1671  1671   951   951   951   951
## [26478]   495   495   495   495   912   912   912   912   114   114   114
## [26489]   393   393   393   393  1287  1287  1287  1287  1092  1092  1092
## [26500]  1092  3609  3609  3609  3609  1404  1404  1404  1404   705   705
## [26511]   705   705  1425  1425  1425  1425  6402  6402   341  1606   341
## [26522]  1438   168  4824  4824  4824  4824  1404  1404  1404  1404  2928
## [26533]  2928  2928  2928   867   867   867   867  2637  2637  2637  2637
## [26544]  1011  1011  1011  1011  1812  1812  1812  1812  1416  1416  1416
## [26555]  1416  1008  1008  1008  1008   969   969   969   969  2577  2577
## [26566]  2577  2577  2223  2223  2223  2223  1284  1284  1284  1284  1023
## [26577]  1023  1023  1023  1239  1239  1239  1239  3333  3333  3333  3333
## [26588]   442   442   442  1332  1332  1332  1332  4242  4242  4242  4242
## [26599]  1488  1488  1488  1488   939   939   939   939   699   699   699
## [26610]   699  1473  1473  1473  1473   981   981   981   981  4272  1638
## [26621]  4272  4272  1638  2067  1605  2205    33   477   477   477   477
## [26632]  3267  3267  3267  3267  1026  1026  1026  1026  5604  5604  5604
## [26643]  5604   999   999   999   999  1077  1077  1077  1077   876   876
## [26654]   876   876  1164  1164  1164  1164    90    90    90  1302  1302
## [26665]  1302  1302   636   636   636   636  1779  1779  1779  1779  1149
## [26676]  1149  1149  1149   507   507   507   507  1572  1572  1572  1572
## [26687]  1527  1527  1527  1527   576   576   576   576    90    90    90
## [26698]  1830  1830  1830  1830  1206  1206  1206  1206  3429  3429  3429
## [26709]  3429   846   846   846   846   399   399   399   399  6252  6252
## [26720]  6252  6252  1221  1221  1221  1221   666   666   666   666  3279
## [26731]  3279  3279  3279   104   104   104  1218  1218  1218  1218   615
## [26742]   615   615   615  2289  2289  2289  2289  1719  1719  1719  1719
## [26753]    89    89    89  1137  1137  1137  1137  1647  1647  1647  1647
## [26764]  1224  1224  1224  1224   756   756   756   756   132   132   132
## [26775]  1263  1263  1263  1263   468   468   468   468   465   465   465
## [26786]   465  1386  1386  1386  1386  3729  3729  3729  3729  1149  1149
## [26797]  1149  1149  1986  1986  1986  1986  1581  1581  1581  1581   447
## [26808]   447   447   447   714   714   714   714  1302  1302  1302  1302
## [26819]   489   489   489   489  2232  2232  2232  2232  3456  3456  3456
## [26830]  3456  1500  1500  1500  1500  2115  2115  2115  2115  1371  1371
## [26841]  1371  1371   501   501   501   501  1824  1824  1824  1824  9228
## [26852]  9228  9228  9228   825   825   825   825  2454  2454  2454  2454
## [26863]   104   104   104    92    92    92   795   795   795   795    90
## [26874]    90    90   213   213   213   756   756   756   756  1755  1755
## [26885]  1755  1755   972   972   972   972  2379  2379  2379  2379  1815
## [26896]  1815  1815  1815  1077  1077  1077  1077    96    96    96  1017
## [26907]  1017  1017  1017  1374  1374  1374  1374  2391  2391  2391  2391
## [26918]  1344  1344  1344  1344  5364  5364  5364  5364   455   455   455
## [26929]  3891  3891  3891  3891  2304  2304  2304  2304   825   825   825
## [26940]   825   735   735   735   735   678   678   678   678  1806  1806
## [26951]  1806  1806  1218  1218  1218  1218   318   318   318   318    82
## [26962]    82    82 19623 19623 19623 19623  3795  3795  3795  3795  1581
## [26973]  1581  1581  1581   192   192   192   192  3549  3549  3549  3549
## [26984]   558   558   558   558   927   927   927   927  1332  1332  1332
## [26995]  1332  1686  1686  1686  1686  5931  5931  5931  5931  4971  4971
## [27006]  4971  4971  3024  3024  3024  3024  1731  1731  1731  1731  2832
## [27017]  2832  2832  2832   639   639   639   639  2733  2733  2733  2733
## [27028]   840   840   840   840  1437  1437  1437  1437  1143  1143  1143
## [27039]  1143  1827  1827  1827  1827  1221  1221  1221  1221  2868  2868
## [27050]  2868  2868   708   708   708   708   636   636   636   636    89
## [27061]    89    89   483   483   483   483  4034  4034  4034  4032     2
## [27072]   555   555   555   555  2775  2775  2775  2775  1332  1332  1332
## [27083]  1332  2292  2292  2292  2292   654   654   654   654   627   627
## [27094]   627   627   603   603   603   603  1146  1146  1146  1146   729
## [27105]   729   729   729  1314  1314  1314  1314  1479  1479  1479  1479
## [27116]  3753  3753  3753  3753  1074  1074  1074  1074  1641  1641  1641
## [27127]  1641   561   561   561   561  3285  3285  3285  3285   324   324
## [27138]   324   324   837   837   837   837  1527  1527  1527  1527    73
## [27149]    73    73  2235  2235  2235  2235  1416  1416  1416  1416   822
## [27160]   822   822   822  2037  2037  2037  2037  2568  2568  2568  2568
## [27171]  3105  3105  3105  3105   339   339   339   339  3981  3981  3981
## [27182]  3981  3630  3630  3630  3630   588   588   588   588  1251  1251
## [27193]  1251  1251  2262  2262  2262  2262   546   546   546   546   104
## [27204]   104   104  3136  3136  1439  3136  1439  1854  1428  1282    11
## [27215]   840   840   840   840  1023  1023  1023  1023    85    85    85
## [27226]   927   927   927   927  3174  3174  3174  3174   966   966   966
## [27237]   966   609   609   609   609  3639  3639  3639  3639   204   204
## [27248]   204   204   114   114   114  1506  1506  1506  1506  2157  2157
## [27259]  2157  2157  1149  1149  1149  1149  4968  4968  4968  4968  1275
## [27270]  1275  1275  1275   651   651   651   651  4230  4230  4230  4230
## [27281]   789   789   789   789  5082  5082  5082  5082  1623  1623  1623
## [27292]  1623   516   516   516   516    81    81    81  1458  1458  1458
## [27303]  1458  1902  1902  1902  1902  1977  1977  1977  1977   243   243
## [27314]   243   243   393   393   393   393   960   960   960   960  4191
## [27325]  4191  4191  4191    69    69    69  1578  1578  1578  1578   603
## [27336]   603   603   603  2250  2250  2250  2250  1260  1260  1260  1260
## [27347]  1458  1458  1458  1458   858   858   858   858  1248  1248  1248
## [27358]  1248   519   519   519   519    85    85    85  2364  2364  2364
## [27369]  2364   828   828   828   828    81    81    81   633   633   633
## [27380]   633  1470  1470  1470  1470  3033  3033  3033  3033  2202  2202
## [27391]  2202  2202  5535  5535  5535  5535  1473  1473  1473  1473  4203
## [27402]  4203  4203  4203   303   303   303   303  1695  1695  1695  1695
## [27413]  1824  1824  1824  1824  3384  3384  3384  3384  2436  2436  2436
## [27424]  2436   870   870   870   870  3492  3492  3492  3492    83    83
## [27435]    83  1227  1227  1227  1227   822   822   822   822   405   405
## [27446]   405   405  1548  1548  1548  1548  2691  2691  2691  2691  3192
## [27457]  3192  3192  3192  1530  1530  1530  1530  4422  4422  4422  4422
## [27468]    70    70    70   207   207   207   207  1035  1035  1035  1035
## [27479]  3255  3255  3255  3255   432   432   432   432  2445  2445  2445
## [27490]  2445  1305  1305  1305  1305  1281  1281  1281  1281   963   963
## [27501]   963   963  3423  3423  3423  3423  5268  5268  5268  5268   116
## [27512]   116   116  5310  5310  5310  5310  2625  2625  2625  2625  3510
## [27523]  3510  3510  3510   981   981   981   981  1338  1338  1338  1338
## [27534]  2982  2982  2982  2982  4665  4665  4665  4665   402   402   402
## [27545]   402    72    72    72   354   354   354   354  1014  1014  1014
## [27556]  1014  1452  1452  1452  1452  2043  2043  2043  2043  3171  3171
## [27567]  3171  3171   732   732   732   732  1233  1233  1233  1233   426
## [27578]   426   426   426  3003  3003  3003  3003  3777  3777  3777  3777
## [27589]  2727  2727  2727  2727  1467  1467  1467  1467  1299  1299  1299
## [27600]  1299  1653  1653  1653  1653  1326  1326  1326  1326   816   816
## [27611]   816   816  1296  1296  1296  1296   156   156   156   156  1539
## [27622]  1539  1539  1539   648   648   648   648  2565  2565  2565  2565
## [27633]  1662  1662  1662  1662  1401  1401  1401  1401   894   894   894
## [27644]   894  2139  2139  2139  2139  2451  2451  2451  2451  1071  1071
## [27655]  1071  1071   201   201   201   201  3511  3511   801  3511   801
## [27666]   990   795     6  2521   492   492   492   492   444   444   444
## [27677]   444  1780  1780  1780   681   681   681   681   369   369   369
## [27688]   369  2454  2454  2454  2454  2355  2355  2355  2355  2232  2232
## [27699]  2232  2232   666   666   666   666  1902  1902  1902  1902  2310
## [27710]  2310  2310  2310  1536  1536  1536  1536   969   969   969   969
## [27721]  1818  1818  1818  1818  2658  2658  2658  2658    69    69    69
## [27732]  2055  2055  2055  2055  2823  2823  2823  2823  3705  3705  3705
## [27743]  3705    68    68    68  1494  1494  1494  1494   909   909   909
## [27754]   909   681   681   681   681  1245  1245  1245  1245  3267  3267
## [27765]  3267  3267  1755  1755  1755  1755  1167  1167  1167  1167  1614
## [27776]  1614  1614  1614  1713  1713  1713  1713   375   375   375   375
## [27787]  2204  2204  2204    70    70    70  2103  2103  2103  2103  1032
## [27798]  1032  1032  1032  4047  4047  4047  4047 50740 50740 18027  1797
## [27809]  1797  1797 27090 18027  1797  1797  1797 27090   468   468   468
## [27820]   468  1695  1695  1695  1695   810   810   810   810    74    74
## [27831]    74  1863  1863  1863  1863   711   711   711   711   837   837
## [27842]   837   837  1203  1203  1203  1203  1332  1332  1332  1332   462
## [27853]   462   462   462  2205  2205  2205  2205   984   984   984   984
## [27864]   375   375   375   375  7134  7134  7134  7134  1320  1320  1320
## [27875]  1320   399   399   399   399  2124  2124  2124  2124   618   618
## [27886]   618   618  2457  2457  2457  2457  3252  3252  3252  3252  1578
## [27897]  1578  1578  1578   501   501   501   501   354   354   354   354
## [27908]   354   354   354   354    66    66    66  1482  1482  1482  1482
## [27919]  1896  1896  1896  1896  1290  1290  1290  1290   933   933   933
## [27930]   933  3306  3306  3306  3306  2283  2283  2283  2283  1215  1215
## [27941]  1215  1215  1242  1242  1242  1242   357   357   357   357  2772
## [27952]  2772  2772  2772  1557  1557  1557  1557  2118  2118  2118  2118
## [27963]   615   615   615   615  1233  1233  1233  1233  2520  2520  2520
## [27974]  2520  1371  1371  1371  1371  8094  8094  8094  8094  2985  2985
## [27985]  2985  2985  4118  2243  2258  4118  4118  2258  2243  2316  2253
## [27996]  2049  1802     5   194  1341  1341  1341  1341  1515  1515  1515
## [28007]  1515   738   738   738   738  2436  2436  2436  2436    99    99
## [28018]    99  1374  1374  1374  1374  3324  3324  3324  3324  1698  1698
## [28029]  1698  1698  1233  1233  1233  1233  2451  2451  2451  2451  5667
## [28040]  5667  5667  5667    72    72    72  2907  2907  2907  2907  1854
## [28051]  1854  1854  1854  1743  1743  1743  1743  4245  4245  4245  4245
## [28062]  1989  1989  1989  1989   678   678   678   678   474   474   474
## [28073]   474   726   726   726   726    90    90    90  3258  3258  3258
## [28084]  3258  2892  2892  2892  2892  2388  2388  2388  2388  1224  1224
## [28095]  1224  1224   504   504   504   504  1536  1536  1536  1536    91
## [28106]    91    91   327   327   327   327  4581  4581  4581  4581  1131
## [28117]  1131  1131  1131   945   945   945   945  1536  1536  1536  1536
## [28128]  9192  9192  9192  9192   618   618   618   618   303   303   303
## [28139]   303  3507  3507  3507  3507 10842 10842 10842 10842    69    69
## [28150]    69    72    72    72  2712  2712  2712  2712   378   378   378
## [28161]   378  1146  1146  1146  1146  1005  1005  1005  1005  1911  1911
## [28172]  1911  1911   729   729   729   729  2190  2190  2190  2190  1023
## [28183]  1023  1023  1023  2370  2370  2370  2370  3234  3234  3234  3234
## [28194]  5331  5331  5331  5331  1998  1998  1998  1998  1218  1218  1218
## [28205]  1218  1305  1305  1305  1305   390   390   390   390   984   984
## [28216]   984   984  1347  1347  1347  1347  3306  3306  3306  3306  1953
## [28227]  1953  1953  1953   897   897   897   897   804   804   804   804
## [28238]   375   375   375   375  3198  3198  3198  3198  1758  1758  1758
## [28249]  1758  2241  2241  2241  2241  4092  4092  4092  4092  2160  2160
## [28260]  2160  2160  2028  2028  2028  2028  2223  2223  2223  2223  1980
## [28271]  1980  1980  1980   486   486   486   486  2886  2886  2886  2886
## [28282]   513   513   513   513  1671  1671  1671  1671  3759  3759  3759
## [28293]  3759  2013  2013  2013  2013  4335  4335  4335  4335  2136  2136
## [28304]  2136  2136  2241  2241  2241  2241  5460  5460  5460  5460  1632
## [28315]  1632  1632  1632   384   384   384   384  1950  1950  1950  1950
## [28326]   774   774   774   774  2145  2145   901  2145    27   873   939
## [28337]   873  1206    27  1650  1650  1650  1650  1536  1536  1536  1536
## [28348]   648   648   648   648  1461  1461  1461  1461  1227  1227  1227
## [28359]  1227   921   921   921   921  1257  1257  1257  1257  1023  1023
## [28370]  1023  1023  1017  1017  1017  1017  2610  2610  2610  2610  1764
## [28381]  1764  1764  1764  1479  1479  1479  1479  1815  1815  1815  1815
## [28392]    98    98    98   627   627   627   627  2865  2865  2865  2865
## [28403]  6162  6162  6162  6162  2073  2073  2073  2073  3888  3888   867
## [28414]   867  3888  1011   612   255  2877   104   104   104  2445  2445
## [28425]  2445  2445   708   708   708   708  1755  1755  1755  1755  1041
## [28436]  1041  1041  1041  1296  1296  1296  1296   795   795   795   795
## [28447]  1506  1506  1506  1506  3510  3510  3510  3510  1263  1263  1263
## [28458]  1263  3237  3237  3237  3237   351   351   351   351  1356  1356
## [28469]  1356  1356   765   765   765   765   609   609   609   609  3030
## [28480]  3030  3030  3030  1965  1965  1965  1965    68    68    68  2484
## [28491]  2484  2484  2484   453   453   453   453  1776  1776  1776  1776
## [28502]   561   561   561   561   567   567   567   567   747   747   747
## [28513]   747  2664  2664  2664  2664   384   384   384   384   990   990
## [28524]   990   990  7665  7665  7665  7665  4005  4005  4005  4005  3354
## [28535]  3354  3354  3354  4059  4059  4059  4059   525   525   525   525
## [28546]  1290  1290  1290  1290   336   336   336   336  5190  5190  5123
## [28557]  5190  5123  5163  4929    27   194  1263  1263  1263  1263  2178
## [28568]  2178  2178  2178  1116  1116  1116  1116   222   222   222   222
## [28579]   972   972   972   972  1335  1335  1335  1335   104   104   104
## [28590]  2844  2844  2844  2844    82    82    82   912   912   912   912
## [28601]  1857  1857  1857  1857   942   942   942   942   918   918   918
## [28612]   918  2349  2349  2349  2349   285   285   285   285   867   867
## [28623]   867   867   507   507   507   507  2346  2346  2346  2346    78
## [28634]    78    78  1113  1113  1113  1113   639   639   639   639  2970
## [28645]  2970  2970  2970  1506  1506  1506  1506  1884  1884  1884  1884
## [28656]  2190  2190  2190  2190  1185  1185  1185  1185  1623  1623  1623
## [28667]  1623   375   375   375   375  1479  1479  1479  1479  3090  3090
## [28678]  3090  3090  1323  1323  1323  1323  2064  2064  2064  2064  1995
## [28689]  1995  1995  1995  1365  1365  1365  1365  3918  3918  3918  3918
## [28700]    68    68    68  1938  1938  1938  1938   987   987   987   987
## [28711] 14058 14058 14058 14058  2925  2925  2925  2925  1752  1752  1752
## [28722]  1752    99    99    99  1278  1278  1278  1278  1770  1770  1770
## [28733]  1770  2103  2103  2103  2103   453   453   453   453   570   570
## [28744]   570   570  1164  1164  1164  1164  2079  2079  2079  2079   540
## [28755]   540   540   540   462   462   462   462   738   738   738   738
## [28766]  1410  1410  1410  1410  1974  1974  1974  1974  1203  1203  1203
## [28777]  1203  1863  1863  1863  1863  1323  1323  1323  1323  5931  5931
## [28788]  5931  5931   549   549   549   549  2004  2004  2004  2004   516
## [28799]   516   516   516   936   936   936   936  1698  1698  1698  1698
## [28810]  1986  1986  1986  1986   405   405   405   405  2925  2925  2925
## [28821]  2925    66    66    66  6612  6612  6612  6612  2763  2763  2763
## [28832]  2763  4224  4224  4224  4224  1122  1122  1122  1122  4968  4968
## [28843]  4968  4968  3459  3459  3459  3459  1518  1518  1518  1518  1689
## [28854]  1689  1689  1689  1860  1860  1860  1860   711   711   711   711
## [28865]  1272  1272  1272  1272   843   843   843   843   885   885   885
## [28876]   885   738   738   738   738  3210  3210  3210  3210  1929  1929
## [28887]  1929  1929  1242  1242  1242  1242  2472  2472  2472  2472  2373
## [28898]  2373  2373  2373   450   450   450   450  1983  1983  1983  1983
## [28909]  5076  5076  5076  5076    70    70    70   321   321   321   321
## [28920]  1764  1764  1764  1764  2037  2037  2037  2037   252   252   252
## [28931]   252  1254  1254  1254  1254  1632  1632  1632  1632    73    73
## [28942]    73  1743  1743  1743  1743  1355  1355   721   632   721   632
## [28953]  2283  2283  2283  2283  2502  2502  2502  2502  5292  5292  5292
## [28964]  5292  2373  2373  2373  2373  2184  2184  2184  2184   390   390
## [28975]   390   390   234   234   234   234   705   705   705   705   588
## [28986]   588   588   588  2031  2031  2031  2031  2634  2634  2634  2634
## [28997]  1599  1599  1599  1599   510   510   510   510  1896  1896  1896
## [29008]  1896   945   945   945   945  6264  6264  6264  6264  1323  1323
## [29019]  1323  1323  1104  1104  1104  1104   729   729   729   729    81
## [29030]    81    81    75    75    75  4173  4173  4173  4173  2790  2790
## [29041]  2790  2790  1725  1725  1725  1725   528   528   528   528  1494
## [29052]  1494  1494  1494  1890  1890  1890  1890    68    68    68   393
## [29063]   393   393   393  1158  1158  1158  1158  1596  1596  1596  1596
## [29074]   366   366   366   366   720   720   720   720  1503  1503  1503
## [29085]  1503  1446  1446  1446  1446  1935  1935  1935  1935  1818  1818
## [29096]  1818  1818  2133  2133  2133  2133   378   378   378   378    69
## [29107]    69    69   666   666   666   666  1674  1674  1674  1674  2154
## [29118]  2154  2154  2154  1115  1115  1078  1078  1115  1092   951   127
## [29129]    23  1257  1257  1257  1257   783   783   783   783  1062  1062
## [29140]  1062  1062   516   516   516   516   630   630   630   630  2562
## [29151]  2562  2562  2562  1131  1131  1131  1131  2879  2879   270   876
## [29162]   666   663   396   270   876   666   663   396  1875  1875  1875
## [29173]  1875   429   429   429   429  2181  2181  2181  2181   603   603
## [29184]   603   603  2919  2919  2919  2919  1644  1644  1644  1644   336
## [29195]   336   336   336  1056  1056  1056  1056  1611  1611  1611  1611
## [29206]  2205  2205  2205  2205    69    69    69   621   621   621   621
## [29217]   972   972   972   972   174   174   174   174  1257  1257  1257
## [29228]  1257  6264  6264  6264  6264  1350  1350  1350  1350   555   555
## [29239]   555   555   455   455   455   435   435   435   435   972   972
## [29250]   972   972   936   936   936   936  2934  2934  2934  2934  1470
## [29261]  1470  1470  1470  1263  1263  1263  1263  1755  1755  1755  1755
## [29272]  1956  1956  1956  1956  2001  2001  2001  2001  2940  2940  2940
## [29283]  2940   741   741   741   741   561   561   561   561  2655  2655
## [29294]  2655  2655  2325  2325  2325  2325  2520  2520  2520  2520   504
## [29305]   504   504   504  3018  3018  3018  3018  3069  3069  3069  3069
## [29316]  1044  1044  1044  1044   615   615   615   615   606   606   606
## [29327]   606   300   300   300   300   918   918   918   918   249   249
## [29338]   249   249  2217  2217  2217  2217   309   309   309   309    68
## [29349]    68    68  1596  1596  1596  1596  2538  2538  2538  2538  1167
## [29360]  1167  1167  1167  1077  1077  1077  1077   867   867   867   867
## [29371]   645   645   645   645  4557  4557  4557  4557  2034  2034  2034
## [29382]  2034   648   648   648   648  2241  2241  2241  2241  1731  1731
## [29393]  1731  1731  1596  1596  1596  1596   666   666   666   666  1290
## [29404]  1290  1290  1290  2601  2601  2601  2601  1578  1578  1578  1578
## [29415]  1089  1089  1089  1089  1512  1512  1512  1512  3417  3417  3417
## [29426]  3417   600   600   600   600  5718  5718  5718  5718  1206  1206
## [29437]  1206  1206  5697  5697  5697  5697   549   549   549   549   342
## [29448]   342   342   342  2817  2817  2817  2817  2556  2556  2556  2556
## [29459]  2950  1157  2950  2950  1157  1119  1332    38  1618   999   999
## [29470]   999   999  1227  1227  1227  1227  6279  6279  6279  6279  2343
## [29481]  2343  2343  2343   891   891   891   891  1059  1059  1059  1059
## [29492]  1207   822  1207   822  1207   693  1074   129   133  2777  2777
## [29503]  1716  1059  1716  1059  2268  2268  2268  2268  3264  3264  3264
## [29514]  3264  3765  3765  3765  3765  2340  2340  2340  2340  1956  1956
## [29525]  1956  1956  1995  1995  1995  1995  1284  1284  1284  1284  1935
## [29536]  1935  1935  1935  4359  4359  4359  4359   411   411   411   411
## [29547]  1326  1326  1326  1326  1431  1431  1431  1431  2218  2218   776
## [29558]   776  2218  2121   729    47    97  2664  2664  2664  2664    66
## [29569]    66    66   921   921   921   921    74    74    74  2762  2762
## [29580]  1130  2762  1130  1461  1047  1301    83  1542  1542  1542  1542
## [29591]  4026  4026  4026  4026  1401  1401  1401  1401   459   459   459
## [29602]   459   738   738   738   738  1758  1758  1758  1758  1089  1089
## [29613]  1089  1089   840   840   840   840  2478  2478  2478  2478   906
## [29624]   906   906   906    99    99    99   915   915   915   915  1030
## [29635]  1030  1005  1005  1030  1017   855   150    13    72    72    72
## [29646]  1524  1524  1524  1524  1089  1089  1089  1089    78    78    78
## [29657]   750   750   750   750   291   291   291   291   750   750   750
## [29668]   750  1653  1653  1653  1653  1218  1218  1218  1218  1008  1008
## [29679]  1008  1008    81    81    81  1077  1077  1077  1077  3357  3357
## [29690]  3357  3357  2193  2193  2193  2193  2073  2073  2073  2073   213
## [29701]   213   213   213  2115  2115  2115  2115  1728  1728  1728  1728
## [29712]  3030  3030  3030  3030  3099  3099  3099  3099  1113  1113  1113
## [29723]  1113  1368  1368  1368  1368   351   351   351   351  1989  1989
## [29734]  1989  1989  1227  1227  1227  1227  1722  1722  1722  1722  3408
## [29745]  3408  3408  3408    69    69    69  2562  2562  2562  2562  1080
## [29756]  1080  1080  1080  1394  1345  1394  1394  1345  1287  1374    58
## [29767]    20   417   417   417   417   489   489   489   489  1446  1446
## [29778]  1446  1446  1191  1191  1191  1191    90    90    90  2793  2793
## [29789]  2793  2793    69    69    69    72    72    72   450   450   450
## [29800]   450   774   774   774   774   759   759   759   759  1317  1317
## [29811]  1317  1317   372   372   372   372  2739  2739  2739  2739   714
## [29822]   714   714   714   455   455   455   458   458   458   573   573
## [29833]   573   573  3606  3606  3606  3606   372   372   372   372    81
## [29844]    81    81    93    93    93  1767  1767  1767  1767   104   104
## [29855]   104  2865  2865  2865  2865  4623  4623  4623  4623  2688  2688
## [29866]  2688  2688   446   446   446   492   492   492   492  1708  1708
## [29877]   630   630  1708   870   459   171   838   909   909   909   909
## [29888] 12480 12480 12480 12480   720   720   720   720   753   753   753
## [29899]   753   675   675   675   675    78    78    78  4344  4344  4344
## [29910]  4344  3996  3996  3996  3996   741   741   741   741  1476  1476
## [29921]  1476  1476   768   768   768   768  1479  1479  1479  1479   870
## [29932]   870   870   870  1377  1377  1359    15  1359    15  2913  2913
## [29943]  2913  2913  1011  1011  1011  1011  2220  2220  2220  2220  2151
## [29954]  2151  2151  2151  1017  1017  1017  1017    85    85    85  8475
## [29965]  8475  8475  8475  4536  4536  4536  4536   777   777   777   777
## [29976]    81    81    81  1494  1494  1494  1494  1818  1818  1818  1818
## [29987]  1824  1824  1824  1824  1071  1071  1071  1071  1575  1575  1575
## [29998]  1575  1617  1617  1617  1617   435   435   435   435  3033  3033
## [30009]  3033  3033  1359  1359  1359  1359  1401  1401  1401  1401  1167
## [30020]  1167  1167  1167  1146  1146  1146  1146  2688  2688  2688  2688
## [30031]  1656  1656  1656  1656    81    81    81    69    69    69  3108
## [30042]  3108  3108  3108  3291  3291  3291  3291   912   912   912   912
## [30053]   861   861   861   861   102   102   102  8298  8298  8298  8298
## [30064]  2988  2988  2988  2988   864   864   864   864   489   489   489
## [30075]   489  1089  1089  1089  1089   822   822   822   822    83    83
## [30086]    83  1674  1674  1674  1674   534   534   534   534  4767  4767
## [30097]  4767  4767   651   651   651   651  1695  1695  1695  1695   351
## [30108]   351   351   351  4311  4311  4311  4311  1854  1854  1854  1854
## [30119]  2031  2031  2031  2031  1185  1185  1185  1185  6006  6006  6006
## [30130]  6006  1671  1671  1671  1671  4125  4125  4125  4125   912   912
## [30141]   912   912  1167  1167  1167  1167  2127  2127  2127  2127  1350
## [30152]  1350  1350  1350   570   570   570   570   555   555   555   555
## [30163]   690   690   690   690   744   744   744   744 11106 11106 11106
## [30174] 11106   450   450   450   450  3291  3291  3291  3291   510   510
## [30185]   510   510   528   528   528   528   309   309   309   309  1236
## [30196]  1236  1236  1236  1197  1197  1197  1197  2112  2112  2112  2112
## [30207]  1932  1932  1932  1932   957   957   957   957  1509  1509  1509
## [30218]  1509  1347  1347  1347  1347   795   795   795   795   810   810
## [30229]   810   810  1680  1680  1680  1680  2469  2469  2469  2469   600
## [30240]   600   600   600    83    83    83  2235  2235  2235  2235  4386
## [30251]  4386  4386  4386  1446  1446  1446  1446  2073  2073  2073  2073
## [30262]  1797  1797  1797  1797  3126  3126  3126  3126  1008  1008  1008
## [30273]  1008   228   228   228   228  1332  1332  1332  1332   273   273
## [30284]   273   273  1275  1275  1275  1275  2289  2289  2289  2289    70
## [30295]    70    70  5982  5982  5982  5982   840   840   840   840    78
## [30306]    78    78   555   555   555   555  1101  1101  1101  1101   114
## [30317]   114   114   750   750   750   750  1320  1320  1320  1320    65
## [30328]    65    65   330   330   330   330  1185  1185  1185  1185   452
## [30339]   452   452  1779  1779  1779  1779  1437  1437  1437  1437   555
## [30350]   555   555   555  1917  1917  1917  1917  1254  1254  1254  1254
## [30361]   999   999   999   999  2467  2467  1333  1333  2467  1389  1200
## [30372]   133  1078    74    74    74  1311  1311  1311  1311  1041  1041
## [30383]  1041  1041  1437  1437  1437  1437   786   786   786   786  1359
## [30394]  1359  1359  1359  2406  2406  2406  2406  4413  4413  4413  4413
## [30405]  1878  1878  1878  1878   663   663   663   663  2433  2433  2433
## [30416]  2433  1569  1569  1569  1569  9519  9519  9519  9519   984   984
## [30427]   984   984   699   699   699   699  2634  2634  2634  2634   777
## [30438]   777   777   777  4674  4674  4674  4674  1767  1767  1767  1767
## [30449]    69    69    69  3207  3207  3207  3207  3258  2278  3258  3258
## [30460]  2278  2418  2124   840   154  5838  5838  5838  5838    91    91
## [30471]    91  1284  1284  1284  1284  2106  2106  2106  2106  1287  1287
## [30482]  1287  1287   119   119   119  5211  5211  5211  5211  1071  1071
## [30493]  1071  1071  6366  6366  6366  6366  1602  1602  1602  1602   642
## [30504]   642   642   642  1323  1323  1323  1323  6729  6729  6729  6729
## [30515]  2835  2835  2835  2835  1302  1302  1302  1302  4050  4050  4050
## [30526]  4050   339   339   339   339   351   351   351   351  3573  3573
## [30537]  3573  3573   339   339   339   339   921   921   921   921  1245
## [30548]  1245  1245  1245   810   810   810   810  6657  6657  6657  6657
## [30559]  1260  1260  1260  1260  1758  1758  1758  1758  1866  1866  1866
## [30570]  1866   483   483   483   483  2274  2274  2274  2274   609   609
## [30581]   609   609  2109  2109  2109  2109  2106  2106  2106  2106   594
## [30592]   594   594   594  5697  5697  5697  5697   654   654   654   654
## [30603]  1083  1083  1083  1083   384   384   384   384  1278  1278  1278
## [30614]  1278   894   894   894   894  1161  1161  1161  1161  1767  1767
## [30625]  1767  1410  1410  1410  1410    82    82    82  2658  2658  2658
## [30636]  2658   131   131   131   816   816   816   816    72    72    72
## [30647]   449   449   449  1131  1131  1131  1131  1017  1017  1017  1017
## [30658]   660   660   660   660   648   648   648   648  6819  6819  6819
## [30669]  6819    83    83    83  2835  2835  2835  2835   678   678   678
## [30680]   678   273   273   273   273   801   801   801   801    72    72
## [30691]    72   918   918   918   918  2142  2142  2142  2142   717   717
## [30702]   717   717  2454  2454  2454  2454  1263  1263  1263  1263  1038
## [30713]  1038  1038  1038  2670  2670  2670  2670   657   657   657   657
## [30724]  2016  2016  2016  2016  1119  1119  1119  1119   561   561   561
## [30735]   561  2454  2454  2454  2454  4077  4077  4077  4077  1449  1449
## [30746]  1449  1449   504   504   504   504   447   447   447   447   783
## [30757]   783   783   783  3375  3375  3375  3375   870   870   870   870
## [30768]  2622  2622  2622  2622    89    89    89  2763  2763  2763  2763
## [30779]  1212  1212  1212  1212  1179  1179  1179  1179  3459  3459  3459
## [30790]  3459  1722  1722  1722  1722  1035  1035  1035  1035   570   570
## [30801]   570   570  1440  1440  1440  1440   294   294   294   294   486
## [30812]   486   486   486    69    69    69  1017  1017  1017  1017  1825
## [30823]  1825  1003  1825  1003  1161   924   664    79    95    95    95
## [30834]   912   912   912   912   573   573   573   573   474   474   474
## [30845]   474  1683  1683  1683  1683   303   303   303   303  5628  5628
## [30856]  5628  5628  1431  1431  1431  1431  9624  9624  9624  9624  3363
## [30867]  3363  3363  3363   396   396   396   396  4365  4365  4365  4365
## [30878]   690   690   690   690  1863  1863  1863  1863   538   538   538
## [30889]   537     1   957   957   957   957   705   705   705   705  1884
## [30900]  1884  1884  1884  1980  1980  1980  1980  1584  1584  1584  1584
## [30911]   104   104   104  1710  1710  1710  1710  1158  1158  1158  1158
## [30922]   879   879   879   879  1530  1530  1530  1530  1032  1032  1032
## [30933]  1032   735   735   735   735   690   690   690   690  1290  1290
## [30944]  1290  1290   648   648   648   648   567   567   567   567  2115
## [30955]  2115  2115  2115   788   735   788   788   735   762   561    26
## [30966]   174  7038  7038  7038  7038   366   366   366   366   645   645
## [30977]   645   645  3237  3237  3237  3237  1389  1389  1389  1389  1167
## [30988]  1167  1167  1167  3381  3381  3381  3381   663   663   663   663
## [30999]   468   468   468   468  7032  7032  7032  7032  6237  6237  6237
## [31010]  6237  2067  2067  2067  2067  9027  9027  9027  9027  1152  1152
## [31021]  1152  1152  3099  3099  3099  3099  5703  5703  5703  5703   455
## [31032]   455   455  3201  3201  3201  3201   984   984   984   984  4614
## [31043]  4614  4614  4614  3436  2145  3436  2145  3436  2124  2199    21
## [31054]  1237    86    86    86  1689  1689  1689  1689   579   579   579
## [31065]   579  2703  2703  2703  2703  2181  2181  2181  2181   771   771
## [31076]   771   771  1185  1185  1185  1185   279   279   279   279   804
## [31087]   804   804   804   297   297   297   297  1746  1746  1746  1746
## [31098]  2041  2041  1290   750  1290   750   600   600   600   600   951
## [31109]   951   951   951  1104  1104  1104  1104  3558  3558  3558  3558
## [31120]   951   951   951   951  1995  1995  1995  1995  2439  2439  2439
## [31131]  2439   585   585   585   585   259   259   259  1167  1167  1167
## [31142]  1167   393   393   393   393  1920  1920  1920  1920   366   366
## [31153]   366   366  1170  1170  1170  1170  2073  2073  2073  2073  1236
## [31164]  1236  1236  1236  2658  2658  2658  2658   615   615   615   615
## [31175]   870   870   870   870  1296  1296  1296  1296  1770  1770  1770
## [31186]  1770   489   489   489   489  1824  1824  1824  1824  2193  2193
## [31197]  2193  2193  1491  1491  1491  1491  1035  1035  1035  1035   924
## [31208]   924   924   924  7548  7548  7548  7548   882   882   882   882
## [31219]  1041  1041  1041  1041   927   927   927   927   522   522   522
## [31230]   522  1257  1257  1257  1257  4581  4581  4581  4581  3027  3027
## [31241]  3027  3027  5820  5820  5820  5820  1176  1176  1176  1176  2559
## [31252]  2559  2559  2559  2043  2043  2043  2043   999   999   999   999
## [31263]   993   993   993   993  2064  2064  2064  2064  1278  1278  1278
## [31274]  1278  1599  1599  1599  1599  1032  1032  1032  1032  1275  1275
## [31285]  1275  1275  5847  5847  5847  5847  5019  5019  5019  5019  1500
## [31296]  1500  1500  1500  1392  1392  1392  1392  1401  1401  1401  1401
## [31307]  2481  2481  2481  2481  1182  1182  1182  1182  1002  1002  1002
## [31318]  1002   705   705   705   705   612   612   612   612   564   564
## [31329]   564   564   882   882   882   882  1182  1182  1182  1182   186
## [31340]   186   186   186   198   198   198   198  1962  1962  1962  1962
## [31351]  1617  1617  1617  1617  1332  1332  1332  1332   261   261   261
## [31362]   261  1134  1134  1134  1134  2682  2682  2682  2682    78    78
## [31373]    78   924   924   924   924   432   432   432   432    94    94
## [31384]    94  3105  3105  3105  3105   768   768   768   768  1443  1443
## [31395]  1443  1443  2679  2679  2679  2679   879   879   879   879  1668
## [31406]  1668  1668  1668  1800  1800  1800  1800  1059  1059  1059  1059
## [31417]  2469  2469  2469  2469   378   378   378   378   573   573   573
## [31428]   573   897   897   897   897  1326  1326  1326  1326  1044  1044
## [31439]  1044  1044   810   810   810   810   990   990   990   990    54
## [31450]    54    54   636   636   636   636  2307  2307  2307  2307   939
## [31461]   939   939   939  1635  1635  1635  1635  1194  1194  1194  1194
## [31472]  1677  1677  1677  1677  2244  2244  2244  2244  3633  3633  3633
## [31483]  3633  1629  1629  1629  1629 52179 52179 52179 52179  4487  4487
## [31494]   952  4487   952  1068   870  3419    82  4317  4317  4317  4317
## [31505]   843   843   843   843  1485  1485  1485  1485  2754  2754  2754
## [31516]  2754   116   116   116    78    78    78  3132  3132  3132  3132
## [31527]  1356  1356  1356  1356  3924  3924  3924  3924   846   846   846
## [31538]   846  1308  1308  1308  1308  2895  2895  2895  2895    68    68
## [31549]    68  1167  1167  1167  1167  6726  6726  6726  6726  1053  1053
## [31560]  1053  1053    66    66    66  1056  1056  1056  1056    86    86
## [31571]    86    86    86    86   399   399   399   399  3314  1242  3314
## [31582]  3314  1242  1527  1170  1787    72   669   669   669   669  1122
## [31593]  1122   582   582  1122   711   450   132   411   375   375   375
## [31604]   375   546   546   546   546  2115  2115  2115  2115   759   759
## [31615]   759   759  1194  1194  1194  1194    96    96    96  2829  2829
## [31626]  2829  2829   483   483   483   483   570   570   570   570  1035
## [31637]  1035  1035  1035  2661  2661  2661  2661   648   648   648   648
## [31648]   903   903   903   903  3813  3813  3813  3813  1806  1806  1806
## [31659]  1806  1839  1839  1839  1839  2013  2013  2013  2013  2787  2787
## [31670]  2787  2787  1803  1803  1803  1803  1296  1296  1296  1296  1866
## [31681]  1866  1866  1866   378   378   378   378  1194  1194  1194  1194
## [31692]   129   129   129    90    90    90   663   663   663   663  2784
## [31703]  2784  2784  2784   121   121   121  2358  2358  2358  2358   840
## [31714]   840   840   840  1158  1158  1158  1158  2100  2100  2100  2100
## [31725]  5289  5289  5289  5289    68    68    68  1683  1683  1683  1683
## [31736]  2607  2607  2607  2607   446   446   446  1191  1191  1191  1191
## [31747]   414   414   414   414  2073  2073  2073  2073  2010  2010  2010
## [31758]  2010   119   119   119   675   675   675   675  1104  1104  1104
## [31769]  1104   726   726   726   726  1470  1470  1470  1470   615   615
## [31780]   615   615  2025  2025  2025  2025   534   534   534   534  6561
## [31791]  6561  6561  6561   963   963   963   963   663   663   663   663
## [31802]  1995  1995  1995  1995  2058  2058  2058  2058   891   891   891
## [31813]   891  1101  1101  1101  1101   765   765   765   765  1791  1791
## [31824]  1791  1791   813   813   813   813  1227  1227  1227  1227    90
## [31835]    90    90   936   936   936   936  3096  3096  3096  3096  1224
## [31846]  1224  1224  1224  1398  1398  1398  1398  2895  2895  2895  2895
## [31857]   828   828   828   828  3102  3102  3102  3102   449   449   449
## [31868]  2226  2226  2226  2226   813   813   813   813  3813  3813  3813
## [31879]  3813  3312  3312  3312  3312   283   283   283  4431  4431  4431
## [31890]  4431  3120  3120  3120  3120  2496  2496  2496  2496  1992  1992
## [31901]  1992  1992  1029  1029  1029  1029  2307  2307  2307  2307  2058
## [31912]  2058  2058  2058   369   369   369   369  2841  2841  2841  2841
## [31923]   651   651   651   651  1098  1098  1098  1098   591   591   591
## [31934]   591  1572  1572  1572  1572  2847  2847   718  2847   718   792
## [31945]   684    34  2055   798   798   798   798  1878  1878  1878  1878
## [31956]  1284  1284  1284  1284   987   987   987   987  2064  2064  2064
## [31967]  2064 13365 13365 13365 13365  2613  2613  2613  2613    70    70
## [31978]    70    94    94    94  1803  1803  1803  1803  2307  2307  2307
## [31989]  2307  1002  1002  1002  1002  4110  4110  4110  4110  1800  1800
## [32000]  1800  1800   104   104   104  1056  1056  1056  1056   552   552
## [32011]   552   552   606   606   606   606   681   681   681   681  1851
## [32022]  1851  1851  1851  3225  3225  3225  3225   378   378   378   378
## [32033]  2727  2727  2727  2727  7521  7521  7521  7521   573   573   573
## [32044]   573   990   990   990   990  1515  1515  1515  1515   453   453
## [32055]   453   453    89    89    89  2628  2628  2628  2628  2721  2721
## [32066]  2721  2721  1569  1569  1569  1569   780   780   780   780   840
## [32077]   840   840   840  1785  1785  1785  1785  2883  2883  2883  2883
## [32088]  5778  5778  5778  5778  1089  1089  1089  1089   449   449   449
## [32099]    73    73    73   480   480   480   480   714   714   714   714
## [32110]  3693  3693  3693  3693  2964  2964  2964  2964  2115  2115  2115
## [32121]  2115    93    93    93   801   801   801   801   132   132   132
## [32132]  1020  1020  1020  1020  1116  1116  1116  1116   600   600   600
## [32143]   600  4893  4893  4893  4893  2664  2664  2664  2664   573   573
## [32154]   573   573  3084  3084  3084  3084  1866  1866  1866  1866  1215
## [32165]  1215  1215  1215  1737  1737  1737  1737   279   279   279   279
## [32176]  4131  4131  4131  4131   645   645   645   645   948   948   948
## [32187]   948  2139  2139  2139  2139   996   996   996   996   630   630
## [32198]   630   630   858   858   858   858  3126  3126  3126  3126  1692
## [32209]  1692  1692  1692   174   174   174   174  1455  1455  1455  1455
## [32220]   510   510   510   510  1548  1548  1548  1548    78    78    78
## [32231]  6096  6096  6096  6096   411   411   411   411   849   849   849
## [32242]   849   432   432   432   432  1932  1932  1932  1932  4071  4071
## [32253]  4071  4071    83    83    83  1686  1686  1686  1686  1476  1476
## [32264]  1476  1476  1500  1500  1500  1500  4041  4041  4041  4041  1281
## [32275]  1281  1281  1281  1083  1083  1083  1083   621   621   621   621
## [32286]   888   888   888   888  1101  1101  1101  1101  2772  2772  2772
## [32297]  2772   102   102   102   525   525   525   525  5043  5043  5043
## [32308]  5043   131   131   131   183   183   183  2368  1412  2368  2368
## [32319]  1412  1347  1458    65   910   417   417   417   417   104   104
## [32330]   104  2778  2778  2778  2778   129   129   129 10716 10716 10716
## [32341] 10716  1695  1695  1695  1695  2168  2168   381  2168   381   705
## [32352]   240  1463   141  3462  3462  3462  3462   183   183   183  4143
## [32363]  4143  4143  4143  1692  1692  1692  1692    73    73    73   744
## [32374]   744   744   744  2502  2502  2502  2502  1440  1440  1440  1440
## [32385]  3225  3225  3225  3225  1099  1099  1099  4254  4254  4254  4254
## [32396]  1977  1977  1977  1977  1929  1929  1929  1929   434   434   321
## [32407]   434   321   357   138   183    77   564   564   564   564  1698
## [32418]  1698  1698  1698  5796  5796  5796  5796   455   455   455   945
## [32429]   945   324   240   378   324   240   378  1482  1482  1482  1482
## [32440]  1686  1686  1686  1686 12552 12552 12552 12552   990   990   990
## [32451]   990  3966  3966  3966  3966  2859  2859  2859  2859   342   342
## [32462]   342   342  1944  1944  1944  1944   951   951   951   951    73
## [32473]    73    73  2298  2298  2298  2298  5034  5034  5034  5034  7107
## [32484]  7107  7107  7107  3300  3300  3300  3300   828   828   828   828
## [32495]    70    70    70   816   816   816   816  1461  1461  1461  1461
## [32506]  1929  1929  1929  1929   324   324   324   324    72    72    72
## [32517]   381   381   381   381  2478  2478  2478  2478  1224  1224  1224
## [32528]  1224  2214  2214  2214  2214   609   609   609   609   384   384
## [32539]   384   384  1743  1743  1743  1743   246   246   246   246    69
## [32550]    69    69   116   116   116  1062  1062  1062  1062  1134  1134
## [32561]  1134  1134  8346  8346  8346  8346  1503  1503  1503  1503  2577
## [32572]  2577  2577  2577   678   678   678   678   504   504   504   504
## [32583]  2784  2784  2784  2784   522   522   522   522    70    70    70
## [32594]  2076  2076  2076  2076  1395  1395  1395  1395   858   858   858
## [32605]   858  1131  1131  1131  1131  1395  1395  1395  1395  3849  3849
## [32616]  3849  3849   459   459   459   459  1494  1494  1494  1494  2574
## [32627]  2574  2574  2574   104   104   104  1530  1530  1530  1530  4887
## [32638]  4887  4887  4887  1575  1575  1575  1575  2409  2409  2409  2409
## [32649]  1188  1188  1188  1188  1764  1764  1764  1764   378   378   378
## [32660]   378   909   909   909   909  4809  4809  4809  4809  2037  2037
## [32671]  2037  2037   114   114   114  2499  2499  2499  2499  1479  1479
## [32682]  1479  1479  1026  1026  1026  1026  2385  2385  2385  2385  1356
## [32693]  1356  1356  1356  2958  2958  2958  2958  5793  5793  5793  5793
## [32704]  1407  1407  1407  1407  2594  2594   623   623  2594   732   615
## [32715]     8  1862   342   342   342   342 20304 20304 20304 20304   486
## [32726]   486   486   486    83    83    83  1596  1596  1596  1596  1968
## [32737]  1968  1968  1968  2445  2445  2445  2445  1392  1392  1392  1392
## [32748]   119   119   119  3657  3657  3657  3657  1395  1395  1395  1395
## [32759]  1278  1278  1278  1278   885   885   885   885  1713  1713  1713
## [32770]  1713  2940  2940  2940  2940  1281  1281  1281  1281   579   579
## [32781]   579   579  2787  2787  2787  2787   804   804   804   804   783
## [32792]   783   783   783  1542  1542  1542  1542  1834  1834   675   105
## [32803]   225   360   465   675   105   225   360   465   312   312   312
## [32814]   312   858   858   858   858  3168  3168  3168  3168  2115  2115
## [32825]  2115  2115  1689  1689  1689  1689  3123  3123  3123  3123  1335
## [32836]  1335  1335  1335  2034  2034  2034  2034  1341  1341  1341  1341
## [32847]   927   927   927   927    70    70    70  3396  3396  3396  3396
## [32858]  1647  1647  1647  1647   639   639   639   639   891   891   891
## [32869]   891  1187  1187   429   756   429   756  1446  1446  1446  1446
## [32880]  1068  1068  1068  1068   131   131   131  3237  3237  3237  3237
## [32891]    84    84    84   131   131   131   984   984   984   984  2178
## [32902]  2178  2178  2178  3099  3099  3099  3099  1785  1785  1785  1785
## [32913]   825   825   825   825  1434  1434  1434  1434  2658  2658  2658
## [32924]  2658  3945  3945  3945  3945  5811  5811  5811  5811  9339  9339
## [32935]  9339  9339  3490  1287  3490  3490  1287  1188  1365    99  2125
## [32946]  2607  2607  2607  2607  3666  3666  3666  3666  1497  1497  1497
## [32957]  1497    70    70    70    85    85    85   300   300   300   300
## [32968]  2883  2883  2883  2883  2097  2097  2097  2097  1346  1346   855
## [32979]   489   855   489   804   804   804   804  1737  1737  1737  1737
## [32990]  7974  7974  7974  7974  4230  4230  4230  4230   990   990   990
## [33001]   990  4617  4617  4617  4617  1525  1525  1525    72    72    72
## [33012]   501   501   501   501  3237  3237  3237  3237  3771  3771  3771
## [33023]  3771  1125  1125  1125  1125  1296  1296  1296  1296   591   591
## [33034]   591   591   921   921   921   921  1740  1740  1740  1740  1611
## [33045]  1611  1611  1611  3900  3900  3900  3900  2178  2178  2178  2178
## [33056]   507   507   507   507   804   804   804   804   717   717   717
## [33067]   717   321   321   321   321   552   552   552   552  7284  7284
## [33078]  7284  7284  1995  1995  1995  1995  3015  3015  3015  3015   594
## [33089]   594   594   594   276   276   276   276   576   576   576   576
## [33100]  1443  1443  1443  1443  2472  2472  2472  2472   777   777   777
## [33111]   777  1140  1140  1140  1140  3381  3381  3381  3381  3546  3546
## [33122]  3546  3546  1185  1185  1185  1185   612   612   612   612   116
## [33133]   116   116  1344  1344  1344  1344  2385  2385  2385  2385  3345
## [33144]  3345  3345  3345  2511  2511  2511  2511  3531  3531  3531  3531
## [33155]    75    75    75   570   570   570   570  3954  3954  3954  3954
## [33166]    72    72    72  1783  1783  1783  3111  3111  3111  3111  4530
## [33177]  4530  4530  4530  1464  1464  1464  1464  1026  1026  1026  1026
## [33188]   396   396   396   396   741   741   741   741   918   918   918
## [33199]   918  2706  2706  2706  2706   459   459   459   459  4005  4005
## [33210]  4005  4005  1626  1626  1626  1626   528   528   528   528  1224
## [33221]  1224  1224  1224  4584  4584  4584  4584  2082  2082  2082  2082
## [33232]  1788  1788  1788  1788  2310  2310  2310  2310    87    87    87
## [33243]   618   618   618   618   867   867   867   867  1008  1008  1008
## [33254]  1008   615   615   615   615  1323  1323  1323  1323  3183  3183
## [33265]  3183  3183  1464  1464  1464  1464  4425  4425  4425  4425  1260
## [33276]  1260  1260  1260   615   615   615   615  1704  1704  1704  1704
## [33287]  2160  2160  2160  2160  1059  1059  1059  1059   864   864   864
## [33298]   864   813   813   813   813  1161  1161  1161  1161  1256  1256
## [33309]   373   882   372   882     1   978   978   978   978  1122  1122
## [33320]  1122  1122  4974  4974  4974  4974  1476  1476  1476  1476    96
## [33331]    96    96   978   978   978   978  2808  2808  2808  2808  2538
## [33342]  2538  2538  2538  1272  1272  1272  1272  2271  2271  2271  2271
## [33353]   234   234   234   234  2685  2685  2685  2685    70    70    70
## [33364]  2046  2046  2046  2046  2925  2925  2925  2925  1995  1995  1995
## [33375]  1995   744   744   744   744  3354  3354  3354  3354  1917  1917
## [33386]  1917  1917  4283  4283   717   411   753  2397   717   411   753
## [33397]  2397  1146  1146  1146  1146  1680  1680  1680  1680  2157  2157
## [33408]  2157  2157  2223  2223  2223  2223  1398  1398  1398  1398  1245
## [33419]  1245  1245  1245   753   753   753   753 17271 17271 17271 17271
## [33430]  2034  2034  2034  2034  1020  1020  1020  1020  4113  4113  4113
## [33441]  4113  1470  1470  1470  1470  1740  1740  1740  1740  5811  5811
## [33452]  5811  5811  2514  2514  2514  2514  1473  1473  1473  1473   354
## [33463]   354   354   354  2136  2136  2136  2136   417   417   417   417
## [33474]  1458  1458  1458  1458  2391  2391  2391  2391  1554  1554  1554
## [33485]  1554  3075  3075  3075  3075   810   810   810   810  1515  1515
## [33496]  1515  1515   993   993   993   993  2415  2415  2415  2415  2772
## [33507]  2772  2772  2772    81    81    81  1158  1158  1158  1158   948
## [33518]   948   948   948    93    93    93   789   789   789   789   114
## [33529]   114   114  1377  1377  1377  1377   231   231   231   231  1128
## [33540]  1128  1128  1128    91    91    91  2844  2844  2844  2844  1530
## [33551]  1530  1530  1530   699   699   699   699  1521  1521  1521  1521
## [33562]  2262  2262  2262  2262  2790  2790  2790  2790  1650  1650  1650
## [33573]  1650   600   600   600   600  1824  1824  1824  1824  1395  1395
## [33584]  1395  1395  1496  1496   423  1071   423  1071   441   441   441
## [33595]   441  1851  1851  1851  1851  1509  1509  1509  1509  1572  1572
## [33606]  1572  1572   438   438   438   438  1515  1515  1515  1515   690
## [33617]   690   690   690  2097  2097  2097  2097  1602  1602  1602  1602
## [33628]   909   909   909   909   948   948   948   948    78    78    78
## [33639]  3222  3222  3222  3222  1002  1002  1002  1002  1056  1056  1056
## [33650]  1056  2106  2106  2106  2106  9171  9171  9171  9171  1444  1444
## [33661]   902  1444   902  1401   840    43    62  2610  2610  2610  2610
## [33672]   939   939   939   939   966   966   966   966  1722  1722  1722
## [33683]  1722  2733  2733  2733  2733  6354  6354  6354  6354  1044  1044
## [33694]  1044  1044  1233  1233  1233  1233  2541  2541  2541  2541   455
## [33705]   455   455  2193  2193  2193  2193  1311  1311  1311  1311  3879
## [33716]  3879  3879  3879  1926  1926  1926  1926  2901  2901  2901  2901
## [33727]   819   819   819   819  2439  2439  2439  2439    72    72    72
## [33738]  3711  3711  3711  3711  1509  1509  1509  1509    72    72    72
## [33749]  8766  8766  8766  8766  3090  3090  3090  3090   894   894   894
## [33760]   894   666   666   666   666    92    92    92  2052  2052  2052
## [33771]  2052  1638  1638  1638  1638  1947  1947  1947  1947   555   555
## [33782]   555   555  1017  1017  1017  1017   366   366   366   366  2172
## [33793]  2172  2172  2172  2178  2178  2178  2178  2175  2175  2175  2175
## [33804]  4161  4161  4161  4161  2682  2682  2682  2682  3639  3639  3639
## [33815]  3639    78    78    78  2355  2355  2355  2355  2574  2574  2574
## [33826]  2574    78    78    78  2040  2040  2040  2040  2019  2019  2019
## [33837]  2019   639   639   639   639  8271  8271  8271  8271   294   294
## [33848]   294   294   885   885   885   885  1248  1248  1248  1248  2124
## [33859]  2124  2124  2124   543   543   543   543   993   993   993   630
## [33870]   630   630   630   387   387   387   387  1779  1779  1779  1779
## [33881]   828   828   828   828  3519  3519  3519  3519   978   978   978
## [33892]   978  2232  2232  2232  2232  2571  2571  2571  2571  1014  1014
## [33903]  1014  1014   456   456   456   456   909   909   909   909   465
## [33914]   465   465   465  1242  1242  1242  1242  2550  2550  2550  2550
## [33925]   771   771   771   771   227   227   227   423   423   423   423
## [33936]   408   408   408   408   954   954   954   954    85    85    85
## [33947]  2463  2463  2463  2463    91    91    91  1572  1572  1572  1572
## [33958]  2478  2478  2478  2478  1260  1260  1260  1260   711   711   711
## [33969]   711  2019  2019  2019  2019  1128  1128  1128  1128  1884  1884
## [33980]  1884  1884  1641  1641  1641  1641  1050  1050  1050  1050   561
## [33991]   561   561   561   498   498   498   498   558   558   558   558
## [34002]   426   426   426   426   654   654   654   654  2532  2532  2532
## [34013]  2532  2772  2772  2772  2772  2451  2451  2451  2451 10608 10608
## [34024] 10608 10608   435   435   435   435  1617  1617  1617  1617  1281
## [34035]  1281  1281  1281  1452  1452  1452  1452  1140  1140  1140  1140
## [34046]    82    82    82  1884  1884  1884  1884    89    89    89  2328
## [34057]  2328  2328  2328   927   927   927   927   744   744   744   744
## [34068]   861   861   861   861  1092  1092  1092  1092  2292  2292  2292
## [34079]  2292  3297  3297  3297  3297  3414  3414  3414  3414   168   168
## [34090]   168   168  2532  2532  2532  2532  3195  3195  3195  3195   666
## [34101]   666   666   666   531   531   531   531   987   987   987   987
## [34112]    78    78    78   978   978   978   978    66    66    66  1914
## [34123]  1914  1914  1914  1527  1527  1527  1527   621   621   621   621
## [34134]    81    81    81  2424  2424  2424  2424   774   774   774   774
## [34145]  2204  2204  2204   222   222   222   222   609   609   609   609
## [34156]  2106  2106  2106  2106   855   855   855   855  2916  2916  2916
## [34167]  2916  1101  1101  1101  1101  1104  1104  1104  1104   102   102
## [34178]   102   771   771   771   771  3309  3309  3309  3309   276   276
## [34189]   276   276   513   513   513   513   534   534   534   534   807
## [34200]   807   807   807   336   336   336   336  1167  1167  1167  1167
## [34211]   363   363   363   363  1773  1773  1773  1773   477   477   477
## [34222]   477  2304  2304  2304  2304  1344  1344  1344  1344  7899  7899
## [34233]  7899  7899   693   693   693   693   528   528   528   528  2817
## [34244]  2817  2817  2817  2157  2157  2157  2157   342   342   342   342
## [34255]  1353  1353  1353  1353  1683  1683  1683  1683   458   458   458
## [34266]  1347  1347  1347  1347  1260  1260  1260  1260   420   420   420
## [34277]   420    86    86    86  3939  3939  3939  3939  1464  1464  1464
## [34288]  1464  6489  6489  6489  6489   283   283   283  1860  1860  1860
## [34299]  1860  1467  1467  1467  1467  2391  2391  2391  2391   351   351
## [34310]   351   351  2331  2331  2331  2331   837   837   837   837  2061
## [34321]  2061  2061  2061  3564  3564  3564  3564    83    83    83  1047
## [34332]  1047  1047  1047  1248  1248  1248  1248    72    72    72  1770
## [34343]  1770  1770  1770  1161  1161  1161  1161    89    89    89    83
## [34354]    83    83  2721  2721  2721  2721  2649  2649  2649  2649  1650
## [34365]  1650  1650  1650   402   402   402   402  8451  8451  8451  8451
## [34376]   381   381   381   381   174   174   174   174  4149  4149  4149
## [34387]  4149   438   438   438   438  2994  2994  2994  2994   525   525
## [34398]   525   525   102   102   102  2469  2469  2469  2469   570   570
## [34409]   570   570  5817  5817  5817  5817  2532  2532  2532  2532   492
## [34420]   492   492   492  3000  3000  3000  3000  2898  2898  2898  2898
## [34431]   446   446   446  1008  1008  1008  1008  2700  2700  2700  2700
## [34442]  1941  1941  1941  1941    73    73    73   420   420   420   420
## [34453]  1173  1173  1173  1173   846   846   846   846  2031  2031  2031
## [34464]  2031  1335  1335  1335  1335  1311  1311  1311  1311  3378  3378
## [34475]  3378  3378  6444  6444  6444  6444  1722  1722  1722  1722  1257
## [34486]  1257  1257  1257  1758  1758  1758  1758    95    95    95   345
## [34497]   345   345   345  1698  1698  1698  1698  2091  2091  2091  2091
## [34508]   116   116   116   648   648   648   648    81    81    81  6372
## [34519]  6372  6372  6372   369   369   369   369  1818  1818  1818  1818
## [34530]  3054  3054  3054  3054   666   666   666   666  1539  1539  1539
## [34541]  1539    90    90    90   339   339   339   339  1599  1599  1599
## [34552]  1599   204   204   204   204    82    82    82  1299  1299  1299
## [34563]  1299   981   981   981   981  2037  2037  2037  2037  7317  7317
## [34574]  7317  7317  6102  6102  6102  6102   393   393   393   393  1602
## [34585]  1602  1602  1602  5685  5685  5685  5685    68    68    68  1755
## [34596]  1755  1755  1755  2217  2217  2217  2217  3786  3786  3786  3786
## [34607]  3594  3594  3594  3594  1800  1800  1800  1800   336   336   336
## [34618]   336   606   606   606   606   735   735   735   735  1083  1083
## [34629]  1083  1083  1662  1662  1662  1662  2334  2334  2334  2334  1833
## [34640]  1833  1833  1833  3840  3840  3840  3840  8406  8406  8406  8406
## [34651]   942   942   942   942   483   483   483   483   462   462   462
## [34662]   462  1488  1488  1488  1488  4974  4974  4974  4974  3183  3183
## [34673]  3183  3183  1794  1794  1794  1794  1539  1539  1539  1539  1560
## [34684]  1560  1560  1560  1299  1299  1299  1299  6582  6582  6582  6582
## [34695]  2043  2043  2043  2043  2070  2070  2070  2070   750   750   750
## [34706]   750  1548  1548  1548  1548  4833  4833  4833  4833   300   300
## [34717]   300   300  1029  1029  1029  1029   387   387   387   387  3474
## [34728]  3474  3474  3474   426   426   426   426    86    86    86   453
## [34739]   453   453   453  3219  3219  3219  3219  2811  2811  2811  2811
## [34750]  1167  1167  1167  1167    72    72    72   660   660   660   660
## [34761]   638   638   638   597    41   104   104   104  2474  2474   422
## [34772]   422  2474   933   402    20  1541  1539  1539  1539  1539   861
## [34783]   861   861   861  3813  3813  3813  3813 12000 12000 12000 12000
## [34794]   900   900   900   900  2445  2445  2445  2445  4473  4473  4473
## [34805]  4473  1440  1440  1440  1440  1722  1722  1722  1722  1356  1356
## [34816]  1356  1356  1378  1378   642   675   642   675  3726  3726  3726
## [34827]  3726   438   438   438   438  2754  2754  2754  2754  1674  1674
## [34838]  1674  1674  2553  2553  2553  2553  1164  1164  1164  1164  1395
## [34849]  1395  1395  1395  1071  1071  1071  1071   720   720   720   720
## [34860]  1503  1503  1503  1503   458   458   458    85    85    85  1884
## [34871]  1884  1884  1884   630   630   630   630  1842  1842  1842  1842
## [34882]  1653  1653  1653  1653  3373  3373  2583  2583  3373  3027  2529
## [34893]    54   346  1296  1296  1296  1296   945   945   945   945   339
## [34904]   339   339   339  2598  2598  2598  2598  1272  1272  1272  1272
## [34915]  1569  1569  1569  1569   273   273   273   273  1668  1668  1668
## [34926]  1668  1665  1665  1665  1665   501   501   501   501    81    81
## [34937]    81   906   906   906   906  1698  1698  1698  1698  4272  4272
## [34948]  4272  4272  2142  2142  2142  2142  5805  5805  5805  5805   693
## [34959]   693   693   693  1872  1872  1872  1872  2196  2196  2196  2196
## [34970]  2031  2031  2031  2031  2310  2310  2310  2310  1026  1026  1026
## [34981]  1026   831   831   831   831   759   759   759   759   891   891
## [34992]   891   891  1512  1512  1512  1512   690   690   690   690  4410
## [35003]  4410  4410  4410  1278  1278  1278  1278  2184  2184  2184  2184
## [35014]  2142  2142  2142  2142  5304  5304  5304  5304  3513  3513  3513
## [35025]  3513  4272  4272  4272  4272  1809  1809  1809  1809    69    69
## [35036]    69  1509  1509  1509  1509  1860  1860  1860  1860  1374  1374
## [35047]  1374  1374   357   357   357   357  1332  1332  1332  1332  1101
## [35058]  1101  1101  1101  2307  2307  2307  2307   240   240   240   240
## [35069]  5316  5316  5316  5316  1503  1503  1503  1503  1668  1668  1668
## [35080]  1668  4485  4485  4485  4485  2187  2187  2187  2187   825   825
## [35091]   825   825   537   537   537   537   999   999   999   999    86
## [35102]    86    86  3144  3144  3144  3144    73    73    73   729   729
## [35113]   729   729   444   444   444   444  4569  4569  4569  4569  1158
## [35124]  1158  1158  1158  2796  2796  2796  2796  5265  5265  5265  5265
## [35135]   267   267   267   267  1780  1780  1780  1386  1386  1386  1386
## [35146]  2004  2004  2004  2004  1485  1485  1485  1485   693   693   693
## [35157]   693  6795  6795  6795  6795   741   741   741   741  2154  2154
## [35168]  2154  2154    95    95    95    90    90    90  1890  1890  1890
## [35179]  1890  1086  1086  1086  1086  3258  3258  3258  3258  1794  1794
## [35190]  1794  1794   693   693   582   693   582   630   201    63   381
## [35201]  4275  4275  4275  4275  5295  5295  5295  5295  1911  1911  1911
## [35212]  1911  2145  2145  2145  2145  1281  1281  1281  1281    68    68
## [35223]    68  1377  1377  1377  1377  1761  1761  1761  1761  1287  1287
## [35234]  1287  1287  2364  2364  2364  2364   927   927   927   927  2562
## [35245]  2562  2562  2562  2613  2613  2613  2613   405   405   405   405
## [35256]    71    71    71   975   975   975   975  1236  1236  1236  1236
## [35267]    76    76    76  1611  1611  1611  1611  1020  1020  1020  1020
## [35278]   906   906   906   906   792   792   792   792  2544  2544  2544
## [35289]  2544  3597  3597  3597  3597  1242  1242  1242  1242  3939  3939
## [35300]  3939  3939  3687  3687  3687  3687  1497  1497  1497  1497   720
## [35311]   720   720   720   906   906   906   906  1584  1584  1584  1584
## [35322]  2031  2031  2031  2031   300   300   300   300    68    68    68
## [35333]   579   579   579   579  4180  3715  4180  3715  4180  3534  3777
## [35344]   181   403  1671  1671  1671  1671  1695  1695  1695  1695  2940
## [35355]  2940  2940  2940  1629  1629  1629  1629  1491  1491  1491  1491
## [35366]   582   582   582   582  2037  2037  2037  2037   519   519   519
## [35377]   519  2235  2235  2235  2235   987   987   987   987  1194  1194
## [35388]  1194  1194  1476  1476  1476  1476  3390  3390  3390  3390  3303
## [35399]  3303  3303  3303   339   339   339   339  1674  1674  1674  1674
## [35410]  1890  1890  1890  1890  2976  2976  2976  2976    68    68    68
## [35421]  1227  1227  1227  1227  1791  1791  1791  1791  1395  1395  1395
## [35432]  1395  1671  1671  1671  1671  1092  1092  1092  1092  1542  1542
## [35443]  1542  1542  4554  4554  4554  4554  5097  5097  5097  5097    73
## [35454]    73    73   732   732   732   732  1182  1182  1182  1182   104
## [35465]   104   104    91    91    91  2127  2127  2127  2127  2727  2727
## [35476]  2727  2727  1647  1647  1647  1647   543   543   543   543  1197
## [35487]  1197  1197  1197  2154  2154  2154  2154   879   879   879   879
## [35498]  1143  1143  1143  1143   999   999   999   999  1995  1995  1995
## [35509]  1995  1395  1395  1395  1395  2292  2292  2292  2292   624   624
## [35520]   624   624  4131  4131  4131  4131  1866  1866  1866  1866  1536
## [35531]  1536  1536  1536    99    99    99 11277 11277 11277 11277  3204
## [35542]  3204  3204  3204  1911  1911  1911  1911  1140  1140  1140  1140
## [35553]  1842  1842  1842  1842    74    74    74  1620  1620  1620  1620
## [35564]  1566  1566  1566  1566  1674  1674  1674  1674   411   411   411
## [35575]   411  2589  2589  2589  2589  2070  2070  2070  2070  5769  5769
## [35586]  5769  5769  1647  1647  1647  1647  1044  1044  1044  1044  3735
## [35597]  3735  3735  3735  1170  1170  1170  1170    85    85    85   372
## [35608]   372   372  1971  1971  1971  1971  1503  1503  1503  1503  3195
## [35619]  3195  3195  3195  2511  2511  2511  2511  2712  2712  2712  2712
## [35630]   474   474   474   474    65    65    65   522   522   522   522
## [35641]  1344  1344  1344  1344  1113  1113  1113  1113  2268  2268  2268
## [35652]  2268  2307  2307  2307  2307  1176  1176  1176  1176  5661  5661
## [35663]  5661  5661  5238  5238  5238  5238  1123  1123   699   423   699
## [35674]   423  1077  1077  1077  1077  2262  2262  2262  2262  3381  3381
## [35685]  3381  3381  2652  2652  2652  2652   119   119   119  2664  2664
## [35696]  2664  2664   669   669   669   669  1780  1780  1780  4365  4365
## [35707]  4365  4365  2502  2502  2502  2502    78    78    78  3378  3378
## [35718]  3378  3378  2460  2460  2460  2460   858   858   858   858  1719
## [35729]  1719  1719  1719   969   969   969   969    91    91    91  2313
## [35740]  2313  2313  2313   441   441   441   441   720   720   720   720
## [35751]  2103  2103  2103  2103  1008  1008  1008  1008   474   474   474
## [35762]   474  1404  1404  1404  1404   501   501   501   501  6972  6972
## [35773]  6972  6972   597   597   597   597  1632  1632  1632  1632  5016
## [35784]  5016  5016  5016  1971  1971  1971  1971   789   789   789   789
## [35795]  1866  1866  1866  1866  3930  3930  3930  3930  3155   996  3155
## [35806]  3155   996  1239   987  1916     9  1278  1278  1278  1278   327
## [35817]   327   327   327  2577  2577  2577  2577   432   432   432   432
## [35828]   660   660   660   660  1890  1890  1890  1890  1686  1686  1686
## [35839]  1686  1167  1167  1167  1167  4626  4626  4626  4626   432   432
## [35850]   432   432   621   621   621   621   837   837   837   837  1877
## [35861]  1877   934  1877   934  1011   906   866    28  2184  2184  2184
## [35872]  2184    70    70    70  1689  1689  1689  1689  2028  2028  2028
## [35883]  2028   366   366   366   366  1251  1251  1251  1251  1560  1560
## [35894]  1560  1560   576   576   576   576   387   387   387   387    72
## [35905]    72    72   426   426   426   426  2430  2430  2430  2430  3207
## [35916]  3207  3207  3207  1533  1533  1533  1533  1029  1029  1029  1029
## [35927]  1464  1464  1464  1464   366   366   366   366   288   288   288
## [35938]   288   594   594   594   594   720   720   720   720   870   870
## [35949]   870   870   708   708   708   708  1773  1773  1773  1773  3225
## [35960]  3225  3225  3225  1077  1077  1077  1077  1551  1551  1551  1551
## [35971]  2550  2550  2550  2550  3834  3834  3834  3834  3261  3261  3261
## [35982]  3261    86    86    86  1134  1134  1134  1134  4098  4098  4098
## [35993]  4098  2169  2169  2169  2169  1821  1821  1821  1821  1206  1206
## [36004]  1206  1206   840   840   840   840  1515  1515  1515  1515  1695
## [36015]  1695  1695  1695   597   597   597   597 14820 14820 14820 14820
## [36026]  1338  1338  1338  1338  2040  2040  2040  2040   939   939   939
## [36037]   939   449   449   449   387   387   387   387  1029  1029  1029
## [36048]  1029  1005  1005  1005  1005  1401  1401  1401  1401  1593  1593
## [36059]  1593  1593   972   972   972   972  1773  1773  1773  1773   954
## [36070]   954   954   954  1023  1023  1023  1023  1347  1347  1347  1347
## [36081]   810   810   810   810   621   621   621   621   702   702   702
## [36092]   702   909   909   909   909  4122  4122  4122  4122   455   455
## [36103]   455 13995 13995 13995 13995  2106  2106  2106  2106   399   399
## [36114]   399   399    82    82    82  2448  2448  2448  2448  2565  2565
## [36125]  2565  2565    96    96    96   375   375   375   375  1044  1044
## [36136]  1044  1044   366   366   366   366   675   675   675   675    76
## [36147]    76    76   621   621   621   621   597   597   597   597   357
## [36158]   357   357   357  3060  3060  3060  3060  2451  2451  2451  2451
## [36169]  1731  1731  1731  1731  1773  1773  1773  1773  1272  1272  1272
## [36180]  1272  2937  2937  2937  2937   519   519   519   519  1923  1923
## [36191]  1923  1923    73    73    73   891   891   891   891  1377  1377
## [36202]  1377  1377  1377  1377  1377  1377  7500  7500  7500  7500  4071
## [36213]  4071  4071  4071  1863  1863  1863  1863  3732  3732  3732  3732
## [36224]  3153  3153  3153  3153   192   192   192   192  1827  1827  1827
## [36235]  1827 11610 11610  1126 11610  1126  1341  1095    31 10269   570
## [36246]   570   570   570   453   453   453   453  4110  4110  4110  4110
## [36257]  4779  4779  4779  4779  4356  4356  4356  4356   861   861   861
## [36268]   861  2355  2355  2355  2355  1443  1443  1443  1443   399   399
## [36279]   399   399  1632  1632  1632  1632  1569  1569  1569  1569  1365
## [36290]  1365  1365  1365  2634  2634  2634  2634  1524  1524  1524  1524
## [36301]  1074  1074  1074  1074  2994  2994  2994  2994  1338  1338  1338
## [36312]  1338  3219  3219  3219  3219  1410  1410  1410  1410   342   342
## [36323]   342   342  2589  2589  2589  2589   390   390   390   390   960
## [36334]   960   960   960  2571  2571  2571  2571  3045  3045  3045  3045
## [36345]  3843  3843  3843  3843    78    78    78  1191  1191  1191  1191
## [36356]  1761  1761  1761  1761  2814  2814  2814  2814   435   435   435
## [36367]   435   462   462   462   462  4569  4569  4569  4569    74    74
## [36378]    74   315   315   315   315    73    73    73   138   138   138
## [36389]   948   948   948   948   969   969   969   969   795   795   795
## [36400]   795   990   990   990   990  2691  2691  2691  2691   303   303
## [36411]   303   303  4464  4464  4464  4464  1494  1494  1494  1494   291
## [36422]   291   291   291  1311  1311  1311  1311  1083  1083  1083  1083
## [36433]  1488  1488  1488  1488   116   116   116  1425  1425  1425  1425
## [36444]   894   894   894   894   480   480   480   480   435   435   435
## [36455]   435  1638  1638  1638  1638  1029  1029  1029  1029   381   381
## [36466]   381   381  1578  1578  1578  1578  9039  9039  9039  9039   903
## [36477]   903   903   903  1599  1599  1599  1599  1809  1809  1809  1809
## [36488]   882   882   882   882  1014  1014  1014  1014  3516  3516  3516
## [36499]  3516    73    73    73  3444  3444  3444  3444  2178  2178  2178
## [36510]  2178  3249  3249  3249  3249    72    72    72  1848  1848  1848
## [36521]  1848  1506  1506  1506  1506   624   624   624   624  1218  1218
## [36532]  1218  1218  1506  1506  1506  1506  1944  1944  1944  1944  1965
## [36543]  1965  1965  1965  1968  1968  1968  1968   891   891   891   891
## [36554]  1671  1671  1671  1671  1722  1722  1722  1722  2211  2211  2211
## [36565]  2211  1383  1383  1383  1383  7362  7362  7362  7362  2133  2133
## [36576]  2133  2133  5391  5391  5391  5391   360   360   360   360  1863
## [36587]  1863  1863  1863   759   759   759   759    95    95    95   642
## [36598]   642   642   642   747   747   747   747  7149  7149  7149  7149
## [36609]   591   591   591   591  1614  1614  1614  1614  1482  1482  1482
## [36620]  1482  5805  5805  5805  5805   957   957   957   957   906   906
## [36631]   906   906    72    72    72   846   846   846   846  1116  1116
## [36642]  1116  1116    70    70    70  5370  5370  5370  5370  1194  1194
## [36653]  1194  1194  3651  3651  3651  3651  1044  1044  1044  1044  1788
## [36664]  1788  1788  1788  1584  1584  1584  1584   387   387   387   387
## [36675]   687   687   687   687  1185  1185  1185  1185  2925  2925  2925
## [36686]  2925  1005  1005  1005  1005   744   744   744   744   801   801
## [36697]   801   801  3444  3444  3444  3444  1155  1155  1155  1155  1143
## [36708]  1143  1143  1143  1245  1245  1245  1245  1320  1320  1320  1320
## [36719]   321   321   321   321  1386  1386  1386  1386  2787  2787  2787
## [36730]  2787   423   423   423   423  1515  1515  1515  1515  3537  3537
## [36741]  3537  3537   300   300   300   300   441   441   441   441  1776
## [36752]  1776  1776  1776  1359  1359  1359  1359   402   402   402   402
## [36763]  2301  2301  2301  2301  2475  2475  2475  2475   131   131   131
## [36774]  1008  1008  1008  1008   330   330   330   330   879   879   879
## [36785]   879  1437  1437  1437  1437  2286  2286  2286  2286  4755  4755
## [36796]  4755  4755  1149  1149  1149  1149  1377  1377  1377  1377    74
## [36807]    74    74  4731  4731  4731  4731  1308  1308  1308  1308    70
## [36818]    70    70   789   789   789   789   113   113   113  6252  6252
## [36829]  6252  6252  5037  5037  5037  5037   393   393   393   393    91
## [36840]    91    91   270   270   270   270  1644  1644  1644  1644   131
## [36851]   131   131  2133  2133  2133  2133   528   528   528   528    64
## [36862]    64    64  1017  1017  1017  1017  3012  3012  3012  3012  3972
## [36873]  3972  3972  3972  1308  1308  1308  1308  1926  1926  1926  1926
## [36884]  5175  5175  5175  5175  7200  7200  7200  7200  1095  1095  1095
## [36895]  1095   963   963   963   963   810   810   810   810  3879  3879
## [36906]  3879  3879  1050  1050  1050  1050  4221  4221  4221  4221  8766
## [36917]  8766  8766  8766  3849  3849  3849  3849  1158  1158  1158  1158
## [36928]   798   798   798   798  3340  3340  3340  3339     1  2388  2388
## [36939]  2388  2388  1401  1401  1401  1401  4572  4572  4572  4572   222
## [36950]   222   222   222  1137  1137  1137  1137   351   351   351   351
## [36961]  1971  1971  1971  1971  1701  1701  1701  1701   807   807   807
## [36972]   807  1737  1737  1737  1737   822   822   822   822  4797  4797
## [36983]  4797  4797   119   119   119  2034  2034  2034  2034  1512  1512
## [36994]  1512  1512   282   282   282   282  1752  1752  1654  1654  1752
## [37005]  1665  1500   154    87   813   813   813   813   104   104   104
## [37016]  2559  2559  2559  2559   399   399   399   399  1470  1470  1470
## [37027]  1470  1719  1719  1719  1719   283   283   283  1326  1326  1326
## [37038]  1326    89    89    89  3867  3867  3867  3867  4968  4968  4968
## [37049]  4968  1527  1527  1527  1527  1140  1140  1140  1140   426   426
## [37060]   426   426  4041  4041  4041  4041   446   446   446  1800  1800
## [37071]  1800  1800   954   954   954   954  3210  3210  3210  3210  1545
## [37082]  1545  1545  1545  1356  1356  1356  1356   645   645   645   645
## [37093]  1569  1569  1569  1569   108   108   108   657   657   657   657
## [37104]   858   858   858   858   348   348   348   348  3120  3120  3120
## [37115]  3120  1824  1824  1824  1824  1680  1680  1680  1680  1488  1488
## [37126]  1488  1488 10779 10779 10779 10779    81    81    81  1851  1851
## [37137]  1851  1851 11337 11337 11337 11337  3147  3147  3147  3147   315
## [37148]   315   315   315  2445  2445  2445  2445  1725  1725  1725  1725
## [37159]  2979  2979  2979  2979   387   387   387   387   255   255   255
## [37170]   255  2232  2232  2232  2232   594   594   594   594   720   720
## [37181]   720   720  4251  4251  4251  4251  1947  1947  1947  1947  1197
## [37192]  1197  1197  1197  1443  1443  1443  1443   459   459   459   459
## [37203]  1098  1098  1098  1098   606   606   606   606  1470  1470  1470
## [37214]  1470   300   300   300   300    69    69    69   570   570   570
## [37225]   570  3021  3021  3021  3021   450   450   450   450   102   102
## [37236]   102   750   750   750   750  1758  1758  1758  1758  3696  3696
## [37247]  3696  3696  1560  1560  1560  1560  2280  2280  2280  2280   780
## [37258]   780   780   780  1374  1374  1374  1374   762   762   762   762
## [37269]  1935  1935  1935  1935  6630  6630  6630  6630  1707  1707  1707
## [37280]  1707  2496  2496  2496  2496  1023  1023  1023  1023   507   507
## [37291]   507   507  1206  1206  1206  1206    94    94    94   936   936
## [37302]   936   936   807   807   807   807   300   300   300   300
```

Some information can be retrieve directly as object properties using the `$` operator:

```
# list of location types in the resource
table(gr$type)
```

```
##
##            gene            mRNA            exon             CDS
##            9378            8519            9583            8606
##          snoRNA            rRNA three_prime_UTR  five_prime_UTR
##             741              63               8             241
##           ncRNA            tRNA           snRNA
##              83              83               6
```

To subset the GRanges instance, you can use the standard `[` operator:

```
# get the first three ranges
gr[1:3]
```

```
## GRanges object with 3 ranges and 9 metadata columns:
##       seqnames        ranges strand |   source     type     score
##          <Rle>     <IRanges>  <Rle> | <factor> <factor> <numeric>
##   [1]  LmjF.24 117748-119043      + | EuPathDB     gene      <NA>
##   [2]  LmjF.24 117748-119043      + | EuPathDB     mRNA      <NA>
##   [3]  LmjF.24 117748-119043      + | EuPathDB     exon      <NA>
##           phase                   ID                          description
##       <integer>          <character>                          <character>
##   [1]      <NA>         LmjF.24.0370 aspartate aminotransferase, putative
##   [2]      <NA>    LmjF.24.0370:mRNA aspartate aminotransferase, putative
##   [3]      <NA> exon_LmjF.24.0370-E1                                 <NA>
##                  Parent                             Note protein_source_id
##         <CharacterList>                  <CharacterList>       <character>
##   [1]              <NA>                             <NA>              <NA>
##   [2]      LmjF.24.0370 2.6.1.1 (Aspartate transaminase)              <NA>
##   [3] LmjF.24.0370:mRNA                             <NA>              <NA>
##   -------
##   seqinfo: 36 sequences from TriTrypDB-39_LmajorFriedlin genome; no seqlengths
```

```
# get all gene entries on chromosome 4
gr[gr$type == 'gene' & seqnames(gr) == 'LmjF.04']
```

```
## GRanges object with 130 ranges and 9 metadata columns:
##         seqnames        ranges strand |   source     type     score
##            <Rle>     <IRanges>  <Rle> | <factor> <factor> <numeric>
##     [1]  LmjF.04 418659-420857      - | EuPathDB     gene      <NA>
##     [2]  LmjF.04 185923-186489      - | EuPathDB     gene      <NA>
##     [3]  LmjF.04 283441-286785      - | EuPathDB     gene      <NA>
##     [4]  LmjF.04 421926-422858      - | EuPathDB     gene      <NA>
##     [5]  LmjF.04 124169-125230      + | EuPathDB     gene      <NA>
##     ...      ...           ...    ... .      ...      ...       ...
##   [126]  LmjF.04 181903-185242      - | EuPathDB     gene      <NA>
##   [127]  LmjF.04 375010-376536      - | EuPathDB     gene      <NA>
##   [128]  LmjF.04 275783-276241      - | EuPathDB     gene      <NA>
##   [129]  LmjF.04 254218-254724      - | EuPathDB     gene      <NA>
##   [130]  LmjF.04 440646-441581      - | EuPathDB     gene      <NA>
##             phase           ID
##         <integer>  <character>
##     [1]      <NA> LmjF.04.1120
##     [2]      <NA> LmjF.04.0470
##     [3]      <NA> LmjF.04.0700
##     [4]      <NA> LmjF.04.1130
##     [5]      <NA> LmjF.04.0380
##     ...       ...          ...
##   [126]      <NA> LmjF.04.0465
##   [127]      <NA> LmjF.04.0970
##   [128]      <NA> LmjF.04.0670
##   [129]      <NA> LmjF.04.0610
##   [130]      <NA> LmjF.04.1170
##                                            description          Parent
##                                            <character> <CharacterList>
##     [1]                hypothetical protein, conserved            <NA>
##     [2]            60S ribosomal protein L11 (L5, L16)            <NA>
##     [3]                hypothetical protein, conserved            <NA>
##     [4] cytochrome c oxidase assembly factor, putative            <NA>
##     [5]     phytanoyl-CoA dioxygenase (PhyH), putative            <NA>
##     ...                                            ...             ...
##   [126]                           hypothetical protein            <NA>
##   [127]                hypothetical protein, conserved            <NA>
##   [128]                hypothetical protein, conserved            <NA>
##   [129]                hypothetical protein, conserved            <NA>
##   [130]            Double RNA binding domain protein 3            <NA>
##                    Note protein_source_id
##         <CharacterList>       <character>
##     [1]            <NA>              <NA>
##     [2]            <NA>              <NA>
##     [3]            <NA>              <NA>
##     [4]            <NA>              <NA>
##     [5]            <NA>              <NA>
##     ...             ...               ...
##   [126]            <NA>              <NA>
##   [127]            <NA>              <NA>
##   [128]            <NA>              <NA>
##   [129]            <NA>              <NA>
##   [130]            <NA>              <NA>
##   -------
##   seqinfo: 36 sequences from TriTrypDB-39_LmajorFriedlin genome; no seqlengths
```

# Session Information

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-08-22 r75177)
## Platform: x86_64-apple-darwin15.6.0 (64-bit)
## Running under: OS X El Capitan 10.11.6
##
## Matrix products: default
## BLAS: /Users/da42327_ca/bin/R-3-5-branch/lib/libRblas.dylib
## LAPACK: /Users/da42327_ca/bin/R-3-5-branch/lib/libRlapack.dylib
##
## locale:
## [1] C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
## [1] GenomicRanges_1.33.14 GenomeInfoDb_1.17.4   AnnotationDbi_1.43.1
## [4] IRanges_2.15.18       S4Vectors_0.19.23     Biobase_2.41.2
## [7] AnnotationHub_2.13.10 BiocGenerics_0.27.1   BiocStyle_2.9.6
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.19                  XVector_0.21.4
##  [3] compiler_3.5.1                BiocManager_1.30.3
##  [5] later_0.7.5                   zlibbioc_1.27.0
##  [7] bitops_1.0-6                  tools_3.5.1
##  [9] digest_0.6.18                 bit_1.1-14
## [11] RSQLite_2.1.1                 evaluate_0.12
## [13] memoise_1.1.0                 pkgconfig_2.0.2
## [15] shiny_1.1.0                   DBI_1.0.0
## [17] curl_3.2                      yaml_2.2.0
## [19] GenomeInfoDbData_1.2.0        httr_1.3.1
## [21] stringr_1.3.1                 knitr_1.20
## [23] rprojroot_1.3-2               bit64_0.9-7
## [25] R6_2.3.0                      rmarkdown_1.10
## [27] blob_1.1.1                    magrittr_1.5
## [29] backports_1.1.2               promises_1.0.1
## [31] htmltools_0.3.6               mime_0.6
## [33] interactiveDisplayBase_1.19.2 xtable_1.8-3
## [35] httpuv_1.4.5                  stringi_1.2.4
## [37] RCurl_1.95-4.11
```