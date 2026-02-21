# *padma* package: Quick-start guide

Andrea Rau1\*

1INRAE

\*andrea.rau@inrae.fr

#### 2025-10-30

#### Package

padma 1.20.0

![](data:image/png;base64...)

*padma* is a package that uses multiple factor analysis to calculate
individualized pathway-centric scores of deviation with respect to the sampled
population based on multi-omic assays (e.g., RNA-seq, copy number alterations,
methylation, etc). In particular, *padma* characterizes individuals with
aberrant multi-omic profiles for a given pathway of interest and quantifies
this deviation with respect to the sampled population using a multi-omic
consensus representation. Graphical and numerical outputs are provided to
identify highly aberrant individuals for a particular pathway of interest, as
well as the gene and omics drivers of aberrant multi-omic profiles.

The method implemented in this package is described in greater detail in the
following pre-print:

> Rau, A., Manansala, R., Flister, M. J., Rui, H., Jaffrézic, F., Laloë,
> D.\*, and Auer, P. L.\* (2019)
> Individualized multi-omic pathway deviation scores
> using multiple factor analysis bioRxiv, <https://doi.org/10.1101/827022>.
> \*These authors contributed equally to this work.

Below, we provide a quick-start guide using a subset of the TCGA LUAD
multi-omic data (included with the *padma* package) to illustrate the
functionalities and output of the method.

# 1 Quick start (tl;dr)

As with any R package, after installation the *padma* package is loaded as
follows:

```
library(padma)
```

Multi-omic data must be formatted as either a `MultiAssayExperiment` object
(preferred) or as a named list of `matrix` objects of matched
multi-omic data from a set of individuals, which is internally converted into
a `MultiAssayExperiment` object. A small example dataset in list
format is provided in `LUAD_subset` for multi-omic data (clinical, RNA-seq,
CNA, methylation, miRNA-seq) on 13 genes from the D4-GDI signaling pathway in
individuals with lung adenocarcinoma from TCGA. In practice, multi-omic
data do not need to be subsetted prior to running *padma*; this reduced
dataset is simply used as a minimal illustrative example.

A standard *padma* analysis for the D4-GDI signalling pathway takes as input
these pre-formatted `MultiAssayExperiment` data (called below)
and the name of the desired pathway. Note that data should be
normalized, batch-corrected, and if appropriate, log-transformed prior
to using *padma*. Built-in pathway names and gene lists from the MSigDB
curated pathway set are provided in the `msigdb` data provided with *padma*.

```
run_padma <-
  padma(mae, pathway_name = "c2_cp_BIOCARTA_D4GDI_PATHWAY")
```

Individualized pathway deviation scores can then be accessed via the `assay`
accessor function, and per-gene contributions to these scores can be accessed
via the `gene_deviation_scores()` accessor. In addition, a variety of plots can
be obtained, including
a factor map or partial factor map of individuals, and a plot of the
percentage contribution to each component by each considered omics.

```
assay(run_padma)

factorMap(run_padma)
factorMap(run_padma, partial_id = "TCGA-78-7536")
omicsContrib(run_padma)
```

Additional numerical outputs included in the `run_padma` S4 object of class
`padmaResults` include the per-gene pathway
deviation scores and full results from the MFA analysis. See the
following section for a more detailed description of these outputs.

# 2 Description of *padma*

A portion of the following text is taken from
[Rau et al. (2019)](https://doi.org/10.1101/827022).

## 2.1 Overview of Multiple Factor Analysis

Multiple factor analysis (MFA) represents an extension of principal component
analysis for the case where multiple quantitative data tables are to be
simultaneously analyzed. In particular, the MFA approach weights each table
individually to ensure that tables with more features or those on a different
scale do not dominate the analysis; all features within a given table are
given the same weight. These weights are chosen such that the first eigenvalue
of a PCA performed on each weighted table is equal to 1, ensuring that all
tables play an equal role in the global multi-table analysis. According to
the desired focus of the analysis, data can be structured either with molecular
assays (e.g., RNA-seq, methylation, miRNA-seq, copy number alterations) as
tables (and genes as features within omics), or with genes as tables (and
molecular assays as features within genes). The MFA weights balance the
contributions of each omic or of each gene, respectively. In *padma*, we
focus on the latter strategy in order to allow different omics to contribute
to a varying degree depending on the chosen pathway.

![](data:image/png;base64...)

Figure 1 from [Rau et al. (2019)](https://doi.org/10.1101/827022),
illustrating the *padma* approach.

More precisely, consider a pathway or gene set composed of \(p\) genes
(Figure 1A), each of which is measured using up to \(k\) molecular assays
(e.g., RNA-seq, methylation, miRNA-seq, copy number alterations), contained
in the set of gene-specific matrices \(X\_1,\ldots, X\_p\) that have the same
\(n\) matched individuals (rows) and \(j\_1,\ldots, j\_p\) potentially unmatched
variables (columns) in each, where \(j\_g \in \lbrace 1, \ldots, k\rbrace\) for
each gene \(g = 1,\ldots, p\). Because only the observations and not the
variables are matched across data tables, genes may be represented by
potentially different subset of omics data (e.g., only expression data for
one gene, and expression and methylation data for another).

In the first step, these data tables are generally standardized (i.e.,
centered and scaled). Next, an individual PCA is performed using singular
value decomposition for each gene table \(X\_g\), and its largest singular
value \(\lambda\_g^1\) is calculated (Figure 1B). Then, all features in each
gene table \(X\_g\) are weighted by \(1/\lambda\_g^1\), and a global PCA is
performed using a singular value decomposition on the concatenated set of
weighted standardized tables, \(X^\ast = \left[ \frac{X\_1}{\lambda\_1^1}, \ldots, \frac{X\_p}{\lambda\_p^1}\right]\) (Figure 1C). This yields a matrix of
components (i.e., latent variables) in the observation and variable space.

The MFA thus provides a consensus across-gene representation of the individuals
for a given pathway, and the global PCA performed on the weighted gene tables
decomposes the consensus variance into orthogonal variables (i.e., principal
components) that are ordered by the proportion of variance explained by each.
The coordinates of each individual on these components, also referred to as
factor scores, can be used to produce factor maps to represent individuals
in this consensus space such that smaller distances reflect greater
similarities among individuals. In addition, partial factor scores, which
represent the position of individuals in the consensus for a given gene,
can also be represented in the consensus factor map; the average of partial
factor scores across all dimensions and genes for a given individual
corresponds to the factor score (Figure 1D).

## 2.2 Calculation of individualized pathway deviation scores

In the consensus space obtained from the MFA, the origin represents the
``average" pathway behavior across genes, omics, and individuals; individuals
that are projected to increasingly distant points in the factor map represent
those with increasingly aberrant values, with respect to this average, for
one or more of the omics measures for one or more genes in the pathway. To
quantify these aberrant individuals, we propose an individualized pathway
deviation score \(d\_i\) based on the multidimensional Euclidean distance of the
MFA component loadings for each individual to the origin:
\[\begin{equation\*}
d\_i^2 = \sum\_{\ell = 1}^L f\_{i,\ell}^2,
\end{equation\*}\]
where \(f\_{i,\ell}\) corresponds to the MFA factor score of individual \(i\) in
component \(\ell\), and \(L\) corresponds to the rank of \(X^\ast\). Note that this
corresponds to the weighted Euclidean distance of the scaled multi-omic data
(for the genes in a given pathway) of each individual to the origin. These
individualized pathway deviation scores are thus nonnegative, where smaller
values represent individuals for whom the average multi-omic pathway variation
is close to the average, while larger scores represent individuals with
increasingly aberrant multi-omic pathway variation with respect to the average.
An individual with a large pathway deviation score is thus characterized by
one or more genes, with one or more omic measures, that explain a large
proportion of the global correlated information across the full pathway.

## 2.3 Calculation of individualized per-gene deviation scores

In order to quantify the role played by each gene for each individual, we
decompose the individualized pathway deviation scores into gene-level
contributions. Recall that the average of partial factor scores across all
MFA dimensions corresponds to each individual’s factor score. We define the
gene-level deviation for a given individual as follows:
\[\begin{equation\*}
d\_{i,g}=\frac{\sum\_{\ell = 1}^L f\_{i,\ell}\left(f\_{i,\ell,g}-f\_{i,\ell}\right)}
{\sum\_{\ell = 1}^L f\_{i,\ell}^2},
\end{equation\*}\]
where as before \(f\_{i,\ell}\) corresponds to the MFA factor score of individual
\(i\) in component \(\ell\), \(L\) corresponds to the rank of \(X^\ast\), and
\(f\_{i,\ell,g}\) corresponds to the MFA partial factor score of individual \(i\)
in gene \(g\) in component \(\ell\). Note that by construction, the contributions
of all pathway genes to the overall deviation score sum to 0. In particular,
per-gene contributions can take on both negative and positive values according
to the extent to which the gene influences the deviation of the overall
pathway score from the origin (i.e., the global center of gravity across
individuals); large positive values correspond to tables with a large
influence on the overall deviation of an individual, while large negative
values correspond to genes that tend to be most similar to the global average.

# 3 Description of built-in datasets

## 3.1 `LUAD_subset`: D4-GDI signaling pathway in the TCGA-LUAD multi-omic data

In this vignette, we focus on the example of multi-omic (RNA-seq, methylation,
copy number alterations, and miRNA-seq) data for the D4-GDI signaling
pathway from individuals with lung adenocarcinoma (LUAD) from The Cancer
Genome Atlas (TCGA) database. The multi-omic TCGA data were downloaded and
processed as [previously described](https://doi.org/10.5281/zenodo.3524080),
including batch correction for the plate effect. The total number of
individuals considered here is \(n=144\). See
[Rau et al. (2019)](https://doi.org/10.1101/827022) for additional details
about data processing and mapping of miRNAs to genes.

The D4-GDP dissociation inhibitor (GDI) signaling pathway is made up of
13 genes; it was chosen for follow-up here as it was identified as having
individualized pathway deviation scores that are significantly positively
correlated with smaller progression-free intervals. RNA-seq, methylation,
and CNA measures are available for all 13 genes, with the exception of CYCS
and PARP1, for which no methylation probes were measured the promoter region.
In addition, miRNA-seq data were included for one predicted target pair:
hsa-mir-421 \(\rightarrow\) CASP3.

The available multi-omic data for the D4-GDI signaling pathway in TCGA LUAD
patients is included within the *padma* package as the `LUAD_subset` object,
which is a named list of `data.frames` each containing the relevant data
(clinical parameters, RNA-seq, methylation, miRNA-seq, CNA) for the \(p=13\)
genes of the D4-GDI pathway in the \(n=144\) individuals.

```
names(LUAD_subset)
#> [1] "clinical" "rnaseq"   "methyl"   "mirna"    "cna"

lapply(LUAD_subset, class)
#> $clinical
#> [1] "data.frame"
#>
#> $rnaseq
#> [1] "data.frame"
#>
#> $methyl
#> [1] "data.frame"
#>
#> $mirna
#> [1] "data.frame"
#>
#> $cna
#> [1] "data.frame"

lapply(LUAD_subset, dim)
#> $clinical
#> [1] 144  55
#>
#> $rnaseq
#> [1]  13 144
#>
#> $methyl
#> [1]  13 144
#>
#> $mirna
#> [1]   1 144
#>
#> $cna
#> [1]  13 144
```

There are some important data formatting issues that are worth mentioning here:

* The clinical data (`LUAD_subset$clinical`) have individuals as
  rows and clinical variables as columns; all other datasets contain assay data
  with biological entities (e.g., genes, miRNAs) as rows and
  individuals as columns, with appropriate row and column names. Sample
  (column) names for assay data correspond to the patient barcodes that are
  provided in the `bcr_patient_barcode` column of `LUAD_subset$clinical`.
  For `LUAD_subset$mirna`, the first two
  columns represent the miRNA ID (`miRNA_lc`) and corresponding targeted gene
  symbol (`gene`).
* A `gene_map` data.frame can be optionally included to map biological entities
  (e.g. miRNAs) to gene symbols as needed. By default, a set of 10,754
  predicted miRNA gene targets with “Functional MTI” support type from
  miRTarBase (version 7.0) are used for the `gene_map`.
* All omics data have already been appropriately pre-processed before
  subsetting to this pathway (e.g., RNA-seq and miRNA-seq data have been
  normalized and log-transformed, all datasets were batch-corrected for the
  plate effect).
* Although *padma* does require that all datasets have the same number of
  individuals, and that all datasets are sorted so that individuals are in the
  same order, each dataset does not need to represent every considered gene.
  Note that in these data, a single gene (CASP3) is predicted to be targeted by
  a miRNA (hsa-mir-421).
* Finally, these toy data have been subsetted to include only values relevant
  to the D4-GDI signaling pathway solely in the interest of space. In practice,
  users do not need to subset their data prior to input in *padma* or match
  miRNAs to genes, as both of these steps are performed automatically for a
  ser-provided pathway name or set of genes.

## 3.2 `msigdb`: the MSigDB canonical pathway gene sets

In our work, we considered the pathways included in the MSigDB canonical
pathways curated gene set catalog, which includes genes whose products are
involved in metabolic and signaling pathways reported in curated public
databases. We specifically used the 1322 “C2 curated gene sets” catalog
from 601MSigDB v5.2 available at <http://bioinf.wehi.edu.au/software/MSigDB/as>
described in the
[*limma*](https://bioconductor.org/packages/release/bioc/html/limma.html)
Bioconductor package. For convenience, the gene sets corresponding to each
pathway have been included in the `msigdb` data frame:

```
head(msigdb)
#>                         geneset
#> 1   c2_cp_BIOCARTA_41BB_PATHWAY
#> 2   c2_cp_BIOCARTA_ACE2_PATHWAY
#> 3    c2_cp_BIOCARTA_ACH_PATHWAY
#> 4 c2_cp_BIOCARTA_ACTINY_PATHWAY
#> 5  c2_cp_BIOCARTA_AGPCR_PATHWAY
#> 6    c2_cp_BIOCARTA_AGR_PATHWAY
#>                                                                                                                                                                                                                            symbol
#> 1                                                                                                              JUN, MAP3K5, MAPK8, CHUK, MAPK14, MAP3K1, RELA, TNFRSF9, IKBKB, MAP4K5, IFNG, TRAF2, ATF2, IL4, NFKB1, NFKBIA, IL2
#> 2                                                                                                                                         ACE2, COL4A1, COL4A2, REN, COL4A3, COL4A4, CMA1, AGT, AGTR1, ACE, AGTR2, COL4A6, COL4A5
#> 3                                                                                                                      SRC, PTK2, TERT, CHRNG, FOXO3, RAPSN, AKT1, PIK3CA, MUSK, FASLG, CHRNB1, YWHAH, BAD, PTK2B, PIK3CG, PIK3R1
#> 4                                                                                         ABI2, WASF2, WASL, ACTA1, PIR, WASF1, ARPC4, PSMA7, ARPC5, ARPC1A, ACTR2, ACTR3, ARPC1B, ARPC3, NCKAP1, WASF3, ARPC2, RAC1, NTRK1, NCK1
#> 5                                                                                                                                PRKCB, PRKCA, PRKAR2B, PRKACB, PRKACG, GNAS, ARRB1, GNGT1, GNB1, PRKAR1A, PRKAR2A, PRKAR1B, GRK4
#> 6 JUN, MAPK8, PAK3, ACTA1, EGFR, NRG1, RAPSN, DAG1, CHRM1, PAK2, LAMA3, LAMA2, PAK4, UTRN, PXN, NRG3, PAK7, DMD, CTTN, SRC, PTK2, ITGA1, CHRNA1, PAK1, SP1, GIT2, DVL1, NRG2, MUSK, ITGB1, MAPK3, LAMA4, RAC1, PAK6, CDC42, MAPK1
```

In practice, to use *padma* a user can either directly provide a vector of
gene symbols, or the geneset name as defined in this data frame
(e.g., `c2_cp_BIOCARTA_41BB_PATHWAY`).

## 3.3 `mirtarbase`: predicted gene targets of miRNAs

*padma* integrates multi-omic data by mapping omics measures to genes in a
given pathway. Although this assignment of values to genes is relatively
straightforward for RNA-seq, CNA, and methylation data, a definitive mapping
of miRNA-to-gene relationships does not exist, as miRNAs can each potentially
target multiple genes. Many methods and databases based on text-mining or
bioinformatics-driven approaches exist to predict miRNA-target pairs. Here,
we make use of the curated miR-target interaction (MTI) predictions in
[miRTarBase](http://mirtarbase.mbc.nctu.edu.tw/php/index.php) (version 7.0),
using only exact matches for miRNA IDs and target gene symbols and predictions
with the “Functional MTI” support type. As a reference, we have included
these predictions in the built-in `mirtarbase` data frame:

```
head(mirtarbase)
#>             miRNA Target Gene
#> 1  hsa-miR-20a-5p       HIF1A
#> 2  hsa-miR-20a-5p       HIF1A
#> 3 hsa-miR-146a-5p       CXCR4
#> 4 hsa-miR-146a-5p       CXCR4
#> 5  hsa-miR-122-5p      CYP7A1
#> 6  hsa-miR-222-3p      STAT5A
```

In practice, unless an alternative data frame is provided for the
`gene_map` argument of *padma*, the `mirtarbase` data frame is used to
match miRNA IDs to gene symbols.

# 4 Running *padma*

To run *padma* for the D4-GDI pathway, we start by formatting the `LUAD_subset`
data as a `MultiAssayExperiment` object.

```
library(MultiAssayExperiment)

LUAD_subset <- padma::LUAD_subset
omics_data <-
  list(rnaseq = as.matrix(LUAD_subset$rnaseq),
       methyl = as.matrix(LUAD_subset$methyl),
       mirna = as.matrix(LUAD_subset$mirna),
       cna = as.matrix(LUAD_subset$cna))
pheno_data <-
  data.frame(LUAD_subset$clinical,
             row.names = LUAD_subset$clinical$bcr_patient_barcode)

mae <-
  suppressMessages(
    MultiAssayExperiment::MultiAssayExperiment(
      experiments = omics_data,
      colData = pheno_data))
```

Next, the following command is used:

```
D4GDI <- msigdb[grep("D4GDI", msigdb$geneset), "geneset"]
run_padma <-
  padma(mae, pathway_name = D4GDI, verbose = FALSE)
```

Alternatively, *padma* could be run directly on the list of matrices
contained in `LUAD_subset` (ensuring that the clinical data are included
as `colData`):

```
clinical_data <- data.frame(LUAD_subset$clinical)
rownames(clinical_data) <- clinical_data$bcr_patient_barcode

run_padma_list <-
  padma(omics_data,
        colData = clinical_data,
        pathway_name = D4GDI,
        verbose = FALSE)
```

Note that we have used the `misgdb` built-in database to find the full name of
the D4-GDI pathway, `"c2_cp_BIOCARTA_D4GDI_PATHWAY"`. Alternatively, a vector
of gene symbols for the pathway of interest could instead
be provided to the `pathway_name` argument:

```
D4GDI_genes <- unlist(strsplit(
  msigdb[grep("D4GDI", msigdb$geneset), "symbol"], ", "))
D4GDI_genes
#>  [1] "CASP10"  "JUN"     "CASP9"   "CASP8"   "APAF1"   "ARHGAP5" "CASP1"
#>  [8] "CASP3"   "PRF1"    "CYCS"    "GZMB"    "ARHGDIB" "PARP1"

run_padma_again <-
  padma(mae, pathway_name = D4GDI_genes, verbose = FALSE)
```

As noted above, it is required to provide either a recognized pathway name
(see `msigdb$geneset`) or a vector
of gene symbols. In most cases, users would provide the full multi-omics data
in the `omics_data` argument
of `padma`, rather than a pre-subsetted dataset as is the case for the
built-in `LUAD_subset` data.

In the following, we detail the various numerical and graphical outputs that
an be accessed after running `padma`; note that the results are an S4 object
of class `"padmaResults"`, an extension of the `RangedSummarizedExperiment`
class.

## 4.1 Numerical outputs

The numerical outputs of `padma` include the following (which can all be
accessed using the matching accessor functions):

There are two primary numerical outputs from `padma`:

* **pathway deviation scores**:
  accessed via `assay(...)`,
  a `data.frame` providing the individualized pathway
  deviation scores for each individual. The `group` column indicates whether an
  individual was included as part of the reference population (`"Base"`) or as a
  supplementary individual projected onto the reference (`"Supp"`), as indicated
  by the user in the `base_ids` and `supp_ids` arguments of `padma`.
* **pathway gene-specific deviation scores**:
  accessed via `pathway_gene_deviation(...)`, a matrix of dimension \(n\)
  (nuumber of individuals) x \(p\) (number of genes in the pathway) containing the
  individualized per-gene deviation scores

There are also several outputs related to the MFA itself, and obtained via
the [*FactorMineR*](http://factominer.free.fr/) R package implementation of
the MFA:

* `MFA_results`:
  accessed via the `MFA_results(...)`, a named list containing
  detailed MFA output. When `padma` is run with
  `full_results = TRUE`, these include eigenvalues (`eig`), the percent
  contributions
  of each individual, gene, and omic to the MFA components (`ind_contrib_MFA`,
  `gene_contrib_MFA`, `omics_contrib_MFA`), the formatted gene tables used
  as input for the MFA (`gene_tables`),
  the pairwise Lg coefficients between genes
  (`gene_Lf_MFA`), and the full *FactoMineR* MFA output
  (`total_MFA`), which is an object of class `"MFA"`.
  See the *FactoMineR*
  [reference manual](https://cran.r-project.org/web/packages/FactoMineR/index.html)
  for a full description of this full MFA output.
  When `padma` is run with
  `full_results = FALSE`, these include eigenvalues (`eig`), and a
  summary of the cumulative contributions
  of each individual, gene, and omic to the first ten and full set of MFA
  components (`ind_contrib_MFA_summary`,
  `gene_contrib_MFA_summary`, `omics_contrib_MFA_summary`). In both cases,
  `eig` is a matrix of dimension \(c\) (number of MFA components) x 3 providing the
  respective eigenvalues, percentage of variance explained, and cumulative
  percentage of variance explained by each MFA component.

Finally, there are additional outputs related to the pathway itself that
can be accessed via appropriate accessor functions:

* `pathway_name`:
  accessed via `pathway_name(...)`, the
  user-provided name of pathway analyzed by `padma`. If a
  vector of gene symbols was provided rather than a built-in name, `"custom"`
  is returned.
* `ngenes`:
  accessed via `ngenes(...)`, number of genes with data available
  in the pathway
* `imputed_genes`:
  accessed via `imputed_genes(...)`, names of entities for
  which values were automatically imputed by `padma`
* `removed_genes`:
  accessed via `removed_genes(...)`, names of entities
  which were automatically removed by
  `padma` due to small variance (< 10e-5) or all missing values across samples.

## 4.2 Graphical outputs

*padma* includes three primary plotting functions, all of which can
be produced using *ggplot2* (default) or base graphics (using argument
`ggplot = FALSE`). Note that when *ggplot2* is used, *ggrepel* is
additionally used to better position sample labels.

* `factorMap`:
  plot the MFA components for each individual for a selected pair
  of components. This would typically be done for the first few components, and
  serves as a visualization of the structuring of indviduals for the pathway;
  for example, below the factor map suggests that individual TCGA-78-7536 is
  likely to have a larger overall pathway deviation score given that it is
  positioned quite far from the origin (for these two axes).

```
factorMap(run_padma, dim_x = 1, dim_y = 2)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the padma package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the padma package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

The base version of this plot may be produced as follows.

```
factorMap(run_padma, dim_x = 1, dim_y = 2, ggplot = FALSE)
#> Loading required namespace: car
```

![](data:image/png;base64...)

* `factorMap` (partial mode):
  plot the MFA partial components for one specific
  individual for a pair of components. This function would be used to zero in
  on one or several indivduals (for example, TCGA-78-7536) to visualize which
  genes appear to be pulling the overall score away from the origin. Here we
  note the seeming large influence of CASP1 and CASP3. Note that the
  individual’s overall pathway score, which is represented as the large black
  point, is the same as that from the previous plot.

```
factorMap(run_padma,
           partial_id = "TCGA-78-7536",
           dim_x = 1, dim_y = 2)
```

![](data:image/png;base64...)

As before, *ggplot2* plotting can be optionally turned off, if desired.

```
factorMap(run_padma,
           partial_id = "TCGA-78-7536",
           dim_x = 1, dim_y = 2, ggplot = FALSE)
```

![](data:image/png;base64...)

* `omicsContrib`:
  visualize the contribution of each omics to the variation of
  a subset of MFA components, and summarize this contribution as a weighted
  overall average. In this plot, transparency of the bars reflects the percentage
  variance explained for each component. Note that if *ggplot2* is used,
  the *cowplot* package is used to combine graphics.

```
omicsContrib(run_padma, max_dim = 10)
#> Loading required namespace: cowplot
```

![](data:image/png;base64...)

Once again, *ggplot2* plotting can be turned off if desired.

```
omicsContrib(run_padma, max_dim = 10, ggplot = FALSE)
```

![](data:image/png;base64...)

## 4.3 Additional options

### 4.3.1 Projecting supplementary individuals onto a reference consensus

Unless otherwise specified, *padma* will make use of all individuals to
calculate pathway deviation scores. However, in some cases users may wish to
perform the MFA on a set of reference individuals and subsequently project a
set a supplementary individuals onto the reference consensus (e.g., in a case
where healthy individuals are to be used as a reference, and pathway deviation
scores of diseased individuals are to be calculated relative to them).

In such a case, the `base_ids` and `supp_ids` arguments of `padma` can be used
to provide the sampel names for individuals in each group, respectively. For
instance, if the first ten individuals are in the reference group, and the
user wishes to project individuals 15 to 20 as supplementary, the following
code could be used:

```
run_padma_supp <-
  padma(mae, pathway_name = D4GDI, verbose = FALSE,
        base_ids = sampleMap(mae)$primary[1:10],
        supp_ids = sampleMap(mae)$primary[15:20])
```

Note that there must not be any overlap in the indices provided for `base_ids`
and `supp_ids`.

### 4.3.2 Missing data imputation

When missing values are included in the `omics_data` argument, by default
*padma* uses mean imputation to replace these values prior to calculating
individualized pathway scores. Alternatively, these values can be imputed via
a preliminary MFA as implemented in the
[*missMDA*}(<https://cran.r-project.org/web/packages/missMDA/index.html>)
package, which can in some cases be slightly more time consuming. To do,
the `impute` argument must be activated:

```
run_padma_impute <-
  padma(mae, pathway_name = D4GDI,
        impute = TRUE, verbose = FALSE)
```

### 4.3.3 Providing miRNA target predictions

As noted above, if miRNA-seq data (or other data in which biological entities
are not genes) are included in the `omics_data` argument,
a mapping to genes must be provided to *padma* in the `gene_map` argument.
By default, the mapping in `mirtarbase` taken from
[miRTarBase](http://mirtarbase.mbc.nctu.edu.tw/php/index.php) is used
within *padma*. If another mapping is desired by the user, this should be
provided as a 2-column data frame (entity name and corresponding gene) in the
`gene_map` argument.

### 4.3.4 Requesting concise results from *padma*

Because *padma* stores the full set of MFA numerical results above (including
factor components and partial factor components for all individuals), the
full output can become quite large if run for very large pathways and/or
looped over a large number of pathways. By default, *padma* returns this
full set of results, but users can request a space-saving concise output via
the `full_results` argument:

```
run_padma_concise <-
  padma(mae, pathway_name = D4GDI, full_results = FALSE)
```

# 5 FAQ

**1. Can *padma* be used with non-continuous data, like binary per-gene**
**somatic mutation calls?**

At the current time, *padma* is only formatted to correctly handle
continuous data. However, the MFA approach (as implemented in the
[*FactoMineR*](http://factominer.free.fr/) package, which is called by *padma*)
is technically able to handle continuous, categorical, and binary data,
so this is merely a question of extending the existing *padma* code to handle
more general situations.

**2. Can *padma* integrate omics data that cannot be summarized to the**
**gene-level? (e.g., SNP genotyping or metabolic data)**

As it is currently written, *padma* is intended to provide inference at the
pathway-level, where members of each pathway correspond to genes. In theory
the MFA could be performed using each omic as a table (rather than each gene),
in which case no gene-level summarization would be required. *padma* is not
currently equipped to handle this more general setting.

# 6 To-do list and ideas for work in progress

The following items are on my to-do list for improvements:

* Incorporation of known hierarchical structure among genes in a given pathway
* Addition of interactivity for exploration of *padma* results
* Extensions for highly structured groups of individuals
* Extension of *padma* to cases where non-continuous data (e.g., binary or
  categorical) can be handled
* Add in the possibility to remove certain MFA components (e.g., those
  correlated with a batch effect)
* Add in the possibility to quantify contribution of a given grouping (e.g.,
  omics) across all MFA components
* Add in a full working example using
  [*curatedTCGAData*](https://bioconductor.org/packages/curatedTCGAData/).

# 7 Session Info

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] MultiAssayExperiment_1.36.0 padma_1.20.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1     dplyr_1.1.4          farver_2.1.2
#>  [4] S7_0.2.0             fastmap_1.2.0        TH.data_1.1-4
#>  [7] digest_0.6.37        estimability_1.5.1   lifecycle_1.0.4
#> [10] cluster_2.1.8.1      multcompView_0.1-10  survival_3.8-3
#> [13] magrittr_2.0.4       compiler_4.5.1       rlang_1.1.6
#> [16] sass_0.4.10          tools_4.5.1          yaml_2.3.10
#> [19] knitr_1.50           S4Arrays_1.10.0      labeling_0.4.3
#> [22] htmlwidgets_1.6.4    scatterplot3d_0.3-44 DelayedArray_0.36.0
#> [25] plyr_1.8.9           RColorBrewer_1.1-3   multcomp_1.4-29
#> [28] abind_1.4-8          withr_3.0.2          purrr_1.1.0
#> [31] grid_4.5.1           xtable_1.8-4         ggplot2_4.0.0
#> [34] emmeans_2.0.0        scales_1.4.0         MASS_7.3-65
#> [37] tinytex_0.57         dichromat_2.0-0.1    flashClust_1.01-2
#> [40] cli_3.6.5            mvtnorm_1.3-3        rmarkdown_2.30
#> [43] crayon_1.5.3         reshape2_1.4.4       BiocBaseUtils_1.12.0
#> [46] cachem_1.1.0         stringr_1.5.2        splines_4.5.1
#> [49] BiocManager_1.30.26  XVector_0.50.0       vctrs_0.6.5
#> [52] Matrix_1.7-4         sandwich_3.1-1       carData_3.0-5
#> [55] jsonlite_2.0.0       car_3.1-3            bookdown_0.45
#> [58] ggrepel_0.9.6        Formula_1.2-5        FactoMineR_2.12
#> [61] magick_2.9.0         jquerylib_0.1.4      tidyr_1.3.1
#> [64] glue_1.8.0           codetools_0.2-20     cowplot_1.2.0
#> [67] DT_0.34.0            stringi_1.8.7        gtable_0.3.6
#> [70] tibble_3.3.0         pillar_1.11.1        htmltools_0.5.8.1
#> [73] R6_2.6.1             evaluate_1.0.5       lattice_0.22-7
#> [76] leaps_3.2            bslib_0.9.0          Rcpp_1.1.0
#> [79] coda_0.19-4.1        SparseArray_1.10.0   xfun_0.53
#> [82] zoo_1.8-14           pkgconfig_2.0.3
```