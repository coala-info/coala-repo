Overview of vignettes for copy number estimation

Rob Scharpf

October 29, 2025

The workflow for copy number analyses in the crlmm package includes preprocessing and genotyping of
the raw intensities followed by estimation of parameters for copy number estimation using crlmmCopynumber.
Supported platforms are those for which a corresponding annotation package is available. Table ?? provides
an overview of the available vignettes pertaining to copy number estimation. These vignettes are located in
the inst/scripts subdirectory of the crlmm package. HapMap datasets are used to illustrate the workflow
and are not provided as part of the crlmm package. Users wishing to reproduce the analysis should download
the HapMap CEL files (Affymetrix) or the idat files (Illumina) and modify the paths to the raw data files
as appropriate.

Vignette
Infrastructure

Platform
Affy/Illumina

Annotation package

AffyGW

Affy 5.0, 6.0

IlluminaPreprocessCN Illumina

genomewidesnp5crlmml,
genomewidesnp6Crlmm
several†

Scope
The CNSet container / large data
support using the ff package
Preprocessing, genotyping, CN
estimation
Preprocessing, genotyping, CN
estimation

Table 1: Vignettes for copy number estimation.
supported Illumina/Affy platforms

† See annotationPackages() for a complete listing of

The Infrastructure vignette provides additional details on the CNSet container used to organize the

processed data as well as a brief discussion regarding large data support through the ff package.

1

