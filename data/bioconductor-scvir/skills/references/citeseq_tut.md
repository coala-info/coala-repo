# scvi-tools CITE-seq tutorial in R, using serialized tutorial components

Follows scvi-tools doc, Gayoso, Steier et al. DOI 10.1038/s41592-020-01050-x

#### October 30, 2025

# Contents

* [1 A CITE-seq example](#a-cite-seq-example)
  + [1.1 Retrieval of PBMC data](#retrieval-of-pbmc-data)
  + [1.2 Retrieval of fitted VAE](#retrieval-of-fitted-vae)
  + [1.3 Trace of (negative) ELBO values](#trace-of-negative-elbo-values)
  + [1.4 Normalized quantities](#normalized-quantities)
  + [1.5 UMAP projection of Leiden clustering in the totalVI latent space](#umap-projection-of-leiden-clustering-in-the-totalvi-latent-space)
  + [1.6 Protein abundances in projected clusters](#protein-abundances-in-projected-clusters)
* [2 Conclusions](#conclusions)
* [3 Appendix: The VAE module](#appendix-the-vae-module)
* [4 Session information](#session-information)

# 1 A CITE-seq example

THIS VIGNETTE IS SUPERSEDED BY new\_citeseq.Rmd. All chunks
in this vignette have eval=FALSE.

The purpose of this vignette is to illustrate the feasibility of reflecting
the material in the [online tutorial](https://colab.research.google.com/github/scverse/scvi-tutorials/blob/0.20.0/totalVI.ipynb) for scvi-tools 0.20.0 in Bioconductor.
The authors of the tutorial describe it as producing

> a joint latent representation of cells, denoised data for both protein and RNA

Additional tasks include

> integrat[ing] datasets, and comput[ing] differential expression of RNA and protein

The integration concerns the simultaneous analysis of two datasets
from 10x genomcs.

In this vignette we carry out the bulk of the tutorial activities using
R and Bioconductor, reaching to scvi-tools python code via basilisk.

## 1.1 Retrieval of PBMC data

The following chunk will
acquire (and cache, using BiocFileCache) a preprocessed version of the 10k and 5k combined
CITE-seq experiments from the scvi-tools data repository.

```
library(scviR)
library(ggplot2)
library(reshape2)
adref = getCiteseq5k10kPbmcs()
adref
```

## 1.2 Retrieval of fitted VAE

The totalVI variational autoencoder was fit
with these data. A fitted version is retrieved and cached
using

```
vae = getCiteseqTutvae()
```

This is an instance of an S3 class, `python.builtin.object`,
defined in the reticulate package.

```
class(vae)
```

Some fields of interest that are directly
available from the instance include an
indicator of the trained state, the general parameters
used to train, and the “anndata” (annotated data) object
that includes the input counts and various results of preprocessing:

```
vae$is_trained
cat(vae$`_model_summary_string`)
vae$adata
```

The structure of the VAE is reported using

```
vae$module
```

This is quite voluminous and is provided in an appendix.

## 1.3 Trace of (negative) ELBO values

The negative “evidence lower bound” (ELBO) is a criterion that is minimized
in order to produce a fitted autoencoder. The scvi-tools
totalVAE elgorithm creates a nonlinear projection of the inputs
to a 20-dimensional latent space, and a decoder that transforms
object positions in the latent space to positions in the
space of observations that are close to the original input positions.

The negative ELBO values are computed for samples from
the training data and
for “left out” validation samples. Details on the validation
assessment would seem to be part of pytorch lightning. More
investigation of scvi-tools code and doc are in order.

```
h = vae$history
npts = nrow(h$elbo_train)
plot(seq_len(npts), as.numeric(h$elbo_train[[1]]), ylim=c(1200,1400),
  type="l", col="blue", main="Negative ELBO over training epochs",
  ylab="neg. ELBO", xlab="epoch")
graphics::legend(300, 1360, lty=1, col=c("blue", "orange"), legend=c("training", "validation"))
graphics::lines(seq_len(npts), as.numeric(h$elbo_validation[[1]]), type="l", col="orange")
```

## 1.4 Normalized quantities

On a CPU, the following can take a long time.

```
NE = vae$get_normalized_expression(n_samples=25L,
    return_mean=TRUE,
    transform_batch=c("PBMC10k", "PBMC5k")
)
```

We provide the totalVI-based denoised quantities in

```
denoised = getTotalVINormalized5k10k()
vapply(denoised, dim, integer(2))
```

Note that these have features as columns, samples (cells)
as rows.

```
utils::head(colnames(denoised$rna_nmlzd))
utils::head(colnames(denoised$prot_nmlzd))
```

## 1.5 UMAP projection of Leiden clustering in the totalVI latent space

We have stored a fully loaded anndata instance for retrieval
to inspect the latent space and clustering produced
by the tutorial notebook procedure. The images produced here
do not agree exactly with what I see in the colab pages for
0.20.0. The process was run in Jetstream2, not in colab.

```
full = getTotalVI5k10kAdata()
# class distribution
cllabs = full$obs$leiden_totalVI
blabs = full$obs$batch
table(cllabs)
um = full$obsm$get("X_umap")
dd = data.frame(umap1=um[,1], umap2=um[,2], clust=factor(cllabs), batch=blabs)
ggplot(dd, aes(x=umap1, y=umap2, colour=clust)) + geom_point(size=.05) +
   guides(color = guide_legend(override.aes = list(size = 4)))
```

Effectiveness at accommodating the two-batch design is suggested by the
mixed representation of the batches in all the Leiden clusters.

```
ggplot(dd, aes(x=umap1, y=umap2, colour=factor(batch))) + geom_point(size=.05)
```

## 1.6 Protein abundances in projected clusters

We focus on four of the ADT. Points (cells) in the UMAP projection
given above are colored by the estimated abundance of
the proteins quantified via (normalized) ADT abundance. Complementary
expression of CD4 and CD8a is suggested by the configurations in
the middle two panels.

```
pro4 = denoised$prot_nmlzd[,1:4]
names(pro4) = gsub("_.*", "", names(pro4))
wprot = cbind(dd, pro4)
mm = melt(wprot, id.vars=c("clust", "batch", "umap1", "umap2"))
utils::head(mm,3)
ggplot(mm, aes(x=umap1, y=umap2, colour=log1p(value))) +
   geom_point(size=.1) + facet_grid(.~variable)
```

# 2 Conclusions

We have shown that all the results of the totalVI application
in the tutorial are readily accessible with utilities in scviR.
Additional work on details of differential expression are present
in the tutorial and can be explored by the interested reader/user.

# 3 Appendix: The VAE module

The structure of the VAE is reported using

```
vae$module
```

# 4 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88803)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /media/volume/biocgpu2/biocbuild/bbs-3.22-bioc-gpu/R/lib/libRblas.so
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
## [1] BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```