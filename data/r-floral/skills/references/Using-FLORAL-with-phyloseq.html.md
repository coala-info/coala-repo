[Skip to contents](#main)

[FLORAL](../index.html)
0.7.0

* [Reference](../reference/index.html)
* Articles
  + [Using FLORAL for Microbiome Analysis](../articles/Using-FLORAL-for-Microbiome-Analysis.html)
  + [Using FLORAL for survival models with longitudinal microbiome data](../articles/Using-FLORAL-for-survival-models-with-longitudinal-microbiome-data.html)
  + [Using FLORAL with phyloseq data](../articles/Using-FLORAL-with-phyloseq.html)
* [Changelog](../news/index.html)

![](../logo.png)

# Using FLORAL with phyloseq data

Source: [`vignettes/Using-FLORAL-with-phyloseq.Rmd`](https://github.com/vdblab/FLORAL/blob/master/vignettes/Using-FLORAL-with-phyloseq.Rmd)

`Using-FLORAL-with-phyloseq.Rmd`

[Phyloseq](http://joey711.github.io/phyloseq/) is a
popular package for working with microbiome data. Here we show how to
use the `phy_to_floral_data` helper function to convert
phyloseq data into a format accepted by FLORAL.

The following code downloads data described in [this paper](https://www.nature.com/articles/s41597-021-00860-8)
and turns it into a phyloseq object. The tax\_glom step here takes some
time, and can be replaced with [`speedyseq::tax_glom`](https://github.com/mikemc/speedyseq)
for better performace.

```
samples <- get0("samples", envir = asNamespace("FLORAL"))
counts <- get0("counts", envir = asNamespace("FLORAL"))
taxonomy <- get0("taxonomy", envir = asNamespace("FLORAL"))

phy <- phyloseq(
  sample_data(samples %>% column_to_rownames("SampleID")),
  tax_table(taxonomy %>% select(ASV, Kingdom:Genus) %>% column_to_rownames("ASV") %>% as.matrix()),
  otu_table(counts  %>% pivot_wider(names_from = "SampleID", values_from = "Count", values_fill = 0) %>% column_to_rownames("ASV") %>% as.matrix(), taxa_are_rows = TRUE)
) %>%  subset_samples(DayRelativeToNearestHCT > -30 & DayRelativeToNearestHCT < 0) %>%
  tax_glom("Genus")
```

Next, we convert that phyloseq object into a list of results to be
used by FLORAL; we have to specify the main outcome of interest as
`y`, and any metadata columns (from
`sample_data(phy)`) to use as covariates. Note that the
analysis described here is just an example for using the function;
this

```
dat <- FLORAL::phy_to_floral_data(phy, covariates=c("Consistency"), y = "DayRelativeToNearestHCT")
```

The resulting list has named entities for the main arguments to
FLORAL:

```
res <- FLORAL::FLORAL(y = dat$y, x = dat$xcount, ncov = dat$ncov, family = "gaussian", ncv=NULL, progress=FALSE)
```

Developed by Teng Fei, Tyler Funnell, Nicholas Waters, Sandeep Raj.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.