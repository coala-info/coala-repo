Toggle navigation

[SeuratDisk](index.html)
0.0.0.9011

* [Reference](reference/index.html)
* Articles
  + [Conversions: h5Seurat and AnnData](articles/convert-anndata.html)
  + [Saving and Loading Data from an h5Seurat File](articles/h5Seurat-load.html)
  + [h5Seurat File Format Specification](articles/h5Seurat-spec.html)

# SeuratDisk v0.0.0.9011

The h5Seurat file format is specifically designed for the storage and analysis of multi-modal single-cell and spatially-resolved expression experiments, for example, from CITE-seq or 10X Visium technologies. It holds all molecular information and associated metadata, including (for example) nearest-neighbor graphs, dimensional reduction information, spatial coordinates and image data, and cluster labels. We also support rapid and on-disk conversion between h5Seurat and AnnData objects, with the goal of enhancing interoperability between Seurat and Scanpy.

## Installation

SeuratDisk is not currently available on CRAN. You can install it from [GitHub](https://github.com/mojaveazure/seurat-disk) with:

```
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("mojaveazure/seurat-disk")
```

## Dependencies

SeuratDisk depends on the following non-standard packages:

| Package | CRAN Webpage | Source | Website |
| --- | --- | --- | --- |
| cli | [CRAN](https://cran.r-project.org/package%3Dcli) | [GitHub](https://github.com/r-lib/cli#readme) | – |
| crayon | [CRAN](https://cran.r-project.org/package%3Dcrayon) | [GitHub](https://github.com/r-lib/crayon#readme) | – |
| hdf5r | [CRAN](https://cran.r-project.org/package%3Dhdf5r) | [GitHub](https://github.com/hhoeflin/hdf5r) | [Website](https://hhoeflin.github.io/hdf5r) |
| Matrix | [CRAN](https://cran.r-project.org/package%3DMatrix) | – | [Website](http://Matrix.R-forge.R-project.org/) |
| R6 | [CRAN](https://cran.r-project.org/package%3DR6) | [GitHub](https://github.com/r-lib/R6/) | [Website](https://r6.r-lib.org) |
| rlang | [CRAN](https://cran.r-project.org/package%3Drlang) | [GitHub](https://github.com/r-lib/rlang) | [Website](http://rlang.r-lib.org) |
| Seurat | [CRAN](https://cran.r-project.org/package%3DSeurat) | [GitHub](https://github.com/satijalab/seurat) | [Website](http://www.satijalab.org/seurat) |
| withr | [CRAN](https://cran.r-project.org/package%3Dwithr) | – | [Website](http://withr.r-lib.org) |

## Links

* Browse source code at
  [https://​github.com/​mojaveazure/​seurat-disk/​](https://github.com/mojaveazure/seurat-disk/)
* Report a bug at
  [https://​github.com/​mojaveazure/​seurat-disk/​issues](https://github.com/mojaveazure/seurat-disk/issues)

## License

* [GPL-3](https://www.r-project.org/Licenses/GPL-3) | file [LICENSE](LICENSE-text.html)

## Developers

* Paul Hoffman
   Author, maintainer
* [All authors...](authors.html)

## Dev status

* [![CRAN/METACRAN](https://img.shields.io/cran/v/SeuratDisk)](https://cran.r-project.org/package%3DSeuratDisk)
* [![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://github.com/mojaveazure/seurat-disk)

Developed by Paul Hoffman.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 1.5.1.