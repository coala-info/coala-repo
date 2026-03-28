[scHiCExplorer](../index.html)

latest

* [Installation](installation.html)
* scHiCExplorer tools
  + [General principles](#general-principles)
  + [Tools for demultiplexing of raw fastq files](#tools-for-demultiplexing-of-raw-fastq-files)
    - [scHicDemultiplex](#schicdemultiplex)
  + [Tools for single-cell Hi-C data pre-preprocessing](#tools-for-single-cell-hi-c-data-pre-preprocessing)
    - [scHicAdjustMatrix](#schicadjustmatrix)
    - [scHicCorrectMatrices](#schiccorrectmatrices)
    - [scHicMergeMatrixBins](#schicmergematrixbins)
    - [scHicMergeToScool](#schicmergetoscool)
    - [scHicNormalize](#schicnormalize)
    - [scHicManageScool](#schicmanagescool)
    - [scHicConvertFormat](#schicconvertformat)
  + [Tools for information about the single-cell Hi-C matrix](#tools-for-information-about-the-single-cell-hi-c-matrix)
    - [scHicInfo](#schicinfo)
  + [Tools for single-cell Hi-C QC](#tools-for-single-cell-hi-c-qc)
    - [scHicQualityControl](#schicqualitycontrol)
  + [Tools for Hi-C data analysis](#tools-for-hi-c-data-analysis)
    - [scHicCluster](#schiccluster)
    - [scHicClusterCompartments](#schicclustercompartments)
    - [scHicClusterMinHash](#schicclusterminhash)
    - [scHicClusterSVL](#schicclustersvl)
    - [scHicConsensusMatrices](#schicconsensusmatrices)
  + [Tools for single-cell Hi-C visualization](#tools-for-single-cell-hi-c-visualization)
    - [scHicPlotClusterProfiles](#schicplotclusterprofiles)
    - [scHicPlotConsensusMatrices](#schicplotconsensusmatrices)
* [News](News.html)
* [Analysis of single-cell Hi-C data](Example_analysis.html)

[scHiCExplorer](../index.html)

* [Docs](../index.html) »
* scHiCExplorer tools
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/list-of-tools.rst)

---

# scHiCExplorer tools[¶](#schicexplorer-tools "Permalink to this headline")

* [General principles](#general-principles)
* [Tools for demultiplexing of raw fastq files](#tools-for-demultiplexing-of-raw-fastq-files)

  + [[scHicDemultiplex](tools/scHicDemultiplex.html#schicdemultiplex)](#schicdemultiplex)
* [Tools for single-cell Hi-C data pre-preprocessing](#tools-for-single-cell-hi-c-data-pre-preprocessing)

  + [[scHicAdjustMatrix](tools/scHicAdjustMatrix.html#schicadjustmatrix)](#schicadjustmatrix)
  + [[scHicCorrectMatrices](tools/scHicCorrectMatrices.html#schiccorrectmatrices)](#schiccorrectmatrices)
  + [[scHicMergeMatrixBins](tools/scHicMergeMatrixBins.html#schicmergematrixbins)](#schicmergematrixbins)
  + [[scHicMergeToSCool](tools/scHicMergeToSCool.html#schicmergetoscool)](#schicmergetoscool)
  + [[scHicNormalize](tools/scHicNormalize.html#schicnormalize)](#schicnormalize)
  + [[scHicManageScool](tools/scHicManageScool.html#schicmanagescool)](#schicmanagescool)
  + [[scHicConvertFormat](tools/scHicConvertFormat.html#schicconvertformat)](#schicconvertformat)
* [Tools for information about the single-cell Hi-C matrix](#tools-for-information-about-the-single-cell-hi-c-matrix)

  + [[scHicInfo](tools/scHicInfo.html#schicinfo)](#schicinfo)
* [Tools for single-cell Hi-C QC](#tools-for-single-cell-hi-c-qc)

  + [[scHicQualityControl](tools/scHicQualityControl.html#schicqualitycontrol)](#schicqualitycontrol)
* [Tools for Hi-C data analysis](#tools-for-hi-c-data-analysis)

  + [[scHicCluster](tools/scHicCluster.html#schiccluster)](#schiccluster)
  + [[scHicClusterCompartments](tools/scHicClusterCompartments.html#schicclustercompartments)](#schicclustercompartments)
  + [[scHicClusterMinHash](tools/scHicClusterMinHash.html#schicclusterminhash)](#schicclusterminhash)
  + [[scHicQualityControl](tools/scHicClusterSVL.html#schicclustersvl)](#schicclustersvl)
  + [[scHicConsensusMatrices](tools/scHicConsensusMatrices.html#schicconsensusmatrices)](#schicconsensusmatrices)
* [Tools for single-cell Hi-C visualization](#tools-for-single-cell-hi-c-visualization)

  + [[scHicPlotClusterProfiles](tools/scHicPlotClusterProfiles.html#schicplotclusterprofiles)](#schicplotclusterprofiles)
  + [[scHicPlotConsensusMatrices](tools/scHicPlotConsenusMatrices.html#schicplotconsensusmatrices)](#schicplotconsensusmatrices)

| tool | type | input files | main output file(s) | application |
| --- | --- | --- | --- | --- |
| [scHicDemultiplex](tools/scHicDemultiplex.html#schicdemultiplex) | preprocessing | 1 FASTQ file SRR to sample mapping file Barcode file | 2\*n demultiplexed FASTQ files | Demultiplexes the samples by their barcodes to one FASTQ file per samples |
| [scHicMergeToSCool](tools/scHicMergeToSCool.html#schicmergetoscool) | preprocessing | n Hi-C matrices in cool format | One scool file containg all Hi-C matrices | Merges all single-cell Hi-C matrices to one |
| [scHicManageScool](tools/scHicManageScool.html#schicmanagescool) | preprocessing | scool Hi-C matrix | one scool matrix or cool matrix | update old version 4 of scHiCExplorer scool file to new scool file of version 5 |
| [scHicConvertFormat](tools/scHicConvertFormat.html#schicconvertformat) | preprocessing | scool Hi-C matrix | scHiCluster data | Converts scool to scHiCluster files |
| [scHicMergeMatrixBins](tools/scHicMergeMatrixBins.html#schicmergematrixbins) | preprocessing | scool Hi-C matrix | scool Hi-C matrix | Changes the resolution of the matrices |
| [scHicQualityControl](tools/scHicQualityControl.html#schicqualitycontrol) | preprocessing | scool Hi-C matrix | One scool file, two qc images, qc report | Checks the quality of all samples and removes bad ones |
| [scHicAdjustMatrix](tools/scHicAdjustMatrix.html#schicadjustmatrix) | preprocessing | scool Hi-C matrix | scool Hi-C matrix | Keeps / removes chromosomes / contigs / scaffolds of all samples |
| [scHicNormalize](tools/scHicNormalize.html#schicnormalize) | preprocessing | scool Hi-C matrix | scool Hi-C matrix | Normalizes the read coverage of all samples to the lowest read coverage |
| [scHicCorrectMatrices](tools/scHicCorrectMatrices.html#schiccorrectmatrices) | preprocessing | scool Hi-C matrix | scool Hi-C matrix | Corrects all samples with Knight-Ruiz correction |
| [scHicInfo](tools/scHicInfo.html#schicinfo) | information | scool Hi-C matrix | information about the scool matrix | Retrieve information about the scool matrix: resolution, number of samples, etc |
| [scHicCreateBulkMatrix](tools/scHicCreateBulkMatrix.html#schiccreatebulkmatrix) | analysis | scool Hi-C matrix | cool Hi-C matrix | Changes the resolution of the matrices |
| [scHicCluster](tools/scHicCluster.html#schiccluster) | analysis | scool Hi-C matrix | text file with sample to cluster association | Cluster all samples on raw data or uses dimension reduction knn or pca |
| [scHicClusterMinHash](tools/scHicClusterMinHash.html#schicclusterminhash) | analysis | scool Hi-C matrix | text file with sample to cluster association | Cluster all samples on knn computed by approximate knn search via LSH |
| [scHicQualityControl](tools/scHicClusterSVL.html#schicclustersvl) | analysis | scool Hi-C matrix | text file with sample to cluster association | Cluster all samples based on short vs long range contact ratio |
| [scHicClusterCompartments](tools/scHicClusterCompartments.html#schicclustercompartments) | analysis | scool Hi-C matrix (gene or histone track) | text file with sample to cluster association | Cluster all samples based on A / B scHicClusterCompartments |
| [scHicConsensusMatrices](tools/scHicConsensusMatrices.html#schicconsensusmatrices) | analysis | scool Hi-C matrix, txt file sample to cluster association | scool Hi-C matrix with consensus matrices | Computes the consensus matrices based on clustering |
| [scHicPlotClusterProfiles](tools/scHicPlotClusterProfiles.html#schicplotclusterprofiles) | visualization | scool Hi-C matrix txt file sample to cluster association | one image with cluster profiles | Plots the cluster profiles with all samples |
| [scHicPlotConsensusMatrices](tools/scHicPlotConsenusMatrices.html#schicplotconsensusmatrices) | visualization | scool Hi-C matrix txt file sample to cluster association | one image with consensus matrices | Plots the cluster consensus matrices |

## [General principles](#id1)[¶](#general-principles "Permalink to this headline")

A typical scHiCExplorer command could look like this:

```
$ scHicPlotClusterProfiles -m matrix.scool \
-o cluster_profiles.png \
-c computed_clusters.txt \
--dpi 300
```

You can always see all available command-line options via –help:

```
$ scHicInfo -m matrix.scool
```

## [Tools for demultiplexing of raw fastq files](#id2)[¶](#tools-for-demultiplexing-of-raw-fastq-files "Permalink to this headline")

### [[scHicDemultiplex](tools/scHicDemultiplex.html#schicdemultiplex)](#id3)[¶](#schicdemultiplex "Permalink to this headline")

## [Tools for single-cell Hi-C data pre-preprocessing](#id4)[¶](#tools-for-single-cell-hi-c-data-pre-preprocessing "Permalink to this headline")

### [[scHicAdjustMatrix](tools/scHicAdjustMatrix.html#schicadjustmatrix)](#id5)[¶](#schicadjustmatrix "Permalink to this headline")

### [[scHicCorrectMatrices](tools/scHicCorrectMatrices.html#schiccorrectmatrices)](#id6)[¶](#schiccorrectmatrices "Permalink to this headline")

### [[scHicMergeMatrixBins](tools/scHicMergeMatrixBins.html#schicmergematrixbins)](#id7)[¶](#schicmergematrixbins "Permalink to this headline")

### [[scHicMergeToSCool](tools/scHicMergeToSCool.html#schicmergetoscool)](#id8)[¶](#schicmergetoscool "Permalink to this headline")

### [[scHicNormalize](tools/scHicNormalize.html#schicnormalize)](#id9)[¶](#schicnormalize "Permalink to this headline")

### [[scHicManageScool](tools/scHicManageScool.html#schicmanagescool)](#id10)[¶](#schicmanagescool "Permalink to this headline")

### [[scHicConvertFormat](tools/scHicConvertFormat.html#schicconvertformat)](#id11)[¶](#schicconvertformat "Permalink to this headline")

## [Tools for information about the single-cell Hi-C matrix](#id12)[¶](#tools-for-information-about-the-single-cell-hi-c-matrix "Permalink to this headline")

### [[scHicInfo](tools/scHicInfo.html#schicinfo)](#id13)[¶](#schicinfo "Permalink to this headline")

## [Tools for single-cell Hi-C QC](#id14)[¶](#tools-for-single-cell-hi-c-qc "Permalink to this headline")

### [[scHicQualityControl](tools/scHicQualityControl.html#schicqualitycontrol)](#id15)[¶](#schicqualitycontrol "Permalink to this headline")

## [Tools for Hi-C data analysis](#id16)[¶](#tools-for-hi-c-data-analysis "Permalink to this headline")

### [[scHicCluster](tools/scHicCluster.html#schiccluster)](#id17)[¶](#schiccluster "Permalink to this headline")

### [[scHicClusterCompartments](tools/scHicClusterCompartments.html#schicclustercompartments)](#id18)[¶](#schicclustercompartments "Permalink to this headline")

### [[scHicClusterMinHash](tools/scHicClusterMinHash.html#schicclusterminhash)](#id19)[¶](#schicclusterminhash "Permalink to this headline")

### [[scHicQualityControl](tools/scHicClusterSVL.html#schicclustersvl)](#id20)[¶](#schicclustersvl "Permalink to this headline")

### [[scHicConsensusMatrices](tools/scHicConsensusMatrices.html#schicconsensusmatrices)](#id21)[¶](#schicconsensusmatrices "Permalink to this headline")

## [Tools for single-cell Hi-C visualization](#id22)[¶](#tools-for-single-cell-hi-c-visualization "Permalink to this headline")

### [[scHicPlotClusterProfiles](tools/scHicPlotClusterProfiles.html#schicplotclusterprofiles)](#id23)[¶](#schicplotclusterprofiles "Permalink to this headline")

### [[scHicPlotConsensusMatrices](tools/scHicPlotConsenusMatrices.html#schicplotconsensusmatrices)](#id24)[¶](#schicplotconsensusmatrices "Permalink to this headline")

[Next](News.html "News")
 [Previous](installation.html "Installation")

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).