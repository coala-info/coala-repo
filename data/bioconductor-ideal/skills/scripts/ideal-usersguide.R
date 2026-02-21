# Code example from 'ideal-usersguide' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, warning=FALSE-----------------------------------------
library("knitr")
set.seed(42)
opts_chunk$set(comment = "#>",
               fig.align = "center",
               warning = FALSE)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())

## ----out.width="50%", echo=FALSE----------------------------------------------
knitr::include_graphics(system.file("www", "ideal.png", package = "ideal"))

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("ideal")

## ----loadlibrary, message=FALSE-----------------------------------------------
library("ideal")

## ----citation-----------------------------------------------------------------
citation("ideal")

## ----using--------------------------------------------------------------------
library("ideal")

## ----out.width="100%", echo=FALSE---------------------------------------------
knitr::include_graphics(system.file("www", "help_dataformats.png", package = "ideal"))

## ----installairway, eval=FALSE------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("airway")

## ----loadairway, message=FALSE------------------------------------------------
library("airway")
library("DESeq2")

data("airway", package = "airway")

dds_airway <- DESeqDataSet(airway, design = ~ cell + dex)
dds_airway
# run deseq on it
dds_airway <- DESeq(dds_airway)
# extract the results
res_airway <- results(dds_airway, contrast = c("dex", "trt", "untrt"), alpha = 0.05)

## ----launchairway, eval=FALSE-------------------------------------------------
# ideal(dds_obj = dds_airway)
# # or also providing the results object
# ideal(dds_obj = dds_airway, res_obj = res_airway)

## ----annoairway, message = FALSE----------------------------------------------
library(org.Hs.eg.db)
genenames_airway <- mapIds(org.Hs.eg.db, keys = rownames(dds_airway), column = "SYMBOL", keytype = "ENSEMBL")
annotation_airway <- data.frame(
  gene_id = rownames(dds_airway),
  gene_name = genenames_airway,
  row.names = rownames(dds_airway),
  stringsAsFactors = FALSE
)
head(annotation_airway)

## ----launchairwayanno, eval=FALSE---------------------------------------------
# ideal(
#   dds_obj = dds_airway,
#   annotation_obj = annotation_airway
# )

## ----fromedgerandlimma--------------------------------------------------------
library(DEFormats)
library(edgeR)
library(limma)
dge_airway <- as.DGEList(dds_airway) # this is your initial object
# your factors for the design:
dex <- colData(dds_airway)$dex
cell <- colData(dds_airway)$cell

redo_dds_airway <- as.DESeqDataSet(dge_airway)
# force the design to ~cell + dex
design(redo_dds_airway) <- ~ cell + group # TODO: this is due to the not 100% re-conversion via DEFormats

### with edgeR
y <- calcNormFactors(dge_airway)
design <- model.matrix(~ cell + dex)
y <- estimateDisp(y, design)
# If you performed quasi-likelihood F-tests
fit <- glmQLFit(y, design)
qlf <- glmQLFTest(fit) # contrast for dexamethasone treatment
topTags(qlf)
# If you performed likelihood ratio tests
fit <- glmFit(y, design)
lrt <- glmLRT(fit)
topTags(lrt)

# lrt to DESeqResults

tbledger <- lrt$table
colnames(tbledger)[colnames(tbledger) == "PValue"] <- "pvalue"
colnames(tbledger)[colnames(tbledger) == "logFC"] <- "log2FoldChange"
colnames(tbledger)[colnames(tbledger) == "logCPM"] <- "baseMean"
# get from the logcpm to something more the baseMean for better
tbledger$baseMean <- (2^tbledger$baseMean) * mean(dge_airway$samples$lib.size) / 1e6
# use the constructor for DESeqResults
edger_resu <- DESeqResults(DataFrame(tbledger))
edger_resu <- DESeq2:::pvalueAdjustment(edger_resu,
  independentFiltering = TRUE,
  alpha = 0.05, pAdjustMethod = "BH"
)

# cfr with res_airway
# plot(res_airway$pvalue,edger_resu$pvalue)



### with limma-voom
x <- calcNormFactors(dge_airway)
design <- model.matrix(~ 0 + dex + cell)
contr.matrix <- makeContrasts(dextrt - dexuntrt, levels = colnames(design))
v <- voom(x, design)
vfit <- lmFit(v, design)
vfit <- contrasts.fit(vfit, contrasts = contr.matrix)
efit <- eBayes(vfit)

tbllimma <- topTable(efit, number = Inf, sort.by = "none")
colnames(tbllimma)[colnames(tbllimma) == "P.Value"] <- "pvalue"
colnames(tbllimma)[colnames(tbllimma) == "logFC"] <- "log2FoldChange"
colnames(tbllimma)[colnames(tbllimma) == "AveExpr"] <- "baseMean"
colnames(tbllimma)[colnames(tbllimma) == "adj.P.Val"] <- "padj"
# get from the logcpm to something more the baseMean for better
tbllimma$baseMean <- (2^tbllimma$baseMean) * mean(dge_airway$samples$lib.size) / 1e6
# use the constructor for DESeqResults
limma_resu <- DESeqResults(DataFrame(tbllimma))

# cfr with res_airway
# plot(res_airway$pvalue,limma_resu$pvalue)

## ----ideal-edgerlimma, eval=FALSE---------------------------------------------
# ideal(redo_dds_airway, edger_resu)
# # or ...
# ideal(redo_dds_airway, limma_resu)

## ----res2tbl------------------------------------------------------------------
summary(res_airway)
res_airway

head(mosdef::deresult_to_df(res_airway))

## ----res2de-------------------------------------------------------------------
head(mosdef::deresult_to_df(res_airway, FDR = 0.05))
# the output in the first lines is the same, but
dim(res_airway)
dim(mosdef::deresult_to_df(res_airway))

## ----res-enhance--------------------------------------------------------------
myde <- mosdef::deresult_to_df(res_airway, FDR = 0.05)
myde$symbol <- mapIds(org.Hs.eg.db, keys = as.character(myde$id), column = "SYMBOL", keytype = "ENSEMBL")

myde_enhanced <- myde
myde_enhanced$id <- mosdef::create_link_ENSEMBL(myde_enhanced$id, species = "Homo_sapiens")
myde_enhanced$symbol <- mosdef::create_link_NCBI(myde_enhanced$symbol)

DT::datatable(myde_enhanced[1:100, ], escape = FALSE)

## ----ggpc1--------------------------------------------------------------------
ggplotCounts(
  dds = dds_airway,
  gene = "ENSG00000103196", # CRISPLD2 in the original publication
  intgroup = "dex"
)

## ----ggpc2--------------------------------------------------------------------
ggplotCounts(
  dds = dds_airway,
  gene = "ENSG00000103196", # CRISPLD2 in the original publication
  intgroup = "dex",
  annotation_obj = annotation_airway
)

## ----goseq, eval=FALSE--------------------------------------------------------
# res_subset <- mosdef::deresult_to_df(res_airway)[1:100, ] # taking only a subset of the DE genes
# myde <- res_subset$id
# myassayed <- rownames(res_airway)
# mygo <- goseqTable(
#   de.genes = myde,
#   assayed.genes = myassayed,
#   genome = "hg38",
#   id = "ensGene",
#   testCats = "GO:BP",
#   addGeneToTerms = FALSE
# )
# head(mygo)

## ----go-enhance, eval=FALSE---------------------------------------------------
# mygo_enhanced <- mygo
# # using the unexported function to link the GO term to the entry in the AmiGO db
# mygo_enhanced$category <- mosdef::create_link_GO(mygo_enhanced$category)
# DT::datatable(mygo_enhanced, escape = FALSE)

## ----plotma, eval=FALSE-------------------------------------------------------
# plot_ma(res_airway,
#   FDR = 0.05, hlines = 1,
#   title = "Adding horizontal lines", add_rug = FALSE
# )
# plot_ma(res_airway,
#   FDR = 0.1,
#   intgenes = c(
#     "ENSG00000103196", # CRISPLD2
#     "ENSG00000120129", # DUSP1
#     "ENSG00000163884", # KLF15
#     "ENSG00000179094"
#   ), # PER1
#   title = "Providing a shortlist of genes",
#   add_rug = FALSE
# )

## ----plotma2------------------------------------------------------------------
res_airway2 <- res_airway
res_airway2$symbol <- mapIds(org.Hs.eg.db, keys = rownames(res_airway2), column = "SYMBOL", keytype = "ENSEMBL")
plot_ma(res_airway2,
  FDR = 0.05,
  intgenes = c(
    "CRISPLD2", # CRISPLD2
    "DUSP1", # DUSP1
    "KLF15", # KLF15
    "PER1"
  ), # PER1
  annotation_obj = annotation_airway,
  hlines = 2,
  add_rug = FALSE,
  title = "Putting gene names..."
)

## ----plotvolcano, eval = FALSE------------------------------------------------
# plot_volcano(res_airway)

## ----plotvolcano2-------------------------------------------------------------
plot_volcano(res_airway2,
  FDR = 0.05,
  intgenes = c(
    "CRISPLD2", # CRISPLD2
    "DUSP1", # DUSP1
    "KLF15", # KLF15
    "PER1"
  ), # PER1
  title = "Selecting the handful of genes - and displaying the full range for the -log10(pvalue)",
  ylim_up = -log10(min(res_airway2$pvalue, na.rm = TRUE))
)

## ----sepguess-----------------------------------------------------------------
sepguesser(system.file("extdata/design_commas.txt", package = "ideal"))
sepguesser(system.file("extdata/design_semicolons.txt", package = "ideal"))
sepguesser(system.file("extdata/design_spaces.txt", package = "ideal"))
anyfile <- system.file("extdata/design_tabs.txt", package = "ideal") # we know it is going to be TAB
guessed_sep <- sepguesser(anyfile)
guessed_sep
# to be used for reading in the same file, without having to specify the sep
read.delim(anyfile,
  header = TRUE, as.is = TRUE,
  sep = guessed_sep,
  quote = "", row.names = 1, check.names = FALSE
)

## ----fgsea, eval=FALSE--------------------------------------------------------
# library("fgsea")
# # selecting the result object from the exported environment
# exported_res <- ideal_env$ideal_values_20200926_135052$res_obj
# summary(exported_res)
# 
# # for processing of intermediate steps
# library("dplyr")
# library("tibble")
# 
# # extracting the rankes for pre-ranked gsea
# de_ranks <- exported_res %>%
#   as.data.frame() %>%
#   dplyr::arrange(padj) %>%
#   dplyr::select(symbol, stat) %>%
#   deframe()
# head(de_ranks, 20)
# 
# # loading the signatures from the gmt file - to be downloaded locally
# pathways_gmtfile <- gmtPathways("path_to/msigdb_v7.0_GMTs/h.all.v6.2.symbols.gmt")
# 
# # running fgsea
# fgsea_result <- fgsea(
#   pathways = pathways_gmtfile,
#   stats = de_ranks,
#   nperm = 100000
# )
# fgsea_result <- fgsea_result %>%
#   arrange(desc(NES))
# 
# # displaying the results
# DT::datatable(fgsea_result)

## ----gprofiler2, eval=FALSE---------------------------------------------------
# library("gprofiler2")
# 
# # selecting the result object from the exported environment
# exported_res <- ideal_env$ideal_values_20200926_135052$res_obj
# summary(exported_res)
# 
# # extracting the DE genes vector
# degenes <- deseqresult2DEgenes(exported_res, FDR = 0.01)$symbol
# 
# # running the test
# gost_res <- gost(
#   query = degenes[1:1000],
#   organism = "hsapiens",
#   ordered_query = FALSE,
#   multi_query = FALSE,
#   significant = FALSE,
#   exclude_iea = TRUE,
#   measure_underrepresentation = FALSE,
#   evcodes = TRUE,
#   user_threshold = 0.05,
#   correction_method = "g_SCS",
#   domain_scope = "annotated",
#   numeric_ns = "",
#   sources = "GO:BP",
#   as_short_link = FALSE
# )
# 
# # displaying the results
# DT::datatable(gost_res$result)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

