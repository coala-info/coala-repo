## dunn.test: Dunn's Test of Multiple Comparisons Using Rank Sums

Computes Dunn's test (1964) for stochastic dominance and reports the results among multiple pairwise comparisons after a Kruskal-Wallis test for 0th-order stochastic dominance among k groups (Kruskal and Wallis, 1952). 'dunn.test' makes k(k-1)/2 multiple pairwise comparisons based on Dunn's z-test-statistic approximations to the actual rank statistics. The null hypothesis for each pairwise comparison is that the probability of observing a randomly selected value from the first group that is larger than a randomly selected value from the second group equals one half; this null hypothesis corresponds to that of the Wilcoxon-Mann-Whitney rank-sum test. Like the rank-sum test, if the data can be assumed to be continuous, and the distributions are assumed identical except for a difference in location, Dunn's test may be understood as a test for median difference and for mean difference. 'dunn.test' accounts for tied ranks.

|  |  |
| --- | --- |
| Version: | 1.3.7 |
| Imports: | [rlang](../rlang/index.html) |
| Published: | 2026-02-13 |
| DOI: | [10.32614/CRAN.package.dunn.test](https://doi.org/10.32614/CRAN.package.dunn.test) |
| Author: | Alexis Dinno [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0003-2560-310X) [aut, cre, cph] |
| Maintainer: | Alexis Dinno <alexis.dinno at pdx.edu> |
| License: | [GPL-2](../../licenses/GPL-2) |
| NeedsCompilation: | no |
| CRAN checks: | [dunn.test results](../../checks/check_results_dunn.test.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [dunn.test.html](refman/dunn.test.html) , <dunn.test.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [dunn.test\_1.3.7.tar.gz](../../../src/contrib/dunn.test_1.3.7.tar.gz) |
| Windows binaries: | r-devel: [dunn.test\_1.3.7.zip](../../../bin/windows/contrib/4.6/dunn.test_1.3.7.zip), r-release: [dunn.test\_1.3.7.zip](../../../bin/windows/contrib/4.5/dunn.test_1.3.7.zip), r-oldrel: [dunn.test\_1.3.7.zip](../../../bin/windows/contrib/4.4/dunn.test_1.3.7.zip) |
| macOS binaries: | r-release (arm64): [dunn.test\_1.3.7.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/dunn.test_1.3.7.tgz), r-oldrel (arm64): [dunn.test\_1.3.7.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/dunn.test_1.3.7.tgz), r-release (x86\_64): [dunn.test\_1.3.7.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/dunn.test_1.3.7.tgz), r-oldrel (x86\_64): [dunn.test\_1.3.7.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/dunn.test_1.3.7.tgz) |
| Old sources: | [dunn.test archive](https://CRAN.R-project.org/src/contrib/Archive/dunn.test) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse imports: | [AgroR](../AgroR/index.html), [CleaningValidation](../CleaningValidation/index.html), [deepSTRAPP](../deepSTRAPP/index.html), [FSA](../FSA/index.html), [MultBiplotR](../MultBiplotR/index.html), [multiclassPairs](../multiclassPairs/index.html), [Orangutan](../Orangutan/index.html), [RTNsurvival](https://www.bioconductor.org/packages/release/bioc/html/RTNsurvival.html), [visxhclust](../visxhclust/index.html) |
| Reverse suggests: | [colleyRstats](../colleyRstats/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=dunn.test`](https://CRAN.R-project.org/package%3Ddunn.test)
to link to this page.