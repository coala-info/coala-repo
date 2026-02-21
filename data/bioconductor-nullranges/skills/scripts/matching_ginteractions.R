# Code example from 'matching_ginteractions' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, echo=FALSE, fig.width=8.5, fig.height=6.5, eval=FALSE----
# ## Define colors
# colors <- c("#e19995", "#adaf64", "#4fbe9b", "#6eb3d9", "#d098d7")
# ## Create artificial GInteractions
# library(InteractionSet)
# set.seed(5)
# pool <- GInteractions(
#   anchor1 = GRanges(seqnames = "chr1",
#                     ranges = IRanges(start = sample(1:990, 120, replace = TRUE),
#                                      width = 10)),
#   anchor2 = GRanges(seqnames = "chr1",
#                     ranges = IRanges(start = sample(1:990, 120, replace = TRUE),
#                                      width = 10)),
#   mode = "strict",
#   color = sample(1:5, 120, replace = TRUE)
# )
# focal <- GInteractions(
#   anchor1 = GRanges(seqnames = "chr1",
#                     ranges = IRanges(start = sample(1:990, 16, replace = TRUE),
#                                      width = 10)),
#   anchor2 = GRanges(seqnames = "chr1",
#                     ranges = IRanges(start = sample(1:990, 16, replace = TRUE),
#                                      width = 10)),
#   mode = "strict",
#   color = sample(1:5, 16, replace = TRUE)
# )
# ## Add distance to metadata
# pool$distance <- pairdist(pool)
# focal$distance <- pairdist(focal)
# ## Match ranges
# library(nullranges)
# set.seed(123)
# x <- matchRanges(focal = focal,
#                  pool = pool,
#                  covar = ~color + distance,
#                  method = 'n', replace = TRUE)
# ## Visualize sets
# library(plotgardener)
# library(grid)
# set.seed(123)
# pageCreate(width = 8.5, height = 6.5, showGuides = FALSE, xgrid = 0, ygrid = 0)
# ## Define common parameters
# p <- pgParams(chrom = "chr1", chromstart = 1, chromend = 1000)
# ## Pool set
# poolSet <- plotPairs(data = pool,
#                      params = p,
#                      fill = colors[pool$color],
#                      x = 1, y = 1.25, width = 2.5, height = 2.25)
# annoGenomeLabel(plot = poolSet, x = 1, y = 3.55)
# plotText(label = "Pool Set",
#             x = 2.25, y = 0.9,
#             just = c("center", "bottom"),
#             fontcolor = "#33A02C",
#             fontface = "bold",
#             fontfamily = 'mono')
# ## Focal set
# focalSet <- plotPairs(data = focal,
#                          params = p,
#                          fill = colors[focal$color],
#                          x = 5, y = 1.1, width = 2.5, height = 0.9)
# annoGenomeLabel(plot = focalSet, x = 5, y = 2.05)
# plotText(label = "Focal Set",
#             x = 6.25, y = 0.9,
#             just = c("center", "bottom"),
#             fontcolor = "#1F78B4",
#             fontface = "bold",
#             fontfamily = 'mono')
# ## Matched set
# matchedSet <- plotPairs(data = x,
#                            params = p,
#                            fill = colors[x$color],
#                            x = 5, y = 2.6, width = 2.5, height = 0.9)
# annoGenomeLabel(plot = matchedSet, x = 5, y = 3.55)
# plotText(label = "Matched Set",
#             x = 6.25, y = 2.50,
#             just = c("center", "bottom"),
#             fontcolor = "#A6CEE3",
#             fontface = "bold",
#             fontfamily = 'mono')
# ## Arrow and matchRanges label
# plotSegments(x0 = 3.5, y0 = 3,
#                 x1 = 5, y1 = 3,
#                 arrow = arrow(type = "closed", length = unit(0.1, "inches")),
#                 fill = "black", lwd = 2)
# plotText(label = "matchRanges()", fontfamily = 'mono',
#             x = 4.25, y = 2.9, just = c("center", "bottom"))
# ## Matching plots
# library(ggplot2)
# smallText <- theme(legend.title = element_text(size=8),
#                    legend.text=element_text(size=8),
#                    title = element_text(size=8),
#                    axis.title.x = element_text(size=8),
#                    axis.title.y = element_text(size=8))
# plot1 <-
#   plotPropensity(x, sets=c('f','m','p')) +
#   smallText +
#   theme(legend.key.size = unit(0.5, 'lines'),
#         title = element_blank())
# plot2 <-
#   plotCovariate(x=x, covar=covariates(x)[1], sets=c('f','m','p')) +
#   smallText +
#   theme(legend.text = element_blank(),
#         legend.position = 'none')
# plot3 <-
#   plotCovariate(x=x, covar=covariates(x)[2], sets=c('f','m','p'))+
#   smallText +
#   theme(legend.key.size = unit(0.5, 'lines'))
# ## Propensity scores
# plotText(label = "plotPropensity()",
#             x = 1.10, y = 4.24,
#             just = c("left", "bottom"),
#             fontface = "bold",
#             fontfamily = 'mono')
# plotText(label = "~color + distance",
#             x = 1.25, y = 4.5,
#             just = c("left", "bottom"),
#             fontsize = 10,
#             fontfamily = "mono")
# plotGG(plot = plot1,
#           x = 1, y = 4.5, width = 2.5, height = 1.5,
#           just = c("left", "top"))
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
# plotGG(plot = plot3,
#           x = 5.30, y = 4.5, width = 2.75, height = 1.5,
#           just = c("left", "top"))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(nullrangesData)
## Load example data
binPairs <- hg19_10kb_ctcfBoundBinPairs()
binPairs

## ----message=FALSE, warning=FALSE---------------------------------------------
library(nullranges)
set.seed(123)
mgi <- matchRanges(focal = binPairs[binPairs$looped],
                   pool = binPairs[!binPairs$looped],
                   covar = ~ctcfSignal + distance + n_sites,
                   method = 'stratified')
mgi

## ----message=FALSE, warning=FALSE---------------------------------------------
library(plyranges)
library(ggplot2)
## Summarize ctcfSignal by n_sites
mgi %>%
  regions() %>%
  group_by(n_sites) %>%
  summarize(ctcfSignal = mean(ctcfSignal)) %>%
  as.data.frame() %>%
  ggplot(aes(x = n_sites, y = ctcfSignal)) +
    geom_line() +
    geom_point(shape = 21, stroke = 1,  fill = 'white') +
    theme_minimal() +
    theme(panel.border = element_rect(color = 'black',
                                      fill = NA))

## -----------------------------------------------------------------------------
ov <- overview(mgi)
ov

## -----------------------------------------------------------------------------
ov$quality

## ----message=FALSE------------------------------------------------------------
plotPropensity(mgi, sets = c('f', 'p', 'm'))

## -----------------------------------------------------------------------------
plotPropensity(mgi, sets = c('f', 'p', 'm'), log = 'x')

## ----message=FALSE, warning=FALSE, fig.height=8, fig.width=5------------------
library(patchwork)
plots <- lapply(covariates(mgi), plotCovariate, x=mgi, sets = c('f', 'm', 'p'))
Reduce('/', plots)

## ----fig.width=6, fig.height=5------------------------------------------------
## Generate a randomly selected set from all binPairs
all <- c(focal(mgi), pool(mgi))
set.seed(123)
random <- all[sample(1:length(all), length(mgi), replace = FALSE)]
## Calculate the percent of convergent CTCF sites for each group
g1 <- (sum(focal(mgi)$convergent) / length(focal(mgi))) * 100
g2 <- (sum(pool(mgi)$convergent) / length(pool(mgi))) * 100
g3 <- (sum(random$convergent) / length(random)) * 100
g4 <- (sum(mgi$convergent) / length(mgi)) * 100
## Visualize
barplot(height = c(g1, g2, g3, g4),
        names.arg = c('looped\n(focal)', 'unlooped\n(pool)',
                      'all pairs\n(random)', 'unlooped\n(matched)'),
        col = c('#1F78B4', '#33A02C', 'orange2', '#A6CEE3'), 
        ylab = "Convergent CTCF Sites (%)",
        main = "Testing the Convergence Rule",
        border = NA,
        las = 1)

## -----------------------------------------------------------------------------
sessionInfo()

