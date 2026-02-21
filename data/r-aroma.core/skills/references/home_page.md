[Skip to main content](#content)

Toggle navigation

[Aroma](index.html "The Aroma Project")

* [Get Started](getstarted/index.html)
* [Documentation](docs/index.html)
* [Features](features/index.html)
* [Resources](resources/index.html)
* [Forum](forum/index.html)
* [FAQ](FAQ/index.html)
* [Developers' Corner](developers/index.html)
* [About](about/index.html)

News and recent updates:

* 2022-11-15: [aroma.core 3.3.0](install/) released
* 2022-07-21: [R.filesets 2.15.0](install/) released
* 2022-07-18: [aroma.affymetrix 3.2.1](install/) released
* 2021-10-23: [PSCBS 0.66.0](install/) released
* 2021-01-11: The Aroma Project turns 15 years!
* 2021-01-05: [aroma.core 3.2.2](install/) released

# An open-source R framework for your microarray analysis

![ChromosomeExplorer](data:image/png;base64...)
![ArrayExplorer](data:image/png;base64...)
![FIRMA and alternative splicing](data:image/png;base64...)
![Allelic crosstalk](data:image/png;base64...)

The aroma.affymetrix package is an R package for analyzing small to
extremely large Affymetrix data sets. It allows you to analyze any number
of arrays of various chip types, e.g. 10,000s of expression arrays, SNP chips,
exon arrays and so on.

Here are some of the features of aroma.affymetrix:

* Number of arrays: **unlimited**.
* System requirements: As low as **1 GiB RAM, any operating system**.
* **Parallel processing**: [Single setting](/howtos/parallel_processing/index.html) to process data on multiple cores, in the background on multiple R sessions on the local machine, on a computer cluster etc.
* Chip types: **all Affymetrix** [chip types](/chipTypes/index.html) with a CDF, e.g. gene expression, exon, SNP & CN, tiling arrays.
* Immediate support for **custom CDFs**, e.g. [Brainarray](http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/genomic_curated_CDF.asp), [GeneAnnot](http://www.xlab.unimo.it/GA_CDF/) and [Wageningen University-NuGO](http://nmg-r.bioinformatics.nl/NuGO_R.html).
* File formats: Works directly with **CEL and CDF files** (all
  versions; text/ASCII, binary/XDA, binary/Calvin).
* Export to/Import from: Bioconductor, CNAG, CNAT & dChip.
* Pre-processing: Background correction, allelic cross-talk
  calibration, quantile normalization, nucleotide-position
  normalization etc.
* Probe-level modeling: RMA (log-additive), MBEI (multiplicative),
  affine (multiplicative with or without offset), ACNE (non-negative
  matrix factorization).
* Post-processing: PCR fragment-length and/or GC-content
  normalization.
* Paired & non-paired copy-number analysis: All generations, including
  10K, 100K, 500K, 5.0, 6.0, and CytoScanHD. Estimation of
  full-resolution (raw) copy numbers using CRMA (10K-500K) and CRMAv2
  (10K-CytoScanHD). Combine data from multiple chip types.
  Segmentation methods such as CBS, GLAD and HaarSeg.
* Genotyping: CRLMM (100K & 500K).
* Alternative splicing: FIRMA.
* **Dynamic HTML reports**: [ArrayExplorer & ChromosomeExplorer](/demos/index.html).
* **Persistent memory**: Final and intermediate results and estimates
  are stored on the file system.
* **Robustness**: Analysis picks up where last interrupted. Only
  complete files are produced (even during power failures).
* Reproducibility: Near **perfect replication** of RMA, GCRMA and
  SNPRMA (normalization & summarization) as implemented in the
  affyPLM, affy, gcrma and oligo packages, as well as CRLMM
  (genotyping) of oligo.
* **Portable scripts**: All data sets and data files are referred to
  by their names - not by pathnames.
* Design goals: usability, quality & extendibility.

The Aroma Project
(https://www.aroma-project.org/)
::
© Henrik Bengtsson
::
Powered by [RSP](https://cran.r-project.org/package%3DR.rsp)

[Validate HTML](https://validator.w3.org/check?st=1;outline=1;verbose=1;group=1&uri=https://www.aroma-project.org/./)

[Edit page](https://github.com/AromaProject/aroma.project.org-website/tree/master/content/index.md.rsp)