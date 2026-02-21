# Code example from 'TMSig' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
options(width = 80)
knitr::opts_chunk$set(collapse = TRUE,
                      message = FALSE,
                      comment = "#>",
                      dpi = 250)

suppressPackageStartupMessages({
    library(TMSig)
})

## ----read-gmt-----------------------------------------------------------------
# Path to GMT file - MSigDB Gene Ontology sets
pathToGMT <- system.file(
    "extdata", "c5.go.v2023.2.Hs.symbols.gmt.gz",
    package = "TMSig"
)

geneSets <- readGMT(path = pathToGMT)

length(geneSets) # 10461 gene sets

head(names(geneSets)) # first 6 gene set names

geneSets[[1]] # genes in first set

## ----filter-sets--------------------------------------------------------------
# Filter by size - no background
filt <- filterSets(x = geneSets, 
                   min_size = 10L, 
                   max_size = 500L)
length(filt) # 7096 gene sets remain (down from 10461)

## ----create-background--------------------------------------------------------
# Top 2000 most common genes
topGenes <- table(unlist(geneSets))
topGenes <- head(sort(topGenes, decreasing = TRUE), 2000L)
head(topGenes)

background <- names(topGenes)

## ----filter-sets-bg-----------------------------------------------------------
# Restrict genes sets to background of genes
geneSetsFilt <- filterSets(
    x = geneSets, 
    background = background, 
    min_size = 10L # min. overlap of each set with background
)

length(geneSetsFilt) # 4629 gene sets pass

## ----overlap-prop-opts, include=FALSE-----------------------------------------
cap <- "Scatterplot of the original set size vs. overlap proportion."

## ----overlap-prop, fig.cap=cap------------------------------------------------
# Calculate proportion of overlap with background
setSizes <- lengths(geneSetsFilt)
setSizesOld <- lengths(geneSets)[names(geneSetsFilt)]
overlapProp <- setSizes / setSizesOld

plot(setSizesOld, overlapProp, main = "Set Size vs. Overlap")

## ----filter-by-overlap--------------------------------------------------------
table(overlapProp >= 0.7)

geneSetsFilt <- geneSetsFilt[overlapProp >= 0.7]
length(geneSetsFilt) # 1015 gene sets pass

## ----incidence-matrix---------------------------------------------------------
imat <- sparseIncidence(x = geneSetsFilt)
dim(imat) # 1015 sets, 1914 genes

imat[seq_len(8L), seq_len(5L)] # first 8 sets, first 5 genes

## ----incidence-products-------------------------------------------------------
# Calculate sizes of all pairwise intersections
tcrossprod(imat)[1:3, 1:3] # first 3 gene sets

# Calculate number of sets and pairs of sets to which each gene belongs
crossprod(imat)[1:3, 1:3] # first 3 genes

## ----sim-matrix---------------------------------------------------------------
# Jaccard similarity (default)
jaccard <- similarity(x = geneSetsFilt)
dim(jaccard) # 1015 1015`
class(jaccard)

## ----sim-jaccard--------------------------------------------------------------
# 6 sets with highest Jaccard for a specific term
idx <- order(jaccard[, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT"], 
             decreasing = TRUE)
idx <- head(idx)

jaccard[idx, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT", drop = FALSE]

## ----sim-simpson--------------------------------------------------------------
overlap <- similarity(x = geneSetsFilt, type = "overlap")

overlap[idx, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT", drop = FALSE]

## ----sim-otsuka---------------------------------------------------------------
otsuka <- similarity(x = geneSetsFilt, type = "otsuka")

otsuka[idx, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT", drop = FALSE]

## ----cluster-sets-------------------------------------------------------------
# clusterSets with default arguments
clusterDF <- clusterSets(x = geneSetsFilt, 
                         type = "jaccard", 
                         cutoff = 0.85, 
                         method = "complete",
                         h = 0.9)

# First 4 clusters with 2 or more sets
subset(clusterDF, subset = cluster <= 4L)

## ----add-clusterDF-columns----------------------------------------------------
## Use clusterSets output to select sets to retain for analysis
clusterDF$overlap_prop <- overlapProp[clusterDF$set] # overlap proportion
clusterDF$n_char <- nchar(clusterDF$set) # length of set description

# Reorder rows so that the first set in each cluster is the one to keep
o <- with(clusterDF, 
          order(cluster, set_size, overlap_prop, n_char, set,
                decreasing = c(FALSE, TRUE, TRUE, FALSE, TRUE),
                method = "radix"))
clusterDF <- clusterDF[o, ]

subset(clusterDF, cluster <= 4L) # show first 4 clusters

## ----remove-similar-sets------------------------------------------------------
# Sets to keep for analysis
keepSets <- with(clusterDF, set[!duplicated(cluster)])
head(keepSets, 4L)

# Subset geneSetsFilt to those sets
geneSetsFilt <- geneSetsFilt[keepSets]
length(geneSetsFilt) # 986 (down from 1015)

## ----venn-diagram-chunk-opts, include=FALSE-----------------------------------
h <- w <- "80%"
cap <- "Decomposition of sets."

## ----venn-diagram, echo=FALSE, out.height=h, out.width=w, fig.cap=cap---------
knitr::include_graphics("images/Venn_Diagram.png")

## ----decompose-sets-----------------------------------------------------------
# Limit maximum set size for this example
geneSetsFilt2 <- filterSets(geneSetsFilt, max_size = 50L)

# Decompose all pairs of sets with at least 10 genes in common
decompSets <- decomposeSets(x = geneSetsFilt2, overlap = 10L)

# Last 3 components
tail(decompSets, 3L)

## ----invert-sets--------------------------------------------------------------
invertedSets <- invertSets(x = geneSetsFilt)

length(invertedSets) # 1914 genes

head(names(invertedSets)) # names are genes

invertedSets["FOXO1"] # all gene sets containing FOXO1

## -----------------------------------------------------------------------------
similarity(x = invertedSets[1:5]) # first 5 genes

## ----simulate-expression-data-------------------------------------------------
# Control and 2 treatment groups, 3 replicates each
group <- rep(c("ctrl", "treat1", "treat2"), 
             each = 3)
design <- model.matrix(~ 0 + group) # design matrix
contrasts <- makeContrasts(
    contrasts = c("grouptreat1 - groupctrl",
                  "grouptreat2 - groupctrl"),
    levels = colnames(design)
)

# Shorten contrast names
colnames(contrasts) <- gsub("group", "", colnames(contrasts))

ngenes <- length(background) # 2000 genes
nsamples <- length(group) # 9 samples

set.seed(0)
y <- matrix(data = rnorm(ngenes * nsamples),
            nrow = ngenes, ncol = nsamples,
            dimnames = list(background, make.unique(group)))
head(y)

## ----perturb-gene-sets--------------------------------------------------------
cardiacGenes <- geneSetsFilt[["GOBP_CARDIAC_ATRIUM_DEVELOPMENT"]]
tcellGenes <- geneSetsFilt[["GOBP_ACTIVATED_T_CELL_PROLIFERATION"]]

# Indices of treatment group samples
trt1 <- which(group == "treat1")
trt2 <- which(group == "treat2")

# Cardiac genes: higher in control relative to treatment
y[cardiacGenes, trt1] <- y[cardiacGenes, trt1] - 2
y[cardiacGenes, trt2] <- y[cardiacGenes, trt2] - 0.7

# T cell proliferation genes: higher in treatment relative to control
y[tcellGenes, trt1] <- y[tcellGenes, trt1] + 2
y[tcellGenes, trt2] <- y[tcellGenes, trt2] + 1

## ----differential-analysis----------------------------------------------------
# Differential analysis with LIMMA
fit <- lmFit(y, design)
fit.contr <- contrasts.fit(fit, contrasts = contrasts)
fit.smooth <- eBayes(fit.contr)

# Matrix of z-score equivalents of moderated t-statistics
modz <- with(fit.smooth, zscoreT(x = t, df = df.total))
head(modz)

## ----reformat-DA-results------------------------------------------------------
# Reformat differential analysis results for enrichmap
resDA <- lapply(colnames(contrasts), function(contrast_i) {
    res_i <- topTable(fit.smooth, 
                      coef = contrast_i, 
                      number = Inf, 
                      sort.by = "none")
    res_i$contrast <- contrast_i
    res_i$gene <- rownames(res_i)
    res_i$df.total <- fit.smooth$df.total
    
    return(res_i)
})

resDA <- data.table::rbindlist(resDA)

# Add z-statistic column
resDA$z <- with(resDA, zscoreT(x = t, df = df.total))

# Reorder rows
resDA <- resDA[with(resDA, order(contrast, P.Value, z)), ]

head(resDA)

## ----count-signif-genes-------------------------------------------------------
# Count number of significant (P adj. < 0.05) genes
table(resDA$contrast, resDA$adj.P.Val < 0.05)

## ----camera-PR----------------------------------------------------------------
# CAMERA-PR (matrix method)
res <- cameraPR(statistic = modz, 
                index = geneSetsFilt)
head(res)

## ----count-signif-sets--------------------------------------------------------
# Number of sets passing FDR threshold
table(res$Contrast, res$FDR < 0.05)

## ----echo=FALSE---------------------------------------------------------------
j1 <- round(jaccard["GOBP_CARDIAC_ATRIUM_DEVELOPMENT", 
                    "GOBP_ATRIAL_SEPTUM_DEVELOPMENT"], 
            digits = 3)
o1 <- overlap["GOBP_CARDIAC_ATRIUM_DEVELOPMENT", 
              "GOBP_ATRIAL_SEPTUM_DEVELOPMENT"]

## ----DA-heatmap-chunk-opts, include=FALSE-------------------------------------
h <- w <- "70%"
cap <- "Bubble heatmap of differential expression analysis results."

## ----DA-bubble-heatmap, out.height=h, out.width=w, fig.cap=cap----------------
# Differential analysis bubble heatmap
enrichmap(x = resDA, 
          scale_by = "max",
          n_top = 15L, # default
          plot_sig_only = TRUE, # default
          set_column = "gene", 
          statistic_column = "z", 
          contrast_column = "contrast", 
          padj_column = "adj.P.Val", 
          padj_legend_title = "BH Adjusted\nP-Value", 
          padj_cutoff = 0.05,
          cell_size = grid::unit(20, "pt"),
          # Additional arguments passed to ComplexHeatmap::Heatmap. Used to
          # modify default appearance.
          heatmap_args = list(
              name = "Z-Score",
              column_names_rot = 60,
              column_names_side = "top"
          ))

## ----camera-heatmap-chunk-opts, include=FALSE---------------------------------
h <- w <- "100%"
cap <- "Bubble heatmap of CAMERA-PR results."

## ----CAMERA-bubble-heatmap, out.height=h, out.width=w, fig.cap=cap------------
# CAMERA-PR bubble heatmap
enrichmap(x = res, 
          scale_by = "row", # default
          n_top = 20L,
          set_column = "GeneSet", 
          statistic_column = "ZScore", 
          contrast_column = "Contrast",
          padj_column = "FDR",
          padj_legend_title = "BH Adjusted\nP-Value",
          padj_cutoff = 0.05,
          cell_size = grid::unit(13, "pt"),
          # Additional arguments passed to ComplexHeatmap::Heatmap. Used to
          # modify default appearance.
          heatmap_args = list(
              name = "Z-Score", 
              column_names_rot = 60,
              column_names_side = "top"
          ))

## ----session-info-------------------------------------------------------------
print(sessionInfo(), locale = FALSE)

