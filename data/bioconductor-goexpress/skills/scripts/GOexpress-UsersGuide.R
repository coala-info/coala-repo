# Code example from 'GOexpress-UsersGuide' vignette. See references/ for full tutorial.

### R code from vignette source 'GOexpress-UsersGuide.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: GOexpress-UsersGuide.Rnw:24-25
###################################################
options(useFancyQuotes="UTF-8")


###################################################
### code chunk number 3: GOexpress-UsersGuide.Rnw:113-114
###################################################
maintainer("GOexpress")


###################################################
### code chunk number 4: GOexpress-UsersGuide.Rnw:145-146
###################################################
citation(package="GOexpress")


###################################################
### code chunk number 5: GOexpress-UsersGuide.Rnw:201-203
###################################################
library(GOexpress) # load the GOexpress package
data(AlvMac) # import the training dataset


###################################################
### code chunk number 6: GOexpress-UsersGuide.Rnw:210-212
###################################################
exprs(AlvMac)[1:5,1:5] # Subset of the expression data
head(pData(AlvMac)) # Subset of the phenotypic information


###################################################
### code chunk number 7: GOexpress-UsersGuide.Rnw:223-224
###################################################
head(rownames(exprs(AlvMac))) # Subset of gene identifiers


###################################################
### code chunk number 8: GOexpress-UsersGuide.Rnw:250-252
###################################################
is.factor(AlvMac$Treatment) # assertion test
AlvMac$Treatment # visual inspection


###################################################
### code chunk number 9: GOexpress-UsersGuide.Rnw:262-263 (eval = FALSE)
###################################################
## AlvMac$Treatment <- factor(AlvMac$Treatment)


###################################################
### code chunk number 10: GOexpress-UsersGuide.Rnw:285-289
###################################################
set.seed(4543) # set random seed for reproducibility
AlvMac_results <- GO_analyse(
    eSet = AlvMac, f = "Treatment",
    GO_genes=AlvMac_GOgenes, all_GO=AlvMac_allGO, all_genes=AlvMac_allgenes)


###################################################
### code chunk number 11: GOexpress-UsersGuide.Rnw:301-305
###################################################
names(AlvMac_results) # Data slot names
head(AlvMac_results$GO[, c(1:5, 7)], n=5) # Ranked table of GO terms (subset)
head(AlvMac_results$genes[, c(1:3)], n=5) # Ranked table of genes (subset)
head(AlvMac_results$mapping) # Gene to gene ontology mapping table (subset)


###################################################
### code chunk number 12: GOexpress-UsersGuide.Rnw:329-330 (eval = FALSE)
###################################################
## AlvMac_results <- GO_analyse(eSet = AlvMac, f = "Treatment")


###################################################
### code chunk number 13: GOexpress-UsersGuide.Rnw:349-350 (eval = FALSE)
###################################################
## data(microarray2dataset)


###################################################
### code chunk number 14: GOexpress-UsersGuide.Rnw:365-366 (eval = FALSE)
###################################################
## AlvMac_results.pVal = pValue_GO(result=AlvMac_results, N=100)


###################################################
### code chunk number 15: GOexpress-UsersGuide.Rnw:369-370
###################################################
data(AlvMac_results.pVal)


###################################################
### code chunk number 16: GOexpress-UsersGuide.Rnw:423-438
###################################################
BP.5 <- subset_scores(
    result = AlvMac_results.pVal,
    namespace = "biological_process",
    total = 5, # requires 5 or more associated genes
    p.val=0.05)
MF.10 <- subset_scores(
    result = AlvMac_results.pVal,
    namespace = "molecular_function",
    total = 10,
    p.val=0.05)
CC.15 <- subset_scores(
    result = AlvMac_results.pVal,
    namespace = "cellular_component",
    total = 15,
    p.val=0.05)


###################################################
### code chunk number 17: GOexpress-UsersGuide.Rnw:472-476 (eval = FALSE)
###################################################
## subset(
##     AlvMac_results.pVal$GO,
##     total_count >= 5 & p.val<0.05 & namespace_1003=='biological_process'
##     )


###################################################
### code chunk number 18: GOexpress-UsersGuide.Rnw:499-500
###################################################
head(BP.5$GO)


###################################################
### code chunk number 19: GOexpress-UsersGuide.Rnw:515-518
###################################################
heatmap_GO(
    go_id = "GO:0034142", result = BP.5, eSet=AlvMac, cexRow=0.4,
    cexCol=1, cex.main=1, main.Lsplit=30)


###################################################
### code chunk number 20: GOexpress-UsersGuide.Rnw:531-535
###################################################
heatmap_GO(
    go_id = "GO:0034142", result = BP.5, eSet=AlvMac, cexRow=0.4,
    cexCol=1, cex.main=1, main.Lsplit=30,
    labRow=AlvMac$Group)


###################################################
### code chunk number 21: GOexpress-UsersGuide.Rnw:543-547
###################################################
heatmap_GO(
    go_id = "GO:0034142", result = BP.5, eSet=AlvMac, cexRow=0.6,
    cexCol=1, cex.main=1, main.Lsplit=30,
    labRow='Group', subset=list(Time=c('24H','48H')))


###################################################
### code chunk number 22: GOexpress-UsersGuide.Rnw:559-563
###################################################
cluster_GO(
    go_id = "GO:0034142", result = BP.5, eSet=AlvMac,
    cex.main=1, cex=0.6, main.Lsplit=30,
    subset=list(Time=c("24H", "48H")), f="Group")


###################################################
### code chunk number 23: GOexpress-UsersGuide.Rnw:579-580
###################################################
table_genes(go_id = "GO:0034142", result = BP.5)[,c(1:3)]


###################################################
### code chunk number 24: GOexpress-UsersGuide.Rnw:598-599
###################################################
list_genes(go_id = "GO:0034142", result = BP.5)


###################################################
### code chunk number 25: GOexpress-UsersGuide.Rnw:621-625
###################################################
expression_plot(
    gene_id = "ENSBTAG00000047107", result = BP.5, eSet=AlvMac,
    x_var = "Timepoint", title.size=1.5,
    legend.title.size=10, legend.text.size=10, legend.key.size=15)


###################################################
### code chunk number 26: GOexpress-UsersGuide.Rnw:649-653
###################################################
expression_plot(
    gene_id = "ENSBTAG00000047107", result = BP.5, eSet=AlvMac,
    x_var = "Animal", title.size=1.5, axis.text.angle=90,
    legend.title.size=10, legend.text.size=10, legend.key.size=15)


###################################################
### code chunk number 27: GOexpress-UsersGuide.Rnw:664-668 (eval = FALSE)
###################################################
## expression_plot_symbol(
##     gene_symbol = "BIKBA", result = BP.5, eSet=AlvMac,
##     x_var = "Timepoint", title.size=1.5,
##     legend.title.size=10, legend.text.size=10, legend.key.size=15)


###################################################
### code chunk number 28: GOexpress-UsersGuide.Rnw:683-687
###################################################
expression_plot_symbol(
    gene_symbol = "RPL36A", result = AlvMac_results, eSet=AlvMac,
    x_var = "Timepoint", title.size=1.5,
    legend.title.size=10, legend.text.size=10, legend.key.size=15)


###################################################
### code chunk number 29: GOexpress-UsersGuide.Rnw:712-719
###################################################
AlvMac$Animal.Treatment <- paste(AlvMac$Animal, AlvMac$Treatment, sep="_")
expression_profiles(
    gene_id = "ENSBTAG00000047107", result = AlvMac_results,
    eSet=AlvMac, x_var = "Timepoint", line.size=1,
    seriesF="Animal.Treatment", linetypeF="Animal",
    legend.title.size=10, legend.text.size=10,
    legend.key.size=15)


###################################################
### code chunk number 30: GOexpress-UsersGuide.Rnw:734-741 (eval = FALSE)
###################################################
## expression_profiles(
##     gene_id = "ENSBTAG00000047107", result = AlvMac_results,
##     eSet=AlvMac, x_var = "Timepoint",
##     lty=rep(1,10), # use line-type 1 for all 10 groups
##     seriesF="Animal.Treatment", linetypeF="Animal",
##     legend.title.size=10, legend.text.size=10,
##     legend.key.size=15, line.size=1)


###################################################
### code chunk number 31: GOexpress-UsersGuide.Rnw:751-757 (eval = FALSE)
###################################################
## expression_profiles_symbol(
##     gene_symbol="TNIP3", result = AlvMac_results,
##     x_var = "Timepoint", linetypeF="Animal", line.size=1,
##     eSet=AlvMac, lty=rep(1,10), seriesF="Animal.Treatment",
##     title.size=1.5, legend.title.size=10, legend.text.size=10,
##     legend.key.size=15)


###################################################
### code chunk number 32: GOexpress-UsersGuide.Rnw:775-779
###################################################
plot_design(
    go_id = "GO:0034134", result = BP.5, eSet=AlvMac,
    ask = FALSE, factors = c("Animal", "Treatment", "Time", "Group"),
    main.Lsplit=30)


###################################################
### code chunk number 33: GOexpress-UsersGuide.Rnw:828-856 (eval = FALSE)
###################################################
## # Load the interface to BioMart databases
## library(biomaRt)
## # See available resources in Ensembl release 75
## listMarts(host='feb2014.archive.ensembl.org')
## # Connect to the Ensembl Genes annotation release 75 for Bos taurus
## ensembl75 = useMart(
##     host='feb2014.archive.ensembl.org',
##     biomart='ENSEMBL_MART_ENSEMBL', dataset='btaurus_gene_ensembl')
## ## Download all the Ensembl gene annotations (no filtering)
## allgenes.Ensembl = getBM(
##     attributes=c('ensembl_gene_id', 'external_gene_id', 'description'),
##     mart=ensembl75)
## # Rename the gene identifier column to 'gene_id'
## # This allows GOexpress to treat microarray and RNA-seq data identically
## colnames(allgenes.Ensembl)[1] = 'gene_id'
## ## Download all the gene ontology annotations (no filtering)
## allGO.Ensembl = getBM(
##     attributes=c('go_id', 'name_1006', 'namespace_1003'),
##     mart=ensembl75)
## ## Download all the mapping between gene and gene ontology identifiers
## GOgenes.Ensembl = getBM(
##     attributes=c('ensembl_gene_id', 'go_id'),
##     mart=ensembl75)
## # Rename the gene identifier column to 'gene_id'
## colnames(GOgenes.Ensembl)[1] = 'gene_id'
## # Cleanup: remove some blank fields often found in both columns
## GOgenes.Ensembl = GOgenes.Ensembl[GOgenes.Ensembl$go_id != '',]
## GOgenes.Ensembl = GOgenes.Ensembl[GOgenes.Ensembl$gene_id != '',]


###################################################
### code chunk number 34: GOexpress-UsersGuide.Rnw:873-883 (eval = FALSE)
###################################################
## # save each custom annotation to a R data file
## save(GOgenes.Ensembl, file='GOgenes.Ensembl75.rda')
## save(allGO.Ensembl, file='allGO.Ensembl75.rda')
## save(allgenes.Ensembl, file='allgenes.Ensembl75.rda')
## # Run an analysis using those local annotations
## GO_analyse(
##     eSet=AlvMac, f='Treatment',
##     GO_genes=GOgenes.Ensembl,
##     all_GO=allGO.Ensembl,
##     all_genes=allgenes.Ensembl)


###################################################
### code chunk number 35: GOexpress-UsersGuide.Rnw:891-894 (eval = FALSE)
###################################################
## data(AlvMac_GOgenes)
## data(AlvMac_allGO)
## data(AlvMac_allgenes)


###################################################
### code chunk number 36: GOexpress-UsersGuide.Rnw:926-939 (eval = FALSE)
###################################################
## AlvMac_results <- GO_analyse(
##     eSet = AlvMac, f = "Treatment",
##     subset=list(
##         Time=c("6H","24H", "48H"),
##         Treatment=c("CN","MB"))
##     )
## 
## expression_plot(
##     gene_id = "ENSBTAG00000047107", result = BP.5, eSet=AlvMac,
##     x_var = "Timepoint", title.size=1.5,
##     legend.title.size=10, legend.text.size=10, legend.key.size=15,
##     subset=list(Treatment=c("TB","MB"))
##     )


###################################################
### code chunk number 37: GOexpress-UsersGuide.Rnw:950-951
###################################################
hist_scores(result = BP.5, labels = TRUE)


###################################################
### code chunk number 38: GOexpress-UsersGuide.Rnw:958-959
###################################################
quantiles_scores(result = BP.5)


###################################################
### code chunk number 39: GOexpress-UsersGuide.Rnw:978-979 (eval = FALSE)
###################################################
## BP.5.byScore <- rerank(result = BP.5, rank.by = "score")


###################################################
### code chunk number 40: GOexpress-UsersGuide.Rnw:988-989 (eval = FALSE)
###################################################
## BP.5.byPval <- rerank(result = BP.5, rank.by = "p.val")


###################################################
### code chunk number 41: GOexpress-UsersGuide.Rnw:998-1000 (eval = FALSE)
###################################################
## BP.5.pVal_rank <- rerank(result = BP.5, rank.by = "rank")
## BP.5.pVal_rank <- rerank(result = BP.5.pVal_rank, rank.by = "p.val")


###################################################
### code chunk number 42: GOexpress-UsersGuide.Rnw:1021-1022
###################################################
pData(AlvMac) <- droplevels(pData(AlvMac))


###################################################
### code chunk number 43: GOexpress-UsersGuide.Rnw:1038-1042 (eval = FALSE)
###################################################
## subEset(
##     eSet=AlvMac, subset=list(
##     Time=c("2H","6H","24H"),
##     Treatment=c("CN","MB")))


###################################################
### code chunk number 44: GOexpress-UsersGuide.Rnw:1198-1199
###################################################
sessionInfo()


