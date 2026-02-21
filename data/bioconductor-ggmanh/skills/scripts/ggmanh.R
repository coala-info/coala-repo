# Code example from 'ggmanh' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(crop = NULL)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("ggmanh")

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4
)

## ----setup--------------------------------------------------------------------
library(ggmanh)
library(SeqArray)

## ----simulated_data-----------------------------------------------------------
set.seed(1000)

nsim <- 50000

simdata <- data.frame(
  "chromosome" = sample(c(1:22,"X"), size = nsim, replace = TRUE),
  "position" = sample(1:100000000, size = nsim),
  "P.value" = rbeta(nsim, shape1 = 5, shape2 = 1)^7
)

## ----showsimdata--------------------------------------------------------------
head(simdata)

## ----order_chrom--------------------------------------------------------------
simdata$chromosome <- factor(simdata$chromosome, c(1:22,"X"))

## ----manh_minimum-------------------------------------------------------------
g <- manhattan_plot(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", plot.title = "Simulated P.Values", y.label = "P")
g

## ----simdata_w_signif---------------------------------------------------------
tmpdata <- data.frame(
  "chromosome" = c(rep(5, 10), rep(21, 5)),
  "position" = c(sample(250000:250100, 10, replace = FALSE), sample(590000:600000, 5, replace = FALSE)),
  "P.value" = c(10^-(rnorm(10, 100, 3)), 10^-rnorm(5, 9, 1))
)

simdata <- rbind(simdata, tmpdata)
simdata$chromosome <- factor(simdata$chromosome, c(1:22,"X"))

## ----manh_badscale------------------------------------------------------------
g <- manhattan_plot(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", plot.title = "Simulated P.Values - Significant", rescale = FALSE)
g

## ----manh_goodscale-----------------------------------------------------------
g <- manhattan_plot(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", plot.title = "Simulated P.Values - Significant", rescale = TRUE)
g

## ----label_data---------------------------------------------------------------
sig <- simdata$P.value < 5e-07

simdata$label <- ""
simdata$label[sig] <- sprintf("Label: %i", 1:sum(sig))

## ----plot_labelled_data_biglabel----------------------------------------------
simdata$label2 <- ""
i <- (simdata$chromosome == 5) & (simdata$P.value < 5e-8)
simdata$label2[i] <- paste("Chromosome 5 label", 1:sum(i))

mpdata <- manhattan_data_preprocess(x = simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position")

g <- manhattan_plot(x = mpdata, label.colname = "label", plot.title = "Simulated P.Values with labels")
g

g <- manhattan_plot(x = mpdata, label.colname = "label2", label.font.size = 2, plot.title = "Simulated P.Values with labels", max.overlaps = Inf, force = 5)
g

## ----highlight chromosome-----------------------------------------------------
simdata$color <- "Not Significant"
simdata$color[simdata$P.value <= 5e-8] <- "Significant"

highlight_colormap <- c("Not Significant" = "grey", "Significant" = "black")

tmp <- manhattan_data_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  highlight.colname = "color", highlight.col = highlight_colormap
)

g_nohighlight <- manhattan_plot(tmp, plot.title = "No Highlight Points")
g <- manhattan_plot(tmp, plot.title = "Highlight Points", color.by.highlight = TRUE)
g_nohighlight
g

## ----chromosome---------------------------------------------------------------
manhattan_plot(simdata, chromosome = 5, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position")

## -----------------------------------------------------------------------------
binned_manhattan_plot(simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position")

## -----------------------------------------------------------------------------
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", 
  bins.x = 7, # number of bins for the "widest" chromosome, either calculated by position or by number of variants
  bins.y = 100, # number of vertical bins
  show.legend = FALSE, plot.title = "Binned Manhattan Plot"
)

## -----------------------------------------------------------------------------
mpdat <- binned_manhattan_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  bins.x = 7, bins.y = 100,
  chr.gap.scaling = 0.5, # scaling factor for chromo some gap
  show.message = FALSE # this suppresses some warning messages built into the function
)

binned_manhattan_plot(mpdat, bin.outline = TRUE)

## ----error=TRUE---------------------------------------------------------------
try({
# using discrete palette for continuous
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", 
  bins.x = 7, bins.y = 100, show.legend = FALSE, plot.title = "Binned Manhattan Plot",
  bin.palette = "Polychrome::dark", # choose bin palette
  palette.direction = -1 # set to -1 for reverse palette direction
)
})

## -----------------------------------------------------------------------------
# using discrete palette for discrete
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", 
  highlight.colname = "chromosome", chr.gap.scaling = 0.4,
  bins.x = 7, bins.y = 100, 
  show.legend = FALSE, # choose not to show legend
  plot.title = "Binned Manhattan Plot",
  bin.palette = "Polychrome::dark", palette.direction = -1
)

## -----------------------------------------------------------------------------
# using continuous palette for continuous variable
binned_manhattan_plot(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", 
  chr.gap.scaling = 0.4,
  bins.x = 7, bins.y = 100, show.legend = FALSE, plot.title = "Binned Manhattan Plot",
  bin.palette = "pals::kovesi.isoluminant_cm_70_c39", palette.direction = -1
)

## -----------------------------------------------------------------------------
tmp <- manhattan_data_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position"
)

mpdata <- binned_manhattan_preprocess(
  simdata, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position",
  bins.x = 7, bins.y = 100, chr.gap.scaling = 0.5,
  # summary expression list
  summarise.expression.list = list(
    max_log10p ~ max(-log10(P.value)), # creates column "min_log10p", which holds the maximum -log10(P.value) among the variants inside the bin
    signif ~ ifelse(max(P.value) < 5e-8, "Significant", "Not Significant") # creates column "signif" which indicates significance of the bin
  )
)

print(head(mpdata$data))

binned_manhattan_plot(
  mpdata, bin.palette = "Polychrome::dark", bin.alpha = 1, bin.outline = TRUE,
  highlight.colname = "signif", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot"
)

binned_manhattan_plot(
  mpdata, bin.palette = "viridis::inferno", bin.alpha = 1, bin.outline = TRUE,
  bin.outline.alpha = 0.3,
  highlight.colname = "max_log10p", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot"
)

## -----------------------------------------------------------------------------
binned_manhattan_plot(
  mpdata, bin.palette = "viridis::inferno", bin.alpha = 1, bin.outline = TRUE,
  bin.outline.alpha = 0.3,
  highlight.colname = "max_log10p", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot",
  plot.subtitle = "Default nonsignif value = NA",
  nonsignif.default = NA
)

binned_manhattan_plot(
  mpdata, bin.palette = "viridis::inferno", bin.alpha = 1, bin.outline = TRUE,
  bin.outline.alpha = 0.3,
  highlight.colname = "max_log10p", signif.lwd = 0.5, plot.title = "Binned Manhattan Plot",
  plot.subtitle = "Default nonsignif value = 0",
  nonsignif.default = 0
)

## ----locate_gds, results="hide"-----------------------------------------------
default_gds_path <- system.file("extdata", "gnomad.exomes.vep.hg19.v5.gds", mustWork = TRUE, package = "ggmanh")
print(default_gds_path)

gds <- SeqArray::seqOpen(default_gds_path)
print(gds)
SeqArray::seqClose(gds)

## ----gds_annotation_demonstration---------------------------------------------
sampledata <- data.frame(
  chromosome = c(1, 17, 19, 22),
  position = c(12422750, 10366900, 43439739, 39710145), 
  Reference = c("A", "T", "T", "G"),
  Alternate = c("G", "G", "C", "A")
)
gds_annotate(
  sampledata, annot.method = "position", 
  chr = "chromosome", pos = "position", ref = "Reference", alt = "Alternate"
  )

## ----manhattan_label_with_gds-------------------------------------------------
simdata$Reference <- NA
simdata$Alternate <- NA
simdata <- simdata[,c("chromosome", "position", "Reference", "Alternate", "P.value")]
sampledata$P.value <- 10^-rnorm(4, 14, 1)
sampledata <- sampledata[c("chromosome", "position", "Reference", "Alternate", "P.value")]
simdata_label <- rbind(simdata, sampledata)

# add annotation
simdata_label$label <- gds_annotate(x = simdata_label, annot.method = "position", chr = "chromosome", pos = "position", ref = "Reference", alt = "Alternate")

manhattan_plot(simdata_label, outfn = NULL, pval.colname = "P.value", chr.colname = "chromosome", pos.colname = "position", label.colname = "label")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

