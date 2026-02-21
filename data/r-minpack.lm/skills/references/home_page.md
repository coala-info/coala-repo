## minpack.lm: R Interface to the Levenberg-Marquardt Nonlinear Least-Squares Algorithm Found in MINPACK, Plus Support for Bounds

The nls.lm function provides an R interface to lmder and lmdif from the MINPACK library, for solving nonlinear least-squares problems by a modification of the Levenberg-Marquardt algorithm, with support for lower and upper parameter bounds. The implementation can be used via nls-like calls using the nlsLM function.

|  |  |
| --- | --- |
| Version: | 1.2-4 |
| Suggests: | [MASS](../MASS/index.html) |
| Published: | 2023-09-11 |
| DOI: | [10.32614/CRAN.package.minpack.lm](https://doi.org/10.32614/CRAN.package.minpack.lm) |
| Author: | Timur V. Elzhov, Katharine M. Mullen, Andrej-Nikolai Spiess, Ben Bolker |
| Maintainer: | Katharine M. Mullen <mullenkate at gmail.com> |
| License: | [GPL-3](../../licenses/GPL-3) |
| Copyright: | inst/COPYRIGHTS   [minpack.lm copyright details](COPYRIGHTS) |
| NeedsCompilation: | yes |
| Materials: | <NEWS> |
| In views: | [ChemPhys](../../views/ChemPhys.html), [Optimization](../../views/Optimization.html) |
| CRAN checks: | [minpack.lm results](../../checks/check_results_minpack.lm.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [minpack.lm.html](refman/minpack.lm.html) , <minpack.lm.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [minpack.lm\_1.2-4.tar.gz](../../../src/contrib/minpack.lm_1.2-4.tar.gz) |
| Windows binaries: | r-devel: [minpack.lm\_1.2-4.zip](../../../bin/windows/contrib/4.6/minpack.lm_1.2-4.zip), r-release: [minpack.lm\_1.2-4.zip](../../../bin/windows/contrib/4.5/minpack.lm_1.2-4.zip), r-oldrel: [minpack.lm\_1.2-4.zip](../../../bin/windows/contrib/4.4/minpack.lm_1.2-4.zip) |
| macOS binaries: | r-release (arm64): [minpack.lm\_1.2-4.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/minpack.lm_1.2-4.tgz), r-oldrel (arm64): [minpack.lm\_1.2-4.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/minpack.lm_1.2-4.tgz), r-release (x86\_64): [minpack.lm\_1.2-4.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/minpack.lm_1.2-4.tgz), r-oldrel (x86\_64): [minpack.lm\_1.2-4.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/minpack.lm_1.2-4.tgz) |
| Old sources: | [minpack.lm archive](https://CRAN.R-project.org/src/contrib/Archive/minpack.lm) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse depends: | [cellVolumeDist](../cellVolumeDist/index.html), [DIMORA](../DIMORA/index.html), [ELISAtools](../ELISAtools/index.html), [micEconCES](../micEconCES/index.html), [miLAG](../miLAG/index.html), [onls](../onls/index.html), [photosynthesis](../photosynthesis/index.html), [propagate](../propagate/index.html), [qpcR](../qpcR/index.html), [Ritc](../Ritc/index.html), [RpeakChrom](../RpeakChrom/index.html), [rTG](../rTG/index.html), [tumgr](../tumgr/index.html) |
| Reverse imports: | [AccelStab](../AccelStab/index.html), [ActCR](../ActCR/index.html), [afmToolkit](../afmToolkit/index.html), [AgroReg](../AgroReg/index.html), [anabel](../anabel/index.html), [AquaEnv](../AquaEnv/index.html), [AquaticLifeHistory](../AquaticLifeHistory/index.html), [beezdiscounting](../beezdiscounting/index.html), [betapart](../betapart/index.html), [BIGL](../BIGL/index.html), [BIOMASS](../BIOMASS/index.html), [BioNAR](https://www.bioconductor.org/packages/release/bioc/html/BioNAR.html), [bootf2](../bootf2/index.html), [cdom](../cdom/index.html), [cercospoRa](../cercospoRa/index.html), [Compositional](../Compositional/index.html), [CompositionalSR](../CompositionalSR/index.html), [dendRoAnalyst](../dendRoAnalyst/index.html), [diffGeneAnalysis](https://www.bioconductor.org/packages/release/bioc/html/diffGeneAnalysis.html), [downscale](../downscale/index.html), [echo.find](../echo.find/index.html), [econet](../econet/index.html), [EMOTIONS](../EMOTIONS/index.html), [EmpiricalDynamics](../EmpiricalDynamics/index.html), [epifitter](../epifitter/index.html), [eseis](../eseis/index.html), [estprod](../estprod/index.html), [FAMetA](../FAMetA/index.html), [FatTailsR](../FatTailsR/index.html), [fdasrvf](../fdasrvf/index.html), [flippant](../flippant/index.html), [flowPloidy](https://www.bioconductor.org/packages/release/bioc/html/flowPloidy.html), [FME](../FME/index.html), [forestmangr](../forestmangr/index.html), [GB2group](../GB2group/index.html), [gen5helper](../gen5helper/index.html), [genSEIR](../genSEIR/index.html), [gplsim](../gplsim/index.html), [grandR](../grandR/index.html), [GrowthCurveME](../GrowthCurveME/index.html), [growthcurver](../growthcurver/index.html), [iCAMP](../iCAMP/index.html), [ImFoR](../ImFoR/index.html), [lactater](../lactater/index.html), [LLSR](../LLSR/index.html), [Luminescence](../Luminescence/index.html), [marcher](../marcher/index.html), [MetaLandSim](../MetaLandSim/index.html), [methimpute](https://www.bioconductor.org/packages/release/bioc/html/methimpute.html), [MFO](../MFO/index.html), [mixchar](../mixchar/index.html), [mixtox](../mixtox/index.html), [mMARCH.AC](../mMARCH.AC/index.html), [MortalityLaws](../MortalityLaws/index.html), [MSstatsLOBD](https://www.bioconductor.org/packages/release/bioc/html/MSstatsLOBD.html), [nls.multstart](../nls.multstart/index.html), [NonlinearTSA](../NonlinearTSA/index.html), [OEFPIL](../OEFPIL/index.html), [OenoKPM](../OenoKPM/index.html), [optRF](../optRF/index.html), [oro.pet](../oro.pet/index.html), [OSLdecomposition](../OSLdecomposition/index.html), [pam](../pam/index.html), [peakPantheR](https://www.bioconductor.org/packages/release/bioc/html/peakPantheR.html), [pkpd.Release](../pkpd.Release/index.html), [postGGIR](../postGGIR/index.html), [PRA](../PRA/index.html), [pricelevels](../pricelevels/index.html), [ptairMS](https://www.bioconductor.org/packages/release/bioc/html/ptairMS.html), [PUPMSI](../PUPMSI/index.html), [QurvE](../QurvE/index.html), [rAmCharts4](../rAmCharts4/index.html), [rBiasCorrection](../rBiasCorrection/index.html), [respirometry](../respirometry/index.html), [RFlocalfdr](../RFlocalfdr/index.html), [Rquake](../Rquake/index.html), [sars](../sars/index.html), [scClassify](https://www.bioconductor.org/packages/release/bioc/html/scClassify.html), [seinfitR](../seinfitR/index.html), [semds](../semds/index.html), [sfadv](../sfadv/index.html), [shapes](../shapes/index.html), [shorts](../shorts/index.html), [sicegar](../sicegar/index.html), [soiltestcorr](../soiltestcorr/index.html), [SOMnmR](../SOMnmR/index.html), [spant](../spant/index.html), [STMr](../STMr/index.html), [temperatureresponse](../temperatureresponse/index.html), [TIMP](../TIMP/index.html), [trajeR](../trajeR/index.html), [TSAR](https://www.bioconductor.org/packages/release/bioc/html/TSAR.html), [vachette](../vachette/index.html), [whippr](../whippr/index.html), [xCell2](https://www.bioconductor.org/packages/release/bioc/html/xCell2.html), [xgxr](../xgxr/index.html), [YEAB](../YEAB/index.html) |
| Reverse suggests: | [biogas](../biogas/index.html), [bootGOF](../bootGOF/index.html), [CircaCP](../CircaCP/index.html), [devRate](../devRate/index.html), [nlmixr2est](../nlmixr2est/index.html), [nlmrt](../nlmrt/index.html), [nlraa](../nlraa/index.html), [nlsr](../nlsr/index.html), [pacu](../pacu/index.html), [pctax](../pctax/index.html), [REddyProc](../REddyProc/index.html), [rTPC](../rTPC/index.html), [simodels](../simodels/index.html), [timbeR](../timbeR/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=minpack.lm`](https://CRAN.R-project.org/package%3Dminpack.lm)
to link to this page.