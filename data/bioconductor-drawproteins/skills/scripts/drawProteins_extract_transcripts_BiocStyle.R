# Code example from 'drawProteins_extract_transcripts_BiocStyle' vignette. See references/ for full tutorial.

## ----load_packages, eval = TRUE, echo=FALSE-----------------------------------
library(BiocStyle)
library(drawProteins)
library(ggplot2)
library(knitr)
opts_chunk$set(comment=NA,
                fig.align = "center",
                out.width = "100%",
                dpi = 100)

## ----load_NFkappaB_data, fig.height=10, fig.wide = TRUE-----------------------
# load up data for five NF-kappaB proteins
data("five_rel_data")
max(five_rel_data$order)
# returns 5

# use extract_transcripts() to create a new data frame
prot_data <- extract_transcripts(five_rel_data)
max(prot_data$order)
# returns 7

## ----check_chains, fig.height=10, fig.wide = TRUE-----------------------------
p1 <- draw_canvas(five_rel_data)
p1 <- draw_chains(p1, five_rel_data)
p1 <- p1 + ggtitle("Five chains plotted")

p2 <- draw_canvas(prot_data)
p2 <- draw_chains(p2, prot_data)
p2 <- p2 + ggtitle("Seven chains plotted")

p1
p2

## ----draw_domains_and_phospho, fig.height=10, fig.wide = TRUE-----------------
p2 <- draw_domains(p2, prot_data)
p2 <- draw_phospho(p2, prot_data, size =8) 
p2


## ----draw_canvas_and_chains, fig.height=8, fig.wide = TRUE--------------------
p2 <- draw_canvas(prot_data)
p2 <- draw_chains(p2, prot_data,
            fill = "lightsteelblue1", 
            outline = "grey",
            labels = c("p105",
                        "p105",
                        "p100", 
                        "p100",
                        "Rel B",
                        "c-Rel", 
                        "p65/Rel A",
                        "p50",
                        "p52"),
            label_size = 5)
p2 <- draw_phospho(p2, prot_data, size = 8, fill = "red")
p2 + theme_bw()

## ----session_Info, echo=FALSE-------------------------------------------------
sessionInfo()

