# INTACT: Integrate TWAS and Colocalization Analysis for Gene Set Enrichment Analysis

Jeffrey Okamoto1\* and Xiaoquan Wen1\*\*

1Department of Biostatistics, University of Michigan

\*jokamoto@umich.edu
\*\*xwen@umich.edu

#### 30 October 2025

#### Abstract

This package integrates colocalization probabilities from
colocalization analysis with transcriptome-wide association study (TWAS)
scan summary statistics to implicate genes that may be biologically relevant
to a complex trait. Given gene set annotations, this package can estimate
gene set enrichment using posterior probabilities from the
TWAS-colocalization integration step.

#### Package

INTACT 1.10.0

# 1 Installation

To install this package, run the following code chunk (in R 4.3 or later):

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("INTACT")
```

# 2 Methodology Reference

For a comprehensive description of the probabilistic framework behind INTACT
please refer to:

Okamoto, Jeffrey, et al. “Probabilistic integration of transcriptome-wide
association studies and colocalization analysis identifies key molecular
pathways of complex traits.” *The American Journal of Human Genetics* 110.1
(2023): 44-57.

# 3 Introduction

Integrative genetic association methods have shown great promise in post-GWAS
(genome-wide association study) analyses, in which one of the most challenging
tasks is identifying putative causal genes and uncovering molecular mechanisms
of complex traits. Prevailing computational approaches include
transcriptome-wide association studies (TWASs) and colocalization analysis.
TWASs aim to assess the correlation between predicted gene expression of a
target gene and a GWAS trait. Common output for TWASs include gene-level
z-statistics. Colocalization analysis attempts to determine whether genetic
variants that are causal for a molecular phenotype (such as gene expression)
overlap with variants that are causal for a GWAS trait. Common output for
colocalization analysis often include gene-level colocalization probabilities,
which provide evidence regarding whether there exists a colocalized variant
for the expression of a target gene and GWAS trait. Recent studies suggest that
TWASs and colocalization analysis are individually imperfect, but their joint
usage can yield robust and powerful inference results. INTACT is a computational
framework to integrate probabilistic evidence from these distinct types of
analyses and implicate putative causal genes. This procedure is flexible and can
work with a wide range of existing integrative analysis approaches. It has the
unique ability to quantify the uncertainty of implicated genes, enabling
rigorous control of false-positive discoveries. INTACT-GSE is an efficient
algorithm for gene set enrichment analysis based on the integrated probabilistic
evidence. This package is intended for performing integrative genetic
association analyses in tandem with other Bioconductor packages such as
`biomaRt` or `GO.db`, which could be used to obtain gene set annotations for
gene set enrichment analysis.

# 4 Included Data Sets

To illustrate the functionality of the `INTACT` package, we include a
simulated data set `simdat`. See the methodology reference for an
explanation of the simulation design. The data is organized as a 1197 row by
3 column data frame, where rows correspond to genes, the GLCP column provides

Additionally, we include a simulated gene set list `gene_set_list`,
which contains two gene sets. The first gene set has 503 gene members and is
significantly enriched among the genes included in `simdat`, based on the
probabilistic INTACT output. The second gene set has 200 gene members and is
not enriched among the `simdat` genes. We include `gene_set_list` to
show how to perform gene set enrichment estimation using INTACT-GSE.

# 5 INTACT: Integrating TWAS Scan and Colocalization Analysis Results

The first main functionality of this package is integrating results from a
transcriptome-wide association study (TWAS) scan and a colocalization analysis.
The TWAS scan results must be in the form of gene-level z scores, and the
colocalization analysis results should be in the form of gene-level
colocalization probabilities. These are provided as output by most popular TWAS
and colocalization methods. Some TWAS methods that we utilize in our work are
[PTWAS](https://github.com/xqwen/ptwas),
[PrediXcan](https://github.com/hakyimlab/PrediXcan), and
[SMR](https://yanglab.westlake.edu.cn/software/smr/#Overview). We
recommend using [fastENLOC](https://github.com/xqwen/fastenloc) for
colocalization analysis, as it estimates enrichment of QTL among
GWAS hits and does not require specification of prior probabilities.

Below, we include an example of how to use INTACT to integrate TWAS scan and
colocalization results for a simulated data set `simdat`.

```
library(INTACT)
```

```
##
## Attaching package: 'INTACT'
```

```
## The following object is masked from 'package:stats':
##
##     step
```

```
data(simdat)

rst <- INTACT::intact(GLCP_vec=simdat$GLCP,
                      z_vec=simdat$TWAS_z)
```

The `intact` function takes a vector of gene-level colocalization
probabilities `GLCP_vec` and TWAS scan z-scores `z_vec`. It outputs
gene-level posterior probabilities of putative causality. The example included
above uses default settings for the prior function and truncation threshold
\(t\) (`prior_fun = linear` and `t=0.05`). There are three additional
prior functions implemented in the `INTACT` software, including `expit`,
`step`, and `hybrid`. The `expit` and `hybrid` options have an
additional curvature shrinkage parameter `D`, with a default value of 0.1.
The default truncation parameter value for the step prior function is 0.5,
while the default value is 0.05 for all other prior functions. Below are three
additional examples of how to integrate the TWAS z scores and colocalization
probabilies from the simulated data using different prior function, truncation
threshold, and curvature shrinkage settings:

```
rst1 <- INTACT::intact(GLCP_vec=simdat$GLCP,
                       prior_fun=INTACT::expit,
                       z_vec = simdat$TWAS_z,
                       t = 0.02,D = 0.09)
rst2 <- INTACT::intact(GLCP_vec=simdat$GLCP,
                       prior_fun=INTACT::step,
                       z_vec = simdat$TWAS_z,
                       t = 0.49)
rst3 <- INTACT::intact(GLCP_vec=simdat$GLCP,
                       prior_fun=INTACT::hybrid,
                       z_vec = simdat$TWAS_z,
                       t = 0.49,D = 0.05)
```

If the user wishes to specify TWAS Bayes factors instead of z-scores, they can
do so through the argument `twas_BFs`. The Bayes factors should be a numeric
vector with genes in the same order as the colocalization probabilities vector.
If the user wishes to specify gene-specific TWAS priors, they can do so through
the argument `twas_priors`. If no input is supplied, INTACT computes a
scalar prior using the TWAS data (see the methodology reference for more
details).

We provide an additional function `fdr_rst` that is useful if the user wishes
to perform Bayesian FDR control on the INTACT output. An example of how to
apply this function at a target control level of 0.05 is shown below.

```
fdr_example <- fdr_rst(rst1, alpha = 0.05)
head(fdr_example)
```

```
##   posterior  sig
## 1         1 TRUE
## 2         1 TRUE
## 3         1 TRUE
## 4         1 TRUE
## 5         1 TRUE
## 6         1 TRUE
```

# 6 INTACT-GSE: Gene Set Enrichment Estimation Using INTACT results

The `INTACT` package provides the `intactGSE` function to perform gene
set enrichment estimation and inference using integrated TWAS scan z-scores and
colocalization probabilities. This function requires a data frame
`gene_data` containing gene names and corresponding colocalization
probabilities and TWAS z-scores for each gene. Column names should be “gene”,
“GLCP”, and “TWAS\_z’. If the user wishes to specify TWAS Bayes factors instead
of z-scores, use the column name”TWAS\_BFs“. If the user wishes to specify
gene-specific TWAS priors, use the column name”TWAS\_priors".

In addition to `gene_data`, the user must provide a list of gene sets
`gene_sets`. The format of `gene_sets` must match the included example
`gene_set_list`: it must named list of gene sets for which enrichment is to
be estimated. List items should be character vectors of gene IDs. Gene ID format
should match the gene column in `gene_data`.

The user can specify the same prior-related arguments as in the `intact`
function, including `prior_fun`, `t`, and `D`(only when the
prior function is specified as `expit` or `hybrid`).

The user can specify the method by which the standard error of the enrichment
estimate is computed. Options include a numerical differentiation of the score
function (default): `NDS`; a profile likelihood approach:
`profile_likelihood`, and bootstrapping: `bootstrap`. For hypothesis
testing, the user can specify a significance threshold, which is 0.05 by
default.

An example of how to estimate gene set enrichment in the gene sets provided in
`gene_set_list` (using default settings) is shown below:

```
data(gene_set_list)
INTACT::intactGSE(gene_data = simdat,gene_sets = gene_set_list)
```

```
##    Gene_Set    Estimate        SE           z         pval CI_Leftlim
## 1 gene_set1  1.01981520 0.1808068  5.64035913 1.696958e-08  0.6654404
## 2 gene_set2 -0.01650172 0.2314519 -0.07129655 9.431617e-01 -0.4701391
##   CI_Rightlim CONVERGED
## 1   1.3741900         1
## 2   0.4371357         1
```

The output of `intactGSE` includes one row per gene set and eight columns:
the gene set name, the enrichment parameter \(\alpha\_1\) estimate, the enrichment
parameter estimate standard error, the z-score, the p-value, the left and right
CIs, and the convergence flag (if CONVERGED = 1, then the enrichment estimation
algorithm converged. If not, CONVERGED = 0). Some data sets are not informative
for gene set enrichment estimation; in this case, the algorithm will fail to
converge. We emphasize that failure of the algorithm to converge does not
provide information regarding the enrichment (or lack thereof) for a given
gene set.

Finally, we include three additional examples of how to estimate enrichment for
the same data sets using non-default prior parameters:

```
INTACT::intactGSE(gene_data = simdat,prior_fun = INTACT::step,
                  t = 0.45,gene_sets = gene_set_list)
```

```
##    Gene_Set   Estimate        SE          z         pval CI_Leftlim CI_Rightlim
## 1 gene_set1  0.9897163 0.1828463  5.4128322 6.203562e-08  0.6313442   1.3480884
## 2 gene_set2 -0.1320656 0.2404421 -0.5492617 5.828259e-01 -0.6033235   0.3391922
##   CONVERGED
## 1         1
## 2         1
```

```
INTACT::intactGSE(gene_data = simdat,prior_fun = INTACT::expit,
                  t = 0.08,D = 0.08, gene_sets = gene_set_list)
```

```
##    Gene_Set   Estimate        SE          z         pval CI_Leftlim CI_Rightlim
## 1 gene_set1  1.0198388 0.1818588  5.6078591 2.048446e-08  0.6634020   1.3762756
## 2 gene_set2 -0.0424509 0.2348399 -0.1807652 8.565518e-01 -0.5027287   0.4178269
##   CONVERGED
## 1         1
## 2         1
```

```
INTACT::intactGSE(gene_data = simdat,prior_fun = INTACT::hybrid,
                  t = 0.08,D = 0.08, gene_sets = gene_set_list)
```

```
##    Gene_Set    Estimate        SE          z         pval CI_Leftlim
## 1 gene_set1  1.02016151 0.1822905  5.5963496 2.189120e-08  0.6628786
## 2 gene_set2 -0.04068458 0.2351970 -0.1729809 8.626665e-01 -0.5016622
##   CI_Rightlim CONVERGED
## 1   1.3774444         1
## 2   0.4202931         1
```

# 7 Integrating Additional Gene Product Data

Although INTACT achieves higher power than colocalization alone and better
false discovery control than TWAS alone, it is not robust to scenarios in which
a causal gene impacts the complex trait, but not through gene expression.
Motivated by recent protein and splicing QTL studies suggesting these scenarios
are quite common, we introduce Multi-INTACT, an empirical Bayes framework that
extends the INTACT model to jointly consider multiple molecular gene products
(e.g. encoded RNA transcript levels and protein levels). Multi-INTACT comprises
two stages: a scanning stage and model selection stage. The scanning stage
integrates GWAS results and QTL data for two or more molecular gene products
to implicate putative causal genes. The model selection stage aims to determine
which of the measured molecular gene products for a gene implicated in the
scanning stage directly affects the complex trait-of-interest. We employ a
Bayesian procedure to compare possible underlying molecular mechanisms using
probabilistic evidence. While leveraging additional molecular gene product
information, Multi-INTACT shares strengths with INTACT such as computational
efficiency and probabilistic uncertainty quantification for causal gene
nomination. This implementation of Multi-INTACT can jointly consider up to
2 molecular gene products at a time.

# 8 Included Data Sets to Demonstrate Multi-INTACT Functionality

To illustrate the functionality of the Multi-INTACT functions, we include a
simulated data set `multi_simdat`. See the methodology reference for an
explanation of the simulation design. The data is organized as a 1197 row by
6 column data frame, where rows correspond to genes, the `GLCP_1` and `GLCP_2`
columns provide pairwise gene-level colocalization probabilities (between the
complex trait/gene expression and complex trait/protein levels, respectively),
`z_1` and `z_2` columns provide TWAS and protein-TWAS (PWAS) z-scores,
respectively, and `chisq` provides multivariate Wald chi-square test statistics
from the joint regression of the complex trait on predicted protein and
expression levels.

If individual-level data are available, recommend using the function `wald.test`
from the `aod` package in order to generate the chi-square test statistics. If
individual-level data are not available, it is still possible to approximate the
statistic. We include simulated data sets `ld_sumstats`, `exprwt_sumstats`,
`protwt_sumstats`, `z_sumstats`, to show how to approximate the multivariate
Wald statistic using summary-level data.

# 9 Estimating the Chi-square Statistic From Summary-level Data

To estimate the chi-square statistic, for each candidate gene, we will need a
set of SNPs used to predict each gene product level, an estimated linkage
disequilibrium (LD) correlation matrix for these SNPs, and prediction weights
for each gene product type, and TWAS z-scores for each gene product type.
The example data `ld_sumstats` contains the LD matrix, `exprwt_sumstats` and
`protwt_sumstats` contain TWAS and PWAS prediction weights, and `z_sumstats`
contains the TWAS and PWAS z-scores for the candidate gene.

To estimate the chi-square statistic, run:

```
data(z_sumstats)
data(exprwt_sumstats)
data(protwt_sumstats)
data(ld_sumstats)

INTACT::chisq_sumstat(z_vec = z_sumstats,
              w = cbind(protwt_sumstats,exprwt_sumstats),
              R = ld_sumstats)
```

```
##          [,1]
## [1,] 1.171374
```

We highly recommend running this step in parallel if you have many candidate
gene-trait pairs.

# 10 Running Multi-INTACT

Once chi-square statistics, pairwise colocalization data, and marginal
z-scores for each gene product are available, we are ready to run Multi-INTACT.
To compute gene probabilities of putative causality (GPPCs) and gene
product relevance probabilities (GPRPs), run:

```
data(multi_simdat)

rst <- INTACT::multi_intact(df = multi_simdat)
```

The output from the `multi_intact` function is a list object containing 3 items.
The first is a data frame with the GPPC, GPRP for expression (`GPRP_1`), and for
protein (`GPRP_2`). The second is a numeric 3-vector containing conditional
prior parameter estimates (denoted \(h\_e,h\_p,h\_{e+p}\) in the methodology
reference). The third is a Boolean indicating whether the EM algorithm
converged.

The a preview of the output is shown below:

```
##                gene GPPC     GPRP_1     GPRP_2
## 15  ENSG00000038274    1 0.06825044 1.00000000
## 20  ENSG00000039319    1 1.00000000 0.08780404
## 130 ENSG00000113161    1 1.00000000 0.09504486
## 143 ENSG00000113269    1 0.98648370 1.00000000
## 168 ENSG00000113456    1 0.78760649 0.28634966
## 236 ENSG00000123643    1 1.00000000 0.09710129
```

```
## [1] 0.2918381 0.3665981 0.3412209
```

```
## [1] TRUE
```

The GPPC is a form of probabilistic evidence that a target gene
exerts a causal effect on the complex trait through at least one of the provided
gene product data types. The GPRPs provide probabilistic evidence to
determine the gene product(s) that exert a direct effect on the complex trait.
For example,in the output above, based on the Multi-INTACT output, it is very
likely that the gene ENSG00000038274 has a causal effect, and it is likely that
encoded protein levels exert a direct effect. There is relatively little
evidence that the gene’s expression levels exert a direct effect (although it
remains possible that gene expression exerts and effect that is mediated by
protein levels). The prior parameter estimates represent prior probabilistic
evidence of three possible underlying causal models (in which only expression,
only protein levels, or both expression and protein levels exert an effect,
respectively). Estimation of these prior parameters is required to estimate
GPRPs. We visualize the complete results below:

![](data:image/png;base64...)![](data:image/png;base64...)

From the histograms above, we can see that the probabilistic evidence of a
causal effect on the complex trait is low for most genes (top plot). In the
bottom plot, we display the distribution of GPRPs. Recall that all genes have 2
GPRPs (`GPRP_1` for protein evidence, and `GPRP_2` for expression), so we
visualize the distribution of each GPRP type in each panel. Additionally, we can
see that the distribution of probabilistic evidence of a direct protein effect
is similar to that of probabilistic evidence of a direct expression effect.
These observed qualities are by design, as this is simulated data.

If you want to see the model posteriors for expression-only
(`posterior_1`), protein-only (`posterior_2`), and expression-and-protein
(`posterior_12`), run:

```
rst <- INTACT::multi_intact(df = multi_simdat,return_model_posteriors = TRUE)
```

```
##                gene GPPC  posterior_0  posterior_1  posterior_2 posterior_12
## 15  ENSG00000038274    1 1.152317e-26 4.676668e-27 9.317496e-01   0.06825044
## 20  ENSG00000039319    1 1.850717e-40 9.121960e-01 3.668790e-41   0.08780404
## 130 ENSG00000113161    1 1.330650e-18 9.049551e-01 2.707217e-19   0.09504486
## 143 ENSG00000113269    1 1.415389e-17 1.625467e-16 1.351630e-02   0.98648370
## 168 ENSG00000113456    1 3.416643e-29 7.136503e-01 2.123935e-01   0.07395614
## 236 ENSG00000123643    1 6.386325e-32 9.028987e-01 4.644891e-33   0.09710129
##         GPRP_1     GPRP_2
## 15  0.06825044 1.00000000
## 20  1.00000000 0.08780404
## 130 1.00000000 0.09504486
## 143 0.98648370 1.00000000
## 168 0.78760649 0.28634966
## 236 1.00000000 0.09710129
```

If you only want to compute GPPCs (and not run the EM algorithm to compute
GPRPs), run:

```
rst <- INTACT::multi_intact(df = multi_simdat,em_algorithm = FALSE)
```

```
##               gene GPPC
## 2  ENSG00000215630    1
## 5  ENSG00000113269    1
## 37 ENSG00000271824    1
## 39 ENSG00000113456    1
## 44 ENSG00000145740    1
## 45 ENSG00000248489    1
```

Session information is included below:

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
## [1] ggplot2_4.0.0    INTACT_1.10.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      dplyr_1.1.4
##  [4] compiler_4.5.1      BiocManager_1.30.26 Rcpp_1.1.0
##  [7] tinytex_0.57        tidyselect_1.2.1    magick_2.9.0
## [10] dichromat_2.0-0.1   tidyr_1.3.1         jquerylib_0.1.4
## [13] scales_1.4.0        yaml_2.3.10         fastmap_1.2.0
## [16] R6_2.6.1            labeling_0.4.3      generics_0.1.4
## [19] knitr_1.50          bdsmatrix_1.3-7     tibble_3.3.0
## [22] bookdown_0.45       RColorBrewer_1.1-3  bslib_0.9.0
## [25] pillar_1.11.1       rlang_1.1.6         cachem_1.1.0
## [28] SQUAREM_2021.1      xfun_0.53           S7_0.2.0
## [31] sass_0.4.10         cli_3.6.5           withr_3.0.2
## [34] magrittr_2.0.4      digest_0.6.37       grid_4.5.1
## [37] lifecycle_1.0.4     vctrs_0.6.5         evaluate_1.0.5
## [40] glue_1.8.0          farver_2.1.2        numDeriv_2016.8-1.1
## [43] rmarkdown_2.30      purrr_1.1.0         tools_4.5.1
## [46] pkgconfig_2.0.3     htmltools_0.5.8.1
```