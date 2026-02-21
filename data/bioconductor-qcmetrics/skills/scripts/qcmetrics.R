# Code example from 'qcmetrics' vignette. See references/ for full tutorial.

## ----env, include=FALSE, echo=FALSE, cache=FALSE------------------------------
suppressPackageStartupMessages(library("qcmetrics"))
suppressPackageStartupMessages(library("mzR"))
suppressPackageStartupMessages(library("MSnbase"))
set.seed(1)

## ----qcmetric-----------------------------------------------------------------
library("qcmetrics")
qc <- QcMetric(name = "A test metric")
qcdata(qc, "x") <- rnorm(100)
qcdata(qc) ## all available qcdata
summary(qcdata(qc, "x")) ## get x
show(qc) ## or just qc
status(qc) <- TRUE
qc

## ----qcmetricplot-------------------------------------------------------------
plot(qc)
plot(qc) <- function(object, ... ) boxplot(qcdata(object, "x"), ...)
plot(qc)

## -----------------------------------------------------------------------------
qcm <- QcMetrics(qcdata = list(qc))
qcm
metadata(qcm) <- list(author = "Prof. Who",
                      lab = "Big lab")
qcm
mdata(qcm)

## -----------------------------------------------------------------------------
metadata(qcm) <- list(author = "Prof. Who",
                      lab = "Cabin lab",
                      University = "Universe-ity")
mdata(qcm)

## ----eval = FALSE-------------------------------------------------------------
# library("RforProteomics")
# msfile <- getPXD000001mzXML()
# library("MSnbase")
# exp <- readMSData(msfile, verbose = FALSE)

## -----------------------------------------------------------------------------
load(system.file("extdata/exp.rda", package = "qcmetrics"))

## ----protqc1------------------------------------------------------------------
qc1 <- QcMetric(name = "Chromatogram")
x <- rtime(exp)
y <- precursorIntensity(exp)
o <- order(x)
qcdata(qc1, "x") <- x[o]
qcdata(qc1, "y") <- y[o]
plot(qc1) <- function(object, ...)
    plot(qcdata(object, "x"),
         qcdata(object, "y"),
         col = "darkgrey", type ="l",
         xlab = "retention time",
         ylab = "precursor intensity")

## ----protqc2, cache = TRUE----------------------------------------------------
qc2 <- QcMetric(name = "MS space")
qcdata(qc2, "p2d") <- plot2d(exp, z = "charge", plot = FALSE)
plot(qc2) <- function(object) {
    require("ggplot2")
    print(qcdata(object, "p2d"))
}

## ----protqc3, cache = TRUE----------------------------------------------------
qc3 <- QcMetric(name = "m/z delta plot")
qcdata(qc3, "pmz") <- plotMzDelta(exp, plot = FALSE,
                                  verbose = FALSE)
plot(qc3) <- function(object)
    suppressWarnings(print(qcdata(object, "pmz")))

## ----protqcm------------------------------------------------------------------
protqcm <- QcMetrics(qcdata = list(qc1, qc2, qc3))
metadata(protqcm) <- list(
    data = "PXD000001",
    instrument = experimentData(exp)@instrumentModel,
    source = experimentData(exp)@ionSource,
    analyser = experimentData(exp)@analyser,
    detector = experimentData(exp)@detectorType,
    manufacurer = experimentData(exp)@instrumentManufacturer)

## ----protreport0, echo = FALSE, message = FALSE, eval = FALSE-----------------
# qcReport(protqcm, reportname = "protqc", clean=FALSE, quiet=TRUE)

## ----protreport, eval = FALSE-------------------------------------------------
# qcReport(protqcm, reportname = "protqc")

## ----results='markup', out.width="100%", fig.align="center", fig.cap="Proteomics QC report", echo=FALSE----
knitr::include_graphics("./figs/protqc.png")

## ----eval = FALSE-------------------------------------------------------------
# browseURL(example_reports("protqc"))

## ----n15ex--------------------------------------------------------------------
library("ggplot2")
library("MSnbase")
data(n15psm)
psm

## ----qcinc--------------------------------------------------------------------
## incorporation rate QC metric
qcinc <- QcMetric(name = "15N incorporation rate")
qcdata(qcinc, "inc") <- fData(psm)$inc
qcdata(qcinc, "tr") <- 97.5
status(qcinc) <- median(qcdata(qcinc, "inc")) > qcdata(qcinc, "tr")

## ----qcinc2-------------------------------------------------------------------
show(qcinc) <- function(object) {
    qcshow(object, qcdata = FALSE)
    cat(" QC threshold:", qcdata(object, "tr"), "\n")
    cat(" Incorporation rate\n")
    print(summary(qcdata(object, "inc")))
    invisible(NULL)
}

## ----qcinc3-------------------------------------------------------------------
plot(qcinc) <- function(object) {
    inc <- qcdata(object, "inc")
    tr <- qcdata(object, "tr")
    lab <- "Incorporation rate"
    dd <- data.frame(inc = qcdata(qcinc, "inc"))
    p <- ggplot(dd, aes(factor(""), inc)) +
        geom_jitter(colour = "#4582B370", size = 3) +
    geom_boxplot(fill = "#FFFFFFD0", colour = "#000000",
                 outlier.size = 0) +
    geom_hline(yintercept = tr, colour = "red",
               linetype = "dotted", size = 1) +
    labs(x = "", y = "Incorporation rate")
    p
}

## ----combinefeatures----------------------------------------------------------
fData(psm)$modseq <- ## pep seq + PTM
    paste(fData(psm)$Peptide_Sequence,
          fData(psm)$Variable_Modifications, sep = "+")
pep <- combineFeatures(psm,
                       as.character(fData(psm)$Peptide_Sequence),
                       "median", verbose = FALSE)
modpep <- combineFeatures(psm,
                          fData(psm)$modseq,
                          "median", verbose = FALSE)
prot <- combineFeatures(psm,
                        as.character(fData(psm)$Protein_Accession),
                        "median", verbose = FALSE)

## ----qclfc--------------------------------------------------------------------
## calculate log fold-change
qclfc <- QcMetric(name = "Log2 fold-changes")
qcdata(qclfc, "lfc.psm") <-
    log2(exprs(psm)[,"unlabelled"] / exprs(psm)[, "N15"])
qcdata(qclfc, "lfc.pep") <-
    log2(exprs(pep)[,"unlabelled"] / exprs(pep)[, "N15"])
qcdata(qclfc, "lfc.modpep") <-
    log2(exprs(modpep)[,"unlabelled"] / exprs(modpep)[, "N15"])
qcdata(qclfc, "lfc.prot") <-
    log2(exprs(prot)[,"unlabelled"] / exprs(prot)[, "N15"])
qcdata(qclfc, "explfc") <- c(-0.5, 0.5)

status(qclfc) <-
    median(qcdata(qclfc, "lfc.psm")) > qcdata(qclfc, "explfc")[1] &
    median(qcdata(qclfc, "lfc.psm")) < qcdata(qclfc, "explfc")[2]

## ----qclfc2-------------------------------------------------------------------
show(qclfc) <- function(object) {
    qcshow(object, qcdata = FALSE) ## default
    cat(" QC thresholds:", qcdata(object, "explfc"), "\n")
    cat(" * PSM log2 fold-changes\n")
    print(summary(qcdata(object, "lfc.psm")))
    cat(" * Modified peptide log2 fold-changes\n")
    print(summary(qcdata(object, "lfc.modpep")))
    cat(" * Peptide log2 fold-changes\n")
    print(summary(qcdata(object, "lfc.pep")))
    cat(" * Protein log2 fold-changes\n")
    print(summary(qcdata(object, "lfc.prot")))
    invisible(NULL)
}
plot(qclfc) <- function(object) {
    x <- qcdata(object, "explfc")
    plot(density(qcdata(object, "lfc.psm")),
         main = "", sub = "", col = "red",
         ylab = "", lwd = 2,
         xlab = expression(log[2]~fold-change))
    lines(density(qcdata(object, "lfc.modpep")),
          col = "steelblue", lwd = 2)
    lines(density(qcdata(object, "lfc.pep")),
          col = "blue", lwd = 2)
    lines(density(qcdata(object, "lfc.prot")),
          col = "orange")
    abline(h = 0, col = "grey")
    abline(v = 0, lty = "dotted")
    rect(x[1], -1, x[2], 1, col = "#EE000030",
         border = NA)
    abline(v = median(qcdata(object, "lfc.psm")),
           lty = "dashed", col = "blue")
    legend("topright",
           c("PSM", "Peptides", "Modified peptides", "Proteins"),
           col = c("red", "steelblue", "blue", "orange"), lwd = 2,
           bty = "n")
}

## ----qcnb---------------------------------------------------------------------
## number of features
qcnb <- QcMetric(name = "Number of features")
qcdata(qcnb, "count") <- c(
    PSM = nrow(psm),
    ModPep = nrow(modpep),
    Pep = nrow(pep),
    Prot = nrow(prot))
qcdata(qcnb, "peptab") <-
    table(fData(psm)$Peptide_Sequence)
qcdata(qcnb, "modpeptab") <-
    table(fData(psm)$modseq)
qcdata(qcnb, "upep.per.prot") <-
    fData(psm)$Number_Of_Unique_Peptides

## ----qcnb2--------------------------------------------------------------------
show(qcnb) <- function(object) {
    qcshow(object, qcdata = FALSE)
    print(qcdata(object, "count"))
}
plot(qcnb) <- function(object) {
    par(mar = c(5, 4, 2, 1))
    layout(matrix(c(1, 2, 1, 3, 1, 4), ncol = 3))
    barplot(qcdata(object, "count"), horiz = TRUE, las = 2)
    barplot(table(qcdata(object, "modpeptab")),
            xlab = "Modified peptides")
    barplot(table(qcdata(object, "peptab")),
            xlab = "Peptides")
    barplot(table(qcdata(object, "upep.per.prot")),
            xlab = "Unique peptides per protein ")
}

## ----n15qcm-------------------------------------------------------------------
n15qcm <- QcMetrics(qcdata = list(qcinc, qclfc, qcnb))

## ----n15report, eval = FALSE--------------------------------------------------
# qcReport(n15qcm, reportname = "n15qcreport",
#          title = expinfo(experimentData(psm))["title"],
#          author = expinfo(experimentData(psm))["contact"],
#          clean = FALSE)

## ----results='markup', out.width="100%", fig.align="center", fig.cap="N15 QC report", echo=FALSE----
knitr::include_graphics("./figs/n15qcreport.png")

## ----eval = FALSE-------------------------------------------------------------
# browseURL(example_reports("n15qc"))

## ----Qc2Tex-------------------------------------------------------------------
qcmetrics:::Qc2Tex
qcmetrics:::Qc2Tex(n15qcm, 1)

## ----maqcreport4, eval = FALSE------------------------------------------------
# qcReport(n15qcm, reportname = "report", qcto = Qc2Tex2)
# qcReport(n15qcm, reportname = "report", qcto = Qc2Tex3) ## for smiley/frowney

## ----results='markup', out.width="100%", fig.cap="Customised QC report", echo=FALSE----
knitr::include_graphics("./figs/custom.png")

## ----eval = FALSE-------------------------------------------------------------
# browseURL(example_reports("custom"))

## ----qcpkg0, eval=FALSE-------------------------------------------------------
# package.skeleton("N15QC", list = "n15qc")

## ----si-----------------------------------------------------------------------
sessionInfo()

