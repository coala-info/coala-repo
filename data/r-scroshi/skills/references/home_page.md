## scROSHI: Robust Supervised Hierarchical Identification of Single Cells

Identifying cell types based on expression profiles is a pillar of single cell analysis. 'scROSHI' identifies cell types based on expression profiles of single cell analysis by utilizing previously obtained cell type specific gene sets. It takes into account the hierarchical nature of cell type relationship and does not require training or annotated data. A detailed description of the method can be found at: Prummer, Bertolini, Bosshard, Barkmann, Yates, Boeva, The Tumor Profiler Consortium, Stekhoven, and Singer (2022) <[doi:10.1101/2022.04.05.487176](https://doi.org/10.1101/2022.04.05.487176)>.

|  |  |
| --- | --- |
| Version: | 1.0.0.0 |
| Depends: | R (≥ 3.60) |
| Imports: | [limma](https://www.bioconductor.org/packages/release/bioc/html/limma.html), [S4Vectors](https://www.bioconductor.org/packages/release/bioc/html/S4Vectors.html), [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html), stats, [SummarizedExperiment](https://www.bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html), utils, [uwot](../uwot/index.html) |
| Published: | 2023-01-10 |
| DOI: | [10.32614/CRAN.package.scROSHI](https://doi.org/10.32614/CRAN.package.scROSHI) |
| Author: | Lars Bosshard [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0002-4550-4777) [aut, cre], Michael Prummer [![ORCID iD](../../orcid.svg)](https://orcid.org/0000-0001-9896-3929) [aut] |
| Maintainer: | Lars Bosshard <bosshard at nexus.ethz.ch> |
| License: | [MIT](../../licenses/MIT) + file <LICENSE> |
| NeedsCompilation: | no |
| Materials: | [README](readme/README.html) |
| CRAN checks: | [scROSHI results](../../checks/check_results_scROSHI.html) |

#### Documentation:

|  |  |
| --- | --- |
| Reference manual: | [scROSHI.html](refman/scROSHI.html) , <scROSHI.pdf> |

#### Downloads:

|  |  |
| --- | --- |
| Package source: | [scROSHI\_1.0.0.0.tar.gz](../../../src/contrib/scROSHI_1.0.0.0.tar.gz) |
| Windows binaries: | r-devel: [scROSHI\_1.0.0.0.zip](../../../bin/windows/contrib/4.6/scROSHI_1.0.0.0.zip), r-release: [scROSHI\_1.0.0.0.zip](../../../bin/windows/contrib/4.5/scROSHI_1.0.0.0.zip), r-oldrel: [scROSHI\_1.0.0.0.zip](../../../bin/windows/contrib/4.4/scROSHI_1.0.0.0.zip) |
| macOS binaries: | r-release (arm64): [scROSHI\_1.0.0.0.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.5/scROSHI_1.0.0.0.tgz), r-oldrel (arm64): [scROSHI\_1.0.0.0.tgz](../../../bin/macosx/big-sur-arm64/contrib/4.4/scROSHI_1.0.0.0.tgz), r-release (x86\_64): [scROSHI\_1.0.0.0.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.5/scROSHI_1.0.0.0.tgz), r-oldrel (x86\_64): [scROSHI\_1.0.0.0.tgz](../../../bin/macosx/big-sur-x86_64/contrib/4.4/scROSHI_1.0.0.0.tgz) |

#### Linking:

Please use the canonical form
[`https://CRAN.R-project.org/package=scROSHI`](https://CRAN.R-project.org/package%3DscROSHI)
to link to this page.