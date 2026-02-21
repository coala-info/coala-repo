# Code example from 'SMITE' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE, eval=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=50), echo=TRUE, results='hide'----
options(stringsAsFactors=FALSE)
library(SMITE)

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE-------
## Load methylation data ##
data(methylationdata)
head(methylation)
## Replace zeros with minimum non-zero p-value ##
methylation[,5] <- replace(methylation[,5], methylation[,5]==0, 
                           min(subset(methylation[,5], methylation[,5]!=0), na.rm=TRUE))

## Remove NAs from p-value column ##
methylation <- methylation[-which(is.na(methylation[, 5])), ] 

## ----warning=FALSE, tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE----
## Load fake genes to show expression conversion ##
data(genes_for_conversiontest)
genes[,1] <- convertGeneIds(gene_IDs=genes[,1], ID_type="refseq", ID_convert_to="symbol")

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=FALSE------
# ## This is just an example of how to pre-process data ##
# expression <- expression[-which(is.na(expression[, 1])), ]
# expression <- split(expression, expression[, 1])
# expression <- lapply(expression, function(i){
#     if(nrow(as.data.frame(i)) > 1){
#         i <- i[which(i[, 3] == min(i[, 3], na.rm=TRUE))[1], ]
#         }
#     return(i)})
# expression <- do.call(rbind, expression)
# expression <- expression[,-1]
# expression[, 2] <- replace(expression[, 2],expression[, 2] == 0,
#                           min(subset(expression[, 2], expression[, 2] != 0), na.rm=TRUE))

## ----warning=FALSE, tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE----
## Load expression data ##
data(curated_expressiondata)

## View data ##
head(expression_curated)


## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE-------
## Load hg19 gene annotation BED file ##
data(hg19_genes_bed)

## Load histone modification file ##
data(histone_h3k4me1)

## View files ##
head(hg19_genes)
head(h3k4me1)

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=50), eval=TRUE-------
test_annotation <- makePvalueAnnotation(data=hg19_genes, other_data=list(h3k4me1=h3k4me1), 
                                        gene_name_col=5, other_tss_distance=5000, 
                                        promoter_upstream_distance=1000, promoter_downstream_distance=1000) 

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=50), eval=TRUE-------
test_annotation <- annotateExpression(pvalue_annotation=test_annotation, expr_data=expression_curated, 
                                      effect_col=1, pval_col=2)

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=45), eval=FALSE------
# test_annotation <- annotateModification(test_annotation, methylation, weight_by_method="Stouffer",
#                                       weight_by=c(promoter="distance", body="distance", h3k4me1="distance"),
#                                       verbose=TRUE, mod_corr=FALSE, mod_type="methylation")

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=50), eval=FALSE, fig.width= 9----
# ## See expression data ##
# head(extractExpression(test_annotation))
# 
# ## See the uncombined p-values for a specific or all modType(s) ##
# extractModification(test_annotation, mod_type="methylation")
# 
# ## See the combined p-value data.frame ##
# head(extractModSummary(test_annotation))

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=35), eval=FALSE------
# test_annotation <- makePvalueObject(test_annotation, effect_directions=c(methylation_promoter="decrease",
#                                                                          methylation_body="increase", methylation_h3k4me1="bidirectional"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
## Because runSpinglass and scorePval are computationally intensive we simply load already ran data instead of evaluating the code.
data(test_annotation_score_data)

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=35), eval=TRUE-------
## Plot density of p-values ##
plotDensityPval(pvalue_annotation=test_annotation, ref="expression")

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=35), eval=TRUE, fig.width=9, fig.height=5----
## Normalize the p-values to the range of expression ##
test_annotation <- normalizePval(test_annotation, ref="expression", 
                                 method="rescale")

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=35), eval=TRUE, fig.width=8----
plotCompareScores(test_annotation, x_name="expression", y_name="methylation_promoter")

## ----long-compute-time, tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=45), eval=FALSE----
# #score with all four features contributing
# test_annotation <- scorePval(test_annotation, weights=c(methylation_promoter=.3,
#                                                         methylation_body=.1,
#                                                         expression=.3,
#                                                         methylation_h3k4me1=.3))

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=45), eval=FALSE------
# ## load REACTOME ##
#  load(system.file("data","Reactome.Symbol.Igraph.rda", package="SMITE"))
# ## Run Spin-glass ##
# test_annotation <- runSpinglass(test_annotation, network=REACTOME, maxsize=50, num_iterations=1000)
# 
# ## Run goseq on individual modules to determine bias an annotate functions ##
# test_annotation <- runGOseq(test_annotation, supply_cov=TRUE, coverage=read.table(system.file(
#     "extdata", "hg19_symbol_hpaii.sites.inbodyand2kbupstream.bed.gz", package="SMITE")),
#     type="kegg")

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE, fig.width=10, fig.height=9----
## search goseq output for keywords ##
searchGOseq(test_annotation, search_string="cell cycle")

## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE, fig.width=10, fig.height=9----
## Draw a network ##
plotModule(test_annotation, which_network=6, layout="fr", label_scale=TRUE, compare_plot = FALSE)
## Compare two networks ##
plotModule(test_annotation, which_network=c(4,6), layout="fr", label_scale=TRUE, compare_plot = TRUE)


## ----tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60), eval=TRUE, fig.width=12,fig.height=6----
## Draw a network with goseq analysis ##
plotModule(test_annotation, which_network=1, layout="fr", goseq=TRUE, label_scale=FALSE)

