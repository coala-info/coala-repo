# Code example from 'CNEr' vignette. See references/ for full tutorial.

## ----code, echo = FALSE-------------------------------------------------------
date = "`r doc_date()`"
pkg = "`r pkg_ver('CNEr')`"

## ----global_options, echo=FALSE-----------------------------------------------
short=TRUE #if short==TRUE, do not echo code chunks
debug=FALSE
knitr::opts_chunk$set(echo=!short, warning=debug, message=debug, error=FALSE,
               cache.path = "cache/", 
               fig.path = "figures/")

## ----Axt, eval=TRUE, echo=TRUE------------------------------------------------
library(CNEr)
## These axt files are specially prepared for the region
## (chr6:24,000,000..27,000,000)
axtFilesHg38DanRer10 <- file.path(system.file("extdata", package="CNEr"), 
                                  "hg38.danRer10.net.axt")
axtFilesDanRer10Hg38 <- file.path(system.file("extdata", package="CNEr"), 
                                  "danRer10.hg38.net.axt")

## ----readAxt, eval=TRUE, echo=TRUE--------------------------------------------
axtHg38DanRer10 <- readAxt(axtFilesHg38DanRer10)
axtDanRer10Hg38 <- readAxt(axtFilesDanRer10Hg38)

## ----showAxt, eval=TRUE, echo=TRUE--------------------------------------------
## Axt class is shown in UCSC axt format
axtHg38DanRer10
axtDanRer10Hg38

## ----matchDistribution, eval=TRUE, echo=TRUE----------------------------------
## Distribution of matched alignments; Given an Axt alignment, plot a heatmap with percentage of each matched alignment
matchDistribution(axtHg38DanRer10)
matchDistribution(axtDanRer10Hg38)

## ----syntenyDotplot, eval=TRUE, echo=TRUE-------------------------------------
## Example of chr4 on hg19 and galGal3
## The synteny of human and zebrafish is not quite obvious on the dotplot.
library(BSgenome.Hsapiens.UCSC.hg19)
library(BSgenome.Ggallus.UCSC.galGal3)
fn <- file.path(system.file("extdata", package="CNEr"),
                "chr4.hg19.galGal3.net.axt.gz")
axt <- readAxt(fn, 
               tAssemblyFn=file.path(system.file("extdata",
                                     package="BSgenome.Hsapiens.UCSC.hg19"),
                                     "single_sequences.2bit"),
               qAssemblyFn=file.path(system.file("extdata",
                                     package="BSgenome.Ggallus.UCSC.galGal3"),
                                     "single_sequences.2bit"))
library(GenomeInfoDb)
syntenicDotplot(axt, firstChrs=c("chr4"), secondChrs="chr4", type="dot")

## ----UCSC, eval=FALSE, echo=TRUE----------------------------------------------
# ## To fetch rmsk table from UCSC
# library(rtracklayer)
# mySession <- browserSession("UCSC")
# genome(mySession) <- "hg38"
# hg38.rmsk <- getTable(ucscTableQuery(mySession, track="RepeatMasker",
#                                      table="rmsk"))
# hg38.rmskGRanges <- GRanges(seqnames=hg38.rmsk$genoName,
#                             ## The UCSC coordinate is 0-based.
#                             ranges=IRanges(start=hg38.rmsk$genoStart+1,
#                                            end=hg38.rmsk$genoEnd),
#                             strand=hg38.rmsk$strand)
# ## To fetch ensembl gene exons from BioMart
# library(biomaRt)
# ensembl <- useMart(biomart="ENSEMBL_MART_ENSEMBL",
#                    host="dec2015.archive.ensembl.org")
# ensembl <-  useDataset("hsapiens_gene_ensembl",mart=ensembl)
# attributes <- listAttributes(ensembl)
# exons <- getBM(attributes=c("chromosome_name", "exon_chrom_start",
#                             "exon_chrom_end", "strand"),
#                mart=ensembl)
# exonsRanges <- GRanges(seqnames=exons$chromosome_name,
#                        ranges=IRanges(start=exons$exon_chrom_start,
#                                       end=exons$exon_chrom_end),
#                        strand=ifelse(exons$strand==1L, "+", "-")
#                        )
# seqlevelsStyle(exonsRanges) <- "UCSC"
# ## Use the existing Bioconductor annotation package for hg38
# library(TxDb.Hsapiens.UCSC.hg38.knownGene)
# exonsRanges <- exons(TxDb.Hsapiens.UCSC.hg38.knownGene)

## ----Bed, eval=TRUE, echo=TRUE------------------------------------------------
## Existing bed file for chr6:24,000,000..27,000,000 of Zebrafish danRer10
bedDanRer10Fn <- file.path(system.file("extdata", package="CNEr"), 
                           "filter_regions.danRer10.bed")
danRer10Filter <- readBed(bedDanRer10Fn)
danRer10Filter

## Existing bed file for alignment region in Human hg38 against
## chr6:24,000,000..27,000,000 of danRer10
bedHg38Fn <- file.path(system.file("extdata", package="CNEr"), 
                       "filter_regions.hg38.bed")
hg38Filter <- readBed(bedHg38Fn)
hg38Filter

## ----CNE, eval=TRUE, echo=TRUE------------------------------------------------
## Here we have the twoBit files from Bioconductor package
## BSgenome.Drerio.UCSC.danRer10 and BSgenome.Hsapiens.UCSC.hg38
cneDanRer10Hg38 <- CNE(
  assembly1Fn=file.path(system.file("extdata",
                                    package="BSgenome.Drerio.UCSC.danRer10"),
                        "single_sequences.2bit"),
  assembly2Fn=file.path(system.file("extdata",
                                    package="BSgenome.Hsapiens.UCSC.hg38"),
                        "single_sequences.2bit"),
  axt12Fn=axtFilesDanRer10Hg38, axt21Fn=axtFilesHg38DanRer10,
  cutoffs1=8L, cutoffs2=4L)
cneDanRer10Hg38

## ----CNEScan, eval=TRUE, echo=TRUE--------------------------------------------
identities <- c(45L, 48L, 49L)
windows <- c(50L, 50L, 50L)
## Here danRer10Filter is tFilter since danRer10 is assembly1
cneListDanRer10Hg38 <- ceScan(x=cneDanRer10Hg38, tFilter=danRer10Filter,
                              qFilter=hg38Filter,
                              window=windows, identity=identities)

## ----CNEScanHead, eval=TRUE, echo=TRUE----------------------------------------
## CNEs from the alignments with danRer10 as reference
CNE12(cneListDanRer10Hg38[["45_50"]])
## CNEs from the alignments with hg38 as reference
CNE21(cneListDanRer10Hg38[["45_50"]])

## ----CNEMerge, eval=TRUE, echo=TRUE-------------------------------------------
cneMergedListDanRer10Hg38 <- lapply(cneListDanRer10Hg38, cneMerge)

## ----CNERealignment, eval=FALSE, echo=TRUE------------------------------------
# cneFinalListDanRer10Hg38 <- lapply(cneMergedListDanRer10Hg38, blatCNE)

## ----saveCNE, eval=TRUE, echo=TRUE--------------------------------------------
## on individual tables
dbName <- tempfile()
data(cneFinalListDanRer10Hg38)
tableNames <- paste("danRer10", "hg38", names(cneFinalListDanRer10Hg38),
                    sep="_")
for(i in 1:length(cneFinalListDanRer10Hg38)){
	saveCNEToSQLite(cneFinalListDanRer10Hg38[[i]], dbName, tableNames[i],
	                overwrite=TRUE)
}

## ----queryCNE, eval=TRUE, echo=TRUE-------------------------------------------
chr <- "chr6"
start <- 24000000L
end <-  27000000L
minLength <- 50L
tableName <- "danRer10_hg38_45_50"
fetchedCNERanges <- readCNERangesFromSQLite(dbName, tableName, chr, 
                                            start, end, whichAssembly="first",
                                            minLength=minLength)
fetchedCNERanges

## ----CNEWidthDistribution, eval=TRUE, echo=TRUE-------------------------------
dbName <- file.path(system.file("extdata", package="CNEr"),
                    "danRer10CNE.sqlite")
tAssemblyFn <- file.path(system.file("extdata",
                         package="BSgenome.Drerio.UCSC.danRer10"),
                         "single_sequences.2bit")
qAssemblyFn <- file.path(system.file("extdata",
                         package="BSgenome.Hsapiens.UCSC.hg38"),
                         "single_sequences.2bit")
cneGRangePairs <- readCNERangesFromSQLite(dbName=dbName, 
                                          tableName="danRer10_hg38_45_50",
                                          tAssemblyFn=tAssemblyFn,
                                          qAssemblyFn=qAssemblyFn)
plotCNEWidth(cneGRangePairs)

## ----plotCNEDistribution, eval=TRUE, echo=TRUE--------------------------------
plotCNEDistribution(first(cneGRangePairs)) 

## ----outputBedBW, eval=FALSE, echo=TRUE---------------------------------------
# makeCNEDensity(cneGRangePairs[1:1000])

## ----queryUCSC, eval=FALSE, echo=TRUE, cache=TRUE-----------------------------
# library(Gviz)
# library(biomaRt)
# genome <- "danRer10"
# axisTrack <- GenomeAxisTrack()
# cpgIslands <- UcscTrack(genome=genome, chromosome=chr,
#                         track="cpgIslandExt", from=start, to=end,
#                         trackType="AnnotationTrack", start="chromStart",
#                         end="chromEnd", id="name", shape="box",
#                         showId=FALSE,
#                         fill="#006400", name="CpG",
#                         background.title="brown")
# refGenes <- UcscTrack(genome=genome, chromosome=chr,
#                       track="refGene", from=start, to=end,
#                       trackType="GeneRegionTrack", rstarts="exonStarts",
#                       rends="exonEnds", gene="name2", symbol="name2",
#                       transcript="name", strand="strand", fill="#8282d2",
#                       name="refSeq Genes", collapseTranscripts=TRUE,
#                       showId=TRUE, background.title="brown")
# ensembl <- useMart(biomart="ENSEMBL_MART_ENSEMBL",
#                    host="dec2015.archive.ensembl.org")
# ensembl <-  useDataset("drerio_gene_ensembl",mart=ensembl)
# biomTrack <- BiomartGeneRegionTrack(genome=genome, chromosome=chr,
#                                     biomart=ensembl,
#                                     start=start , end=end, name="Ensembl Genes")

## ----loadAnnotation, eval=TRUE, echo=FALSE------------------------------------
data(axisTrack)
data(cpgIslands)
data(refGenes)

## ----plotAnnotation, eval=TRUE, echo=TRUE, fig.height=5, fig.width=7----------
library(Gviz)
plotTracks(list(axisTrack, cpgIslands, refGenes), 
           collapseTranscripts=TRUE, shape="arrow",
           transcriptAnnotation="symbol")

## ----CNEDensity, eval=TRUE, echo=TRUE-----------------------------------------
dbName <- file.path(system.file("extdata", package="CNEr"),
                    "danRer10CNE.sqlite")
genome <- "danRer10"
windowSize <- 200L
minLength <- 50L
cneDanRer10Hg38_21_30 <- 
  CNEDensity(dbName=dbName, 
             tableName="danRer10_hg38_21_30",
             whichAssembly="first", chr=chr, start=start,
             end=end, windowSize=windowSize, 
             minLength=minLength)
cneDanRer10Hg38_45_50 <-
  CNEDensity(dbName=dbName, 
             tableName="danRer10_hg38_45_50", 
             whichAssembly="first", chr=chr, start=start,
             end=end, windowSize=windowSize, 
             minLength=minLength)
cneDanRer10Hg38_49_50 <-
  CNEDensity(dbName=dbName, 
             tableName="danRer10_hg38_49_50", 
             whichAssembly="first", chr=chr, start=start,
             end=end, windowSize=windowSize, 
             minLength=minLength)
cneDanRer10AstMex102_48_50 <-
  CNEDensity(dbName=dbName, 
             tableName="AstMex102_danRer10_48_50",
             whichAssembly="second", chr=chr, start=start,
             end=end, windowSize=windowSize, 
             minLength=minLength)
cneDanRer10CteIde1_75_75 <-
  CNEDensity(dbName=dbName, 
             tableName="cteIde1_danRer10_75_75", 
             whichAssembly="second", chr=chr, start=start,
             end=end, windowSize=windowSize, 
             minLength=minLength)

## ----GvizDataTrack, eval=TRUE, echo=TRUE--------------------------------------
dTrack1 <- DataTrack(range=cneDanRer10Hg38_21_30,
                     genome=genome, type="horiz", 
                     horizon.scale=max(cneDanRer10Hg38_21_30$score)/3, 
                     fill.horizon=c("#B41414", "#E03231", "#F7A99C", 
                                    "yellow", "orange", "red"), 
                     name="human 21/30", background.title="brown")
dTrack2 <- DataTrack(range=cneDanRer10Hg38_45_50,
                     genome=genome, type="horiz", 
                     horizon.scale=max(cneDanRer10Hg38_45_50$score)/2, 
                     fill.horizon=c("#B41414", "#E03231", "#F7A99C", 
                                    "yellow", "orange", "red"), 
                     name="human 45/50", background.title="brown")
dTrack3 <- DataTrack(range=cneDanRer10Hg38_49_50,
                     genome=genome, type="horiz", 
                     horizon.scale=max(cneDanRer10Hg38_21_30$score)/3, 
                     fill.horizon=c("#B41414", "#E03231", "#F7A99C", 
                                    "yellow", "orange", "red"), 
                     name="human 49/50", background.title="brown")
dTrack4 <- DataTrack(range=cneDanRer10AstMex102_48_50,
                     genome=genome, type="horiz", 
                     horizon.scale=max(cneDanRer10Hg38_21_30$score)/3, 
                     fill.horizon=c("#B41414", "#E03231", "#F7A99C", 
                                    "yellow", "orange", "red"), 
                     name="blind cave fish 48/50", background.title="brown")
dTrack5 <- DataTrack(range=cneDanRer10CteIde1_75_75,
                     genome=genome, type="horiz", 
                     horizon.scale=max(cneDanRer10CteIde1_75_75$score)/3, 
                     fill.horizon=c("#B41414", "#E03231", "#F7A99C", 
                                    "yellow", "orange", "red"), 
                     name="grass carp 75/75", background.title="brown")

## ----plotCNE, eval=TRUE, echo=TRUE, fig.height=10, fig.width=8----------------
ht <- HighlightTrack(trackList=list(refGenes, dTrack5, dTrack4, 
                                    dTrack1, dTrack2, dTrack3), 
                     start=c(24200000, 25200000, 26200000), 
                     end=c(25100000, 26150000, 27000000),
                     chromosome =chr)
plotTracks(list(axisTrack, cpgIslands, ht),
           collapseTranscripts=TRUE, shape="arrow",
           transcriptAnnotation="symbol",
           from=24000000, to=27000000)

## ----sessionInfo, eval=TRUE, echo=TRUE----------------------------------------
  sessionInfo()

