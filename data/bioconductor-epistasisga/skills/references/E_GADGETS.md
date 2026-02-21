# Detecting GxGxE interactions with case-parent triads using E-GADGETS

Michael Nodzenski1,2,3\*

1Department of Biostatistics, University of North Carolina, Chapel Hill, NC
2Graduate Partnerships Program, National Institutes of Health, Bethesda, MD
3Biostatistics and Computational Biology Branch, National Institute of Environmental Health Sciences, Research Triangle Park, NC

\*michael.nodzenski@gmail.com

#### December 28, 2022

#### Package

epistasisGA 1.12.0

# 1 Introduction

This vignette describes how to implement the E-GADGETS method using the epistasisGA package. The E-GADGETS method is used to mine genetic data from case-parent triads for higher-order gene-by-environment interactions, in which the joint effect of a set of single nucleotide polymorphisms (SNPs) depends on candidate non-genetic factors. We here refer to non-genetic factors as ‘environmental exposures’, or just ‘exposures’, regardless of whether those factors are actually agents encountered in the environment. For example, disease severity (i.e., high, medium, low) could be considered an ‘exposure’. Additionally, we here refer to gene-by-environment interactions that involve multiple SNPs as ‘GxGxE’ interactions, and those that also involve multiple exposures as ‘GxGxExE’ interactions. E-GADGETS is an extension of the previously described GADGETS method (Nodzenski\* et al. [2022](#ref-GADGET2020)), and we advise users to consult the ‘GADGETS’ vignette prior to this one for a more detailed explanation of how GADGETS, and by extension, E-GADGETS, works.

# 2 Implementing E-GADGETS

## 2.1 Load Data

We begin our demonstration of E-GADGETS by loading a simulated example of case-parent triad data. Note that E-GADGETS requires case-parent triads and, unlike GADGETS, does not accommodate disease-discordant siblings. In the example data, we load simulated maternal, paternal, and case genotypes, as well as the exposures. These data represent 24 SNPs from 1,000 families. Rows correspond to families, and columns represent SNP genotypes. Genotypes must be coded as 0, 1, or 2. The exposure is a binary factor with two levels (0, 1). In the input genotype data, SNPs 6, 12, and 18 are simulated to jointly interact with the exposure.

```
library(epistasisGA)
data("case.gxe")
case <- as.matrix(case.gxe)
data("dad.gxe")
dad <- as.matrix(dad.gxe)
data("mom.gxe")
mom <- as.matrix(mom.gxe)
data("exposure")
```

## 2.2 Pre-process Data

The second step is to pre-process the data. Below, we default to the assumption that SNPs located on the same biological chromosome are in linkage, but users can more carefully tailor this argument based on individual circumstances if desired. For the example data, the SNPs are drawn from chromosomes 10-13, with the columns sorted by chromosome, and 6 SNPs per chromosome. We therefore construct a vector as follows indicating this assumed linkage structure:

```
ld.block.vec <- rep(6, 4)
```

This vector indicates that the input genetic data has 4 distinct linkage blocks, with SNPs 1-6 in the first block, 7-12 in the second block, 13-18 in the third block, and 19-24 in the fourth block. Note the ordering of the columns in the input data must be consistent with the specified structure.

Now, we can execute pre-processing:

```
pp.list <- preprocess.genetic.data(case, father.genetic.data = dad,
                                   mother.genetic.data = mom,
                                   ld.block.vec = ld.block.vec,
                                   categorical.exposures = exposure)
```

Note that, above, the exposure data were input for the argument `categorical.exposures`. In doing so, the software will treat each input column as a factor variable and, ultimately, create dummy variables for each level. On the other hand, if the exposure of interest were continuous, users would need to specify the argument `continuous.exposures`, which will not dummy code the input. Strictly speaking, since the example exposure is binary, dummy coding would not be different from the existing coding, so we could have specified either argument.

Also note that E-GADGETS can, in principle, accept multiple exposures, but we have not fully tested that idea; specifically, if there are multiple exposures and at least one is continuous. If users nevertheless wish to input multiple exposures in which one or more exposures are continuous, they should be mindful that we have not tested the software in that context and interpret results with caution. With that said, if users are interested in simultaneous effects of both continuous and categorical exposures, the continuous data should be included for `continuous.exposures` and the categorical data should be specified for `categorical.exposures`.

## 2.3 Run E-GADGETS

We now run E-GADGETS to nominate SNP-sets whose joint effects appear to depend on the exposure using the `run.gadgets` function. A more detailed discussion of the `run.gadgets` function and its arguments is available in the ‘GADGETS’ vignette. Like GADGETS, E-GADGETS requires the user to pre-specify the number of SNPs that may jointly interact with the exposure, controlled by the `chromosome.size` argument. We recommend running the algorithm for a range of sizes (2-5 or 2-6), but for this small example, we will only consider 3-4.

```
set.seed(100)
run.gadgets(pp.list, n.chromosomes = 5, chromosome.size = 3,
       results.dir = "size3_res", cluster.type = "interactive",
       registryargs = list(file.dir = "size3_reg", seed = 1300),
       n.islands = 8, island.cluster.size = 4,
       n.migrations = 2)

run.gadgets(pp.list, n.chromosomes = 5, chromosome.size = 4,
       results.dir = "size4_res", cluster.type = "interactive",
       registryargs = list(file.dir = "size4_reg", seed = 1400),
       n.islands = 8, island.cluster.size = 4,
       n.migrations = 2)
```

Next, we condense the sets of results using the function `combine.islands`. Note that in addition to the results directory path, the function requires as input a data.frame indicating the rsIDs (or a placeholder name), reference, and alternate alleles for each SNP in the data passed to `preprocess.genetic.data` as well as the list output by `preprocess.genetic.data`.

```
data(snp.annotations.mci)
size3.combined.res <- combine.islands("size3_res", snp.annotations.mci,
                                      pp.list)
size4.combined.res <- combine.islands("size4_res", snp.annotations.mci,
                                      pp.list)
```

The E-GADGETS fitness score involves a standardization step, where the standardization is based on the fitness scores from 10,000 random SNP-sets and permutations of the exposure initiated at algorithm outset. The relevant means and standard deviations are stored in the `results.dir` directory, in the `null.mean.sd.info.rds` file. That information will be required to carry out permutation-based inferential procedures, demonstrated later.

We now examine the results:

```
library(magrittr)
library(knitr)
library(kableExtra)
kable(head(size3.combined.res)) %>%
  kable_styling() %>%
  scroll_box(width = "750px")
```

| snp1 | snp2 | snp3 | snp1.rsid | snp2.rsid | snp3.rsid | snp1.risk.allele | snp2.risk.allele | snp3.risk.allele | snp1.diff.vec | snp2.diff.vec | snp3.diff.vec | snp1.allele.copies | snp2.allele.copies | snp3.allele.copies | parent\_comp.exp1.beta | parent\_comp.exp2.beta | transmission\_comp.exp1.snp1.beta | transmission\_comp.exp1.snp2.beta | transmission\_comp.exp1.snp3.beta | transmission\_comp.exp2.snp1.beta | transmission\_comp.exp2.snp2.beta | transmission\_comp.exp2.snp3.beta | fitness.score | chromosome | n.islands.found |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 6 | 12 | 18 | rs2296831 | rs10834232 | rs4766312 | T | C | C | 0.5614679 | 0.5376147 | 0.640367 | 1+ | 1+ | 1+ | 0.4214377 | 2.090245 | -0.0541028 | -0.0180343 | -0.0162308 | 0.6155707 | 0.5556489 | 0.6565978 | 681.1244 | 6.12.18 | 8 |

We see that we have identified the correct SNPs with the simulated GxGxE effect. In this example, with just few input SNPs, E-GADGETS was able to identify only the correct SNP-set as risk-associated and no others. In real applications, we anticipate E-GADGETS will nominate multiple distinct SNP-sets for further follow-up study.

The elements of the output are similar to those from GADGETS. The most useful components are simply the identities of the SNPs in the nominated set(s). Similar to GADGETS, E-GADGETS suggests a risk associated allele for each SNP in the set; that nomination process is described in the E-GADGETS paper. Specifically note that the ‘diff.vec’ columns report the fitted mean genotype difference vector for the exposure level that appears most strongly associated with allele transmissions, the details of which are available in the E-GADGETS paper. For this vignette, it will suffice to mention that a positive value for a ‘diff.vec’ column suggests the variant allele for the corresponding SNP is more strongly risk associated than the reference allele, while a negative value suggests the reverse. Unlike GADGETS, E-GADGETS does not try to determine whether risk associated alleles follow a recessive pattern of inheritance, and instead automatically assumes that carrying one or more copies of the nominated allele is risk associated. (That is why the “allele.copies” columns are always “1+” for E-GADGETS, while they may be “1+” or “2” for GADGETS.) The `fitness.score` column does not have a straightforward interpretation except that SNP-sets with higher fitness presumably are more likely to have GxGxE effects.

A difference from GADGETS output is that E-GADGETS also outputs columns that start with “parent\_comp” and “transmission\_comp”. Those columns report the coefficients from the parental and transmission-based components of the fitness score, respectively. The two fitness score components are described in the E-GADGETS paper, and we refer readers to that manuscript for full details. In this example, our exposure has two levels, so the ‘parent\_comp.exp1.beta’ reports the model coefficient from the parental component associated with the first exposure level (here the value of the first exposure level is ‘0’) and the ‘parent\_comp.exp2.beta’ reports the coefficient associated with the second exposure level (here the value of the second exposure level is ‘1’). Likewise, the ‘transmission\_comp.exp1.snp1.beta’ column reports the coefficient from the transmission-based component associated with the first SNP in the SNP-set for the first level of the exposure, ‘transmission\_comp.exp1.snp2.beta’ the second SNP in the SNP-set, etc.

## 2.4 Run Permutation-based Tests

Like GADGETS, E-GADGETS has an associated global test of association. The test assesses the null hypothesis that, among top-scoring SNP-sets returned by E-GADGETS, none contain any GxE or GxGxE effects. The test is similar to that from GADGETS, except here, we shuffle the exposure, rather than randomizing case/complement-sibling labels, and then re-run E-GADGETS to generate a null distribution of fitness scores. Note that this test assumes the input SNPs are independent of the candidate exposure under the null.
We begin by creating 4 data sets with the observed exposure randomly re-assigned:

```
set.seed(1400)
permute.dataset(pp.list,
                permutation.data.file.path = "perm_data",
                n.permutations = 4)
```

Now we re-run E-GADGETS on each permuted data set. Note that we pass the same standardization information to `run.gadgets` as we used for the observed data.

```
#pre-process permuted data
preprocessed.lists <- lapply(seq_len(4), function(permutation){

  exp.perm.file <- file.path("perm_data",
                             paste0("exposure.permute", permutation, ".rds"))
  exp.perm <- readRDS(exp.perm.file)
  preprocess.genetic.data(case, father.genetic.data = dad,
                          mother.genetic.data = mom,
                          ld.block.vec = ld.block.vec,
                          categorical.exposures = exp.perm)
})

#specify chromosome sizes
chrom.sizes <- 3:4

#specify a different seed for each permutation
seeds <- 4:7

#run GADGETS for each permutation and size
perm.res <- lapply(chrom.sizes, function(chrom.size){

  # grab standardization info
  orig.res.dir <- paste0("size", chrom.size, "_res")
  st.info <- readRDS(file.path(orig.res.dir, "null.mean.sd.info.rds"))
  st.means <- st.info$null.mean
  st.sd <- st.info$null.se

  lapply(seq_len(4), function(permutation){

    perm.data.list <- preprocessed.lists[[permutation]]
    seed.val <- chrom.size*seeds[permutation]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    reg.dir <- paste0("perm", permutation, "_size", chrom.size, "_reg")
    run.gadgets(perm.data.list, n.chromosomes = 5,
           chromosome.size = chrom.size,
           results.dir = res.dir, cluster.type = "interactive",
           registryargs = list(file.dir = reg.dir, seed = seed.val),
           n.islands = 8, island.cluster.size = 4,
           n.migrations = 2, null.mean.vec = st.means,
           null.sd.vec = st.sd)

  })

})

#condense the results
perm.res.list <- lapply(chrom.sizes, function(chrom.size){

  lapply(seq_len(4), function(permutation){

    perm.data.list <- preprocessed.lists[[permutation]]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    combine.islands(res.dir, snp.annotations.mci, perm.data.list)

  })

})
```

After the null distribution of fitness scores has been generated, the global test of association can be run with exactly the same commands as GADGETS. The only difference is that, for E-GADGETS, the null hypothesis being tested is that none of the input SNPs interact with the exposure (either via GxE or GxGxE interactions). Note here that we base the test on the top chromosome of each size (`n.top.scores = 1`), but we recommend the default (`n.top.scores = 10`) for real applications.

```
# chromosome size 3 results

# function requires a list of vectors of
# permutation based fitness scores
chrom3.perm.fs <- lapply(perm.res.list[[1]],
                         function(x) x$fitness.score)
chrom3.list <- list(observed.data = size3.combined.res$fitness.score,
                     permutation.list = chrom3.perm.fs)

# chromosome size 4 results
chrom4.perm.fs <- lapply(perm.res.list[[2]],
                         function(x) x$fitness.score)
chrom4.list <- list(observed.data = size4.combined.res$fitness.score,
                     permutation.list = chrom4.perm.fs)

# list of results across chromosome sizes, with each list
# element corresponding to a chromosome size
final.results <- list(chrom3.list, chrom4.list)

# run global test
global.test.res <- global.test(final.results, n.top.scores = 1)
global.test.res$pval
```

```
## [1] 0.2
```

Aside from the global test, for a candidate SNP-set, we can also compute a p-value corresponding to the null hypothesis that none of the component SNPs interact with the exposure (via either GxE or GxGxE interactions). In this example, we choose the highest ranking E-GADGETS chromosome to test and thereafter run the test on the same data. Therefore, the ‘p-value’ generated by the software will not have uniform distribution under the null, and should not be used for hypothesis tests. We instead refer to it as an ‘h-value’. If the test were instead run on data independent from that used by E-GADGETS, the p-value would allow for valid inference. Regardless, smaller h-values indicate less consistency with the null.

We carry out the test as follows:

```
top.snps <- as.vector(t(size3.combined.res[1, 1:3]))
d3.st.info <- readRDS(file.path("size3_res/null.mean.sd.info.rds"))
d3.st.means <- d3.st.info$null.mean
d3.st.sd <- d3.st.info$null.se
set.seed(10)
GxE.test.res <- GxE.test(top.snps, pp.list,
                         null.mean.vec = d3.st.means,
                         null.sd.vec = d3.st.sd)
GxE.test.res$pval
```

```
## [1] 9.999e-05
```

The test indicates the SNP-set’s fitness score is inconsistent with what would be expected under the null.

## 2.5 Visualize Results

We visualize results from E-GADGETS using the same network-plotting approach as GADGETS, except larger SNP and SNP-pair scores now indicate evidence for involvement in GxE or GxGxE interactions for the implicated SNPs or pairs, rather than epistasis.

```
# vector of 95th percentile of null fitness scores max
chrom.size.thresholds <- global.test.res$max.perm.95th.pctl

# chromosome size 3 threshold
d3.t <- chrom.size.thresholds[1]

# chromosome size 4 threshold
d4.t <- chrom.size.thresholds[2]

# create results list
obs.res.list <- list(size3.combined.res[size3.combined.res$fitness.score >=
                                          d3.t, ],
                     size4.combined.res[size4.combined.res$fitness.score >=
                                          d4.t, ])

# list of standardization information for each chromosome size
d4.st.info <- readRDS(file.path("size4_res/null.mean.sd.info.rds"))
d4.st.means <- d4.st.info$null.mean
d4.st.sd <- d4.st.info$null.se
null.means.list <- list(d3.st.means, d4.st.means)
null.sds.list <- list(d3.st.sd, d4.st.sd)

set.seed(10)
graphical.scores <- compute.graphical.scores(obs.res.list, pp.list,
                                             null.mean.vec.list = null.means.list,
                                             null.sd.vec.list = null.sds.list)
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 2)
```

![](data:image/png;base64...)

# Cleanup and sessionInfo()

```
#remove all example directories
chrom.sizes <- 3:4
perm.reg.dirs <- as.vector(outer(paste0("perm", 1:4),
                                 paste0("_size", chrom.sizes, "_reg"),
                                 paste0))
perm.res.dirs <- as.vector(outer(paste0("perm", 1:4),
                                 paste0("_size", chrom.sizes, "_res"),
                                 paste0))
lapply(c("size3_res", "size3_reg", "size4_res", "size4_reg",
         perm.reg.dirs, perm.res.dirs,
         "perm_data"), unlink, recursive = TRUE)
```

```
#session information
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
## [1] kableExtra_1.4.0   knitr_1.50         magrittr_2.0.4     epistasisGA_1.12.0
## [5] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] mnormt_2.1.1        pbapply_1.7-4       gridExtra_2.3
##   [4] fdrtool_1.2.18      rlang_1.1.6         matrixStats_1.5.0
##   [7] compiler_4.5.1      png_0.1-8           systemfonts_1.3.1
##  [10] vctrs_0.6.5         reshape2_1.4.4      quadprog_1.5-8
##  [13] stringr_1.5.2       pkgconfig_2.0.3     crayon_1.5.3
##  [16] fastmap_1.2.0       backports_1.5.0     magick_2.9.0
##  [19] labeling_0.4.3      pbivnorm_0.6.0      rmarkdown_2.30
##  [22] tinytex_0.57        xfun_0.53           cachem_1.1.0
##  [25] jsonlite_2.0.0      progress_1.2.3      uuid_1.2-1
##  [28] BiocParallel_1.44.0 jpeg_0.1-11         psych_2.5.6
##  [31] parallel_4.5.1      lavaan_0.6-20       prettyunits_1.2.0
##  [34] cluster_2.1.8.1     R6_2.6.1            bslib_0.9.0
##  [37] stringi_1.8.7       RColorBrewer_1.1-3  rpart_4.1.24
##  [40] jquerylib_0.1.4     Rcpp_1.1.0          bookdown_0.45
##  [43] base64enc_0.1-3     Matrix_1.7-4        splines_4.5.1
##  [46] nnet_7.3-20         igraph_2.2.1        tidyselect_1.2.1
##  [49] rstudioapi_0.17.1   dichromat_2.0-0.1   abind_1.4-8
##  [52] yaml_2.3.10         codetools_0.2-20    qgraph_1.9.8
##  [55] lattice_0.22-7      tibble_3.3.0        plyr_1.8.9
##  [58] withr_3.0.2         S7_0.2.0            evaluate_1.0.5
##  [61] foreign_0.8-90      survival_3.8-3      xml2_1.4.1
##  [64] pillar_1.11.1       BiocManager_1.30.26 debugme_1.2.0
##  [67] checkmate_2.3.3     stats4_4.5.1        generics_0.1.4
##  [70] hms_1.1.4           ggplot2_4.0.0       scales_1.4.0
##  [73] gtools_3.9.5        base64url_1.4       glue_1.8.0
##  [76] Hmisc_5.2-4         tools_4.5.1         data.table_1.17.8
##  [79] fs_1.6.6            grid_4.5.1          bigmemory_4.6.4
##  [82] colorspace_2.1-2    nlme_3.1-168        htmlTable_2.4.3
##  [85] Formula_1.2-5       cli_3.6.5           brew_1.0-10
##  [88] rappdirs_0.3.3      textshaping_1.0.4   bigmemory.sri_0.1.8
##  [91] batchtools_0.9.18   viridisLite_0.4.2   svglite_2.2.2
##  [94] dplyr_1.1.4         corpcor_1.6.10      glasso_1.11
##  [97] gtable_0.3.6        sass_0.4.10         digest_0.6.37
## [100] htmlwidgets_1.6.4   farver_2.1.2        htmltools_0.5.8.1
## [103] lifecycle_1.0.4
```

# References

Nodzenski\*, M., M. Shi\*, J. Krahn, A. S. Wise, Y. Li, L. Li, D. M. Umbach, and C. R. Weinberg. 2022. “GADGETS: A genetic algorithm for detecting epistasis using nuclear families.” *Bioinformatics* 38 (4): 1052–8.