# enhancerHomologSearch Guide

#### Jianhong Ou

## Introduction

There is an increasing requirement for the tools to identify of putative mammalian orthologs to enhancers in species other than human and mouse, such as zebrafish, which is lacking whole genome comparison analysis data. Take zebrafish as an example, there are two major methods to identify the orthologs to enhancers in human and mouse,

1. use the whole genome comparison analysis data and conservation data1,
2. use spotted gar genome as bridge genome to search the orthologs2.

Both methods will work well in the coding region. However, there is lacking comparative data in distal regulation region such as enhancers and silencers.

In 2020, Emily S. Wong et. al. provides a new method for identification of putative human orthologs to enhancers of zebrafish3. They used the method to interrogate conserved syntenic regions and human and mouse using candidate sponge enhancer sequences. First, they looked for overlap with available functional genomics information. For example, they used mouse ENCODE data to infer enhancer activity based on histone marks in specific tissues. Second, they select the best-aligned region by whole genome alignment from the candidates regions for human and mouse as orthologs. This method provides the possibility to search orthologs for enhancers or silencers even there is not genome comparative data available.

This package is modified from Wong’s methods and provide the easy-to-use script for researchers to quick search putative mammalian orthologs to enhancers. The modified algorithm is: The candidate regions were determined by ENCODE histone marks (default is H3K4me1) in specific tissue for human and mouse. The mapping score were calculated by pairwise Transcription Factors Binding Pattern Similarity (TFBPS) between enhancer sequences and candidates by fast motif match4. The Z-score were calculated from mapping score and then converted to P-value based on two-side test from a normal distribution. The candidates were filtered by p-value and distance from the TSS of target homologs. And then the top candidates from human and mouse were aligned to each other and exported as multiple alignments with given enhancer.

## Installation

First install `enhancerHomologSearch` and other packages required to run the examples. Please note the example dataset used here is from zebrafish. To run analysis with dataset from a different species or different assembly, please install the corresponding Bsgenome and TxDb. For example, to analyze cattle data aligned to bosTau9, please install BSgenome.Btaurus.UCSC.bosTau9, and TxDb.Btaurus.UCSC.bosTau9.refGene. You can also generate a TxDb object by functions makeTxDbFromGFF from a local gff file, or makeTxDbFromUCSC, makeTxDbFromBiomart, and makeTxDbFromEnsembl, from online resources in GenomicFeatures package.

```
if (!"BiocManager" %in% rownames(installed.packages()))
     install.packages("BiocManager")
library(BiocManager)
BiocManager::install(c("enhancerHomologSearch",
                       "BiocParallel",
                       "BSgenome.Drerio.UCSC.danRer10",
                       "BSgenome.Hsapiens.UCSC.hg38",
                       "BSgenome.Mmusculus.UCSC.mm10",
                       "TxDb.Hsapiens.UCSC.hg38.knownGene",
                       "TxDb.Mmusculus.UCSC.mm10.knownGene",
                       "org.Hs.eg.db",
                       "org.Mm.eg.db",
                       "MotifDb",
                       "motifmatchr"))
```

If you have trouble in install enhancerHomologSearch, please check your R version first. The `enhancerHomologSearch` package require R >= 4.1.0.

```
R.version
```

```
##                _
## platform       x86_64-pc-linux-gnu
## arch           x86_64
## os             linux-gnu
## system         x86_64, linux-gnu
## status         Patched
## major          4
## minor          5.1
## year           2025
## month          08
## day            23
## svn rev        88802
## language       R
## version.string R version 4.5.1 Patched (2025-08-23 r88802)
## nickname       Great Square Root
```

## Step 1, prepare target enhancer sequences.

In this example, we will use an enhancer of `lepb` gene in zebrafish.

```
# load genome sequences
library(BSgenome.Drerio.UCSC.danRer10)
# define the enhancer genomic coordinates
LEN <- GRanges("chr4", IRanges(19050041, 19051709))
# extract the sequences as Biostrings::DNAStringSet object
(seqEN <- getSeq(BSgenome.Drerio.UCSC.danRer10, LEN))
```

```
## DNAStringSet object of length 1:
##     width seq
## [1]  1669 TGGCATACACAGCAAACATCATGAATTTAATTTA...TAGATAAATAGAAACAGAAGCAAATTGGCGAGT
```

## Step 2, download candidate regions of enhancers from ENCODE by H3K4me1 marks

By default, the hisone marker is H3K4me1. Users can also define the markers by `markers` parameter in the function `getENCODEdata`. To make sure the markers are tissue specific, we can filter the data by `biosample_name` and `biosample_type` parameters. For additional filters, please refer `?getENCODEdata`.

```
# load library
library(enhancerHomologSearch)
library(BSgenome.Hsapiens.UCSC.hg38)
library(BSgenome.Mmusculus.UCSC.mm10)
# download enhancer candidates for human heart tissue
hs <- getENCODEdata(genome=Hsapiens,
                    partialMatch=c(biosample_summary = "heart"))
# download enhancer candidates for mouse heart tissue
mm <- getENCODEdata(genome=Mmusculus,
                    partialMatch=c(biosample_summary = "heart"))
```

## Step 3, get alignment score for target enhancer and candidate enhancers.

Previous methods were get alignment score from the alignment of enhancer and candidate enhancers via the function `alignmentOne`. However, most of the enhancer evolution are rapid. This package is modified from Wong’s methods and calculate the alignment score by pairwise Transcription Factors Binding Pattern Similarity (TFBPS) between enhancer sequences and candidates. This step is time consuming step. For quick run, users can subset the data by given genomic coordinates.

```
# subset the data for test run
# in human, the homolog LEP gene is located at chromosome 7
# In this test run, we will only use upstream 1M and downstream 1M of homolog
# gene
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)
eid <- mget("LEP", org.Hs.egALIAS2EG)[[1]]
g_hs <- select(TxDb.Hsapiens.UCSC.hg38.knownGene,
               keys=eid,
               columns=c("GENEID", "TXCHROM", "TXSTART", "TXEND", "TXSTRAND"),
               keytype="GENEID")
g_hs <- range(with(g_hs, GRanges(TXCHROM, IRanges(TXSTART, TXEND))))
expandGR <- function(x, ext){
  stopifnot(length(x)==1)
  start(x) <- max(1, start(x)-ext)
  end(x) <- end(x)+ext
  GenomicRanges::trim(x)
}
hs <- subsetByOverlaps(hs, expandGR(g_hs, ext=1000000))
# in mouse, the homolog Lep gene is located at chromosome 6
# Here we use the subset of 1M upstream and downstream of homolog gene.
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(org.Mm.eg.db)
eid <- mget("Lep", org.Mm.egALIAS2EG)[[1]]
g_mm <- select(TxDb.Mmusculus.UCSC.mm10.knownGene,
               keys=eid,
               columns=c("GENEID", "TXCHROM", "TXSTART", "TXEND", "TXSTRAND"),
               keytype="GENEID")
g_mm <- range(with(g_mm,
                   GRanges(TXCHROM,
                           IRanges(TXSTART, TXEND),
                           strand=TXSTRAND)))
g_mm <- g_mm[seqnames(g_mm) %in% "chr6" & strand(g_mm) %in% "+"]
mm <- subsetByOverlaps(mm, expandGR(g_mm, ext=1000000))

# search the binding pattern
data(motifs)
## In the package, there are 10 sets of motif cluster sets.
## In this example, we use motif clusters merged by distance 60, which
## is calculated by matalgin (motifStack implementation)
PWMs <- motifs[["dist60"]]
## Here we set maximalShuffleEnhancers = 100 to decrease the computation time.
## The defaults of maximalShuffleEnhancers is 1000. Increase the shuffle number
## may help to get accurate P-value.
aln_hs <- searchTFBPS(seqEN, hs, PWMs = PWMs,
                      queryGenome = Drerio,
                      maximalShuffleEnhancers = 100)
aln_mm <- searchTFBPS(seqEN, mm, PWMs = PWMs,
                      queryGenome = Drerio,
                      maximalShuffleEnhancers = 100)
## if you want to stick to sequence similarity search, try to use ?alignmentOne
```

## Step 4, filter the candidate regions.

Here we will filter the candidate regions more than 5K from TSS of homolog but within 100K from the gene body. The candidates will be also filtered by p-value.

```
# Step4
ext <- 100000
aln_hs <- subsetByOverlaps(aln_hs, ranges = expandGR(g_hs, ext=ext))
## filter by distance
distance(aln_hs) <- distance(peaks(aln_hs), g_hs, ignore.strand=TRUE)
aln_hs <- subset(aln_hs, pval<0.1 & distance >5000)
aln_hs
```

```
## This is an object with  1  Enhancers for  Homo sapiens
```

```
aln_mm <- subsetByOverlaps(aln_mm, ranges = expandGR(g_mm, ext=ext))
## filter by distance
distance(aln_mm) <- distance(peaks(aln_mm), g_mm, ignore.strand=TRUE)
aln_mm <- subset(aln_mm, pval<0.1 & distance >5000)
aln_mm
```

```
## This is an object with  3  Enhancers for  Mus musculus
```

## Step 5, alignment for the enhancer and the orthologs

This step will create alignments for all combination of the enhancer and the orthologs.

```
aln_list <- list(human=aln_hs, mouse=aln_mm)
al <- alignment(seqEN, aln_list,
                method="ClustalW", order="input")
al
```

```
## [[1]]
## DNAMultipleAlignment with 3 rows and 1676 columns
##      aln                                                    names
## [1] TGGCATACACAGCAAACATCATGAAT...TAGAAACAGAAGCAAATTGGCGAGT Enhancer
## [2] --------------------------...------------------------- human_chr7:128264...
## [3] --------------------------...------------------------- mouse_chr6:290320...
##
## [[2]]
## DNAMultipleAlignment with 3 rows and 1707 columns
##      aln                                                    names
## [1] TGGCATACACAGCAAACATCATGAAT...TAGAAACAGAAGCAAATTGGCGAGT Enhancer
## [2] --------------------------...------------------------- human_chr7:128264...
## [3] --------------------------...------------------------- mouse_chr6:291474...
##
## [[3]]
## DNAMultipleAlignment with 3 rows and 1683 columns
##      aln                                                    names
## [1] TGGCATACACAGCAAACATCATGAAT...TAGAAACAGAAGCAAATTGGCGAGT Enhancer
## [2] --------------------------...------------------------- human_chr7:128264...
## [3] --------------------------...------------------------- mouse_chr6:290312...
```

## Step 6a, for quick evolution enhancers, check the conserved motifs in the orthologs

Different form finding motif hits from the consensus of multiple alignment results, the `conservedMotifs` function will search the user defined motifs form available homologs.

```
cm <- conservedMotifs(al[[1]], aln_list, PWMs, Drerio)
```

## Step 6b, for slow evolution enhancers, export the multiple alignments in order.

The selected candidates will be aligned cross human and mouse and then output as phylip multiple alignment file in `text` or `html` format.

```
library(MotifDb)
motifs <- query(MotifDb, "JASPAR_CORE")
consensus <- sapply(motifs, consensusString)
consensus <- DNAStringSet(gsub("\\?", "N", consensus))
tmpfolder <- tempdir()
saveAlignments(al, output_folder = tmpfolder, motifConsensus=consensus)
readLines(file.path(tmpfolder, "aln1.phylip.txt"))
```

```
##   [1] " 5 1676"
##   [2] "Enhancer                           TGGCATACAC AGCAAACATC ATGAATTTAA TTTAATTTAA TTTAATTTAA"
##   [3] "human_chr7:128264261-128265260:+   ---------- ---------- ---------- ---------- ----------"
##   [4] "mouse_chr6:29032045-29033044:+     ---------- ---------- ---------- ---------- ----------"
##   [5] "Consensus                          ---------- ---------- ---------- ---------- ----------"
##   [6] "motifConsensus                     ---------- ---------- ---------- ---------- ----------"
##   [7] ""
##   [8] "                                   TTTAATTTTT TTAATTTAAT TTTAATATTT TAAAATAAAA TAAAATAAAA"
##   [9] "                                   ---------- ---------- ---------- ---------- ----------"
##  [10] "                                   ---------- ---------- ---------- ---------- ----------"
##  [11] "                                   ---------- ---------- ---------- ---------- ----------"
##  [12] "                                   ---------- ---------- ---------- ---------- ----------"
##  [13] ""
##  [14] "                                   TAAAATAAAA TAAAAGATAA AGATAAAGAT AAAATAAAAT TCAACTCAAT"
##  [15] "                                   ---------- ---------- ---------- ---------- ----------"
##  [16] "                                   ---------- ---------- ---------- ---------- ----------"
##  [17] "                                   ---------- ---------- ---------- ---------- ----------"
##  [18] "                                   ---------- ---------- ---------- ---------- ----------"
##  [19] ""
##  [20] "                                   TAAATTAAAA CTAAGCTAAA ATAAAAATAC AATAAAATAA ATTTCAATTT"
##  [21] "                                   ---------- ---------- ---------- ---------- ----------"
##  [22] "                                   ---------- ---------- ---------- ---------- ----------"
##  [23] "                                   ---------- ---------- ---------- ---------- ----------"
##  [24] "                                   ---------- ---------- ---------- ---------- ----------"
##  [25] ""
##  [26] "                                   AATGTAATTT AATTTAAAAA GGGACTACGC CGAAAAGAAA ATGAATGAAT"
##  [27] "                                   ---------- ---------- ---------- ---------- ----------"
##  [28] "                                   ---------- ---------- ---------- ---------- ----------"
##  [29] "                                   ---------- ---------- ---------- ---------- ----------"
##  [30] "                                   ---------- ---------- ---------- ---------- ----------"
##  [31] ""
##  [32] "                                   GGATGAATAA ATAATTTAAT TTAATTTAAT TTAATTTAAT TTAATTTAAT"
##  [33] "                                   ---------- ---------- ---------- ---------- ----------"
##  [34] "                                   ---------- ---------- ---------- ---------- ----------"
##  [35] "                                   ---------- ---------- ---------- ---------- ----------"
##  [36] "                                   ---------- ---------- ---------- ---------- ----------"
##  [37] ""
##  [38] "                                   TTAATTTAAT TTAATTTAAT TTAATTTAAT TTAATTTAAT TTAATTTAAT"
##  [39] "                                   ---------- ---------- ---------- ---------- ----------"
##  [40] "                                   ---------- ---------- ---------- ---------- ----------"
##  [41] "                                   ---------- ---------- ---------- ---------- ----------"
##  [42] "                                   ---------- ---------- ---------- ---------- ----------"
##  [43] ""
##  [44] "                                   TTAATTTAAT TTGTTCGGCA CAGTATAATA TGCTAGCATC TCAGTTATTT"
##  [45] "                                   ---------- ---------- ---------- ---------- ----------"
##  [46] "                                   ---------- ---------- ---------- ---------- ----------"
##  [47] "                                   ---------- ---------- ---------- ---------- ----------"
##  [48] "                                   ---------- ---------- ---------- ---------- ----------"
##  [49] ""
##  [50] "                                   CACGTGTGTT GTTACTATAA AATAAGCAAA ACAGTGATAA AATAAGTTTG"
##  [51] "                                   ---------- ---------- ---------- ---------- ----------"
##  [52] "                                   ---------- ---------- ---------- ---------- ----------"
##  [53] "                                   ---------- ---------- ---------- ---------- ----------"
##  [54] "                                   ---------- ---------- ---------- ---------- ----------"
##  [55] ""
##  [56] "                                   TGTTGCTTAT CTTATGACTG GTGGAATGTA ACAGGGAAAA AAAGCACATA"
##  [57] "                                   ---------- ---------- ---------- ---------- ----------"
##  [58] "                                   ---------- ---------- ---------- ---------- ----------"
##  [59] "                                   ---------- ---------- ---------- ---------- ----------"
##  [60] "                                   ---------- ---------- ---------- ---------- ----------"
##  [61] ""
##  [62] "                                   CTGTGACTTT GACAAAACTG AGTGACTGAT GATAATAAAC TTCTCTTCTC"
##  [63] "                                   ---------- ---------- ---------- ------GAAC AGAGAGGATT"
##  [64] "                                   ---------- ---------- ---------- ---TCTGAAC TGCCTTGTTT"
##  [65] "                                   ---------- ---------- ---------- -----T-AAC T-C--T--T-"
##  [66] "                                   ---------- ---------- ---------- ---------- ----------"
##  [67] ""
##  [68] "                                   GTAAGCTGAC AGTTCATAAA ACCTCTGCTT GTTTTTTTGT ACTTTTAATC"
##  [69] "                                   GCCTGGAG-- -GTTCCTAGG ACCACAGCAA GAGGTGTT-- GTGGGGGGCT"
##  [70] "                                   ACCAGCTG-- -TCTTGCTAA ACCTCAGCCT ATGCCGGTA- GCAGGCTGTT"
##  [71] "                                   G--AGCTG-- -GTTC-TAAA ACCTC-GC-T GT--T-TT-- -C------T-"
##  [72] "                                   ---------- ---------- ---------- ---------- ----------"
##  [73] ""
##  [74] "                                   TTAAGGTGAC GCATGTAGCT TCCTGTCCTT CT-CAGTTTA CTGACAGAGG"
##  [75] "                                   T---CCCGGC T-TCCCGGAG GCCCTTCTTC CCATGACAGG AGG---GACA"
##  [76] "                                   TAGGCCGGGT TATTCTAGAG CTTGGATCTT TAGTGGTTTA ATGTTTAAGG"
##  [77] "                                   T------G-C ---T-TAG-- -CC-GTCCTT C----GTTTA -TG---GAGG"
##  [78] "                                   ---------- ---------- ---------- ---------- ----------"
##  [79] ""
##  [80] "                                   TTAGGGTTTA -ATCCCAGAT ATCCAGTCTG ACTGTACAGT AGTTCAGGAG"
##  [81] "                                   GTGGAGATAG CACCTACTCT GGTGACCTTG C--TCTCTGC TTTT---GTC"
##  [82] "                                   ATGCATCAGG GGCTTCCGAT GGCCAGCCTG CGGCTGCTTC CGAT---GAC"
##  [83] "                                   -T-G-G-T-- -A-C-C-GAT --CCAG-CTG ----T-C-G- -GTT---GA-"
##  [84] "                                   ---------- ------NGAT N--------- ---------- ----------"
##  [85] ""
##  [86] "                                   ACCGACGCAG ATTTATAGCA TCATTCGTCA AACCCTGAGG ATAATCATTT"
##  [87] "                                   TTGTGACC-T GCTTGTGG-- --GTGAGCCC TACCCCTTGG -TTTCCACGT"
##  [88] "                                   AGATATCCAT GCGTATGGC- TCGTGACACT CTTCCCGTGG -CATCCAGCA"
##  [89] "                                   A---A--CA- --TTAT-GC- TC-T--G-C- -ACCC-G-GG -TA--CA--T"
##  [90] "                                   ---------- ---------- ---------- ---------- ----------"
##  [91] ""
##  [92] "                                   GTCACAGCTT CCTTTGGTCA TCATTACTGT GCAAATAAAC TGTTAGAGCA"
##  [93] "                                   GACCCAT-AA AGTCTACTCA TTTTCTGTCC AG-GGTTCA- -GGCACAGAG"
##  [94] "                                   GAATTG--GA GCTCCAAGCA GACCTGGTCT GCCAGTTGC- -AAAACGTCT"
##  [95] "                                   G-C-CA---- -CT-T--TCA T--TT--T-T GC-A-T--A- -G--A-AGC-"
##  [96] "                                   ---------- ---------- ---------- ---------- ----------"
##  [97] ""
##  [98] "                                   TGAGCCAGCA AAAACAGTGG GAAACGCAGC AATTTCCTGT ATTTAATAGT"
##  [99] "                                   AGAAAAGGCA AGGATGTGGA GGGAGAGGAG AGTC-CCTGG AAGGAATGTC"
## [100] "                                   TCCATACAAA GAGGCATGTC AGAATGCAAG CAAC-CGTCT GGGCATCATT"
## [101] "                                   TGA----GCA AA-ACA--G- G-AA-GCA-- AAT--CCTGT A---AATA-T"
## [102] "                                   ---------- ---------- ---------- ---------- ----------"
## [103] ""
## [104] "                                   CTGTGAGATA TACTTTAATG AGATGAAATT GAAGAAAACT GAGTCATTAG"
## [105] "                                   CCC-AGCATA T-CAGCCTGG AGTTTCCATT CAGGAAATTT CCCCAGCTCC"
## [106] "                                   ACG-GGGTTA T-GTGGAATC TGTTCTAATT GATTAAAACC AGGAAGATCA"
## [107] "                                   C-G-G-GATA T-CT--AATG AG-T--AATT GA-GAAAACT --G----T--"
## [108] "                                   ---------- ---------- ---------- ---------- ----------"
## [109] ""
## [110] "                                   AAAGGCATTC ACATAAACTT TCCTGGTGTA TATTTCCTAA CTCTCTTCCA"
## [111] "                                   CCAGACCCTC CCA--GACTT GCCTCCTCCC TCCTGACAAA GCCCCAGCCC"
## [112] "                                   TCAATCATTC GAA--AGCCT CGACAGTTTG TTATTAGGTA GCCACTTGCC"
## [113] "                                   --AG-CATTC -CA--AACTT -CCT-GT-T- T--TT-C-AA --C-CTTCC-"
## [114] "                                   ---------- ---------- ---------- ---------- ----------"
## [115] ""
## [116] "                                   GTGTTTTCTA CACCAGAAGA GTTCATTACA TCATTGAAGG ACAATGCTGA"
## [117] "                                   -TACC-CATA GCCCCAGCCA CCACCCCCTT T-GAGGAGAG AAGGTGCTGG"
## [118] "                                   -TATGACACA CCTCAAAACT GCTCCAGGCA T-GCAGCATG TTAGGACACC"
## [119] "                                   -T-T----TA C-CCA-AA-A G-TC----CA T----GAA-G A-A-TGCTG-"
## [120] "                                   ---------- ---------- ---------- ---------- ----------"
## [121] ""
## [122] "                                   AAAATAAGAA CGCGTTTGGT TTTTCATAAA CCACATGGTC TTGTGGGTCA"
## [123] "                                   GTTGGGTGAG GAGCTCTGCG GGAGGACTGA AC-CA-AGCT --GTGGGCTC"
## [124] "                                   GCTGTGGGAA AAACCGCTGG TCACGATGAT GC-CAGAGCC --GCCAGTTG"
## [125] "                                   ----T--GAA ----T-TGG- T----AT-AA -C-CA--G-C --GTGGGT--"
## [126] "                                   ---------- ---------- ---------- ---------- ----------"
## [127] ""
## [128] "                                   TGTTGTTTTG TTTCTTTAGA TTTGAGAGAC GGGGAATGAT GTGATTTTGC"
## [129] "                                   CTGGGC---A CCTGCCCA-- --TG--AGCC AGGCCTGCAT CTCCCAGACC"
## [130] "                                   TGAAAT---G AAAACCAA-- --TGCCAGCT AACTAATTGT TTCAACTACC"
## [131] "                                   TG--GT---G --T----A-- --TG--AG-C -GG-AAT-AT -T-A--T--C"
## [132] "                                   ---------- ---------- ---------- ---------- ----------"
## [133] ""
## [134] "                                   CCAGTCAGCA TGGATATGAT TTGGACTTCC ATCTGTTTAA GATTAAATGG"
## [135] "                                   TGCTTGTGGG TGAGCCTGCA TGCTGACATG CTTGGCTGGG CTCTAGCC--"
## [136] "                                   C-TGTGCCAA AGAATCGATT GGGGAGAACA TTTTGTCCAC ACTCACCCGA"
## [137] "                                   C--GT--G-A TG-AT-TG-T T-GGA---C- -T-TGTT-A- --TTA---G-"
## [138] "                                   ---------- ---------- ---------- ---------- ----------"
## [139] ""
## [140] "                                   TAGACAGAGA GAAATATTTC TGTTTTTTTT ATCCATGATT GCAAATCTGT"
## [141] "                                   TTGGCTATTG GTGGC--CCA GGGTGTGTGT GTGTGTGCGT GCATGTGTGT"
## [142] "                                   TTGGC--TTG GTGGT--CTT GGTCCTGTAG AGATGCAGCC GGAGTATCAG"
## [143] "                                   T-G-C----- G---T---T- -GTT-T-T-T AT---TG--T GCA--T-TGT"
## [144] "                                   ---------- ---------- ---------- ---------- ----------"
## [145] ""
## [146] "                                   GGGTTCAAAG TCTGCTTTTG TTCCAAATAA TCATTCAAAC CTGCCGTACT"
## [147] "                                   GTGTGTCC-C TTTGGAGCTA TGTAGTTTGT GTACCAAAAT AAGAAGGGAG"
## [148] "                                   GAATGTGG-G CCTAGTGTCA GGTA--TCAG AATTCGAGGC TGGAAGGAGC"
## [149] "                                   G-GT-----G TCTG-T-TT- T------TA- --AT--AAAC --G--G-A--"
## [150] "                                   ---------- ---------- ---------- ---------- ----------"
## [151] ""
## [152] "                                   GTGTGGGGTG GGAAGTGAAG GAGGATCTTA TCTGGAA--A TCATGTGCTG"
## [153] "                                   CTGGGGAGTT GAGCCCTGAT GAACTTTGTA ACAATAA--A GCCTTATCTT"
## [154] "                                   CTCCAGAGAG AGAGTTTCAT GCATTCCCTT CATGTCACCA ACAAGGATCA"
## [155] "                                   -TG-GG-GTG GGA--T--A- GA---TC-TA -CTG-AA--A -CATG--CT-"
## [156] "                                   ---------- ---------- ---------- ---------- ----------"
## [157] ""
## [158] "                                   TATGATGAAG GCAGGATATG GAAAACTCC- AAATATGGAC ACC-TTTATG"
## [159] "                                   GTTAAATAAA TCAAGCCTTG AATAAATGC- CTGCTTATTC CTTGCCAATA"
## [160] "                                   GAGGGAGCAG CCAGGCTGCT GAAGGGCGCG CCACACAATT GTGGACTATT"
## [161] "                                   -ATGA-GAAG -CAGG-T-TG GAAAA-T-C- --A-AT---C ------TAT-"
## [162] "                                   ---------- ---------- ---------- ---------- ----------"
## [163] ""
## [164] "                                   TGTGCAAGGG AGAAAGTCTG AAGGATGCAA CCTGTTCATA ACATTTTCAT"
## [165] "                                   TTTTCCTGCT ACCTAAGGCA ACATAGCTCT GTGACCTGTA ACCAGTCACT"
## [166] "                                   GTTTTCAGAA A--GAGGTCA ATGAGGGCAC ATCTTTGCCC ACAGCATTTT"
## [167] "                                   T-T-C-AG-- A---AG---- A-G-A-GCA- ----TT--TA ACA--TT--T"
## [168] "                                   ---------- ---------- ---------- --------TA ACA-------"
## [169] ""
## [170] "                                   TCAAATTTAA ACTAGTTTGA TTAATTCCAA ATGCACATTT GATTTGTTGT"
## [171] "                                   TAACCTCTCT GG------GT CTATTTCCAT ATCTATAGAA AGTGGATATA"
## [172] "                                   TAACATTTTC GC------AG CTATTTCAGA ATC---ACGG TGCCCACTGA"
## [173] "                                   T-A-ATTT-- -C------G- -TA-TTCCAA AT--A-A--- --T---TTG-"
## [174] "                                   ---------- ---------- ---------- ---------- ----------"
## [175] ""
## [176] "                                   GTTTTTATGA TGTATTTCAC AATACTGTTG CATAAAATAT CTAAAAAAAA"
## [177] "                                   ATACT-ATT- TGTTCTCCTC AATGCTGCTT ATTGTAGAGA TCAAATGTAA"
## [178] "                                   ATGGC-ATTG CGTACTTTCT AAAAGTAGAC A----AGAAT TTGAGAAACA"
## [179] "                                   -T--T-AT-- TGTA-TTC-C AATACTG-T- --T--A--AT -TAAAAAAAA"
## [180] "                                   ---------- ---------- ---------- ---------- ----------"
## [181] ""
## [182] "                                   CATTTAGTTA TATGGAAGAC ACTTGGACAA CTGGTTGTTA TTTGTTTGTC"
## [183] "                                   TAACG---TG TGTGAAAG-- ---TGCTTTA TAGATGGCAA GGTGCTGTTC"
## [184] "                                   CCCCG---TG -GTGCAAC-- ---TG-TTCA TTGCTTA-AA CCTACTGCTG"
## [185] "                                   CA------T- T-TG-AAG-- ---TG----A -TG-TTG--A --TG-T--TC"
## [186] "                                   ---------- ---------- ---------- ---------- ----------"
## [187] ""
## [188] "                                   TATTTTTATG AATGCCTCAA AGATCAAATA GTTACACAC- TTAATGCAAT"
## [189] "                                   TGCTGTAAGG AATCCTTCTG ATCATTACGC TTTTTGTAAA GCAATCAGAA"
## [190] "                                   ACTCATTTG- ---CCCTTCG ATACTT---C TTTACCAACA TCGGTGGTGG"
## [191] "                                   T-TT-TTA-G AAT-CCTC-- A-A---A--- -TTAC--AC- T-AATG--A-"
## [192] "                                   ---------- ---------- ---------- ---------- ----------"
## [193] ""
## [194] "                                   CGAGCTTAGA GAGAGAAATT AAAAGTCTTA AATAAATTGT GATTAGATAA"
## [195] "                                   CAGCCATC-- ---------- ---------- ---------- ----------"
## [196] "                                   CATCT----- ---------- ---------- ---------- ----------"
## [197] "                                   C---C-T--- ---------- ---------- ---------- ----------"
## [198] "                                   ---------- ---------- ---------- ---------- ----------"
## [199] ""
## [200] "                                   ATAGAAACAG AAGCAAATTG GCGAGT"
## [201] "                                   ---------- ---------- ------"
## [202] "                                   ---------- ---------- ------"
## [203] "                                   ---------- ---------- ------"
## [204] "                                   ---------- ---------- ------"
```

## Session info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] motifmatchr_1.32.0
##  [2] MotifDb_1.52.0
##  [3] org.Mm.eg.db_3.22.0
##  [4] TxDb.Mmusculus.UCSC.mm10.knownGene_3.10.0
##  [5] org.Hs.eg.db_3.22.0
##  [6] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
##  [7] GenomicFeatures_1.62.0
##  [8] AnnotationDbi_1.72.0
##  [9] Biobase_2.70.0
## [10] BSgenome.Mmusculus.UCSC.mm10_1.4.3
## [11] BSgenome.Hsapiens.UCSC.hg38_1.4.5
## [12] GenomeInfoDb_1.46.0
## [13] BSgenome.Drerio.UCSC.danRer10_1.4.2
## [14] BSgenome_1.78.0
## [15] rtracklayer_1.70.0
## [16] BiocIO_1.20.0
## [17] Biostrings_2.78.0
## [18] XVector_0.50.0
## [19] GenomicRanges_1.62.0
## [20] Seqinfo_1.0.0
## [21] IRanges_2.44.0
## [22] S4Vectors_0.48.0
## [23] BiocGenerics_0.56.0
## [24] generics_0.1.4
## [25] enhancerHomologSearch_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] bitops_1.0-9                fastmap_1.2.0
##  [7] RCurl_1.98-1.17             BiocFileCache_3.0.0
##  [9] GenomicAlignments_1.46.0    XML_3.99-0.19
## [11] digest_0.6.37               DirichletMultinomial_1.52.0
## [13] lifecycle_1.0.4             pwalign_1.6.0
## [15] KEGGREST_1.50.0             RSQLite_2.4.3
## [17] magrittr_2.0.4              compiler_4.5.1
## [19] rlang_1.1.6                 sass_0.4.10
## [21] tools_4.5.1                 yaml_2.3.10
## [23] data.table_1.17.8           knitr_1.50
## [25] S4Arrays_1.10.0             bit_4.6.0
## [27] curl_7.0.0                  splitstackshape_1.4.8
## [29] DelayedArray_0.36.0         abind_1.4-8
## [31] BiocParallel_1.44.0         withr_3.0.2
## [33] purrr_1.1.0                 grid_4.5.1
## [35] caTools_1.18.3              gtools_3.9.5
## [37] SummarizedExperiment_1.40.0 cli_3.6.5
## [39] rmarkdown_2.30              crayon_1.5.3
## [41] TFMPvalue_0.0.9             httr_1.4.7
## [43] rjson_0.2.23                DBI_1.2.3
## [45] cachem_1.1.0                parallel_4.5.1
## [47] restfulr_0.0.16             matrixStats_1.5.0
## [49] vctrs_0.6.5                 Matrix_1.7-4
## [51] jsonlite_2.0.0              bit64_4.6.0-1
## [53] seqLogo_1.76.0              jquerylib_0.1.4
## [55] glue_1.8.0                  TFBSTools_1.48.0
## [57] codetools_0.2-20            UCSC.utils_1.6.0
## [59] tibble_3.3.0                pillar_1.11.1
## [61] rappdirs_0.3.3              htmltools_0.5.8.1
## [63] R6_2.6.1                    dbplyr_2.5.1
## [65] httr2_1.2.1                 evaluate_1.0.5
## [67] lattice_0.22-7              png_0.1-8
## [69] Rsamtools_2.26.0            cigarillo_1.0.0
## [71] memoise_2.0.1               bslib_0.9.0
## [73] Rcpp_1.1.0                  SparseArray_1.10.0
## [75] xfun_0.53                   MatrixGenerics_1.22.0
## [77] pkgconfig_2.0.3
```

1. Howe, K. *et al.* The zebrafish reference genome sequence and its relationship to the human genome. *Nature* **496,** 498–503 (2013).

2. Braasch, I. *et al.* The spotted gar genome illuminates vertebrate evolution and facilitates human-teleost comparisons. *Nature genetics* **48,** 427–437 (2016).

3. Wong, E. S. *et al.* Deep conservation of the enhancer regulatory code in animals. *Science* **370,** (2020).

4. A, S. Motifmatchr: Fast motif matching in r. *R package version*