# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----include=FALSE, echo=FALSE, results="hide", warning=FALSE-----------------
suppressPackageStartupMessages({
library(rgoslin)
library(dplyr)
library(knitr)
library(kableExtra)
})
scrollBoxWidth <- "650px"

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("rgoslin")

## ----eval = FALSE-------------------------------------------------------------
# library(rgoslin)

## -----------------------------------------------------------------------------
listAvailableGrammars()

## -----------------------------------------------------------------------------
isValidLipidName("PC 32:1")

## -----------------------------------------------------------------------------
df <- parseLipidNames("PC 32:1")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(df %>% select(-starts_with("FA"),-starts_with("LCB")), caption = "Lipid name parsing results for PC 32:1, FA and LCB columns omitted, since they are unpopulated (`NA`) on the lipid species level.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "150px")

## -----------------------------------------------------------------------------
originalName <- "TG(16:1(5E)/18:0/20:2(3Z,6Z))"
tagDf <- parseLipidNames(originalName, grammar = "LipidMaps")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(tagDf %>% select(-starts_with("FA"),-starts_with("LCB")), caption = "Lipid name parsing results for TG isomeric subspecies, FA and LCB columns omitted for brevity.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "200px")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(tagDf %>% select(Normalized.Name, starts_with("FA"),starts_with("LCB")), caption = "Lipid name parsing results for TG isomeric subspecies with FA and LCB columns.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "200px")

## -----------------------------------------------------------------------------
multipleLipidNamesDf <- parseLipidNames(c("PC 32:1","LPC 34:1","TG(18:1_18:0_16:1)"))

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(multipleLipidNamesDf %>% select(-starts_with("FA"),-starts_with("LCB")), caption = "Lipid name parsing results for PC 32:1, LPC 34:1, TG(18:1_18:0_16:1), FA and LCB columns omitted for brevity.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(multipleLipidNamesDf %>% select(Normalized.Name, starts_with("FA"), starts_with("LCB")), caption = "Lipid name parsing results for PC 32:1, LPC 34:1, TG(18:1_18:0_16:1) with FA and LCB columns.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## -----------------------------------------------------------------------------
originalNames <- c("PC 32:1","LPC 34:1","TAG 18:1_18:0_16:1")
multipleLipidNamesWithGrammar <- parseLipidNames(originalNames, grammar = "Goslin")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(multipleLipidNamesWithGrammar %>% select(-starts_with("FA"),-starts_with("LCB")), caption = "Lipid name parsing results for Goslin grammar and lipids PC 32:1, LPC 34:1, TG(18:1_18:0_16:1), FA and LCB columns omitted for brevity.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(multipleLipidNamesWithGrammar %>% select(Normalized.Name, starts_with("FA"), starts_with("LCB")), caption = "Lipid name parsing results for Goslin grammar and lipids PC 32:1, LPC 34:1, TG(18:1_18:0_16:1) with FA and LCB columns.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## -----------------------------------------------------------------------------
originalNames <- c("LMFA01020216"="5-methyl-octadecanoic acid", "LMFA08040030"="N-((+/-)-8,9-dihydroxy-5Z,11Z,14Z-eicosatrienoyl)-ethanolamine")
normalizedFattyAcidsNames <- parseLipidNames(originalNames, "FattyAcids")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(normalizedFattyAcidsNames %>% select(-starts_with(c("LCB","FA2","FA3","FA4","Adduct", "Adduct.Charge"))), caption = "Lipid name parsing results for Goslin grammar and fatty acids 5-methyl-octadecanoic acid N-((+/-)-8,9-dihydroxy-5Z,11Z,14Z-eicosatrienoyl)-ethanolamine, some columns omitted for brevity.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## -----------------------------------------------------------------------------
originalNames <- c("PC 32:1[M+H]1+", "PC 32:1 [M+H]+","PC 32:1")
lipidNamesWithAdduct <- parseLipidNames(originalNames, "Goslin")

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(lipidNamesWithAdduct %>% select(-starts_with("FA"),-starts_with("LCB")), caption = "Lipid name parsing results for Goslin grammar and lipids PC 32:1[M+H]1+, PC 32:1 [M+H]+ and PC 32:1, FA and LCB columns omitted for brevity.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("lipidr")

## ----eval = FALSE-------------------------------------------------------------
# library(rgoslin)
# library(lipidr)
# library(stringr)
# library(ggplot2)

## ----include=FALSE, echo=FALSE, results="hide", warning=FALSE-----------------
suppressPackageStartupMessages({
library(lipidr)
library(stringr)
library(ggplot2)
})

## -----------------------------------------------------------------------------
datadir = system.file("extdata", package="lipidr")
filelist = list.files(datadir, "data.csv", full.names = TRUE) # all csv files
d = read_skyline(filelist)
clinical_file = system.file("extdata", "clin.csv", package="lipidr")
d = add_sample_annotation(d, clinical_file)

## ----echo = FALSE, results = 'asis'-------------------------------------------
kable(rowData(d[1:10, 1:10]), caption = "Subset of first ten rows of row data.") %>% kable_styling(bootstrap_options = c("striped", "hover", "condensed", font_size = 7)) %>% scroll_box(width = scrollBoxWidth, height = "300px")

## -----------------------------------------------------------------------------
lipidNames <- parseLipidNames(rowData(d)$clean_name)

## -----------------------------------------------------------------------------
# lipidr stores original lipid names in the Molecule column
old_names <- rowData(d)$Molecule
# split lipid prefix from potential (d7) suffix for labeled internal standards
new_names <- rowData(d)$clean_name %>% str_match(pattern="([\\w :-]+)(\\(\\w+\\))?")
# extract the first match group (the original word is at column index 1)
normalized_new_names <- new_names[,2] %>% str_replace_all(c("Sa1P"="SPBP","So1P"="SPBP")) %>% parseLipidNames(.)

## -----------------------------------------------------------------------------
updated <- update_molecule_names(d, old_names, normalized_new_names$Normalized.Name)

## -----------------------------------------------------------------------------
rowData(updated)$Class <- normalized_new_names$Lipid.Maps.Main.Class
rowData(updated)$Category <- normalized_new_names$Lipid.Maps.Category
rowData(updated)$Molecule <- normalized_new_names$Normalized.Name
rowData(updated)$LipidSpecies <- normalized_new_names$Species.Name
rowData(updated)$Mass <- normalized_new_names$Mass
rowData(updated)$SumFormula <- normalized_new_names$Sum.Formula
# select Ceramides, Lyso-Phosphatidylcholines and Phosphatidylcholines (includes plasmanyls and plasmenyls)
lipid_classes <- rowData(updated)$Class %in% c("Cer","LPC", "PC")
d <- updated[lipid_classes,]

## -----------------------------------------------------------------------------
ddf <- lipidr:::to_long_format(d)
ggplot(data=ddf, mapping=aes(x=Molecule, y=Area, fill=Class)) + geom_boxplot() + facet_wrap(~filename, scales = "free_y") + scale_y_log10() + coord_flip()

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

