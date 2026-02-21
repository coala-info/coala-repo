# Using NicheNet with OmnipathR

Denes Turei\*, Alberto Valdeolivas and Julio Saez-Rodriguez1

1Institute for Computational Biomedicine, Heidelberg University

\*turei.denes@gmail.com

#### 29 January 2026

#### Abstract

NicheNet is a method to infer ligand activities from transcriptomics data.
It relies on prior knowledge which includes signaling networks and
transcriptomics data from ligand perturbation experiments. OmnipathR
provides a close integration with NicheNet: it provides methods to build
the networks directly from the original sources in a format suitable for
NicheNet in a highly customizable way. OmnipathR also provides a workflow
template which connects OmnipathR and NicheNet methods from building the
prior knowledge up until the inference of ligand activities. With this
pipeline the only thing users need to provide is processed transcriptomics
data.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Status](#status)
* [2 Introduction](#introduction)
* [3 Run the workflow by a single call](#run-the-workflow-by-a-single-call)
* [4 Only model building](#only-model-building)
* [5 Installing packages and loading nichenetr](#installing-packages-and-loading-nichenetr)
* [6 Testing the pipeline](#testing-the-pipeline)
* [7 Workflow steps](#workflow-steps)
  + [7.1 Networks](#networks)
    - [7.1.1 Signaling network](#signaling-network)
    - [7.1.2 Raw data from network resources](#raw-data-from-network-resources)
    - [7.1.3 Ligand-receptor interactions and gene regulation](#ligand-receptor-interactions-and-gene-regulation)
      * [7.1.3.1 The OmniPath ligand-receptor network](#the-omnipath-ligand-receptor-network)
    - [7.1.4 Small network](#small-network)
  + [7.2 Ligand perturbation experiments](#ligand-perturbation-experiments)
  + [7.3 Model optimization](#model-optimization)
  + [7.4 Model build](#model-build)
  + [7.5 Ligand-target matrix](#ligand-target-matrix)
  + [7.6 Ligand activities](#ligand-activities)
* [8 Further steps](#further-steps)
* [Session info](#session-info)
* [References](#references)
* **Appendix**

1 Institute for Computational Biomedicine, Heidelberg University

# 1 Status

The integration between NicheNet and OmniPath is a fresh development, as of
May 2021 we have already tested the basic functionality. To use the features
described here you will need the [latest git version of OmnipathR](https://github.com/saezlab/OmnipathR), which we update often as we test and
improve the elements of the pipeline. Bug reports, questions and suggestions
are welcome, please open an issue on [github](https://github.com/saezlab/OmnipathR/issues).

# 2 Introduction

The OmnipathR package contains methods to build NichNet[1] format networks
from OmniPath[2] data and from the resources used in the original NicheNet
study. With a few exceptions, almost all resources used originally by
NicheNet are available by OmnipathR both in their raw format or after minimal
preprocessing, and in the format suitable for NicheNet. However, the networks
built by OmnipathR are not completely identical with the ones used by
NicheNet due to the complexity of processing such a large amount of data.
The advantage of building these networks with OmnipathR is the transparent
and reproducible process, as the origin of any data record can be easily
traced back to its original source. The data used in the NicheNet publication
is deposited at [Zenodo](https://zenodo.org/record/3260758). The other part
of the prior knowledge used by NicheNet is a collection of expression data
from ligand perturbation experiments. In OmnipathR this is taken directly
from the Zenodo repository.

Apart from building the prior knowledge, OmnipathR provides a number of glue
methods which connect elements of the NicheNet workflow, ultimately making it
possible to run everything with a single function call, starting from the
processed transcriptomics data and going until the predicted ligand
activities. To implement such a workflow we followed the [analysis from the
case study](https://workflows.omnipathdb.org/nichenet1.html) in the [OmniPath
paper](https://www.biorxiv.org/content/10.1101/2020.08.03.221242v2) and the
[vignettes](https://github.com/saeyslab/nichenetr/tree/master/vignettes) from
NicheNet. The workflow consists of thin wrappers around some of the NicheNet
methods. Parameters for these methods can be provided from the top level call.

The transcriptomics data is the main input for the pipeline which is specific
for the study. The transcriptomics data can be processed by standard tools,
such as
[DESeq](https://bioconductor.org/packages/release/bioc/html/DESeq.html)[3]
for bulk and [Seurat](https://satijalab.org/seurat/)[4] for single-cell
transcriptomics. For the latter more guidance is available in the [NicheNet
vignettes](https://github.com/saeyslab/nichenetr/blob/master/vignettes/%20seurat_wrapper.md). The pipeline presented here only requires the list of
genes expressed in the transmitter and receiver cells (in case of autocrine
signaling these are the same); and a list with genes of interest. Genes of
interest might come from the investigation subject or gene set enrichment
analysis (see an example
[here](https://workflows.omnipathdb.org/nichenet1.html)).

# 3 Run the workflow by a single call

The `nichenet_main` function executes all the workflow elements, hence it can
be used to run the complete workflow. Here we show it as an example, and in
the next sections we take a closer look at the individual steps. The first
four arguments comes from the study data and objective, as discussed above.
All parameters of the workflow can be overridden here, for example, for the
`mlrbo_optimization` we override the `ncores` argument, and exclude CPDB
from the signaling network and set the confidence threshold for EVEX.

```
library(OmnipathR)
library(nichenetr)

nichenet_results <- nichenet_main(
    expressed_genes_transmitter = expressed_genes_transmitter,
    expressed_genes_receiver = expressed_genes_receiver,
    genes_of_interest = genes_of_interest,
    background_genes = background_genes,
    signaling_network = list(
        cpdb = NULL,
        evex = list(min_confidence = 1.0)
    ),
    gr_network = list(only_omnipath = TRUE),
    n_top_ligands = 20,
    mlrmbo_optimization_param = list(ncores = 4)
)
```

# 4 Only model building

Without transcriptomics data, it is possible to build a NicheNet model which
later can be used for the ligand activity prediction. Hence if the first four
arguments above are `NULL` the pipeline will run only the model building.
Still, in this tutorial we wrap all blocks into `eval = FALSE` because the
model optimization is computationally intensive, it might take hours to run.
To create the NicheNet model it’s enough to call `nichenet_main` without
arguments, all further arguments are optional override of package defaults.

```
nichenet_model <- nichenet_main()
```

# 5 Installing packages and loading nichenetr

Before running the pipeline it’s necessary to install `nichenetr` and its
dependencies. The `nichenetr` package is available only from github, while
the dependencies are distributed in standard repositories like CRAN.

```
require(devtools)
install_github('saeyslab/nichenetr')
```

This procedure should install the dependencies as well. Some more specific
dependencies are `mlrMBO`, `parallelMap`, `ParamHelpers` and `smoof`.

The `nichenetr` package is suggested by `OmnipathR` but not loaded and
attached by default. This might cause issues, for example NicheNet requires
access to some of its lazy loaded external data. To address this, you can
either attach `nichenetr`:

```
library(nichenetr)
```

Or call a function which loads the datasets into the global environment, so
NicheNet can access them:

```
nichenet_workarounds()
```

# 6 Testing the pipeline

With a fresh setup, as a first step it is recommended to test the pipeline,
to make sure it is able to run in your particular environment, all packages
are installed and loaded properly. The optimization process takes hours to
run, while the test included in `OmnipathR` takes only around 10 minutes.
This way you can avoid some errors to come up after running the analysis
already for many hours. Although it’s never guaranteed that you won’t have
errors in the pipeline as the outcome depends on the input data and certain
conditions are not handled in `nichenetr`, `mlr` and `mlrMBO`. If you get
an error during the optimization process, start it over a few times to see
if it’s consistent. Sometimes it helps also to restart your R session. I
would recommend to try it around 10 times before suspecting a bug. See more
details in the docs of `nichenet_test`.

The `nichenet_test` function builds a tiny network and runs the pipeline
with a highly reduced number of parameters and iteration steps in the
optimization. Also it inputs dummy gene sets as genes of interest and
background genes.

```
require(OmnipathR)
nichenet_workarounds()
nichenet_test()
```

# 7 Workflow steps

## 7.1 Networks

NicheNet requires three types of interactions: signaling, ligand-receptor (lr)
and gene regulatory (gr). All these are collected from various resources. In
OmnipathR a top level function, `nichenet_networks` manages the build of all
the three networks. It returns a list with three data frames:

```
networks <- nichenet_networks()
```

Its `only_omnipath` argument is a shortcut to build all networks by using
only OmniPath data:

```
networks <- nichenet_networks(only_omnipath = TRUE)
```

To the network building functions of OmniPath many further arguments can
be provided, at the end these are passed to
`post_translational`, `intercell_network` and
`transcriptional`, so we recommend to read the manual of
these functions. As an example, one can restrict the signaling network to
the resources SIGNOR and PhosphoSite, while for ligand-receptor use only
ligands and enzymes on the transmitter side and receptors and transporters
on the receiver side, while for gene regulatory network, use only the A
confidence level of DoRothEA:

```
networks <- nichenet_networks(
    only_omnipath = TRUE,
    signaling_network = list(
        omnipath = list(
            resources = c('SIGNOR', 'PhosphoSite')
        )
    ),
    lr_network = list(
        omnipath = list(
            transmitter_param = list(parent = c('ligand', 'secreted_enzyme')),
            receiver_param = list(parent = c('receptor', 'transporter'))
        )
    ),
    gr_network = list(
        omnipath = list(
            resources = 'DoRothEA',
            dorothea_levels = 'A'
        )
    )
)
```

### 7.1.1 Signaling network

The function `nichenet_signaling_network` builds the signaling network from
all resources with the default settings. Each argument of this function is a
list of arguments for a single resource. If an argument is set to `NULL`, the
resource will be omitted. In the example below we set custom confidence score
thresholds for ConsensusPathDB and EVEX, while use no data from Pathway
Commons. In this case, the rest of the resources will be loaded with their
default parameters:

```
signaling_network <- nichenet_signaling_network(
    cpdb = list(
        complex_max_size = 1,
        min_score = .98
    ),
    evex = list(
        min_confidence = 2
    ),
    pathwaycommons = NULL
)
```

Currently the following signaling network resources are available by
OmnipathR: OmniPath, Pathway Commons, Harmonizome (PhosphoSite, KEA and
DEPOD), Vinayagam et al. 2011, ConsensusPathDB, EVEX and InWeb InBioMap.
Let’s take a closer look on one of the resource specific methods. The name
of these functions all follow the same scheme, e.g. for EVEX it is:
`nichenet_signaling_network_evex`. From most of the resources we just load
and format the interactions, but a few of them accepts parameters, such as
confidence score thresholds or switches to include or exclude certain kind
of records:

### 7.1.2 Raw data from network resources

```
evex_signaling <- nichenet_signaling_network_evex(top_confidence = .9)
```

The network format of NicheNet is very minimalistic, it contains only the
interacting partners and the resource. To investigate the data more in depth,
we recommend to look at the original data. The methods retrieving data from
resources all end by `_download` for foreign resources and start by ``
for OmniPath. For example, to access the EVEX data as it is provided by the
resource:

```
evex <- evex_download(remove_negatives = FALSE)
```

### 7.1.3 Ligand-receptor interactions and gene regulation

These networks work exactly the same way as the signaling network: they are
built by the `nichenet_lr_network` and `nichenet_gr_network` functions.
Currently the following ligand-receptor network resources are available in
OmnipathR: OmniPath, Ramilowski et al. 2015, Guide to Pharmacology
(IUPHAR/BPS); and in the gene regulatory network: OmniPath, Harmonizome,
RegNetwork, HTRIdb, ReMap, EVEX, PathwayCommons and TRRUST.

#### 7.1.3.1 The OmniPath ligand-receptor network

The ligand-receptor interactions from OmniPath are special: these cover
broader categories than only ligands and receptors. It includes also
secreted enzymes, transporters, etc. Also the `intercell_network`
function, responsible for creating the OmniPath LR network, by default
returns the most complete network. However, this contains a considerable
number of interactions which might be false positives in the context of
intercellular communication. It is highly recommended to apply quality
filtering on this network, using the `quality_filter_param` argument of
the functions in the NicheNet pipeline. The default settings already
ensure a certain level of filtering, read more about the options in the
docs of `filter_intercell_network`. Passing the `high_confidence = TRUE`
argument by `lr_network = list(omnipath = list(high_confidence = TRUE))`
results a quite stringent filtering, it’s better to find your preferred
options and set them by `quality_filter_param`. An example how to pass
quality options from the top of the pipeline:

```
nichenet_results <- nichenet_main(
    quality_filter_param = list(
        min_curation_effort = 1,
        consensus_percentile = 30
    )
)
```

### 7.1.4 Small network

Initially for testing purposes we included an option to create a small
network (few thousands interactions instead of few millions), using only
a high quality subset of OmniPath data. It might be interesting to try
the analysis with this lower coverage but higher confidence network:

```
nichenet_results <- nichenet_main(small = TRUE)
```

The small network is not customizable, and it uses the `high_confidence`
option in `intercell_network`. You can build similar smaller networks
by using the general options instead. Another option `tiny` generates an
even smaller network, however this involves a random subsetting, the outcome
is not deterministic, this option is only for testing purposes.

## 7.2 Ligand perturbation experiments

The expression data from the collection of over a hundred of ligand
perturbation experiments is available in the data deposited by NicheNet
authors in [Zenodo](https://zenodo.org/record/3260758), in the
`expression_settings.rds` file. The function below downloads and imports
this data:

```
expression <- nichenet_expression_data()
```

If there is any ligand which is missing from the ligand-receptor network,
probably we want to remove it:

```
lr_network <- nichenet_lr_network()
expression <- nichenet_remove_orphan_ligands(
    expression = expression,
    lr_network = lr_network
)
```

## 7.3 Model optimization

In this step we optimize the parameters of the model and assign weights to
the network resources, especially based on the ligand perturbation data. The
`nichenet_optimization` function is a wrapper around
`nichenetr::mlrmbl_optimization`. The arguments for this function, and the
objective function can be overriden, for example it’s a good idea to set
the cores according to our machine’s CPU count:

```
optimization_results <- nichenet_optimization(
    networks = networks,
    expression = expression,
    mlrmbo_optimization_param = list(ncores = 4)
)
```

This function takes very long, even hours to run. Before it returns the
results, it saves them into an RDS file. This and the further RDS files are
saved into the `nichenet_results` directory by default, it can be changed
by the option `omnipath.nichenet_results_dir`.

```
options(omnipath.nichenet_results_dir = 'my/nichenet/dir')
nichenet_results_dir()
# [1] "my/nichenet/dir"
```

## 7.4 Model build

The next major part is to build a model which connects ligands to targets,
i.e. which genes are affected in their expression by which of the ligands.
Again, we use a wrapper around NicheNet functions: the `nichenet_build_model`
calls `nichenetr::onstruct_weighted_networks` and
`nichenetr::apply_hub_corrections`. If the argument `weights` is `FALSE`,
the optimized resource weights are not used, all resources considered with
the same weight. The results are saved automatically into an RDS.

```
nichenet_model <- nichenet_build_model(
    optimization_results = optimization_results,
    networks = networks,
)
```

## 7.5 Ligand-target matrix

Finally, we produce a ligand-target matrix, a sparse matrix with weighted
connections from ligands to targets. The function
`nichenet_ligand_target_matrix` is a wrapper around
`nichenetr::construct_ligand_target_matrix`. As usual the results are
exported to an RDS. This is the last step of the NicheNet model building
process.

```
lt_matrix <- nichenet_ligand_target_matrix(
    nichenet_model$weighted_networks,
    networks$lr_network,
    nichenet_model$optimized_parameters
)
```

## 7.6 Ligand activities

In this step we ues the NicheNet model to infer ligand activities from our
transcriptomics data. The last three arguments are all character vectors
with gene symbols. For genes of interest, here we select 50 random genes
from the targets in the ligand-target matrix. Also just for testing
purposes, we consider all genes in the network to be expressed in both
the transmitter and receiver cells.

```
genes_of_interest <- sample(rownames(ligand_target_matrix), 50)
background_genes <- setdiff(
    rownames(ligand_target_matrix),
    genes_of_interest
)
expressed_genes_transmitter <- union(
    unlist(purrr::map(networks, 'from')),
    unlist(purrr::map(networks, 'to'))
)
expressed_genes_receiver <- expressed_genes_transmitter

ligand_activities <- nichenet_ligand_activities(
    ligand_target_matrix = lt_matrix,
    lr_network = networks$lr_network,
    expressed_genes_transmitter = expressed_genes_transmitter,
    expressed_genes_receiver = expressed_genes_receiver,
    genes_of_interest = genes_of_interest
)
```

Once the ligand activities inferred, we can obtain a list of top ligand-target
links. It’s up to us how many of the top ranking ligands, and for each of
these ligands, how many of their top targets we include in this table:

```
lt_links <- nichenet_ligand_target_links(
    ligand_activities = ligand_activities,
    ligand_target_matrix = lt_matrix,
    genes_of_interest = genes_of_interest,
    n_top_ligands = 20,
    n_top_targets = 100
)
```

# 8 Further steps

The NicheNet workflow in OmnipathR is implemented until this point. The
results can be visualized by the methods included in `nichenetr`, can be
analysed for enrichment of functional properties, or the signaling network
connecting the ligands to targets can be reconstructed and analysed,
as it’s shown in the OmniPath
[case study](https://workflows.omnipathdb.org/nichenet1.html).

# Session info

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] magrittr_2.0.4   ggraph_2.2.2     igraph_2.2.1     ggplot2_4.0.1    dplyr_1.1.4      OmnipathR_3.18.4
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    viridisLite_0.4.2   farver_2.1.2        blob_1.3.0          viridis_0.6.5
##  [6] R.utils_2.13.0      S7_0.2.1            fastmap_1.2.0       tweenr_2.0.3        promises_1.5.0
## [11] XML_3.99-0.20       digest_0.6.39       timechange_0.3.0    lifecycle_1.0.5     processx_3.8.6
## [16] RSQLite_2.4.5       compiler_4.5.2      rlang_1.1.7         sass_0.4.10         progress_1.2.3
## [21] tools_4.5.2         utf8_1.2.6          yaml_2.3.12         knitr_1.51          labeling_0.4.3
## [26] graphlayouts_1.2.2  prettyunits_1.2.0   bit_4.6.0           curl_7.0.0          xml2_1.5.2
## [31] RColorBrewer_1.1-3  websocket_1.4.4     withr_3.0.2         purrr_1.2.1         R.oo_1.27.1
## [36] polyclip_1.10-7     grid_4.5.2          scales_1.4.0        MASS_7.3-65         tinytex_0.58
## [41] dichromat_2.0-0.1   cli_3.6.5           rmarkdown_2.30      crayon_1.5.3        generics_0.1.4
## [46] otel_0.2.0          httr_1.4.7          tzdb_0.5.0          sessioninfo_1.2.3   readxl_1.4.5
## [51] DBI_1.2.3           cachem_1.1.0        chromote_0.5.1      ggforce_0.5.0       stringr_1.6.0
## [56] rvest_1.0.5         parallel_4.5.2      BiocManager_1.30.27 selectr_0.5-1       cellranger_1.1.0
## [61] vctrs_0.7.1         jsonlite_2.0.0      bookdown_0.46       hms_1.1.4           ggrepel_0.9.6
## [66] bit64_4.6.0-1       magick_2.9.0        jquerylib_0.1.4     tidyr_1.3.2         glue_1.8.0
## [71] ps_1.9.1            lubridate_1.9.4     stringi_1.8.7       gtable_0.3.6        later_1.4.5
## [76] tibble_3.3.1        logger_0.4.1        pillar_1.11.1       rappdirs_0.3.4      htmltools_0.5.9
## [81] R6_2.6.1            httr2_1.2.2         tcltk_4.5.2         tidygraph_1.3.1     vroom_1.7.0
## [86] evaluate_1.0.5      readr_2.1.6         R.methodsS3_1.8.2   backports_1.5.0     memoise_2.0.1
## [91] bslib_0.10.0        Rcpp_1.1.1          zip_2.3.3           gridExtra_2.3       checkmate_2.3.3
## [96] xfun_0.56           fs_1.6.6            pkgconfig_2.0.3
```

# References

# Appendix

[1] R Browaeys, W Saelens and Y Saeys (2020) NicheNet: modeling intercellular
communication by linking ligands to target genes. *Nat Methods* 17, 159–162

[2] D Turei, A Valdeolivas, L Gul, N Palacio-Escat, M Klein, O Ivanova,
M Olbei, A Gabor, F Theis, D Modos, T Korcsmaros and J Saez-Rodriguez (2021)
Integrated intra- and intercellular signaling knowledge for multicellular
omics analysis. *Molecular Systems Biology* 17:e9923

[3] S Anders, W Huber (2010) Differential expression analysis for sequence
count data. *Genome Biol* 11, R106

[4] Y Hao, S Hao, E Andersen-Nissen, WM Mauck, S Zheng, A Butler, MJ Lee,
AJ Wilk, C Darby, M Zagar, P Hoffman, M Stoeckius, E Papalexi, EP Mimitou,
J Jain, A Srivastava, T Stuart, LB Fleming, B Yeung, AJ Rogers, JM McElrath,
CA Blish, R Gottardo, P Smibert and R Satija (2020) Integrated analysis of
multimodal single-cell data. *bioRxiv* 2020.10.12.335331