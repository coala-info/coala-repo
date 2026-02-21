# Introduction to SEPIRA

### Yuting Chen and Andrew Teschendorff

### 2018-10-30

`SEPIRA` (Systems EPigenomics Inference of Regulatory Activity) is a novel algorithm which estimates transcription factor activity in any given sample from its genome-wide mRNA expression or DNA methylation profile(Chen Y, Widschwendter M, and Teschendorff AE 2017). It encompasses two main steps:

1. Construction of a tissue-specific transcription factor regulatory network, consisting of transcription factors that are more highly expressed in the user-specified tissue type (the ‘tissue type of interest’) compared to other tissue types, plus an associated set of high-confidence downstream targets.
2. Estimation of transcription factor activity in this network, in any given dataset consisting of gene expression or promoter DNA methylation profiles.

To infer the network, we use the large [GTEx](https://www.gtexportal.org/home/) RNA-seq data set encompassing 8555 samples from about 30 tissue types. With this inferred network, we can then estimate transcription factor activity in samples from other data sets. Due to the large size of the GTEx data set we did not include it in our package. However, in order to gain an appreciation for the SEPIRA algorithm we show the results obtained by applying it to this full dataset. Then we validate it using an RNA-seq data set from Protein Atlas and a DNA methylation data set from the Stem-cell matrix compendium-2 (SCM2).

### How to use

#### Inferring tissue-specific network

```
net.o <- sepiraInfNet(data=data.m, tissue=colnames(data.m), toi = "Lung", cft = "Blood",
TFs = TFeid, sdth = 0.25, sigth = 0.05, pcorth = 0.2, degth = c(0.05, 0.05),
lfcth = c(log2(1.5), 0), minNtgts = 5, ncores = 1)
## Note: `data.m` should be a normalized gene expression data set.
## Parameters used here are not recommended. See "?sepiraInfNet" for more info.
```

#### Estimating transcription factor activity

```
act <- sepiraRegAct(data = data.m, type = "DNAm", regnet = net.o$netTOI, norm = "z", ncores = 1)
```

## Getting started

### Constructing a lung tissue-specific network

`SEPIRA` uses a tissue-centric approach, whereby the user specifies a tissue-type of interest, for which `SEPIRA` then constructs a corresponding tissue-specific transcription factor regulatory network. We note that this network contains transcription factors that are more active in the tissue of interest, and is unlikely to include those factors which carry out housekeeping functions and which are active in all tissues. The ultimate aim of `SEPIRA` is to identify disrupted regulatory networks in diseases that occur in that tissue type of interest. For instance, we might be interested in lung cancer, in which case we would construct a lung-specific regulatory network. As outlined above, there are two main functions in `SEPIRA`, the first one being `sepiraInfNet()` which generates the regulatory network.

```
net.o <- sepiraInfNet(data=data.m, tissue=colnames(data.m), toi = "Lung", cft = "Blood",
TFs = TFeid, sdth = 0.25, sigth = 0.05, pcorth = 0.2, degth = c(0.05, 0.05),
lfcth = c(log2(1.5), 0), minNtgts = 3, ncores = 1)
```

The `sepiraInfNet()` function returns an object with all the information of the resulting generated network. Here, we display the network for lung-tissue:

![](data:image/png;base64...)

### Estimating transcription factor activity

Having inferred the lung-specific regulatory network, we could now infer transcription factor activity in any given sample using the second function `sepiraRegAct()`. Users need to provide as input preferably a genome-wide dataset (either mRNA expression or DNA methylation), since we require values for as many of the predicted target genes as possible. For each sample, `sepiraRegAct()` regresses the sample’s expression/ methylation profile against the binding profile of the given transcription factor. The t-statistic of this linear regression is interpreted as the transcription factor activity score. After you have run this function, as a sanity check we can display the average TF activity scores out for each tissue-type in the same GTEX dataset:

```
# estimating transcription factor activity in data.m
TFact_gtex.m <- sepiraRegAct(data.m,type="exp",regnet=net.o$netTOI,norm="z",ncores=1)
```

![](data:image/png;base64...)

### Validation of correctness of tissue-specific networks

It is important to validate the regulatory network in another dataset `dataVAL.m` to see if the predicted targets of the transcription factors in the network do indeed faithfully measure upstream transcription factor (TF) activity. In the paper we used an independent RNA-seq dataset from the ProteinAtlas project for this purpose (see figure below). If you run `sepiraRegAct` on your own validation dataset, you could generate another boxplots to see if the estimated TF activity scores differ.

```
# estimating transcription factor activity in a validation dataset
TFact_val.m <- sepiraRegAct(dataVAL.m,type="exp",regnet=net.o$netTOI,norm="z",ncores=1)
```

![](data:image/png;base64...)

For both datasets, the top ranked tissue is lung, as required.

### Estimating TF activity from DNA methylation

It is also possible to estimate transcription factor activity from promoter DNA methylation profiles. For example, we verified the validity of the infered lung-specific network using a subset of the Stem-Cell Matrix compendium (SCM2) Illumina 450k DNAm dataset consisting of 479,328 probes (after quality control) and 153 samples. When assigning a DNAm value to a gene, we used the method used in (Jiao Y, Widschwendter M, and Teschendorff AE 2014) which first assigns to genes the average DNAm of probes mapping to within 200bp of TSSs (TSS200), or probes mapping to the 1st exon if no probes are mapped to TSS200, or TSS1500 if no probes mapping to the 1st exon. However, there is a little difference when you run `sepiraRegAct` on DNA methylation data set, promoter DNAm values must be used, in which case the binding profile is multiplied by -1 before estimation, since normally a methylated promoter is associated with gene silencing. In the paper we estimated TF activities from SCM2 DNAm dataset, as expected, their activity levels are also significantly higher in lung tissue than in other tissues (one-tailed Wilcoxon test).

![](data:image/png;base64...)

## Session Info

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] SEPIRA_1.2.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.19    corpcor_1.6.9   digest_0.6.18   rprojroot_1.3-2
##  [5] backports_1.1.2 magrittr_1.5    evaluate_0.12   stringi_1.2.4
##  [9] limma_3.38.0    rmarkdown_1.10  tools_3.5.1     stringr_1.3.1
## [13] prettydoc_0.2.1 parallel_3.5.1  yaml_2.2.0      compiler_3.5.1
## [17] htmltools_0.3.6 knitr_1.20
```

## References

Chen Y, Widschwendter M, and Teschendorff AE. 2017. “Systems-Epigenomics Inference of Transcription Factor Activity Implicates Aryl-Hydrocarbon-Receptor Inactivation as a Key Event in Lung Cancer Development.” *Genome Biol* 18:236.

Jiao Y, Widschwendter M, and Teschendorff AE. 2014. “A Systems-Level Integrative Framework for Genome-Wide Dna Methylation and Gene Expression Data Identifies Differential Gene Expression Modules Under Epigenetic Control.” *Genome Med* 30:2360–6.