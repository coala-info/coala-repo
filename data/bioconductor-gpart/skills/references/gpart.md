# How to use gpart

#### Sunah Kim

#### 1 April 2019

* [1 Introduction](#introduction)
* [2 Running gpart](#running-gpart)
  + [2.1 Installation](#installation)
  + [2.2 Input data for gpart](#input-data-for-gpart)
  + [2.3 Functions](#functions)
    - [2.3.1 CLQD function.](#clqd-function.)
      * [2.3.1.1 Examples](#examples)
      * [2.3.1.2 Values](#values)
      * [2.3.1.3 Details](#details)
    - [2.3.2 BigLD function.](#bigld-function.)
      * [2.3.2.1 Examples](#examples-1)
      * [2.3.2.2 Values](#values-1)
      * [2.3.2.3 Details](#details-1)
    - [2.3.3 GPART function](#gpart-function)
      * [2.3.3.1 Examples](#examples-2)
      * [2.3.3.2 Values](#values-2)
      * [2.3.3.3 Details](#details-2)
    - [2.3.4 LDblockHeatmap](#ldblockheatmap)
    - [2.3.5 convert2GRange](#convert2grange)
* [3 References](#references)

# 1 Introduction

In this package **“gpart”**, we provide a new SNP sequence partitioning method which partitions the whole SNP sequence based on not only LD block structures but also gene location information. The LD block construction for GPART is performed using Big-LD algorithm, with additional improvement from previous version reported in Kim et al.(2017). We also add a visualization tool to show the LD heatmap with the information of LD block boundaries and gene locations in the package.

**gpart** including 5 functions as follows.

* CLQD
* BigLD
* GPART
* LDblockHeatmap
* convert2GRange

# 2 Running gpart

## 2.1 Installation

Download and install the most current of “gpart”.

```
library(gpart)
```

## 2.2 Input data for gpart

To run the `CLQD` and `BigLD` function, you need two kind of input data, additive genotype data in matrix or data.frame (`geno`) and SNP information data(`SNPinfo`). Each column of `geno` includes the additive genotypes of individuls for each SNP, and each rwo of `SNPinfo` includes the chromosome name, rsID and bp of each SNP. The example data contains 286 individuals in EAS population in 1000 Genomes phase 1 data of chr21:16040232-16835352 (4000 SNPs).

```
data(geno)
data(SNPinfo)
```

```
geno[1:5, 1:5]
```

```
##   rs59504523 rs193065234 rs117862161 rs185637933 rs149273822
## 1          1           0           0           0           0
## 2          1           0           0           0           0
## 3          0           0           0           0           0
## 4          0           0           0           0           0
## 5          1           0           0           0           0
```

```
head(SNPinfo)
```

```
##   chrN        rsID       bp
## 1   21  rs59504523 16040232
## 2   21 rs193065234 16040492
## 3   21 rs117862161 16040674
## 4   21 rs185637933 16040851
## 5   21 rs149273822 16040964
## 6   21 rs185891489 16040979
```

## 2.3 Functions

### 2.3.1 CLQD function.

CLQD is an algorithm for clustering the SNPs into LD bins which are high-correlated SNP groups.

#### 2.3.1.1 Examples

```
clq1 = CLQD(geno[, 1:300], SNPinfo[1:300,])
```

#### 2.3.1.2 Values

CLQD returns a vector of bin numbers of SNPs. `NA` means that the corresponding SNP is a singleton, i.e. that SNP is an LD bin of size 1.

```
# CLQ results for 300 SNPs
head(clq1, n = 20)
```

```
##  [1] 22 NA 41 35 31 NA 38 NA 45 39 48 22 NA 22 NA 28 46 NA NA  8
```

```
table(clq1)
```

```
## clq1
##  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
##  2  2 44  3 44 10  2  2  2  3  5  5  6  4  3  2 11  3  2  7  8  3  2  2  4
## 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
##  2  3  2  2  4  2  2  4  3  2  4  2  2  3  2  2  2  2  2  2  2  2  2
```

```
# n of singletons
sum(is.na(clq1))
```

```
## [1] 64
```

#### 2.3.1.3 Details

```
CLQD(geno[, 1:500], SNPinfo[1:500,], LD = "Dprime")
```

The algorithm first constructs a graph in which the vertices are SNPs and each edge is an unordered pair of two SNPs. Each edge weight is given by LD value between two SNPs. CLQD uses \(r^2\) or D’ as the LD measurement. If you want to measure \(r^2\), set `LD = "r2"`(default), otherwise set `LD = "Dprime"`. When `LD = "r2"`, we have to specify a threshold for \(|r|\) by using the parameter `CLQcut`. The default is `CLQcut = 0.5`. For the D’, we define valid edges following definition of ‘strong LD’ suggested by Gabriel et al., (2002).

```
CLQD(geno[, 1:500], SNPinfo[1:500,], CLQcut = 0.7, hrstType = "fast",
     CLQmode = "maximal")
```

CLQ algorithm first detects maximal cliques in the constructed graph and then takes cliques which include SNPs not yet selected as LD bins greedily. There are two clique selection methods. If you want to give a priority to a clique of larger size, set as `CLQmode = "maximal"`, or if you want to give a priority to a cluster of denser LD bins (that is, the average distance of SNPs in a bin is smaller), set as `CLQmode = "density"`(default).

For the worst case, memory and time to listing all maximal cliques could be exponentially increased. Although, we can find all maximal cliques in reasonable time and memory usage for the most graphs corresponding to the LD structures. However, there are SNP sequence regions in which the time and memory usage for detecting maximal cliques extremely increasing, and we suggested heuristic algorithm for these regions. There are two kind of heuristic algorithm, “fast” and “near-nonhrst”(default). You can choose which algorithm to be used by setting the option `hrstType` such as `hrstType = "fast"` or `hrstType = "near-nonhrst"`. “fast” algorithm needs less memory usage and time than the “near-nonhrst” algorithm. The “near-nonhrst” algorithm needs more memory and time than “fast” algorithm, but it returns the results similar to results obtained by non-heuristic algorithm. Adopting the “near-nonhrst” algorithm should specify a heuristic parameter `hrstParam` that specifies how similar to the non-heuristic result. Entering a high value produces results similar to non-heuristic results. It is recommended to set at least 150, and the default value is 200. To use the non-heuristic algorithm, set as `hrstType = "nonhrst"`.

If the distance of two consecutive SNPs in a clique is too far, we can divide the clique into two cliques. The parameter for the threshold is `clstgap` and the default is 40000(bp).

### 2.3.2 BigLD function.

Big-LD is an algorithm to construct LD blocks using the interval graph modeling. The detailed algorithm can be found in Kim et al.(2017). Big-LD have several distinctive features. Since the Big-LD algorithm designed based on the graph modeling, large and mosaic pattern of LD blocks which allow the “holes” can be detected by the algorithm. Moreover, the boundaries of LD blocks identified by Big-LD tend to agree better with the recombination hotspots than the above mentioned methods. It also was shown that the LD block boundaries found by this algorithm are more invariant for the changes in the marker density compared to existing methods. For the vast number of SNPs, execution of the algorithm was completed within a reasonable time.

#### 2.3.2.1 Examples

```
# Use the options `geno` and `SNPinfo` to input additive genotype data and SNP information data respectively.
# use r2 measure (default)
res1 = BigLD(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,])
```

```
## working chromosome name: 21
```

```
## remove SNPs with MAF < 0.05
```

```
## Number of SNPs after prunning SNPs with MAF< 0.05 : 501
```

```
## start to split the whole sequence into sub-task regions
```

```
## there is only one sub-region!
```

```
## 2019-04-01 22:05:10 | chr21:16040232-16196907 | sub-region: 1/1
```

```
## CLQ done!
constructLDblock done!
```

```
##
## BigLD done!
```

```
#use D' measure
res1_dp = BigLD(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,]
                ,LD = "Dprime")
```

#### 2.3.2.2 Values

BigLD returns a data frame which contains 7 information of each block (chromosome name, indices of the first SNP and last SNP, rsID of the first SNP and last SNP, bp of the first SNP and last SNP)

```
head(res1)
```

```
##   chr start.index end.index start.rsID   end.rsID start.bp   end.bp
## 1  21           1        14 rs59504523  rs2822825 16040232 16042876
## 2  21          20        23  rs9808806 rs13052089 16043928 16044788
## 3  21          26        93  rs2822826  rs2822833 16045615 16057487
## 4  21          95       115   rs988831   rs960479 16057936 16060592
## 5  21         125       132   rs467116 rs12626958 16062725 16063744
## 6  21         133       147   rs458700   rs458705 16064006 16065336
```

#### 2.3.2.3 Details

```
# When you have to input files directly, use the parameter `genofile` (and `SNPinfofile`) instead of `geno` and `SNPinfo`.
res2 = BigLD(genofile = "geno.vcf")
res3 = BigLD(genofile = "geno.ped", SNPinfofile = "geno.map")
# change LD measure, hrstParam
res4 = BigLD(geno = geno, SNPinfo = SNPinfo, LD = "Dprime", hrstParam = 150)
```

The input consists of genotype and SNP information. The function also can directly load the data from the files of PLINK format or VCF (.ped, .map, .traw, .raw, .vcf). **If the file sizes (.ped, .traw, .raw, .vcf) are larger than 10Gb, we strongly recommand to use `geno` and `SNPinfo` options after reformatting your data instead of loading large files file directly**. As with `CLQD` function, you can choose an LD measure to use (`LD`), r2 threshold (`CLQcut`), heuristic algorithm (`hrstType`, `hrstParam`), CLQ methods (`CLQmode`), threshold for distance of consecutive SNPs in a clique (`clstgap`).

```
res5 = BigLD(geno = geno, SNPinfo = SNPinfo, MAFcut = 0.1, appendRare = TRUE)
```

`BigLD` algorithm construct LD blocks using the common variants after filtering rare variants by the option `MAFcut`(default 0.05). To include a rare variant in the LD block results, add the `appendRare = TRUE` option. Rare variants with maf \(\leq\) `MAFcut` could be appended to a proper LD block already constructed by common variants.

We can force specified SNP to be the last SNP in a block using `cutByForce` option.

```
cutlist = rbind(c(21, "rs440600", 16051956), c(21, "rs9979041", 16055738))
res6 = BigLD(geno = geno[, 1:100], SNPinfo = SNPinfo[1:100,], cutByForce = cutlist)
```

```
print(cutlist)
```

```
##      [,1] [,2]        [,3]
## [1,] "21" "rs440600"  "16051956"
## [2,] "21" "rs9979041" "16055738"
```

```
head(res6)
```

```
##   chr start.index end.index start.rsID   end.rsID start.bp   end.bp
## 1  21           1        93 rs59504523  rs2822833 16040232 16057487
## 2  21          95       100   rs988831 rs59861729 16057936 16058409
```

If you want to obtain BigLD results of some specific region of an input data, you can speicify the region to calculate by using the options `chrN`, `startbp`, and `endbp`.

```
res7 = BigLD(geno = geno, SNPinfo = SNPinfo, startbp = 16058400, endbp = 16076500)
```

```
res7
```

```
##   chr start.index end.index start.rsID   end.rsID start.bp   end.bp
## 1  21           1        16 rs59861729   rs960479 16058409 16060592
## 2  21          26        99   rs467116 rs13051994 16062725 16076420
```

### 2.3.3 GPART function

GPART is a SNP sequence partitioning algorithm based on the Big-LD results. Big-LD algorithm might allow quite long LD blocks or very small LD blocks, also do not consider the gene region information during the LD block construction procedures. GPART could partition SNP sequences considering gene region information by merging the overlapping gene regions and LD blocks. To partition the SNP sequences into blocks satisfying the predefined size threshold, GPART split the big blocks or merging the small consecutive blocks.

For the function `GPART`, you must input gene information data.

```
data(geneinfo)
head(geneinfo)
```

```
##       genename chrN start.bp   end.bp
## 40 IGHV1OR21-1   21 10862622 10863067
## 51        TPTE   21 10906201 11029719
## 60  AL050302.1   21 14741931 14745386
## 61       POTED   21 14982498 15013906
## 62  AL050303.1   21 15051621 15053459
## 63        LIPI   21 15481134 15583166
```

The GPART functions uses BigLD results as an initial clustering results. Therefore you need to input the BigLD results using the option `BigLDresult`. In other ways, you can make that the GPART function automatically run the `BigLD` before the main GPART algorithm (set `BigLDresult=NULL`, default). For this case, you can set parameters (`CLQmode`, `CLQcut`) for `BigLD` additionally.

#### 2.3.3.1 Examples

```
# gene based GPART using the pre-calculated BigLD result 'res1'
# The input data of GPART must be the same as the input data used to obtain 'res1'
# note that the `res1` is obtained by using the first 1000 SNPs in geno.
# default minsize = 4, maxsize = 50
Gres0 = GPART(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
              geneinfo = geneinfo,BigLDresult = res1,
              minsize = 4, maxsize = 50)
```

```
## Number of SNPs after prunning SNPs with MAF< 0.05 : 501
```

```
## Use the inputted BigLD result
```

```
## GPART algorithm: geneBased
```

```
## working chromosome name: 21
```

```
## chr 21 done!
```

#### 2.3.3.2 Values

`GPART()` returns data frame which contains 9 information of each partition (chromosome, indices of the first SNP and last SNP in the inputted data, rsIDs of the first SNP and last SNP, basepair positions of the first SNP and last SNP, blocksize, Name of a block)

```
# results of gene-based GPART
head(Gres0)
```

```
##   chr start.index end.index start.rsID   end.rsID start.bp   end.bp
## 1  21           1         5 rs59504523 rs13052089 16040232 16044788
## 2  21           6        43  rs2822826  rs2822833 16045615 16057487
## 3  21          44        53   rs988831   rs960479 16057936 16060592
## 4  21          54        57   rs467116 rs12626958 16062725 16063744
## 5  21          58        68   rs458700   rs458705 16064006 16065336
## 6  21          69       116   rs460403  rs2822849 16066007 16078541
##   blocksize                              Name
## 1         5 inter-AF165138.7:AF127936.3-part1
## 2        38 inter-AF165138.7:AF127936.3-part2
## 3        10 inter-AF165138.7:AF127936.3-part3
## 4         4 inter-AF165138.7:AF127936.3-part4
## 5        11 inter-AF165138.7:AF127936.3-part5
## 6        48 inter-AF165138.7:AF127936.3-part6
```

< Naming Examples >

* before-Gene1-part1 : 1st block located before 1st gene (No overlapping LD block with the Gene1).
* before-Gene1-part2 : 2nd block located at before 1st gene region.
* Gene2/Gene3-part1 : 1st block overlapping Gene2/Gene3 region (Gene2 and Gene3 are overlaped).
* Gene4-Gene5-part1 : 1st block which have a common LD block overlapping both Gene4 and Gene5 gene regions.
* Gene4-Gene5-part2 : 2nd block which have a common LD block overlapping both Gene4 and Gene5 gene regions.
* inter-Gene5:Gene6-part1 : 1st block located at the intergenic region between Gene5 and Gene6
* Gene6-part1 : 1st block overlapping Gene6 region
* after-Gene100-part1 : 1st block located at the region after the lastly located Gene100

#### 2.3.3.3 Details

As with `BigLD`, GPART can run the algorithm based on LD measure, D’ by setting `LD = "Dprime"`.

```
# gene based model
Gres1 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo)
# gene based model using LD measure Dprime
Gres2 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo, LD = "Dprime")
```

There are three GPART algorithms:

1. “Gene based”. first merge the overlapping LD blocks and gene regions, split the big LD blocks and merged gene-block regions, and then merge small consecutive blocks such as singletons to satisfy the pre-defined min-size threshold (set `GPARTmode="geneBased"`, default).
2. “LDblock based only”. This algorithm does not use any gene information. It partitions the SNP sequence by splitting or merging the LD blocks to satisfy the given size threshold (`GPARTmode="LDblockBased"`, and `Blockbasedmode="onlyBlocks"`, default for LD block based methods).
3. “LDblock based - use gene info”. This use gene information only for the merging consecutive small blocks procedure. If consecutive small blocks of which size are less than threshold do overlap with gene region, we merge them as large as possible (at most max-size threshold), otherwise, we merge them as small as possible. (set `GPARTmode="LDblockBased"`, and `Blockbasedmode="useGeneRegions"`)

```
# LD block based - use only LD block information
Gres3 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
              GPARTmode = "LDblockBased", Blockbasedmode = "onlyBlocks")
# LD block based - use gene information to merge singletons
Gres4 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
              GPARTmode = "LDblockBased", Blockbasedmode = "useGeneRegions")
```

You can load gene information from a text file using the option `geneinfofile`.

```
# you can load text file containing gene information.
Gres5 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfofile = "geneinfo.txt")
```

You can also load the gene information data from “Ensembl” or “UCSC” database via internal sub-function of `GPART`. You need to set the database and assembly via the options of function, `geneDB` for database and `assembly` for assembly. Default for `geneDB` is `"ensembl"` and default for `assembly` is `"GRCh38"`.

When you use “ensembl” data, you can set the version of the data by using the option `ensbversion`. By default, we use “hgnc symbol” for the gene name. You can change it by the option `geneid` depending on the gene DB you choose. If there are more than 2 gene information with the same gene name, we union the regions with the same name.

```
# use `geneDB` option instead of `geneinfo` or `geneinfofile`
# default geneDB is "ensembl" and  default assembly is "GRCh38"
Gres6 = GPART(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
              BigLDresult = res1, geneDB = "ensembl", assembly = "GRCh37")
Gres7 = GPART(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
              BigLDresult = res1, geneDB = "ucsc", assembly = "GRCh37" )
```

### 2.3.4 LDblockHeatmap

LDblockHeatmap function visualizes the BigLD (or GPART) results. The function can draw

* LD heatmap of the data (up to 20000 SNPs).
* Block boundaries obtained by BigLD (or GPART). (optional)
* Information of first and last SNP in largest LD blocks.
* LD bins obtained by CLQ algorithm (when the total number of SNPs <=200). (optional)
* physical location of LD blocks.
* gene information in the region of data. (optional)

If you want to show the Big-LD (or GPART) results, you need to input the Big-LD (or GPART) results. Otherwise the function first executes the Big-LD (or GPART) algorithm and then draw the figures with the obtained results as `blocktype` you specify.

Set the option `filename` and `res` to specify the file name and resolution of a plot respectively.

```
# First LDblockHeatmap calculate the LD block results using BigLD(), and then draw the LD heatmap, block boundaries and physical locations, and gene information
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo,geneinfo = geneinfo,
                filename = "heatmap_all", res = 150)
```

* heatmap\_all.png

In `geno`, there are 3340 SNPs with MAF>0.05. The “heatmap\_all.png” shows the LDheatmap and BigLD results of the 3340SNPs.

![](data:image/png;base64...)

```
# You can use the already obtained BigLD result using an option 'blockresult'.
# note that the `res1` is obtained by using the first 1000 SNPs in geno.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneinfo = geneinfo, blockresult = res1,
               filename = "heatmap1", res = 200)
# For the obtained result 'res1', you can plot the only part of the result.
LDblockHeatmap(geno = geno[,300:800], SNPinfo = SNPinfo[300:800,],
               geneinfo = geneinfo, blockresult = res1,
               filename = "heatmap1_part", res = 200)
# If there is no inputted Big-LD result,
# the function will calculate the BigLD result first and then draw the figure using the result.
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo,
               geneinfo = geneinfo, filename = "heatmap2")
# you can save the output in tiff file
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo,
               geneinfo = geneinfo, filename = "heatmap3", type = "tif")
```

To draw heatmap, there are three kind of LD measures

* r2 (`LD = "r2"`)
* D-prime (`LD = "Dprime"`)
* D-prime & strong LD definition (`LD = "Dp-str"`), suggested in Gabriel et al, (2002)

Set `LD = "Dprime"` if you want to draw heatmap using D’ measure. Set `LD = "Dp-str"` if you want to show only strong LD relations.

```
# the function first execute BigLD to obtain LDblock results, and then run GPART algorithm.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneinfo = geneinfo, LD = "Dprime",
               filename = "heatmap_Dp", res = 200)
# or you can use the Big-LD results already obtained.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneinfo = geneinfo, LD = "Dp-str"
               , filename = "heatmap_Dp-str", res = 200)
```

* heatmap\_Dp-str.png

![](data:image/png;base64...)

You can speicify the region by using options `chrN`, `startbp` and `endbp`. If the data includes more than two chromosome, you need to specify the chromosome name to draw by using `chrN`

```
# the function first execute BigLD to obtain LDblock results, and then run GPART algorithm.
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
               chrN = 21, startbp = 16000000, endbp = 16200000,
               filename = "heatmap_16mb-16.2mb")
```

The default block construction method is “Big-LD”. When `LDblockHeatmap` function automatically run the `BigLD`, you can additionally specify the parameters, `CLQmode`, `CLQcut`.

when you set as `LD = "Dprime"` or `LD = "Dp-str"`, the `BigLD` execute the algorithm using LD measure D-prime.

To draw the figures using the GPART results, you need to set the option `blocktype = "gpart"`. If you do not input GPART results via `blockresult`, `GPART` first will be executed and gene-based algorithm will be applied.

```
# using the obatined GPART results, draw figure.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneinfo = geneinfo, blockresult = Gres0,
               blocktype = "gpart", filename = "heatmap_gpart")
# or if you set the blocktype only, the function will execute the proper block construction algorithm.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneinfo = geneinfo, blocktype = "gpart",
               filename = "heatmap_gpart2")
```

As with `GPART`, you can use the options `geneinfofile`, `geneDB`, `assembly`, and `ensbversion`.

```
# Show gene region information obtained from "ensembl" DB in assembly GRCh38.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneDB = "ensembl", assembly = "GRCh37",
               filename = "heatmap_enb")
```

You also can choose to not show the gene region information by setting as `geneshow = FALSE`

```
# Do not show the gene region information.
LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
               geneshow = FALSE, filename = "heatmap_wogene")
```

To show LD bins obtained by CLQ algorithm (when the total number of SNPs <=200), use the option `CLQshow = TRUE`.

```
# using CLQshow = TRUE options to show LD bin results.
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
               CLQshow = TRUE, startbp = 16300000, endbp = 16350000,
               res=200, filename = "heatmap_clq")
```

```
## Number of SNPs after prunning SNPs with MAF< 0.05 : 1649
```

```
## working chromosome name: 21
```

```
## remove SNPs with MAF < 0.05
```

```
## Number of SNPs after prunning SNPs with MAF< 0.05 : 88
```

```
## start to split the whole sequence into sub-task regions
```

```
## there is only one sub-region!
```

```
## 2019-04-01 22:05:13 | chr21:16301803-16349907 | sub-region: 1/1
```

```
##
## BigLD done!
```

```
## Generating file....
```

```
## heatmap_clq.png
```

* heatmap\_clq.png

![](data:image/png;base64...) In the “heatmap\_clq.png”, there are 2 LD blocks. The first LD block contains 2 LD bins(colored by navy and blue), and the second LD block contains 7 LD bins. SNPs colored by the same color are strongly correlated, and pairwise |r| values are at least inputted `CLQcut` value. For the above figure, `CLQcut` was set to 0.5 by default.

You can choose not to draw block boundaries by using the option `onlyHeatmap = TRUE`. The function then ignores the entered block results or not pre-calculates the block results and draws pictures without block boundaries

```
# using "onlyHeatmap = TRUE"
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
               onlyHeatmap = TRUE, filename = "heatmap_no_bound", res = 150)
```

### 2.3.5 convert2GRange

You can convert an output of `BigLD` or `GPART` in data.frame format to a `GRanges` object.

```
BigLD_grange = convert2GRange(res1)
BigLD_grange
```

```
## GRanges object with 14 ranges and 2 metadata columns:
##        seqnames            ranges strand |  start_rsID    end_rsID
##           <Rle>         <IRanges>  <Rle> | <character> <character>
##    [1]       21 16040232-16042876      * |  rs59504523   rs2822825
##    [2]       21 16043928-16044788      * |   rs9808806  rs13052089
##    [3]       21 16045615-16057487      * |   rs2822826   rs2822833
##    [4]       21 16057936-16060592      * |    rs988831    rs960479
##    [5]       21 16062725-16063744      * |    rs467116  rs12626958
##    ...      ...               ...    ... .         ...         ...
##   [10]       21 16135896-16136181      * |   rs2822907   rs2403806
##   [11]       21 16137182-16139409      * |  rs11702007  rs79754834
##   [12]       21 16140376-16140490      * |   rs2822915   rs2822916
##   [13]       21 16140831-16140918      * |   rs9984409   rs4490276
##   [14]       21 16140970-16194790      * |  rs75671158   rs2822951
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# 3 References

* Gabriel, Stacey B., et al. “The structure of haplotype blocks in the human genome.” Science 296.5576 (2002): 2225-2229.
* Kim, Sun Ah, et al. “A new haplotype block detection method for dense genome sequencing data based on interval graph modeling of clusters of highly correlated SNPs.” Bioinformatics 34.3 (2017): 388-397.