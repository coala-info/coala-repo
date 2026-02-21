# Code example from 'drawProteins_BiocStyle' vignette. See references/ for full tutorial.

## ----load_packages, eval = TRUE, echo=FALSE-----------------------------------
library(BiocStyle)
library(drawProteins)
library(httr)
library(ggplot2)
library(knitr)
opts_chunk$set(comment=NA,
                fig.align = "center",
                out.width = "100%",
                dpi = 100)

## ----download_rel_json, eval=TRUE, echo=TRUE----------------------------------
# accession numbers of rel A
    drawProteins::get_features("Q04206") ->
    rel_json

## ----generate_dataframe-------------------------------------------------------
drawProteins::feature_to_dataframe(rel_json) -> rel_data

# show in console
head(rel_data[1:4])


## ----using_draw_canvas, fig.height=3, fig.wide = TRUE-------------------------
draw_canvas(rel_data) -> p
p

## ----using draw_chains, fig.height=3, fig.wide = TRUE-------------------------
p <- draw_chains(p, rel_data)
p

## ----using draw_domains, fig.height=3, fig.wide = TRUE------------------------
p <- draw_domains(p, rel_data)
p

## ----white_background, fig.height=3, fig.wide = TRUE--------------------------
# white background and remove y-axis
p <- p + theme_bw(base_size = 20) + # white background
    theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank()) +
    theme(axis.ticks = element_blank(), 
        axis.text.y = element_blank()) +
    theme(panel.border = element_blank())
p

## ----show_draw_regions, fig.height=3, fig.wide = TRUE-------------------------
draw_regions(p, rel_data) # adds activation domain


## ----show_draw_repeat, fig.height=3, fig.wide = TRUE--------------------------
draw_repeat(p, rel_data) # doesn't add anything in this case


## ----show_draw_motif, fig.height=3, fig.wide = TRUE---------------------------
draw_motif(p, rel_data) # adds 9aa Transactivation domain & NLS

## ----show_draw_phospho, fig.height=3, fig.wide = TRUE-------------------------
# add phosphorylation sites from Uniprot
draw_phospho(p, rel_data, size = 8)

## ----relA_workflow, fig.height=3.5, fig.wide = TRUE---------------------------
draw_canvas(rel_data) -> p
p <- draw_chains(p, rel_data)
p <- draw_domains(p, rel_data)
p <- draw_regions(p, rel_data)
p <- draw_motif(p, rel_data)
p <- draw_phospho(p, rel_data, size = 8) 

p <- p + theme_bw(base_size = 20) + # white backgnd & change text size
    theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank()) +
    theme(axis.ticks = element_blank(), 
        axis.text.y = element_blank()) +
    theme(panel.border = element_blank())
p

## ----add_titles, fig.height=4, fig.wide = TRUE--------------------------------
# add titles
rel_subtitle <- paste0("circles = phosphorylation sites\n",
                "RHD = Rel Homology Domain\nsource:Uniprot")

p <- p + labs(title = "Rel A/p65",
                subtitle = rel_subtitle)
p

## ----five_NFkappaB, fig.height=10, fig.wide = TRUE----------------------------
# accession numbers of five NF-kappaB proteins
prot_data <- drawProteins::get_features("Q04206 Q01201 Q04864 P19838 Q00653")
prot_data <- drawProteins::feature_to_dataframe(prot_data)
    

p <- draw_canvas(prot_data)
p <- draw_chains(p, prot_data)
p <- draw_domains(p, prot_data)
p <- draw_repeat(p, prot_data)
p <- draw_motif(p, prot_data)
p <- draw_phospho(p, prot_data, size = 8)

# background and y-axis
p <- p + theme_bw(base_size = 20) + # white backgnd & change text size
    theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
    theme(axis.ticks = element_blank(),
        axis.text.y = element_blank()) +
    theme(panel.border = element_blank())

# add titles
rel_subtitle <- paste0("circles = phosphorylation sites\n",
                "RHD = Rel Homology Domain\nsource:Uniprot")

p <- p + labs(title = "Schematic of human NF-kappaB proteins",
                subtitle = rel_subtitle)


# move legend to top
p <- p + theme(legend.position="top") + labs(fill="")
p

## ----customising, fig.height=6, fig.wide = TRUE-------------------------------
data("five_rel_data")
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data, 
            label_chains = FALSE,
            fill = "hotpink", 
            outline = "midnightblue")
p

## ----custom_phospho, fig.height=8, fig.wide = TRUE----------------------------
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data, 
            fill = "lightsteelblue1", 
            outline = "grey", 
            label_size = 5) 
p <- draw_phospho(p, five_rel_data, size = 10, fill = "red")
p + theme_bw()

## ----change_labels, fig.height=8, fig.wide = TRUE-----------------------------
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data, 
            fill = "lightsteelblue1", 
            outline = "grey",
            labels = c("p50/p105",
                        "p50/p105",
                        "p52/p100", 
                        "p52/p100",
                        "Rel B",
                        "c-Rel", 
                        "p65/Rel A"),
            label_size = 5) 
p <- draw_phospho(p, five_rel_data, size = 8, fill = "red")
p + theme_bw()

## ----session_Info, echo=FALSE-------------------------------------------------
sessionInfo()

