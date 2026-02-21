# PRObabilistic Pathway Scores (PROPS)

#### Lichy Han

#### 2025-10-30

This R package calculates PRObabilistic Pathway Scores (PROPS), which are pathway-based features, from gene-based data. For more information, see:

Lichy Han, Mateusz Maciejewski, Christoph Brockel, William Gordon, Scott B. Snapper, Joshua R. Korzenik, Lovisa Afzelius, Russ B. Altman. A PRObabilistic Pathway Score (PROPS) for Classification with Applications to Inflammatory Bowel Disease.

## Example Data

In the package, example healthy data and patient data are included. Note that each data frame is patient x gene, and the column names are by gene Entrez ID.

```
data(example_healthy)
example_healthy[1:5,1:5]
```

|  | 10 | 100 | 1000 | 10000 | 10005 |
| --- | --- | --- | --- | --- | --- |
| HealthySample1 | 6.993072 | 7.890769 | 1.187037 | 3.186920 | 2.243749 |
| HealthySample2 | 7.170742 | 5.786940 | 6.681429 | 4.765805 | 5.404951 |
| HealthySample3 | 4.458645 | 4.302536 | 3.893047 | 1.921196 | 8.437868 |
| HealthySample4 | 3.215118 | 5.515139 | 4.178101 | 6.063425 | 6.152115 |
| HealthySample5 | 4.456360 | 8.889095 | 6.342727 | 8.625195 | 2.956368 |

```
data(example_data)
example_data[1:5,1:5]
```

|  | 10 | 100 | 1000 | 10000 | 10005 |
| --- | --- | --- | --- | --- | --- |
| Sample1 | 3.848834 | 3.485361 | 5.650030 | 7.020021 | 3.996484 |
| Sample2 | 4.165301 | 1.808756 | 5.927112 | 10.229086 | 6.963043 |
| Sample3 | 4.874789 | 4.627511 | 6.410964 | 6.036542 | 4.334305 |
| Sample4 | 1.295941 | 4.173276 | 2.408115 | 4.329023 | 3.800146 |
| Sample5 | 8.924654 | 4.229810 | 3.939608 | 7.241261 | 5.378624 |

## Calculating PROPS using KEGG

KEGG edges have been included as part of this package, and will be used by default. To run PROPS, simply call the props command with the healthy data and the disease data.

```
props_features <- props(example_healthy, example_data)
props_features[1:5,1:5]
```

| pathway\_ID | Sample1 | Sample2 | Sample3 | Sample4 |
| --- | --- | --- | --- | --- |
| 00010.xml | -158.04258 | -158.32598 | -145.98850 | -146.00487 |
| 00020.xml | -66.17120 | -62.16094 | -68.88433 | -63.12966 |
| 00030.xml | -66.22571 | -64.21520 | -62.79041 | -66.15095 |
| 00040.xml | -75.33802 | -58.61511 | -64.90238 | -60.49886 |
| 00051.xml | -67.92010 | -68.43428 | -72.10788 | -72.97831 |

## Optional Batch Correction

As part of this package, we have included an optional flag to use ComBat via the sva package. Let us have two batches of data, where the first 50 samples from example\_healthy and first 20 samples from example\_data are from batch 1, and the remaining are from batch 2. Run the props command with batch\_correct as TRUE, followed by the batch numbers.

```
healthy_batches = c(rep(1, 25), rep(2, 25))
dat_batches = c(rep(1, 20), rep(2, 30))

props_features_batchcorrected <- props(example_healthy, example_data, batch_correct = TRUE, healthy_batches = healthy_batches, dat_batches = dat_batches)
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

```
props_features_batchcorrected[1:5,1:5]
```

| pathway\_ID | Sample1 | Sample2 | Sample3 | Sample4 |
| --- | --- | --- | --- | --- |
| 00010.xml | -156.63410 | -156.47363 | -144.31896 | -144.92005 |
| 00020.xml | -65.88403 | -61.90767 | -68.20912 | -62.55624 |
| 00030.xml | -65.99093 | -63.33211 | -61.63162 | -65.68156 |
| 00040.xml | -74.86549 | -58.33588 | -64.11862 | -60.10108 |
| 00051.xml | -67.54016 | -67.50353 | -71.28965 | -72.63510 |

## Calculating PROPS using User Input Pathways

A user can also input his or her own pathways, and thus our package is compatible with additional pathway databases and hand-curated pathways from literature or data. To do so, one needs to format the pathways into three columns, where the first column is the source or “from” node of the edge, the second column is the sink or “to” node of the edge, and the third column is the pathway ID (e.g. “glucose\_metabolism”).

```
data(example_edges)
example_edges[1:8, ]
```

| from | to | pathway\_ID |
| --- | --- | --- |
| 7476 | 8322 | pathway1 |
| 3913 | 3690 | pathway1 |
| 26060 | 836 | pathway1 |
| 163688 | 5532 | pathway1 |
| 84812 | 10423 | pathway1 |
| 57104 | 1056 | pathway1 |
| 9651 | 8396 | pathway1 |
| 3976 | 3563 | pathway1 |

Run props with the user specified edges as follows:

```
props_features_userpathways <- props(example_healthy, example_data, pathway_edges = example_edges)
props_features_userpathways[,1:5]
```

| pathway\_ID | Sample1 | Sample2 | Sample3 | Sample4 |
| --- | --- | --- | --- | --- |
| pathway1 | -370.3345 | -372.7717 | -397.3746 | -370.7386 |
| pathway2 | -355.6405 | -343.6026 | -354.3261 | -339.1284 |
| pathway3 | -357.4726 | -354.8797 | -352.8343 | -353.7832 |