# Code example from 'VanillaICE' vignette. See references/ for full tutorial.

### R code from vignette source 'VanillaICE.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width=70)


###################################################
### code chunk number 2: example_data
###################################################
library(VanillaICE)
library(foreach)
registerDoSEQ()
extdir <- system.file("extdata", package="VanillaICE", mustWork=TRUE)
files <- list.files(extdir, pattern="FinalReport")


###################################################
### code chunk number 3: annotation_file
###################################################
list.files(extdir, pattern="SNP_info")


###################################################
### code chunk number 4: FeatureAnnotation
###################################################
require(data.table)
features <- suppressWarnings(fread(file.path(extdir, "SNP_info.csv")))
fgr <- GRanges(paste0("chr", features$Chr), IRanges(features$Position, width=1),
               isSnp=features[["Intensity Only"]]==0)
fgr <- SnpGRanges(fgr)
names(fgr) <- features[["Name"]]


###################################################
### code chunk number 5: seqinfo
###################################################
library(BSgenome.Hsapiens.UCSC.hg18)
sl <- seqlevels(BSgenome.Hsapiens.UCSC.hg18)
seqlevels(fgr) <- sl[sl %in% seqlevels(fgr)]
seqinfo(fgr) <- seqinfo(BSgenome.Hsapiens.UCSC.hg18)[seqlevels(fgr),]
fgr <- sort(fgr)


###################################################
### code chunk number 6: sourceFiles
###################################################
files <- list.files(extdir, full.names=TRUE, recursive=TRUE, pattern="FinalReport")


###################################################
### code chunk number 7: ArrayViews
###################################################
##
## A directory to keep parsed files
##
parsedDir <- tempdir()
views <- ArrayViews(rowRanges=fgr, sourcePaths=files,
                    parsedPath=parsedDir)
lrrFile(views) <- file.path(parsedDir, basename(fileName(views, "lrr")))
views@bafFiles <- file.path(parsedDir, basename(fileName(views, "baf")))
views@gtFiles <- file.path(parsedDir, basename(fileName(views, "gt")))
colnames(views) <- gsub(".csv", "", colnames(views))
show(views)


###################################################
### code chunk number 8: fread
###################################################
## read the first file
dat <- fread(files[1], skip="[Data]")
head(dat,n=3)


###################################################
### code chunk number 9: select_columns
###################################################
## information to store on the markers
select_columns <- match(c("SNP Name", "Allele1 - AB", "Allele2 - AB",
                          "Log R Ratio", "B Allele Freq"), names(dat))


###################################################
### code chunk number 10: order_of_markers
###################################################
index_genome <- match(names(fgr), dat[["SNP Name"]])


###################################################
### code chunk number 11: scan_params
###################################################
scan_params <- CopyNumScanParams(index_genome=index_genome,
                                 select=select_columns,
                                 cnvar="Log R Ratio",
                                 bafvar="B Allele Freq",
                                 gtvar=c("Allele1 - AB", "Allele2 - AB"))


###################################################
### code chunk number 12: applyParseSourceFile
###################################################
parseSourceFile(views, scan_params)


###################################################
### code chunk number 13: list_parsed_files
###################################################
head(list.files(parsedPath(views)), n=3)


###################################################
### code chunk number 14: Views
###################################################
lrr(views)[1:2, ]
## or
lrr(views[1:2, ])
## B allele frequencies
baf(views[1:2, ])
## Use :: to avoid  masking by function of the same name in crlmm
VanillaICE::genotypes(views)[1:2, ]


###################################################
### code chunk number 15: SnpArrayExperiment
###################################################
snp_exp <- SnpExperiment(views[, 4:5])
show(snp_exp)


###################################################
### code chunk number 16: emission_param
###################################################
param <- EmissionParam()


###################################################
### code chunk number 17: temper
###################################################
param <- EmissionParam(temper=0.5)
show(param)


###################################################
### code chunk number 18: hmm
###################################################
fit <- hmm2(snp_exp, param)
show(fit)
length(fit)
## HMM object for the first sample
fit[[1]]


###################################################
### code chunk number 19: HMMList_names
###################################################
names(fit)


###################################################
### code chunk number 20: HMMList_subset
###################################################
show(fit[[2]])


###################################################
### code chunk number 21: HMMList_unlist
###################################################
head(unlist(fit), n=3)


###################################################
### code chunk number 22: HMMList_grangeslist
###################################################
grl <- split(unlist(fit), unlist(fit)$id)


###################################################
### code chunk number 23: filter_param
###################################################
filter_param <- FilterParam()
show(filter_param)


###################################################
### code chunk number 24: cnvFilter
###################################################
cnvFilter(fit, filter_param)


###################################################
### code chunk number 25: cnvFilter_altered
###################################################
select_cnv <- FilterParam(state=c("1", "2", "5", "6"), seqnames="chr22")
cnvs <- cnvFilter(fit, select_cnv)
cnvs


###################################################
### code chunk number 26: xyplotList
###################################################
trellis_param <- HmmTrellisParam()
cnvList <- split(cnvs, cnvs$id)
figList <- xyplotList(cnvList, snp_exp, trellis_param)
names(figList)


###################################################
### code chunk number 27: trellis
###################################################
class(figList[["FinalReport6841.csv"]][[1]])


###################################################
### code chunk number 28: viewports
###################################################
fig1 <- figList[["FinalReport6841.csv"]][[1]]


###################################################
### code chunk number 29: fig1
###################################################
vps <- viewports()
xygrid(fig1, vps, cnvList[[1]][1])


###################################################
### code chunk number 30: fig2
###################################################
cnvs_sample2 <- cnvList[[2]]
cnvs_sample2
xygrid(figList[[2]][[1]], vps, cnvs_sample2[1])


###################################################
### code chunk number 31: reduce
###################################################
cnvs_sample2r <- reduce(cnvs_sample2, min.gapwidth=500e3)
fig2 <- xyplotList(cnvs_sample2r, snp_exp)


###################################################
### code chunk number 32: fig_reduced
###################################################
invisible(print(fig2[[1]]))


###################################################
### code chunk number 33: parallelEnvironment (eval = FALSE)
###################################################
## library(foreach)
## library(snow)
## library(doSNOW)
## cl <- makeCluster(2, type="SOCK")
## registerDoSNOW(cl)


###################################################
### code chunk number 34: fitParallel (eval = FALSE)
###################################################
## results <- hmm2(snp_exp)


###################################################
### code chunk number 35: stopcl (eval = FALSE)
###################################################
## stopCluster(cl)


###################################################
### code chunk number 36: VanillaICE.Rnw:557-558
###################################################
toLatex(sessionInfo())


