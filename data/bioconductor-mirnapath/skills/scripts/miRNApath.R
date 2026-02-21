# Code example from 'miRNApath' vignette. See references/ for full tutorial.

### R code from vignette source 'miRNApath.Rnw'

###################################################
### code chunk number 1: miRNApath.Rnw:61-62
###################################################
library("miRNApath")


###################################################
### code chunk number 2: miRNApath.Rnw:79-94
###################################################
## Start with miRNA data from this package
data(mirnaobj);

## Write a file as example of required input
write.table(mirnaobj@mirnaTable, file="mirnaTable.txt", 
    quote=FALSE, row.names=FALSE, col.names=TRUE, na="",
    sep="\t");

## Now essentially load it back, but assign column headers
mirnaobj <- loadmirnapath( mirnafile="mirnaTable.txt",
    pvaluecol="P-value", groupcol="GROUP", 
    mirnacol="miRNA Name", assayidcol="ASSAYID" );

## Display summary information for the resulting object
mirnaobj;


###################################################
### code chunk number 3: miRNApath.Rnw:103-104
###################################################
mirnaobj@columns["pvaluecol"] <- "P-value";


###################################################
### code chunk number 4: miRNApath.Rnw:111-113
###################################################
mirnaobj <- filtermirnapath( mirnaobj, pvalue=0.05,
    expression=NA, foldchange=NA );


###################################################
### code chunk number 5: miRNApath.Rnw:122-133
###################################################
## Again we load data from the package
data(mirnaobj);

## Write a file as example of required miRNA-gene input
write.table(mirnaobj@mirnaGene, file="mirnaGene.txt", 
    quote=FALSE, row.names=FALSE, col.names=TRUE, na="",
    sep="\t");

## For consistency to a new user's workflow, remove pathways
mirnaobj@pathwaycount = 0;
mirnaobj@mirnaPathways = data.frame();


###################################################
### code chunk number 6: miRNApath.Rnw:135-143
###################################################
## Load the miRNA to gene associations
mirnaobj <- loadmirnatogene( mirnafile="mirnaGene.txt",
    mirnaobj=mirnaobj, mirnacol="miRNA Name",
    genecol="Entrez Gene ID", 
    columns=c(assayidcol="ASSAYID") );

## Display summary, noting the miRNA-gene predictions
mirnaobj;


###################################################
### code chunk number 7: miRNApath.Rnw:154-161
###################################################
## Again we load data from the package
data(mirnaobj);

## Write a file as example of required input
write.table(mirnaobj@mirnaPathways, file="mirnaPathways.txt", 
    quote=FALSE, row.names=FALSE, col.names=TRUE, na="",
    sep="\t");


###################################################
### code chunk number 8: miRNApath.Rnw:163-170
###################################################
## Load the gene to pathway associations
mirnaobj <- loadmirnapathways( mirnaobj=mirnaobj, 
    pathwayfile="mirnaPathways.txt", 
    pathwaycol="Pathway Name", genecol="Entrez Gene ID");

## Display summary, noting the number of pathways reported
mirnaobj;


###################################################
### code chunk number 9: miRNApath.Rnw:179-183
###################################################
Groups = unique(mirnaobj@mirnaTable[,
	mirnaobj@columns["groupcol"] ]);
mirnaobj <- runEnrichment( mirnaobj=mirnaobj, Composite=TRUE,
   groups=Groups[grep("^AD.+(UP|DOWN)",Groups)], permutations=0 );


###################################################
### code chunk number 10: miRNApath.Rnw:196-202
###################################################
finaltable <- mirnaTable( mirnaobj, groups=NULL, format="Tall", 
   Significance=0.1, pvalueTypes=c("pvalues","permpvalues"),
   maxStringLength=42 );

## Display only the first few rows of the best P-values...
finaltable[sort(finaltable[,"pvalues"], index.return=TRUE)$ix,][1:5,];


###################################################
### code chunk number 11: heatmap
###################################################
## Example which calls heatmap function on the resulting data
widetable <- mirnaTable( mirnaobj, groups=NULL, format="Wide", 
    Significance=0.3, na.char=NA, pvalueTypes=c("pvalues") );
## Assign 1 to NA values, assuming they're all equally
## non-significant
widetable[is.na(widetable)] <- 1;

## Display a heatmap of the result across sample groups
pathwaycol <- mirnaobj@columns["pathwaycol"];
pathwayidcol <- mirnaobj@columns["pathwayidcol"];
rownames(widetable) <- apply(widetable[,c(pathwaycol,
   pathwayidcol)], 1, function(i)paste(i, collapse="-"));
wt <- as.matrix(widetable[3:dim(widetable)[2]], mode="numeric");

pathwaySubset = apply(wt, 1, function(i)length(i[i<0.2])>1)

## Print out a heatmap
par(ps="8");
heatmap(log2(wt[pathwaySubset,]), scale="row",
  cexRow=0.9, margins=c(15,12));



###################################################
### code chunk number 12: miRNApath.Rnw:245-247 (eval = FALSE)
###################################################
## grid.newpage()
## 


