# Code example from 'ggmsa' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

# Packages -------------------------------------------------------------------
library(ggmsa)
library(ggplot2)
library(yulab.utils)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("ggmsa")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
library(ggmsa)

## ----echo=FALSE, out.width='50%'----------------------------------------------
knitr::include_graphics("man/figures/workflow.png")

## ----warning=FALSE------------------------------------------------------------
 available_msa()

 protein_sequences <- system.file("extdata", "sample.fasta", 
                                  package = "ggmsa")
 miRNA_sequences <- system.file("extdata", "seedSample.fa", 
                                package = "ggmsa")
 nt_sequences <- system.file("extdata", "LeaderRepeat_All.fa", 
                             package = "ggmsa")
 

## ----fig.height = 2, fig.width = 10, warning=FALSE----------------------------
ggmsa(protein_sequences, 300, 350, color = "Clustal", 
      font = "DroidSansMono", char_width = 0.5, seq_name = TRUE )

## ----warning=FALSE------------------------------------------------------------
available_colors()

## ----echo=FALSE, out.width = '50%'--------------------------------------------
knitr::include_graphics("man/figures/schemes.png")

## ----warning=FALSE------------------------------------------------------------
available_fonts()

## ----fig.height = 2.5, fig.width = 11, warning = FALSE, message = FALSE-------
ggmsa(protein_sequences, 221, 280, seq_name = TRUE, char_width = 0.5) + 
  geom_seqlogo(color = "Chemistry_AA") + geom_msaBar()

## ----echo=FALSE, results='asis', warning=FALSE, message=FALSE-----------------
library(kableExtra)
x <- "geom_seqlogo()\tgeometric layer\tautomatically generated sequence logos for a MSA\n
geom_GC()\tannotation module\tshows GC content with bubble chart\n
geom_seed()\tannotation module\thighlights seed region on miRNA sequences\n
geom_msaBar()\tannotation module\tshows sequences conservation by a bar chart\n
geom_helix()\tannotation module\tdepicts RNA secondary structure as arc diagrams(need extra data)\n
 "

xx <- strsplit(x, "\n\n")[[1]]
y <- strsplit(xx, "\t") %>% do.call("rbind", .)
y <- as.data.frame(y, stringsAsFactors = FALSE)

colnames(y) <- c("Annotation modules", "Type", "Description")

knitr::kable(y, align = "l", booktabs = TRUE, escape = TRUE) %>% 
    kable_styling(latex_options = c("striped", "hold_position", "scale_down"))
  

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

