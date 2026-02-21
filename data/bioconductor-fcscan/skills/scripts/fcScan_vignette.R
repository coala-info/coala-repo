# Code example from 'fcScan_vignette' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----echo=FALSE, results="hide", warning=FALSE--------------------------------
suppressPackageStartupMessages({library('fcScan')})

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----echo=FALSE, results='asis'-----------------------------------------------
df <- data.frame(seqnames = c("chr1", "chr1", "chr1", "chr1", "chr1", "chr1"),
                start = c(10, 17, 25, 27, 32, 41),
                end = c(15, 20, 30, 35, 40, 48),
                strand = c("+", "+", "+", "+", "+", "+"),
                site = c("a", "b", "b", "a", "c", "b"))
knitr::kable(df)

## ----eval=TRUE----------------------------------------------------------------
x1 = data.frame(seqnames = rep("chr1", times = 17),
    start = c(1,10,17,25,27,32,41,47,60,70,87,94,99,107,113,121,132),
    end = c(8,15,20,30,35,40,48,55,68,75,93,100,105,113,120,130,135),
    strand = c("+","+","+","+","+","+","+","+","+",
        "+","+","+","+","+","+","+","-"),
    site = c("s3","s1","s2","s2","s1","s2","s1","s1","s2","s1","s2",
        "s2","s1","s2","s1","s1","s2"))

clusters = getCluster(x1, w = 20, c = c("s1" = 1, "s2" = 1, "s3" = 0), 
    greedy = TRUE, order = c("s1","s2"), site_orientation=c("+","+"), 
    site_overlap = 2, verbose = TRUE)

clusters

## ----eval=TRUE----------------------------------------------------------------
suppressMessages(library(GenomicRanges))

x = GRanges(
    seqnames = Rle("chr1", 16),
    ranges = IRanges(start = c(10L,17L,25L,27L,32L,41L,47L,
        60L,70L,87L,94L,99L,107L,113L,121L,132L),
    end = c(15L,20L,30L,35L,40L,48L,55L,68L,75L,93L,100L,105L,
        113L,120L,130L,135L)),
    strand = Rle("+",16),
    site = c("s1","s2","s2","s1","s2","s1","s1","s2",
        "s1","s2","s2","s1","s2","s1","s1","s2"))
    
clusters = getCluster(x, w = 25, c = c("s1"=1,"s2"=2), s = "+")

clusters

## -----------------------------------------------------------------------------
sessionInfo() 

