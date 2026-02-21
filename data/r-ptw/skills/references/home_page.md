## ptw: Parametric Time Warping

Parametric Time Warping aligns patterns, i.e., it aims to
put corresponding features at the same locations. The algorithm
searches for an optimal polynomial describing the warping. It
is possible to align one sample to a reference, several samples
to the same reference, or several samples to several
references. One can choose between calculating individual
warpings, or one global warping for a set of samples and one
reference. Two optimization criteria are implemented: RMS (Root
Mean Square error) and WCC (Weighted Cross Correlation). Both
warping of peak profiles and of peak lists are supported. A
vignette for the latter is contained in the inst/doc directory
of the source package - the vignette source can be found on
the package github site. See 'citation("ptw")' for more details.

|  |  |
| --- | --- |
| Version: | 1.9-17 |
| Imports: | [RcppDE](../RcppDE/index.html), graphics, grDevices, stats |
| Published: | 2026-01-22 |
| DOI: | [10.32614/CRAN.package.ptw](https://doi.org/10.32614/CRAN.package.ptw) |
| Author: | Jan Gerretzen [ctb], Paul Eilers [aut], Hans Wouters [ctb], Tom Bloemberg [aut], Ron Wehrens [aut, cre] |
| Maintainer: | Ron Wehrens <ron.wehrens at gmail.com> |
| BugReports: | <https://github.com/rwehrens/ptw/issues> |
| License: | [GPL-2](../../licenses/GPL-2) | [GPL-3](../../licenses/GPL-3) [expanded from: GPL (≥ 2)] |
| URL: | <https://github.com/rwehrens/ptw> |
| NeedsCompilation: | yes |
| Citation: | [ptw citation info](citation.html) |
| Materials: | <NEWS> |
| In views: | [TimeSeries](../../views/TimeSeries.html) |
| CRAN checks: | [ptw results](../../checks/check_results_ptw.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [ptw.html](refman/ptw.html) , <ptw.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [ptw\_1.9-17.tar.gz](../../../src/contrib/ptw_1.9-17.tar.gz) |
| Windows binaries: | r-devel: [ptw\_1.9-17.zip](../../../bin/windows/contrib/4.6/ptw_1.9-17.zip), r-release: [ptw\_1.9-17.zip](../../../bin/windows/contrib/4.5/ptw_1.9-17.zip), r-oldrel: [ptw\_1.9-17.zip](../../../bin/windows/contrib/4.4/ptw_1.9-17.zip) |
| macOS binaries: | r-release (arm64): [ptw\_1.9-17.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/ptw_1.9-17.tgz), r-oldrel (arm64): [ptw\_1.9-17.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/ptw_1.9-17.tgz), r-release (x86\_64): [ptw\_1.9-17.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/ptw_1.9-17.tgz), r-oldrel (x86\_64): [ptw\_1.9-17.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/ptw_1.9-17.tgz) |
| Old sources: | [ptw archive](https://CRAN.R-project.org/src/contrib/Archive/ptw) |

#### Reverse dependencies:

|  |  |
| --- | --- |
| Reverse depends: | [RGCxGC](../RGCxGC/index.html), [RpeakChrom](../RpeakChrom/index.html) |
| Reverse imports: | [chipPCR](../chipPCR/index.html), [gcxgclab](../gcxgclab/index.html), [PepsNMR](https://www.bioconductor.org/packages/release/bioc/html/PepsNMR.html), [Rnmr1D](../Rnmr1D/index.html), [spant](../spant/index.html) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=ptw`](https://CRAN.R-project.org/package%3Dptw)
to link to this page.