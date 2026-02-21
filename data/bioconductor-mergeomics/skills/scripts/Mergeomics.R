# Code example from 'Mergeomics' vignette. See references/ for full tutorial.

### R code from vignette source 'Mergeomics.Rnw'

###################################################
### code chunk number 1: Mergeomics.Rnw:80-86 (eval = FALSE)
###################################################
## install.packages("Mergeomics.tar.gz", repos = NULL, 
## type="source")
## ## or from bioconductor3.3 release, use following lines:
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("Mergeomics")


###################################################
### code chunk number 2: Mergeomics.Rnw:198-234 (eval = FALSE)
###################################################
## ###########################################################
## #######    One-step analysis for Mergeomics - 1st way    ##
## ###########################################################
## ## Import library scripts.
## library(Mergeomics)
## 
## ## first, give the module info file, genefile, marker file, and network file
## ## paths for the pipeline
## plan <- list()
## plan$label <- "hdlc"
## plan$folder <- "Results"
## plan$genfile <- system.file("extdata", 
## "genes.hdlc_040kb_ld70.human_eliminated.txt", package="Mergeomics")
## plan$marfile <- system.file("extdata", 
## "marker.hdlc_040kb_ld70.human_eliminated.txt", package="Mergeomics")
## plan$modfile <- system.file("extdata", 
## "modules.mousecoexpr.liver.human.txt", package="Mergeomics")
## plan$inffile <- system.file("extdata", 
## "coexpr.info.txt", package="Mergeomics")
## plan$netfile <- system.file("extdata", 
## "network.mouseliver.mouse.txt", package="Mergeomics")
## 
## ## second, define pipeline parameters (e.g. permutation #, seed for random #
## ## generator, min and max module sizes, max overlapping ratio, etc.)
## plan$permtype <- "gene" ## default setting is gene permutation
## plan$nperm <- 100 ## default value is 20000
## plan$mingenes <- 10   ## default value is 10
## plan$maxgenes <- 500   ## default value is 500
## 
## ## then, call the one-step pipeline function including both MSEA and KDA steps
## plan <- MSEA.KDA.onestep(plan, apply.MSEA=TRUE, apply.KDA=TRUE, 
## maxoverlap.genesets=0.20, symbol.transfer.needed=TRUE, 
## sym.from=c("HUMAN", "MOUSE"), sym.to=c("HUMAN", "MOUSE"))
## ## NOTE: default value of maxoverlap.genesets=0.33; but in all the examples of
## ## this tutorial it is 0.2 (see job.msea$rmax<- 0.2 in the following example)
## ## maxoverlap.genesets=0.33 (or job.msea$rmax<- 0.33) is recommended to use.


###################################################
### code chunk number 3: Mergeomics.Rnw:241-287
###################################################
###########################################################
#######    One-step analysis for Mergeomics - 2nd way    ##
###########################################################
## Import library scripts.
library(Mergeomics)
################ MSEA (Marker set enrichment analysis)  ###
job.msea <- list()
job.msea$label <- "hdlc"
job.msea$folder <- "Results"
job.msea$genfile <- system.file("extdata", 
"genes.hdlc_040kb_ld70.human_eliminated.txt", package="Mergeomics")
job.msea$marfile <- system.file("extdata", 
"marker.hdlc_040kb_ld70.human_eliminated.txt", package="Mergeomics")
job.msea$modfile <- system.file("extdata", 
"modules.mousecoexpr.liver.human.txt", package="Mergeomics")
job.msea$inffile <- system.file("extdata", "coexpr.info.txt", 
package="Mergeomics")
job.msea$nperm <- 100 ## default value is 20000 (this is recommended)
job.msea <- ssea.start(job.msea)
job.msea <- ssea.prepare(job.msea)
job.msea <- ssea.control(job.msea)
job.msea <- ssea.analyze(job.msea)
job.msea <- ssea.finish(job.msea)
#########  Create intermediary datasets for KDA ###########
syms <- tool.read(system.file("extdata", "symbols.txt", 
package="Mergeomics"))
syms <- syms[,c("HUMAN", "MOUSE")]
names(syms) <- c("FROM", "TO")

## default and recommended rmax=0.33.
## min.module.count is the number of the pathways to be taken from the MSEA
## results to merge. If it is not specified (NULL), all the pathways having 
## MSEA-FDR value less than 0.25 will be considered for merging if they are 
## overlapping with the given ratio rmax. 
job.kda <- ssea2kda(job.msea, rmax=0.2, symbols=syms, min.module.count=NULL) 
#######   wKDA (Weighted key driver analysis)    ##########
job.kda$netfile <- system.file("extdata", 
"network.mouseliver.mouse.txt", package="Mergeomics")
job.kda <- kda.configure(job.kda)
job.kda <- kda.start(job.kda)
job.kda <- kda.prepare(job.kda)
job.kda <- kda.analyze(job.kda)
job.kda <- kda.finish(job.kda)
######  Prepare network files for visualization   #########
## Creates the input files for Cytoscape (http://www.cytoscape.org/)
job.kda <- kda2cytoscape(job.kda)


###################################################
### code chunk number 4: Mergeomics.Rnw:298-347 (eval = FALSE)
###################################################
## ###########################################################
## ## Import Mergeomics library.
## library("Mergeomics")
## ## create an empty list for setting parameters
## job.msea <- list()
## ## Next, label your project
## job.msea$label <- "HDLC"
## ## The pathway size varies from 1 to a few thousands and will
## ## introduce bias to the analysis. We set criteria for the 
## ## min. (mingenes) and max. (maxgenes) gene size for the pathways.
## job.msea$maxgenes <- 500
## job.msea$mingenes <- 10
## ## The permutation setting and number of permutations. We recommend 
## ## using gene permutation due to its robust performance. 
## ## The alternative is locus permutation.
## job.msea$permtype <- "gene"
## job.msea$nperm <- 100 ## default value is 20000 (this is recommended)
## ## set the output folder
## job.msea$folder <- "./Results"
## ## The parameter genfile defines the Marker-to-Gene mapping file
## ## It contains two columns, GENE and MARKER, delimited by tab 
## job.msea$genfile <- system.file("extdata", 
## "genes.hdlc_040kb_ld70.human_eliminated.txt", package="Mergeomics")
## ## The parameter marfile defines the Disease association data file
## ## It contains two columns, MARKER and VALUE, delimited by tab
## ## Here, the marfile comes from the GWAS file after marker 
## ## dependency pruning, so the VALUE is the minus log10 transformed
## job.msea$marfile <- system.file("extdata", 
## "marker.hdlc_040kb_ld70.human_eliminated.txt", package="Mergeomics")
## ## The modfile defines the pathway information, which could come 
## ## from knowledge-based databases (such as KEGG, and Reactome) 
## ## or data-driven data sets (such as co-expression modules).
## ## It contains two columns, MOUDLE and GENE, delimited by tab
## job.msea$modfile <- system.file("extdata", 
## "modules.mousecoexpr.liver.human.txt", package="Mergeomics")
## ## The inffile provides the basic descriptions for the pathways
## ## It contains three columns, MODULE, SOURCE, and DESCR, which 
## ## provide information for pathway IDs corresponding to the 
## ## pathway names in modfile, the sources of the pathways, and
## ## pathway annotations
## job.msea$inffile <- system.file("extdata", "coexpr.info.txt", 
## package="Mergeomics")
## ## Then, MSEA will run for ~30 minutes to ~2 hours
## job.msea <- ssea.start(job.msea)
## job.msea <- ssea.prepare(job.msea)
## job.msea <- ssea.control(job.msea)
## job.msea <- ssea.analyze(job.msea)
## job.msea <- ssea.finish(job.msea)
## ###########################################################


###################################################
### code chunk number 5: Mergeomics.Rnw:382-429 (eval = FALSE)
###################################################
## ###########################################################
## job <-list()
## job$folder <- c("module_merge")
## ## The moddata and modinfo either come from the significant pathways found in
## ## any previous MSEA run or these files can be manually curated by the user.
## ## moddata is an obligatory input file; while modinfo is an optional input.
## ## It is recommended to merge the overlapping pathways among significant
## ## ones before applying KDA to proceed with the independent gene sets.
## moddata <- tool.read(system.file("extdata", "Significant_pathways.txt",
## package="Mergeomics"), c("MODULE","GENE"))
## modinfo <- tool.read(system.file("extdata", "Significant_pathways.info.txt",
## package="Mergeomics"),c("MODULE","SOURCE","DESCR"))
## 
## syms <- tool.read(system.file("extdata", "symbols.txt", 
## package="Mergeomics"))
## syms <- syms[,c("HUMAN", "MOUSE")]
## names(syms) <- c("FROM", "TO")
## moddata$GENE <- tool.translate(words=moddata$GENE, from=syms$FROM,
## to=syms$TO)
## 
## ## Merge and trim overlapping modules.
## rmax <- 0.2
## moddata$OVERLAP <- moddata$MODULE
## moddata <- tool.coalesce(items=moddata$GENE, groups=moddata$MODULE, 
## rcutoff=rmax)
## moddata$MODULE <- moddata$CLUSTER
## moddata$GENE <- moddata$ITEM
## moddata$OVERLAP <- moddata$GROUPS
## moddata <- moddata[,c("MODULE", "GENE", "OVERLAP")]
## moddata <- unique(moddata)
## modinfo <- modinfo[which(!is.na(match(modinfo[,1], moddata[,1]))), ]
## 
## ## Mark modules with overlaps.
## for(i in which(moddata$MODULE != moddata$OVERLAP)){
##     modinfo[which(modinfo[,"MODULE"] == moddata[i,"MODULE"]), 
##             "MODULE"] <- paste(moddata[i,"MODULE"], "..", sep=",")
##     moddata[i,"MODULE"] <- paste(moddata[i,"MODULE"], "..", sep=",")
## }
## ## Save merged module data and info for KDA.
## modfile <- "mergedModules.txt"
## modinfofile <- "mergedModules.info.txt"
## moddata$NODE <- moddata$GENE
## tool.save(frame=unique(moddata[,c("MODULE", "GENE", "OVERLAP", "NODE")]),
## file=modfile, directory=job$folder)
## tool.save(frame=unique(modinfo[,c("MODULE","SOURCE","DESCR")]),
## file=modinfofile, directory=job$folder)
## ###########################################################


###################################################
### code chunk number 6: Mergeomics.Rnw:444-454 (eval = FALSE)
###################################################
## ###########################################################
## ## Assume there are three MSEA objects passed down by 
## ## ssea.finish()
## # job.metamsea = list()
## # job.metamsea$job1 = job.msea1
## # job.metamsea$job2 = job.msea2
## # job.metamsea$job3 = job.msea3
## # job.metamsea = ssea.meta(job.metamsea,"meta_label",
## # "meta_folder")
## ###########################################################


###################################################
### code chunk number 7: Mergeomics.Rnw:465-498 (eval = FALSE)
###################################################
## ###########################################################
## job.kda <- list()
## job.kda$label<-"HDLC"
## ## parent folder for results
## job.kda$folder<-"./Results"
## ## Input a network
## ## columns: TAIL HEAD WEIGHT
## job.kda$netfile <- system.file("extdata", "network.mouseliver.mouse.txt", 
## package="Mergeomics")
## ## Gene sets derived from ModuleMerge, containing two columns,
## ## MODULE, NODE, delimited by tab 
## job.kda$modfile<- system.file("extdata", 
## "mergedModules.txt", package="Mergeomics")
## ## Annotation file for the gene sets
## ## if module or pathway annotation is not available, skip this:
## job.kda$inffile<-system.file("extdata", 
## "mergedModules.info.txt", package="Mergeomics")
## ## "0" means we do not consider edge weights while 1 is 
## ## opposite.
## job.kda$edgefactor<-0.5 ## default value
## ## The searching depth for the KDA
## job.kda$depth<-1 ## default value
## ## "0" means we do not consider the directions of the 
## ## regulatory interactions
## ## while 1 is opposite.
## job.kda$direction<-0 ## default value
## ## Let us run KDA!
## job.kda <- kda.configure(job.kda)
## job.kda <- kda.start(job.kda)
## job.kda <- kda.prepare(job.kda)
## job.kda <- kda.analyze(job.kda)
## job.kda <- kda.finish(job.kda)
## ###########################################################


###################################################
### code chunk number 8: Mergeomics.Rnw:547-553 (eval = FALSE)
###################################################
## ###########################################################
## ## run following line after finishing the KDA process
## ## i.e., after the kda.finish() function concluded
## job.kda <- kda2cytoscape (job.kda, node.list=NULL, 
## modules=NULL, ndrivers=5, depth=1)
## ###########################################################


