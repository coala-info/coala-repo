[ELMER](index.html)

* [Introduction](index.html)
* [Data input](input.html)
* Analysis
  + Analysis steps
  + [1 - Creating MAE with distal probes (data input)](analysis_data_input.html)
  + [2 - Identifying differentially methylated probes](analysis_diff_meth.html)
  + [3 - Identifying putative probe-gene pairs](analysis_get_pair.html)
  + [4 - Motif enrichment analysis on the selected probes](analysis_motif_enrichment.html)
  + [5 - Identifying regulatory TFs](analysis_regulatory_tf.html)
  + Compact version with TCGA data
  + [TCGA pipe](pipe.html)
* Plots
  + Plot functions
  + [1 - Scatter plots](plots_scatter.html)
  + [2 - Schematic plots](plots_schematic.html)
  + [3 - Motif enrichment plots](plots_motif_enrichment.html)
  + [4 - Regulatory TF plots](plots_TF.html)
  + [5 - Heatmap plots](plots_heatmap.html)
* [Graphical User interface](analysis_gui.html)
* [Use case](usecase.html)

* + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
  + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
* + Cedars-sinai
  + [center4bfg](https://twitter.com/center4bfg)
  + [center4bfg.org](https://center4bfg.org)
  + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [NCI ITCR program (1U01CA184826)](https://itcr.nci.nih.gov/)
  + [Genomic Data Analysis Network NIH/NCI (1U24CA210969)](https://projectreporter.nih.gov/project_info_description.cfm?aid=9210719&icde=31197242&ddparam=&ddvalue=&ddsub=&cr=1&csb=default&cs=ASC)

# 3.2 - Identifying differentially methylated probes

# Identifying differentially methylated probes

The first step is the identification of differentially methylated CpGs (DMCs) carried out by function `get.diff.meth`.

In the `Supervised` mode, we compare the DNA methylation level of each distal CpG for all samples in Group 1 compared to all samples Group 2, using an unpaired one-tailed t-test. In the `Unsupervised` mode, the samples of each group (Group 1 and Group 2) are ranked by their DNA methylation beta values for the given probe, and those samples in the lower quintile (20% samples with the lowest methylation levels) of each group are used to identify if the probe is hypomethylated in Group 1 compared to Group 2. The reverse applies for the identification of hypermethylated probes. It is important to highlight that in the `Unsupervised` mode, each probe selected may be based on a different subset the samples, and thus probe sets from multiple molecular subtypes may be represented. In the `Supervised` mode, all tests are based on the same set of samples.

The 20% is a parameter to the `diff.meth` function called `minSubgroupFrac`. For the unsupervised analysis, this is set to 20% as in Yao et al. (Yao and others 2015), because we wanted to be able to detect a specific molecular subtype among samples; these subtypes often make up only a minority of samples, and 20% was chosen as a lower bound for the purposes of statistical power (high enough sample numbers to yield t-test p-values that could overcome multiple hypotheses corrections, yet low enough to be able to capture changes in individual molecular subtypes occurring in 20% or more of the cases.) This number can be set as an input to the `diff.meth` function and should be tuned based on sample sizes in individual studies. In the `Supervised` mode, where the comparison groups are implicit in the sample set and labeled, the `minSubgroupFrac` parameter is set to 100%. An example would be a cell culture experiment with 5 replicates of the untreated cell line, and another 5 replicates that include an experimental treatment.

To identify hypomethylated DMCs, a one-tailed t-test is used to rule out the null hypothesis: *μ**g**r**o**u**p*1 ≥ *μ**g**r**o**u**p*2, where *μ**g**r**o**u**p*1 is the mean methylation within the lowest group 1 quintile (or another percentile as specified by the `minSubgroupFrac` parameter) and *μ**g**r**o**u**p*2 is the mean within the lowest group 2 quintile. Raw p-values are adjusted for multiple hypothesis testing using the Benjamini-Hochberg method, and probes are selected when they had adjusted p-value less than 0.01 (which can be configured using the `pvalue` parameter). For additional stringency, probes are only selected if the methylation difference: *Δ* = *μ**g**r**o**u**p*1 − *μ**g**r**o**u**p*2 was greater than 0.3. The same method is used to identify hypermethylated DMCs, except we use the *upper* quintile, and the opposite tail in the t-test is chosen.

![Source: Yao, Lijing, et al. “Inferring regulatory element landscapes and transcription factor networks from cancer methylomes.” Genome biology 16.1 (2015): 105.](data:image/jpeg;base64...) (Yao and others 2015, @yao2015demystifying)

# Function arguments

Main get.diff.meth arguments

| Argument | Description |
| --- | --- |
| data | A `multiAssayExperiment` with DNA methylation and Gene Expression data. See `createMAE` function. |
| diff.dir | A character can be “hypo”, “hyper” or “both”, showing differential methylation dirction. It can be “hypo” which is only selecting hypomethylated probes (one tailed test); “hyper” which is only selecting hypermethylated probes (one tailed test); or “both” which are probes differenly methylated (two tailed test). |
| minSubgroupFrac | A number ranging from 0 to 1,specifying the fraction of extreme samples from group 1 and group 2 that are used to identify the differential DNA methylation. The default is 0.2 because we typically want to be able to detect a specific (possibly unknown) molecular subtype among tumor; these subtypes often make up only a minority of samples, and 20% was chosen as a lower bound for the purposes of statistical power. If you are using pre-defined group labels, such as treated replicates vs. untreated replicated, use a value of 1.0 (***Supervised*** mode) |
| pvalue | A number specifies the significant P value (adjusted P value by BH) cutoff for selecting significant hypo/hyper-methylated probes. Default is 0.01 |
| group.col | A column defining the groups of the sample. You can view the available columns using: `colnames(MultiAssayExperiment::colData(data))`. |
| group1 | A group from group.col. ELMER will run group1 vs group2. That means, if direction is hyper, get probes hypermethylated in group 1 compared to group 2. |
| group2 | A group from group.col. ELMER will run group1 vs group2. That means, if direction is hyper, get probes hypermethylated in group 1 compared to group 2. |
| sig.dif | A number specifies the smallest DNA methylation difference as a cutoff for selecting significant hypo/hyper-methylated probes. Default is 0.3. |

# Example of use

```
mae <- get(load("mae.rda"))

sig.diff <- get.diff.meth(
  data = mae,
  group.col = "definition",
  group1 =  "Primary solid Tumor",
  group2 = "Solid Tissue Normal",
  minSubgroupFrac = 0.2, # if supervised mode set to 1
  sig.dif = 0.3,
  diff.dir = "hypo", # Search for hypomethylated probes in group 1
  cores = 1,
  dir.out ="result",
  pvalue = 0.01
)
```

```
head(sig.diff)  %>% datatable(options = list(scrollX = TRUE))
```

```
# get.diff.meth automatically save output files.
# - getMethdiff.hypo.probes.csv contains statistics for all the probes.
# - getMethdiff.hypo.probes.significant.csv contains only the significant probes which
# is the same with sig.diff
# - a volcano plot with the diff mean and significance levels
dir(path = "result", pattern = "getMethdiff")
```

```
## [1] "getMethdiff.hypo.probes.csv"
## [2] "getMethdiff.hypo.probes.significant.csv"
```

![](data:image/png;base64...)

# Bibliography

Yao, Lijing, Benjamin P Berman, and Peggy J Farnham. 2015. “Demystifying the Secret Mission of Enhancers: Linking Distal Regulatory Elements to Target Genes.” *Critical Reviews in Biochemistry and Molecular Biology* 50 (6): 550–73.

Yao, Lijing, and others. 2015. “Inferring Regulatory Element Landscapes and Transcription Factor Networks from Cancer Methylomes.” *Genome Biology* 16 (1): 105.