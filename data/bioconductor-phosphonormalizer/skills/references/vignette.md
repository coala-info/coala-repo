# phosphonormalizer: Pairwise normalization of phosphoproteomics data

#### Sohrab Saraei, Tomi Suomi, Otto Kauko,Laura L. Elo

#### October 11, 2016

## Introduction

Global centering-based normalization is a commonly-used normalization approach in mass spectrometry (MS) -based label-free proteomics. It scales the peptide abundances to have the same median intensities, based on an assumption that the majority of abundances remain the same across the samples. However, especially in phosphoproteomics experiments, this assumption can introduce bias, as the enrichment of phosphopeptides during sample preparation can mask large unidirectional biological changes. Therefore, a novel method called pairwise normalization has been introduced that addresses this possible bias by utilizing phosphopeptides quantified in both enriched and non-enriched samples to calculate factors that mitigate the bias (Kauko et al. 2015). The phosphonormalizer package implements the pairwise normalization (Saraei et al., under review ).

The phosphonormalizer package (Saraei et al. under review) normalizes the enriched samples in label-free MS-based phosphoproteomics using phosphopeptides that are present in both enriched and non-enriched data of the same samples. If there are no common phosphopeptides between the enriched and non-enriched data, then the normalization is not possible and an error is generated.

## Input data

In order to use phosphonormalizer package, we assume that the experiment have been conducted on both enriched and non-enriched samples. These datasets must have the sequence, modification and abundance columns. The sequence and modification columns in the dataframe must be in character format and the abundance columns in numeric. The algorithm expects that the abundances are pre-normalized with median normalization (Kauko et al. 2015). This package also supports MSnSet data type from MSnbase package which is used in data preprocessing step of bioconductor mass spectrometry proteomics workflow (see more: <https://www.bioconductor.org/help/workflows/proteomics/>).

```
    #Load the library
    library(phosphonormalizer)
    #Enriched data overview
    head(enriched.rd)
```

```
##                          Sequence
## 1                       SSSPVNVKK
## 2 TTSQKHRDFVAEPMGEKPVGSLAGIGEVLGK
## 3                      RRSPSPYYSR
## 4                     LRLSPSPTSQR
## 5        MEDLDQSPLVSSSDSPPRPQPAFK
## 6                     LRLSPSPTSQR
##                                                 Modification gcNorm.ctrl2.1
## 1                  [N-term] Acetyl; (N-Term)|[3] Phospho (S)      259694658
## 2 [N-term] Acetyl; (N-Term)|[2] Phospho; (T)|[3] Phospho (S)     1119159195
## 3                           [3] Phospho; (S)|[5] Phospho (S)      336584109
## 4                           [4] Phospho; (S)|[6] Phospho (S)      134915349
## 5                 [N-term] Acetyl; (N-Term)|[15] Phospho (S)      720567253
## 6                           [4] Phospho; (S)|[6] Phospho (S)       54067728
##   gcNorm.ctrl2.2 gcNorm.ctrl2.3 gcNorm.ctrl1.1 gcNorm.ctrl1.2 gcNorm.ctrl1.3
## 1      457040590      587004777      230727898      322501318      440483177
## 2     1705615152     1953963165     1078311545     1773146888     1474056582
## 3      193881363      276640765      148976414      174112138      153753909
## 4      167734763      197708821      229647325      191052464      166754233
## 5      630721302      568929214      606538462      723389269      682481415
## 6       68288843       89662099       95882948       88779229       81051004
##   gcNorm.CIP2A.1 gcNorm.CIP2A.2 gcNorm.CIP2A.3 gcNorm.RAS.1 gcNorm.RAS.2
## 1      668689914      674423478      625035056    451234167    363667417
## 2     1190582658      676441788      769588835   1372965516   1339147824
## 3      287782373      287136785      245112678    234516289    283827574
## 4      220674695      194132906      162583218    227425157    320668737
## 5      874073517     1017771417     1007191248    427561343    662159439
## 6       89833726       71876578       68494304    114763943    146028525
##   gcNorm.RAS.3 gcNorm.OA.1 gcNorm.OA.2 gcNorm.OA.3
## 1    309494581   352078454   177105234   227394429
## 2   2078858839  1179294365  1167182710  2117750218
## 3    200462805   180598176   158187327   209212284
## 4    256416084   150749053   373474922   306284818
## 5    681176179   436802093   309956463   307752815
## 6    111620925    83197600   165557524   152691693
```

```
    #Non-enriched data overview
    head(non.enriched.rd)
```

```
##              Sequence Modification gcNorm.ctrl2.1 gcNorm.ctrl2.2 gcNorm.ctrl2.3
## 1           LLLPGELAK         <NA>     1134176418      974814910     1228718539
## 2           AGLQFPVGR         <NA>      826483607      715965777      830605008
## 3     AMGIMNSFVNDIFER         <NA>     2528350640     2105237338     2495554811
## 4 VTIAQGGVLPNIQAVLLPK         <NA>     1263890433     1174074703     1306359138
## 5 VTIAQGGVLPNIQAVLLPK         <NA>     1715542498     1657401406     1626124071
## 6          AGFAGDDAPR         <NA>      410016382      334405218      692078515
##   gcNorm.ctrl1.1 gcNorm.ctrl1.2 gcNorm.ctrl1.3 gcNorm.CIP2A.1 gcNorm.CIP2A.2
## 1     1394059839     1527009279     2331374945     3262876356     1475250309
## 2      902406245     1107622809     1508853999     1051523142     1619993343
## 3     1272528331     2944603758     2443519913     3243241407     3981953390
## 4     1068498506     1116762968     1431064191     1586541519     2171400749
## 5     1985173704     2236269438     2453708614     2788681677     3975512588
## 6      939263413      409181048      515946375      122490064      232386439
##   gcNorm.CIP2A.3 gcNorm.RAS.1 gcNorm.RAS.2 gcNorm.RAS.3 gcNorm.OA.1 gcNorm.OA.2
## 1     1402379678   2331435624   1359941630   1337506496  1776762436  2068739879
## 2     1374369052   1702157550   1021184670   1094560285  1230922434  1253221279
## 3     3293949927   2804134445   3542050573   4403231723  3307460281  2235874137
## 4     1334195938   1514303277   1828763181   1619522966  1197144107  1204365265
## 5     2547762644   2568498719   3679284319   3297580183  2495127098  2084809203
## 6      354316201    338037562    267232025    414121334   275091595   249007012
##   gcNorm.OA.3
## 1  1619286624
## 2  1234030083
## 3  2344112126
## 4  1428068227
## 5  2121807104
## 6   416661130
```

## Pairwise normalization

The normalization begins by loading the phosphonormalizer package. Here for demonstration, the data used is from “enriched.rd” and “non.enriched.rd” are available with the package. Boxplot of fold change distribution before and after pairwise normalization can also be generated by setting the plot parameter (look at the example).

## Installation

To install this package, start R and enter:

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("phosphonormalizer")
```

## Example

```
    #Load the library
    library(phosphonormalizer)
    #Specify the column numbers of abundances in the original data.frame,
    #from both enriched and non-enriched runs
    samplesCols <- data.frame(enriched=3:17, non.enriched=3:17)
    #Specify the column numbers of sequence and modification in the original data.frame,
    #from both enriched and non-enriched runs
    modseqCols <- data.frame(enriched = 1:2, non.enriched = 1:2)
    #The samples and their technical replicates
    techRep <- factor(x = c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5))
    #If the paramter plot.fc set, the corresponding plots of Sample fold changes is produced
    #Here, for demonstration, the fold change distributions are shown for samples 3 vs 1
    plot.param <- list(control = c(1), samples = c(3))
    #Call the function
    norm <- normalizePhospho(enriched = enriched.rd, non.enriched = non.enriched.rd,
    samplesCols = samplesCols, modseqCols = modseqCols, techRep = techRep,
    plot.fc = plot.param)
```

![](data:image/png;base64...)

```
## The number of peptides in the intersect is: 54
```

```
## 1 plots generated. Browse through them.
```