# Code example from 'GIGSEA_tutorial' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(GIGSEA)

## -----------------------------------------------------------------------------
# runGIGSEA( MetaXcan="software/MetaXcan.py" , 
# model_db_path="eQTL/DGN-WB_0.5.db", 
# covariance="reference/covariance.DGN-WB_0.5.txt.gz", 
# gwas_folder="data/GWAS_summary", gwas_file_pattern="heart.sumstats", 
# output_dir="result/GIGSEA", permutation_num=1000)

## -----------------------------------------------------------------------------
data(heart.metaXcan)
head(heart.metaXcan)

## -----------------------------------------------------------------------------
gene = heart.metaXcan$gene_name
# extract the imputed Z-score of differential gene expression, which follows 
# the normal distribution
fc <- heart.metaXcan$zscore
# use the prediction R^2 and fraction of imputation-used SNPs as weights 
usedFrac <- heart.metaXcan$n_snps_used / heart.metaXcan$n_snps_in_model
r2 <- heart.metaXcan$pred_perf_r2
weights <- usedFrac*r2
# build a new data frame for the following weighted linear regression-based 
# enrichment analysis
data <- data.frame(gene,fc,weights)
head(data)

## -----------------------------------------------------------------------------
# load data
data(MSigDB.KEGG.Pathway)
# MSigDB.KEGG.Pathway is a list comprising two components: net and annot
class(MSigDB.KEGG.Pathway)
names(MSigDB.KEGG.Pathway)
dim(MSigDB.KEGG.Pathway$net)
# the column is the pathway and the row is the gene
head(colnames(MSigDB.KEGG.Pathway$net))
head(rownames(MSigDB.KEGG.Pathway$net))
# the annotation of the pathway
head(MSigDB.KEGG.Pathway$annot)
# the net takes discrete values of 0 or 1
head(MSigDB.KEGG.Pathway$net[,1:30])

## -----------------------------------------------------------------------------
# load data
data(TargetScan.miRNA)
# TargetScan.miRNA is a list comprising two components: net and annot
class(TargetScan.miRNA)
names(TargetScan.miRNA)
dim(TargetScan.miRNA$net)
# the column is the miRNA and the row is the gene
head(colnames(TargetScan.miRNA$net))
head(rownames(TargetScan.miRNA$net))
# the annotation of the miRNA
head(TargetScan.miRNA$annot)
# the net takes continuous values
head(TargetScan.miRNA$net[,1:20])

## -----------------------------------------------------------------------------
# downlaod the gmt file
gmt <- readLines( paste0('http://amp.pharm.mssm.edu/CREEDS/download/',
                        'single_drug_perturbations-v1.0.gmt') )
# obtain the index of up-regulated and down-regulated gene sets
index_up <- grep('-up',gmt)
index_down <- grep('-dn',gmt)
# transform the gmt file into gene sets. The gene set is a data frame, 
# comprising three vectors: term (here is drug), geneset (a gene symbol list 
# separated by comma), and value (1 and -1 separated by comma) 
gff_up <- gmt2geneSet( gmt[index_up] , termCol=c(1,2) , singleValue = 1 )
gff_down <- gmt2geneSet( gmt[index_down] , termCol=c(1,2) , singleValue = -1 )

# as following, combine the up and down-regulated gene sets together, 
# and use value of 1 and -1 to indicate their direction:
# extract the drug names
term_up <- sapply( gff_up$term , function(x) gsub('-up','',x) )
term_down <- sapply( gff_down$term , function(x) gsub('-dn','',x) )
all(term_up==term_down)
# combine up and down-regulated gene names for each drug perturbation
geneset <- sapply( 1:nrow(gff_up) , function(i) 
  paste(gff_up$geneset[i],gff_down$geneset[i],sep=',') )
# use 1 and -1 to indicate direction of up-regulated and down-regulated genes
value <- sapply( 1:nrow(gff_up) , function(i) 
  paste(gff_up$value[i],gff_down$value[i],sep=',') )
# transform the gene set into matrix, where the row represents the gene, 
# the column represents the drug perturbation, and each entry takes values of 
# 1 and -1
net1 <- geneSet2Net( term=term_up , geneset=geneset , value=value )
# transform the gene set into sparse matrix, where the row represents the gene,
# the column represents the drug perturbation, and each entry takes values of 
# 1 and -1
net2 <- geneSet2sparseMatrix( term=term_up , geneset=geneset , value=value )
tail(net1[,1:30])
tail(net2[,1:30])
# the size of sparse matrix is much smaller than the matrix
format( object.size(net1), units = "auto")
format( object.size(net2), units = "auto")

## -----------------------------------------------------------------------------
# take MSigDB.KEGG.Pathway as an example
net <- MSigDB.KEGG.Pathway$net
# intersect the permuted genes with the gene sets of interest
data2 <- orderedIntersect( x = data , by.x = data$gene , by.y = rownames(net) )
net2 <- orderedIntersect( x = net , by.x = rownames(net) , by.y = data$gene  )
all( rownames(net2) == as.character(data2$gene) )
# the SGSEA.res1 uses the weighted simple linear regression model, while 
# SGSEA.res2 used the weighted Pearson correlation. The latter one takes 
# substantially less time. 
system.time( SGSEA.res1 <- permutationSimpleLm( fc=data2$fc , net=net2 , 
                              weights=data2$weights , num=100 ) )
system.time( SGSEA.res2 <- permutationSimpleLmMatrix( fc=data2$fc , 
                              net=net2 , weights=data2$weights , num=100 ) )
head(SGSEA.res2)

## -----------------------------------------------------------------------------
# MGSEA.res1 uses the weighted multiple linear regression model 
system.time( MGSEA.res1 <- permutationMultipleLm( fc=data2$fc , net=net2 , 
                              weights=data2$weights , num=1000 ) )
# MGSEA.res2 used the matrix solution
system.time( MGSEA.res2 <- permutationMultipleLmMatrix( fc=data2$fc , 
                              net=net2 , weights=data2$weights , num=1000 ) )
head(MGSEA.res2)

## -----------------------------------------------------------------------------
# import packages and prepare data as above
library(GIGSEA)

# prepare the dataset
data(heart.metaXcan)
gene = heart.metaXcan$gene_name
fc <- heart.metaXcan$zscore
usedFrac <- heart.metaXcan$n_snps_used / heart.metaXcan$n_snps_in_cov
r2 <- heart.metaXcan$pred_perf_r2
weights <- usedFrac*r2
data <- data.frame(gene,fc,weights)

# run one-step GIGSEA 
#weightedGSEA(data, geneCol='gene', fcCol='fc', weightCol= 'weights',
#geneSet=c("MSigDB.KEGG.Pathway","Fantom5.TF","TargetScan.miRNA","GO"), 
#permutationNum=10000, outputDir="./GIGSEA" )

#dir("./GIGSEA")

