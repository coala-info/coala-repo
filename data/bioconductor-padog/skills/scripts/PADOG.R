# Code example from 'PADOG' vignette. See references/ for full tutorial.

### R code from vignette source 'PADOG.Rnw'

###################################################
### code chunk number 1: fig1
###################################################
library(PADOG)
set = "GSE9348"
data(list = set, package = "KEGGdzPathwaysGEO")
#write a function to extract required info into a list
getdataaslist = function(x) {
    x = get(x)
    exp = experimentData(x)
    dataset = exp@name
    disease = notes(exp)$disease
    dat.m = exprs(x)
    ano = pData(x)
    design = notes(exp)$design
    annotation = paste(x@annotation, ".db", sep = "")
    targetGeneSets = notes(exp)$targetGeneSets
    list = list(dataset, disease, dat.m, ano, design, annotation, targetGeneSets)
    names(list) = c("dataset", "disease", "dat.m", "ano", "design", "annotation", 
        "targetGeneSets")
    return(list)
}
dlist = getdataaslist(set)
#run padog function on KEGG pathways
#use NI=1000 for accurate results and run in parallel to speed up (see below)
myr = padog(
    esetm = dlist$dat.m,
    group = dlist$ano$Group,
    paired = dlist$design == "Paired",
    block = dlist$ano$Block,
    targetgs = dlist$targetGeneSets,
    annotation = dlist$annotation,
    gslist = "KEGGRESTpathway",
    organism = "hsa",
    verbose = FALSE,
    Nmin = 3,
    NI = 50,
    plots = TRUE,
    dseed = 1
)

myr[1:15,-c(4,5)]


###################################################
### code chunk number 2: PADOG.Rnw:124-143
###################################################
#you can control the number of cores to use via argument 'ncr' 
myr2 = padog(
    esetm = dlist$dat.m,
    group = dlist$ano$Group,
    paired = dlist$design == "Paired",
    block = dlist$ano$Block,
    targetgs = dlist$targetGeneSets,
    annotation = dlist$annotation,
    gslist = "KEGGRESTpathway",
    organism = "hsa",
    verbose = FALSE,
    Nmin = 3,
    NI = 50,
    plots = TRUE,
    dseed = 1,
    parallel = TRUE
)
# verify that the result is the same which is a built-in feature
all.equal(myr, myr2)


###################################################
### code chunk number 3: PADOG.Rnw:203-261
###################################################
randFun = function(dseed, mname = "myRand") {
    #a helper function to pass additional variables to your method
    getdataaslist = getdataaslist
    return(function(set, mygslist, minsize) {#your method function
        set.seed(dseed)
        #this loads the dataset 
        data(list = set, package = "KEGGdzPathwaysGEO")
        #extract the required info using the function defined earlier 
        dlist = getdataaslist(set)
        #get rid of duplicates probesets per ENTREZ ID by keeping the probeset 
        #with smallest p-value (computed using limma) 
        aT1 = filteranot(esetm = dlist$dat.m, group = dlist$ano$Group, 
            paired = dlist$design == "Paired", block = dlist$ano$Block, 
            annotation = dlist$annotation)
        #create an output dataframe for this toy method with random gene set p-values
        mygslistSize = unlist(lapply(mygslist, function(x) {
            length(intersect(aT1$ENTREZID, x))
        }))
        res = data.frame(ID = names(mygslist), P = runif(length(mygslist)),
            Size = mygslistSize, stringsAsFactors = FALSE)
        res$FDR = p.adjust(res$P,"fdr")
        #drop genesets with less than minsize genes in the current dataset 
        res = res[res$Size >= minsize,]
        #compute ranks
        res$Rank = rank(res$P) / dim(res)[1]*100
        #needed to compare ranks between methods; must be the same as given 
        #in mymethods argument "list(myRand="
        res$Method = mname 
        #needed because comparisons of ranks between methods is paired at dataset level
        res$Dataset = dlist$dataset
        #output only result for the targetGeneSets 
        #which are gene sets expected to be relevant in this dataset
        return(res[res$ID %in% dlist$targetGeneSets,])
        }
    )
}

randomF = randFun(1)

#run the analysis on all 24 datasets and compare the new method "myRand" with 
#PADOG and GSA (if installed) (chosen as reference since is listed first in the
#existingMethods) 
#if the package doParallel is installed datasets are analyzed in parallel.
#out = compPADOG(datasets = NULL, existingMethods = c("GSA","PADOG"),
#    mymethods = list(myRand = randomF), gslist = "KEGGRESTpathway",
#    Nmin = 3, NI = 1000, plots = TRUE, verbose=FALSE, 
#    parallel = TRUE, dseed = 1, pkgs = NULL)

#compare myRand against PADOG on 3 datasets only
#mysets = data(package = "KEGGdzPathwaysGEO")$results[,"Item"]
mysets = c("GSE9348","GSE8671","GSE1297")
out = compPADOG(datasets = mysets, existingMethods = c("PADOG"),
    mymethods = list(myRand = randomF), 
    gslist = "KEGGRESTpathway", Nmin = 3, NI = 40, plots = TRUE, 
    verbose=FALSE, parallel = TRUE, dseed = 1, pkgs = NULL)

print(out)



