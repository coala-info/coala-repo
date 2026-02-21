# Code example from 'uncoverappLib' vignette. See references/ for full tutorial.

## ----warning=FALSE, error=F---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=F, echo=T-----------------------------------------------------------
# 
# install.packages("BiocManager")
# BiocManager::install("uncoverappLib")
# library(uncoverappLib)

## ----eval=F, echo=T-----------------------------------------------------------
# 
# #library(devtools)
# #install_github("Manuelaio/uncoverappLib")
# #library(uncoverappLib)
# 

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
library(uncoverappLib)
#getAnnotationFiles(verbose= TRUE, vignette= TRUE)


## ----eval=TRUE, echo=TRUE-----------------------------------------------------
gene.list<- system.file("extdata", "mygene.txt", package = "uncoverappLib")


## ----eval=TRUE, echo=TRUE-----------------------------------------------------

bam_example <- system.file("extdata", "example_POLG.bam", package = "uncoverappLib")

print(bam_example)

write.table(bam_example, file= "./bam.list", quote= FALSE, row.names = FALSE, 
            col.names = FALSE)


## ----echo = FALSE, out.width='80%', fig.align='center', fig.cap="Screenshot of Preprocessing page."----
knitr::include_graphics("pre_file.png")


## ----eval=FALSE, echo=TRUE----------------------------------------------------
# 
# chr15   89859516        89859516        68      A:68
# chr15   89859517        89859517        70      T:70
# chr15   89859518        89859518        73      A:2;G:71
# chr15   89859519        89859519        73      A:73
# chr15   89859520        89859520        74      C:74
# chr15   89859521        89859521        75      C:1;T:74
# 

## ----echo = FALSE, out.width='100%', fig.align='center', fig.cap="Screenshot of Coverage Analysis page."----
knitr::include_graphics("load_file.png")


## ----echo = FALSE, out.width='100%', fig.align='center', fig.cap="Screenshot of output of UCSC gene table."----
knitr::include_graphics("ucsc_info.png")


## ----echo = FALSE, out.width='100%', fig.align='center', fig.cap="Screenshot of output of Exon genomic coordinate positions from UCSC table."----
knitr::include_graphics("exon_info.png")


## ----echo = FALSE, out.width='100%', fig.align='center', fig.cap="Screenshot of output of gene coverage."----
knitr::include_graphics("all_gene.png")


## ----echo = FALSE, out.width='80%', fig.align='center', fig.cap= "zoom of exon 10 "----
knitr::include_graphics("exon10tab.png")


## ----echo = FALSE, out.width='80%', fig.align='center', fig.cap=" Example of uncovered positions annotate with dbNSFP."----
knitr::include_graphics("annotate.png")


## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()


