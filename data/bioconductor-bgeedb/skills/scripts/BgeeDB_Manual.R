# Code example from 'BgeeDB_Manual' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
#if (!requireNamespace("BiocManager", quietly=TRUE))
    #install.packages("BiocManager")
#BiocManager::install("BgeeDB")

## ----message = FALSE, warning = FALSE-----------------------------------------
library(BgeeDB)

## -----------------------------------------------------------------------------
listBgeeSpecies()

## -----------------------------------------------------------------------------
listBgeeSpecies(release = "13.2", order = 2)

## -----------------------------------------------------------------------------
bgee <- Bgee$new(species = "Danio_rerio", dataType = "rna_seq")

## -----------------------------------------------------------------------------
annotation_bgee_zebrafish <- getAnnotation(bgee)
# list the first experiments and libraries
lapply(annotation_bgee_zebrafish, head)

## -----------------------------------------------------------------------------
# download all RNA-seq experiments from zebrafish
data_bgee_zebrafish <- getSampleProcessedData(bgee)
# number of experiments downloaded
length(data_bgee_zebrafish)
# check the downloaded data
lapply(data_bgee_zebrafish, head)
# isolate the first experiment
data_bgee_experiment1 <- data_bgee_zebrafish[[1]]

## -----------------------------------------------------------------------------
# download data for GSE68666
data_bgee_zebrafish_gse68666 <- getSampleProcessedData(bgee, experimentId = "GSE68666")

## ----eval=FALSE---------------------------------------------------------------
# # Examples of data downloading using different filtering combination
# # retrieve zebrafish RNA-Seq data for heart (UBERON:0000955) or brain (UBERON:0000948)
# data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, anatEntityId = c("UBERON:0000955","UBERON:0000948"))
# # retrieve zebrafish RNA-Seq data for embryo (UBERON:0000922) part of the experiment GSE68666
# data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, experimentId = "GSE68666", anatEntityId = "UBERON:0000922")
# # retrieve zebrafish RNA-Seq data for head kidney (UBERON:0007132) or swim bladder (UBERON:0006860) from post-juvenile adult stage (UBERON:0000113)
# data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, stageId = "UBERON:0000113", anatEntityId = c("UBERON:0007132","UBERON:0006860"))
# # retrieve zebrafish RNA-Seq data for brain (UBERON:0000948) and all substructures of brain from post-juvenile adult stage (UBERON:0000113)
# data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, stageId = "UBERON:0000113", anatEntityId = "UBERON:0000948", withDescendantAnatEntities = TRUE)

## -----------------------------------------------------------------------------
# use only present calls and fill expression matrix with TPM values
gene.expression.zebrafish.tpm <- formatData(bgee, data_bgee_zebrafish_gse68666, callType = "present", stats = "tpm")
gene.expression.zebrafish.tpm 

## ----eval=FALSE---------------------------------------------------------------
# #create a bgee object to download droplet based data from Gallus gallus
# bgee <- Bgee$new(species = "Gallus_gallus", dataType = "sc_droplet_based")
# # download cell data for one RNA-seq experiment
# cell_data_bgee_gallus_gallus <- getCellProcessedData(bgee, experimentId = "ERP132576")

## -----------------------------------------------------------------------------
# Creating new Bgee class object
bgee <- Bgee$new(species = "Danio_rerio", release = "15.2")

## -----------------------------------------------------------------------------
# Loading calls of expression
myTopAnatData <- loadTopAnatData(bgee)
# Look at the data
## str(myTopAnatData)

## ----eval=FALSE---------------------------------------------------------------
# ## Loading silver and gold expression calls from affymetrix data made on embryonic samples only
# ## This is just given as an example, but is not run in this vignette because only few data are returned
# bgee <- Bgee$new(species = "Danio_rerio", dataType="affymetrix", release = "15.2")
# myTopAnatData <- loadTopAnatData(bgee, stage="UBERON:0000068", confidence="silver")

## ----eval=FALSE---------------------------------------------------------------
# # if (!requireNamespace("BiocManager", quietly=TRUE))
#     # install.packages("BiocManager")
# # BiocManager::install("biomaRt")
# library(biomaRt)
# ensembl <- useMart("ENSEMBL_MART_ENSEMBL", dataset="drerio_gene_ensembl", host="mar2016.archive.ensembl.org")
# 
# # get the mapping of Ensembl genes to phenotypes. It will corresponds to the background genes
# universe <- getBM(filters=c("phenotype_source"), value=c("ZFIN"), attributes=c("ensembl_gene_id","phenotype_description"), mart=ensembl)
# 
# # select phenotypes related to pectoral fin
# phenotypes <- grep("pectoral fin", unique(universe$phenotype_description), value=T)
# 
# # Foreground genes are those with an annotated phenotype related to "pectoral fin"
# myGenes <- unique(universe$ensembl_gene_id[universe$phenotype_description %in% phenotypes])
# 
# # Prepare the gene list vector
# geneList <- factor(as.integer(unique(universe$ensembl_gene_id) %in% myGenes))
# names(geneList) <- unique(universe$ensembl_gene_id)
# summary(geneList)
# 
# # Prepare the topGO object
# myTopAnatObject <-  topAnat(myTopAnatData, geneList)

## -----------------------------------------------------------------------------
data(geneList)
myTopAnatObject <-  topAnat(myTopAnatData, geneList)

## -----------------------------------------------------------------------------
results <- runTest(myTopAnatObject, algorithm = 'weight', statistic = 'fisher')

## -----------------------------------------------------------------------------
# Display results sigificant at a 1% FDR threshold
tableOver <- makeTable(myTopAnatData, myTopAnatObject, results, cutoff = 0.01)
head(tableOver)

## -----------------------------------------------------------------------------
# In order to retrieve significant genes mapped to the term " paired limb/fin bud"
term <- "UBERON:0004357"
termStat(myTopAnatObject, term) 

# 172 genes mapped to this term for Bgee 15.2
genesInTerm(myTopAnatObject, term)
# 37 significant genes mapped to this term for Bgee 15.2
annotated <- genesInTerm(myTopAnatObject, term)[["UBERON:0004357"]]
annotated[annotated %in% sigGenes(myTopAnatObject)]

## ----eval = FALSE-------------------------------------------------------------
# bgee <- Bgee$new(species="Mus_musculus", release = "14.1")
# # delete all old .rds files of species Mus musculus
# deleteOldData(bgee)

## ----eval = FALSE-------------------------------------------------------------
# bgee <- Bgee$new(species="Mus_musculus", release = "14.1")
# # delete local SQLite database of species Mus musculus from Bgee 14.1
# deleteLocalData(bgee)

