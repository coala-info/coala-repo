# Transcriptomic Intelligent Pipeline: The KnowSeq user guide ![](data:image/png;base64...)

### KnowSeq: R/Bioconductor package

#### Daniel Castillo-Secilla, Juan Manuel Galvez, Marta Verona-Almeida, Francisco Carrillo-Perez, Francisco Manuel Ortuno, Luis Javier Herrera and Ignacio Rojas

#### march, 29 of 2020

# 1 Citation

Please, use the following cite to reference KnowSeq R package within your own manuscripts or researches:

*Castillo-Secilla, D., Galvez, J. M., Carrillo-Perez, F., Verona-Almeida, M., Redondo-Sanchez, D., Ortuno, F. M., … and Rojas, I. (2021). KnowSeq R-Bioc Package: The Automatic Smart Gene Expression Tool For Retrieving Relevant Biological Knowledge. Computers in Biology and Medicine, 104387.*

# 2 Installation

To install and load KnowSeq package in R, it is necessary the previous installation of BiocManager from Bioconductor. The next code shows how this installation can be performed:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("KnowSeq")

library(KnowSeq)
```

KnowSeq is now available also on Docker by running the next command, allowing the use of KnowSeq without a previous installation:

```
Docker run -it casedugr/knowseq
```

# 3 Introduction

KnowSeq proposes a novel methodology that comprises the most relevant steps in the Transcriptomic gene expression analysis. KnowSeq expects to serve as an integrative tool that allows to process and extract relevant biomarkers, as well as to assess them through a Machine Learning approaches. Finally, the last objective of KnowSeq is the biological knowledge extraction from the biomarkers (Gene Ontology enrichment, Pathway listing and Evidences related to the addressed disease). Although the package allows analyzing all the data manually, the main strength of KnowSeq is the possibility of carrying out an automatic and intelligent HTML report that collect all the involved steps in one document. Nowadays, there is no package that only from the information of the samples to align -included in a text file-, automatically performs the download and alignment of all of the samples. Furthermore, KnowSeq is the only package that allows applying both a machine learning and biomarkers enrichment processes just after the biomarkers extraction. It is important to highlight that the pipeline is totally modular and flexible, hence it can be started from whichever of the different steps. This pipeline has been used in our previous publications for processing raw RNA-seq data and to perform the biomarkers extraction along with the machine learning classifier design steps, also for their integration with microarray data [1,2,3,4].

![](data:image/png;base64...)

The whole pipeline included in KnowSeq has been designed carefully with the purpose of achieving a great quality and robustness in each of the steps that conform the pipeline. For that, the pipeline has four fundamental processes:

* Transcriptomic RAW data processing.
* Biomarkers identification & assessment.
* DEGs enrichment methodology.
* Intelligent Automatic Report.

The first process is focused on the Transcriptomic RAW data treatment. This step has the purpose of extracting a set of count files from raw files stored in the repositories supported by our package (NCBI/GEO [5] ArrayExpress [6] and GDC-Portal). The second one englobes the Differential Expressed Genes (DEGs) identification and extraction by using a novel parameter (Specifically for multiclass studies) defined as Coverage [3], and the assessment of those DEGs by applying advanced machine learning techniques (feature selection process and supervised classification). Once the DEGs are assessed, the next step is the DEGs enrichment methodology which allows retrieving biological information from the DEGs. In this process, relevant information (such as related diseases, biological processes associated and pathways) about the DEGs is retrieved by using very well-known tools and databases. The three types of enrichment are the Gene Ontology (GO) study, the pathways visualization taking into account the gene expression, and the Evidences related to the addressed disease from the final set of DEGs. Finally, all of this information can be displayed on an automatic and intelligent HTML report that contains the results of the complete study for the faced disease or diseases.

# 4 Transcriptomic RAW data processing

## 4.1 Alignment preparation

In order to avoid version incompatibilities with hisat2 aligner and the installation of the required tools, pre-compiled versions will be used to run the R functions. Consequently, all the tools were compressed and stored in an external server to be downloaded whenever it is required (<http://iwbbio.ugr.es/utils/unixUtils.tar.gz>). If the tools are directly downloaded from the link, the compressed files must be decompressed in the current project folder in R or RStudio. The name of the resultant folder must be *“utils”*. Nevertheless, this file can be downloaded automatically by just calling the function *rawAlignment*, in case the folder utils is not detected in the project folder. This is all needed to run hisat2 through the function *rawAlignment*. It is not possible to run the alignment without the utils folder. It must be mentioned too that the different files included in the compressed *.tar.gz* are not only the aligner but also functions needed in the raw alignment process. The tools included are the following:

* Bowtie2 [7].
* Hisat2 [8].
* Htseq-count [9].
* Samtools [12].
* Sratoolkit [13].
* GDC-client.

## 4.2 Launching Raw Alignment step

The *rawAlignment* function allows running hisat2 aligner. The function takes as single input a CSV from GEO or ArrayExpress loaded in R. There is the possibility to process data from GDC-portal, but a previous authorization (token file) from this platform is required. Furthermore, there is a set of logical parameters to edit the default pipeline followed for the function. With the parameters the user can select if the BAM/SAM/Count files are created. The user can choose if wants to download the reference genome, the GTF, and which version. Even if the user has custom FASTA and GTF files, this can be specified by setting the parameter *referenceGenome* to *“custom”* and using the parameters *customFA* and *customGTF* to indicates the paths to the custom files. Other functionality is the possibility to process BAM files from the GDC Portal database by setting to *TRUE* the parameter *fromGDC*. Then the function will download the specific genome reference of GDC and process the BAM files to Count files. Furthermore, if the user has access to the controlled data, with the token and the manifest acquired from GDC Portal web platform, the samples can be downloaded automatically. An example to run the function with hisat2 aligner is showed below:

```
# Downloading one series from NCBI/GEO and one series from ArrayExpress
downloadPublicSeries(c("GSE74251"))

# Using read.csv for NCBI/GEO files (read.csv2 for ArrayExpress files)
GSE74251csv <- read.csv("ReferenceFiles/GSE74251.csv")

# Performing the alignment of the samples by using hisat2 aligner
rawAlignment(GSE74251csv,downloadRef=TRUE,downloadSamples=TRUE,BAMfiles = TRUE,
SAMfiles = TRUE,countFiles = TRUE,referenceGenome = 38, fromGDC = FALSE, customFA = "",
customGTF = "", tokenPath = "", manifest = "")
```

*RawAlignment* function creates a folder structure in the current project folder which will store all the downloaded and created files. The main folder of this structure is the folder ReferenceFiles but inside of it there are more folders that allows storing the different files used by the process in an organized way.

Another important requirement to take into account is the format of the csv file used to launch the function. It could be from three repositories, two publics (NCBI/GEO and ArrayExpress) and one controlled (GDC Portal). Each of these repositories has its own format in the csv file that contains the information to download and process the desired samples. The necessary format for each repository is explained below.

### 4.2.1 NCBI/GEO CSV format

Series belonging to RNA-seq have a SRA identifier. If this identifier is clicked, a list with the samples that conform this series is showed. Then, the desired samples of the series can be checked and the CSV is automatically generated by clicking the button shown in the image below:

![](data:image/png;base64...)

The previous selection generates a csv files that contains a number of columns with information about the samples. However, running the *rawAlignment* function only needs the three columns shown below in the csv (although the rest of the columns can be kept):

| Run | download\_path | LibraryLayout |
| --- | --- | --- |
| SRR2753177 | sra-download.ncbi.nlm.nih.gov/traces/sra21/SRR/0026… | SINGLE |
| SRR2753178 | sra-download.ncbi.nlm.nih.gov/traces/sra21/SRR/0026… | SINGLE |
| SRR2753179 | sra-download.ncbi.nlm.nih.gov/traces/sra21/SRR/0026… | SINGLE |

There is another way to obtain this csv automatically by calling the function *downloadPublicSeries* with the NCBI/GEO GSE ID of the wanted series, but this option does not let the user to choose the wanted samples and downloads all the samples of each selected series.

### 4.2.2 ArrayExpress CSV format

The process for ArrayExpress is the very similar to that for NCBI/GEO. It changes the way to download the csv and the name of the columns in the file. To download the csv there is a file finished as .sdrf.txt inside the RNA-seq series in ArrayExpress, as can be seen in the example below:

![](data:image/png;base64...)

As with the NCBI/GEO csv, the csv of ArrayExpress requires only three columns as is shown below:

| Comment[ENA\_RUN] | Comment[FASTQ\_URI] | Comment[LIBRARY\_LAYOUT] |
| --- | --- | --- |
| ERR1654640 | ftp.sra.ebi.ac.uk/vol1/fastq/ERR165/000/ERR16… | PAIRED |
| ERR1654640 | ftp.sra.ebi.ac.uk/vol1/fastq/ERR165/000/ERR16… | PAIRED |

There is another way to achieve this csv automatically by calling the function downloadPublicSeries with the ArrayExpress MTAB ID of the wanted series, but this option does not let the user to choose the wanted samples, and therefore and downloads all the samples of each selected series.

### 4.2.3 GDC Portal CSV format

GDC portal has the BAM files access restricted or controlled for the user who has access to them. However, the count files are open and can be used directly in this package as input of the function countsToMatrix. If there exist the possibility to download the controlled BAM files, the tsv file that this package uses to convert them into count files is the tsv file generated when the button Sample Sheet is clicked in the cart:

![](data:image/png;base64...)

As in the other two repositories, there are a lot of columns inside the tsv files but this package only needs two of them. Furthermore, if the BAM download is carried out by the gdc-client or the web browser, the BAM has to be moved to the path *ReferenceFiles/Samples/RNAseq/BAMFiles/Sample.ID/File.Name/* where Sample.ID and File.Name are the columns with the samples information in the tsv file. This folder is created automatically in the current project folder when the *rawAlignment* function is called, but it can be created manually. However, GDC portal has public access to count files that can be used in a posterior step of the KnowSeq pipeline to merge and analyze them.

### 4.2.4 Downloading automatically GDC Portal controlled files (GDC permission required)

It exists the possibility to download automatically the raw data from GDC portal by using the *rawAlignment* function. In order to carry this out, the function needs the parameters downloadSamples and fromGDC set to *TRUE*, the path to the token in order to obtain the authentication to download the controlled data and the path to the manifest that contains the information to download the samples. This step needs the permission of GDC portal to the controlled data.

```
# GDC portal controlled data processing with automatic raw data download

rawAlignment(x, downloadRef=TRUE, downloadSamples=TRUE, fromGDC = TRUE,
tokenPath = "~/pathToToken", manifestPath = "~/pathToManifest")
```

## 4.3 Preparing the count files

From now on, the data that will be used for the documentation are real count files, but with a limited number of genes (around 1000). Furthermore, to reduce the computational cost of this example, only 5 samples from each of the two selected series will be taken into account. Showed in the code snippet below, two RNA-seq series from NCBI/GEO are downloaded automatically and the existing count files prepared to be merged in one matrix with the purpose of preparing the data for further steps:

```
suppressMessages(library(KnowSeq))

dir <- system.file("extdata", package="KnowSeq")

# Using read.csv for NCBI/GEO files and read.csv2 for ArrayExpress files

GSE74251 <- read.csv(paste(dir,"GSE74251.csv",sep = "/"))
GSE81593 <- read.csv(paste(dir,"GSE81593.csv",sep = "/"))

# Creating the csv file with the information about the counts files location and the labels
Run <- GSE74251$Run
Path <- paste(dir,"/countFiles/",GSE74251$Run,sep = "")
Class <- rep("Tumor", length(GSE74251$Run))
GSE74251CountsInfo <-  data.frame(Run = Run, Path = Path, Class = Class)

Run <- GSE81593$Run
Path <- paste(dir,"/countFiles/",GSE81593$Run,sep = "")
Class <- rep("Control", length(GSE81593$Run))
GSE81593CountsInfo <-  data.frame(Run = Run, Path = Path, Class = Class)

mergedCountsInfo <- rbind(GSE74251CountsInfo, GSE81593CountsInfo)

write.csv(mergedCountsInfo, file = "mergedCountsInfo.csv")
```

However, the user can run a complete example by executing the following code:

```
dir <- system.file("script", package="KnowSeq")

# Code to execute the example script
source(paste(dir,"/KnowSeqExample.R",sep=""))

# Code to edit the example script
file.edit(paste(dir,"/KnowSeqExample.R",sep=""))
```

## 4.4 Processing count files

After the raw alignment step, a list of count files of the samples is available at *ReferenceFiles/Samples/RNAseq/CountFiles*. The next step in the pipeline implemented in this package is the processing of those count files in order to obtain a gene expression matrix by merging all of them.

### 4.4.1 Merging all count files

After the alignment, as many count files as samples in the CSV used for the alignment have been created. In order to prepare the data for the DEGs analysis, it is important to merge all these files in one matrix that contains the genes Ensembl ID (or other IDs) in the rows and the name of the samples in the columns. To carry this out, the function *countsToMatrix* is available. This function reads all count files and joints them in one matrix by using edgeR package [15]. To call the function it is only necessary a CSV with the information about the count files paths. The required CSV has to have the following format:

| Run | Path | Class |
| --- | --- | --- |
| SRR2753159 | ~/ReferenceFile/Count/SRR2753159/ | Tumor |
| SRR2753162 | ~/ReferenceFile/Count/SRR2753162/ | Tumor |
| SRR2827426 | ~/ReferenceFile/Count/SRR2827426/ | Healthy |
| SRR2827427 | ~/ReferenceFile/Count/SRR2827427/ | Healthy |

The column Run is the name of the sample without .count, the column Path is the Path to the count file and the Class column is the labels of the samples. Furthermore, an example of this function is shown below:

```
# Merging in one matrix all the count files indicated inside the CSV file

countsInformation <- countsToMatrix("mergedCountsInfo.csv", extension = "count")
```

```
##
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR2753159/SRR2753159.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR2753160/SRR2753160.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR2753161/SRR2753161.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR2753162/SRR2753162.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR2753163/SRR2753163.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR3541296/SRR3541296.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR3541297/SRR3541297.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR3541298/SRR3541298.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR3541299/SRR3541299.count
## /tmp/RtmpKRFxZv/Rinst125278588df899/KnowSeq/extdata/countFiles/SRR3541300/SRR3541300.count
## Merging 10 counts files...
```

```
# Exporting to independent variables the counts matrix and the labels

countsMatrix <- countsInformation$countsMatrix

labels <- countsInformation$labels
```

The function returns a list that contains the matrix with the merged counts and the labels of the samples. It is very important to store the labels in a new variable because as it will be required in several functions of KnowSeq.

### 4.4.2 Getting the annotation of the genes

This step is only required if the user wants to get the gene names and the annotation is retrieved with the information given by the ensembl webpage [16]. Normally, the counts matrix has the Ensembl Ids as gene identifier, but with this step, the Ensembl Ids are change by the gene names. However, the user can decide to keep its own annotation or the Ensembl Ids. For example, to achieve the gene names the function needs the current Ensembl Ids, and the reference Genome used would be the number 38. If the user wants a different annotation than the human annotation, the parameter *notHSapiens* has to be set to *TRUE* and the desired specie dataset from ensembl indicated in the parameter *notHumandataset* (i.e. “mm129s1svimj\_gene\_ensembl”). An example can be seen below:

```
# Downloading human annotation
myAnnotation <- getGenesAnnotation(rownames(countsMatrix))
```

```
## Getting annotation of the Homo Sapiens...
## Using reference genome 38.
```

```
# Downloading mus musculus annotation
myAnnotationMusMusculus <- getGenesAnnotation(rownames(countsMatrix),
notHSapiens = TRUE,notHumandataset = "mm129s1svimj_gene_ensembl")
```

```
## Downloading annotation mm129s1svimj_gene_ensembl...
```

```
##
## Connection error, trying again...
##
## Connection error, trying again...
```

### 4.4.3 Converting to gene expression matrix

Finally, once both the countsMatrix and the annotation are ready, it is time to convert those counts into gene expression values. For that, the function *calculateGeneExpressionValues* uses the cqn package to calculates the equivalent gene expression [17]. This function performs a conversion of counts into gene expression values, and changes the Ensembl Ids by the gene names if the parameter geneNames is equal to *TRUE*. An example of the use of this function is showed below:

```
# Calculating gene expression values matrix using the counts matrix

expressionMatrix <- calculateGeneExpressionValues(countsMatrix,myAnnotation,
genesNames = TRUE)
```

```
## Calculating gene expression values...
## RQ fit ..........
## SQN
```

```
## .
```

At this time of the pipeline, a function that plots the expression data and allows verifying if the data is well normalized can be used. This function has the purpose of joining all the important graphical representation of the pipeline in the same function and is called *dataPlot*. It is very easy to use because just by changing the parameter method many different representations can be achieved. In this case, in order to see the expression boxplot of each sample, the function has to be called with the parameter mode equal to *“boxplot”*. The labels are necessary to colour the different samples depending on the class of the samples. These colours can be selected by the user, by introducing in the parameter colours a vector with the name of the desired colours. The function also allows exporting the plots as PNG and PDF files.

```
# Plotting the boxplot of the expression of each samples for all the genes

dataPlot(expressionMatrix,labels,mode = "boxplot", toPNG = TRUE,
toPDF = TRUE)
```

```
## Creating PNG...
```

```
## Creating PDF...
```

![](data:image/png;base64...)

# 5 Biomarkers identification & assessment

## 5.1 Batch effect removal

A crucial step in this pipeline is the batch effect treatment. It is widely known that this is a crucial step in the omics data processing due to the intrinsic deviations that the data can present due to its origin, sequencing design, etc… Besides, when working with public data it is very difficult to know if exists a real batch effect among the selected datasets. This package allows removing batch effect if the batch groups are known by calling the function *batchEffectRemoval*, that makes use of sva package [18], with the parameter mode equal to *“combat”* [19]. This step allows obtaining an expression matrix with the batch effect treated by combat method. An example to do this is below:

```
# Removing batch effect by using combat and known batch groups

batchGroups <- c(1,1,1,1,2,2,1,2,1,2)

expressionMatrixCorrected <- batchEffectRemoval(expressionMatrix, labels,
batchGroups = batchGroups, method = "combat")
```

```
## Correcting batch effect by using combat method...
```

```
## Using the 'mean only' version of ComBat
```

```
## Found2batches
```

```
## Adjusting for0covariate(s) or covariate level(s)
```

```
## Standardizing Data across genes
```

```
## Fitting L/S model and finding priors
```

```
## Finding parametric adjustments
```

```
## Adjusting the Data
```

There is another method in the function that removes the batch effect that uses surrogate variable analysis or sva. The only requirement to use it is to set the parameter method equal to *“sva”*. This method returns a matrix with the batch effect corrected which has to be used as input of the function *DEGsExtraction*.

```
# Calculating the surrogate variable analysis to remove batch effect

expressionMatrixCorrected <- batchEffectRemoval(expressionMatrix, labels, method = "sva")
```

```
## Calculating sva model to batch effect correction...
## Number of significant surrogate variables is:  1
## Iteration (out of 5 ):1  2  3  4  5
```

## 5.2 Differential Expressed Genes extraction and visualization

There is a long way between the raw data and the DEGs extraction, for that in this step the samples have to have had a strong pre-processing step applied. At this point of the pipeline the DEGs existing among two or more classes will be extracted by using the novel parameter coverage (cov) along with limma R-bioc package [20]. The parameter cov represents the number of different pathologies that a certain gen is able to discern. By default, the parameter is set to *1*, so all genes that has the capability to discern among the comparison of two classes would be selected as DEGs. To understand better this parameter, our multiclass study applied to different leukemia sub-types introduces it, and it’s publicly available [3].

The function *DEGsExtraction* receives an expression matrix, the labels of the samples and the restriction imposed for considering a gene as differential expressed gene. The function returns a list containing the table with statistical values of each DEGs and the expression matrix of the DEGs instead all of the genes. The call to the function is listed below:

```
# Extracting DEGs that pass the imposed restrictions

DEGsInformation <- DEGsExtraction(expressionMatrixCorrected, labels,
lfc = 1.0, pvalue = 0.01, number = 100, cov = 1)
```

```
## Two classes detected, applying limma biclass
```

```
topTable <- DEGsInformation$DEG_Results$DEGs_Table

DEGsMatrix <- DEGsInformation$DEG_Results$DEGs_Matrix
```

DEGs are genes that have a truly different expression among the studied classes, for that it is important to try to see graphically if those DEGs comply with this requirement. In order to provide a tool to perform this task, the function dataPlot encapsulate a set of graphs that allows plotting in different ways the expression of the DEGs.

*dataPlot* function also allows representing an ordered boxplot that internally orders the samples by class and plots a boxplot for each samples and for the first top 12 DEGs in this example. With this plot, the difference at gene expression level between the classes can be seen graphically. The code to reproduce this plot is the following:

```
# Plotting the expression of the first 12 DEGs for each of the samples in an ordered way

dataPlot(DEGsMatrix[1:12,],labels,mode = "orderedBoxplot",toPNG = FALSE,toPDF = FALSE)
```

![](data:image/png;base64...)

In the previous boxplot the expression of a set of DEGs for each sample its showed, however it is interesting to see the differentiation at gene expression level for each of the top 12 genes used before separately. It is recommended to use this function with a low number of genes, because with a larger number the plot it is difficult to distinguish the information provided and R would not have enough memory to calculate the plot. For that, the function *dataPlot* with the mode *genesBoxplot* allows to do that by executing the next code:

```
# Plotting the expression of the first 12 DEGs separatelly for all the samples

dataPlot(DEGsMatrix[1:12,],labels,mode = "genesBoxplot",toPNG = FALSE,toPDF = FALSE)
```

![](data:image/png;base64...)

Finally, it is possible to plot one of the most widespread visualization methods in the literature, the heatmap. By setting the parameter method to *heatmap*, the function calculates the heatmap for the given samples and classes. The code to do this is the same than for the previous boxplot but changing the method parameter:

```
# Plotting the heatmap of the first 12 DEGs separatelly for all the samples

dataPlot(DEGsMatrix[1:12,],labels,mode = "heatmap",toPNG = FALSE,toPDF = FALSE)
```

![](data:image/png;base64...)

## 5.3 Performing the machine learning processing: classifier design and assessment and gene selection

Normally, in the literature, the last step in the pipeline for differential gene expression analysis is the DEGs extraction step. However, in this package a novel machine learning step is implemented with the purpose of giving to the user an automatic tool to assess the DEGs, and evaluate their robustness in the discernment among the studied pathologies. This library has three possible classification methodologies to take into account. These options are k-NN [21], SVM [22] and Random Forest [23], three of the most popular classifiers in the literature. Furthermore, it includes two different working procedures for each of them. The first one implements a cross-validation process, in order to assess the expected accuracy with different models and samples the DEGs with a specific number of folds. These functions return a list with 4 objects that contain the confusion matrices, the accuracy, the sensitivity and the specificity.

The second one is to assess a specific test dataset by using a classifier trained using the training dataset separately. Moreover, the function featureSelection allows performing a feature selection process by using, mRMR [24], Random Forest (as feature selector instead of classifier) or Disease Association based algorithms with the purpose of finding the best DEGs order to assess the data. Da-FS is a new novel method designed in KnowSeq with the purpose of giving to the expert a biological based feature selection method. This method makes use of targetValidation webplatform to acquire an association score for each DEGs with the required genetic disease, breast cancer in the example. This score takes values between 1 and 0, meaning 1 a total association and 0 no association. Therefore, the DEGs are sorted by this score, achieving a ranking in which in the first positions those DEGs with more biological relation to breast cancer are placed.

Moreover, targetValidation webplatform allows acquiring evidences that tie a gene with a certain disease. DA-RED-FS is a novel iterative method based on DA-FS that use these evidences to calculate the redundance between genes based on biological information. This redundances take values between 1 and 0. For example, if gene A has a redundance of 1 with gene B, means that all found evidences for gene A and a certain disease are also found in gene B and the disease. Likewise, if this redundance is 0, means that there are not any gene A evidences in gene B evidences. DA-RED-FS starts with an empty set of selected genes, \(S\_G\), and a set of possible genes \(G\). In the first step, the gene with the highest DA score is selected. In the following steps, genes that verify the following equation are added to selected genes set.

\[
max\_{g \in G - S\_G} DA(g) - \frac{\sum\_{g\_i \in S\_g} RED(g,g\_i)}{|S\_G|} \times DA(g)
\]

Where \(RED(g,g\_i)\) is the redundance between gene \(g\) and gen \(g\_i\) and \(DA(g)\) is the DA score of gene \(g\). The algorithms ends when a certain number of genes are selected, this number can be fixed by the maxGenes parameter.

To invoke these functions, it is necessary an expression matrix with the samples in the rows and the genes in the columns and the labels of the samples, the genes that will be assessed and the number of fold in the case of the cross-validation function. In the case of the test functions, it is necessary the matrix and the labels for both the training and the test datasets:

```
DEGsMatrixML <- t(DEGsMatrix)

# Feature selection process with mRMR and RF
mrmrRanking <- featureSelection(DEGsMatrixML,labels,colnames(DEGsMatrixML), mode = "mrmr")
```

```
## Calculating the ranking of the most relevant genes by using mRMR algorithm...
## mRMR ranking: BCAS1 ATP2B4 RPS17P5 CXorf56 GALC VIM SCIN ROS1 SH2D2A ETV1 AGPS SNAI2 LAMC2 GNA15 MAGEC2 EHD3 GYG2 PRSS3 FSTL4 BIRC3 ADAM22 COL17A1 CCN5 CALCR DNASE1L1 ARHGAP44 TNC DLX3 FUT8 CCDC85A CDH1 EHD2 HOXC8 PRSS21 MATK ABCB4 DKK3 YBX2 COL9A2 RIPOR3 VCAN NFIX LY75 SLC7A2 CCT8L1P ERBB3 ARSD BARX2 APPBP2 DCN CNTN1 NLRP2 APBA2 TYMP MPPED2 TENM1 PRKCQ FUZ CHDH NEXMIF PLAUR CYP26B1 E2F2 DLEC1 FAS RAI14 EPHA3 AGPAT4 RCN1 ATP2C2 GAS7 CPS1 LAMA3 ARHGAP31 PRSS8 TIMP2 DGKA PLEKHG6 TRAF1 BTN3A1 EPN3 CP PRSS22 ABCC2 ME1 NGEF SYT13 SEZ6 PLEKHB1 CYFIP2 ABCC8 ZMYND12 SPATA20 CEACAM7 DAPK2 GRAMD1B IYD PHF21B SARM1 NDC1
```

```
rfRanking <- featureSelection(DEGsMatrixML,labels,colnames(DEGsMatrixML), mode = "rf")
```

```
## Calculating the ranking of the most relevant genes by using Random Forest algorithm...
## Random Forest ranking: ARHGAP44 ZMYND12 SYT13 LY75 YBX2 HOXC8 RIPOR3 APPBP2 RPS17P5 E2F2 RAI14 NLRP2 DLEC1 LAMA3 PLAUR FUT8 FSTL4 EHD3 MPPED2 GRAMD1B FUZ TIMP2 BIRC3 FAS PRSS22 CHDH GAS7 CP BCAS1 DKK3 TRAF1 AGPAT4 MATK SH2D2A EPN3 DCN EHD2 NFIX TYMP PHF21B GALC SNAI2 PRSS8 ME1 VIM AGPS ARSD CXorf56 LAMC2 PRSS21 CYP26B1 PRKCQ COL17A1 SCIN DNASE1L1 CEACAM7 ATP2B4 SEZ6 ROS1 TNC CNTN1 DAPK2 NGEF SLC7A2 ERBB3 APBA2 SPATA20 NEXMIF EPHA3 ATP2C2 NDC1 ETV1 MAGEC2 CCN5 COL9A2 VCAN CPS1 ABCC2 BARX2 TENM1 RCN1 ARHGAP31 PLEKHG6 ADAM22 SARM1 DGKA GYG2 ABCC8 BTN3A1 CALCR CCT8L1P PLEKHB1 CDH1 IYD CCDC85A GNA15 PRSS3 DLX3 ABCB4 CYFIP2
```

```
daRanking <- featureSelection(DEGsMatrixML,labels,colnames(DEGsMatrixML), mode = "da", disease = "breast")
```

```
## Calculating ranking of biological relevant genes by using DA implementation...
## Getting annotation of the Homo Sapiens...
## Using reference genome 38.
## Obtaining scores for breast...
## Disease scores acquired successfully!
## Disease Association ranking:    BCAS1  RPS17P5     GALC      VIM     SCIN     ROS1   SH2D2A     ETV1
##        0        0        0        0        0        0        0        0
##     AGPS    SNAI2    LAMC2    GNA15   MAGEC2     EHD3     GYG2    PRSS3
##        0        0        0        0        0        0        0        0
##    FSTL4    BIRC3   ADAM22  COL17A1     CCN5    CALCR DNASE1L1 ARHGAP44
##        0        0        0        0        0        0        0        0
##      TNC     DLX3   ATP2B4  PLEKHB1     FUT8  CCDC85A     CDH1     EHD2
##        0        0        0        0        0        0        0        0
##    HOXC8   PRSS21     MATK    ABCB4     DKK3     YBX2   COL9A2   RIPOR3
##        0        0        0        0        0        0        0        0
##     VCAN     NFIX    ABCC8     LY75   SLC7A2  CCT8L1P    ERBB3     ARSD
##        0        0        0        0        0        0        0        0
##    BARX2   APPBP2      DCN    CNTN1    NLRP2  CXorf56    APBA2     TYMP
##        0        0        0        0        0        0        0        0
##    SARM1   MPPED2    TENM1    PRKCQ      FUZ     CHDH   NEXMIF    PLAUR
##        0        0        0        0        0        0        0        0
##  CYP26B1     E2F2    DLEC1      FAS    RAI14    EPHA3   AGPAT4     RCN1
##        0        0        0        0        0        0        0        0
##   ATP2C2     GAS7     CPS1    LAMA3     NDC1  CEACAM7    DAPK2  SPATA20
##        0        0        0        0        0        0        0        0
## ARHGAP31    PRSS8    TIMP2  ZMYND12    SYT13     DGKA  PLEKHG6    TRAF1
##        0        0        0        0        0        0        0        0
##   CYFIP2   BTN3A1     SEZ6     EPN3      IYD       CP   PRSS22    ABCC2
##        0        0        0        0        0        0        0        0
##  GRAMD1B   PHF21B      ME1     NGEF
##        0        0        0        0
```

```
# CV functions with k-NN, SVM and RF
results_cv_knn <- knn_trn(DEGsMatrixML,labels,names(mrmrRanking)[1:10],5)
```

```
## Tuning the optimal K...
```

```
## Loading required package: ggplot2
```

```
## Loading required package: lattice
```

```
## Optimal K: 7
## Running K-Fold Cross-Validation...
## Training fold 1...
## Running K-Fold Cross-Validation...
## Training fold 2...
## Running K-Fold Cross-Validation...
## Training fold 3...
## Running K-Fold Cross-Validation...
## Training fold 4...
## Running K-Fold Cross-Validation...
## Training fold 5...
## Classification done successfully!
```

```
results_cv_svm <- svm_trn(DEGsMatrixML,labels,rfRanking[1:10],5)
```

```
## Tuning the optimal C and G...
```

```
## Optimal cost: 0.25
## Optimal gamma: 0.5
## Training fold 1...
## Training fold 2...
## Training fold 3...
## Training fold 4...
## Training fold 5...
## Classification done successfully!
```

```
results_cv_rf <- rf_trn(DEGsMatrixML,labels,names(daRanking)[1:10],5)
```

```
## Tuning the optimal mtry...
```

```
## Training fold 1...
```

```
## Training fold 2...
```

```
## Training fold 3...
```

```
## Training fold 4...
```

```
## Training fold 5...
```

```
## Classification done successfully!
```

It is important to show graphically the results of the classifiers and for that purpose, the function *dataPlot* implements some methods. Concretely, to plot the accuracy, the sensitivity or the specificity reached by the classifiers, the function *dataPlot* has to be run with the parameter method equal to *classResults*. This method generated as many random colors as folds or simulations in the rows of the matrix passed to the function but, through the parameter colors a vector of desired colors can be specified. For the legend, the function uses the rownames of the input matrix but these names can be changed with the parameter legend. An example of this method is showed below:

```
# Plotting the accuracy of all the folds evaluated in the CV process

dataPlot(rbind(results_cv_knn$accuracy$meanAccuracy,results_cv_knn$accuracy$standardDeviation),mode = "classResults", legend = c("Mean Acc","Standard Deviation"),
main = "Mean Accuracy with k-NN", xlab = "Genes", ylab = "Accuracy")
```

![](data:image/png;base64...)

```
# Plotting the sensitivity of all the folds evaluated in the CV process

dataPlot(rbind(results_cv_knn$sensitivity$meanSensitivity,results_cv_knn$sensitivity$standardDeviation),mode = "classResults", legend = c("Mean Sens","Standard Deviation"),
main = "Mean Sensitivity with k-NN", xlab = "Genes", ylab = "Sensitivity")
```

![](data:image/png;base64...)

```
# Plotting the specificity of all the folds evaluated in the CV process

dataPlot(rbind(results_cv_knn$specificity$meanSpecificity,results_cv_knn$specificity$standardDeviation),mode = "classResults", legend = c("Mean Spec","Standard Deviation"),
main = "Mean Specificity with k-NN", xlab = "Genes", ylab = "Specificity")
```

![](data:image/png;base64...)

```
# Plotting all the metrics depending on the number of used DEGs in the CV process

dataPlot(results_cv_knn,labels,mode = "heatmapResults")
```

![](data:image/png;base64...)

Furthermore, the function *dataPlot* counts with another similar mode to the previous but this time to represents confusion matrices. This mode is called *confusionMatrix* and allows creating graphically a confusion matrix with the most important statistical measures. The following code allows doing this:

```
# Plotting the confusion matrix with the sum of the confusion matrices
# of each folds evaluated in the CV process

allCfMats <- results_cv_knn$cfMats[[1]]$table + results_cv_knn$cfMats[[2]]$table +
results_cv_knn$cfMats[[3]]$table + results_cv_knn$cfMats[[4]]$table +
results_cv_knn$cfMats[[5]]$table

dataPlot(allCfMats,labels,mode = "confusionMatrix")
```

![](data:image/png;base64...)

```
# Test functions with k-NN, SVM and RF
trainingMatrix <- DEGsMatrixML[c(1:4,6:9),]
trainingLabels <- labels[c(1:4,6:9)]
testMatrix <- DEGsMatrixML[c(5,10),]
testLabels <- labels[c(5,10)]

results_test_knn <- knn_test(trainingMatrix, trainingLabels, testMatrix,
testLabels, names(mrmrRanking)[1:10], bestK = results_cv_knn$bestK)
```

```
## Testing with 1 variables...
## Testing with 2 variables...
## Testing with 3 variables...
## Testing with 4 variables...
## Testing with 5 variables...
## Testing with 6 variables...
## Testing with 7 variables...
## Testing with 8 variables...
## Testing with 9 variables...
## Testing with 10 variables...
## Classification done successfully!
```

```
results_test_svm <- svm_test(trainingMatrix, trainingLabels, testMatrix,
testLabels, rfRanking[1:10], bestParameters = results_cv_svm$bestParameters)
```

```
## Testing with 1 variables...
## Testing with 2 variables...
## Testing with 3 variables...
## Testing with 4 variables...
## Testing with 5 variables...
## Testing with 6 variables...
## Testing with 7 variables...
## Testing with 8 variables...
## Testing with 9 variables...
## Testing with 10 variables...
## Classification done successfully!
```

```
results_test_rf <- rf_test(trainingMatrix, trainingLabels, testMatrix,
testLabels, colnames(DEGsMatrixML)[1:10], results_cv_rf$bestParameters)
```

```
## Testing with 1 variables...
```

```
## Testing with 2 variables...
```

```
## Testing with 3 variables...
```

```
## Testing with 4 variables...
```

```
## Testing with 5 variables...
```

```
## Testing with 6 variables...
```

```
## Testing with 7 variables...
```

```
## Testing with 8 variables...
```

```
## Testing with 9 variables...
```

```
## Testing with 10 variables...
```

```
## Classification done successfully!
```

```
# Plotting the accuracy achieved in the test process

dataPlot(results_test_knn$accVector,mode = "classResults",
main = "Accuracy with k-NN", xlab = "Genes", ylab = "Accuracy")
```

![](data:image/png;base64...)

```
dataPlot(results_test_svm$accVector,mode = "classResults",
main = "Accuracy with SVM", xlab = "Genes", ylab = "Accuracy")
```

![](data:image/png;base64...)

```
dataPlot(results_test_rf$accVector,mode = "classResults",
main = "Accuracy with RF", xlab = "Genes", ylab = "Accuracy")
```

![](data:image/png;base64...)

# 6 DEGs enrichment methodology

The main goal of the previous pipeline is the extraction of biological relevant information from the DEGs. For that, this package provides a set of tools that allows doing it. The last step of the pipeline englobes all the available tools in KnowSeq for DEGs enrichment, where three different approaches can be taken. The gene ontology information, the pathway visualization and the relationship between the DEGs and diseases related to the studied pathologies.

## 6.1 Gene Ontology

Gene ontology (GO) provides information about the biological functions of the genes. In order to complete this pipeline, it is important to know if the DEGs have functions related with the studied pathologies. In this sense, this package brings the possibility to know the GOs from the three different ontologies (BP, MF and CC) by using the function *geneOntologyEnrichment* that internally uses information from *DAVID* web-platform [20]. The function returns a list that contains a matrix for each ontology and a matrix with the GOs of the three ontologies together. Moreover, the matrices have different statistical measures and the description of the functionality of each GO.

```
# Retrieving the GO information from the three different ontologies

GOsList <- geneOntologyEnrichment(names(mrmrRanking)[1:10], geneType='GENE_SYMBOL', pvalCutOff=0.1)
```

```
## Getting gene symbols...Getting annotation of the Homo Sapiens...
## Using reference genome 38.
## Retrieving Gene Ontology terms related to the list of DEGs...
```

```
## Error in curl::curl_fetch_memory(url, handle = handle): Couldn't resolve host name [david.ncifcrf.gov]:
## Could not resolve host: david.ncifcrf.gov
```

For example, in this example, the top 10 GOs from the BP ontology for the extracted DEGs are shown in the following image.

![](data:image/png;base64...)

## 6.2 Pathway Information

Another important step in the enrichment methodology in this pipeline is the related pathway information. The function uses the DEGs to retrieve pathways with any relation with DEGs. For that, DEGsToPathways makes use of the information gathered from KEGG database in order to supply as more details as possible .

```
# Retrieving the pathways related to the DEGs
paths <- DEGsToPathways(names(mrmrRanking)[1:10])
```

```
## Retrieving information about KEGG pathways...
```

```
print(paths)
```

```
##    KEGG_Path         Name  Description        Class  Genes
## 1   map04020 Calcium .... Ca2+ tha.... Environm.... ATP2B4
## 2   map04022 cGMP-PKG.... Cyclic G.... Environm.... ATP2B4
## 3   map04024 cAMP sig.... cAMP is .... Environm.... ATP2B4
## 4   map04261 Adrenerg.... Cardiac .... Organism.... ATP2B4
## 5   map04925 Aldoster.... Aldoster.... Organism.... ATP2B4
## 6   map04961 Endocrin.... Calcium .... Organism.... ATP2B4
## 7   map04970 Salivary.... Saliva h.... Organism.... ATP2B4
## 8   map04972 Pancreat.... The panc.... Organism.... ATP2B4
## 9   map04978 Mineral .... Minerals.... Organism.... ATP2B4
## 10  map00600      nothing      nothing Metaboli....   GALC
## 11  map01100      nothing      nothing      nothing   GALC
## 12  map04142     Lysosome Lysosome.... Cellular....   GALC
## 13  map05169 Epstein-.... Epstein-.... Human Di....    VIM
## 14  map05206 MicroRNA.... MicroRNA.... Human Di....    VIM
## 15  map04666 Fc gamma.... Phagocyt.... Organism....   SCIN
## 16  map04810      nothing      nothing Cellular....   SCIN
## 17  map05203 Viral ca.... There is.... Human Di....   SCIN
## 18  map04370 VEGF sig.... There is.... Environm.... SH2D2A
## 19  map05202 Transcri.... In tumor.... Human Di....   ETV1
```

## 6.3 Related diseases

Finally, the last enrichment method implemented is the related diseases enrichment. In this step, the function *DEGsToDisease* searches the diseases related to a list of genes or DEGs indicated as parameter. The function returns a list of diseases only for genes and also for groups of genes with several statistical values to know the relation between the diseases and the gene or group of genes. This information is retrieved from the targetValidation web platform [27]. Also, it is possible to obtain the evidences that tie diseases with each gene from targetValidation platform, setting getEvidences parameter to *TRUE*. There are seven types of evidences: known drug, literature, affected pathway, animal model, RNA expression, genetic association or somatic mutation. Each of them contains different fields with the most important information for each one.

```
# Downloading the information about the DEGs related diseases

diseasesTargetValidation <- DEGsToDiseases(rownames(DEGsMatrix)[1:5], getEvidences = FALSE)
```

```
## Getting annotation of the Homo Sapiens...
## Using reference genome 38.
## Obtaining related diseases with the DEGs from targetValidation platform...
## Diseases acquired successfully!
```

```
diseasesTargetValidation
```

```
## $BCAS1
## $BCAS1$summary
##       Disease                       Overall Score       Literature RNA Expr.
##  [1,] "serum creatinine amount"     "0.526488904346172" "0"        "0"
##  [2,] "glomerular filtration rate"  "0.491959750406482" "0"        "0"
##  [3,] "platelet volume"             "0.486430544082506" "0"        "0"
##  [4,] "vitamin D amount"            "0.483500514785249" "0"        "0"
##  [5,] "calcium measurement"         "0.478224880638828" "0"        "0"
##  [6,] "erythrocyte count"           "0.472979068179309" "0"        "0"
##  [7,] "strand of hair color"        "0.472850361967942" "0"        "0"
##  [8,] "eosinophil count"            "0.458360162978447" "0"        "0"
##  [9,] "triglyceride measurement"    "0.458026809335919" "0"        "0"
## [10,] "Red cell distribution width" "0.455048703948118" "0"        "0"
##       Genetic Assoc.      Somatic Mut. Known Drug Animal Model
##  [1,] "0.866034269713905" "0"          "0"        "0"
##  [2,] "0.809236433388875" "0"          "0"        "0"
##  [3,] "0.80014130883572"  "0"          "0"        "0"
##  [4,] "0.795321633127945" "0"          "0"        "0"
##  [5,] "0.786643615552347" "0"          "0"        "0"
##  [6,] "0.77801465238725"  "0"          "0"        "0"
##  [7,] "0.777802940442614" "0"          "0"        "0"
##  [8,] "0.753967663390649" "0"          "0"        "0"
##  [9,] "0.753419321961266" "0"          "0"        "0"
## [10,] "0.748520564735113" "0"          "0"        "0"
##       Affected Pathways
##  [1,] "0"
##  [2,] "0"
##  [3,] "0"
##  [4,] "0"
##  [5,] "0"
##  [6,] "0"
##  [7,] "0"
##  [8,] "0"
##  [9,] "0"
## [10,] "0"
##
##
## $GALC
## $GALC$summary
##       Disease                                  Overall Score
##  [1,] "Krabbe disease"                         "0.859253691066357"
##  [2,] "genetic disorder"                       "0.509173779273002"
##  [3,] "eosinophil count"                       "0.413063541517051"
##  [4,] "spastic ataxia"                         "0.406537840153172"
##  [5,] "Crohn's disease"                        "0.403531986501863"
##  [6,] "inflammatory bowel disease"             "0.401285567141366"
##  [7,] "basophil count"                         "0.395640286363121"
##  [8,] "adult Krabbe disease"                   "0.37820954429159"
##  [9,] "infantile Krabbe disease"               "0.37336804819522"
## [10,] "late-infantile/juvenile Krabbe disease" "0.369579854684702"
##       Literature           RNA Expr. Genetic Assoc.      Somatic Mut.
##  [1,] "0.569176299880714"  "0"       "0.946154231098327" "0"
##  [2,] "0.0121586159522324" "0"       "0.836944272962084" "0"
##  [3,] "0"                  "0"       "0.679458160599619" "0"
##  [4,] "0"                  "0"       "0.668723877372783" "0"
##  [5,] "0"                  "0"       "0.663779476360171" "0"
##  [6,] "0"                  "0"       "0.660084287089743" "0"
##  [7,] "0"                  "0"       "0.65079822887321"  "0"
##  [8,] "0"                  "0"       "0.607930797611621" "0"
##  [9,] "0.124625813510382"  "0"       "0.607930797611621" "0"
## [10,] "0"                  "0"       "0.607930797611621" "0"
##       Known Drug Animal Model        Affected Pathways
##  [1,] "0"        "0"                 "0"
##  [2,] "0"        "0"                 "0"
##  [3,] "0"        "0"                 "0"
##  [4,] "0"        "0"                 "0"
##  [5,] "0"        "0"                 "0"
##  [6,] "0"        "0"                 "0"
##  [7,] "0"        "0"                 "0"
##  [8,] "0"        "0.283903682484627" "0"
##  [9,] "0"        "0"                 "0"
## [10,] "0"        "0"                 "0"
##
##
## $VIM
## $VIM$summary
##       Disease
##  [1,] "total cholesterol measurement"
##  [2,] "high density lipoprotein cholesterol measurement"
##  [3,] "low density lipoprotein cholesterol measurement"
##  [4,] "Partial congenital cataract"
##  [5,] "Developmental cataract"
##  [6,] "erythrocyte volume"
##  [7,] "aspartate aminotransferase measurement"
##  [8,] "pulverulent cataract"
##  [9,] "esterified cholesterol measurement"
## [10,] "non-high density lipoprotein cholesterol measurement"
##       Overall Score       Literature           RNA Expr. Genetic Assoc.
##  [1,] "0.498245876854407" "0"                  "0"       "0.819576634070633"
##  [2,] "0.481223740440312" "0"                  "0"       "0.791576512213062"
##  [3,] "0.464715806931798" "0"                  "0"       "0.764422215090152"
##  [4,] "0.456930654958644" "0"                  "0"       "0.75161623124505"
##  [5,] "0.434644159966231" "0.0287078432205488" "0"       "0.571454949754924"
##  [6,] "0.430425261535608" "0"                  "0"       "0.708016871700892"
##  [7,] "0.376902385442009" "0"                  "0"       "0.619975804684919"
##  [8,] "0.369579854684702" "0"                  "0"       "0.607930797611621"
##  [9,] "0.362112853139499" "0"                  "0"       "0.595648147062351"
## [10,] "0.333659697720965" "0"                  "0"       "0.548844866935208"
##       Somatic Mut. Known Drug Animal Model Affected Pathways
##  [1,] "0"          "0"        "0"          "0"
##  [2,] "0"          "0"        "0"          "0"
##  [3,] "0"          "0"        "0"          "0"
##  [4,] "0"          "0"        "0"          "0"
##  [5,] "0"          "0"        "0"          "0"
##  [6,] "0"          "0"        "0"          "0"
##  [7,] "0"          "0"        "0"          "0"
##  [8,] "0"          "0"        "0"          "0"
##  [9,] "0"          "0"        "0"          "0"
## [10,] "0"          "0"        "0"          "0"
##
##
## $SCIN
## $SCIN$summary
##       Disease                 Overall Score        Literature
##  [1,] "sweat gland disease"   "0.295806369629571"  "0"
##  [2,] "adseverin measurement" "0.2720597212946"    "0"
##  [3,] "colorectal carcinoma"  "0.255104160592706"  "0.279648166901346"
##  [4,] "body height"           "0.23271859876386"   "0"
##  [5,] "Alzheimer disease"     "0.140327270157095"  "0.100139711939914"
##  [6,] "polygenic risk score"  "0.137283369409484"  "0"
##  [7,] "glioma"                "0.0934770113568357" "0.768812928412897"
##  [8,] "neoplasm"              "0.0897283556219559" "0.737981658228797"
##  [9,] "cancer"                "0.0813256154834187" "0.668872310819938"
## [10,] "erythrocyte volume"    "0.0629677274318189" "0"
##       RNA Expr. Genetic Assoc.      Somatic Mut. Known Drug Animal Model
##  [1,] "0"       "0.486579016545479" "0"          "0"        "0"
##  [2,] "0"       "0.447517583191116" "0"          "0"        "0"
##  [3,] "0"       "0.405644564979749" "0"          "0"        "0"
##  [4,] "0"       "0.38280442392151"  "0"          "0"        "0"
##  [5,] "0"       "0.225820718326542" "0"          "0"        "0"
##  [6,] "0"       "0.225820718326542" "0"          "0"        "0"
##  [7,] "0"       "0"                 "0"          "0"        "0"
##  [8,] "0"       "0"                 "0"          "0"        "0"
##  [9,] "0"       "0"                 "0"          "0"        "0"
## [10,] "0"       "0.103577130290488" "0"          "0"        "0"
##       Affected Pathways
##  [1,] "0"
##  [2,] "0"
##  [3,] "0"
##  [4,] "0"
##  [5,] "0"
##  [6,] "0"
##  [7,] "0"
##  [8,] "0"
##  [9,] "0"
## [10,] "0"
```

# 7 Gene Expression Intelligent Report

Most of these steps can be displayed using a single function, *knowseqReport*, that starting from an expression matrix (or counts matrix) and the labels of the samples, will follow part of the pipeline explained above and will display the result in a report in html format.

For the obtention of this report a DEGs extraction using limma package will be performed. Then, a feature selection process will be carried out, where the used algorithm can be set by the featureSelectionMode parameter, along with the visualizations steps that have been described previously.

Following, the machine learning process starts, where the classification algorithms and the classification metrics to be displayed can be chossen by the user by clasifAlgs and metrics parameters.

Finally DEGs enrichment is obtained, showing Gene Ontologies and found evidences for related diseases for each gene. It is possible to obtain evidences for a certain disease, specifying it by the disease parameter.

```
# Performing the automatic and intelligent KnowSeq report
knowseqReport(expressionMatrix,labels,'knowSeq-report',clasifAlgs=c('knn'),disease='breast-cancer', lfc = 2, pvalue = 0.001, geneOntology = T, getPathways = T)
```

# 8 Session Info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] caret_7.0-1    lattice_0.22-7 ggplot2_4.0.0  KnowSeq_1.24.0 cqn_1.56.0
## [6] mclust_6.1.1
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3    rstudioapi_0.17.1     jsonlite_2.0.0
##   [4] magrittr_2.0.4        farver_2.1.2          rmarkdown_2.30
##   [7] vctrs_0.6.5           memoise_2.0.1         base64enc_0.1-3
##  [10] htmltools_0.5.8.1     curl_7.0.0            Formula_1.2-5
##  [13] pROC_1.19.0.1         sass_0.4.10           parallelly_1.45.1
##  [16] nor1mix_1.3-3         bslib_0.9.0           htmlwidgets_1.6.4
##  [19] plyr_1.8.9            lubridate_1.9.4       cachem_1.1.0
##  [22] lifecycle_1.0.4       iterators_1.0.14      pkgconfig_2.0.3
##  [25] Matrix_1.7-4          R6_2.6.1              fastmap_1.2.0
##  [28] praznik_11.0.0        MatrixGenerics_1.22.0 future_1.67.0
##  [31] digest_0.6.37         colorspace_2.1-2      AnnotationDbi_1.72.0
##  [34] S4Vectors_0.48.0      Hmisc_5.2-4           RSQLite_2.4.3
##  [37] labeling_0.4.3        randomForest_4.7-1.2  timechange_0.3.0
##  [40] httr_1.4.7            mgcv_1.9-3            compiler_4.5.1
##  [43] proxy_0.4-27          bit64_4.6.0-1         withr_3.0.2
##  [46] htmlTable_2.4.3       S7_0.2.0              backports_1.5.0
##  [49] BiocParallel_1.44.0   DBI_1.2.3             R.utils_2.13.0
##  [52] MASS_7.3-65           lava_1.8.1            quantreg_6.1
##  [55] ModelMetrics_1.2.2.2  tools_4.5.1           foreign_0.8-90
##  [58] future.apply_1.20.0   nnet_7.3-20           R.oo_1.27.1
##  [61] glue_1.8.0            nlme_3.1-168          grid_4.5.1
##  [64] checkmate_2.3.3       cluster_2.1.8.1       reshape2_1.4.4
##  [67] generics_0.1.4        recipes_1.3.1         sva_3.58.0
##  [70] gtable_0.3.6          R.methodsS3_1.8.2     class_7.3-23
##  [73] data.table_1.17.8     XVector_0.50.0        BiocGenerics_0.56.0
##  [76] foreach_1.5.2         pillar_1.11.1         stringr_1.5.2
##  [79] limma_3.66.0          genefilter_1.92.0     splines_4.5.1
##  [82] dplyr_1.1.4           survival_3.8-3        bit_4.6.0
##  [85] annotate_1.88.0       SparseM_1.84-2        tidyselect_1.2.1
##  [88] locfit_1.5-9.12       Biostrings_2.78.0     knitr_1.50
##  [91] gridExtra_2.3         IRanges_2.44.0        Seqinfo_1.0.0
##  [94] edgeR_4.8.0           stats4_4.5.1          xfun_0.53
##  [97] Biobase_2.70.0        statmod_1.5.1         hardhat_1.4.2
## [100] timeDate_4051.111     matrixStats_1.5.0     stringi_1.8.7
## [103] yaml_2.3.10           evaluate_1.0.5        codetools_0.2-20
## [106] kernlab_0.9-33        tibble_3.3.0          cli_3.6.5
## [109] rpart_4.1.24          xtable_1.8-4          jquerylib_0.1.4
## [112] dichromat_2.0-0.1     Rcpp_1.1.0            globals_0.18.0
## [115] png_0.1-8             XML_3.99-0.19         parallel_4.5.1
## [118] MatrixModels_0.5-4    gower_1.0.2           blob_1.2.4
## [121] listenv_0.9.1         ipred_0.9-15          rlist_0.4.6.2
## [124] scales_1.4.0          prodlim_2025.04.28    e1071_1.7-16
## [127] purrr_1.1.0           crayon_1.5.3          rlang_1.1.6
## [130] KEGGREST_1.50.0
```

# 9 References

1. Castillo, D., Gálvez, J. M., Herrera, L. J., San Román, B., Rojas, F., & Rojas, I. (2017). Integration of RNA-Seq data with heterogeneous microarray data for breast cancer profiling. BMC bioinformatics, 18(1), 506.
2. Gálvez, J. M., Castillo, D., Herrera, L. J., San Roman, B., Valenzuela, O., Ortuno, F. M., & Rojas, I. (2018). Multiclass classification for skin cancer profiling based on the integration of heterogeneous gene expression series. PloS one, 13(5), e0196836.
3. Castillo, D., Galvez, J. M., Herrera, L. J., Rojas, F., Valenzuela, O., Caba, O., … & Rojas, I. (2019). Leukemia multiclass assessment and classification from Microarray and RNA-seq technologies integration at gene expression level. PloS one, 14(2), e0212127.
4. Gálvez, J. M., Castillo, D., Herrera, L. J., Valenzuela, O., Caba, O., Prados, J. C., … & Rojas, I. (2019). Towards Improving Skin Cancer Diagnosis by Integrating Microarray and RNA-seq Datasets. IEEE Journal of Biomedical and Health Informatics.
5. Barrett, T., Wilhite, S. E., Ledoux, P., Evangelista, C., Kim, I. F., Tomashevsky, M., … & Yefanov, A. (2012). NCBI GEO: archive for functional genomics data sets—update. Nucleic acids research, 41(D1), D991-D995.
6. Kolesnikov, N., Hastings, E., Keays, M., Melnichuk, O., Tang, Y. A., Williams, E., … & Megy, K. (2014). ArrayExpress update—simplifying data submissions. Nucleic acids research, 43(D1), D1113-D1116.
7. Langmead, B., & Salzberg, S. L. (2012). Fast gapped-read alignment with Bowtie 2. Nature methods, 9(4), 357.
8. Kim, D., Langmead, B., & Salzberg, S. L. (2015). HISAT: a fast spliced aligner with low memory requirements. Nature methods, 12(4), 357.
9. Anders, S., Pyl, P. T., & Huber, W. (2015). HTSeq—a Python framework to work with high-throughput sequencing data. Bioinformatics, 31(2), 166-169.
10. Bray, N. L., Pimentel, H., Melsted, P., & Pachter, L. (2016). Near-optimal probabilistic RNA-seq quantification. Nature biotechnology, 34(5), 525.
11. Patro, R., Duggal, G., Love, M. I., Irizarry, R. A., & Kingsford, C. (2017). Salmon provides fast and bias-aware quantification of transcript expression. Nature methods, 14(4), 417.
12. Li, H. (2011). A statistical framework for SNP calling, mutation discovery, association mapping and population genetical parameter estimation from sequencing data. Bioinformatics, 27(21), 2987-2993.
13. Sherry, S., & Xiao, C. (2012, January). Ncbi sra toolkit technology for next generation sequence data. In Plant and Animal Genome XX Conference (January 14-18, 2012). Plant and Animal Genome.
14. Soneson, C., Love, M. I., & Robinson, M. D. (2015). Differential analyses for RNA-seq: transcript-level estimates improve gene-level inferences. F1000Research, 4.
15. Robinson, M. D., McCarthy, D. J., & Smyth, G. K. (2010). edgeR: a Bioconductor package for differential expression analysis of digital gene expression data. Bioinformatics, 26(1), 139-140.
16. Cunningham, F., Achuthan, P., Akanni, W., Allen, J., … , & Huber, W. (2018). Ensembl 2019. Nucleic Acids Research, 47(D1), D745–D751.
17. Hansen, K. D., Irizarry, R. A., & Wu, Z. (2012). Removing technical variability in RNA-seq data using conditional quantile normalization. Biostatistics, 13(2), 204-216.
18. Leek JT, Johnson WE, Parker HS, Fertig EJ, Jaffe AE, Storey JD, Zhang Y, Torres LC (2019). sva: Surrogate Variable Analysis. R package version 3.34.0.
19. Ritchie, M. E., Phipson, B., Wu, D., Hu, Y., Law, C. W., Shi, W., & Smyth, G. K. (2015). limma powers differential expression analyses for RNA-sequencing and microarray studies. Nucleic acids research, 43(7), e47-e47.
20. X Jiao, BT Sherman, R Stephens, MW Baseler, HC Lane, RA Lempicki. DAVID-WS: a stateful web service to facilitate gene/protein list analysis. Bioinformatics (2012) 28 (13): 1805-1806. doi: 10.1093/bioinformatics/bts251
21. Luo, W., & Brouwer, C. (2013). Pathview: an R/Bioconductor package for pathway-based data integration and visualization. Bioinformatics, 29(14), 1830-1831.
22. Goh, W. W. B., Wang, W., & Wong, L. (2017). Why batch effects matter in omics data, and how to avoid them. Trends in biotechnology, 35(6), 498-507.
23. Ding, C., & Peng, H. (2005). Minimum redundancy feature selection from microarray gene expression data. Journal of bioinformatics and computational biology, 3(02), 185-205.
24. Noble, W. S. (2006). What is a support vector machine?. Nature biotechnology, 24(12), 1565.
25. Parry, R. M., Jones, W., Stokes, T. H., Phan, J. H., Moffitt, R. A., Fang, H., … & Wang, M. D. (2010). k-Nearest neighbor models for microarray gene expression analysis and clinical outcome prediction. The pharmacogenomics journal, 10(4), 292.
26. Koscielny, G., An, P., Carvalho-Silva, D., Cham, J. A., Fumis, L., Gasparyan, R., … & Pierleoni, A. (2016). Open Targets: a platform for therapeutic target identification and validation. Nucleic acids research, 45(D1), D985-D994.