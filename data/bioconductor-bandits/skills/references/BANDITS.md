# BANDITS: Bayesian ANalysis of DIfferenTial Splicing

Simone Tiberi1\*

1Department of Statistical Sciences, University of Bologna, Italy

\*simone.tiberi@unibo.it

#### 10/29/2025

#### Package

BANDITS 1.26.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Bioconductor installation](#bioconductor-installation)
  + [1.2 Devel installation from github](#devel-installation-from-github)
* [2 Aligning reads](#aligning-reads)
* [3 Gene-transcript matching](#gene-transcript-matching)
* [4 DTU pipeline](#dtu-pipeline)
  + [4.1 Preliminary information](#preliminary-information)
  + [4.2 Optional (recommended): transcript pre-filtering](#optional-recommended-transcript-pre-filtering)
  + [4.3 Load the data](#load-the-data)
    - [4.3.1 salmon input](#salmon-input)
    - [4.3.2 kallisto input](#kallisto-input)
  + [4.4 Optional (recommended): infer an informative prior for the precision parameter](#optional-recommended-infer-an-informative-prior-for-the-precision-parameter)
  + [4.5 Test for DTU](#test-for-dtu)
    - [4.5.1 Results in detail](#results-in-detail)
* [5 Inference with 3 or more groups](#inference-with-3-or-more-groups)
* [6 Inference with 1 group only](#inference-with-1-group-only)
* [7 Session info](#session-info)
* [References](#references)

---

# 1 Introduction

*BANDITS* is a Bayesian hierarchical method to perform differential splicing via differential transcript usage (DTU).
*BANDITS* uses a hierarchical structure, via a Dirichlet-multinomial model, to explicitly model the over-dispersion between replicates and allowing for sample-specific transcript relative abundance (i.e., the proportions).
More mathematically, consider a gene with K transcripts with transcript level counts \(Y = (Y\_1, \ldots, Y\_K)\); we assume that \(Y \sim DM(\pi\_1, \ldots,\pi\_K, \delta)\), where
\(DM\) denotes the Dirichlet-multinomial distribution,
\(\pi\_1, \ldots,\pi\_K\) indicate the relative abundance of transcripts \(1, \ldots, K\),
and \(\delta\) represents the precision parameter, modelling the degree of over-dispersion between samples.

We input the equivalence classes and respective counts, where the equivalence classes represent the group of transcripts reads are compatible with.
The method is embedded in a Bayesian hierarchical framework, where the posterior densities of the parameters are inferred via Markov chain Monte Carlo (MCMC) techniques.
The allocation of each RNA-seq read to its transcript of origin is treated as a latent variable and also sampled in the MCMC.
To test for DTU, we compare the average transcript relative abundance between two or more conditions.
A statistical test is performed, both, at the gene- and transcript-level, allowing scientists to investigate what specific transcripts are differentially used in significant genes.

To access the R code used in the vignettes, type:

```
browseVignettes("BANDITS")
```

Questions relative to *BANDITS* should be reported as a new issue at *[BugReports](https://github.com/SimoneTiberi/BANDITS/issues)*.

To cite BANDITS, type:

```
citation("BANDITS")
```

```
## To cite BANDITS in publications use:
##
##   Simone Tiberi and Mark D. Robinson (2020). BANDITS: Bayesian
##   differential splicing accounting for sample-to-sample variability and
##   mapping uncertainty. Genome Biology, 21 (69). URL
##   https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-01967-8
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {BANDITS: Bayesian differential splicing accounting for sample-to-sample variability and mapping uncertainty},
##     author = {Simone Tiberi and Mark D. Robinson},
##     eprint = {https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-01967-8},
##     journal = {Genome Biology},
##     volume = {21},
##     number = {69},
##     year = {2020},
##     doi = {10.1186/s13059-020-01967-8},
##     url = {https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-01967-8},
##     publisher = {Springer},
##   }
```

## 1.1 Bioconductor installation

`BANDITS` is available on [Bioconductor](https://bioconductor.org/packages/BANDITS) and can be installed with the command:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("BANDITS")
```

## 1.2 Devel installation from github

To install the latest development version of the package from github, use `devtools` (available [here](https://github.com/hadley/devtools)):

```
devtools::install_github("SimoneTiberi/BANDITS")
```

To install the package jointly with its vignette remove `--no-build-vignettes` from `build_opts`:

```
devtools::install_github("SimoneTiberi/BANDITS",
                         build_opts = c("--no-resave-data", "--no-manual"))
```

# 2 Aligning reads

The package inputs the equivalence classes and respective counts.
These can be obtained by aligning reads either directly to a reference transcriptome with pseudo-alignmers, via *salmon* (Patro et al. [2017](#ref-salmon)) or *kallisto* (Bray et al. [2016](#ref-kallisto)), or to a reference genome with splice-aware genome alignment algorithms, via *STAR* (Dobin et al. [2013](#ref-STAR)), and checking the transcripts compatible with each genome alignment with *salmon*.

NOTE: when using *salmon*, use the option `--dumpEq` to obtain the equivalence classes, when using *STAR*, use the option `--quantMode TranscriptomeSAM` to obtain alignments translated into transcript coordinates, and when using *kallisto*, run `kallisto quant`, to obtain the transcript estimated counts, and `kallisto bus` and `bustools text` to get the equivalence classes.

The file [README](https://github.com/SimoneTiberi/BANDITS/blob/master/README.md) provides three pipelines for aligning reads with *salmon*, *kallisto* and *STAR*.

# 3 Gene-transcript matching

Further to the equivalence classes, our tool requires the matching between gene and transcript ids, compatible with the genome or transcriptome used to align reads.
There are multiple ways to compute a gene-transcript compatibility matrix; below we show two examples to create it, accoriding to whether reads are aligned with a genome and transcriptome aligner.
Bear in mind that the example code below will not work on any given gtf and fasta file and adjustments might be needed; alternative approaches to compute gene-transcript matchings are illustrated in *tximport* (Soneson, Love, and Robinson [2015](#ref-tximport)) vignette.

If the reads are aligned to the genome first (with *STAR*), we can compute a gene-transcript association from the gtf file via *GenomicFeatures* (Lawrence et al. [2013](#ref-GenomicFeatures)) library.
Here we provide an example code:

```
suppressMessages(library(GenomicFeatures))
gtf_file = system.file("extdata","GTF_files","Aedes_aegypti.partial.gtf",
                       package="GenomicFeatures")
tx = makeTxDbFromGFF(gtf_file)
ss = unlist(transcriptsBy(tx, by="gene"))
gene_tr_id_gtf = data.frame(gene_id = names(ss), transcript_id = ss$tx_name )
# remove eventual NA's:
gene_tr_id_gtf = gene_tr_id_gtf[ rowSums( is.na(gene_tr_id_gtf)) == 0, ]
# remove eventual duplicated rows:
gene_tr_id_gtf = unique(gene_tr_id_gtf)
```

If the reads are aligned directly to the transcriptome (with *salmon* or *kallisto*), we compute a gene-transcript association from the cDNA fasta file via *Biostrings* (Pagès et al. [2019](#ref-Biostrings)) library.
Here we provide an example code:

```
suppressMessages(library(Biostrings))
data_dir = system.file("extdata", package = "BANDITS")
fasta = readDNAStringSet(file.path(data_dir, "Homo_sapiens.GRCh38.cdna.all.1.1.10M.fa.gz"))
ss = strsplit(names(fasta), " ")
gene_tr_id_fasta = data.frame(gene_id = gsub("gene:", "", sapply(ss, .subset, 4)),
                              transcript_id = sapply(ss, .subset, 1))
# remove eventual NA's
gene_tr_id_fasta = gene_tr_id_fasta[ rowSums( is.na(gene_tr_id_fasta)) == 0, ]
# remove eventual duplicated rows:
gene_tr_id_fasta = unique(gene_tr_id_fasta)
```

# 4 DTU pipeline

Load *BANDITS*

```
library(BANDITS)
```

## 4.1 Preliminary information

Specify the directory of the data (internal in the package).

```
data_dir = system.file("extdata", package = "BANDITS")
```

We need a matrix or data.frame containing the matching between gene and transcript identifiers.
The file “alignment and gene-transcript matching.txt” shows how to create such a file from a gtf (in case of genome alignment) or from a fasta file (in case of transcript alignment).

Load the precomputed gene-transcript matching.
`gene_tr_id` is a data.frame (but a matrix is also accepted) containing the transcripts ids on the second column and the corresponding gene ids on the first column.

```
data("gene_tr_id", package = "BANDITS")
head(gene_tr_id)
```

```
##            gene_id   transcript_id
## 2  ENSG00000223972 ENST00000456328
## 6  ENSG00000223972 ENST00000450305
## 14 ENSG00000227232 ENST00000488147
## 27 ENSG00000278267 ENST00000619216
## 30 ENSG00000243485 ENST00000473358
## 34 ENSG00000243485 ENST00000469289
```

Specify the directory of the transcript level estimated counts.

```
sample_names = paste0("sample", seq_len(4))
quant_files = file.path(data_dir, "STAR-salmon", sample_names, "quant.sf")
file.exists(quant_files)
```

```
## [1] TRUE TRUE TRUE TRUE
```

Load the transcript level estimated counts via tximport.

```
library(tximport)
txi = tximport(files = quant_files, type = "salmon", txOut = TRUE)
```

```
## reading in files with read_tsv
```

```
## 1 2 3 4
```

```
counts = txi$counts
head(counts)
```

```
##                     [,1]     [,2]     [,3]     [,4]
## ENST00000456328  5.00000  2.00000  8.00000  2.00000
## ENST00000450305  0.00000  0.00000  0.00000  0.00000
## ENST00000488147 47.39685 43.09507 65.84316 31.40446
## ENST00000619216  0.00000  0.00000  0.00000  0.00000
## ENST00000473358  1.00000  1.00000  1.00000  1.00000
## ENST00000469289  0.00000  0.00000  1.00000  0.00000
```

We define the design of the study: in our case we have 2 groups, that we call “A” and “B” of 2 samples each.

```
samples_design = data.frame(sample_id = sample_names,
                            group = c("A", "A", "B", "B"))
samples_design
```

```
##   sample_id group
## 1   sample1     A
## 2   sample2     A
## 3   sample3     B
## 4   sample4     B
```

The groups are defined in:

```
levels(samples_design$group)
```

```
## NULL
```

Here we consider a two-group comparison, however *BANDITS* also allows to compare more than 2 groups.

Before loading the data, we also compute, via `eff_len_compute`, the median effective length of each transcript (the median is computed with respect to the samples).

```
eff_len = eff_len_compute(x_eff_len = txi$length)
head(eff_len)
```

```
## ENST00000456328 ENST00000450305 ENST00000488147 ENST00000619216 ENST00000473358
##       1503.1350        478.2580       1197.1350          3.0210        558.2165
## ENST00000469289
##        381.3605
```

## 4.2 Optional (recommended): transcript pre-filtering

Pre-filtering lowly abundant transcripts was found to improve performance of differential splicing methods; furthermore, by simplifying the inferential problem, it also leads to a significant reduction in the computational cost of our method.
Albeit not strictly required, we highly suggest to pre-filter transcripts.
Here, we use a mild filtering cutoff by remove transcripts whose average relative abundance is below 0.01.
For the filtering step, we use transcript-level estimated counts to compute the average relative abundance.

Compute the transcripts to keep, by filtering lowly abundant transcripts.
Here `min_transcript_proportion = 0.01` will remove transctipts with estimated mean relative abundance below 0.01.
We further impose constraints on the total abundance: `min_transcript_counts = 10` indicates that each transcript must have at least 10 estimated counts (adding counts from all samples), and `min_gene_counts = 20` specifies that each gene should have at least 20 estimated counts (adding counts from all samples).
While running, `filter_transcripts` prints on screen the percentage of transcripts kept after filtering.

```
transcripts_to_keep = filter_transcripts(gene_to_transcript = gene_tr_id,
                                         transcript_counts = counts,
                                         min_transcript_proportion = 0.01,
                                         min_transcript_counts = 10,
                                         min_gene_counts = 20)
```

```
## After filtering, 12.24% of transcripts are kept
```

```
head(transcripts_to_keep)
```

```
## [1] "ENST00000377577" "ENST00000358779" "ENST00000341426" "ENST00000341991"
## [5] "ENST00000377403" "ENST00000054666"
```

## 4.3 Load the data

Below we illustrate how to load the equivalence classes computed with `salmon` or `kallisto`.

### 4.3.1 salmon input

We specify the path to the equivalence classes computed by `salmon` in `equiv_classes_files`.

```
equiv_classes_files = file.path(data_dir, "STAR-salmon", sample_names,
                                "aux_info", "eq_classes.txt")
file.exists(equiv_classes_files)
```

```
## [1] TRUE TRUE TRUE TRUE
```

Warning: the sample names in `equiv_classes_files` must have the same order as those in the design object, containted in `samples_design`.

```
equiv_classes_files
```

```
## [1] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/STAR-salmon/sample1/aux_info/eq_classes.txt"
## [2] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/STAR-salmon/sample2/aux_info/eq_classes.txt"
## [3] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/STAR-salmon/sample3/aux_info/eq_classes.txt"
## [4] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/STAR-salmon/sample4/aux_info/eq_classes.txt"
```

```
samples_design$sample_id
```

```
## [1] "sample1" "sample2" "sample3" "sample4"
```

We then import the equivalence classes and respective counts, and create a `BANDITS_data` object via `create_data`.
When providing `transcripts_to_keep`, the function filters internally transcripts that are not in the vector.
When filtering transripts, we suggest to parallelize computations and use one core per sample (i.e., `n_cores = length(path_to_eq_classes)`).
Since at least 2 transcripts are necessary to study differential splicing, genes with a single transcript are not analyzed.

In our example data, reads were aligned to the genome with *STAR*, and *salmon* was then used to compute the equivalence classes (and quantify transcript abundance) on the aligned reads; therefore we set `salmon_or_kallisto = "salmon"`.

```
input_data = create_data(salmon_or_kallisto = "salmon",
                         gene_to_transcript = gene_tr_id,
                         salmon_path_to_eq_classes = equiv_classes_files,
                         eff_len = eff_len,
                         n_cores = 2,
                         transcripts_to_keep = transcripts_to_keep)
```

```
## Data has been loaded
```

```
## Max  11  transcripts per group
```

```
## Max  5  genes per group
```

If transcripts pre-filtering is not wanted, do not specify `transcripts_to_keep` parameter.

After loading the data, with `filter_genes(data, min_counts_per_gene = 20)`, we remove genes with less than 20 counts overall (i.e., considering all equivalence classes across all samples).

```
input_data = filter_genes(input_data, min_counts_per_gene = 20)
```

```
## Initial number of genes: 40; number of selected genes: 40
```

### 4.3.2 kallisto input

When reads have been aligned with `kallisto`, we proceed in a very similar way as above.

We specify the path to the equivalence classes (`kallisto_equiv_classes`) and respective counts (`kallisto_equiv_counts`) computed by `kallisto`.

```
kallisto_equiv_classes = file.path(data_dir, "kallisto", sample_names, "pseudoalignments.ec")
kallisto_equiv_counts  = file.path(data_dir, "kallisto", sample_names, "pseudoalignments.tsv")
file.exists(kallisto_equiv_classes); file.exists(kallisto_equiv_counts)
```

```
## [1] TRUE TRUE TRUE TRUE
```

```
## [1] TRUE TRUE TRUE TRUE
```

Note that, with the new version of `kallisto bustools`, the `.ec` and `.tsv` files are named `matrix.ec` and `bus.tsv`.

Warning: as above, the sample names in `kallisto_equiv_classes` and `kallisto_equiv_classes` must have the same order as those in the design object, containted in `samples_design`.

```
kallisto_equiv_classes; kallisto_equiv_counts
```

```
## [1] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample1/pseudoalignments.ec"
## [2] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample2/pseudoalignments.ec"
## [3] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample3/pseudoalignments.ec"
## [4] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample4/pseudoalignments.ec"
```

```
## [1] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample1/pseudoalignments.tsv"
## [2] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample2/pseudoalignments.tsv"
## [3] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample3/pseudoalignments.tsv"
## [4] "/tmp/RtmpWZZVpE/Rinst3429432f2c8b4f/BANDITS/extdata/kallisto/sample4/pseudoalignments.tsv"
```

```
samples_design$sample_id
```

```
## [1] "sample1" "sample2" "sample3" "sample4"
```

As above, we import the equivalence classes and respective counts, and create a `BANDITS_data` object via `create_data`.

```
input_data_2 = create_data(salmon_or_kallisto = "kallisto",
                           gene_to_transcript = gene_tr_id,
                           kallisto_equiv_classes = kallisto_equiv_classes,
                           kallisto_equiv_counts = kallisto_equiv_counts,
                           kallisto_counts = counts,
                           eff_len = eff_len, n_cores = 2,
                           transcripts_to_keep = transcripts_to_keep)
```

```
## Data has been loaded
```

```
## Max  69  transcripts per group
```

```
## Max  29  genes per group
```

```
input_data_2
```

```
## A 'BANDITS_data' object with 4 samples and 40 genes.
```

If transcripts pre-filtering is not wanted, do not specify `transcripts_to_keep` parameter.

After loading the data, with `filter_genes(data, min_counts_per_gene = 20)`, we remove genes with less than 20 counts overall (i.e., considering all equivalence classes across all samples).

```
input_data_2 = filter_genes(input_data_2, min_counts_per_gene = 20)
```

```
## Initial number of genes: 40; number of selected genes: 40
```

## 4.4 Optional (recommended): infer an informative prior for the precision parameter

In this Section we illustrate how to formulate an informative prior for the precision parameter
(i.e., the Dirichlet-Multinomial parameter modelling the degree of over-dispersion between samples).
Note that this is an optional, yet highly recommended, step.

The `prior_precision` function builds on top of *DRIMSeq*’s (Nowicka and Robinson [2016](#ref-DRIMSeq)) `DRIMSeq::dmPrecision` function which provides genewise estimates of the precision parameter.
Use the same filtering criteria as in `create_data`, by choosing the same argument for `transcripts_to_keep`.
If transcript pre-filtering is not performed, leave `transcripts_to_keep` unspecified.

```
set.seed(61217)
precision = prior_precision(gene_to_transcript = gene_tr_id,
                            transcript_counts = counts, n_cores = 2,
                            transcripts_to_keep = transcripts_to_keep)
```

```
## Estimating gene-wise precision parameters
```

```
## Estimation completed
```

The first element of the result contains the mean and standard deviation of the log-precision estimates.

```
precision$prior
```

```
## [1] 3.658696 3.622948
```

Plot the histogram of the genewise log-precision estimates.
The black solid line represents the normally distributed prior distribution for the log-precision parameter.

```
plot_precision(precision)
```

![](data:image/png;base64...)

## 4.5 Test for DTU

With `test_DTU`, we jointly run the MCMC algorithm, to infer the posterior distributions of the parameters, and test for DTU.
`mean_log_delta` and `sd_log_delta` represent the mean and standard deviation of the informative prior for the log-precision parameter, if available.
If an informative prior was not computed, leave `mean_log_delta` and `sd_log_delta` fields unspecified.

`R` and `burn_in` represent the length of the MCMC chain (excluding the burn-in) and the length of the burn-in (i.e., the initial portion of the chain which is discarded).
For genes that are analyzed together (because one or more reads are compatible with multiple genes), `R` and `burn_in` are doubled to face the increased complexity of the inferential problem.
The method requires at least `R = 10^4` and `burn_in = 2*10^3`.
Albeit no difference was observed in simulation studies when increasing these numbers, we encourage users to possibly use higher values (e.g., double) if the computational time allows it.

A convergence diagnostic is used to test if the posterior chains are stationary and to determine if a further fraction of the chain should be discarded as burn-in.
If convergence is not reached, the chain is discarded and a second chain is run; if convergence is again not reached, a third chain is run: if three consecutive chains fail to converge, the respective gene is not tested for DTU.

It is highly suggested to speed up computations by parallelizing the method and specifying the number of parallel threads via the `n_cores` parameter.
Before running the MCMC, we set the seed for the random number generation in R.

For genes with a p.value below 0.1, `test_DTU` runs a second independent MCMC chain, merges it with the first one and tests again for DTU based on the aggregated chain.

The method can technically be run with a single observation per group, however 2 in each group should be regarded as the very minimum sample size.

We run the DTU method.
`group_col_name` indicates the name of the column of `samples_design` containing the group id of each sample (by default `group_col_name = "group"`).

```
set.seed(61217)
results = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, n_cores = 2,
                   gene_to_transcript = gene_tr_id)
```

```
## Starting the MCMC
```

```
## MCMC completed
```

```
## Returning results
```

The output of `test_DTU` is a `BANDITS_test` object; results are stored in 3 `data.frame` objects containing gene level results, transcript level results and convergence output.
All results are sorted, by default, according to the significance of the gene level test.

To read a full description of the output from `test_DTU`, see `help(BANDITS_test)`.

```
results
```

```
## A 'BANDITS_test' object, with 36 gene and 114 transcript level results.
```

Functions `top_genes`, `top_transcripts` and `convergence` can be used to access gene level results, transcript level results and convergence output, respectively.

Visualize the most significant Genes, sorted by gene level significance.

```
head(top_genes(results))
```

```
##           Gene_id     p.values adj.p.values p.values_inverted
## 1 ENSG00000162585 9.132076e-05  0.003287547      9.132076e-05
## 2 ENSG00000197530 1.491652e-02  0.225596113      1.491652e-02
## 3 ENSG00000162576 1.879968e-02  0.225596113      1.879968e-02
## 4 ENSG00000221978 7.392109e-02  0.665289799      7.392109e-02
## 5 ENSG00000160087 9.415837e-02  0.677940254      9.415837e-02
## 6 ENSG00000008130 1.364419e-01  0.763873326      1.364419e-01
##   adj.p.values_inverted DTU_measure Mean log-prec A Mean log-prec B
## 1           0.003287547   1.3291221        3.864902        5.115116
## 2           0.225596113   0.6243606        3.450269        5.575319
## 3           0.225596113   0.3239252        6.423918        6.619155
## 4           0.665289799   0.2343388        6.008342        5.457248
## 5           0.677940254   0.7565747        4.332407        3.276718
## 6           0.763873326   0.7482182        4.455511        3.510488
##   SD log-prec A SD log-prec B
## 1     1.4022517     2.2936126
## 2     1.0497853     1.9110451
## 3     1.3727094     1.5984266
## 4     0.8940015     0.9458887
## 5     1.6222813     1.4648085
## 6     3.2135855     2.0631852
```

Alternatively, gene-level results can also be sorted according to “DTU\_measure”, which is a measure of the strength of the change between average relative abundances of the two groups.

```
head(top_genes(results, sort_by = "DTU_measure"))
```

```
##           Gene_id     p.values adj.p.values p.values_inverted
## 1 ENSG00000162585 9.132076e-05  0.003287547      9.132076e-05
## 7 ENSG00000224870 1.523895e-01  0.763873326      1.523895e-01
## 5 ENSG00000160087 9.415837e-02  0.677940254      9.415837e-02
## 6 ENSG00000008130 1.364419e-01  0.763873326      1.364419e-01
## 9 ENSG00000157870 2.172148e-01  0.787589869      2.172148e-01
## 2 ENSG00000197530 1.491652e-02  0.225596113      1.491652e-02
##   adj.p.values_inverted DTU_measure Mean log-prec A Mean log-prec B
## 1           0.003287547   1.3291221        3.864902        5.115116
## 7           0.763873326   0.8338453        4.830025        3.853537
## 5           0.677940254   0.7565747        4.332407        3.276718
## 6           0.763873326   0.7482182        4.455511        3.510488
## 9           0.787589869   0.6929428        4.549368        4.433119
## 2           0.225596113   0.6243606        3.450269        5.575319
##   SD log-prec A SD log-prec B
## 1      1.402252      2.293613
## 7      2.715598      3.100057
## 5      1.622281      1.464809
## 6      3.213585      2.063185
## 9      2.534583      2.443005
## 2      1.049785      1.911045
```

Visualize the most significant transcripts, sorted by transcript level significance.

```
head(top_transcripts(results, sort_by = "transcript"))
```

```
##            Gene_id   Transcript_id     p.values adj.p.values Max_Gene_Tr.p.val
## 1  ENSG00000162585 ENST00000378546 3.861658e-06  0.000440229        0.72092739
## 2  ENSG00000162585 ENST00000476803 1.083969e-04  0.006178621        0.78309429
## 10 ENSG00000162576 ENST00000474033 6.126550e-03  0.232808919        0.47255983
## 11 ENSG00000162576 ENST00000309212 1.166504e-02  0.332453669        0.49623648
## 15 ENSG00000221978 ENST00000480479 1.678391e-02  0.376822431        0.07392109
## 5  ENSG00000197530 ENST00000514234 2.281786e-02  0.376822431        0.54400706
##    Max_Gene_Tr.Adj.p.val     Mean A     Mean B       SD A       SD B
## 1            0.003287547 0.72092739 0.04278565 0.12135398 0.09376301
## 2            0.006178621 0.13211392 0.78309429 0.11263834 0.14019984
## 10           0.232808919 0.30257391 0.47255983 0.03429573 0.05332130
## 11           0.332453669 0.49623648 0.34229722 0.03547474 0.04984745
## 15           0.665289799 0.07348898 0.01782466 0.01878554 0.01339365
## 5            0.376822431 0.17240518 0.54400706 0.09319581 0.13862266
```

Visualize the convergence output for the most significant genes, sorted by gene level significance.

```
head(convergence(results))
```

```
##           Gene_id converged burn_in
## 1 ENSG00000162585      TRUE     0.0
## 2 ENSG00000197530      TRUE     0.0
## 3 ENSG00000162576      TRUE     0.1
## 4 ENSG00000221978      TRUE     0.4
## 5 ENSG00000160087      TRUE     0.0
## 6 ENSG00000008130      TRUE     0.0
```

We can further use the `gene` function to gather all output for a specific gene: gene level, transcript level and convergence results.

```
top_gene = top_genes(results, n = 1)
gene(results, top_gene$Gene_id)
```

```
## $gene_results
##           Gene_id     p.values adj.p.values p.values_inverted
## 1 ENSG00000162585 9.132076e-05  0.003287547      9.132076e-05
##   adj.p.values_inverted DTU_measure Mean log-prec A Mean log-prec B
## 1           0.003287547    1.329122        3.864902        5.115116
##   SD log-prec A SD log-prec B
## 1      1.402252      2.293613
##
## $transcript_results
##           Gene_id   Transcript_id     p.values adj.p.values Max_Gene_Tr.p.val
## 1 ENSG00000162585 ENST00000378546 3.861658e-06  0.000440229         0.7209274
## 2 ENSG00000162585 ENST00000476803 1.083969e-04  0.006178621         0.7830943
## 3 ENSG00000162585 ENST00000414253 9.183543e-01  0.999945452         0.9183543
## 4 ENSG00000162585 ENST00000497675 9.773652e-01  0.999945452         0.9773652
##   Max_Gene_Tr.Adj.p.val     Mean A     Mean B       SD A       SD B
## 1           0.003287547 0.72092739 0.04278565 0.12135398 0.09376301
## 2           0.006178621 0.13211392 0.78309429 0.11263834 0.14019984
## 3           0.999945452 0.10138194 0.11783651 0.04353412 0.06672338
## 4           0.999945452 0.04557675 0.05628355 0.02149286 0.04648564
##
## $convergence_results
##           Gene_id converged burn_in
## 1 ENSG00000162585      TRUE       0
```

Similarly we can use the `transcript` function to gather all output for a specific transcript.

```
top_transcript = top_transcripts(results, n = 1)
transcript(results, top_transcript$Transcript_id)
```

```
## $transcript_results
##           Gene_id   Transcript_id     p.values adj.p.values Max_Gene_Tr.p.val
## 1 ENSG00000162585 ENST00000378546 3.861658e-06  0.000440229         0.7209274
##   Max_Gene_Tr.Adj.p.val    Mean A     Mean B     SD A       SD B
## 1           0.003287547 0.7209274 0.04278565 0.121354 0.09376301
##
## $gene_results
##           Gene_id     p.values adj.p.values p.values_inverted
## 1 ENSG00000162585 9.132076e-05  0.003287547      9.132076e-05
##   adj.p.values_inverted DTU_measure Mean log-prec A Mean log-prec B
## 1           0.003287547    1.329122        3.864902        5.115116
##   SD log-prec A SD log-prec B
## 1      1.402252      2.293613
##
## $convergence_results
##           Gene_id converged burn_in
## 1 ENSG00000162585      TRUE       0
```

Finally, we can plot the estimated average transcript relative expression in the two groups for a specific gene via `plot_proportions`.
When `CI = TRUE` (default), a solid black line is plotted on top of the histograms, indicating the profile Wald type confidence interval (CI) of each transcript relative expression; the level of the CI can be set via `CI_level` parameter (0.95 by default).
Note that the width of the CIs is a consequence of the limited ammount of available data (i.e., few counts); the boundaries are usually much smaller in real datasets.

```
plot_proportions(results, top_gene$Gene_id, CI = TRUE, CI_level = 0.95)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the BANDITS package.
##   Please report the issue at <https://github.com/SimoneTiberi/BANDITS/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the BANDITS package.
##   Please report the issue at <https://github.com/SimoneTiberi/BANDITS/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### 4.5.1 Results in detail

In this Section we aim to explain in detail the output of `test_DTU`.

In both, gene- and transcript-level tests, `p.values` and `adj.p.values` indicate the p.values and adjusted p.values, where adjusted p.values are obtained via `p.adjust`, by implementing Benjamini and Hochberg correction.

#### Gene level results

In gene level results, only for two-group comparisons, we also propose a conservative measure, `p.values_inverted`, which accounts for the inversion of the dominant transcript (i.e., the most expressed transcript).
If the dominant transcript is the same under both groups, \(p.values\\_inverted = \sqrt{p.values}\), while if the dominant transcript varies between the two groups, \(p.values\\_inverted = p.values\).
In other words, when the dominant transcript is unchanged between conditions, we take the square root of the p.value, which results in an inflated value (e.g., \(\sqrt{0.01} = 0.1\)).
This measure is based on the observation that often differential splicing leads to a change in the dominant transcript and, given similar p.values, it will rank higher genes with different dominant transcritps between conditions.

We also propose a score, `DTU_measure`, again only defined for two-group comparisons, which is intended to measure the intensity of the DTU change, similarly to fold changes in differential expression analyses.
Consider a gene with K transcripts with relative abundance \(\pi\_1^{(A)}, \ldots,\pi\_K^{(A)}\), for group \(A\), and \(\pi\_1^{(B)}, \ldots,\pi\_K^{(B)}\), for group \(B\).
`DTU_measure` is defined as the summation of the absolute difference between the two most expressed transcripts: \(\sum\_{k \in \tilde{K} } \left| \pi\_k^{(A)} - \pi\_k^{(B)} \right|\), where \(\tilde{K}\) indicates the set of two most expressed transcripts across both groups (i.e., adding \(\pi\_k^{(A)}\) and \(\pi\_k^{(B)}\)).
Note that this measure ranges between 0, when proportions are identical between groups, and 2, when an isoform is always expressed in group A and a different transcript is always chosen in group B.

Finally, `Mean log-prec group_name` and `SD log-prec group_name` indicate the posterior mean and standard deviation of \(log(\delta)\), i.e., the logarithm of the Dirichlet precision parameter in each group.
The precision parameter models the degree of over-dispersion between samples: the higher the precision parameter (or its logarithm), the lower the sample-to-sample variability.

#### Transcript level results

In transcript level results, `Max_Gene_Tr.p.val` and `Max_Gene_Tr.Adj.p.val` are two conservative transcript level measures which account for both, the gene- and transcript-level p.values: they are the maximum between the gene and transcript level p.values and adjusted p.values, respectively.
With these measures, a transcript can only be detected as significant if the corresponding gene is also significant.

Finally, `Mean group_name` and `SD group_name` indicate the posterior mean and standard deviation of each transcript mean relative abundance.

# 5 Inference with 3 or more groups

If 3 or more groups are available inference is carried out as in the case with 2 groups described above.

Here we propose re-analyze the previous data assuming a three-group structure.
The pipeline exposed above is unchanged, except for the design matrix, which now includes three groups.

```
samples_design_3_groups = data.frame(sample_id = sample_names,
                            group = c("A", "B", "B", "C"))
samples_design_3_groups
```

```
##   sample_id group
## 1   sample1     A
## 2   sample2     B
## 3   sample3     B
## 4   sample4     C
```

```
levels(samples_design_3_groups$group)
```

```
## NULL
```

Perform differential splicing:

```
set.seed(61217)
results_3_groups = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design_3_groups,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, n_cores = 2,
                   gene_to_transcript = gene_tr_id)
```

```
## Starting the MCMC
```

```
## MCMC completed
```

```
## Returning results
```

```
results_3_groups
```

```
## A 'BANDITS_test' object, with 36 gene and 114 transcript level results.
```

Below we visualize gene- and transcript-level results tables
Note that `NaN` or `NA` appear when no counts are available for a specific group of samples; in such cases, the remainig two groups of samples are compared.

```
head(top_genes(results_3_groups))
```

```
##           Gene_id     p.values adj.p.values Mean log-prec A Mean log-prec B
## 1 ENSG00000162585 3.102162e-09 1.116778e-07        5.863215        4.530507
## 2 ENSG00000197530 1.197647e-02 2.155765e-01        4.486540        4.109291
## 3 ENSG00000127054 2.277277e-02 2.732733e-01        5.410571        4.944628
## 4 ENSG00000162591 6.444559e-02 5.800103e-01        5.719586        4.369761
## 5 ENSG00000008130 1.266663e-01 9.119972e-01        4.318826        4.037817
## 6 ENSG00000162576 1.726275e-01 9.996210e-01        5.146465        5.870339
##   Mean log-prec C SD log-prec A SD log-prec B SD log-prec C
## 1        5.577595      1.849752      1.545439     2.3136707
## 2        5.744296      2.177195      1.666262     1.4797078
## 3        6.709370      1.322932      1.336821     1.0835958
## 4        3.895671      3.470601      2.583375     2.4996056
## 5        5.076597      2.730004      2.981370     2.5079506
## 6        6.750191      1.475366      1.108706     0.9372319
```

```
head(top_transcripts(results_3_groups))
```

```
##           Gene_id   Transcript_id     p.values adj.p.values Max_Gene_Tr.p.val
## 1 ENSG00000162585 ENST00000378546 3.651777e-08 4.163026e-06         0.7267715
## 2 ENSG00000162585 ENST00000476803 5.971199e-06 3.403583e-04         0.7807805
## 3 ENSG00000162585 ENST00000414253 1.444479e-01 9.970392e-01         0.1895209
## 4 ENSG00000162585 ENST00000497675 8.454711e-01 9.970392e-01         0.8454711
## 5 ENSG00000197530 ENST00000487053 2.241618e-02 5.110890e-01         0.2998206
## 6 ENSG00000197530 ENST00000514234 3.105753e-02 5.900930e-01         0.5408052
##   Max_Gene_Tr.Adj.p.val     Mean A     Mean B      Mean C       SD A       SD B
## 1          4.163026e-06 0.72677150 0.72185950 0.043756376 0.10023540 0.15802857
## 2          3.403583e-04 0.03153497 0.18966573 0.780780500 0.07301589 0.14675543
## 3          9.970392e-01 0.18952088 0.05165924 0.116029863 0.05948471 0.03833544
## 4          9.970392e-01 0.05217265 0.03681553 0.059433260 0.01908561 0.01758466
## 5          5.110890e-01 0.24743125 0.29982063 0.007190108 0.10656616 0.15745540
## 6          5.900930e-01 0.09004714 0.34861448 0.540805194 0.09533680 0.14327694
##         SD C
## 1 0.08841037
## 2 0.14335759
## 3 0.07755130
## 4 0.04865518
## 5 0.02103195
## 6 0.15765804
```

We can visualize results from specific gene or transcript.

```
gene(results_3_groups, top_genes(results_3_groups)$Gene_id[1])
```

```
## $gene_results
##           Gene_id     p.values adj.p.values Mean log-prec A Mean log-prec B
## 1 ENSG00000162585 3.102162e-09 1.116778e-07        5.863215        4.530507
##   Mean log-prec C SD log-prec A SD log-prec B SD log-prec C
## 1        5.577595      1.849752      1.545439      2.313671
##
## $transcript_results
##           Gene_id   Transcript_id     p.values adj.p.values Max_Gene_Tr.p.val
## 1 ENSG00000162585 ENST00000378546 3.651777e-08 4.163026e-06         0.7267715
## 2 ENSG00000162585 ENST00000476803 5.971199e-06 3.403583e-04         0.7807805
## 3 ENSG00000162585 ENST00000414253 1.444479e-01 9.970392e-01         0.1895209
## 4 ENSG00000162585 ENST00000497675 8.454711e-01 9.970392e-01         0.8454711
##   Max_Gene_Tr.Adj.p.val     Mean A     Mean B     Mean C       SD A       SD B
## 1          4.163026e-06 0.72677150 0.72185950 0.04375638 0.10023540 0.15802857
## 2          3.403583e-04 0.03153497 0.18966573 0.78078050 0.07301589 0.14675543
## 3          9.970392e-01 0.18952088 0.05165924 0.11602986 0.05948471 0.03833544
## 4          9.970392e-01 0.05217265 0.03681553 0.05943326 0.01908561 0.01758466
##         SD C
## 1 0.08841037
## 2 0.14335759
## 3 0.07755130
## 4 0.04865518
##
## $convergence_results
##            Gene_id converged burn_in
## 13 ENSG00000162585      TRUE       0
```

```
transcript(results_3_groups, top_transcripts(results_3_groups)$Transcript_id[1])
```

```
## $transcript_results
##           Gene_id   Transcript_id     p.values adj.p.values Max_Gene_Tr.p.val
## 1 ENSG00000162585 ENST00000378546 3.651777e-08 4.163026e-06         0.7267715
##   Max_Gene_Tr.Adj.p.val    Mean A    Mean B     Mean C      SD A      SD B
## 1          4.163026e-06 0.7267715 0.7218595 0.04375638 0.1002354 0.1580286
##         SD C
## 1 0.08841037
##
## $gene_results
##           Gene_id     p.values adj.p.values Mean log-prec A Mean log-prec B
## 1 ENSG00000162585 3.102162e-09 1.116778e-07        5.863215        4.530507
##   Mean log-prec C SD log-prec A SD log-prec B SD log-prec C
## 1        5.577595      1.849752      1.545439      2.313671
##
## $convergence_results
##            Gene_id converged burn_in
## 13 ENSG00000162585      TRUE       0
```

Finally, we can plots the estimated mean transcript relative expression of a specific gene.

```
plot_proportions(results_3_groups, top_genes(results_3_groups)$Gene_id[1], CI = TRUE, CI_level = 0.95)
```

![](data:image/png;base64...)

# 6 Inference with 1 group only

If all samples belong to the same experimental condition, differential testing between conditions cannot be performed.
Nonetheless, BANDITS can still be used to infer group-level parameters (i.e., mean relative abundance of transcripts and dispersion).

The pipeline is identical to the case exposed above: the only difference concerns the design matrix, which now includes a single group for all samples.

```
samples_design_1_group = data.frame(sample_id = sample_names,
                            group = c("A", "A", "A", "A"))
samples_design_1_group
```

```
##   sample_id group
## 1   sample1     A
## 2   sample2     A
## 3   sample3     A
## 4   sample4     A
```

```
levels(samples_design_1_group$group)
```

```
## NULL
```

Inference is again performed via `test_DTU` function (even though the differential testing itself is not implemented).

```
set.seed(61217)
results_1_group = test_DTU(BANDITS_data = input_data,
                   precision = precision$prior,
                   samples_design = samples_design_1_group,
                   group_col_name = "group",
                   R = 10^4, burn_in = 2*10^3, n_cores = 2,
                   gene_to_transcript = gene_tr_id)
```

```
## One group only is present in 'samples_design$group':
##   BANDITS will infer model parameters, but will not test for DTU between groups.
```

```
## Starting the MCMC
```

```
## MCMC completed
```

```
## Returning results
```

```
results_1_group
```

```
## A 'BANDITS_test' object, with 40 gene and 124 transcript level results.
```

Gene- and transcript-level results can be visualized as above; results are sorted by gene name.
Note that now all columns relative to DTU testing are missing (p.values, adjusted p.values, DTU\_measure, etc…).

```
head(top_genes(results_1_group))
```

```
##           Gene_id Mean log-prec A SD log-prec A
## 1 ENSG00000008130        3.886154     2.4905563
## 2 ENSG00000069424        5.219230     3.0897909
## 3 ENSG00000078369        4.161549     2.2753614
## 4 ENSG00000078808        8.093806     0.4912126
## 5 ENSG00000107404       10.980998     3.7645846
## 6 ENSG00000116198        4.331888     3.1714630
```

```
head(top_transcripts(results_1_group))
```

```
##           Gene_id   Transcript_id    Mean A       SD A
## 1 ENSG00000008130 ENST00000341991 0.6104389 0.15831450
## 2 ENSG00000008130 ENST00000341426 0.3895611 0.15831450
## 3 ENSG00000069424 ENST00000378097 0.9551271 0.07772535
## 4 ENSG00000069424 ENST00000378083 0.0448729 0.07772535
## 5 ENSG00000078369 ENST00000378609 0.8892735 0.09303573
## 6 ENSG00000078369 ENST00000610897 0.1107265 0.09303573
```

We can focus on the results of a specific gene or transcript.

```
gene(results_1_group, top_genes(results_1_group)$Gene_id[1])
```

```
## $gene_results
##           Gene_id Mean log-prec A SD log-prec A
## 1 ENSG00000008130        3.886154      2.490556
##
## $transcript_results
##           Gene_id   Transcript_id    Mean A      SD A
## 1 ENSG00000008130 ENST00000341991 0.6104389 0.1583145
## 2 ENSG00000008130 ENST00000341426 0.3895611 0.1583145
##
## $convergence_results
##           Gene_id converged burn_in
## 3 ENSG00000008130      TRUE       0
```

```
transcript(results_1_group, top_transcripts(results_1_group)$Transcript_id[1])
```

```
## $transcript_results
##           Gene_id   Transcript_id    Mean A      SD A
## 1 ENSG00000008130 ENST00000341991 0.6104389 0.1583145
##
## $gene_results
##           Gene_id Mean log-prec A SD log-prec A
## 1 ENSG00000008130        3.886154      2.490556
##
## $convergence_results
##           Gene_id converged burn_in
## 3 ENSG00000008130      TRUE       0
```

Finally, we can plots the estimated mean transcript relative expression of a specific gene.

```
plot_proportions(results_1_group, top_genes(results)$Gene_id[1], CI = TRUE, CI_level = 0.95)
```

![](data:image/png;base64...)

# 7 Session info

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
## [1] tximport_1.38.0  BANDITS_1.26.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         xfun_0.53            bslib_0.9.0
##  [4] ggplot2_4.0.0        lattice_0.22-7       tzdb_0.5.0
##  [7] vctrs_0.6.5          tools_4.5.1          generics_0.1.4
## [10] stats4_4.5.1         parallel_4.5.1       tibble_3.3.0
## [13] DRIMSeq_1.38.0       pkgconfig_2.0.3      data.table_1.17.8
## [16] RColorBrewer_1.1-3   S7_0.2.0             S4Vectors_0.48.0
## [19] rngtools_1.5.2       lifecycle_1.0.4      compiler_4.5.1
## [22] farver_2.1.2         stringr_1.5.2        tinytex_0.57
## [25] statmod_1.5.1        Seqinfo_1.0.0        codetools_0.2-20
## [28] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [31] crayon_1.5.3         pillar_1.11.1        jquerylib_0.1.4
## [34] MASS_7.3-65          BiocParallel_1.44.0  cachem_1.1.0
## [37] limma_3.66.0         magick_2.9.0         doRNG_1.8.6.2
## [40] iterators_1.0.14     foreach_1.5.2        tidyselect_1.2.1
## [43] locfit_1.5-9.12      digest_0.6.37        stringi_1.8.7
## [46] dplyr_1.1.4          reshape2_1.4.4       bookdown_0.45
## [49] labeling_0.4.3       fastmap_1.2.0        grid_4.5.1
## [52] archive_1.1.12       cli_3.6.5            magrittr_2.0.4
## [55] dichromat_2.0-0.1    withr_3.0.2          readr_2.1.5
## [58] edgeR_4.8.0          scales_1.4.0         bit64_4.6.0-1
## [61] rmarkdown_2.30       bit_4.6.0            hms_1.1.4
## [64] evaluate_1.0.5       knitr_1.50           GenomicRanges_1.62.0
## [67] IRanges_2.44.0       doParallel_1.0.17    rlang_1.1.6
## [70] Rcpp_1.1.0           glue_1.8.0           BiocManager_1.30.26
## [73] BiocGenerics_0.56.0  vroom_1.6.6          jsonlite_2.0.0
## [76] R6_2.6.1             plyr_1.8.9
```

# References

Bray, Nicolas L, Harold Pimentel, Páll Melsted, and Lior Pachter. 2016. “Near-Optimal Probabilistic Rna-Seq Quantification.” *Nature Biotechnology* 34 (5): 525.

Dobin, Alexander, Carrie A Davis, Felix Schlesinger, Jorg Drenkow, Chris Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R Gingeras. 2013. “STAR: Ultrafast Universal Rna-Seq Aligner.” *Bioinformatics* 29 (1): 15–21.

Lawrence, Michael, Wolfgang Huber, Hervé Pages, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T Morgan, and Vincent J Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Computational Biology* 9 (8): e1003118.

Nowicka, Malgorzata, and Mark D. Robinson. 2016. “DRIMSeq: A Dirichlet-Multinomial Framework for Multivariate Count Outcomes in Genomics.” *F1000Research* 5 (1356).

Pagès, H., P. Aboyoun, R. Gentleman, and S. DebRoy. 2019. *Biostrings: Efficient Manipulation of Biological Strings*.

Patro, Rob, Geet Duggal, Michael I Love, Rafael A Irizarry, and Carl Kingsford. 2017. “Salmon Provides Fast and Bias-Aware Quantification of Transcript Expression.” *Nature Methods* 14 (4): 417.

Soneson, Charlotte, Michael I. Love, and Mark D. Robinson. 2015. “Differential Analyses for Rna-Seq: Transcript-Level Estimates Improve Gene-Level Inferences.” *F1000Research* 4 (1521).