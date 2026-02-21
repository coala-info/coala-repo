[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinksGUI/)](index.html)

* [Introduction](index.html)
* [Data](data.html)
* [Analysis](analysis.html)
* [Integrative analysis](integrative.html)
* [Case Study](Cases.html)

* + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
  + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Université libre de Bruxelles (ULB)
  + [mlg.ulb.ac.be](http://mlg.ulb.ac.be/)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [Belgian FNRS PDR T100914F](http://mlg.ulb.ac.be/GENGISCAN)
  + [BridgeIRIS](http://mlg.ulb.ac.be/BridgeIRIS)

# 1 Detailed explanation

For a detailed manual for this section please access these links:

1. [Starburst menu manual](https://drive.google.com/open?id=0B0-8N2fjttG-RzU1T1VQU2dQcXM)
2. [ELMER menu manual](https://drive.google.com/open?id=0B0-8N2fjttG-TDg1czNPUGUwTG8)

# 2 Menu: Starburst plot

![Starburst plot menu: Main window.](data:image/png;base64...)

## 2.1 Data

Expected input is a CSV file with the following pattern:

* DEA result: DEA\_results\_Group\_subgruop1\_subgroup2\_pcut\_0.01\_logFC.cut\_2.csv
* DMR result: DMR\_results\_Group\_subgruop1\_subgroup2\_pcut\_1e-30\_meancut\_0.55.csv

## 2.2 Thresholds control

The possible thresholds controls are:

* Log FC threshold: gene expression Log2FC threshold
* Expression FDR cut-off: gene expression FDR cut-off (y-axis)
* Mean DNA methylation difference threshold: Mean DNA methylation difference threshold
* Methylation FDR cut-off: DNA methylation FDR cut-off (x-axis)

The options Mean DNA methylation difference threshold and Log FC threshold are used to circle genes which pass the cut-offs previously defined (eg. mean methylation or FDR).

## 2.3 Highlight control

The possible highlight controls are:

* Show gene names: show names of significant genes
* Boxed names: show names inside a box
* Circle genes: Circle candidate biologically significant genes

## 2.4 Other option

* Save result: save results in a CSV file

## 2.5 Tutorial video:

[![IMAGE ALT TEXT](data:image/jpeg;base64...)](http://www.youtube.com/watch?v=_ec6Sij4MBc "Tutorial video: Integrating DMR analysis and DEA results to be visualized into a starburst plot - (http://www.youtube.com/watch?v=_ec6Sij4MBc)")

**Tutorial Video:** Integrating DMR analysis and DEA results to be visualized into a starburst plot - (<http://www.youtube.com/watch?v=_ec6Sij4MBc>)

# 3 Menu: ELMER (Enhancer Linking by Methylation/Expression Relationship)

This sub-menu will help the user to perform an integrative analysis of DNA methylation and Gene expression using the R/Bioconductor ELMER package (L Yao et al. 2015).

## 3.1 Introduction

Recently, many studies suggest that enhancers play a major role as regulators of cell-specific phenotypes leading to alteration in transcriptomes related to diseases (Giorgio et al. 2015; Gröschel et al. 2014; Sur et al. 2012; Lijing Yao, Berman, and Farnham 2015). In order to investigate regulatory enhancers that can be located at long distances upstream or downstream of target genes Bioconductor offer the [Enhancer Linking by Methylation/Expression Relationship (ELMER)](http://bioconductor.org/packages/ELMER/) package. This package is designed to combine DNA methylation and gene expression data from human tissues to infer multi-level cis-regulatory networks. It uses DNA methylation to identify enhancers and correlates their state with the expression of nearby genes to identify one or more transcriptional targets. Transcription factor (TF) binding site analysis of enhancers is coupled with expression analysis of all TFs to infer upstream regulators. This package can be easily applied to TCGA public available cancer datasets and custom DNA methylation and gene expression datasets (L Yao et al. 2015).

[ELMER](http://bioconductor.org/packages/ELMER/) analysis have 5 main steps:

1. Identify distal probes on HM450K or EPIC.
2. Identification of distal probes with significant differential DNA methylation (i.e. DMCs) in tumor vs. normal samples.
3. Identification of putative target gene(s) for differentially methylated distal probes.
4. Identification of enriched motifs within a set of probes in significant probe-gene pairs.
5. Identification of master regulator Transcription Factors (TF) for each enriched motif.

## 3.2 Sub-menu ELMER: Create input data

The [ELMER](http://bioconductor.org/packages/ELMER/) input is a mee object that contains a DNA methylation matrix, a gene expression matrix, a probe information GRanges, the gene information GRanges and a data frame summarizing the data. It should be highlighted that samples without both the gene expression and DNA methylation data will be removed from the mee object.

To perform ELMER analyses, we need to populate a **MultiAssayExperiment** with a DNA methylation matrix or **SummarizedExperiment** object from HM450K or EPIC platform; a gene expression matrix or SummarizedExperiment object for the same samples; a matrix mapping DNA methylation samples to gene expression samples; and a matrix with sample metadata (i.e. clinical data, molecular subtype, etc.). If TCGA data are used, the last two matrices will be automatically generated. If using non-TCGA data, the matrix with sample metadata should be provided with at least a column with a patient identifier and another one identifying its group which will be used for analysis, if samples in the methylation and expression matrices are not ordered and with same names, a matrix mapping for each patient identifier their DNA methylation samples and their gene expression samples should be provided to the *createMAE* function. Based on the genome of reference selected, metadata for the DNA methylation probes, such as genomic coordinates, will be added from <http://zwdzwd.github.io/InfiniumAnnotation> (Zhou, Laird, and Shen 2016); and metadata for gene expression and annotation is added from Ensembl database (Yates et al. 2015) using [biomaRt](http://bioconductor.org/packages/biomaRt/) (Durinck et al. 2009).

The steps required to create this object and perform ELMER analysis is described in this [tutorial](https://bioinformaticsfmrp.github.io/Bioc2017.TCGAbiolinks.ELMER/analysis_gui.html).

### 3.2.1 Sub-menu ELMER: Analysis

After preparing the data into a MAE object, we will execute the five [ELMER](http://bioconductor.org/packages/ELMER/) steps for the hypo (distal probes hypomethylated in the group2) direction.

This box has all the available options for ELMER functions. Please see the [ELMER vignette](http://bioconductor.org/packages/3.7/bioc/vignettes/ELMER/inst/doc/index.html).

Also, a description of the data used by ELMER (such as the distal enhancer probes) is found in the [ELMER.data](https://bioconductor.org/packages/release/data/experiment/vignettes/ELMER.data/inst/doc/vignettes.html) vignette.

ELMER Identifies the enriched motifs for the distal probes which are significantly differentially methylated and linked to a putative target gene, it will plot the Odds Ratio (x axis) for each motif found. These motifs by default have a minimum incidence of 10 probes (that means at least 10 probes were associated with the motif) in the given probes set and the smallest lower boundary of 95% confidence interval for Odds Ratio of 1.1.

After finding the enriched motifs, [ELMER](http://bioconductor.org/packages/ELMER/) identifies regulatory transcription factors (TFs) whose expression is associated with DNA methylation at motifs. [ELMER](http://bioconductor.org/packages/ELMER/) automatically creates a TF ranking plot for each enriched motif. This plot shows the TF ranking plots based on the association score ( − *l**o**g*(*P**v**a**l**u**e*)) between TF expression and DNA methylation of the motif. We can see in Figure below that the top three TFs that are associated with a motif found.

In case, it identifies regulatory transcription factors (TFs), an object with the prefix ELMER\_results will be created with the necessary data to visualize the results.

## 3.3 Sub-menu ELMER: Visualize results

### 3.3.1 Data

Select the R object (rda) file with ELMER results created in the analysis step (the one with prefix ELMER\_results)

# References

Durinck, Steffen, Paul T Spellman, Ewan Birney, and Wolfgang Huber. 2009. “Mapping Identifiers for the Integration of Genomic Datasets with the R/Bioconductor Package biomaRt.” *Nature Protocols* 4 (8). Nature Publishing Group:1184–91.

Giorgio, Elisa, Daniel Robyr, Malte Spielmann, Enza Ferrero, Eleonora Di Gregorio, Daniele Imperiale, Giovanna Vaula, et al. 2015. “A Large Genomic Deletion Leads to Enhancer Adoption by the Lamin B1 Gene: A Second Path to Autosomal Dominant Leukodystrophy (Adld).” *Human Molecular Genetics*. Oxford Univ Press, ddv065.

Gröschel, Stefan, Mathijs A Sanders, Remco Hoogenboezem, Elzo de Wit, Britta AM Bouwman, Claudia Erpelinck, Vincent HJ van der Velden, et al. 2014. “A Single Oncogenic Enhancer Rearrangement Causes Concomitant Evi1 and Gata2 Deregulation in Leukemia.” *Cell* 157 (2). Elsevier:369–81.

Sur, Inderpreet Kaur, Outi Hallikas, Anna Vähärautio, Jian Yan, Mikko Turunen, Martin Enge, Minna Taipale, Auli Karhu, Lauri A Aaltonen, and Jussi Taipale. 2012. “Mice Lacking a Myc Enhancer That Includes Human Snp Rs6983267 Are Resistant to Intestinal Tumors.” *Science* 338 (6112). American Association for the Advancement of Science:1360–3.

Yao, Lijing, Benjamin P Berman, and Peggy J Farnham. 2015. “Demystifying the Secret Mission of Enhancers: Linking Distal Regulatory Elements to Target Genes.” *Critical Reviews in Biochemistry and Molecular Biology* 50 (6). Taylor & Francis:550–73.

Yao, L, H Shen, PW Laird, PJ Farnham, and BP Berman. 2015. “Inferring Regulatory Element Landscapes and Transcription Factor Networks from Cancer Methylomes.” *Genome Biology* 16 (1):105–5.

Yates, Andrew, Wasiu Akanni, M Ridwan Amode, Daniel Barrell, Konstantinos Billis, Denise Carvalho-Silva, Carla Cummins, et al. 2015. “Ensembl 2016.” *Nucleic Acids Research*. Oxford Univ Press, gkv1157.

Zhou, Wanding, Peter W Laird, and Hui Shen. 2016. “Comprehensive Characterization, Annotation and Innovative Use of Infinium Dna Methylation Beadchip Probes.” *Nucleic Acids Research*. Oxford Univ Press, gkw967.