# Code example from 'BioCartaImage' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = FALSE------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    fig.width = 7,
    fig.height = 7,
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    crop = NULL
)

## ----echo = FALSE-------------------------------------------------------------
knitr::knit_hooks$set(pngquant = knitr::hook_pngquant)

knitr::opts_chunk$set(
  message = FALSE,
  dev = "ragg_png",
  fig.align = "center",
  pngquant = "--speed=10 --quality=30"
)

## -----------------------------------------------------------------------------
system.file("script", "process.R", package = "BioCartaImage")

## -----------------------------------------------------------------------------
library(BioCartaImage)
ap = all_pathways()
length(ap)
head(ap)

## -----------------------------------------------------------------------------
p = get_pathway("h_RELAPathway")
p

## -----------------------------------------------------------------------------
# MSigDB ID
get_pathway("BIOCARTA_RELA_PATHWAY")

## -----------------------------------------------------------------------------
str(p)

## -----------------------------------------------------------------------------
genes_in_pathway("h_RELAPathway")
genes_in_pathway(p)

## ----crop = NULL--------------------------------------------------------------
library(grid)
grid.newpage()
grid.biocarta("h_RELAPathway", color = c("1387" = "yellow"))

## ----crop = NULL--------------------------------------------------------------
grid.newpage()
grid.biocarta("h_RELAPathway", 
    x = unit(0.2, "npc"), y = unit(0.9, "npc"),
    just = c("left", "top"),
    color = c("1387" = "yellow"),
    width = unit(6, "cm"))

## ----crop = NULL--------------------------------------------------------------
grid.newpage()
pushViewport(viewport(width = 0.7, height = 0.5))
grid.biocarta("h_RELAPathway", color = c("1387" = "yellow"))
popViewport()

## ----crop = NULL--------------------------------------------------------------
grid.newpage()
grid.biocarta("h_RELAPathway", color = c("1387" = "yellow"))

## -----------------------------------------------------------------------------
grob = biocartaGrob("h_RELAPathway")

## ----crop = NULL--------------------------------------------------------------
grid.newpage()
grob2 = mark_gene(grob, "1387", function(x, y) {
    pos = pos_by_polygon(x, y, where = "left")
    pointsGrob(pos[1], pos[2], default.units = "native",
        pch = 16, gp = gpar(col = "yellow"))
})
grid.draw(grob2)

## ----crop = NULL--------------------------------------------------------------
grid.newpage()
grob3 = mark_gene(grob, "1387", function(x, y) {
    pos = pos_by_polygon(x, y, where = "left")
    grid.points(pos[1], pos[2], default.units = "native",
        pch = 16, gp = gpar(col = "yellow"))
}, capture = TRUE)
grid.draw(grob3)

## ----crop = NULL--------------------------------------------------------------
grid.newpage()
grob4 = mark_gene(grob, "1387", function(x, y) {
    pos = pos_by_polygon(x, y)
    pushViewport(viewport(x = pos[1] - 10, y = pos[2], 
        width = unit(4, "cm"), height = unit(4, "cm"), 
        default.units = "native", just = "right"))
    grid.rect(gp = gpar(fill = "red"))
    grid.text("add whatever\nyou want here")
    popViewport()
}, capture = TRUE)
grid.draw(grob4)

## -----------------------------------------------------------------------------
sessionInfo()

