# Data for mCSEA package

Jordi Martorell-Marugán1, Raúl López-Domínguez2\* and Pedro Carmona-Sáez1\*\*

1Bioinformatics and Health Data Science. GENYO, Centre for Genomics and Oncological Research
2Genomics Unit. GENYO, Centre for Genomics and Oncological Research

\*raul.lopez@genyo.es
\*\*pedro.carmona@genyo.es

#### 4 November 2025

#### Abstract

*mCSEAdata* package contains the necessary files to run the core analysis in *mCSEA* package. It also contains example data used by *mCSEA* to show it’s functionality.

#### Package

mCSEAdata 1.30.0

# Contents

* [1 Package contents](#package-contents)
* [2 Sources](#sources)
* [3 Session info](#session-info)

# 1 Package contents

```
library(mCSEAdata)
data(mcseadata)
data(bandTable)
```

Firstly, **betaTest**, **phenoTest** and **exprTest** are the objects necessary
to run the
examples in *mCSEA* package. **betaTest** is a matrix with the beta-values
of 9241 EPIC probes for 20 samples. **exprTest** is a subset of 100 genes’
expression from bone marrows of 10 healthy and 10 leukemia patients.
**phenoTest** is a dataframe with the
explanatory variable and covariates associated to the samples.

```
class(betaTest)
```

```
## [1] "matrix" "array"
```

```
dim(betaTest)
```

```
## [1] 9241   20
```

```
head(betaTest, 3)
```

```
##                    1         2         3         4         5         6
## cg18478105 0.6845279 0.6917252 0.8622046 0.6966168 0.1204777 0.7670960
## cg10605442 0.1370685 0.8450987 0.5480076 0.8671236 0.8300113 0.1667405
## cg27657131 0.1333706 0.6745949 0.8702664 0.9338893 0.8788454 0.1853554
##                     7          8          9        10         11         12
## cg18478105 0.93804510 0.88166619 0.90385504 0.9287976 0.04052779 0.10765614
## cg10605442 0.08727434 0.10568040 0.11896201 0.1764874 0.73534148 0.05741730
## cg27657131 0.10463463 0.05660229 0.06469281 0.2235293 0.92030432 0.04618165
##                   13        14        15         16        17        18
## cg18478105 0.1459481 0.8334884 0.1209040 0.07747453 0.7001099 0.7528026
## cg10605442 0.8213965 0.8208602 0.1671381 0.10157830 0.8874912 0.1723724
## cg27657131 0.1374107 0.8432675 0.9642680 0.14536637 0.9372422 0.9315385
##                    19         20
## cg18478105 0.86687272 0.85999403
## cg10605442 0.88836050 0.06521765
## cg27657131 0.06357636 0.50609450
```

```
class(phenoTest)
```

```
## [1] "data.frame"
```

```
dim(phenoTest)
```

```
## [1] 20  2
```

```
head(phenoTest, 3)
```

```
##   expla cov1
## 1  Case    1
## 2  Case    2
## 3  Case    1
```

```
class(exprTest)
```

```
## [1] "matrix" "array"
```

```
dim(exprTest)
```

```
## [1] 100  20
```

```
head(exprTest, 3)
```

```
##                        1        2        3        4        5        6        7
## ENSG00000179023 4.145748 4.388779 4.265583 4.374576 4.463465 4.078678 4.335878
## ENSG00000179029 4.485414 5.044662 5.411474 5.590093 5.365381 4.951236 6.626413
## ENSG00000179041 6.618769 6.443408 7.642324 7.989362 7.133374 7.224613 5.853054
##                        8        9       10       11       12       13       14
## ENSG00000179023 4.121601 4.163271 4.219654 4.340421 3.917131 4.284802 4.161627
## ENSG00000179029 5.070305 5.582466 5.688895 5.675448 5.053258 5.708689 5.170988
## ENSG00000179041 8.198245 6.847891 6.598557 6.546835 7.211352 7.190893 6.825418
##                       15       16       17       18       19       20
## ENSG00000179023 4.308718 4.074333 4.171878 4.083548 4.549825 4.199466
## ENSG00000179029 5.480265 5.118550 5.657001 5.257061 5.677323 5.171198
## ENSG00000179041 7.342032 7.309422 6.831020 7.728485 7.214401 6.781880
```

On the other hand, there are 9 association objects. Each one is a list of
features with their associated 450k, EPIC and EPICv2 CpG probes. The features included
are promoters (**assocPromoters450k**, **assocPromotersEPIC** and **assocPromotersEPICv2**), gene bodies
(**assocGenes450k**, **assocGenesEPIC** and **assocGenesEPICv2**) and CpG islands (**assocCGI450k**,
**assocCGIEPIC** and **assocCGIEPICv2**). These objects are internally used by *mCSEA.test*
function in *mCSEA* package.

```
class(assocPromoters450k)
```

```
## [1] "list"
```

```
length(assocPromoters450k)
```

```
## [1] 20960
```

```
head(assocPromoters450k, 3)
```

```
## $FAM197Y2
## [1] "cg00050873" "cg03052502" "cg03443143" "cg17834650" "cg02802508"
## [6] "cg03535417" "cg08635406" "cg17769199"
##
## $TTTY14
## [1] "cg00212031" "cg15345074" "cg06628792" "cg11684211" "cg11816202"
##
## $TMSB4Y
## [1] "cg00214611" "cg02004872" "cg02730008" "cg26198148"
```

```
class(assocGenes450k)
```

```
## [1] "list"
```

```
length(assocGenes450k)
```

```
## [1] 19071
```

```
head(assocGenes450k, 3)
```

```
## $TSPY4
##  [1] "cg00050873" "cg03443143" "cg04016144" "cg05544622" "cg09350919"
##  [6] "cg15810474" "cg15935877" "cg17834650" "cg17837162" "cg25705492"
## [11] "cg00543493" "cg00903245" "cg01523029" "cg02606988" "cg02802508"
## [16] "cg03535417" "cg04958669" "cg08258654" "cg08635406" "cg10239257"
## [21] "cg13861458" "cg14005657" "cg25538674" "cg26475999"
##
## $TTTY14
## [1] "cg03244189" "cg05230942" "cg10811597" "cg13765957" "cg13845521"
## [6] "cg15281205" "cg26251715"
##
## $NLGN4Y
##  [1] "cg03706273" "cg25518695" "cg01073572" "cg01498999" "cg02340092"
##  [6] "cg03278611" "cg04419680" "cg05939513" "cg07795413" "cg08816194"
## [11] "cg09300505" "cg09748856" "cg09804407" "cg10990737" "cg18113731"
## [16] "cg19244032" "cg27214488" "cg27265812" "cg27443332"
```

```
class(assocCGI450k)
```

```
## [1] "list"
```

```
length(assocCGI450k)
```

```
## [1] 27176
```

```
head(assocCGI450k, 3)
```

```
## $`chrY:9363680-9363943`
## [1] "cg00050873" "cg03443143"
##
## $`chrY:21238448-21240005`
## [1] "cg00212031" "cg03244189" "cg15345074" "cg06628792" "cg10811597"
## [6] "cg11684211" "cg11816202" "cg13845521" "cg26251715"
##
## $`chrY:8147877-8148210`
## [1] "cg00213748" "cg02272584" "cg06237805" "cg08160949" "cg08702825"
## [6] "cg08739478"
```

```
class(assocPromotersEPIC)
```

```
## [1] "list"
```

```
length(assocPromotersEPIC)
```

```
## [1] 26208
```

```
head(assocPromotersEPIC, 3)
```

```
## $YTHDF1
##  [1] "cg18478105" "cg10605442" "cg27657131" "cg08514185" "cg13587582"
##  [6] "cg25802399" "cg22485414" "cg03501095" "cg24092253" "cg12589387"
##
## $EIF2S3
## [1] "cg09835024" "cg06127902" "cg12275687" "cg00914804" "cg27345735"
## [6] "cg12590845" "cg25034591" "cg16712639" "cg07622257"
##
## $PKN3
## [1] "cg14361672" "cg06550760" "cg14204415" "cg11056832" "cg14036226"
## [6] "cg22365023" "cg20593100"
```

```
class(assocGenesEPIC)
```

```
## [1] "list"
```

```
length(assocGenesEPIC)
```

```
## [1] 23772
```

```
head(assocGenesEPIC, 3)
```

```
## $CCDC57
##  [1] "cg01763666" "cg26701563" "cg16920238" "cg17286790" "cg11989942"
##  [6] "cg03388043" "cg05483915" "cg05915375" "cg04098763" "cg14090409"
## [11] "cg21295367" "cg20780302" "cg01465684" "cg18209359" "cg16578864"
## [16] "cg15754222" "cg21880101" "cg05522083" "cg12952529" "cg14673194"
## [21] "cg10477817" "cg17751591" "cg11719141" "cg26928858" "cg21698718"
## [26] "cg07310278" "cg13339291" "cg13367490" "cg12336460" "cg02208313"
## [31] "cg26507988" "cg15857073" "cg22476252" "cg11935831" "cg08864681"
## [36] "cg22167267" "cg14832684" "cg09804706" "cg24973483" "cg12486944"
## [41] "cg00412514" "cg13796123" "cg13000015" "cg04824810" "cg25639749"
## [46] "cg03789597" "cg14136083" "cg13855717" "cg25612997" "cg20880890"
## [51] "cg04955630" "cg19976037" "cg16849440" "cg25735697" "cg22312907"
## [56] "cg12223090" "cg02967812" "cg04210266" "cg26837952" "cg06493125"
## [61] "cg08047030" "cg20798760" "cg00755572" "cg25388952" "cg13198984"
## [66] "cg01216201" "cg19567758" "cg22882093" "cg24480260" "cg23985595"
## [71] "cg06073302" "cg16477682" "cg25532751" "cg20299209" "cg11716677"
## [76] "cg02094669" "cg11859384" "cg10505658" "cg21577598" "cg24963024"
## [81] "cg17251650" "cg24378699" "cg02262688" "cg06132853" "cg22491947"
## [86] "cg02200666" "cg07959490" "cg09163921" "cg18996153" "cg20197093"
## [91] "cg18151291" "cg22142205" "cg16124601" "cg26105045" "cg23522485"
## [96] "cg16279483" "cg26093898" "cg21565972"
##
## $INF2
##  [1] "cg12950382" "cg18425377" "cg09184385" "cg10533694" "cg20980960"
##  [6] "cg07039149" "cg18519050" "cg23206460" "cg05210373" "cg03576530"
## [11] "cg25592858" "cg18996808" "cg10345522" "cg08043200" "cg17331554"
## [16] "cg03719908" "cg18465331" "cg23956771" "cg21827986" "cg14377342"
## [21] "cg24404909" "cg00816970" "cg23601271" "cg04966159" "cg18924331"
## [26] "cg22090592" "cg04278105" "cg12031670" "cg26212352" "cg02878289"
## [31] "cg05018513" "cg06971503" "cg11290775" "cg23343291" "cg18447460"
##
## $PIP5K1C
##  [1] "cg26724186" "cg05809578" "cg05233128" "cg17845617" "cg25247177"
##  [6] "cg02322048" "cg19423978" "cg16583193" "cg20969388" "cg08145067"
## [11] "cg15564488" "cg07577499" "cg03228408" "cg24732692" "cg09288755"
## [16] "cg02952625" "cg13995193" "cg11243391" "cg00793543" "cg27490930"
## [21] "cg19841005" "cg10591771" "cg10490670" "cg06358131" "cg16019751"
## [26] "cg22848927" "cg21865657" "cg19736470" "cg11955890" "cg07479621"
## [31] "cg17791316" "cg05312862" "cg07907254" "cg15483758" "cg02818004"
## [36] "cg06724384" "cg07059636" "cg17097293" "cg22623033" "cg01168835"
## [41] "cg13588224" "cg15389497" "cg23249839" "cg23480820" "cg13561409"
## [46] "cg17820448" "cg08301518" "cg17698261" "cg22677650" "cg03540494"
## [51] "cg15200445" "cg16248034" "cg14093663" "cg16564917" "cg07963254"
## [56] "cg02859655" "cg02106453" "cg00376288" "cg17290669" "cg20750693"
## [61] "cg12557799" "cg01070272" "cg06497674" "cg04385058" "cg00438838"
## [66] "cg10996109" "cg18249653" "cg06587767" "cg13670756" "cg04801430"
## [71] "cg12298375" "cg23654206" "cg15080709" "cg15540507" "cg08267629"
## [76] "cg11976007" "cg11452653" "cg09547756" "cg04742624"
```

```
class(assocCGIEPIC)
```

```
## [1] "list"
```

```
length(assocCGIEPIC)
```

```
## [1] 27187
```

```
head(assocCGIEPIC, 3)
```

```
## $`chr20:61846843-61848103`
##  [1] "cg18478105" "cg10605442" "cg27657131" "cg08514185" "cg17364922"
##  [6] "cg13587582" "cg25802399" "cg22485414" "cg15407723" "cg03501095"
## [11] "cg02177162" "cg10201192" "cg13388572" "cg00624976" "cg24092253"
## [16] "cg12589387"
##
## $`chrX:24072558-24073135`
## [1] "cg09835024" "cg06127902" "cg12275687" "cg00914804" "cg27345735"
## [6] "cg12590845" "cg25034591" "cg16712639" "cg07622257"
##
## $`chr9:131464843-131465830`
## [1] "cg14361672" "cg06550760" "cg14204415" "cg07950002" "cg11056832"
## [6] "cg14036226" "cg22365023" "cg20593100" "cg13548833"
```

```
class(assocPromotersEPICv2)
```

```
## [1] "list"
```

```
length(assocPromotersEPICv2)
```

```
## [1] 26153
```

```
head(assocPromotersEPICv2, 3)
```

```
## $ZNF781
##  [1] "cg25324105_BC11" "cg22521696_TC11" "cg25875213_TC11" "cg17445666_TC11"
##  [5] "cg04784475_TC11" "cg03611452_TC11" "cg14587524_BC11" "cg22685966_BC21"
##  [9] "cg17182700_TC21" "cg10701051_BC21"
##
## $ETNK2
##  [1] "cg25623721_TC11" "cg20136584_TC11" "cg04913057_TC11" "cg08114257_TC11"
##  [5] "cg01486694_BC11" "cg01566404_BC21" "cg25512657_BC21" "cg00103329_TC21"
##  [9] "cg21535580_TC21" "cg11687966_BC21" "cg12549161_BC21"
##
## $`PPM1F-AS1`
##  [1] "cg25898577_BC11" "cg27653384_TC11" "cg26102199_BC21" "cg01612629_TC21"
##  [5] "cg01052666_TC21" "cg03086022_BC21" "cg17159137_BC21" "cg25225310_TC21"
##  [9] "cg15736557_BC21" "cg04524370_BC21" "cg14641478_TC21" "cg25923015_TC21"
## [13] "cg05160769_BC21" "cg25405702_BC21" "cg17570088_TC21" "cg26102189_TC21"
## [17] "cg26102184_TC21"
```

```
class(assocGenesEPICv2)
```

```
## [1] "list"
```

```
length(assocGenesEPICv2)
```

```
## [1] 18614
```

```
head(assocGenesEPICv2, 3)
```

```
## $ACTN4
##  [1] "cg25383568_TC11" "cg03575974_BC11" "cg03575974_BC12" "cg03575974_BC13"
##  [5] "cg24500219_BC11" "cg01030321_TC21" "cg16814576_BC21" "cg23197406_TC21"
##  [9] "cg24499830_BC21" "cg07001793_BC21" "cg06540331_BC21" "cg19484260_TC21"
## [13] "cg24500564_TC21" "cg24500541_BC21" "cg24500217_BC21"
##
## $FAM171A2
## [1] "cg23766254_TC11" "cg22078805_BC11" "cg19935040_BC11" "cg17624802_BC11"
## [5] "cg15909132_TC11" "cg09014329_TC21" "cg05622422_BC21"
##
## $CLPTM1L
##  [1] "cg26224791_TC11" "cg17304712_TC11" "cg07576613_TC11" "cg14631690_TC11"
##  [5] "cg08433725_TC21" "cg25692669_BC21" "cg20700235_TC21" "cg07385490_TC21"
##  [9] "cg07162264_BC21" "cg21891499_BC21" "cg08547617_TC21"
```

```
class(assocCGIEPICv2)
```

```
## [1] "list"
```

```
length(assocCGIEPICv2)
```

```
## [1] 25805
```

```
head(assocCGIEPICv2, 3)
```

```
## $`chr19:37691892-37692426`
## [1] "cg25324105_BC11" "cg22521696_TC11" "cg09449030_TC11" "cg25875213_TC11"
## [5] "cg17445666_TC11" "cg04784475_TC11" "cg03611452_TC11" "cg14587524_BC11"
##
## $`chr19:38726890-38727217`
## [1] "cg25383568_TC11" "cg04517274_TC21"
##
## $`chr19:1591428-1591629`
## [1] "cg25455143_BC11" "cg24140597_BC11" "cg08660999_TC11" "cg12286540_TC11"
## [5] "cg08704080_TC11" "cg22069171_BC11" "cg26982998_BC21" "cg09174855_TC21"
## [9] "cg21739009_BC21"
```

There are also 3 GRanges objects with the locations of 450K, EPIC and EPICv2 probes,
used by *mCSEAPlot()* and *mCSEAIntegrate()* functions:

```
class(annot450K)
```

```
## [1] "GRanges"
## attr(,"package")
## [1] "GenomicRanges"
```

```
head(annot450K, 3)
```

```
## GRanges object with 3 ranges and 0 metadata columns:
##              seqnames    ranges strand
##                 <Rle> <IRanges>  <Rle>
##   cg00050873     chrY   9363356      *
##   cg00212031     chrY  21239348      *
##   cg00213748     chrY   8148233      *
##   -------
##   seqinfo: 24 sequences from hg19 genome; no seqlengths
```

```
class(annotEPIC)
```

```
## [1] "GRanges"
## attr(,"package")
## [1] "GenomicRanges"
```

```
head(annotEPIC, 3)
```

```
## GRanges object with 3 ranges and 0 metadata columns:
##              seqnames    ranges strand
##                 <Rle> <IRanges>  <Rle>
##   cg18478105    chr20  61847650      *
##   cg09835024     chrX  24072640      *
##   cg14361672     chr9 131463936      *
##   -------
##   seqinfo: 24 sequences from hg19 genome; no seqlengths
```

```
class(annotEPICv2)
```

```
## [1] "GRanges"
## attr(,"package")
## [1] "GenomicRanges"
```

```
head(annotEPICv2, 3)
```

```
## GRanges object with 3 ranges and 0 metadata columns:
##                   seqnames    ranges strand
##                      <Rle> <IRanges>  <Rle>
##   cg25324105_BC11    chr19  37692358      +
##   cg25383568_TC11    chr19  38727081      -
##   cg25455143_BC11    chr19   1591515      -
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

Finally, **bandTable** object contains two objects with the information of chromosomes band information and
centromer location, one for each genome building: hg19 and hg38 It is used by mCSEAPlot() function to plot the chromosome
track.

```
head(bandTablehg19)
```

```
##   chrom chromStart chromEnd   name gieStain
## 1  chr1          0  2300000 p36.33     gneg
## 2  chr1    2300000  5400000 p36.32   gpos25
## 3  chr1    5400000  7200000 p36.31     gneg
## 4  chr1    7200000  9200000 p36.23   gpos25
## 5  chr1    9200000 12700000 p36.22     gneg
## 6  chr1   12700000 16200000 p36.21   gpos50
```

```
head(bandTablehg38)
```

```
##   chrom chromStart chromEnd   name gieStain
## 1  chr1          0  2300000 p36.33     gneg
## 2  chr1    2300000  5300000 p36.32   gpos25
## 3  chr1    5300000  7100000 p36.31     gneg
## 4  chr1    7100000  9100000 p36.23   gpos25
## 5  chr1    9100000 12500000 p36.22     gneg
## 6  chr1   12500000 15900000 p36.21   gpos50
```

# 2 Sources

* Example objects:
  + **betaTest** contains simulated beta-values for EPIC platform probes.
  + **exprTest** contains expression data from Leukemia and healthy patients
    extracted from *[leukemiaEset](https://bioconductor.org/packages/3.22/leukemiaEset)* package.
  + **phenoTest** contains arbitrary phenotypes for each sample.
* Association objects: They were all constructed from
  *[IlluminaHumanMethylation450kanno.ilmn12.hg19](https://bioconductor.org/packages/3.22/IlluminaHumanMethylation450kanno.ilmn12.hg19)*,

| Region type | mCSEAdata association objects | Column from association DataFrame used | Column values | Feature name column |
| --- | --- | --- | --- | --- |
| Promoters | assocPromoters450k, assocPromotersEPIC and assocPromotersEPICv2 | UCSC\_RefGene\_Group | TSS1500, TSS200, 5’UTR, 1stExon or exon\_1 | UCSC\_RefGene\_Name |
| Gene bodies | assocGenes450k, assocGenesEPIC and assocGenesEPICv2 | UCSC\_RefGene\_Group | Body | UCSC\_RefGene\_Name |
| CpG Islands | assocCGI450k, assocCGIEPIC and assocCGIEPICv2 | Relation\_to\_Island | Island, N\_Shore, S\_Shore, N\_Shelf or S\_Shelf | Islands\_Name |

For instance, *cg00212031* probe from 450k platform has the following
annotation data in the association DataFrame:

| UCSC\_RefGene\_Group | UCSC\_RefGene\_Name | Relation\_to\_Island | Islands\_Name |
| --- | --- | --- | --- |
| TSS200 | TTTY14 | Island | chrY:21238448-21240005 |

So this probe is associated to TTTY14 promoter in assocPromoters450k object
and to chrY:21238448-21240005 CpG Island in assocCGI450k object.

* Annotation objects (**annot450K**, **annotEPIC** and **annotEPICv2**): They were both
  constructed with *[minfi](https://bioconductor.org/packages/3.22/minfi)* package. A *RGChannelSet* object was
  obtained for each platform and *getLocations()* function
  was applied to such objects.
* bandTablehg19 and bandTablehg38: It was constructed with *[Gviz](https://bioconductor.org/packages/3.22/Gviz)* package, concretely
  with *IdeogramTrack()* function.

# 3 Session info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] mCSEAdata_1.30.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5            knitr_1.50           rlang_1.1.6
##  [4] xfun_0.54            generics_0.1.4       jsonlite_2.0.0
##  [7] S4Vectors_0.48.0     htmltools_0.5.8.1    sass_0.4.10
## [10] stats4_4.5.1         rmarkdown_2.30       Seqinfo_1.0.0
## [13] evaluate_1.0.5       jquerylib_0.1.4      fastmap_1.2.0
## [16] yaml_2.3.10          IRanges_2.44.0       lifecycle_1.0.4
## [19] bookdown_0.45        BiocManager_1.30.26  compiler_4.5.1
## [22] digest_0.6.37        R6_2.6.1             GenomicRanges_1.62.0
## [25] bslib_0.9.0          tools_4.5.1          BiocGenerics_0.56.0
## [28] cachem_1.1.0
```