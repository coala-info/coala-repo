# Code example from 'database-explore' vignette. See references/ for full tutorial.

## ----setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)
suppressPackageStartupMessages(library(metagenomeFeatures)) 
suppressPackageStartupMessages(library(ggtree))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(forcats))

## ----eval=FALSE------------------------------------------------------------
#  library(metagenomeFeatures)
#  library(dplyr)
#  library(forcats)
#  library(ggplot2)
#  library(ggtree)

## --------------------------------------------------------------------------
gg85 <- get_gg13.8_85MgDb()

gamma_16S <- mgDb_select(gg85, 
                          type = "all", 
                          keys = "Gammaproteobacteria", 
                          keytype = "Class")

## --------------------------------------------------------------------------
## Per genus count data
gamma_df <- gamma_16S$taxa %>% 
    group_by(Genus) %>% 
    summarise(Count = n()) %>% 
    ungroup() %>% 
    mutate(Genus = fct_reorder(Genus, Count)) 

## Count info for text 
escherichia_count <- gamma_df$Count[gamma_df$Genus == "g__Escherichia"]

## excluding unassigned genera and genera with only one assigned sequence
gamma_trim_df <- gamma_df %>% filter(Genus != "g__", Count > 1)

## ----generaCount, fig.cap = "Number of seqeunces assigned to genera in the Class Gammaproteobacteria. Only Genera with more than one assigned sequence are shown.", fig.width = 6, fig.height = 6----
 ggplot(gamma_trim_df) + 
    geom_bar(aes(x = Genus, y = Count), stat = "identity") + 
    labs(y = "Number of OTUs") + 
    coord_flip() + 
    theme_bw() 

## ----annoTree, fig.cap = "Phylogenetic tree of Gammaproteobacteria class OTU representative sequences.", fig.height = 8, fig.width = 6, message = FALSE----

genus_lab <- paste0("g__", c("","Stenotrophomonas", "Pseudomonas"))
genus_anno_df <- gamma_16S$taxa %>% 
    group_by(Genus) %>% 
    mutate(Count = n()) %>% 
    ungroup() %>% 
    mutate(Genus_lab = if_else(Count > 3, Genus, ""))

ggtree(gamma_16S$tree) %<+% 
    genus_anno_df + 
    ## Add taxa name for unlabeled Stenotrophomonas branch
    geom_tippoint(aes(color = Genus_lab), size = 3) + 
    scale_color_manual(values = c("#FF000000","darkorange", "blue", "green", "tan", "black")) +
    theme(legend.position = "bottom") + 
    labs(color = "Genus")

## --------------------------------------------------------------------------
gamma_16S$seq

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

