# perturbatr cookbook

Simon Dirmeier

#### *2019-01-04*

# 1 Introduction

`perturbatr` does stage-wise analysis of large-scale genetic
perturbation screens for integrated data sets consisting of multiple screens.
For multiple integrated perturbation screens a hierarchical model that
considers the variance between different biological conditions is fitted.
That means that we first estimate relative effect sizes for all genes.
The resulting hit lists is then further extended using a network
propagation algorithm to correct for false negatives.

Here we show an example data analysis using a pan-pathogenic data set of
three RNAi screening studies.
The data set consists of two kinome and a druggable genome wide RNAi screen
and have been
published in Reiss et al. (2011) (HCV) and Wilde et al. (2015) (SARS).

# 2 Data analysis tutorial

This tutorial walks you to the basic functionality of `perturbatr`.

## 2.1 Creating a `PerturbationData` object

You supposedly start with something like a `data.frame` or `tibble`:

```
  head(rnaiscreen)
```

```
## # A tibble: 6 x 9
##   Condition Replicate GeneSymbol Perturbation Readout Control Design
##   <chr>         <int> <chr>      <chr>          <dbl>   <int> <chr>
## 1 SARS              1 aak1       D-005300-01…   0.699       0 pooled
## 2 SARS              1 aatk       D-005301-02…   0.713       0 pooled
## 3 SARS              1 cerk       D-004061-01…  -0.446       0 pooled
## 4 SARS              1 rapgef4    D-009511-01…  -0.398       0 pooled
## 5 SARS              1 chek1      D-003255-06…   0.670       0 pooled
## 6 SARS              1 chek2      D-003256-05…   1.12        0 pooled
## # … with 2 more variables: ScreenType <chr>, Screen <chr>
```

In order to start your analysis you need to create a perturbation data set
first.For this you only need to call the `as` method on your `data.frame`:

```
  rnaiscreen <- methods::as(rnaiscreen, "PerturbationData")
```

Coercing your `data.frame` to `PerturbationData` will automatically warn you if
your table is formatted wrongly. You need at least the following column names
order to be able to do analysis of perturbation screens using `perturbatr`:

* Condition: an identifier that best describes the respective screen.
  For instance this can be the name of a virus for pathogen screens, the name
  of a cell line, organoid or the like. The *condition* describes a single data
  set, i.e. if you want to integrate multiple different data sets, make sure to
  give each a different condition.
* Replicate: an integer representing the replicate number of a screen.
* GeneSymbol: the HUGO identifier, ENTREZ id, etc. as character.
* Perturbation: a siRNA id or gRNA id that describes the knockout/knockdown for
  the gene.
* Readout: a *normalized* readout like a log-fold change for gRNAs,
  a GFP signal, etc.
* Control: vector of integers representing perturbations that have been
  used as negative or positive controls. A negative control is marked with
  ‘-1’, a positive control with ‘1’ and a normal sample with ‘0’.

Depending on how you want to model the readout using the hierarchical model,
you might want to add additional
columns. For the sake of simplicity this suffices though.

## 2.2 Working with `PerturbationData` S4 objects

A `PerturbationData` object consists of a single slot that stores your data. We
bundled your data into an `S4` object such that dispatch is easier to handle
and to make sure that your data set has the correct columns:

```
  rnaiscreen
```

```
## A perturbation data set
##
##   Condition GeneSymbol     Readout
## 1       HCV    mgc1136 -0.05238662
## 2       HCV     agpat3 -0.76807966
## 3      SARS  scrambled -0.61532301
## 4      SARS     card14 -2.04674764
```

```
  dataSet(rnaiscreen)
```

```
## # A tibble: 215,427 x 9
##    Condition Replicate GeneSymbol Perturbation Readout Control Design
##    <chr>         <int> <chr>      <chr>          <dbl>   <int> <chr>
##  1 SARS              1 aak1       D-005300-01…   0.699       0 pooled
##  2 SARS              1 aatk       D-005301-02…   0.713       0 pooled
##  3 SARS              1 cerk       D-004061-01…  -0.446       0 pooled
##  4 SARS              1 rapgef4    D-009511-01…  -0.398       0 pooled
##  5 SARS              1 chek1      D-003255-06…   0.670       0 pooled
##  6 SARS              1 chek2      D-003256-05…   1.12        0 pooled
##  7 SARS              1 chka       D-006704-01…   1.76        0 pooled
##  8 SARS              1 chkb       D-006705-01…  -0.343       0 pooled
##  9 SARS              1 chrm1      D-005462-01…   0.878       0 pooled
## 10 SARS              1 chuk       D-003473-03…  -0.511       0 pooled
## # … with 215,417 more rows, and 2 more variables: ScreenType <chr>,
## #   Screen <chr>
```

`PerturbationData` has some basic `filter` and `rbind` functionality.
Similar to `dplyr::filter` you can select rows by some predicate(s). In the
example below we extract all rows from the data set that have a positive
readout.

```
  perturbatr::filter(rnaiscreen, Readout > 0)
```

```
## A perturbation data set
##
##   Condition GeneSymbol   Readout
## 1       HCV      cabp2 0.5086061
## 2       HCV       mink 1.2146601
## 3      SARS     dyrk1a 0.5725032
## 4      SARS       clk4 1.5121474
```

Filtering on multiple rows works by just adding predicates:

```
  perturbatr::filter(rnaiscreen, Readout > 0, Replicate == 2)
```

```
## A perturbation data set
##
##   Condition GeneSymbol   Readout
## 1       HCV      phkg1 0.7439663
## 2       HCV   humcyt2a 0.3916604
## 3      SARS   c6orf199 0.7447410
## 4      SARS      phka1 0.9434946
```

If you want to combine data sets you can call `rbind`, which will
automatically dispatch on `PerturbationData` object:

```
  dh <- perturbatr::filter(rnaiscreen, Readout > 0, Replicate == 2)
  rbind(dh, dh)
```

```
## A perturbation data set
##
##   Condition GeneSymbol   Readout
## 1       HCV       tgif 0.2224921
## 2       HCV       hlcs 2.1085551
## 3      SARS     pkmyt1 0.1405859
## 4      SARS      akap5 0.9554385
```

## 2.3 Data analysis using a hierarchical model and network diffusion

Finally, after having set up the data set, we analyse it using a hierarchical
model and network diffusion.

We **expect you already normalized the data sets accordingly**.
As noted above, if you want to analyse multiple data sets, make sure that
every data set corresponds to a unique `Condition`.

First, let’s have a rough look at the data set that we are using:

```
  plot(rnaiscreen)
```

![](data:image/png;base64...)

We have roughly the same number of replicates per gene, but the HCV screen has
less genes
than the SARS data set. That is no problem however, because we automatically
filter such that the genes are same.
We also automatically remove positive controls for obvious reasons.

Next we rank the genes using a hierarchical model which requires explicitely
modelling the readout of our data set using an
R `formula`. Let’s look at the data in more detail first:

```
  dataSet(rnaiscreen) %>% str()
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':    215427 obs. of  9 variables:
##  $ Condition   : chr  "SARS" "SARS" "SARS" "SARS" ...
##  $ Replicate   : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ GeneSymbol  : chr  "aak1" "aatk" "cerk" "rapgef4" ...
##  $ Perturbation: chr  "D-005300-01,D-005300-02,D-005300-03,D-005300-04" "D-005301-02,D-005301-03,D-005301-04,D-005301-05" "D-004061-01,D-004061-02,D-004061-03,D-004061-04" "D-009511-01,D-009511-02,D-009511-03,D-009511-04" ...
##  $ Readout     : num  0.699 0.713 -0.446 -0.398 0.67 ...
##  $ Control     : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ Design      : chr  "pooled" "pooled" "pooled" "pooled" ...
##  $ ScreenType  : chr  "E/R" "E/R" "E/R" "E/R" ...
##  $ Screen      : chr  "Kinome" "Kinome" "Kinome" "Kinome" ...
```

Here, variables like `Replicate`, `Plate`, `RowIdx/ColIdx` should not be
associated with a change in the response `Readout` as we normalized the data
and corrected for batch effects.
However, the `Readout`s should definitely have been different between
`ScreenType`s:

```
  dataSet(rnaiscreen) %>% pull(ScreenType) %>% unique()
```

```
## [1] "E/R" "A/R"
```

where `E/R` represents that the screen has measured the effect of a gene
knockdown during the *entry and replication* stages of the viral
lifecycle while `A/R` repesents the gene knockdown’s effect having been
measures during the *assembly and release* stages of the lifecycle.
In the life cycle of positive-sense RNA viruses we know
that viruses make use of different host factors during their life cycle.
That means while some genes are required during *entry and replication*,
others might play a role in *assembly and release* of the virions.
So we have reason to believe that the stage of the infection also introduces
a clustering effect. In that case we would need to add a random effect
for the stage of the infection.

A model selection using the Bayesian information criterion indeed suggests
the following hierarchical random intercept model:

\[y\_{cgtp} \mid\gamma\_g, \delta\_{cg}, \zeta\_t , \xi\_{ct} \sim \mathcal{N}(x\_c \beta + \gamma\_g + \delta\_{cg} + \zeta\_t + \xi\_{ct}, \sigma^2),\]
where \(y\_{cgtp}\) is the readout of virus \(c\), gene \(g\), stage of the viral
lifecycle \(t\) (`E/R` vs `A/R`) and \(p\) is the perturbation (siRNA) used for
gene \(g\).
We estimate the parameters of the model using `lme4` (Bates et al. 2015):

```
  frm <- Readout ~ Condition +
                   (1|GeneSymbol) + (1|Condition:GeneSymbol) +
                   (1|ScreenType) + (1|Condition:ScreenType)
  res.hm <- hm(rnaiscreen, formula = frm)
```

**Note that for your own data different effects might be visible. Thus,**
**before modelling you need to exploratorily detect possible effects.**

Let’s take the last result and plot them. This yields a list of multiple
plots. The first plot shows the first 25 strongest gene effects ranked by their
absolute effect sizes. Most of the genes are colored in blue which represents
that a
gene knockdown leads to an inhibition of viral growth on a **pan-viral** level.
Bars colored in red represent genes for which a knockdown results in increased
viral viability.
If you are interested in the complete ranking of genes, use
`geneEffects(res.hm)`.

```
  pl <- plot(res.hm)
  pl[[1]]
```

![](data:image/png;base64...)

The second plots shows the *nested gene effects*, i.e. the estimated effects of
a gene knockdown for a **single** virus. The genes shown here are the same as
in the first plot,
so it might be possible that there are *nested gene effects* that are stronger
which are just not plotted.
You can get all nested gene effects using `nestedGeneEffects(res.hm)`.

```
  pl[[2]]
```

![](data:image/png;base64...)

Next we might want to *smooth* the effect from the hierarchical model using
network diffusion, by that possibly reduce the number of some false negatives.
For that we need to supply a graph as a `data.frame` and call the `diffuse`
function:

```
  graph <- readRDS(
    system.file("extdata", "graph_small.rds",package = "perturbatr"))
  diffu <- diffuse(res.hm, graph=graph, r=0.3)
```

If we plot the results we get a list of reranked genes. Note that the
ranking uses the network diffusion computes a stationary distribution
of a Markov random walk with restarts.

```
  plot(diffu)
```

![](data:image/png;base64...)
Further note that we used a very small network here. You might want to redo
this analysis with the full graph which is located in
`system.file("extdata", "graph_full.rds",package = "perturbatr")`.

## 2.4 Session info

```
  sessionInfo()
```

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] bindrcpp_0.2.2   perturbatr_1.2.1 tibble_2.0.0     dplyr_0.7.8
## [5] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_0.2.5     xfun_0.4             purrr_0.2.5
##  [4] reshape2_1.4.3       operator.tools_1.6.3 splines_3.5.2
##  [7] lattice_0.20-38      colorspace_1.3-2     htmltools_0.3.6
## [10] yaml_2.2.0           utf8_1.1.4           rlang_0.3.0.1
## [13] pillar_1.3.1         nloptr_1.2.1         glue_1.3.0
## [16] foreach_1.4.4        bindr_0.1.1          plyr_1.8.4
## [19] stringr_1.3.1        munsell_0.5.0        gtable_0.2.0
## [22] codetools_0.2-16     evaluate_0.12        labeling_0.3
## [25] knitr_1.21           doParallel_1.0.14    parallel_3.5.2
## [28] fansi_0.4.0          Rcpp_1.0.0           scales_1.0.0
## [31] BiocManager_1.30.4   lme4_1.1-19          ggplot2_3.1.0
## [34] digest_0.6.18        stringi_1.2.4        formula.tools_1.7.1
## [37] bookdown_0.9         grid_3.5.2           cli_1.0.1
## [40] tools_3.5.2          magrittr_1.5         diffusr_0.1.4
## [43] lazyeval_0.2.1       crayon_1.3.4         tidyr_0.8.2
## [46] pkgconfig_2.0.2      MASS_7.3-51.1        Matrix_1.2-15
## [49] assertthat_0.2.0     minqa_1.2.4          rmarkdown_1.11
## [52] iterators_1.0.10     R6_2.3.0             igraph_1.2.2
## [55] nlme_3.1-137         compiler_3.5.2
```

## References

Bates, Douglas, Martin Mächler, Ben Bolker, and Steve Walker. 2015. “Fitting Linear Mixed-Effects Models Using lme4.” *Journal of Statistical Software* 67 (1):1–48. <https://doi.org/10.18637/jss.v067.i01>.

Reiss, Simon, Ilka Rebhan, Perdita Backes, Ines Romero-Brey, Holger Erfle, Petr Matula, Lars Kaderali, et al. 2011. “Recruitment and activation of a lipid kinase by hepatitis C virus NS5A is essential for integrity of the membranous replication compartment.” *Cell Host & Microbe* 9 (1). Elsevier:32–45.

Wilde, Adriaan H de, Kazimier F Wannee, Florine EM Scholte, Jelle J Goeman, Peter ten Dijke, Eric J Snijder, Marjolein Kikkert, and Martijn J van Hemert. 2015. “A Kinome-Wide Small Interfering Rna Screen Identifies Proviral and Antiviral Host Factors in Severe Acute Respiratory Syndrome Coronavirus Replication, Including Double-Stranded Rna-Activated Protein Kinase and Early Secretory Pathway Proteins.” *Journal of Virology* 89 (16). Am Soc Microbiol:8318–33.