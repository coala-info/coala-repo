Code

* Show All Code
* Hide All Code

# deconvR : Simulation and Deconvolution of Omic Profiles

Irem B. Gunduz, Veronika Ebenal, Altuna Akalin

#### 2025-10-29

#### Package

deconvR 1.16.0

# 1 Introduction

Recent studies associated the differences of cell-type proportions may be
correlated to certain phenotypes, such as cancer. Therefore, the demand for the
development of computational methods to predict cell type proportions increased.
Hereby, we developed `deconvR`, a collection of functions designed for analyzing
deconvolution of the bulk sample(s) using an atlas of reference omic signature
profiles and a user-selected model. We wanted to give users an option to extend
their reference atlas. Users can create new reference atlases using
`findSignatures` or extend their atlas by adding more cell types. Additionally, we
included `BSMeth2Probe` to make mapping whole-genome bisulfite sequencing data
to their probe IDs easier. So users can map WGBS methylation data (as in
**methylKit** or **GRanges** object format) to probe IDs, and the results of
this mapping can be used as the bulk samples in the deconvolution. We also
included a comprehensive DNA methylation atlas of 25 different cell types to use
in the main function `deconvolute`. `deconvolute` allows the user to specify
their desired deconvolution model (non-negative least squares regression,
support vector regression, quadratic programming, or robust linear regression),
and returns a dataframe which contains predicted cell-type proportions of bulk
methylation profiles, as well as partial R-squared values for each sample.

As an another option, users can generate a simulated table of a desired number
of samples, with either user-specified or random origin proportions using
`simulateCellMix`. `simulateCellMix` returns a second data frame called
`proportions`, which contains the actual cell-type proportions of the simulated
sample. It can be used for testing the accuracy of the deconvolution by
comparing these actual proportions to the proportions predicted by
`deconvolute`.

`deconvolute` returns partial R-squares, to check if deconvolution brings
advantages on top of the basic bimodal profiles. The reference matrix usually
follows a bimodal distribution in the case of methylation, and taking the
average of the rows of methylation matrix might give a pretty similar profile
to the bulk methylation profile you are trying to deconvolute. If the
deconvolution is advantageous, partial R-squared is expect to be high.

# 2 Installation

The deconvR package can be installed from Bioconductor with:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("deconvR")
```

# 3 Data

## 3.1 Comprehensive Human Methylome Reference Atlas

The comprehensive human methylome reference atlas created by Moss et al. 111 Moss,
J. et al. (2018). Comprehensive human cell-type methylation atlas reveals
origins of circulating cell-free DNA in health and disease. Nature
communications, 9(1), 1-12. <https://doi.org/10.1038/s41467-018-07466-6> can be
used as the reference atlas parameter for several functions in this package.
This atlas was modified to remove duplicate CpG loci before being included in
the package as the dataframe. The dataframe is composed of 25 human cell types
and roughly 6000 CpG loci, identified by their Illumina Probe ID. For each cell
type and CpG locus, a methylation value between 0 and 1 is provided. This value
represents the fraction of methylated bases of the CpG locus. The atlas
therefore provides a unique methylation pattern for each cell type and can be
directly used as `reference` in `deconvolute` and `simulateCellMix`, and `atlas`
in `findSignatures`. Below is an example dataframe to illustrate the `atlas`
format.

```
library(deconvR)

data("HumanCellTypeMethAtlas")
head(HumanCellTypeMethAtlas[,1:5])
```

```
##          IDs Monocytes_EPIC B.cells_EPIC CD4T.cells_EPIC NK.cells_EPIC
## 1 cg08169020         0.8866       0.2615          0.0149        0.0777
## 2 cg25913761         0.8363       0.2210          0.2816        0.4705
## 3 cg26955540         0.7658       0.0222          0.1492        0.4005
## 4 cg25170017         0.8861       0.5116          0.1021        0.4363
## 5 cg12827637         0.5212       0.3614          0.0227        0.2120
## 6 cg19442545         0.2013       0.1137          0.0608        0.0410
```

## 3.2 Illumina Infinium MethylationEPIC v1.0 B5 Manifest Probes (hg38)

The **GRanges** object `IlluminaMethEpicB5ProbeIDs` contains the Illumina probe
IDs of 400000 genomic loci (identified using the “seqnames”, “ranges”, and
“strand” values). This object is based off of the Infinium MethylationEPIC v1.0
B5 Manifest data. Unnecessary columns were removed and rows were truncated to
reduce file size before converting the file to a **GRanges** object. It can be
used directly as `probe_id_locations` in `BSmeth2Probe`.

```
data("IlluminaMethEpicB5ProbeIDs")
head(IlluminaMethEpicB5ProbeIDs)
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames              ranges strand |          ID
##          <Rle>           <IRanges>  <Rle> | <character>
##   [1]    chr19     5236005-5236006      + |  cg07881041
##   [2]    chr20   63216298-63216299      + |  cg18478105
##   [3]     chr1     6781065-6781066      + |  cg23229610
##   [4]     chr2 197438742-197438743      - |  cg03513874
##   [5]     chrX   24054523-24054524      + |  cg09835024
##   [6]    chr14   93114794-93114795      - |  cg05451842
##   -------
##   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

# 4 Example Workflow For Whole Genome Bisulfate Sequencing Data

## 4.1 Expanding Reference Atlas

As mentioned in the introduction section, users can extend their reference atlas
to incorporate new data. Or may combine different reference atlases to construct
a more comprehensive one. This can be done using the `findSignatures` function.
In this example, since we don’t have any additional reference atlas, we will add
simulated data as a new cell type to reference atlas for example purposes.
First, ensure that `atlas` (the signature matrix to be extended) and `samples`
(the new data to be added to the signature matrix) are compliant with the
function requirements. Below illustrates the `samples` format.

```
samples <- simulateCellMix(3,reference = HumanCellTypeMethAtlas)$simulated
head(samples)
```

```
##          IDs   Sample 1  Sample 2   Sample 3
## 1 cg08169020 0.05481248 0.4439928 0.05021644
## 2 cg25913761 0.18639044 0.5267096 0.23501946
## 3 cg26955540 0.09434432 0.4360650 0.11633755
## 4 cg25170017 0.04426438 0.4288502 0.08920042
## 5 cg12827637 0.07341295 0.3115573 0.06120240
## 6 cg19442545 0.01884305 0.1063737 0.02427485
```

`sampleMeta` should include all sample names in `samples`, and specify the
origins they should be mapped to when added to `atlas`.

```
sampleMeta <- data.table("Experiment_accession" = colnames(samples)[-1],
                         "Biosample_term_name" = "new cell type")
head(sampleMeta)
```

```
##    Experiment_accession Biosample_term_name
##                  <char>              <char>
## 1:             Sample 1       new cell type
## 2:             Sample 2       new cell type
## 3:             Sample 3       new cell type
```

Use `findSignatures` to extend the matrix.

```
extended_matrix <- findSignatures(samples = samples,
                                 sampleMeta = sampleMeta,
                                 atlas = HumanCellTypeMethAtlas,
                                 IDs = "IDs")
```

```
## CELL TYPES IN EXTENDED ATLAS:
## new cell type
## Monocytes_EPIC
## B.cells_EPIC
## CD4T.cells_EPIC
## NK.cells_EPIC
## CD8T.cells_EPIC
## Neutrophils_EPIC
## Erythrocyte_progenitors
## Adipocytes
## Cortical_neurons
## Hepatocytes
## Lung_cells
## Pancreatic_beta_cells
## Pancreatic_acinar_cells
## Pancreatic_duct_cells
## Vascular_endothelial_cells
## Colon_epithelial_cells
## Left_atrium
## Bladder
## Breast
## Head_and_neck_larynx
## Kidney
## Prostate
## Thyroid
## Upper_GI
## Uterus_cervix
```

```
head(extended_matrix)
```

```
##          IDs new_cell_type Monocytes_EPIC B.cells_EPIC CD4T.cells_EPIC
## 1 cg08169020    0.18300724         0.8866       0.2615          0.0149
## 2 cg25913761    0.31603984         0.8363       0.2210          0.2816
## 3 cg26955540    0.21558230         0.7658       0.0222          0.1492
## 4 cg25170017    0.18743834         0.8861       0.5116          0.1021
## 5 cg12827637    0.14872422         0.5212       0.3614          0.0227
## 6 cg19442545    0.04983053         0.2013       0.1137          0.0608
##   NK.cells_EPIC CD8T.cells_EPIC Neutrophils_EPIC Erythrocyte_progenitors
## 1        0.0777          0.0164           0.8680                  0.9509
## 2        0.4705          0.3961           0.8293                  0.2385
## 3        0.4005          0.3474           0.7915                  0.1374
## 4        0.4363          0.0875           0.7042                  0.9447
## 5        0.2120          0.0225           0.5368                  0.4667
## 6        0.0410          0.0668           0.1952                  0.1601
##   Adipocytes Cortical_neurons Hepatocytes Lung_cells Pancreatic_beta_cells
## 1     0.0336           0.0168      0.0340     0.0416              0.038875
## 2     0.3578           0.3104      0.2389     0.2250              0.132000
## 3     0.1965           0.0978      0.0338     0.0768              0.041725
## 4     0.0842           0.2832      0.2259     0.0544              0.111750
## 5     0.0287           0.1368      0.0307     0.1607              0.065975
## 6     0.0364           0.0222      0.1574     0.0122              0.003825
##   Pancreatic_acinar_cells Pancreatic_duct_cells Vascular_endothelial_cells
## 1                  0.0209                0.0130                     0.0323
## 2                  0.2249                0.1996                     0.3654
## 3                  0.0314                0.0139                     0.2382
## 4                  0.0309                0.0217                     0.0972
## 5                  0.0370                0.0230                     0.0798
## 6                  0.0378                0.0347                     0.0470
##   Colon_epithelial_cells Left_atrium Bladder Breast Head_and_neck_larynx Kidney
## 1                 0.0163      0.0386  0.0462 0.0264               0.0470 0.0269
## 2                 0.2037      0.2446  0.2054 0.1922               0.2045 0.1596
## 3                 0.0193      0.1134  0.1269 0.1651               0.1523 0.1034
## 4                 0.0187      0.0674  0.0769 0.0691               0.0704 0.0604
## 5                 0.0193      0.0432  0.0459 0.0228               0.0687 0.0234
## 6                 0.0193      0.0287  0.0246 0.0081               0.0098 0.0309
##   Prostate Thyroid Upper_GI Uterus_cervix
## 1   0.0353  0.0553   0.0701        0.0344
## 2   0.1557  0.1848   0.1680        0.2026
## 3   0.0686  0.0943   0.1298        0.1075
## 4   0.0369  0.0412   0.0924        0.0697
## 5   0.0508  0.0726   0.0759        0.0196
## 6   0.0055  0.0188   0.0090        0.0166
```

WGBS methylation data first needs to be mapped to probes using `BSmeth2Probe`
before being deconvoluted. The methylation data `WGBS_data` in `BSmeth2Probe`
may be either a **GRanges** object or a **methylKit** object.

Format of `WGBS_data` as **GRanges** object:

```
load(system.file("extdata", "WGBS_GRanges.rda",
                                     package = "deconvR"))
head(WGBS_GRanges)
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames    ranges strand |   sample1
##          <Rle> <IRanges>  <Rle> | <numeric>
##   [1]     chr1     47176      + |  0.833333
##   [2]     chr1     47177      - |  0.818182
##   [3]     chr1     47205      + |  0.681818
##   [4]     chr1     47206      - |  0.583333
##   [5]     chr1     47362      + |  0.416667
##   [6]     chr1     49271      + |  0.733333
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

or as **methylKit** object:

```
head(methylKit::methRead(system.file("extdata", "test1.myCpG.txt",
                                     package = "methylKit"),
                         sample.id="test", assembly="hg18",
                         treatment=1, context="CpG", mincov = 0))
```

```
##     chr   start     end strand coverage numCs numTs
## 1 chr21 9764513 9764513      -       12     0    12
## 2 chr21 9764539 9764539      -       12     3     9
## 3 chr21 9820622 9820622      +       13     0    13
## 4 chr21 9837545 9837545      +       11     0    11
## 5 chr21 9849022 9849022      +      124    90    34
## 6 chr21 9853296 9853296      +       17    10     7
```

`probe_id_locations` contains information needed to map cellular loci to probe IDs

```
data("IlluminaMethEpicB5ProbeIDs")
head(IlluminaMethEpicB5ProbeIDs)
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames              ranges strand |          ID
##          <Rle>           <IRanges>  <Rle> | <character>
##   [1]    chr19     5236005-5236006      + |  cg07881041
##   [2]    chr20   63216298-63216299      + |  cg18478105
##   [3]     chr1     6781065-6781066      + |  cg23229610
##   [4]     chr2 197438742-197438743      - |  cg03513874
##   [5]     chrX   24054523-24054524      + |  cg09835024
##   [6]    chr14   93114794-93114795      - |  cg05451842
##   -------
##   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

Use `BSmeth2Probe` to map WGBS data to probe IDs.

```
mapped_WGBS_data <- BSmeth2Probe(probe_id_locations = IlluminaMethEpicB5ProbeIDs,
                                 WGBS_data = WGBS_GRanges,
                                 multipleMapping = TRUE,
                                 cutoff = 10)
head(mapped_WGBS_data)
```

```
##          IDs   sample1
## 1 cg00305774 1.0000000
## 2 cg00546078 0.8181818
## 3 cg00546307 0.5454545
## 4 cg00546971 0.5000000
## 5 cg00774867 0.8461538
## 6 cg00830435 0.9166667
```

This mapped data can now be used in `deconvolute`. Here we will deconvolute it
using the previously extended signature matrix as the reference atlas.

```
deconvolution <- deconvolute(reference = HumanCellTypeMethAtlas,
                             bulk = mapped_WGBS_data)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.9963  0.9963  0.9963  0.9963  0.9963  0.9963
```

```
deconvolution$proportions
```

```
##         Monocytes_EPIC B.cells_EPIC CD4T.cells_EPIC NK.cells_EPIC
## sample1              0            0               0             0
##         CD8T.cells_EPIC Neutrophils_EPIC Erythrocyte_progenitors Adipocytes
## sample1               0                0                       0  0.5011789
##         Cortical_neurons Hepatocytes Lung_cells Pancreatic_beta_cells
## sample1        0.2917357           0          0                     0
##         Pancreatic_acinar_cells Pancreatic_duct_cells
## sample1                       0                     0
##         Vascular_endothelial_cells Colon_epithelial_cells Left_atrium Bladder
## sample1                          0            0.001012524           0       0
##         Breast Head_and_neck_larynx Kidney Prostate Thyroid Upper_GI
## sample1      0            0.2060729      0        0       0        0
##         Uterus_cervix
## sample1             0
```

## 4.2 Constructing tissue specific CpG signature matrix

Alternatively, users can set *tissueSpecCpGs* as **TRUE** to construct tissue
based methylation signature matrix by using the reference atlas. Here, we
used simulated samples to construct tissue specific signature matrix since we
don’t have tissue specific samples.

```
data("HumanCellTypeMethAtlas")
exampleSamples <- simulateCellMix(1,reference = HumanCellTypeMethAtlas)$simulated
exampleMeta <- data.table("Experiment_accession" = "example_sample",
                          "Biosample_term_name" = "example_cell_type")
colnames(exampleSamples) <- c("CpGs", "example_sample")
colnames(HumanCellTypeMethAtlas)[1] <- c("CpGs")

signatures <- findSignatures(
  samples = exampleSamples,
  sampleMeta = exampleMeta,
  atlas = HumanCellTypeMethAtlas,
  IDs = "CpGs", K = 100, tissueSpecCpGs = TRUE)
```

```
## CELL TYPES IN EXTENDED ATLAS:
## example_cell_type
## Monocytes_EPIC
## B.cells_EPIC
## CD4T.cells_EPIC
## NK.cells_EPIC
## CD8T.cells_EPIC
## Neutrophils_EPIC
## Erythrocyte_progenitors
## Adipocytes
## Cortical_neurons
## Hepatocytes
## Lung_cells
## Pancreatic_beta_cells
## Pancreatic_acinar_cells
## Pancreatic_duct_cells
## Vascular_endothelial_cells
## Colon_epithelial_cells
## Left_atrium
## Bladder
## Breast
## Head_and_neck_larynx
## Kidney
## Prostate
## Thyroid
## Upper_GI
## Uterus_cervix
```

```
print(head(signatures[[2]]))
```

```
## $hyper
## cg08169020 cg26955540 cg25170017 cg12827637 cg15838173 cg04858631 cg19442545
## 0.22976392 0.16815565 0.16470045 0.16033923 0.14629499 0.14519425 0.14186253
## cg10560079 cg00982136 cg26460530 cg22017733 cg13677741 cg09642825 cg01424562
## 0.13830036 0.13480894 0.12828571 0.12734828 0.12339214 0.12212957 0.12181311
## cg24082121 cg15376996 cg14789659 cg06340704 cg19300307 cg11895835 cg14785464
## 0.12172120 0.11848056 0.11564105 0.11459739 0.11445116 0.11443580 0.11433531
## cg12474798 cg18856478 cg27189395 cg26033520 cg05507654 cg25913761 cg24275356
## 0.11422905 0.11400394 0.11399042 0.11387529 0.11257589 0.11151931 0.11143426
## cg05056497 cg00936790 cg20684110 cg08474651 cg05258935 cg08857351 cg23220823
## 0.11132351 0.11121582 0.11111512 0.11110692 0.11108929 0.11089921 0.11067362
## cg06167719 cg27395200 cg23247274 cg10509607 cg22897141 cg14855367 cg03254916
## 0.11052547 0.11023815 0.11022589 0.11004936 0.10928832 0.10905426 0.10889707
## cg22879098 cg09267773 cg08425810 cg26757820 cg10361922 cg04913246 cg08063160
## 0.10844309 0.10840374 0.10799468 0.10767923 0.10766684 0.10761764 0.10754506
## cg26953232 cg16416715 cg03711944 cg02962602 cg08257293 cg26047334 cg14057303
## 0.10744006 0.10733354 0.10731773 0.10730516 0.10717471 0.10706990 0.10692556
## cg27388962 cg08832851 cg25158622 cg11975790 cg14845962 cg08367326 cg16127573
## 0.10677857 0.10637535 0.10611620 0.10544097 0.10465157 0.10444712 0.10433130
## cg05043794 cg15014975 cg16278496 cg27312961 cg04055490 cg22138735 cg18675610
## 0.10417146 0.10405907 0.10404948 0.10364299 0.10332897 0.10332149 0.10294149
## cg09577804 cg08846870 cg19331221 cg03063309 cg17847861 cg07865091 cg16402452
## 0.10291439 0.10282237 0.10260259 0.10213251 0.10201251 0.10200538 0.10158619
## cg24591770 cg11532431 cg10661769 cg02297709 cg00769843 cg06398251 cg04462378
## 0.10156157 0.10145741 0.10137156 0.10129259 0.10111459 0.10101429 0.10071804
## cg21181453 cg06889535 cg11025609 cg01377358 cg13638257 cg07218880 cg15185986
## 0.10071571 0.10032920 0.10031604 0.10025822 0.10016467 0.10007930 0.09991422
## cg01726273 cg07438103 cg15575375 cg16829306 cg08659179 cg16017089 cg16988611
## 0.09990700 0.09975406 0.09973156 0.09964999 0.09947387 0.09931086 0.09930403
## cg16306706 cg20074395
## 0.09918485 0.09907415
##
## $hypo
## cg03663120 cg20942286 cg03963853 cg03126713 cg24788483 cg00828556 cg11186858
##  0.3748184  0.2968653  0.2756572  0.2707669  0.2702883  0.2688623  0.2655537
## cg05612654 cg13931640 cg22528270 cg15310871 cg15871206 cg13500029 cg10480329
##  0.2645588  0.2640592  0.2623621  0.2594756  0.2593717  0.2581766  0.2496936
## cg11231069 cg12655112 cg03549146 cg05923857 cg12458039 cg20610950 cg07737292
##  0.2486399  0.2413471  0.2392287  0.2379140  0.2356702  0.2338536  0.2330758
## cg10456459 cg03313271 cg06988336 cg06517984 cg23952578 cg16636767 cg27334271
##  0.2281586  0.2234442  0.2212834  0.2143253  0.2134724  0.2131513  0.2112561
## cg14976569 cg06297318 cg11597902 cg04851465 cg18990407 cg11327657 cg22259797
##  0.2109376  0.2105989  0.2104191  0.2100169  0.2086467  0.2080934  0.2079668
## cg15633603 cg08425796 cg13403369 cg06373940 cg04354689 cg22185977 cg09322573
##  0.2078026  0.2059298  0.2050875  0.2033139  0.2028430  0.2018648  0.2014103
## cg06125903 cg20107506 cg07033722 cg10718056 cg01879591 cg25517015 cg12866960
##  0.2013245  0.2011970  0.2002839  0.2000314  0.1996943  0.1988826  0.1984443
## cg27366072 cg26538782 cg03310874 cg02796279 cg13093111 cg19502671 cg08538581
##  0.1978556  0.1975027  0.1967210  0.1949899  0.1949124  0.1947517  0.1939747
## cg06978145 cg20429104 cg10967114 cg23403750 cg26783127 cg19380303 cg06721411
##  0.1936430  0.1933242  0.1921721  0.1921620  0.1921088  0.1921086  0.1920408
## cg26923863 cg11153071 cg26305504 cg01024962 cg23755933 cg20966357 cg05445326
##  0.1912692  0.1910378  0.1910186  0.1907187  0.1907120  0.1901307  0.1901265
## cg06585734 cg12555086 cg04664897 cg07918933 cg04217515 cg11802666 cg27340480
##  0.1900814  0.1900699  0.1891814  0.1888667  0.1885464  0.1884098  0.1882676
## cg18835472 cg25596405 cg04836151 cg23334433 cg02244028 cg26298914 cg24250902
##  0.1881477  0.1878478  0.1877900  0.1877093  0.1875868  0.1873966  0.1873011
## cg00009088 cg26889953 cg04586126 cg17117981 cg08400494 cg13980609 cg14189391
##  0.1871801  0.1867145  0.1864936  0.1864299  0.1857244  0.1853924  0.1852855
## cg08428868 cg17086773 cg15288326 cg22875823 cg22662844 cg07417146 cg22666015
##  0.1851617  0.1847544  0.1847348  0.1847197  0.1836755  0.1828791  0.1826590
## cg00235484 cg01622606
##  0.1824586  0.1812738
```

## 4.3 Constructing tissue specific DMPs

Alternatively, users can set *tissueSpecDMPs* as **TRUE** to obtain tissue based
DMPs by using the reference atlas. Here, we used simulated samples since we
don’t have tissue specific samples. Note that both *tissueSpecCpGs* and *tissueSpecDMPs*
can’t be *TRUE* at the same time.

```
data("HumanCellTypeMethAtlas")
exampleSamples <- simulateCellMix(1,reference = HumanCellTypeMethAtlas)$simulated
exampleMeta <- data.table("Experiment_accession" = "example_sample",
                          "Biosample_term_name" = "example_cell_type")
colnames(exampleSamples) <- c("CpGs", "example_sample")
colnames(HumanCellTypeMethAtlas)[1] <- c("CpGs")

signatures <- findSignatures(
  samples = exampleSamples,
  sampleMeta = exampleMeta,
  atlas = HumanCellTypeMethAtlas,
  IDs = "CpGs", tissueSpecDMPs = TRUE)
```

```
## CELL TYPES IN EXTENDED ATLAS:
## example_cell_type
## Monocytes_EPIC
## B.cells_EPIC
## CD4T.cells_EPIC
## NK.cells_EPIC
## CD8T.cells_EPIC
## Neutrophils_EPIC
## Erythrocyte_progenitors
## Adipocytes
## Cortical_neurons
## Hepatocytes
## Lung_cells
## Pancreatic_beta_cells
## Pancreatic_acinar_cells
## Pancreatic_duct_cells
## Vascular_endothelial_cells
## Colon_epithelial_cells
## Left_atrium
## Bladder
## Breast
## Head_and_neck_larynx
## Kidney
## Prostate
## Thyroid
## Upper_GI
## Uterus_cervix
```

```
print(head(signatures[[2]]))
```

```
##            intercept        f         pval         qval
## cg10480329 -3.287511 216.5808 1.643248e-13 9.905499e-10
## cg06297318 -3.496336 181.1808 1.119520e-12 3.374234e-09
## cg18835472 -3.350244 155.5107 5.615444e-12 1.128330e-08
## cg15633603 -1.496293 146.2749 1.062494e-11 1.296475e-08
## cg05923857 -3.515739 146.1051 1.075377e-11 1.296475e-08
## cg27366072 -2.858145 142.3335 1.409777e-11 1.416356e-08
```

# 5 Example Workflow For RNA Sequencing Data

It is possible to use RNA-seq data for deconvolution via **deconvR** package.
Beware that you have to set `IDs` column that contains `Gene names` to run
**deconvR** functions. Therefore you can simulate bulk RNA-seq data via
`simulateCellMix` and, extend RNA-seq reference atlas via `findSignatures`.

# 6 sessionInfo

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
## [1] parallel  stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] dplyr_1.1.4       doParallel_1.0.17 iterators_1.0.14  foreach_1.5.2
## [5] deconvR_1.16.0    data.table_1.17.8 knitr_1.50        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               BiocIO_1.20.0
##   [3] bitops_1.0-9                tibble_3.3.0
##   [5] R.oo_1.27.1                 preprocessCore_1.72.0
##   [7] XML_3.99-0.19               lifecycle_1.0.4
##   [9] Rdpack_2.6.4                lattice_0.22-7
##  [11] MASS_7.3-65                 base64_2.0.2
##  [13] scrime_1.3.5                magrittr_2.0.4
##  [15] minfi_1.56.0                limma_3.66.0
##  [17] sass_0.4.10                 rmarkdown_2.30
##  [19] jquerylib_0.1.4             yaml_2.3.10
##  [21] robslopes_1.1.3             doRNG_1.8.6.2
##  [23] askpass_1.2.1               DBI_1.2.3
##  [25] minqa_1.2.8                 RColorBrewer_1.1-3
##  [27] abind_1.4-8                 quadprog_1.5-8
##  [29] GenomicRanges_1.62.0        purrr_1.1.0
##  [31] R.utils_2.13.0              BiocGenerics_0.56.0
##  [33] RCurl_1.98-1.17             IRanges_2.44.0
##  [35] S4Vectors_0.48.0            rentrez_1.2.4
##  [37] genefilter_1.92.0           annotate_1.88.0
##  [39] DelayedMatrixStats_1.32.0   codetools_0.2-20
##  [41] DelayedArray_0.36.0         xml2_1.4.1
##  [43] tidyselect_1.2.1            farver_2.1.2
##  [45] lme4_1.1-37                 beanplot_1.3.1
##  [47] matrixStats_1.5.0           stats4_4.5.1
##  [49] illuminaio_0.52.0           Seqinfo_1.0.0
##  [51] GenomicAlignments_1.46.0    jsonlite_2.0.0
##  [53] multtest_2.66.0             e1071_1.7-16
##  [55] survival_3.8-3              bbmle_1.0.25.1
##  [57] tools_4.5.1                 rsq_2.7
##  [59] Rcpp_1.1.0                  glue_1.8.0
##  [61] SparseArray_1.10.0          xfun_0.53
##  [63] qvalue_2.42.0               MatrixGenerics_1.22.0
##  [65] HDF5Array_1.38.0            numDeriv_2016.8-1.1
##  [67] BiocManager_1.30.26         fastmap_1.2.0
##  [69] boot_1.3-32                 rhdf5filters_1.22.0
##  [71] openssl_2.3.4               digest_0.6.37
##  [73] R6_2.6.1                    gtools_3.9.5
##  [75] dichromat_2.0-0.1           RSQLite_2.4.3
##  [77] cigarillo_1.0.0             R.methodsS3_1.8.2
##  [79] h5mread_1.2.0               tidyr_1.3.1
##  [81] generics_0.1.4              rtracklayer_1.70.0
##  [83] class_7.3-23                httr_1.4.7
##  [85] S4Arrays_1.10.0             pkgconfig_2.0.3
##  [87] gtable_0.3.6                blob_1.2.4
##  [89] S7_0.2.0                    siggenes_1.84.0
##  [91] XVector_0.50.0              htmltools_0.5.8.1
##  [93] bookdown_0.45               scales_1.4.0
##  [95] Biobase_2.70.0              png_0.1-8
##  [97] reformulas_0.4.2            deming_1.4-1
##  [99] tzdb_0.5.0                  reshape2_1.4.4
## [101] rjson_0.2.23                nloptr_2.2.1
## [103] coda_0.19-4.1               nlme_3.1-168
## [105] curl_7.0.0                  bdsmatrix_1.3-7
## [107] bumphunter_1.52.0           proxy_0.4-27
## [109] cachem_1.1.0                rhdf5_2.54.0
## [111] stringr_1.5.2               AnnotationDbi_1.72.0
## [113] restfulr_0.0.16             GEOquery_2.78.0
## [115] pillar_1.11.1               grid_4.5.1
## [117] reshape_0.8.10              vctrs_0.6.5
## [119] Deriv_4.2.0                 xtable_1.8-4
## [121] evaluate_1.0.5              readr_2.1.5
## [123] GenomicFeatures_1.62.0      mvtnorm_1.3-3
## [125] cli_3.6.5                   locfit_1.5-9.12
## [127] compiler_4.5.1              Rsamtools_2.26.0
## [129] rlang_1.1.6                 crayon_1.5.3
## [131] rngtools_1.5.2              nor1mix_1.3-3
## [133] mclust_6.1.1                emdbook_1.3.14
## [135] plyr_1.8.9                  stringi_1.8.7
## [137] mcr_1.3.3.1                 BiocParallel_1.44.0
## [139] nnls_1.6                    assertthat_0.2.1
## [141] Biostrings_2.78.0           Matrix_1.7-4
## [143] hms_1.1.4                   sparseMatrixStats_1.22.0
## [145] bit64_4.6.0-1               ggplot2_4.0.0
## [147] Rhdf5lib_1.32.0             KEGGREST_1.50.0
## [149] methylKit_1.36.0            statmod_1.5.1
## [151] SummarizedExperiment_1.40.0 fastseg_1.56.0
## [153] rbibutils_2.3               memoise_2.0.1
## [155] bslib_0.9.0                 bit_4.6.0
```

```
stopCluster(cl)
```