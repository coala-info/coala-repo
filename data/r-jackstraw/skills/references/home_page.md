## jackstraw: Statistical Inference for Unsupervised Learning

Test for association between the observed data and their estimated latent variables. The jackstraw package provides a resampling strategy and testing scheme to estimate statistical significance of association between the observed data and their latent variables. Depending on the data type and the analysis aim, the latent variables may be estimated by principal component analysis (PCA), factor analysis (FA), K-means clustering, and related unsupervised learning algorithms. The jackstraw methods learn over-fitting characteristics inherent in this circular analysis, where the observed data are used to estimate the latent variables and used again to test against that estimated latent variables. When latent variables are estimated by PCA, the jackstraw enables statistical testing for association between observed variables and latent variables, as estimated by low-dimensional principal components (PCs). This essentially leads to identifying variables that are significantly associated with PCs. Similarly, unsupervised clustering, such as K-means clustering, partition around medoids (PAM), and others, finds coherent groups in high-dimensional data. The jackstraw estimates statistical significance of cluster membership, by testing association between data and cluster centers. Clustering membership can be improved by using the resulting jackstraw p-values and posterior inclusion probabilities (PIPs), with an application to unsupervised evaluation of cell identities in single cell RNA-seq (scRNA-seq).

|  |  |
| --- | --- |
| Version: | 1.3.17 |
| Depends: | R (≥ 3.0.0) |
| Imports: | methods, stats, [corpcor](../corpcor/index.html), [irlba](../irlba/index.html), [rsvd](../rsvd/index.html), [ClusterR](../ClusterR/index.html), [cluster](../cluster/index.html), [BEDMatrix](../BEDMatrix/index.html), [genio](../genio/index.html) (≥ 1.0.15.9000) |
| Suggests: | [qvalue](https://www.bioconductor.org/packages/release/bioc/html/qvalue.html), [lfa](https://www.bioconductor.org/packages/release/bioc/html/lfa.html) (≥ 2.0.6.9000), [gcatest](https://www.bioconductor.org/packages/release/bioc/html/gcatest.html) (≥ 2.0.4.9000), [testthat](../testthat/index.html) (≥ 3.0.0) |
| Published: | 2024-09-16 |
| DOI: | [10.32614/CRAN.package.jackstraw](https://doi.org/10.32614/CRAN.package.jackstraw) |
| Author: | Neo Christopher Chung [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0001-6798-8867) [aut, cre], John D. Storey [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0001-5992-402X) [aut], Wei Hao [aut], Alejandro Ochoa [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0003-4928-3403) [aut] |
| Maintainer: | Neo Christopher Chung <nchchung at gmail.com> |
| License: | [GPL-2](../../licenses/GPL-2) |
| NeedsCompilation: | no |
| Materials: | [README](readme/README.html), [NEWS](news/news.html) |
| CRAN checks: | [jackstraw results](../../checks/check_results_jackstraw.html) [issues need fixing before 2026-02-24] |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [jackstraw.html](refman/jackstraw.html) , <jackstraw.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [jackstraw\_1.3.17.tar.gz](../../../src/contrib/jackstraw_1.3.17.tar.gz) |
| Windows binaries: | r-devel: [jackstraw\_1.3.17.zip](../../../bin/windows/contrib/4.6/jackstraw_1.3.17.zip), r-release: [jackstraw\_1.3.17.zip](../../../bin/windows/contrib/4.5/jackstraw_1.3.17.zip), r-oldrel: [jackstraw\_1.3.17.zip](../../../bin/windows/contrib/4.4/jackstraw_1.3.17.zip) |
| macOS binaries: | r-release (arm64): [jackstraw\_1.3.17.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/jackstraw_1.3.17.tgz), r-oldrel (arm64): [jackstraw\_1.3.17.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/jackstraw_1.3.17.tgz), r-release (x86\_64): [jackstraw\_1.3.17.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/jackstraw_1.3.17.tgz), r-oldrel (x86\_64): [jackstraw\_1.3.17.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/jackstraw_1.3.17.tgz) |
| Old sources: | [jackstraw archive](https://CRAN.R-project.org/src/contrib/Archive/jackstraw) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=jackstraw`](https://CRAN.R-project.org/package%3Djackstraw)
to link to this page.