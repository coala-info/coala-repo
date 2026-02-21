# Microbial dIversity and Network Analysis with *mina*

#### Rui Guan

#### 2025-10-30

Abstract

With the help of rapidly developing sequencing technologies, an increasing number of microbiome datasets are generated and analysed. At present, diversity analysis of taxonomic profiling data is mainly conducted using composition-based methods, which ignores the interactions between community members and limits the study of community dynamics.The goal of *mina* is to provide a framework for microbial community analysis based on higher order community structures to better understand the principles that govern the establishment of those communities. In addition, a bootstrap-permutation based network comparison method was developed to compare global and local ecological networks and to statistically assess their dissimilarity. *mina* package version: 1.18.0

# Overview

The package is used for microbial profiling data analysis, including community similarity / dissimilarity / distance calculation and network comparison.

# Input data

*mina* package expects count data (e.g. OTU table or ASV table) to represent community profiling results and a descriptive table which indicates the information of each sample. In the quantitative table, each row contains one composition in the community and each column represents one profiled sample. In the descriptive table, same samples as rows in quantitative table should be included in the column “**Sample\_ID**”.

## Import data

Using `new()` to create a new object and then import data into the object. The new object could be generated and slots could be imported simultaneously:

```
    library(mina)
#>
#> Attaching package: 'mina'
#> The following object is masked from 'package:base':
#>
#>     norm
    # maize_asv2 and maize_des2 are subset of maize_asv and maize_des
    maize <- new("mina", tab = maize_asv2, des = maize_des2)
```

Please be aware that the descriptive table have to contain a column called “**Sample\_ID**” which includes the same samples indicated in the quantitative tables. See an example here:

```
    head(maize_des)
#>   Sample_ID Host_genotype Compartment Soil Management
#> 1     RT_1H         1_B73        root DEMO         NK
#> 2     RT_2H         1_B73        root DEMO         NK
#> 3     RT_3H         1_B73        root DEMO         NK
#> 4     RT_7H       2_DK105        root DEMO         NK
#> 5     RT_8H       2_DK105        root DEMO         NK
#> 6     RT_9H       2_DK105        root DEMO         NK
```

For the quantitative table, each column correspond to one sample indicated in the descriptive table and each row represent one composition in the community.

```
    maize_asv[1:6, 1:6]
#>           BK_481H BK_481H2 BK_482H BK_482H2 BK_483H BK_483H2
#> ASV_1          12        2       3        4       6        9
#> ASV_10          0        0       0        0       0        0
#> ASV_100         1        0       0        0       1        3
#> ASV_1000        1        1       3        1       0        0
#> ASV_10000       1        0       0        0       0        0
#> ASV_10001       0        0       0        0       0        0
```

## Check data format and tidy up

For the format of data, one could take a look at the data included in the package as indicated as before. After checking, if there is mismatch between quantitative and descriptive tables, `fit_tabs()` could be implied.

```
    maize <- fit_tabs(maize)
```

# Diversity analysis of the community

Typically the analysis of microbial community data includes estimating within and between sample diversities (alpha- and beta-diversity) based on compositions. By counting the number of observed compositions and evaluating the evenness of their distribution, alpha diversity of each community is quantified. Distance or dissimilarity between samples calculated from counts differentiation of compositions is used to indicate the beta diversity of community.

## Data normalization

Due to the varied sequencing depth, it is essential to normalize the data before the analysis of the diversity. Rarefaction and normalization by total sum are available here. For rarefaction, to reduce the random effect, multiple times bootstrap is recommended. The normalized table will be stored in the same *mina* object automatically when it were given as input.

```
    # check available normalization methods
    ? norm_tab_method_list
    # normalized by total sum
    maize <- norm_tab(maize, method = "total")
    # normalized by rarefaction
    maize <- norm_tab(maize, method = "raref", depth = 5000)
#> 270 samples removed for low depth
    # normalized by rarefaction and bootstrap 9 times
    maize <- norm_tab(maize, method = "raref", depth = 5000, multi = 9)
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
```

When given a matrix for normalization, the normalized matrix will be returned.

```
    # normalized by total sum
    maize_asv_norm <- norm_tab(maize_asv2, method = "total")
    # normalized by rarefaction
    maize_asv_norm <- norm_tab(maize_asv2, method = "raref", depth = 5000)
#> 270 samples removed for low depth
    # normalized by rarefaction and bootstrap 99 times
    maize_asv_norm <- norm_tab(maize_asv2, method = "raref", depth = 5000,
                               multi = 9)
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
#> 270 samples removed for low depth
```

## Community diversity

Based on the normalized quantitative table, distance / dissimilarity could be calculated between pairwise samples and used for beta-diversity analysis.

```
    # check available dissimilarity parameters
    ? com_dis_list
    # tidy the norm tab, intial tab and des tab
    maize <- fit_tabs(maize)
    # community dissimilarity calculation, Bray-Curtis used in example
    maize <- com_dis(maize, method = "bray")
    # TINA dissimilarity in Schmidt_et_al_2016
    # maize <- com_dis(maize, method = "tina")
```

For *TINA* dissimilarity described in Schmidt *et al.* 2017, in `com_dis()` function, *Spearman* correlation and weighted Jaccard was used by default, to calculate *TINA* with other options, use function `tina()`.

```
    # get the TINA dissimilarity of normalized quantitative table
    maize_tina <- tina(maize_asv_norm, cor_method = "spearman", sim_method =
                       "w_ja", threads = 80, nblocks = 400)
```

## Unexplained variance of community diversity

To evaluate the biological meaningful variance to noise ratio, the percentage of variance that could not be explained by any factors was calculated.

```
    # get the unexplained variance ratio of quantitative table according to the
    # group information indicated in descriptive table.
    com_r2(maize, group = c("Compartment", "Soil", "Host_genotype"))
#> [1] 0.519
    # use tables as input
    maize_dis <- dis(maize)
    get_r2(maize_dis, maize_des, group = c("Compartment", "Soil", "Host_genotype"))
#> [1] 0.519
```

## Community beta-diversity visualization

PCoA (Principle Coordinate Analysis) is usually used for the visualization of beta-diversity of microbial community data. By using different color and shape, samples from different conditions are compared.

```
    # dimensionality reduction
    maize <- dmr(maize)
    # plot the community beta-diversity
    # separate samples from different conditions by color, plot PCo1 and PCo2
    p1 <- com_plot(maize, match = "Sample_ID", color = "Compartment")
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the mina package.
#>   Please report the issue at <https://github.com/Guan06/mina>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
    # plot PCo3 and PCo4
    p2 <- com_plot(maize, match = "Sample_ID", d1 = 3, d2 = 4, color =
                    "Compartment")
    # in addition, separate samples from different soil type by shape
    p3 <- com_plot(maize, match = "Sample_ID", color = "Compartment", shape =
                    "Soil")
    # plot PCo1 and PCo4
    p4 <- com_plot(maize, match = "Sample_ID", d1 = 1, d2 = 4, color =
                    "Compartment", shape = "Soil")
```

When using dissimilarity matrix as input, the `dmr()` function is used to reduce the dimension of data and `pcoa_plot()` is used for plotting.

```
    maize_dmr <- dmr(maize_dis, k = 4)
    maize_des <- maize_des[maize_des$Sample_ID %in% rownames(maize_dis), ]
    p <- pcoa_plot(maize_dmr, maize_des, match = "Sample_ID", d1 = 3, d2 = 4,
                   color = "Host_genotype")
```

# Network inference and clustering

For the microbial community research, diversity analysis capture only static features and co-occurrence networks are typically inferred to indicate dynamics of the system.

## Correlation coefficient adjacency matrix

Correlation will be calculated according to the covariance of compositions across samples. When significance test is applied, `rcorr()` from `Hmisc`.

```
    # check available adjacency matrix
    ? adj_method_list
    # Pearson and Spearman correlation
    maize <- adj(maize, method = "pearson")
    # Pearson and Spearman correlation with significance test
    maize <- adj(maize, method = "spearman", sig = TRUE)
```

Also the function could be applied to matrix directly, the correlation between pairwise rows will be calculated.

```
    # Pearson and Spearman correlation
    asv_adj <- adj(maize_asv_norm, method = "pearson")
```

## Network clustering

By removing the non-significant(waiting for update) and weak correlations, the network of each adjacency matrix is generated and closely related nodes will be inferred by clustering methods. In the package, Markov Cluster Algorithm (MCL, Dongen, 2000) and Affinity Propagation (AP, Frey *et al*, 2007) are implemented for network clustering.

```
    # check available network clustering methods
    ? net_cls_list
#> No documentation for 'net_cls_list' in specified packages and libraries:
#> you could try '??net_cls_list'
    # network clustering by MCL
    maize <- net_cls(maize, method = "mcl", cutoff = 0.6)
#> 186 components are removed for clustering.
    # network clustering by AP
    maize <- net_cls(maize, method = "ap", cutoff = 0.6, neg = FALSE)
#> 186 components are removed for clustering.
```

Also it is possible to give a adjacency matrix directly and got the generated cluster data frame.

```
    # filter the weak correlation by cutoff and cluster by MCL
    asv_cls <- net_cls(asv_adj, method = "mcl", cutoff = 0.6)
#> 64 components are removed for clustering.
```

# Higher-order feature based diversity analysis

By accumulating the relative abundance of compositions belong to the same network clusters, the higher-order feature quantitative table is obtained and could be used for further diversity analysis. Besides, compositions belong to the same phylogenetic group could also be grouped together as new quantitative table.

## Higher-order quantitative table

According to the network cluster assignments, compositions belong to the same higher order level group are accumulated by summing up their relative abundances.

```
    # get the cluster table by summing up compositions of the same cluster
    maize <- net_cls_tab(maize)
#> Different number of components!
#> Filtering...
```

## Community diversity analysis and comparison

Same diversity analysis could be applied to cluster table and compared with composition based table.

```
    # dissimilarity between samples based on cluster table
    maize_cls_tab <- cls_tab(maize)
    maize_cls_dis <- com_dis(maize_cls_tab, method = "bray")
    get_r2(maize_cls_dis, maize_des, group = c("Compartment", "Soil",
                                               "Host_genotype"))
#> [1] 0.478
```

# Network comparison and statistical test

To compare the network of communities, pairwise distance between adjacency matrix, which present all connection information, are calculated. By substrate adjacency matrix (**A**) by the degree matrix (**D**), Laplacian matrix is obtained and the corresponding eigenvector and eigenvalues are calculated. Spectral distance then defined as the Euclidean distance between first *k* eigenvalues. Alternatively, Jaccard distance between matrix is implemented as dividing the sum of matrix contrast by the sum of larger absolute value between two adjacency matrices.

## Bootstrap-permutation based network construction

To be able to test the significance of distances between matrices, a bootstrap-permutation based method is developed. By subsampling and bootstrap, true correlation adjacency matrices were constructed from subset of original data. Then the metadata of samples is randomly swapped as permutated datasets, from which the pseudo correlation coefficient is calculated. By comparing the true adjacency matrices with the pseudo ones, the significance of distance is obtained.

```
    # compare the networks from different compartments
    maize <- fit_tabs(maize)
    maize <- bs_pm(maize, group = "Compartment")
    # only get the distance, no significance test
    maize <- bs_pm(maize, group = "Compartment", sig = FALSE)
```

When the composition number is big, the bootstrap-permutation could take very long time, thus pre-filtering is needed. `g_size` is the minimum number of samples for groups defined by `group`. Conditions with less than `g_size` would be removed for later analysis and this is set as 88 by default. `s_size` is the sub-sampling size for bootstrap and permutation, 30 by default. `s_size` should definitely smaller than `g_size` and preferably smaller than half of it. Also compositions appear in less than specific percentage of samples could be filtered by setting the occupancy threshold `per` and `rm`. By default, the compositions which present in less than 10% samples would be filtered. When the quantitative matrix is too big, one could choose to output the bootstrap and permutation results separately for each comparison.

```
    # set the size of group to remove consitions with less sample
    # also larger s_size will lead to more stable results but will consume more
    # computation and time resource
    maize <- bs_pm(maize, group = "Compartment", g_size = 200, s_size = 80)
    # remove the compositions appear in less than 20% of samples
    maize <- bs_pm(maize, group = "Compartment", per = 0.2)

    # set the bootstrap and permutation times. Again the more times bootstrap
    # and permutation, the more reliable the significance, with increased
    # computation and time resource.
    maize <- bs_pm(maize, group = "Compartment", bs = 11, pm = 11)

    # output the comparison separately to the defined directory
    bs_pm(maize, group = "Compartment", bs = 6, pm = 6,
    individual = TRUE, out_dir = out_dir)
```

## Network distance calculation and significance test

After getting the true and pseudo adjacency matrices, Spectral and Jaccard distance defined before is then calculated and p value is obtained by comparing the *F* (the real distance) and *Fp* (the pseudo distance) following the formula: p = \(\frac { C\_{F\_p > F} + 1 }{ N\_{dis} + 1 }\) For the individual generated network comparison results, the distance calculation is implemented by the function `net_dis_indi()`. Same methods are available.

```
    # check the available methods
    ? net_dis_method_list
    # calculate the distances between matrices
    maize <- net_dis(maize, method = "spectra")
    maize <- net_dis(maize, method = "Jaccard")
    # check the ditance results and significance (if applicable)
    dis_stat(maize)
    # the comparison stored separately in previous step
    ja <- net_dis_indi(out_dir, method = "Jaccard")
    dis_stat(ja)
    spectra <- net_dis_indi(out_dir, method = "spectra")
    dis_stat(spectra)
```