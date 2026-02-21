# Code example from 'BadRegionFinder' vignette. See references/ for full tutorial.

### R code from vignette source 'BadRegionFinder.Rnw'

###################################################
### code chunk number 1: BadRegionFinder.Rnw:21-22
###################################################
options(width=100)


###################################################
### code chunk number 2: 3installing (eval = FALSE)
###################################################
## BiocManager::install("BadRegionFinder")


###################################################
### code chunk number 3: 4loading
###################################################
library(BadRegionFinder)


###################################################
### code chunk number 4: 5
###################################################
sample_file <- system.file("extdata", "SampleNames2.txt", package = "BadRegionFinder")
samples <- read.table(sample_file)
samples


###################################################
### code chunk number 5: 6
###################################################
target_regions <- system.file("extdata", "targetRegions2.bed", package = "BadRegionFinder")
targetRegions <- read.table(target_regions, header = FALSE, stringsAsFactors = FALSE)
targetRegions


###################################################
### code chunk number 6: 7
###################################################
bam_input <- system.file("extdata", package = "BadRegionFinder")
coverage_summary <- determineCoverage(samples, bam_input, targetRegions, "", TRonly = FALSE)
coverage_summary[[2]]


###################################################
### code chunk number 7: 7
###################################################
threshold1 <- 20
threshold2 <- 100
percentage1 <- 0.80
percentage2 <- 0.90
coverage_indicators <- determineCoverageQuality(threshold1, threshold2, percentage1,
                                                percentage2, coverage_summary)
coverage_indicators[[2]]


###################################################
### code chunk number 8: 8
###################################################
regionsOfInterest<-data.frame(chr = c(2,2,17),
                              start = c(198266420,198267200,74732940),
                              end = c(198267032,198267800,74733301))
regionsOfInterest


###################################################
### code chunk number 9: 9
###################################################
coverage_indicators_2 <- determineRegionsOfInterest(regionsOfInterest, coverage_indicators)
coverage_indicators_2[[2]]


###################################################
### code chunk number 10: 10
###################################################
library(biomaRt)
mart = useMart(biomart="ENSEMBL_MART_ENSEMBL",host="https://grch37.ensembl.org",
               path="/biomart/martservice",dataset="hsapiens_gene_ensembl")
mart


###################################################
### code chunk number 11: 11
###################################################
badCoverageSummary <- reportBadRegionsSummary(threshold1, threshold2, percentage1,
                                              percentage2, coverage_indicators_2, mart, "")
badCoverageSummary


###################################################
### code chunk number 12: 12
###################################################
coverage_indicators_temp <- reportBadRegionsDetailed(threshold1, threshold2, percentage1,
                                                     percentage2, coverage_indicators_2, "",
                                                     samples, "")
coverage_indicators_temp[[2]]


###################################################
### code chunk number 13: 13
###################################################
badCoverageOverview <- reportBadRegionsGenes(threshold1, threshold2, percentage1, percentage2,
                                             badCoverageSummary, "")
badCoverageOverview


###################################################
### code chunk number 14: 13
###################################################
plotSummary(threshold1, threshold2, percentage1, percentage2, badCoverageSummary, "")


###################################################
### code chunk number 15: 14
###################################################
plotDetailed(threshold1, threshold2, percentage1, percentage2, coverage_indicators_temp, "")


###################################################
### code chunk number 16: 15
###################################################
plotSummaryGenes(threshold1, threshold2, percentage1, percentage2, badCoverageOverview, "")


###################################################
### code chunk number 17: 16
###################################################
quantiles <- c(0.5)
coverage_summary2 <- determineQuantiles(coverage_summary, quantiles, "")
coverage_summary2[[2]]


