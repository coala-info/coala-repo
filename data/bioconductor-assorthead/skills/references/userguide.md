# Assortment of header-only libraries

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 2025-10-29

#### Package

assorthead 1.4.0

# Contents

* [1 Overview](#overview)
* [2 Quick start](#quick-start)
* [3 Available libraries](#available-libraries)
* [4 Using interfaces](#using-interfaces)
* [5 Contributing](#contributing)

# 1 Overview

*[assorthead](https://bioconductor.org/packages/3.22/assorthead)* vendors an assortment of header-only C++ libraries for use in Bioconductor packages.
The use of a central repository avoids duplicate vendoring of libraries across multiple R packages,
and enables better coordination of version updates across cohorts of interdependent C++ libraries.
This package is minimalistic by design to ensure that downstream packages are not burdened with more transitive dependencies.

# 2 Quick start

To use *[assorthead](https://bioconductor.org/packages/3.22/assorthead)* in a Bioconductor package,
just add it to the `LinkingTo` field in the `DESCRIPTION`:

```
LinkingTo: assorthead
```

The package C++ code can `#include` any of the available libraries, for example:

```
#include "Eigen/Dense"
#include "annoy/annoylib.h"
#include "annoy/kissrandom.h"
#include "tatami/tatami.hpp"
```

# 3 Available libraries

| Name | Version | Description |
| --- | --- | --- |
| [**tatami**](https://github.com/tatami-inc/tatami) | v4.0.3 | C++ API for matrix representations |
| [**tatami\_stats**](https://github.com/tatami-inc/tatami_stats) | v2.0.1 | Compute statistics from **tatami** matrices |
| [**tatami\_mult**](https://github.com/tatami-inc/tatami_mult) | v0.1.3 | Multiplication of **tatami** matrices |
| [**tatami\_chunked**](https://github.com/tatami-inc/tatami_chunked) | v2.1.0 | **tatami** extension for chunked matrices |
| [**manticore**](https://github.com/tatami-inc/manticore) | v1.0.3 | Execute arbitrary functions on the main thread |
| [**tatami\_r**](https://github.com/tatami-inc/tatami_r) | v2.0.4 | **tatami** extension for R matrices |
| [**tatami\_hdf5**](https://github.com/tatami-inc/tatami_hdf5) | v2.0.5 | **tatami** extension for HDF5 matrices |
| [**tatami\_tiledb**](https://github.com/tatami-inc/tatami_tiledb) | v2.0.1 | **tatami** extension for TileDB matrices |
| [**eminem**](https://github.com/tatami-inc/eminem) | v1.2.0 | **tatami** extension for TileDB matrices |
| [**byteme**](https://github.com/LTLA/byteme) | v2.0.1 | C++ interfaces for reading/writing byte buffers |
| [**aarand**](https://github.com/LTLA/aarand) | v1.1.0 | Lightweight random distribution functions |
| [**powerit**](https://github.com/LTLA/powerit) | v2.0.1 | Power iterations |
| [**irlba**](https://github.com/LTLA/CppIrlba) | v2.0.2 | C++ port of IRLBA, based on the **irlba** R package |
| [**WeightedLowess**](https://github.com/LTLA/CppWeightedLowess) | v2.1.4 | Lowess trend fitting with weights, à la `limma::weightedLowess` |
| [**kmeans**](https://github.com/LTLA/CppKmeans) | v4.0.4 | C++ port of `stats::kmeans` with various initialization methods |
| [**knncolle**](https://github.com/knncolle/knncolle) | v3.0.0 | C++ API for nearest-neighbor searches |
| [**knncolle\_annoy**](https://github.com/knncolle/knncolle_annoy) | v0.2.0 | **knncolle** extension for Annoy |
| [**knncolle\_hnsw**](https://github.com/knncolle/knncolle_hnsw) | v0.2.1 | **knncolle** extension for HNSW |
| [**knncolle\_kmknn**](https://github.com/knncolle/knncolle_kmknn) | v0.1.0 | **knncolle** extension for HNSW |
| [**kaori**](https://github.com/crisprverse/kaori) | v1.1.2 | Sequence alignment and counting for CRISPR guides |
| [**nenesub**](https://github.com/libscran/nenesub) | v0.2.1 | Subsampling based on nearest neighbors |
| [**raiigraph**](https://github.com/LTLA/raiigraph) | v1.1.0 | C++ wrappers around **igraph** data structures |
| [**scran\_qc**](https://github.com/libscran/scran_qc) | v0.2.0 | Simple quality control for single-cell data |
| [**scran\_norm**](https://github.com/libscran/scran_norm) | v0.2.0 | Scaling normalization for single-cell data |
| [**scran\_variances**](https://github.com/libscran/scran_variances) | v0.2.1 | Variance modelling and feature selection for single-cell data |
| [**scran\_pca**](https://github.com/libscran/scran_pca) | v0.2.0 | Principal components analysis for single-cell data |
| [**scran\_graph\_cluster**](https://github.com/libscran/scran_graph_cluster) | v0.2.0 | Graph-based clustering for single-cell data |
| [**scran\_markers**](https://github.com/libscran/scran_markers) | v0.3.0 | Marker detection for groups of interest in single-cell data |
| [**scran\_aggregate**](https://github.com/libscran/scran_aggregate) | v0.3.0 | Aggregating expression data for groups of cells |
| [**scran\_blocks**](https://github.com/libscran/scran_blocks) | v0.1.1 | Blocking utilities for all **libscran** libraries |
| [**annoy**](https://github.com/spotify/annoy) | v1.17.2 | Approximate nearest neighbors oh yeah |
| [**hnswlib**](https://github.com/nmslib/hnswlib) | v0.8.0 | Hierarchical navigable small worlds for finding nearest neighbors |
| [**Eigen**](https://gitlab.com/libeigen/eigen) | 3.4.0 | C++ template library for linear algebra |
| [**gsdecon**](https://github.com/libscran/gsdecon) | v0.1.0 | Compute gene set scores via eigengenes |
| [**clrm1**](https://github.com/libscran/clrm1) | v0.2.0 | Compute gene set scores via eigengenes |
| [**mnncorrect**](https://github.com/libscran/mnncorrect) | v3.0.0 | Batch correction with mutual nearest neighbors |
| [**qdtsne**](https://github.com/libscran/qdtsne) | v3.0.1 | Quick-and-dirty t-SNE in C++ |
| [**umappp**](https://github.com/libscran/umappp) | v3.1.0 | C++ implementation of the UMAP algorithm |
| [**mumosa**](https://github.com/libscran/mumosa) | v0.2.1 | Simple multi-modal analyses of single-cell data |
| [**phyper**](https://github.com/libscran/phyper) | v0.1.1 | Hypergeometric tail calculations for enrichment testing |
| [**subpar**](https://github.com/LTLA/subpar) | v0.4.1 | Substitutable parallelization for C++ libraries |
| [**singlepp**](https://github.com/SingleR-inc/singlepp) | v3.0.0 | Cell type annotation for single-cell expression data |
| [**millijson**](https://github.com/ArtifactDB/millijson) | v2.0.0 | Lightweight JSON parsing library |
| [**uzuki2**](https://github.com/ArtifactDB/uzuki2) | v2.0.0 | Storing simple R lists inside HDF5 or JSON |
| [**ritsuko**](https://github.com/ArtifactDB/ritsuko) | v0.6.1 | Helper functions for ArtifactDB libraries |
| [**takane**](https://github.com/ArtifactDB/takane) | v0.9.0 | ArtifactDB file validators |
| [**chihaya**](https://github.com/ArtifactDB/chihaya) | v1.1.2 | A C++ validator for delayed array operations |
| [**sanisizer**](https://github.com/LTLA/sanisizer) | v0.1.3 | Sanitize sizes to avoid integer overflow |
| [**topicks**](https://github.com/libscran/topicks) | v0.2.2 | Pick top genes for downstream analyses |

# 4 Using interfaces

The *[beachmat](https://bioconductor.org/packages/3.22/beachmat)* package contains the `initializeCpp()` function, which creates an external pointer to a `tatami::Matrix`.
Similarly, the *[BiocNeighbors](https://bioconductor.org/packages/3.22/BiocNeighbors)* package can create external pointers to various **knncolle** objects via its `defineBuilder()` and `buildIndex()` functions.
Downstream packages can use these pointers in their own C++ code by compiling against the relevant interfaces in *[assorthead](https://bioconductor.org/packages/3.22/assorthead)*.
This means that downstream packages do not need to re-compile all of the relevant header libraries to get full functionality of *[beachmat](https://bioconductor.org/packages/3.22/beachmat)*, *[BiocNeighbors](https://bioconductor.org/packages/3.22/BiocNeighbors)*, etc.
It also allows the C++ code of downstream packages to handle extensions to each framework, e.g., new matrix types in *[beachmat.hdf5](https://bioconductor.org/packages/3.22/beachmat.hdf5)*.
Check out each of the packages for more specific instructions on how to use its external pointers.

# 5 Contributing

If you want to add new libraries or update existing versions,
make a [pull request](https://github.com/LTLA/assorthead/pulls) with appropriate motifications in the `inst/fetch.R` file.