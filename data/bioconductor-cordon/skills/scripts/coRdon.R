# Code example from 'coRdon' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----setup, echo = FALSE, message = FALSE, warning = FALSE--------------------
library(knitr)
opts_chunk$set(comment = NA,
                fig.align = "center",
                warning = FALSE,
                cache = FALSE)
library(coRdon)
library(ggplot2)
library(Biostrings)
library(Biobase)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("coRdon")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("BioinfoHR/coRdon")

## -----------------------------------------------------------------------------
dnaLD94 <- readSet(
  file="https://raw.githubusercontent.com/BioinfoHR/coRdon-examples/master/LD94.fasta"
)
LD94 <- codonTable(dnaLD94)
dnaHD59 <- readSet(
  file="https://raw.githubusercontent.com/BioinfoHR/coRdon-examples/master/HD59.fasta"
)
HD59 <- codonTable(dnaHD59)

## -----------------------------------------------------------------------------
cc <- codonCounts(HD59)
head(cc)
l <- getlen(HD59)
head(l)
length(HD59)

## -----------------------------------------------------------------------------
ko <- getKO(HD59)
head(ko)

## -----------------------------------------------------------------------------
milc <- MILC(HD59)
head(milc)

## -----------------------------------------------------------------------------
milc <- MILC(HD59, ribosomal = TRUE)
head(milc)

## ----warning=TRUE-------------------------------------------------------------
milc <- MILC(HD59, filtering = "soft")

## ----include=FALSE------------------------------------------------------------
lengths <- getlen(HD59)
hist(lengths, breaks = 60)
abline(v = 80, col="red")

## -----------------------------------------------------------------------------
lengths <- as.data.frame(getlen(HD59))
colnames(lengths) <- "length"
ggplot(lengths, aes(length)) + 
    geom_density() +
    geom_vline(xintercept = 80, colour = "red") +
    theme_light()

## -----------------------------------------------------------------------------
milc <- MILC(HD59, ribosomal = TRUE, filtering = "hard")

## -----------------------------------------------------------------------------
library(ggplot2)

xlab <- "MILC distance from sample centroid"
ylab <- "MILC distance from ribosomal genes"

milc_HD59 <- MILC(HD59, ribosomal = TRUE)
Bplot(x = "ribosomal", y = "self", data = milc_HD59) +
    labs(x = xlab, y = ylab)

## ----eval=FALSE---------------------------------------------------------------
# milc_LD94 <- MILC(LD94, ribosomal = TRUE)
# Bplot(x = "ribosomal", y = "self", data = milc_LD94) +
#     labs(x = xlab, y = ylab)

## -----------------------------------------------------------------------------
genes <- getKO(HD59)[getlen(HD59) > 80]
Bplot(x = "ribosomal", y = "self", data = milc,
        annotations = genes, ribosomal = TRUE) +
    labs(x = xlab, y = ylab)

## -----------------------------------------------------------------------------
intraBplot(HD59, LD94, names = c("HD59", "LD94"), 
            variable = "MILC", 
            ribosomal = TRUE)

## -----------------------------------------------------------------------------
melp <- MELP(HD59, ribosomal = TRUE, filtering = "hard")
head(melp)

## -----------------------------------------------------------------------------
ct <- crossTab(genes, as.numeric(melp), threshold = 1L)
ct

## -----------------------------------------------------------------------------
contable(ct)
ann <- getSeqAnnot(ct)
head(ann)
var <- getVariable(ct)
head(var)

## -----------------------------------------------------------------------------
crossTab(genes, as.numeric(melp), percentiles = 0.05)

## -----------------------------------------------------------------------------
enr <- enrichment(ct)
enr

## -----------------------------------------------------------------------------
require(Biobase)
enr_data <- pData(enr)
head(enr_data)

## -----------------------------------------------------------------------------
enrichMAplot(enr, pvalue = "pvals", siglev = 0.05) +
    theme_light()

## -----------------------------------------------------------------------------
ctpath <- reduceCrossTab(ct, target = "pathway")
ctpath

## -----------------------------------------------------------------------------
enrpath <- enrichment(ctpath)
enrpath_data <- pData(enrpath)
head(enrpath_data)

## ----fig.height=12------------------------------------------------------------
enrichBarplot(enrpath, variable = "enrich", 
                pvalue = "padj", siglev = 0.05) +
    theme_light() +
    coord_flip() +
    labs(x = "category", y = "relative enrichment")

## ----eval=FALSE---------------------------------------------------------------
# require(KEGGREST)
# paths <- names(keggList("pathway"))
# paths <- regmatches(paths, regexpr("[[:alpha:]]{2,4}\\d{5}", paths))
# pnames <- unname(keggList("pathway"))
# ids <- match(pData(enrpath)$category, paths)
# descriptions <- pnames[ids]
# pData(enrpath)$category <- descriptions
# enrpath_data <- pData(enrpath)

## -----------------------------------------------------------------------------
# calculate MELP
melpHD59 <- MELP(HD59, ribosomal = TRUE, 
                filtering = "hard", len.threshold = 100)
genesHD59 <- getKO(HD59)[getlen(HD59) > 100]

melpLD94 <- MELP(LD94, ribosomal = TRUE, 
                filtering = "hard", len.threshold = 100)
genesLD94 <- getKO(LD94)[getlen(LD94) > 100]

# make cntingency table
ctHD59 <- crossTab(genesHD59, as.numeric(melpHD59))
ctLD94 <- crossTab(genesLD94, as.numeric(melpLD94))

ctHD59 <- reduceCrossTab(ctHD59, "pathway")
ctLD94 <- reduceCrossTab(ctLD94, "pathway")

# calculate enrichment
enrHD59 <- enrichment(ctHD59)
enrLD94 <- enrichment(ctLD94)

mat <- enrichMatrix(list(HD59 = enrHD59, LD94 = enrLD94), 
                    variable = "enrich")
head(mat)

## ----fig.height=15, fig.width=7, eval=FALSE-----------------------------------
# paths <- names(KEGGREST::keggList("pathway"))
# paths <- regmatches(paths, regexpr("[[:alpha:]]{2,4}\\d{5}", paths))
# pnames <- unname(KEGGREST::keggList("pathway"))
# ids <- match(rownames(mat), paths)
# descriptions <- pnames[ids]
# rownames(mat) <- descriptions
# 
# mat <- mat[apply(mat, 1, function(x) all(x!=0)), ]
# ComplexHeatmap::Heatmap(
#     mat,
#     name = "relative \nenrichment",
#     col = circlize::colorRamp2( c(-100, 0, 100),
#                                 c("red", "white", "blue")),
#     row_names_side = "left",
#     row_names_gp = gpar(fontsize = 8),
#     show_column_dend = FALSE,
#     show_row_dend = FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

