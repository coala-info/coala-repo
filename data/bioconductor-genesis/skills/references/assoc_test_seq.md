# Analyzing Sequence Data using the GENESIS Package

Stephanie M. Gogarten

#### 2025-10-30

# Contents

* [1 Overview](#overview)
* [2 Convert VCF to GDS](#convert-vcf-to-gds)
  + [2.1 Create a SeqVarData object](#create-a-seqvardata-object)
* [3 Population structure and relatedness](#population-structure-and-relatedness)
  + [3.1 KING](#king)
  + [3.2 PC-AiR](#pc-air)
  + [3.3 PC-Relate](#pc-relate)
* [4 Association tests](#association-tests)
  + [4.1 Null model](#null-model)
  + [4.2 Single variant tests](#single-variant-tests)
  + [4.3 Aggregate tests](#aggregate-tests)
* [5 References](#references)
* **Appendix**

# 1 Overview

This vignette provides a description of how to use the *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)* package to analyze sequence data. We demonstrate the use of mixed models for genetic association testing, as PC-AiR PCs can be used as fixed effect covariates to adjust for population stratification, and a kinship matrix (or genetic relationship matrix) estimated from PC-Relate can be used to account for phenotype correlation due to genetic similarity among samples. To illustrate the methods, we use a small subset of data from 1000 Genomes Phase 3.

# 2 Convert VCF to GDS

The first step is to convert a VCF file into the GDS file format used by *[GENESIS](https://bioconductor.org/packages/3.22/GENESIS)*. We use the *[SeqArray](https://bioconductor.org/packages/3.22/SeqArray)* package, which defines the extended GDS format used to capture all data in a VCF file. If the VCF files are split by chromosome, they can be combined into a single GDS file.

```
library(SeqArray)
vcffile <- system.file("extdata", "1KG",
                       paste0("1KG_phase3_subset_chr", 1:22, ".vcf.gz"),
                       package="GENESIS")
gdsfile <- tempfile()
seqVCF2GDS(vcffile, gdsfile, verbose=FALSE)
gds <- seqOpen(gdsfile)
gds
```

```
## Object of class "SeqVarGDSClass"
## File: /tmp/RtmpK21FOp/file97d6f1fbec427 (419.7K)
## +    [  ] *
## |--+ description   [  ] *
## |--+ sample.id   { Str8 100 LZMA_ra(37.8%), 309B } *
## |--+ variant.id   { Int32 24639 LZMA_ra(7.99%), 7.7K } *
## |--+ chromosome   { Str8 24639 LZMA_ra(0.36%), 237B } *
## |--+ position   { Int32 24639 LZMA_ra(71.8%), 69.1K } *
## |--+ allele   { Str8 24639 LZMA_ra(19.2%), 20.0K } *
## |--+ genotype   [  ] *
## |  |--+ data   { Bit2 2x100x24657 LZMA_ra(18.7%), 224.9K } *
## |  |--+ extra.index   { Int32 3x0 LZMA_ra, 18B } *
## |  \--+ extra   { Int16 0 LZMA_ra, 18B }
## |--+ phase   [  ]
## |  |--+ data   { Bit1 100x24639 LZMA_ra(0.06%), 201B } *
## |  |--+ extra.index   { Int32 3x0 LZMA_ra, 18B } *
## |  \--+ extra   { Bit1 0 LZMA_ra, 18B }
## |--+ annotation   [  ]
## |  |--+ id   { Str8 24639 LZMA_ra(37.3%), 87.8K } *
## |  |--+ qual   { Float32 24639 LZMA_ra(0.17%), 173B } *
## |  |--+ filter   { Int32,factor 24639 LZMA_ra(0.17%), 173B } *
## |  |--+ info   [  ]
## |  \--+ format   [  ]
## \--+ sample.annotation   [  ]
```

## 2.1 Create a SeqVarData object

Next, we combine the GDS file with information about the samples, which we store in an `AnnotatedDataFrame` (defined in the *[Biobase](https://bioconductor.org/packages/3.22/Biobase)* package). An `AnnotatedDataFrame` combines a `data.frame` with metadata describing each column. A `SeqVarData` object (defined in the *[SeqVarTools](https://bioconductor.org/packages/3.22/SeqVarTools)* package), contains both an open GDS file and an `AnnotatedDataFrame` describing the samples. The `sample.id` column in the `AnnotatedDataFrame` must match the `sample.id` node in the GDS file.

```
library(GENESIS)
library(Biobase)
library(SeqVarTools)

data(sample_annotation_1KG)
annot <- sample_annotation_1KG
head(annot)
```

```
##   sample.id Population sex
## 1   HG00110        GBR   F
## 2   HG00116        GBR   M
## 3   HG00120        GBR   F
## 4   HG00128        GBR   F
## 5   HG00136        GBR   M
## 6   HG00137        GBR   F
```

```
# simulate some phenotype data
set.seed(4)
annot$outcome <- rnorm(nrow(annot))
metadata <- data.frame(labelDescription=c("sample id",
                                          "1000 genomes population",
                                          "sex",
                                          "simulated phenotype"),
                       row.names=names(annot))
annot <- AnnotatedDataFrame(annot, metadata)

all.equal(annot$sample.id, seqGetData(gds, "sample.id"))
```

```
## [1] TRUE
```

```
seqData <- SeqVarData(gds, sampleData=annot)
```

# 3 Population structure and relatedness

PC-AiR and PC-Relate are described in detail in a separate vignette. Here, we demonstrate their use to provide adjustment for population structure and relatedness in a mixed model.

## 3.1 KING

Step 1 is to get initial estimates of kinship using KING, which is robust to population structure but not admixture. The KING algorithm is available in SNPRelate. We select a subset of variants for this calculation with LD pruning.

```
library(SNPRelate)

# LD pruning to get variant set
snpset <- snpgdsLDpruning(gds, method="corr", slide.max.bp=10e6,
                          ld.threshold=sqrt(0.1), verbose=FALSE)
pruned <- unlist(snpset, use.names=FALSE)

king <- snpgdsIBDKING(gds, snp.id=pruned, verbose=FALSE)
kingMat <- king$kinship
dimnames(kingMat) <- list(king$sample.id, king$sample.id)
```

## 3.2 PC-AiR

The next step is PC-AiR, in which we select a set of unrelated samples that is maximally informative about all ancestries in the sample, use this unrelated set for Principal Component Analysis (PCA), then project the relatives onto the PCs. We use a kinship threshold of degree 3 (unrelated is less than first cousins). In this example, we use the KING estimates for both kinship (`kinobj`) and ancestry divergence (`divobj`). KING kinship estimates are negative for samples with different ancestry.

```
pcs <- pcair(seqData,
             kinobj=kingMat, kin.thresh=2^(-9/2),
             divobj=kingMat, div.thresh=-2^(-9/2),
             snp.include=pruned)
```

```
## Principal Component Analysis (PCA) on genotypes:
## Calculating allele counts/frequencies (10798 variants) ...
##
[..................................................]  0%, ETC: --- (1/1)
[==================================================] 100%, used 0s (1/1)
[==================================================] 100%, complete, 0s
## # of selected variants: 10,468
## Excluding 330 SNVs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 88
##     # of SNVs: 10,468
##     using 1 thread/core
##     # of principal components: 32
## CPU capabilities: Double-Precision SSE2
## 2025-10-30 00:07:22    (internal increment: 35328)
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed, 0s
## 2025-10-30 00:07:22    Begin (eigenvalues and eigenvectors)
## 2025-10-30 00:07:22    Done.
```

```
## SNP Loading:
##     # of samples: 88
##     # of SNPs: 10,468
##     using 1 thread/core
##     using the top 32 eigenvectors
## 2025-10-30 00:07:22    (internal increment: 65536)
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed, 0s
## 2025-10-30 00:07:22    Done.
## Sample Loading:
##     # of samples: 12
##     # of SNPs: 10,468
##     using 1 thread/core
##     using the top 32 eigenvectors
## 2025-10-30 00:07:22    (internal increment: 65536)
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed, 0s
## 2025-10-30 00:07:22    Done.
```

We need to determine which PCs are ancestry informative. To do this we need population information for the 1000 Genomes samples. We make a parallel coordinates plot, color-coding by 1000 Genomes population.

```
library(dplyr)
library(RColorBrewer)
library(ggplot2)
library(GGally)

pc.df <- as.data.frame(pcs$vectors)
names(pc.df) <- paste0("PC", 1:ncol(pcs$vectors))
pc.df$sample.id <- row.names(pcs$vectors)
pc.df <- left_join(pc.df, pData(annot), by="sample.id")

pop.cols <- setNames(brewer.pal(12, "Paired"),
    c("ACB", "ASW", "CEU", "GBR", "CHB", "JPT",
      "CLM", "MXL", "LWK", "YRI", "GIH", "PUR"))

ggplot(pc.df, aes(PC1, PC2, color=Population)) + geom_point() +
    scale_color_manual(values=pop.cols)
```

![](data:image/png;base64...)

```
ggparcoord(pc.df, columns=1:10, groupColumn="Population", scale="uniminmax") +
    scale_color_manual(values=pop.cols) +
    xlab("PC") + ylab("")
```

![](data:image/png;base64...)

## 3.3 PC-Relate

The first 2 PCs separate populations, so we use them to compute kinship estimates adjusting for ancestry. The `pcrelate` method requires creating a `SeqVarBlockIterator` object, which should iterate over the pruned SNPs only.

```
seqSetFilter(seqData, variant.id=pruned)
```

```
## # of selected variants: 10,798
```

```
iterator <- SeqVarBlockIterator(seqData, variantBlock=20000, verbose=FALSE)
pcrel <- pcrelate(iterator, pcs=pcs$vectors[,1:2], training.set=pcs$unrels,
                  BPPARAM=BiocParallel::SerialParam())
seqResetFilter(seqData, verbose=FALSE)
```

```
kinship <- pcrel$kinBtwn

ggplot(kinship, aes(k0, kin)) +
    geom_hline(yintercept=2^(-seq(3,9,2)/2), linetype="dashed", color="grey") +
    geom_point(alpha=0.5) +
    ylab("kinship estimate") +
    theme_bw()
```

![](data:image/png;base64...)

To improve our estimates for PCs and kinship, we could run another iteration of PC-AiR and PC-Relate, this time using the PC-Relate kinship estimates as the `kinobj` argument to `pcair`. The KING matrix is still used for ancestry divergence. We could then use those new PCs to calculate revised kinship estimates.

# 4 Association tests

## 4.1 Null model

The first step for association testing is to fit the model under the null hypothesis that each SNP has no effect. This null model contains all of the covariates, including ancestry representative PCs, as well as any random effects, such as a polygenic effect due to genetic relatedness, but it does not include any SNP genotype terms as fixed effects.

The type of model fit depends on the arguments to `fitNullModel`. Including a `cov.mat` argument will result in a mixed model, while omitting this argument will run a standard linear model. A logistic model is specified with `family="binomial"`. In the case of a logistic model and a covariance matrix, `fitNullModel` will use the GMMAT algorithm. Including a `group.var` argument will allow heteroscedastic variance (for linear models or linear mixed models only).

```
# add PCs to sample annotation in SeqVarData object
annot <- AnnotatedDataFrame(pc.df)
sampleData(seqData) <- annot

# covariance matrix from pcrelate output
grm <- pcrelateToMatrix(pcrel, scaleKin=2)

# fit the null model
nullmod <- fitNullModel(seqData, outcome="outcome",
                        covars=c("sex", "Population", paste0("PC", 1:2)),
                        cov.mat=grm, verbose=FALSE)
```

## 4.2 Single variant tests

To run a test using the null model, we first create an iterator object specifying how we want variants to be selected. (See the documentation for the `SeqVarIterator` class in *[SeqVarTools](https://bioconductor.org/packages/3.22/SeqVarTools)* for more details.) For single-variant tests (GWAS), it is common to use a block iterator that reads variants in blocks (default is 10,000 variants per block).

For example purposes, we restrict our analysis to chromosome 1. The `seqSetFilter` function can be used to restrict the set of variants tested in other ways (e.g., variants that pass a quality filter).

```
# select chromosome 1
seqSetFilterChrom(seqData, include=1)
```

```
## # of selected variants: 1,120
```

```
iterator <- SeqVarBlockIterator(seqData, verbose=FALSE)
assoc <- assocTestSingle(iterator, nullmod, verbose=FALSE,
                         BPPARAM=BiocParallel::SerialParam())
head(assoc)
```

```
##   variant.id chr     pos allele.index n.obs  freq MAC        Score Score.SE
## 1          1   1  828740            1   100 0.035   7   0.01852643 2.810783
## 2          2   1  913272            1   100 0.010   2  -0.19822201 1.378855
## 3          3   1 1171878            1   100 0.005   1   0.05842004 1.016472
## 4          4   1 1242288            1   100 0.025   5  -0.63222028 2.152144
## 5          5   1 1378837            1   100 0.670  66 -10.25156898 6.031003
## 6          6   1 1403820            1   100 0.015   3   2.30811833 1.689624
##    Score.Stat Score.pval          Est    Est.SE          PVE
## 1  0.00659120 0.99474102  0.002344969 0.3557727 5.111049e-07
## 2 -0.14375838 0.88569127 -0.104259227 0.7252393 2.431350e-04
## 3  0.05747337 0.95416812  0.056542030 0.9837953 3.886103e-05
## 4 -0.29376304 0.76893898 -0.136497869 0.4646530 1.015256e-03
## 5 -1.69981158 0.08916637 -0.281845581 0.1658099 3.399246e-02
## 6  1.36605427 0.17192193  0.808495931 0.5918476 2.195417e-02
```

The default test is a Score test, but the Wald test is also available for continuous outcomes.

If there are multiallelic variants, each alternate allele is tested separately. The `allele.index` column in the output differentiates between different alternate alleles for the same variant.

We make a QQ plot to examine the results.

```
qqPlot <- function(pval) {
    pval <- pval[!is.na(pval)]
    n <- length(pval)
    x <- 1:n
    dat <- data.frame(obs=sort(pval),
                      exp=x/n,
                      upper=qbeta(0.025, x, rev(x)),
                      lower=qbeta(0.975, x, rev(x)))

    ggplot(dat, aes(-log10(exp), -log10(obs))) +
        geom_line(aes(-log10(exp), -log10(upper)), color="gray") +
        geom_line(aes(-log10(exp), -log10(lower)), color="gray") +
        geom_point() +
        geom_abline(intercept=0, slope=1, color="red") +
        xlab(expression(paste(-log[10], "(expected P)"))) +
        ylab(expression(paste(-log[10], "(observed P)"))) +
        theme_bw()
}

qqPlot(assoc$Score.pval)
```

![](data:image/png;base64...)

## 4.3 Aggregate tests

We can aggregate rare variants for association testing to decrease multiple testing burden and increase statistical power. We can create functionally agnostic units using a `SeqVarWindowIterator`. This iterator type generates a sliding window over the genome, with user-specified width and step size. We can also create units with specific start and end points or containing specific variants, using a `SeqVarRangeIterator` or a `SeqVarListIterator`.

In this example, we illustrate defining ranges based on known genes. We run a burden test, setting a maximum alternate allele frequency to exclude common variants.

```
library(GenomicRanges)
library(GenomeInfoDb)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

# return the variants on chromosome 1 as a GRanges object
seqSetFilterChrom(seqData, include=1)
```

```
## # of selected variants: 1,120
```

```
gr <- granges(gds)

# find variants that overlap with each gene
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
gr <- renameSeqlevels(gr, paste0("chr", seqlevels(gr)))
ts <- transcriptsByOverlaps(txdb, gr, columns="GENEID")
# simplistic example - define genes as overlapping transcripts
genes <- reduce(ts)
genes <- renameSeqlevels(genes, sub("chr", "", seqlevels(genes)))

# create an iterator where each successive unit is a different gene
iterator <- SeqVarRangeIterator(seqData, variantRanges=genes, verbose=FALSE)

# do a burden test on the rare variants in each gene
assoc <- assocTestAggregate(iterator, nullmod, AF.max=0.05, test="Burden",
                            BPPARAM=BiocParallel::SerialParam(), verbose=FALSE)
```

The output of an aggregate test is a list with two elements: 1) a data.frame with the test results for each aggregate unit, and 2) a list of data.frames containing the variants in each aggregate unit.

```
head(assoc$results)
```

```
##   n.site n.alt n.sample.alt     Score Score.SE Score.Stat Score.pval        Est
## 1      1     3            3  2.308118 1.689624  1.3660543 0.17192193  0.8084959
## 2      1     5            5  3.726985 2.238929  1.6646284 0.09598691  0.7434931
## 3      1     2            2 -0.838852 1.391778 -0.6027196 0.54669524 -0.4330572
## 4      1     1            1 -0.775075 1.046050 -0.7409537 0.45872150 -0.7083346
## 5      1     2            2  2.842712 1.442053  1.9712951 0.04869014  1.3670060
## 6      1     5            5  1.478815 2.148447  0.6883182 0.49125241  0.3203794
##      Est.SE         PVE
## 1 0.5918476 0.021954168
## 2 0.4466421 0.032599857
## 3 0.7185053 0.004273776
## 4 0.9559768 0.006458970
## 5 0.6934558 0.045717697
## 6 0.4654524 0.005573905
```

```
head(assoc$variantInfo)
```

```
## [[1]]
##   variant.id chr     pos allele.index n.obs  freq MAC weight
## 1          6   1 1403820            1   100 0.015   3      1
##
## [[2]]
##   variant.id chr     pos allele.index n.obs  freq MAC weight
## 1          7   1 1421285            1   100 0.025   5      1
##
## [[3]]
##   variant.id chr     pos allele.index n.obs freq MAC weight
## 1          8   1 1721369            1   100 0.01   2      1
##
## [[4]]
##   variant.id chr     pos allele.index n.obs  freq MAC weight
## 1         12   1 2023475            1   100 0.005   1      1
##
## [[5]]
##   variant.id chr     pos allele.index n.obs freq MAC weight
## 1         17   1 2496207            1   100 0.01   2      1
##
## [[6]]
##   variant.id chr     pos allele.index n.obs  freq MAC weight
## 1         18   1 2511226            1   100 0.025   5      1
```

# 5 References

# Appendix

* Conomos M.P., Reiner A.P., Weir B.S., & Thornton T.A. (2016). Model-free Estimation of Recent Genetic Relatedness. American Journal of Human Genetics, 98(1), 127-148.
* Conomos M.P., Miller M.B., & Thornton T.A. (2015). Robust Inference of Population Structure for Ancestry Prediction and Correction of Stratification in the Presence of Relatedness. Genetic Epidemiology, 39(4), 276-293.
* Manichaikul, A., Mychaleckyj, J.C., Rich, S.S., Daly, K., Sale, M., & Chen, W.M. (2010). Robust relationship inference in genome-wide association studies. Bioinformatics, 26(22), 2867-2873.
* Breslow NE and Clayton DG. (1993). Approximate Inference in Generalized Linear Mixed Models. Journal of the American Statistical Association 88: 9-25.
* Chen H, Wang C, Conomos MP, Stilp AM, Li Z, Sofer T, Szpiro AA, Chen W, Brehm JM, Celedon JC, Redline S, Papanicolaou GJ, Thornton TA, Laurie CC, Rice K and Lin X. Control for Population Structure and Relatedness for Binary Traits in Genetic Association Studies Using Logistic Mixed Models. American Journal of Human Genetics, 98(4): 653-66.
* Leal, S.M. & Li, B. (2008). Methods for Detecting Associations with Rare Variants for Common Diseases: Application to Analysis of Sequence Data. American Journal of Human Genetics, 83(3), 311-321.