## Rsolnp: General Non-Linear Optimization

General Non-linear Optimization Using Augmented Lagrange Multiplier Method.

|  |  |
| --- | --- |
| Version: | 2.0.1 |
| Depends: | R (≥ 3.0.2) |
| Imports: | [Rcpp](../Rcpp/index.html), [truncnorm](../truncnorm/index.html), parallel, stats, [numDeriv](../numDeriv/index.html), [future.apply](../future.apply/index.html) |
| LinkingTo: | [Rcpp](../Rcpp/index.html) (≥ 0.10.6), [RcppArmadillo](../RcppArmadillo/index.html) |
| Suggests: | [knitr](../knitr/index.html), [rmarkdown](../rmarkdown/index.html) |
| Published: | 2025-06-30 |
| DOI: | [10.32614/CRAN.package.Rsolnp](https://doi.org/10.32614/CRAN.package.Rsolnp) |
| Author: | Alexios Galanos [![ORCID iD](../../orcid.svg)](https://orcid.org/0009-0000-9308-0457) [aut, cre, cph], Stefan Theussl [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0002-6523-4620) [ctb], Yinyu Ye [aut] (Original author of the solnp Matlab code, Stanford University) |
| Maintainer: | Alexios Galanos <alexios at 4dscape.com> |
| License: | [GPL-2](../../licenses/GPL-2) |
| NeedsCompilation: | yes |
| Materials: | <ChangeLog> |
| In views: | [Optimization](../../views/Optimization.html) |
| CRAN checks: | [Rsolnp results](../../checks/check_results_Rsolnp.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [Rsolnp.html](refman/Rsolnp.html) , <Rsolnp.pdf> |
| Vignettes: | [Introduction to SOLNP ver 2.0.0](vignettes/introduction.html) ([source](vignettes/introduction.Rmd), [R code](vignettes/introduction.R))  [SOLNP Test Suite](vignettes/test_suite.html) ([source](vignettes/test_suite.Rmd), [R code](vignettes/test_suite.R)) |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [Rsolnp\_2.0.1.tar.gz](../../../src/contrib/Rsolnp_2.0.1.tar.gz) |
| Windows binaries: | r-devel: [Rsolnp\_2.0.1.zip](../../../bin/windows/contrib/4.6/Rsolnp_2.0.1.zip), r-release: [Rsolnp\_2.0.1.zip](../../../bin/windows/contrib/4.5/Rsolnp_2.0.1.zip), r-oldrel: [Rsolnp\_2.0.1.zip](../../../bin/windows/contrib/4.4/Rsolnp_2.0.1.zip) |
| macOS binaries: | r-release (arm64): [Rsolnp\_2.0.1.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/Rsolnp_2.0.1.tgz), r-oldrel (arm64): [Rsolnp\_2.0.1.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/Rsolnp_2.0.1.tgz), r-release (x86\_64): [Rsolnp\_2.0.1.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/Rsolnp_2.0.1.tgz), r-oldrel (x86\_64): [Rsolnp\_2.0.1.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/Rsolnp_2.0.1.tgz) |
| Old sources: | [Rsolnp archive](https://CRAN.R-project.org/src/contrib/Archive/Rsolnp) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse depends: | [alphaOutlier](../alphaOutlier/index.html), [depmixS4](../depmixS4/index.html), [DiscreteInverseWeibull](../DiscreteInverseWeibull/index.html), [DiscreteWeibull](../DiscreteWeibull/index.html), [Familias](../Familias/index.html), [GsymPoint](../GsymPoint/index.html), [HardyWeinberg](../HardyWeinberg/index.html), [IDPSurvival](../IDPSurvival/index.html), [Jacquard](../Jacquard/index.html), [MEIGOR](https://www.bioconductor.org/packages/release/bioc/html/MEIGOR.html), [mipfp](../mipfp/index.html), [portn](../portn/index.html), [regsem](../regsem/index.html), [robustDA](../robustDA/index.html), [SemiMarkov](../SemiMarkov/index.html), [SPEM](https://www.bioconductor.org/packages/release/bioc/html/SPEM.html) |
| Reverse imports: | [ACDm](../ACDm/index.html), [AIPW](../AIPW/index.html), [apollo](../apollo/index.html), [clickstream](../clickstream/index.html), [CompositeReliability](../CompositeReliability/index.html), [compositeReliabilityInNestedDesigns](../compositeReliabilityInNestedDesigns/index.html), [ConsReg](../ConsReg/index.html), [cops](../cops/index.html), [DNAmixturesLite](../DNAmixturesLite/index.html), [DNAtools](../DNAtools/index.html), [dosedesignR](../dosedesignR/index.html), [fEGarch](../fEGarch/index.html), [fPortfolio](../fPortfolio/index.html), [GARCHIto](../GARCHIto/index.html), [GARCHSK](../GARCHSK/index.html), [garma](../garma/index.html), [GCEstim](../GCEstim/index.html), [GDINA](../GDINA/index.html), [GRIDCOPULA](../GRIDCOPULA/index.html), [groupWQS](../groupWQS/index.html), [guess](../guess/index.html), [highfrequency](../highfrequency/index.html), [KinMixLite](../KinMixLite/index.html), [likelihoodAsy](../likelihoodAsy/index.html), [longevity](../longevity/index.html), [MachineShop](../MachineShop/index.html), [MetaIntegration](../MetaIntegration/index.html), [mev](../mev/index.html), [mixOofA](../mixOofA/index.html), [movieROC](../movieROC/index.html), [mrds](../mrds/index.html), [prodest](../prodest/index.html), [QFASA](../QFASA/index.html), [qfasar](../qfasar/index.html), [QuantBondCurves](../QuantBondCurves/index.html), [r6qualitytools](../r6qualitytools/index.html), [Renvlp](../Renvlp/index.html), [rmgarch](../rmgarch/index.html), [robustGarch](../robustGarch/index.html), [rugarch](../rugarch/index.html), [SIRE](../SIRE/index.html), [spGARCH](../spGARCH/index.html), [tsdistributions](../tsdistributions/index.html), [tseriesTARMA](../tseriesTARMA/index.html), [tsmarch](../tsmarch/index.html), [vaccine](../vaccine/index.html) |
| Reverse suggests: | [DoseFinding](../DoseFinding/index.html), [LambertW](../LambertW/index.html), [lessSEM](../lessSEM/index.html), [markovchain](../markovchain/index.html), [mcgf](../mcgf/index.html), [metafor](../metafor/index.html), [mirt](../mirt/index.html), [RSDC](../RSDC/index.html), [txshift](../txshift/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=Rsolnp`](https://CRAN.R-project.org/package%3DRsolnp)
to link to this page.