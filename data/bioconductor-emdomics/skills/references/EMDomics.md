# EMDomics Vignette

#### Sadhika Malladi and Daniel Schmolze

#### 2025-10-29

---

# Welcome

Welcome to the **EMDomics** package! This vignette will explain the functionality of the package through the creation and analysis of a toy data set.

# Earth Mover’s Distance

**EMDomics** analyzes differences in genomics data between groups of samples. Typically the data will be gene expression levels from array- or sequence-based experiments, but other scenarios are possible. In a real two-class experiment, the groups might be test vs. control, sensitive vs. resistant, etc. In a multi-class experiment (i.e., more than two groups of patients), groups may be associated with patients (in the case of single cell measurements) or disease subtypes. Typically you’ll be analyzing differences across multiple genes, but we’ll start with a single gene to get a feel for how the Earth Mover’s Distance (EMD) algorithm works. Note also that this package includes functionality for Komolgorov-Smirnov (K-S) and Cramer von Mises (CVM) distribution comparison tests. To access these tests, use `calculate_ks` or `calculate_cvm`. The input and output syntax is the same as `calculate_emd`, with “emd” being replaced with “ks” or “cvm” when accessing output values.

Because this package is **EMDomics** we will go through functionality with calculations for EMD, but K-S and CVM can be accessed with ease by replacing the function name.

We’ll create a vector of expression data for 100 samples. We’ll assign the first 50 to group “A,” the next 20 to group “B,” and the final 30 to group “C.” We will create a vector of group labels that describes which group each of the samples is a part of. Note that the vector of labels must have names corresponding to the sample identifiers in the data:

```
exp_data <- rnorm(100)
names(exp_data) <- paste("sample", 1:100)

groupA.labels <- rep("A",50)
groupB.labels <- rep("B",20)
groupC.labels <- rep("C",30)

labels <- c(groupA.labels, groupB.labels, groupC.labels)
names(labels) <- names(exp_data)
```

We’ll take a quick look at the three distributions using `ggplot`:

```
library(ggplot2)

df <- as.data.frame(exp_data)
df$group[1:50] <- "A"
df$group[51:70] <- "B"
df$group[71:100] <- "C"

ggplot(df, aes(exp_data, fill=group)) + geom_density(alpha=0.5)
```

![](data:image/png;base64...)

We shouldn’t expect the three groups to look too different, since we’re just sampling from the normal distribution. Intuitively, the “work” required to transform any one distribution into another should be low. We can calculate the EMD score for this single gene using the function `calculate_emd_gene`:

```
library(EMDomics)
calculate_emd_gene(exp_data, labels, names(exp_data))
```

```
## [1] 1.916667
```

Now we’ll modify the expression data for `group A` and see how the EMD score changes. We’ll randomly add or subtract 2 from each data point in `group A`:

```
exp_data2 <- exp_data
mod_vec <- sample(c(2,-2), 50, replace=TRUE)
exp_data2[1:50] <- exp_data2[1:50] + mod_vec
```

Let’s again visualize the distributions and calculate the EMD score:

```
df <- as.data.frame(exp_data2)
df$group[1:50] <- "A"
df$group[51:70] <- "B"
df$group[71:100] <- "C"

ggplot(df, aes(exp_data2, fill=group)) + geom_density(alpha=0.5)
```

![](data:image/png;base64...)

```
calculate_emd_gene(exp_data2, labels, names(exp_data2))
```

```
## [1] 7.28
```

The EMD score is larger, reflecting the increased work needed to transform one distribution into another. Note that since we have three classes defined, we aren’t able to tell from the EMD score alone which two groups (or, potentially, all three groups) demonstrate differences in gene behavior. The composite EMD score in a multi-class analysis is the average of all the pairwise EMD scores. The pairwise EMD scores are computed by comparing all possible combinations of two of the classes. More information on multi-class analysis is in the next section.

Note that in a two-class analysis, a greater EMD score is directly indicative of a greater difference between the measurement distributions of the two classes.

# Analyzing Significance

The EMD score increases as the distributions become increasingly dissimilar, but we have no framework for estimating the significance of a particular EMD score. **EMDomics** uses a permutation-based method to calculate a q-value that is interpreted analogously to a p-value. To access the full functionality of the package, we’ll use the function `calculate_emd`.

We’ll first create a matrix of gene expression data for 100 samples (tumors, patients, etc.) and 100 genes. We’ll just sample from the normal distribution for now. The first 50 samples will be our “group A,” second 20 will be “group B,” and the final 30 will be “group C.” Just as before, we will store these sample labels in a named vector associating group with sample identifier:

```
data <- matrix(rnorm(10000), nrow=100, ncol=100)
rownames(data) <- paste("gene", 1:100, sep="")
colnames(data) <- paste("sample", 1:100, sep="")

groupA.labels <- rep("A",50)
groupB.labels <- rep("B",20)
groupC.labels <- rep("C",30)

labels <- c(groupA.labels, groupB.labels, groupC.labels)
names(labels) <- colnames(data)
```

Now we can call `calculate_emd`. We’ll only use 10 permutations for the purposes of this vignette, but in actual experiments using at least 100 permutations is advised. For this example we will turn off parallel processing, but in general it should be enabled.

```
results <- calculate_emd(data, labels, nperm=10, parallel=FALSE)
```

Most of the time, you’ll be interested in the `emd` matrix returned as a member of the return object:

```
emd <- results$emd
head(emd)
```

```
##        emd   q-value
## gene1 2.16 0.5172414
## gene2 1.95 0.9523810
## gene3 1.54 1.0000000
## gene4 2.35 0.2222222
## gene5 1.93 1.0000000
## gene6 2.30 0.2857143
```

This matrix lists the emd score and the q-value for each gene in the data set. Because we’re not analyzing many genes and the data is randomly generated, there may be some significant q-values in the results simply by chance. We can order the `emd` matrix by q-value:

```
emd2 <- emd[(order(emd[,"q-value"])),]
head(emd2)
```

```
##             emd q-value
## gene14 2.933333       0
## gene25 2.800000       0
## gene32 2.653333       0
## gene45 3.130000       0
## gene51 3.466667       0
## gene77 4.416667       0
```

Note the correlation of significant q-values with relatively large EMD scores.

In a multi-class analysis, it may not be enough to know that a gene behaves differently somehow among the defined classes. We may be interested in finding which two classes display a greater difference in gene behavior, or if all three classes are somehow different. The differences between each of the classes is defined in the `pairwise.emd.table`. Note that EMD is not directional, so all possible combinations, not permutations, of the class labels are used in the pairwise EMD score calculations. Each of the columns represents a pairwise comparison (e.g. Group A vs Group B), each row represents a gene, and the cell content is the EMD score quantifying the work required to transform the distribution of one group into the other.

```
emd.pairwise <- results$pairwise.emd.table
head(emd.pairwise)
```

```
##       A vs B    A vs C    B vs C
## gene1   1.36 2.1600001 1.4000000
## gene2   1.23 1.1133333 1.9500000
## gene3   1.54 1.0533334 1.4666666
## gene4   2.35 0.8733333 1.7833334
## gene5   1.93 1.4466667 1.5166667
## gene6   1.90 2.3000000 0.9666666
```

# Visualization

**EMDomics** includes a few visualization functions. The function `plot_density` will display the density distributions of each of the groups for a given gene, along with the EMD score. We can compare the gene with the largest EMD score and the gene with the smallest EMD score, for example:

```
emd3 <- emd[(order(emd[,"emd"])),]
smallest_gene <- rownames(emd3)[1]
biggest_gene <- rownames(emd3)[nrow(emd3)]

plot_emd_density(results, smallest_gene)
```

![](data:image/png;base64...)

```
plot_emd_density(results, biggest_gene)
```

![](data:image/png;base64...)

Note that the EMD score is the average of the each of the pairwise EMD scores. This means that the smallest and largest EMD scores may have ambiguous meanings in a multi-class analysis. To understand how each class compares to the others, the `pairwise.emd.table` provides pairwise comparisons of gene behavior. These pairwise EMD scores will lend more insight into how the gene is similar or different across classes.

In a two-class analysis, the smallest score represents the gene that demonstrates the most similar behavior in both classes, and the largest score represents the gene that demonstrates the most different behavior in both classes.

We can plot a histogram of all the calculated EMD scores with the function `plot_emdperms`:

```
plot_emdperms(results)
```

![](data:image/png;base64...)

This plot can help intuitively understand the relative significance of an EMD score. For example, almost all the randomly permuted EMD scores are smaller than the largest calculated EMD score plotted above.

In a similar vein, the function `plot_emdnull` plots the null distribution (the median of the permuted EMD scores) for each gene vs. the calculated EMD score (the line x=y is superimposed in red):

```
plot_emdnull(results)
```

![](data:image/png;base64...)

# Wrapping Up

This concludes the **EMDomics** vignette. For additional information, please consult the reference manual.

# Session Info

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
## [1] EMDomics_2.40.0 ggplot2_4.0.0
##
## loaded via a namespace (and not attached):
##  [1] preprocessCore_1.72.0 gtable_0.3.6          jsonlite_2.0.0
##  [4] dplyr_1.1.4           compiler_4.5.1        tidyselect_1.2.1
##  [7] CDFt_1.2              parallel_4.5.1        dichromat_2.0-0.1
## [10] jquerylib_0.1.4       scales_1.4.0          emdist_0.3-3
## [13] BiocParallel_1.44.0   yaml_2.3.10           fastmap_1.2.0
## [16] R6_2.6.1              labeling_0.4.3        generics_0.1.4
## [19] knitr_1.50            tibble_3.3.0          bslib_0.9.0
## [22] pillar_1.11.1         RColorBrewer_1.1-3    rlang_1.1.6
## [25] cachem_1.1.0          xfun_0.53             sass_0.4.10
## [28] S7_0.2.0              cli_3.6.5             withr_3.0.2
## [31] magrittr_2.0.4        digest_0.6.37         grid_4.5.1
## [34] lifecycle_1.0.4       vctrs_0.6.5           evaluate_1.0.5
## [37] glue_1.8.0            farver_2.1.2          codetools_0.2-20
## [40] rmarkdown_2.30        matrixStats_1.5.0     tools_4.5.1
## [43] pkgconfig_2.0.3       htmltools_0.5.8.1
```