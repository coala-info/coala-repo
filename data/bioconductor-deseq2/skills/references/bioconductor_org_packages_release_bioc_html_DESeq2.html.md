[Bioconductor
3.23](https://bioconductor.org/developers/release-schedule/) Release Schedule

[![Bioconductor home](/images/logo/svg/Logo.svg)](/)

[About](/about/)
[Learn](/help/)
[Packages](/packages/release/BiocViews.html#___Software)
[Developers](/developers/)

Search
![Search icon](/images/icons/search-icon.svg)

[Get Started](/install/)

###### Menu

* [Home](/)
* [Bioconductor 3.22](/packages/3.22/BiocViews.html)
* [Software Packages](/packages/3.22/bioc)
* DESeq2

# DESeq2

This is the **released** version of DESeq2; for the devel version, see
[DESeq2](/packages/devel/bioc/html/DESeq2.html).

## Differential gene expression analysis based on the negative binomial distribution

[![Platform availability badge](/shields/availability/release/DESeq2.svg "Whether the package is available on all platforms; click for details.")](#archives)
[![Ranking badge](/shields/downloads/release/DESeq2.svg "Ranking by number of downloads. A lower number means the package is downloaded more frequently. Determined within a package type (software, experiment, annotation, workflow) and uses the number of distinct IPs for the last 12 months.")](http://bioconductor.org/packages/stats/bioc/DESeq2/)
[![Support activity badge](/shields/posts/DESeq2.svg "Support site activity, last 6 months: answered posts / total posts.")](https://support.bioconductor.org/tag/deseq2)
[![Years in BioConductor badge](/shields/years-in-bioc/DESeq2.svg "How long since the package was first in a released Bioconductor version (or is it in devel only).")](#since)
[![Build results badge](/shields/build/release/bioc/DESeq2.svg "build results; click for full report")](https://bioconductor.org/checkResults/release/bioc-LATEST/DESeq2/)
[![Last commit badge](/shields/lastcommit/release/bioc/DESeq2.svg "time since last commit. possible values: today, < 1 week, < 1 month, < 3 months, since release, before release")](https://bioconductor.org/checkResults/release/bioc-LATEST/DESeq2/)
[![Dependency count badge](/shields/dependencies/release/DESeq2.svg "Number of recursive dependencies needed to install package.")](#since)

DOI:
[10.18129/B9.bioc.DESeq2](https://doi.org/doi%3A10.18129/B9.bioc.DESeq2 "DOI for use in publications, etc., will always redirect to current release version (or devel if package is not in release yet).")

**Bioconductor version:** Release (3.22)

Estimate variance-mean dependence in count data from high-throughput sequencing assays and test for differential expression based on a model using the negative binomial distribution.

**Author:** Michael Love [aut, cre], Constantin Ahlmann-Eltze [ctb], Kwame Forbes [ctb], Simon Anders [aut, ctb], Wolfgang Huber [aut, ctb], RADIANT EU FP7 [fnd], NIH NHGRI [fnd], CZI [fnd]

**Maintainer:** Michael Love <michaelisaiahlove at gmail.com>

**Citation (from within R, enter `citation("DESeq2")`):**

### Installation

To install this package, start R (version "4.5") and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")
```

For older versions of R, please refer to the appropriate [Bioconductor release](/about/release-announcements/).

### Documentation

To view documentation for the version of this package installed in your system, start R and enter:

```
browseVignettes("DESeq2")
```

|  |  |  |
| --- | --- | --- |
| Analyzing RNA-seq data with DESeq2 | [HTML](../vignettes/DESeq2/inst/doc/DESeq2.html) | [R Script](../vignettes/DESeq2/inst/doc/DESeq2.R) |
| Reference Manual | [PDF](../manuals/DESeq2/man/DESeq2.pdf) |
| NEWS | [Text](../news/DESeq2/NEWS) |

[Need some help? Ask on the Bioconductor Support site!](https://support.bioconductor.org/tag/deseq2)

### Details

|  |  |
| --- | --- |
| biocViews | [Bayesian](../../BiocViews.html#___Bayesian), [ChIPSeq](../../BiocViews.html#___ChIPSeq), [Clustering](../../BiocViews.html#___Clustering), [DifferentialExpression](../../BiocViews.html#___DifferentialExpression), [GeneExpression](../../BiocViews.html#___GeneExpression), [ImmunoOncology](../../BiocViews.html#___ImmunoOncology), [Normalization](../../BiocViews.html#___Normalization), [PrincipalComponent](../../BiocViews.html#___PrincipalComponent), [RNASeq](../../BiocViews.html#___RNASeq), [Regression](../../BiocViews.html#___Regression), [Sequencing](../../BiocViews.html#___Sequencing), [Software](../../BiocViews.html#___Software), [Transcription](../../BiocViews.html#___Transcription) |
| Version | 1.50.2 |
| In Bioconductor since | BioC 2.12 (R-3.0) (13 years) |
| License | LGPL (>= 3) |
| Depends | [S4Vectors](../../bioc/html/S4Vectors.html)(>= 0.23.18), [IRanges](../../bioc/html/IRanges.html), [GenomicRanges](../../bioc/html/GenomicRanges.html), [SummarizedExperiment](../../bioc/html/SummarizedExperiment.html)(>= 1.1.6) |
| Imports | [BiocGenerics](../../bioc/html/BiocGenerics.html)(>= 0.7.5), [Biobase](../../bioc/html/Biobase.html), [BiocParallel](../../bioc/html/BiocParallel.html), [matrixStats](http://cran.rstudio.com/web/packages/matrixStats/index.html), methods, stats4, [locfit](http://cran.rstudio.com/web/packages/locfit/index.html), [ggplot2](http://cran.rstudio.com/web/packages/ggplot2/index.html) (>= 3.4.0), [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) (>= 0.11.0), [MatrixGenerics](../../bioc/html/MatrixGenerics.html) |
| System Requirements |  |
| URL | <https://github.com/thelovelab/DESeq2> |

See More

|  |  |
| --- | --- |
| Suggests | [testthat](http://cran.rstudio.com/web/packages/testthat/index.html), [knitr](http://cran.rstudio.com/web/packages/knitr/index.html), [rmarkdown](http://cran.rstudio.com/web/packages/rmarkdown/index.html), [vsn](../../bioc/html/vsn.html), [pheatmap](http://cran.rstudio.com/web/packages/pheatmap/index.html), [RColorBrewer](http://cran.rstudio.com/web/packages/RColorBrewer/index.html), [apeglm](../../bioc/html/apeglm.html), [ashr](http://cran.rstudio.com/web/packages/ashr/index.html), [tximport](../../bioc/html/tximport.html), [tximeta](../../bioc/html/tximeta.html), [tximportData](../../data/experiment/html/tximportData.html), [readr](http://cran.rstudio.com/web/packages/readr/index.html), [pbapply](http://cran.rstudio.com/web/packages/pbapply/index.html), [airway](../../data/experiment/html/airway.html), [glmGamPoi](../../bioc/html/glmGamPoi.html), [BiocManager](http://cran.rstudio.com/web/packages/BiocManager/index.html) |
| Linking To | [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html), [RcppArmadillo](http://cran.rstudio.com/web/packages/RcppArmadillo/index.html) |
| Enhances |  |
| Depends On Me | [DEWSeq](../../bioc/html/DEWSeq.html), [DEXSeq](../../bioc/html/DEXSeq.html), [metaseqR2](../../bioc/html/metaseqR2.html), [octad](../../bioc/html/octad.html), [rgsepd](../../bioc/html/rgsepd.html), [SeqGSEA](../../bioc/html/SeqGSEA.html), [TCC](../../bioc/html/TCC.html), [tRanslatome](../../bioc/html/tRanslatome.html), [rnaseqDTU](../../workflows/html/rnaseqDTU.html), [rnaseqGene](../../workflows/html/rnaseqGene.html), [Anaconda](http://cran.rstudio.com/web/packages/Anaconda/index.html), [DRomics](http://cran.rstudio.com/web/packages/DRomics/index.html), [ordinalbayes](http://cran.rstudio.com/web/packages/ordinalbayes/index.html) |
| Imports Me | [Anaquin](../../bioc/html/Anaquin.html), [animalcules](../../bioc/html/animalcules.html), [BatchQC](../../bioc/html/BatchQC.html), [CeTF](../../bioc/html/CeTF.html), [circRNAprofiler](../../bioc/html/circRNAprofiler.html), [CleanUpRNAseq](../../bioc/html/CleanUpRNAseq.html), [consensusDE](../../bioc/html/consensusDE.html), [coseq](../../bioc/html/coseq.html), [countsimQC](../../bioc/html/countsimQC.html), [cypress](../../bioc/html/cypress.html), [DaMiRseq](../../bioc/html/DaMiRseq.html), [debrowser](../../bioc/html/debrowser.html), [DeeDeeExperiment](../../bioc/html/DeeDeeExperiment.html), [DEFormats](../../bioc/html/DEFormats.html), [DEGreport](../../bioc/html/DEGreport.html), [deltaCaptureC](../../bioc/html/deltaCaptureC.html), [DEsubs](../../bioc/html/DEsubs.html), [DiffBind](../../bioc/html/DiffBind.html), [DOtools](../../bioc/html/DOtools.html), [DspikeIn](../../bioc/html/DspikeIn.html), [easier](../../bioc/html/easier.html), [EBSEA](../../bioc/html/EBSEA.html), [ERSSA](../../bioc/html/ERSSA.html), [GDCRNATools](../../bioc/html/GDCRNATools.html), [GeneTonic](../../bioc/html/GeneTonic.html), [gg4way](../../bioc/html/gg4way.html), [Glimma](../../bioc/html/Glimma.html), [GRaNIE](../../bioc/html/GRaNIE.html), [hermes](../../bioc/html/hermes.html), [HTSFilter](../../bioc/html/HTSFilter.html), [HybridExpress](../../bioc/html/HybridExpress.html), [icetea](../../bioc/html/icetea.html), [ideal](../../bioc/html/ideal.html), [INSPEcT](../../bioc/html/INSPEcT.html), [IntEREst](../../bioc/html/IntEREst.html), [iSEEde](../../bioc/html/iSEEde.html), [isomiRs](../../bioc/html/isomiRs.html), [kissDE](../../bioc/html/kissDE.html), [magpie](../../bioc/html/magpie.html), [microbiomeExplorer](../../bioc/html/microbiomeExplorer.html), [MIRit](../../bioc/html/MIRit.html), [MLSeq](../../bioc/html/MLSeq.html), [mobileRNA](../../bioc/html/mobileRNA.html), [mosdef](../../bioc/html/mosdef.html), [MultiRNAflow](../../bioc/html/MultiRNAflow.html), [muscat](../../bioc/html/muscat.html), [NBAMSeq](../../bioc/html/NBAMSeq.html), [NetActivity](../../bioc/html/NetActivity.html), [ORFik](../../bioc/html/ORFik.html), [OUTRIDER](../../bioc/html/OUTRIDER.html), [pairedGSEA](../../bioc/html/pairedGSEA.html), [PathoStat](../../bioc/html/PathoStat.html), [pcaExplorer](../../bioc/html/pcaExplorer.html), [phantasus](../../bioc/html/phantasus.html), [POMA](../../bioc/html/POMA.html), [proActiv](../../bioc/html/proActiv.html), [RegEnrich](../../bioc/html/RegEnrich.html), [regionReport](../../bioc/html/regionReport.html), [ReportingTools](../../bioc/html/ReportingTools.html), [RiboDiPA](../../bioc/html/RiboDiPA.html), [Rmmquant](../../bioc/html/Rmmquant.html), [saseR](../../bioc/html/saseR.html), [scBFA](../../bioc/html/scBFA.html), [scGPS](../../bioc/html/scGPS.html), [scQTLtools](../../bioc/html/scQTLtools.html), [SEtools](../../bioc/html/SEtools.html), [singleCellTK](../../bioc/html/singleCellTK.html), [SNPhood](../../bioc/html/SNPhood.html), [srnadiff](../../bioc/html/srnadiff.html), [SurfR](../../bioc/html/SurfR.html), [systemPipeTools](../../bioc/html/systemPipeTools.html), [TBSignatureProfiler](../../bioc/html/TBSignatureProfiler.html), [TEKRABber](../../bioc/html/TEKRABber.html), [terapadog](../../bioc/html/terapadog.html), [UMI4Cats](../../bioc/html/UMI4Cats.html), [vidger](../../bioc/html/vidger.html), [vulcan](../../bioc/html/vulcan.html), [zitools](../../bioc/html/zitools.html), [BloodCancerMultiOmics2017](../../data/experiment/html/BloodCancerMultiOmics2017.html), [FieldEffectCrc](../../data/experiment/html/FieldEffectCrc.html), [homosapienDEE2CellScore](../../data/experiment/html/homosapienDEE2CellScore.html), [IHWpaper](../../data/experiment/html/IHWpaper.html), [ExpHunterSuite](../../workflows/html/ExpHunterSuite.html), [recountWorkflow](../../workflows/html/recountWorkflow.html), [autoGO](http://cran.rstudio.com/web/packages/autoGO/index.html), [cinaR](http://cran.rstudio.com/web/packages/cinaR/index.html), [ExpGenetic](http://cran.rstudio.com/web/packages/ExpGenetic/index.html), [HEssRNA](http://cran.rstudio.com/web/packages/HEssRNA/index.html), [limorhyde2](http://cran.rstudio.com/web/packages/limorhyde2/index.html), [microbial](http://cran.rstudio.com/web/packages/microbial/index.html), [RCPA](http://cran.rstudio.com/web/packages/RCPA/index.html), [RNAseqQC](http://cran.rstudio.com/web/packages/RNAseqQC/index.html), [sRNAGenetic](http://cran.rstudio.com/web/packages/sRNAGenetic/index.html), [TransProR](http://cran.rstudio.com/web/packages/TransProR/index.html), [wilson](http://cran.rstudio.com/web/packages/wilson/index.html) |
| Suggests Me | [aggregateBioVar](../../bioc/html/aggregateBioVar.html), [apeglm](../../bioc/html/apeglm.html), [bambu](../../bioc/html/bambu.html), [BindingSiteFinder](../../bioc/html/BindingSiteFinder.html), [biobroom](../../bioc/html/biobroom.html), [BiocGenerics](../../bioc/html/BiocGenerics.html), [BioCor](../../bioc/html/BioCor.html), [BiocSet](../../bioc/html/BiocSet.html), [BioNERO](../../bioc/html/BioNERO.html), [CAGEr](../../bioc/html/CAGEr.html), [compcodeR](../../bioc/html/compcodeR.html), [dar](../../bioc/html/dar.html), [dearseq](../../bioc/html/dearseq.html), [derfinder](../../bioc/html/derfinder.html), [dittoSeq](../../bioc/html/dittoSeq.html), [EDASeq](../../bioc/html/EDASeq.html), [EnhancedVolcano](../../bioc/html/EnhancedVolcano.html), [EnrichmentBrowser](../../bioc/html/EnrichmentBrowser.html), [EWCE](../../bioc/html/EWCE.html), [extraChIPs](../../bioc/html/extraChIPs.html), [fishpond](../../bioc/html/fishpond.html), [gage](../../bioc/html/gage.html), [GeDi](../../bioc/html/GeDi.html), [GenomicAlignments](../../bioc/html/GenomicAlignments.html), [GenomicRanges](../../bioc/html/GenomicRanges.html), [GeoTcgaData](../../bioc/html/GeoTcgaData.html), [geyser](../../bioc/html/geyser.html), [glmGamPoi](../../bioc/html/glmGamPoi.html), [HiCDCPlus](../../bioc/html/HiCDCPlus.html), [IHW](../../bioc/html/IHW.html), [InteractiveComplexHeatmap](../../bioc/html/InteractiveComplexHeatmap.html), [methodical](../../bioc/html/methodical.html), [OPWeight](../../bioc/html/OPWeight.html), [pathlinkR](../../bioc/html/pathlinkR.html), [PCAtools](../../bioc/html/PCAtools.html), [phyloseq](../../bioc/html/phyloseq.html), [progeny](../../bioc/html/progeny.html), [QRscore](../../bioc/html/QRscore.html), [raer](../../bioc/html/raer.html), [recount](../../bioc/html/recount.html), [ribosomeProfilingQC](../../bioc/html/ribosomeProfilingQC.html), [roastgsa](../../bioc/html/roastgsa.html), [RUVSeq](../../bioc/html/RUVSeq.html), [Rvisdiff](../../bioc/html/Rvisdiff.html), [scran](../../bioc/html/scran.html), [sparrow](../../bioc/html/sparrow.html), [spatialHeatmap](../../bioc/html/spatialHeatmap.html), [SpliceWiz](../../bioc/html/SpliceWiz.html), [subSeq](../../bioc/html/subSeq.html), [systemPipeR](../../bioc/html/systemPipeR.html), [systemPipeShiny](../../bioc/html/systemPipeShiny.html), [TFEA.ChIP](../../bioc/html/TFEA.ChIP.html), [tidybulk](../../bioc/html/tidybulk.html), [topconfects](../../bioc/html/topconfects.html), [tximeta](../../bioc/html/tximeta.html), [tximport](../../bioc/html/tximport.html), [variancePartition](../../bioc/html/variancePartition.html), [Wrench](../../bioc/html/Wrench.html), [zinbwave](../../bioc/html/zinbwave.html), [ChIPDBData](../../data/experiment/html/ChIPDBData.html), [curatedAdipoChIP](../../data/experiment/html/curatedAdipoChIP.html), [curatedAdipoRNA](../../data/experiment/html/curatedAdipoRNA.html), [GSE62944](../../data/experiment/html/GSE62944.html), [RegParallel](../../data/experiment/html/RegParallel.html), [Single.mTEC.Transcriptomes](../../data/experiment/html/Single.mTEC.Transcriptomes.html), [CAGEWorkflow](../../workflows/html/CAGEWorkflow.html), [fluentGenomics](../../workflows/html/fluent