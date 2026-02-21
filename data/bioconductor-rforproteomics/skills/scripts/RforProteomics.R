# Code example from 'RforProteomics' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env0, echo = FALSE, warning = FALSE, message=FALSE-----------------------
suppressPackageStartupMessages(library("DT"))
suppressPackageStartupMessages(library("BiocManager"))
suppressPackageStartupMessages(library("mzR"))
suppressPackageStartupMessages(library("MSnbase"))
suppressPackageStartupMessages(library("mzID"))
suppressPackageStartupMessages(library("rpx"))
suppressPackageStartupMessages(library("MALDIquant"))
suppressPackageStartupMessages(library("MALDIquantForeign"))
suppressPackageStartupMessages(library("rols"))
suppressPackageStartupMessages(library("hpar"))
suppressPackageStartupMessages(library("BRAIN"))
suppressPackageStartupMessages(library("org.Hs.eg.db"))
suppressPackageStartupMessages(library("GO.db"))
suppressPackageStartupMessages(library("Rdisop"))
suppressPackageStartupMessages(library("biomaRt"))

## ----vignette1, echo = TRUE, eval = FALSE-------------------------------------
# ## list all the vignettes in the RforProteomics package
# vignette(package = "RforProteomics")
# ## Open the vignette called RforProteomics
# vignette("RforProteomics", package = "RforProteomics")
# ## or just
# vignette("RforProteomics")

## ----installation, eval = FALSE-----------------------------------------------
# ## only first time you install Bioconductor packages
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# ## else
# library("BiocManager")
# BiocManager::install("RforProteomics")

## ----installation2, eval = FALSE----------------------------------------------
# BiocManager::install("RforProteomics", dependencies = TRUE)

## ----loadR4Prot, warning=FALSE------------------------------------------------
library("RforProteomics")

## ----stangle, eval=TRUE, tidy=FALSE, error=FALSE------------------------------
## gets the vignette source
rfile <- system.file("doc/RforProteomics.R",
                     package = "RforProteomics")
rfile

## ----env, message=FALSE-------------------------------------------------------
library("RColorBrewer") ## Color palettes
library("ggplot2")  ## Convenient and nice plotting
library("reshape2") ## Flexibly reshape data

## ----mzr----------------------------------------------------------------------
## load the required packages
library("mzR") ## the software package
library("msdata") ## the data package
## below, we extract the releavant example file
## from the local 'msdata' installation
filepath <- system.file("microtofq", package = "msdata")
file <- list.files(filepath, pattern="MM14.mzML",
                   full.names=TRUE, recursive = TRUE)
## creates a commection to the mzML file
mz <- openMSfile(file)
## demonstraction of data access
basename(fileName(mz))
runInfo(mz)
instrumentInfo(mz)
## once finished, it is good to explicitely
## close the connection
close(mz)

## ----mzrid--------------------------------------------------------------------
file <- system.file("mzid", "Tandem.mzid.gz", package="msdata")
mzid <- openIDfile(file)
mzid

## ----mzrid2-------------------------------------------------------------------
softwareInfo(mzid)
enzymes(mzid)
names(psms(mzid))
head(psms(mzid))[, 1:13]

## ----mzid1--------------------------------------------------------------------
library("mzID")
mzids <- list.files(system.file('extdata', package = 'mzID'),
                    pattern = '*.mzid', full.names = TRUE)
mzids
id <- mzID(mzids[1])
id

## ----mzid2--------------------------------------------------------------------
ids <- mzID(mzids[1:2])
ids

## ----flatid-------------------------------------------------------------------
fid <- flatten(id)
names(fid)
dim(fid)

## ----msnexp0------------------------------------------------------------------
library("MSnbase")
## uses a simple dummy test included in the package
mzXML <- dir(system.file(package="MSnbase",dir="extdata"),
             full.name=TRUE,
             pattern="mzXML$")
basename(mzXML)
## reads the raw data into and MSnExp instance
raw <- readMSData(mzXML, verbose = FALSE, centroided = TRUE)
raw
## Extract a single spectrum
raw[[3]]

## ----msnexp, fig.cap = "The `plot` method can be used on experiments, i.e. spectrum collections (top), or individual spectra (bottom)."----
plot(raw, full = TRUE)
plot(raw[[3]], full = TRUE, reporters = iTRAQ4)

## ----downloadmztab, tidy = FALSE----------------------------------------------
## Experiment information
library("rpx")
px1 <- PXDataset("PXD000001")
px1
pxfiles(px1)
## Downloading the mzTab data
mztab <- pxget(px1, "F063721.dat-mztab.txt")
mztab

## ----mztab, tidy = FALSE------------------------------------------------------
## Load mzTab peptide data
qnt <- readMzTabData(mztab, what = "PEP", version = "0.9")
sampleNames(qnt) <- reporterNames(TMT6)
head(exprs(qnt))
## remove missing values
qnt <- filterNA(qnt)
processingData(qnt)

## combine into proteins
## - using the 'accession' feature meta data
## - sum the peptide intensities
protqnt <- combineFeatures(qnt,
                           groupBy = fData(qnt)$accession,
                           method = sum)

## ----matplot, fig.cap = "Protein quantitation data."--------------------------
cls <- brewer.pal(5, "Set1")
matplot(t(tail(exprs(protqnt), n = 5)), type = "b",
        lty = 1, col = cls,
        ylab = "Protein intensity (summed peptides)",
        xlab = "TMT reporters")
legend("topright", tail(featureNames(protqnt), n=5),
       lty = 1, bty = "n", cex = .8, col = cls)

## ----mztab2-------------------------------------------------------------------
qntS <- normalise(qnt, "sum")
qntV <- normalise(qntS, "vsn")
qntV2 <- normalise(qnt, "vsn")

acc <- c("P00489", "P00924",
         "P02769", "P62894",
         "ECA")

idx <- sapply(acc, grep, fData(qnt)$accession)
idx2 <- sapply(idx, head, 3)
small <- qntS[unlist(idx2), ]

idx3 <- sapply(idx, head, 10)
medium <- qntV[unlist(idx3), ]

m <- exprs(medium)
colnames(m) <- c("126", "127", "128",
                 "129", "130", "131")
rownames(m) <- fData(medium)$accession
rownames(m)[grep("CYC", rownames(m))] <- "CYT"
rownames(m)[grep("ENO", rownames(m))] <- "ENO"
rownames(m)[grep("ALB", rownames(m))] <- "BSA"
rownames(m)[grep("PYGM", rownames(m))] <- "PHO"
rownames(m)[grep("ECA", rownames(m))] <- "Background"

cls <- c(brewer.pal(length(unique(rownames(m)))-1, "Set1"),
         "grey")
names(cls) <- unique(rownames(m))
wbcol <- colorRampPalette(c("white", "darkblue"))(256)

## ----heatmap, fig.cap = "A heatmap."------------------------------------------
heatmap(m, col = wbcol, RowSideColors=cls[rownames(m)])

## ----spikes, fig.cap = "Spikes plot using `r CRANpkg('ggplot2')`."------------
dfr <- data.frame(exprs(small),
                  Protein = as.character(fData(small)$accession),
                  Feature = featureNames(small),
                  stringsAsFactors = FALSE)
colnames(dfr) <- c("126", "127", "128", "129", "130", "131",
                   "Protein", "Feature")
dfr$Protein[dfr$Protein == "sp|P00924|ENO1_YEAST"] <- "ENO"
dfr$Protein[dfr$Protein == "sp|P62894|CYC_BOVIN"]  <- "CYT"
dfr$Protein[dfr$Protein == "sp|P02769|ALBU_BOVIN"] <- "BSA"
dfr$Protein[dfr$Protein == "sp|P00489|PYGM_RABIT"] <- "PHO"
dfr$Protein[grep("ECA", dfr$Protein)] <- "Background"
dfr2 <- melt(dfr)
ggplot(aes(x = variable, y = value, colour = Protein),
       data = dfr2) +
  geom_point() +
  geom_line(aes(group=as.factor(Feature)), alpha = 0.5) +
  facet_grid(. ~ Protein) + theme(legend.position="none") +
  labs(x = "Reporters", y = "Normalised intensity")

## ----mzxmlqnt-----------------------------------------------------------------
mzxml <- pxget(px1, "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.mzXML")
rawms <- readMSData(mzxml, centroided = TRUE, verbose = FALSE)
qntms <- quantify(rawms, reporters = TMT7, method = "max")
qntms

## ----qntdf--------------------------------------------------------------------
d <- data.frame(Signal = rowSums(exprs(qntms)[, 1:6]),
                Incomplete = exprs(qntms)[, 7])
d <- log(d)
cls <- rep("#00000050", nrow(qnt))
pch <- rep(1, nrow(qnt))
cls[grep("P02769", fData(qnt)$accession)] <- "gold4" ## BSA
cls[grep("P00924", fData(qnt)$accession)] <- "dodgerblue" ## ENO
cls[grep("P62894", fData(qnt)$accession)] <- "springgreen4" ## CYT
cls[grep("P00489", fData(qnt)$accession)] <- "darkorchid2" ## PHO
pch[grep("P02769", fData(qnt)$accession)] <- 19
pch[grep("P00924", fData(qnt)$accession)] <- 19
pch[grep("P62894", fData(qnt)$accession)] <- 19
pch[grep("P00489", fData(qnt)$accession)] <- 19

## ----mzp, fig.keep='none', warning = FALSE------------------------------------
mzp <- plotMzDelta(rawms, reporters = TMT6, verbose = FALSE) + ggtitle("")

## ----plotmzdelta, fig.cap = "A m/z delta plot."-------------------------------
mzp

## ----incompl, fig.cap = "Incomplete dissociation."----------------------------
plot(Signal ~ Incomplete, data = d,
     xlab = expression(Incomplete~dissociation),
     ylab = expression(Sum~of~reporters~intensities),
     pch = 19,
     col = "#4582B380")
grid()
abline(0, 1, lty = "dotted")
abline(lm(Signal ~ Incomplete, data = d), col = "darkblue")

## ----maplot, fig.cap = "MAplot on an `MSnSet` instance."----------------------
MAplot(qnt[, c(4, 2)], cex = .9, col = cls, pch = pch, show.statistics = FALSE)

## ----mqload, tidy=FALSE-------------------------------------------------------
## load packages
library("MALDIquant")
library("MALDIquantForeign")
## getting test data
datapath <-
  file.path(system.file("Examples",
                        package = "readBrukerFlexData"),
            "2010_05_19_Gibb_C8_A1")
dir(datapath)
sA1 <- importBrukerFlex(datapath, verbose=FALSE)
# in the following we use only the first spectrum
s <- sA1[[1]]

summary(mass(s))
summary(intensity(s))
head(as.matrix(s))

## ----mqplot1, fig.cap = "Spectrum plotting in `r CRANpkg('MALDIquant')`."-----
plot(s)

## ----mqpreproc----------------------------------------------------------------
## sqrt transform (for variance stabilization)
s2 <- transformIntensity(s, method="sqrt")
s2

## smoothing - 5 point moving average
s3 <- smoothIntensity(s2, method="MovingAverage", halfWindowSize=2)
s3

## baseline subtraction
s4 <- removeBaseline(s3, method="SNIP")
s4

## ----mqred--------------------------------------------------------------------
## peak picking
p <- detectPeaks(s4)
length(p) # 181
peak.data <- as.matrix(p) # extract peak information

## ----mqplot, fig.cap = "Spectrum plotting in `r CRANpkg('MALDIquant')`."------
par(mfrow=c(2,3))
xl <- range(mass(s))
# use same xlim on all plots for better comparison
plot(s, sub="", main="1: raw", xlim=xl)
plot(s2, sub="", main="2: variance stabilisation", xlim=xl)
plot(s3, sub="", main="3: smoothing", xlim=xl)
plot(s4, sub="", main="4: base line correction", xlim=xl)
plot(s4, sub="", main="5: peak detection", xlim=xl)
points(p)
top20 <- intensity(p) %in% sort(intensity(p), decreasing=TRUE)[1:20]
labelPeaks(p, index=top20, underline=TRUE)
plot(p, sub="", main="6: peak plot", xlim=xl)
labelPeaks(p, index=top20, underline=TRUE)

## ----isotopes, tidy = FALSE, warning = FALSE----------------------------------
library(BRAIN)
atoms <- getAtomsFromSeq("SIVPSGASTGVHEALEMR")
unlist(atoms)

library(Rdisop)
pepmol <- getMolecule(paste0(names(atoms),
                             unlist(atoms),
                             collapse = ""))
pepmol

##
library(OrgMassSpecR)
data(itraqdata)

simplottest <-
  itraqdata[featureNames(itraqdata) %in% paste0("X", 46:47)]
sim <- SpectrumSimilarity(as(simplottest[[1]], "data.frame"),
                          as(simplottest[[2]], "data.frame"),
                          top.lab = "itraqdata[['X46']]",
                          bottom.lab = "itraqdata[['X47']]",
                          b = 25)
title(main = paste("Spectrum similarity", round(sim, 3)))

MonoisotopicMass(formula = list(C = 2, O = 1, H=6))
molecule <- getMolecule("C2H5OH")
molecule$exactmass
## x11()
## plot(t(.pepmol$isotopes[[1]]), type = "h")

## x <- IsotopicDistribution(formula = list(C = 2, O = 1, H=6))
## t(molecule$isotopes[[1]])
## par(mfrow = c(2,1))
## plot(t(molecule$isotopes[[1]]), type = "h")
## plot(x[, c(1,3)], type = "h")

## data(myo500)
## masses <- c(147.053, 148.056)
## intensities <- c(93, 5.8)
## molecules <- decomposeIsotopes(masses, intensities)

## experimental eno peptides
exppep <-
  as.character(fData(qnt[grep("ENO", fData(qnt)[, 2]), ])[, 1]) ## 13
minlength <- min(nchar(exppep))


if (!file.exists("P00924.fasta"))
    eno <- download.file("http://www.uniprot.org/uniprot/P00924.fasta",
                         destfile = "P00924.fasta")
eno <- paste(readLines("P00924.fasta")[-1], collapse = "")
enopep <- Digest(eno, missed = 1)
nrow(enopep) ## 103
sum(nchar(enopep$peptide) >= minlength) ## 68
pepcnt <- enopep[enopep[, 1] %in% exppep, ]
nrow(pepcnt) ## 13

## ----cleaver, tidy = FALSE----------------------------------------------------
library(cleaver)
cleave("LAAGKVEDSD", enzym = "trypsin")

## ----cleaver_missing, tidy = FALSE--------------------------------------------
## miss one cleavage position
cleave("LAAGKVEDSD", enzym = "trypsin", missedCleavages = 1)

## miss zero or one cleavage positions
cleave("LAAGKVEDSD", enzym = "trypsin", missedCleavages = 0:1)

## ----n15, fig.height = 15, fig.cap = "Isotopic envelope for the `YEVQGEVFTKPQLWP` peptide at different N15 incorporation rates "----
## 15N incorporation rates from 0, 0.1, ..., 0.9, 0.95, 1
incrate <- c(seq(0, 0.9, 0.1), 0.95, 1)
inc <- lapply(incrate, function(inc)
              IsotopicDistributionN("YEVQGEVFTKPQLWP", inc))
par(mfrow = c(4,3))
for (i in 1:length(inc))
  plot(inc[[i]][, c(1, 3)], xlim = c(1823, 1848), type = "h",
       main = paste0("15N incorporation at ", incrate[i]*100, "%"))

## ----MSnIDstart---------------------------------------------------------------
library("MSnID")
msnid <- MSnID(".")

## ----MSnIDdataImport1---------------------------------------------------------
PSMresults <- read.delim(system.file("extdata", "human_brain.txt",
                                     package="MSnID"),
                         stringsAsFactors=FALSE)
psms(msnid) <- PSMresults
show(msnid)

## ----MSnIDdataImport2---------------------------------------------------------
mzids <- system.file("extdata", "c_elegans.mzid.gz", package="MSnID")
msnid <- read_mzIDs(msnid, mzids)
show(msnid)

## ----MSnIDsequence------------------------------------------------------------
msnid <- assess_termini(msnid, validCleavagePattern="[KR]\\.[^P]")
msnid <- assess_missed_cleavages(msnid, missedCleavagePattern="[KR](?=[^P$])")
prop.table(table(msnid$numIrregCleavages))

## ----MSnIDmissedCleavagesPlot-------------------------------------------------
pepCleav <- unique(psms(msnid)[,c("numMissCleavages", "isDecoy", "peptide")])
pepCleav <- as.data.frame(table(pepCleav[,c("numMissCleavages", "isDecoy")]))
library("ggplot2")
ggplot(pepCleav, aes(x=numMissCleavages, y=Freq, fill=isDecoy)) +
    geom_bar(stat='identity', position='dodge') +
    ggtitle("Number of Missed Cleavages")

## ----MSnIDfilteringCriteria---------------------------------------------------
msnid$msmsScore <- -log10(msnid$`MS-GF:SpecEValue`)
msnid$absParentMassErrorPPM <- abs(mass_measurement_error(msnid))

## ----MSnIDsettingFilter-------------------------------------------------------
filtObj <- MSnIDFilter(msnid)
filtObj$absParentMassErrorPPM <- list(comparison="<", threshold=5.0)
filtObj$msmsScore <- list(comparison=">", threshold=8.0)
show(filtObj)

## ----MSnIDfilterAssessment----------------------------------------------------
evaluate_filter(msnid, filtObj, level="PSM")
evaluate_filter(msnid, filtObj, level="peptide")
evaluate_filter(msnid, filtObj, level="accession")

## ----MSnIDfilterOptimization1-------------------------------------------------
filtObj.grid <- optimize_filter(filtObj, msnid, fdr.max=0.01,
                                method="Grid", level="peptide",
                                n.iter=500)
show(filtObj.grid)

## ----MSnIDfilterOptimization2-------------------------------------------------
filtObj.nm <- optimize_filter(filtObj.grid, msnid, fdr.max=0.01,
                                method="Nelder-Mead", level="peptide",
                                n.iter=500)
show(filtObj.nm)

## ----MSnIDfilterAssessment2---------------------------------------------------
evaluate_filter(msnid, filtObj, level="peptide")
evaluate_filter(msnid, filtObj.grid, level="peptide")
evaluate_filter(msnid, filtObj.nm, level="peptide")

## ----MSnIDapplyFilter---------------------------------------------------------
msnid <- apply_filter(msnid, filtObj.nm)
show(msnid)

## ----MSnIDremovingDecoyAndContaminants----------------------------------------
msnid <- apply_filter(msnid, "isDecoy == FALSE")
show(msnid)
msnid <- apply_filter(msnid, "!grepl('Contaminant',accession)")
show(msnid)

## ----MSnIDgetDataOut1---------------------------------------------------------
psm.df <- psms(msnid)
psm.dt <- as(msnid, "data.table")

## ----MSnIDgetDataOut2---------------------------------------------------------
peps <- MSnID::peptides(msnid)
head(peps)
prots <- accessions(msnid)
head(prots)
prots <- proteins(msnid) # may be more intuitive then accessions
head(prots)

## ----MSnIDconvertingToMSnSet--------------------------------------------------
msnset <- as(msnid, "MSnSet")
library("MSnbase")
head(fData(msnset))
head(exprs(msnset))

## ----MSnIDsummingPeptidesToProteins-------------------------------------------
msnset <- combineFeatures(msnset,
                            fData(msnset)$accession,
                            redundancy.handler="unique",
                            fun="sum",
                            cv=FALSE)
head(fData(msnset))
head(exprs(msnset))

## ----eval=TRUE, echo=FALSE, results='hide'------------------------------------
unlink(".Rcache", recursive=TRUE)

## ----annot1-------------------------------------------------------------------
id <- "ENSG00000105323"
library("hpar")
subcell <- hpaSubcellularLoc()
subset(subcell, Gene == id)

## ----annot2, warning=FALSE----------------------------------------------------
library("org.Hs.eg.db")
library("GO.db")
ans <- AnnotationDbi::select(org.Hs.eg.db,
                             keys = id,
                             columns = c("ENSEMBL", "GO", "ONTOLOGY"),
                             keytype = "ENSEMBL")
ans <- ans[ans$ONTOLOGY == "CC", ]
ans
sapply(as.list(GOTERM[ans$GO]), slot, "Term")

## ----annot3a, include = FALSE-------------------------------------------------
library("biomaRt")
ensembl <- NULL

while (is.null(ensembl)) {
    try(ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl"))
    Sys.sleep(2)
}

## ----annot3b, eval = FALSE----------------------------------------------------
# library("biomaRt")
# ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")

## ----annot4, message=FALSE----------------------------------------------------
efilter <- "ensembl_gene_id"
eattr <- c("go_id", "name_1006", "namespace_1003")
bmres <- getBM(attributes=eattr, filters = efilter, values = id, mart = ensembl)
bmres[bmres$namespace_1003 == "cellular_component", "name_1006"]

## ----protpacks, echo=FALSE, warning=FALSE-------------------------------------
# biocVersion has to be of type character
biocv <- as.character(version())
pkTab <- list(Proteomics = proteomicsPackages(biocv),
              MassSpectrometry = massSpectrometryPackages(biocv),
              MassSpectrometryData = massSpectrometryDataPackages(biocv))

## ----protstab, echo=FALSE-----------------------------------------------------
DT::datatable(pkTab[["Proteomics"]])

## ----mstab, echo=FALSE--------------------------------------------------------
DT::datatable(pkTab[["MassSpectrometry"]])

## ----msdatatab, echo=FALSE----------------------------------------------------
DT::datatable(pkTab[["MassSpectrometryData"]])

## ----pkgs, eval=FALSE---------------------------------------------------------
# pp <- proteomicsPackages()
# display(pp)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

