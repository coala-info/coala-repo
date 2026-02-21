# gwascat: structuring and querying the NHGRI GWAS catalog

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
  + [1.2 Attachment and access to documentation](#attachment-and-access-to-documentation)
  + [1.3 Using tidy methods – added August 2022](#using-tidy-methods-added-august-2022)
  + [1.4 Getting a recent version of the GWAS catalog](#getting-a-recent-version-of-the-gwas-catalog)
* [2 Illustrations: computing](#illustrations-computing)
* [3 Some visualizations](#some-visualizations)
  + [3.1 Basic Manhattan plot](#basic-manhattan-plot)
  + [3.2 Annotated Manhattan plot](#annotated-manhattan-plot)
  + [3.3 Integrative view of potential genetic determinants](#integrative-view-of-potential-genetic-determinants)
* [4 SNP sets and trait sets](#snp-sets-and-trait-sets)
  + [4.1 SNPs by name](#snps-by-name)
  + [4.2 Traits by genomic location](#traits-by-genomic-location)
* [5 Counting alleles associated with traits](#counting-alleles-associated-with-traits)
* [6 Formal management of trait vocabularies](#formal-management-of-trait-vocabularies)
  + [6.1 Diseases: Disease Ontology](#diseases-disease-ontology)
  + [6.2 Other phenotypic traits: Human Phenotype Ontology](#other-phenotypic-traits-human-phenotype-ontology)
* [7 CADD scores](#cadd-scores)
* [8 Appendix: Adequacy of location annotation](#appendix-adequacy-of-location-annotation)
* [9 Acknowledgment](#acknowledgment)
* [10 References](#references)
* **Appendix**

# 1 Introduction

NHGRI maintains and routinely updates a database of selected genome-wide
association studies. This document describes R/Bioconductor facilities for
working with contents of this database.

## 1.1 Installation

The package can be installed using Bioconductor’s
package, with the sequence

## 1.2 Attachment and access to documentation

Once the package has been installed, use to
obtain interactive access to all the facilities. After executing
this command, use to obtain an overview.
The current version of this vignette can always be accessed at
www.bioconductor.org, or by suitably navigating the web pages generated
with .

## 1.3 Using tidy methods – added August 2022

```
gwcat = get_cached_gwascat()
library(dplyr)
gwcat |> arrange(DATE)
```

```
## # A tibble: 1,000,000 × 38
##    DATE ADDED TO CATALO…¹ PUBMEDID `FIRST AUTHOR` DATE       JOURNAL LINK  STUDY
##    <IDate>                   <int> <chr>          <IDate>    <chr>   <chr> <chr>
##  1 2008-06-16             15761122 Klein RJ       2005-03-10 Science www.… Comp…
##  2 2008-06-16             16252231 Maraganore DM  2005-09-09 Am J H… www.… High…
##  3 2008-06-16             16648850 Arking DE      2006-04-30 Nat Ge… www.… A co…
##  4 2008-06-16             17052657 Fung HC        2006-09-28 Lancet… www.… Geno…
##  5 2008-06-16             17052657 Fung HC        2006-09-28 Lancet… www.… Geno…
##  6 2008-06-16             17052657 Fung HC        2006-09-28 Lancet… www.… Geno…
##  7 2008-06-16             17053108 Dewan A        2006-10-19 Science www.… HTRA…
##  8 2008-06-16             17068223 Duerr RH       2006-10-26 Science www.… A ge…
##  9 2008-06-16             17158188 Bierut LJ      2006-12-07 Hum Mo… www.… Nove…
## 10 2008-06-16             17158188 Bierut LJ      2006-12-07 Hum Mo… www.… Nove…
## # ℹ 999,990 more rows
## # ℹ abbreviated name: ¹​`DATE ADDED TO CATALOG`
## # ℹ 31 more variables: `DISEASE/TRAIT` <chr>, `INITIAL SAMPLE SIZE` <chr>,
## #   `REPLICATION SAMPLE SIZE` <chr>, REGION <chr>, CHR_ID <chr>, CHR_POS <chr>,
## #   `REPORTED GENE(S)` <chr>, MAPPED_GENE <chr>, UPSTREAM_GENE_ID <chr>,
## #   DOWNSTREAM_GENE_ID <chr>, SNP_GENE_IDS <chr>, UPSTREAM_GENE_DISTANCE <int>,
## #   DOWNSTREAM_GENE_DISTANCE <int>, `STRONGEST SNP-RISK ALLELE` <chr>, …
```

We can produce a GRanges in two forms. By default
we get an mcols that has a small set of columns. Note
that records that lack a `CHR_POS` value are omitted.
Records that have complicated `CHR_POS` values, including
semicolons or " x " notation are kept, but only the first
position is retained. The `CHR_ID` field may have
complicated character values, these are not normalized,
and are simply used as `seqnames` “as is”.

```
gg = gwcat |> as_GRanges()
gg
```

```
## GRanges object with 990960 ranges and 4 metadata columns:
##            seqnames    ranges strand |  PUBMEDID       DATE
##               <Rle> <IRanges>  <Rle> | <integer>    <IDate>
##        [1]        1  22373858      * |  26974007 2016-03-14
##        [2]        1 200132792      * |  26974007 2016-03-14
##        [3]        1   1238231      * |  26974007 2016-03-14
##        [4]        1   2559766      * |  26974007 2016-03-14
##        [5]        1   7962137      * |  26974007 2016-03-14
##        ...      ...       ...    ... .       ...        ...
##   [990956]        6  25727504      * |  40220762 2025-04-11
##   [990957]        6 135011428      * |  40220762 2025-04-11
##   [990958]        6 135025213      * |  40220762 2025-04-11
##   [990959]        6 135069698      * |  40220762 2025-04-11
##   [990960]        6 135070859      * |  40220762 2025-04-11
##                     DISEASE/TRAIT        SNPS
##                       <character> <character>
##        [1] Chronic inflammatory..  rs34920465
##        [2] Chronic inflammatory..   rs2816958
##        [3] Chronic inflammatory..   rs6697886
##        [4] Chronic inflammatory..   rs2234161
##        [5] Chronic inflammatory..   rs3766606
##        ...                    ...         ...
##   [990956] Blood cell traits la.. rs547711512
##   [990957] Blood cell traits la.. rs117206061
##   [990958] Blood cell traits la..  rs13192235
##   [990959] Blood cell traits la..   rs1547247
##   [990960] Blood cell traits la..  rs60723107
##   -------
##   seqinfo: 24 sequences from GRCh38 genome; no seqlengths
```

We can set the seqinfo as follows, retaining only
records that employ
standard chromosomes.

```
library(GenomeInfoDb)
data(si.hs.38)
gg = keepStandardChromosomes(gg, pruning="coarse")
seqlevels(gg) = seqlevels(si.hs.38)
seqinfo(gg) = si.hs.38
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 590 out-of-bound ranges located on sequences 9, 21,
##   13, 1, 2, 10, 22, 8, 19, 12, 4, 15, 14, and 6. Note that ranges located on a
##   sequence whose length is unknown (NA) or on a circular sequence are not
##   considered out-of-bound (use seqlengths() and isCircular() to get the lengths
##   and circularity flags of the underlying sequences). You can use trim() to
##   trim these ranges. See ?`trim,GenomicRanges-method` for more information.
```

```
gg
```

```
## GRanges object with 990960 ranges and 4 metadata columns:
##            seqnames    ranges strand |  PUBMEDID       DATE
##               <Rle> <IRanges>  <Rle> | <integer>    <IDate>
##        [1]        1  22373858      * |  26974007 2016-03-14
##        [2]        1 200132792      * |  26974007 2016-03-14
##        [3]        1   1238231      * |  26974007 2016-03-14
##        [4]        1   2559766      * |  26974007 2016-03-14
##        [5]        1   7962137      * |  26974007 2016-03-14
##        ...      ...       ...    ... .       ...        ...
##   [990956]        6  25727504      * |  40220762 2025-04-11
##   [990957]        6 135011428      * |  40220762 2025-04-11
##   [990958]        6 135025213      * |  40220762 2025-04-11
##   [990959]        6 135069698      * |  40220762 2025-04-11
##   [990960]        6 135070859      * |  40220762 2025-04-11
##                     DISEASE/TRAIT        SNPS
##                       <character> <character>
##        [1] Chronic inflammatory..  rs34920465
##        [2] Chronic inflammatory..   rs2816958
##        [3] Chronic inflammatory..   rs6697886
##        [4] Chronic inflammatory..   rs2234161
##        [5] Chronic inflammatory..   rs3766606
##        ...                    ...         ...
##   [990956] Blood cell traits la.. rs547711512
##   [990957] Blood cell traits la.. rs117206061
##   [990958] Blood cell traits la..  rs13192235
##   [990959] Blood cell traits la..   rs1547247
##   [990960] Blood cell traits la..  rs60723107
##   -------
##   seqinfo: 24 sequences from GRCh38 genome
```

## 1.4 Getting a recent version of the GWAS catalog

We use BiocFileCache to manage downloaded TSV from
EBI’s download site. The file is provided without
compression, so prepare for 200+MB download if you
are not working from a cache. There is no etag
set, so you have to check for updates on your own.

```
args(get_cached_gwascat)
```

```
## function (url = "http://www.ebi.ac.uk/gwas/api/search/downloads/alternative",
##     cache = BiocFileCache::BiocFileCache(), refresh = FALSE,
##     ...)
## NULL
```

This is converted to a manageable extension of GRanges using
`process_gwas_dataframe`.

```
args(process_gwas_dataframe)
```

```
## function (df)
## NULL
```

# 2 Illustrations: computing

Available functions are:

```
library(gwascat)
```

```
## gwascat loaded.  Use makeCurrentGwascat() to extract current image.
```

```
##  from EBI.  The data folder of this package has some legacy extracts.
```

```
objects("package:gwascat")
```

```
##  [1] "as_GRanges"             "bindcadd_snv"           "fixsnps"
##  [4] "getRsids"               "getTraits"              "get_cached_gwascat"
##  [7] "gwascat_from_AHub"      "gwcat_snapshot"         "gwcex2gviz"
## [10] "ldtagr"                 "locs4trait"             "makeCurrentGwascat"
## [13] "obo2graphNEL"           "process_gwas_dataframe" "riskyAlleleCount"
## [16] "subsetByChromosome"     "subsetByTraits"         "topTraits"
## [19] "traitsManh"
```

An extended GRanges instance with a sample of 50000 SNP-disease associations reported
on 30 April 2020 is
obtained as follows, with addresses based on the GRCh38 genome build.
We use `gwtrunc` to refer to it in the sequel.

```
data(ebicat_2020_04_30)
gwtrunc = ebicat_2020_04_30
```

To determine the most frequently occurring traits in this sample:

```
topTraits(gwtrunc)
```

```
##
##                        Blood protein levels
##                                        1941
##                   Heel bone mineral density
##                                        1309
##                             Body mass index
##                                        1283
##                                      Height
##                                        1238
##                           Metabolite levels
##                                         691
##                     Systolic blood pressure
##                                         654
##                               Schizophrenia
##                                         643
## Educational attainment (years of education)
##                                         642
##          Post bronchodilator FEV1/FVC ratio
##                                         479
##                             Type 2 diabetes
##                                         466
```

For a given trait, obtain a GRanges with all recorded associations; here
only three associations are shown:

```
subsetByTraits(gwtrunc, tr="LDL cholesterol")[1:3]
```

```
## gwasloc instance with 3 records and 38 attributes per record.
## Extracted:  2020-04-30 23:24:51
## metadata()$badpos includes records for which no unique locus was given.
## Genome:  GRCh38
## Excerpt:
## GRanges object with 3 ranges and 3 metadata columns:
##       seqnames    ranges strand |   DISEASE/TRAIT        SNPS   P-VALUE
##          <Rle> <IRanges>  <Rle> |     <character> <character> <numeric>
##   [1]        7  21567734      * | LDL cholesterol  rs12670798     6e-09
##   [2]        5  75355259      * | LDL cholesterol   rs3846662     2e-11
##   [3]        2  43837951      * | LDL cholesterol   rs6756629     3e-10
##   -------
##   seqinfo: 24 sequences from GRCh38 genome
```

# 3 Some visualizations

## 3.1 Basic Manhattan plot

A basic Manhattan plot is easily constructed with the
ggbio package facilities. Here we confine attention to
chromosomes 4:6. First, we create a version of the
catalog with \(-log\_{10} p\) truncated at a maximum value of 25.

```
requireNamespace("S4Vectors")
mcols = S4Vectors::mcols
mlpv = mcols(gwtrunc)$PVALUE_MLOG
mlpv = ifelse(mlpv > 25, 25, mlpv)
S4Vectors::mcols(gwtrunc)$PVALUE_MLOG = mlpv
library(GenomeInfoDb)
# seqlevelsStyle(gwtrunc) = "UCSC" # no more!
seqlevels(gwtrunc) = paste0("chr", seqlevels(gwtrunc))
gwlit = gwtrunc[ which(as.character(seqnames(gwtrunc)) %in% c("chr4", "chr5", "chr6")) ]
library(ggbio)
mlpv = mcols(gwlit)$PVALUE_MLOG
mlpv = ifelse(mlpv > 25, 25, mlpv)
S4Vectors::mcols(gwlit)$PVALUE_MLOG = mlpv
```

```
autoplot(gwlit, geom="point", aes(y=PVALUE_MLOG), xlab="chr4-chr6")
```

![](data:image/png;base64...)

## 3.2 Annotated Manhattan plot

A simple call permits visualization of GWAS results for
a small number of traits. Note the defaults in this call.

```
traitsManh(gwtrunc)
```

![](data:image/png;base64...)

%
%

## 3.3 Integrative view of potential genetic determinants

The following chunk uses GFF3 data on eQTL and related
phenomena distributed at the GBrowse instance at
eqtl.uchicago.edu. A request for all information at
43-45 Mb was made on 2 June 2012, yielding the GFF3 referenced below.
Of interest are locations and
scores of genetic associations with DNaseI hypersensitivity
(scores identifying dsQTL, see Degner et al 2012).

```
gffpath = system.file("gff3/chr17_43000000_45000000.gff3", package="gwascat")
library(rtracklayer)
c17tg = import(gffpath)
```

We make a Gviz DataTrack of the dsQTL scores.

```
c17td = c17tg[ which(S4Vectors::mcols(c17tg)$type == "Degner_dsQTL") ]
library(Gviz)
```

```
## Loading required package: grid
```

```
dsqs = DataTrack( c17td, chrom="chr17", genome="hg19", data="score",
  name="dsQTL")
```

We start the construction of the graph here.

```
g2 = GRanges(seqnames="chr17", IRanges(start=4.3e7, width=2e6))

basic = gwcex2gviz(basegr = gwtrunc, contextGR=g2, plot.it=FALSE)
```

```
##
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

We also collect locations of eQTL in the Stranger 2007
multipopulation eQTL study.

```
c17ts = c17tg[ which(S4Vectors::mcols(c17tg)$type == "Stranger_eqtl") ]
eqloc = AnnotationTrack(c17ts,  chrom="chr17", genome="hg19", name="Str eQTL")
displayPars(eqloc)$col = "black"
displayPars(dsqs)$col = "red"
integ = list(basic[[1]], eqloc, dsqs, basic[[2]], basic[[3]])
```

Now use Gviz.

```
plotTracks(integ)
```

![](data:image/png;base64...)

# 4 SNP sets and trait sets

## 4.1 SNPs by name

We can regard the content of a SNP chip as a set of SNP, referenced
by name. The
pd.genomewidesnp.6 package describes the Affymetrix SNP 6.0 chip.
We can determine which traits are associated with loci interrogated
by the chip as follows. We work with a subset of the 1 million loci
for illustration.

The data frame has information on 10000 probes,
acquired through the following code (not executed here to reduce
dependence on the pd.genomewidesnp.6 package, which is very large.

```
library(pd.genomewidesnp.6)
con = pd.genomewidesnp.6@getdb()
locon6 = dbGetQuery(con,
   "select dbsnp_rs_id, chrom, physical_pos from featureSet limit 10000")
```

Instead use the serialized information:

```
data(locon6)
rson6 = as.character(locon6[[1]])
rson6[1:5]
```

```
## [1] "rs2887286"  "rs1496555"  "rs41477744" "rs3890745"  "rs10492936"
```

We subset the GWAS ranges structure with rsids that
are common to both the chip and the GWAS catalog.
We then tabulate the diseases associated with the
common loci.

```
intr = gwtrunc[ intersect(getRsids(gwtrunc), rson6) ]
sort(table(getTraits(intr)), decreasing=TRUE)[1:10]
```

```
##
##    Adolescent idiopathic scoliosis                             Height
##                                  4                                  4
##                  Metabolite levels               Blood protein levels
##                                  4                                  3
##                    Body mass index                             Asthma
##                                  3                                  2
##           Diastolic blood pressure Post bronchodilator FEV1/FVC ratio
##                                  2                                  2
##                    Type 2 diabetes Age-related diseases and mortality
##                                  2                                  1
```

## 4.2 Traits by genomic location

We will assemble genomic coordinates for SNP on the Affymetrix 6.0 chip
and show the effects of identifying the trait-associated
loci with regions of width 1000bp instead
of 1bp.

The following code retrieves coordinates for SNP interrogated
on 10000 probes (to save time)
on the 6.0 chip, in a GRanges instance that was lifted over to GRCh38.
The data statement is preceded by legacy code that produced
an instance with hg19 coordinates.

```
#gr6.0 = GRanges(seqnames=ifelse(is.na(locon6$chrom),0,locon6$chrom),
#       IRanges(ifelse(is.na(locon6$phys),1,locon6$phys), width=1))
#S4Vectors::mcols(gr6.0)$rsid = as.character(locon6$dbsnp_rs_id)
#seqlevels(gr6.0) = paste("chr", seqlevels(gr6.0), sep="")
data(gr6.0_hg38)
```

Here we compute overlaps with both the raw disease-associated locus
addresses, and with the locus address \(\pm\) 500bp.

```
ag = function(x) as(x, "GRanges")
ovraw = suppressWarnings(subsetByOverlaps(ag(gwtrunc), gr6.0_hg38))
length(ovraw)
```

```
## [1] 125
```

```
ovaug = suppressWarnings(subsetByOverlaps(ag(gwtrunc+500), gr6.0_hg38))
length(ovaug)
```

```
## [1] 248
```

To acquire the subset of the catalog to which 6.0 probes are
within 500bp, use:

```
rawrs = mcols(ovraw)$SNPS
augrs = mcols(ovaug)$SNPS
gwtrunc[augrs]
```

```
## gwasloc instance with 248 records and 38 attributes per record.
## Extracted:  2020-04-30 23:24:51
## metadata()$badpos includes records for which no unique locus was given.
## Genome:  GRCh38
## Excerpt:
## GRanges object with 5 ranges and 3 metadata columns:
##       seqnames    ranges strand |          DISEASE/TRAIT        SNPS   P-VALUE
##          <Rle> <IRanges>  <Rle> |            <character> <character> <numeric>
##   [1]    chr11  78380104      * | Alzheimer's disease ..   rs2373115     1e-10
##   [2]    chr11  45851540      * |  Fasting blood glucose  rs11605924     1e-14
##   [3]     chr1 101475100      * |       Bipolar disorder   rs1419103     6e-06
##   [4]    chr11  43064544      * |  Cognitive performance  rs10501293     5e-06
##   [5]     chr1   2622185      * |   Rheumatoid arthritis   rs3890745     1e-07
##   -------
##   seqinfo: 24 sequences from GRCh38 genome
```

Relaxing the intersection criterion in this
limited case leads to a larger set of traits.

```
nn = setdiff( getTraits(gwtrunc[augrs]), getTraits(gwtrunc[rawrs]) )
length(nn)
```

```
## [1] 65
```

```
head(nn)
```

```
## [1] "Fasting blood glucose"               "Bipolar disorder"
## [3] "Obesity"                             "Osteonecrosis of the jaw"
## [5] "Optic nerve measurement (disc area)" "Venous thromboembolism"
```

```
tail(nn)
```

```
## [1] "Medication use (diuretics)"
## [2] "Pre-treatment viral load in HIV-1 infection"
## [3] "Medication use (agents acting on the renin-angiotensin system)"
## [4] "Macular thickness"
## [5] "Systolic blood pressure (alcohol consumption interaction)"
## [6] "Skin pigmentation"
```

# 5 Counting alleles associated with traits

We can use to count
risky alleles enumerated in the GWAS catalog. This
particular function assumes that we have genotyped at
the catalogued loci. Below we will discuss how to impute
from non-catalogued loci to those enumerated in the catalog.

```
data(gg17N) # translated from GGdata chr 17 calls using ABmat2nuc
gg17N[1:5,1:5]
```

```
##         rs6565733 rs1106175 rs17054921 rs8064924 rs8070440
## NA06985 "G/G"     "A/G"     "C/C"      "G/G"     "G/G"
## NA06991 "G/G"     "A/A"     "C/C"      "G/G"     "G/G"
## NA06993 "G/G"     "A/A"     "C/C"      "G/G"     "G/G"
## NA06994 "A/G"     "A/G"     "C/C"      "A/G"     "G/G"
## NA07000 "G/G"     "A/A"     "C/C"      "G/G"     "G/G"
```

This function can use genotype information in the A/B format,
assuming that B denotes the alphabetically later nucleotide.
Because we have direct nucleotide coding in our matrix, we set
the parameter to false in this call.

```
h17 = riskyAlleleCount(gg17N, matIsAB=FALSE, chr="ch17",
 gwwl = gwtrunc)
h17[1:5,1:5]
```

```
##         rs2034088 rs741677 rs9907102 rs8066620 rs12603526
## NA06985         0        0         0         2          0
## NA06991         1        1         0         2          0
## NA06993         1        2         0         2          0
## NA06994         2        2         0         2          0
## NA07000         1        2         0         1          0
```

```
table(as.numeric(h17))
```

```
##
##     0     1     2
## 34530 14477 10483
```

It is of interest to bind the counts back to the catalog data.

```
gwr = gwtrunc
gwr = gwr[colnames(h17),]
S4Vectors::mcols(gwr) = cbind(mcols(gwr), DataFrame(t(h17)))
sn = rownames(h17)
gwr[,c("DISEASE/TRAIT", sn[1:4])]
```

```
## gwasloc instance with 661 records and 5 attributes per record.
## Extracted:  2020-04-30 23:24:51
## metadata()$badpos includes records for which no unique locus was given.
## Genome:  GRCh38
## Excerpt:
## GRanges object with 5 ranges and 5 metadata columns:
##       seqnames    ranges strand |          DISEASE/TRAIT   NA06985   NA06991
##          <Rle> <IRanges>  <Rle> |            <character> <integer> <integer>
##   [1]    chr17    519811      * | Hip circumference ad..         0         1
##   [2]    chr17    560603      * | Waist circumference ..         0         1
##   [3]    chr17    561592      * |      Metabolite levels         0         0
##   [4]    chr17    835613      * | Heel bone mineral de..         2         2
##   [5]    chr17    897353      * |      Colorectal cancer         0         0
##         NA06993   NA06994
##       <integer> <integer>
##   [1]         1         2
##   [2]         2         2
##   [3]         0         0
##   [4]         2         2
##   [5]         0         0
##   -------
##   seqinfo: 24 sequences from GRCh38 genome
```

Now by programming on the metadata columns, we can identify
individuals with particular risk profiles.

# 6 Formal management of trait vocabularies

## 6.1 Diseases: Disease Ontology

The Disease Ontology project Osborne et al. ([2009](#ref-Osborne:2009p4571)) formalizes a vocabulary
for human diseases. Bioconductor’s DO.db package is a curated
representation.

```
library(DO.db)
```

```
## Loading required package: AnnotationDbi
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
## Attaching package: 'AnnotationDbi'
```

```
## The following object is masked from 'package:dplyr':
##
##     select
```

```
DO()
```

```
## Quality control information for DO:
##
##
## This package has the following mappings:
##
## DOANCESTOR has 6569 mapped keys (of 6570 keys)
## DOCHILDREN has 1811 mapped keys (of 6570 keys)
## DOOBSOLETE has 2374 mapped keys (of 2374 keys)
## DOOFFSPRING has 1811 mapped keys (of 6570 keys)
## DOPARENTS has 6569 mapped keys (of 6570 keys)
## DOTERM has 6570 mapped keys (of 6570 keys)
##
##
## Additional Information about this package:
##
## DB schema: DO_DB
## DB schema version: 1.0
```

All tokens of the ontology are acquired via:

```
alltob = unlist(mget(mappedkeys(DOTERM), DOTERM))
allt = sapply(alltob, Term)
allt[1:5]
```

```
##                      DOID:0001816                      DOID:0002116
##                    "angiosarcoma"                       "pterygium"
##                      DOID:0014667                      DOID:0050004
##           "disease of metabolism" "seminal vesicle acute gonorrhea"
##                      DOID:0050012
##                     "chikungunya"
```

Direct mapping from disease trait tokens in the catalog
to this vocabulary succeeds for a modest proportion of
records.

```
cattra = mcols(gwtrunc)$`DISEASE/TRAIT`
mat = match(tolower(cattra), tolower(allt))
catDO = names(allt)[mat]
na.omit(catDO)[1:50]
```

```
##  [1] "DOID:8778"    "DOID:8778"    "DOID:8778"    "DOID:8778"    "DOID:8778"
##  [6] "DOID:8778"    "DOID:8778"    "DOID:8778"    "DOID:8778"    "DOID:8778"
## [11] "DOID:8778"    "DOID:8778"    "DOID:8778"    "DOID:8577"    "DOID:8577"
## [16] "DOID:8577"    "DOID:10652"   "DOID:8778"    "DOID:8778"    "DOID:8778"
## [21] "DOID:8778"    "DOID:8778"    "DOID:9256"    "DOID:9256"    "DOID:9256"
## [26] "DOID:8893"    "DOID:5419"    "DOID:1909"    "DOID:1324"    "DOID:1324"
## [31] "DOID:8577"    "DOID:8577"    "DOID:10652"   "DOID:3312"    "DOID:3312"
## [36] "DOID:3312"    "DOID:3312"    "DOID:1324"    "DOID:1324"    "DOID:1324"
## [41] "DOID:7148"    "DOID:1040"    "DOID:3910"    "DOID:8778"    "DOID:8778"
## [46] "DOID:8577"    "DOID:8577"    "DOID:8577"    "DOID:8577"    "DOID:0050425"
```

```
mean(is.na(catDO))
```

```
## [1] 0.90354
```

Approximate matching of unmatched tokens can proceed
by various routes. Some traits are not diseases, and
will not be mappable using Disease Ontology. However, consider

```
unique(cattra[is.na(catDO)])[1:20]
```

```
##  [1] "Alcohol consumption (transferrin glycosylation)"
##  [2] "Sudden cardiac arrest"
##  [3] "Orofacial clefts (maternal alcohol consumption interaction)"
##  [4] "Height"
##  [5] "Pulmonary function"
##  [6] "Glioma"
##  [7] "Bone mineral density (hip)"
##  [8] "Bone mineral density (spine)"
##  [9] "Idiopathic dilated cardiomyopathy"
## [10] "Osteoporosis-related phenotypes"
## [11] "Cutaneous nevi"
## [12] "Primary biliary cholangitis"
## [13] "Cardiac hypertrophy"
## [14] "Adiposity"
## [15] "Uric acid levels"
## [16] "Type 1 diabetes"
## [17] "Alzheimer's disease (late onset)"
## [18] "Fasting blood insulin"
## [19] "Fasting blood glucose"
## [20] "Homeostasis model assessment of beta-cell function"
```

```
nomatch = cattra[is.na(catDO)]
unique(nomatch)[1:5]
```

```
## [1] "Alcohol consumption (transferrin glycosylation)"
## [2] "Sudden cardiac arrest"
## [3] "Orofacial clefts (maternal alcohol consumption interaction)"
## [4] "Height"
## [5] "Pulmonary function"
```

Manual searching shows that a number of these have
very close matches.

## 6.2 Other phenotypic traits: Human Phenotype Ontology

Bioconductor does not possess an annotation package for phenotype ontology,
but the standardized OBO format can be parsed and modeled into a graph.

```
hpobo = gzfile(dir(system.file("obo", package="gwascat"), pattern="hpo", full=TRUE))
HPOgraph = obo2graphNEL(hpobo)
close(hpobo)
```

The phenotypic terms are obtained via:

```
requireNamespace("graph")
hpoterms = unlist(graph::nodeData(HPOgraph, graph::nodes(HPOgraph), "name"))
hpoterms[1:10]
```

```
##                                 HP:0000001
##                                      "All"
##                                 HP:0000002
##               "Abnormality of body height"
##                                 HP:0000003
##             "Multicystic kidney dysplasia"
##                                 HP:0000004
##                "Onset and clinical course"
##                                 HP:0000005
##                      "Mode of inheritance"
##                                 HP:0000006
##           "Autosomal dominant inheritance"
##                                 HP:0000007
##          "Autosomal recessive inheritance"
##                                 HP:0000008
## "Abnormality of female internal genitalia"
##                                 HP:0000009
##    "Functional abnormality of the bladder"
##                                 HP:0000010
##       "Recurrent urinary tract infections"
```

Exact hits to unmatched GWAS catalog traits exist:

```
intersect(tolower(nomatch), tolower(hpoterms))
```

```
##  [1] "glioma"                        "stroke"
##  [3] "autism"                        "glioblastoma"
##  [5] "knee osteoarthritis"           "coronary artery calcification"
##  [7] "hearing impairment"            "nephropathy"
##  [9] "hypertriglyceridemia"          "insomnia"
## [11] "depression"                    "eczema"
## [13] "nasal polyps"                  "eating disorders"
## [15] "ischemic stroke"               "iga nephropathy"
## [17] "hematuria"                     "neurofibrillary tangles"
## [19] "hashimoto thyroiditis"         "selective iga deficiency"
## [21] "headache"                      "thrombosis"
## [23] "dysphagia"                     "excessive daytime sleepiness"
## [25] "benign prostatic hyperplasia"  "bicuspid aortic valve"
## [27] "orthostatic hypotension"       "freckling"
## [29] "impulsivity"
```

More work on formalization of trait terms is underway.

%## {Curation of approximate matches}

% NB the graph stuff can be used for other OBO without .db packages..
%The package includes an OBO-formatted
%image of the ontology and a model for it as a instance
%as defined in the Bioconductor package .

%The graph model is constructed as follows.
%<<dogrmod}
%doobo = dir(system.file(“obo”, package=“gwascat”), full=TRUE, patt=“HumanDO”)
%DOgraph = obo2graphNEL(doobo)
%DOgraph
%@
%
%Nodes are the formal disease term identifiers; node data provides additional
%metadata.
%<<lkno}
%nodeData(DOgraph)[1:5]
%@

# 7 CADD scores

Kircher et al. ([2014](#ref-Kircher:2014p5681)) define combined annotation-dependent
depletion scores measuring variant pathogenicity in an integrative way.
Small requests to bind scores for SNV to GRanges can be resolved
through HTTP; large requests can be carried out on a local tabix-indexed
selection from their archive.

```
g3 = as(gwtrunc, "GRanges")
bg3 = bindcadd_snv( g3[which(seqnames(g3)=="chr3")][1:20] )
inds = ncol(mcols(bg3))
bg3[, (inds-3):inds]
```

This requires cooperation of network interface and server, so we
don’t evaluate in vignette build but on 1 Apr 2014 the response was:

```
GRanges with 20 ranges and 4 metadata columns:
       seqnames                 ranges strand   |         Ref         Alt
          <Rle>              <IRanges>  <Rle>   | <character> <character>
   [1]        3 [109789570, 109789570]      *   |           A           G
   [2]        3 [ 25922285,  25922285]      *   |           G           A
   [3]        3 [109529550, 109529550]      *   |           T           C
   [4]        3 [175055759, 175055759]      *   |           T           G
   [5]        3 [191912870, 191912870]      *   |           C           T
   ...      ...                    ...    ... ...         ...         ...
  [16]        3 [187716886, 187716886]      *   |           A           G
  [17]        3 [160820524, 160820524]      *   |           G           C
  [18]        3 [169518455, 169518455]      *   |           T           C
  [19]        3 [179172979, 179172979]      *   |           G           T
  [20]        3 [171785168, 171785168]      *   |           G           C
          CScore     PHRED
       <numeric> <numeric>
   [1] -0.182763     3.110
   [2] -0.289708     2.616
   [3]  0.225373     5.216
   [4] -0.205689     3.003
   [5] -0.172189     3.161
   ...       ...       ...
  [16] -0.019710     3.913
  [17] -0.375183     2.235
  [18] -0.695270     0.987
  [19] -0.441673     1.949
  [20]  0.231972     5.252
  ---
  seqlengths:
           1         2         3         4 ...        21        22         X
   249250621 243199373 198022430 191154276 ...  48129895  51304566 155270560
```

# 8 Appendix: Adequacy of location annotation

A basic question concerning the use of archived
SNP identifiers is durability
of the association between asserted location
and SNP identifier. The
function uses a current Bioconductor
SNPlocs package to check this.

For example, to verify that locations asserted on chromosome
20 agree between the Bioconductor dbSNP image and the
gwas catalog,

```
if ("SNPlocs.Hsapiens.dbSNP144.GRCh37" %in% installed.packages()[,1]) {
 library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
 chklocs("20", gwtrunc)
}
```

This is not a fast procedure.

# 9 Acknowledgment

The development of this software was supported in part
by Robert Gentleman and the
Computational Biology Group of
Genentech, Inc.

# 10 References

Kircher, Martin, Daniela M Witten, Preti Jain, Brian J O’Roak, Gregory M Cooper, and Jay Shendure. 2014. “A General Framework for Estimating the Relative Pathogenicity of Human Genetic Variants.” *Nat Genet*, February. <https://doi.org/10.1038/ng.2892>.

Osborne, John D, Jared Flatow, Michelle Holko, Simon M Lin, Warren A Kibbe, Lihua Julie Zhu, Maria I Danila, Gang Feng, and Rex L Chisholm. 2009. “Annotating the Human Genome with Disease Ontology.” *BMC Genomics* 10 Suppl 1 (January): S6. <https://doi.org/10.1186/1471-2164-10-S1-S6>.

# Appendix