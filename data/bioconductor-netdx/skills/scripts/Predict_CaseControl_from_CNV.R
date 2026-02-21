# Code example from 'Predict_CaseControl_from_CNV' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  suppressMessages(require(netDx))
#  suppressMessages(require(GenomicRanges))
#  
#  # read patient CNVs
#  phenoFile <- paste(path.package("netDx"), "extdata", "AGP1_CNV.txt",
#  	sep=getFileSep())
#  pheno   <- read.delim(phenoFile,sep="\t",header=TRUE,as.is=TRUE)
#  # sample metadata table must have ID and STATUS columns
#  colnames(pheno)[1] <- "ID"
#  
#  # create GRanges object.
#  # Must have ID and LOCUS_NAMES in metadata
#  cnv_GR    <- GRanges(pheno$seqnames,
#  		IRanges(pheno$start,pheno$end),
#  		ID=pheno$ID,LOCUS_NAMES=pheno$Gene_symbols)
#  pheno <- pheno[!duplicated(pheno$ID),]
#  
#  pathFile <- fetchPathwayDefinitions(
#  	"February",2018,verbose=TRUE)
#  pathwayList <- readPathways(pathFile)
#  
#  # get gene coordinates, use hg18
#  # cache for faster local access
#  require(BiocFileCache)
#  geneURL <- paste("http://download.baderlab.org/netDx/",
#  	"supporting_data/refGene.hg18.bed",sep="")
#  cache <- rappdirs::user_cache_dir(appname = "netDx")
#  bfc <- BiocFileCache::BiocFileCache(cache,ask=FALSE)
#  geneFile <- bfcrpath(bfc,geneURL)
#  genes <- read.delim(geneFile,sep="\t",header=FALSE,as.is=TRUE)
#  genes <- genes[which(genes[,4]!=""),]
#  gene_GR     <- GRanges(genes[,1],
#  		IRanges(genes[,2],genes[,3]),
#     	name=genes[,4]
#  )
#  
#  # create GRangesList of pathway ranges
#  path_GRList <- mapNamedRangesToSets(gene_GR,pathwayList)
#  
#  outDir <- paste(tempdir(),randAlphanumString(),
#  	"ASD",sep=getFileSep()) ## absolute path
#  if (file.exists(outDir)) unlink(outDir,recursive=TRUE); dir.create(outDir)
#  
#  message("Getting java version for debugging")
#  	java_ver <- suppressWarnings(
#  		system2("java", args="--version",stdout=TRUE,stderr=NULL)
#  	)
#  print(java_ver)
#  message("***")
#  
#  predictClass	<- "case"
#  out <- buildPredictor_sparseGenetic(
#  			pheno, cnv_GR, predictClass,
#        path_GRList,
#  		outDir=outDir, ## absolute path
#        numSplits=3L, featScoreMax=3L,
#        enrichLabels=TRUE,numPermsEnrich=3L,
#        numCores=2L)
#  
#  # plot ROC curve. Note that the denominator only includes
#  # patients with events in networks that are label-enriched
#  dat	<- out$performance_denEnrichedNets
#  plot(0,0,type="n",xlim=c(0,100),ylim=c(0,100),
#  	las=1, xlab="False Positive Rate (%)",
#  	ylab="True Positive Rate (%)",
#  	bty='n',cex.axis=1.5,cex.lab=1.3,
#  	main="ROC curve - Patients in label-enriched pathways")
#  points(dat$other_pct,dat$pred_pct,
#  	  col="red",type="o",pch=16,cex=1.3,lwd=2)
#  
#  # calculate AUROC and AUPR
#  tmp <- data.frame(	
#  	score=dat$score,
#  	tp=dat$pred_ol,fp=dat$other_ol,
#  	# tn: "-" that were correctly not called
#  	tn=dat$other_tot - dat$other_ol,
#  	# fn: "+" that were not called
#  	fn=dat$pred_tot - dat$pred_ol)
#  
#  stats <- netDx::perfCalc(tmp)
#  tmp <- stats$stats
#  message(sprintf("PRAUC = %1.2f\n", stats$prauc))
#  message(sprintf("ROCAUC = %1.2f\n", stats$auc))
#  
#  # examine pathway-level scores; these are
#  # cumulative across the splits - here, each of three
#  # splits has a max feature score of three, so
#  # a feature can score a max of (3 + 3 + 3) = 9.
#  print(head(out$cumulativeFeatScores))

## ----eval=TRUE----------------------------------------------------------------
suppressMessages(require(netDx))
suppressMessages(require(GenomicRanges))

## ----eval=TRUE----------------------------------------------------------------

outDir <- paste(tempdir(),randAlphanumString(),
	"ASD",sep=getFileSep()) ## must be absolute path
if (file.exists(outDir)) unlink(outDir,recursive=TRUE); 
dir.create(outDir)

cat("* Setting up sample metadata\n")
phenoFile <- paste(path.package("netDx"), "extdata", "AGP1_CNV.txt", 
	sep=getFileSep())
pheno   <- read.delim(phenoFile,sep="\t",header=TRUE,as.is=TRUE)
colnames(pheno)[1] <- "ID"
head(pheno)

cnv_GR    <- GRanges(pheno$seqnames,IRanges(pheno$start,pheno$end),
                        ID=pheno$ID,LOCUS_NAMES=pheno$Gene_symbols)
pheno <- pheno[!duplicated(pheno$ID),]

## ----eval=TRUE----------------------------------------------------------------
pathFile <- fetchPathwayDefinitions("February",2018,verbose=TRUE)
pathwayList <- readPathways(pathFile)

# get gene coordinates, use hg18
# cache for faster local access
require(BiocFileCache)
geneURL <- paste("http://download.baderlab.org/netDx/",
	"supporting_data/refGene.hg18.bed",sep="")
cache <- rappdirs::user_cache_dir(appname = "netDx")
bfc <- BiocFileCache::BiocFileCache(cache,ask=FALSE)
geneFile <- bfcrpath(bfc,geneURL)
genes <- read.delim(geneFile,sep="\t",header=FALSE,as.is=TRUE)
genes <- genes[which(genes[,4]!=""),]
gene_GR     <- GRanges(genes[,1],IRanges(genes[,2],genes[,3]),
   name=genes[,4])

## ----eval=TRUE----------------------------------------------------------------
path_GRList <- mapNamedRangesToSets(gene_GR,pathwayList)

## ----eval=TRUE----------------------------------------------------------------
predictClass	<- "case"
out <- 
   buildPredictor_sparseGenetic(pheno, cnv_GR, predictClass,
                             path_GRList,
                             outDir=outDir, ## absolute path
                             numSplits=3L, featScoreMax=3L,
                             enrichLabels=TRUE,numPermsEnrich=3L,
                             numCores=2L)

## ----eval=TRUE----------------------------------------------------------------
dat	<- out$performance_denEnrichedNets
plot(0,0,type="n",xlim=c(0,100),ylim=c(0,100),
	las=1, xlab="False Positive Rate (%)", 
	ylab="True Positive Rate (%)",
	bty='n',cex.axis=1.5,cex.lab=1.3,
	main="ROC curve - Patients in label-enriched pathways")
points(dat$other_pct,dat$pred_pct,
	  col="red",type="o",pch=16,cex=1.3,lwd=2)

## ----eval=TRUE----------------------------------------------------------------
tmp <- data.frame(	
	score=dat$score,
	tp=dat$pred_ol,fp=dat$other_ol,
	# tn: "-" that were correctly not called
	tn=dat$other_tot - dat$other_ol,
	# fn: "+" that were not called 
	fn=dat$pred_tot - dat$pred_ol) 

stats <- netDx::perfCalc(tmp)
tmp <- stats$stats
message(sprintf("PRAUC = %1.2f\n", stats$prauc))
message(sprintf("ROCAUC = %1.2f\n", stats$auc))

## ----eval=TRUE----------------------------------------------------------------
# now get pathway score
print(head(out$cumulativeFeatScores))

