# Code example from 'AllelicImbalance-vignette' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----functions, include=FALSE-------------------------------------------------
# A function for captioning and referencing images
fig <- local({
    i <- 0
    ref <- list()
    list(
        cap=function(refName, text) {
            i <<- i + 1
            ref[[refName]] <<- i
            #paste("Figure ", i, ": ", text, sep="")
            paste(text, sep="")
        },
        ref=function(refName) {
            ref[[refName]]
        })
})

## ----echo = TRUE, eval = TRUE, message = FALSE--------------------------------
library(AllelicImbalance)

## ----echo = TRUE, eval = TRUE-------------------------------------------------
searchArea <- GRanges(seqnames = c("17"), ranges = IRanges(79478301, 79478361))
pathToFiles <- system.file("extdata/ERP000101_subset", 
								package = "AllelicImbalance")
reads <- impBamGAL(pathToFiles, searchArea, verbose = FALSE)
heterozygotePositions <- scanForHeterozygotes(reads, verbose = FALSE)
countList <- getAlleleCounts(reads, heterozygotePositions, verbose = FALSE)
a.simple <- ASEsetFromCountList(heterozygotePositions, countList)
a.simple

## ----echo = TRUE, eval = TRUE, warning = FALSE--------------------------------
library(VariantAnnotation)
pathToVcf <- paste(pathToFiles,"/ERP000101.vcf",sep="")
VCF <- readVcf(pathToVcf,"hg19") 
gr <- granges(VCF) 

#only use bi-allelic positions
gr.filt <- gr[width(mcols(gr)[,"REF"]) == 1 | 
				unlist(lapply(mcols(gr)[,"ALT"],width))==1]

countList <- getAlleleCounts(reads, gr.filt, verbose=FALSE) 
a.vcf <- ASEsetFromCountList(rowRanges = gr, countList)

## ----echo = TRUE, eval = TRUE-------------------------------------------------
BcfGR <- impBcfGR(pathToFiles,searchArea,verbose=FALSE)
countListBcf <- getAlleleCounts(reads, BcfGR,verbose=FALSE)
a.bcf <- ASEsetFromCountList(BcfGR, countListBcf)

## ----echo = TRUE, eval = TRUE-------------------------------------------------
plus <- getAlleleCounts(reads, heterozygotePositions, strand="+",verbose=F) 
minus <- getAlleleCounts(reads, heterozygotePositions, strand="-",verbose=F)

a.stranded <-
ASEsetFromCountList(
heterozygotePositions,
countListPlus=plus,
countListMinus=minus
)
a.stranded

## ----echo = TRUE, eval = TRUE, message = FALSE, results = 'hide'--------------
#Getting searchArea from genesymbol
library(org.Hs.eg.db )
searchArea<-getAreaFromGeneNames("ACTG1",org.Hs.eg.db)

#Getting rs-IDs
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
gr <- rowRanges(a.simple)
updatedGRanges<-getSnpIdFromLocation(gr, SNPlocs.Hsapiens.dbSNP144.GRCh37)
rowRanges(a.simple)<-updatedGRanges

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#simulate phenotype data
pdata <- DataFrame(
	Treatment=sample(c("ChIP", "Input"),length(reads),replace=TRUE),
	Gender=sample(c("male", "female"),length(reads),replace=TRUE), 
	row.names=paste("individual",1:length(reads),sep=""))

#make new ASEset with pdata
a.new <- ASEsetFromCountList(
		heterozygotePositions,
		countList,
		colData=pdata)

#add to existing object
colData(a.simple) <- pdata

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#infer and add genotype require declaration of the reference allele 
ref(a.simple) <- randomRef(a.simple)
genotype(a.simple) <- inferGenotypes(a.simple)

#access to genotype information requires not only the information about the
#reference allele but also the alternative allele
alt(a.simple) <- inferAltAllele(a.simple)
genotype(a.simple)[,1:4]

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#construct an example phase matrix 
set.seed(1)
rows <-nrow(a.simple)
cols <- ncol(a.simple)
p1 <- matrix(sample(c(1,0),replace=TRUE, size=rows*cols), nrow=rows, ncol=cols)
p2 <- matrix(sample(c(1,0),replace=TRUE, size=rows*cols), nrow=rows, ncol=cols)
phase.mat <- matrix(paste(p1,sample(c("|","|","/"), size=rows*cols, 
						replace=TRUE), p2, sep=""),	nrow=rows, ncol=cols)

phase(a.simple) <- phase.mat 

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#load VariantAnnotation and use the phase information from a Vcf file
pathToVcf <- system.file("extdata/ERP000101_subset/ERP000101.vcf", 
							package = "AllelicImbalance")
p <- readGT(pathToVcf)
#The example Vcf file contains only 19 out of our 20 samples
#So we have to subset and order
a.subset <- a.simple[,colnames(a.simple) %in% colnames(p)]
p.subset <- p[, colnames(p) %in% colnames(a.subset)]
p.ordered <- p.subset[ , match(colnames(a.subset), colnames(p.subset))]

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#from simulated data
ref(a.simple) <- c("G","T","C")

#infer and set alternative allele
alt <- inferAltAllele(a.simple)
alt(a.simple) <- alt

#from reference genome
data(ASEset.sim)
fasta <- system.file('extdata/hg19.chr17.subset.fa', package='AllelicImbalance')
ref <- refAllele(ASEset.sim,fasta=fasta) 
ref(ASEset.sim) <- ref

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#make an example countList including a global sample of SNPs
set.seed(1)
countListUnknown <- list()
samples <- paste(rep("sample",10),1:10,sep="")
snps <- 1000
for(snp in 1:snps){
	count<-matrix(0, nrow=length(samples), ncol=4, 
					dimnames=list(samples, c('A','T','G','C')))
	alleles <- sample(1:4, 2)
	for(sample in 1:length(samples)){
		count[sample, alleles] <- as.integer(rnorm(2,mean=50,sd=10))
	}
	countListUnknown[[snp]] <- count
}

#make example rowRanges for the corresponding information
gr <- GRanges(
	seqnames = Rle(sample(paste("chr",1:22,sep=""),snps, replace=TRUE)),
	ranges = IRanges(1:snps, width = 1, names= paste("snp",1:snps,sep="")),
	strand="*"
)

#make ASEset
a <- ASEsetFromCountList(gr, countListUnknown=countListUnknown)

#set a random allele as reference
ref(a) <- randomRef(a)
genotype(a) <- inferGenotypes(a)

#get the fraction of the reference allele
refFrac <- fraction(a, top.fraction.criteria="ref")

#check mean
mean(refFrac)


## ----echo=TRUE, eval=TRUE-----------------------------------------------------
#set ref allele
ref(a.stranded) <- c("G","T","C")

#binomial test
binom.test(a.stranded[,5:8], "+")
#chi-square test
chisq.test(a.stranded[,5:8], "-")

## ----echo=TRUE, eval=TRUE, message=FALSE--------------------------------------
# in this example every snp is on separate exons
region <- granges(a.simple)
rs <- regionSummary(a.simple, region)
rs
basic(rs)

## ----echo=TRUE, eval=TRUE, fig.cap=fig$cap("barplotPlusStrandDefault", "The red bars show how many reads with the G-allele that overlaps the snp at position chr17:79478331, and the green bars show how many reads with the T allele that overlaps.")----
barplot(a.stranded[2], strand="+", xlab.text="", legend.interspace=2)

## ----echo=TRUE, eval=TRUE, fig.cap=fig$cap("barplotPlusStrandPsub", "Here the default chi-square p-values have been replaced by p-values from binomial tests.")----
#use another source of p-values
btp <- binom.test(a.stranded[1],"+")
barplot(a.stranded[2], strand="+", testValue=t(btp), xlab.text="",
			 legend.interspace=2)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
init <- c(15,20)
for(i in c(1,2,4,6)){
	bp <- signif(binom.test(init*i, p=0.5)$p.value,3)
	cp <- signif(chisq.test(init*i, p=c(0.5,0.5))$p.value, 3)
	cat(paste("A: ", init[1]*i , " B: ", init[2]*i, " binom p: ", bp, "chisq p: ", cp,"\n"))
}

## ----echo=TRUE, eval=TRUE, fig.cap=fig$cap("barplotFraction", "A barplot with type='fraction'. Each bar represents one sample and by default the most expressed allele over all samples is on the top, here in green. The black line denotes 1:1 expression of the alleles.")----
barplot(a.simple[2], type="fraction", cex.main = 0.7)

## ----echo=TRUE, eval=TRUE, fig.cap=fig$cap("barplotSampleColour", "A barplot with allele fractions, additionally colored by gender.")----
#top and bottom colour
sampleColour.top <-rep("palevioletred",ncol(a.simple))
sampleColour.top[colData(a.simple)[,"Gender"]%in%"male"] <- "darkgreen"
sampleColour.bot <- rep("blue",ncol(a.simple))
sampleColour.bot[colData(a.simple)[,"Gender"]%in%"male"] <- "seashell2"
barplot(a.simple[2], type="fraction", sampleColour.top=sampleColour.top,
	 sampleColour.bot=sampleColour.bot, cex.main = 0.7)

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("barplotAnnotation", "A barplot with Gene information extracted from the org.Hs.eg.db package")----
library(org.Hs.eg.db)
barplot(a.simple[1],OrgDb=org.Hs.eg.db,
			cex.main = 0.7,
			xlab.text="",
			ypos.annotation = 0.08,
			annotation.interspace=1.3,
			legend.interspace=1.5
			)

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("barplotRef", "A barplot with the reference allele as top fraction, top.fraction.criteria='ref' ")----
#load data
data(ASEset)

#using reference and alternative allele information
alt(ASEset) <- inferAltAllele(ASEset)
barplot(ASEset[1], type="fraction", strand="+", xlab.text="", 
			top.fraction.criteria="ref", cex.main=0.7)

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("barplotPhase", "A barplot with the maternal phase as top fraction, top.fraction.criteria='phase' ")----
#using phase information
phase(ASEset) <- phase.mat 
barplot(ASEset[1], type="fraction", strand="+", xlab.text="", 
			top.fraction.criteria="phase", cex.main=0.7)

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("locationplotDefault", "A locationplot with countbars displaying a region of SNPs")----
# locationplot using count type
a.stranded.sorted <- sort(a.stranded, decreasing=FALSE)
locationplot(a.stranded.sorted, type="count", cex.main=0.7, cex.legend=0.4)

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("locationplotAnnotation", "A locationplot with Gene and Transcript information extracted from the org.Hs.eg.db and TxDb.Hsapiens.UCSC.hg19.knownGene packages")----
# locationplot annotation
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
locationplot(a.stranded.sorted, OrgDb=org.Hs.eg.db, 
				TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene)

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("gbarplotcount", "A gbarplot with type='count'")----
#gbarplots with type "count" 
gbarplot(ASEset, type="count")

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("gbarplotfraction", "A gbarplot with type='fraction'")----
# gbarplots with type "fraction" 
gbarplot(ASEset, type="fraction")

## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("glocationplot", "A glocationplot, showing the ASE of SNPs within a defined region")----
#remember to set the genome
genome(ASEset) <- "hg19"

glocationplot(ASEset, strand='+')


## ----echo=TRUE, eval=TRUE, message=FALSE, fig.cap=fig$cap("glocationplot", "A custom built Gviz plot using the ASEDAnnotationTrack, showing the ASE of SNPs within a defined region together with read coverage information")----

#load Gviz package
library(Gviz)

#subset ASEset and reads
x <- ASEset[,1:2]
r <- reads[1:2]
seqlevels(r, pruning.mode="coarse") <- seqlevels(x)

GR <- GRanges(seqnames=seqlevels(x),
 		ranges=IRanges(start=min(start(x)), end=max(end(x))),
 		strand='+', genome=genome(x))

deTrack <- ASEDAnnotationTrack(x, GR=GR, type='fraction', strand='+')
covTracks <- CoverageDataTrack(x, BamList=r, strand='+') 
lst <- c(deTrack,covTracks)
sizes <- c(0.5,rep(0.5/length(covTracks),length(covTracks)))

plotTracks(lst, from=min(start(x)), to=max(end(x)), sizes=sizes, 
				col.line = NULL, showId = FALSE, main = 'main', cex.main = 1, 
				title.width = 1, type = 'histogram')

## ----echo = TRUE, eval = TRUE, message = FALSE--------------------------------
data(ASEset.old)
#this command doesnt work anymore, for some reason(Will ask the mail-list)
#ASEset.new <- updateObject(ASEset.old)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
sessionInfo()

