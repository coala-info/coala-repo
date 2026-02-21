# brainImageR

#### *Sara Linker*

#### *2018-10-30*

BrainImageR provides a suite of tools to compare gene expression data to post-mortem human brain data from the Allen Brain Atlas. BrainImageR has two main functionalities, the first which is presented in **Section 1** is to characterize spatial gene set enrichment (SGSE) in the human brain using either the developing brain or the adult brain as the reference material. The second, presented in **Section 2**, predicts the approximate point in developmental time that the sample relates to.

Comparing your dataset versus the human post-mortem reference:

* quantify SGSE
* qualitatively plot SGSE maps
* predict developmental time

```
library(brainImageR)
library(ggplot2)
brainImageR:::loadworkspace()
#> snapshotDate(): 2018-10-30
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1434'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1435'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1436'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1437'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1438'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1439'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1440'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1441'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1442'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1443'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1444'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1445'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1446'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1447'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1448'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1449'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1450'
#> Bioconductor version 3.8 (BiocManager 1.30.3), R 3.5.1 Patched (2018-07-12
#>   r74967)
#> Installing package(s) 'brainimageRdata'
#> Update old packages: 'reactome.db', 'rgeos'
#> downloading 0 resources
#> loading from cache
#>     '/home/biocbuild//.ExperimentHub/1451'
```

## SECTION 1: Spatial Gene Set Enrichment Analysis

The Spatial Gene Set Enrichment (SGSE) tools provide the user with a quantitative measure of gene set enrichment within the postmortem brain as well as additional tools to dig in deeper into the genes that overlap across regions, and an ability to plot the SGSE over reference drawings of the human brain. These set of tools work both for the developing and adult human brain.

*One point to note* is that a major advantage of brainImageR is the ability to cross-reference two disparate datasets from the Allen Brain Atlas:

* **microdissected tissue**: Transcription datasets from microdissected tissue. This set is used to identify which genes are present within a given tissue.
* **general brain area**: Regions noted in the Allen Brain Atlas reference map. This set is used to plot the final SGSE over a map of the human brain.

These two datasets do not share a 1:1 relationship. As a general rule more than one microdissected tissue will be combined to generate the profile plotted over the general brain area reference atlas. We will refer to these two datsets as either **microdissected tissue** or **general brain area** throughout the vignette to clearly distinguish the two datasets being queried.

## 1.0: Preparing the data

The SGSE analysis works directly off of gene lists such as those that are returned from a differential expression analysis. We’ve provided two datasets to examine SGSE in either the developing ventral thalamus `vth` or the adult hippocampus `hip`.

```
data(vth)
length(vth)
#> [1] 1389
head(vth)
#> [1] "A_32_P3431"   "PITX2"        "PMCH"         "CALCR"
#> [5] "A_32_P183652" "PMCHL2"
```

```
data(hipp)
length(hipp)
#> [1] 1302
head(hipp)
#> [1] "NEUROD2" "BHLHE22" "NEUROD6" "SHISA6"  "SLC17A7" "FNDC1"
```

## (Optional) Converting gene names to Human Gene Symbols

`brainImageR` works from gene names in the Human Gene Symbol format. If your genes are not in this format they must first be converted. There are many utilities online for this purpose such as GeneIDConversion from DAVID Bioinformatics. Below we’ve included a section on how to do this with BiomaRt.

```
### FILL THIS IN
```

## 1.1: Spatial Gene Set Enrichment

The first step in SGSE is to compare your query gene list to the genes known to be expressed in post-mortem human brain **microdissected tissue** using `SpatialEnrichment`. There are three important arguments that go into `SpatialEnrichment`.

`SpatialEnrichment` Arguments:

* `genes` : The query gene list of common Human Gene Symbols.
* `refset`: The user will pick whether `genes` is compared to the developing human or the adult human by assigning the `refset` to “developing” or “adult”.
* `reps` : The final significance estimates are determined by eirther a fisher’s exact test or by bootstrapping the raw data. If you choose to bootstrap, increasing the number of iterations or “reps” will increase the sensitivity of this analysis. For the initial exploratory analysis it is recommended to set this value low (ex: 20). This will allow you to assess different conditions and gene sets. We suggest that for the final analysis that `reps` be increased to a number that can successfully discern comparisons that are significant after Bonferroni correction (developing = 6540 reps, adult = 3680 rep).

```
composite <- SpatialEnrichment(genes = vth, reps = 2, refset = "developing")
```

Additionally you can input a user-defined background list for more nuanced analyses.

* `background`: A gene list of common Human Gene Symbols to perform a user-defined background correction.

## 1.2: Calculate significance

The second step in SGSE is to calculate significance of the observed fold-change compared to random chance within the **microdissected tissue** with `testEnrich`.
`testEnrich` only requires the output of `SpatialEnrichment` to run. If using method = “fisher” a standard fisher’s exact test is called. If using method = “bootstrap” the p-value will be estimated from the raw data.

```
res <- testEnrich(composite, method = "fisher")
```

It is good practice to save your data at this point.

```
save(list = c("composite", "res"), file = "/mydir/myfile.rda")
```

The table produced from `testEnrich` reports the enrichment score for all tested **microdissected tissue** as well as the raw and adjusted p-values. These values can be used to identify the exact **microdissected tissues** that are over- or under-represented by the gene list.

Output from `testEnrich`:

* count.sample: overlap of query gene list and **microdissected tissue** gene list
* count.random: average overlap of random gene list and **microdissected tissue** gene list
* FC: fold-change between sample and random
* p-value: raw p-value
* p-adj: FDR corrected p-value
* abrev: Abreviation of the tissue name provided by Allen Brain Atlas reference. This abreviation can be used as input to the Allen Brain Atlas reference map to identify where exactly the tissue is located within the **general brain area**. It can also be used as input into `GetGenes` to determine exactly which of your query gene list overlaps with the specific tissue.
* structure: Full tissue name.

```
res <- res[order(res$FC, decreasing=TRUE),]
head(res)
#>      count.sample count.random odds.ratio       pvalue         padj abrev
#> MRF           512         71.0  1.8045412 1.066190e-23 8.955997e-22   MRF
#> LHAa          435         67.5  1.4176442 8.252459e-09 4.621377e-07  LHAa
#> InM           533         85.5  1.9326275 1.873317e-29 1.648519e-27   InM
#> DMH           369         60.5  1.0916344 1.639891e-01 1.000000e+00   DMH
#> DT            286         50.5  0.7833224 2.595515e-04 9.603407e-03    DT
#> RMg           538         99.5  2.0160705 3.771557e-33 3.469833e-31   RMg
#>            FC                                structure
#> MRF  7.211268             midbrain reticular formation
#> LHAa 6.444444 lateral hypothalamic area, anterior part
#> InM  6.233918          intercalated nucleus of medulla
#> DMH  6.099174         dorsomedial hypothalamic nucleus
#> DT   5.663366                dentate (lateral) nucleus
#> RMg  5.407035                     raphe magnus nucleus
```

The results from `testEnrich` can be easily plotted with `PlotEnrich`

```
PlotEnrich(res)
```

![](data:image/png;base64...)

One of the top enriched **microdissected tissues** is “LHAa” or the lateral hypothalemic area, anterior part. Let’s see what genes are overlapping between the vth set and the LHAa tissue.

```
vth_lha_overlap <- GetGenes(vth, composite, tissue_abrev = "LHAa")
length(vth_lha_overlap)
#> [1] 459
```

Then using GO term enrichment packages such as `clusterProfiler` we can identify what GO terms are enriched given these overlapped genes.

# ```{r, message=FALSE, warning=FALSE,fig.width = 10, fig.height = 5 }

# library(clusterProfiler)

# library(org.Hs.eg.db)

# vth\_go <- enrichGO(gene = vth\_lha\_overlap,

# OrgDb = org.Hs.eg.db,

# keytype = ‘SYMBOL’,

# pvalueCutoff = 0.05,

# qvalueCutoff = 0.05)

#

# dotplot(vth\_go, showCategory=30)

```

## 1.3: Plot the Brain

Next we would like to see if neighboring brain areas share SGSE estimates. To do this we will use `CreateBrain` to merge all of the **microdissected tissues** returned from `testEnrich` so that each **general brain area** present within the Allen Brain Atlas reference map is supported by the respective set of underlying tissues.

As mentioned above, note that the **general brain areas** within the Allen Brain Atlas reference map and the **microdissected tissues** present within the Allen Brain Atlas transcription datasets do not have a 1:1 relationship. Therefore some areas are not supported by transcriptional information in the reference map while other areas are supported by more than one tissue.

`CreateBrain` takes the results from `SpatialEnrichment` and `testEnrich` as input. There are two additional arguments to consider.

`CreateBrain` arguments:

* slice: Image from within either the developing or adult brain set to plot. The choices for both the developing and adult brain are 1-10.
* pcut: p-value threshold for considering a **microdissected tissue** as being enriched or depleted

Since we initially found the LHAa interesting, let’s see what slice of the developing brain contains **general brain areas** composed of the LHAa.

```
tis_in_region(composite, "LHAa")
#>   slice areas
#> 1     6   THM
#> 2     7   THM
```

Slices 6 and 7 both have relevant information for LHAa in the thalamus (THM). Let’s use slice 6 for downstream analysis.

```
composite <- CreateBrain(composite, res, slice = 5, pcut = 0.05)
```

Once the **microdissected tissues** have been merged into the corresponding **general brain areas**, the image can be plotted.

```
PlotBrain(composite)
```

![](data:image/png;base64...)

From this image it looks like the thalamus is indeed enriched for the vth gene set.Interestingly surrounding areas are also enriched for this set. By referencing the Allen Brain Atlas we can see that those are **general brain areas** like the Putamen (Pu) and Caudate Nucleus (Ca).

Note that you can either reference the Allen Brain Atlas directly or use `available_areanames` to identify the list of available **general brain area** names to query.

```
available_areanames(composite, slice = 6)
#>  [1] "BNST" "CP"   "Ca"   "FWM"  "HTH"  "IZ"   "LGE"  "MGE"  "MZ"   "Pu"
#> [11] "R"    "SG"   "SN"   "SP"   "SZ"   "THM"  "VA"   "VZ"   "alCP" "peCP"
#> [21] "peMZ"
```

Let’s look more closely at the **general brain area** of the Putamen (Pu). Using `tis_set` we can work backwards and identify which **microdissected tissues** support the final color code in a given area of interest.

```
tis_set(composite, area.name = "Pu", slice = 6)
#>   abrev               structure_name
#> 1   Pld laterodorsal part of putamen
#> 2   Pmv medioventral part of putamen
#> 3   PuC               caudal putamen
#> 4   PuR              rostral putamen
```

And now we can go back and observe the gene overlap in a **microdissected tissue** within the Putamen. Here we focus in on the medioventral part of putamen (Pmv)

```
vth_pld_overlap <- GetGenes(vth, composite, tissue_abrev = "Pmv")
length(vth_pld_overlap)
#> [1] 154
##vth_go <- enrichGO(gene = vth_pld_overlap,
##                   OrgDb = org.Hs.eg.db,
##                   keytype = 'SYMBOL',
##                   pvalueCutoff = 0.05,
##                   qvalueCutoff = 0.05)

##dotplot(vth_go, showCategory=30)
```

The GO term “hormone activity” has showed up in both the comparison with LHAa and Pmv. Perhaps there is a shared pathway across these tissues. Let’s use `whichtissues` to see if the genes with hormone activity in the Pmv are also present in the LHAa.

```
#grab the genes associated with hormone activity
#vth_go2 <- data.frame(vth_go)
#vth_match <- vth_go2$Description == "hormone activity"
#vth_pmv_hormone <- vth_go2[vth_match, "geneID"]
#vth_pmv_hormone <- unlist(strsplit(vth_pmv_hormone,"/"))

#identify the presence of these genes across all tissues
#vth_pmv_hormone_tis <- whichtissues(vth_pmv_hormone, refset = "developing")
#vth_pmv_hormone_tis[,1:10]

#which genes are present (1) in the LHAa
#all <- vth_pmv_hormone_tis[,"LHAa"]
#vth_pmv_hormone[ all == 1]
```

Indeed all of the genes involved in hormone activity in the Pmv are also expressed in the LHAa.

Using the above mentioned functions, brainImageR has provided us with a easy way to query SGSE with respect to the postmortem human brain. We calculated the significance of the enrichment of gene overlaps and visualized these enrichments with images of the human brain. Now let’s move on to predicting developmental time from a dataset.

## SECTION 2: DEVELOPMENTAL TIME POINT PREDICTION

## 2.0: Preparing the data

An additional functionality of brainImageR is predicting the developmental timepoint of the sample with reference to the postmortem human brain. This analysis takes a **normalized** expression matrix as input. The columns of this matrix should be samples, and the rows should be gene names in the Gene Symbol format. An example is provided here in `dat`.

```
data(dat)
dim(dat)
#> [1] 10192     6
head(rownames(dat))
#> [1] "A2M"   "NAT2"  "ACAT1" "ADA"   "ADRB2" "ADRB3"
head(colnames(dat))
#> [1] "NPC.1"     "NPC.2"     "NPC.3"     "NPC.4"     "Neurons.5" "Neurons.6"

state <- do.call("rbind", strsplit(colnames(dat), ".", fixed = TRUE))[,1]
```

## 2.1: Predict developmental time

In the simplest case, one can predict developmental time with respect to the full Allen Brain Atlas dataset by providing `predict_time`. It has been shown across multiple studies that neurons derived in-vitro primarily recapitulate prenatal development. Therefore we’ve provided additional flexibility in `predict_time` to obtain higher resolution within this prenatal window. This is done by restricting the analysis to samples within the Allen Brain Atlas that come from a given class of data. You can see which datasets that we’ve precomputed using `availabledatasets`.

```
#availabledatasets()
```

Let’s start with the default settings which will use all of the available samples to perform the temoral prediction.

```
time <- predict_time(dat,  minage = 8, maxage = 40)
```

`PlotPred` will show the predictions overlaid on top of predictions against the Allen Brain Atlas reference set (aba) to show how the model performs on the starting dataset. This plot enables the user to have an intuitive understanding of how the model is performing

```
PlotPred(time)
```

![](data:image/png;base64...)

As we can see, using all samples, the prediction is linear across all timepoints. As with most in vitro studies of neurons, our samples are clustering with the prenatal samples. Although our model is good at predicting time over all ages, there is the issue that the prenatal samples are predicted within a small window of each other. To provide higher resolution within this time period lets restrict the analysis to use only prenatal samples in the prediction.

If we select “prenatal” this will restrict the predictions to only those samples that are < 40 weeks post-conception.

```
#time <- predict_time(dat,dataset = "prenatal")
#PlotPred(time)
```

Now we can see that the model has higher resolution within the prenatal timepoints. Note that this model should not be used for postnatal samples, as (conversely to the default model) it has a reduced ability to resolve differences between postnatal timepoints.

Now that we have a model that is useful for examining samples with respect to prenatal development, lets compare the NPCs to the Neurons.

```
#time2 <- data.frame(pred_age = time@pred_age, state)
#time2$state <- factor(time2$state, c("NPC","Neurons"))

#ggplot(time2, aes(state,pred_age))+
#  geom_boxplot()+
#  ylab("Predicted time, weeks post-conception")+
#  labs(title = "predicted developmental time,\ndataset = prenatal")
```

As expected the neural progenitor cells are predicted to be younger in developmental time than the neurons. In the manuscript associated with this package there are additional examples of predicting developmental time on post-mortem and in vitro-derived neurons showing the utility of `predict_time` across datasets and types.

There are additional options in `predict_time` that allow the user to further refine their analysis.

predict\_time arguments:

* dat: A normalized expression matrix where columns are samples, and rows are genes defined by Gene Symbol.
* dataset: If desired, the user can work from a pre-computed model. Use `availabledatasets` to see what options are available. default = “all”.
* genelist: If you would like to restrict the predictions to a certain subset of genes you can retain your full dataset in the argument `dat` and input the restricted gene list here.
* minage: Minimum weeks post-conception for running the prediction.
* maxage: Maximum weeks post-conception for running the prediction.
* tissue: Tissue of interest to restrict the dataset to.
* minrsq: (0-1). `minrsq` is correlated with the predictive strength of the model. Reduce the value to allow weaker models to be calculated.

Using these additional options we have more flexibility in our predictions. For example, let’s say that we have generated neurons that we expect to be functionally similar to the adult amygdala and therefore would prefer a model that most closely represents that profile. We can set `minage` to 40 and `tissue` to AMY and recalculate our predictions.

```
#time <- predict_time(dat,minage = 40, tissue = "AMY")
```