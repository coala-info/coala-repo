# Code example from 'BioImageDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----load-lib, message = FALSE------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()

## ----list-BioImageDbs---------------------------------------------------------
query(eh, "BioImage")

## ----confirm-metadata---------------------------------------------------------
mcols(query(eh, "BioImage"))

## ----query-mouse--------------------------------------------------------------
qr <- query(eh, c("BioImageDbs", "LM_id0001"))
qr

#Import data
#BioImageDbs_image_Dat <- qr[[1]]

## -----------------------------------------------------------------------------
qr <- query(eh, c("BioImageDbs", ".gif"))
qr

#EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_data
qr[1]

##Display the gif image
#magick::image_read(qr[[1]])

## ----Fig001, fig.cap = "EM_id0001_Brain_CA1_hippocampus_region_5dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[1]])
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0001.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig002, fig.cap = "EM_id0002_Drosophila_brain_region_5dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[2]])
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0002.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig003, fig.cap = "EM_id0003_J558L_4dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[9]])
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0003.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig004, fig.cap = "EM_id0004_PrHudata_4dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[10]])
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0004.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig008, fig.cap = "EM_id0005_Mouse_Kidney_2D_All_Mito_1024_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0005_Mouse_Kidney_2D_Mito.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig009, fig.cap = "EM_id0005_Mouse_Kidney_2D_All_Nuc_1024_4dtensor.Rds", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0005_Mouse_Kidney_2D_Nuc.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig010, fig.cap = "EM_id0006_Rat_Liver_2D_All_Mito_1024_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0006_Rat_Liver_Mito.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig011, fig.cap = "EM_id0006_Rat_Liver_2D_All_Nuc_1024_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0006_Rat_Liver_Nuc.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig012, fig.cap = "EM_id0007_Mouse_Kidney_MultiScale_All_Low_Glomerulus_1024_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0007_Mouse_Kidney_MultiScale_Glomerulus.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig013, fig.cap = "EM_id0007_Mouse_Kidney_MultiScale_All_Middle_Podocyte_1024_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0007_Mouse_Kidney_MultiScale_Podocyte.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig014, fig.cap = "EM_id0008_Human_NB4_2D_All_Cel_512_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0008_Human_NB4_Nuc.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig015, fig.cap = "EM_id0008_Human_NB4_2D_All_Nuc_1024_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0008_Human_NB4_Cell.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig016, fig.cap = "EM_id0009_MurineBMMC_All_512_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0009.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig017, fig.cap = "EM_id0010_HumanBlast_All_512_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0010.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig018, fig.cap = "EM_id0011_HumanJurkat_All_512_4dTensor_dataset.gif", echo = FALSE----
options(EBImage.display = "raster")
img <- system.file("images", "EM_id0011.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig005, fig.cap = "LM_id0001_DIC_C2DH_HeLa_4dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[3]])
options(EBImage.display = "raster")
img <- system.file("images", "LM_id0001.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig006, fig.cap = "LM_id0002_PhC_C2DH_U373_4dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[5]])
options(EBImage.display = "raster")
img <- system.file("images", "LM_id0002.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## ----Fig007, fig.cap = "LM_id0003_Fluo_N2DH_GOWT1_4dTensor_train_dataset.gif", echo = FALSE----
#magick::image_read(qr[[7]])
options(EBImage.display = "raster")
img <- system.file("images", "LM_id0003.png", package="BioImageDbs")
EBImage::display(EBImage::readImage(files = img))

## -----------------------------------------------------------------------------
## Not Run ##
# qr <- query(eh, c("BioImageDbs"))
# BioImageData <- qr[[1]]
# data <- BioImageData$Train$Train_Original
# labels <- BioImageData$Train$Train_GroundTruth
# dim(data); dim(labels)
# model %>% fit( x = data, y = labels )

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

