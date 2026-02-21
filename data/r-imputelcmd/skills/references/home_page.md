## imputeLCMD: A Collection of Methods for Left-Censored Missing Data Imputation

A collection of functions for left-censored missing data imputation. Left-censoring is a special case of missing not at random (MNAR) mechanism that generates non-responses in proteomics experiments. The package also contains functions to artificially generate peptide/protein expression data (log-transformed) as random draws from a multivariate Gaussian distribution as well as a function to generate missing data (both randomly and non-randomly). For comparison reasons, the package also contains several wrapper functions for the imputation of non-responses that are missing at random. \* New functionality has been added: a hybrid method that allows the imputation of missing values in a more complex scenario where the missing data are both MAR and MNAR.

|  |  |
| --- | --- |
| Version: | 2.1 |
| Depends: | R (≥ 2.10), [tmvtnorm](../tmvtnorm/index.html), [norm](../norm/index.html), [pcaMethods](https://www.bioconductor.org/packages/release/bioc/html/pcaMethods.html), [impute](https://www.bioconductor.org/packages/release/bioc/html/impute.html) |
| Published: | 2022-06-10 |
| DOI: | [10.32614/CRAN.package.imputeLCMD](https://doi.org/10.32614/CRAN.package.imputeLCMD) |
| Author: | Cosmin Lazar [aut], Thomas Burger [aut], Samuel Wieczorek [cre, ctb] |
| Maintainer: | Samuel Wieczorek <samuel.wieczorek at cea.fr> |
| License: | [GPL-2](../../licenses/GPL-2) | [GPL-3](../../licenses/GPL-3) [expanded from: GPL (≥ 2)] |
| NeedsCompilation: | no |
| In views: | [MissingData](../../views/MissingData.html), [Omics](../../views/Omics.html) |
| CRAN checks: | [imputeLCMD results](../../checks/check_results_imputeLCMD.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [imputeLCMD.html](refman/imputeLCMD.html) , <imputeLCMD.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [imputeLCMD\_2.1.tar.gz](../../../src/contrib/imputeLCMD_2.1.tar.gz) |
| Windows binaries: | r-devel: [imputeLCMD\_2.1.zip](../../../bin/windows/contrib/4.6/imputeLCMD_2.1.zip), r-release: [imputeLCMD\_2.1.zip](../../../bin/windows/contrib/4.5/imputeLCMD_2.1.zip), r-oldrel: [imputeLCMD\_2.1.zip](../../../bin/windows/contrib/4.4/imputeLCMD_2.1.zip) |
| macOS binaries: | r-release (arm64): [imputeLCMD\_2.1.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/imputeLCMD_2.1.tgz), r-oldrel (arm64): [imputeLCMD\_2.1.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/imputeLCMD_2.1.tgz), r-release (x86\_64): [imputeLCMD\_2.1.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/imputeLCMD_2.1.tgz), r-oldrel (x86\_64): [imputeLCMD\_2.1.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/imputeLCMD_2.1.tgz) |
| Old sources: | [imputeLCMD archive](https://CRAN.R-project.org/src/contrib/Archive/imputeLCMD) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse imports: | [DEP](https://www.bioconductor.org/packages/release/bioc/html/DEP.html), [lipidr](https://www.bioconductor.org/packages/release/bioc/html/lipidr.html), [MatrixQCvis](https://www.bioconductor.org/packages/release/bioc/html/MatrixQCvis.html), [rexposome](https://www.bioconductor.org/packages/release/bioc/html/rexposome.html), [SmartPhos](https://www.bioconductor.org/packages/release/bioc/html/SmartPhos.html) |
| Reverse suggests: | [MsCoreUtils](https://www.bioconductor.org/packages/release/bioc/html/MsCoreUtils.html), [msImpute](https://www.bioconductor.org/packages/release/bioc/html/msImpute.html), [MSnbase](https://www.bioconductor.org/packages/release/bioc/html/MSnbase.html), [mspms](https://www.bioconductor.org/packages/release/bioc/html/mspms.html), [QFeatures](https://www.bioconductor.org/packages/release/bioc/html/QFeatures.html), [qmtools](https://www.bioconductor.org/packages/release/bioc/html/qmtools.html), [readyomics](../readyomics/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=imputeLCMD`](https://CRAN.R-project.org/package%3DimputeLCMD)
to link to this page.