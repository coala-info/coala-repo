# Code example from 'BioImageBbs_Datasets' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----load-lib, message = FALSE------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs"))
qr

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#Show metadata (e.g. ah_id and title)
qr$ah_id
qr$title

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0001"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]
gif_Data <- qr[[2]]

#Show animation
library(magick)
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0002"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]
gif_Data <- qr[[2]]

#Show animation
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0003"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0004"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0005"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0006"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0007"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0008"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0009"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0010"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "EM_id0011"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "LM_id0001"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "LM_id0002"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qr <- query(eh, c("BioImageDbs", "LM_id0003"))

##Show metadata
qr

##Import data
#Img_Data <- qr[[1]]

#Show animation
gif_Data <- qr[[2]]
magick::image_read(gif_Data)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

