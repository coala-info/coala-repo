[[![](data:image/png;base64...)](http://bioconductor.org/packages/release/bioc/html/knowYourCG.html)](index.html)

* [Sequencing Data](Sequencing.html)
* [Array Data](Array.html)
* [Continuous Data](Continuous.html)
* [Visualization](visualization.html)

# Enrichment Analysis Visualization

# Visualize Enrichment Results

There are many ways one can visualize enrichment results. Here we demonstrate a few popular ones supported in sesame. Dot plot:

```
library(SummarizedExperiment)
library(sesame)
library(knowYourCG)
sesameDataCache("MM285.tissueSignature")
kycgDataCache()
df <- rowData(sesameDataGet('MM285.tissueSignature'))
query <- df$Probe_ID[df$branch == "fetal_liver" & df$type == "Hypo"]
results <- testEnrichment(query, "TFBS")
```

```
KYCG_plotDot(results)
```

![](data:image/png;base64...)

or a bar plot:

```
library(ggplot2)
library(wheatmap)
p1 <- KYCG_plotBar(results, label=TRUE)
p2 <- KYCG_plotBar(results, y="estimate") + ylab("log2(Odds Ratio)") +
    xlab("") + theme(axis.text.y = element_blank())
WGG(p1) + WGG(p2, RightOf(width=0.5, pad=0))
```

![](data:image/png;base64...)

or a volcano plot. Here we need a two-tailed test to show both enrichment and depletion (the default is one-tailed):

```
query <- df$Probe_ID[df$branch == "fetal_brain" & df$type == "Hypo"]
results_2tailed <- testEnrichment(query, "TFBS", alternative = "two.sided")
KYCG_plotVolcano(results_2tailed)
```

![](data:image/png;base64...)

and a Waterfall plot:

```
KYCG_plotWaterfall(results)
```

```
## 316 extremes are capped.
```

![](data:image/png;base64...)

If you have a list of cg groups and they were tested against the same set of databases, you can make a point range plot to summarize the overall trend:

```
## pick some big TFBS-overlapping CpG groups
cg_lists <- getDBs("MM285.TFBS", silent=TRUE)
queries <- cg_lists[(sapply(cg_lists, length) > 40000)]
res <- lapply(queries, function(q) {
    testEnrichment(q, "MM285.chromHMM", silent=TRUE)})

## note the input of the function is a list of testEnrichment outputs.
KYCG_plotPointRange(res)
```

![](data:image/png;base64...)

plot enrichment over metagene:

KnowYourCG builds in several metagene/meta-feature coordinates. One can test enrichment over meta genes or simply plot the mean over metagenes:

```
sdf <- sesameDataGet("EPIC.1.SigDF")
KYCG_plotMeta(getBetas(sdf))
```

![](data:image/png;base64...)

Here we picked some transcription factor binding sites-overlapping CpGs and tested against chromHMM states. As expected, most of these CGs are enriched at promoters and enhancers but depleted at heterchromatic regions.

## Manhattan plot

Manhattan plots are an intuitive way to visualize the results from large scale “omics” studies that investigate genetic or epigenetic features on genome wide scales across large groups of samples. Here we demonstrate how the `KYCG_plotManhattan()` function can be used to visualize the chromosomal distribution and significance level of CpG probes from an EWAS study. `KYCG_plotManhattan()` takes a named numeric vector with CpG probeIDs as names and numeric values (P,Q,logFC,etc) obtained from analysis as values. To plot EWAS results, simply load the necessary libraries and pass the named numeric vector to `KYCG_plotManhattan()`

By default, `KYCG_plotManhattan()` will infer the array platform from the probeIDs and retrieve the corresponding GRanges object to obtain probe coordinates. However, the platform and GRanges objects can be pre - specified if offline. Color, title, and the threshold to label significant probes on the plot can also be specified:

```
library(ggrepel)
smry_pvals = readRDS(url("https://zenodo.org/records/18176501/files/20220413_testManhattan.rds"))
KYCG_plotManhattan(-log10(smry_pvals), platform="HM450",
    title="Differentially Methylated CpGs - EWAS Aging",
    col=c("navy","skyblue"), ylabel = bquote(-log[10](P~value)), label_min=30) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
```

![](data:image/png;base64...)

## Feature Aggregation

In addition to hypothesis testing, knowYourCG also uses the curated database sets for feature engineering. We have a pre-curated summarized experiment containing a samplesheet and beta value matrix corresponding to about 467 MM285 samples with 20k probes. The samplesheet includes UIDs pertaining to the sample and several categorical/numerical features. To use this data for a linear model, we will extract the most relevant prevalent features.

```
library(SummarizedExperiment)
betas = assay(sesameDataGet('MM285.467.SE.tissue20Kprobes'))
```

We have found that it is computationally expensive to perform a linear model/generalized linear model on a feature set of individual CpGs. Additionally, interpreting the mechanism the significantly contributing CpGs is non-trivial due to their complex interactions. We hope to leverage these pre-curated database sets by using their beta value summary statistics as features instead. We will calculate the summary statistics for the betas matrix using a list of database sets. The default is to calculate the mean.

```
stats <- dbStats(betas, 'MM285.chromHMM')
```

```
## Selected the following database groups:
```

```
## 1. KYCG.MM285.chromHMM.20210210
```

```
head(stats[, 1:5])
```

```
##            Enh      EnhG     EnhLo   EnhPois     EnhPr
## [1,] 0.4747438 0.6719724 0.6432090 0.5546328 0.3883567
## [2,] 0.4629993 0.6726350 0.5992930 0.5677431 0.3881347
## [3,] 0.4857179 0.6724716 0.6359722 0.5672481 0.3889514
## [4,] 0.4985426 0.6888043 0.6279642 0.5803560 0.3987007
## [5,] 0.4720005 0.6698668 0.6420811 0.5530925 0.3851314
## [6,] 0.4978402 0.6910251 0.6072940 0.5807078 0.4133535
```

Just from the few database set means above, we can see that TSS are consistently hypomethylated, which is consistent with known biology.

```
library(wheatmap)
WHeatmap(both.cluster(stats)$mat, xticklabels=TRUE,
    cmp=CMPar(stop.points=c("blue","yellow")))
```

![](data:image/png;base64...)

## Feature Annotation

We can also use KYCG database to annotate an arbitrary probe set. This can be done using the `KYCG_annoProbes` function:

```
query <- names(sesameData_getManifestGRanges("MM285"))
anno <- annoProbes(query, "designGroup", silent = TRUE)
head(anno)
```

```
## cg36602742_TC11 cg36602743_TC21 cg36602902_BC11 cg36603287_TC21 cg36603393_BC21
##        "Random"        "Random"           "VMR"       "Adenoma"      "Enhancer"
## cg36603791_TC21
##        "Random"
```