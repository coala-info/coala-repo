## nleqslv: Solve Systems of Nonlinear Equations

Solve a system of nonlinear equations using a Broyden or a Newton method
with a choice of global strategies such as line search and trust region.
There are options for using a numerical or user supplied Jacobian,
for specifying a banded numerical Jacobian and for allowing
a singular or ill-conditioned Jacobian.

|  |  |
| --- | --- |
| Version: | 3.3.5 |
| Published: | 2023-11-26 |
| DOI: | [10.32614/CRAN.package.nleqslv](https://doi.org/10.32614/CRAN.package.nleqslv) |
| Author: | Berend Hasselman |
| Maintainer: | Berend Hasselman <bhh at xs4all.nl> |
| License: | [GPL-2](../../licenses/GPL-2) | [GPL-3](../../licenses/GPL-3) [expanded from: GPL (≥ 2)] |
| NeedsCompilation: | yes |
| Materials: | <NEWS> |
| In views: | [NumericalMathematics](../../views/NumericalMathematics.html) |
| CRAN checks: | [nleqslv results](../../checks/check_results_nleqslv.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [nleqslv.html](refman/nleqslv.html) , <nleqslv.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [nleqslv\_3.3.5.tar.gz](../../../src/contrib/nleqslv_3.3.5.tar.gz) |
| Windows binaries: | r-devel: [nleqslv\_3.3.5.zip](../../../bin/windows/contrib/4.6/nleqslv_3.3.5.zip), r-release: [nleqslv\_3.3.5.zip](../../../bin/windows/contrib/4.5/nleqslv_3.3.5.zip), r-oldrel: [nleqslv\_3.3.5.zip](../../../bin/windows/contrib/4.4/nleqslv_3.3.5.zip) |
| macOS binaries: | r-release (arm64): [nleqslv\_3.3.5.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/nleqslv_3.3.5.tgz), r-oldrel (arm64): [nleqslv\_3.3.5.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/nleqslv_3.3.5.tgz), r-release (x86\_64): [nleqslv\_3.3.5.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/nleqslv_3.3.5.tgz), r-oldrel (x86\_64): [nleqslv\_3.3.5.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/nleqslv_3.3.5.tgz) |
| Old sources: | [nleqslv archive](https://CRAN.R-project.org/src/contrib/Archive/nleqslv) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse depends: | [alphaOutlier](../alphaOutlier/index.html), [BayesGOF](../BayesGOF/index.html), [BwQuant](../BwQuant/index.html), [GNE](../GNE/index.html), [mbrglm](../mbrglm/index.html), [ph2bye](../ph2bye/index.html), [PriorGen](../PriorGen/index.html) |
| Reverse imports: | [aae.pop](../aae.pop/index.html), [acc](../acc/index.html), [augSIMEX](../augSIMEX/index.html), [automatedRecLin](../automatedRecLin/index.html), [BIGL](../BIGL/index.html), [brglm2](../brglm2/index.html), [brms](../brms/index.html), [cifmodeling](../cifmodeling/index.html), [combi](https://www.bioconductor.org/packages/release/bioc/html/combi.html), [covsim](../covsim/index.html), [decisionSupport](../decisionSupport/index.html), [depCensoring](../depCensoring/index.html), [detectnorm](../detectnorm/index.html), [DiscreteDists](../DiscreteDists/index.html), [drgee](../drgee/index.html), [DTEAssurance](../DTEAssurance/index.html), [dynsurv](../dynsurv/index.html), [EHRmuse](../EHRmuse/index.html), [EL](../EL/index.html), [frailtySurv](../frailtySurv/index.html), [fungible](../fungible/index.html), [gasanalyzer](../gasanalyzer/index.html), [GECal](../GECal/index.html), [GEint](../GEint/index.html), [genpwr](../genpwr/index.html), [georob](../georob/index.html), [GWEX](../GWEX/index.html), [hmmm](../hmmm/index.html), [ipwErrorY](../ipwErrorY/index.html), [ivtools](../ivtools/index.html), [JICO](../JICO/index.html), [ktsolve](../ktsolve/index.html), [likelihoodAsy](../likelihoodAsy/index.html), [LLSR](../LLSR/index.html), [lumi](https://www.bioconductor.org/packages/release/bioc/html/lumi.html), [MCPModBC](../MCPModBC/index.html), [meteR](../meteR/index.html), [mev](../mev/index.html), [miCoPTCM](../miCoPTCM/index.html), [MLEce](../MLEce/index.html), [MSPRT](../MSPRT/index.html), [NiLeDAM](../NiLeDAM/index.html), [NMA](../NMA/index.html), [NMAR](../NMAR/index.html), [nonprobsvy](../nonprobsvy/index.html), [optedr](../optedr/index.html), [pim](../pim/index.html), [PLreg](../PLreg/index.html), [ppmHR](../ppmHR/index.html), [RCM](https://www.bioconductor.org/packages/release/bioc/html/RCM.html), [reReg](../reReg/index.html), [RLescalation](../RLescalation/index.html), [RMT4DS](../RMT4DS/index.html), [sfaR](../sfaR/index.html), [SimCorrMix](../SimCorrMix/index.html), [SimMultiCorrData](../SimMultiCorrData/index.html), [spef](../spef/index.html), [spGARCH](../spGARCH/index.html), [SPPcomb](../SPPcomb/index.html), [SurvSparse](../SurvSparse/index.html), [SWIM](../SWIM/index.html), [synergyfinder](https://www.bioconductor.org/packages/release/bioc/html/synergyfinder.html), [translate.logit](../translate.logit/index.html), [TrendInTrend](../TrendInTrend/index.html), [triggerstrategy](../triggerstrategy/index.html), [TruncatedNormal](../TruncatedNormal/index.html), [VeccTMVN](../VeccTMVN/index.html), [VFS](../VFS/index.html), [zcurve](../zcurve/index.html) |
| Reverse suggests: | [epimdr](../epimdr/index.html), [momentuHMM](../momentuHMM/index.html), [SemiEstimate](../SemiEstimate/index.html), [spatstat.model](../spatstat.model/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=nleqslv`](https://CRAN.R-project.org/package%3Dnleqslv)
to link to this page.