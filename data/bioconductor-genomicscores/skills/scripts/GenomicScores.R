# Code example from 'GenomicScores' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, cache=FALSE-------------------------------------------
library(knitr)

options(width=80)
knitr::opts_chunk$set(
  collapse=TRUE,
  comment="",
  fig.align="center",
  fig.wide=TRUE
)

## ----library_install, message=FALSE, cache=FALSE, eval=FALSE------------------
# install.packages("BiocManager")
# BiocManager::install("GenomicScores")

## ----library_upload, message=FALSE, warning=FALSE, cache=FALSE----------------
library(GenomicScores)

## -----------------------------------------------------------------------------
avgs <- availableGScores()
avgs

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("phastCons100way.UCSC.hg38")

## ----message=FALSE, warning=FALSE, cache=FALSE--------------------------------
library(phastCons100way.UCSC.hg38)
phast <- phastCons100way.UCSC.hg38
class(phast)

## -----------------------------------------------------------------------------
phast

## -----------------------------------------------------------------------------
citation(phast)

## -----------------------------------------------------------------------------
provider(phast)
providerVersion(phast)
organism(phast)
seqlevelsStyle(phast)

## -----------------------------------------------------------------------------
gscores(phast, GRanges(seqnames="chr22",
                       IRanges(start=50528591:50528596, width=1)))

## -----------------------------------------------------------------------------
gscores(phast, GRanges("chr22:50528593"))

## -----------------------------------------------------------------------------
score(phast, GRanges(seqnames="chr22",
                     IRanges(start=50528591:50528596, width=1)))
score(phast, GRanges("chr22:50528593"))

## ----eval=FALSE---------------------------------------------------------------
# library(BSgenome.Hsapiens.UCSC.hg38)
# library(gwascat)
# 
# gwc <- get_cached_gwascat()
# mask <- !is.na(gwc$CHR_ID) & !is.na(gwc$CHR_POS) &
#         !is.na(as.integer(gwc$CHR_POS))
# gwc <- gwc[mask, ]
# grstr <- sprintf("%s:%s-%s", gwc$CHR_ID, gwc$CHR_POS, gwc$CHR_POS)
# gwcgr <- GRanges(grstr, RISK_ALLELE=gwc[["STRONGEST SNP-RISK ALLELE"]],
#                  MAPPED_TRAIT=gwc$MAPPED_TRAIT)
# seqlevelsStyle(gwcgr) <- "UCSC"
# mask <- seqnames(gwcgr) %in% c("chr20", "chr21", "chr22")
# gwcgr <- gwcgr[mask]
# ref <- as.character(getSeq(Hsapiens, gwcgr))
# alt <- gsub("rs[0-9]+-", "", gwcgr$RISK_ALLELE)
# mask <- (ref %in% c("A", "C", "G", "T")) & (alt %in% c("A", "C", "G", "T")) &
#          nchar(alt) == 1 & ref != alt
# gwcgr <- gwcgr[mask]
# mcols(gwcgr)$REF <- ref[mask]
# mcols(gwcgr)$ALT <- alt[mask]

## ----message=FALSE, echo=FALSE------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)
library(gwascat)
gwcgr <- readRDS(system.file("extdata", "gwcgr_chr20-22_151123.rds",
                             package="GenomicScores"))

## -----------------------------------------------------------------------------
gwcgr

## -----------------------------------------------------------------------------
pcsco <- score(phast, gwcgr)
summary(pcsco)
round(cumsum(table(na.omit(pcsco))) / sum(!is.na(pcsco)), digits=2)

## -----------------------------------------------------------------------------
xtab <- table(gwcgr$MAPPED_TRAIT[pcsco == 1])
head(xtab[order(xtab, decreasing=TRUE)])

## -----------------------------------------------------------------------------
rownames(avgs)[avgs$AnnotationHub]

## ----echo=FALSE---------------------------------------------------------------
obj20 <- readRDS(system.file("extdata", "phyloP100way.UCSC.hg38.chr20.rds",
                             package="GenomicScores"))
obj21 <- readRDS(system.file("extdata", "phyloP100way.UCSC.hg38.chr21.rds",
                             package="GenomicScores"))
obj22 <- readRDS(system.file("extdata", "phyloP100way.UCSC.hg38.chr22.rds",
                             package="GenomicScores"))
mdobj <- metadata(obj20)
phylop <- GScores(provider=mdobj$provider,
                  provider_version=mdobj$provider_version,
                  download_url=mdobj$download_url,
                  download_date=mdobj$download_date,
                  reference_genome=mdobj$reference_genome,
                  data_pkgname=mdobj$data_pkgname,
                  data_dirpath="../inst/extdata",
                  data_serialized_objnames=c(phyloP100way.UCSC.hg38.chr20.rds="phyloP100way.UCSC.hg38.chr20.rds",
                                             phyloP100way.UCSC.hg38.chr21.rds="phyloP100way.UCSC.hg38.chr21.rds",
                                             phyloP100way.UCSC.hg38.chr22.rds="phyloP100way.UCSC.hg38.chr22.rds"),
                  data_tag="phyloP",
                  license="", license_url="",
                  license_reqconsent=FALSE)
gscopops <- get(mdobj$data_pkgname, envir=phylop@.data_cache)
gscopops[["default"]] <- RleList(compress=FALSE)
gscopops[["default"]][[mdobj$seqname]] <- obj20
assign(mdobj$data_pkgname, gscopops, envir=phylop@.data_cache)

## ----message=FALSE, cache=FALSE, eval=FALSE-----------------------------------
# phylop <- getGScores("phyloP100way.UCSC.hg38")

## -----------------------------------------------------------------------------
phylop

## ----phastvsphylop, fig.cap = "Comparison between phastCons and phyloP conservation scores. On the y-axis, phyloP scores as function of phastCons scores on the x-axis, for a set of GWAS catalog variant in the human chromosome 22.", fig.height=5, fig.wide=TRUE, echo=TRUE----
ppsco <- score(phylop, gwcgr)
plot(pcsco, ppsco, xlab="phastCons", ylab="phyloP",
     cex.axis=1.2, cex.lab=1.5, las=1)

## -----------------------------------------------------------------------------
populations(phast)

## -----------------------------------------------------------------------------
defaultPopulation(phast)

## -----------------------------------------------------------------------------
pcsco2 <- score(phast, gwcgr, pop="DP2")
head(pcsco2)

## ----phastvsphylop2, fig.cap = "Comparison between phastCons and phyloP conservation scores at a higher resolution. On the y-axis, phyloP scores as function of phastCons scores on the x-axis, for a set of GWAS catalog variant in the human chromosome 22.", fig.height=5, fig.wide=TRUE, echo=TRUE----
plot(pcsco2, ppsco, xlab="phastCons", ylab="phyloP",
     cex.axis=1.2, cex.lab=1.5, las=1)

## ----eval=FALSE---------------------------------------------------------------
# makeGScoresPackage(phast, maintainer="Me <me@example.com>",
#                    author="Me", version="1.0.0")

## ----echo=FALSE---------------------------------------------------------------
cat("Creating package in ./phastCons100way.UCSC.hg38\n")

## ----message=FALSE, warning=FALSE, cache=FALSE--------------------------------
library(MafH5.gnomAD.v4.0.GRCh38)

mafh5 <- MafH5.gnomAD.v4.0.GRCh38
mafh5

populations(mafh5)

## -----------------------------------------------------------------------------
mafs <- score(mafh5, gwcgr, pop="AF_allpopmax")
summary(mafs)
sum(mafs < 0.01, na.rm=TRUE)
sum(mafs < 0.01, na.rm=TRUE) / sum(!is.na(mafs))

## -----------------------------------------------------------------------------
xtab <- table(gwcgr$MAPPED_TRAIT[mafs < 0.01])
head(xtab[order(xtab, decreasing=TRUE)])

## ----echo=FALSE---------------------------------------------------------------
obj20 <- readRDS(system.file("extdata", "AlphaMissense.v2023.hg38.chr20.rds",
                             package="GenomicScores"))
obj21 <- readRDS(system.file("extdata", "AlphaMissense.v2023.hg38.chr21.rds",
                             package="GenomicScores"))
obj22 <- readRDS(system.file("extdata", "AlphaMissense.v2023.hg38.chr22.rds",
                             package="GenomicScores"))
mdobj <- metadata(obj20)
am23 <- GScores(provider=mdobj$provider,
                provider_version=mdobj$provider_version,
                download_url=mdobj$download_url,
                download_date=mdobj$download_date,
                reference_genome=mdobj$reference_genome,
                data_pkgname=mdobj$data_pkgname,
                data_dirpath="../inst/extdata",
                data_serialized_objnames=c(AlphaMissense.v2023.hg38.chr20.rds="AlphaMissense.v2023.hg38.chr20.rds",
                                           AlphaMissense.v2023.hg38.chr21.rds="AlphaMissense.v2023.hg38.chr21.rds",
                                           AlphaMissense.v2023.hg38.chr22.rds="AlphaMissense.v2023.hg38.chr22.rds"),
                data_tag="AlphaMissense",
                license=mdobj$license,
                license_url=mdobj$license_url,
                license_reqconsent=TRUE)
gscopops <- get(mdobj$data_pkgname, envir=am23@.data_cache)
gscopops[["default"]] <- RleList(compress=FALSE)
gscopops[["default"]][[mdobj$seqname]] <- obj20
assign(mdobj$data_pkgname, gscopops, envir=am23@.data_cache)

## ----eval=FALSE---------------------------------------------------------------
# am23 <- getGScores("AlphaMissense.v2023.hg38")
# These data is shared under the license CC BY-NC-SA 4.0
# (see https://creativecommons.org/licenses/by-nc-sa/4.0),
# do you accept it? [y/n]: y

## -----------------------------------------------------------------------------
am23
amsco <- score(am23, gwcgr, ref=gwcgr$REF, alt=gwcgr$ALT)
summary(amsco)

## -----------------------------------------------------------------------------
mask <- !is.na(amsco) & !is.na(mafs)
amscofac <- cut(amsco[mask], breaks=c(0, 0.34, 0.56, 1))
amscofac <- relevel(amscofac, ref="(0.56,1]")
maffac <- cut(mafs[mask], breaks=c(0, 0.01, 0.1, 1))
xtab <- table(maffac, amscofac)
t(xtab)
xtab <- t(xtab / rowSums(xtab))
round(xtab, digits=2)

## ----ChengEtAl2024Fig5b, echo=FALSE, height=5, width=7, fig.cap="AlphaMissense predictions. Proportions of three ranges of AlphaMissense pathogenicity scores for three ranges of minor allele frequencies (MAF) derived from gnomAD, on data from the GWAS catalog. This figure is analogous to Figure 5B from @cheng2023accurate, but with much fewer variants."----
par(mar=c(4, 5, 3, 1))
barplot(xtab, horiz=TRUE, col=c("red", "royalblue", "gray"),
        xlab="Proportion", ylab="MAF",
        cex.axis=1.2, cex.names=1.2, cex.lab=1.5)
par(xpd=TRUE)
legend(0.17, 4.1, c("likely pathogenic", "likely benign", "ambiguous"),
       fill=c("red", "royalblue", "gray"), inset=0.01, horiz=TRUE)
par(xpd=FALSE)

## -----------------------------------------------------------------------------
gr1 <- GRanges(seqnames="chr22", IRanges(start=50528591:50528596, width=1))
gr1sco <- gscores(phast, gr1)
gr1sco
mean(gr1sco$default)
gr2 <- GRanges("chr22:50528591-50528596")
gscores(phast, gr2)

## -----------------------------------------------------------------------------
gscores(phast, gr2, summaryFun=max)
gscores(phast, gr2, summaryFun=min)
gscores(phast, gr2, summaryFun=median)

## ----message=FALSE, warning=FALSE, cache=FALSE--------------------------------
library(VariantAnnotation)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

## ----message=FALSE, warning=FALSE---------------------------------------------
loc <- locateVariants(gwcgr, txdb, AllVariants())
loc[1:3]
table(loc$LOCATION)

## -----------------------------------------------------------------------------
loc$PHASTCONS <- score(phast, loc, pop="DP2")
loc[1:3]

## ----plot1, fig.cap = "Distribution of phastCons conservation scores in variants across different annotated regions. Diamonds indicate mean values.", echo = FALSE, fig.height=5, fig.wide = TRUE, echo=TRUE----
x <- split(loc$PHASTCONS, loc$LOCATION)
mask <- elementNROWS(x) > 0
boxplot(x[mask], ylab="phastCons score", las=1, cex.axis=1.2, cex.lab=1.5, col="gray")
points(1:length(x[mask])+0.25, sapply(x[mask], mean, na.rm=TRUE), pch=23, bg="black")

## -----------------------------------------------------------------------------
loc$AM <- score(am23, loc,
                ref=gwcgr$REF[loc$QUERYID],
                alt=gwcgr$ALT[loc$QUERYID])

## ----echo=FALSE---------------------------------------------------------------
obj20 <- readRDS(system.file("extdata", "cadd.v1.6.hg38.chr20.rds",
                             package="GenomicScores"))
obj21 <- readRDS(system.file("extdata", "cadd.v1.6.hg38.chr21.rds",
                             package="GenomicScores"))
obj22 <- readRDS(system.file("extdata", "cadd.v1.6.hg38.chr22.rds",
                             package="GenomicScores"))

mdobj <- metadata(obj20)
cadd <- GScores(provider=mdobj$provider,
                provider_version=mdobj$provider_version,
                download_url=mdobj$download_url,
                download_date=mdobj$download_date,
                reference_genome=mdobj$reference_genome,
                data_pkgname=mdobj$data_pkgname,
                data_dirpath="../inst/extdata",
                data_serialized_objnames=c(cadd.v1.6.hg38.chr20.rds="cadd.v1.6.hg38.chr20.rds",
                                           cadd.v1.6.hg38.chr21.rds="cadd.v1.6.hg38.chr21.rds",
                                           cadd.v1.6.hg38.chr22.rds="cadd.v1.6.hg38.chr22.rds"),
                data_tag="CADD")
gscopops <- get(mdobj$data_pkgname, envir=cadd@.data_cache)
gscopops[["default"]] <- RleList(compress=FALSE)
gscopops[["default"]][[mdobj$seqname]] <- obj20
assign(mdobj$data_pkgname, gscopops, envir=cadd@.data_cache)

## -----------------------------------------------------------------------------
cadd
loc$CADD <- score(cadd, loc, ref=gwcgr$REF[loc$QUERYID], alt=gwcgr$ALT[loc$QUERYID])

## ----am23vscadd, fig.cap = "Comparison of AlphaMissense and CADD scores. Values on the y-axis are jittered to facilitate visualization.", echo = FALSE, fig.height=5, fig.width=7, dpi=100, echo=TRUE----
library(RColorBrewer)
par(mar=c(4, 5, 1, 1))
hmcol <- colorRampPalette(brewer.pal(nlevels(loc$LOCATION), "Set1"))(nlevels(loc$LOCATION))
plot(loc$AM, jitter(loc$CADD, factor=2), pch=19,
     col=hmcol, xlab="AlphaMissense scores", ylab="CADD scores",
     las=1, cex.axis=1.2, cex.lab=1.5, panel.first=grid())
legend("bottomright", levels(loc$LOCATION), pch=19, col=hmcol, inset=0.01)

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

