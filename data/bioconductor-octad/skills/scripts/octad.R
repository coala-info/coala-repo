# Code example from 'octad' vignette. See references/ for full tutorial.

## ----eval=TRUE----------------------------------------------------------------
#select data
library(octad)
phenoDF=get_ExperimentHub_data("EH7274") #load data.frame with samples included in the OCTAD database. 
head(phenoDF) #list all data included within the package
HCC_primary=subset(phenoDF,cancer=='liver hepatocellular carcinoma'&sample.type == 'primary') #select data
case_id=HCC_primary$sample.id #select cases

## ----eval=TRUE----------------------------------------------------------------
#computing top 50 reference tissues 
control_id=computeRefTissue(case_id,output=FALSE,adjacent=TRUE,source = "octad",control_size = 50)  
#please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
# use adjacent normal tissue samples as control_id allow you to avoid running this function    

## ----eval=TRUE----------------------------------------------------------------
#computing top 50 reference tissues 
control_id=subset(phenoDF,biopsy.site=='LIVER'&sample.type=='normal')$sample.id[1:50] #select first 50 samples from healthy liver
# use adjacent normal tissue samples as control_id allow you to avoid running this function    

## ----eval=TRUE----------------------------------------------------------------
tsne=get_ExperimentHub_data("EH7276") #Download file with tsneresults for all samples in the octad.db once. After this it will be cached and no additional download required.
tsne$type <- "others"
tsne$type[tsne$sample.id %in% case_id] <- "case"
tsne$type[tsne$sample.id %in% control_id] <- "control"

#plot
p2 <- ggplot(tsne, aes(X, Y, color = type)) + geom_point(alpha = 0.4)+
    labs(title = paste ('TNSE PLOT'), x= 'TSNE Dim1', y='TSNE Dim2', caption="OCTAD")+
    theme_bw()
p2

## ----eval=FALSE---------------------------------------------------------------
# res=diffExp(case_id,control_id,source='octad.small',output=FALSE,DE_method='wilcox')
# #please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
# head(res)
# #Use simple subset to filter the DE results:
# res=subset(res,abs(log2FoldChange)>1&padj<0.001)

## ----eval=FALSE---------------------------------------------------------------
# data("res_example") #load differential expression example for HCC vs adjacent liver tissue computed in diffExp() function from previous step
# res=subset(res_example,abs(log2FoldChange)>1&padj<0.001) #load example expression dataset
# sRGES=runsRGES(res,max_gene_size=100,permutations=1000,output=FALSE)
# #please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
# head(sRGES)

## ----eval=TRUE----------------------------------------------------------------
cell_line_computed=computeCellLine(case_id=case_id,source='octad.small')
#please note, if \code{output = TRUE}, \code{outputFolder} variable must be specified, otherwise it will be written to \code{tempdir()}
head(cell_line_computed)

## ----eval=TRUE----------------------------------------------------------------
data("sRGES_example") #load example sRGES from octad.db
#please note, if \code{outputFolder=NULL}, output it will be written to \code{tempdir()}
topLineEval(topline = 'HEPG2',mysRGES = sRGES_example)

## ----eval=TRUE----------------------------------------------------------------
data("sRGES_example") 
octadDrugEnrichment(sRGES = sRGES_example, target_type='chembl_targets')
#please note, if \code{outputFolder=NULL}, output it will be written to \code{tempdir()}

## ----eval=FALSE---------------------------------------------------------------
# get_ExperimentHub_data('EH7277')
# res=diffExp(case_id,control_id,source='octad.whole',
#     output=FALSE,n_topGenes=10000,file='octad.counts.and.tpm.h5')

## ----eval=FALSE---------------------------------------------------------------
# data=data.table::fread(('https://ftp.ncbi.nlm.nih.gov/geo/series/GSE144nnn/GSE144269/suppl/GSE144269_RSEM_GeneCounts.txt.gz'),header=TRUE)
# row.names(data)=data$entrez_id
# data$entrez_id=NULL
# samples=colnames(data) #define the case and control cohorts, A samples were obtained from tumors, B samples were obtained from adjacent tissue
# case_id=samples[grepl('A_S',samples)]
# control_id=samples[grepl('B_S',samples)]
# res=diffExp(case_id,control_id,source='side',output=FALSE,outputFolder=tempdir(),n_topGenes=10000,
#     expSet=log2(as.matrix(data)+1),annotate=FALSE) #compute DE

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

