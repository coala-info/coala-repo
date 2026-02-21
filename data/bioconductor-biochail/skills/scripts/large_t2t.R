# Code example from 'large_t2t' vignette. See references/ for full tutorial.

## ----doini,message=FALSE------------------------------------------------------
library(BiocHail)

## ----do17, eval=TRUE----------------------------------------------------------
hl <- hail_init()
# NB the following two commands are now encapsulated in the rg_update function
nn <- hl$get_reference('GRCh38')
nn <- nn$read(system.file("json/t2tAnVIL.json", package="BiocHail"))
# updates the hail reference genome
bigloc = Sys.getenv("HAIL_T2T_CHR17")
if (nchar(bigloc)>0) {
  mt17 <- hl$read_matrix_table(Sys.getenv("HAIL_T2T_CHR17"))
  mt17$count()
}

## ----lk191,eval=TRUE----------------------------------------------------------
utils::data(pcs_191k)
graphics::pairs(pcs_191k[,1:5], pch=".")

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("BiocHail")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

