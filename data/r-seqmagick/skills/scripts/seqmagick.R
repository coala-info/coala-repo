# Code example from 'seqmagick' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
		   message = FALSE)

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
library(magrittr)
library(Biostrings)
library("seqmagick")

## ----eval=FALSE---------------------------------------------------------------
# tmpgb <- tempfile(fileext = '.gb')
# tmpfa <- tempfile(fileext = '.fa')
# download_genbank(acc='AB115403', format='genbank', outfile=tmpgb)
# download_genbank(acc='AB115403', format='fasta', outfile=tmpfa)
# ## readLines(tmpgb)[1:10]
# ## readLines(tmpfa)

## ----eval=F-------------------------------------------------------------------
# fa_file <- system.file("extdata/HA.fas", package="seqmagick")
# ## use the small subset to save compilation time of the vignette
# fa2 <- tempfile(fileext = '.fa')
# fa_read(fa_file) %>% bs_filter('ATGAAAGTAAAA', by='sequence') %>% fa_write(fa2, type='interleaved')
# 
# 
# alnfas <- tempfile(fileext = ".fas")
# fa_read(fa2) %>% bs_aln(quiet=TRUE) %>% fa_write(alnfas)
# 
# ## phylip format is only for aligned sequences
# tmpphy <- tempfile(fileext = ".phy")
# fas2phy(alnfas, tmpphy, type = 'sequential')

## ----eval=F-------------------------------------------------------------------
# phy2fas(tmpphy, alnfas, type = 'interleaved')

## ----eval=F-------------------------------------------------------------------
# tmpfas <- tempfile(fileext='.fa')
# fa_read(fa2) %>% fa_write(tmpfas, type="sequential")

## ----eval=F-------------------------------------------------------------------
# tmpphy2 <- tempfile(fileext = '.phy')
# phy_read(tmpphy) %>% phy_write(tmpphy2, type="interleaved")

## ----eval=F-------------------------------------------------------------------
# bs <- fa_read(fa_file)
# bs_filter(bs, 'ATGAAAGTAAAA', by='sequence')
# 
# aln <- bs_filter(bs, 'ATGAAAGTAAAA', by='sequence') %>% bs_aln(quiet=TRUE)
# 
# bs_consensus(aln)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

