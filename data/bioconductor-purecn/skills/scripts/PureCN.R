# Code example from 'PureCN' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----load-purecn, echo=FALSE, message=FALSE--------------------------------
library(PureCN)
set.seed(1234)

## ----exampleac-------------------------------------------------------------
ac.file <- system.file("extdata", "example_allelic_counts.tsv", 
          package="PureCN")
vcf.ac <- readAllelicCountsFile(ac.file)

## ----examplegc-------------------------------------------------------------
reference.file <- system.file("extdata", "ex2_reference.fa", 
    package = "PureCN", mustWork = TRUE)
bed.file <- system.file("extdata", "ex2_intervals.bed", 
        package = "PureCN", mustWork = TRUE)
mappability.file <- system.file("extdata", "ex2_mappability.bigWig", 
        package = "PureCN", mustWork = TRUE)

intervals <- import(bed.file)
mappability <- import(mappability.file)

preprocessIntervals(intervals, reference.file, 
    mappability = mappability, output.file = "ex2_gc_file.txt")

## ----examplecoverage-------------------------------------------------------
bam.file <- system.file("extdata", "ex1.bam", package="PureCN", 
    mustWork = TRUE)
interval.file <- system.file("extdata", "ex1_intervals.txt", 
    package = "PureCN", mustWork = TRUE)

calculateBamCoverageByInterval(bam.file = bam.file, 
 interval.file = interval.file, output.file = "ex1_coverage.txt")

## ----example_files, message=FALSE, warning=FALSE, results='hide'-----------
library(PureCN)

normal.coverage.file <- system.file("extdata", "example_normal.txt.gz",
    package = "PureCN") 
normal2.coverage.file <- system.file("extdata", "example_normal2.txt.gz", 
    package = "PureCN") 
normal.coverage.files <- c(normal.coverage.file, normal2.coverage.file) 
tumor.coverage.file <- system.file("extdata", "example_tumor.txt.gz", 
    package = "PureCN") 
seg.file <- system.file("extdata", "example_seg.txt",
    package = "PureCN")
vcf.file <- system.file("extdata", "example.vcf.gz", package = "PureCN")
interval.file <- system.file("extdata", "example_intervals.txt", 
    package = "PureCN")

## ----figuregccorrect, fig.show='hide', fig.width=7, fig.height=7, warning=FALSE----
correctCoverageBias(normal.coverage.file, interval.file, 
    output.file = "example_normal_loess.txt.gz", plot.bias = TRUE)

## ----normaldb--------------------------------------------------------------
normalDB <- createNormalDatabase(normal.coverage.files)
# serialize, so that we need to do this only once for each assay
saveRDS(normalDB, file = "normalDB.rds")

## ----normaldbpca-----------------------------------------------------------
normalDB <- readRDS("normalDB.rds")
pool <- calculateTangentNormal(tumor.coverage.file, normalDB)

## ----calculatemappingbias--------------------------------------------------
# speed-up future runtimes by pre-calculating variant mapping biases
normal.panel.vcf.file <- system.file("extdata", "normalpanel.vcf.gz",
                                     package = "PureCN")

bias <- calculateMappingBiasVcf(normal.panel.vcf.file, genome = "h19")
saveRDS(bias, "mapping_bias.rds")
mapping.bias.file <- "mapping_bias.rds"

## ----ucsc_segmental--------------------------------------------------------
# Instead of using a pool of normals to find low quality regions,
# we use suitable BED files, for example from the UCSC genome browser.

# We do not download these in this vignette to avoid build failures 
# due to internet connectivity problems.
downloadFromUCSC <- FALSE
if (downloadFromUCSC) {
    library(rtracklayer)
    mySession <- browserSession("UCSC")
    genome(mySession) <- "hg19"
    simpleRepeats <- track(ucscTableQuery(mySession, 
        track = "Simple Repeats", table = "simpleRepeat"))
    export(simpleRepeats, "hg19_simpleRepeats.bed")
}

snp.blacklist <- "hg19_simpleRepeats.bed"

## ----runpurecn-------------------------------------------------------------
ret <-runAbsoluteCN(normal.coverage.file = pool,
    tumor.coverage.file = tumor.coverage.file, vcf.file = vcf.file, 
    genome = "hg19", sampleid = "Sample1", 
    interval.file = interval.file, normalDB = normalDB,
#    args.setMappingBiasVcf=list(
        # mapping.bias.file = mapping.bias.file
#    ),
    args.filterVcf=list(
        # snp.blacklist = snp.blacklist, 
        # stats.file = mutect.stats.file
    ),
    args.filterIntervals = list(
        min.total.counts = 50
    ), 
    post.optimize = FALSE, plot.cnv = FALSE, verbose = FALSE)

## ----createoutput----------------------------------------------------------
file.rds <- "Sample1_PureCN.rds"
saveRDS(ret, file = file.rds)
pdf("Sample1_PureCN.pdf", width = 10, height = 11)
plotAbs(ret, type = "all")
dev.off()

## ----figureexample1, fig.show='hide', fig.width=6, fig.height=6------------
plotAbs(ret, type = "overview")

## ----figureexample2, fig.show='hide', fig.width=6, fig.height=6------------
plotAbs(ret, 1, type = "hist")

## ----figureexample3, fig.show='hide', fig.width=8, fig.height=8------------
plotAbs(ret, 1, type = "BAF")

## ----figureexample3b, fig.show='hide', fig.width=9, fig.height=8-----------
plotAbs(ret, 1, type = "BAF", chr = "chr19")

## ----figureexample4, fig.show='hide', fig.width=8, fig.height=8------------
plotAbs(ret, 1, type = "AF")

## ----output1---------------------------------------------------------------
names(ret)

## ----output3---------------------------------------------------------------
head(predictSomatic(ret), 3)

## ----output4---------------------------------------------------------------
vcf <- predictSomatic(ret, return.vcf = TRUE)
writeVcf(vcf, file = "Sample1_PureCN.vcf") 

## ----calling2--------------------------------------------------------------
gene.calls <- callAlterations(ret)
head(gene.calls)

## ----calling3--------------------------------------------------------------
gene.calls.zscore <- callAmplificationsInLowPurity(ret, normalDB)
head(gene.calls.zscore)
# filter to known amplifications 
known.calls.zscore <- gene.calls.zscore[ gene.calls.zscore$gene.symbol %in% 
c("AR", "BRAF", "CCND1", "CCNE1", "CDK4", "CDK6", "EGFR", "ERBB2", "FGFR1", 
"FGFR2", "KIT", "KRAS", "MCL1", "MDM2", "MDM4", "MET", "MYC", "PDGFRA", 
"PIK3CA", "RAF1"),]

## ----loh-------------------------------------------------------------------
loh <- callLOH(ret)
head(loh)

## ----curationfile----------------------------------------------------------
createCurationFile(file.rds) 

## ----readcurationfile------------------------------------------------------
ret <- readCurationFile(file.rds)

## ----curationfileshow------------------------------------------------------
read.csv("Sample1_PureCN.csv")

## ----customseg-------------------------------------------------------------
retSegmented <- runAbsoluteCN(seg.file = seg.file, 
    interval.file = interval.file, vcf.file = vcf.file, 
    max.candidate.solutions = 1, genome = "hg19",
    test.purity = seq(0.3,0.7,by = 0.05), verbose = FALSE, 
    plot.cnv = FALSE)

## ----figurecustombaf, fig.show='hide', fig.width=8, fig.height=8-----------
plotAbs(retSegmented, 1, type = "BAF")

## ----customlogratio, message=FALSE-----------------------------------------
# We still use the log2-ratio exactly as normalized by PureCN for this
# example
log.ratio <- calculateLogRatio(readCoverageFile(normal.coverage.file),
    readCoverageFile(tumor.coverage.file))

retLogRatio <- runAbsoluteCN(log.ratio = log.ratio,
    interval.file = interval.file, vcf.file = vcf.file, 
    max.candidate.solutions = 1, genome = "hg19",
    test.purity = seq(0.3, 0.7, by = 0.05), verbose = FALSE, 
    normalDB = normalDB, plot.cnv = FALSE)

## ----callmutationburden----------------------------------------------------
callableBed <- import(system.file("extdata", "example_callable.bed.gz", 
    package = "PureCN"))

callMutationBurden(ret, callable = callableBed)

## ----callcin---------------------------------------------------------------
# All 4 possible ways to calculate fraction of genome altered
cin <- data.frame(
    cin = callCIN(ret, allele.specific = FALSE, reference.state = "normal"),
    cin.allele.specific = callCIN(ret, reference.state = "normal"),
    cin.ploidy.robust = callCIN(ret, allele.specific = FALSE),
    cin.allele.specific.ploidy.robust = callCIN(ret)
)

## ----power1, fig.show='hide', fig.width=6, fig.height=6--------------------
purity <- c(0.1,0.15,0.2,0.25,0.4,0.6,1)
coverage <- seq(5,35,1)
power <- lapply(purity, function(p) sapply(coverage, function(cv) 
    calculatePowerDetectSomatic(coverage = cv, purity = p, ploidy = 2, 
    verbose = FALSE)$power))

# Figure S7b in Carter et al.
plot(coverage, power[[1]], col = 1, xlab = "Sequence coverage", 
    ylab = "Detection power", ylim = c(0, 1), type = "l")

for (i in 2:length(power)) lines(coverage, power[[i]], col = i)
abline(h = 0.8, lty = 2, col = "grey")
legend("bottomright", legend = paste("Purity", purity),
    fill = seq_along(purity))

## ----power2, fig.show='hide', fig.width=6, fig.height=6--------------------
coverage <- seq(5,350,1)
power <- lapply(purity, function(p) sapply(coverage, function(cv) 
    calculatePowerDetectSomatic(coverage = cv, purity = p, ploidy = 2,
    cell.fraction = 0.2, verbose = FALSE)$power))
plot(coverage, power[[1]], col = 1, xlab = "Sequence coverage", 
    ylab="Detection power", ylim = c(0, 1), type = "l")

for (i in 2:length(power)) lines(coverage, power[[i]], col = i)
abline(h = 0.8, lty = 2, col = "grey")
legend("bottomright", legend = paste("Purity", purity),
    fill = seq_along(purity))

## ----sessioninfo, results='asis', echo=FALSE-------------------------------
toLatex(sessionInfo())

