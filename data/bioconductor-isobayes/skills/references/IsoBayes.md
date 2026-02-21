# IsoBayes

Jordy Bollon1\* and Simone Tiberi2\*\*

1Research Center dedicated to Personalized, Preventive and Predictive Medicine (CMP3VDA), Computational Department, Aosta, Italy
2Department of Statistical Sciences, University of Bologna, Bologna, Italy

\*jordy.bollon@iit.it
\*\*simone.tiberi@unibo.it

#### 10/30/2025

#### Package

IsoBayes 1.8.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Bioconductor installation](#bioconductor-installation)
* [2 Questions, issues and citation](#questions-issues-and-citation)
* [3 Load the package](#load-the-package)
* [4 Key options](#key-options)
  + [4.1 Input data](#input-data)
  + [4.2 PSM counts vs. intensities](#psm-counts-vs.-intensities)
  + [4.3 TPMs (optional)](#tpms-optional)
  + [4.4 PEP vs. FDR cutoff](#pep-vs.-fdr-cutoff)
* [5 Generate `SummarizedExperiment` object](#generate-summarizedexperiment-object)
  + [5.1 Input *MetaMorpheus* data](#input-metamorpheus-data)
    - [5.1.1 Peptide-Spectrum Match (PSM) counts](#peptide-spectrum-match-psm-counts)
    - [5.1.2 Intensities](#intensities)
  + [5.2 Input *Percolator* data](#input-percolator-data)
  + [5.3 Input user provided-data](#input-user-provided-data)
    - [5.3.1 `.tsv` or `data.frame` format](#tsv-or-data.frame-format)
    - [5.3.2 SummarizedExperiment format](#summarizedexperiment-format)
* [6 Input and pre-process data](#input-and-pre-process-data)
* [7 Inference](#inference)
  + [7.1 Gene Normalization (optional)](#gene-normalization-optional)
* [8 Visualizing results](#visualizing-results)
* [9 Assessing convergence via traceplots](#assessing-convergence-via-traceplots)
* [10 Session info](#session-info)
* [11 *OpenMS* and *Metamorpheus* pipeline](#openms-and-metamorpheus-pipeline)
  + [11.1 *MetaMorpheus* pipeline](#metamorpheus-pipeline)
  + [11.2 *Percolator* pipeline](#percolator-pipeline)
* [References](#references)

# 1 Introduction

*IsoBayes* is a Bayesian method to perform inference on single protein isoforms.
Our approach infers the presence/absence of protein isoforms, and also estimates their abundance;
additionally, it provides a measure of the uncertainty of these estimates, via:
i) the posterior probability that a protein isoform is present in the sample;
ii) a posterior credible interval of its abundance.
*IsoBayes* inputs liquid cromatography mass spectrometry (MS) data,
and can work with both PSM counts, and intensities.
When available, trascript isoform abundances (i.e., TPMs) are also incorporated:
TPMs are used to formulate an informative prior for the respective protein isoform relative abundance.
We further identify isoforms where the relative abundance of proteins and transcripts significantly differ.
We use a two-layer latent variable approach to model two sources of uncertainty typical of MS data:
i) peptides may be erroneously detected (even when absent);
ii) many peptides are compatible with multiple protein isoforms.
In the first layer, we sample the presence/absence of each peptide based on its estimated probability
of being mistakenly detected, also known as PEP (i.e., posterior error probability).
In the second layer, for peptides that were estimated as being present,
we allocate their abundance across the protein isoforms they map to.
These two steps allow us to recover the presence and abundance of each protein isoform.

## 1.1 Bioconductor installation

*IsoBayes* is available on [Bioconductor](https://bioconductor.org/packages/IsoBayes) and can be installed with the command:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("IsoBayes")
```

To access the R code used in the vignettes, type:

```
browseVignettes("IsoBayes")
```

# 2 Questions, issues and citation

Questions relative to *IsoBayes* should be reported as a new issue at *[BugReports](https://github.com/SimoneTiberi/IsoBayes/issues)*.

To cite *IsoBayes*, type:

```
citation("IsoBayes")
```

```
## To cite DifferentialRegulation in publications use:
##
##   Jordy Bollon, Michael R. Shortreed, Ben T. Jordan, Rachel Miller,
##   Erin Jeffery, Andrea Cavalli, Lloyd M. Smith, Colin Dewey, Gloria M.
##   Sheynkman, and Simone Tiberi (2024). IsoBayes: a Bayesian approach
##   for single-isoform proteomics inference. bioRxiv. URL
##   https://doi.org/10.1101/2024.06.10.598223
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {IsoBayes: a Bayesian approach for single-isoform proteomics inference},
##     author = {Jordy Bollon and Michael R. Shortreed and Ben T. Jordan and Rachel Miller and Erin Jeffery and Andrea Cavalli and Lloyd M. Smith and Colin Dewey and Gloria M. Sheynkman and Simone Tiberi},
##     eprint = {https://doi.org/10.1101/2024.06.10.598223},
##     journal = {bioRxiv},
##     year = {2024},
##     doi = {10.1101/2024.06.10.598223},
##     url = {https://doi.org/10.1101/2024.06.10.598223},
##   }
```

# 3 Load the package

Load *IsoBayes*:

```
library(IsoBayes)
```

# 4 Key options

## 4.1 Input data

*IsoBayes* works with the output of both *MetaMorpheus* (MM) (Solntsev et al. [2018](#ref-MetaMorpheus)), or *Percolator* (The et al. [2016](#ref-Percolator)) (via the *OpenMS* toolkit (Röst et al. [2016](#ref-OpenMS))).
Additionally, users can also provide MS data obtained from any bioinformatics tool, as long as the input files follow the structure mentioned in the [Input user-provided data](#input-user-provided-data) Section.
In our benchmarks, we tested our model using both *MetaMorpheus* and *Percolator* data, and obtained slightly better results, and a shorter runtime with *MetaMorpheus*.

At the bottom of the vignette, in Section [*OpenMS* and *Metamorpheus* pipeline](#openms-and-metamorpheus-pipeline) we provide example scripts for both *OpenMS* and *Metamorpheus*.

In this tutorial, we use a small dataset created by *MetaMorpheus*.
The code to generate the data can be found [here](https://github.com/SimoneTiberi/IsoBayes/blob/main/inst/script/extdata.Rmd).

## 4.2 PSM counts vs. intensities

We can run *IsoBayes* on either PSM counts or intensities.
In our benchmarks, we found that, although results are consistent between the two types of input data, intensities led to a marginal improvement in performance.

## 4.3 TPMs (optional)

If available, transcriptomics data (from short of long reads), can also be integrated in the model in the form of TPMs; this will enhance protein isoform inference.
To correctly match proteomics and transcriptomics data, transcript isoform and protein isoform names must be consistent.
Here, we also specify the path to TPMs (optional).
TPMs must be stored in a `data.frame` object (with columns `isoname` and `tpm`), or in a `.tsv` file (with headers `isoname` and `tpm`); in either case, there should be 1 row per isoform, and 2 columns:

* ‘isoname’: a character string indicating the isoform name;
* ‘tpm’: a numeric variable indicating the TPM counts.
  Column names must be ‘isoname’ and ‘tpm’.

We set the directory of the data (internal in the package):

```
data_dir = system.file("extdata", package = "IsoBayes")
```

We set the path (optional) to the TPMs:

```
tpm_path = paste0(data_dir, "/jurkat_isoform_kallisto.tsv")
```

## 4.4 PEP vs. FDR cutoff

Additionally, we suggest to provide the probability that peptides are erroneously detected (usually called PEP): *IsoBayes* will use the PEP to sample the presence/absence of each peptide; this will propagate the peptide identification uncertainty throughout the inference process.
Alternatively, unreliable peptides can be discarded by specifying a peptide False Discovery Rate (FDR) threshold (also known as qvalue).
We suggest using PEP with a weak FDR threshold of 0.1 (default parameters options).
This is because peptides with FDR > 0.1 are usually unreliable, and associated to high error probabilities (e.g., PEP > 0.9).
In our benchmarks, we found that using `PEP` (with and FDR threshold of 0.1) provides a (minor) increase in performace compared to the classical FDR thresholding (0.01 threshold), at the cost of a (marginally) higher runtime.
If we want to disable the PEP integration, and filter based on the FDR, we can set `PEP = FALSE` and specify a more stringent FDR cutoff, e.g., as `FDR_thd = 0.01`.

# 5 Generate `SummarizedExperiment` object

Before running the IsoBayes model, we structure all the required input data into a `SummarizedExperiment` object.
Such object can be created in multiple ways;

## 5.1 Input *MetaMorpheus* data

We set the path to the AllPeptides.psmtsv file returned by *MetaMorpheus*:

```
path_to_peptides_psm = paste0(data_dir, "/AllPeptides.psmtsv")
```

### 5.1.1 Peptide-Spectrum Match (PSM) counts

The AllPeptides.psmtsv file contains all the information required to run *IsoBayes* with PSM counts.
First, we load the file and we convert it into a `SummarizedExperiment` object via `generate_SE` function. Then, we preprocess the input data using the `input_data` function:

```
SE = generate_SE(path_to_peptides_psm = path_to_peptides_psm,
                 abundance_type = "psm",
                 input_type = "metamorpheus")
```

```
## We found:
```

```
## 10647 protein isoforms.
```

```
SE
```

```
## class: SummarizedExperiment
## dim: 1 8209
## metadata(5): PEP FDR_thd input_type protein_name id_openMS
## assays(1): Y
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(5): EC QValue DCT sequence PEP
```

### 5.1.2 Intensities

If we want to run the algorithm with peptide intensities, in addition to AllPeptides.psmtsv, we also need to load a second file generated by MM: AllQuantifiedPeptides.tsv.
Then, we have to set `abundance_type` argument to “intensities”; otherwise, the `generate_SE` function will ignore the AllQuantifiedPeptides.tsv file.

```
path_to_peptides_intensities = paste0(data_dir, "/AllQuantifiedPeptides.tsv")
SE = generate_SE(path_to_peptides_psm = path_to_peptides_psm,
                 path_to_peptides_intensities = path_to_peptides_intensities,
                 abundance_type = "intensities",
                 input_type = "metamorpheus")
```

```
## Peptides with intensity equal to 0:
## 0.568%
```

```
## NA's intensity: 30.823%
```

```
## We found:
```

```
## 10647 protein isoforms.
```

## 5.2 Input *Percolator* data

*IsoBayes* is also compatible with the PSM file from *Percolator* (from the *OpenMS* toolkit).
The [README](https://github.com/SimoneTiberi/IsoBayes/tree/main#readme) shows how to use *OpenMS* tools to generate an idXML file containing PSM data.
Once the file has been created, we can pass its path to `input_data` and set `input_type` as “openMS”.

```
SE = generate_SE(path_to_peptides_psm = "/path/to/file.idXML",
                 abundance_type = "psm",
                 input_type = "openMS")
```

Please note that when using data generated by *Percolator*, the algorithm can only process PSM counts and not intensities.

## 5.3 Input user provided-data

We can also input MS data obtained from any bioinformatics tool.
The data can be organized in a `.tsv` file, a `data.frame` or a `SummarizedExperiment`.

### 5.3.1 `.tsv` or `data.frame` format

In both `.tsv` and `data.frame` files, each row corresponds to a peptide, and columns refer to:

* ‘Y’: a numeric variable indicating the peptide abundance (PSM counts or intensities, as defined by the user);
* ‘EC’: Equivalent Classes, a character string indicating the isoform(s) name the peptide maps to. If the peptide maps to multiple protein isoforms, the names must be separated with “|” , i.e. “name\_isoform\_1|name\_isoform\_2”;
* ‘FDR’: (optional) a numeric variable indicating the FDR of each peptide;
* ‘PEP’: (optional) a numeric variable indicating the probability that a peptide is erroneously detected;
* ‘sequence’: (required when using PEP) a character string indicating the peptide name/id/amino acids sequence.

Note that, when using user-provided data, argument `path_to_peptides_intensities` is not considered, because users are free to set column `Y` to PSM counts or intensities.

To load user-provided data, we just need to pass the file path, the `data.frame` or the `SummarizedExperiment` object and set `input_type` as “other” .

```
# X can be a path to a .tsv file or a data.frame
SE = generate_SE(path_to_peptides_psm = X,
                 abundance_type = "psm",
                 input_type = "other")
```

### 5.3.2 SummarizedExperiment format

If the data is already stored in a `SummarizedExperiment`, it can be passed to `input_data` function directly.
The `SummarizedExperiment` should contain `assays`, `colData` and `metadata` with the structure specified below.

Object `assays`:

* `Y`; a numeric vector indicating the peptide abundance (PSM counts or intensities).

Object `colData`, a `DataFrame` object with columns:

* ‘EC’: Equivalent Classes, a character string indicating the isoform(s) name the peptide maps to. If the peptide maps to multiple protein isoforms, the names must be separated with “|” , i.e. “name\_isoform\_1|name\_isoform\_2”;
* ‘PEP’: (optional) a numeric variable indicating the probability that a peptide is erroneously detected;
* ‘sequence’: (required when using PEP) a character string indicating the peptide name/id/amino acids sequence.

Object `metadata`, a list of objects:

* ‘PEP’: logical; if TRUE, the algorithm will account for the probability that peptides are erroneously detected;
* ‘protein\_name’: a character vector indicating the protein isoforms name.

IMPORTANT: `input_data` does not filter peptides based on their FDR, since it assumes that unreliable peptides have been already discarded.
Therefore, FDR filtering must be performed by users before the `SE` oject is provided to `input_data`.

# 6 Input and pre-process data

Once we have generated an `SE` object, we can process it, together with the TPMs (if available), via `input_data`.
For this vignette, we use the `SE` object generated above loading the output from *MetaMorpheus*.

```
data_loaded = input_data(SE, path_to_tpm = tpm_path)
```

```
## After filtering petides, we will analyze:
```

```
## 7106 protein isoforms.
```

```
## Percentage of unique peptides:
## 46.49%
```

# 7 Inference

Once we have loaded the data, we can run the algorithm using the `inference` function.

```
set.seed(169612)
results = inference(data_loaded)
```

By default, *IsoBayes* uses one single core.
For large datasets, to speed up the execution time, the number of cores can be increased via the `n_cores` argument.

## 7.1 Gene Normalization (optional)

In order to analyse alternative splicing within a specific gene, we may want to normalize the estimated relative abundances for each set of protein isoforms that maps to a gene. To this aim, we need to input a csv file containing two columns denoting the isoform name and the gene name.
Alternatively, if isoform-gene ids are already loaded, a data.frame can be used directly.
In both cases, the csv file or data.frame must have 2 columns: the 1st column must contain the isoform name/id, while the 2nd column has the gene name/id.

```
path_to_map_iso_gene = paste0(data_dir, "/map_iso_gene.csv")
set.seed(169612)
results_normalized = inference(data_loaded, map_iso_gene = path_to_map_iso_gene, traceplot = TRUE)
```

Specifying the `map_iso_gene` argument, also enables users to plot results via `plot_relative_abundances` function.

# 8 Visualizing results

Results are stored as a `list` with three `data.frame` objects: ‘isoform\_results’, ‘normalized\_isoform\_results’ and ‘gene\_abundance’. If ‘map\_iso\_gene’ was not provided, only ‘isoform\_results’ is returned.

```
names(results_normalized)
```

```
## [1] "isoform_results"            "normalized_isoform_results"
## [3] "gene_abundance"             "MCMC"
```

Inside the ‘isoform\_results’ `data.frame`, each row corresponds to a protein isoform. The columns report the following results:

* ‘Prob\_present’: the probability that the protein isoform is present in the biological sample;
* ‘Abundance’: estimate (posterior mean) of the protein isoform absolute abundance - note that, for intensities, abundances are normalized (they add to 10,000), so the scale differs from the one provided as input by the user;
* ‘CI\_LB’: lower bound of the Highest Posterior Density (HPD) credible interval (0.95 level) for the absolute abundance;
* ‘CI\_UB’: upper bound of the HPD credible interval (0.95 level) for the absolute abundance;
* ‘Pi’: estimate (posterior mean) of the protein isoform relative abundance across all isoforms (i.e., the sum of across all isoforms adds to 1);
* ‘Pi\_CI\_LB’: lower bound of the HPD credible interval (0.95 level) for Pi;
* ‘Pi\_CI\_UB’: upper bound of the HPD credible interval (0.95 level) for Pi;
* ‘TPM’: transcript isoform abundance, provided by the users as input in `input_data` function;
* ‘Log2\_FC’: log2 fold change between protein and transcript isoform relative abundances (i.e., ‘Pi’ and normalized TPMs);
  positive (negative) values indicate higher (lower) relative isoform abundance at the protein level, compared to the transcript level;
* ‘Prob\_prot\_inc’: estimated probability that the relative abundance of the protein isoform is greater than the relative abundance of the corresponding transcript isoform (to be interpreted in conjunction with ‘Log2\_FC’); values towards 1 (towards 0) suggest that isoform relative abundances are higher (lower) at the protein-level than at the transcript-level.

```
head(results_normalized$isoform_results)
```

```
##    Gene   Isoform Prob_present Abundance CI_LB CI_UB           Pi     Pi_CI_LB
## 1 AAGAB AAGAB-201        0.644     1.262     0     3 1.584713e-05 2.383631e-11
## 2 AAGAB AAGAB-203        0.793     1.738     0     3 2.153024e-05 6.702643e-08
## 3  AAK1  AAK1-201        0.736     1.565     0     3 1.489832e-05 3.930209e-26
## 4  AAK1  AAK1-203        0.355     0.701     0     3 6.720064e-06 3.967865e-28
## 5  AAK1  AAK1-211        0.797     3.443     0     6 3.240565e-05 7.724298e-11
## 6  AAK1  AAK1-212        0.624     2.291     0     6 2.185897e-05 3.862298e-15
##       Pi_CI_UB       TPM     Log2_FC Prob_prot_inc
## 1 4.702063e-05 17.284100 -1.55230266         0.050
## 2 5.471843e-05 26.384500 -1.72040513         0.015
## 3 4.220247e-05  1.625010  1.76955056         0.702
## 4 3.228300e-05  0.632271  1.98278141         0.428
## 5 7.634762e-05 11.637600  0.05037318         0.485
## 6 6.822451e-05  7.264770  0.16215810         0.430
```

In ‘normalized\_isoform\_results’ `data.frame`, we report the protein isoform relative abundances, normalized within each gene (i.e., adding to 1 within a gene).

```
head(results_normalized$normalized_isoform_results)
```

```
##    Gene   Isoform    Pi_norm Pi_norm_CI_LB Pi_norm_CI_UB Pi_norm_TPM
## 1 AAGAB AAGAB-201 0.42417351  4.935733e-07     0.9559613  0.39580156
## 2 AAGAB AAGAB-203 0.57582649  4.403868e-02     0.9999995  0.60419844
## 3  AAK1  AAK1-201 0.19820016  3.737326e-22     0.5085673  0.07679758
## 4  AAK1  AAK1-203 0.08748612  6.632691e-24     0.4136955  0.02988097
## 5  AAK1  AAK1-211 0.42462808  1.506936e-06     0.8609503  0.54999017
## 6  AAK1  AAK1-212 0.28968564  9.926213e-11     0.8071473  0.34333128
```

In ‘gene\_abundance’ `data.frame`, for each gene (row) we return:

* ‘Abundance’: estimate (posterior mean) of the gene absolute abundance;
* ‘CI\_LB’: lower bound of the HPD credible interval (0.95 level) for the gene absolute abundance;
* ‘CI\_UB’: upper bound of the HPD credible interval (0.95 level) for the gene absolute abundance.

```
head(results_normalized$gene_abundance)
```

```
##    Gene Abundance CI_LB CI_UB
## 1 AAGAB     3.000     3     3
## 2  AAK1     8.000     8     8
## 3  AAMP     8.991     9     9
## 4  AAR2     8.000     8     8
## 5 AARS1   119.000   119   119
## 6 AARS2     4.000     4     4
```

Finally, *IsoBayes* provides the `plot_relative_abundances` function to visualize protein-level and transcript-level relative abundances across the isoforms of a specific gene:

```
plot_relative_abundances(results_normalized, gene_id = "TUBB")
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the IsoBayes package.
##   Please report the issue at <https://github.com/SimoneTiberi/IsoBayes/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the IsoBayes package.
##   Please report the issue at <https://github.com/SimoneTiberi/IsoBayes/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

By default `plot_relative_abundances` normalizes the relative abundances within genes (again, adding to 1 within a gene).
To disable the normalization, set the
`normalize_gene` argument to `FALSE`:

```
plot_relative_abundances(results_normalized, gene_id = "TUBB", normalize_gene = FALSE)
```

![](data:image/png;base64...)

Note that `plot_relative_abundances` can be used only when, in the `map_iso_gene` argument of the `inference` function, we provide a csv file that maps the protein isoforms to the corresponding gene (`path_to_map_iso_gene` in this case).

# 9 Assessing convergence via traceplots

If `inference` function was run with parameter `traceplot = TRUE`, we can visualize the traceplot of the posterior chains of the relative abundances of each protein isoform (i.e., `PI`).
We use the `plot_traceplot` function to plot the 3 isoforms of the gene `TUBB`:

```
plot_traceplot(results_normalized, "TUBB-205")
```

![](data:image/png;base64...)

```
plot_traceplot(results_normalized, "TUBB-206")
```

![](data:image/png;base64...)

```
plot_traceplot(results_normalized, "TUBB-208")
```

![](data:image/png;base64...)

The vertical grey dashed line indicates the burn-in (the iterations on the left side of the burn-in are discarded in posterior analyses).

Note that, although we are using normalized results, gene-level information is ignored in the traceplot.

# 10 Session info

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
## [1] IsoBayes_1.8.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] ggplot2_4.0.0               Biobase_2.70.0
##  [7] lattice_0.22-7              vctrs_0.6.5
##  [9] tools_4.5.1                 generics_0.1.4
## [11] stats4_4.5.1                parallel_4.5.1
## [13] tibble_3.3.0                pkgconfig_2.0.3
## [15] Matrix_1.7-4                data.table_1.17.8
## [17] RColorBrewer_1.1-3          S7_0.2.0
## [19] S4Vectors_0.48.0            rngtools_1.5.2
## [21] HDInterval_0.2.4            lifecycle_1.0.4
## [23] compiler_4.5.1              farver_2.1.2
## [25] tinytex_0.57                Seqinfo_1.0.0
## [27] codetools_0.2-20            htmltools_0.5.8.1
## [29] sass_0.4.10                 yaml_2.3.10
## [31] pillar_1.11.1               crayon_1.5.3
## [33] jquerylib_0.1.4             DelayedArray_0.36.0
## [35] cachem_1.1.0                magick_2.9.0
## [37] doRNG_1.8.6.2               iterators_1.0.14
## [39] abind_1.4-8                 foreach_1.5.2
## [41] tidyselect_1.2.1            digest_0.6.37
## [43] dplyr_1.1.4                 bookdown_0.45
## [45] labeling_0.4.3              fastmap_1.2.0
## [47] grid_4.5.1                  cli_3.6.5
## [49] SparseArray_1.10.0          magrittr_2.0.4
## [51] S4Arrays_1.10.0             dichromat_2.0-0.1
## [53] withr_3.0.2                 scales_1.4.0
## [55] rmarkdown_2.30              XVector_0.50.0
## [57] matrixStats_1.5.0           evaluate_1.0.5
## [59] knitr_1.50                  GenomicRanges_1.62.0
## [61] IRanges_2.44.0              doParallel_1.0.17
## [63] rlang_1.1.6                 Rcpp_1.1.0
## [65] glue_1.8.0                  BiocManager_1.30.26
## [67] BiocGenerics_0.56.0         jsonlite_2.0.0
## [69] R6_2.6.1                    MatrixGenerics_1.22.0
```

# 11 *OpenMS* and *Metamorpheus* pipeline

*IsoBayes* works directly with the output of *MetaMorpheus*, or *Percolator* (via the *OpenMS* toolkit).
Additionally, users can also provide MS data obtained from any bioinformatics tool, as long as the input files follow the structure mentioned in the Input user-provided data Section
*IsoBayes* works with the output of both *MetaMorpheus* (MM) (Solntsev et al. [2018](#ref-MetaMorpheus)), or *Percolator* (The et al. [2016](#ref-Percolator)) (via the *OpenMS* toolkit (Röst et al. [2016](#ref-OpenMS))).
Additionally, users can also provide MS data obtained from any bioinformatics tool, as long as the input files follow the structure mentioned in the [Input user-provided data](#input-user-provided-data) Section.

Below, we provide example scripts for both *OpenMS* and *Metamorpheus*.

## 11.1 *MetaMorpheus* pipeline

To generate the MM output files required to run *IsoBayes*, we need to execute the following commands:

* Install *MetaMorpheus* via [*Conda*](https://docs.conda.io/en/latest/miniconda.html):

```
conda install -c conda-forge metamorpheus
```

* Inside the folder with the configuration (.toml), spectra (.mzML or .raw) and database (.xml) files run:

```
metamorpheus -t Task1-SearchTaskconfig.toml Task2-CalibrateTaskconfig.toml Task3-SearchTaskconfig.toml Task4-GPTMDTaskconfig.toml Task5-SearchTaskconfig.toml -s 04-30-13_CAST_Frac4_6uL.raw 04-30-13_CAST_Frac5_4uL.raw -d uniprot-mouse-reviewed-1-24-2018.xml.gz uniprot-cRAP-1-24-2018.xml.gz
```

or

```
metamorpheus -t Task1-SearchTaskconfig.toml Task2-CalibrateTaskconfig.toml Task3-SearchTaskconfig.toml Task4-GPTMDTaskconfig.toml Task5-SearchTaskconfig.toml -s mzML/04-30-13_CAST_Frac4_6uL.mzML mzML/04-30-13_CAST_Frac5_4uL.mzML -d uniprot-mouse-reviewed-1-24-2018.xml.gz uniprot-cRAP-1-24-2018.xml.gz
```

There are several ways to install and run MM. For more details see the MM [tutorial](https://github.com/smith-chem-wisc/MetaMorpheus/wiki/Getting-Started#test-installation-via-net-core-dll---linux-macos-windows), where you can also find the example files used here.

## 11.2 *Percolator* pipeline

We provide a brief pipeline where several *OpenMS* applications are chained together to generate an idXML file required to run *IsoBayes* with *Percolator* output. The pipeline starts from peptide identification results stored in mzID files.

First, install *OpenMS* toolkit and *Percolator* tool.
For instructions on how to install them on your operating system see [OpenMS Installation](https://openms.readthedocs.io/en/latest/openms-applications-and-tools/installation.html) and [Percolator Installation](https://github.com/percolator/percolator).

Next, declare some useful global variable:

```
path_to_data=/path/to/mzIDfiles
path_out=/path/to/output
NTHREADS=4
ENZYME_indexer="Chymotrypsin"
ENZYME_percolator="chymotrypsin"
DECOY_STRING="mz|DECOY_"
fdr=1
```

Below, we show an example with chymotrypsin enzyme.
If the data was generated with another enzyme, please search for the corresponding enzyme in the documentation below, and reset the global variables `ENZYME_indexer` and `ENZYME_percolator` with the correct enzyme.

```
PeptideIndexer --help
PercolatorAdapter --help
```

This pipeline also assumes that in the `/path/to/mzIDfiles` folder there is a fasta file listing target and decoy protein isoforms.
The `DECOY_STRING` allows you to change the string needed to identify a decoy in the fasta file.

```
cd $path_out

# convert mzID files into idXML files
for mz in $path_to_data/*.mzID
do
        IDFileConverter -in $mz -threads $NTHREADS -out $mz.idXML
done

# merge the files
IDMerger -in $path_to_data/*.idXML -threads $NTHREADS -merge_proteins_add_PSMs -out $path_out/merge.idXML
rm $path_to_data/*.idXML

# index the peptide file with the fasta file
PeptideIndexer -in $path_out/merge.idXML -enzyme:name $ENZYME_indexer -threads $NTHREADS -decoy_string_position prefix -decoy_string $DECOY_STRING -fasta $path_to_data/genecodeAndDecoy.fasta -out $path_out/merge_index.idXML
rm $path_out/merge.idXML

# run percolator
PercolatorAdapter -in $path_out/merge_index.idXML -enzyme $ENZYME_percolator -threads $NTHREADS -generic_feature_set -score_type pep -out $path_out/merge_index_percolator_pep.idXML
rm $path_out/merge_index.idXML

# Estimate the false discovery rate on peptide level using decoy searches and keep the ones with FDR < $fdr
FalseDiscoveryRate -in $path_out/merge_index_percolator_pep.idXML -out $path_out/merge_index_percolator_pep_$fdr.idXML -protein false -threads $NTHREADS -FDR:PSM $fdr -algorithm:add_decoy_peptides -algorithm:add_decoy_proteins
rm $path_out/merge_index_percolator_pep.idXML

# Associate each peptite with Posterior Error Probability score
IDScoreSwitcher -in $path_out/merge_index_percolator_pep_$fdr.idXML -out $path_out/merge_index_percolator_pep_switched_$fdr.idXML -new_score 'Posterior Error Probability_score' -new_score_orientation lower_better -new_score_type pep -threads $NTHREADS
rm $path_out/merge_index_percolator_pep_$fdr.idXML
```

For more details on *OpenMS* tools see its [Documentation](https://abibuilder.cs.uni-tuebingen.de/archive/openms/Documentation/nightly/html/TOPP_documentation.html).

# References

Röst, Hannes L, Timo Sachsenberg, Stephan Aiche, Chris Bielow, Hendrik Weisser, Fabian Aicheler, Sandro Andreotti, et al. 2016. “OpenMS: A Flexible Open-Source Software Platform for Mass Spectrometry Data Analysis.” *Nature Methods* 13 (9): 741–48.

Solntsev, Stefan K, Michael R Shortreed, Brian L Frey, and Lloyd M Smith. 2018. “Enhanced Global Post-Translational Modification Discovery with Metamorpheus.” *Journal of Proteome Research* 17 (5): 1844–51.

The, Matthew, Michael J MacCoss, William S Noble, and Lukas Käll. 2016. “Fast and Accurate Protein False Discovery Rates on Large-Scale Proteomics Data Sets with Percolator 3.0.” *Journal of the American Society for Mass Spectrometry* 27: 1719–27.