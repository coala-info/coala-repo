# SCArray – Large-scale single-cell omics data manipulation with GDS files

Dr. Xiuwen Zheng
Genomics Research Center, AbbVie

Aug, 2021

# Introduction

* Single-cell technology development
  + larger and larger numbers of cells assayed per experiment
  + the scalability leveraging on-disk data processing (avoid “out-of-memory”)
* Genomic Data Structure (GDS) files
  + an alternative to HDF5 & TileDB
  + hierarchical structure to store array-oriented data sets
  + compress & decompress data internally
  + out-of-memory data storage and manipulation in R
* SCArray
  + applies GDS to single-cell data manipulation & analysis
  + utilizes DelayedArray & SingleCellExperiment in Bioconductor
  + reuse existing analysis packages efficiently (e.g., scater) via internal “seed-aware” functions

# Workflow & Data Structure

![](data:image/svg+xml;base64...)

# Key Functions in SCArray

![](data:image/svg+xml;base64...)

# Example: Small-size Dataset

![](data:image/svg+xml;base64...)

# Example: Large-size Dataset (1.3M mouse brain cells)

![](data:image/svg+xml;base64...)

# Discussion

* SCArray
  + under development
  + GDS as a file-based representation
    - a DelayedArray backend
    - for large-scale single-cell data storage & manipulation
  + leverage existing analysis R packages (e.g., scater)
    - via DelayedMatrix
* Plans
  + further integrate with Bioconductor infrastructure
    - GDSArray, DelayedMatrixStats, …
  + reimplement some memory-intensive algorithms

# Acknowledgements

* Genomics Research Center (GRC), AbbVie
  + Astrid Wachter
  + Priyanka Vijay
  + Yating(Claire) Chai
  + Zheng Zha
* Bioconductor
  + Qian Liu (Roswell Park Comprehensive Cancer Center)
* National Center for Supercomputing Applications (NCSA)
  + University of Illinois at Urbana-Champaign (UIUC)