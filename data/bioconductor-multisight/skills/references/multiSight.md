# multiSight quick start guide

Florian Jeanneret1 and Stéphane Gazut1

1Université Paris-Saclay, CEA, List, F-91120, Palaiseau, France.

#### 19 May 2021

# 1 multiSight

The purpose of this vignette is to help you become productive as quickly as
possible with the **multiSight** package.

## 1.1 Version Info

**R version**: R version 4.1.0 (2021-05-18)

**Bioconductor version**: 3.13

**Package version**: 1.0.0

# 2 Installation

You can install the released version of **multiSight** from
[Bioconductor](https://www.bioconductor.org/) with:

```
#To install this package ensure you have BiocManager installed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

#The following initializes usage of Bioc devel
BiocManager::install("multiSight")
```

# 3 **multiSight** purpose

**multiSight** is an R package providing a graphical interface to
analyze and explore your omic datasets (e.g. RNAseq, RPPA) by both
**single-omics** and **multi-omics** approaches.

*Single-omics* means Differential Expression Analysis (DEA) is led by DESeq2
towards Over Representation Analysis (ORA). Features with DEA p-values under
the 0.05 threshold, or user’s value set in the *Biological Insight* tab, are
selected. These features are saved to carry out ORA on several databases
(see *Biological insights* tab section).

*Multi-omics* is defined by substituting the DEA part by sPLS-DA method.
This is a multi-block selection features method taking several omic blocks
into account to select features (see *sPLS-DA* section). Biological processes
(*BPs*) from a database (e.g. Reactome) are then enriched with these selected
features by ORA to reveal putative altered biological processes.

Enrichment results obtained by ORAs are tables with *BP* IDs,
descriptions and p-values. An enrichment table is provided for each omic data
block and for each database.
**multiSight** proposes easing enrichment results interpretation from
several omic datasets. For each *BP* shared between enrichment results
from a given database, the relative p-values are merged.
Stouffer’s pooling method is used to calculate probabilities fusion
(see Multi-omics table section).
For instance, if “*signaling by ERBB2*” is highlighted by ORAs of RNAseq and
RPPA features with p-values of 0.06 and 0.10, Stouffer’s method
calculates a probability of 0.0224 for this pathway.
Thereby, multi-omics
information is harnessed to make decision of significance.

Stouffer’s p-values for *BP* beget a multi-omics table where
*BP* IDs, description and Stouffer’s p-values are provided.
This *multi-omics* enrichment table is used to draw an *enrichment map*.

*Enrichment map* is a network based on *BPs* information.
*BPs* are nodes while the bonds are built between
*BPs* sharing some features (see *Multi-omics enrichment map* section).

In addition, classification models are fitted to select few subsets of
features, using **biosigner** or **sPLS-DA methods**.
*biosigner* provides one model by omic block and one list of features named
*biosignature*.
Nevertheless, sPLS-DA *biosignatures* are based on more features than biosigner.

**Biosignatures** can be used:

* To forecast phenotypes (e.g. to diagnostic tasks, histological subtyping);
* To design ***Pathways*** and ***gene ontology*** **enrichments**
  (sPLS-DA biosignatures only);
* To build ***Network inference***;
* To find ***PubMed*** references to make assumptions easier and data-driven.

Moreover, numerical relationships between features selected by *sPLS-DA* or
*biosigner* can feed network inferences (for instance by correlation
or mutual information, see *Assumption tab* section).

***multiSight** package provides a graphical interface and relative functions*
*to use in a script.*

## 3.1 App structure

**multiSight** allows to get better biological insights for each omic dataset
based on **four analytic modules**:

* **Data input** & **results**;
* **Classification** models building;
* **Biological databases** querying;
* **Network Inference** & **PubMed** querying.

*All figures and tables can be retrieved in an automatic report.*

## 3.2 Which omic data?

All types of omic data respecting input format are supported to build
**classification models**, **biosignatures** and
**network inference**.

* Genomics;
* Transcriptomics;
* Proteomics;
* Metabolomics;
* Lipidomics;

*This package supports all numerical matrices.*

*You can take a look on data format supported in **Home** tab details.*

# 4 Home tab

This is the first tab of **multiSight**.

In this tab, you can load your biological data and find all results in a
generated report (.html or .doc formats).

## 4.1 Data format

You should provide two types of data: **numerical matrices** and
**classes vector** as **csv tables** for the **same samples**.

| Omic data 1 |  |  |  |  |
| --- | --- | --- | --- | --- |
|  | SIGIRR | SIGIRR | MANSC1 |  |
| AOFJ | 0 | 150 | 1004 | … |
| A13E | 34 | 0 | 0 |  |
|  |  | … |  |  |

| Omic data 2 |  |  |  |  |
| --- | --- | --- | --- | --- |
|  | ENSG00000139618 | ENSG00000226023 | ENSG00000198695 |  |
| AOFJ | 25 | 42 | 423 | … |
| A13E | 0 | 154 | 4900 |  |
|  |  | … |  |  |

| Omic classes |  |
| --- | --- |
|  | Y |
| AOFJ | condA |
| A13E | condB |
|  | … |

## 4.2 Organism

**multiSight** downloads organism database automatically according to your
choice in *Home tab*. **19 organism databases** are available (see *Home tab*).
Please note that *multiSight* can be used without enrichment analysis, and
thus, without a organism database matching with your data.

## 4.3 Generated report

Report of results can be generated in *Home tab* below *datasets input part*
inside the **Analysis Results** block (.html or .doc formats).

# 5 Classification tab

*This tab background is launched when you start analysis in Home tab. Results*
*are displayed after biosigner and sPLS-DA models fitting*.

This tab presents **classification models** to **predict sample classes**
based upon only a **small subset of features** selected by **multiSight**
models.

## 5.1 Model methods

Two types of models have been implemented so far to answer different
questions: from **biosigner** & **mixOmics (sPLS-DA)** R packages.

* To determine *small biosignatures* - biosigner.
* To build *classification models* by a *multi-block* approach - sPLS-DA
* To select relevant biological *features* to *enrich* - sPLS-DA

### 5.1.1 biosigner

[**biosigner**](bioconductor.org/packages/release/bioc/html/biosigner.html)
is an R package available in *Bioconductor* project.

*In a single-omics* approach, **biosigner** computes **SVM**
and **Random Forest** models and selects features for all omic
datasets **one by one**.

Thereby, a biosignature is defined for each omic as the *union of SVM and RF*
variable lists.

*If there are 3 omic datasets, **biosigner** gives 6 models and 3 feature lists
(about 5-10 features by data type).*

### 5.1.2 Example

```
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")

splitData <- splitDatatoTrainTest(omic2, freq = 0.8)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build model and one biosignature by omic dataset.
biosignerRes <- runSVMRFmodels_Biosigner(data.train)

## Results
biosignerModels <- biosignerRes$model #list of SVM/RF models for each omic.
biosignerFeats <- biosignerRes$biosignature #selected features for each omic.

## Assess model classification performances
biosignerPerf <- assessPerformance_Biosigner(modelList = biosignerModels,
                                             dataTest = data.test)
print(biosignerPerf) #confusion matrices and performance metrics
```

```
## $svm
## $svm$rnaRead
## Confusion Matrix and Statistics
##
##
##     A B
##   A 2 0
##   B 0 4
##
##                Accuracy : 1
##                  95% CI : (0.5407, 1)
##     No Information Rate : 0.6667
##     P-Value [Acc > NIR] : 0.08779
##
##                   Kappa : 1
##
##  Mcnemar's Test P-Value : NA
##
##             Sensitivity : 1.0000
##             Specificity : 1.0000
##          Pos Pred Value : 1.0000
##          Neg Pred Value : 1.0000
##              Prevalence : 0.3333
##          Detection Rate : 0.3333
##    Detection Prevalence : 0.3333
##       Balanced Accuracy : 1.0000
##
##        'Positive' Class : A
##
##
## $svm$dnaRead
## Confusion Matrix and Statistics
##
##
##     A B
##   A 2 0
##   B 0 4
##
##                Accuracy : 1
##                  95% CI : (0.5407, 1)
##     No Information Rate : 0.6667
##     P-Value [Acc > NIR] : 0.08779
##
##                   Kappa : 1
##
##  Mcnemar's Test P-Value : NA
##
##             Sensitivity : 1.0000
##             Specificity : 1.0000
##          Pos Pred Value : 1.0000
##          Neg Pred Value : 1.0000
##              Prevalence : 0.3333
##          Detection Rate : 0.3333
##    Detection Prevalence : 0.3333
##       Balanced Accuracy : 1.0000
##
##        'Positive' Class : A
##
##
##
## $rf
## $rf$rnaRead
## Confusion Matrix and Statistics
##
##
##     A B
##   A 2 0
##   B 0 4
##
##                Accuracy : 1
##                  95% CI : (0.5407, 1)
##     No Information Rate : 0.6667
##     P-Value [Acc > NIR] : 0.08779
##
##                   Kappa : 1
##
##  Mcnemar's Test P-Value : NA
##
##             Sensitivity : 1.0000
##             Specificity : 1.0000
##          Pos Pred Value : 1.0000
##          Neg Pred Value : 1.0000
##              Prevalence : 0.3333
##          Detection Rate : 0.3333
##    Detection Prevalence : 0.3333
##       Balanced Accuracy : 1.0000
##
##        'Positive' Class : A
##
##
## $rf$dnaRead
## Confusion Matrix and Statistics
##
##
##     A B
##   A 2 0
##   B 0 4
##
##                Accuracy : 1
##                  95% CI : (0.5407, 1)
##     No Information Rate : 0.6667
##     P-Value [Acc > NIR] : 0.08779
##
##                   Kappa : 1
##
##  Mcnemar's Test P-Value : NA
##
##             Sensitivity : 1.0000
##             Specificity : 1.0000
##          Pos Pred Value : 1.0000
##          Neg Pred Value : 1.0000
##              Prevalence : 0.3333
##          Detection Rate : 0.3333
##    Detection Prevalence : 0.3333
##       Balanced Accuracy : 1.0000
##
##        'Positive' Class : A
##
```

### 5.1.3 sPLS-DA (DIABLO)

By a *multi-omics* approach,
[**sPLS-DA (DIABLO)**](doi.org/10.1093/bioinformatics/bty1054)
method selects relevant features to explain biological outcome of interest.
This is implemented into the
[**mixOmics**](bioconductor.org/packages/release/bioc/html/mixOmics.html)
R package available in *Bioconductor* project.

*sPLS-DA method* builds a new space for each omic dataset by linear
combinations of initial features giving several components.
In fact, around 20-40 features, for each omic, are selected according to
contributions to components. Then, these features can be used to
enrich some biological processes from a biological database
(e.g. KEGG, Reactome) by ORA.

Classification **performances** are displayed in *classification tab* for
each model and **selected features** by omic data type (e.g. if you have
provided 3 omic types, you could observe 3 feature lists).

### 5.1.4 Example

```
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")

splitData <- splitDatatoTrainTest(omic2, freq = 0.9)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build model and one biosignature by omic dataset.
# diabloRes <- runSPLSDA(data.train)
# diabloRes #internal object of package to save time

## Results
diabloModels <- diabloRes$model #sPLS-DA model using all omics.
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Asses model classification performances
diabloPerf <- assessPerformance_Diablo(splsdaModel = diabloModels,
                                          dataTest = data.test)
print(diabloPerf) #confusion matrices and performance metrics
```

```
## Confusion Matrix and Statistics
##
##     Ytest
##      A NA
##   A  3  0
##   NA 0  0
##
##                Accuracy : 1
##                  95% CI : (0.2924, 1)
##     No Information Rate : 1
##     P-Value [Acc > NIR] : 1
##
##                   Kappa : NaN
##
##  Mcnemar's Test P-Value : NA
##
##             Sensitivity :  1
##             Specificity : NA
##          Pos Pred Value : NA
##          Neg Pred Value : NA
##              Prevalence :  1
##          Detection Rate :  1
##    Detection Prevalence :  1
##       Balanced Accuracy : NA
##
##        'Positive' Class : A
##
```

```
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")

splitData <- splitDatatoTrainTest(omic2, freq = 0.9)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build model and one biosignature by omic dataset.
# diabloRes <- runSPLSDA(data.train)
# diabloRes #internal object of package to save time

## Results
diabloModels <- diabloRes$model #sPLS-DA model using all omics.
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Asses model classification performances
diabloPerf <- assessPerformance_Diablo(splsdaModel = diabloModels,
                                          dataTest = data.test)
print(diabloPerf) #confusion matrices and performance metrics
```

```
## Confusion Matrix and Statistics
##
##     Ytest
##      A B NA
##   A  2 0  0
##   B  0 1  0
##   NA 0 0  0
##
## Overall Statistics
##
##                Accuracy : 1
##                  95% CI : (0.2924, 1)
##     No Information Rate : 0.6667
##     P-Value [Acc > NIR] : 0.2963
##
##                   Kappa : 1
##
##  Mcnemar's Test P-Value : NA
##
## Statistics by Class:
##
##                      Class: A Class: B Class: NA
## Sensitivity            1.0000   1.0000        NA
## Specificity            1.0000   1.0000         1
## Pos Pred Value         1.0000   1.0000        NA
## Neg Pred Value         1.0000   1.0000        NA
## Prevalence             0.6667   0.3333         0
## Detection Rate         0.6667   0.3333         0
## Detection Prevalence   0.6667   0.3333         0
## Balanced Accuracy      1.0000   1.0000        NA
```

# 6 Biological insights tab

*This tab is ready to use when Classification tab features selection is over.*

**Biological Insights** tab is dedicated to give biological sense to your data.

You can carry out enrichment by ORA with features selected according to
*DESeq2* feature probabilities under the 0.05 threshold.
Or, you can compute biological
enrichment with features selected by *sPLS-DA*.

## 6.1 Biological Annotation Databases

**Several databases** are implemented in **multiSight** package to
provide a large panel of **enrichment analysis**:

There are **Pathways** and **Gene Ontology** databases helped by
**clusterProfiler** and **reactomePA** R Bioconductor packages:

* Kegg;
* Reactome;
* wikiPathways;
* Molecular Function (GO)
* Cellular Component (GO)
* Biological Process (GO)

See table below to check available biological information for **pathways** from
these databases, according to organism annotations.

**multiSight** supports **19 organism databases**
(required only for enrichment analysis):

| orgDb | kegg | reactome | wikipathways |
| --- | --- | --- | --- |
| org.Hs.eg.db | hsa | human | Homo sapiens |
| org.Mm.eg.db | mmu | mouse | Mus musculus |
| org.Rn.eg.db | rno | rat | Rattus norvegicus |
| org.Sc.sgd.db | sce | yeast | Saccharomyces cerevisiae |
| org.Dm.eg.db | dme | fly | Drosophila melanogaster |
| org.Dr.eg.db | dre | zebrafish | Danio rerio |
| org.Ce.eg.db | cel | celegans | Caenorhabditis elegans |
| org.At.tair.db | ath | x | Arabidopsis thaliana |
| org.Bt.eg.db | bta | x | Bos taurus |
| org.Gg.eg.db | gga | x | Gallus gallus |
| org.Cf.eg.db | cfa | x | Canis familiaris |
| org.Ss.eg.db | ssc | x | Sus scrofa |
| org.EcK12.eg.db | eck | x | Escherichia coli |
| org.Pt.eg.db | ptr | x | Pan troglodytes |
| org.Ag.eg.db | aga | x | Anopheles gambiae |
| org.Pf.plasmo.db | pfa | x | Plasmodium falciparum |
| org.EcSakai.eg.db | ecs | x | Escherichia coli |
| org.Mmu.eg.db | mcc | x | x |
| org.Xl.eg.db | xla | x | x |

**Note for enrichment**: only convertible feature names to genes could be
enriched according to information in organism’s database (e.g. *Gene SYMBOL*
*to entrez ids*).

To know *what feature name types are supported*, copy these two lines of
codes with your organism database of interest.
For instance, org.Mm.eg.db for Human provides 24 input names you can use as
feature names in your datasets.

```
if (requireNamespace("org.Mm.eg.db", quietly = TRUE))
{
  library(org.Mm.eg.db)
  columns(org.Mm.eg.db)
}
```

```
##  [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS"
##  [6] "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"
## [11] "GENETYPE"     "GO"           "GOALL"        "IPI"          "MGI"
## [16] "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"         "PMID"
## [21] "PROSITE"      "REFSEQ"       "SYMBOL"       "UNIPROT"
```

Please note that feature IDs can differ between omic blocks (e.g. one dataset
with gene SYMBOL, another one with ENSEMBL IDs). You can provide this
information to convert them for enrichment in the application.

## 6.2 **Single-omic** DESeq2 differential expression analysis

Therefore, in this *Biological insights tab* you can compute
**Differential Expression Analysis (DEA) by DESeq2** for several omic datasets
Moreover, with features selected according to
*p-value threshold set by the user* you can enrich pathway or Gene Ontology
databases.

### 6.2.1 Example

```
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("deseqRes", package = "multiSight")
# deseqRes <- runMultiDeseqAnalysis(omicDataList = omic2,
                                  # padjUser = 0.05)
## One Differential Expression Analysis table for each omic dataset
# View(deseqRes$DEtable)
## One feature selected list for each omic according to padjust user threshold
multiOmic_biosignature <- deseqRes$selectedFeatures
# View(multiOmic_biosignature)

## Multi-omics enrichment
### convert features
dbList <- list(rnaRead = "ENSEMBL",
               dnaRead = "ENSEMBL")
convFeat <- convertToEntrezid(multiOmic_biosignature, dbList, "org.Mm.eg.db")

### ORA enrichment analysis
if (requireNamespace("org.Mm.eg.db", quietly = TRUE))
{
    # database <- c("kegg", "wikiPathways", "reactome", "MF", "CC", "BP")
    database <- c("reactome")
    data("enrichResList", package = "multiSight")
    # enrichResList <- runMultiEnrichment(omicSignature = convFeat,
    #                                    databasesChosen = database,
    #                                    organismDb = "org.Mm.eg.db",
    #                                    pvAdjust = "BH", #default value
    #                                    minGSSize = 5, #default value
    #                                    maxGSSize = 800, #default value
    #                                    pvStouffer = 0.1) #default value
    reacRes <- enrichResList$pathways$reactome
    names(reacRes$result) # classical enrichment tables, multi-omics and EMap
}
```

```
## NULL
```

## 6.3 **Multi-omics** sPLS-DA selected features

This tab gives a graphical interface where all **multi-omics features**
selected by sPLS-DA method are used to enrich chosen databases.
You could retrieve **functional enrichment results** in Home tab’s report or
save tables in this tab.

```
require(multiSight)
## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")
# splitData <- splitDatatoTrainTest(omic2, 0.8)
# data.train <- splitData$data.train
# data.test <- splitData$data.test
#
# diabloRes <- runSPLSDA(data.train)
# diabloRes #internal object of package to save time
diabloModels <- diabloRes$model #sPLS-DA model using all omics.
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Multi-omics enrichment
### convert features
names(diabloFeats) #/!\use same names for dbList and omic datasets.
```

```
## [1] "rnaRead" "dnaRead"
```

```
dbList <- list(rnaRead = "ENSEMBL", #feature names origin
               dnaRead = "ENSEMBL")

if (requireNamespace("org.Mm.eg.db", quietly = TRUE))
{
    convFeat <- convertToEntrezid(diabloFeats,
                                  dbList,
                                  "org.Mm.eg.db")

    ### ORA enrichment analysis for omic feature lists
    # database <- c("kegg", "wikiPathways", "reactome", "MF", "CC", "BP")
    database <- c("reactome")
    multiOmicRes <- runMultiEnrichment(omicSignature = convFeat,
                                       databasesChosen = database,
                                       organismDb = "org.Mm.eg.db",
                                       pvAdjust = "BH", #default value
                                       minGSSize = 5, #default value
                                       maxGSSize = 800, #default value
                                       pvStouffer = 0.1) #default value

    ## Results
    reacRes <- multiOmicRes$pathways$reactome
    names(reacRes$result) # classical enrichment tables, multi-omics and EMap
}
```

```
## [1] "enrichTable_omic1" "enrichTable_omic2" "multi"
## [4] "enrichMap"
```

## 6.4 Visualizations

Two types of result visualization are given:

* Classical **enrichment tables** for each omic and each database (with
  pathways id, p-value, padjust column).
* Then, when more than one omic is used for enrichment,
  a *multi-omics table* and a *multi-omics enrichment map*
  with **DEA** and *sPLS-DA selected features* are available.

### 6.4.1 Multi-omics Table

A **multi-omics table** is built by annotation database (e.g. Reactome) with
all enrichment results obtained for omic datasets using Stouffer’s method.
[*Stouffer’s p-value method*](https://doi.org/10.1371/journal.pone.0089297)
consists in *p-values pooling* for same pathways or
ontology.
In fact, a Stouffer’s value is computed for every biological
annotations shared by at least 2 enrichment analysis results (NOTE: each omic
data used for enrichment has one usual enrichment table by selected database).

Thereby, you can **summarize information for several datasets** and
enrichment results with a multi-omics table, for instance:

| ID | Description | p-value:Omic1 | p-value:Omic2 | Stouffer | StoufferWeighted | geneID | GeneRatio | Count |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R-MMU-2173791 | TGF-beta receptor signaling in EMT (epithelial to mesenchymal transition) | 0.043 | 0.047 | 0.008 | 0.008 | 102098/11848/16456/18762/21803/… | 2/60 | 2 |
| R-MMU-194315 | Signaling by Rho GTPases | 0.096 | 0.029 | 0.011 | 0.011 | 100043813/101497/102098/102920/… | 1/60 | 1 |
| R-MMU-73887 | Death Receptor Signalling | 0.056 | 0.06 | 0.013 | 0.013 | 101497/102098/106025/109934/11491/ | 2/60 | 2 |
| R-MMU-8953854 | Metabolism of RNA | 0.533 | 0.002 | 0.024 | 0.021 | 100043813/100044627/100502825/… | 1/60 | 1 |

Each value is similar to an *enrichRes* object obtained by *clusterProfiler*.

In fact, Stouffer’s results are transformed as \*enrichRes\*\* objects and could be
used for usual *enrichRes* analysis and visualization functions.

Note in our *cytoscape-like case* that *geneID* column refers to all genes in
pathways or ontology named in database annotations. In usual *enrichRes*, this
column presents genes enriched contributing in pathways.

A graphical network is built according to this table as an **Enrichment Map**.

### 6.4.2 Multi-omics enrichment map

**Enrichment map** is a graph drawn to observe pathway or ontology
relationships according to overlapping elements in each parts.

Each pathway is a node and a bond is built between them if there have
common genes (see *Jaccard similarity coefficient - JC’s similarity* method).

Here, enrichment map functions from *enrichPlot* package are adapted to draw
similar map to **cytoscape** add-on
[*EnrichmentMap*](doi.org/10.1371/journal.pone.0013984):
all genes in each pathway are used to compute similarity between pathway
building network bonds.

![Enrichment Map from Stouffer p-values pooling method](data:image/png;base64...)
*Each multi-omics enrichment map (one by enrichment database) could be*
*retrieve in a report automatically generated and in the Home tab to be saved.*

# 7 Assumption tab

**Assumption tab** aims to help biological hypothesis making by *network
inference* from feature relationship values (e.g correlation,
partial correlation) and by a *PubMed module*.

You can find both functions:

* To compute **network inference** and to reveal feature relationships.
* To get **PubMed articles** based on your personalized query without leaving
  app.

```
require(multiSight)
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")
## omic2 is a multi-omics dataset of 2 simulated omics included in package
splitData <- splitDatatoTrainTest(omic2, 0.8)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build sPLS-DA models
# diabloRes <- runSPLSDA(data.train)
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Build biosigner models
biosignerRes <- runSVMRFmodels_Biosigner(data.train)
biosignerFeats <- biosignerRes$biosignature #selected features for each omic.

## Network inference
### DIABLO features
concatMat_diablo <- getDataSelectedFeatures(omic2, diabloFeats)
corrRes_diablo <- correlationNetworkInference(concatMat_diablo, 0.85)
pcorRes_diablo <- partialCorrelationNI(concatMat_diablo, 0.4)
miRes_diablo <- mutualInformationNI(concatMat_diablo, 0.2)

### biosigner features
concatMat_biosigner <- getDataSelectedFeatures(omic2, biosignerFeats)
corrRes_bios <- correlationNetworkInference(concatMat_biosigner, 0.85)
pcorRes_bios <- partialCorrelationNI(concatMat_biosigner, 0.4)
miRes_bios <- mutualInformationNI(concatMat_biosigner, 0.2)

corrRes_diablo$graph
```

# Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc 2.5:

```
## R version 4.1.0 (2021-05-18)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
## [1] org.Mm.eg.db_3.13.0  AnnotationDbi_1.54.0 IRanges_2.26.0
## [4] S4Vectors_0.30.0     Biobase_2.52.0       BiocGenerics_0.38.0
## [7] multiSight_1.0.0     BiocStyle_2.20.0
##
## loaded via a namespace (and not attached):
##   [1] rappdirs_0.3.3              ModelMetrics_1.2.2.2
##   [3] tidyr_1.1.3                 ggplot2_3.3.3
##   [5] bit64_4.0.5                 knitr_1.33
##   [7] multcomp_1.4-17             DelayedArray_0.18.0
##   [9] data.table_1.14.0           rpart_4.1-15
##  [11] KEGGREST_1.32.0             RCurl_1.98-1.3
##  [13] generics_0.1.0              metap_1.4
##  [15] cowplot_1.1.1               TH.data_1.0-10
##  [17] usethis_2.0.1               RSQLite_2.2.7
##  [19] mixOmics_6.16.0             shadowtext_0.0.8
##  [21] proxy_0.4-25                bit_4.0.4
##  [23] enrichplot_1.12.0           anyLib_1.0.5
##  [25] mutoss_0.1-12               xml2_1.3.2
##  [27] lubridate_1.7.10            httpuv_1.6.1
##  [29] SummarizedExperiment_1.22.0 assertthat_0.2.1
##  [31] viridis_0.6.1               gower_0.2.2
##  [33] xfun_0.23                   jquerylib_0.1.4
##  [35] evaluate_0.14               promises_1.2.0.1
##  [37] fansi_0.4.2                 igraph_1.2.6
##  [39] DBI_1.1.1                   geneplotter_1.70.0
##  [41] tmvnsim_1.0-2               htmlwidgets_1.5.3
##  [43] rWikiPathways_1.12.0        rARPACK_0.11-0
##  [45] purrr_0.3.4                 ellipsis_0.3.2
##  [47] RSpectra_0.16-0             ggnewscale_0.4.5
##  [49] dplyr_1.0.6                 backports_1.2.1
##  [51] bookdown_0.22               annotate_1.70.0
##  [53] MatrixGenerics_1.4.0        vctrs_0.3.8
##  [55] remotes_2.3.0               caret_6.0-88
##  [57] cachem_1.0.5                withr_2.4.2
##  [59] ggforce_0.3.3               checkmate_2.0.0
##  [61] treeio_1.16.0               ropls_1.24.0
##  [63] mnormt_2.0.2                DOSE_3.18.0
##  [65] ape_5.5                     lazyeval_0.2.2
##  [67] crayon_1.4.1                ellipse_0.4.2
##  [69] genefilter_1.74.0           labeling_0.4.2
##  [71] recipes_0.1.16              pkgconfig_2.0.3
##  [73] tweenr_1.0.2                GenomeInfoDb_1.28.0
##  [75] nlme_3.1-152                pkgload_1.2.1
##  [77] nnet_7.3-16                 rlang_0.4.11
##  [79] biosigner_1.20.0            lifecycle_1.0.0
##  [81] sandwich_3.0-1              downloader_0.4
##  [83] mathjaxr_1.4-0              randomForest_4.6-14
##  [85] rprojroot_2.0.2             polyclip_1.10-0
##  [87] matrixStats_0.58.0          graph_1.70.0
##  [89] Matrix_1.3-3                aplot_0.0.6
##  [91] zoo_1.8-9                   rjson_0.2.20
##  [93] png_0.1-7                   viridisLite_0.4.0
##  [95] bitops_1.0-7                shinydashboard_0.7.1
##  [97] pROC_1.17.0.1               Biostrings_2.60.0
##  [99] blob_1.2.1                  stringr_1.4.0
## [101] qvalue_2.24.0               reactome.db_1.76.0
## [103] scales_1.1.1                memoise_2.0.0
## [105] graphite_1.38.0             magrittr_2.0.1
## [107] plyr_1.8.6                  zlibbioc_1.38.0
## [109] compiler_4.1.0              scatterpie_0.1.6
## [111] RColorBrewer_1.1-2          plotrix_3.8-1
## [113] DESeq2_1.32.0               cli_2.5.0
## [115] XVector_0.32.0              patchwork_1.1.1
## [117] MASS_7.3-54                 tidyselect_1.1.1
## [119] stringi_1.6.2               yaml_2.2.1
## [121] GOSemSim_2.18.0             dockerfiler_0.1.3
## [123] locfit_1.5-9.4              ggrepel_0.9.1
## [125] grid_4.1.0                  sass_0.4.0
## [127] fastmatch_1.1-0             tools_4.1.0
## [129] rstudioapi_0.13             foreach_1.5.1
## [131] gridExtra_2.3               prodlim_2019.11.13
## [133] farver_2.1.0                ggraph_2.0.5
## [135] digest_0.6.27               rvcheck_0.1.8
## [137] BiocManager_1.30.15         shiny_1.6.0
## [139] lava_1.6.9                  networkD3_0.4
## [141] ppcor_1.1                   Rcpp_1.0.6
## [143] GenomicRanges_1.44.0        later_1.2.0
## [145] infotheo_1.2.0              httr_1.4.2
## [147] Rdpack_2.1.1                colorspace_2.0-1
## [149] XML_3.99-0.6                fs_1.5.0
## [151] splines_4.1.0               tidytree_0.3.3
## [153] sn_2.0.0                    graphlayouts_0.7.1
## [155] multtest_2.48.0             xtable_1.8-4
## [157] jsonlite_1.7.2              ggtree_3.0.0
## [159] tidygraph_1.2.0             corpcor_1.6.9
## [161] timeDate_3043.102           testthat_3.0.2
## [163] ipred_0.9-11                R6_2.5.0
## [165] TFisher_0.2.0               pillar_1.6.1
## [167] htmltools_0.5.1.1           mime_0.10
## [169] glue_1.4.2                  fastmap_1.1.0
## [171] clusterProfiler_4.0.0       DT_0.18
## [173] BiocParallel_1.26.0         easyPubMed_2.13
## [175] class_7.3-19                codetools_0.2-18
## [177] fgsea_1.18.0                mvtnorm_1.1-1
## [179] utf8_1.2.1                  lattice_0.20-44
## [181] bslib_0.2.5.1               tibble_3.1.2
## [183] numDeriv_2016.8-1.1         attempt_0.3.1
## [185] ReactomePA_1.36.0           config_0.3.1
## [187] GO.db_3.13.0                golem_0.3.1
## [189] survival_3.2-11             roxygen2_7.1.1
## [191] rmarkdown_2.8               desc_1.3.0
## [193] munsell_0.5.0               e1071_1.7-6
## [195] DO.db_2.9                   GenomeInfoDbData_1.2.6
## [197] iterators_1.0.13            reshape2_1.4.4
## [199] gtable_0.3.0                rbibutils_2.1.1
```