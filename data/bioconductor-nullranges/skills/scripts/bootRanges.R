# Code example from 'bootRanges' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(fig.width=5, fig.height=5, message=FALSE, warning=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# eh <- ExperimentHub()
# ah <- AnnotationHub()
# # some default resources:
# seg <- eh[["EH7307"]] # pre-built genome segmentation for hg38
# exclude <- ah[["AH107305"]] # Kundaje excluded regions for hg38, see below
# 
# set.seed(5) # set seed for reproducibility
# blockLength <- 5e5 # size of blocks to bootstrap
# R <- 10 # number of iterations of the bootstrap
# 
# # input `ranges` require seqlengths, if missing see `Seqinfo::Seqinfo`
# seqlengths(ranges)
# # next, we remove non-standard chromosomes ...
# library(GenomeInfoDb)  # for keepStandardChromosomes()
# ranges <- keepStandardChromosomes(ranges, pruning.mode="coarse")
# # ... and mitochondrial genome, as these are too short
# seqlevels(ranges, pruning.mode="coarse") <- setdiff(seqlevels(ranges), "MT")
# 
# # generate bootstraps
# boots <- bootRanges(ranges, blockLength=blockLength, R=R,
#                     seg=seg, exclude=exclude)
# # `boots` can then be used with plyranges commands, e.g. join_overlap_*

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("images/bootRanges.jpeg")

## ----excluderanges------------------------------------------------------------
suppressPackageStartupMessages(library(AnnotationHub))
ah <- AnnotationHub()
# hg38.Kundaje.GRCh38_unified_Excludable
exclude_1 <- ah[["AH107305"]]
# hg38.UCSC.centromere
exclude_2 <- ah[["AH107354"]]
# hg38.UCSC.telomere
exclude_3 <- ah[["AH107355"]]
# hg38.UCSC.short_arm
exclude_4 <- ah[["AH107356"]]
# combine them
suppressWarnings({
  exclude <- trim(c(exclude_1, exclude_2, exclude_3, exclude_4))
})
exclude <- sort(GenomicRanges::reduce(exclude))

## ----message=FALSE, warning=FALSE---------------------------------------------
suppressPackageStartupMessages(library(ExperimentHub))
eh <- ExperimentHub()
seg_cbs <- eh[["EH7307"]] # prefer CBS for hg38
seg_hmm <- eh[["EH7308"]]
seg <- seg_cbs

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(ensembldb))
suppressPackageStartupMessages(library(EnsDb.Hsapiens.v86))
edb <- EnsDb.Hsapiens.v86
filt <- AnnotationFilterList(GeneIdFilter("ENSG", "startsWith"))
g <- genes(edb, filter = filt)

## -----------------------------------------------------------------------------
library(GenomeInfoDb)  # for keepStandardChromosomes()
g <- keepStandardChromosomes(g, pruning.mode = "coarse")
# MT is too small for bootstrapping, so must be removed
seqlevels(g, pruning.mode="coarse") <- setdiff(seqlevels(g), "MT")
# normally we would assign a new style, but for recent host issues
# that produced vignette build problems, we use `paste0`
## seqlevelsStyle(g) <- "UCSC" 
seqlevels(g) <- paste0("chr", seqlevels(g))
genome(g) <- "hg38"
g <- sortSeqlevels(g)
g <- sort(g)
table(seqnames(g))

## -----------------------------------------------------------------------------
library(nullranges)
suppressPackageStartupMessages(library(plyranges))
library(patchwork)

## ----seg-cbs, fig.width=5, fig.height=4---------------------------------------
set.seed(5)
exclude <- exclude %>%
  filter(width(exclude) >= 500)
L_s <- 1e6
seg_cbs <- segmentDensity(g, n = 3, L_s = L_s,
                          exclude = exclude, type = "cbs")
plots <- lapply(c("ranges","barplot","boxplot"), function(t) {
  plotSegment(seg_cbs, exclude, type = t)
})
plots[[1]]
plots[[2]] + plots[[3]]

## ----fig.width=4, fig.height=3------------------------------------------------
region <- GRanges("chr16", IRanges(3e7,4e7))
plotSegment(seg_cbs, exclude, type="ranges", region=region)

## ----seg-hmm, fig.width=5, fig.height=4---------------------------------------
seg_hmm <- segmentDensity(g, n = 3, L_s = L_s,
                          exclude = exclude, type = "hmm")
plots <- lapply(c("ranges","barplot","boxplot"), function(t) {
  plotSegment(seg_hmm, exclude, type = t)
})
plots[[1]]
plots[[2]] + plots[[3]]

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(nullrangesData))
dhs <- DHSA549Hg38()
dhs <- dhs %>% filter(signalValue > 100) %>%
  mutate(id = seq_along(.)) %>%
  select(id, signalValue)
length(dhs)
table(seqnames(dhs))

## -----------------------------------------------------------------------------
set.seed(5) # for reproducibility
R <- 50
blockLength <- 5e5
boots <- bootRanges(dhs, blockLength, R = R, seg = seg, exclude=exclude)
boots

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyr))
combined <- dhs %>% 
  mutate(iter=0) %>%
  bind_ranges(boots) %>% 
  select(iter)
stats <- combined %>% 
  group_by(iter) %>%
  summarize(n = n()) %>%
  as_tibble()
head(stats)

## ----eval=FALSE---------------------------------------------------------------
# # pseudocode for the general paradigm:
# boots <- bootRanges(y) # make bootstrapped y
# x %>% join_overlap_inner(boots) %>% # overlaps of x with bootstrapped y
#   group_by(x_id, iter) %>% # collate by x ID and the bootstrap iteration
#   summarize(some_statistic = ...) %>% # compute some summary on metadata
#   as_tibble() %>% # pass to tibble
#   complete(
#     x_id, iter, # for any missing combinations of x ID and iter...
#     fill=list(some_statistic = 0) # ...fill in missing values
#   )

## -----------------------------------------------------------------------------
x <- GRanges("chr2", IRanges(1 + 50:99 * 1e6, width=1e6), x_id=1:50)

## -----------------------------------------------------------------------------
x <- x %>% mutate(n_overlaps = count_overlaps(., dhs))
sum( x$n_overlaps )

## -----------------------------------------------------------------------------
boot_stats <- x %>% join_overlap_inner(boots) %>%
  group_by(x_id, iter) %>%
  summarize(n_overlaps = n()) %>%
  as_tibble() %>%
  complete(x_id, iter, fill=list(n_overlaps = 0)) %>%
  group_by(iter) %>%
  summarize(sumOverlaps = sum(n_overlaps))

## ----boot-histI---------------------------------------------------------------
suppressPackageStartupMessages(library(ggplot2))
ggplot(boot_stats, aes(sumOverlaps)) +
  geom_histogram(binwidth=5)+
  geom_vline(xintercept = sum(x$n_overlaps), linetype = "dashed")

## -----------------------------------------------------------------------------
x_obs <- x %>% join_overlap_inner(dhs,maxgap=1e3)
sum(x_obs$signalValue )
boot_stats <- x %>% join_overlap_inner(boots,maxgap=1e3)  %>%
  group_by(x_id, iter) %>%
  summarize(Signal = sum(signalValue)) %>%
  as_tibble() %>% 
  complete(x_id, iter, fill=list(Signal = 0)) %>%
  group_by(iter) %>%
  summarize(sumSignal = sum(Signal))

## ----boot-histII--------------------------------------------------------------
ggplot(boot_stats, aes(sumSignal)) +
  geom_histogram()+
  geom_vline(xintercept = sum(x_obs$signalValue), linetype = "dashed")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(nullrangesData))
dhs <- DHSA549Hg38()
region <- GRanges("chr1", IRanges(10e6 + 1, width=1e6))
x <- GRanges("chr1", IRanges(10e6 + 0:9 * 1e5 + 1, width=1e4))
y <- dhs %>% filter_by_overlaps(region) %>% select(NULL)
x %>% mutate(num_overlaps = count_overlaps(., y))

## -----------------------------------------------------------------------------
seg <- oneRegionSegment(region, seqlength=248956422)
seqlevels(y) <- "chr1"
set.seed(1)
boot <- bootRanges(y, blockLength=1e5, R=1, seg=seg,
                   proportionLength=FALSE)
boot
x %>% mutate(num_overlaps = count_overlaps(., boot))

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(plotgardener))
my_palette <- function(n) {
  head(c("red","green3","red3","dodgerblue",
         "blue2","green4","darkred"), n)
}
plotGRanges <- function(gr) {
  pageCreate(width = 5, height = 5, xgrid = 0,
                ygrid = 0, showGuides = TRUE)
  for (i in seq_along(seqlevels(gr))) {
    chrom <- seqlevels(gr)[i]
    chromend <- seqlengths(gr)[[chrom]]
    suppressMessages({
      p <- pgParams(chromstart = 0, chromend = chromend,
                    x = 0.5, width = 4*chromend/500, height = 2,
                    at = seq(0, chromend, 50),
                    fill = colorby("state_col", palette=my_palette))
      prngs <- plotRanges(data = gr, params = p,
                          chrom = chrom,
                          y = 2 * i,
                          just = c("left", "bottom"))
      annoGenomeLabel(plot = prngs, params = p, y = 0.1 + 2 * i)
    })
  }
}

## -----------------------------------------------------------------------------
library(GenomicRanges)
seq_nms <- rep(c("chr1","chr2"), c(4,3))
seg <- GRanges(
  seqnames = seq_nms,
  IRanges(start = c(1, 101, 201, 401, 1, 201, 301),
          width = c(100, 100, 200, 100, 200, 100, 100)),
  seqlengths=c(chr1=500,chr2=400),
  state = c(1,2,1,3,3,2,1),
  state_col = factor(1:7)
)

## ----toysegments, fig.width=5, fig.height=4-----------------------------------
plotGRanges(seg)

## ----toyrangesI, fig.width=5, fig.height=4------------------------------------
set.seed(1)
n <- 200
gr <- GRanges(
  seqnames=sort(sample(c("chr1","chr2"), n, TRUE)),
  IRanges(start=round(runif(n, 1, 500-10+1)), width=10)
)
suppressWarnings({
  seqlengths(gr) <- seqlengths(seg)
})
gr <- gr[!(seqnames(gr) == "chr2" & end(gr) > 400)]
gr <- sort(gr)
idx <- findOverlaps(gr, seg, type="within", select="first")
gr <- gr[!is.na(idx)]
idx <- idx[!is.na(idx)]
gr$state <- seg$state[idx]
gr$state_col <- factor(seg$state_col[idx])
plotGRanges(gr)

## ----toy-no-prop, fig.width=5, fig.height=4-----------------------------------
set.seed(1)
gr_prime <- bootRanges(gr, blockLength = 25, seg = seg,
                       proportionLength = FALSE)
plotGRanges(gr_prime)

## ----toy-prop, fig.width=5, fig.height=4--------------------------------------
set.seed(1)
gr_prime <- bootRanges(gr, blockLength = 50, seg = seg,
                       proportionLength = TRUE)
plotGRanges(gr_prime)

## -----------------------------------------------------------------------------
sessionInfo()

