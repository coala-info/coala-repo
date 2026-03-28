scHiCExplorer

latest

* [Installation](content/installation.html)
* [scHiCExplorer tools](content/list-of-tools.html)
* [News](content/News.html)
* [Analysis of single-cell Hi-C data](content/Example_analysis.html)

scHiCExplorer

* Docs »
* scHiCExplorer
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/index.rst)

---

# scHiCExplorer[¶](#schicexplorer "Permalink to this headline")

## Set of programs to process, normalize, analyse and visualize single-cell Hi-C data[¶](#set-of-programs-to-process-normalize-analyse-and-visualize-single-cell-hi-c-data "Permalink to this headline")

## Citation[¶](#citation "Permalink to this headline")

Joachim Wolff, Leily Rabbani, Ralf Gilsbach, Gautier Richard, Thomas Manke, Rolf Backofen, Björn A Grüning.
**Galaxy HiCExplorer 3: a web server for reproducible Hi-C, capture Hi-C and single-cell Hi-C data analysis, quality control and visualization, Nucleic Acids Research**, <https://doi.org/10.1093/nar/gkaa220>

## Availability[¶](#availability "Permalink to this headline")

scHiCExplorer is available as a **command line suite of tools** on this [GitHub repository](https://github.com/joachimwolff/scHiCExplorer). scHiCExplorer is a general use single-cell Hi-C analysis software,
to process raw single-cell Hi-C data we provide a demultiplexing tool for data provided by Nagano 2017. For all other protocols the pre-processing (demultiplexing, trimming) must be computed by third party tools.
However, as long as per cell one forward and reverse mapped BAM/SAM file is provided, scHiCExplorer is able to process it.

## The following is the list of tools available in scHiCExplorer[¶](#the-following-is-the-list-of-tools-available-in-schicexplorer "Permalink to this headline")

| tool | description |
| --- | --- |
| [scHicDemultiplex](content/tools/scHicDemultiplex.html#schicdemultiplex) | Demultiplexes the samples by their barcodes to one FASTQ file per samples |
| [scHicMergeToSCool](content/tools/scHicMergeToSCool.html#schicmergetoscool) | Merges all single-cell Hi-C matrices to one |
| [scHicCreateBulkMatrix](content/tools/scHicCreateBulkMatrix.html#schiccreatebulkmatrix) | Compute the bulk matrix out of all single-cell Hi-C matrices |
| [scHicMergeMatrixBins](content/tools/scHicMergeMatrixBins.html#schicmergematrixbins) | Changes the resolution of the matrices |
| [scHicQualityControl](content/tools/scHicQualityControl.html#schicqualitycontrol) | Estimates the quality of scHi-C datasets |
| [scHicAdjustMatrix](content/tools/scHicAdjustMatrix.html#schicadjustmatrix) | Keeps / removes chromosomes / contigs / scaffolds of all samples |
| [scHicNormalize](content/tools/scHicNormalize.html#schicnormalize) | Normalizes the read coverage of all samples to the lowest read coverage |
| [scHicCorrectMatrices](content/tools/scHicCorrectMatrices.html#schiccorrectmatrices) | Corrects all samples with Knight-Ruiz correction |
| [scHicInfo](content/tools/scHicInfo.html#schicinfo) | Retrieve information about the mcool matrix |
| [scHicCluster](content/tools/scHicCluster.html#schiccluster) | Cluster all samples on raw data or uses dimension reduction knn or pca |
| [scHicClusterMinHash](content/tools/scHicClusterMinHash.html#schicclusterminhash) | Cluster all samples on knn computed by approximate knn search via LSH |
| [scHicQualityControl](content/tools/scHicClusterSVL.html#schicclustersvl) | Cluster all samples based on short vs long range contact ratio |
| [scHicClusterCompartments](content/tools/scHicClusterCompartments.html#schicclustercompartments) | Cluster all samples based on A / B scHicClusterCompartments |
| [scHicConsensusMatrices](content/tools/scHicConsensusMatrices.html#schicconsensusmatrices) | Computes the consensus matrices based on clustering |
| [scHicPlotClusterProfiles](content/tools/scHicPlotClusterProfiles.html#schicplotclusterprofiles) | Plots the cluster profiles with all samples |
| [scHicPlotConsensusMatrices](content/tools/scHicPlotConsenusMatrices.html#schicplotconsensusmatrices) | Estimates the quality of Hi-C dataset |

## Getting Help[¶](#getting-help "Permalink to this headline")

* For all kind of questions, suggesting changes/enhancements and to report bugs, please create an issue on [our GitHub repository](https://github.com/joachimwolff/scHiCExplorer)

## Contents:[¶](#contents "Permalink to this headline")

* [Installation](content/installation.html)
  + [Requirements](content/installation.html#requirements)
  + [Command line installation using `conda`](content/installation.html#command-line-installation-using-conda)
  + [Command line installation with source code](content/installation.html#command-line-installation-with-source-code)
* [scHiCExplorer tools](content/list-of-tools.html)
  + [General principles](content/list-of-tools.html#general-principles)
  + [Tools for demultiplexing of raw fastq files](content/list-of-tools.html#tools-for-demultiplexing-of-raw-fastq-files)
  + [Tools for single-cell Hi-C data pre-preprocessing](content/list-of-tools.html#tools-for-single-cell-hi-c-data-pre-preprocessing)
  + [Tools for information about the single-cell Hi-C matrix](content/list-of-tools.html#tools-for-information-about-the-single-cell-hi-c-matrix)
  + [Tools for single-cell Hi-C QC](content/list-of-tools.html#tools-for-single-cell-hi-c-qc)
  + [Tools for Hi-C data analysis](content/list-of-tools.html#tools-for-hi-c-data-analysis)
  + [Tools for single-cell Hi-C visualization](content/list-of-tools.html#tools-for-single-cell-hi-c-visualization)
* [News](content/News.html)
* [Analysis of single-cell Hi-C data](content/Example_analysis.html)
  + [Download of the fastq files](content/Example_analysis.html#download-of-the-fastq-files)
  + [Demultiplexing](content/Example_analysis.html#demultiplexing)
  + [Mapping](content/Example_analysis.html#mapping)
  + [Creation of Hi-C interaction matrices](content/Example_analysis.html#creation-of-hi-c-interaction-matrices)
  + [Quality control](content/Example_analysis.html#quality-control)
  + [Removal of chromosomes / contigs / scaffolds](content/Example_analysis.html#removal-of-chromosomes-contigs-scaffolds)
  + [Normalization](content/Example_analysis.html#normalization)
  + [Correction](content/Example_analysis.html#correction)
  + [Analysis](content/Example_analysis.html#analysis)
  + [Bulk matrix](content/Example_analysis.html#bulk-matrix)

This tool suite is developed by Joachim Wolff from the [Bioinformatics Lab](http://bioinf.uni-freiburg.de/) of the [Albert-Ludwigs-University Freiburg](http://www.uni-freiburg.de), Germany.

[Next](content/installation.html "Installation")

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).