# Code example from 'omixer-vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment="#>")
set.seed(123)

## ----loadPackages, warning=FALSE, message=FALSE-------------------------------
library(Omixer)
library(tibble)
library(forcats)
library(stringr)
library(dplyr)
library(ggplot2)
library(magick)

## ----echo=FALSE, out.width='100%'---------------------------------------------
knitr::include_graphics('./omixer_48col.png')

## ----echo=FALSE, out.width='100%'---------------------------------------------
knitr::include_graphics('./omixer_48row.png')

## ----echo=FALSE, out.width='100%'---------------------------------------------
knitr::include_graphics('./omixer_48colblock.png')

## -----------------------------------------------------------------------------
layout <- tibble(plate=rep(1, 96), well=1:96, 
    row=factor(rep(1:8, each=12), labels=toupper(letters[1:8])),
    column=rep(1:12, 8), chip=as.integer(ceiling(column/2)),
    chipPos=ifelse(column %% 2 == 0, as.numeric(row)+8, row))

techVars <- c("chip", "chipPos")

layout

## ----rna_toy_data-------------------------------------------------------------
sampleList <- tibble(sampleId=str_pad(1:48, 4, pad="0"),
    sex=as_factor(sample(c("m", "f"), 48, replace=TRUE)), 
    age=round(rnorm(48, mean=30, sd=8), 0), 
    smoke=as_factor(sample(c("yes", "ex", "never"), 48, 
        replace=TRUE)),
    date=sample(seq(as.Date('2008/01/01'), as.Date('2016/01/01'), 
        by="day"), 48))

sampleList

## ----rna_var_setup------------------------------------------------------------
randVars <- c("sex", "age", "smoke", "date")

## ----rna_omixer_rand----------------------------------------------------------
omixerLayout <- omixerRand(sampleList, sampleId="sampleId", 
    block="block", iterNum=100, wells=48, div="row", 
    plateNum=1, randVars=randVars)

## -----------------------------------------------------------------------------
head(omixerLayout[1:11])

## ----omixer_specific_rna, eval=FALSE------------------------------------------
# load("randomSeed.Rdata")
# .GlobalEnv$.Random.seed <- randomSeed
# 
# omixerLayout <- omixerSpecific(sampleList, sampleId="sampleId",
#     block="block", wells=96, div="row",
#     plateNum=1, randVars=randVars)

## ----omixer_sheet_rna---------------------------------------------------------
omixerSheet(omixerLayout)

## ----echo=FALSE, out.width='100%'---------------------------------------------
knitr::include_graphics('./omixer_sample_sheets_rna.PNG')

## ----dna_toy_data-------------------------------------------------------------
sampleList<- tibble(sampleId=str_pad(1:616, 4, pad="0"), 
    block=rep(1:308, each=2), 
    time=rep(0:1, 308), 
    tissue=as_factor(rep(c("blood", "fat", "muscle", "saliva"), 
        each=2, 77)), 
    sex=as_factor(rep(sample(c("male", "female"), 77, replace=TRUE), 
        each=8)), 
    age=round(rep(rnorm(77, mean=60, sd=10), each=8), 0), 
    bmi=round(rep(rnorm(77, mean=25, sd=2), each=8) , 1), 
    date=rep(sample(seq(as.Date('2015/01/01'), as.Date('2020/01/01'), 
        by="day"), 77), each=8))

sampleList
save(sampleList, file="sampleList.Rdata")

## ----dna_var_setup------------------------------------------------------------
randVars <- c("tissue", "sex", "age", "bmi", "date")

## ----dna_mask-----------------------------------------------------------------
mask <- rep(c(rep(0, 88), rep(1, 8)), 7)

## ----dna_omixer_rand, fig.wide = TRUE-----------------------------------------
omixerLayout <- omixerRand(sampleList, sampleId="sampleId", 
    block="block", iterNum=100, wells=96, div="col", plateNum=7, 
    randVars=randVars, mask=mask)

## ----omixer_v_simple, fig.wide = TRUE-----------------------------------------
simpleLayout <- omixerRand(sampleList, sampleId="sampleId", 
    block="block",iterNum=1, wells=96, div="col", plateNum=7, 
    randVars=randVars, mask=mask)

## ----omixer_specific_dna, eval=FALSE------------------------------------------
# load("randomSeed.Rdata")
# .GlobalEnv$.Random.seed <- randomSeed
# 
# omixerLayout <- omixerSpecific(sampleList, sampleId="sampleId",
#     block="block", wells=96, div="col", plateNum=7,
#     randVars=randVars, mask=mask)

## ----omixer_sheet-------------------------------------------------------------
omixerSheet(omixerLayout, group="tissue")

## ----echo=FALSE, out.width='100%'---------------------------------------------
knitr::include_graphics('./omixer_sample_sheets_dna.PNG')

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

