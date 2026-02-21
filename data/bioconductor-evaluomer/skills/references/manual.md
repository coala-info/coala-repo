# Evaluation of Bioinformatics Metrics with evaluomeR

José Antonio Bernabé-Díaz1, Manuel Franco2, Juana-María Vivo2, Manuel Quesada-Martínez3, Astrid Duque-Ramos4 and Jesualdo Tomás Fernández-Breis1

1Departamento de Informática y Sistemas, Universidad de Murcia, IMIB-Arrixaca, 30100, Murcia, Spain
2Departamento de Estadística e Investigación Operativa, Universidad de Murcia, 30100, Murcia, Spain
3Center of Operations Research (CIO), Miguel Hernández University of Elche, 03202, Elche, Spain
4Departamento de Sistemas, Facultad de Ingenierías, Universidad de Antioquia, Medellín, 050010, Colombia

#### 2021-03-09

#### Abstract

R package **evaluomeR** how-to guide

#### Package

evaluomeR 1.26.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 Prerequisites](#prerequisites)
* [3 Using evaluomeR](#using-evaluomer)
  + [3.1 Creating an input SummarizedExperiment](#creating-an-input-summarizedexperiment)
  + [3.2 Using input sample data from evaluomeR](#using-input-sample-data-from-evaluomer)
  + [3.3 Correlations](#correlations)
  + [3.4 Stability analysis](#stability-analysis)
    - [3.4.1 Stability](#stability)
    - [3.4.2 Stability range](#sec:stabilityrange)
  + [3.5 Goodness of classifications](#goodness-of-classifications)
    - [3.5.1 Quality](#quality)
    - [3.5.2 Quality range](#quality-range)
  + [3.6 General functionality](#general-functionality)
    - [3.6.1 Disabling plotting](#disabling-plotting)
* [4 Selecting the optimal value of k](#selecting-the-optimal-value-of-k)
* [5 Metric analysis](#metric-analysis)
* [6 Information](#information)
  + [6.1 Contact](#contact)
  + [6.2 License](#license)
  + [6.3 How to cite](#how-to-cite)
  + [6.4 Additional information](#additional-information)
  + [6.5 Session information](#session-information)
  + [Bibliography](#bibliography)

# 1 Introduction

The **evaluomeR** package permits to evaluate the reliability of bioinformatic
metrics by analysing the stability and goodness of the classifications of such
metrics. The method takes the measurements of the metrics for the dataset and
evaluates the reliability of the metrics according to the following analyses:
Correlations, Stability and Goodness of classifications.

* **Correlations**: Calculation of Pearson correlation coefficient between
  every pair of metrics available in order to quantify their interrelationship
  degree. The score is in the range [-1,1].

  + Perfect correlations: -1 (inverse), and 1 (direct).
* **Stability**: This analysis permits to estimate whether the clustering is
  meaningfully affected by small variations in the sample
  (Milligan and Cheng [1996](#ref-milligan1996measuring)). First, a clustering using the k-means algorithm is
  carried out. The value of K can be provided by the user. Then, the stability
  index is the mean of the Jaccard coefficient (Jaccard [1901](#ref-jaccard1901distribution))
  values of a number of bootstrap replicates. The values are in the range [0,1],
  having the following meaning:

  + Unstable: [0, 0.60[.
  + Doubtful: [0.60, 0.75].
  + Stable: ]0.75, 0.85].
  + Highly Stable: ]0.85, 1].
* **Goodness of classifications**: The goodness of the classifications are
  assessed by validating the clusters generated. For this purpose, we use the
  Silhouette width as validity index. This index computes and compares the
  quality of the clustering outputs found by the different metrics, thus
  enabling to measure the goodness of the classification for both instances and
  metrics. More precisely, this goodness measurement provides an assessment of
  how similar an instance is to other instances from the same cluster and
  dissimilar to the rest of clusters. The average on all the instances
  quantifies how the instances appropriately are clustered. Kaufman and
  Rousseeuw (Kaufman and Rousseeuw [2009](#ref-kaufman2009finding)) suggested the interpretation of the global
  Silhouette width score as the effectiveness of the clustering structure. The
  values are in the range [0,1], having the following meaning:

  + There is no substantial clustering structure: [-1, 0.25].
  + The clustering structure is weak and could be artificial: ]0.25, 0.50].
  + There is a reasonable clustering structure: ]0.50, 0.70].
  + A strong clustering structure has been found: ]0.70, 1].

# 2 Installation

The installation of **evaluomeR** package is performed via Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("evaluomeR")
```

## 2.1 Prerequisites

The package **evaluomeR** depends on the following CRAN packages for the
calculus: *cluster* (Maechler et al. [2018](#ref-cluster2018)), *corrplot*
(Wei and Simko [2017](#ref-corrplot2017)). Moreover, this package also depends on *grDevices*,
*graphics*, *stats* and *utils* from R Core (R Core Team [2018](#ref-rcore)) for plotting and on the
Bioconductor packages *SummarizedExperiment* (Morgan et al. [2018](#ref-summarizedExperiment)), *MultiAssayExperiment* (Ramos et al. [2017](#ref-multiAssayExperiment)) for
input/output data.

# 3 Using evaluomeR

## 3.1 Creating an input SummarizedExperiment

The input is a `SummarizedExperiment` object. The assay contained in
`SummarizedExperiment` must follow a certain structure, see Table
[1](#tab:table): A valid header must be specified. The first column of the
header is the ID or name of the instance of the dataset (e.g., ontology,
pathway, etc.) on which the metrics are measured. The other columns of the
header contains the names of the metrics. The rows contains the measurements
of the metrics for each instance in the dataset.

Table 1: Example of an input assay from a `SummarizedExperiment` for
the **evaluomeR** package.

| ID | MetricNameA | MetricNameB | MetricNameC | … |
| --- | --- | --- | --- | --- |
| instance1 | 1.2 | 6.4 | 0.5 | … |
| instance2 | 2.4 | 5.4 | 0.8 | … |
| instance3 | 1.9 | 8.9 | 1.1 | … |

## 3.2 Using input sample data from evaluomeR

In our package we provide three different sample input data:

* **ontMetrics**: Structural ontology metrics, 19 metrics measuring
  structural aspects of bio-ontologies have been analysed on two different
  corpora of ontologies: OBO Foundry and AgroPortal (Franco et al. [2019](#ref-ontoeval)).
* **rnaMetrics**: RNA quality metrics for the assessment of gene expression
  differences, 2 quality metrics from 16 aliquots of a unique batch of RNA
  Samples. The metrics are Degradation Factor (DegFact) and RNA Integrity Number
  (RIN) (Imbeaud et al. [2005](#ref-imbeaud2005towards)).
* **bioMetrics**: Metrics for biological pathways, 2 metrics that
  quantitative characterizations of the importance of regulation in biochemical
  pathway systems, including systems designed for applications in synthetic
  biology or metabolic engineering. The metrics are reachability and efficiency
  (Davis and Voit [2018](#ref-davis2018metrics)).

The user shall run the `data` built-in method to load **evaluomeR** sample input
data. This requires to provide the descriptor of the desired dataset. The
datasets availables can take the following values: “ontMetrics”, “rnaMetrics” or
“bioMetrics”.

```
library(evaluomeR)
data("ontMetrics")
data("rnaMetrics")
data("bioMetrics")
```

## 3.3 Correlations

We provide the `metricsCorrelations` function to evaluate the correlations among the
metrics defined in the `SummarizedExperiment`:

```
library(evaluomeR)
data("rnaMetrics")
correlationSE <- metricsCorrelations(rnaMetrics, margins =  c(4,4,12,10))
```

```
##
```

```
## Data loaded.
## Number of rows: 16
## Number of columns: 3
```

![](data:image/png;base64...)

```
# Access the correlation matrix via its first assay:
# assay(correlationSE,1)
```

## 3.4 Stability analysis

The calculation of the stability indices is performed by `stability` and
`stabilityRange` functions.

### 3.4.1 Stability

The stability index analysis is performed by the `stability` function. For
instance, running a stability analysis for the metrics of `rnaMetrics` with a
number of `100` bootstrap replicates with a k-means cluster whose `k` is 2
(note that `k` must be inside [2,15] range):

```
stabilityData <- stability(rnaMetrics, k=2, bs = 100)
```

The `stability` function returns the `stabilityData` object, a
`ExperimentList` that contains the several assays such as the stability mean or the mean, betweenss, totss, tot.swithinss and anova values from the `kmeans` clustering:

```
stabilityData
```

```
## ExperimentList class object of length 9:
##  [1] stability_mean: SummarizedExperiment with 2 rows and 2 columns
##  [2] cluster_partition: SummarizedExperiment with 2 rows and 2 columns
##  [3] cluster_mean: SummarizedExperiment with 2 rows and 2 columns
##  [4] cluster_centers: SummarizedExperiment with 2 rows and 2 columns
##  [5] cluster_size: SummarizedExperiment with 2 rows and 2 columns
##  [6] cluster_betweenss: SummarizedExperiment with 2 rows and 2 columns
##  [7] cluster_totss: SummarizedExperiment with 2 rows and 2 columns
##  [8] cluster_tot.withinss: SummarizedExperiment with 2 rows and 2 columns
##  [9] cluster_anova: SummarizedExperiment with 2 rows and 2 columns
```

The stability indices plots shown when `getImages = TRUE` are generated with the values of the stability mean:

```
assay(stabilityData, "stability_mean")
```

| Metric | Mean\_stability\_k\_2 |
| --- | --- |
| RIN | 0.82540873015873 |
| DegFact | 0.873916305916306 |

The plot represents the stability mean from each metric for a given `k` value.
This mean is calculated by performing the average of every stability index
from `k`ranges [1,k] for each metric.

### 3.4.2 Stability range

The `stabilityRange` function is an iterative method of `stability` function.
It performs a stability analysis for a range of `k` values (`k.range`).

For instance, analyzing the stability of `rnaMetrics` in range [2,4], with
`bs=100`:

```
stabilityRangeData = stabilityRange(rnaMetrics, k.range=c(2,4), bs = 100)
```

Two kind of graphs are plotted in `stabilityRange` function. The first type
(titled as “*St. Indices for k=X across metrics*”) shows, for every `k` value,
the stability indices across the metrics. The second kind (titled as
*St. Indices for metric ‘X’ in range [x,y]*), shows a plot of the behaviour of
each metric across the `k` range.

## 3.5 Goodness of classifications

There are two methods to calculate the goodness of classifications: `quality`
and `qualityRange`.

### 3.5.1 Quality

This method plots how the metrics behave for the current `k` value, according
to the average silhouette width. Also, it will plot how the clusters are
grouped for each metric (one plot per metric).
For instance, running a quality analysis for the two metrics of `rnaMetrics`
dataset, being `k=4`:

```
qualityData = quality(rnaMetrics, k = 4)
```

The data of the first plot titled as “*Qual. Indices for k=4 across metrics*”
according to *Silhouette avg. width*, is stored in *Avg\_Silhouette\_Width*
column from the first assay of the `SummarizedExperiment`, `qualityData`. The
other three plots titled by their metric name display the input rows grouped
by colours for each cluster, along with their Silhouette width scores.

The variable `qualityData` contains information about the clusters of each
metric: The average silhouette width per cluster, the overall average
sihouette width (taking into account all the clusters) and the number of
individuals per cluster:

```
assay(qualityData,1)
```

| Metric | Cluster\_1\_SilScore | Cluster\_2\_SilScore | Cluster\_3\_SilScore | Cluster\_4\_SilScore | Avg\_Silhouette\_Width | Cluster\_1\_Size | Cluster\_2\_Size | Cluster\_3\_Size | Cluster\_4\_Size |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| RIN | 0.473928571428572 | 0.324731573607137 | 0.696597735248404 | 0.420502645502646 | 0.488264943810529 | 5 | 3 | 4 | 4 |
| DegFact | 0.759196481622952 | 0.59496499852177 | 0.600198799385732 | 0.521618857725795 | 0.634170498361632 | 5 | 3 | 5 | 3 |

### 3.5.2 Quality range

The `qualityRange` function is an iterative method that uses the same
functionality of `quality` for a range of values (`k.range`), instead for one
unique `k` value. This methods allows to analyse the goodness of the
classifications of the metric for different values of the range.

In the next example we will keep using the `rnaMetrics` dataset, and a
`k.range` set to [4,6].

```
k.range = c(4,6)
qualityRangeData = qualityRange(rnaMetrics, k.range)
```

The `qualityRange` function also returns two kind of plots, as seen in
[Stability range](#sec:stabilityrange) section. One for each `k` in the
`k.range`, showing the quality indices (goodness of the classification) across
the metrics, and a second type of plot to show each metric with its respective
quality index in each `k` value.

The `qualityRangeData` object returned by `qualityRange` is a `ExperimentList` from
`MultiAssayExperiment`, which is a list of `SummarizedExperiment`
objects whose size is `diff(k.range)+1`. In the example shown above, the size of
`qualityRangeData` is 3, since the array length would contain the dataframes from
`k=4` to `k=6`.

```
diff(k.range)+1
```

```
## [1] 3
```

```
length(qualityRangeData)
```

```
## [1] 3
```

The user can access a specific dataframe for a given `k` value in three
different ways: by dollar notation, brackets notation or using our wrapper
method `getDataQualityRange`. For instance, if the user wishes to retrieve the
dataframe which contains information of `k=5`, being the `k.range` [4,6]:

```
k5Data = qualityRangeData$k_5
k5Data = qualityRangeData[["k_5"]]
k5Data = getDataQualityRange(qualityRangeData, 5)
assay(k5Data, 1)
```

| Metric | Cluster\_1\_SilScore | Cluster\_2\_SilScore | Cluster\_3\_SilScore | Cluster\_4\_SilScore | Cluster\_5\_SilScore | Avg\_Silhouette\_Width | Cluster\_1\_Size | Cluster\_2\_Size | Cluster\_3\_Size | Cluster\_4\_Size | Cluster\_5\_Size | Cluster\_position | Cluster\_labels |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| RIN | 0.523616734143049 | 0 | 0.674226581940152 | 0.420502645502646 | 0.251461988304093 | 0.451735613203479 | 4 | 1 | 4 | 4 | 3 | 2,1,1,1,1,5,5,5,3,3,3,3,4,4,4,4 |  |
| DegFact | 0.718287037037037 | 0.0375000000000007 | 0.904545454545454 | 0.521618857725795 | 0.585791823535685 | 0.578190921755929 | 4 | 2 | 2 | 3 | 5 | 1,1,2,1,1,3,2,3,5,5,5,5,5,4,4,4 |  |

Once the user believes to have found a proper `k` value, then the user can run
the `quality` function to see further silhouette information on the plots.

## 3.6 General functionality

In this section we describe a series of parameters that are shared among our
analysis functions: `metricsCorrelations`, `stability`, `stabilityRange`, `quality`
and `qualityRange`.

### 3.6.1 Disabling plotting

The generation of the images can be disabled by setting to `FALSE` the
parameter `getImages`:

```
stabilityData <- stability(rnaMetrics, k=5, bs = 50, getImages = FALSE)
```

This prevents from generating any graph, performing only the calculus. By
default `getImages` is set to `TRUE`.

# 4 Selecting the optimal value of k

`evaluomeR` analyzes the behavior of the metrics in terms of stability and goodness of the clusters for a range of values of \(k\). In case of wishing to select the optimal value for \(k\) for a metric in a given dataset we have implemented the `getOptimalKValue` function, which returns a table stating which is the optimal value of `k` for each metric.

The algorithm works as follows: The highest stability and the highest goodness are obtained for the same value of \(k\). In such case, that value would be the optimal one. On the other hand, the highest stability and the highest goodness are obtained for different values of \(k\). In this case, additional criteria are needed. does not currently aim at providing those criteria, but to provide the data that could permit the user to make decisions. In the use cases described in this paper, we will apply the following criteria for the latter case:

* If both values of \(k\) provide at least stable classifications (value >0.75), then we select the value of \(k\) that provides the largest Silhouette width. The same would happen if none provides stable classifications.
* If \(k\_1\) provides stable classifications and \(k\_2\) does not, we will select \(k\_1\) if the width of the Silhouette is at least reasonable.
* If \(k\_1\) provides stable classifications, \(k\_2\) does not, and the width of the Silhouette of \(k\_1\) is less than reasonable, then we will select the value of \(k\) with the largest Silhouette width.

```
stabilityData <- stabilityRange(data=ontMetrics, k.range=c(2,4),
                                bs=20, getImages = FALSE, seed=100)
qualityData <- qualityRange(data=ontMetrics, k.range=c(2,4),
                            getImages = FALSE, seed=100)

kOptTable <- getOptimalKValue(stabilityData, qualityData)
```

| Metric | Stability\_max\_k | Stability\_max\_k\_stab | Stability\_max\_k\_qual | Quality\_max\_k | Quality\_max\_k\_stab | Quality\_max\_k\_qual | Global\_optimal\_k |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ANOnto | 2 | 1.0000000 | 0.7548590 | 2 | 1.0000000 | 0.7548590 | 2 |
| AROnto | 4 | 0.9276802 | 0.8138336 | 4 | 0.9276802 | 0.8138336 | 4 |
| CBOOnto | 2 | 0.8786781 | 0.7193928 | 3 | 0.7897443 | 0.7231989 | 3 |
| CBOOnto2 | 2 | 0.8786781 | 0.7193928 | 3 | 0.7897443 | 0.7231989 | 3 |
| CROnto | 4 | 0.8450463 | 0.8450265 | 2 | 0.7831180 | 0.9643551 | 2 |
| DITOnto | 4 | 0.8228266 | 0.5933836 | 2 | 0.8129876 | 0.5971269 | 2 |
| INROnto | 2 | 0.9251030 | 0.7251026 | 2 | 0.9251030 | 0.7251026 | 2 |
| LCOMOnto | 3 | 1.0000000 | 0.6529131 | 3 | 1.0000000 | 0.6529131 | 3 |
| NACOnto | 2 | 0.8807614 | 0.7391430 | 2 | 0.8807614 | 0.7391430 | 2 |
| NOCOnto | 2 | 0.9478757 | 0.9431037 | 2 | 0.9478757 | 0.9431037 | 2 |
| NOMOnto | 2 | 0.8912204 | 0.6529583 | 3 | 0.8335419 | 0.6689736 | 3 |
| POnto | 2 | 1.0000000 | 0.7023466 | 2 | 1.0000000 | 0.7023466 | 2 |
| PROnto | 2 | 0.9941906 | 0.7065895 | 2 | 0.9941906 | 0.7065895 | 2 |
| RFCOnto | 2 | 0.8630298 | 0.6442806 | 2 | 0.8630298 | 0.6442806 | 2 |
| RROnto | 2 | 0.9941906 | 0.7065895 | 2 | 0.9941906 | 0.7065895 | 2 |
| TMOnto | 2 | 0.9664951 | 0.7331493 | 2 | 0.9664951 | 0.7331493 | 2 |
| TMOnto2 | 2 | 1.0000000 | 0.9493957 | 2 | 1.0000000 | 0.9493957 | 2 |
| WMCOnto | 2 | 0.9169334 | 0.9464120 | 2 | 0.9169334 | 0.9464120 | 2 |
| WMCOnto2 | 2 | 0.9208949 | 0.9467042 | 2 | 0.9208949 | 0.9467042 | 2 |

Additionally, you can select another subset of `k.range` to delimit the range of the optimal `k`.

```
kOptTable <- getOptimalKValue(stabilityData, qualityData, k.range=c(3,4))
```

```
## Processing metric: ANOnto
```

```
##  Stability k '4' is stable but quality k '3' is not
```

```
##  Using '4' since it provides higher stability
```

```
## Processing metric: AROnto
```

```
##  Maximum stability and quality values matches the same K value: '4'
```

```
## Processing metric: CBOOnto
```

```
##  Both Ks have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

```
## Processing metric: CBOOnto2
```

```
##  Both Ks have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

```
## Processing metric: CROnto
```

```
##  Both Ks have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

```
## Processing metric: DITOnto
```

```
##  Maximum stability and quality values matches the same K value: '4'
```

```
## Processing metric: INROnto
```

```
##  Stability k '4' is stable but quality k '3' is not
```

```
##  Using '4' since it provides higher stability
```

```
## Processing metric: LCOMOnto
```

```
##  Maximum stability and quality values matches the same K value: '3'
```

```
## Processing metric: NACOnto
```

```
##  Both Ks do not have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

```
## Processing metric: NOCOnto
```

```
##  Maximum stability and quality values matches the same K value: '3'
```

```
## Processing metric: NOMOnto
```

```
##  Maximum stability and quality values matches the same K value: '3'
```

```
## Processing metric: POnto
```

```
##  Stability k '4' is stable but quality k '3' is not
```

```
##  Using '4' since it provides higher stability
```

```
## Processing metric: PROnto
```

```
##  Maximum stability and quality values matches the same K value: '3'
```

```
## Processing metric: RFCOnto
```

```
##  Maximum stability and quality values matches the same K value: '3'
```

```
## Processing metric: RROnto
```

```
##  Maximum stability and quality values matches the same K value: '3'
```

```
## Processing metric: TMOnto
```

```
##  Both Ks have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

```
## Processing metric: TMOnto2
```

```
##  Both Ks have a stable classification: '3', '4'
```

```
##  Using '4' since it provides higher silhouette width
```

```
## Processing metric: WMCOnto
```

```
##  Both Ks have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

```
## Processing metric: WMCOnto2
```

```
##  Both Ks have a stable classification: '4', '3'
```

```
##  Using '3' since it provides higher silhouette width
```

| Metric | Stability\_max\_k | Stability\_max\_k\_stab | Stability\_max\_k\_qual | Quality\_max\_k | Quality\_max\_k\_stab | Quality\_max\_k\_qual | Global\_optimal\_k |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ANOnto | 4 | 0.7858551 | 0.7033107 | 3 | 0.6537009 | 0.7367429 | 4 |
| AROnto | 4 | 0.9276802 | 0.8138336 | 4 | 0.9276802 | 0.8138336 | 4 |
| CBOOnto | 4 | 0.8009833 | 0.5843870 | 3 | 0.7897443 | 0.7231989 | 3 |
| CBOOnto2 | 4 | 0.8009833 | 0.5843870 | 3 | 0.7897443 | 0.7231989 | 3 |
| CROnto | 4 | 0.8450463 | 0.8450265 | 3 | 0.8202259 | 0.8553226 | 3 |
| DITOnto | 4 | 0.8228266 | 0.5933836 | 4 | 0.8228266 | 0.5933836 | 4 |
| INROnto | 4 | 0.7889145 | 0.6095614 | 3 | 0.7404618 | 0.6909412 | 4 |
| LCOMOnto | 3 | 1.0000000 | 0.6529131 | 3 | 1.0000000 | 0.6529131 | 3 |
| NACOnto | 4 | 0.7076790 | 0.6271890 | 3 | 0.6647891 | 0.6613224 | 3 |
| NOCOnto | 3 | 0.8972253 | 0.8791838 | 3 | 0.8972253 | 0.8791838 | 3 |
| NOMOnto | 3 | 0.8335419 | 0.6689736 | 3 | 0.8335419 | 0.6689736 | 3 |
| POnto | 4 | 0.8464754 | 0.6763749 | 3 | 0.6300979 | 0.6766154 | 4 |
| PROnto | 3 | 0.9704167 | 0.6686449 | 3 | 0.9704167 | 0.6686449 | 3 |
| RFCOnto | 3 | 0.8192584 | 0.6352988 | 3 | 0.8192584 | 0.6352988 | 3 |
| RROnto | 3 | 0.9704167 | 0.6686449 | 3 | 0.9704167 | 0.6686449 | 3 |
| TMOnto | 4 | 0.9002443 | 0.6944084 | 3 | 0.8665560 | 0.7100906 | 3 |
| TMOnto2 | 3 | 0.9375096 | 0.7246579 | 4 | 0.8971283 | 0.7254086 | 4 |
| WMCOnto | 4 | 0.8539321 | 0.7370700 | 3 | 0.8151443 | 0.8285148 | 3 |
| WMCOnto2 | 4 | 0.8699698 | 0.7294024 | 3 | 0.7801632 | 0.8702324 | 3 |

# 5 Metric analysis

We provide a series of methods for a further analysis on the metrics. These methods are: `plotMetricsMinMax`, `plotMetricsBoxplot`, `plotMetricsCluster` and `plotMetricsViolin`.

The `plotMetricsMinMax` function plots the minimum, maximum and standard deviation of min/max points of the values of each metric:

```
plotMetricsMinMax(ontMetrics)
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the evaluomeR package.
##   Please report the issue at <https://github.com/neobernad/evaluomeR/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Use of `dataStats.df.t$Min` is discouraged.
## ℹ Use `Min` instead.
```

```
## Warning: Use of `dataStats.df.t$Max` is discouraged.
## ℹ Use `Max` instead.
```

```
## Warning: Use of `dataStats.df.t$Metric` is discouraged.
## ℹ Use `Metric` instead.
```

```
## Warning: Use of `dataStats.df.t$Min` is discouraged.
## ℹ Use `Min` instead.
```

```
## Warning: Use of `dataStats.df.t$Metric` is discouraged.
## ℹ Use `Metric` instead.
```

```
## Warning: Use of `dataStats.df.t$Max` is discouraged.
## ℹ Use `Max` instead.
```

```
## Warning: Use of `dataStats.df.t$Metric` is discouraged.
## ℹ Use `Metric` instead.
```

```
## Warning: Use of `dataStats.df.t$Max` is discouraged.
## ℹ Use `Max` instead.
```

```
## Warning: Use of `dataStats.df.t$Sd` is discouraged.
## ℹ Use `Sd` instead.
```

```
## Warning: Use of `dataStats.df.t$Max` is discouraged.
## ℹ Use `Max` instead.
```

```
## Warning: Use of `dataStats.df.t$Sd` is discouraged.
## ℹ Use `Sd` instead.
```

```
## Warning: Use of `dataStats.df.t$Metric` is discouraged.
## ℹ Use `Metric` instead.
```

```
## Warning: Use of `dataStats.df.t$Min` is discouraged.
## ℹ Use `Min` instead.
```

```
## Warning: Use of `dataStats.df.t$Sd` is discouraged.
## ℹ Use `Sd` instead.
```

```
## Warning: Use of `dataStats.df.t$Min` is discouraged.
## ℹ Use `Min` instead.
```

```
## Warning: Use of `dataStats.df.t$Sd` is discouraged.
## ℹ Use `Sd` instead.
```

```
## Warning: Use of `dataStats.df.t$Metric` is discouraged.
## ℹ Use `Metric` instead.
```

![](data:image/png;base64...)

The `plotMetricsBoxplot` method boxplots the value of each metric:

```
plotMetricsBoxplot(rnaMetrics)
```

```
## Warning: Use of `data.melt$variable` is discouraged.
## ℹ Use `variable` instead.
```

```
## Warning: Use of `data.melt$value` is discouraged.
## ℹ Use `value` instead.
```

```
## Ignoring unknown labels:
## • fill : "Metrics"
```

![](data:image/png;base64...)

Next, the `plotMetricsCluster` function clusters the values of the metrics by
using the euclidean distance and the method `ward.D2` from `hclust`:

```
plotMetricsCluster(ontMetrics)
```

![](data:image/png;base64...)

And finally the `plotMetricsViolin` function:

```
plotMetricsViolin(rnaMetrics)
```

```
## Warning: Use of `data.melt$variable` is discouraged.
## ℹ Use `variable` instead.
```

```
## Warning: Use of `data.melt$value` is discouraged.
## ℹ Use `value` instead.
```

```
## Warning: Use of `data.melt$variable` is discouraged.
## ℹ Use `variable` instead.
```

```
## Warning: Use of `data.melt$value` is discouraged.
## ℹ Use `value` instead.
```

```
## Ignoring unknown labels:
## • fill : "Metrics"
```

![](data:image/png;base64...)

# 6 Information

## 6.1 Contact

The source code is available at **github**. For bug/error reports please refer
to evaluomeR github issues <https://github.com/neobernad/evaluomeR/issues>.

## 6.2 License

The package ‘evaluomeR’ is licensed under GPL-3.

## 6.3 How to cite

Currently there is no literature for evaluomeR. Please cite the R package, the
github or the website. This package will be updated as soon as a citation is
available.

## 6.4 Additional information

The evaluomeR functionality can also be access through a web
interface111 [Evaluome web](http://sele.inf.um.es/evaluome/index.html) an API
REST222 [API documentation](https://documenter.getpostman.com/view/1705269/RznBMfbB).

## 6.5 Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] evaluomeR_1.26.0            sparcl_1.0.4
##  [3] RSKC_2.4.2                  flexclust_1.5.0
##  [5] flexmix_2.3-20              lattice_0.22-7
##  [7] randomForest_4.7-1.2        fpc_2.2-13
##  [9] cluster_2.1.8.1             MultiAssayExperiment_1.36.0
## [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] magrittr_2.0.4              kableExtra_1.4.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1     viridisLite_0.4.2    dplyr_1.1.4
##  [4] farver_2.1.2         S7_0.2.0             fastmap_1.2.0
##  [7] digest_0.6.37        lifecycle_1.0.4      kernlab_0.9-33
## [10] compiler_4.5.1       rlang_1.1.6          sass_0.4.10
## [13] tools_4.5.1          plotrix_3.8-4        yaml_2.3.10
## [16] corrplot_0.95        knitr_1.50           labeling_0.4.3
## [19] S4Arrays_1.10.0      mclust_6.1.1         DelayedArray_0.36.0
## [22] plyr_1.8.9           xml2_1.4.1           RColorBrewer_1.1-3
## [25] abind_1.4-8          withr_3.0.2          nnet_7.3-20
## [28] grid_4.5.1           ggplot2_4.0.0        scales_1.4.0
## [31] MASS_7.3-65          prabclus_2.3-4       tinytex_0.57
## [34] dichromat_2.0-0.1    cli_3.6.5            crayon_1.5.3
## [37] rmarkdown_2.30       rstudioapi_0.17.1    robustbase_0.99-6
## [40] reshape2_1.4.4       BiocBaseUtils_1.12.0 cachem_1.1.0
## [43] stringr_1.5.2        modeltools_0.2-24    parallel_4.5.1
## [46] BiocManager_1.30.26  XVector_0.50.0       vctrs_0.6.5
## [49] Matrix_1.7-4         jsonlite_2.0.0       bookdown_0.45
## [52] magick_2.9.0         systemfonts_1.3.1    diptest_0.77-2
## [55] jquerylib_0.1.4      ggdendro_0.2.0       glue_1.8.0
## [58] DEoptimR_1.1-4       stringi_1.8.7        gtable_0.3.6
## [61] tibble_3.3.0         pillar_1.11.1        htmltools_0.5.8.1
## [64] R6_2.6.1             textshaping_1.0.4    Rdpack_2.6.4
## [67] evaluate_1.0.5       rbibutils_2.3        bslib_0.9.0
## [70] class_7.3-23         Rcpp_1.1.0           svglite_2.2.2
## [73] SparseArray_1.10.0   xfun_0.53            pkgconfig_2.0.3
```

## Bibliography

Davis, Jacob D, and Eberhard O Voit. 2018. “Metrics for Regulated Biochemical Pathway Systems.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/bty942>.

Franco, Manuel, Juana María Vivo, Manuel Quesada-Martínez, Astrid Duque-Ramos, and Jesualdo Tomás Fernández-Breis. 2019. “Evaluation of ontology structural metrics based on public repository data.” *Bioinformatics*, February. <https://doi.org/10.1093/bib/bbz009>.

Imbeaud, Sandrine, Esther Graudens, Virginie Boulanger, Xavier Barlet, Patrick Zaborski, Eric Eveno, Odilo Mueller, Andreas Schroeder, and Charles Auffray. 2005. “Towards Standardization of Rna Quality Assessment Using User-Independent Classifiers of Microcapillary Electrophoresis Traces.” *Nucleic Acids Research* 33 (6): e56–e56.

Jaccard, Paul. 1901. “Distribution de La Flore Alpine Dans Le Bassin Des Dranses et Dans Quelques Regions Voisines.” *Bull Soc Vaudoise Sci Nat* 37: 241–72.

Kaufman, Leonard, and Peter J Rousseeuw. 2009. *Finding Groups in Data: An Introduction to Cluster Analysis*. Vol. 344. John Wiley & Sons.

Maechler, Martin, Peter Rousseeuw, Anja Struyf, Mia Hubert, Kurt Hornik, Matthias Studer, Pierre Roudier, Juan Gonzalez, and Kamil Kozlowski. 2018. *R Package "Cluster": "Finding Groups in Data": Cluster Analysis Extended Rousseeuw et Al"*. [https://cran.r-project.org/package=cluster](https://cran.r-project.org/package%3Dcluster).

Milligan, Glenn W, and Richard Cheng. 1996. “Measuring the Influence of Individual Data Points in a Cluster Analysis.” *Journal of Classification* 13 (2): 315–35.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2018. *SummarizedExperiment: SummarizedExperiment Container*.

Ramos, Marcel, Lucas Schiffer, Angela Re, Rimsha Azhar, Azfar Basunia, Carmen Rodriguez Cabrera, Tiffany Chan, et al. 2017. “Software for the Integration of Multi-Omics Experiments in Bioconductor.” *Cancer Research* 77(21); e39-42.

R Core Team. 2018. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <https://www.R-project.org/>.

Wei, Taiyun, and Viliam Simko. 2017. *R Package "Corrplot": Visualization of a Correlation Matrix*. <https://github.com/taiyun/corrplot>.