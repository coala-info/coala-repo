# Code example from 'intro' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
# These settings make the vignette prettier
knitr::opts_chunk$set(results="hold", collapse=FALSE, message=FALSE, 
                      warning = FALSE)
#refreshPackage("GenomicDistributions")
#devtools::build_vignettes("code/GenomicDistributions")
#devtools::test("code/GenomicDistributions")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")
# BiocManager::install("GenomicDistributions")

## ----install, eval=FALSE------------------------------------------------------
# devtools::install_github("databio/GenomicDistributions")

## ----echo=TRUE, results="hide", message=FALSE, warning=FALSE------------------
library("GenomicDistributions")
queryFile = system.file("extdata", "vistaEnhancers.bed.gz", package="GenomicDistributions")
query = rtracklayer::import(queryFile)

## ----chrom-plots-single-------------------------------------------------------
# First, calculate the distribution:
x = calcChromBinsRef(query, "hg19")

# Then, plot the result:
plotChromBins(x)

## ----chrom-plots-multi--------------------------------------------------------
# Let's fudge a second region set by shifting the first one over 
query2 = GenomicRanges::shift(query, 1e6)
queryList = GRangesList(vistaEnhancers=query, shifted=query2)
x2 = calcChromBinsRef(queryList, "hg19")
plotChromBins(x2)

## ----tss-distribution, fig.cap="TSS plot. Distribution of query regions relative to TSSs", fig.small=TRUE----
# Calculate the distances:
TSSdist = calcFeatureDistRefTSS(query, "hg19")

# Then plot the result:
plotFeatureDist(TSSdist, featureName="TSS")

## ----tss-distribution-multi, fig.cap="TSS plots with multiple region sets"----

TSSdist2 = calcFeatureDistRefTSS(queryList, "hg19")
plotFeatureDist(TSSdist2, featureName="TSS")


## ----tiled-distance-plot, fig.cap="Tiled feature distance plot. Distribution of query regions relative to arbitrary features", fig.small=TRUE----
plotFeatureDist(TSSdist2, featureName="TSS", tile=TRUE, labelOrder = "center")

## ----Build features-----------------------------------------------------------
featureExample = GenomicRanges::shift(query, round(rnorm(length(query), 0,1000)))

## ----distance-to-features-plot, fig.cap="Feature distance plot. Distribution of query regions relative to arbitrary features", fig.small=TRUE----
fdd = calcFeatureDist(query, featureExample)
plotFeatureDist(fdd)

## ----percentage-partition-plot, fig.cap="Partition distribution plot. Percentage distribution of query regions across genomic features", fig.small=TRUE----
gp = calcPartitionsRef(query, "hg19")
plotPartitions(gp)

## ----multiple-percentage-partition-plot, fig.cap="Partition distribution plot for multiple query region sets.", fig.small=TRUE----
gp2 = calcPartitionsRef(queryList, "hg19")
plotPartitions(gp2)

## ----multiple-raw-partition-plot, fig.cap="Raw partition distribution plot for multiple regionsets", fig.small=TRUE----
# Plot the results:
plotPartitions(gp2, numbers=TRUE)

## ----multiple-proportional-partition-plot, fig.cap="Proportional partition distribution plot for multiple query region sets.", fig.small=TRUE----
gp3 = calcPartitionsRef(queryList, "hg19", bpProportion=TRUE)
plotPartitions(gp3)

## ----corrected-partition-plot, fig.cap="Expected partition distribution plot. Distribution of query regions across genomic features relative to the expected distribution of those features.", fig.small=TRUE----
ep = calcExpectedPartitionsRef(query, "hg19")
plotExpectedPartitions(ep)

## ----multiple-corrected-partition-plot, fig.cap="Expected partition distribution plots for multiple query region sets.", fig.small=TRUE----
ep2 = calcExpectedPartitionsRef(queryList, "hg19")
plotExpectedPartitions(ep2)

## ----multiple-corrected-partition-plot-pvals, fig.cap="Expected partition distribution plots for multiple query region sets with p-values displayed.", fig.small=TRUE----
plotExpectedPartitions(ep2, pval=TRUE)

## ----multiple-corrected-proportional-partition-plot, fig.cap="Expected proportional partition distribution plots for multiple query region sets.", fig.small=TRUE----
ep3 = calcExpectedPartitionsRef(queryList, "hg19", bpProportion=TRUE)
plotExpectedPartitions(ep3)

## ----cumulative-partition-plot, fig.cap="Cumulative partition distribution plot. Cumulative distribution of query regions across genomic features.", fig.small=TRUE----
cp = calcCumulativePartitionsRef(query, "hg19")
plotCumulativePartitions(cp)

## ----multiple-cumulative-partition-plot, fig.cap="Cumulative partition distribution plots for multiple query region sets.", fig.small=TRUE----
cp2 = calcCumulativePartitionsRef(queryList, "hg19")
plotCumulativePartitions(cp2)

## ----specificity-plot-single, fig.height = 6, fig.cap="Specificity of chromatin accessibility across cell types."----
exampleCellMatrixFile = system.file("extdata", "example_cell_matrix.txt", package="GenomicDistributions")
cellMatrix = data.table::fread(exampleCellMatrixFile)
op = calcSummarySignal(query, cellMatrix)
plotSummarySignal(op)

## ----specificity-plot-multi, fig.height = 7, fig.cap="Specificity of chromatin accessibility across cell types."----
op2 = calcSummarySignal(queryList, cellMatrix)
plotSummarySignal(op2)

## ----specificity-plot-multi-color, fig.height = 7, fig.cap="Specificity of chromatin accessibility across cell types."----
op2 = calcSummarySignal(queryList, cellMatrix)
# get cell type metadata from GenomicDistributions
cellTypeMetadata = cellTypeMetadata
plotSummarySignal(op2, metadata = cellTypeMetadata, colorColumn = "tissueType")

## ----specificity-plot-multi-violin, fig.height = 7, fig.cap="Violin plot: chromatin accessibility across cell types."----
plotSummarySignal(signalSummaryList = op2, plotType = "violinPlot", metadata = cellTypeMetadata, colorColumn = "tissueType")

## ----neighbor-distance-plots, fig.cap="Distances between neighboring intervals of a regionset", fig.small=TRUE----

# Calculate the distances 
nd = calcNeighborDist(query)

# Plot the distribution
plotNeighborDist(nd)

## ----multiple-neighbor-distance-plots, fig.cap="Neighboring regions distance for multiple regionsets", fig.small=TRUE----

# Create a list of GRanges objects
s = system.file("extdata", "setB_100.bed.gz", package="GenomicDistributions")
setB = rtracklayer::import(s)
queryList2 = GRangesList(vistaEnhancers=query, setB=setB)

# Calculate the distances
dist2 = calcNeighborDist(queryList2)

# Plot the distribution
plotNeighborDist(dist2)

## ----gc-content-plots, fig.cap="GC content plot. Probability density function of GC percentage", eval=FALSE----
# # Calculate the GC content
# gc1 = calcGCContentRef(query, "hg19")
# 
# # Plot the GC distribution
# plotGCContent(gc1)

## ----gc-content-plots-multi, fig.cap="Multiple GC content plots.", eval=FALSE----
# gc2 = calcGCContentRef(queryList, "hg19")
# plotGCContent(gc2)

## ----dinic-content-plots, fig.cap="Dinucleotide frequency plots.", eval=FALSE----
# df1 = calcDinuclFreqRef(query, "hg19")
# plotDinuclFreq(df1)

## ----dinic-content-plots-multi, fig.cap="Multiple dinucleotide frequency plots.", eval=FALSE----
# df2=calcDinuclFreqRef(queryList, "hg19")
# plotDinuclFreq(df2)

## ----dinic-content-plots-multi-raw-counts, fig.cap="Multiple dinucleotide frequency plots.", eval=FALSE----
# df3=calcDinuclFreqRef(queryList, "hg19", rawCounts=TRUE)
# plotDinuclFreq(df3)

## ----width-distribution-single, fig.cap="Width distribution plot. Frequency of widths in this query"----
# Calculate the widths
qt1 = calcWidth(query)

# Plot the width distribution
plotQTHist(qt1)

## ----width-distribution-multi, fig.cap="Multiple width distribution plots.", fig.small=TRUE----
qt2 = calcWidth(queryList)
plotQTHist(qt2)

## ----width-distribution-colors, fig.cap="Width distribution plot with color options.", fig.small=TRUE----
plotQTHist(qt1, bins=7, EndBarColor = 'black', MiddleBarColor='darkblue')

## -----------------------------------------------------------------------------
fastaSource = "http://ftp.ensembl.org/pub/release-103/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.toplevel.fa.gz"
gtfSource = "http://ftp.ensembl.org/pub/release-103/gtf/caenorhabditis_elegans/Caenorhabditis_elegans.WBcel235.103.gtf.gz"

## ----message=TRUE, eval=FALSE-------------------------------------------------
# CEelegansChromSizes = getChromSizesFromFasta(source=fastaSource)

## ----message=TRUE, eval=FALSE-------------------------------------------------
# bins  = getGenomeBins(CEelegansChromSizes)

## ----message=TRUE, eval=FALSE-------------------------------------------------
# CEelegansTSSs = getTssFromGTF(source=gtfSource, convertEnsemblUCSC=TRUE)

## ----message=TRUE, eval=FALSE-------------------------------------------------
# features = c("gene", "exon", "three_prime_utr", "five_prime_utr")
# CEelegansGeneModels = getGeneModelsFromGTF(source=gtfSource, features=features, convertEnsemblUCSC=TRUE)

## ----message=TRUE, eval=FALSE-------------------------------------------------
# partitionList = genomePartitionList(CEelegansGeneModels$gene,
#                                     CEelegansGeneModels$exon,
#                                     CEelegansGeneModels$three_prime_utr,
#                                     CEelegansGeneModels$five_prime_utr)

## ----eval=FALSE---------------------------------------------------------------
# funcgen = biomaRt::useMart("ENSEMBL_MART_FUNCGEN", host="grch37.ensembl.org")
# funcgen = biomaRt::useDataset("hsapiens_regulatory_feature", mart=funcgen)
# 
# enhancers = biomaRt::getBM(attributes=c('chromosome_name',
#                                         'chromosome_start',
#                                         'chromosome_end',
#                                         'feature_type_name'),
#                   filters='regulatory_feature_type_name',
#                   values='Enhancer',
#                   mart=funcgen)

## ----eval=FALSE---------------------------------------------------------------
# enhancers$chromosome_name = paste("chr", enhancers$chromosome_name, sep="")
# 
# gr1 = GenomicRanges::sort(GenomeInfoDb::sortSeqlevels(
#     GenomicDistributions::dtToGr(enhancers,
#                                  chr="chromosome_name",
#                                  start="chromosome_start",
#                                  end="chromosome_end")))

## ----eval=FALSE---------------------------------------------------------------
# geneModels = GenomicDistributions::getGeneModels("hg19")
# partitionList = GenomicDistributions::genomePartitionList(geneModels$genesGR,
#                                                           geneModels$exonsGR,
#                                                           geneModels$threeUTRGR,
#                                                           geneModels$fiveUTRGR)
# partitionList[["enhancer"]] = gr1

