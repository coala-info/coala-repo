# Using gatom package

Anstasiia Gainullina, Mariia Emelianova, Alexey Sergushichev

#### October 2023

# Contents

* [1 Installation](#installation)
* [2 Example workfow](#example-workfow)
* [3 Saving modules](#saving-modules)
* [4 Example on full data and full network](#example-full)
* [5 Networks](#networks)
  + [5.1 KEGG](#kegg-network)
  + [5.2 Rhea](#rhea)
  + [5.3 Combined network](#combined-network)
  + [5.4 Rhea lipid subnetwork](#rhea-lipid-subnetwork)
* [6 Misc](#misc)
  + [6.1 Supplementary gene files](#suppl-genes)
  + [6.2 Non-enzymatic reactions](#non-enzymatic-reactions)
  + [6.3 Using exact solver](#exact-solver)
  + [6.4 Running with no metabolite data](#running-with-no-metabolite-data)
  + [6.5 Running with no gene data](#running-with-no-gene-data)
  + [6.6 Using metabolite-level network](#met-topology)
  + [6.7 Pathway annotation](#pathway-annotation)

This tutorial describes an R-package for finding active metabolic modules
based on high throughput data. The pipeline takes as input transcriptional and/or metabolic data
and finds a metabolic subnetwork (module) most regulated between the two
conditions of interest.

The package relies on the active module analysis framework
developed in [BioNet package](https://bioconductor.org/packages/BioNet),
but extends it to work with metabolic reaction networks.
Further, it illustrates the usage of [mwcsr package](https://cran.r-project.org/package%3Dmwcsr)
which provides a number of solvers for Maximum Weight Connected Subgraph problem and its variants.

Example of using the pipeline include:

* studying metabolic differences between pro- and anti-inflammatory macrophage activation ([Jha et al, 2015](http://dx.doi.org/10.1016/j.immuni.2015.02.005));
* studying metabolic rewiring associated with glucose-independent tumor growth ([Vinent at al, 2015](http://dx.doi.org/10.1016/j.molcel.2015.08.013));
* identification of deregulation of energy metabolism in Trem2-deficient macrophages ([Ulland et al, 2017](http://doi.org/10.1016/j.cell.2017.07.023));
* identification of inositol-triphosphate metabolism activation in monocytes in fasting mice ([Jordan et al, 2019](https://doi.org/10.1016/j.cell.2019.07.050)).

More details on the pipeline are available in [Sergushichev et al, 2016](http://dx.doi.org/10.1093/nar/gkw266) and [Emelianova et al, 2022](https://doi.org/10.1093/nar/gkac427).

# 1 Installation

You can install **gatom** via `BiocManager`:

```
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
#
# BiocManager::install("gatom")
```

# 2 Example workfow

In this example we will find an active metabolic module based on macrophage
activation gene expression and metabolomics data
([Jha et al, 2015](http://dx.doi.org/10.1016/j.immuni.2015.02.005)).
For improved performance here we will consider a simplified version of the data.
See [Example on full data and full network](#example-full) section for the real-scale analysis.

```
library(gatom)
library(data.table)
library(igraph)
library(mwcsr)
```

First let’s load the example tables with input differential gene expression
and metabolite abundance data for LPS-IFNg stimulated macrophages compared to controls:

```
data("gene.de.rawEx")
print(head(gene.de.rawEx))
```

```
## # A tibble: 6 × 4
##   ID               pval log2FC baseMean
##   <chr>           <dbl>  <dbl>    <dbl>
## 1 NM_008392    8.83e-16  10.3   16589.
## 2 NM_001110517 1.12e-12   5.97    153.
## 3 NM_001253809 3.22e-11  -5.87     43.6
## 4 NM_013693    1.88e-10   4.92    326.
## 5 NM_009114    8.59e-10  -3.21    473.
## 6 NM_021491    2.36e- 9  -6.69     50.9
```

```
data("met.de.rawEx")
print(head(met.de.rawEx))
```

```
## # A tibble: 6 × 4
##   ID            pval log2FC baseMean
##   <chr>        <dbl>  <dbl>    <dbl>
## 1 HMDB02092 8.83e-34  3.12      17.1
## 2 HMDB00749 8.83e-34  3.12      17.1
## 3 HMDB00263 3.16e-19  1.41      12.8
## 4 HMDB01316 2.88e-13 -1.23      13.2
## 5 HMDB00191 4.39e-13  0.735     16.4
## 6 HMDB01112 6.60e-13  0.653     15.2
```

Next we will load example network related objects: global reaction network (`networkEx` object),
metabolite annotations (`met.kegg.dbEx`), and organism-specific enzyme annotations for mouse (`org.Mm.eg.gatom.annoEx`).

```
data("networkEx")
data("met.kegg.dbEx")
data("org.Mm.eg.gatom.annoEx")
```

Here `networkEx` object contain information about 204 KEGG reactions, their atom mappings and relation to enzymes:

```
str(networkEx, max.level=1, give.attr = FALSE)
```

```
## List of 5
##  $ reactions      :Classes 'data.table' and 'data.frame':    204 obs. of  4 variables:
##  $ enzyme2reaction:Classes 'data.table' and 'data.frame':    243 obs. of  2 variables:
##  $ reaction2align :Classes 'data.table' and 'data.frame':    3919 obs. of  3 variables:
##  $ atoms          :Classes 'data.table' and 'data.frame':    1689 obs. of  3 variables:
##  $ metabolite2atom:Classes 'data.table' and 'data.frame':    1689 obs. of  2 variables:
```

Object `met.kegg.dbEx` contains information about 138 KEGG metabolites, including mappings from HMDB and ChEBI:

```
str(met.kegg.dbEx, max.level=2, give.attr = FALSE)
```

```
## List of 4
##  $ baseId     : chr "KEGG"
##  $ metabolites:Classes 'data.table' and 'data.frame':    138 obs. of  3 variables:
##   ..$ metabolite     : chr [1:138] "C00002" "C00003" "C00004" "C00005" ...
##   ..$ metabolite_name: chr [1:138] "ATP" "NAD+" "NADH" "NADPH" ...
##   ..$ metabolite_url : chr [1:138] "http://www.kegg.jp/entry/C00002" "http://www.kegg.jp/entry/C00003" "http://www.kegg.jp/entry/C00004" "http://www.kegg.jp/entry/C00005" ...
##  $ anomers    :List of 2
##   ..$ metabolite2base_metabolite:Classes 'data.table' and 'data.frame':  238 obs. of  2 variables:
##   ..$ base_metabolite2metabolite:Classes 'data.table' and 'data.frame':  238 obs. of  2 variables:
##  $ mapFrom    :List of 2
##   ..$ HMDB :Classes 'data.table' and 'data.frame':   212 obs. of  2 variables:
##   ..$ ChEBI:Classes 'data.table' and 'data.frame':   161 obs. of  2 variables:
```

Object `org.Mm.eg.gatom.annoEx` contains mouse-specific mapping between enzyme classes
and genes, as well as mapping between different types of gene identifiers:

```
str(org.Mm.eg.gatom.annoEx, max.level=2, give.attr = FALSE)
```

```
## List of 4
##  $ baseId     : chr "Entrez"
##  $ gene2enzyme:Classes 'data.table' and 'data.frame':    150 obs. of  2 variables:
##   ..$ gene  : chr [1:150] "100042025" "100198" "100198" "100678" ...
##   ..$ enzyme: chr [1:150] "1.2.1.12" "3.1.1.31" "1.1.1.47" "3.1.3.3" ...
##  $ genes      :Classes 'data.table' and 'data.frame':    135 obs. of  2 variables:
##   ..$ gene  : chr [1:135] "100042025" "100198" "100678" "100705" ...
##   ..$ symbol: chr [1:135] "Gapdh-ps15" "H6pd" "Psph" "Acacb" ...
##  $ mapFrom    :List of 3
##   ..$ RefSeq :Classes 'data.table' and 'data.frame': 724 obs. of  2 variables:
##   ..$ Ensembl:Classes 'data.table' and 'data.frame': 135 obs. of  2 variables:
##   ..$ Symbol :Classes 'data.table' and 'data.frame': 135 obs. of  2 variables:
```

Then we create a metabolic graph with atom topology from the loaded data.
Depending on `topology` parameter, the graph vertices can correspond either
to `atoms` or `metabolites`. For metabolite topology,
see [Using metabolite-level network](#met-topology) section.

```
g <- makeMetabolicGraph(network=networkEx,
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx,
                        gene.de=gene.de.rawEx,
                        met.db=met.kegg.dbEx,
                        met.de=met.de.rawEx)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
print(g)
```

```
## IGRAPH 8808b4d UN-- 176 190 --
## + attr: name (v/c), metabolite (v/c), element (v/c), label (v/c), url
## | (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC (v/n), baseMean
## | (v/n), logPval (v/n), signal (v/c), label (e/c), pval (e/n), origin
## | (e/n), RefSeq (e/c), gene (e/c), enzyme (e/c), reaction_name (e/c),
## | reaction_equation (e/c), url (e/c), reaction (e/c), log2FC (e/n),
## | baseMean (e/n), logPval (e/n), signal (e/c), signalRank (e/n)
## + edges from 8808b4d (vertex names):
## [1] C00025_-0.3248_2.8125 --C00026_-0.3248_2.8125
## [2] C00025_-1.6238_3.5625 --C00026_-1.6238_3.5625
## [3] C00025_-2.9228_2.8125 --C00026_-2.9228_2.8125
## + ... omitted several edges
```

After creating the metabolic graph, we then score it, obtaining an instance of
Signal Generalized Maximum Weight Subgraph (SGMWCS) problem.

The size of the module can be controlled by changing scoring parameters `k.gene`
and `k.met`. The higher the values of scoring parameters are, the bigger the
module is going to be.

```
gs <- scoreGraph(g, k.gene = 25, k.met = 25)
```

Then we initialize an SMGWCS solver. Here, we use a heuristic relax-and-cut
solver `rnc_solver` for simplicity.

See `mwcsr` package documentation for more solver options, or
[Using exact solver](#exact-solver) section for the recommended way.

```
solver <- rnc_solver()
```

Then we find an active metabolic module with chosen solver and scored graph:

```
set.seed(42)
res <- solve_mwcsp(solver, gs)
m <- res$graph
```

The result module is an `igraph` object that captures the most regulated
reactions:

```
print(m)
```

```
## IGRAPH 4a28b75 UN-- 33 32 --
## + attr: signals (g/n), name (v/c), metabolite (v/c), element (v/c),
## | label (v/c), url (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC
## | (v/n), baseMean (v/n), logPval (v/n), signal (v/c), score (v/n),
## | label (e/c), pval (e/n), origin (e/n), RefSeq (e/c), gene (e/c),
## | enzyme (e/c), reaction_name (e/c), reaction_equation (e/c), url
## | (e/c), reaction (e/c), log2FC (e/n), baseMean (e/n), logPval (e/n),
## | signal (e/c), signalRank (e/n), score (e/n)
## + edges from 4a28b75 (vertex names):
## [1] C00025_-1.6238_3.5625--C00026_-1.6238_3.5625
## [2] C00022_-1.299_2.25   --C00041_-1.299_2.25
## + ... omitted several edges
```

```
head(E(m)$label)
```

```
## [1] "Psat1" "Gpt2"  "Got2"  "Shmt1" "Pkm"   "Tpi1"
```

```
head(V(m)$label)
```

```
## [1] "Pyruvate"       "L-Glutamate"    "2-Oxoglutarate" "Oxaloacetate"
## [5] "Glycine"        "L-Alanine"
```

The module can be plotted in R Viewer with `createShinyCyJSWidget()`.
Here, red color corresponds to up-regulation (positive log-2 fold change) and
green to down-regulation (negative log-2 fold change). Blue nodes and edges
come from data with absent log-2 fold change values. Bigger size of nodes and
width of edges reflect lower p-values.

```
createShinyCyJSWidget(m)
```

# 3 Saving modules

We can save the module to graphml format with `write_graph()` function from `igraph`:

```
write_graph(m, file = file.path(tempdir(), "M0.vs.M1.graphml"), format = "graphml")
```

Or it can be saved to an interactive html widget:

```
saveModuleToHtml(module = m, file = file.path(tempdir(), "M0.vs.M1.html"),
                 name="M0.vs.M1")
```

We can also save the module to dot format:

```
saveModuleToDot(m, file = file.path(tempdir(), "M0.vs.M1.dot"), name = "M0.vs.M1")
```

Such dot file can be further used to generate svg file using `neato` tool
from graphviz suite if it is installed on the system:

```
system(paste0("neato -Tsvg ", file.path(tempdir(), "M0.vs.M1.dot"),
              " > ", file.path(tempdir(), "M0.vs.M1.svg")),
       ignore.stderr=TRUE)
```

Alternatively, the module can be saved to pdf format with a nice layout.

You may vary the meaning of repel force and the number of iterations of
repel algorithm for label layout. Note, that the larger your graph is the softer
force you should use.

You may also set different seed for different variants of edge layout with `set.seed()`.

```
set.seed(42)
saveModuleToPdf(m, file = file.path(tempdir(), "M0.vs.M1.pdf"), name = "M0.vs.M1",
                n_iter=100, force=1e-5)
```

# 4 Example on full data and full network

Let’s now look at how the analysis will work with the full dataset and the full network.
For this case we will be using the combined network instead of KEGG network
(see [Networks](#networks) for details on the network types).

```
library(R.utils)
library(data.table)
```

The full macrophage LPS+IFNG-activation dataset can be downloaded from
<http://artyomovlab.wustl.edu/publications/supp_materials/GAM/>:

```
met.de.raw <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GAM/Ctrl.vs.MandLPSandIFNg.met.de.tsv.gz")
gene.de.raw <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GAM/Ctrl.vs.MandLPSandIFNg.gene.de.tsv.gz")
```

Full pre-generated combined network, corresponding metabolite annotation,
and enzyme annotation can be downloaded from <http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/>:

```
network.combined <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.combined.rds"))
met.combined.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.combined.db.rds"))

org.Mm.eg.gatom.anno <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/org.Mm.eg.gatom.anno.rds"))
```

For better work of the combined network we highly recommend using additional
supplementary gene files (see [Supplementary Genes](#suppl-genes)).

```
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.combined.mmu.eg.tsv", colClasses="character")
```

Running `gatom` on the combined network and the full dataset:

```
cg <- makeMetabolicGraph(network=network.combined,
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=gene.de.raw,
                         met.db=met.combined.db,
                         met.de=met.de.raw,
                         gene2reaction.extra=gene2reaction.extra)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
cgs <- scoreGraph(cg, k.gene = 50, k.met = 50)
```

```
## Metabolite p-value threshold: 0.038971
```

```
## Metabolite BU alpha: 0.078854
```

```
## FDR for metabolites: 0.054345
```

```
## Gene p-value threshold: 0.001204
```

```
## Gene BU alpha: 0.153709
```

```
## FDR for genes: 0.006234
```

```
solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, cgs)
cm <- sol$graph
cm
```

```
## IGRAPH a95873b UN-- 75 77 --
## + attr: signals (g/n), name (v/c), metabolite (v/c), element (v/c),
## | label (v/c), url (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC
## | (v/n), baseMean (v/n), logPval (v/n), signal (v/c), score (v/n),
## | label (e/c), pval (e/n), origin (e/n), RefSeq (e/c), gene (e/c),
## | enzyme (e/c), reaction_name (e/c), reaction_equation (e/c), url
## | (e/c), reaction (e/c), log2FC (e/n), baseMean (e/n), logPval (e/n),
## | signal (e/c), signalRank (e/n), score (e/n)
## + edges from a95873b (vertex names):
## [1] C00025_1.299_0.75--C00025_1.299_0.75  C00022_1.299_0.75--C00026_-1.299_0.75
## [3] C00025_1.299_0.75--C00026_-1.299_0.75 C00025_0_0       --C00026_1.299_0.75
## + ... omitted several edges
```

The result module for combined network:

```
createShinyCyJSWidget(cm)
```

# 5 Networks

We provide four types of networks that can be used for analysis:

1. KEGG network
2. Rhea network
3. Combined network
4. Rhea lipid subnetwork

## 5.1 KEGG

KEGG network consists of `network.kegg.rds` & `met.kegg.db.rds` files and is
based on [KEGG database](https://www.genome.jp/kegg/kegg1.html).

Both metabolites and reactions in KEGG network have KEGG IDs.

This network was generated with the pipeline available
[here](https://github.com/ctlab/KEGG-network-pipeline).
For extra details on KEGG network you can also reference
[shinyGatom](https://doi.org/10.1093/nar/gkac427) and
[GAM](https://doi.org/10.1093/nar/gkw266) articles.

```
network <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.kegg.rds"))
met.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.kegg.db.rds"))
```

Running `gatom` with KEGG network on full dataset:

```
kg <- makeMetabolicGraph(network=network,
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.anno,
                        gene.de=gene.de.raw,
                        met.db=met.db,
                        met.de=met.de.raw)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
kgs <- scoreGraph(kg, k.gene = 50, k.met = 50)
```

```
## Metabolite p-value threshold: 0.055133
```

```
## Metabolite BU alpha: 0.087937
```

```
## FDR for metabolites: 0.070765
```

```
## Gene p-value threshold: 0.002471
```

```
## Gene BU alpha: 0.164266
```

```
## FDR for genes: 0.010231
```

```
solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, kgs)
km <- sol$graph
km
```

```
## IGRAPH 9f2f2b0 UN-- 67 67 --
## + attr: signals (g/n), name (v/c), metabolite (v/c), element (v/c),
## | label (v/c), url (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC
## | (v/n), baseMean (v/n), logPval (v/n), signal (v/c), score (v/n),
## | label (e/c), pval (e/n), origin (e/n), RefSeq (e/c), gene (e/c),
## | enzyme (e/c), reaction_name (e/c), reaction_equation (e/c), url
## | (e/c), reaction (e/c), log2FC (e/n), baseMean (e/n), logPval (e/n),
## | signal (e/c), signalRank (e/n), score (e/n)
## + edges from 9f2f2b0 (vertex names):
## [1] C00025_-4.2219_3.5625--C00026_-4.2219_3.5625
## [2] C00025_0.9743_3.5625 --C00026_-4.2219_3.5625
## + ... omitted several edges
```

```
createShinyCyJSWidget(km)
```

## 5.2 Rhea

Rhea network consists of `network.rhea.rds` & `met.rhea.db.rds` files and
is based on [Rhea database](https://www.rhea-db.org/).

Reactions in Rhea have their own IDs, but unlike KEGG, metabolite IDs come
from a separate database – [ChEBI database](https://www.ebi.ac.uk/chebi/).

This network was generated with the pipeline available
[here](https://github.com/ctlab/Rhea-network-pipeline).
For extra details on Rhea network you can also reference
[shinyGatom](https://doi.org/10.1093/nar/gkac427) article.

To use Rhea network download the following files:

```
network.rhea <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.rhea.rds"))
met.rhea.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.rhea.db.rds"))
```

For proper work of the Rhea network we also need a corresponding
supplementary gene file (ref. [Supplementary Genes](#suppl-genes)).

```
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.rhea.mmu.eg.tsv", colClasses="character")
```

And run `gatom` on Rhea network:

```
rg <- makeMetabolicGraph(network=network.rhea,
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=gene.de.raw,
                         met.db=met.rhea.db,
                         met.de=met.de.raw,
                         gene2reaction.extra=gene2reaction.extra)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
rgs <- scoreGraph(rg, k.gene = 50, k.met = 50)
```

```
## Metabolite p-value threshold: 0.046206
```

```
## Metabolite BU alpha: 0.082053
```

```
## FDR for metabolites: 0.092911
```

```
## Gene p-value threshold: 0.000695
```

```
## Gene BU alpha: 0.161730
```

```
## FDR for genes: 0.004909
```

```
solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, rgs)
rm <- sol$graph
rm
```

```
## IGRAPH 5af05d4 UN-- 46 46 --
## + attr: signals (g/n), name (v/c), metabolite (v/c), element (v/c),
## | label (v/c), url (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC
## | (v/n), baseMean (v/n), logPval (v/n), signal (v/c), score (v/n),
## | label (e/c), pval (e/n), origin (e/n), RefSeq (e/c), gene (e/c),
## | enzyme (e/c), url (e/c), reaction (e/c), log2FC (e/n), baseMean
## | (e/n), logPval (e/n), signal (e/c), signalRank (e/n), score (e/n)
## + edges from 5af05d4 (vertex names):
## [1] CHEBI:15562_-2.9228_2.8125--CHEBI:16383_-0.3248_2.8125
## [2] CHEBI:15361_-1.299_3.75   --CHEBI:16452_-1.9486_3.375
## [3] CHEBI:15562_-2.9228_2.8125--CHEBI:16810_-0.3248_2.8125
## + ... omitted several edges
```

Result Rhea network module:

```
createShinyCyJSWidget(rm)
```

## 5.3 Combined network

Combined network comprises not only KEGG and Rhea reactions, but also transport
reactions from [BIGG database](http://bigg.ucsd.edu/).

This means that reactions in such network have either KEGG or Rhea or BIGG IDs,
and metabolite IDs are KEGGs and ChEBIs.

## 5.4 Rhea lipid subnetwork

Rhea lipid subnetwork is subset of Rhea reactions that involve lipids,
and it consists of `network.rhea.lipids.rds` & `met.rhea.lipids.db.rds` files.

This network was generated with the pipeline available
[here](https://github.com/ctlab/Rhea-network-pipeline).
For extra details on Rhea lipid subnetwork you can also reference
[shinyGatom](https://doi.org/10.1093/nar/gkac427) article.

```
network.lipids <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.rhea.lipids.rds"))
met.lipids.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.lipids.db.rds"))
```

For proper work of the lipid network we will also need a corresponding
supplementary gene file (ref. [Supplementary Genes](#suppl-genes))

```
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.rhea.mmu.eg.tsv", colClasses="character")
```

To test lipid network we will use example lipidomics data for WT mice control
vs high fat diet comparison from
[ST001289 dataset](https://www.metabolomicsworkbench.org/data/DRCCMetadata.php?Mode=Study&StudyID=ST001289).

```
met.de.lipids <- fread("https://artyomovlab.wustl.edu/publications/supp_materials/GATOM/Ctrl.vs.HighFat.lipid.de.csv")
```

For lipid network we recommend setting topology to `metabolites`
(ref. [Using metabolite-level network](#met-topology)):

```
lg <- makeMetabolicGraph(network=network.lipids,
                         topology="metabolites",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=NULL,
                         met.db=met.lipids.db,
                         met.de=met.de.lipids,
                         gene2reaction.extra=gene2reaction.extra)
```

```
## Found DE table for metabolites with Species IDs
```

```
lgs <- scoreGraph(lg, k.gene = NULL, k.met = 50)
```

```
## Metabolite p-value threshold: 0.009204
```

```
## Metabolite BU alpha: 0.145591
```

```
## FDR for metabolites: 0.006065
```

```
solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, lgs)
lm <- sol$graph
lm
```

```
## IGRAPH b5bec5b UN-- 47 46 --
## + attr: signals (g/n), name (v/c), metabolite (v/c), element (v/c),
## | label (v/c), url (v/c), LipidMaps_ID (v/c), SwissLipids_ID (v/c),
## | Class_LipidMaps (v/c), Abbreviation_LipidMaps (v/c),
## | Synonyms_LipidMaps (v/c), Class_SwissLipids (v/c),
## | Abbreviation_SwissLipids (v/c), pval (v/n), origin (v/n), Species
## | (v/c), Mean(ctrl) (v/n), Mean(exp) (v/n), FC (v/n), log2FC (v/n),
## | -Log10(p-value) (v/n), -Log10(padj) (v/n), adj.P.Val (v/n),
## | Significance(padj) (v/c), Significance(p-value) (v/c), logPval (v/n),
## | signal (v/c), score (v/n), label (e/c), pval (e/l), gene (e/c),
## | enzyme (e/c), url (e/c), reaction (e/c), score (e/n), signal (e/c)
## + edges from b5bec5b (vertex names):
```

Result lipid subnetwork module:

```
createShinyCyJSWidget(lm)
```

If IDs for metabolite differential abundance data are of type `Species` we can
process metabolite labels into more readable ones:

```
lm1 <- abbreviateLabels(lm, orig.names = TRUE, abbrev.names = TRUE)

createShinyCyJSWidget(lm1)
```

# 6 Misc

## 6.1 Supplementary gene files

For combined, Rhea and lipid networks we provide supplementary files with genes
that either come from proteome or are not linked to a specific enzyme.
These files are organism-specific and are also available at <http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/>.

```
network.combined <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.combined.rds"))
met.combined.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.combined.db.rds"))
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.combined.mmu.eg.tsv", colClasses="character")

gg <- makeMetabolicGraph(network=network.combined,
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=gene.de.raw,
                         met.db=met.combined.db,
                         met.de=met.de.raw,
                         gene2reaction.extra=gene2reaction.extra)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
gg
```

```
## IGRAPH 8378305 UN-- 5047 6374 --
## + attr: name (v/c), metabolite (v/c), element (v/c), label (v/c), url
## | (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC (v/n), baseMean
## | (v/n), logPval (v/n), signal (v/c), label (e/c), pval (e/n), origin
## | (e/n), RefSeq (e/c), gene (e/c), enzyme (e/c), reaction_name (e/c),
## | reaction_equation (e/c), url (e/c), reaction (e/c), log2FC (e/n),
## | baseMean (e/n), logPval (e/n), signal (e/c), signalRank (e/n)
## + edges from 8378305 (vertex names):
## [1] C00019_-0.75_-1.299--C00019_-0.75_-1.299
## [2] C00019_-1.5_0      --C00019_-1.5_0
## [3] C00019_0.75_-1.299 --C00019_0.75_-1.299
## + ... omitted several edges
```

## 6.2 Non-enzymatic reactions

Optionally, we can also preserve non-enzymatic reactions that are found in the network.
This can be done by setting `keepReactionsWithoutEnzymes` to `TRUE`:

```
ge <- makeMetabolicGraph(network=network.combined,
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=gene.de.raw,
                         met.db=met.combined.db,
                         met.de=met.de.raw,
                         gene2reaction.extra=gene2reaction.extra,
                         keepReactionsWithoutEnzymes=TRUE)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
ge
```

```
## IGRAPH 5b5a748 UN-- 5171 6519 --
## + attr: name (v/c), metabolite (v/c), element (v/c), label (v/c), url
## | (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC (v/n), baseMean
## | (v/n), logPval (v/n), signal (v/c), label (e/c), pval (e/n), origin
## | (e/n), RefSeq (e/c), gene (e/c), enzyme (e/c), reaction_name (e/c),
## | reaction_equation (e/c), url (e/c), reaction (e/c), log2FC (e/n),
## | baseMean (e/n), logPval (e/n), signal (e/c), signalRank (e/n)
## + edges from 5b5a748 (vertex names):
## [1] C00019_-0.75_-1.299--C00019_-0.75_-1.299
## [2] C00019_-1.5_0      --C00019_-1.5_0
## [3] C00019_0.75_-1.299 --C00019_0.75_-1.299
## + ... omitted several edges
```

## 6.3 Using exact solver

For proper analysis quality we recommend to use exact SGMWCS solver `virgo_solver()`,
which requires Java (version >= 11) and CPLEX (version >= 12.7) to be installed.
If the requirements are met you can then find a module as following:

```
vsolver <- virgo_solver(cplex_dir=Sys.getenv("CPLEX_HOME"),
                        threads=4, penalty=0.001, log=1)
sol <- solve_mwcsp(vsolver, gs)
m <- sol$graph
```

Edge penalty option there is used to remove excessive redundancy in genes.

## 6.4 Running with no metabolite data

If there is no metabolite data in your experiment assign `met.de` and `k.met` to `NULL`:

```
g <- makeMetabolicGraph(network=networkEx,
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx,
                        gene.de=gene.de.rawEx,
                        met.db=met.kegg.dbEx,
                        met.de=NULL)
```

```
## Found DE table for genes with RefSeq IDs
```

```
gs <- scoreGraph(g, k.gene = 50, k.met = NULL)
```

```
## Warning in bumOptim(x = x, starts): One or both parameters are on the limit of
## the defined parameter space
```

```
## Gene p-value threshold: 0.130626
```

```
## Gene BU alpha: 0.364527
```

```
## FDR for genes: 0.100000
```

## 6.5 Running with no gene data

If there is no gene data in your experiment assign `gene.de` and `k.gene` to `NULL`:

```
g <- makeMetabolicGraph(network=networkEx,
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx,
                        gene.de=NULL,
                        met.db=met.kegg.dbEx,
                        met.de=met.de.rawEx)
```

```
## Found DE table for metabolites with HMDB IDs
```

```
gs <- scoreGraph(g, k.gene = NULL, k.met = 50)
```

```
## Metabolite p-value threshold: 0.260385
```

```
## Metabolite BU alpha: 0.080774
```

```
## FDR for metabolites: 0.100000
```

## 6.6 Using metabolite-level network

Sometimes it could make sense to work with metabolite-metabolite topology
of the network, not atom-atom one. Such network is less structured, but contains
more genes.

```
gm <- makeMetabolicGraph(network=network,
                        topology="metabolite",
                        org.gatom.anno=org.Mm.eg.gatom.anno,
                        gene.de=gene.de.raw,
                        met.db=met.db,
                        met.de=met.de.raw)
```

```
## Found DE table for genes with RefSeq IDs
```

```
## Found DE table for metabolites with HMDB IDs
```

```
gms <- scoreGraph(gm, k.gene = 50, k.met = 50)
```

```
## Metabolite p-value threshold: 0.037216
```

```
## Metabolite BU alpha: 0.078983
```

```
## FDR for metabolites: 0.062353
```

```
## Gene p-value threshold: 0.001241
```

```
## Gene BU alpha: 0.163383
```

```
## FDR for genes: 0.006075
```

```
solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, gms)
mm <- sol$graph
mm
```

```
## IGRAPH d59c6f1 UN-- 63 63 --
## + attr: signals (g/n), name (v/c), metabolite (v/c), element (v/c),
## | label (v/c), url (v/c), pval (v/n), origin (v/n), HMDB (v/c), log2FC
## | (v/n), baseMean (v/n), logPval (v/n), signal (v/c), score (v/n),
## | label (e/c), pval (e/n), origin (e/n), RefSeq (e/c), gene (e/c),
## | enzyme (e/c), reaction_name (e/c), reaction_equation (e/c), url
## | (e/c), reaction (e/c), log2FC (e/n), baseMean (e/n), logPval (e/n),
## | signal (e/c), signalRank (e/n), score (e/n)
## + edges from d59c6f1 (vertex names):
##  [1] C00219--C05956 C00062--C05933 C00327--C05933 C00417--C00490 C00062--C00086
##  [6] C00157--C00162 C00157--C00219 C00162--C00350 C00550--C00588 C00669--C01879
## + ... omitted several edges
```

## 6.7 Pathway annotation

To get functional annotation of obtained modules by KEGG and Reactome
metabolic pathways, we can use hypergeometric test with `fora()` function from `fgsea` package.

```
foraRes <- fgsea::fora(pathways=org.Mm.eg.gatom.anno$pathways,
                       genes=E(km)$gene,
                       universe=unique(E(kg)$gene),
                       minSize=5)
foraRes[padj < 0.05]
```

```
##                                                                  pathway
##                                                                   <char>
## 1:  mmu_M00002: Glycolysis, core module involving three-carbon compounds
## 2:              mmu_M00003: Gluconeogenesis, oxaloacetate => fructose-6P
## 3: mmu_M00001: Glycolysis (Embden-Meyerhof pathway), glucose => pyruvate
## 4:                                      mmu00565: Ether lipid metabolism
## 5:                                mmu00010: Glycolysis / Gluconeogenesis
## 6:                                   mmu00030: Pentose phosphate pathway
## 7:                                   mmu00020: Citrate cycle (TCA cycle)
## 8:                              mmu00564: Glycerophospholipid metabolism
## 9:       mmu_M00004: Pentose phosphate pathway (Pentose phosphate cycle)
##            pval        padj foldEnrichment overlap  size overlapGenes
##           <num>       <num>          <num>   <int> <int>       <list>
## 1: 5.046444e-05 0.003532511       7.017241       5     5 21991, 1....
## 2: 2.695203e-04 0.005915625       5.847701       5     6 74551, 1....
## 3: 3.925355e-04 0.005915625       4.678161       6     9 212032, ....
## 4: 3.925355e-04 0.005915625       4.678161       6     9 18783, 2....
## 5: 4.225447e-04 0.005915625       3.050975      10    23 13806, 1....
## 6: 2.154500e-03 0.025135833       3.274713       7    15 110208, ....
## 7: 3.034903e-03 0.026789277       3.508621       6    12 11428, 1....
## 8: 3.061632e-03 0.026789277       2.631466       9    24 14571, 1....
## 9: 3.996354e-03 0.031082754       3.898467       5     9 110208, ....
```

Optionally, redundancy in pathways can be decreased with `collapsePathwaysORA()` function:

```
mainPathways <- fgsea::collapsePathwaysORA(
  foraRes[padj < 0.05],
  pathways=org.Mm.eg.gatom.anno$pathways,
  genes=E(km)$gene,
  universe=unique(E(kg)$gene))
foraRes[pathway %in% mainPathways$mainPathways]
```

```
##                                                                 pathway
##                                                                  <char>
## 1: mmu_M00002: Glycolysis, core module involving three-carbon compounds
## 2:                                     mmu00565: Ether lipid metabolism
## 3:                                  mmu00030: Pentose phosphate pathway
## 4:                                  mmu00020: Citrate cycle (TCA cycle)
##            pval        padj foldEnrichment overlap  size overlapGenes
##           <num>       <num>          <num>   <int> <int>       <list>
## 1: 5.046444e-05 0.003532511       7.017241       5     5 21991, 1....
## 2: 3.925355e-04 0.005915625       4.678161       6     9 18783, 2....
## 3: 2.154500e-03 0.025135833       3.274713       7    15 110208, ....
## 4: 3.034903e-03 0.026789277       3.508621       6    12 11428, 1....
```

```
sessionInfo()
```

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
## [1] R.utils_2.13.0    R.oo_1.27.1       R.methodsS3_1.8.2 mwcsr_0.1.10
## [5] igraph_2.2.1      data.table_1.17.8 gatom_1.8.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      dplyr_1.1.4           farver_2.1.2
##  [4] blob_1.2.4            Biostrings_2.78.0     S7_0.2.1
##  [7] fastmap_1.2.0         GGally_2.4.0          XML_3.99-0.20
## [10] digest_0.6.39         lifecycle_1.0.4       KEGGREST_1.50.0
## [13] RSQLite_2.4.5         magrittr_2.0.4        compiler_4.5.2
## [16] rlang_1.1.6           sass_0.4.10           tools_4.5.2
## [19] utf8_1.2.6            yaml_2.3.11           sna_2.8
## [22] knitr_1.50            htmlwidgets_1.6.4     bit_4.6.0
## [25] plyr_1.8.9            RColorBrewer_1.1-3    BiocParallel_1.44.0
## [28] withr_3.0.2           purrr_1.2.0           BiocGenerics_0.56.0
## [31] shinyCyJS_1.0.0       grid_4.5.2            stats4_4.5.2
## [34] ggplot2_4.0.1         scales_1.4.0          dichromat_2.0-0.1
## [37] cli_3.6.5             rmarkdown_2.30        crayon_1.5.3
## [40] generics_0.1.4        httr_1.4.7            DBI_1.2.3
## [43] cachem_1.1.0          network_1.19.0        parallel_4.5.2
## [46] AnnotationDbi_1.72.0  BiocManager_1.30.27   XVector_0.50.0
## [49] vctrs_0.6.5           Matrix_1.7-4          jsonlite_2.0.0
## [52] bookdown_0.45         IRanges_2.44.0        S4Vectors_0.48.0
## [55] bit64_4.6.0-1         BioNet_1.70.0         tidyr_1.3.1
## [58] jquerylib_0.1.4       intergraph_2.0-4      glue_1.8.0
## [61] statnet.common_4.12.0 ggstats_0.11.0        codetools_0.2-20
## [64] cowplot_1.2.0         gtable_0.3.6          tibble_3.3.0
## [67] pillar_1.11.1         htmltools_0.5.9       Seqinfo_1.0.0
## [70] fgsea_1.36.0          R6_2.6.1              evaluate_1.0.5
## [73] Biobase_2.70.0        lattice_0.22-7        png_0.1-8
## [76] memoise_2.0.1         bslib_0.9.0           fastmatch_1.1-6
## [79] Rcpp_1.1.0            coda_0.19-4.1         xfun_0.54
## [82] pkgconfig_2.0.3
```