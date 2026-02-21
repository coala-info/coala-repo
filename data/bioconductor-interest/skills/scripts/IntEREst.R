# Code example from 'IntEREst' vignette. See references/ for full tutorial.

## ----pipeline, out.width = 500, ppi=100, fig.retina = NULL, fig.align="center", echo=FALSE, eval=TRUE, fig.cap="**Figure 1:** Diagram of IntEREst running pipeline"----
knitr::include_graphics("../inst/fig/IntEREst.png")

## ----collapseExons, out.width = 500, ppi=100, fig.retina = NULL, fig.align="center", echo=FALSE, eval=TRUE, fig.cap="**Figure 2:** Running reference isoforms a, b, c and d leads to gene A with exons that are results of collapsing of exons of all isoforms."----
knitr::include_graphics("../inst/fig/collapseExons.png")

## ----reference_build, out.width = 500, echo=TRUE, eval=TRUE-------------------
# Load library quietly
suppressMessages(library("IntEREst"))
# Selecting rows related to RHBDD3 gene
tmpGen<-u12[u12[,"gene_name"]=="RHBDD3",]
# Extracting exons
tmpEx<-tmpGen[tmpGen[,"int_ex"]=="exon",]

# Building GFF3 file
exonDat<- cbind(tmpEx[,3], ".",
	tmpEx[,c(7,4,5)], ".", tmpEx[,6], ".",paste("ID=exon",
	tmpEx[,11], "; Parent=ENST00000413811", sep="") )
trDat<- c(tmpEx[1,3], ".", "mRNA", as.numeric(min(tmpEx[,4])),
	as.numeric(max(tmpEx[,5])), ".", tmpEx[1,6], ".",
	"ID=ENST00000413811")
outDir<- file.path(tempdir(),"tmpFolder")
dir.create(outDir)
outDir<- normalizePath(outDir)
gff3File<-paste(outDir, "gffFile.gff", sep="/")
cat("##gff-version 3\n",file=gff3File, append=FALSE)
cat(paste(paste(trDat, collapse="\t"),"\n", sep=""),
	file=gff3File, append=TRUE)
write.table(exonDat, gff3File,
	row.names=FALSE, col.names=FALSE,
	sep='\t', quote=FALSE, append=TRUE)

# Extracting U12 introns info from 'u12' data
u12Int<-u12[u12$int_ex=="intron"&u12$int_type=="U12",]

# Building reference
#Since it is based on one gene only (that does not feature alternative splicing
#events) there is no difference if the collapseExons is set as TRUE or FALSE
testRef<- referencePrepare (sourceBuild="file",
	filePath=gff3File, u12IntronsChr=u12Int[,"chr"],
	u12IntronsBeg=u12Int[,"begin"],
	u12IntronsEnd=u12Int[,"end"], collapseExons=TRUE,
	fileFormat="gff3", annotateGeneIds=FALSE)

head (testRef)

## ----annotate_u12, out.width = 500, echo=TRUE, eval=TRUE----------------------
# Improting genome
BSgenome.Hsapiens.UCSC.hg19 <-
BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
#Index of the subset of rows
ind<- u12$gene_name %in% c("RHBDD2", "YBX2")

# Annotate U12 introns with strong U12 donor site, branch point
# and acceptor site from the u12 data in the package
annoU12<-
	annotateU12(pwmU12U2=list(pwmU12db[[1]][,11:17],pwmU12db[[2]],
		pwmU12db[[3]][,38:40],pwmU12db[[4]][,11:17],
		pwmU12db[[5]][,38:40]),
	pwmSsIndex=list(indexDonU12=1, indexBpU12=1, indexAccU12=3,
		indexDonU2=1, indexAccU2=3),
	referenceChr=u12[ind,'chr'],
	referenceBegin=u12[ind,'begin'],
	referenceEnd=u12[ind,'end'],
	referenceIntronExon=u12[ind,"int_ex"],
	intronExon="intron",
	matchWindowRelativeUpstreamPos=c(NA,-29,NA,NA,NA),
	matchWindowRelativeDownstreamPos=c(NA,-9,NA,NA,NA),
	minMatchScore=c(rep(paste(80,"%",sep=""),2), "40%",
	paste(80,"%",sep=""), "40%"),
	refGenome=BSgenome.Hsapiens.UCSC.hg19,
	setNaAs="U2",
	annotateU12Subtype=TRUE)
# How many U12 and U2 type introns with strong U12 donor sites,
# acceptor sites (and branch points for U12-type) are there?
	table(annoU12[,1])

## ----testInterest, out.width = 500, echo=TRUE, eval=TRUE----------------------
# Creating temp directory to store the results
outDir<- file.path(tempdir(),"interestFolder")
dir.create(outDir)
outDir<- normalizePath(outDir)
# Loading suitable bam file
bamF <- system.file("extdata", "small_test_SRR1691637_ZRSR2Mut_RHBDD3.bam",
	package="IntEREst", mustWork=TRUE)
# Choosing reference for the gene RHBDD3
ref<-u12[u12[,"gene_name"]=="RHBDD3",]

# Intron retention analysis
# Reads mapping to inner introns are considered, hence 
# junctionReadsOnly is FALSE
testInterest<- interest(
	bamFileYieldSize=10000,
	junctionReadsOnly=FALSE,
	bamFile=bamF,
	isPaired=TRUE,
	isPairedDuplicate=NA,
	isSingleReadDuplicate=NA,
	reference=ref,
	referenceGeneNames=ref[,"ens_gene_id"],
	referenceIntronExon=ref[,"int_ex"],
	repeatsTableToFilter=c(),
	outFile=paste(outDir,
		"intRetRes.tsv", sep="/"),
	logFile=paste(outDir,
		"log.txt", sep="/"),
	method="IntRet",
	returnObj=FALSE,
	scaleLength= TRUE,
	scaleFragment= TRUE,
	strandSpecific="unstranded"
)

testIntRetObj<- readInterestResults(
    resultFiles= paste(outDir,
		"intRetRes.tsv", sep="/"), 
    sampleNames="small_test_SRR1691637_ZRSR2Mut_RHBDD3", 
    sampleAnnotation=data.frame( 
        type="ZRSR2mut",
        test_ctrl="test"), 
    commonColumns=1:ncol(ref), freqCol=ncol(ref)+1, 
	scaledRetentionCol=ncol(ref)+2, scaleLength=TRUE, scaleFragment=TRUE, 
	reScale=TRUE, geneIdCol="ens_gene_id")

# Intron Spanning analysis
# Reads mapping to inner introns are considered, hence 
# junctionReadsOnly is FALSE
testInterest<- interest(
	bamFileYieldSize=10000,
	junctionReadsOnly=FALSE,
	bamFile=bamF,
	isPaired=TRUE,
	isPairedDuplicate=FALSE,
	isSingleReadDuplicate=NA,
	reference=ref,
	referenceGeneNames=ref[,"ens_gene_id"],
	referenceIntronExon=ref[,"int_ex"],
	repeatsTableToFilter=c(),
	outFile=paste(outDir,
		"intSpanRes.tsv", sep="/"),
	logFile=paste(outDir,
		"log.txt", sep="/"),
	method="IntSpan",
	returnObj=FALSE,
	scaleLength= TRUE,
	scaleFragment= TRUE,
	strandSpecific="unstranded"
)

testIntSpanObj<- readInterestResults(
    resultFiles= paste(outDir,
		"intSpanRes.tsv", sep="/"), 
    sampleNames="small_test_SRR1691637_ZRSR2Mut_RHBDD3", 
    sampleAnnotation=data.frame( 
        type="ZRSR2mut",
        test_ctrl="test"), 
    commonColumns=1:ncol(ref), freqCol=ncol(ref)+1, 
	scaledRetentionCol=ncol(ref)+2, scaleLength=TRUE, scaleFragment=TRUE, 
	reScale=TRUE, geneIdCol="ens_gene_id")

# Exon-exon junction analysis
# Reads mapping to inner exons are NOT considered, hence 
# junctionReadsOnly is TRUE
testInterest<- interest(
	bamFileYieldSize=10000,
	junctionReadsOnly=TRUE,
	bamFile=bamF,
	isPaired=TRUE,
	isPairedDuplicate=FALSE,
	isSingleReadDuplicate=NA,
	reference=ref,
	referenceGeneNames=ref[,"ens_gene_id"],
	referenceIntronExon=ref[,"int_ex"],
	repeatsTableToFilter=c(),
	outFile=paste(outDir,
		"exExRes.tsv", sep="/"),
	logFile=paste(outDir,
		"log.txt", sep="/"),
	method="ExEx",
	returnObj=FALSE,
	scaleLength= TRUE,
	scaleFragment= TRUE,
	strandSpecific="unstranded"
)

testExExObj<- readInterestResults(
    resultFiles= paste(outDir,
		"exExRes.tsv", sep="/"), 
    sampleNames="small_test_SRR1691637_ZRSR2Mut_RHBDD3", 
    sampleAnnotation=data.frame( 
        type="ZRSR2mut",
        test_ctrl="test"), 
    commonColumns=1:ncol(ref), freqCol=ncol(ref)+1, 
	scaledRetentionCol=ncol(ref)+2, scaleLength=TRUE, scaleFragment=TRUE, 
	reScale=TRUE, geneIdCol="ens_gene_id")

# View intron retention result object
testIntRetObj
# View intron spanning  result object
testIntSpanObj
# View exon-exon junction result object
testExExObj

# View first rows of intron retention read counts table
head(counts(testIntRetObj))
# View first rows of intron spanning read counts table
head(counts(testIntSpanObj))
# View first rows of exon-exon junction read counts table
head(counts(testExExObj))


## ----view_object, out.width = 500, echo=TRUE, eval=TRUE-----------------------
# Load library quietly
suppressMessages(library("IntEREst"))
#View object
mdsChr22Obj

mdsChr22ExObj


# See read counts
head(counts(mdsChr22Obj))

# See FPKM Normalized values
head(scaledRetention(mdsChr22Obj))

# See intron/exon annotations
head(rowData(mdsChr22Obj))

# See sample annotations
head(colData(mdsChr22Obj))



## ----plot_intron_object, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center", fig.cap="**Figure 3:** Plotting the distribution of the retention levels ($log_e$ scaled retention) of introns of genes located on chromosome 22. The values have been averaged across the sample types ZRSR2 mutated, ZRSR2 wild type, and healthy."----

# Retention of all introns
plot(mdsChr22Obj, logScaleBase=exp(1), pch=20, loessLwd=1.2, 
	summary="mean", col="black", sampleAnnoCol="type", 
	lowerPlot=TRUE, upperPlot=TRUE)

## ----plot_u12intron_object, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center", fig.cap="**Figure 4:** Plotting the distribution of the retention levels ($log_e$ scaled retention) of introns of genes located on chromosome 22. The values have been averaged across the sample types ZRSR2 mutated, ZRSR2 wild type, and healthy."----

#Retention of U12 introns
plot(mdsChr22Obj, logScaleBase=exp(1), pch=20, plotLoess=FALSE, 
	summary="mean", col="black", sampleAnnoCol="type", 
	subsetRows=u12Index(mdsChr22Obj, intTypeCol="intron_type"))

## ----exact_test, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center"----
# Check the sample annotation table
getAnnotation(mdsChr22Obj)

# Run exact test
test<- exactTestInterest(mdsChr22Obj, 
	sampleAnnoCol="test_ctrl", sampleAnnotation=c("ctrl","test"), 
	geneIdCol= "collapsed_transcripts_id", silent=TRUE, disp="common")

# Number of stabilized introns (in Chr 22)
sInt<- length(which(test$table[,"PValue"]<0.05 
	& test$table[,"logFC"]>0 & 
	rowData(mdsChr22Obj)[,"int_ex"]=="intron"))
print(sInt)
# Number of stabilized (significantly retained) U12 type introns
numStU12Int<- length(which(test$table[,"PValue"]<0.05 & 
	test$table[,"logFC"]>0 & 
	rowData(mdsChr22Obj)[,"intron_type"]=="U12" & 
	!is.na(rowData(mdsChr22Obj)[,"intron_type"])))
# Number of U12 introns
numU12Int<- 
	length(which(rowData(mdsChr22Obj)[,"intron_type"]=="U12" & 
	!is.na(rowData(mdsChr22Obj)[,"intron_type"]))) 
# Fraction(%) of stabilized (significantly retained) U12 introns
perStU12Int<- numStU12Int/numU12Int*100
print(perStU12Int)
# Number of stabilized U2 type introns
numStU2Int<- length(which(test$table[,"PValue"]<0.05 & 
	test$table[,"logFC"]>0 & 
	rowData(mdsChr22Obj)[,"intron_type"]=="U2" & 
	!is.na(rowData(mdsChr22Obj)[,"intron_type"])))
# Number of U2 introns
numU2Int<- 
	length(which(rowData(mdsChr22Obj)[,"intron_type"]=="U2" & 
	!is.na(rowData(mdsChr22Obj)[,"intron_type"])))
# Fraction(%) of stabilized U2 introns
perStU2Int<- numStU2Int/numU2Int*100
print(perStU2Int)

## ----glr_test, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center"----

# Extract type of samples
group <- getAnnotation(mdsChr22Obj)[,"type"]
group

# Test retention levels' differentiation across 3 types samples
qlfRes<- qlfInterest(x=mdsChr22Obj, 
	design=model.matrix(~group), silent=TRUE, 
	disp="tagwiseInitTrended", coef=2:3, contrast=NULL, 
	poisson.bound=TRUE)

# Extract index of the introns with significant retention changes
ind= which(qlfRes$table$PValue< 0.05)
# Extract introns with significant retention level changes
variedIntrons= rowData(mdsChr22Obj)[ind,]

#Show first 5 rows and columns of the result table
print(variedIntrons[1:5,1:5])


## ----boxplot_object, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center", fig.cap= "**Figure 5:** Boxplot of the retention levels of U12 introns vs U2 introns, summed over samples with similar annotations *i.e.* ZRSR2 mutation, ZRSR2 wild type, or healthy."----
# boxplot U12 and U2-type introns 
par(mar=c(7,4,2,1))
u12Boxplot(mdsChr22Obj, sampleAnnoCol="type", 
	intExCol="int_ex",	intTypeCol="intron_type", intronExon="intron", 
	col=rep(c("orange", "yellow"),3) ,	lasNames=3, 
	outline=FALSE, ylab="FPKM", cex.axis=0.8)

## ----u12BoxplotNb_object, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center", fig.cap="**Figure 6:** Boxplot of retention levels of U12 introns vs their up- and down-stream U2 introns across all samples."----
# boxplot U12-type intron and its up/downstream U2-type introns 
par(mar=c(2,4,1,1))
u12BoxplotNb(mdsChr22Obj, sampleAnnoCol="type", lasNames=1,
	intExCol="int_ex", intTypeCol="intron_type", intronExon="intron", 
	boxplotNames=c(), outline=FALSE, plotLegend=TRUE, 
	geneIdCol="collapsed_transcripts_id", xLegend="topleft", 
	col=c("pink", "lightblue", "lightyellow"), ylim=c(0,1e+06), 
	ylab="FPKM", cex.axis=0.8)

## ----density_plot, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.cap= "**Figure 7:** Density plot of the log fold change of U12-type introns, random U2-type introns and U2 introns (up / down / up and down)stream of U12-type introns. "----
u12DensityPlotIntron(mdsChr22Obj, 
	type= c("U12", "U2Up", "U2Dn", "U2UpDn", "U2Rand"), 
	fcType= "edgeR", sampleAnnoCol="test_ctrl", 
	sampleAnnotation=c("ctrl","test"), intExCol="int_ex", 
	intTypeCol="intron_type", strandCol= "strand", 
	geneIdCol= "collapsed_transcripts_id", naUnstrand=FALSE, col=c(2,3,4,5,6), 
	lty=c(1,2,3,4,5), lwd=1, plotLegend=TRUE, cexLegend=0.7, 
	xLegend="topright", yLegend=NULL, legend=c(), randomSeed=10,
	ylim=c(0,0.6), xlab=expression("log"[2]*" fold change FPKM"))

# estimate log fold-change of introns 
# by comparing test samples vs ctrl 
# and don't show warnings !
lfcRes<- lfc(mdsChr22Obj, fcType= "edgeR", 
	sampleAnnoCol="test_ctrl",sampleAnnotation=c("ctrl","test"))

# Build the order vector
ord<- rep(1,length(lfcRes))
ord[u12Index(mdsChr22Obj, intTypeCol="intron_type")]=2

# Median of log fold change of U2 introns (ZRSR2 mut. vs ctrl)
median(lfcRes[ord==1])
# Median of log fold change of U2 introns (ZRSR2 mut. vs ctrl)
median(lfcRes[ord==2])

## ----lfc-sig, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center"----
# Run Jockheere Terpstra's trend test
library(clinfun)
jtRes<- jonckheere.test(lfcRes, ord, alternative = "increasing", 
	nperm=1000)
jtRes

## ----downstreamExample, echo = TRUE, eval=TRUE, message = FALSE, fig.width=6, fig.height=4, fig.align="center"----
mdsChr22RefIntRetSpObj<- cbind(mdsChr22Obj, mdsChr22IntSpObj)

mdsChr22RefIntRetSpObj<- addAnnotation(x=mdsChr22RefIntRetSpObj, 
	sampleAnnotationType="intronExon", 
	sampleAnnotation=c(rep("intron",16), rep("exon",16))
	)

library(BiocParallel)
mdsChr22RefIntRetSpIntFilObj<- 
	mdsChr22RefIntRetSpObj[rowData(mdsChr22RefIntRetSpObj)$int_ex=="intron",]

# Differential IR analysis run
ddsChr22Diff<- deseqInterest(mdsChr22RefIntRetSpIntFilObj,  
    design=~test_ctrl+test_ctrl:intronExon, 
    sizeFactor=rep(1,nrow(colData(mdsChr22RefIntRetSpIntFilObj))), 
    contrast=list("test_ctrltest.intronExonintron",
        "test_ctrlctrl.intronExonintron"),
    bpparam = SnowParam(workers=20))

# See the number of significantly more retained U12 and U2 introns
pThreshold<- 0.01
mdsChr22UpIntInd<- which(ddsChr22Diff$padj< pThreshold & ddsChr22Diff$padj>0)
table(rowData(mdsChr22RefIntRetSpIntFilObj)$intron_type[mdsChr22UpIntInd])

# See the fraction of significantly more retained U12 and U2 introns
100*table(rowData(mdsChr22RefIntRetSpIntFilObj)$intron_type[mdsChr22UpIntInd])/
	table(rowData(mdsChr22RefIntRetSpIntFilObj)$intron_type)

