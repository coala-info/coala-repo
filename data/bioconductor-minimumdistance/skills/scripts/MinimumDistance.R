# Code example from 'MinimumDistance' vignette. See references/ for full tutorial.

### R code from vignette source 'MinimumDistance.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(prompt="R> ", continue=" ", device=pdf, width=65)


###################################################
### code chunk number 2: registerBackend
###################################################
library(oligoClasses)
library(VanillaICE)
library(SummarizedExperiment)
library(MinimumDistance)
foreach::registerDoSEQ()


###################################################
### code chunk number 3: FeatureAnnotation
###################################################
library(data.table)
extdir <- system.file("extdata", package="VanillaICE")
features <- suppressWarnings(fread(file.path(extdir, "SNP_info.csv")))
fgr <- GRanges(paste0("chr", features$Chr), IRanges(features$Position, width=1),
               isSnp=features[["Intensity Only"]]==0)
fgr <- SnpGRanges(fgr)
names(fgr) <- features[["Name"]]


###################################################
### code chunk number 4: seqinfo
###################################################
library(BSgenome.Hsapiens.UCSC.hg18)
sl <- seqlevels(BSgenome.Hsapiens.UCSC.hg18)
seqlevels(fgr) <- sl[sl %in% seqlevels(fgr)]
seqinfo(fgr) <- seqinfo(BSgenome.Hsapiens.UCSC.hg18)[seqlevels(fgr),]
fgr <- sort(fgr)


###################################################
### code chunk number 5: sourceFiles
###################################################
files <- list.files(extdir, full.names=TRUE, recursive=TRUE, pattern="FinalReport")


###################################################
### code chunk number 6: ArrayViews
###################################################
##
## Where to keep parsed files
##
parsedDir <- "ParsedFiles"
if(!file.exists(parsedDir)) dir.create(parsedDir)
views <- ArrayViews(rowRanges=fgr, sourcePaths=files, parsedPath=parsedDir)
show(views)


###################################################
### code chunk number 7: fread
###################################################
## read the first file
dat <- fread(files[1], skip="[Data]")
head(dat,n=3)


###################################################
### code chunk number 8: select_columns
###################################################
## information to store on the markers
select_columns <- match(c("SNP Name", "Allele1 - AB", "Allele2 - AB",
                          "Log R Ratio", "B Allele Freq"), names(dat))


###################################################
### code chunk number 9: order_of_markers
###################################################
index_genome <- match(names(fgr), dat[["SNP Name"]])


###################################################
### code chunk number 10: scan_params
###################################################
scan_params <- CopyNumScanParams(index_genome=index_genome,
                                 select=select_columns,
                                 cnvar="Log R Ratio",
                                 bafvar="B Allele Freq",
                                 gtvar=c("Allele1 - AB", "Allele2 - AB"))


###################################################
### code chunk number 11: parseSourceFile
###################################################
parsedPath(views)
parseSourceFile(views[, 1], scan_params)


###################################################
### code chunk number 12: applyParseSourceFile
###################################################
invisible(sapply(views, parseSourceFile, param=scan_params))


###################################################
### code chunk number 13: list_parsed_files
###################################################
head(list.files(parsedPath(views)), n=3)


###################################################
### code chunk number 14: Views
###################################################
lrr(views)[1:2, 2:4]
## or
lrr(views[1:2, 2:4])
## B allele frequencies
baf(views[1:2, 2:4])
## potentially masked by function of the same name in crlmm
VanillaICE::genotypes(views)[1:2, 2:4]


###################################################
### code chunk number 15: pedigree_hapmap
###################################################
ped_hapmap <- ParentOffspring(id = "hapmap", father="12287_03",
                              mother="12287_02",
                              offspring="12287_01",
                              parsedPath=parsedPath(views))


###################################################
### code chunk number 16: pedigree_list
###################################################
ped_list <- ParentOffspringList(pedigrees=list(
                                  ParentOffspring(id = "hapmap", father="12287_03",
                                                  mother="12287_02",
                                                  offspring="12287_01",
                                                  parsedPath=parsedPath(views)),
                                  ParentOffspring(id = "cleft",
                                                  father="22169_03",
                                                  mother="22169_02",
                                                  offspring="22169_01",
                                                  parsedPath=parsedPath(views))))
pedigreeName(ped_list)


###################################################
### code chunk number 17: sample_data
###################################################
sample_info <- read.csv(file.path(extdir, "sample_data.csv"), stringsAsFactors=FALSE)
ind_id <- setNames(gsub(" ", "", sample_info$IndividualID), sample_info$File)
colnames(views) <- ind_id[gsub(".txt", "", colnames(views))]


###################################################
### code chunk number 18: mindistexperiment
###################################################
me <- MinDistExperiment(views, pedigree=ped_list[[2]])
colnames(me)
me


###################################################
### code chunk number 19: param_class
###################################################
params <- MinDistParam()
show(params)


###################################################
### code chunk number 20: dnacopy
###################################################
segment_params <- DNAcopyParam(alpha=0.01)
params <- MinDistParam(dnacopy=segment_params)


###################################################
### code chunk number 21: penn_param
###################################################
penn_param <- PennParam()
show(penn_param)


###################################################
### code chunk number 22: computeMinimumDistance
###################################################
mdgr <- segment2(me, params)


###################################################
### code chunk number 23: computeBayesFactor
###################################################
## the threshold in terms of the number of median absolute deviations from zero
nMAD(params)
md_g <- MAP2(me, mdgr, params)
show(md_g)


###################################################
### code chunk number 24: filter_param
###################################################
filter_param <- FilterParamMD()
show(filter_param)


###################################################
### code chunk number 25: cnvFilter
###################################################
cnvFilter(md_g, filter_param)


###################################################
### code chunk number 26: denovoFilters
###################################################
denovoHemizygous(md_g)
denovoHomozygous(md_g)


###################################################
### code chunk number 27: cnvFilter_denovo
###################################################
select_cnv <- FilterParamMD(state=c("220", "221", "223"), seqnames="chr22")
cnvs <- cnvFilter(md_g, select_cnv)
cnvs


###################################################
### code chunk number 28: denovo_hemizygous
###################################################
denovoHemizygous(md_g)


###################################################
### code chunk number 29: plotDenovo
###################################################
library(grid)
g2 <- reduce(denovoHemizygous(md_g), min.gapwidth=500e3)
post <- MAP2(me, g2, params)
g2 <- denovoHemizygous(post)
vps <- pedigreeViewports()
grid.params <-  HmmTrellisParam()
p <- plotDenovo(me, g2, grid.params)
pedigreeGrid(g=g2, vps=vps, figs=p)


###################################################
### code chunk number 30: sessionInfo
###################################################
toLatex(sessionInfo())


