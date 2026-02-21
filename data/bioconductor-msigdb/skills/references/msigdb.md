# msigdb: The molecular signatures database (MSigDB) in R

### Dharmesh D. Bhuva

### 4 November 2025

* [1 The Molecular Signatures Database (MSigDB)](#the-molecular-signatures-database-msigdb)
* [2 Download data from the msigdb R package](#download-data-from-the-msigdb-r-package)
* [3 Downloading and integrating KEGG gene sets](#downloading-and-integrating-kegg-gene-sets)
* [4 Accessing the GeneSet and GeneSetCollection objects](#accessing-the-geneset-and-genesetcollection-objects)
* [5 Subset collections from the MSigDB](#subset-collections-from-the-msigdb)
* [6 Preparing collections for limma::fry](#preparing-collections-for-limmafry)
* [7 Accessing the mouse MSigDB](#accessing-the-mouse-msigdb)
* [8 Session information](#session-information)

# 1 The Molecular Signatures Database (MSigDB)

The [molecular signatures database (MSigDB)](https://www.gsea-msigdb.org/gsea/msigdb) is one of the largest collections of molecular signatures or gene expression signatures. A variety of gene expression signatures are hosted on this database including experimentally derived signatures and signatures representing pathways and ontologies from other curated databases. This rich collection of gene expression signatures (>25,000) can facilitate a wide variety of signature-based analyses, the most popular being gene set enrichment analyses. These signatures can be used to perform enrichment analysis in a DE experiment using tools such as GSEA, fry (from limma) and camera (from limma). Alternatively, they can be used to perform single-sample gene-set analysis of individual transcriptomic profiles using approaches such as [singscore](https://doi.org/doi%3A10.18129/B9.bioc.singscore), ssGSEA and [GSVA](https://doi.org/doi%3A10.18129/B9.bioc.GSVA).

This package provides the gene sets in the MSigDB in the form of `GeneSet` objects. This data structure is specifically designed to store information about gene sets, including their member genes and metadata. Other packages, such as `msigdbr` and `EGSEAdata` provide these gene sets too, however, they do so by storing them as lists or tibbles. These structures are not specific to gene sets therefore do not allow storage of important metadata associated with each gene set, for example, their short and long descriptions. Additionally, the lack of structure allows creation of invalid gene sets. Accessory functions implemented in the `GSEABase` package provide a neat interface to interact with `GeneSet` objects.

This package can be installed using the code below:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("msigdb")
```

# 2 Download data from the msigdb R package

This ExperimentHub package processes the latest version of the MSigDB database into R objects that can be queried using the [GSEABase](https://doi.org/doi%3A10.18129/B9.bioc.GSEABase) R/Bioconductor package. The entire database is stored in a `GeneSetCollection` object which in turn stores each signature as a `GeneSet` object. All empty gene expression signatures (i.e. no genes formed the signature) have been dropped. Data in this package can be downloaded using the `ExperimentHub` interface as shown below.

To download the data, we first need to get a list of the data available in the `msigdb` package and determine the unique identifiers for each data. The `query()` function assists in getting this list.

```
library(msigdb)
library(ExperimentHub)
library(GSEABase)
```

```
eh = ExperimentHub()
query(eh , 'msigdb')
#> ExperimentHub with 51 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Broad Institute, Emory University, EBI, NA
#> # $species: Homo sapiens, Mus musculus
#> # $rdataclass: GSEABase::GeneSetCollection, data.frame, list
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH5421"]]'
#>
#>            title
#>   EH5421 | msigdb.v7.2.hs.SYM
#>   EH5422 | msigdb.v7.2.hs.EZID
#>   EH5423 | msigdb.v7.2.mm.SYM
#>   EH5424 | msigdb.v7.2.mm.EZID
#>   EH6727 | MSigDB C8 MANNO MIDBRAIN
#>   ...      ...
#>   EH8298 | msigdb.v7.5.1.mm.idf
#>   EH8299 | msigdb.v7.5.1.mm.SYM
#>   EH8300 | imex_hsmm_0722
#>   EH9632 | MSigDB v2024.1.Hs
#>   EH9633 | MSigDB v2024.1.Mm
```

Data can then be downloaded using the unique identifier.

```
eh[['EH5421']]
#> GeneSetCollection
#>   names: chr11q, chr6q, ..., WP_HOSTPATHOGEN_INTERACTION_OF_HUMAN_CORONA_VIRUSES_INTERFERON_INDUCTION (31322 total)
#>   unique identifiers: AP001767.2, SLC22A9, ..., AC023491.2 (40044 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

Data can also be downloaded using the custom accessor `msigdb::getMsigdb()`:

```
#use the custom accessor to select a specific version of MSigDB
msigdb.hs = getMsigdb(org = 'hs', id = 'SYM', version = '7.4')
msigdb.hs
#> GeneSetCollection
#>   names: chr1p12, chr1p13, ..., GOMF_STARCH_BINDING (44662 total)
#>   unique identifiers: VTCN1, LINC01525, ..., LOC102725072 (40018 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

# 3 Downloading and integrating KEGG gene sets

KEGG gene sets cannot be integrated within this ExperimentHub package due to licensing limitations. However, users can download, process and integrate the data directly from the MSigDB when needed. This can be done using the code that follows.

```
msigdb.hs = appendKEGG(msigdb.hs)
msigdb.hs
#> GeneSetCollection
#>   names: chr1p12, chr1p13, ..., KEGG_VIRAL_MYOCARDITIS (44848 total)
#>   unique identifiers: VTCN1, LINC01525, ..., RIGI (40029 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

# 4 Accessing the GeneSet and GeneSetCollection objects

A GeneSetCollection object is effectively a list therefore all list processing functions such as `length` and `lapply` can be used to process its constituents

```
length(msigdb.hs)
#> [1] 44848
```

Each signature is stored in a `GeneSet` object and can be processed using functions in the `GSEABase` R/Bioconductor package.

```
gs = msigdb.hs[[1000]]
gs
#> setName: NIKOLSKY_BREAST_CANCER_16Q24_AMPLICON
#> geneIds: ZC3H18, DPEP1, ..., DBNDD1 (total: 52)
#> geneIdType: Symbol
#> collectionType: Broad
#>   bcCategory: c2 (Curated)mh (Mouse-Ortholog Hallmark)
#>   bcSubCategory: CGP
#> details: use 'details(object)'
#get genes in the signature
geneIds(gs)
#>  [1] "ZC3H18"   "DPEP1"    "C16orf74" "SPG7"     "GAS8-AS1" "GALNS"
#>  [7] "TCF25"    "APRT"     "PABPN1L"  "SNAI3"    "CDK10"    "BANP"
#> [13] "IL17C"    "CDH15"    "ZCCHC14"  "CYBA"     "CBFA2T3"  "JPH3"
#> [19] "KLHDC4"   "MAP1LC3B" "CENPBD1"  "SLC7A5"   "TUBB3"    "CHMP1A"
#> [25] "GAS8"     "GSE1"     "ZFPM1"    "ANKRD11"  "SPIRE2"   "MC1R"
#> [31] "VPS9D1"   "RPL13"    "CTU2"     "RNF166"   "PRDM7"    "MVD"
#> [37] "COX4I1"   "SPATA33"  "FANCA"    "CA5A"     "SPATA2L"  "TRAPPC2L"
#> [43] "GINS2"    "DEF8"     "CDT1"     "PIEZO1"   "ZNF276"   "ACSF3"
#> [49] "ZNF778"   "CPNE7"    "EMC8"     "DBNDD1"
#get collection type
collectionType(gs)
#> collectionType: Broad
#>   bcCategory: c2 (Curated)mh (Mouse-Ortholog Hallmark)
#>   bcSubCategory: CGP
#get MSigDB category
bcCategory(collectionType(gs))
#> [1] "c2"
#get MSigDB subcategory
bcSubCategory(collectionType(gs))
#> [1] "CGP"
#get description
description(gs)
#> [1] "Genes within amplicon 16q24 identified in a copy number alterations study of 191 breast tumor samples."
#get details
details(gs)
#> setName: NIKOLSKY_BREAST_CANCER_16Q24_AMPLICON
#> geneIds: ZC3H18, DPEP1, ..., DBNDD1 (total: 52)
#> geneIdType: Symbol
#> collectionType: Broad
#>   bcCategory: c2 (Curated)mh (Mouse-Ortholog Hallmark)
#>   bcSubCategory: CGP
#> setIdentifier: rstudio-2.hpc.wehi.edu.au:4454:Wed Aug 11 22:15:15 2021:755632
#> description: Genes within amplicon 16q24 identified in a copy number alterations study of 191 breast tumor samples.
#>   (longDescription available)
#> organism: Homo sapiens
#> pubMedIds: 19010930
#> urls: https://data.broadinstitute.org/gsea-msigdb/msigdb/release/7.4/msigdb_v7.4.xml
#> contributor: Jessica Robertson
#> setVersion: 7.4
#> creationDate:
```

We can also summarise some of these values across the entire database. Description of these codes can be found at the MSigDB website (<https://www.gsea-msigdb.org/gsea/msigdb>).

```
#calculate the number of signatures in each category
table(sapply(lapply(msigdb.hs, collectionType), bcCategory))
#>
#>    c1    c2    c3    c4    c5    c6    c7    c8     h
#>   278  6290  3731   858 27562   189  5219   671    50
#calculate the number of signatures in each subcategory
table(sapply(lapply(msigdb.hs, collectionType), bcSubCategory))
#>
#>             CGN             CGP              CM              CP     CP:BIOCARTA
#>             427            3368             431              29             292
#>         CP:KEGG          CP:PID     CP:REACTOME CP:WIKIPATHWAYS           GO:BP
#>             186             196            1604             615           16013
#>           GO:CC           GO:MF             HPO     IMMUNESIGDB       MIR:MIRDB
#>            1981            4755            4813            4872            2377
#>  MIR:MIR_Legacy        TFT:GTRD  TFT:TFT_Legacy             VAX
#>             221             523             610             347
#plot the distribution of sizes
hist(sapply(lapply(msigdb.hs, geneIds), length),
     main = 'MSigDB signature size distribution',
     xlab = 'Signature size')
```

![](data:image/png;base64...)

# 5 Subset collections from the MSigDB

Most gene set analysis is performed within specific collections rather than across the entire database. This package comes with functions to subset specific collections. The list of all collections and sub-collections present within a GeneSetCollection object can be listed using the functions below:

```
listCollections(msigdb.hs)
#> [1] "c1" "c2" "c3" "c4" "c5" "c6" "c7" "c8" "h"
listSubCollections(msigdb.hs)
#>  [1] "CGP"             "CP:BIOCARTA"     "CP:PID"          "CP"
#>  [5] "CP:WIKIPATHWAYS" "MIR:MIRDB"       "MIR:MIR_Legacy"  "TFT:GTRD"
#>  [9] "TFT:TFT_Legacy"  "CGN"             "CM"              "HPO"
#> [13] "IMMUNESIGDB"     "VAX"             "CP:REACTOME"     "GO:BP"
#> [17] "GO:CC"           "GO:MF"           "CP:KEGG"
```

Specific collections can be retrieved using the code below:

```
#retrieeve the hallmarks gene sets
subsetCollection(msigdb.hs, 'h')
#> GeneSetCollection
#>   names: HALLMARK_TNFA_SIGNALING_VIA_NFKB, HALLMARK_HYPOXIA, ..., HALLMARK_PANCREAS_BETA_CELLS (50 total)
#>   unique identifiers: JUNB, CXCL2, ..., SRP14 (4383 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
#retrieve the biological processes category of gene ontology
subsetCollection(msigdb.hs, 'c5', 'GO:BP')
#> GeneSetCollection
#>   names: HP_MULTICYSTIC_KIDNEY_DYSPLASIA, HP_RECURRENT_URINARY_TRACT_INFECTIONS, ..., GOMF_STARCH_BINDING (27562 total)
#>   unique identifiers: CHRM3, RPGRIP1L, ..., LOC102725072 (20725 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

# 6 Preparing collections for limma::fry

Any gene-set collection can be easily transformed for usage with `limma::fry` by first transforming it into a list of gene IDs and following that with a transformation to indices as shown below.

```
library(limma)

#create expression data
allg = unique(unlist(geneIds(msigdb.hs)))
emat = matrix(0, nrow = length(allg), ncol = 6)
rownames(emat) = allg
colnames(emat) = paste0('sample', 1:6)
head(emat)
#>           sample1 sample2 sample3 sample4 sample5 sample6
#> VTCN1           0       0       0       0       0       0
#> LINC01525       0       0       0       0       0       0
#> MAN1A2          0       0       0       0       0       0
#> VPS25P1         0       0       0       0       0       0
#> TENT5C          0       0       0       0       0       0
#> VDAC2P3         0       0       0       0       0       0
```

```
#retrieve collections
hallmarks = subsetCollection(msigdb.hs, 'h')
msigdb_ids = geneIds(hallmarks)

#convert gene sets into a list of gene indices
fry_indices = ids2indices(msigdb_ids, rownames(emat))
fry_indices[1:2]
#> $HALLMARK_TNFA_SIGNALING_VIA_NFKB
#>   [1]   109   257   369   545   567   661   821   837   966   980  1299  1502
#>  [13]  1528  2155  2365  2873  2940  3090  3205  3208  3252  3931  3970  3974
#>  [25]  4227  4398  4586  4808  4900  5104  5788  5846  5862  5924  5991  6317
#>  [37]  6318  6435  7158  7219  7235  7540  7739  7985  8062  8080  8206  9076
#>  [49]  9463 10003 10175 10470 10865 11928 12145 13207 13208 13613 14099 14447
#>  [61] 14465 14683 14721 14733 14932 14959 15533 15677 15731 15912 16430 16433
#>  [73] 16763 16891 16899 17026 17062 17144 17169 17285 17648 17819 17861 17874
#>  [85] 17895 18031 18862 19030 19182 19480 19566 19648 19742 19995 19996 20318
#>  [97] 20380 20419 20469 20485 20643 20862 21229 21421 21446 21929 22027 22044
#> [109] 22128 22398 22578 22601 22659 22739 22761 23305 23476 24053 24751 25005
#> [121] 25453 25463 25467 25801 25852 26277 26564 26592 26951 27273 27332 27625
#> [133] 27649 27846 28199 28288 28299 28404 28447 28578 28656 28754 28884 28894
#> [145] 28961 29018 29122 29244 29379 29392 29765 29818 29865 30101 30294 30478
#> [157] 30519 30733 31180 31207 32019 32103 32882 32988 33354 33561 33631 33717
#> [169] 33761 33864 34032 34049 34726 34892 34929 35040 35094 35116 35214 35246
#> [181] 35500 36358 38001 38023 38024 38025 38050 38051 38057 38059 38067 38106
#> [193] 38117 38145 38183 38204 38299 38330 38411 38506
#>
#> $HALLMARK_HYPOXIA
#>   [1]   257   369   519   537   837  1062  1086  1246  1375  1504  1514  1522
#>  [13]  2196  2293  2364  2365  2383  2438  3034  3081  3252  3926  3931  3974
#>  [25]  4297  4345  4350  4363  4396  4615  4891  4896  5124  5770  5782  6553
#>  [37]  6746  7098  7120  7125  7158  7302  7433  7783  7787  7996  8076  8080
#>  [49]  8563 10158 10460 10470 10482 11825 11828 11854 11990 12267 12514 13404
#>  [61] 13406 14176 14329 14525 14559 14961 15189 15211 15498 15648 15694 15763
#>  [73] 16185 16367 16418 16952 17238 17390 17459 17507 17648 17819 18012 18031
#>  [85] 18038 18206 18634 18784 18896 19073 19480 20284 20574 20970 21139 21159
#>  [97] 21827 21911 21929 22126 22765 22951 23190 23243 23385 23400 23401 23476
#> [109] 23483 23508 23816 24620 24683 24751 24833 25048 25356 25389 25453 25476
#> [121] 25703 26043 26098 26165 26191 26665 26803 27639 28013 28080 28213 28290
#> [133] 28370 28554 28568 28754 28766 28961 29244 29255 29379 29796 30041 30082
#> [145] 30101 30110 30228 30437 30519 30539 30644 30850 30874 30930 30931 30996
#> [157] 31004 31207 32019 32169 32172 33012 33030 33627 33790 33948 34086 34458
#> [169] 34537 34892 34956 35063 35323 35518 35699 36369 36604 36605 37165 37167
#> [181] 37247 37372 37460 37499 38047 38049 38067 38097 38099 38115 38116 38133
#> [193] 38159 38172 38204 38272 38288 38463 38474 38639
```

# 7 Accessing the mouse MSigDB

The mouse MSigDB has been created in collaboration with Gordon K. Smyth and Alex Garnham from WEHI. The code they use to generate the mouse MSigDB has been used in this package. Detailed description of the steps conducted to convert human gene expression signatures to mouse can be found at <http://bioinf.wehi.edu.au/MSigDB>. Mouse homologs for human genes were obtained using the HCOP database (as of 18/03/2021).

All the above functions apply to the mouse MSigDB and can be used to interact with the collection.

```
msigdb.mm = getMsigdb(org = 'mm', id = 'SYM', version = '7.4')
msigdb.mm
#> GeneSetCollection
#>   names: 10qA1, 10qA2, ..., ZZZ3_TARGET_GENES (44688 total)
#>   unique identifiers: Epm2a, Esr1, ..., Gm52481 (53805 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

# 8 Session information

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] limma_3.66.0         GSEABase_1.72.0      graph_1.88.0
#>  [4] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
#>  [7] IRanges_2.44.0       S4Vectors_0.48.0     Biobase_2.70.0
#> [10] ExperimentHub_3.0.0  AnnotationHub_4.0.0  BiocFileCache_3.0.0
#> [13] dbplyr_2.5.1         BiocGenerics_0.56.0  generics_0.1.4
#> [16] msigdb_1.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0     xfun_0.54           bslib_0.9.0
#>  [4] httr2_1.2.1         vctrs_0.6.5         tools_4.5.1
#>  [7] curl_7.0.0          tibble_3.3.0        RSQLite_2.4.3
#> [10] blob_1.2.4          pkgconfig_2.0.3     lifecycle_1.0.4
#> [13] compiler_4.5.1      Biostrings_2.78.0   prettydoc_0.4.1
#> [16] statmod_1.5.1       BiocStyle_2.38.0    Seqinfo_1.0.0
#> [19] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
#> [22] pillar_1.11.1       crayon_1.5.3        jquerylib_0.1.4
#> [25] cachem_1.1.0        org.Hs.eg.db_3.22.0 tidyselect_1.2.1
#> [28] digest_0.6.37       dplyr_1.1.4         purrr_1.1.0
#> [31] BiocVersion_3.22.0  fastmap_1.2.0       cli_3.6.5
#> [34] magrittr_2.0.4      withr_3.0.2         filelock_1.0.3
#> [37] rappdirs_0.3.3      bit64_4.6.0-1       rmarkdown_2.30
#> [40] XVector_0.50.0      httr_1.4.7          bit_4.6.0
#> [43] png_0.1-8           memoise_2.0.1       evaluate_1.0.5
#> [46] knitr_1.50          rlang_1.1.6         xtable_1.8-4
#> [49] glue_1.8.0          DBI_1.2.3           BiocManager_1.30.26
#> [52] jsonlite_2.0.0      R6_2.6.1
```