## EZtune: Tunes AdaBoost, Elastic Net, Support Vector Machines, and Gradient Boosting Machines

Contains two functions that are intended to make
tuning supervised learning methods easy. The eztune function uses a
genetic algorithm or Hooke-Jeeves optimizer to find the best
set of tuning parameters. The user can choose the optimizer, the
learning method, and if optimization will be based on accuracy
obtained through validation error, cross validation, or resubstitution.
The function eztune.cv will compute a cross validated error rate. The purpose
of eztune\_cv is to provide a cross validated accuracy or MSE when
resubstitution or validation data are used for optimization because
error measures from both approaches can be misleading.

|  |  |
| --- | --- |
| Version: | 3.1.1 |
| Depends: | R (≥ 3.1.0) |
| Imports: | [ada](../ada/index.html), [e1071](../e1071/index.html), [GA](../GA/index.html), [gbm](../gbm/index.html), [optimx](../optimx/index.html), [rpart](../rpart/index.html), [glmnet](../glmnet/index.html), [ROCR](../ROCR/index.html), [BiocStyle](https://www.bioconductor.org/packages/release/bioc/html/BiocStyle.html) |
| Suggests: | [knitr](../knitr/index.html), [rmarkdown](../rmarkdown/index.html), [mlbench](../mlbench/index.html), [doParallel](../doParallel/index.html), parallel, [dplyr](../dplyr/index.html), [yardstick](../yardstick/index.html), [rsample](../rsample/index.html) |
| Published: | 2021-12-10 |
| DOI: | [10.32614/CRAN.package.EZtune](https://doi.org/10.32614/CRAN.package.EZtune) |
| Author: | Jill Lundell [aut, cre] |
| Maintainer: | Jill Lundell <jflundell at gmail.com> |
| License: | [GPL-3](../../licenses/GPL-3) |
| NeedsCompilation: | no |
| Citation: | [EZtune citation info](citation.html) |
| Materials: | [README](readme/README.html) |
| CRAN checks: | [EZtune results](../../checks/check_results_EZtune.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [EZtune.html](refman/EZtune.html) , <EZtune.pdf> |
| Vignettes: | [EZtune](vignettes/my-vignette.html) ([source](vignettes/my-vignette.Rmd), [R code](vignettes/my-vignette.R)) |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [EZtune\_3.1.1.tar.gz](../../../src/contrib/EZtune_3.1.1.tar.gz) |
| Windows binaries: | r-devel: [EZtune\_3.1.1.zip](../../../bin/windows/contrib/4.6/EZtune_3.1.1.zip), r-release: [EZtune\_3.1.1.zip](../../../bin/windows/contrib/4.5/EZtune_3.1.1.zip), r-oldrel: [EZtune\_3.1.1.zip](../../../bin/windows/contrib/4.4/EZtune_3.1.1.zip) |
| macOS binaries: | r-release (arm64): [EZtune\_3.1.1.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/EZtune_3.1.1.tgz), r-oldrel (arm64): [EZtune\_3.1.1.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/EZtune_3.1.1.tgz), r-release (x86\_64): [EZtune\_3.1.1.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/EZtune_3.1.1.tgz), r-oldrel (x86\_64): [EZtune\_3.1.1.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/EZtune_3.1.1.tgz) |
| Old sources: | [EZtune archive](https://CRAN.R-project.org/src/contrib/Archive/EZtune) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse suggests: | [randomForestVIP](../randomForestVIP/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=EZtune`](https://CRAN.R-project.org/package%3DEZtune)
to link to this page.