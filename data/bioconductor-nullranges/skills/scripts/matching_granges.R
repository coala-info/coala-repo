# Code example from 'matching_granges' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, echo=FALSE, fig.width=8.5, fig.height=6.5, eval=FALSE----
# ## Define colors
# colors <- c("#e19995", "#adaf64", "#4fbe9b", "#6eb3d9", "#d098d7")
# 
# ## Create artificial GRanges
# library(GenomicRanges)
# set.seed(5)
# pool <- GRanges(seqnames = "chr1",
#                 ranges = IRanges(start = sample(1:800, 120, replace = TRUE),
#                                  width = sample(25:200, 120, replace = TRUE)),
#                 color = sample(1:5, 120, replace = TRUE))
# focal <- GRanges(seqnames = "chr1",
#                  ranges = IRanges(start = sample(1:800, 16, replace = TRUE),
#                                   width = sample(25:200, 16, replace = TRUE)),
#                  color = sample(1:5, 16, replace = TRUE))
# 
# ## Add width to metadata
# pool$length <- width(pool)
# focal$length <- width(focal)
# 
# ## Match ranges
# library(nullranges)
# set.seed(123)
# x <- matchRanges(focal = focal,
#                  pool = pool,
#                  covar = ~color + length,
#                  method = 'n', replace = TRUE)
# 
# ## Visualize sets
# library(plotgardener)
# library(grid)
# set.seed(123)
# pageCreate(width = 8.5, height = 6.5, showGuides = FALSE, xgrid = 0, ygrid = 0)
# 
# ## Define common parameters
# p <- pgParams(chrom = "chr1", chromstart = 1, chromend = 1000)
# 
# ## Pool set
# poolSet <- plotRanges(data = pool, params = p,
#                          x = 1, y = 1, width = 2.5, height = 2.5,
#                          fill = colors,
#                          colorby = colorby("color"))
# annoGenomeLabel(plot = poolSet, x = 1, y = 3.55)
# plotText(label = "Pool Set",
#             x = 2.25, y = 0.9,
#             just = c("center", "bottom"),
#             fontcolor = "#33A02C",
#             fontface = "bold",
#             fontfamily = 'mono')
# 
# ## Focal set
# focalSet <- plotRanges(data = focal, params = p,
#                           x = 5, y = 1, width = 2.5, height = 1,
#                           fill = colors,
#                           colorby = colorby("color"))
# annoGenomeLabel(plot = focalSet, x = 5, y = 2.05)
# plotText(label = "Focal Set",
#             x = 6.25, y = 0.9,
#             just = c("center", "bottom"),
#             fontcolor = "#1F78B4",
#             fontface = "bold",
#             fontfamily = 'mono')
# 
# 
# ## Matched set
# matchedSet <- plotRanges(data = matched(x), params = p,
#                             x = 5, y = 2.5, width = 2.5, height = 1,
#                             fill = colors,
#                             colorby = colorby("color"))
# annoGenomeLabel(plot = matchedSet, x = 5, y = 3.55)
# plotText(label = "Matched Set",
#             x = 6.25, y = 2.75,
#             just = c("center", "bottom"),
#             fontcolor = "#A6CEE3",
#             fontface = "bold",
#             fontfamily = 'mono')
# 
# 
# ## Arrow and matchRanges label
# plotSegments(x0 = 3.5, y0 = 3,
#                 x1 = 5, y1 = 3,
#                 arrow = arrow(type = "closed", length = unit(0.1, "inches")),
#                 fill = "black", lwd = 2)
# plotText(label = "matchRanges()", fontfamily = 'mono',
#             x = 4.25, y = 2.9, just = c("center", "bottom"))
# 
# 
# 
# ## Matching plots
# library(ggplot2)
# smallText <- theme(legend.title = element_text(size=8),
#                    legend.text=element_text(size=8),
#                    title = element_text(size=8),
#                    axis.title.x = element_text(size=8),
#                    axis.title.y = element_text(size=8))
# 
# plot1 <-
#   plotPropensity(x, sets=c('f','m','p')) +
#   smallText +
#   theme(legend.key.size = unit(0.5, 'lines'),
#         title = element_blank())
# 
# plot2 <-
#   plotCovariate(x=x, covar=covariates(x)[1], sets=c('f','m','p')) +
#   smallText +
#   theme(legend.text = element_blank(),
#         legend.position = 'none')
# 
# plot3 <-
#   plotCovariate(x=x, covar=covariates(x)[2], sets=c('f','m','p'))+
#   smallText +
#   theme(legend.key.size = unit(0.5, 'lines'))
# 
# 
# ## Propensity scores
# plotText(label = "plotPropensity()",
#             x = 1.10, y = 4.24,
#             just = c("left", "bottom"),
#             fontface = "bold",
#             fontfamily = 'mono')
# plotText(label = "~color + length",
#             x = 1.25, y = 4.5,
#             just = c("left", "bottom"),
#             fontsize = 10,
#             fontfamily = "mono")
# plotGG(plot = plot1,
#           x = 1, y = 4.5, width = 2.5, height = 1.5,
#           just = c("left", "top"))
# 
# ## Covariate balance
# plotText(label = "plotCovariate()",
#             x = 3.75, y = 4.24,
#             just = c("left", "bottom"),
#             fontface = "bold",
#             fontfamily = "mono")
# plotText(label = covariates(x),
#             x = c(4, 5.9), y = 4.5,
#             just = c("left", "bottom"),
#             fontsize = 10,
#             fontfamily = "mono")
# plotGG(plot = plot2,
#           x = 3.50, y = 4.5, width = 1.8, height = 1.5,
#           just = c("left", "top"))
# 
# plotGG(plot = plot3,
#           x = 5.30, y = 4.5, width = 2.75, height = 1.5,
#           just = c("left", "top"))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(nullrangesData)

## Load example data
bins <- hg19_10kb_bins()

bins

## -----------------------------------------------------------------------------
library(nullranges)

## Match ranges
set.seed(123)
mgr <- matchRanges(focal = bins[bins$looped],
                   pool = bins[!bins$looped],
                   covar = ~dnaseSignal + n_dnase_sites)
mgr

## ----message=FALSE, warning=FALSE---------------------------------------------
library(GenomicRanges)
library(plyranges)
library(ggplot2)

## Summarize ctcfSignal by n_ctcf_sites
mgr %>%
  group_by(n_ctcf_sites) %>%
  summarize(ctcfSignal = mean(ctcfSignal)) %>%
  as.data.frame() %>%
  ggplot(aes(x = n_ctcf_sites, y = ctcfSignal)) +
    geom_line() +
    geom_point(shape = 21, stroke = 1,  fill = 'white') +
    theme_minimal() +
    theme(panel.border = element_rect(color = 'black',
                                      fill = NA))

## -----------------------------------------------------------------------------
overview(mgr)

## ----message=FALSE------------------------------------------------------------
plotPropensity(mgr, sets = c('f', 'p', 'm'), type = 'ridges')

## ----message=FALSE, warning=FALSE, fig.height=6, fig.width=5------------------
library(patchwork)
plots <- lapply(covariates(mgr), plotCovariate, x=mgr, sets = c('f', 'm', 'p'))
Reduce('/', plots)

## -----------------------------------------------------------------------------
tidy_gr <- bind_ranges(
  looped_focal=focal(mgr),
  unlooped_pool=pool(mgr),
  unlooped_matched=mgr, .id="type"
)

## -----------------------------------------------------------------------------
cols <- c(looped_focal="#1F78B4",
          unlooped_matched="#A6CEE3",
          unlooped_pool="#33A02C")

## ----fig.width=4.5, fig.height=5----------------------------------------------
tidy_gr %>%
  group_by(type) %>%
  summarize(CTCF_occupied = 100*mean(n_ctcf_sites >= 1)) %>%
  as.data.frame() %>%
  ggplot(aes(type, CTCF_occupied, fill=type)) +
  geom_col(show.legend = FALSE) +
  ylab("CTCF occupied bins (%)") +
  scale_fill_manual(values=cols) +
  ggtitle("CTCF occupancy")

## -----------------------------------------------------------------------------
sessionInfo()

