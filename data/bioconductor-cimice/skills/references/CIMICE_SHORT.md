# Quick guide

#### Nicolò Rossi

#### 28/3/2020

## Reference for quick CIMICE analysis

In this short tutorial it is shown how to execute CIMICE’s analysis

### Read input

To load the input use `CIMICE::read` family functions or the pair `CIMICE::make_dataset`, `CIMICE::update_df` in the following manner:

```
# read from file
read_CAPRI(system.file("extdata", "example.CAPRI", package = "CIMICE", mustWork = TRUE))
```

```
# from a string
read_CAPRI_string("
s\\g A B C D
S1 0 0 0 1
S2 1 0 0 0
S3 1 0 0 0
S4 1 0 0 1
S5 1 1 0 1
S6 1 1 0 1
S7 1 0 1 1
S8 1 1 0 1
")
```

```
## 8 x 4 sparse Matrix of class "dgCMatrix"
##    A B C D
## S1 . . . 1
## S2 1 . . .
## S3 1 . . .
## S4 1 . . 1
## S5 1 1 . 1
## S6 1 1 . 1
## S7 1 . 1 1
## S8 1 1 . 1
```

```
# using CIMICE::make_dataset and CIMICE::update_df
# genes
make_dataset(A,B,C,D) %>%
    # samples
    update_df("S1", 0, 0, 0, 1) %>%
    update_df("S2", 1, 0, 0, 0) %>%
    update_df("S3", 1, 0, 0, 0) %>%
    update_df("S4", 1, 0, 0, 1) %>%
    update_df("S5", 1, 1, 0, 1) %>%
    update_df("S6", 1, 1, 0, 1) %>%
    update_df("S7", 1, 0, 1, 1) %>%
    update_df("S8", 1, 1, 0, 1)
```

```
## 8 x 4 Matrix of class "dgeMatrix"
##    A B C D
## S1 0 0 0 1
## S2 1 0 0 0
## S3 1 0 0 0
## S4 1 0 0 1
## S5 1 1 0 1
## S6 1 1 0 1
## S7 1 0 1 1
## S8 1 1 0 1
```

This last dataset will be use in this example, under the name of `example_dataset()`. Input dataset analysis and feature selection should be done at this point.

## Preprocess dataset

This early phase reorganizes the dataset to simplify further analysis.

```
preproc <- dataset_preprocessing(example_dataset())
samples <- preproc[["samples"]]
freqs   <- preproc[["freqs"]]
labels  <- preproc[["labels"]]
genes   <- preproc[["genes"]]
```

## Build topology

The default method to organize genotypes in a graph in CIMICE is based on the “subset” relation among them.

```
g <- graph_non_transitive_subset_topology(samples,labels)
```

![](data:image/png;base64...)

## Compute Weights

CIMICE provides a strategy to estimate transition probabilities among genotypes. This phase is divided in four different subphases that can be executed together in this way:

```
W <- compute_weights_default(g, freqs)
```

## Visualize output:

CIMICE supports many different output options, the recommended one is based on “visNetwork”.

```
out <- quick_run(example_dataset()) # quick_run summarizes all the previous steps
draw_visNetwork(out)
```