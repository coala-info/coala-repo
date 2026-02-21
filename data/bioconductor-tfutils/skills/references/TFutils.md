# TFutils: Data Structures for Transcription Factor Bioinformatics

#### BJ Stubbs

Channing Division of Network Medicine, Brigham and Women’s Hospital, Harvard Medical School

#### Shweta Gopaulakrishnan

Channing Division of Network Medicine, Brigham and Women’s Hospital, Harvard Medical School

#### Kimberly Glass

Channing Division of Network Medicine, Brigham and Women’s Hospital, Harvard Medical School

#### Nathalie Pochet

Department of Neurology, Brigham and Women’s Hospital, Harvard Medical School; Broad Institute

#### Celine Everaert

Department of Neurology, Brigham and Women’s Hospital, Harvard Medical School; Broad Institute

#### Benjamin Raby

Channing Division of Network Medicine, Brigham and Women’s Hospital, Harvard Medical School

#### Vincent Carey

Channing Division of Network Medicine, Brigham and Women’s Hospital, Harvard Medical School

Abstract

DNA transcription is intrinsically complex. Bioinformatic work with transcription factors (TFs) is complicated by a multiplicity of data resources and annotations. The Bioconductor package *TFutils* includes data structures and functions to enhance the precision and utility of integrative analyses that have components involving TFs. *TFutils* provides catalogs of human TFs from three reference sources (CISBP, HOCOMOCO, and GO), a catalog of TF targets derived from MSigDb, and multiple approaches to enumerating TF binding sites. Aspects of integration of TF binding patterns and genome-wide association study results are explored in examples.

# Introduction

A central concern of genome biology is improving understanding of gene transcription. In simple terms, transcription factors (TFs) are proteins that bind to DNA, typically near gene promoter regions. The role of TFs in gene expression variation is of great interest. Progress in deciphering genetic and epigenetic processes that affect TF abundance and function will be essential in clarifying and interpreting gene expression variation patterns and their effects on phenotype. Difficulties of identifying functional binding of TFs, and opportunities for using information of TF binding in systems biology contexts, are reviewed in Lambert et al. (2018) and Weirauch et al. (2014).

This paper describes an R/Bioconductor package called TFutils, which assembles various resources intended to clarify and unify approaches to working with TF concepts in bioinformatic analysis. Computations described in this paper can be carried out with Bioconductor version 3.8. The package can be installed with

```
# use install.packages("BiocManager") if not already available
library(BiocManager)
install("TFutils")
```

In the next section we describe the basic concepts of enumerating and classifying TFs, enumerating TF targets, and representing genome-wide quantification of TF binding affinity. This is followed by a review of the key data structures and functions provided in the package, and an example in cancer informatics.

The present paper does not deal directly with the manipulation or interpretation of sequence motifs. An excellent Bioconductor package that synthesizes many approaches to these tasks is *[universalmotif](https://bioconductor.org/packages/3.22/universalmotif)*.

# Basic concepts of transcription factor bioinformatics

## Enumerating transcription factors

Given the importance of the topic, it is not surprising that a number of bioinformatic research groups have published catalogs of transcription factors along with metadata about their features. Standard nomenclature for TFs has yet to be established. Gene symbols, motif sequences, and position-weight matrix catalog entries have all been used as TF identifiers.

In TFutils we have gathered information from four widely used resources, focusing specifically on human TFs: Gene Ontology (GO, Ashburner et al. (2000), in which `GO:0003700` is the tag for the molecular function concept “DNA binding transcription factor activity”), CISBP (Weirauch et al. (2014)), HOCOMOCO (Kulakovskiy et al. (2018)), and the “c3 TFT (transcription factor target)” signature set of MSigDb (Subramanian et al. (2005)). Figure @ref(fig:lkupset) depicts the sizes of these catalogs, measured using counts of unique HGNC gene symbols. The enumeration for GO uses Bioconductor’s *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* package to find direct associations from `GO:0003700` to HGNC symbols. The enumeration for MSigDb is heuristic and involves parsing the gene set identifiers used in MSigDb for exact or close matches to HGNC symbols. For CISBP and HOCOMOCO, the associated web servers provide easily parsed tabular catalogs.

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![Sizes of TF catalogs and of intersections based on HGNC symbols for TFs.](data:image/png;base64...)

Sizes of TF catalogs and of intersections based on HGNC symbols for TFs.

## Classification of transcription factors

As noted by Weirauch et al. (2014), interpretation of the “function and evolution of DNA sequences” is dependent on the analysis of sequence-specific DNA binding domains. These domains are dynamic and cell-type specific (Gertz et al. (2013)). Classifying TFs according to features of the binding domain is an ongoing process of increasing intricacy. Figure @ref(fig:TFclass) shows excerpts of hierarchies of terms related to TF type derived from GO (on the left) and [TFclass](http://tfclass.bioinf.med.uni-goettingen.de/) (Wingender et al. (2018)). There is a disagreement between our enumeration of TFs based on GO in Figure @ref(fig:lkupset) and the 1919 shown in AmiGO, as the latter includes a broader collection of receptor activities.

![Screenshots of AmiGO and TFClass hierarchy excerpts.](data:image/png;base64...)

Screenshots of AmiGO and TFClass hierarchy excerpts.

Table @ref(tab:classtab) provides examples of frequently encountered TF classifications in the CISBP and HOCOMOCO catalogs. The numerical components of the HOCOMOCO classes correspond to TFClass subfamilies (Wingender et al. (2018)).

(#tab:classtab) Most frequently represented TF classes in CISBP and HOCOMOCO. Entries in columns Nc (Nh) are numbers of distinct TFs annotated to classes in columns CISBP (HOCOMOCO) respectively. Entries are ordered top to bottom by frequency of occurrence. There is no substantive correspondence between entries on a given row. Harmonization of class terminology is beyond the scope of this paper.

| CISBP | Nc | HOCOMOCO | Nh |
| --- | --- | --- | --- |
| C2H2 ZF | 655 | More than 3 adjacent zinc finger factors{2.3.3} | 106 |
| Homeodomain | 199 | HOX-related factors{3.1.1} | 41 |
| bHLH | 104 | NK-related factors{3.1.2} | 36 |
| bZIP | 66 | Paired-related HD factors{3.1.3} | 35 |
| Unknown | 49 | Factors with multiple dispersed zinc fingers{2.3.4} | 30 |
| Forkhead | 48 | Forkhead box (FOX) factors{3.3.1} | 27 |
| Sox | 48 | Ets-related factors{3.5.2} | 25 |
| Nuclear receptor | 46 | Three-zinc finger Krueppel-related factors{2.3.1} | 20 |
| Myb/SANT | 30 | POU domain factors{3.1.10} | 18 |
| Ets | 27 | Tal-related factors{1.2.3} | 18 |

## Enumerating TF targets

The Broad Institute MSigDb (Subramanian et al. (2005)) includes a gene set collection devoted to cataloging TF targets. We have used Bioconductor’s *[GSEABase](https://bioconductor.org/packages/3.22/GSEABase)* package to import and serialize the `gmt` representation of this collection.

```
TFutils::tftColl
```

```
## GeneSetCollection
##   names: AAANWWTGC_UNKNOWN, AAAYRNCTG_UNKNOWN, ..., GCCATNTTG_YY1_Q6 (615 total)
##   unique identifiers: 4208, 481, ..., 56903 (12774 total)
##   types in collection:
##     geneIdType: EntrezIdentifier (1 total)
##     collectionType: NullCollection (1 total)
```

Names of TFs for which target sets are assembled are encoded in a systematic way, with underscores separating substrings describing motifs, genes, and versions. Some peculiarity in nomenclature in the MSigDb labels can be observed:

```
grep("NFK", names(TFutils::tftColl), value=TRUE)
```

```
## [1] "NFKAPPAB65_01"         "NFKAPPAB_01"           "NFKB_Q6"
## [4] "NFKB_C"                "NFKB_Q6_01"            "GGGNNTTTCC_NFKB_Q6_01"
```

Manual curation will be needed to improve the precision with which MSigDb TF target sets can be associated with specific TFs or motifs.

## Quantitative predictions of TF binding affinities

In this subsection we address representation of putative binding sites. First we illustrate how to represent sequence-based affinity measures and the binding site locations implied by these. We then discuss use of results of ChIP-seq experiments for cell-type-specific binding site enumeration.

**Affinity scores based on reference sequence.** The FIMO algorithm of the MEME suite (Grant, Bailey, and Noble (2011)) was used to score the human reference genome for TF binding affinity for 689 motif matrices to which genes are associated. Full details are provided in Sonawane et al. (2017). Sixteen (16) tabix-indexed BED files are lodged in an AWS S3 bucket for illustration purposes.

```
library(GenomicFiles)
data(fimo16)
fimo16
```

```
## GenomicFiles object with 0 ranges and 16 files:
## files: M0635_1.02sort.bed.gz, M3433_1.02sort.bed.gz, ..., M6159_1.02sort.bed.gz, M6497_1.02sort.bed.gz
## detail: use files(), rowRanges(), colData(), ...
```

```
head(colData(fimo16))
```

```
## DataFrame with 6 rows and 2 columns
##          Mtag        HGNC
##   <character> <character>
## 1     M0635_1      DMRTC2
## 2     M3433_1       HOXA3
## 3     M3467_1        IRF1
## 4     M3675_1      POU2F1
## 5     M3698_1        TP53
## 6     M3966_1       STAT1
```

We harvest scores in a genomic interval of interest (bound to `fimo16` in the `rowRanges` assignment below) using `reduceByFile`. This yields a list with one element per file. Each such element holds a list of `scanTabix` results, one per query range.

```
if (.Platform$OS.type != "windows") {
 library(BiocParallel)
 register(SerialParam()) # important for macosx?
 rowRanges(fimo16) = GRanges("chr17", IRanges(38.077e6, 38.084e6))
 rr = GenomicFiles::reduceByFile(fimo16, MAP=function(r,f)
   scanTabix(f, param=r))
} else {
rr = readRDS(system.file("fimoser/fimo16rr.rds", package="TFutils"))
}
```

scanTabix produces a list of vectors of text strings, which we parse with `data.table::fread`. The resulting tables are then reduced to a genomic location and -log10 of the p-value derived from the binding affinity statistic of FIMO in the vicinity of that location.

```
asdf = function(x) data.table::fread(paste0(x, collapse="\n"), header=FALSE)
gg = lapply(rr, function(x) {
       tmp = asdf(x[[1]][[1]])
       data.frame(loc=tmp$V2, score=-log10(tmp$V7))
     })
for (i in 1:length(gg))  gg[[i]]$tf = colData(fimo16)[i,2]
```

It turns out there are too many distinct TFs to display names individually, so we label the scores with the names of the associated TF families as defined in CISBP.

```
matchcis = match(colData(fimo16)[,2], cisbpTFcat[,2])
famn = cisbpTFcat[matchcis,]$Family_Name
for (i in 1:length(gg))  gg[[i]]$tffam = famn[i]
nn = do.call(rbind, gg)
```

A simple display of *predicted* TF binding affinity near the gene ORMDL3 is provided in Figure @ref(fig:finish).

![TF binding in the vicinity of gene ORMDL3.  Points are -log10-transformed FIMO-based p-values colored according to TF class as annotated in CISBP.  Segments at bottom of plot are transcribed regions of ORMDL3 according to UCSC gene models in build hg19.](data:image/png;base64...)

TF binding in the vicinity of gene ORMDL3. Points are -log10-transformed FIMO-based p-values colored according to TF class as annotated in CISBP. Segments at bottom of plot are transcribed regions of ORMDL3 according to UCSC gene models in build hg19.

**TF binding predictions based on ChIP-seq data from ENCODE.** The ENCODE project provides BED-formatted reports on ChIP-seq experiments for many combinations of cell type and DNA-binding factors. TFutils includes a table `encode690` that gives information on 690 experiments involving pairs formed from 91 cell lines and 161 TFs for which results have been recorded as GRanges instances that can be acquired with the *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package. Positional relationships between cell-type specific binding sites and genomic features can be investigated. An illustration is given in Figure @ref(fig:lkbi), in which is it suggested that in HepG2 cells, CEBPB exhibits a distinctive pattern of binding in the vicinity of ORMDL3.

![Binding of CEBPB in the vicinity of ORMDL3 derived from ChIP-seq experiments in four cell lines reported by ENCODE.  Colored rectangles at top are regions identified as narrow binding peaks, arrows in bottom half are exons in ORMDL3.  Arrows sharing a common vertical position are members of the same transcript as cataloged in Ensembl version 75.](data:image/png;base64...)

Binding of CEBPB in the vicinity of ORMDL3 derived from ChIP-seq experiments in four cell lines reported by ENCODE. Colored rectangles at top are regions identified as narrow binding peaks, arrows in bottom half are exons in ORMDL3. Arrows sharing a common vertical position are members of the same transcript as cataloged in Ensembl version 75.

## Summary

We have compared enumerations of human transcription factors by different projects, provided access to two forms of binding domain classification, and illustrated the use of cloud-resident genome-wide binding predictions. In the next section we review selected details of data structures and methods of the *[TFutils](https://bioconductor.org/packages/3.22/TFutils)* package.

# Methods

## Implementation

The TFutils package is designed to lower barriers to usage of key findings of TF biology in human genome research. TFutils is supplied as a conventional R package distributed with, and making use of, the Bioconductor software ecosystem. TFutils includes ready-to-use reference data, tools for visualizing binding sites, and tools that simplify integrative use of TF binding information with GWAS findings.

### Data resources

**Catalogs.** Two reference resources have been collected into the TFutils package as data.frame instances. These are `cisbpTFcat` (CISBP: 7592 x 28), and `hocomoco.mono.sep2018` (mononucleotide models, full catalog, 769 x 9). These data.frames are snapshots of the CISBP and HOCOMOCO catalogs

**Indexed BED in AWS S3.** As described above `fimo16` provides programmatic access to FIMO scores for 16 TFs, using the *[GenomicFiles](https://bioconductor.org/packages/3.22/GenomicFiles)* protocol.

**Annotated reference to ENCODE ChIP-seq results.** `encode690` simplifies programmatic access to TF:cell-line combinations available in Bioconductor *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*.

**TF targets enumerated in MsigDb.** The c3-TFT (TF targets) subset from MSigDb is provided as a GeneSetCollection instance as defined in *[GSEABase](https://bioconductor.org/packages/3.22/GSEABase)*.

**Illustrative GWAS records.** The full EBI/EMBL GWAS catalog is available in the *[gwascat](https://bioconductor.org/packages/3.22/gwascat)* package; for convenience, an excerpt focusing on chromosome 17 is supplied with TFutils as `gwascat_hg19_chr17`.

### Infrastructure for interacting with components of TFutils

**Interactive enumeration of TF targets implicated in GWAS.** The `TFtargs` function runs a shiny app that permits selection of a TF in the nomenclature of the MSigDb c3/TFT gene set collection. The app will search an object provided by the *[gwascat](https://bioconductor.org/packages/3.22/gwascat)* package for references in the `MAPPED_GENE` field that match the targets of the selected TF. Figure @ref(fig:lktarapp) gives an illustration.

![TFtargs() screenshot.  This example reports on recent EBI GWAS catalog hits on chromosome 17 only.](data:image/png;base64...)

TFtargs() screenshot. This example reports on recent EBI GWAS catalog hits on chromosome 17 only.

**The TFCatalog S4 class**. Reference catalogs for TF biology are structured with the `TFCatalog` S4 class. Two essential components for managing a catalog are the native TF identifier for the catalog and the HGNC gene symbol typically used to name the TF. The `TFCatalog` class includes a name field to name the catalog, and a character vector with elements comprised of the native identifiers for catalogued TFs.

A `data.frame` instance that has an obligatory column named ‘HGNC’ can include any collection of fields that offer metadata about the TF in the specified catalog. Here is how we construct and view a TFCatalog object using the CISBP reference data.

```
data(cisbpTFcat)
TFs_CISBP = TFCatalog(name="CISBP.info",
   nativeIds=cisbpTFcat[,1],
   HGNCmap = cisbpTFcat)
TFs_CISBP
```

```
## TFutils TFCatalog instance CISBP.info
##  7592 native Ids, including
##    T004843_1.02 ... T153733_1.02
##  1551 unique HGNC tags, including
##    TFAP2B TFAP2B ... ZNF10 ZNF350
```

## Operation: Use cases

In this section we consider applications of the tools in genetic epidemiology. First we look for TFs that may harbor variants associated with traits in the EBI GWAS catalog. Then we show how to enumerate traits associated with targets of a selected TF.

**TFs that are direct GWAS hits for a given trait.** `directHitsInCISBP` accepts a string naming a trait , and returns a data.frame of TFs identified as “mapped genes” for the trait, with their TF “family name”.

```
library(dplyr)
library(magrittr)
library(gwascat)
#data(ebicat37)
load(system.file("legacy/ebicat37.rda", package="gwascat"))
directHitsInCISBP("Rheumatoid arthritis", ebicat37)
```

```
## Joining with `by = join_by(HGNC)`
```

```
##      HGNC Family_Name
## 1  ARID5B ARID/BRIGHT
## 7   EOMES       T-box
## 15  GATA3        GATA
## 35  JAZF1     C2H2 ZF
## 37  MECP2         MBD
## 45   MTF1     C2H2 ZF
## 57    REL         Rel
## 65  STAT4        STAT
## 79   AIRE        SAND
## 82   IRF5         IRF
```

**Traits mapped to genes that are targets of a given TF**

`topTraitsOfTargets` will acquire the targets of a selected TF, check for hits in these genes in a given GWAS catalog instance, and tabulate the most commonly reported traits.

```
tt = topTraitsOfTargets("MTF1", TFutils::tftColl, ebicat37)
```

```
## remapping identifiers of input GeneSetCollection to Symbol...
```

```
## done
```

```
head(tt)
```

```
##                              DISEASE.TRAIT MAPPED_GENE       SNPS CHR_ID
## 1                        Atopic dermatitis        TNXB rs41268896      6
## 2                        Atopic dermatitis        TNXB rs12153855      6
## 3                        Atopic dermatitis       KIF3A  rs2897442      5
## 4 Attention deficit hyperactivity disorder      SEMA3A   rs797820      7
## 5 Attention deficit hyperactivity disorder        DNM1  rs2502731      9
## 6 Attention deficit hyperactivity disorder        GPC6  rs7995215     13
##     CHR_POS
## 1  32102292
## 2  32107027
## 3 132713335
## 4  83979723
## 5 128214278
## 6  93756253
```

```
table(tt[,1])
```

```
##
##                        Atopic dermatitis
##                                        3
## Attention deficit hyperactivity disorder
##                                        3
##                                   Height
##                                        7
##                  Menarche (age at onset)
##                                        4
##                   Obesity-related traits
##                                       11
##                     Rheumatoid arthritis
##                                        3
```

# Discussion

Sources and consequences of variations in DNA transcription are fundamental problems for cell biology, and the projects we have made use of for cataloging transcription factors are at the boundaries of current knowledge.

It is noteworthy that the four resources used for Figure @ref(fig:lkupset) agree on names of only 119 TFs. The fact that CISBP distinguishes 475 TFs that are not identified in any other source should be better understood. We observe that the ascription of TF status to AHRR is based on its sharing motifs with AHR (see ).

Figure @ref(fig:TFclass) and Table @ref(tab:classtab) show that the classification of TFs is now fairly elaborate. Use of the precise terminology of the TFClass system to label TFs of interest at present relies on associations provided with the HOCOMOCO catalog.

As population studies in genomic and genetic epidemiology grow in size and scope, principles for organizing and prioritizing loci associated with phenotypes of interest are urgently needed. Figure @ref(fig:lktarapp) shows that loci associated with phenotypes related to kidney function, lung function, and IL-8 levels are potentially unified through the fact that the GWAS hits are connected with genes identified as targets of VDR (vitamin D receptor). This example limited attention to hits on chromosome 17; the `TFtargs` tool permits exploration of phenotype-locus-gene-TF associations. Our hope is that the tools and resources collected in TFutils will foster systematic development of evidence-based mechanistic network models for transcription regulation in human disease contexts, thereby contributing to the development of personalized genomic medicine.

# Acknowledgments

Support for the development of this software was provided by NIH grants U01 CA214846 (Carey, PI), U24 CA180996 (Morgan, PI), Chan Zuckerberg Initiative DAF 2018-183436 (Carey, PI), and R01 NHLBI HL118455 (Raby, PI).

# Session Information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] UpSetR_1.4.0                magrittr_2.0.4
##  [3] dplyr_1.1.4                 gwascat_2.42.0
##  [5] GSEABase_1.72.0             graph_1.88.0
##  [7] annotate_1.88.0             XML_3.99-0.19
##  [9] png_0.1-8                   ggplot2_4.0.0
## [11] knitr_1.50                  data.table_1.17.8
## [13] GO.db_3.22.0                GenomicFiles_1.46.0
## [15] SummarizedExperiment_1.40.0 rtracklayer_1.70.0
## [17] Rsamtools_2.26.0            Biostrings_2.78.0
## [19] XVector_0.50.0              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           GenomicRanges_1.62.0
## [23] Seqinfo_1.0.0               BiocParallel_1.44.0
## [25] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
## [27] IRanges_2.44.0              S4Vectors_0.48.0
## [29] Biobase_2.70.0              BiocGenerics_0.56.0
## [31] generics_0.1.4              TFutils_1.30.0
## [33] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             gridExtra_2.3
##  [4] httr2_1.2.1              readxl_1.4.5             rlang_1.1.6
##  [7] otel_0.2.0               compiler_4.5.1           RSQLite_2.4.3
## [10] GenomicFeatures_1.62.0   vctrs_0.6.5              pkgconfig_2.0.3
## [13] crayon_1.5.3             fastmap_1.2.0            dbplyr_2.5.1
## [16] labeling_0.4.3           promises_1.4.0           rmarkdown_2.30
## [19] UCSC.utils_1.6.0         bit_4.6.0                xfun_0.53
## [22] cachem_1.1.0             cigarillo_1.0.0          GenomeInfoDb_1.46.0
## [25] jsonlite_2.0.0           blob_1.2.4               later_1.4.4
## [28] DelayedArray_0.36.0      parallel_4.5.1           R6_2.6.1
## [31] VariantAnnotation_1.56.0 RColorBrewer_1.1-3       bslib_0.9.0
## [34] jquerylib_0.1.4          cellranger_1.1.0         Rcpp_1.1.0
## [37] BiocBaseUtils_1.12.0     splines_4.5.1            httpuv_1.6.16
## [40] Matrix_1.7-4             tidyselect_1.2.1         dichromat_2.0-0.1
## [43] abind_1.4-8              yaml_2.3.10              codetools_0.2-20
## [46] miniUI_0.1.2             curl_7.0.0               plyr_1.8.9
## [49] lattice_0.22-7           tibble_3.3.0             withr_3.0.2
## [52] S7_0.2.0                 shiny_1.11.1             KEGGREST_1.50.0
## [55] evaluate_1.0.5           survival_3.8-3           BiocFileCache_3.0.0
## [58] snpStats_1.60.0          pillar_1.11.1            BiocManager_1.30.26
## [61] filelock_1.0.3           RCurl_1.98-1.17          scales_1.4.0
## [64] xtable_1.8-4             glue_1.8.0               tools_4.5.1
## [67] BiocIO_1.20.0            BSgenome_1.78.0          GenomicAlignments_1.46.0
## [70] restfulr_0.0.16          cli_3.6.5                rappdirs_0.3.3
## [73] S4Arrays_1.10.0          gtable_0.3.6             sass_0.4.10
## [76] digest_0.6.37            SparseArray_1.10.0       rjson_0.2.23
## [79] farver_2.1.2             memoise_2.0.1            htmltools_0.5.8.1
## [82] lifecycle_1.0.4          httr_1.4.7               mime_0.13
## [85] bit64_4.6.0-1
```

Ashburner, M., C. A. Ball, J. A. Blake, D. Botstein, H. Butler, J. M. Cherry, A. P. Davis, et al. 2000. “Gene Ontology: Tool for the Unification of Biology. The Gene Ontology Consortium.” *Nature Genetics* 25 (1): 25–29. <https://doi.org/10.1038/75556>.

Gertz, Jason, Daniel Savic, Katherine E. Varley, E. Christopher Partridge, Alexias Safi, Preti Jain, Gregory M. Cooper, Timothy E. Reddy, Gregory E. Crawford, and Richard M. Myers. 2013. “Distinct Properties of Cell-Type-Specific and Shared Transcription Factor Binding Sites.” *Molecular Cell* 52 (1): 25–36. <https://doi.org/10.1016/j.molcel.2013.08.037>.

Grant, Charles E., Timothy L. Bailey, and William Stafford Noble. 2011. “FIMO: Scanning for Occurrences of a Given Motif.” *Bioinformatics (Oxford, England)* 27 (7): 1017–8. <https://doi.org/10.1093/bioinformatics/btr064>.

Kulakovskiy, Ivan V., Ilya E. Vorontsov, Ivan S. Yevshin, Ruslan N. Sharipov, Alla D. Fedorova, Eugene I. Rumynskiy, Yulia A. Medvedeva, et al. 2018. “HOCOMOCO: Towards a complete collection of transcription factor binding models for human and mouse via large-scale ChIP-Seq analysis.” *Nucleic Acids Research* 46 (D1): D252–D259. <https://doi.org/10.1093/nar/gkx1106>.

Lambert, Samuel A., Arttu Jolma, Laura F. Campitelli, Pratyush K. Das, Yimeng Yin, Mihai Albu, Xiaoting Chen, Jussi Taipale, Timothy R. Hughes, and Matthew T. Weirauch. 2018. “The Human Transcription Factors.” *Cell* 172 (4): 650–65. <https://doi.org/10.1016/j.cell.2018.01.029>.

Sonawane, Abhijeet Rajendra, John Platig, Maud Fagny, Cho Yi Chen, Joseph Nathaniel Paulson, Camila Miranda Lopes-Ramos, Dawn Lisa DeMeo, John Quackenbush, Kimberly Glass, and Marieke Lydia Kuijjer. 2017. “Understanding Tissue-Specific Gene Regulation.” *Cell Reports* 21 (4): 1077–88. <https://doi.org/10.1016/j.celrep.2017.10.001>.

Subramanian, Aravind, Pablo Tamayo, Vamsi K. Mootha, Sayan Mukherjee, Benjamin L. Ebert, Michael A. Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proceedings of the National Academy of Sciences* 102 (43): 15545–50. <https://doi.org/10.1073/pnas.0506580102>.

Weirauch, Matthew T., Ally Yang, Mihai Albu, Atina G. Cote, Alejandro Montenegro-Montero, Philipp Drewe, Hamed S. Najafabadi, et al. 2014. “Determination and Inference of Eukaryotic Transcription Factor Sequence Specificity.” *Cell* 158 (6): 1431–43. <https://doi.org/10.1016/j.cell.2014.08.009>.

Wingender, Edgar, Torsten Schoeps, Martin Haubrock, Mathias Krull, and Jürgen Dönitz. 2018. “TFClass: Expanding the classification of human transcription factors to their mammalian orthologs.” *Nucleic Acids Research* 46 (D1): D343–D347. <https://doi.org/10.1093/nar/gkx987>.