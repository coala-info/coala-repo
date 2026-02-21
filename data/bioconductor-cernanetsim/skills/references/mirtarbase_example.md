# A TCGA dataset application

#### Selcen Ari

#### 2025-10-29

* [1. Introduction](#introduction)
* [2. Installation](#installation)
* [3. Integration of dataset which includes only miRNA and gene expression values](#integration-of-dataset-which-includes-only-mirna-and-gene-expression-values)
  + [3.1. miRNA:target pairs](#mirnatarget-pairs)
  + [3.2. Gene expression in normal and tumor samples](#gene-expression-in-normal-and-tumor-samples)
  + [3.3. miRNA expression data](#mirna-expression-data)
  + [3.4. Integrating and analysing data](#integrating-and-analysing-data)
  + [3.5. The sum of two conditions:](#the-sum-of-two-conditions)
* [4. Dataset (`huge_example`) which includes miRNA and gene expressions and miRNA:target interaction factors](#dataset-huge_example-which-includes-mirna-and-gene-expressions-and-mirnatarget-interaction-factors)
  + [4.1. Description of the *huge\_example* dataset](#description-of-the-huge_example-dataset)
  + [4.2. Select a node as trigger](#select-a-node-as-trigger)
* [5. Finding perturbation efficiency on an experimental dataset](#finding-perturbation-efficiency-on-an-experimental-dataset)
* [6. Session Info](#session-info)
  + [References](#references)

# 1. Introduction

This vignette is about the integration of gene and miRNA pairs and their expression dataset and analysis. The sample dataset in this demonstration, which contains human miRNA:target pairs, was retrieved from [miRTarBase](http://mirtarbase.mbc.nctu.edu.tw/php/download.php) website (Release 7.0).

```
library(ceRNAnetsim)
```

# 2. Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ceRNAnetsim")
```

# 3. Integration of dataset which includes only miRNA and gene expression values

## 3.1. miRNA:target pairs

```
data("mirtarbasegene")
head(mirtarbasegene)
#> # A tibble: 6 × 2
#>   miRNA           Target
#>   <chr>           <chr>
#> 1 hsa-miR-20a-5p  HIF1A
#> 2 hsa-miR-146a-5p CXCR4
#> 3 hsa-miR-122-5p  CYP7A1
#> 4 hsa-miR-222-3p  STAT5A
#> 5 hsa-miR-21-5p   RASGRP1
#> 6 hsa-miR-148a-3p DNMT1
```

**NOTE** if the mirna:target dataset includes miRNA genes as targets, the `priming_graph()` function can fail. Because, the function define to miRNAs and targets without distinguishing between uppercase or lowercase.

## 3.2. Gene expression in normal and tumor samples

The gene and mirna expression counts of patient barcoded with TCGA-E9-A1N5 is retrieved from TCGA via `TCGAbiolinks` package (Colaprico et al. 2015) from `Bioconductor`. The instructions of retrieving data can be found at `TCGAbiolinks` manual.

For this step you don’t have to use TCGA data, any other source or package can be utilized.

```
data("TCGA_E9_A1N5_normal")
head(TCGA_E9_A1N5_normal)
#> # A tibble: 6 × 7
#>   patient      sample      barcode definition ensembl_gene_id external_gene_name
#>   <chr>        <chr>       <chr>   <chr>      <chr>           <chr>
#> 1 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Solid Tis… ENSG00000000003 TSPAN6
#> 2 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Solid Tis… ENSG00000000005 TNMD
#> 3 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Solid Tis… ENSG00000000419 DPM1
#> 4 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Solid Tis… ENSG00000000457 SCYL3
#> 5 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Solid Tis… ENSG00000000460 C1orf112
#> 6 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Solid Tis… ENSG00000000938 FGR
#> # ℹ 1 more variable: gene_expression <dbl>
```

```
data("TCGA_E9_A1N5_tumor")
head(TCGA_E9_A1N5_tumor)
#> # A tibble: 6 × 7
#>   patient      sample      barcode definition ensembl_gene_id external_gene_name
#>   <chr>        <chr>       <chr>   <chr>      <chr>           <chr>
#> 1 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Primary s… ENSG00000000003 TSPAN6
#> 2 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Primary s… ENSG00000000005 TNMD
#> 3 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Primary s… ENSG00000000419 DPM1
#> 4 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Primary s… ENSG00000000457 SCYL3
#> 5 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Primary s… ENSG00000000460 C1orf112
#> 6 TCGA-E9-A1N5 TCGA-E9-A1… TCGA-E… Primary s… ENSG00000000938 FGR
#> # ℹ 1 more variable: gene_expression <dbl>
```

## 3.3. miRNA expression data

```
data("TCGA_E9_A1N5_mirnatumor")
head(TCGA_E9_A1N5_mirnatumor)
#> # A tibble: 6 × 6
#>   barcode                      mirbase_ID   miRNA  Precusor total_read total_RPM
#>   <chr>                        <chr>        <chr>  <chr>         <int>     <dbl>
#> 1 TCGA-E9-A1N5-01A-11R-A14C-13 MIMAT0000062 hsa-l… MI00000…      45725  20802.
#> 2 TCGA-E9-A1N5-01A-11R-A14C-13 MIMAT0004481 hsa-l… MI00000…        100     45.5
#> 3 TCGA-E9-A1N5-01A-11R-A14C-13 MIMAT0010195 hsa-l… MI00000…          6      2.73
#> 4 TCGA-E9-A1N5-01A-11R-A14C-13 MIMAT0000063 hsa-l… MI00000…      43489  19785.
#> 5 TCGA-E9-A1N5-01A-11R-A14C-13 MIMAT0004482 hsa-l… MI00000…        126     57.3
#> 6 TCGA-E9-A1N5-01A-11R-A14C-13 MIMAT0000064 hsa-l… MI00000…       2002    911.
```

```
data("TCGA_E9_A1N5_mirnanormal")
head(TCGA_E9_A1N5_mirnanormal)
#> # A tibble: 6 × 6
#>   barcode                      mirbase_ID   miRNA  Precusor total_read total_RPM
#>   <chr>                        <chr>        <chr>  <chr>         <int>     <dbl>
#> 1 TCGA-E9-A1N5-11A-41R-A14C-13 MIMAT0000062 hsa-l… MI00000…      67599   37068.
#> 2 TCGA-E9-A1N5-11A-41R-A14C-13 MIMAT0004481 hsa-l… MI00000…        132      72.4
#> 3 TCGA-E9-A1N5-11A-41R-A14C-13 MIMAT0010195 hsa-l… MI00000…         57      31.3
#> 4 TCGA-E9-A1N5-11A-41R-A14C-13 MIMAT0000063 hsa-l… MI00000…      47266   25918.
#> 5 TCGA-E9-A1N5-11A-41R-A14C-13 MIMAT0004482 hsa-l… MI00000…        126      69.1
#> 6 TCGA-E9-A1N5-11A-41R-A14C-13 MIMAT0000064 hsa-l… MI00000…      14554    7981.
```

Here’s the summary of size of each dataset

| Dataset name | Number of rows |
| --- | --- |
| `mirtarbasegene` | 380627 |
| `TCGA_E9_A1N5_normal` | 56830 |
| `TCGA_E9_A1N5_tumor` | 56830 |
| `TCGA_E9_A1N5_mirnanormal` | 750 |
| `TCGA_E9_A1N5_mirnatumor` | 648 |

## 3.4. Integrating and analysing data

All of these datasets are integrated using the code below resulting in miRNA:target dataset that contains miRNA and gene expression values.

```
TCGA_E9_A1N5_mirnagene <- TCGA_E9_A1N5_mirnanormal %>%
  inner_join(mirtarbasegene, by= "miRNA") %>%
  inner_join(TCGA_E9_A1N5_normal,
             by = c("Target"= "external_gene_name")) %>%
  select(Target, miRNA, total_read, gene_expression) %>%
  distinct()
#> Warning in inner_join(., TCGA_E9_A1N5_normal, by = c(Target = "external_gene_name")): Detected an unexpected many-to-many relationship between `x` and `y`.
#> ℹ Row 3405 of `x` matches multiple rows in `y`.
#> ℹ Row 842 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set `relationship =
#>   "many-to-many"` to silence this warning.
```

Note: Some of genes have expression values more than one because some of tissue samples were sequenced in two medium separately. So, we select maximum expression values of that genes at following:

```
#> # A tibble: 26 × 3
#> # Groups:   Target, miRNA [26]
#>    Target  miRNA               n
#>    <chr>   <chr>           <int>
#>  1 COG8    hsa-miR-186-5p      2
#>  2 GOLGA8M hsa-miR-1270        2
#>  3 GOLGA8M hsa-miR-5703        2
#>  4 MATR3   hsa-let-7e-5p       2
#>  5 MATR3   hsa-miR-1-3p        2
#>  6 MATR3   hsa-miR-10b-3p      2
#>  7 MATR3   hsa-miR-125b-5p     2
#>  8 MATR3   hsa-miR-149-5p      2
#>  9 MATR3   hsa-miR-155-5p      2
#> 10 MATR3   hsa-miR-16-1-3p     2
#> # ℹ 16 more rows
```

```
head(TCGA_E9_A1N5_mirnagene)
#> # A tibble: 6 × 4
#>   Target  miRNA         total_read gene_expression
#>   <chr>   <chr>              <int>           <dbl>
#> 1 CDK6    hsa-let-7a-5p      67599            4669
#> 2 MYC     hsa-let-7a-5p      67599           11593
#> 3 BCL2    hsa-let-7a-5p      67599            2445
#> 4 NKIRAS2 hsa-let-7a-5p      67599            1519
#> 5 ITGB3   hsa-let-7a-5p      67599             196
#> 6 NF2     hsa-let-7a-5p      67599            1755
```

When we compared the two gene expression dataset of TCGA-E9A1N5 patient, and selected a gene which has 30-fold increased expression, (gene name: HIST1H3H), this gene node will be used in the example. Note that the selected node must not be isolated one. If the an isolated node is selected the change in expression will not propagate in network. (You can see commands for node selection in the vignette [The auxiliary commands which can help to the users](https://selcenari.github.io/ceRNAnetsim/articles/auxiliary_commands.html))

Optionally, you can filter the low expressed gene nodes because they are not effective elements.

```
TCGA_E9_A1N5_mirnagene <- TCGA_E9_A1N5_mirnagene%>%
  filter(gene_expression > 10)
```

The analysis is performed based on amounts of miRNAs and targets as seen. Firstly, we tried to find optimal iteration for the network when simulation start with *HIST1H3H* node. As an example, `simulation()` function was used with `cycle = 5` argument, this argument can be arranged according to network. Note that it can be appropriate that using greater number of `cycle` for comprehensive network objects.

```
simulation_res_HIST <- TCGA_E9_A1N5_mirnagene %>%
  priming_graph(competing_count = gene_expression,
                miRNA_count = total_read) %>%
  update_how(node_name = "HIST1H3H", how =30) %>%
  simulate(5)

simulation_res_HIST%>%
  find_iteration(plot=TRUE)
```

![](data:image/png;base64...)

The graph was shown that the change in expression level of HIST1H3H results in weak perturbation efficiency, despite 30-fold change. The code shown below can be used for calculation of fold changes after simulation HIST1H3H gene to 30 fold:

```
simulation_res_HIST%>%
  as_tibble()%>%
  mutate(FC= count_current/initial_count)%>%
  arrange(desc(FC))
#> # A tibble: 13,432 × 8
#>    name     type  node_id initial_count count_pre count_current changes_variable
#>    <chr>    <chr>   <int>         <dbl>     <dbl>         <dbl> <chr>
#>  1 HIST1H3H Comp…    9705            27       808           808 Competing
#>  2 CDK6     Comp…       1          4669      4669          4669 Competing
#>  3 MYC      Comp…       2         11593     11593         11593 Competing
#>  4 BCL2     Comp…       3          2445      2445          2445 Competing
#>  5 NKIRAS2  Comp…       4          1519      1519          1519 Competing
#>  6 ITGB3    Comp…       5           196       196           196 Competing
#>  7 NF2      Comp…       6          1755      1755          1755 Competing
#>  8 NRAS     Comp…       7          2311      2311          2311 Competing
#>  9 KRAS     Comp…       8          1204      1204          1204 Competing
#> 10 PRDM1    Comp…       9           456       456           456 Competing
#> # ℹ 13,422 more rows
#> # ℹ 1 more variable: FC <dbl>
```

And then, we tried to simulate the network with the gene which has higher expression value. For this, we selected *ACTB* node as shown in [The auxiliary commands which can help to the users](https://selcenari.github.io/ceRNAnetsim/articles/auxiliary_commands.html)

```
simulation_res_ACTB <- TCGA_E9_A1N5_mirnagene %>%
  priming_graph(competing_count = gene_expression,
                miRNA_count = total_read) %>%
  update_how(node_name = "ACTB", how =1.87) %>%
  simulate(5)

simulation_res_ACTB%>%
  find_iteration(plot=TRUE)
```

![](data:image/png;base64...)

Following codes are shown entire gene fold changes after simulation ACTB gene to 1.87 fold:

```
simulation_res_ACTB%>%
  as_tibble()%>%
  mutate(FC= count_current/initial_count)%>%
  arrange(desc(FC))
#> # A tibble: 13,432 × 8
#>    name    type   node_id initial_count count_pre count_current changes_variable
#>    <chr>   <chr>    <int>         <dbl>     <dbl>         <dbl> <chr>
#>  1 ACTB    Compe…      84        101917    183705        183705 Competing
#>  2 YOD1    Compe…     472           470       472           472 Competing
#>  3 ADIPOR2 Compe…     319          3015      3026          3026 Competing
#>  4 FAM105A Compe…     385           569       571           571 Competing
#>  5 RRM2    Compe…      67          1479      1484          1484 Competing
#>  6 NKIRAS2 Compe…       4          1519      1524          1524 Competing
#>  7 IGF1R   Compe…     324          3875      3887          3887 Competing
#>  8 NRAS    Compe…       7          2311      2318          2318 Competing
#>  9 SOCS7   Compe…     592          1331      1335          1335 Competing
#> 10 SRD5A3  Compe…    2887           676       678           678 Competing
#> # ℹ 13,422 more rows
#> # ℹ 1 more variable: FC <dbl>
```

Note: it can be useful that you look at [The auxiliary commands which can help to the users](https://selcenari.github.io/ceRNAnetsim/articles/auxiliary_commands.html) for perturbation efficiency of ACTB gene by simulation with same conditions and different expression changes.

## 3.5. The sum of two conditions:

In a real biological sample, we tested perturbation efficiencies of two genes; \* one with low expression but high fold change (HIST1H3H, 30-fold increase in tumor) \* another one with high expression but small change in expression level (ACTB, 1.87-fold increase in tumor)

With these two samples, it has been obtained that expression values of genes, rest of the perturbed gene, changed slightly.

Despite high fold change, former gene caused little perturbation. When the perturbation efficiencies of both of these genes are analysed, it has been oberved that HIST1H3H does not affect the other genes in given limit. On the contrary, high expressing gene with very low fold increase in tumor causes greater perturbation in the network. Additionaly, the perturbation efficiency of ACTB gene is quite high from HIST1H3H with 30-fold change, when ACTB is simulated with 30 fold-change.

Thus, if the perturbed node has lower target:total target ratio in group or groups, the efficiency of it can be weak, or vice versa. The efficiency of ACTB gene may be high for this reason, in comparison with HIST1H3H perturbation. In fact, it has been observed that ACTB has not strong perturbation efficiency too. This could be arisen from low miRNA:target ratio or ineffective target nodes which have very low expression levels.

# 4. Dataset (`huge_example`) which includes miRNA and gene expressions and miRNA:target interaction factors

## 4.1. Description of the *huge\_example* dataset

Interactions between miRNAs and their targets can be analyzed after the integration of miRNA and targets via various datasets. As an example, we prepared the *huge\_example* dataset. It was generated by integrating:

* Next-generation RNA sequencing data of a breast cancer patient from TCGA (patient id:TCGA\_A7\_A0CE)
* The microRNA expression values of the same breast cancer patient.
* High-throughput miRNA:target determination datasets. We utilised the microRNA:target gene dataset which was integrated from high-throughput experimental studies([CLASH](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3650559/) & [CLEAR-CLiP](https://www.nature.com/articles/ncomms9864) methods). These datasets give exact microRNA:target pairs because of these methods base on chimeric reading of pairs after binding of microRNAs and their targets. For this reason, the datasets contain detailed information for microRNA:target pairs such as interacted bases (in terms of degree of complementarity) on microRNAs and target mRNAs, location of interaction region (seed) on mRNA and estimated binding energies of pairs.

Below, only 6 rows from total of 26,176 rows are shown.

```
data("huge_example")
head(huge_example)
#>   competing           miRNA competing_counts mirnaexpression_normal Energy
#> 1    TSPAN6     hsa-miR-484             5404              23.058807  -21.4
#> 2      DPM1  hsa-miR-18b-5p             2472               0.256209  -10.0
#> 3     SCYL3  hsa-miR-149-5p             1483              34.844420   -5.5
#> 4     SCYL3  hsa-miR-30a-5p             1483           63031.505507  -13.0
#> 5  C1orf112 hsa-miR-1296-5p              312               1.793463   -8.1
#> 6       CFH   hsa-miR-17-5p             5760              89.929349  -17.2
#>   region_effect seed_type_effect
#> 1          0.42             0.43
#> 2          0.84             0.01
#> 3          0.42             0.01
#> 4          0.84             0.43
#> 5          0.42             0.01
#> 6          0.42             0.01
```

## 4.2. Select a node as trigger

The node that initiates simulation can be determined according your interest or research.

The dataset, which is a data frame, can be manipulated with [tidyverse packages](https://www.tidyverse.org/packages/). As an example, competing RNAs targeted by less than 5 miRNAs are eliminated to make the network manageable size.

```
filtered_example <- huge_example %>%
  add_count(competing) %>%
  filter(n > 5) %>%
  select(-n)

head(filtered_example)
#>   competing           miRNA competing_counts mirnaexpression_normal Energy
#> 1    MAD1L1  hsa-miR-149-5p             1909               34.84442  -18.6
#> 2    MAD1L1   hsa-miR-16-5p             1909              296.68999  -19.3
#> 3    MAD1L1 hsa-miR-196a-5p             1909               55.85356  -15.4
#> 4    MAD1L1  hsa-miR-20a-5p             1909               65.84570  -13.6
#> 5    MAD1L1  hsa-miR-30c-5p             1909              602.60349  -26.7
#> 6    MAD1L1  hsa-miR-92a-3p             1909             5112.64996  -30.6
#>   region_effect seed_type_effect
#> 1          0.42             0.01
#> 2          0.01             0.07
#> 3          0.01             0.07
#> 4          0.42             0.01
#> 5          0.01             0.01
#> 6          0.01             0.05
```

On the other hand, we chose the node *GAPDH* according to interaction count of the nodes. With the simulation, the graph was visualized after node *GAPDH* was increased to five fold.

```
simulation_GAPDH <- filtered_example %>%
  priming_graph(competing_count = competing_counts,
                miRNA_count = mirnaexpression_normal,
                aff_factor = Energy) %>%
  update_how("GAPDH", 5)

simulation_GAPDH%>%
  vis_graph(title = "Distribution of GAPDH gene node")
```

![](data:image/png;base64...)

Let’s visualize each step of simulation via `simulate_vis()` function.

```
simulation_GAPDH%>%
  simulate_vis(title = "GAPDH over expression in the real dataset", 3)
#> # A tbl_graph: 1526 nodes and 11384 edges
#> #
#> # A directed acyclic simple graph with 1 component
#> #
#> # Node Data: 1,526 × 7 (active)
#>    name     type  node_id initial_count count_pre count_current changes_variable
#>    <chr>    <chr>   <int>         <dbl>     <dbl>         <dbl> <chr>
#>  1 MAD1L1   Comp…       1          1909     1909.         1909. Up
#>  2 TFPI     Comp…       2          3377     3377.         3377. Down
#>  3 SLC7A2   Comp…       3          8706     8707.         8707. Down
#>  4 FKBP4    Comp…       4         20583    20584.        20584. Down
#>  5 SLC25A13 Comp…       5          1637     1638.         1638. Down
#>  6 ST7      Comp…       6          1962     1962.         1962. Up
#>  7 UPF1     Comp…       7         10094    10095.        10095. Up
#>  8 SLC25A5  Comp…       8         13819    13827.        13824. Down
#>  9 THSD7A   Comp…       9           558      558.          558. Up
#> 10 MSL3     Comp…      10          2029     2030.         2030. Down
#> # ℹ 1,516 more rows
#> #
#> # Edge Data: 11,384 × 21
#>    from    to Competing_name miRNA_name  competing_counts mirnaexpression_normal
#>   <int> <int> <chr>          <chr>                  <dbl>                  <dbl>
#> 1     1  1255 MAD1L1         hsa-miR-14…             1909                   34.8
#> 2     1  1256 MAD1L1         hsa-miR-16…             1909                  297.
#> 3     1  1257 MAD1L1         hsa-miR-19…             1909                   55.9
#> # ℹ 11,381 more rows
#> # ℹ 15 more variables: Energy <dbl>, dummy <dbl>, afff_factor <dbl>,
#> #   degg_factor <dbl>, comp_count_list <list>, comp_count_pre <dbl>,
#> #   comp_count_current <dbl>, mirna_count_list <list>, mirna_count_pre <dbl>,
#> #   mirna_count_current <dbl>, mirna_count_per_dep <dbl>, effect_current <dbl>,
#> #   effect_pre <dbl>, effect_list <list>, mirna_count_per_comp <dbl>
```

![](data:image/gif;base64...)

GAPDH over expression in real dataset

Now, we can track changes in expression levels at every node for 3 cycles when GAPDH is overexpressed 5-fold.

* After increase in GAPDH expression level in the first graph, the responses of the other competing elements to the GAPDH distributions were calculated.
* The changing regulations (up or down) were observed as a result of interactions in the second graph.
* When three graphs were carefully compared to each other, it can be observed that the expression levels of nodes change continuously at each stage.

# 5. Finding perturbation efficiency on an experimental dataset

`find_node_perturbation()` runs `calc_perturb` on all nodes in the network in parallel with help of the `future` and `furrr` packages. In this vignette, the function is demonstrated on the `midsamp` data. This dataset is not comparable to actual biological miRNA:target gene datasets in size and complexity. Although `find_node_perturbation()` runs in parallel it might take long time to run in real huge biological datasets.

In real biological datasets, more complex interactions whether functional or non-functional could be observed. We have improved our approach with `fast` argument in `find_node_perturbation()` based on selection of elements that could be affected from perturbation. In this fucntion, `fast` argument specifies the percentage of the competing amount that can be affected within the initial competing amount and acts as a selection parameter. For instance, in filtered example data:

```
entire_perturbation <- filtered_example%>%
  priming_graph(competing_count = competing_counts, miRNA_count = mirnaexpression_normal)%>%
  find_node_perturbation(how=5, cycle=3, fast = 15)%>%
  select(name, perturbation_efficiency, perturbed_count)
```

```
entire_perturbation%>%
  filter(!is.na(perturbation_efficiency), !is.na(perturbed_count))%>%
  select(name, perturbation_efficiency, perturbed_count)
#> # A tibble: 53 × 3
#>    name     perturbation_efficiency perturbed_count
#>    <chr>                      <dbl>           <dbl>
#>  1 SLC25A5                    1.34               43
#>  2 MSL3                       0.198              43
#>  3 SCMH1                      0.354              43
#>  4 RALBP1                     0.650              43
#>  5 THUMPD1                    0.648              43
#>  6 ARFGEF1                    0.481              43
#>  7 PABPC1                     6.35               43
#>  8 CNOT4                      0                   0
#>  9 PPP1R13B                   0.262              43
#> 10 CSNK2A1                    0.545              43
#> # ℹ 43 more rows
```

# 6. Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] purrr_1.1.0        future_1.67.0      png_0.1-8          ceRNAnetsim_1.22.0
#> [5] tidygraph_1.3.1    dplyr_1.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] viridis_0.6.5      utf8_1.2.6         sass_0.4.10        generics_0.1.4
#>  [5] tidyr_1.3.1        listenv_0.9.1      digest_0.6.37      magrittr_2.0.4
#>  [9] evaluate_1.0.5     grid_4.5.1         RColorBrewer_1.1-3 fastmap_1.2.0
#> [13] jsonlite_2.0.0     ggrepel_0.9.6      gridExtra_2.3      viridisLite_0.4.2
#> [17] scales_1.4.0       tweenr_2.0.3       codetools_0.2-20   jquerylib_0.1.4
#> [21] cli_3.6.5          graphlayouts_1.2.2 rlang_1.1.6        polyclip_1.10-7
#> [25] parallelly_1.45.1  withr_3.0.2        cachem_1.1.0       yaml_2.3.10
#> [29] tools_4.5.1        parallel_4.5.1     memoise_2.0.1      ggplot2_4.0.0
#> [33] globals_0.18.0     vctrs_0.6.5        R6_2.6.1           lifecycle_1.0.4
#> [37] MASS_7.3-65        furrr_0.3.1        ggraph_2.2.2       pkgconfig_2.0.3
#> [41] pillar_1.11.1      bslib_0.9.0        gtable_0.3.6       Rcpp_1.1.0
#> [45] glue_1.8.0         ggforce_0.5.0      xfun_0.53          tibble_3.3.0
#> [49] tidyselect_1.2.1   knitr_1.50         dichromat_2.0-0.1  farver_2.1.2
#> [53] htmltools_0.5.8.1  igraph_2.2.1       labeling_0.4.3     rmarkdown_2.30
#> [57] compiler_4.5.1     S7_0.2.0
```

## References

Colaprico, Antonio, Tiago C Silva, Catharina Olsen, Luciano Garofano, Claudia Cava, Davide Garolini, Thais S Sabedot, et al. 2015. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of Tcga Data.” *Nucleic Acids Research* 44 (8): e71–e71.