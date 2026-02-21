# DifferentialRegulation: a method to identify genes displaying differential regulation between groups of samples

Simone Tiberi1\* and Charlotte Soneson2\*\*

1Department of Statistical Sciences, University of Bologna, Bologna, Italy
2Computational Biology Platform, Friedrich Miescher Institute for Biomedical Research, Basel, Switzerland

\*simone.tiberi@unibo.it
\*\*charlottesoneson@gmail.com

#### 10/29/2025

#### Package

DifferentialRegulation 2.8.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Conceptual idea](#conceptual-idea)
  + [1.2 Mathematical details](#mathematical-details)
  + [1.3 Bioconductor installation](#bioconductor-installation)
  + [1.4 Questions, issues and citation](#questions-issues-and-citation)
* [2 Single-cell RNA-seq pipeline](#single-cell-rna-seq-pipeline)
  + [2.1 Input data: alignment and quantification with *alevin-fry*](#input-data-alignment-and-quantification-with-alevin-fry)
  + [2.2 Load the package](#load-the-package)
  + [2.3 Load the data](#load-the-data)
    - [2.3.1 Load USA counts](#load-usa-counts)
    - [2.3.2 Load equivalence classes (EC)](#load-equivalence-classes-ec)
  + [2.4 QC and filtering](#qc-and-filtering)
  + [2.5 Differential testing](#differential-testing)
  + [2.6 Visualizing results](#visualizing-results)
* [3 Bulk RNA-seq pipeline](#bulk-rna-seq-pipeline)
  + [3.1 Input data: alignment and quantification with *salmon* or *kallisto*](#input-data-alignment-and-quantification-with-salmon-or-kallisto)
  + [3.2 Load the package](#load-the-package-1)
  + [3.3 Load the data](#load-the-data-1)
    - [3.3.1 Load US counts](#load-us-counts)
    - [3.3.2 Load equivalence classes (EC)](#load-equivalence-classes-ec-1)
  + [3.4 QC and filtering](#qc-and-filtering-1)
  + [3.5 Differential testing](#differential-testing-1)
  + [3.6 Visualizing results](#visualizing-results-1)
* [4 Session info](#session-info)
* [References](#references)

---

# 1 Introduction

*DifferentialRegulation* is a method for detecting differentially regulated genes between two groups of samples (e.g., healthy vs. disease, or treated vs. untreated samples), by targeting differences in the balance of spliced (S) and unspliced (U) mRNA abundances.
The method fits both bulk and single-cell RNA-sequencing (scRNA-seq) data: on bulk data, *DifferentialRegulation* targets changes (across all cells) at the transcript level, while on single-cell data, it targets cell-type specific changes at the gene-level.

Below, we briefly illustrate the main conceptual and mathematical aspects.
For more details, a pre-print will follow shortly.

## 1.1 Conceptual idea

*DifferentialRegulation* is based on a similar rationale to RNA velocity tools, notably *velocyto* (La Manno et al. [2018](#ref-velocyto)) and *scVelo* (Bergen et al. [2020](#ref-scVelo)), which compare spliced and unspliced abundances to their equilibrium levels.

Intuitively, if a large fraction of U is present for a gene, this will be spliced and increase the relative abundance of S.
Conversely, if a small fraction of U is present for a gene, the newly spliced mRNA will not compensate the degradation of the (already) spliced mRNA, and the proportion of S will decrease in the short term.
Therefore, in the two examples above, the gene is currently being up- and down-regulated, respectively; i.e., gene expression is going to increase and decrease, respectively.

We extend this argument to compare the relative abundances of S and U reads across groups of samples.
In particular, a higher proportion of unspliced (spliced) mRNA in a condition suggests that a gene is currently being up- (down-) regulated compared to the other condition.

While canonical differential gene expression focuses on changes in overall gene abundance, *DifferentialRegulation* discovers differences (between conditions) in the near future changes of (spliced) gene expression (conceptually similar to the derivative of S respect to time).

Similarly to RNA velocity tools, *DifferentialRegulation* is an instrument to facilitate discoveries in the context of development.

## 1.2 Mathematical details

From a mathematical point of view, *DifferentialRegulation* accounts for the sample-to-sample variability, and embeds multiple samples in a Bayesian hierarchical model.
Furthermore, our method also deals with two major sources of mapping uncertainty: i) ‘ambiguous’ reads, compatible with both spliced and unspliced versions of a gene or transcript, and ii) reads mapping to multiple genes or transcripts.
When using scRNA-seq data, ambiguous reads are considered separately from spliced and unsplced reads, while reads that are compatible with multiple genes are treated as latent variables and allocated to the gene of origin.
When using bulk RNA-seq data, we allocate both ambiguous reads and reads mapping to multiple transcripts: the former ones are allocated to the spliced or unspliced version of each trascript, while the latter ones are allocated to the transcript of origin.

*DifferentialRegulation* uses two nested models.

In single-cell RNA-seq data:

* a Dirichlet-multinomial (\(DM\)) for the proportions of unspliced, spliced and ambiguous (USA) reads in each gene: \(DM(\pi\_U, \pi\_S, \pi\_A, \delta)\), where \(\pi\_U, \pi\_S, \pi\_A\) indicate the (group-level) relative abundances of U, S and A counts, and \(\delta\) represents the precision parameter, modelling the degree of over-dispersion between samples;
* a multinomial (\(MN\)) for the (sample-specific) relative abundance of genes in each sample: \(MN(\pi^i\_1, ..., \pi^i\_{n\_g})\), where \(\pi^i\_g\) is the relative abundance of the \(g\)-th gene in the \(i\)-th sample.

In bulk RNA-seq data:

* a Dirichlet-multinomial (\(DM\)) for the proportions of unspliced and spliced (US) reads in each transcript: \(DM(\pi\_U, \pi\_S, \delta)\), where \(\pi\_U, \pi\_S\) indicate the (group-level) relative abundances of U and S counts, and \(\delta\) represents the precision parameter, modelling the degree of over-dispersion between samples;
* a multinomial (\(MN\)) for the (sample-specific) relative abundance of transcripts in each sample: \(MN(\pi^i\_1, ..., \pi^i\_{n\_t})\), where \(\pi^i\_t\) is the relative abundance of the \(t\)-th transcript in the \(i\)-th sample.

The \(DM\) model is the main focus here, and the one which is used for differential testing between conditions, while the \(MN\) model is necessary for allocating reads across genes.

Parameters are inferred via Markov chain Monte Carlo (MCMC) techniques (Metropolis-within-Gibbs), and differential testing is performed by comparing \((\pi\_U, \pi\_S, \pi\_A)\) (single-cell data) or \((\pi\_U, \pi\_S)\) (bulk data) or between conditions.

## 1.3 Bioconductor installation

`DifferentialRegulation` is available on [Bioconductor](https://bioconductor.org/packages/DifferentialRegulation) and can be installed with the command:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("DifferentialRegulation")
```

To access the R code used in the vignettes, type:

```
browseVignettes("DifferentialRegulation")
```

## 1.4 Questions, issues and citation

Questions relative to *DifferentialRegulation* should be reported as a new issue at *[BugReports](https://github.com/SimoneTiberi/DifferentialRegulation/issues)*.

To cite *DifferentialRegulation*, type:

```
citation("DifferentialRegulation")
```

```
## To cite DifferentialRegulation in publications use:
##
##   Simone Tiberi, Joel Meili, Peiying Cai, Charlotte Soneson, Dongze He,
##   Hirak Sarkar, Alejandra Avalos-Pacheco, Rob Patro, Mark D. Robinson
##   (2024). DifferentialRegulation: a Bayesian hierarchical approach to
##   identify differentially regulated genes. Biostatistics. URL
##   https://doi.org/10.1093/biostatistics/kxae017
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {DifferentialRegulation: a Bayesian hierarchical approach to identify differentially regulated genes},
##     author = {Simone Tiberi and Joel Meili and Peiying Cai and Charlotte Soneson and Dongze He and Hirak Sarkar and Alejandra Avalos-Pacheco and Rob Patro and Mark D. Robinson},
##     eprint = {https://doi.org/10.1093/biostatistics/kxae017},
##     journal = {Biostatistics},
##     year = {2024},
##     doi = {10.1093/biostatistics/kxae017},
##     url = {https://doi.org/10.1093/biostatistics/kxae017},
##   }
```

# 2 Single-cell RNA-seq pipeline

## 2.1 Input data: alignment and quantification with *alevin-fry*

*DifferentialRegulation* inputs scRNA-seq data, aligned via *alevin-fry* (He et al. [2022](#ref-alevin-fry)).

NOTE: when using *alevin-fry*, set options:

* `--d` (or `--dump-eqclasses`), to obtain the equivalence classes;
* `--use-mtx`, to store counts in a `quants_mat.mtx` file (as expected by our `load_USA` function).

We also recommend using the `--CR-like-EM` option, which also allows equivalence classes of reads that map to multiple genes.

*alevin-fry* software: <https://github.com/COMBINE-lab/alevin-fry>

*alevin-fry* documentation: <https://alevin-fry.readthedocs.io/en/latest/index.html>

*alevin-fry* tutorial to obtain USA mapping:
<https://combine-lab.github.io/alevin-fry-tutorials/2021/improving-txome-specificity/>

## 2.2 Load the package

Load *DifferentialRegulation*.

```
library(DifferentialRegulation)
```

## 2.3 Load the data

We use a real droplet scRNA-seq dataset from Velasco et al. ([2019](#ref-Velasco_19)).
In particular, we compare two groups of three samples, consisting of human brain organoids, cultured for 3 and 6 months.
For computational reasons, we stored a subset of this dataset, in our package, consisting of 100 genes and 3,493 cells, belonging to two cell-types.
Cell-type assignment was done in the original styudy (Velasco et al. [2019](#ref-Velasco_19)).
For more information about the data, refer to the original study [here](https://doi.org/10.1038/s41586-019-1289-x).

We specify the directory of the data (internal in the package).

```
data_dir = system.file("extdata", package = "DifferentialRegulation")
```

Specify the directory of the USA (unspliced, spliced and ambiguous) estimated counts, inferred via *alevin-fry*.

```
# specify samples ids:
sample_ids = paste0("organoid", c(1:3, 16:18))
# set directories of each sample input data (obtained via alevin-fry):
base_dir = file.path(data_dir, "alevin-fry", sample_ids)

# Note that alevin-fry needs to be run with `--use-mtx` option to store counts in a `quants_mat.mtx` file.
path_to_counts = file.path(base_dir,"/alevin/quants_mat.mtx")
path_to_cell_id = file.path(base_dir,"/alevin/quants_mat_rows.txt")
path_to_gene_id = file.path(base_dir,"/alevin/quants_mat_cols.txt")
```

Specify the directory of the ECs and respective counts, inferred via *alevin-fry*.

```
path_to_EC_counts = file.path(base_dir,"/alevin/geqc_counts.mtx")
path_to_EC = file.path(base_dir,"/alevin/gene_eqclass.txt.gz")
```

### 2.3.1 Load USA counts

Load the unspliced, spliced and ambiguous (USA) estimated counts, quantified by *alevin-fry*, in a *SingleCellExperiment*.
By default, counts (stored in `assays(sce)$counts`) are defined as summation of spliced read and 50% of ambiguous reads (i.e., reads compatible with both spliced and unspliced versions of a gene): counts = spliced + 0.5 \* ambiguous.

```
sce = load_USA(path_to_counts,
               path_to_cell_id,
               path_to_gene_id,
               sample_ids)

sce
```

```
## class: SingleCellExperiment
## dim: 100 3493
## metadata(0):
## assays(4): spliced unspliced ambiguous counts
## rownames(100): ENSG00000223972.5 ENSG00000243485.5 ...
##   ENSG00000162592.10 ENSG00000235169.11
## rowData names(0):
## colnames(3493): organoid1.GCCTCTAGTCGGATCC organoid1.GAACATCGTCTGATCA
##   ... organoid18.AGCGTCGAGCGCCTCA organoid18.GATCGCGTCGTTACGA
## colData names(1): sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Cell types should be assigned to each cell; here we load pre-computed cell types.

```
path_to_DF = file.path(data_dir,"DF_cell_types.txt")
DF_cell_types = read.csv(path_to_DF, sep = "\t", header = TRUE)
matches = match(colnames(sce), DF_cell_types$cell_id)
sce$cell_type = DF_cell_types$cell_type[matches]
table(sce$cell_type)
```

```
##
## Cycling      RG
##    2399    1094
```

### 2.3.2 Load equivalence classes (EC)

Load the equivalence classes and respective counts.

```
EC_list = load_EC(path_to_EC_counts,
                  path_to_EC,
                  path_to_cell_id,
                  path_to_gene_id,
                  sample_ids)
```

```
## The percentage of multi-gene mapping reads in sample 'organoid1' is: 11.09
```

```
## The percentage of multi-gene mapping reads in sample 'organoid2' is: 13.53
```

```
## The percentage of multi-gene mapping reads in sample 'organoid3' is: 7.19
```

```
## The percentage of multi-gene mapping reads in sample 'organoid16' is: 8.59
```

```
## The percentage of multi-gene mapping reads in sample 'organoid17' is: 3.75
```

```
## The percentage of multi-gene mapping reads in sample 'organoid18' is: 6.76
```

For every sample, `load_EC` prints the percentage of reads compatible with multiple genes (i.e., multi-gene mapping reads).
Here multi-gene reads are relatively low, because we are considering a subset of 100 genes only; however, in the full dataset we found that approximately 40% of reads map to multiple genes.
Intuitively, the larger these numbers, the greater the benefits one may achieve by using ECs and modelling the variability of these uncertain gene allocations.

## 2.4 QC and filtering

Quality control (QC) and filtering of low quality cells can be performed as usual on the `sce` object.
The `sce` object computed via `load_USA` contains a `counts` assays, defined as the summation of spliced counts and 50% of ambiguous counts.

For examples of QC, you can refer to the [OSCA book](http://bioconductor.org/books/3.15/OSCA.basic/quality-control.html) (Amezquita et al. [2020](#ref-OSCA)).

Importantly, cells only need to be filtered in the `sce` object, and NOT in the `EC_list` object: cells that are filtered in `sce` will also be removed from ECs by `compute_PB_counts` function.

## 2.5 Differential testing

First, we define the design of the study: in our case we have 2 groups, that we call “A” and “B” of 2 samples each.

```
design = data.frame(sample = sample_ids,
                    group = c( rep("3 mon", 3), rep("6 mon", 3) ))
design
```

```
##       sample group
## 1  organoid1 3 mon
## 2  organoid2 3 mon
## 3  organoid3 3 mon
## 4 organoid16 6 mon
## 5 organoid17 6 mon
## 6 organoid18 6 mon
```

Compute pseudo-bulk (PB) onbject needed for differential testing.

```
PB_counts = compute_PB_counts(sce = sce,
                              EC_list = EC_list,
                              design =  design,
                              sample_col_name = "sample",
                              group_col_name = "group",
                              sce_cluster_name = "cell_type")
```

```
## the following cell clusters (e.g., cell types) have more than 100 cells and will be analyzed:
```

```
## Cycling --- RG
```

NB: to reduce memory usage, we can remove the `EC_list` object, which typically requires a large amount of memory, particularly in large datasets.
If needed, the `sce` object can be removed as well, since it is not needed for differential testing.

```
rm(EC_list)
```

We perform differential testing:

```
# EC-based test:
set.seed(1609612)
results = DifferentialRegulation(PB_counts,
                                 n_cores = 2,
                                 traceplot = TRUE)
```

## 2.6 Visualizing results

`DifferentialRegulation` function returns of a list of 4 data.frames:

* `Differential_results`, which contains results from differential testing only;
* `US_results`, that has results for the proportion of Spliced and Unspliced counts (where Ambiguous counts are allocated 50:50 to Spliced and Unspliced);
* `USA_results`, which includes results for the proportion of Spliced, Unspliced and Ambiguous counts (Ambiguous counts are reported separately from Spliced and Unspliced counts);
* `Convergence_results`, that contains information about convergence of posterior chains.

```
names(results)
```

```
## [1] "Differential_results" "US_results"           "USA_results"
## [4] "Convergence_results"  "MCMC_U"
```

In `Differential_results` element, columns `Gene_id` and `Cluster_id` contain the gene and cell-cluster name, while `p_val`, `p_adj.loc` and `p_adj.glb` report the raw p-values, locally and globally adjusted p-values, via Benjamini and Hochberg (BH) correction.
In locally adjusted p-values (`p_adj.loc`) BH correction is applied to each cluster separately, while in globally adjusted p-values (`p_adj.glb`) BH correction is performed to the results from all clusters.

```
head(results$Differential_results, 3)
```

```
##               Gene_id Cluster_id      p_val p_adj.glb p_adj.loc Prob-6 mon-UP
## 31 ENSG00000179403.12         RG 0.01702780 0.2527751 0.2271129   0.004666667
## 5  ENSG00000157933.10    Cycling 0.25362515 0.8454172 0.7608754   0.010000000
## 12 ENSG00000197530.12    Cycling 0.02393744 0.2527751 0.2527751   0.010000000
```

The final column of `results$Differential_results`, `Prob-group_name-UP`, indicates the probability that a gene is UP-regulated in one group (`6 mon` in this case) compared to the other group.
This column can be used to sort genes, by the probability that they are being up-regulated in group `6 mon`:

```
ordering_UP = order(results$Differential_results[,6], decreasing = TRUE)
head(results$Differential_results[ordering_UP,], 3)
```

```
##               Gene_id Cluster_id      p_val p_adj.glb p_adj.loc Prob-6 mon-UP
## 17  ENSG00000227775.3    Cycling 0.03159689 0.2527751 0.2527751     0.9973333
## 13 ENSG00000197785.14    Cycling 0.84706492 0.9750586 0.9705238     0.9293333
## 34 ENSG00000197785.14         RG 0.82842935 0.9750586 0.9743574     0.8726667
```

Alternatively, one can sort genes by their probability of currently being down-regulated in group `6 mon` (or conversely, up-regularted in the alternative group, `3mon`):

```
ordering_DOWN = order(results$Differential_results[,6], decreasing = FALSE)
head(results$Differential_results[ordering_DOWN,], 3)
```

```
##               Gene_id Cluster_id      p_val p_adj.glb p_adj.loc Prob-6 mon-UP
## 31 ENSG00000179403.12         RG 0.01702780 0.2527751 0.2271129   0.004666667
## 5  ENSG00000157933.10    Cycling 0.25362515 0.8454172 0.7608754   0.010000000
## 12 ENSG00000197530.12    Cycling 0.02393744 0.2527751 0.2527751   0.010000000
```

In `US_results` and `USA_results` elements, `pi` and `sd` indicate the estimated proportion and standard deviation, respectively, `S`, `U` and `A` refer to Spliced, Unspliced and Ambiguous counts, respectively, while `3 mon` and `6 mon` refer to the groups, as named in the `design`.
For instance, columns `pi_S-3 mon` and `sd_S-3 mon` indicate the estimate (posterior mean) and standard deviation (sd) for the proportion of Spliced (pi\_S) and Unspliced (pi\_U) counts in group `3 mon`, respectively.

We visualize US results.

```
head(results$US_results, 3)
```

```
##               Gene_id Cluster_id      p_val p_adj.glb p_adj.loc Prob-6 mon-UP
## 31 ENSG00000179403.12         RG 0.01702780 0.2527751 0.2271129   0.004666667
## 5  ENSG00000157933.10    Cycling 0.25362515 0.8454172 0.7608754   0.010000000
## 12 ENSG00000197530.12    Cycling 0.02393744 0.2527751 0.2527751   0.010000000
##    pi_S-3 mon pi_U-3 mon pi_S-6 mon pi_U-6 mon sd_S-3 mon sd_U-3 mon sd_S-6 mon
## 31 0.60280253  0.3971975  0.9580279 0.04197211 0.14499713 0.14499713 0.04702326
## 5  0.02351666  0.9764833  0.1974490 0.80255101 0.02653935 0.02653935 0.09575482
## 12 0.44962146  0.5503785  0.8170496 0.18295039 0.13969280 0.13969280 0.03817278
##    sd_U-6 mon
## 31 0.04702326
## 5  0.09575482
## 12 0.03817278
```

We visualize USA results.

```
head(results$USA_results, 3)
```

```
##               Gene_id Cluster_id      p_val p_adj.glb p_adj.loc Prob-6 mon-UP
## 31 ENSG00000179403.12         RG 0.01702780 0.2527751 0.2271129   0.004666667
## 5  ENSG00000157933.10    Cycling 0.25362515 0.8454172 0.7608754   0.010000000
## 12 ENSG00000197530.12    Cycling 0.02393744 0.2527751 0.2527751   0.010000000
##    pi_S-3 mon pi_U-3 mon  pi_A-3 mon pi_S-6 mon pi_U-6 mon pi_A-6 mon
## 31 0.32469407  0.1190890 0.556216926  0.9292102 0.01315445 0.05763533
## 5  0.01872584  0.9716925 0.009581638  0.1305360 0.73563802 0.13382598
## 12 0.28148866  0.3822457 0.336265611  0.7642271 0.13012789 0.10564501
##    sd_S-3 mon sd_U-3 mon sd_A-3 mon sd_S-6 mon sd_U-6 mon sd_A-6 mon
## 31 0.20797530 0.12195424 0.17932220 0.07453247 0.02936422 0.06316600
## 5  0.02626491 0.02792489 0.01104273 0.07469199 0.14825977 0.13580783
## 12 0.17266473 0.16050666 0.18191944 0.05059876 0.03802437 0.04672828
```

We can also visualize information about the convergence of the posterior chains.

```
results$Convergence_results
```

```
##   Cluster_id burn_in N_MCMC first_chain                  second_chain
## 1    Cycling     500   2000   converged NOT run (1st chain converged)
## 2         RG     500   2000   converged NOT run (1st chain converged)
```

Finally, we can plot the estimated proportions of spliced and unspliced reads.
If `CI = TRUE` (default option), for each estimate, we can also add the respective profile Wald type confidence interval, of level `CI_level` (0.95 by default).

Similarly to above, we can plot the proportion of US or USA reads.
Note that, although US reads are easier to interpret, USA reads more closely reflect what is being compared between conditions.

```
plot_pi(results,
        type = "US",
        gene_id = results$Differential_results$Gene_id[1],
        cluster_id = results$Differential_results$Cluster_id[1])
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the DifferentialRegulation package.
##   Please report the issue at
##   <https://github.com/SimoneTiberi/DifferentialRegulation/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
plot_pi(results,
        type = "US",
        gene_id = results$Differential_results$Gene_id[2],
        cluster_id = results$Differential_results$Cluster_id[2])
```

![](data:image/png;base64...)

```
plot_pi(results,
        type = "USA",
        gene_id = results$Differential_results$Gene_id[1],
        cluster_id = results$Differential_results$Cluster_id[1])
```

![](data:image/png;base64...)

```
plot_pi(results,
        type = "USA",
        gene_id = results$Differential_results$Gene_id[2],
        cluster_id = results$Differential_results$Cluster_id[2])
```

![](data:image/png;base64...)

If `traceplot = TRUE` in `DifferentialRegulation`, can also plot the posterior chains of \(\pi\_U\) (i.e., the group-level relative abundances of U) in both groups.
The vertical dashed grey line indicates the burn-in that was used (i.e., the iterations to the left side of the line were excluded).
Note that, to decrease memory requirements, the burn-in is not returned.

```
plot_traceplot(results,
               gene_id = results$Differential_results$Gene_id[1],
               cluster_id = results$Differential_results$Cluster_id[1])
```

![](data:image/png;base64...)

```
plot_traceplot(results,
               gene_id = results$Differential_results$Gene_id[2],
               cluster_id = results$Differential_results$Cluster_id[2])
```

![](data:image/png;base64...)

# 3 Bulk RNA-seq pipeline

## 3.1 Input data: alignment and quantification with *salmon* or *kallisto*

*DifferentialRegulation* inputs bulk RNA-seq data.

Firstly, we should generate an expanded reference transcriptome, containing both spliced and unsplced versions of each transcript.
The code to generate such a reference can be found [here](https://github.com/csoneson/differential_regulation_simulation/blob/main/scripts/prepare_expanded_reference_files.R).

Then, using the extended reference, alignment and quantification can be performed via *salmon* (Patro et al. [2017](#ref-salmon)) or *kallisto* (Bray et al. [2016](#ref-kallisto)).

NOTE:
- when using *salmon*, use the option `--dumpEq` to obtain the equivalence classes;
- when using *kallisto*, run both `kallisto quant` and `kallisto pseudo` to obtain the transcript estimated counts and equivalence classes, respectively.

*salmon* software: <https://combine-lab.github.io/salmon/>

*kallisto* software:
<https://pachterlab.github.io/kallisto/about>

## 3.2 Load the package

Load *DifferentialRegulation*.

```
library(DifferentialRegulation)
```

## 3.3 Load the data

Here, we use a small simulated dataset (human genome), made of two groups of three samples each, where differential effects were artificially introduced in a sub-set of transcripts.

The scripts to generate this simulated data can be found [here](https://github.com/csoneson/differential_regulation_simulation).
Here we use the small simulation (called subset), based on chromosome 22 only.

We specify the directory of the data (internal in the package).

```
data_dir = system.file("extdata", package = "DifferentialRegulation")
```

Specify the path to the data (counts and equivalence classes).

```
# specify samples ids:
sample_ids = paste0("sample", seq_len(6))

# US estimates:
quant_files = file.path(data_dir, "salmon", sample_ids, "quant.sf")
file.exists(quant_files)
```

```
## [1] TRUE TRUE TRUE TRUE TRUE TRUE
```

```
# Equivalence classes:
equiv_classes_files = file.path(data_dir, "salmon", sample_ids, "aux_info/eq_classes.txt.gz")
file.exists(equiv_classes_files)
```

```
## [1] TRUE TRUE TRUE TRUE TRUE TRUE
```

### 3.3.1 Load US counts

Load the unspliced and spliced (US) estimated counts, quantified by *salmon*, in a *SummarizedExperiment*.

```
SE = load_bulk_US(quant_files,
                  sample_ids)
```

```
## reading in files with read_tsv
```

```
## 1 2 3 4 5 6
```

### 3.3.2 Load equivalence classes (EC)

Load the equivalence classes and respective counts.

```
EC_list = load_bulk_EC(path_to_eq_classes = equiv_classes_files,
                       n_cores = 2)
```

```
## The percentage of multi-mapping reads in sample 1 is: 94
```

```
## The percentage of multi-mapping reads in sample 2 is: 94
```

```
## The percentage of multi-mapping reads in sample 3 is: 94
```

```
## The percentage of multi-mapping reads in sample 4 is: 93
```

```
## The percentage of multi-mapping reads in sample 5 is: 93
```

```
## The percentage of multi-mapping reads in sample 6 is: 92
```

For every sample, `load_bulk_EC` prints the percentage of multi-mapping reads; i.e., reads compatible with multiple transcripts, or to both spliced and unspliced versions of a trascript.
Intuitively, the larger these numbers, the greater the benefits one may achieve by using ECs and modelling the variability of these uncertain gene allocations.

## 3.4 QC and filtering

Quality control (QC) and filtering of low quality cells can be performed as usual on the `SE` object, using the `spliced` assay.

Importantly, cells only need to be filtered in the `SE` object, and NOT in the `EC_list` object: cells that are filtered in `SE` will also be removed from ECs when running `DifferentialRegulation_bulk` function.

## 3.5 Differential testing

First, we define the design of the study: in our case we have 2 groups, that we call “A” and “B” of 2 samples each.

```
group_names = rep(c("A", "B"), each = 3)
design = data.frame(sample = sample_ids,
                    group = group_names)
design
```

```
##    sample group
## 1 sample1     A
## 2 sample2     A
## 3 sample3     A
## 4 sample4     B
## 5 sample5     B
## 6 sample6     B
```

We perform differential testing.
As above, if `traceplot = TRUE` the function also returns the posterior chains of \(\pi\_U\) (i.e., the group-level relative abundances of U) in both groups (`MCMC_U` object), which can then be visualized via `plot_bulk_traceplot` function.
Again, the vertical dashed grey line represents the burn-in.

```
# EC-based test:
set.seed(1609612)
results = DifferentialRegulation_bulk(SE = SE,
                                      EC_list = EC_list,
                                      design = design,
                                      n_cores = 2,
                                      traceplot = TRUE)
```

```
## 714 transcripts pass filtering and will be analyzed.
```

```
## Estimating gene-wise precision parameters
```

```
## Estimation completed
```

```
## Starting the MCMC
```

```
## MCMC completed and successfully converged.
```

## 3.6 Visualizing results

`DifferentialRegulation` function returns of a list of 2 data.frames:

* `Differential_results`, which contains results from differential testing, and estimates of the proportion of Spliced and Unspliced reads in each group;
* `Convergence_results`, that contains information about convergence of posterior chains.

```
names(results)
```

```
## [1] "Differential_results" "Convergence_results"  "MCMC_U"
```

In `Differential_results` element, column `Transcript_id` contains the transcript name, while `p_val` and `p_adj` report the raw and adjusted p-values, via Benjamini and Hochberg (BH) correction.
`Prob-group_name-UP`, indicates the probability that a gene is UP-regulated in one group (`B` in this case) compared to the other group.
Names `pi` and `sd` indicate the estimated proportion and standard deviation, respectively, `S` and `U` refer to Spliced and Unspliced counts, respectively, while `A` and `B` refer to the groups, as named in the `design`.
For instance, columns `pi_S-B` and `sd_S-B` indicate the estimate (posterior mean) and standard deviation (sd) for the proportion of Spliced (pi\_S) and Unspliced (pi\_U) counts in group `B`, respectively.

```
head(results$Differential_results, 3)
```

```
##         Transcript_id      p_val     p_adj    Prob-B-UP     pi_S-A    pi_U-A
## 405 ENST00000455558.2 0.01306881 0.2926763 0.0006666667 0.02236814 0.9776319
## 489 ENST00000475941.1 0.04195051 0.7513694 0.0333333333 0.18076359 0.8192364
## 352 ENST00000437122.1 0.37595245 0.9999918 0.1280000000 0.08693849 0.9130615
##        pi_S-B    pi_U-B     sd_S-A     sd_U-A    sd_S-B    sd_U-B
## 405 0.3329001 0.6670999 0.01836548 0.01836548 0.1211540 0.1211540
## 489 0.6213707 0.3786293 0.12237619 0.12237619 0.1878014 0.1878014
## 352 0.2607850 0.7392150 0.08816988 0.08816988 0.1646697 0.1646697
```

We can also sort genes by the probability that they are being up-regulated in group `B`:

```
ordering_UP = order(results$Differential_results[,4], decreasing = TRUE)
head(results$Differential_results[ordering_UP,], 3)
```

```
##         Transcript_id        p_val        p_adj Prob-B-UP    pi_S-A    pi_U-A
## 92  ENST00000331728.9 7.621029e-05 6.801768e-03         1 0.6714835 0.3285165
## 98  ENST00000333130.4 2.727985e-07 6.492605e-05         1 0.8644982 0.1355018
## 174 ENST00000398822.7 1.721514e-03 6.469269e-02         1 0.5781232 0.4218768
##         pi_S-B    pi_U-B    sd_S-A    sd_U-A     sd_S-B     sd_U-B
## 92  0.02080984 0.9791902 0.1590060 0.1590060 0.05302101 0.05302101
## 98  0.02821470 0.9717853 0.1552249 0.1552249 0.06050581 0.06050581
## 174 0.05021898 0.9497810 0.1666666 0.1666666 0.03243535 0.03243535
```

Alternatively, one can sort genes by their probability of currently being down-regulated in group `B` (or conversely, up-regularted in the alternative group, `3mon`):

```
ordering_DOWN = order(results$Differential_results[,4], decreasing = FALSE)
head(results$Differential_results[ordering_DOWN,], 3)
```

```
##         Transcript_id      p_val     p_adj    Prob-B-UP     pi_S-A    pi_U-A
## 405 ENST00000455558.2 0.01306881 0.2926763 0.0006666667 0.02236814 0.9776319
## 489 ENST00000475941.1 0.04195051 0.7513694 0.0333333333 0.18076359 0.8192364
## 352 ENST00000437122.1 0.37595245 0.9999918 0.1280000000 0.08693849 0.9130615
##        pi_S-B    pi_U-B     sd_S-A     sd_U-A    sd_S-B    sd_U-B
## 405 0.3329001 0.6670999 0.01836548 0.01836548 0.1211540 0.1211540
## 489 0.6213707 0.3786293 0.12237619 0.12237619 0.1878014 0.1878014
## 352 0.2607850 0.7392150 0.08816988 0.08816988 0.1646697 0.1646697
```

We can also visualize information about the convergence of the posterior chains.

```
results$Convergence_results
```

```
##   burn_in N_MCMC first_chain                  second_chain
## 1     500   2000   converged NOT run (1st chain converged)
```

Finally, we can plot the estimated proportions of spliced and unspliced reads.
If `CI = TRUE` (default option), for each estimate, we can also add the respective profile Wald type confidence interval, of level `CI_level` (0.95 by default).

```
plot_bulk_pi(results,
             transcript_id = results$Differential_results$Transcript_id[1])
```

![](data:image/png;base64...)

```
plot_bulk_pi(results,
             transcript_id = results$Differential_results$Transcript_id[2])
```

![](data:image/png;base64...)

If `traceplot = TRUE` in `DifferentialRegulation_bulk`, can also plot the posterior chains of \(\pi\_U\) (i.e., the group-level relative abundances of U) in both groups.
Note that, to decrease memory requirements, the burn-in is not returned.

```
plot_bulk_traceplot(results,
                    transcript_id = results$Differential_results$Transcript_id[1])
```

![](data:image/png;base64...)

```
plot_bulk_traceplot(results,
                    transcript_id = results$Differential_results$Transcript_id[2])
```

![](data:image/png;base64...)

# 4 Session info

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
## [1] DifferentialRegulation_2.8.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                R.utils_2.13.0
##  [5] S7_0.2.0                    fastmap_1.2.0
##  [7] SingleCellExperiment_1.32.0 digest_0.6.37
##  [9] lifecycle_1.0.4             statmod_1.5.1
## [11] DRIMSeq_1.38.0              magrittr_2.0.4
## [13] compiler_4.5.1              rlang_1.1.6
## [15] sass_0.4.10                 rngtools_1.5.2
## [17] tools_4.5.1                 yaml_2.3.10
## [19] data.table_1.17.8           knitr_1.50
## [21] S4Arrays_1.10.0             labeling_0.4.3
## [23] doRNG_1.8.6.2               bit_4.6.0
## [25] DelayedArray_0.36.0         plyr_1.8.9
## [27] RColorBrewer_1.1-3          abind_1.4-8
## [29] BiocParallel_1.44.0         withr_3.0.2
## [31] BiocGenerics_0.56.0         R.oo_1.27.1
## [33] grid_4.5.1                  stats4_4.5.1
## [35] edgeR_4.8.0                 ggplot2_4.0.0
## [37] scales_1.4.0                iterators_1.0.14
## [39] MASS_7.3-65                 tinytex_0.57
## [41] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [43] cli_3.6.5                   rmarkdown_2.30
## [45] crayon_1.5.3                generics_0.1.4
## [47] tzdb_0.5.0                  reshape2_1.4.4
## [49] cachem_1.1.0                stringr_1.5.2
## [51] parallel_4.5.1              BiocManager_1.30.26
## [53] XVector_0.50.0              matrixStats_1.5.0
## [55] vctrs_0.6.5                 Matrix_1.7-4
## [57] jsonlite_2.0.0              bookdown_0.45
## [59] hms_1.1.4                   IRanges_2.44.0
## [61] S4Vectors_0.48.0            bit64_4.6.0-1
## [63] archive_1.1.12              magick_2.9.0
## [65] locfit_1.5-9.12             foreach_1.5.2
## [67] limma_3.66.0                jquerylib_0.1.4
## [69] glue_1.8.0                  codetools_0.2-20
## [71] stringi_1.8.7               gtable_0.3.6
## [73] GenomicRanges_1.62.0        BANDITS_1.26.0
## [75] tibble_3.3.0                pillar_1.11.1
## [77] htmltools_0.5.8.1           Seqinfo_1.0.0
## [79] R6_2.6.1                    doParallel_1.0.17
## [81] tximport_1.38.0             vroom_1.6.6
## [83] evaluate_1.0.5              lattice_0.22-7
## [85] Biobase_2.70.0              readr_2.1.5
## [87] R.methodsS3_1.8.2           bslib_0.9.0
## [89] Rcpp_1.1.0                  gridExtra_2.3
## [91] SparseArray_1.10.0          xfun_0.53
## [93] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Amezquita, Robert A, Aaron TL Lun, Etienne Becht, Vince J Carey, Lindsay N Carpp, Ludwig Geistlinger, Federico Marini, et al. 2020. “Orchestrating Single-Cell Analysis with Bioconductor.” *Nature Methods* 17 (2): 137–45.

Bergen, Volker, Marius Lange, Stefan Peidli, F Alexander Wolf, and Fabian J Theis. 2020. “Generalizing Rna Velocity to Transient Cell States Through Dynamical Modeling.” *Nature Biotechnology* 38 (12): 1408–14.

Bray, Nicolas L, Harold Pimentel, Páll Melsted, and Lior Pachter. 2016. “Near-Optimal Probabilistic Rna-Seq Quantification.” *Nature Biotechnology* 34 (5): 525.

He, Dongze, Mohsen Zakeri, Hirak Sarkar, Charlotte Soneson, Avi Srivastava, and Rob Patro. 2022. “Alevin-fry unlocks rapid, accurate and memory-frugal quantification of single-cell RNA-seq data.” *Nature Methods* 19 (3): 316–22.

La Manno, Gioele, Ruslan Soldatov, Amit Zeisel, Emelie Braun, Hannah Hochgerner, Viktor Petukhov, Katja Lidschreiber, et al. 2018. “RNA Velocity of Single Cells.” *Nature* 560 (7719): 494–98.

Patro, Rob, Geet Duggal, Michael I Love, Rafael A Irizarry, and Carl Kingsford. 2017. “Salmon Provides Fast and Bias-Aware Quantification of Transcript Expression.” *Nature Methods* 14 (4): 417.

Velasco, Silvia, Amanda J Kedaigle, Sean K Simmons, Allison Nash, Marina Rocha, Giorgia Quadrato, Bruna Paulsen, et al. 2019. “Individual Brain Organoids Reproducibly Form Cell Diversity of the Human Cerebral Cortex.” *Nature* 570 (7762): 523–27.