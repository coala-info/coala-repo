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

1. [Clinical analysis menu manual](https://drive.google.com/drive/folders/0B0-8N2fjttG-U1dyZ2g2VEhFXzQ?usp=sharing)
2. [Epigenetics analysis menu manual](https://drive.google.com/drive/folders/0B0-8N2fjttG-N3k0SWZua1RGTW8?usp=sharing)
3. [Transcriptomic analysis menu manual](https://drive.google.com/drive/folders/0B0-8N2fjttG-cGF3SkFac2lueFk?usp=sharing)
4. [Genomic analysis menu manual](https://drive.google.com/drive/folders/0B0-8N2fjttG-TEx6MjBfY0p4dE0?usp=sharing)

# 2 Menu: Clinical analysis

## 2.1 Sub-menu: Survival plot

Users can access the clinical data download in the TCGA data menu to verify the survival of different groups.

![Survival plot menu: Main window.](data:image/png;base64...)

### 2.1.1 Data

A CSV or R object (rda) file with the clinical information.

### 2.1.2 Parameters

* Group column: Select the column that identifies the group of each sample.
* Legend text: Text of the legend.
* Title: Title text.
* x-axis limit: Limits the x-axis. If 0, no cut-off is considered.
* Add p-value: Add p-value to the plot.

### 2.1.3 Size control

Changes the size of the plot

# 3 Menu: Manage summarized Experiment object

To facilitate visualization and modification of the SummarizedExperiment object, we created this menu in which it is possible to visualize the three matrices of the object (assay matrix [i.e. gene expresssion values], features matrix [i.e. gene information] and sample information matrix). Also, it is possible to download the sample information matrix as a CSV file, and, after modifying it, to upload and update the SummarizedExperiment object. This might be useful if for example the user wants to compare two groups not already pre-defined.

[![IMAGE ALT TEXT](data:image/jpeg;base64...)](http://www.youtube.com/watch?v=54rP_yZlpQs "Tutorial Video: Managing a SummarizedExperiment object - (http://www.youtube.com/watch?v=54NBug9ycwM)")

**Tutorial Video:** Managing a SummarizedExperiment object - (<http://www.youtube.com/watch?v=54NBug9ycwM>)

# 4 Menu: Epigenetic analysis

## 4.1 Sub-menu: Differential methylation analysis

The user will be able to perform a Differential methylation regions (DMR) analysis. The output will be a file with the following pattern: DMR\_results\_GroupCol\_group1\_group2\_pcut\_1e-30\_meancut\_0.55.csv Also, the summarized Experiment will be saved with all the results inside it and the new object will be saved with \_result suffix.

Obs: Depending on the number of samples and the number of probes of interest, this analysis can last anywhere from minutes to days. Duration of the analysis also depends on the type of machine and hardware on which it is run.

![Differential methylation analysis menu: Main window.](data:image/png;base64...)

Differential methylation analysis menu: Main window.

### 4.1.1 Data

Select a summarized Experiment object (rda)

### 4.1.2 Parameters control

* Cores: Selects the number of cores to be used in the analysis
* DNA methylation threshold: minimum difference of DNA methylation levels to be considered as hyper/hypomethylated
* P-value adj cut-off: minimum adjusted P-value to be considered as significant.
* Group column: columns with the groups to be used in the analysis
* Groups: Select at least two groups for analysis. For example if it has three groups (g1, g2 and g3) the analysis will output g1 vs g2, g1 vs g3 and g2 vs g3.

## 4.2 Sub-menu: Volcano plot

In this sub-menu the user will be able to plot the results from the Differentially methylated regions (DMR) analysis and the differential expression analysis (DEA).

![Volcano plot menu: Main window.](data:image/png;base64...)

Volcano plot menu: Main window.

### 4.2.1 Data

Expected input a CSV file with the following pattern:

* For expression: DEA\_results\_Group\_subgruop1\_subgroup2\_pcut\_0.01\_logFC.cut\_2.csv
* For DNA methylation: DMR\_results\_Group\_subgruop1\_subgroup2\_pcut\_1e-30\_meancut\_0.55.csv

### 4.2.2 Volcano options

This box will control the x-axis thresholds “Log FC threshold” for expression and “DNA methylation threshold” for DNA methylation and the y-axis thresholds “P-value adj cut-off”.

### 4.2.3 Highlighting options

Checkbox option:

* Show names: Shows the names of up/down regulated genes or hypo/hyper methylated probes
* Boxed names: Put names inside a box. To highlight specific genes/probes consider using the “Highlighting option.”

The option “points to highlight” can perform the following functions:

* Highlighted - Shows the names for only the highlighted genes/probes list
* Significant - Shows the names for only the up/down regulated genes or hypo/hyper methylated probes
* Both - Shows both groups

### 4.2.4 Color control

Change the color of the plot

### 4.2.5 Size control

Change the size of the plot

### 4.2.6 Other

* Save file with results: Create a file with the same pattern as the one in the input, but with the new thresholds.

## 4.3 Sub-menu: Mean DNA methylation plot

In this sub-menu the user will be able to plot the mean DNA methylation by groups.

![Mean DNA methylation plot menu: Main window.](data:image/png;base64...)

Mean DNA methylation plot menu: Main window.

### 4.3.1 Data

Expected input is an R object (rda) file with a summarized Experiment object.

### 4.3.2 Parameters control

* Groups column: Select the column that will split the data into groups. This column is selected from the sample matrix (accessed with colData)
* Subgroups column: Select the column that will highlight the different subgroups data in the groups.
* Plot jitters: Show jitters
* Select y limits: Set lower/upper limits for y
* Sort method: Methods to sort the groups in the plot
* x-axis label angle: Change angle of the text in the x-axis

### 4.3.3 Size control

Change the size of the plot

# 5 Menu: Transcriptomic analysis

In this sub-menu the user will be able to perform a gene ontology enrichment analysis for the following processes: biological, cellular component, and molecular function. In addition, a network analysis for the groups of genes will be performed.

## 5.1 Sub-menu: Differential expression analysis

### 5.1.1 Gene expression object box

Select a summarized Experiment object (rda)

### 5.1.2 Normalization of genes

Using the `TCGAanalyze_Normalization` function you can normalize mRNA transcripts and miRNA, using EDASeq package. This function uses Within-lane normalization procedures to adjust for GC-content effect (or other gene-level effects) on read counts: loess robust local regression, global-scaling, and full-quantile normalization (Risso et al. 2011) and between-lane normalization procedures to adjust for distributional differences between lanes (e.g., sequencing depth): global-scaling and full-quantile normalization (Bullard et al. 2010).

* Normalization of genes?
* Normalization of genes method? Options: gcContent, geneLength

### 5.1.3 Quantile filter of genes

* Quantile filter of genes?
* DEA test method: quantile, varFilter, filter1, filter2
* Threshold selected as mean for filtering

### 5.1.4 DEA analysis

* Log FC threshold: Log2FoldChange threshold
* P-value adj cut-off: significant threshold
* Group column: group column in the summarized Experiment object
* Group 1: Group 1 for comparison
* Group 2: Group 2 for comparison
* DEA test method: options glmRT, exactTest

After the analysis is completed, the results will be saved into a CSV file. The **Delta** column shown in the results is:
*δ* = |*l**o**g**F**C*| × |*m**e**a**n*(*g**r**o**u**p*1) − *m**e**a**n*(*g**r**o**u**p*2)|
. ![Results DEA](data:image/png;base64...)

### 5.1.5 Pathway graphs

* DEA result: Select CSV file create by the analysis.
* Pathway ID: plot results in a pathway graphs. See bioconductor [Pathview](http://bioconductor.org/packages/pathview/) (Luo and Brouwer 2013) package.

![Pathway graphs output.](data:image/png;base64...)

Pathway graphs output.

[![IMAGE ALT TEXT](data:image/jpeg;base64...)](http://www.youtube.com/watch?v=MtEVe7_ULlQ "Tutorial video: Visualizing DEA results using pathview graphs - (http://www.youtube.com/watch?v=MtEVe7_ULlQ)")

**Tutorial Video:** Visualizing DEA results using pathview graphs - (<http://www.youtube.com/watch?v=MtEVe7_ULlQ>)

## 5.2 Sub-menu: Heatmap plot

![Heatmap plot menu: Main window.](data:image/png;base64...)

Heatmap plot menu: Main window.

### 5.2.1 Data

* Select R object (rda) file: Should receive a summarized Experiment object
* Results file: Should receive the output from the DEA or DMR analysis.

DEA result file should have the following pattern: DEA\_result\_groupCol\_group1\_group2\_pcut\_0.05\_logFC.cut\_0.csv DMR result file should have the following pattern: DMR\_results\_groupCol\_group1\_group2\_pcut\_0.05\_meancut\_0.3.csv

### 5.2.2 Genes/Probes selection

* By status: Based on the results file the user can select to see hyper/hypo methylated probes
* Text: The user can write a list of genes separated by “;” , “,” or a new line

### 5.2.3 Annotation options

* Columns annotation: using the data in the summarized experiment the user can annotate the heatmap.
* Sort by column: The order of the columns can be sorted by one of the selected columns
* Row annotation: Add annotation to rows

### 5.2.4 Other options

* Scale data: option “none”, “by row”,“column”
* Cluster rows
* Cluster columns
* Show row names
* Show col names

### 5.2.5 Size control

Change the size of the plot and the number of bars to plot

### 5.2.6 Sub-menu: Enrichment analysis

To better understand the underlying biological processes, researchers often retrieve a functional profile of a set of genes that might have an important role. This can be done by performing an enrichment analysis.

Given a set of genes that are up-regulated under certain conditions, an enrichment analysis will identify classes of genes or proteins that are over or under-represented using gene set annotations.

![Enrichment analysis menu: Main window.](data:image/png;base64...)

Enrichment analysis menu: Main window.

### 5.2.7 Gene selection

Input a list of genes by:

* Selection: The user can select by hand multiple genes from a list
* Text: the user can write a list of genes separated by “;” , “,” or a new line
* File: select a file (rda, CSV, txt) with a column Gene\_symbol or mRNA

### 5.2.8 Parameter control

* Size of the text
* x upper limit: x-axis upper limit. If 0 no limit is used.
* Number of bar histograms to show: Maximum number of bars to plot

### 5.2.9 Plot selection

* Plot Biological Process
* Plot Cellular Component
* Plot Molecular Function
* Plot Pathways

### 5.2.10 Colors control

Change the color of the plot

### 5.2.11 Size control

Change the size of the plot and the number of bars to plot

### 5.2.12 Sub-menu: Network inference

Inference of gene regulatory networks. Starting with the set of differentially expressed genes, we infer gene regulatory networks using the following state-of-the art inference algorithms: ARACNE(Margolin, Nemenman, and al 2006), CLR(Faith et al. 2007), MRNET(Meyer et al. 2007) and C3NET(Altay and Emmert-Streib 2010). These methods are based on mutual inference and use different heuristics to infer the edges in the network. These methods have been made available via Bioconductor/CRAN packages (MINET(Meyer, Lafitte, and Bontempi 2008) and c3net(Altay and Emmert-Streib 2010), respectively).

# 6 Menu: Genomic analysis

## 6.1 Sub-menu: Oncoprint

Using the oncoPrint function from the [ComplexHeatmap](http://bioconductor.org/packages/ComplexHeatmap/) package, this sub-menu offers a way to visualize multiple genomic alterations.

![Oncoprint plot menu: Main window.](data:image/png;base64...)

Oncoprint plot menu: Main window.

[![IMAGE ALT TEXT](data:image/jpeg;base64...)](http://www.youtube.com/watch?v=cp1AwT8Ogmg "Tutorial video: Download Mutation Annotation files (MAF) and visualize through an oncoprint plot - (http://www.youtube.com/watch?v=cp1AwT8Ogmg)")

**Tutorial Video:** Download Mutation Annotation files (MAF) and visualize through an oncoprint plot - (<http://www.youtube.com/watch?v=cp1AwT8Ogmg>)

### 6.1.1 Data

* Select MAF file: Select a MAF file (.rda) with mutation annotation information
* Select annotation file: Select an R object (rda) with the metadata information. Columns labeled “patient” or “bcr\_patient\_barcode” should exist.
* Annotation columns: Which columns of the annotation file should be visible?
* Annotation position: Location of the annotation (e.g. Top or bottom).

### 6.1.2 Gene selection

* Selection: The user can select multiple genes from a list
* Text: The user can write a list of genes separated by “;” , “,” or a new line
* File: Select a file (rda, CSV, txt) with a column Gene\_symbol or mRNA

### 6.1.3 Parameters control

* Remove empty columns? If a sample has no mutation, it will be removed from the plot
* Show column names? Show patient barcodes?
* Show barplot annotation on rows? Show right barplot?

# 7 Menu: Classifier

## 7.1 Sub-menu: Glioma classifier

In this menu, users can select ther processed DNA methylation data from glioma samples and classify them into molecular subtypes as defined by Ceccareli et al. (Ceccarelli et al. 2016) using a RandomForest trained model from the DNA methylation signatures available at (<https://tcga-data.nci.nih.gov/docs/publications/lgggbm_2015/>).

![Glioma classifier menu: Predicting molecular subtypes based on DNA methylation using data from GEO (accession GSE61160).](data:image/png;base64...)

Glioma classifier menu: Predicting molecular subtypes based on DNA methylation using data from GEO (accession GSE61160).

For a detailed manual for this section please access this link: [IDAT processing and glioma classifier](https://drive.google.com/open?id=1UWeKrZ9HMxEOwRjLJ_Y0-c1O6SksjxVU)

# References

Altay, Gökmen, and Frank Emmert-Streib. 2010. “Inferring the Conservative Causal Core of Gene Regulatory Networks.” *BMC Systems Biology* 4 (1). BioMed Central Ltd:132.

Bullard, James H, Elizabeth Purdom, Kasper D Hansen, and Sandrine Dudoit. 2010. “Evaluation of Statistical Methods for Normalization and Differential Expression in mRNA-Seq Experiments.” *BMC Bioinformatics* 11 (1). BioMed Central Ltd:94.

Ceccarelli, Michele, FlorisP. Barthel, TathianeM. Malta, ThaisS. Sabedot, SofieR. Salama, BradleyA. Murray, Olena Morozova, et al. 2016. “Molecular Profiling Reveals Biologically Discrete Subsets and Pathways of Progression in Diffuse Glioma.” *Cell* 164 (3):550–63. [https://doi.org/http://dx.doi.org/10.1016/j.cell.2015.12.028](https://doi.org/http%3A//dx.doi.org/10.1016/j.cell.2015.12.028).

Faith, Jeremiah J, Boris Hayete, Joshua T Thaden, Ilaria Mogno, Jamey Wierzbowski, Guillaume Cottarel, Simon Kasif, James J Collins, and Timothy S Gardner. 2007. “Large-Scale Mapping and Validation of Escherichia Coli Transcriptional Regulation from a Compendium of Expression Profiles.” *PLoS Biol* 5 (1):e8.

Luo, Weijun, and Cory Brouwer. 2013. “Pathview: An R/Bioconductor Package for Pathway-Based Data Integration and Visualization.” *Bioinformatics* 29 (14). Oxford Univ Press:1830–1.

Margolin, A.A., I. Nemenman, and K. Basso et al. 2006. “ARACNE: An Algorithm for the Reconstruction of Gene Regulatory Networks in a Mammalian Cellular Context.” *BMC Bioinformatics* 7.

Meyer, Patrick E., Frédéric Lafitte, and Gianluca Bontempi. 2008. “Minet: A R/Bioconductor Package for Inferring Large Transcriptional Networks Using Mutual Information.” *BMC Bioinformatics* 9 (1):1–10. <https://doi.org/10.1186/1471-2105-9-461>.

Meyer, Patrick E, Kevin Kontos, Frederic Lafitte, and Gianluca Bontempi. 2007. “Information-Theoretic Inference of Large Transcriptional Regulatory Networks.” *EURASIP Journal on Bioinformatics and Systems Biology* 2007. Hindawi Publishing Corp.:8–8.

Risso, Davide, Katja Schwartz, Gavin Sherlock, and Sandrine Dudoit. 2011. “GC-Content Normalization for Rna-Seq Data.” *BMC Bioinformatics* 12 (1). BioMed Central Ltd:480.