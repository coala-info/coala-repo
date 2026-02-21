# Using the GADGETS method to detect epistatic maternally-mediated effects and maternal-fetal interactions

Michael Nodzenski1,2,3\*

1Department of Biostatistics, University of North Carolina, Chapel Hill, NC
2Graduate Partnerships Program, National Institutes of Health, Bethesda, MD
3Biostatistics and Computational Biology Branch, National Institute of Environmental Health Sciences, Research Triangle Park, NC

\*michael.nodzenski@gmail.com

#### November 9, 2022

#### Package

epistasisGA 1.12.0

# 1 Introduction

In addition to epistatic effects among child SNPs, the GADGETS method (Nodzenski\* et al. [2022](#ref-GADGET2020)) can search for genetic interactions associated with child disease that involve multiple maternal SNPs, or those involving a combination of maternal and child SNPs (Nodzenski et al. [2025](#ref-GADGETS2023)). We refer to the former as ‘epistatic maternally-mediated effects’ and the latter as ‘maternal-fetal interactions’. For full details of this application of GADGETS, analysts should consult Nodzenski et al. ([2025](#ref-GADGETS2023)). This vignette will demonstrate how to conduct such an analysis using the epistasisGA package. Users are encouraged to first consult the ‘GADGETS’ vignette for a detailed overview of the software options.

# 2 Example Analysis

## 2.1 Load Data

To search for maternal SNPs that are involved in genetic interactions associated with disease in the child, GADGETS requires case-parent triad data (i.e., it does not accommodate disease-discordant sibling studies). The method also relies on an assumption of ‘mating symmetry’ among the parents in the source population under study. Under mating symmetry, for any parental genotypes \(g\_1\) and \(g\_2\), mother/father pairs with genotypes \((g\_1, g\_2)\) should be as prevalent as those with genotypes \((g\_2, g\_1)\). GADGETS also assumes that no fetal SNP influences fetal survival. The validity of those assumptions should be assessed by the user.

We begin our example usage of GADGETS by loading a simulated example of case-parent triad data.

```
library(epistasisGA)
data(case.mci)
case <- as.matrix(case.mci)
data(dad.mci)
dad <- as.matrix(dad.mci)
data(mom.mci)
mom <- as.matrix(mom.mci)
data(snp.annotations.mci)
```

These data include a simulated maternal-fetal interaction involving one maternal-SNP and two child SNPs. The implicated maternal SNP genotypes are contained in column 6 of the input data, and risk-related child SNPs are in columns 12 and 18. In total, these data include 24 simulated loci, with columns 1-6, 7-12, 13-18, and 19-24 located on chromosomes 10, 11, 12, and 13, respectively. Note that the genotypes are coded as 0, 1, and 2, corresponding to counts of an analyst-designated variant allele. GADGETS does not currently accept genotype data imputed with uncertainty. In some genotypes are sporadically missing, those genotypes should be coded as NA. If one member of the triad, for instance the father, was not genotyped at all, that family should be excluded from analysis.

## 2.2 Format Input

GADGETS was first developed to mine for higher-order genetic interactions among offspring SNPs, where, for case-parent triad data, the case genotypes are compared to those of the ‘pseudo-sibling’. We define the pseudo-sibling as the parental genotypes that the case could have inherited, but did not (pseudo-sibling = mom + dad - case). We construct the pseudo-sibling genotypes for this example as follows:

```
pseudo.sib <- mom + dad - case
```

To also include maternal SNPs in the search, GADGETS treats the maternal genotypes like those of cases, and treats the paternal SNPs like those of controls. To create the required data inputs, we therefore combine the case and maternal genotypes, and, separately, the pseudo-sibling and paternal genotypes. Note that we need to align the input data so that SNPs that appear on chromosome 10 appear in the first set of columns, chromosome 11 next, etc., and, within the chromosome specific columns, the all child SNPs appear first, followed by all parental SNPs. We start by combing case and mother data:

```
input.case <- cbind(case[ , 1:6], mom[ , 1:6],
                    case[ , 7:12], mom[ , 7:12],
                    case[ , 13:18], mom[ , 13:18],
                    case[ , 19:24], mom[ , 19:24])
```

Then we combine pseudo-sibling and father:

```
input.control <- cbind(pseudo.sib[ , 1:6], dad[ , 1:6],
                    pseudo.sib[ , 7:12], dad[ , 7:12],
                    pseudo.sib[ , 13:18], dad[ , 13:18],
                    pseudo.sib[ , 19:24], dad[ , 19:24])
```

## 2.3 Pre-process Data

The second step in the analysis pipeline is to pre-process the data. This step requires the user to indicate which sets of SNPs in the input should be considered non-independent under the null. Below, we assume that all SNPs located on the same nominal chromosome, child or parent, should be considered non-independent (or ‘linked’). We indicate that as follows:

```
ld.block.vec <- rep(12, 4)
```

This vector indicates that the input genetic data has 4 distinct linkage blocks, with SNPs 1-12 in the first block, 13-24 in the second block, 25-36 in the third block, and 37-48 in the fourth block. Also note that, for instance, SNPs 1-12 comprise the 6 child SNPs on chromosome 10, followed by the 6 maternal SNPs on chromosome 10.

Now, we can execute pre-processing. Importantly, users need to indicate which columns in the ‘input.case’ data object contain maternal SNPs, and which contain child SNPs.

```
pp.list <- preprocess.genetic.data(case.genetic.data = input.case,
                                   complement.genetic.data = input.control,
                                   ld.block.vec = ld.block.vec,
                                   child.snps = c(1:6, 13:18, 25:30, 37:42),
                                   mother.snps = c(7:12, 19:24, 31:36, 43:48))
```

## 2.4 Run GADGETS

Once the input data has been properly formatted and pre-processed, GADGETS should be run exactly as described in the ‘GADGETS’ vignette. We encourage users to read through that vignette carefully for full details on how to implement the method and how to interpret results. Below, we show the computational commands, but do not comment extensively on the underlying intuition.

For this small example, we will search for interactions among 3 and 4 genetic loci. Note that, in the results returned, GADGETS may nominate as potentially interacting SNP-sets composed of only maternal SNPs, only child SNPs, or a combination. A nominated SNP-set containing only maternal SNPs suggests epistatic maternally-mediated effects, a set of only child loci suggests child-SNP epistasis, and a SNP-set containing both maternal and child SNPs could suggest a maternal-fetal interaction.

```
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

Now we condense the results using the function `combine.islands`. Note here that we need to provide annotations to match the
data input to the `preprocess.genetic.data` function, so each SNP will appear twice in the annotations (once for the child, and once for the mother).

```
snp.anno <- snp.annotations.mci[c(rep(1:6, 2),
                       rep(7:12, 2),
                       rep(13:18, 2),
                       rep(19:24, 2)), ]
size3.combined.res <- combine.islands("size3_res", snp.anno,
                                      pp.list)
size4.combined.res <- combine.islands("size4_res", snp.anno,
                                      pp.list)
```

Then we check the results for SNP-sets of three elements:

```
library(magrittr)
library(knitr)
library(kableExtra)
kable(head(size3.combined.res)) %>%
  kable_styling() %>%
  scroll_box(width = "750px")
```

| snp1 | snp2 | snp3 | snp1.rsid | snp2.rsid | snp3.rsid | snp1.risk.allele | snp2.risk.allele | snp3.risk.allele | snp1.diff.vec | snp2.diff.vec | snp3.diff.vec | snp1.allele.copies | snp2.allele.copies | snp3.allele.copies | fitness.score | n.cases.risk.geno | n.comps.risk.geno | chromosome | n.islands.found |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 12 | 18 | 30 | rs2296831 | rs10834232 | rs4766312 | T | C | C | 0.4293653 | 0.4619761 | 0.4423246 | 1+ | 1+ | 1+ | 4.813884 | 64 | 0 | 12.18.30 | 8 |

In this case, we see that input SNPs 12, 18, and 30 have been nominated as potentially interacting. These are the true risk-related SNPs: SNP 12 corresponds to the genotypes for maternal SNP 6 in the ‘mom.mci’ object, SNP 18 corresponds to SNP 12 in the ‘case.mci’ object, and SNP 30 corresponds to SNP 18 in the ‘case.mci’ object. In real, or larger, applications, we anticipate GADGETS will nominate multiple distinct SNP-sets for further follow-up study.

## 2.5 Post-hoc Tests

The post-hoc ‘global test’ of association, demonstrated in the ‘GADGETS’ vignette (function `global.test`), can also be applied to analyses that include maternal SNPs using the same commands. We do not repeat those here. When including maternal SNPs in the analysis, however, a small p-value from the global test could reflect the presence risk-related maternal SNPs, child SNPs, or both. Likewise, the ‘epistasis test’, also demonstrated in the ‘GADGETS’ vignette (function `epistasis.test`), can also be applied to probe evidence for interaction effects among the component SNPs of specific SNP-sets. For details on how to interpret results from the epistasis test in an analysis that includes maternal SNPs, users should refer to Nodzenski et al. ([2025](#ref-GADGETS2023)). Note that the software will report ‘p-values’ from `epistasis.test`, whereas Nodzenski\* et al. ([2022](#ref-GADGET2020)) and Nodzenski et al. ([2025](#ref-GADGETS2023)) report those instead as ‘h-values’. We use the term ‘h-value’ when `epistasis.test` is run using the same data as GADGETS because, even under a no-epistasis null hypothesis, the distribution of those ‘h-values’ will not be uniform. On the other hand, if `epistasis.test` is run on data independent from that used by GADGETS, the returned p-values can be used for valid hypothesis tests. In either case, a smaller value suggests more inconsistency with the no-epistasis (no-interaction) null hypothesis. Regardless, we do not demonstrate that specific functionality here and refer users to the ‘GADGETS’ vignette.

For SNP-sets that contain both maternal SNPs and child SNPs, where no maternal-SNP/child-SNP pair is located on the same nominal chromosome, we also offer an updated version of the epistasis test that is designed to reflect evidence for maternal-fetal interactions specifically. We demonstrate its usage below. Like the original epistasis test, the procedure is permutation-based, but the permutes are conducted in such a way that only joint maternal-fetal effects will be destroyed, and any other types of effects present in the SNP-set will be preserved. The caveats in interpretation for the epistasis test listed above still apply, particularly with respect to whether the resulting ‘p-value’ can be used for valid hypothesis testing. Here, because we have chosen the SNP-set to be tested based on GADGETS results and thereafter run the test on that same data, the software ‘p-value’ is actually an ‘h-value’.

We carry out the test as follows:

```
top.snps <- as.vector(t(size3.combined.res[1, 1:3]))
set.seed(10)
epi.test.res <- epistasis.test(top.snps, pp.list, maternal.fetal.test = TRUE)
epi.test.res$pval
```

```
## [1] 9.999e-05
```

The test indicates the observed fitness score is unusual under the assumption of no maternal-fetal interaction effects, consistent with the fact that we are applying the test to a SNP-set with a simulated maternal-fetal interaction effect. Users will receive a warning if this test is applied to a SNP-set where at least one maternal-SNP/child-SNP pairs located on the same chromosome, and a p-value of NA will be returned.

## 2.6 Visualize Results

The same network graphics demonstrated in the ‘GADGETS’ vignette are applicable here, with the same interpretation. However, we note that maternal SNPs are now represented by squares, while child SNPs remain circles. The shapes of the child SNP symbols is given by the first element in the vector passed to argument `node.shape` and the shapes of the maternal SNP symbols is the second element.

```
obs.res.list <- list(size3.combined.res, size4.combined.res)
set.seed(10)
graphical.scores <- compute.graphical.scores(obs.res.list, pp.list)
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 2,
             node.shape = c("circle", "square"))
```

![](data:image/png;base64...)

# Cleanup and sessionInfo()

```
#remove all example directories
lapply(c("size3_res", "size3_reg", "size4_res", "size4_reg"),
       unlink, recursive = TRUE)
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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] ggplot2_4.0.0      kableExtra_1.4.0   knitr_1.50         magrittr_2.0.4
## [5] epistasisGA_1.12.0 BiocStyle_2.38.0
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
##  [70] hms_1.1.4           scales_1.4.0        gtools_3.9.5
##  [73] base64url_1.4       glue_1.8.0          Hmisc_5.2-4
##  [76] tools_4.5.1         data.table_1.17.8   fs_1.6.6
##  [79] bigmemory_4.6.4     colorspace_2.1-2    nlme_3.1-168
##  [82] htmlTable_2.4.3     Formula_1.2-5       cli_3.6.5
##  [85] brew_1.0-10         rappdirs_0.3.3      textshaping_1.0.4
##  [88] bigmemory.sri_0.1.8 batchtools_0.9.18   viridisLite_0.4.2
##  [91] svglite_2.2.2       dplyr_1.1.4         corpcor_1.6.10
##  [94] glasso_1.11         gtable_0.3.6        sass_0.4.10
##  [97] digest_0.6.37       htmlwidgets_1.6.4   farver_2.1.2
## [100] htmltools_0.5.8.1   lifecycle_1.0.4
```

# References

Nodzenski\*, M., M. Shi\*, J. Krahn, A. S. Wise, Y. Li, L. Li, D. M. Umbach, and C. R. Weinberg. 2022. “GADGETS: A genetic algorithm for detecting epistasis using nuclear families.” *Bioinformatics* 38 (4): 1052–8.

Nodzenski, M., M. Shi, D. M. Umbach, B. Kidd, T. Petty, and C. R. Weinberg. 2025. “A method for finding epistatic effects of maternal and fetal variants.” *Frontiers in Genetics* 31 (16): 1420641.