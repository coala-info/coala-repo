# Code example from 'DMRcaller' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
local_caption <- paste(
  "Local methylation profile.",
  "The points on the graph represent methylation proportion of individual cytosines,",
  "their colour (red or blue) which sample they belong to and the intensity of the colour how many reads that particular cytosine had.",
  "This means that darker colours indicate stronger evidence that the corresponding cytosine has the corresponding methylation proportion,",
  "while lighter colours indicate a weaker evidence.",
  "The solid lines represent the smoothed profiles and the intensity of the colour the coverage at the corresponding position (darker colours indicate more reads while lighter ones less reads).",
  "The boxes on top represent the DMRs, where a filled box will represent a DMR which gained methylation while a box with a pattern represent a DMR that lost methylation.",
  "The DMRs need to have a metadata column `regionType` which can be either `gain` (where there is more methylation in condition 2 compared to condition 1) or `loss` (where there is less methylation in condition 2 compared to condition 1).",
  "In case this metadata column is missing all DMRs are drawn using filled boxes.",
  "Finally we also allow annotation of the DNA sequence.",
  "We represent by black boxes all the exons, which are joined by a horizontal black line, thus, marking the full body of the gene.",
  "With grey boxes we mark the transposable elements.",
  "Both for genes and transposable elements we plot them over a mid line if they are on the positive strand and under the mid line if they are on the negative strand."
)

knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  fig.width = 7,
  fig.height = 5)

## ----pvalue, echo=TRUE, message=FALSE, eval=FALSE-----------------------------
# pValue <- 2*pnorm(-abs(zScore))

## ----pvalue_adjust, echo=TRUE, message=FALSE, eval=FALSE----------------------
# pValue <- p.adjust(pValue, method="fdr")

## ----load_presaved, message=FALSE,cache=FALSE---------------------------------
library(DMRcaller)

#load presaved data
data(methylationDataList)

## ----load, echo=TRUE, message=FALSE, cache=FALSE, eval=FALSE------------------
# # specify the Bismark CX report files
# saveBismark(methylationDataList[["WT"]],
#             "chr3test_a_thaliana_wt.CX_report")
# saveBismark(methylationDataList[["met1-3"]],
#             "chr3test_a_thaliana_met13.CX_report")
# 
# # load the data
# methylationDataWT <- readBismark("chr3test_a_thaliana_wt.CX_report")
# methylationDataMet13 <- readBismark("chr3test_a_thaliana_met13.CX_report")
# methylationDataList <- GRangesList("WT" = methylationDataWT,
#                                    "met1-3" = methylationDataMet13)

## ----pool_data, echo=TRUE, message=FALSE, cache=FALSE, eval=FALSE-------------
# # load the data
# methylationDataAll <- poolMethylationDatasets(methylationDataList)
# 
# # In the case of 2 elements, this is equivalent to
# methylationDataAll <- poolTwoMethylationDatasets(methylationDataList[[1]],
#                                                  methylationDataList[[2]])

## ----read_pool_data, echo=TRUE, message=FALSE, cache=FALSE, eval=FALSE--------
# # load the data
# methylationDataAll <- readBismarkPool(c(file_wt, file_met13))

## ----selectCytosine_example, echo=TRUE, message=FALSE, cache=FALSE,eval=FALSE----
# library(BSgenome.Hsapiens.UCSC.hg38)
# 
# # Select cytosines in CG context on chromosome 1
# gr_cpg <- selectCytosine(
#   genome = BSgenome.Hsapiens.UCSC.hg38,
#   context = "CG",
#   chr     = "chr1"
# )
# gr_cpg

## ----read_ONT, echo=TRUE,message=FALSE,cache=FALSE,eval=FALSE-----------------
# # Path to ONT BAM (with MM/ML tags)
# bamfile <- system.file("extdata",
#                        "scanBamChr1Random5.bam",
#                        package="DMRcaller")
# 
# # Decode methylation and compute read-level counts
# OntChr1CG <- readONTbam(
#   bamfile    = bamfile,
#   ref_gr     = gr_cpg,
#   genome     = BSgenome.Hsapiens.UCSC.hg38,
#   modif      = "C+m?",
#   chr        = "chr1",
#   region     = FALSE,
#   prob_thresh= 0.5,
#   parallel   = FALSE,
# )
# 
# # View results
# OntChr1CG

## ----BSgenome_available, echo=TRUE, cache=FALSE, message=FALSE, eval=FALSE----
# head(BSgenome::available.genomes())
# 

## ----load_ontSampleGRangesList, message=FALSE, cache=FALSE--------------------
# load presaved ont GRanges data
data(ontSampleGRangesList)

## ----lowResProfile, fig.height=4, fig.width=12, fig.cap="Low resolution profile in CG context for WT and met1-3", out.width='95%',echo=TRUE, fig.align='center', message=FALSE, cache=FALSE----
plotMethylationProfileFromData(methylationDataList[["WT"]],
                               methylationDataList[["met1-3"]],
                               conditionsNames = c("WT","met1-3"),
                               windowSize = 10000,
                               autoscale = FALSE,
                               context = c("CG"))

## ----profile_fine, echo=TRUE, message=FALSE, cache=FALSE,  fig.width=5,fig.height=5, fig.align='center', eval=FALSE----
# regions <- GRanges(seqnames = Rle("Chr3"), ranges = IRanges(1,1E6))
# 
# # compute low resolution profile in 10 Kb windows
# profileCGWT <- computeMethylationProfile(methylationDataList[["WT"]],
#                                          regions,
#                                          windowSize = 10000,
#                                          context = "CG")
# 
# profileCGMet13 <- computeMethylationProfile(methylationDataList[["met1-3"]],
#                                             regions,
#                                             windowSize = 10000,
#                                             context = "CG")
# 
# profilesCG <- GRangesList("WT" = profileCGWT, "met1-3" = profileCGMet13)
# 
# #plot the low resolution profile
# par(mar=c(4, 4, 3, 1)+0.1)
# par(mfrow=c(1,1))
# plotMethylationProfile(profilesCG,
#                        autoscale = FALSE,
#                        labels = NULL,
#                        title="CG methylation on Chromosome 3",
#                        col=c("#D55E00","#E69F00"),
#                        pch = c(1,0),
#                        lty = c(4,1))

## ----coverage, fig.width=6,fig.height=5,out.width='60%', fig.cap="Coverage. For example, this figure shows that in WT only $30%$ of the cytosines in CHH context have at least 10 reads", fig.align='center', message=FALSE,cache=FALSE----
# plot the coverage in the two contexts
par(mar=c(4, 4, 3, 1)+0.1)
plotMethylationDataCoverage(methylationDataList[["WT"]],
                            methylationDataList[["met1-3"]],
                            breaks = c(1,5,10,15),
                            regions = NULL,
                            conditionsNames=c("WT","met1-3"),
                            context = c("CHH"),
                            proportion = TRUE,
                            labels=LETTERS,
                            contextPerRow = FALSE)

## ----coverage_compute, message=FALSE,cache=FALSE, eval=FALSE------------------
# coverageCGWT <- computeMethylationDataCoverage(methylationDataList[["WT"]],
#                                                context="CG",
#                                                breaks = c(1,5,10,15))

## ----correlationPlot, fig.width=6,fig.height=5, fig.cap="Spatial correlation of methylation levels", fig.align='center', out.width='60%', message=FALSE,cache=FALSE----
# compute the spatial correlation of methylation levels
plotMethylationDataSpatialCorrelation(methylationDataList[["WT"]],
                            distances = c(1,100,10000), regions = NULL,
                            conditionsNames = c("WT"),
                            context = c("CG"),
                            labels = LETTERS, col = NULL,
                            pch = c(1,0,16,2,15,17), lty = c(4,1,3,2,6,5),
                            contextPerRow = FALSE,
                            log = "x")

## ----correlation_compute, message=FALSE,cache=FALSE, eval=FALSE---------------
# correlation_CG_wt <- computeMethylationDataSpatialCorrelation(methylationDataList[["WT"]],
#                                                               context="CG",
#                                                               distances=c(1,10,100,1000,10000))

## ----compute_DMRs_CG_noise_filter, message=FALSE,cache=FALSE------------------
chr_local <- GRanges(seqnames = Rle("Chr3"), ranges = IRanges(5E5,6E5))

# compute the DMRs in CG context with noise_filter method
DMRsNoiseFilterCG <- computeDMRs(methylationDataList[["WT"]],
                      methylationDataList[["met1-3"]],
                      regions = chr_local,
                      context = "CG",
                      method = "noise_filter",
                      windowSize = 100,
                      kernelFunction = "triangular",
                      test = "score",
                      pValueThreshold = 0.01,
                      minCytosinesCount = 4,
                      minProportionDifference = 0.4,
                      minGap = 0,
                      minSize = 50,
                      minReadsPerCytosine = 4,
                      cores = 1)

print(DMRsNoiseFilterCG)

## ----compute_DMRs_CG_neighbourhood, message=FALSE,cache=FALSE-----------------
# compute the DMRs in CG context with neighbourhood method
DMRsNeighbourhoodCG <- computeDMRs(methylationDataList[["WT"]],
                                   methylationDataList[["met1-3"]],
                                   regions = chr_local,
                                   context = "CG",
                                   method = "neighbourhood",
                                   test = "score",
                                   pValueThreshold = 0.01,
                                   minCytosinesCount = 4,
                                   minProportionDifference = 0.4,
                                   minGap = 200,
                                   minSize = 1,
                                   minReadsPerCytosine = 4,
                                   cores = 1)

print(DMRsNeighbourhoodCG)

## ----compute_DMRs_CG_bins, message=FALSE,cache=FALSE--------------------------
# compute the DMRs in CG context with bins method
DMRsBinsCG <- computeDMRs(methylationDataList[["WT"]],
                          methylationDataList[["met1-3"]],
                          regions = chr_local,
                          context = "CG",
                          method = "bins",
                          binSize = 100,
                          test = "score",
                          pValueThreshold = 0.01,
                          minCytosinesCount = 4,
                          minProportionDifference = 0.4,
                          minGap = 200,
                          minSize = 50,
                          minReadsPerCytosine = 4,
                          cores = 1)

print(DMRsBinsCG)

## ----compute_DMRs_CG_GE, message=FALSE,cache=FALSE----------------------------
# load the gene annotation data
data(GEs)

#select the genes
genes <- GEs[which(GEs$type == "gene")]

# compute the DMRs in CG context over genes
DMRsGenesCG <- filterDMRs(methylationDataList[["WT"]],
                          methylationDataList[["met1-3"]],
                          potentialDMRs = genes[overlapsAny(genes, chr_local)],
                          context = "CG",
                          test = "score",
                          pValueThreshold = 0.01,
                          minCytosinesCount = 4,
                          minProportionDifference = 0.4,
                          minReadsPerCytosine = 3,
                          cores = 1)
print(DMRsGenesCG)

## ----merge_DMRs_CG_noise_filter, message=FALSE,cache=FALSE--------------------
DMRsNoiseFilterCGMerged <- mergeDMRsIteratively(DMRsNoiseFilterCG,
                                                minGap = 200,
                                                respectSigns = TRUE,
                                                methylationDataList[["WT"]],
                                                methylationDataList[["met1-3"]],
                                                context = "CG",
                                                minProportionDifference = 0.4,
                                                minReadsPerCytosine = 4,
                                                pValueThreshold = 0.01,
                                                test="score")
print(DMRsNoiseFilterCGMerged)

## ----differenceMethylationReplicates, fig.width=12,fig.height=5,out.width='95%', fig.cap="Methylation proportions in the synthetic dataset.", fig.align='center',message=FALSE,cache=FALSE----
# loading synthetic data
data("syntheticDataReplicates")

# create vector with colours for plotting
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442",
                "#0072B2", "#D55E00", "#CC79A7")

# plotting the difference in proportions
plot(start(syntheticDataReplicates),
     syntheticDataReplicates$readsM1/syntheticDataReplicates$readsN1,
     ylim=c(0,1), col=cbbPalette[2], xlab="Position in Chr3 (bp)",
     ylab="Methylation proportion")
points(start(syntheticDataReplicates),
       syntheticDataReplicates$readsM2/syntheticDataReplicates$readsN2,
       col=cbbPalette[7], pch=4)
points(start(syntheticDataReplicates),
       syntheticDataReplicates$readsM3/syntheticDataReplicates$readsN3,
       col=cbbPalette[3], pch=2)
points(start(syntheticDataReplicates),
       syntheticDataReplicates$readsM4/syntheticDataReplicates$readsN4,
       col=cbbPalette[6], pch=3)
legend(x = "topleft", legend=c("Treatment 1", "Treatment 2", "Control 1",
                               "Control 2"), pch=c(1,4,2,3),
       col=cbbPalette[c(2,7,3,6)], bty="n", cex=1.0)

## ----computingBiologicalReplicates, message=FALSE,cache=FALSE, eval=TRUE------
if (requireNamespace("GenomeInfoDb", quietly = TRUE)) {
# starting with data joined using joinReplicates

# creating condition vector
condition <- c("a", "a", "b", "b")

# computing DMRs using the neighbourhood method
DMRsReplicatesBins <- computeDMRsReplicates(methylationData = syntheticDataReplicates,
                                            condition = condition,
                                            regions = NULL,
                                            context = "CG",
                                            method = "bins",
                                            binSize = 100,
                                            test = "betareg",
                                            pseudocountM = 1,
                                            pseudocountN = 2,
                                            pValueThreshold = 0.01,
                                            minCytosinesCount = 4,
                                            minProportionDifference = 0.4,
                                            minGap = 0,
                                            minSize = 50,
                                            minReadsPerCytosine = 4,
                                            cores = 1)

print(DMRsReplicatesBins)
}

## ----analyse_reads_inside_regions_for_condition, message=FALSE,cache=FALSE----
#retrive the number of reads in CHH context in WT in CG DMRs
DMRsNoiseFilterCGreadsCHH <- analyseReadsInsideRegionsForCondition(
                              DMRsNoiseFilterCGMerged,
                              methylationDataList[["WT"]], context = "CHH",
                              label = "WT")
print(DMRsNoiseFilterCGreadsCHH)

## ----compute_PMDs_CG_noise_filter, message=FALSE, cache=FALSE,eval=FALSE------
# # load the ONT methylation data
# data(ontSampleGRangesList)
# 
# # define the region of interest on chr1
# chr1_ranges <- GRanges(seqnames = Rle("chr1"), ranges = IRanges(1E6+5E5,2E6))
# 
# # compute the PMDs in CG context using the noise_filter method
# PMDsNoiseFilterCG <- computePMDs(ontSampleGRangesList[["GM18501"]],
#                                  regions = chr1_ranges,
#                                  context = "CG",
#                                  method = "noise_filter",
#                                  windowSize = 100,
#                                  kernelFunction = "triangular",
#                                  lambda = 0.5,
#                                  minCytosinesCount = 4,
#                                  minMethylation = 0.4,
#                                  maxMethylation = 0.6,
#                                  minGap = 200,
#                                  minSize = 50,
#                                  minReadsPerCytosine = 4,
#                                  cores = 1,
#                                  parallel = FALSE)
# 
# PMDsNoiseFilterCG

## ----compute_PMDs_CG_neighbourhood, message=FALSE, cache=FALSE, eval=FALSE----
# # compute the PMDs using the neighbourhood method
# PMDsNeighbourhoodCG <- computePMDs(ontSampleGRangesList[["GM18501"]],
#                                    regions = chr1_ranges,
#                                    context = "CG",
#                                    method = "neighbourhood",
#                                    minCytosinesCount = 4,
#                                    minMethylation = 0.4,
#                                    maxMethylation = 0.6,
#                                    minGap = 200,
#                                    minSize = 50,
#                                    minReadsPerCytosine = 4,
#                                    cores = 1,
#                                    parallel = FALSE)
# 
# PMDsNeighbourhoodCG

## ----compute_PMDs_CG_bins, message=FALSE, cache=FALSE, eval=FALSE-------------
# # compute the PMDs using the bins method
# PMDsBinsCG <- computePMDs(ontSampleGRangesList[["GM18501"]],
#                           regions = chr1_ranges,
#                           context = "CG",
#                           method = "bins",
#                           binSize = 100,
#                           minCytosinesCount = 4,
#                           minMethylation = 0.4,
#                           maxMethylation = 0.6,
#                           minGap = 200,
#                           minSize = 50,
#                           minReadsPerCytosine = 4,
#                           cores = 1,
#                           parallel = FALSE)
# 
# PMDsBinsCG

## ----compute_VMDs_CG, message=FALSE, cache=FALSE, eval=FALSE------------------
# # load the ONT methylation data
# data(ontSampleGRangesList)
# 
# # define the region of interest on chr1
# chr1_ranges <- GRanges(seqnames = Rle("chr1"), ranges = IRanges(1E6+5E5, 1E6+6E5))
# 
# # compute the VMDs in CG context using the "EDE.high" variance threshold
# VMDsBinsCG <- computeVMDs(ontSampleGRangesList[["GM18501"]],
#                           regions = chr1_ranges,
#                           context = "CG",
#                           binSize = 100,
#                           minCytosinesCount = 4,
#                           sdCutoffMethod = "per.high",  # elbow-detected high variance
#                           percentage = 0.05,            # only used if sdCutoffMethod = "per.high" or "per.low"
#                           minGap = 200,
#                           minSize = 50,
#                           minReadsPerCytosine = 4,
#                           parallel = FALSE,
#                           cores = 1)
# 
# VMDsBinsCG

## ----filter_VMRs, message=FALSE, cache=FALSE, eval=FALSE----------------------
# # load the ONT methylation data
# data(ontSampleGRangesList)
# # load the gene annotation data
# data(GEs_hg38)
# 
# # select the transcript
# transcript <- GEs_hg38[which(GEs_hg38$type == "transcript")]
# 
# # the regions where to compute the PMDs
# regions <- GRanges(seqnames = Rle("chr1"), ranges = IRanges(1E6+5E5,2E6))
# transcript <- transcript[overlapsAny(transcript, regions)]
# 
# # filter genes that are differntially methylated in the two conditions
# VMRsGenesCG <- filterVMRsONT(ontSampleGRangesList[["GM18501"]],
#                ontSampleGRangesList[["GM18876"]], potentialVMRs = transcript,
#                context = "CG", pValueThreshold = 0.01,
#                minCytosinesCount = 4, minProportionDifference = 0.01,
#                minReadsPerCytosine = 3, ciExcludesOne = TRUE,
#                varRatioFc = NULL, parallel = TRUE) # parallel recommended

## ----compute_comethylation_fisher, message=FALSE, cache=FALSE, eval=TRUE------
# load ONT methylation and PMD data
data("ont_gr_GM18870_chr1_PMD_bins_1k")
data("ont_gr_GM18870_chr1_sorted_bins_1k")

# compute co-methylation using Fisher's exact test
coMethylationFisher <- computeCoMethylatedPositions(
  ont_gr_GM18870_chr1_sorted_bins_1k,
  regions = ont_gr_GM18870_chr1_PMD_bins_1k[1:4],
  minDistance = 150,
  maxDistance = 1000,
  minCoverage = 1,
  pValueThreshold = 0.01,
  test = "fisher",
  parallel = FALSE)

coMethylationFisher

## ----compute_cmrs_pearson, message=FALSE, cache=FALSE, eval=TRUE--------------
# load ONT methylation and PMD data
data("ont_gr_GM18870_chr1_sorted_bins_1k")
data("ont_gr_GM18870_chr1_PMD_bins_1k")

# compute highly correlated PMD region pairs using Pearson method
coMethRegions <- computeCoMethylatedRegions(
  methylationData = ont_gr_GM18870_chr1_sorted_bins_1k,
  regions = ont_gr_GM18870_chr1_PMD_bins_1k[1:5],
  minDistance = 500,
  maxDistance = 50000,
  minCoverage = 4,
  pValueThreshold = 0.05,
  correlation_test = "pearson",
  minCorrelation = -0.5,
  maxCorrelation = 0.5,
  parallel = FALSE
)

coMethRegions

## ----DMRdensity, fig.width=15,fig.height=2.5,out.width='95%', fig.cap= "Distribution of DMRs. Darker colour indicates higher density, while lighter colour lower density.", fig.align='center', message=FALSE,cache=FALSE----
# compute the distribution of DMRs
hotspots <- computeOverlapProfile(DMRsNoiseFilterCGMerged, chr_local,
                                  windowSize=5000, binary=TRUE)
# plot the distribution of DMRs
plotOverlapProfile(GRangesList("Chr3"=hotspots))

## ----localMethylationProfile, fig.width=15,fig.height=5,out.width='95%',  fig.cap=local_caption, fig.align='center',message=FALSE,cache=FALSE----
# select a 20 Kb location on the Chr3
chr3Reg <- GRanges(seqnames = Rle("Chr3"), ranges = IRanges(510000,530000))

# create a list with all DMRs
DMRsCGList <- list("noise filter" = DMRsNoiseFilterCGMerged,
                   "neighbourhood" = DMRsNeighbourhoodCG,
                   "bins" = DMRsBinsCG,
                   "genes" = DMRsGenesCG)
# plot the local profile
par(cex=0.9)
par(mar=c(4, 4, 3, 1)+0.1)
plotLocalMethylationProfile(methylationDataList[["WT"]],
                            methylationDataList[["met1-3"]],
                            chr3Reg,
                            DMRsCGList,
                            conditionsNames = c("WT", "met1-3"),
                            GEs,
                            windowSize = 300,
                            main="CG methylation")

## ----DMRinParallel, message=FALSE,cache=FALSE---------------------------------
# Parallel; compute the DMRs in CG context with noise_filter method
DMRsNoiseFilterCG_3cores <- computeDMRs(methylationDataList[["WT"]],
                      methylationDataList[["met1-3"]],
                      regions = chr_local,
                      context = "CG",
                      method = "noise_filter",
                      windowSize = 100,
                      kernelFunction = "triangular",
                      test = "score",
                      pValueThreshold = 0.01,
                      minCytosinesCount = 4,
                      minProportionDifference = 0.4,
                      minGap = 0,
                      minSize = 50,
                      minReadsPerCytosine = 4,
                      parallel = TRUE, # default: FALSE
                      BPPARAM = NULL, # default: NULL
                      cores = 3 # default: 1
                      ) 

print(DMRsNoiseFilterCG_3cores)

## ----session_info, echo=TRUE--------------------------------------------------
sessionInfo()

