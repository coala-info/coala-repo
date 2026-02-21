Toggle navigation

[SeuratDisk](../index.html)
0.0.0.9011

* [Reference](../reference/index.html)
* Articles
  + [Conversions: h5Seurat and AnnData](../articles/convert-anndata.html)
  + [Saving and Loading Data from an h5Seurat File](../articles/h5Seurat-load.html)
  + [h5Seurat File Format Specification](../articles/h5Seurat-spec.html)

# Conversions: h5Seurat and AnnData

Source: [`vignettes/convert-anndata.Rmd`](https://github.com/mojaveazure/seurat-disk/blob/master/vignettes/convert-anndata.Rmd)

`convert-anndata.Rmd`

This vignette showcases how to convert from `Seurat` object to AnnData files via an intermediate step thorugh h5Seurat files. This allows interoperability between Seurat and [Scanpy](https://scanpy.readthedocs.io/)

```
library(Seurat)
library(SeuratData)
library(SeuratDisk)
```

## Converting from Seurat to AnnData via h5Seurat

To showcase going from a `Seurat` object to an AnnData file, we'll use the processed version of the PBMC 3k dataset, available on [SeuratData](https://github.com/satijalab/seurat-data); this dataset was created following [Seurat's PBMC 3k tutorial](https://satijalab.org/seurat/v3.1/pbmc3k_tutorial.html)

```
InstallData("pbmc3k")
data("pbmc3k.final")
pbmc3k.final
#> An object of class Seurat
#> 13714 features across 2638 samples within 1 assay
#> Active assay: RNA (13714 features, 2000 variable features)
#>  2 dimensional reductions calculated: pca, umap
```

To see how this dataset was generated, please run `?pbmc3k.final`

Converting the `Seurat` object to an AnnData file is a two-step process. First, we [save the `Seurat` object](https://mojaveazure.github.io/seurat-disk/reference/SaveH5Seurat.html) as an h5Seurat file. For more details about saving `Seurat` objects to h5Seurat files, please see [this vignette](https://mojaveazure.github.io/seurat-disk/articles/h5Seurat-load.html); after the file is saved, we can [convert](https://mojaveazure.github.io/seurat-disk/reference/Convert.html) it to an AnnData file for use in Scanpy. Full details about the conversion processes are listed in the [manual page](https://mojaveazure.github.io/seurat-disk/reference/Convert.html) for the `Convert` function

```
SaveH5Seurat(pbmc3k.final, filename = "pbmc3k.h5Seurat")
Convert("pbmc3k.h5Seurat", dest = "h5ad")
```

We can view the AnnData file in Scanpy by using the `read_h5ad` function

```
import scanpy
#> /home/paul/.local/lib/python3.6/site-packages/anndata/_core/anndata.py:21: FutureWarning: pandas.core.index is deprecated and will be removed in a future version.  The public classes are available in the top-level namespace.
#>   from pandas.core.index import RangeIndex
#> /home/paul/.local/lib/python3.6/site-packages/numba/core/errors.py:144: UserWarning: Insufficiently recent colorama version found. Numba requires colorama >= 0.3.9
#>   warnings.warn(msg)
adata = scanpy.read_h5ad("pbmc3k.h5ad")
adata
#> AnnData object with n_obs × n_vars = 2638 × 13714
#>     obs: 'orig.ident', 'nCount_RNA', 'nFeature_RNA', 'seurat_annotations', 'percent.mt', 'RNA_snn_res.0.5', 'seurat_clusters'
#>     var: 'vst.mean', 'vst.variance', 'vst.variance.expected', 'vst.variance.standardized', 'vst.variable'
#>     uns: 'neighbors'
#>     obsm: 'X_pca', 'X_umap'
#>     varm: 'PCs'
```

## Converting from AnnData to Seurat via h5Seurat

To shocwcase going from an AnnData file to a `Seurat` object, we'll use a processed version of the PBMC 3k dataset; this dataset was processed using Scanpy following [Scanpy's PBMC 3k tutorial](https://scanpy-tutorials.readthedocs.io/en/latest/pbmc3k.html)

```
url <- "https://seurat.nygenome.org/pbmc3k_final.h5ad"
curl::curl_download(url, basename(url))
```

To see how this dataset was created, please see [this script](https://gist.github.com/mojaveazure/922aa904b9ac212e627f522c2b816a52)

Converting the AnnData file to a `Seurat` object is a two-step process. First, convert the AnnData file to an h5Seurat file using the [`Convert` function](https://mojaveazure.github.io/seurat-disk/reference/Convert.html); full details about the conversion process are listed in the [manual page](https://mojaveazure.github.io/seurat-disk/reference/Convert.html). Then, we [load the h5Seurat file](https://mojaveazure.github.io/seurat-disk/reference/LoadH5Seurat.html) into a `Seurat` object; for more details about loading `Seurat` objects from h5Seurat files, please see [this vignette](https://mojaveazure.github.io/seurat-disk/articles/h5Seurat-load.html)

```
Convert("pbmc3k_final.h5ad", dest = "h5seurat", overwrite = TRUE)
pbmc3k <- LoadH5Seurat("pbmc3k_final.h5seurat")
pbmc3k
#> An object of class Seurat
#> 13714 features across 2638 samples within 1 assay
#> Active assay: RNA (13714 features, 0 variable features)
#>  2 dimensional reductions calculated: pca, umap
```

## Contents

Developed by Paul Hoffman.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 1.5.1.