# SequenceExtraction

#### 28 August 2020

#### Package

BRGenomics 1.0.3

In this section, we’ll give one more example showing the benefit of Bioconductor
integration by using the `Biostrings` package to extract sequences given by
GRanges objects.

```
library(BRGenomics)
library(Biostrings)
```

We’ve included a twobit file of sequences, although users can use fasta files,
as well.

```
# get path to included 2bit file
sfile <- system.file("extdata", "dm6_chr4chrM.2bit",
                     package = "BRGenomics")
```

We could import the entire sequence using the rtracklayer `import()` function,
which will figure out the file format and import a suitable object. In this
case, a `DNAStringSet`:

```
seq_chr4 <- import(sfile)
seq_chr4
```

```
## DNAStringSet object of length 2:
##       width seq                                             names
## [1] 1348131 TTATTATATTATTATATTATTA...CCGTCGATTTGAGATATATGAA chr4
## [2]   19524 AATGAATTGCCTGATAAAAAGG...AAAAAATGAAAATTATATTATT chrM
```

*We included mitochondrial DNA to demonstrate how the DNAStringSet treats
multiple chromosomes.*

However, we don’t need to import all the sequences. Instead, we can make a
`TwoBitFile` object that points to the file, and extract desired sequences from
it directly using the `getSeq()` function:

```
data("txs_dm6_chr4")
txs_pr <- promoters(txs_dm6_chr4, 0, 100)
```

```
seq_txs_pr <- getSeq(TwoBitFile(sfile), txs_pr)
seq_txs_pr
```

```
## DNAStringSet object of length 339:
##       width seq
##   [1]   100 ATCAATATAGCATAGCTCTTTTAATCAAATAAA...AAATAAGGAACACAAAATTAATGGAAAAGAAA
##   [2]   100 TGCGACATTGTTCTACGATGACTACAAAAAATG...GAGTTTCGGTCCCATACGAAGTCGCCGACTTA
##   [3]   100 CCTATAAAAATGCTTCATCAATCCATTTGTGTA...ATATTTCAAAGCGATAGTTAATGAAACTTATG
##   [4]   100 GAACAGTCGGCGAAGGCGGGCAGATCGAAGATG...TACTTTTCGATGCCAGTGCTGTTAATATAGAT
##   [5]   100 GAACAGTCGGCGAAGGCGGGCAGATCGAAGATG...TACTTTTCGATGCCAGTGCTGTTAATATAGAT
##   ...   ... ...
## [335]   100 GGTATTTCATATTATAAATTTATGTAAACTACA...AATACAATAATCATATCTGCAAAGTAAACTAA
## [336]   100 GGTATTTCATATTATAAATTTATGTAAACTACA...AATACAATAATCATATCTGCAAAGTAAACTAA
## [337]   100 AACACGGTCACACTGTTCTTCTCTTTGTTCGGG...CGATAAACAAATATCTGGTTTTACCTATTTGT
## [338]   100 AACACGGTCACACTGTTCTTCTCTTTGTTCGGG...CGATAAACAAATATCTGGTTTTACCTATTTGT
## [339]   100 AACACGGTCACACTGTTCTTCTCTTTGTTCGGG...CGATAAACAAATATCTGGTTTTACCTATTTGT
```

The sequences are stranded as well, such that if a plus and minus strand gene
overlapped perfectly, the minus strand sequence would be the reverse complement
of the plus strand sequence.

The Biostrings package itself is richly featured, and we’ll demonstrate only a
couple functions below. This functionality is extended by packages like
`ggseqlogo`, for example, which plots sequence logos directly from
DNAStringSets.

```
RNAStringSet(seq_txs_pr)
```

```
## RNAStringSet object of length 339:
##       width seq
##   [1]   100 AUCAAUAUAGCAUAGCUCUUUUAAUCAAAUAAA...AAAUAAGGAACACAAAAUUAAUGGAAAAGAAA
##   [2]   100 UGCGACAUUGUUCUACGAUGACUACAAAAAAUG...GAGUUUCGGUCCCAUACGAAGUCGCCGACUUA
##   [3]   100 CCUAUAAAAAUGCUUCAUCAAUCCAUUUGUGUA...AUAUUUCAAAGCGAUAGUUAAUGAAACUUAUG
##   [4]   100 GAACAGUCGGCGAAGGCGGGCAGAUCGAAGAUG...UACUUUUCGAUGCCAGUGCUGUUAAUAUAGAU
##   [5]   100 GAACAGUCGGCGAAGGCGGGCAGAUCGAAGAUG...UACUUUUCGAUGCCAGUGCUGUUAAUAUAGAU
##   ...   ... ...
## [335]   100 GGUAUUUCAUAUUAUAAAUUUAUGUAAACUACA...AAUACAAUAAUCAUAUCUGCAAAGUAAACUAA
## [336]   100 GGUAUUUCAUAUUAUAAAUUUAUGUAAACUACA...AAUACAAUAAUCAUAUCUGCAAAGUAAACUAA
## [337]   100 AACACGGUCACACUGUUCUUCUCUUUGUUCGGG...CGAUAAACAAAUAUCUGGUUUUACCUAUUUGU
## [338]   100 AACACGGUCACACUGUUCUUCUCUUUGUUCGGG...CGAUAAACAAAUAUCUGGUUUUACCUAUUUGU
## [339]   100 AACACGGUCACACUGUUCUUCUCUUUGUUCGGG...CGAUAAACAAAUAUCUGGUUUUACCUAUUUGU
```

```
suppressWarnings(translate(seq_txs_pr))
```

```
## AAStringSet object of length 339:
##       width seq
##   [1]    33 INIA*LF*SNKTRNSKRMPPKKKNKEHKINGKE
##   [2]    33 CDIVLR*LQKMTNNFYKPIRYVRSFGPIRSRRL
##   [3]    33 PIKMLHQSICVVTLQGCTSVNRLYFKAIVNETY
##   [4]    33 EQSAKAGRSKMATQYIYSYVS*DTFRCQCC*YR
##   [5]    33 EQSAKAGRSKMATQYIYSYVS*DTFRCQCC*YR
##   ...   ... ...
## [335]    33 GISYYKFM*TTNLSVQKPASHCKIQ*SYLQSKL
## [336]    33 GISYYKFM*TTNLSVQKPASHCKIQ*SYLQSKL
## [337]    33 NTVTLFFSLFGSL*KLCIQMKLYDKQISGFTYL
## [338]    33 NTVTLFFSLFGSL*KLCIQMKLYDKQISGFTYL
## [339]    33 NTVTLFFSLFGSL*KLCIQMKLYDKQISGFTYL
```

```
oligonucleotideFrequency(seq_txs_pr[1:5], width = 1)
```

```
##       A  C  G  T
## [1,] 57 13 12 18
## [2,] 34 23 17 26
## [3,] 31 18 17 34
## [4,] 31 19 26 24
## [5,] 31 19 26 24
```

```
oligonucleotideFrequency(seq_txs_pr[1:5], width = 2)
```

```
##      AA AC AG AT CA CC CG CT GA GC GG GT TA TC TG TT
## [1,] 34  5  7 10  8  2  0  3  5  3  3  1  9  3  2  4
## [2,] 11 10  3  9  6  5  7  5  8  2  2  5  9  6  5  6
## [3,] 12  5  4 10  6  3  3  6  3  3  3  7 10  6  7 11
## [4,]  6  7  8 10  7  2  7  3  9  6  5  6  9  4  5  5
## [5,]  6  7  8 10  7  2  7  3  9  6  5  6  9  4  5  5
```

```
tss_seq <- getSeq(TwoBitFile(sfile), promoters(txs_dm6_chr4, 4, 4))
tsspwm <- PWM(tss_seq)
tsspwm
```

```
##          [,1]         [,2]          [,3]          [,4]         [,5]       [,6]
## A  0.11786207  0.121558228  0.0728689800 -0.0009513673  0.133239908 0.08113711
## C -0.00672592  0.040604643  0.0340837029  0.0795207580  0.027255784 0.03184325
## G  0.03184325 -0.009701748 -0.0009513673  0.0151092375 -0.003809913 0.06942510
## T  0.11017463  0.102056901  0.1430050774  0.1471427266  0.093457851 0.09924681
##          [,7]       [,8]
## A  0.09924681 0.09345785
## C  0.04684502 0.05086096
## G -0.02225587 0.01255293
## T  0.12516255 0.11278263
```