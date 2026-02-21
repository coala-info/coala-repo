# motifbreakR: an Introduction

#### Simon G. Coetzee, Gerhard A. Coetzee and Dennis J. Hazelett

#### 2025-10-30

* [1 Introduction](#introduction)
* [2 Processing overview](#flow)
  + [2.1 Outline of process](#outline-of-process)
* [3 How To Use motifbreakR: A Practical Example](#practical)
  + [3.1 *Step 1* | Read in Single Nucleotide Variants](#step-1-read-in-single-nucleotide-variants)
  + [3.2 *Step 2* | Find Broken Motifs](#step-2-find-broken-motifs)
  + [3.3 *Step 3* | Visualize](#step-3-visualize)
  + [3.4 *Added functionality* | Query Remap 2022 Peaks](#added-functionality-query-remap-2022-peaks)
  + [3.5 *Export Results*](#export-results)
* [4 Methods](#methods)
  + [4.1 Sum of Log Probabilities](#eqn1)
  + [4.2 Weighted Sum](#weighted-sum)
  + [4.3 Calculating Scoring Vector \(p\)](#calculating-scoring-vector-p)
  + [4.4 Calculating \(\omega\) For Weighted Sum](#eqn4.1)
  + [4.5 Calculating \(\omega\) For Relative Entropy](#eqn4.2)
  + [4.6 Calculate P-values for PWM match](#calculate-p-values-for-pwm-match)
* [5 Session Info](#session-info)

# 1 Introduction

This document offers an introduction and overview of *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)*, which allows the biologist to judge whether the sequence surrounding a polymorphism or mutation is a good match to known transcription factor binding sites, and how much information is gained or lost in one allele of the polymorphism relative to another or mutation vs. wildtype. *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* is flexible, giving a choice of algorithms for interrogation of genomes with motifs from public sources that users can choose from; these are 1) a weighted-sum, 2) log-probabilities, and 3) relative entropy. *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* can predict effects for novel or previously described variants in public databases, making it suitable for tasks beyond the scope of its original design. Lastly, it can be used to interrogate any genome curated within Bioconductor.

As of version 2.0 *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* is also able to perform it’s analysis on indels, small insertions or deletions.

*[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* works with position probability matrices (PPM). PPM are derived as the fractional occurrence of nucleotides A,C,G, and T at each position of a position frequency matrix (PFM). PFM are simply the tally of each nucleotide at each position across a set of aligned sequences. With a PPM, one can generate probabilities based on the genome, or more practically, create any number of position specific scoring matrices (PSSM) based on the principle that the PPM contains information about the likelihood of observing a particular nucleotide at a particular position of a true transcription factor binding site.

This guide includes a brief overview of the [processing flow](#flow), an example focusing more in depth on the [practical](#practical) aspect of using *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)*, and finally a detailed section on the [scoring methods](#methods) employed by the package.

# 2 Processing overview

*[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* may be used to interrogate SNPs or SNVs for their potential effect on transcription factor binding by examining how the two alleles of the variant effect the binding score of a motif. The basic process is outlined in the figure below.

## 2.1 Outline of process

![](data:image/png;base64...)

*motifbreakR workflow: How inputs (trapezoids) are generated from R functions (rectangles). Diamonds represent decisions of the user.*

This straightforward process allows the interrogation of SNPs and SNVs in the context of the different species represented by *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* packages (at least 22 different species) and allows the use of the full *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* data set that includes over 4200 motifs across 8 studies and 22 organisms that we have supplemented with over 2800 additional motifs across four additional studies in Humans see `data(encodemotif)`[1](#fn1), `data(factorbook)`[2](#fn2), `data(hocomoco)`[3](#fn3) and `data(homer)`[4](#fn4) for the additional studies that we have included.

Practically *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* has involves three phases.

1. *Read in Single Nucleotide Variants or Indels:* The first step is to read in the list of variants. Variants can be a list of rsIDs if your SNPs are represented in one of the SNPlocs packages, may be included as a [.bed](http://www.genome.ucsc.edu/FAQ/FAQformat.html#format1) file with a specifically formatted name field, or may be provided as a [.vcf](http://www.1000genomes.org/wiki/analysis/variant%20call%20format/vcf-variant-call-format-version-41) file. We then transform these input such that it may be read my *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)*.
2. *Find Broken Motifs:* Next we present *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* with the input generated in the previous step, along with a set of motifs formatted as class `MotifList`, and your preferred [scoring method](#methods).
3. *Visualize SNPs and motifs:* Finally we can visualize which motifs are broken by any individual SNP using our plotting function.

# 3 How To Use motifbreakR: A Practical Example

This section offers an example of how to use *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* to identify potentially disrupted transcription factor binding sites due to 701 SNPs output from a *[FunciSNP](https://bioconductor.org/packages/3.22/FunciSNP)* analysis of Prostate Cancer (PCa) genome wide association studies (GWAS) risk loci. The SNPs are included in this package here:

```
library(motifbreakR)
pca.snps.file <- system.file("extdata", "pca.enhancer.snps", package = "motifbreakR")
pca.snps <- as.character(read.table(pca.snps.file)[,1])
```

The simplest form of a *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* analysis is summarized as follows:

```
variants <- snps.from.rsid(rsid = pca.snps,
                           dbSNP = SNPlocs.Hsapiens.dbSNP155.GRCh37,
                           search.genome = BSgenome.Hsapiens.UCSC.hg19)
motifbreakr.results <- motifbreakR(snpList = variants, pwmList = MotifDb, threshold = 0.9)
plotMB(results = motifbreakr.results, rsid = "rs7837328", effect = "strong")
```

Lets look at these steps more closely and see how we can customize our analysis.

## 3.1 *Step 1* | Read in Single Nucleotide Variants

Variants can be input either as a list of rsIDs or as a [.bed](http://www.genome.ucsc.edu/FAQ/FAQformat.html#format1) file. The main factor determining which you will use is if your variants have rsIDs that are included in one of the Bioconductor `SNPlocs` packages. The present selection is seen here:

```
library(BSgenome)
available.SNPs()
```

```
## [1] "SNPlocs.Hsapiens.dbSNP144.GRCh37"     "SNPlocs.Hsapiens.dbSNP144.GRCh38"
## [3] "SNPlocs.Hsapiens.dbSNP149.GRCh38"     "SNPlocs.Hsapiens.dbSNP150.GRCh38"
## [5] "SNPlocs.Hsapiens.dbSNP155.GRCh37"     "SNPlocs.Hsapiens.dbSNP155.GRCh38"
## [7] "XtraSNPlocs.Hsapiens.dbSNP144.GRCh37" "XtraSNPlocs.Hsapiens.dbSNP144.GRCh38"
```

For cases where your rsIDs are not available in a SNPlocs package, or you have novel variants that are not cataloged at all, variants may be entered in [BED](http://www.genome.ucsc.edu/FAQ/FAQformat.html#format1) format as seen below:

```
snps.file <- system.file("extdata", "snps.bed", package = "motifbreakR")
read.delim(snps.file, header = FALSE)
```

```
##     V1        V2        V3                V4 V5 V6
## 1 chr2  12581137  12581138        rs10170896  0  +
## 2 chr2  12594017  12594018 chr2:12594018:G:A  0  +
## 3 chr3 192388677 192388678        rs13068005  0  +
## 4 chr4 122361479 122361480        rs12644995  0  +
## 5 chr6  44503245  44503246 chr6:44503246:A:T  0  +
## 6 chr6  44503247  44503248 chr6:44503248:G:C  0  +
## 7 chr6  85232897  85232898         rs4510639  0  +
## 8 chr6  44501872  44501873          rs932680  0  +
```

Our requirements for the BED file are that it must include `chromosome`, `start`, `end`, `name`, `score` and `strand` fields – where the name field is required to be in one of two formats, either an rsID that is present in a SNPlocs package, or in the form `chromosome:position:referenceAllele:alternateAllele` e.g., `chr2:12594018:G:A`. It is also essential that the fields are TAB separated, not a mixture of tabs and spaces.

More to the point here are the two methods for reading in the variants.

### 3.1.1 SNPs from rsID:

We use the *[SNPlocs.Hsapiens.dbSNP155.GRCh37](https://bioconductor.org/packages/3.22/SNPlocs.Hsapiens.dbSNP155.GRCh37)* which is the SNP locations and alleles defined in [dbSNP155](http://www.ncbi.nlm.nih.gov/projects/SNP/snp_summary.cgi?view+summary=view+summary&build_id=155) as a source for looking up our rsIDs and *[BSgenome.Hsapiens.UCSC.hg19](https://bioconductor.org/packages/3.22/BSgenome.Hsapiens.UCSC.hg19)* which holds the reference sequence for [UCSC genome build hg19](http://www.ncbi.nlm.nih.gov/assembly/2758/). Additional SNPlocs packages are availble from Bioconductor.

```
library(SNPlocs.Hsapiens.dbSNP155.GRCh37) # dbSNP155 in hg19
```

```
## Warning: replacing previous import 'utils::findMatches' by 'S4Vectors::findMatches' when loading
## 'SNPlocs.Hsapiens.dbSNP155.GRCh37'
```

```
library(BSgenome.Hsapiens.UCSC.hg19)     # hg19 genome
head(pca.snps)
```

```
## [1] "rs1551515"  "rs1551513"  "rs17762938" "rs4473999"  "rs7823297"  "rs9656964"
```

```
snps.mb <- snps.from.rsid(rsid = pca.snps,
                          dbSNP = SNPlocs.Hsapiens.dbSNP155.GRCh37,
                          search.genome = BSgenome.Hsapiens.UCSC.hg19)
```

```
## Warning in rowids2rowidx(user_rowids, ids, x_rowids_env, ifnotfound): SNP ids not found: rs78914317, rs75425437, rs114099824, rs79509278, rs74738513, rs137898974
##
##   They were dropped.
```

```
snps.mb
```

```
## GRanges object with 1173 ranges and 3 metadata columns:
##                seqnames    ranges strand |      SNP_id            REF            ALT
##                   <Rle> <IRanges>  <Rle> | <character> <DNAStringSet> <DNAStringSet>
##   rs10007915:A     chr4 106065308      * |  rs10007915              C              A
##   rs10007915:G     chr4 106065308      * |  rs10007915              C              G
##   rs10007915:T     chr4 106065308      * |  rs10007915              C              T
##     rs10015716     chr4  95548550      * |  rs10015716              G              A
##   rs10034824:A     chr4  95524838      * |  rs10034824              G              A
##            ...      ...       ...    ... .         ...            ...            ...
##     rs991429:T    chr17  69109773      * |    rs991429              G              T
##      rs9973650     chr2 238380266      * |   rs9973650              G              A
##     rs998071:A     chr4  95591976      * |    rs998071              C              A
##     rs998071:G     chr4  95591976      * |    rs998071              C              G
##     rs998071:T     chr4  95591976      * |    rs998071              C              T
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
```

A far greater variety of variants may be read into *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* via the `snps.from.file` function. In fact *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* will work with any organism present as a Bioconductor *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* package. This includes 76 genomes representing 22 species.

```
library(BSgenome)
genomes <- available.genomes()
length(genomes)
```

```
## [1] 113
```

```
genomes
```

```
##   [1] "BSgenome.Alyrata.JGI.v1"
##   [2] "BSgenome.Amellifera.BeeBase.assembly4"
##   [3] "BSgenome.Amellifera.NCBI.AmelHAv3.1"
##   [4] "BSgenome.Amellifera.UCSC.apiMel2"
##   [5] "BSgenome.Amellifera.UCSC.apiMel2.masked"
##   [6] "BSgenome.Aofficinalis.NCBI.V1"
##   [7] "BSgenome.Athaliana.TAIR.04232008"
##   [8] "BSgenome.Athaliana.TAIR.TAIR9"
##   [9] "BSgenome.Btaurus.UCSC.bosTau3"
##  [10] "BSgenome.Btaurus.UCSC.bosTau3.masked"
##  [11] "BSgenome.Btaurus.UCSC.bosTau4"
##  [12] "BSgenome.Btaurus.UCSC.bosTau4.masked"
##  [13] "BSgenome.Btaurus.UCSC.bosTau6"
##  [14] "BSgenome.Btaurus.UCSC.bosTau6.masked"
##  [15] "BSgenome.Btaurus.UCSC.bosTau8"
##  [16] "BSgenome.Btaurus.UCSC.bosTau9"
##  [17] "BSgenome.Btaurus.UCSC.bosTau9.masked"
##  [18] "BSgenome.Carietinum.NCBI.v1"
##  [19] "BSgenome.Celegans.UCSC.ce10"
##  [20] "BSgenome.Celegans.UCSC.ce11"
##  [21] "BSgenome.Celegans.UCSC.ce2"
##  [22] "BSgenome.Celegans.UCSC.ce6"
##  [23] "BSgenome.Cfamiliaris.UCSC.canFam2"
##  [24] "BSgenome.Cfamiliaris.UCSC.canFam2.masked"
##  [25] "BSgenome.Cfamiliaris.UCSC.canFam3"
##  [26] "BSgenome.Cfamiliaris.UCSC.canFam3.masked"
##  [27] "BSgenome.Cjacchus.UCSC.calJac3"
##  [28] "BSgenome.Cjacchus.UCSC.calJac4"
##  [29] "BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1"
##  [30] "BSgenome.Creinhardtii.JGI.v5.6"
##  [31] "BSgenome.Dmelanogaster.UCSC.dm2"
##  [32] "BSgenome.Dmelanogaster.UCSC.dm2.masked"
##  [33] "BSgenome.Dmelanogaster.UCSC.dm3"
##  [34] "BSgenome.Dmelanogaster.UCSC.dm3.masked"
##  [35] "BSgenome.Dmelanogaster.UCSC.dm6"
##  [36] "BSgenome.Drerio.UCSC.danRer10"
##  [37] "BSgenome.Drerio.UCSC.danRer11"
##  [38] "BSgenome.Drerio.UCSC.danRer5"
##  [39] "BSgenome.Drerio.UCSC.danRer5.masked"
##  [40] "BSgenome.Drerio.UCSC.danRer6"
##  [41] "BSgenome.Drerio.UCSC.danRer6.masked"
##  [42] "BSgenome.Drerio.UCSC.danRer7"
##  [43] "BSgenome.Drerio.UCSC.danRer7.masked"
##  [44] "BSgenome.Dvirilis.Ensembl.dvircaf1"
##  [45] "BSgenome.Ecoli.NCBI.20080805"
##  [46] "BSgenome.Gaculeatus.UCSC.gasAcu1"
##  [47] "BSgenome.Gaculeatus.UCSC.gasAcu1.masked"
##  [48] "BSgenome.Ggallus.UCSC.galGal3"
##  [49] "BSgenome.Ggallus.UCSC.galGal3.masked"
##  [50] "BSgenome.Ggallus.UCSC.galGal4"
##  [51] "BSgenome.Ggallus.UCSC.galGal4.masked"
##  [52] "BSgenome.Ggallus.UCSC.galGal5"
##  [53] "BSgenome.Ggallus.UCSC.galGal6"
##  [54] "BSgenome.Gmax.NCBI.Gmv40"
##  [55] "BSgenome.Hsapiens.1000genomes.hs37d5"
##  [56] "BSgenome.Hsapiens.NCBI.GRCh38"
##  [57] "BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0"
##  [58] "BSgenome.Hsapiens.UCSC.hg17"
##  [59] "BSgenome.Hsapiens.UCSC.hg17.masked"
##  [60] "BSgenome.Hsapiens.UCSC.hg18"
##  [61] "BSgenome.Hsapiens.UCSC.hg18.masked"
##  [62] "BSgenome.Hsapiens.UCSC.hg19"
##  [63] "BSgenome.Hsapiens.UCSC.hg19.masked"
##  [64] "BSgenome.Hsapiens.UCSC.hg38"
##  [65] "BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major"
##  [66] "BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor"
##  [67] "BSgenome.Hsapiens.UCSC.hg38.masked"
##  [68] "BSgenome.Hsapiens.UCSC.hs1"
##  [69] "BSgenome.Mdomestica.UCSC.monDom5"
##  [70] "BSgenome.Mfascicularis.NCBI.5.0"
##  [71] "BSgenome.Mfascicularis.NCBI.6.0"
##  [72] "BSgenome.Mfuro.UCSC.musFur1"
##  [73] "BSgenome.Mmulatta.UCSC.rheMac10"
##  [74] "BSgenome.Mmulatta.UCSC.rheMac2"
##  [75] "BSgenome.Mmulatta.UCSC.rheMac2.masked"
##  [76] "BSgenome.Mmulatta.UCSC.rheMac3"
##  [77] "BSgenome.Mmulatta.UCSC.rheMac3.masked"
##  [78] "BSgenome.Mmulatta.UCSC.rheMac8"
##  [79] "BSgenome.Mmusculus.UCSC.mm10"
##  [80] "BSgenome.Mmusculus.UCSC.mm10.masked"
##  [81] "BSgenome.Mmusculus.UCSC.mm39"
##  [82] "BSgenome.Mmusculus.UCSC.mm8"
##  [83] "BSgenome.Mmusculus.UCSC.mm8.masked"
##  [84] "BSgenome.Mmusculus.UCSC.mm9"
##  [85] "BSgenome.Mmusculus.UCSC.mm9.masked"
##  [86] "BSgenome.Osativa.MSU.MSU7"
##  [87] "BSgenome.Ppaniscus.UCSC.panPan1"
##  [88] "BSgenome.Ppaniscus.UCSC.panPan2"
##  [89] "BSgenome.Ptroglodytes.UCSC.panTro2"
##  [90] "BSgenome.Ptroglodytes.UCSC.panTro2.masked"
##  [91] "BSgenome.Ptroglodytes.UCSC.panTro3"
##  [92] "BSgenome.Ptroglodytes.UCSC.panTro3.masked"
##  [93] "BSgenome.Ptroglodytes.UCSC.panTro5"
##  [94] "BSgenome.Ptroglodytes.UCSC.panTro6"
##  [95] "BSgenome.Rnorvegicus.UCSC.rn4"
##  [96] "BSgenome.Rnorvegicus.UCSC.rn4.masked"
##  [97] "BSgenome.Rnorvegicus.UCSC.rn5"
##  [98] "BSgenome.Rnorvegicus.UCSC.rn5.masked"
##  [99] "BSgenome.Rnorvegicus.UCSC.rn6"
## [100] "BSgenome.Rnorvegicus.UCSC.rn7"
## [101] "BSgenome.Scerevisiae.UCSC.sacCer1"
## [102] "BSgenome.Scerevisiae.UCSC.sacCer2"
## [103] "BSgenome.Scerevisiae.UCSC.sacCer3"
## [104] "BSgenome.Sscrofa.UCSC.susScr11"
## [105] "BSgenome.Sscrofa.UCSC.susScr3"
## [106] "BSgenome.Sscrofa.UCSC.susScr3.masked"
## [107] "BSgenome.Tgondii.ToxoDB.7.0"
## [108] "BSgenome.Tguttata.UCSC.taeGut1"
## [109] "BSgenome.Tguttata.UCSC.taeGut1.masked"
## [110] "BSgenome.Tguttata.UCSC.taeGut2"
## [111] "BSgenome.Vvinifera.URGI.IGGP12Xv0"
## [112] "BSgenome.Vvinifera.URGI.IGGP12Xv2"
## [113] "BSgenome.Vvinifera.URGI.IGGP8X"
```

### 3.1.2 SNPs from BED formatted file:

Here we examine two possibilities. In one case we have a mixture of rsIDs and our naming scheme that allows for arbitrary variants. Second we have a list of variants for the zebrafish *Danio rerio* that does not have a `SNPlocs` package, but does have it’s genome present among the `availible.genomes()`.

```
snps.bed.file <- system.file("extdata", "snps.bed", package = "motifbreakR")
# see the contents
read.table(snps.bed.file, header = FALSE)
```

```
##     V1        V2        V3                V4 V5 V6
## 1 chr2  12581137  12581138        rs10170896  0  +
## 2 chr2  12594017  12594018 chr2:12594018:G:A  0  +
## 3 chr3 192388677 192388678        rs13068005  0  +
## 4 chr4 122361479 122361480        rs12644995  0  +
## 5 chr6  44503245  44503246 chr6:44503246:A:T  0  +
## 6 chr6  44503247  44503248 chr6:44503248:G:C  0  +
## 7 chr6  85232897  85232898         rs4510639  0  +
## 8 chr6  44501872  44501873          rs932680  0  +
```

Seeing as we have some SNPs listed by their rsIDs we can query those by including a SNPlocs object as an argument to `snps.from.file`

```
library(SNPlocs.Hsapiens.dbSNP155.GRCh37)
#import the BED file
snps.mb.frombed <- snps.from.file(file = snps.bed.file,
                                  dbSNP = SNPlocs.Hsapiens.dbSNP155.GRCh37,
                                  search.genome = BSgenome.Hsapiens.UCSC.hg19,
                                  format = "bed", check.unnamed.for.rsid = TRUE)
snps.mb.frombed
```

```
## Warning in snps.from.file(file = snps.bed.file, dbSNP = SNPlocs.Hsapiens.dbSNP155.GRCh37,  :
##   rs7601289 was found as a match for chr2:12594018:G:A; using entry from dbSNP
##   rs11753604 was found as a match for chr6:44503246:A:T; using entry from dbSNP
```

```
## GRanges object with 13 ranges and 3 metadata columns:
##                     seqnames    ranges strand |            SNP_id            REF            ALT
##                        <Rle> <IRanges>  <Rle> |       <character> <DNAStringSet> <DNAStringSet>
##          rs10170896     chr2  12581138      * |        rs10170896              G              A
##          rs10170896     chr2  12581138      * |        rs10170896              G              C
##          rs12644995     chr4 122361480      * |        rs12644995              C              A
##          rs13068005     chr3 192388678      * |        rs13068005              G              A
##          rs13068005     chr3 192388678      * |        rs13068005              G              C
##                 ...      ...       ...    ... .               ...            ...            ...
##            rs932680     chr6  44501873      * |          rs932680              G              C
##            rs932680     chr6  44501873      * |          rs932680              G              T
##           rs7601289     chr2  12594018      * |         rs7601289              G              A
##          rs11753604     chr6  44503246      * |        rs11753604              A              T
##   chr6:44503248:G:C     chr6  44503248      * | chr6:44503248:G:C              G              C
##   -------
##   seqinfo: 4 sequences from hg19 genome
```

We see also that two of our custom variants `chr2:12594018:G:A` and `chr6:44503246:A:T` were actually already included in dbSNP155, and were therefor annotated in the output as `rs7601289` and `rs11753604` respectively.

If our BED file includes no rsIDs, then we may omit the `dbSNP` argument from the function. This example uses variants from *Danio rerio*

```
library(BSgenome.Drerio.UCSC.danRer7)
snps.bedfile.nors <- system.file("extdata", "danRer.bed", package = "motifbreakR")
read.table(snps.bedfile.nors, header = FALSE)
```

```
##       V1       V2       V3                 V4 V5 V6
## 1  chr18 13030932 13030933 chr18:13030933:G:A  0  +
## 2  chr18 30445455 30445456 chr18:30445456:T:A  0  +
## 3   chr5 22065023 22065024  chr5:22065024:A:T  0  +
## 4  chr14 36140941 36140942 chr14:36140942:T:A  0  +
## 5   chr3 16701576 16701577  chr3:16701577:T:A  0  +
## 6  chr14 20887995 20887996 chr14:20887996:G:A  0  +
## 7   chr7 25195449 25195450  chr7:25195450:G:T  0  +
## 8   chr2 59181852 59181853  chr2:59181853:A:G  0  +
## 9   chr3 58162674 58162675  chr3:58162675:C:T  0  +
## 10 chr22 18708824 18708825 chr22:18708825:T:A  0  +
```

```
snps.mb.frombed <- snps.from.file(file = snps.bedfile.nors,
                                  search.genome = BSgenome.Drerio.UCSC.danRer7,
                                  format = "bed")
snps.mb.frombed
```

```
## GRanges object with 10 ranges and 3 metadata columns:
##                      seqnames    ranges strand |             SNP_id            REF            ALT
##                         <Rle> <IRanges>  <Rle> |        <character> <DNAStringSet> <DNAStringSet>
##    chr2:59181853:A:G     chr2  59181853      * |  chr2:59181853:A:G              A              G
##    chr3:16701577:T:A     chr3  16701577      * |  chr3:16701577:T:A              T              A
##    chr3:58162675:C:T     chr3  58162675      * |  chr3:58162675:C:T              C              T
##    chr5:22065024:A:T     chr5  22065024      * |  chr5:22065024:A:T              A              T
##    chr7:25195450:G:T     chr7  25195450      * |  chr7:25195450:G:T              G              T
##   chr14:20887996:G:A    chr14  20887996      * | chr14:20887996:G:A              G              A
##   chr14:36140942:T:A    chr14  36140942      * | chr14:36140942:T:A              T              A
##   chr18:13030933:G:A    chr18  13030933      * | chr18:13030933:G:A              G              A
##   chr18:30445456:T:A    chr18  30445456      * | chr18:30445456:T:A              T              A
##   chr22:18708825:T:A    chr22  18708825      * | chr22:18708825:T:A              T              A
##   -------
##   seqinfo: 26 sequences (1 circular) from danRer7 genome
```

`snps.from.file` also can take as input a vcf file with SNVs, by using `format = "vcf"`.

### 3.1.3 Indels

As of version 2.0 *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* is able to parse and analyse indels as well as SNVs. The function `variants.from.file()` allows the import of indels and SNVs simultaneously.

```
snps.indel.vcf <- system.file("extdata", "chek2.vcf.gz", package = "motifbreakR")
snps.indel <- variants.from.file(file = snps.indel.vcf,
                                 search.genome = BSgenome.Hsapiens.UCSC.hg19,
                                 format = "vcf")
snps.indel
```

```
## GRanges object with 1456 ranges and 3 metadata columns:
##               seqnames    ranges strand |      SNP_id            REF            ALT
##                  <Rle> <IRanges>  <Rle> | <character> <DNAStringSet> <DNAStringSet>
##   rs541513166    chr22  29083808      * | rs541513166              T             TA
##   rs540410451    chr22  29083826      * | rs540410451              G              A
##   rs562206743    chr22  29083843      * | rs562206743              A              G
##   rs529320954    chr22  29083856      * | rs529320954              A              G
##   rs544216926    chr22  29083913      * | rs544216926              C              T
##           ...      ...       ...    ... .         ...            ...            ...
##   rs539227672    chr22  29137758      * | rs539227672              G              A
##   rs554107994    chr22  29137761      * | rs554107994              T              G
##   rs566344661    chr22  29137770      * | rs566344661              C              G
##   rs536566373    chr22  29137782      * | rs536566373              A              G
##   rs142541707    chr22  29137790      * | rs142541707              C              A
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
```

We can filter to specifically see the indels like this:

```
snps.indel[nchar(snps.indel$REF) > 1 | nchar(snps.indel$ALT) > 1]
```

```
## GRanges object with 66 ranges and 3 metadata columns:
##               seqnames            ranges strand |      SNP_id            REF            ALT
##                  <Rle>         <IRanges>  <Rle> | <character> <DNAStringSet> <DNAStringSet>
##   rs541513166    chr22          29083808      * | rs541513166              T             TA
##   rs552933761    chr22 29086616-29086617      * | rs552933761             CA              C
##    rs61611714    chr22 29086940-29086941      * |  rs61611714             TG              T
##   rs541631272    chr22 29087474-29087478      * | rs541631272          GAAAT              G
##   rs537685613    chr22          29089333      * | rs537685613              A             AT
##           ...      ...               ...    ... .         ...            ...            ...
##   rs543703620    chr22 29133462-29133463      * | rs543703620             CT              C
##   rs113960351    chr22          29135358      * | rs113960351              C             CT
##    rs17882761    chr22          29136187      * |  rs17882761              C             CA
##   rs547061967    chr22 29136972-29136973      * | rs547061967             CG              C
##   rs199585274    chr22 29137694-29137695      * | rs199585274             CA              C
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
```

## 3.2 *Step 2* | Find Broken Motifs

Now that we have our data in the required format, we may continue to the task at hand, and determine which variants modify potential transcription factor binding. An important element of this task is identifying a set of transcription factor binding motifs that we wish to query. Fortunately *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* includes a large selection of motifs across multiple species that we can see here:

```
library(MotifDb)
MotifDb
```

```
## MotifDb object of length 16361
## | Created from downloaded public sources, last update: 2022-Mar-04
## | 16361 position frequency matrices from 24 sources:
## |    FlyFactorSurvey:  614
## |        HOCOMOCOv10: 1066
## | HOCOMOCOv11-core-A:  181
## | HOCOMOCOv11-core-B:   84
## | HOCOMOCOv11-core-C:  135
## | HOCOMOCOv11-secondary-A:   46
## | HOCOMOCOv11-secondary-B:   19
## | HOCOMOCOv11-secondary-C:   13
## | HOCOMOCOv11-secondary-D:  290
## |        HOCOMOCOv13: 1358
## |              HOMER:  332
## |        JASPAR_2014:  592
## |        JASPAR_CORE:  459
## |             ScerTF:  196
## |       SwissRegulon:  684
## |           UniPROBE:  380
## |         cisbp_1.02:  874
## |               hPDI:  437
## |         jaspar2016: 1209
## |         jaspar2018: 1564
## |         jaspar2022: 1956
## |         jaspar2024: 2346
## |          jolma2013:  843
## |            stamlab:  683
## | 62 organism/s
## |           Hsapiens: 8152
## |          Athaliana: 1962
## |      Dmelanogaster: 1723
## |          Mmusculus: 1706
## |        Scerevisiae: 1390
## |                 NA:  416
## |              other: 1012
## Scerevisiae-ScerTF-ABF2-badis
## Scerevisiae-ScerTF-CAT8-badis
## Scerevisiae-ScerTF-CST6-badis
## Scerevisiae-ScerTF-ECM23-badis
## Scerevisiae-ScerTF-EDS1-badis
## ...
## Mmusculus-UniPROBE-Zfp740.UP00022
## Mmusculus-UniPROBE-Zic1.UP00102
## Mmusculus-UniPROBE-Zic2.UP00057
## Mmusculus-UniPROBE-Zic3.UP00006
## Mmusculus-UniPROBE-Zscan4.UP00026
```

```
### Here we can see which organisms are availible under which sources
### in MotifDb
table(mcols(MotifDb)$organism, mcols(MotifDb)$dataSource)
```

|  | FlyFactorSurvey | HOCOMOCOv10 | HOCOMOCOv11-core-A | HOCOMOCOv11-core-B | HOCOMOCOv11-core-C | HOCOMOCOv11-secondary-A | HOCOMOCOv11-secondary-B | HOCOMOCOv11-secondary-C | HOCOMOCOv11-secondary-D | HOCOMOCOv13 | HOMER | JASPAR\_2014 | JASPAR\_CORE | ScerTF | SwissRegulon | UniPROBE | cisbp\_1.02 | hPDI | jaspar2016 | jaspar2018 | jaspar2022 | jaspar2024 | jolma2013 | stamlab |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Acarolinensis | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Amajus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 3 | 3 | 0 | 0 | 0 | 0 | 0 | 3 | 3 | 3 | 3 | 0 | 0 |
| Anidulans | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 8 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Apisum | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Aterreus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Athaliana | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 48 | 5 | 0 | 0 | 0 | 107 | 0 | 191 | 452 | 568 | 591 | 0 | 0 |
| Bdistachyon | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Celegans | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 15 | 5 | 0 | 0 | 2 | 22 | 0 | 23 | 23 | 34 | 94 | 0 | 0 |
| Cparvum | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Csativa | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Ddiscoideum | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 9 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Dmelanogaster | 614 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 131 | 125 | 0 | 0 | 0 | 138 | 0 | 139 | 140 | 150 | 286 | 0 | 0 |
| Drerio | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 3 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Gaculeatus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Gallus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Ggallus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 4 | 4 | 1 | 1 | 0 | 0 |
| Hcapsulatum | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Hroretzi | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 |
| Hsapiens | 0 | 640 | 181 | 84 | 135 | 46 | 19 | 13 | 290 | 1358 | 0 | 117 | 66 | 0 | 684 | 2 | 313 | 437 | 442 | 522 | 691 | 719 | 710 | 683 |
| Hsapiens;Ocuniculus;Mmusculus;Rrattus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 |
| Hvulgare | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 |
| Mdomestica | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Mgallopavo | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Mmurinus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Mmusculus | 0 | 426 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 66 | 47 | 0 | 0 | 282 | 132 | 0 | 165 | 160 | 143 | 152 | 133 | 0 |
| Mmusculus;Hsapiens | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 3 | 0 | 0 | 0 | 0 |
| Mmusculus;Rnorvegicus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 | 0 | 0 | 0 |
| Mmusculus;Rnorvegicus;Hsapiens | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 6 | 0 | 0 | 0 | 0 |
| Mmusculus;Rnorvegicus;Hsapiens;Ocuniculus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| Mmusculus;Rnorvegicus;Omykiss;Ggallus;Hsapiens | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| Mmusculus;Rnorvegicus;Xlaevis;Stropicalis;Ggallus;Hsapiens;Btaurus;Ocuniculus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 | 0 | 0 | 0 |
| Mmusculus;Rrattus;Hsapiens;Ocuniculus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| Mtruncatula | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| NA | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 40 | 144 | 232 | 0 | 0 |
| Ncrassa | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 15 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Ngruberi | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Nhaematococca | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Nsp. | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 |
| Nsylvestris | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Nvectensis | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Ocuniculus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| Osativa | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 5 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Otauri | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Pcapensis | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Pfalciparum | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 2 | 26 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Phybrida | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 |
| Ppatens | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 7 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Ppygmaeus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Psativum | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 3 | 3 | 0 | 0 | 0 | 1 | 0 | 3 | 3 | 1 | 0 | 0 | 0 |
| Ptetraurelia | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Rnorvegicus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 6 | 8 | 0 | 0 | 0 | 2 | 0 | 12 | 7 | 3 | 4 | 0 | 0 |
| Rnorvegicus;Hsapiens | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| Rrattus | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 2 | 1 | 0 | 0 | 0 | 0 |
| Scerevisiae | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 177 | 177 | 196 | 0 | 91 | 60 | 0 | 175 | 175 | 170 | 169 | 0 | 0 |
| Taestivam | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 32 | 0 | 0 |
| Tthermophila | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Vertebrata | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 4 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| Vvinifera | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Xlaevis | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 3 | 2 | 1 | 1 | 0 | 0 |
| Xtropicalis | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Zmays | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 6 | 6 | 0 | 0 | 0 | 1 | 0 | 6 | 8 | 41 | 57 | 0 | 0 |

We have leveraged the `MotifList` introduced by *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* to include an additional set of motifs that have been gathered to this package:

```
data(motifbreakR_motif)
motifbreakR_motif
```

```
## MotifDb object of length 2817
## | Created from downloaded public sources, last update: 2022-Mar-04
## | 2817 position frequency matrices from 4 sources:
## |       ENCODE-motif: 2065
## |         FactorBook:   79
## |           HOCOMOCO:  426
## |              HOMER:  247
## | 1 organism/s
## |           Hsapiens: 2817
## Hsapiens-ENCODE-motifs-SIX5_disc1
## Hsapiens-ENCODE-motifs-MYC_disc1
## Hsapiens-ENCODE-motifs-SRF_disc1
## Hsapiens-ENCODE-motifs-AP1_disc1
## Hsapiens-ENCODE-motifs-SIX5_disc2
## ...
## Hsapiens-HOMER-yy1.motif
## Hsapiens-HOMER-zbtb33.motif
## Hsapiens-HOMER-zfx.motif
## Hsapiens-HOMER-znf263.motif
## Hsapiens-HOMER-znf711.motif
```

The different studies included in this data set may be called individually; for example:

```
data(hocomoco)
hocomoco
```

```
## MotifDb object of length 426
## | Created from downloaded public sources, last update: 2022-Mar-04
## | 426 position frequency matrices from 1 source:
## |           HOCOMOCO:  426
## | 1 organism/s
## |           Hsapiens:  426
## Hsapiens-HOCOMOCO-AHR_si
## Hsapiens-HOCOMOCO-AIRE_f2
## Hsapiens-HOCOMOCO-ALX1_si
## Hsapiens-HOCOMOCO-ANDR_do
## Hsapiens-HOCOMOCO-AP2A_f2
## ...
## Hsapiens-HOCOMOCO-ZN333_f1
## Hsapiens-HOCOMOCO-ZN350_f1
## Hsapiens-HOCOMOCO-ZN384_f1
## Hsapiens-HOCOMOCO-ZN423_f1
## Hsapiens-HOCOMOCO-ZN589_f1
```

See `?motifbreakR_motif` for more information and citations.

Some of our data sets include a sequenceCount. These include `FlyFactorSurvey`, `hPDI`, `JASPAR_2014`, `JASPAR_CORE`, and `jolma2013` from *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* and `HOCOMOCO` from the set of `motifbreakR_motif`. Using these we calculate a pseudocount to allow us to calculate the logarithms in the case where we have a `0` in a pwm. The calculation for incorporating pseudocounts is `ppm <- (ppm * sequenceCount + 0.25)/(sequenceCount + 1)`. If the sequenceCount for a particular ppm is `NA` we use 20 as a default sequenceCount.

Now that we have the three necessary components to run *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)*:

1. A `BSgenome` object for our organism, in this case `BSgenome.Hsapiens.UCSC.hg19`
2. A `MotifList` object containing our motifs, in this case `hocomoco`,
3. And our input `GRanges` object generated by `snps.from.rsid`, in this case `snps.mb`

We get to the task of actually running the function `motifbreakR()`.

We have several options that we may pass to the function, the main ones that will dictate how long the function will run with a given set of variants and motifs are the `threshold` we pass and the `method` we use to [score](#methods).

Here we specify the `snpList`, `pwmList`, `threshold` that we declare as the cutoff for reporting results, `filterp` set to true declares that we are filtering by p-value, the `method`, and `bkg` the relative nucleotide frequency of A, C, G, and T.

For the purposes of this small example, we use the `SerialParam` back end. However, for larger variant lists, `MulticoreParam` or one of the other *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* back-ends could speed up completion.

```
results <- motifbreakR(snpList = snps.mb[1:12], filterp = TRUE,
                       pwmList = subset(MotifDb,
                                        dataSource %in% c("HOCOMOCOv11-core-A", "HOCOMOCOv11-core-B", "HOCOMOCOv11-core-C")),
                       threshold = 1e-4,
                       method = "ic",
                       bkg = c(A=0.25, C=0.25, G=0.25, T=0.25),
                       BPPARAM = BiocParallel::SerialParam())
```

The results reveal which variants disrupt which motifs, and to which degree. If we want to examine a single variant, we can select one like this:

```
rs1006140 <- results[results$SNP_id == "rs1006140"]
rs1006140
```

```
## GRanges object with 27 ranges and 20 metadata columns:
##               seqnames    ranges strand |      SNP_id            REF            ALT     varType
##                  <Rle> <IRanges>  <Rle> | <character> <DNAStringSet> <DNAStringSet> <character>
##   rs1006140:C    chr19  38778915      - |   rs1006140              A              C         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##           ...      ...       ...    ... .         ...            ...            ...         ...
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:C    chr19  38778915      - |   rs1006140              A              C         SNV
##   rs1006140:C    chr19  38778915      - |   rs1006140              A              C         SNV
##   rs1006140:T    chr19  38778915      - |   rs1006140              A              T         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##               motifPos  geneSymbol         dataSource          providerName            providerId
##                 <list> <character>        <character>           <character>           <character>
##   rs1006140:C  -13,  8       ZN467 HOCOMOCOv11-core-C ZN467_HUMAN.H11MO.0.C ZN467_HUMAN.H11MO.0.C
##   rs1006140:G    -8, 4        E2F7 HOCOMOCOv11-core-B  E2F7_HUMAN.H11MO.0.B  E2F7_HUMAN.H11MO.0.B
##   rs1006140:G  -15,  6         SP1 HOCOMOCOv11-core-A   SP1_HUMAN.H11MO.0.A   SP1_HUMAN.H11MO.0.A
##   rs1006140:G    -5, 5       KLF12 HOCOMOCOv11-core-C KLF12_HUMAN.H11MO.0.C KLF12_HUMAN.H11MO.0.C
##   rs1006140:G    -6, 8        KLF9 HOCOMOCOv11-core-C  KLF9_HUMAN.H11MO.0.C  KLF9_HUMAN.H11MO.0.C
##           ...      ...         ...                ...                   ...                   ...
##   rs1006140:G  -14,  7       ZN143 HOCOMOCOv11-core-A ZN143_HUMAN.H11MO.0.A ZN143_HUMAN.H11MO.0.A
##   rs1006140:C  -14,  7       ZN143 HOCOMOCOv11-core-A ZN143_HUMAN.H11MO.0.A ZN143_HUMAN.H11MO.0.A
##   rs1006140:C  -11,  3        KLF9 HOCOMOCOv11-core-C  KLF9_HUMAN.H11MO.0.C  KLF9_HUMAN.H11MO.0.C
##   rs1006140:T    -5, 4        KLF4 HOCOMOCOv11-core-A  KLF4_HUMAN.H11MO.0.A  KLF4_HUMAN.H11MO.0.A
##   rs1006140:G  -11, 10         SP2 HOCOMOCOv11-core-A   SP2_HUMAN.H11MO.0.A   SP2_HUMAN.H11MO.0.A
##                             seqMatch    pctRef    pctAlt  scoreRef  scoreAlt Refpvalue Altpvalue
##                          <character> <numeric> <numeric> <numeric> <numeric> <logical> <logical>
##   rs1006140:C ctctgctgaccccactcccc..  0.775627  0.806966  10.66759  11.08109      <NA>      <NA>
##   rs1006140:G         accccactcccc..  0.803434  0.923907   6.68298   7.65925      <NA>      <NA>
##   rs1006140:G ctctgctgaccccactcccc..  0.758168  0.845123  14.10174  15.67334      <NA>      <NA>
##   rs1006140:G           cccactcccc..  0.840058  0.928011  10.99304  12.13449      <NA>      <NA>
##   rs1006140:G       tgaccccactcccc..  0.806264  0.847777  11.52649  12.10930      <NA>      <NA>
##           ...                    ...       ...       ...       ...       ...       ...       ...
##   rs1006140:G ctctgctgaccccactcccc..  0.747658  0.695443  12.66301   11.8163      <NA>      <NA>
##   rs1006140:C ctctgctgaccccactcccc..  0.747658  0.685454  12.66301   11.6544      <NA>      <NA>
##   rs1006140:C       tgaccccactcccc..  0.806264  0.862410  11.52649   12.3147      <NA>      <NA>
##   rs1006140:T            ccactcccc..  0.957953  0.921141  10.72543   10.3171      <NA>      <NA>
##   rs1006140:G ctctgctgaccccactcccc..  0.812640  0.918401   9.06648   10.1848      <NA>      <NA>
##                  altPos alleleDiff alleleEffectSize      effect
##               <integer>  <numeric>        <numeric> <character>
##   rs1006140:C         1   0.413503        0.0303419        weak
##   rs1006140:G         1   0.976264        0.1179651      strong
##   rs1006140:G         1   1.571597        0.0850776      strong
##   rs1006140:G         1   1.141453        0.0873421      strong
##   rs1006140:G         1   0.582811        0.0409094        weak
##           ...       ...        ...              ...         ...
##   rs1006140:G         1  -0.846669       -0.0505330      strong
##   rs1006140:C         1  -1.008640       -0.0602002      strong
##   rs1006140:C         1   0.788242        0.0553293      strong
##   rs1006140:T         1  -0.408366       -0.0364878        weak
##   rs1006140:G         1   1.118277        0.1012240      strong
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
```

Here we can see that SNP rs1006140 disrupts multiple motifs. We can then check what the pvalue for each allele is with regard to each motif, using `calculatePvalue`.

```
rs1006140 <- calculatePvalue(rs1006140, granularity = 1e-6)
rs1006140
```

```
## GRanges object with 16 ranges and 23 metadata columns:
##               seqnames    ranges strand |      SNP_id            REF            ALT     varType
##                  <Rle> <IRanges>  <Rle> | <character> <DNAStringSet> <DNAStringSet> <character>
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:T    chr19  38778915      - |   rs1006140              A              T         SNV
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:T    chr19  38778915      - |   rs1006140              A              T         SNV
##           ...      ...       ...    ... .         ...            ...            ...         ...
##   rs1006140:G    chr19  38778915      - |   rs1006140              A              G         SNV
##   rs1006140:T    chr19  38778915      - |   rs1006140              A              T         SNV
##   rs1006140:C    chr19  38778915      - |   rs1006140              A              C         SNV
##   rs1006140:C    chr19  38778915      - |   rs1006140              A              C         SNV
##   rs1006140:T    chr19  38778915      - |   rs1006140              A              T         SNV
##               motifPos  geneSymbol  dataSource providerName  providerId               seqMatch
##                 <list> <character> <character>  <character> <character>            <character>
##   rs1006140:G    -5, 5        KLF1    HOCOMOCO      KLF1_f1  KLF1_HUMAN              cccactc..
##   rs1006140:G    -2, 8        EGR1    HOCOMOCO      EGR1_f2  EGR1_HUMAN              cccactc..
##   rs1006140:T    -5, 5        KLF1    HOCOMOCO      KLF1_f1  KLF1_HUMAN              cccactc..
##   rs1006140:G  -10, 11       RREB1    HOCOMOCO     RREB1_si RREB1_HUMAN   gctctgctgaccccactc..
##   rs1006140:T    -3,13       ZBTB4    HOCOMOCO     ZBTB4_si ZBTB4_HUMAN        gctgaccccactc..
##           ...      ...         ...         ...          ...         ...                    ...
##   rs1006140:G    -3, 9       EPAS1    HOCOMOCO     EPAS1_si EPAS1_HUMAN            accccactc..
##   rs1006140:T    -3, 9       EPAS1    HOCOMOCO     EPAS1_si EPAS1_HUMAN            accccactc..
##   rs1006140:C    -6, 8      ZNF148    HOCOMOCO     ZN148_si ZN148_HUMAN          tgaccccactc..
##   rs1006140:C    -3, 9       EPAS1    HOCOMOCO     EPAS1_si EPAS1_HUMAN            accccactc..
##   rs1006140:T    -2, 5       IKZF1    HOCOMOCO     IKZF1_f1 IKZF1_HUMAN                 actc..
##                  pctRef    pctAlt  scoreRef  scoreAlt   Refpvalue   Altpvalue    snpPos alleleRef
##               <numeric> <numeric> <numeric> <numeric>   <numeric>   <numeric> <integer> <numeric>
##   rs1006140:G  0.960844  0.871972   8.99202   8.18880 3.24249e-05 2.63691e-04      <NA>        NA
##   rs1006140:G  0.871144  0.918955   9.92843  10.46639 1.41621e-04 3.98159e-05      <NA>        NA
##   rs1006140:T  0.960844  0.860781   8.99202   8.08766 3.24249e-05 3.42369e-04      <NA>        NA
##   rs1006140:G  0.821312  0.749228  10.06841   9.21044 1.83542e-05 2.63112e-04      <NA>        NA
##   rs1006140:T  0.797832  0.744510  12.74424  11.91989 1.21765e-05 8.17876e-05      <NA>        NA
##           ...       ...       ...       ...       ...         ...         ...       ...       ...
##   rs1006140:G  0.915901  0.792753   7.09686   6.17249 1.02818e-05 7.11918e-04      <NA>        NA
##   rs1006140:T  0.915901  0.811224   7.09686   6.31114 1.02818e-05 4.33713e-04      <NA>        NA
##   rs1006140:C  0.880142  0.935234   9.89863  10.50089 4.94868e-05 6.27805e-06      <NA>        NA
##   rs1006140:C  0.915901  0.836589   7.09686   6.50153 1.02818e-05 2.00659e-04      <NA>        NA
##   rs1006140:T  0.852780  0.991006   6.25307   7.25513 1.83105e-03 7.62939e-05      <NA>        NA
##               alleleAlt      effect    altPos alleleDiff alleleEffectSize
##               <numeric> <character> <integer>  <numeric>        <numeric>
##   rs1006140:G        NA      strong         1  -0.803230       -0.0859444
##   rs1006140:G        NA        weak         1   0.537962        0.0472796
##   rs1006140:T        NA      strong         1  -0.904368       -0.0967661
##   rs1006140:G        NA      strong         1  -0.857970       -0.0703529
##   rs1006140:T        NA      strong         1  -0.824348       -0.0519448
##           ...       ...         ...       ...        ...              ...
##   rs1006140:G        NA      strong         1  -0.924373       -0.1196115
##   rs1006140:T        NA      strong         1  -0.785724       -0.1016707
##   rs1006140:C        NA        weak         1   0.602262        0.0537307
##   rs1006140:C        NA        weak         1  -0.595327       -0.0770338
##   rs1006140:T        NA      strong         1   1.002061        0.1368875
##   -------
##   seqinfo: 16 sequences from hg19 genome
```

And here we see that for each SNP we have at least one allele achieving a p-value below 1e-4 threshold that we required. The `seqMatch` column shows what the reference genome sequence is at that location, with the variant position appearing in an uppercase letter. pctRef and pctAlt display the the score for the motif in the sequence as a percentage of the best score that motif could achieve on an ideal sequence. In other words \((scoreVariant-minscorePWM)/(maxscorePWM-minscorePWM)\). We can also see the absolute scores for our method in scoreRef and scoreAlt and thier respective p-values.

### 3.2.1 Parallel Evaluation (an aside)

Important to note, is that `motifbreakR` uses the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* parallel back-end, and one may modify what type of parallel evaluation it uses (or if it runs in parallel at all). Here we can see the versions available on the machine this vignette was compiled on.

```
BiocParallel::registered()
```

```
## $MulticoreParam
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
##
## $SnowParam
## class: SnowParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: TRUE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: SOCK
##
## $SerialParam
## class: SerialParam
##   bpisup: FALSE; bpnworkers: 1; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: FALSE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: FALSE
##   bplogdir: NA
##   bpresultdir: NA
```

```
BiocParallel::bpparam()
```

```
## class: MulticoreParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: ; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: FALSE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: FORK
```

By default `motifbreakR` uses `bpparam()` as an argument to `BPPARAM` and will use all available cores on the machine on which it is running. However on Windows machines this reverts to using a serial evaluation model, so if you wish to run in parallel on a Windows machine consider using a different parameter shown in `BiocParallel::registered()` such as `SnowParam` passing `BPPARAM = SnowParam()`.

## 3.3 *Step 3* | Visualize

Now that we have our results, we can visualize them with the function `plotMB`. Lets take a look at rs1006140.

```
plotMB(results = results, rsid = "rs1006140", effect = "strong", altAllele = "G")
```

```
## Loading required namespace: Cairo
```

```
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been generated by Cairo
## graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been generated by Cairo
## graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been generated by Cairo
## graphics; errors may result
## Warning in checkValidSVG(doc, warn = warn): This picture may not have been generated by Cairo
## graphics; errors may result
```

![](data:image/png;base64...)

```
plotMB(results = results, rsid = "rs1006140", effect = "strong", altAllele = "C")
```

![](data:image/png;base64...)

### 3.3.1 Shiny version

In addition to the existing interface, we have implemented an R/Shiny graphical user interface to simplify and enhance access to researchers with different skill sets. This is focused on human variants.

In order to launch the shiny version, one executes the following two lines:

```
app <- shiny_motifbreakR()
shiny::runApp(app)
```

## 3.4 *Added functionality* | Query Remap 2022 Peaks

While computational prediction of differential transcription factor binding potential based on sequence preference is the core of *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)*, grounding the analysis in observed transcription factor binding can improve the prioritization of results. ReMap[^remap2022] provides manually curated, high quality catalogs of regulatory regions based on DNA binding experiments in Human, Mouse, Fly and *Arabidopsis thaliana*

We can annotate results with the ReMap sourced TF peaks corresponding to to motif/transcription factor relationships provided by the constituent public *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* sources. The user may optionally query an expanded motif/transcription factor relationship encompassing the entire potential transcription factor family as implemented by *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* based on TFClass[^TFclass].

```
results <- findSupportingRemapPeaks(results,
                                    genome = "hg19",
                                    TFClass = TRUE)
results
```

[^remap2022] Website: [Remap](https://remap.univ-amu.fr/) Paper: [ReMap 2022: a database of Human, Mouse, Drosophila and Arabidopsis regulatory regions from an integrative analysis of DNA-binding sequencing experiments](https://doi.org/10.1093/nar/gkab996)

[^TFclass] Website: [Classification of Transcription Factors in Mammalia](https://tfclass.bioinf.med.uni-goettingen.de/) Paper: [TFClass: expanding the classification of human transcription factors to their mammalian orthologs](https://doi.org/10.1093/nar/gkx987)

## 3.5 *Export Results*

There are two exports that *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* can generate in addition to the figures. We can export a table of results resembling the results object, either as CSV or TSV files.

```
exportMBtable(results, file = "mb_test_output.tsv", format = "tsv")
```

Alternatively, we can export a BED file of results. The BED file represents the variants that interact with motifs. They are named by the variant name, reference and alternate alleles, and the name of the motif disrupted. The intervals may be colored with diverging color scale for effect\_size (blue representing stronger binding in `REF`}`, red representing stronger binding in`ALT`), or a sequential color scale otherwise (low values as purple, high values as yellow). The score column is either the`effect\_size`(`alleleDiff`column), the -log10(p-value) (capped at 10), corresponding to`Refpvalue`,`Altpvalue`, or the best match of the two, or the`scorepctRef`,`pctAlt`, or the highest match of the two.

```
exportMBbed(results, file = "mb_test_output.bed", color = "effect_size")
```

# 4 Methods

*[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* works with position probability matrices (PPM). PPM are derived as the fractional occurrence of nucleotides A,C,G, and T at each position of a position frequency matrix (PFM). PFM are simply the tally of each nucleotide at each position across a set of aligned sequences. With a PPM, one can generate probabilities based on the genome, or more practically, create any number of position specific scoring matrices (PSSM) based on the principle that the PPM contains information about the likelihood of observing a particular nucleotide at a particular position of a true transcription factor binding site. What follows is a discussion of the three different algorithms that may be employed in calls to the *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* function via the `method` argument.

Suppose we have a frequency matrix \(M\) of width \(n\) (*i.e.* a PPM as described above). Furthermore, we have a sequence \(s\) also of length \(n\), such that \(s\_{i} \in \{ A,T,C,G \}, i = 1,\ldots n\). Each column of \(M\) contains the frequencies of each letter in each position.

Commonly in the literature sequences are scored as the sum of log probabilities:

## 4.1 Sum of Log Probabilities

\[F( s,M ) = \sum\_{i = 1}^{n}{\log( \frac{M\_{s\_{i},i}}{b\_{s\_{i}}} )}\]

where \(b\_{s\_{i}}\) is the background frequency of letter \(s\_{i}\) in the genome of interest. This method can be specified by the user as `method='log'`.

As an alternative to this method, we introduced a scoring method to directly weight the score by the importance of the position within the match sequence. This method of weighting is accessed by specifying `method='default'` (weighted sum). A general representation of this scoring method is given by:

## 4.2 Weighted Sum

\[F( s,M ) = p( s ) \cdot \omega\_{M}\]

where \(p\_{s}\) is the scoring vector derived from sequence \(s\) and matrix \(M\), and \(w\_{M}\) is a weight vector derived from \(M\). First, we compute the scoring vector of position scores \(p\):

## 4.3 Calculating Scoring Vector \(p\)

\[p( s ) = ( M\_{s\_{i},i} ) \textrm{ where } \frac{i = 1,\ldots n}{s\_{i} \in \{ A,C,G,T \}}\]

and second, for each \(M\) a constant vector of weights \(\omega\_{M} = ( \omega\_{1},\omega\_{2},\ldots,\omega\_{n} )\).

There are two methods for producing \(\omega\_{M}\). The first, which we call weighted sum, is the difference in the probabilities for the two letters of the polymorphism (or variant), *i.e.* \(\Delta p\_{s\_{i}}\), or the difference of the maximum and minimum values for each column of \(M\):

## 4.4 Calculating \(\omega\) For Weighted Sum

\[\omega\_{i} = \max \{ M\_{i} \} - \min \{ M\_{i} \}\textrm{ where }i = 1,\ldots n\]

The second variation of this theme is to weight by relative entropy. Thus the relative entropy weight for each column \(i\) of the matrix is given by:

## 4.5 Calculating \(\omega\) For Relative Entropy

\[\omega\_{i} = \sum\_{j \in \{ A,C,G,T \}}^{}{M\_{j,i}\log\_2( \frac{M\_{j,i}}{b\_{i}} )}\textrm{ where }i = 1,\ldots n\]

where \(b\_{i}\) is again the background frequency of the letter \(i\).

Thus, there are 3 possible algorithms to apply via the `method` argument. The first is the standard summation of log probabilities (`method='log'`). The second and third are the weighted sum and information content methods (`method='default'` and `method='ic'`) specified by equations for [Weighted Sum](#eqn4.1) and [Relative Entropy](#eqn4.2), respectively. *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* assumes a uniform background nucleotide distribution (\(b\)) in equations [4.1](#eqn1) and [4.5](#eqn4.1) unless otherwise specified by the user. Since we are primarily interested in the difference between alleles, background frequency is not a major factor, although it can change the results. Additionally, inclusion of background frequency introduces potential bias when collections of motifs are employed, since motifs are themselves unbalanced with respect to nucleotide composition. With these cautions in mind, users may override the uniform distribution if so desired. For all three methods, *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* scores and reports the reference and alternate alleles of the sequence (\(F( s\_{\textrm{REF}},M )\) and \(F( s\_{\textrm{ALT}},M )\)), and provides the matrix scores \(p\_{s\_{\textrm{REF}}}\) and \(p\_{s\_{\textrm{ALT}}}\) of the SNP (or variant). The scores are scaled as a fraction of scoring range 0-1 of the motif matrix, \(M\). If either of \(F( s\_{\textrm{REF}},M )\) and \(F( s\_{\textrm{ALT}},M )\) is greater than a user-specified threshold (default value of 0.85) the SNP is reported. By default *[motifbreakR](https://bioconductor.org/packages/3.22/motifbreakR)* does not display neutral effects, (\(\Delta p\_{i} < 0.4\)) but this behavior can be overridden.

## 4.6 Calculate P-values for PWM match

Additionally, now, with the use of *[TFMPvalue](https://CRAN.R-project.org/package%3DTFMPvalue)*, we may filter by p-value of the match. This is unfortunately a two step process. First, by invoking `filterp=TRUE` and setting a threshold at a desired p-value e.g 1e-4, we perform a rough filter on the results by rounding all values in the PWM to two decimal place, and calculating a scoring threshold based upon that. The second step is to use the function `calculatePvalue()` on a selection of results which will change the `Refpvalue` and `Altpvalue` columns in the output from `NA` to the p-value calculated by `TFMsc2pv`. This can be (although not always) a very memory and time intensive process if the algorithm doesn’t converge rapidly.

P-values can also be calculated in parallel, it is highly recommended to round the PWM matrix with the granularity argument. This trades the accuracy of the p-value calculation for speed of convergence. For most purposes a range of 1e-4 to 1e-6 is an acceptable trade off between accuracy and speed.

The granularity in TFMPvalue paper is defined:

“Let \(M\) be a matrix of real coefficient values of length \(m\) and let \(\epsilon\) be a positive real number. We denote \(M\_\epsilon\) the round matrix deduced from \(M\) by rounding each value by \(\epsilon\):”

\[M\_\epsilon(i,x) = \epsilon \lfloor \frac{M(i,x)}{\epsilon} \rfloor\]

# 5 Session Info

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    grid      stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] BSgenome.Drerio.UCSC.danRer7_1.4.0       BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] SNPlocs.Hsapiens.dbSNP155.GRCh37_0.99.24 BSgenome_1.78.0
##  [5] rtracklayer_1.70.0                       BiocIO_1.20.0
##  [7] motifbreakR_2.24.0                       MotifDb_1.52.0
##  [9] Biostrings_2.78.0                        XVector_0.50.0
## [11] GenomicRanges_1.62.0                     Seqinfo_1.0.0
## [13] IRanges_2.44.0                           S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0                      generics_0.1.4
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1           jsonlite_2.0.0
##   [4] magrittr_2.0.4              GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.6.5                 Cairo_1.7-0
##  [10] memoise_2.0.1               Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] base64enc_0.1-3             htmltools_0.5.8.1           S4Arrays_1.10.0
##  [16] progress_1.2.3              curl_7.0.0                  SparseArray_1.10.0
##  [19] Formula_1.2-5               sass_0.4.10                 bslib_0.9.0
##  [22] htmlwidgets_1.6.4           Gviz_1.54.0                 httr2_1.2.1
##  [25] cachem_1.1.0                GenomicAlignments_1.46.0    mime_0.13
##  [28] lifecycle_1.0.4             pkgconfig_2.0.3             Matrix_1.7-4
##  [31] R6_2.6.1                    fastmap_1.2.0               MatrixGenerics_1.22.0
##  [34] shiny_1.11.1                digest_0.6.37               TFMPvalue_0.0.9
##  [37] colorspace_2.1-2            AnnotationDbi_1.72.0        Hmisc_5.2-4
##  [40] RSQLite_2.4.3               seqLogo_1.76.0              filelock_1.0.3
##  [43] httr_1.4.7                  abind_1.4-8                 compiler_4.5.1
##  [46] bit64_4.6.0-1               htmlTable_2.4.3             S7_0.2.0
##  [49] backports_1.5.0             bsicons_0.1.2               BiocParallel_1.44.0
##  [52] DBI_1.2.3                   biomaRt_2.66.0              MASS_7.3-65
##  [55] rappdirs_0.3.3              DelayedArray_0.36.0         rjson_0.2.23
##  [58] gtools_3.9.5                caTools_1.18.3              tools_4.5.1
##  [61] splitstackshape_1.4.8       foreign_0.8-90              otel_0.2.0
##  [64] httpuv_1.6.16               nnet_7.3-20                 glue_1.8.0
##  [67] restfulr_0.0.16             promises_1.4.0              checkmate_2.3.3
##  [70] ade4_1.7-23                 cluster_2.1.8.1             TFBSTools_1.48.0
##  [73] gtable_0.3.6                tzdb_0.5.0                  ensembldb_2.34.0
##  [76] data.table_1.17.8           hms_1.1.4                   pillar_1.11.1
##  [79] stringr_1.5.2               vroom_1.6.6                 later_1.4.4
##  [82] dplyr_1.1.4                 BiocFileCache_3.0.0         lattice_0.22-7
##  [85] deldir_2.0-4                bit_4.6.0                   biovizBase_1.58.0
##  [88] DirichletMultinomial_1.52.0 tidyselect_1.2.1            knitr_1.50
##  [91] gridExtra_2.3               grImport2_0.3-3             ProtGenerics_1.42.0
##  [94] SummarizedExperiment_1.40.0 xfun_0.53                   Biobase_2.70.0
##  [97] matrixStats_1.5.0           DT_0.34.0                   stringi_1.8.7
## [100] UCSC.utils_1.6.0            lazyeval_0.2.2              yaml_2.3.10
## [103] evaluate_1.0.5              codetools_0.2-20            cigarillo_1.0.0
## [106] interp_1.1-6                tibble_3.3.0                BiocManager_1.30.26
## [109] cli_3.6.5                   rpart_4.1.24                xtable_1.8-4
## [112] jquerylib_0.1.4             dichromat_2.0-0.1           Rcpp_1.1.0
## [115] GenomeInfoDb_1.46.0         dbplyr_2.5.1                png_0.1-8
## [118] XML_3.99-0.19               parallel_4.5.1              ggplot2_4.0.0
## [121] blob_1.2.4                  prettyunits_1.2.0           jpeg_0.1-11
## [124] latticeExtra_0.6-31         AnnotationFilter_1.34.0     bitops_1.0-9
## [127] pwalign_1.6.0               VariantAnnotation_1.56.0    motifStack_1.54.0
## [130] scales_1.4.0                crayon_1.5.3                rlang_1.1.6
## [133] KEGGREST_1.50.0
```

---

1. Website: [encode-motifs](http://compbio.mit.edu/encode-motifs/) Paper: [Systematic discovery and characterization of regulatory motifs in ENCODE TF binding experiments](http://dx.doi.org/10.1093/nar/gkt1249)[↩︎](#fnref1)
2. Website: [Factorbook](http://factorbook.org/mediawiki/index.php/Welcome_to_factorbook) Paper: [Sequence features and chromatin structure around the genomic regions bound by 119 human transcription factors](http://dx.doi.org/10.1101/gr.139105.112)[↩︎](#fnref2)
3. Website: [HOCOMOCO](http://autosome.ru/HOCOMOCO/) Paper: [HOCOMOCO: a comprehensive collection of human transcription factor binding sites models](http://dx.doi.org/10.1093/nar/gks1089)[↩︎](#fnref3)
4. Website: [Homer](http://homer.salk.edu/homer/index.html) Paper: [http://www.sciencedirect.com/science/article/pii/S1097276510003667](http://dx.doi.org/10.1016/j.molcel.2010.05.004)[↩︎](#fnref4)