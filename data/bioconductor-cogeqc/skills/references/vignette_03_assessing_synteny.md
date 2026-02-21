# Assessing synteny identification

Fabricio Almeida-Silva1 and Yves Van de Peer1

1VIB-UGent Center for Plant Systems Biology, Ghent University, Ghent, Belgium

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data description](#data-description)
* [4 Network-based assessment of synteny identification](#network-based-assessment-of-synteny-identification)
* [Session information](#session-information)
* [References](#references)

# 1 Introduction

Synteny analysis allows the identification of conserved gene content and
gene order (collinearity) in a genomic segment, and it is often used to study
how genomic rearrangements have shaped genomes during the course of evolution.
However, accurate detection of syntenic blocks is highly dependent on
parameters such as minimum number of anchors, and maximum number of upstream
and downstream genes to search for syntenic blocks. Zhao and Schranz ([2019](#ref-zhao2019network)) proposed a
network-based synteny analysis (algorithm now implemented in the
Bioconductor package *[syntenet](https://bioconductor.org/packages/3.22/syntenet)*) that allows the
identification of optimal parameters using the network’s
**average clustering coefficient** and **number of nodes**. Here, we slightly
modified the approach to also take into account **how well the network’s degree
distribution fits a scale-free topology**, which is a typical property of
biological networks. This method allows users to identify the best combination
of parameters for synteny detection and synteny network inference.

# 2 Installation

To install the package from Bioconductor, use the following code:

```
if(!requireNamespace('BiocManager', quietly = TRUE))
  install.packages('BiocManager')
BiocManager::install("cogeqc")
```

Loading the package after installtion:

```
# Load package after installation
library(cogeqc)
set.seed(123) # for reproducibility
```

# 3 Data description

Here, we will use a subset of the synteny network inferred in Zhao and Schranz ([2019](#ref-zhao2019network))
that contains the synteny network for *Brassica oleraceae*, *B. napus*, and
*B. rapa*.

```
# Load synteny network for
data(synnet)

head(synnet)
#>             anchor1        anchor2
#> 1 bnp_BnaA01g05780D bol_Bo1g011310
#> 2 bnp_BnaA01g05800D bol_Bo1g011320
#> 3 bnp_BnaA01g05810D bol_Bo1g011330
#> 4 bnp_BnaA01g05820D bol_Bo1g011340
#> 5 bnp_BnaA01g05830D bol_Bo1g011350
#> 6 bnp_BnaA01g05840D bol_Bo1g011360
```

# 4 Network-based assessment of synteny identification

To assess synteny detection, we calculate a synteny network score as follows:

\[
\begin{aligned}
Score &= C N R^2\_{SFT}
\end{aligned}
\]

where \(C\) is the network’s clustering coefficient, \(N\) is the number of nodes,
and \(R^2\_{SFT}\) is the coefficient of determination for the scale-free topology
fit.

The network with the highest score is considered the most accurate.
To score a network, you will use the function `assess_synnet()`.

```
assess_synnet(synnet)
#>         CC Node_count  Rsquared    Score
#> 1 0.877912     149144 0.6806854 89125.76
```

Ideally, you should infer synteny networks using
*[syntenet](https://bioconductor.org/packages/3.22/syntenet)* with multiple combinations of parameters
and assess each network to pick the best. To demonstrate it, let’s simulate
different networks through resampling and calculate scores for each of them
with the wrapper function `assess_synnet_list()`.

```
# Simulate networks
net1 <- synnet
net2 <- synnet[-sample(1:10000, 500), ]
net3 <- synnet[-sample(1:10000, 1000), ]
synnet_list <- list(
  net1 = net1,
  net2 = net2,
  net3 = net3
)

# Assess original network + 2 simulations
synnet_assesment <- assess_synnet_list(synnet_list)
synnet_assesment
#>          CC Node_count  Rsquared    Score Network
#> 1 0.8779120     149144 0.6806854 89125.76    net1
#> 2 0.8769428     149133 0.6813367 89105.97    net2
#> 3 0.8758974     149114 0.6810978 88957.20    net3

# Determine the best network
synnet_assesment$Network[which.max(synnet_assesment$Score)]
#> [1] "net1"
```

As you can see, the first (original) network is the best,
as it has the highest score.

# Session information

This document was created under the following conditions:

```
sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package           * version date (UTC) lib source
#>  ape                 5.8-1   2024-12-16 [2] CRAN (R 4.5.1)
#>  aplot               0.2.9   2025-09-12 [2] CRAN (R 4.5.1)
#>  beeswarm            0.4.0   2021-06-01 [2] CRAN (R 4.5.1)
#>  BiocGenerics        0.56.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager         1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle         * 2.38.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings          2.78.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown            0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib               0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem              1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                 3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  cogeqc            * 1.14.0  2025-10-30 [1] Bioconductor 3.22 (R 4.5.1)
#>  crayon              1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  dichromat           2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest              0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr               1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate            1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver              2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap             1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  fontBitstreamVera   0.1.1   2017-02-01 [2] CRAN (R 4.5.1)
#>  fontLiberation      0.1.0   2016-10-15 [2] CRAN (R 4.5.1)
#>  fontquiver          0.2.1   2017-02-01 [2] CRAN (R 4.5.1)
#>  fs                  1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
#>  gdtools             0.4.4   2025-10-06 [2] CRAN (R 4.5.1)
#>  generics            0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  ggbeeswarm          0.7.2   2023-04-29 [2] CRAN (R 4.5.1)
#>  ggfun               0.2.0   2025-07-15 [2] CRAN (R 4.5.1)
#>  ggiraph             0.9.2   2025-10-07 [2] CRAN (R 4.5.1)
#>  ggplot2             4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  ggplotify           0.1.3   2025-09-20 [2] CRAN (R 4.5.1)
#>  ggtree              4.0.1   2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  glue                1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gridGraphics        0.5-1   2020-12-13 [2] CRAN (R 4.5.1)
#>  gtable              0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools           0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets         1.6.4   2023-12-06 [2] CRAN (R 4.5.1)
#>  igraph              2.2.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges             2.44.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib           0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite            2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr               1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling            0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice             0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval            0.2.2   2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle           1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  magrittr            2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  nlme                3.1-168 2025-03-31 [3] CRAN (R 4.5.1)
#>  patchwork           1.3.2   2025-08-25 [2] CRAN (R 4.5.1)
#>  pillar              1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig           2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  purrr               1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                  2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs            0.3.3   2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer        1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  reshape2            1.4.4   2020-04-09 [2] CRAN (R 4.5.1)
#>  rlang               1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown           2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Vectors           0.48.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                  0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales              1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo             1.0.0   2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo         1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi             1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr             1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  systemfonts         1.3.1   2025-10-01 [2] CRAN (R 4.5.1)
#>  tibble              3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr               1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect          1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  tidytree            0.4.6   2023-12-12 [2] CRAN (R 4.5.1)
#>  treeio              1.34.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  vctrs               0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor               0.4.7   2023-12-18 [2] CRAN (R 4.5.1)
#>  withr               3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                0.54    2025-10-30 [2] CRAN (R 4.5.1)
#>  XVector             0.50.0  2025-10-30 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>  yulab.utils         0.2.1   2025-08-19 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpK86p6k/Rinstf807d4dfb03d6
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```

# References

Zhao, Tao, and M Eric Schranz. 2019. “Network-Based Microsynteny Analysis Identifies Major Differences and Genomic Outliers in Mammalian and Angiosperm Genomes.” *Proceedings of the National Academy of Sciences* 116 (6): 2165–74.