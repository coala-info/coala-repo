# Code example from 'eegc' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results="hide"-----------------------------------
library("knitr")
opts_chunk$set(tidy=FALSE,tidy.opts=list(width.cutoff=30),dev="pdf",
               fig.width=7,fig.hight=5,
               fig.show="hide",message=FALSE)

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----options, results="hide", echo=FALSE--------------------------------------
options(digits=3, width=80, prompt=" ", continue=" ")

## ----install_eegc, eval=FALSE-------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("eegc")

## ----init_eegc, cache=FALSE, eval=TRUE,warning=FALSE--------------------------
library(eegc)

## ----load_data, eval=TRUE-----------------------------------------------------
# load Sandler's data set:
data(SandlerFPKM)

#the column names of the data, representing the samples CB, DMEC, and rEChMPP
colnames(SandlerFPKM)

## ----diff_analysis, eval=TRUE, warning=FALSE----------------------------------
# differential expression analysis:
diffgene = diffGene(expr = SandlerFPKM, array=FALSE,  fpkm=TRUE,  counts=FALSE,
                    from.sample="DMEC", to.sample="rEChMPP", target.sample="CB",
                    filter=TRUE, filter.perc =0.4, pvalue = 0.05 )

## ----diffresults, eval=TRUE, warning=FALSE------------------------------------
# differential analysis results
diffgene.result = diffgene[[1]]

# differential genes
diffgene.genes = diffgene[[2]]

#filtered expression data
expr.filter = diffgene[[3]]
dim(expr.filter)
dim(SandlerFPKM)

## ----gene_categorization, eval=TRUE-------------------------------------------
# categorizate differential genes from differential analysis
category = categorizeGene(expr = expr.filter,diffGene = diffgene.genes,
                          from.sample="DMEC",
                          to.sample="rEChMPP",
                          target.sample="CB")
cate.gene = category[[1]]
cate.ratio = category[[2]]

# the information of cate.gene
class(cate.gene)
length(cate.gene)
names(cate.gene)

head(cate.gene[[1]])
head(cate.ratio[[1]])

## ----markerScattera, eval = TRUE, echo=TRUE,fig.width =6, fig.height =6,dev="pdf"----
#load the marker genes of somatic and primary cells
data(markers)

#scatterplot
col = c("#abd9e9", "#2c7bb6", "#fee090", "#d7191c", "#fdae61")
markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "DMEC"),
              cate.gene = cate.gene[2:4], markers = markers, col = col[2:4],
              xlab = expression('log'[2]*' expression in CB (target)'),
              ylab = expression('log'[2]*' expression in DMEC (input)'),
              main = "")

## ----markerScatterb,eval = TRUE, echo=TRUE,fig.width =6, fig.height =6,dev="pdf"----
markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "rEChMPP"),
              cate.gene = cate.gene[2:4], markers = markers, col = col[2:4],
              xlab = expression('log'[2]*' expression in CB (target)'),
              ylab = expression('log'[2]*' expression in rEC-hMPP (output)'),
              main = "")

## ----markerScatterc,eval = TRUE, echo=TRUE,fig.width =6, fig.height =6,dev="pdf"----
markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "DMEC"),
              cate.gene = cate.gene[c(1,5)], markers = markers, col = col[c(1,5)],
              xlab = expression('log'[2]*' expression in CB (target)'),
              ylab = expression('log'[2]*' expression in DMEC (input)'),
              main = "")

## ----markerScatterd, eval = TRUE, echo=TRUE,fig.width =6,fig.height =6,dev="pdf"----
markerScatter(expr = expr.filter, log = TRUE, samples = c("CB", "rEChMPP"),
              cate.gene = cate.gene[c(1,5)], markers = markers, col = col[c(1,5)],
              xlab = expression('log'[2]*' expression in CB (target)'),
              ylab = expression('log'[2]*' expression in rEC-hMPP (output)'),
              main = "")

## ----densityPlot,eval=TRUE,fig.width=8,fig.height=5,dev="pdf"-----------------
# make the extreme ED ratios in Reversed and Over categories to the median values
reverse = cate.ratio[[1]]
over = cate.ratio[[5]]
reverse[reverse[,1] <= median(reverse[,1]), 1]  = median(reverse[,1])
over[over[,1] >= median(over[,1]),1] = median(over[,1])
cate.ratio[[1]] = reverse
cate.ratio[[5]] = over

# density plot with quantified proportions
densityPlot(cate.ratio, xlab = "ED ratio", ylab = "Density", proportion = TRUE)

## ----functionEnrichment, eval=TRUE, warning = FALSE---------------------------
#  result in "enrichResult" class by specifying TRUE to enrichResult parameter
goenrichraw = functionEnrich(cate.gene, organism = "human", pAdjustMethod = "fdr",
                             GO = TRUE, KEGG = FALSE, enrichResult = TRUE)
class(goenrichraw[[1]])

## ----functionEnrichment2, eval=FALSE, warning = FALSE-------------------------
#  # result of the summary of "enrichResult" by specifying FALSE to enrichResult parameter
#  # GO enrichment
#  goenrich = functionEnrich(cate.gene, organism = "human", pAdjustMethod = "fdr",
#                            GO = TRUE, KEGG = FALSE, enrichResult = FALSE)
#  # KEGG enrichment
#  keggenrich = functionEnrich(cate.gene, organism = "human", pAdjustMethod = "fdr",
#                              GO = FALSE, KEGG = TRUE, enrichResult = FALSE)

## ----barplotEnrich,eval=TRUE,dev="pdf",fig.width=6,fig.height=3---------------
# plot only the "enrichResult" of Inactive category
inactive = goenrichraw[[2]]
barplotEnrich(inactive, top =5, color ="#2c7bb6", title = "Inactive")

## ----heatmapPlot,eval=TRUE,echo=TRUE,dev="pdf",fig.width=7,fig.heigth=7-------
# plot the enrichment results by the five gene categories
data(goenrich)
heatmaptable = heatmapPlot(goenrich, GO = TRUE, top = 5, filter = FALSE,
                           main = "Gene ontology enrichment",
                           display_numbers =  FALSE)

## ----tissueheatmap, eval=TRUE,echo=TRUE,dev="pdf",fig.width=7,fig.height=8----
#load the cell/tissue-specific genes
data(tissueGenes)
length(tissueGenes)
head(names(tissueGenes))

#load the mapping file of cells/tissues to grouped cells/tissues
data(tissueGroup)
head(tissueGroup)

#get the background genes
genes = rownames(expr.filter)
#enrichment analysis for the five gene categories
tissueenrich = enrichment(cate.gene = cate.gene, annotated.gene = tissueGenes,
                          background.gene = genes, padjust.method = "fdr")

#select a group of cells/tissues
tissueGroup.selec = c("stem cells","B cells","T cells","Myeloid","Endothelial CD105+")
tissues.selec = tissueGroup[tissueGroup[,"Group"] %in% tissueGroup.selec,c(2,3)]
tissuetable = heatmapPlot(tissueenrich, terms = tissues.selec, GO=FALSE,
                          annotated_row = TRUE,annotation_legend = TRUE,
                          main = "Tissue-specific enrichment")

## ----dotpercentage, eval = TRUE, echo=TRUE,dev="pdf",fig.width=7,fig.height=5----
#load the C/T-specific genes in 16 cells/tissues
data(human.gene)

# the 16 cells/tissues
head(names(human.gene))
perc = dotPercentage(cate.gene = cate.gene, annotated.gene = human.gene,
              order.by = "Successful")

## ----cellnetheatmap, eval = FALSE, echo=TRUE,dev="pdf"------------------------
#  # CellNet C/T-specific enrichment analysis
#  cellnetenrich = enrichment(cate.gene = cate.gene, annotated.gene = human.gene,
#                             background.gene = genes, padjust.method ="fdr")
#  cellnetheatmap = heatmapPlot(cellnetenrich,
#                               main = "CellNet tissue specific enrichment")

## ----tfheatmap,eval=TRUE,echo=TRUE,fig.width=5,fig.height=6,dev="pdf"---------
# load transcription factor regulated gene sets from on CellNet data
data(human.tf)
tfenrich = enrichment(cate.gene = cate.gene,  annotated.gene = human.tf,
                      background.gene = genes, padjust.method ="fdr")
tfheatmap = heatmapPlot(tfenrich, top = 5,
                        main = "CellNet transcription factor enrichment")

## ----networkanalyze,eval = TRUE,echo=TRUE-------------------------------------
# load the CellNet GRN
data(human.grn)

# specify a tissue-specifc network
tissue = "Hspc"
degree = networkAnalyze(human.grn[[tissue]], cate.gene = cate.gene,
                        centrality = "degree", mode ="all")
head(degree)

## ----grnPlot,eval = TRUE,echo=TRUE,dev="pdf",fig.width=6,fig.height=6---------
# select genes to shown their regulation with others
node.genes = c("ZNF641", "BCL6")

# enlarge the centrality
centrality.score = degree$centrality*100
names(centrality.score) = degree$Gene
par(mar = c(2,2,3,2))
grnPlot(grn.data = human.grn[[tissue]], cate.gene = cate.gene, filter = TRUE,
        nodes = node.genes, centrality.score = centrality.score,
        main = "Gene regulatory network")

## ----session_info, eval=TRUE--------------------------------------------------
sessionInfo()

