# The BioImageBbs Datasets

Satoshi Kume\*

\*satoshi.kume.1984@gmail.com

#### 2025-10-30

#### Package

BioImageDbs, magick

**Last modified:** NA
**Compiled**: 2025-10-30 11:12:18.347524

# 1 Fetch Bioimage Datasets from ExperimentHub

The `BioImageDbs` package provides the metadata for bioimage datasets,
which is preprocessed as array format and saved in
*[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*.

# 2 ExperimentHub package

First we load/update the `ExperimentHub` resource.

```
library(ExperimentHub)
eh <- ExperimentHub()
```

# 3 Simaple query

We can retrieve only the BioImageDbs tibble files as follows.

```
qr <- query(eh, c("BioImageDbs"))
qr
```

```
## ExperimentHub with 73 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Satoshi Kume <satoshi.kume.1984@gmail.com>, CELL TRACKING C...
## # $species: Mus musculus, Homo sapiens, Rattus norvegicus, Drosophila melano...
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6874"]]'
##
##            title
##   EH6874 | EM_id0001_Brain_CA1_hippocampus_region_5dTensor.Rds
##   EH6875 | EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif
##   EH6876 | EM_id0002_Drosophila_brain_region_5dTensor.Rds
##   EH6877 | EM_id0002_Drosophila_brain_region_5dTensor_train_dataset.gif
##   EH6878 | LM_id0001_DIC_C2DH_HeLa_4dTensor.Rds
##   ...      ...
##   EH6942 | EM_id0009_MurineBMMC_All_512_4dTensor_dataset.gif
##   EH6943 | EM_id0010_HumanBlast_All_512_4dTensor.Rds
##   EH6944 | EM_id0010_HumanBlast_All_512_4dTensor_dataset.gif
##   EH6945 | EM_id0011_HumanJurkat_All_512_4dTensor.Rds
##   EH6946 | EM_id0011_HumanJurkat_All_512_4dTensor_dataset.gif
```

We can use the `$` symbol to access metadata such as the id and title.

```
#Show metadata (e.g. ah_id and title)
qr$ah_id
```

```
##  [1] "EH6874" "EH6875" "EH6876" "EH6877" "EH6878" "EH6879" "EH6880" "EH6881"
##  [9] "EH6882" "EH6883" "EH6884" "EH6885" "EH6886" "EH6887" "EH6888" "EH6889"
## [17] "EH6890" "EH6891" "EH6892" "EH6893" "EH6894" "EH6895" "EH6896" "EH6897"
## [25] "EH6898" "EH6899" "EH6900" "EH6901" "EH6902" "EH6903" "EH6904" "EH6905"
## [33] "EH6906" "EH6907" "EH6908" "EH6909" "EH6910" "EH6911" "EH6912" "EH6913"
## [41] "EH6914" "EH6915" "EH6916" "EH6917" "EH6918" "EH6919" "EH6920" "EH6921"
## [49] "EH6922" "EH6923" "EH6924" "EH6925" "EH6926" "EH6927" "EH6928" "EH6929"
## [57] "EH6930" "EH6931" "EH6932" "EH6933" "EH6934" "EH6935" "EH6936" "EH6937"
## [65] "EH6938" "EH6939" "EH6940" "EH6941" "EH6942" "EH6943" "EH6944" "EH6945"
## [73] "EH6946"
```

```
qr$title
```

```
##  [1] "EM_id0001_Brain_CA1_hippocampus_region_5dTensor.Rds"
##  [2] "EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif"
##  [3] "EM_id0002_Drosophila_brain_region_5dTensor.Rds"
##  [4] "EM_id0002_Drosophila_brain_region_5dTensor_train_dataset.gif"
##  [5] "LM_id0001_DIC_C2DH_HeLa_4dTensor.Rds"
##  [6] "LM_id0001_DIC_C2DH_HeLa_4dTensor_train_dataset.gif"
##  [7] "LM_id0001_DIC_C2DH_HeLa_4dTensor_Binary.Rds"
##  [8] "LM_id0001_DIC_C2DH_HeLa_4dTensor_Binary_train_dataset.gif"
##  [9] "LM_id0001_DIC_C2DH_HeLa_5dTensor.Rds"
## [10] "LM_id0002_PhC_C2DH_U373_4dTensor.Rds"
## [11] "LM_id0002_PhC_C2DH_U373_4dTensor_train_dataset.gif"
## [12] "LM_id0002_PhC_C2DH_U373_4dTensor_Binary.Rds"
## [13] "LM_id0002_PhC_C2DH_U373_4dTensor_Binary_train_dataset.gif"
## [14] "LM_id0002_PhC_C2DH_U373_5dTensor.Rds"
## [15] "LM_id0003_Fluo_N2DH_GOWT1_4dTensor.Rds"
## [16] "LM_id0003_Fluo_N2DH_GOWT1_4dTensor_train_dataset.gif"
## [17] "LM_id0003_Fluo_N2DH_GOWT1_4dTensor_Binary.Rds"
## [18] "LM_id0003_Fluo_N2DH_GOWT1_4dTensor_Binary_train_dataset.gif"
## [19] "LM_id0003_Fluo_N2DH_GOWT1_5dTensor.Rds"
## [20] "EM_id0003_J558L_4dTensor.Rds"
## [21] "EM_id0003_J558L_4dTensor_train_dataset.gif"
## [22] "EM_id0004_PrHudata_4dTensor.Rds"
## [23] "EM_id0004_PrHudata_4dTensor_train_dataset.gif"
## [24] "EM_id0005_Mouse_Kidney_2D_All_Mito_512_4dTensor.Rds"
## [25] "EM_id0005_Mouse_Kidney_2D_All_Mito_512_4dTensor_dataset.gif"
## [26] "EM_id0005_Mouse_Kidney_2D_All_Mito_1024_4dTensor.Rds"
## [27] "EM_id0005_Mouse_Kidney_2D_All_Mito_1024_4dTensor_dataset.gif"
## [28] "EM_id0005_Mouse_Kidney_2D_All_Nuc_1024_4dTensor.Rds"
## [29] "EM_id0005_Mouse_Kidney_2D_All_Nuc_1024_4dTensor_dataset.gif"
## [30] "EM_id0005_Mouse_Kidney_2D_WideEM_Mouse_Kidney_Fused_Img_126_190725cut_4dtensor.Rds"
## [31] "EM_id0006_Rat_Liver_2D_All_Mito_256_4dTensor.Rds"
## [32] "EM_id0006_Rat_Liver_2D_All_Mito_256_4dTensor_dataset.gif"
## [33] "EM_id0006_Rat_Liver_2D_All_Mito_512_4dTensor.Rds"
## [34] "EM_id0006_Rat_Liver_2D_All_Mito_512_4dTensor_dataset.gif"
## [35] "EM_id0006_Rat_Liver_2D_All_Mito_1024_4dTensor.Rds"
## [36] "EM_id0006_Rat_Liver_2D_All_Mito_1024_4dTensor_dataset.gif"
## [37] "EM_id0006_Rat_Liver_2D_All_Nuc_1024_4dTensor.Rds"
## [38] "EM_id0006_Rat_Liver_2D_All_Nuc_1024_4dTensor_dataset.gif"
## [39] "EM_id0006_Rat_Liver_2D_WideEM_Rat_Liver_NCMIR_001_160408_1_1185_4dtensor.Rds"
## [40] "EM_id0006_Rat_Liver_2D_WideEM_Rat_Liver_NCMIR_001_160408_1186_2370_4dtensor.Rds"
## [41] "EM_id0007_Mouse_Kidney_MultiScale_All_High_Gap_1024_4dTensor.Rds"
## [42] "EM_id0007_Mouse_Kidney_MultiScale_All_High_Gap_1024_4dTensor_dataset.gif"
## [43] "EM_id0007_Mouse_Kidney_MultiScale_All_High_Mito_1024_4dTensor.Rds"
## [44] "EM_id0007_Mouse_Kidney_MultiScale_All_High_Mito_1024_4dTensor_dataset.gif"
## [45] "EM_id0007_Mouse_Kidney_MultiScale_All_High_Nuc_1024_4dTensor.Rds"
## [46] "EM_id0007_Mouse_Kidney_MultiScale_All_High_Nuc_1024_4dTensor_dataset.gif"
## [47] "EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Fibroblast_1024_4dTensor.Rds"
## [48] "EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Fibroblast_1024_4dTensor_dataset.gif"
## [49] "EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Podocyte_1024_4dTensor.Rds"
## [50] "EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Podocyte_1024_4dTensor_dataset.gif"
## [51] "EM_id0007_Mouse_Kidney_MultiScale_All_Low_Uriniferous_Tubule_1024_4dTensor.Rds"
## [52] "EM_id0007_Mouse_Kidney_MultiScale_All_Low_Uriniferous_Tubule_1024_4dTensor_dataset.gif"
## [53] "EM_id0007_Mouse_Kidney_MultiScale_All_Low_Glomerulus_1024_4dTensor.Rds"
## [54] "EM_id0007_Mouse_Kidney_MultiScale_All_Low_Glomerulus_1024_4dTensor_dataset.gif"
## [55] "EM_id0008_Human_NB4_2D_All_Cel_512_4dTensor.Rds"
## [56] "EM_id0008_Human_NB4_2D_All_Cel_512_4dTensor_dataset.gif"
## [57] "EM_id0008_Human_NB4_2D_All_Mito_512_4dTensor.Rds"
## [58] "EM_id0008_Human_NB4_2D_All_Mito_512_4dTensor_dataset.gif"
## [59] "EM_id0008_Human_NB4_2D_All_Nuc_crop512_4dTensor.Rds"
## [60] "EM_id0008_Human_NB4_2D_All_Nuc_crop512_4dTensor_dataset.gif"
## [61] "EM_id0008_Human_NB4_2D_All_Nuc_512_4dTensor.Rds"
## [62] "EM_id0008_Human_NB4_2D_All_Nuc_512_4dTensor_dataset.gif"
## [63] "EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor.Rds"
## [64] "EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor_dataset.gif"
## [65] "EM_id0008_Human_NB4_2D_WideEM_NB4_097_01_4dtensor.Rds"
## [66] "EM_id0008_Human_NB4_2D_WideEM_NB4_097_02_4dtensor.Rds"
## [67] "EM_id0008_Human_NB4_2D_WideEM_NB4_127_4dtensor.Rds"
## [68] "EM_id0009_MurineBMMC_All_512_4dTensor.Rds"
## [69] "EM_id0009_MurineBMMC_All_512_4dTensor_dataset.gif"
## [70] "EM_id0010_HumanBlast_All_512_4dTensor.Rds"
## [71] "EM_id0010_HumanBlast_All_512_4dTensor_dataset.gif"
## [72] "EM_id0011_HumanJurkat_All_512_4dTensor.Rds"
## [73] "EM_id0011_HumanJurkat_All_512_4dTensor_dataset.gif"
```

# 4 About datasets

In this section, the query to retrieve each bioimage dataset will be introduced.

## 4.1 EM\_id0001: Mouse brain neurons (5D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0001"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: https://www.epfl.ch/labs/cvlab/data/data-em/
## # $species: Mus musculus
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6874"]]'
##
##            title
##   EH6874 | EM_id0001_Brain_CA1_hippocampus_region_5dTensor.Rds
##   EH6875 | EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
#Show animation
library(magick)
```

```
## Linking to ImageMagick 6.9.12.98
## Enabled features: fontconfig, freetype, fftw, heic, lcms, pango, raw, webp, x11
## Disabled features: cairo, ghostscript, rsvg
```

```
## Using 2 threads
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.2 EM\_id0002: Drosophila brain neurons (5D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0002"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: the ISBI 2012 Challenge dataset (https://academictorrents.c...
## # $species: Drosophila melanogaster
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6876"]]'
##
##            title
##   EH6876 | EM_id0002_Drosophila_brain_region_5dTensor.Rds
##   EH6877 | EM_id0002_Drosophila_brain_region_5dTensor_train_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
#Show animation
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.3 EM\_id0003: J558L cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0003"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Pattern Recognition and Image Processing, University of Fre...
## # $species: Mus musculus
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6893"]]'
##
##            title
##   EH6893 | EM_id0003_J558L_4dTensor.Rds
##   EH6894 | EM_id0003_J558L_4dTensor_train_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.4 EM\_id0004: primary human T cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0004"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Pattern Recognition and Image Processing, University of Fre...
## # $species: Homo sapiens
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6895"]]'
##
##            title
##   EH6895 | EM_id0004_PrHudata_4dTensor.Rds
##   EH6896 | EM_id0004_PrHudata_4dTensor_train_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.5 EM\_id0005: Mouse Kidney 2D imaging (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0005"))

##Show metadata
qr
```

```
## ExperimentHub with 7 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Satoshi Kume <satoshi.kume.1984@gmail.com>
## # $species: Mus musculus
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6897"]]'
##
##            title
##   EH6897 | EM_id0005_Mouse_Kidney_2D_All_Mito_512_4dTensor.Rds
##   EH6898 | EM_id0005_Mouse_Kidney_2D_All_Mito_512_4dTensor_dataset.gif
##   EH6899 | EM_id0005_Mouse_Kidney_2D_All_Mito_1024_4dTensor.Rds
##   EH6900 | EM_id0005_Mouse_Kidney_2D_All_Mito_1024_4dTensor_dataset.gif
##   EH6901 | EM_id0005_Mouse_Kidney_2D_All_Nuc_1024_4dTensor.Rds
##   EH6902 | EM_id0005_Mouse_Kidney_2D_All_Nuc_1024_4dTensor_dataset.gif
##   EH6903 | EM_id0005_Mouse_Kidney_2D_WideEM_Mouse_Kidney_Fused_Img_126_1907...
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.6 EM\_id0006: Rat Liver 2D imaging (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0006"))

##Show metadata
qr
```

```
## ExperimentHub with 10 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Satoshi Kume <satoshi.kume.1984@gmail.com>
## # $species: Rattus norvegicus
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6904"]]'
##
##            title
##   EH6904 | EM_id0006_Rat_Liver_2D_All_Mito_256_4dTensor.Rds
##   EH6905 | EM_id0006_Rat_Liver_2D_All_Mito_256_4dTensor_dataset.gif
##   EH6906 | EM_id0006_Rat_Liver_2D_All_Mito_512_4dTensor.Rds
##   EH6907 | EM_id0006_Rat_Liver_2D_All_Mito_512_4dTensor_dataset.gif
##   EH6908 | EM_id0006_Rat_Liver_2D_All_Mito_1024_4dTensor.Rds
##   EH6909 | EM_id0006_Rat_Liver_2D_All_Mito_1024_4dTensor_dataset.gif
##   EH6910 | EM_id0006_Rat_Liver_2D_All_Nuc_1024_4dTensor.Rds
##   EH6911 | EM_id0006_Rat_Liver_2D_All_Nuc_1024_4dTensor_dataset.gif
##   EH6912 | EM_id0006_Rat_Liver_2D_WideEM_Rat_Liver_NCMIR_001_160408_1_1185_...
##   EH6913 | EM_id0006_Rat_Liver_2D_WideEM_Rat_Liver_NCMIR_001_160408_1186_23...
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.7 EM\_id0007: Mouse Kidney MultiScale images (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0007"))

##Show metadata
qr
```

```
## ExperimentHub with 14 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Satoshi Kume <satoshi.kume.1984@gmail.com>
## # $species: Mus musculus
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6914"]]'
##
##            title
##   EH6914 | EM_id0007_Mouse_Kidney_MultiScale_All_High_Gap_1024_4dTensor.Rds
##   EH6915 | EM_id0007_Mouse_Kidney_MultiScale_All_High_Gap_1024_4dTensor_dat...
##   EH6916 | EM_id0007_Mouse_Kidney_MultiScale_All_High_Mito_1024_4dTensor.Rds
##   EH6917 | EM_id0007_Mouse_Kidney_MultiScale_All_High_Mito_1024_4dTensor_da...
##   EH6918 | EM_id0007_Mouse_Kidney_MultiScale_All_High_Nuc_1024_4dTensor.Rds
##   ...      ...
##   EH6923 | EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Podocyte_1024_4dTen...
##   EH6924 | EM_id0007_Mouse_Kidney_MultiScale_All_Low_Uriniferous_Tubule_102...
##   EH6925 | EM_id0007_Mouse_Kidney_MultiScale_All_Low_Uriniferous_Tubule_102...
##   EH6926 | EM_id0007_Mouse_Kidney_MultiScale_All_Low_Glomerulus_1024_4dTens...
##   EH6927 | EM_id0007_Mouse_Kidney_MultiScale_All_Low_Glomerulus_1024_4dTens...
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.8 EM\_id0008: Human NB4 cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0008"))

##Show metadata
qr
```

```
## ExperimentHub with 13 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Satoshi Kume <satoshi.kume.1984@gmail.com>
## # $species: Homo sapiens
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6928"]]'
##
##            title
##   EH6928 | EM_id0008_Human_NB4_2D_All_Cel_512_4dTensor.Rds
##   EH6929 | EM_id0008_Human_NB4_2D_All_Cel_512_4dTensor_dataset.gif
##   EH6930 | EM_id0008_Human_NB4_2D_All_Mito_512_4dTensor.Rds
##   EH6931 | EM_id0008_Human_NB4_2D_All_Mito_512_4dTensor_dataset.gif
##   EH6932 | EM_id0008_Human_NB4_2D_All_Nuc_crop512_4dTensor.Rds
##   ...      ...
##   EH6936 | EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor.Rds
##   EH6937 | EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor_dataset.gif
##   EH6938 | EM_id0008_Human_NB4_2D_WideEM_NB4_097_01_4dtensor.Rds
##   EH6939 | EM_id0008_Human_NB4_2D_WideEM_NB4_097_02_4dtensor.Rds
##   EH6940 | EM_id0008_Human_NB4_2D_WideEM_NB4_127_4dtensor.Rds
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.9 EM\_id0009: Murine BMMC cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0009"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Pattern Recognition and Image Processing, University of Fre...
## # $species: Mus musculus
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6941"]]'
##
##            title
##   EH6941 | EM_id0009_MurineBMMC_All_512_4dTensor.Rds
##   EH6942 | EM_id0009_MurineBMMC_All_512_4dTensor_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.10 EM\_id0010: Human Blast cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0010"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Pattern Recognition and Image Processing, University of Fre...
## # $species: Homo sapiens
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6943"]]'
##
##            title
##   EH6943 | EM_id0010_HumanBlast_All_512_4dTensor.Rds
##   EH6944 | EM_id0010_HumanBlast_All_512_4dTensor_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.11 EM\_id0011: human T-cell line Jurkat cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "EM_id0011"))

##Show metadata
qr
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Pattern Recognition and Image Processing, University of Fre...
## # $species: Homo sapiens
## # $rdataclass: magick-image, List
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6945"]]'
##
##            title
##   EH6945 | EM_id0011_HumanJurkat_All_512_4dTensor.Rds
##   EH6946 | EM_id0011_HumanJurkat_All_512_4dTensor_dataset.gif
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.12 LM\_id0001: HeLa cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "LM_id0001"))

##Show metadata
qr
```

```
## ExperimentHub with 5 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: CELL TRACKING CHALLENGE (http://celltrackingchallenge.net/2...
## # $species: Homo sapiens
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6878"]]'
##
##            title
##   EH6878 | LM_id0001_DIC_C2DH_HeLa_4dTensor.Rds
##   EH6879 | LM_id0001_DIC_C2DH_HeLa_4dTensor_train_dataset.gif
##   EH6880 | LM_id0001_DIC_C2DH_HeLa_4dTensor_Binary.Rds
##   EH6881 | LM_id0001_DIC_C2DH_HeLa_4dTensor_Binary_train_dataset.gif
##   EH6882 | LM_id0001_DIC_C2DH_HeLa_5dTensor.Rds
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.13 LM\_id0002: Human glioblastoma-astrocytoma U373 cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "LM_id0002"))

##Show metadata
qr
```

```
## ExperimentHub with 5 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: CELL TRACKING CHALLENGE (http://celltrackingchallenge.net/2...
## # $species: Homo sapiens
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6883"]]'
##
##            title
##   EH6883 | LM_id0002_PhC_C2DH_U373_4dTensor.Rds
##   EH6884 | LM_id0002_PhC_C2DH_U373_4dTensor_train_dataset.gif
##   EH6885 | LM_id0002_PhC_C2DH_U373_4dTensor_Binary.Rds
##   EH6886 | LM_id0002_PhC_C2DH_U373_4dTensor_Binary_train_dataset.gif
##   EH6887 | LM_id0002_PhC_C2DH_U373_5dTensor.Rds
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

## 4.14 LM\_id0003: GFP-GOWT1 mouse stem cells (4D Array / Tensor)

```
qr <- query(eh, c("BioImageDbs", "LM_id0003"))

##Show metadata
qr
```

```
## ExperimentHub with 5 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: CELL TRACKING CHALLENGE (http://celltrackingchallenge.net/2...
## # $species: Mus musculus
## # $rdataclass: List, magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6888"]]'
##
##            title
##   EH6888 | LM_id0003_Fluo_N2DH_GOWT1_4dTensor.Rds
##   EH6889 | LM_id0003_Fluo_N2DH_GOWT1_4dTensor_train_dataset.gif
##   EH6890 | LM_id0003_Fluo_N2DH_GOWT1_4dTensor_Binary.Rds
##   EH6891 | LM_id0003_Fluo_N2DH_GOWT1_4dTensor_Binary_train_dataset.gif
##   EH6892 | LM_id0003_Fluo_N2DH_GOWT1_5dTensor.Rds
```

```
##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
```

```
## see ?BioImageDbs and browseVignettes('BioImageDbs') for documentation
```

```
## loading from cache
```

```
magick::image_read(gif_Data)
```

![](data:image/gif;base64...)

# Session information

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
## [1] magick_2.9.0        BioImageDbs_1.18.0  ExperimentHub_3.0.0
## [4] AnnotationHub_4.0.0 BiocFileCache_3.0.0 dbplyr_2.5.1
## [7] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
##  [4] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
##  [7] evaluate_1.0.5       bookdown_0.45        fastmap_1.2.0
## [10] blob_1.2.4           jsonlite_2.0.0       AnnotationDbi_1.72.0
## [13] DBI_1.2.3            BiocManager_1.30.26  httr_1.4.7
## [16] purrr_1.1.0          Biostrings_2.78.0    httr2_1.2.1
## [19] jquerylib_0.1.4      cli_3.6.5            crayon_1.5.3
## [22] rlang_1.1.6          XVector_0.50.0       Biobase_2.70.0
## [25] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
## [28] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
## [31] dplyr_1.1.4          filelock_1.0.3       curl_7.0.0
## [34] vctrs_0.6.5          R6_2.6.1             png_0.1-8
## [37] stats4_4.5.1         lifecycle_1.0.4      Seqinfo_1.0.0
## [40] KEGGREST_1.50.0      S4Vectors_0.48.0     IRanges_2.44.0
## [43] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
## [46] bslib_0.9.0          Rcpp_1.1.0           glue_1.8.0
## [49] xfun_0.53            tibble_3.3.0         tidyselect_1.2.1
## [52] knitr_1.50           htmltools_0.5.8.1    rmarkdown_2.30
## [55] compiler_4.5.1
```