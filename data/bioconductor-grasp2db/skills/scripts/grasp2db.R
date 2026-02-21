# Code example from 'grasp2db' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()
suppressPackageStartupMessages(library(grasp2db))

## ----loadup2-------------------------------------------------------------
library(grasp2db)

## ----grasp2--------------------------------------------------------------
grasp2 <- GRASP2()
grasp2

## ----lkp-----------------------------------------------------------------
variant <- tbl(grasp2, "variant")
q1 = (variant %>% select(Pvalue, NegativeLog10PBin) %>%
       filter(NegativeLog10PBin > 8) %>% 
       summarize(maxp = max(Pvalue), n=n()))
q1

## ----lkex----------------------------------------------------------------
explain(q1)

## ----lkp2----------------------------------------------------------------
study <- tbl(grasp2, "study")
large_effect <- 
    variant %>% select(PMID, SNPid_dbSNP134, NegativeLog10PBin) %>% 
        filter(NegativeLog10PBin > 5)
phenotype <-
    left_join(large_effect,
              study %>% select(PMID, PaperPhenotypeDescription))
phenotype

## ----doasth--------------------------------------------------------------
lkaw <- semi_join(
    variant %>%
        filter(NegativeLog10PBin <= 4) %>% 
        select(PMID, chr_hg19, SNPid_dbSNP134, PolyPhen2),
    study %>% filter(PaperPhenotypeDescription == "Asthma"))

## ----dogre---------------------------------------------------------------
lkaw %>% filter(PolyPhen2 %like% "%amaging%")

## ----lkbasic-------------------------------------------------------------
grasp2

## ----lkcon---------------------------------------------------------------
gcon = grasp2$con
library(RSQLite)
gcon
dbListTables(gcon)

## ----getgw---------------------------------------------------------------
library(gwascat)
data(gwrngs19)  # hg19 addresses; NHGRI ships hg38
gwrngs19

## ----lkanti--------------------------------------------------------------
gr22 = variant %>% filter(chr_hg19 == "22")
abs22 = checkAnti("22")
1 - (abs22 %>% nrow()) / 
    (gr22 %>% count %>% collect %>% `[[`("n"))

## ----lkabs---------------------------------------------------------------
abs22

