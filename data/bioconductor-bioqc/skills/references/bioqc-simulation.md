# BioQC-benchmark: Testing Efficiency, Sensitivity and Specificity of BioQC on simulated and real-world data

#### 2025-10-29

Supplementary Information for “Detect issue heterogenity in gene expression data with [*BioQC*](https://github.com/Accio/BioQC)” (Jitao David Zhang, Klas Hatje, Gregor Sturm, Clemens Broger, Martin Ebeling, Martine Burtin, Fabiola Terzi, Silvia Ines Pomposiello and Laura Badi)

In this vignette, we perform simulations with both model-generated and real-world data using *BioQC*. We show that *BioQC* is a sensitive method to detect tissue heterogeneity from high-throughput gene expression data. The source code used to produce this document can be found in the github repository [BioQC-example](https://github.com/Accio/BioQC-example).

*BioQC* is a R/Bioconductor package to detect tissue heterogeneity from high-throughput gene expression profiling data. It implements an efficient Wilcoxon-Mann-Whitney test, and offers tissue-specific gene signatures that are ready to use ‘out of the box’.

## Experiment setup

In this document, we perform two simulation studies with *BioQC*:

* **Sensitivity benchmark** tests the sensitivity and specificity of *BioQC* detecting tissue heterogeneity using model-generated, simulated data;
* **Mixing benchmark** tests the sensitivity and specificity of *BioQC* using simulated contamination with real-world data.

All source code that is needed to reproduce the results can be found in the `.Rmd` file generating this document.

```
library(BioQC)
library(hgu133plus2.db) ## to simulate an microarray expression dataset
library(lattice)
library(latticeExtra)
library(gridExtra)
library(gplots)

pdf.options(family="ArialMT", useDingbats=FALSE)

set.seed(1887)

## list human genes
humanGenes <- unique(na.omit(unlist(as.list(hgu133plus2SYMBOL))))

## read tissue-specific gene signatures
gmtFile <- system.file("extdata/exp.tissuemark.affy.roche.symbols.gmt",
                       package="BioQC")
gmt <- readGmt(gmtFile)
tissueInds <- sapply(gmt, function(x) match(x$genes, humanGenes))
```

## Sensitivity Benchmark

We next asked the question how sensitive *BioQC* is to expression changes of tissue signature genes. Similar to the previous simulation, we create random expression matrices. While keeping all other genes \(i.i.d\) normally distributed following \(\mathcal{N}(0,1)\), we dedicatedly increase the expression of genes in one randomly selected tissue signature (ovary, with 43 genes) by different amplitudes: these genes’ expression levels are randomly drawn from different normal distributions with varying expectation and constant variance between \(\mathcal{N}(0,1)\) and \(\mathcal{N}(3,1)\). To test the robustness of the algorithm, 10 samples are generated for each mean expression difference value.

![**Figure 1:** Sensitivity benchmark. Expression levels of genes in the ovary signature are dedicately sampled randomly from normal distributions with different mean values. Left panel: enrichment scores reported by *BioQC* for the ovary signature, plotted against the differences in mean expression values; Right panel: rank of ovary enrichment scores in all 155 signatures plotted against the difference in mean expression values.](bioqc-simulation_files/figure-html/sensitivity_benchmark_fig-1.png)

**Figure 1:** Sensitivity benchmark. Expression levels of genes in the ovary signature are dedicately sampled randomly from normal distributions with different mean values. Left panel: enrichment scores reported by *BioQC* for the ovary signature, plotted against the differences in mean expression values; Right panel: rank of ovary enrichment scores in all 155 signatures plotted against the difference in mean expression values.

The above figure visualizes the distribution of enrichment scores and their ranks dependent on the mean expression difference between ovary signature genes and background genes. As soon as the expression of signature genes increases by a very moderate ampltiude \(1\sigma\), *BioQC* will identify the gene set as the highest-ranking signature. A even stronger difference in expression will lead to higher enrichment scores but no change in the rank.

The results suggest that *BioQC* is sensitive even to moderate changes in the average expression of a gene set.

## Mixing Benchmark

The sensitivity benchmark above suffers from the limitation that the distributions of gene expression are not physiological. To overcome this, we designed and performed a benchmark by *in silico* mixing expression profiles with weighted linear combination, thereby mimicking tissue contamination.

Given the expression profile of a sample of tissue A (\(\mathbf{Y}\_A\)), and that of a sample of tissue B (\(\mathbf{Y}\_B\)), the weighted linear mixing produces a new profile \(\mathbf{Y}=\omega\mathbf{Y\_A}+(1-\omega)\mathbf{Y\_B}\), where \(\omega \in [0,1]\). In essence the profiles of two tissue types are linearly mixed in different proportions, which simulates varying severities of contaminations. We asked whether BioQC could detect such mixings, and if so, how sensitive is the method.

### Dataset selection and quality control

In order to avoid over-fitting of signatures derived from human expression data, we decided to use a normal tissue expression dataset from a non-human mammal species, because it has been shown that tissue-preferential expression patterns tend to be conserved between mammal species. We identified a dataset of *Canis lupus familiaris* (dog), which is publicly available in Gene Expression Omnibus ([GDS4164](http://www.ncbi.nlm.nih.gov/sites/GDSbrowser?acc=GDS4164)).

In this study, the authors examined 39 samples from 10 pathologically normal tissues (liver, kidney, heart, lung, brain, lymph node, spleen, jejunum, pancreas, and skeletal muscle) of four dogs (with one pancreas sample missing). We downloaded the data, and performed minimal pre-processing: for multiple probesets that map to same genes, we kept the one with the highest average expression level and removed the rest. The resulting dataset contained expression of 16797 genes. BioQC was applied to the dataset to test whether there are major contamination issues. The results, including tissues reported by the authors, and the BioQC tissue signatures with the highest and second-highest scores, are reported in the following table:

Quality control of the mixing benchmark input data with *BioQC*. Four columns (f.l.t.r.): sample index; tissue reported by the authors; the tissue signature with the highest enrichment score reported by *BioQC*; the tissue signature with the second- highest enrichment score.

|  | Label | BioQC.best | BioQC.second |
| --- | --- | --- | --- |
| GSM502573 | Brain | Spinal\_cord | Nodose\_nucleus |
| GSM502574 | Brain | Brain\_Cortex\_prefrontal | Brain\_Amygdala |
| GSM502575 | Brain | Brain\_Cortex\_prefrontal | Brain\_Amygdala |
| GSM502576 | Brain | Brain\_Cortex\_prefrontal | Brain\_Amygdala |
| GSM502577 | Heart | Muscle\_cardiac | Muscle\_skeletal |
| GSM502578 | Heart | Muscle\_cardiac | Muscle\_skeletal |
| GSM502579 | Heart | Muscle\_cardiac | Muscle\_skeletal |
| GSM502580 | Heart | Muscle\_cardiac | Muscle\_skeletal |
| GSM502581 | Jejunum | Intestine\_small | Intestine\_Colon |
| GSM502582 | Jejunum | Intestine\_small | Intestine\_Colon |
| GSM502583 | Jejunum | Intestine\_small | Intestine\_Colon |
| GSM502584 | Jejunum | Intestine\_small | Intestine\_Colon |
| GSM502585 | Kidney | Kidney | Kidney\_Renal\_Cortex |
| GSM502586 | Kidney | Kidney | Kidney\_Renal\_Cortex |
| GSM502587 | Kidney | Kidney | Kidney\_Renal\_Cortex |
| GSM502588 | Kidney | Kidney | Kidney\_Renal\_Cortex |
| GSM502589 | Liver | Liver | Liver |
| GSM502590 | Liver | Liver | Liver |
| GSM502591 | Liver | Liver | Liver |
| GSM502592 | Liver | Liver | Liver |
| GSM502593 | Lung | Lung | Monocytes |
| GSM502594 | Lung | Monocytes | Lung |
| GSM502595 | Lung | Lung | Monocytes |
| GSM502596 | Lung | Monocytes | Lung |
| GSM502597 | LymphNode | Lymphocyte\_B\_FOLL | Lymphocytes\_T\_H |
| GSM502598 | LymphNode | Lymphocyte\_B\_FOLL | Lymphocytes\_T\_H |
| GSM502599 | LymphNode | Lymphocyte\_B\_FOLL | Lymphocytes\_T\_H |
| GSM502600 | LymphNode | Lymphocyte\_B\_FOLL | Lymphocytes\_T\_H |
| GSM502601 | Pancreas | Pancreas\_Islets | Pancreas |
| GSM502602 | Pancreas | Pancreas\_Islets | Pancreas |
| GSM502603 | Pancreas | Pancreas\_Islets | Pancreas |
| GSM502604 | SkeletalMuscle | Muscle\_skeletal | Muscle\_cardiac |
| GSM502605 | SkeletalMuscle | Muscle\_skeletal | Muscle\_cardiac |
| GSM502606 | SkeletalMuscle | Muscle\_skeletal | Muscle\_cardiac |
| GSM502607 | SkeletalMuscle | Muscle\_skeletal | Muscle\_cardiac |
| GSM502608 | Spleen | Monocytes | Lymphocyte\_B\_FOLL |
| GSM502609 | Spleen | Monocytes | Lymphocyte\_B\_FOLL |
| GSM502610 | Spleen | Monocytes | Erythroid\_cells |
| GSM502611 | Spleen | Monocytes | Myeloblast |

By comparing the tissue labels provided by the authors and the predictions of *BioQC*, we notice that in most cases the two match well (despite of ontological differences). In three cases (sample ID GSM502573, GSM502594, and GSM502596) though, there seem to be intriguing differences, which might be explained by different sampling procedures or immune cell infiltration. We will however in this vignette not further explore them. These three samples are removed from the simulation procedures.

### An example of weighted mixing: heart and jejunum

As an example, we take average expression of heart and jejunum samples, and mix them by different compositions. This allows us comparing enrichment scores and their ranks when the expression profiles of heart and jejunum are mixed *in silico*:

![**Figure 2:** Results of a mixing case study. Left panel: *BioQC* enrichment scores of small intestine and cardiac muscle varying upon different proportions of jejunum; Right panel: ranks of enrichment scores varying upon different proportions of jejunum.](bioqc-simulation_files/figure-html/hjMixVis-1.png)

**Figure 2:** Results of a mixing case study. Left panel: *BioQC* enrichment scores of small intestine and cardiac muscle varying upon different proportions of jejunum; Right panel: ranks of enrichment scores varying upon different proportions of jejunum.

We observe that with as little as 5% contamination of heart tissue in jejunum samples (rightmost in the right panel), the rank of heart signature jumps from 34 to 9; 10% and 20% contamination will further enhance the rank to 4 and 3 respectively. If we start from the other end, namely assuming jejunum contamination in heart samples, the BioQC algorithms ranks jejunum the 7th only when there are more than 25% contamination. If we set enrichment score equal or over 3 as the threshold of calling a suspected contamination event (\(p<0.001\) in the one-sided Wilcoxon-Mann-Whitney test), it takes about 10% heart in jejunum tissue or about 30% jejunum tissue in heart to make a call. It means the sensitivity of contamination detection is not symmetric between tissues: contamination by tissues with distinct expression patterns (such as heart) are easier to be detected than contamination by tissues with less distinct expression patterns (such as small intestine).

While it is difficult to quantify the absolute sensitivity of contamination detection, it is apparent that if the enrichment score of a unforeseen tissue is very high (or ranked high), one may suspect potential contamination. Also, if there are replicates of samples from the same tissue, a higher value in one sample compared with the other samples suggests a contamination or infiltration incident.

### Pairwise Mixing

Following the heart-jejunum example, we performed all 45 pairwise mixing experiments, producing weighted linear combinations of gene expression profiles of each pair of tissues (excluding self-mixing). The results are summaried in a heatmap:

![**Figure 3:** Results of the pairwise mixing experiment. Each cell represents the minimal percentage of tissue of the column as contamination in the tissue of the row that can be detected by *BioQC*. No values are available for cells on the diagonal because self-mixing was excluded. Heart  and skeletal muscle are very close to each other and therefore their detection limit is not considered.](bioqc-simulation_files/figure-html/dog_mix_vis-1.png)

**Figure 3:** Results of the pairwise mixing experiment. Each cell represents the minimal percentage of tissue of the column as contamination in the tissue of the row that can be detected by *BioQC*. No values are available for cells on the diagonal because self-mixing was excluded. Heart and skeletal muscle are very close to each other and therefore their detection limit is not considered.

The heatmap visualization summarizes the detection limit of contamination of each pair of tissues. Take the cell in row 1 column 2 from top left: its value (0.15) means that if there are 15% or more contamination by heart in the brain sample, *BioQC* will be able to detect it (with the threshold enrichment score \(\geqslant3\) or the rank \(\leqslant10\)), because the enrichment score is equal to or larger than 3, or the heart tissue signature ranks in the top 10 of all tissue signatures.

Take another cell in row 2 column 1 from top left: its value (0.5) means that if there are 50% or more contanmination by brain in a heart sample, *BioQC* will be able to detect it. Here we observe the asymmetry again that we observed before with the heart/jejenum example: while it is realtively easy to identify heart contamination of a brain sample, it is more difficult to identify brain contamination of a heart sample in this dataset.

The average detection limits of tissues as contamination sources are listed in the following table. The values are derived from median values of each column in the heatmap, except for diagonal and missing elements.

Median lower detection limites of tissues as contamination sources.

| Tissue | MedianDetectionLimit |
| --- | --- |
| Brain | 52.22% |
| Heart | 10.62% |
| Jejunum | 19.44% |
| Kidney | 23.75% |
| Liver | 11.87% |
| Lung | 31.67% |
| LymphNode | 30.63% |
| Pancreas | 17.22% |
| SkeletalMuscle | 15.00% |
| Spleen | 13.57% |

Interestingly, brain samples are a special case: if they contaminate other tissues, it is more difficult to identify (but not other way around). It can be partially explained by the experiment design: Briggs *et al.* profiled the whole cerebrum, whereas in *BioQC* there are 22 distinct gene sets assigned to distinct brain regions. Though the prefrontal cortex signature scored highest in the canine brain samples, its score is relative low (7.45), and the genes in the signature are not too far away from the background genes:

![**Figure 4:** Average expression of tissue-preferential genes in respective tissues. For each tissue (*e.g.* brain), we calculate the median ratio of gene expression level of specific genes over the median expression level of background genes. The value reflects the specificity of tissue-specific genes in respective tissues. Likely due to the sampling of different brain regions, the score of brain ranks the lowest.](bioqc-simulation_files/figure-html/brain_low_exp-1.png)

**Figure 4:** Average expression of tissue-preferential genes in respective tissues. For each tissue (*e.g.* brain), we calculate the median ratio of gene expression level of specific genes over the median expression level of background genes. The value reflects the specificity of tissue-specific genes in respective tissues. Likely due to the sampling of different brain regions, the score of brain ranks the lowest.

Therefore only a strong contamination by brain in this dataset will be detected by the given threshold. We expect that if prefrontal cortex instead of cerebrum sample was profiled, the mixing profile of brain will be similar to other organs. This needs to be tested in other datasets.

Apart from that, most *in silico* contamination events are detectable in this dataset, with median detection limit around 0.2. This suggests that *BioQC* is sensitive towards tissue heterogeneity in physiological settings.

# Conclusions

Benchmark studies with similated and real-world data demonstrate that *BioQC* is an efficient and sensitive method to detect tissue heterogeneity from high-throughput gene expression data.

# Appendix

### Comparing BioQC with Principal Component Analysis (PCA)

In the context of the dog transcriptome dataset, we can compare the results of principal component analysis (PCA) with that of *BioQC*:

![Sample separation revealed by principal component analysis (PCA) of the dog transcriptome dataset.](bioqc-simulation_files/figure-html/pca-1.png)

Sample separation revealed by principal component analysis (PCA) of the dog transcriptome dataset.

PCA sugggests that samples from each tissue tend to cluster together, in line with the *BioQC* results. In addition, PCA reveals that tissues with cells of similar origins cluster together, such as skeletal muscle and heart. As expected, one brain sample and two lung samples seem to be different from other samples of the same cluster, which are consistent with the *BioQC* findings; however, unlike BioQC, PCA does not provide information on what are potential contamination/infiltration casues.

Therefore, we believe *BioQC* complements existing unsupervised methods to inspect quality of gene expression data.

## R Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] hgu133plus2.db_3.13.0 rbenchmark_1.0.0      gplots_3.2.0
##  [4] gridExtra_2.3         latticeExtra_0.6-31   lattice_0.22-7
##  [7] org.Hs.eg.db_3.22.0   AnnotationDbi_1.72.0  IRanges_2.44.0
## [10] S4Vectors_0.48.0      testthat_3.2.3        limma_3.66.0
## [13] RColorBrewer_1.1-3    BioQC_1.38.0          Biobase_2.70.0
## [16] BiocGenerics_0.56.0   generics_0.1.4        knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0    gtable_0.3.6       xfun_0.53          bslib_0.9.0
##  [5] caTools_1.18.3     vctrs_0.6.5        tools_4.5.1        bitops_1.0-9
##  [9] RSQLite_2.4.3      blob_1.2.4         pkgconfig_2.0.3    KernSmooth_2.23-26
## [13] desc_1.4.3         lifecycle_1.0.4    compiler_4.5.1     deldir_2.0-4
## [17] Biostrings_2.78.0  brio_1.1.5         statmod_1.5.1      Seqinfo_1.0.0
## [21] htmltools_0.5.8.1  sass_0.4.10        yaml_2.3.10        crayon_1.5.3
## [25] jquerylib_0.1.4    cachem_1.1.0       gtools_3.9.5       locfit_1.5-9.12
## [29] digest_0.6.37      rprojroot_2.1.1    fastmap_1.2.0      grid_4.5.1
## [33] cli_3.6.5          magrittr_2.0.4     edgeR_4.8.0        bit64_4.6.0-1
## [37] rmarkdown_2.30     XVector_0.50.0     httr_1.4.7         jpeg_0.1-11
## [41] bit_4.6.0          interp_1.1-6       png_0.1-8          memoise_2.0.1
## [45] evaluate_1.0.5     rlang_1.1.6        Rcpp_1.1.0         glue_1.8.0
## [49] DBI_1.2.3          pkgload_1.4.1      jsonlite_2.0.0     R6_2.6.1
```