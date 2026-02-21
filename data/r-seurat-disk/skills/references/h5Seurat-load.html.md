Toggle navigation

[SeuratDisk](../index.html)
0.0.0.9011

* [Reference](../reference/index.html)
* Articles
  + [Conversions: h5Seurat and AnnData](../articles/convert-anndata.html)
  + [Saving and Loading Data from an h5Seurat File](../articles/h5Seurat-load.html)
  + [h5Seurat File Format Specification](../articles/h5Seurat-spec.html)

# Saving and Loading Data from an h5Seurat File

Source: [`vignettes/h5Seurat-load.Rmd`](https://github.com/mojaveazure/seurat-disk/blob/master/vignettes/h5Seurat-load.Rmd)

`h5Seurat-load.Rmd`

The h5Seurat file format, based on [HDF5](https://en.wikipedia.org/wiki/Hierarchical_Data_Format), is on specifically designed for the storage and analysis of multi-modal single-cell and spatially-resolved expression experiments, for example, from CITE-seq or 10X Visium technologies. It holds all molecular information and associated metadata, including (for example) nearest-neighbor graphs, dimensional reduction information, spatial coordinates and image data, and cluster labels.

This vignette serves as a guide to saving and loading `Seurat` objects to h5Seurat files. The h5Seurat file format, based on [HDF5](https://en.wikipedia.org/wiki/Hierarchical_Data_Format), is on specifically designed for the storage and analysis of multi-modal single-cell and spatially-resolved expression experiments, for example, from CITE-seq or 10X Visium technologies. It holds all molecular information and associated metadata, including (for example) nearest-neighbor graphs, dimensional reduction information, spatial coordinates and image data, and cluster labels. For more details about h5Seurat files, please see the [h5Seurat file specification](https://mojaveazure.github.io/seurat-disk/articles/h5Seurat-spec.html).

## Saving a dataset

Saving a `Seurat` object to an h5Seurat file is a fairly painless process. All assays, dimensional reductions, spatial images, and nearest-neighbor graphs are automatically saved as well as extra metadata such as miscellaneous data, command logs, or cell identity classes from a `Seurat` object. To save a `Seurat` object, we need the [Seurat](https://satijalab.org/seurat) and [SeuratDisk](https://mojaveazure.github.io/seurat-disk) R packages. Example `Seurat` objects are distributed through [SeuratData](https://github.com/satijalab/seurat-data).

```
library(Seurat)
library(SeuratDisk)
library(SeuratData)
```

For this vignette, we'll use one of the 10X Genomics Visium datasets from the stxBrain data package. We use this dataset to showcase saving and loading a dataset with multiple assays, dimensional reductions, nearest-neighbor graphs, and with spatial image data.

```
InstallData(ds = "stxBrain")
brain <- LoadData(ds = "stxBrain", type = "anterior1")
```

The data loaded is the raw, unprocessed version of the data. In order to generate the full dataset, we'll follow the steps outlined in [Seurat's spatial dataset vignette](https://satijalab.org/seurat/v3.1/spatial_vignette.html).

Processing Steps

```
brain <- UpdateSeuratObject(brain)
brain <- SCTransform(brain, assay = "Spatial", verbose = FALSE)
brain <- RunPCA(brain)
brain <- FindNeighbors(brain, dims = 1:30)
brain <- FindClusters(brain, verbose = FALSE)
brain <- RunUMAP(brain, dims = 1:30)
```

```
brain
#> An object of class Seurat
#> 48721 features across 2696 samples within 2 assays
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 other assay present: Spatial
#>  2 dimensional reductions calculated: pca, umap
```

As seen, we have a dataset with multiple components to it. Despite being a complex dataset with multiple parts, saving the dataset is no problem with nearly all information from the object being written to disk. Saving an object is as simple as calling [`SaveH5Seurat`](https://mojaveazure.github.io/seurat-disk/reference/SaveH5Seurat.html); minimally, this function takes a `Seurat` object and nothing else. Optional arguments are present for specifying a filename and whether or not you want to overwrite a preexisting file.

```
SaveH5Seurat(brain, overwrite = TRUE)
```

On a laptop running Ubuntu 16.04 LTS with an Intel Core i5-2520M clocked at 2.5 GHz, 16 GB of RAM, and a 512 Gb Samsung Evo SSD, this process takes ~20 seconds and results in an on-disk file size of roughly 213 Mb.

```
size <- file.size("anterior1.h5Seurat")
print(structure(size, class = "object_size"), units = "Mb")
#> 211.2 Mb
```

An [Rds](http://stat.ethz.ch/R-manual/R-devel/library/base/html/readRDS.html) file with the same object is roughly 200 Mb on disk, though saving the Rds file took ~42 seconds on the same laptop. Moreover, Rds files are not easily readable in other languages, such as Python.

## Connecting to and querying h5Seurat files

Unlike most data formats, HDF5 files can be connected to and explored without loading the data into memory. To facilitate this, we've built an [`h5Seurat` object](https://mojaveazure.github.io/seurat-disk/reference/h5Seurat-class.html) to serve as an interface to h5Seurat files in R. `h5Seurat` objects are built off of the [`H5File` object](https://hhoeflin.github.io/hdf5r/reference/H5File-class.html) from [hdf5r](https://hhoeflin.github.io/hdf5r/).

`h5Seurat` objects and R6 classes One thing to note, `h5Seurat` and `H5File` objects are R6 objects. Unlike most R objects (called S3 and S4), and more like objects in Python, R6 objects are *encapsulated* objects; this means that methods are attached directly to the object instead of to a generic function.
 In Seurat, most functions take an object as input and return an object as output. These functions actually run differently depending on the class of the object passed to them. For example, `RunUMAP` has 3 different modes of operation, depending on the type of object that's passed to it. One can see which objects trigger different routines by using the [`methods`](https://stat.ethz.ch/R-manual/R-patched/library/utils/html/methods.html) function. Functions that change behavior are known as "generics" and the exact implementations are known as "methods"; these methods are associated with the generic instead of with the object itself.
 R6 objects, however, have their methods attached directly to the object. Calling an R6 method is done similarly to data access in R's S3 and S4 object system: using the `[$](https://rdrr.io/r/base/Extract.html)` operator. For example, creating a new Seurat object is done with `CreateSeuratObject` or `new(Class = "Seurat")` (for advanced users), while initializing a new `h5Seurat` object is done with `h5Seurat$new()`
 For more details about R6 objects, please see the [R6 website and documentation](https://r6.r-lib.org/)

Connecting to an h5Seurat file is as simple as instantiating an `h5Seurat` object.

```
hfile <- Connect("anterior1.h5Seurat")
hfile
#> Class: h5Seurat
#> Filename: /home/paul/software/seurat-disk/vignettes/anterior1.h5Seurat
#> Access type: H5F_ACC_RDONLY
#> Attributes: version, project, active.assay
#> Listing:
#>          name    obj_type dataset.dims dataset.type_class
#>  active.ident   H5I_GROUP         <NA>               <NA>
#>        assays   H5I_GROUP         <NA>               <NA>
#>    cell.names H5I_DATASET         2696         H5T_STRING
#>      commands   H5I_GROUP         <NA>               <NA>
#>        graphs   H5I_GROUP         <NA>               <NA>
#>     meta.data   H5I_GROUP         <NA>               <NA>
#>          misc   H5I_GROUP         <NA>               <NA>
#>    reductions   H5I_GROUP         <NA>               <NA>
#>         tools   H5I_GROUP         <NA>               <NA>
```

As seen, the h5Seurat file is structured similarly to a `Seurat` object, with different HDF5 groups sharing the names of slots in a `Seurat` object. However, it's difficult to glean what data is present in this dataset similar to calling a `Seurat` object in the R console. To get around this, we've created an `index` method for `h5Seurat` objects; this method creates a summary of the data stored within the h5Seurat object. As `Seurat` objects are organized around the assay data, this h5Seurat index showcases the data grouped by assay.

```
hfile$index()
#> Data for assay SCT★ (default assay)
#>    counts      data    scale.data
#>      ✔          ✔          ✔
#> Dimensional reductions:
#>         Embeddings  Loadings  Projected  JackStraw
#>  pca:       ✔          ✔          ✖          ✖
#>  umap:      ✔          ✖          ✖          ✖
#> Graphs:
#>  ─ SCT_nn
#>  ─ SCT_snn
#> Data for assay Spatial
#>    counts      data    scale.data
#>      ✔          ✔          ✖
```

First we get a breakdown of what slots are filled within each assay, followed by a table of dimensional reduction information. This table shows which bits of information (eg. cell embeddings, feature loadings, JackStraw data) are present. these tables, we get a list of nearest-neighbor graphs and spatial image data. This way, we can see what data gets loaded on a per-assay basis as is required by Seurat.

To explore an h5Seurat file deeper, we can use the double bracket `[[[](https://rdrr.io/r/base/Extract.html)` operator to explore various aspects of the dataset. The double bracket `[[[](https://rdrr.io/r/base/Extract.html)` operator takes a UNIX-style path comprised of dataset names.

```
hfile[["assays"]]
#> Class: H5Group
#> Filename: /home/paul/software/seurat-disk/vignettes/anterior1.h5Seurat
#> Group: /assays
#> Listing:
#>     name  obj_type dataset.dims dataset.type_class
#>      SCT H5I_GROUP         <NA>               <NA>
#>  Spatial H5I_GROUP         <NA>               <NA>
hfile[["assays/SCT"]]
#> Class: H5Group
#> Filename: /home/paul/software/seurat-disk/vignettes/anterior1.h5Seurat
#> Group: /assays/SCT
#> Attributes: key
#> Listing:
#>               name    obj_type dataset.dims dataset.type_class
#>             counts   H5I_GROUP         <NA>               <NA>
#>               data   H5I_GROUP         <NA>               <NA>
#>           features H5I_DATASET        17668         H5T_STRING
#>      meta.features   H5I_GROUP         <NA>               <NA>
#>               misc   H5I_GROUP         <NA>               <NA>
#>         scale.data H5I_DATASET  3000 x 2696          H5T_FLOAT
#>    scaled.features H5I_DATASET         3000         H5T_STRING
#>  variable.features H5I_DATASET         3000         H5T_STRING
hfile[["reductions"]]
#> Class: H5Group
#> Filename: /home/paul/software/seurat-disk/vignettes/anterior1.h5Seurat
#> Group: /reductions
#> Listing:
#>  name  obj_type dataset.dims dataset.type_class
#>   pca H5I_GROUP         <NA>               <NA>
#>  umap H5I_GROUP         <NA>               <NA>
hfile[["reductions/umap"]]
#> Class: H5Group
#> Filename: /home/paul/software/seurat-disk/vignettes/anterior1.h5Seurat
#> Group: /reductions/umap
#> Attributes: active.assay, key, global
#> Listing:
#>             name    obj_type dataset.dims dataset.type_class
#>  cell.embeddings H5I_DATASET     2696 x 2          H5T_FLOAT
#>             misc   H5I_GROUP         <NA>               <NA>
```

When finished exploring an h5Seurat file, remember to close the connection. Because we're working with file on disk directly rather than loading it into memory, we need to close it to prevent file corruption. You can also open the file in read-only mode (`mode = "r"`) to help alleviate file corruption, though it's still a good habit to close the h5Seurat file when done working with it.

```
hfile$close_all()
```

## Loading datasets

Reading data from an h5Seurat file is as simple as calling [`LoadH5Seurat`](https://mojaveazure.github.io/seurat-disk/reference/LoadH5Seurat.html); by default, it loads the entire object into memory.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat")
brain2
```

However, there are situations in which loading an entire `Seurat` object is not desirable. As such, we can leverage the HDF5 format and load only parts of a dataset at a time. `LoadH5Seurat` makes use of assay association to limit the data loaded. In `Seurat` objects, all dimensional reduction information, nearest-neighbor graphs, and spatial image data have an assay they "belong" to (see the help page for [`DefaultAssay`](https://rdrr.io/cran/Seurat/man/DefaultAssay.html) for more details). If only certain assays are requested, then only the object associated with those assays are loaded.

There are four main parameters for controlling data loading. The first is the `assays` parameter; this parameter controls which assays are loaded and which slots of each assay are loaded. The simplest level of control is specifying the assays to load. For our brain dataset, we can choose from either "SCT" or "Spatial"; passing one of these will load the entire assay object for the assay specified.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat", assays = "SCT")
brain2
#> An object of class Seurat
#> 17668 features across 2696 samples within 1 assay
#> Active assay: SCT (17668 features, 3000 variable features)
#>  2 dimensional reductions calculated: pca, umap
```

We can also choose the slots to load; the slots available are "counts" for the raw expression data, "data" for the normalized expression data, or "scale.data" for the scaled expression data. Specifying slots instead of assays will load the desired slots from all assays that have the requested slots. When specifying slots, one of either "counts" or "data" **must** be specified as the `Seurat` object uses these slots to control dataset dimensionality information.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat", assays = "data")
brain2
#> An object of class Seurat
#> 48721 features across 2696 samples within 2 assays
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 other assay present: Spatial
#>  2 dimensional reductions calculated: pca, umap
```

For more fine-tuned control, the `assays` parameter can also take a named list or vector, where the names are the names of the assays to load and the values are the slots to load.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat", assays = list(SCT = c("data", "scale.data"),
    Spatial = "counts"))
brain2
#> An object of class Seurat
#> 48721 features across 2696 samples within 2 assays
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 other assay present: Spatial
#>  2 dimensional reductions calculated: pca, umap
```

Finally, passing `NULL` to `assays` (the default behavior) loads all assays and all slots.

The second of the main parameters is the `reductions` parameter; this parameter controls which dimensional reductions are loaded. As dimensional reductions are tied to assays, the data request needs to be either associated to a loaded assay or marked as global to be loaded (see details below). For example, trying to load the "pca" reduction with the "Spatial" assay won't work as the "pca" reduction is associated with the "SCT" assay and not marked as global.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat", assays = "Spatial", reductions = "pca")
brain2
#> An object of class Seurat
#> 31053 features across 2696 samples within 1 assay
#> Active assay: Spatial (31053 features, 0 variable features)
```

There are three special values the `reductions` parameter can take: `NULL` for all dimensional reductions that can be loaded (the default behavior), `NA` for *global* dimensional reductions only, or `FALSE` for no dimensional reduction information.

The `graphs` parameter is the third main parameter; this parameter controls which nearest-neighbor graphs to load. Just like dimensional reduction information, nearest-neighbor graphs are tied to assays, and thus are only loaded when their associated assay is loaded as well. There are two special values the `graphs` parameter can take: `NULL` for all graphs that can be loaded (the default behavior) or `FALSE` for no nearest-neighbor graphs.

The final main parameter is the `images` parameter; this parameter controls which spatial image data is loaded. All spatial image data are marked global by default, so they are loaded whether or not their associated assays are loaded as well. The `images` parameter has three special values: `NULL` for all spatial image data (the default), `NA` for *global* spatial image data (typically the same as `NULL`), or `FALSE` for no spatial image data.

With these four parameters, there is a lot of customization for loading `Seurat` objects from h5Seurat files. For example, the following will load the "data" slot from the "Spatial" assay, the "data" and "scale.data" slots from the "SCT" assay, *global* dimensional reductions, none of the nearest neighbor graphs, and all spatial images.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat", assays = list(SCT = c("data", "scale.data"),
    Spatial = "counts"), reductions = NA, graphs = FALSE, images = NULL)
brain2
#> An object of class Seurat
#> 48721 features across 2696 samples within 2 assays
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 other assay present: Spatial
#>  1 dimensional reduction calculated: umap
```

In addition, there are four secondary parameters to `LoadH5Seurat`: `meta.data`, `commands`, `misc`, and `tools`; these all take simple `TRUE`/`FALSE` values to control the loading of cell-level metadata, command logs, miscellaneous information, or tool-specific results, respectively.

Global objects The concept of global objects in Seurat is designed as an extension to the assay-centric nature of `Seurat` objects. In Seurat, each assay is considered to be one experiment or measurement of data for a common group of cells. These assays are then used to generate working summaries, such as reduced dimension space or nearest-neighbor graphs. Generally, if an assay is removed from an object, the working summaries are of little use so they get removed as well.
 However, there are some instances in which these working summaries are useful outside the context of their assay. For example, some reduced representations of the data such as tSNE or UMAP are useful for visualization regardless of the the assay. As such, certain reduced representations and all spatial image data are marked as *global*, allowing them to persist as useful visualization contexts without their associated assay and large expression matrices being present.
 For more details about global objects, please see the documentation for [globality in Seurat](https://rdrr.io/cran/Seurat/man/IsGlobal.html)

Partial loading of datasets is an excellent way to limit memory usage and prevent the loading of massive datasets into memory. However, there can be instances in which a partial dataset was loaded, but then needs to be expanded with additional data from the h5Seurat file. Instead of redoing the partial load, we can make use of [`AppendData`](https://mojaveazure.github.io/seurat-disk/reference/AppendData.html) to add additional objects from an h5Seurat file to an already-loaded `Seurat` object. To show how this works, we'll start off with by loading just the "data" slot from the "SCT" assay as well as all spatial image data, but not load any dimensional reduction information or nearest-neighbor graphs.

```
brain2 <- LoadH5Seurat("anterior1.h5Seurat", assays = c(SCT = "data"), reductions = FALSE,
    graphs = FALSE, images = NULL)
brain2
#> An object of class Seurat
#> 17668 features across 2696 samples within 1 assay
#> Active assay: SCT (17668 features, 3000 variable features)
```

`AppendData` takes the h5Seurat file, the `Seurat` object generated from `LoadH5Seurat` and uses the four main paramters from `LoadH5Seurat` (`assays`, `reductions`, `graphs`, and `images`). These parameters are used in the same way as `LoadH5Seurat` with one exception: `assays` can now take `FALSE` as a value. By passing `FALSE`, we prevent other assay information from being loaded; this is useful if we only want to add other bits of data to our `Seurat` object. For example, we can choose to add only *global* dimensional reductions to the already existing `Seurat` object.

```
brain2 <- AppendData("anterior1.h5Seurat", brain2, assays = FALSE, reductions = NA,
    graphs = FALSE, images = NULL)
brain2
#> An object of class Seurat
#> 17668 features across 2696 samples within 1 assay
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 dimensional reduction calculated: umap
```

The only limits to the number of times `AppendData` can be run is when the `h5Seurat` file has run out of data not present in the `Seurat` object. Otherwise, it can be run multiple times, adding new bits of data to our `Seurat` object. Here, we fill out the rest of the "SCT" assay, but load no other information

```
brain2 <- AppendData("anterior1.h5Seurat", brain2, assays = "SCT", reductions = FALSE,
    graphs = FALSE, images = FALSE)
brain2
#> An object of class Seurat
#> 17668 features across 2696 samples within 1 assay
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 dimensional reduction calculated: umap
```

If we want to perform a "full append" (loading all bits of data of a `Seurat` object from an h5Seurat file), we can set the four parameters to `NULL`, which happens to be the default values for these parmaters. This loads the rest of the `Seurat` object from the h5Seurat file into memory.

```
brain2 <- AppendData("anterior1.h5Seurat", brain2)
brain2
#> An object of class Seurat
#> 48721 features across 2696 samples within 2 assays
#> Active assay: SCT (17668 features, 3000 variable features)
#>  1 other assay present: Spatial
#>  2 dimensional reductions calculated: umap, pca
```

## h5Seurat files and SeuratData

Coming soon!

## Contents

Developed by Paul Hoffman.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 1.5.1.