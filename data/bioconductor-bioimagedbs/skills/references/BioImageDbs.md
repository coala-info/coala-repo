# Providing Bioimage Dataset for ExperimentHub

Satoshi Kume\*

\*satoshi.kume.1984@gmail.com

#### 2025-10-30

#### Package

BioImageDbs 1.18.0

**Last modified:** 2025-10-30 09:33:00.222955
**Compiled**: 2025-10-30 11:15:37.277977

# 1 Utilisation and prospects of bioimage datasets

In recent years, there has been a growing need for data analysis using machine
learning in the field of bioimaging research. Machine learning is an inductive
approach using data, and the construction of models, such as image segmentation
and classification, involves the use of image data itself. Therefore, the
publication and sharing of bioimage datasets [[1](#ref-Williams2017)] as well as knowledge creation
through providing metadata to bioimages [[2](#ref-Kobayashi2018),[3](#ref-Kume2017)] are important issues to be
discussed. At present, there is no commonly used format for sharing bioimage
datasets. Also, the data is scattered among various repositories. Therefore,
different image repositories manage the data in different formats (image data
itself and metadata, including image format, instruments/microscopes and
biosamples).

In the data analysis and quantification using those images, it is assumed that
several steps of image pre-processing are performed depending on the analysis
environment used. However, the implementation of supervised learning starts with
finding a repository of the bioimage dataset that contains original images and
their corresponding supervised labels. Once the repository is found, the image
data is downloaded from the repository, the data is loaded into each
environment and it is prepared in a format suitable for analytical package.
These processes are time consuming before the main analysis. Also, in most of
the image repositories, the data are not published in a format suitable for
reading and processing in R (.Rdata, etc.), and the data are not easy to use
for R users.

For performing supervised learning of bioimage data, BioImageDbs provides R
list objects of the original images and their corresponding supervised labels
converted into a 4D or 5D array. After retrieving the data from ExperimentHub,
it can be utilised for deep learning using Keras/Tensorflow [[4](#ref-Chollet2017kerasR)]
and other machine learning methods, without the need for pre-processing.

On the other hand, many image analysis packages are also available on R;
however, there is a lack of standardisation in image analysis. The use of
common, open datasets is one of the essential steps in standardising and
comparing the analytical methods. The provision of the array data of images
through ExperimentHub is also intended for applications such as (1) comparing
models using common-sharing data among R users and (2) applying predictions
to new datasets through transfer learning and fine-tuning based on these arrays.

# 2 Fetch Bioimage Datasets from ExperimentHub

The `BioImageDbs` package provides the metadata for all BioImage
databases in *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*.

The `BioImageDbs` package provides the metadata for bioimage datasets,
which is preprocessed as array format and saved in
*[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*.

First we load/update the `ExperimentHub` resource.

```
library(ExperimentHub)
eh <- ExperimentHub()
```

Next we list all BioImageDbs entries from `ExperimentHub`.

```
query(eh, "BioImage")
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

We can confirm the metadata in ExperimentHub in Bioconductor S3 bucket
with `mcols()`.

```
mcols(query(eh, "BioImage"))
```

```
## DataFrame with 73 rows and 15 columns
##                         title           dataprovider                species
##                   <character>            <character>            <character>
## EH6874 EM_id0001_Brain_CA1_.. https://www.epfl.ch/..           Mus musculus
## EH6875 EM_id0001_Brain_CA1_.. https://www.epfl.ch/..           Mus musculus
## EH6876 EM_id0002_Drosophila.. the ISBI 2012 Challe.. Drosophila melanogas..
## EH6877 EM_id0002_Drosophila.. the ISBI 2012 Challe.. Drosophila melanogas..
## EH6878 LM_id0001_DIC_C2DH_H.. CELL TRACKING CHALLE..           Homo sapiens
## ...                       ...                    ...                    ...
## EH6942 EM_id0009_MurineBMMC.. Pattern Recognition ..           Mus musculus
## EH6943 EM_id0010_HumanBlast.. Pattern Recognition ..           Homo sapiens
## EH6944 EM_id0010_HumanBlast.. Pattern Recognition ..           Homo sapiens
## EH6945 EM_id0011_HumanJurka.. Pattern Recognition ..           Homo sapiens
## EH6946 EM_id0011_HumanJurka.. Pattern Recognition ..           Homo sapiens
##        taxonomyid      genome            description coordinate_1_based
##         <integer> <character>            <character>          <integer>
## EH6874      10090          NA 5D arrays with the b..                  1
## EH6875      10090          NA A animation file (.g..                  1
## EH6876       7227          NA 5D arrays with the b..                  1
## EH6877       7227          NA A animation file (.g..                  1
## EH6878       9606          NA 4D arrays with the m..                  1
## ...           ...         ...                    ...                ...
## EH6942      10090          NA A animation file (.g..                  1
## EH6943       9606          NA 4D arrays with the m..                  1
## EH6944       9606          NA A animation file (.g..                  1
## EH6945       9606          NA 4D arrays with the m..                  1
## EH6946       9606          NA A animation file (.g..                  1
##                    maintainer rdatadateadded preparerclass
##                   <character>    <character>   <character>
## EH6874 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6875 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6876 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6877 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6878 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## ...                       ...            ...           ...
## EH6942 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6943 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6944 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6945 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
## EH6946 Satoshi Kume <satosh..     2021-05-18   BioImageDbs
##                                          tags   rdataclass
##                                        <AsIs>  <character>
## EH6874     3D images,bioimage,CellCulture,...         List
## EH6875     animation,bioimage,CellCulture,... magick-image
## EH6876      3D image,bioimage,CellCulture,...         List
## EH6877     animation,bioimage,CellCulture,... magick-image
## EH6878 bioimage,cell tracking,CellCulture,...         List
## ...                                       ...          ...
## EH6942     2D images,bioimage,CellCulture,... magick-image
## EH6943     2D images,bioimage,CellCulture,...         List
## EH6944     2D images,bioimage,CellCulture,... magick-image
## EH6945     2D images,bioimage,CellCulture,...         List
## EH6946     2D images,bioimage,CellCulture,... magick-image
##                     rdatapath              sourceurl  sourcetype
##                   <character>            <character> <character>
## EH6874 BioImageDbs/v01/EM_i.. https://github.com/k..         PNG
## EH6875 BioImageDbs/v01/EM_i.. https://github.com/k..         PNG
## EH6876 BioImageDbs/v01/EM_i.. https://github.com/k..         PNG
## EH6877 BioImageDbs/v01/EM_i.. https://github.com/k..         PNG
## EH6878 BioImageDbs/v01/LM_i.. https://github.com/k..         PNG
## ...                       ...                    ...         ...
## EH6942 BioImageDbs/v02/EM_i.. https://github.com/k..         PNG
## EH6943 BioImageDbs/v02/EM_i.. https://github.com/k..         PNG
## EH6944 BioImageDbs/v02/EM_i.. https://github.com/k..         PNG
## EH6945 BioImageDbs/v02/EM_i.. https://github.com/k..         PNG
## EH6946 BioImageDbs/v02/EM_i.. https://github.com/k..         PNG
```

We can retrieve only the BioImageDbs tibble files as follows.

```
qr <- query(eh, c("BioImageDbs", "LM_id0001"))
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
#Import data
#BioImageDbs_image_Dat <- qr[[1]]
```

# 3 5D Arrays from the ExperimentHub

The ordering of the array dimensions corresponds to the channels\_last format
(default) in R/Keras. The input shape of 5D array is to be batch, spatial\_dim1,
spatial\_dim2, spatial\_dim3 and channels. The number of this batch is the same
as the number of the 3D image sets. The number of channels is 1 for grey
images and 3 for RGB images.

# 4 4D Arrays from the ExperimentHub

The ordering of the array dimensions corresponds to the channels\_last format
(default) in R/Keras. The input shape of 4D array is to be batch, height,
width and channels. The number of this batch is the same as the number of
the 2D images.

# 5 Visualization of gif images from the ExperimentHub

As a test, we also provided gif files of some arrays for visualizations.
We visualize the files using `magick::image_read` function.

```
qr <- query(eh, c("BioImageDbs", ".gif"))
qr
```

```
## ExperimentHub with 32 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Satoshi Kume <satoshi.kume.1984@gmail.com>, CELL TRACKING C...
## # $species: Mus musculus, Homo sapiens, Rattus norvegicus, Drosophila melano...
## # $rdataclass: magick-image
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6875"]]'
##
##            title
##   EH6875 | EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif
##   EH6877 | EM_id0002_Drosophila_brain_region_5dTensor_train_dataset.gif
##   EH6879 | LM_id0001_DIC_C2DH_HeLa_4dTensor_train_dataset.gif
##   EH6881 | LM_id0001_DIC_C2DH_HeLa_4dTensor_Binary_train_dataset.gif
##   EH6884 | LM_id0002_PhC_C2DH_U373_4dTensor_train_dataset.gif
##   ...      ...
##   EH6935 | EM_id0008_Human_NB4_2D_All_Nuc_512_4dTensor_dataset.gif
##   EH6937 | EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor_dataset.gif
##   EH6942 | EM_id0009_MurineBMMC_All_512_4dTensor_dataset.gif
##   EH6944 | EM_id0010_HumanBlast_All_512_4dTensor_dataset.gif
##   EH6946 | EM_id0011_HumanJurkat_All_512_4dTensor_dataset.gif
```

```
#EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_data
qr[1]
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH6875
## # package(): BioImageDbs
## # $dataprovider: https://www.epfl.ch/labs/cvlab/data/data-em/
## # $species: Mus musculus
## # $rdataclass: magick-image
## # $rdatadateadded: 2021-05-18
## # $title: EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif
## # $description: A animation file (.gif) of the train dataset of EM_id0001_Br...
## # $taxonomyid: 10090
## # $genome: NA
## # $sourcetype: PNG
## # $sourceurl: https://github.com/kumeS/BioImageDbs
## # $sourcesize: NA
## # $tags: c("animation", "bioimage", "CellCulture", "electron
## #   microscopy", "microscope", "scanning electron microscopy",
## #   "segmentation", "Tissue")
## # retrieve record with 'object[["EH6875"]]'
```

```
##Display the gif image
#magick::image_read(qr[[1]])
```

![EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif](data:image/png;base64...)

Figure 1: EM\_id0001\_Brain\_CA1\_hippocampus\_region\_5dTensor\_train\_dataset.gif

![EM_id0002_Drosophila_brain_region_5dTensor_train_dataset.gif](data:image/png;base64...)

Figure 2: EM\_id0002\_Drosophila\_brain\_region\_5dTensor\_train\_dataset.gif

![EM_id0003_J558L_4dTensor_train_dataset.gif](data:image/png;base64...)

Figure 3: EM\_id0003\_J558L\_4dTensor\_train\_dataset.gif

![EM_id0004_PrHudata_4dTensor_train_dataset.gif](data:image/png;base64...)

Figure 4: EM\_id0004\_PrHudata\_4dTensor\_train\_dataset.gif

![EM_id0005_Mouse_Kidney_2D_All_Mito_1024_4dTensor_dataset.gif](data:image/png;base64...)

Figure 5: EM\_id0005\_Mouse\_Kidney\_2D\_All\_Mito\_1024\_4dTensor\_dataset.gif

![EM_id0005_Mouse_Kidney_2D_All_Nuc_1024_4dtensor.Rds](data:image/png;base64...)

Figure 6: EM\_id0005\_Mouse\_Kidney\_2D\_All\_Nuc\_1024\_4dtensor.Rds

![EM_id0006_Rat_Liver_2D_All_Mito_1024_4dTensor_dataset.gif](data:image/png;base64...)

Figure 7: EM\_id0006\_Rat\_Liver\_2D\_All\_Mito\_1024\_4dTensor\_dataset.gif

![EM_id0006_Rat_Liver_2D_All_Nuc_1024_4dTensor_dataset.gif](data:image/png;base64...)

Figure 8: EM\_id0006\_Rat\_Liver\_2D\_All\_Nuc\_1024\_4dTensor\_dataset.gif

![EM_id0007_Mouse_Kidney_MultiScale_All_Low_Glomerulus_1024_4dTensor_dataset.gif](data:image/png;base64...)

Figure 9: EM\_id0007\_Mouse\_Kidney\_MultiScale\_All\_Low\_Glomerulus\_1024\_4dTensor\_dataset.gif

![EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Podocyte_1024_4dTensor_dataset.gif](data:image/png;base64...)

Figure 10: EM\_id0007\_Mouse\_Kidney\_MultiScale\_All\_Middle\_Podocyte\_1024\_4dTensor\_dataset.gif

![EM_id0008_Human_NB4_2D_All_Cel_512_4dTensor_dataset.gif](data:image/png;base64...)

Figure 11: EM\_id0008\_Human\_NB4\_2D\_All\_Cel\_512\_4dTensor\_dataset.gif

![EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor_dataset.gif](data:image/png;base64...)

Figure 12: EM\_id0008\_Human\_NB4\_2D\_All\_Nuc\_1024\_4dTensor\_dataset.gif

![EM_id0009_MurineBMMC_All_512_4dTensor_dataset.gif](data:image/png;base64...)

Figure 13: EM\_id0009\_MurineBMMC\_All\_512\_4dTensor\_dataset.gif

![EM_id0010_HumanBlast_All_512_4dTensor_dataset.gif](data:image/png;base64...)

Figure 14: EM\_id0010\_HumanBlast\_All\_512\_4dTensor\_dataset.gif

![EM_id0011_HumanJurkat_All_512_4dTensor_dataset.gif](data:image/png;base64...)

Figure 15: EM\_id0011\_HumanJurkat\_All\_512\_4dTensor\_dataset.gif

![LM_id0001_DIC_C2DH_HeLa_4dTensor_train_dataset.gif](data:image/png;base64...)

Figure 16: LM\_id0001\_DIC\_C2DH\_HeLa\_4dTensor\_train\_dataset.gif

![LM_id0002_PhC_C2DH_U373_4dTensor_train_dataset.gif](data:image/png;base64...)

Figure 17: LM\_id0002\_PhC\_C2DH\_U373\_4dTensor\_train\_dataset.gif

![LM_id0003_Fluo_N2DH_GOWT1_4dTensor_train_dataset.gif](data:image/png;base64...)

Figure 18: LM\_id0003\_Fluo\_N2DH\_GOWT1\_4dTensor\_train\_dataset.gif

# 6 A simple execution command using Keras/Tensorflow

We select a data array and a label array from the data list and assign
them to variables. These variables are then used as the x and y arguments
of the fit (<keras.engine.training.Model>) function of Keras as an example.
The model in Keras should be prepared before the execution.

```
## Not Run ##
# qr <- query(eh, c("BioImageDbs"))
# BioImageData <- qr[[1]]
# data <- BioImageData$Train$Train_Original
# labels <- BioImageData$Train$Train_GroundTruth
# dim(data); dim(labels)
# model %>% fit( x = data, y = labels )
```

# 7 About the imaging dataset and its metadata in BioImageDbs

For this dataset in BioImageDbs, the published open data was used as follows:

1. For cellular ultra-microstructures, electron microscopy-based imaging data of
   mouse B myeloma cell line J558L (ex. EM\_id0003\_J558L\_4dTensor.Rda) [[5](#ref-Morath2013)]
   and primary human T cell isolated from peripheral blood mononuclear cells
   (ex. EM\_id0004\_PrHudata\_4dTensor.Rda) [[5](#ref-Morath2013)], Human NB-4 cell
   (ex. EM\_id0008\_Human\_NB4\_2D\_All\_Cel\_512\_4dTensor.Rds) [[3](#ref-Kume2017)],
   murine bone marrow derived-mast cells (ex. EM\_id0009\_MurineBMMC\_All\_512\_4dTensor.Rds) [[5](#ref-Morath2013)],
   human blasts (ex. EM\_id0010\_HumanBlast\_All\_512\_4dTensor.Rds) [[5](#ref-Morath2013)], and
   human T-cell line Jurkat (ex. EM\_id0011\_HumanJurkat\_All\_512\_4dTensor.Rds) [[5](#ref-Morath2013)]
   were used.
2. For bio-tissue ultra-microstructures, electron microscopy-based imaging data
   of the mouse brain (ex. EM\_id0001\_Brain\_CA1\_hippocampus\_region\_5dTensor.Rda)
   [[6](#ref-Lucchi2012),[7](#ref-Lucchi2013bib)], Drosophila brain (ex. EM\_id0002\_Drosophila\_brain\_region\_5dTensor.Rda)
   [[8](#ref-Cardona2010),[9](#ref-ArgandaCarreras2015)], mouse kidney (ex. EM\_id0005\_Mouse\_Kidney\_2D\_All\_Nuc\_1024\_4dtensor.Rds) [[10](#ref-Kume2016)]
   and rat liver (ex. EM\_id0006\_Rat\_Liver\_2D\_All\_Mito\_1024\_4dtensor.Rds) [[10](#ref-Kume2016)] were used.
3. For cell tracking, light microscopy-based imaging data of the human HeLa
   cells on a flat glass (ex. LM\_id0001\_DIC\_C2DH\_HeLa\_4dTensor.Rda) [[11](#ref-Maska2014),[12](#ref-Ulman2017)],
   human glioblastoma-astrocytoma U373 cells on a polyacrylamide substrate
   (ex. LM\_id0002\_PhC\_C2DH\_U373\_4dTensor.Rda) [[11](#ref-Maska2014),[12](#ref-Ulman2017)] and GFP-GOWT1 mouse stem
   cells (ex. LM\_id0003\_Fluo\_N2DH\_GOWT1\_4dTensor.Rda) [[13](#ref-Bartova2011)] were used.

The values of the supervised labels were provided as array data with binary
or multiple values. The detailed information was described in the metadata
file of BioImageDbs.
Some of cell tracking data were obtained from the [cell tracking challenge](http://celltrackingchallenge.net/2d-datasets/).

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
##  [1] KEGGREST_1.50.0      xfun_0.53            bslib_0.9.0
##  [4] httr2_1.2.1          htmlwidgets_1.6.4    Biobase_2.70.0
##  [7] lattice_0.22-7       bitops_1.0-9         vctrs_0.6.5
## [10] tools_4.5.1          stats4_4.5.1         curl_7.0.0
## [13] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
## [16] blob_1.2.4           pkgconfig_2.0.3      EBImage_4.52.0
## [19] S4Vectors_0.48.0     lifecycle_1.0.4      compiler_4.5.1
## [22] Biostrings_2.78.0    tinytex_0.57         tiff_0.1-12
## [25] Seqinfo_1.0.0        htmltools_0.5.8.1    sass_0.4.10
## [28] RCurl_1.98-1.17      yaml_2.3.10          pillar_1.11.1
## [31] crayon_1.5.3         jquerylib_0.1.4      cachem_1.1.0
## [34] abind_1.4-8          tidyselect_1.2.1     locfit_1.5-9.12
## [37] digest_0.6.37        dplyr_1.1.4          purrr_1.1.0
## [40] bookdown_0.45        BiocVersion_3.22.0   grid_4.5.1
## [43] fastmap_1.2.0        cli_3.6.5            magrittr_2.0.4
## [46] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
## [49] bit64_4.6.0-1        rmarkdown_2.30       XVector_0.50.0
## [52] httr_1.4.7           fftwtools_0.9-11     jpeg_0.1-11
## [55] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [58] evaluate_1.0.5       knitr_1.50           IRanges_2.44.0
## [61] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
## [64] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [67] R6_2.6.1
```

# References

1 Williams, E., Moore, J., Li, S., Rustici, G., Tarkowska, A., Chessel, A., Leo, S., Antal, B., Ferguson, R., Sarkans, U., et al. (2017) Image data resource: A bioimage data integration and publication platform. Nature Methods, Springer Nature **14**, 775–781.

2 Kobayashi, N., Kume, S., Lenz, K. and Masuya, H. (2018) RIKEN metadatabase: A database platform for health care and life sciences as a microcosm of linked open data cloud. International Journal on Semantic Web and Information Systems (IJSWIS) **14**, 140–164.

3 Kume, S., Masuya, H., Maeda, M., Suga, M., Kataoka, Y. and Kobayashi, N. (2017) Development of semantic web-based imaging database for biological morphome. In Semantic technology (Wang, Z., Turhan, A.-Y., Wang, K., and Zhang, X., eds.), pp 277–285, Springer International Publishing, Cham.

4 Chollet, F., Allaire, J. and others. (2017) R interface to keras, <https://github.com/rstudio/keras>; GitHub.

5 Morath, V., Keuper, M., Rodriguez-Franco, M., Deswal, S., Fiala, G., Blumenthal, B., Kaschek, D., Timmer, J., Neuhaus, G., Ehl, S., et al. (2013) Semi-automatic determination of cell surface areas used in systems biology. Frontiers in Bioscience-Elite **5**, 533–545.

6 Lucchi, A., Smith, K., Achanta, R., Knott, G. and Fua, P. (2012) Supervoxel-based segmentation of mitochondria in em image stacks with learned shape features. IEEE transactions on medical imaging **31**, 474–486.

7 Lucchi, A., Li, Y. and Fua, P. (2013) Learning for structured prediction using approximate subgradient descent with working sets. In 2013 ieee conference on computer vision and pattern recognition, pp 1987–1994.

8 Cardona, A., Saalfeld, S., Preibisch, S., Schmid, B., Cheng, A., Pulokas, J., Tomancak, P. and Hartenstein, V. (2010) An integrated micro- and macroarchitectural analysis of the drosophila brain by computer-assisted serial section electron microscopy. PLOS Biology, Public Library of Science **8**, 1–17.

9 Arganda-Carreras, I., Turaga, S. C., Berger, D. R., Cireşan, D., Giusti, A., Gambardella, L. M., Schmidhuber, J., Laptev, D., Dwivedi, S., Buhmann, J. M., et al. (2015) Crowdsourcing the creation of image segmentation algorithms for connectomics. Frontiers in Neuroanatomy **9**, 142.

10 Kume, S., Masuya, H., Kataoka, Y. and Kobayashi, N. (2016) Development of an ontology for an integrated image analysis platform to enable global sharing of microscopy imaging data. In Proceedings of the 15th international semantic web conference (iswc2016).

11 Maška, M., Ulman, V., Svoboda, D., Matula, P., Matula, P., Ederra, C., Urbiola, A., España, T., Venkatesan, S., Balak, D. M. W., et al. (2014) A benchmark for comparison of cell tracking algorithms. Bioinformatics **30**, 1609–1617.

12 Ulman, V., Maška, M., Magnusson, K. E. G., Ronneberger, O., Haubold, C., Harder, N., Matula, P., Matula, P., Svoboda, D., Radojevic, M., et al. (2017) An objective comparison of cell-tracking algorithms. Nature Methods **14**, 1141–1152.

13 Bártová, E., Šustáčková, G., Stixová, L., Kozubek, S., Legartová, S. and Foltánková, V. (2011) Recruitment of oct4 protein to uv-damaged chromatin in embryonic stem cells. PLOS ONE, Public Library of Science **6**, 1–13.