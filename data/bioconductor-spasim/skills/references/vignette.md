# spaSim vignette

Yuzhou Feng, Anna Trigos

#### 30 October 2025

#### Package

spaSim 1.12.0

# Contents

* [1 Basics](#basics)
  + [1.1 Installing `spaSim`](#installing-spasim)
  + [1.2 Citing `spaSim`](#citing-spasim)
* [2 Quick start to using `spaSim`](#quick-start-to-using-spasim)
  + [2.1 Simulate an individual image](#simulate-an-individual-image)
    - [2.1.1 Simulate background cells](#simulate-background-cells)
    - [2.1.2 Simulate mixed background](#simulate-mixed-background)
    - [2.1.3 Simulate clusters](#simulate-clusters)
    - [2.1.4 Simulate immune rings](#simulate-immune-rings)
    - [2.1.5 Simulate double rings](#simulate-double-rings)
    - [2.1.6 Simulate vessels](#simulate-vessels)
    - [2.1.7 Displaying the sequential construction of a simulated image](#displaying-the-sequential-construction-of-a-simulated-image)
  + [2.2 Simulating a range of multiple images](#simulating-a-range-of-multiple-images)
    - [2.2.1 Simulate multiple background images (multiple cell types) with different proportions of cell types.](#simulate-multiple-background-images-multiple-cell-types-with-different-proportions-of-cell-types.)
    - [2.2.2 Simulate multiple images with clusters of different properties.](#simulate-multiple-images-with-clusters-of-different-properties.)
    - [2.2.3 Simulate multiple images with immune rings of different properties](#simulate-multiple-images-with-immune-rings-of-different-properties)
  + [2.3 Input simulated images into *SPIAT* package.](#input-simulated-images-into-spiat-package.)
* [3 Citation](#citation)
* [4 Reproducibility](#reproducibility)
* [5 Bibliography](#bibliography)

# 1 Basics

spaSim (**spa**tial **Sim**ulator) is a simulator of tumour immune microenvironment spatial data. It includes a family of functions to simulate a diverse set of cell localization patterns in tissues. Patterns include background cells (one cell type or multiple cell types of different proportions), tumour/immune clusters, immune rings and double immune rings and stripes (blood/lymphatic vessels).

As quantitative tools for spatial tissue image analysis have been developed and need benchmarking, simulations from spaSim can be applied to test and benchmark these tools and metrics. The output of spaSim are images in `SpatialExperiment` object format and can be used with SPIAT (SPIAT (**Sp**atial **I**mage **A**nalysis of **T**issues) also developed by our team.

## 1.1 Installing `spaSim`

*[spaSim](https://bioconductor.org/packages/3.22/spaSim)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. You can install the latest development version from Github. You can install spaSim using the following commands in your `R` session:

```
## Check that you have a valid Bioconductor installation
BiocManager::valid()
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("spaSim")

# install from GitHub the development version
install.packages("devtools")
devtools::install_github("TrigosTeam/spaSim")
```

## 1.2 Citing `spaSim`

We hope that *[spaSim](https://bioconductor.org/packages/3.22/spaSim)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("spaSim")
#> To cite package 'spaSim' in publications use:
#>
#>   Feng Y, Trigos A (2023). _spaSim: Spatial point data simulator for
#>   tissue images_. R package version 1.3.1,
#>   <https://trigosteam.github.io/spaSim/>.
#>
#>   Feng Y, Yang T, Zhu J, Li M, Doyle M, Ozcoban V, Bass G, Pizzolla A,
#>   Cain L, Weng S, Pasam A, Kocovski N, Huang Y, Keam S, Speed T, Neeson
#>   P, Pearson R, Sandhu S, Goode D, Trigos A (2023). "Spatial analysis
#>   with SPIAT and spaSim to characterize and simulate tissue
#>   microenvironments." _Nature Communications_, *14*(2697).
#>   doi:10.1038/s41467-023-37822-0
#>   <https://doi.org/10.1038/s41467-023-37822-0>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 Quick start to using `spaSim`

First attach the package

```
library(spaSim)
```

## 2.1 Simulate an individual image

In spaSim, spatial patterns are simulated on separate layers sequentially starting from ‘background cells’ which serve as the canvas for higher order structures (e.g. tumour clusters, immune clusters and immune rings can be simulated after/on top of background cells). Here we will go through each of these steps.

### 2.1.1 Simulate background cells

First we randomly generate the spatial locations of generic ‘background cells’ (without cell identities). The ‘background cells’ will serve as the input to the other simulation functions shown below which can assign new identities to these cells in a structured or unstructured way.

Two options are avaible for background cell simulation. We suggest simulating tumour images with a Hardcore Process (`method = "Hardcore"`), which is a Poisson process where events (i.e. cells) are maintained at a specific minimum distance from each other. As `rHardcore` from `spatstat.random` package deletes cells based on this requirement, our function uses a `oversampling_rate` to create more cells than the target number of cells (`n_cells`) to ensure the resulting image has the number of cells specified. If the resulting image ends up with slightly fewer cells than specified, increase the `oversampling_rate` argument to account for this.

For normal tissues, we suggest using option `method = "Even"` to simulate the background cells, where the cells approximately locate on the vertices of hexagons with a jitter that follows a uniform distribution applied. This is because normal cells tend to evenly spaced across the image.

```
set.seed(610)
bg <- simulate_background_cells(n_cells = 5000,
                                width = 2000,
                                height = 2000,
                                method = "Hardcore",
                                min_d = 10,
                                oversampling_rate = 1.6,
                                Cell.Type = "Others")
```

![](data:image/png;base64...)

```
head(bg)
#>           Cell.X.Position Cell.Y.Position Cell.Type
#> Cell_55          156.3994        349.0815    Others
#> Cell_2226        878.6766        633.4749    Others
#> Cell_1113        569.0253        489.3713    Others
#> Cell_4788       1996.0439        292.1873    Others
#> Cell_4600       1756.8683       1608.0244    Others
#> Cell_951         306.1119       1641.1277    Others
# use dim(bg)[1] to check if the same number of cells are simulated.
# if not, increase `oversampling_rate`.
dim(bg)[1]
#> [1] 5000
```

We also give an example of normal tissue simulation here. The following code is not run within this vignette.

```
set.seed(610)
bg_normal <- simulate_background_cells(n_cells = 5000,
                                      width = 2000,
                                      height = 2000,
                                      method = "Even",
                                      min_d = NULL,
                                      jitter = 0.3,
                                      Cell.Type = "Others")
head(bg_normal)
dim(bg_normal)[1]
```

### 2.1.2 Simulate mixed background

To randomly assign ‘background cells’ to the the specified cell identities in the specified proportions in an unstructured manner, spaSim includes the `simulate_mixing` function.

Users can use the background image they defined earlier (e.g. `bg`), or the image predefined in the package (`bg1`) as the ‘background cells’ to further construct the mixed cell identities. In this example, we use `bg` that was defined in the previous section.

The `props` argument defines the proportions of each cell type in `idents`. Although the proportions are specified, the exact cells that are assigned by each identity are stochastic. Therefore, users are encouraged to use the set.seed() function to ensure reproducibility.

```
mix_bg <- simulate_mixing(bg_sample = bg,
                          idents = c("Tumour", "Immune", "Others"),
                          props = c(0.2, 0.3, 0.5),
                          plot_image = TRUE,
                          plot_colours = c("red","darkgreen","lightgray"))
```

![](data:image/png;base64...)

### 2.1.3 Simulate clusters

This function aims to simulate cells that aggregate as clusters like tumour clusters or immune clusters. Tumour clusters can be circles or ovals (or merging several ovals/circles together), and immune clusters are irregular (or merging several irregular shapes together).

First, we specify the properties of clusters such their primary cell type, size, shape and location. If infiltrating cell types are required, we can also include their properties.

If there are multiple cell types lying in the cluster (e.g. tumour cells and infiltrating cells), the assignment of identities to these cells is random, using the random number sampling technique.

```
cluster_properties <- list(
  C1 =list(name_of_cluster_cell = "Tumour", size = 500, shape = "Oval",
           centre_loc = data.frame(x = 600, y = 600),infiltration_types = c("Immune1", "Others"),
           infiltration_proportions = c(0.1, 0.05)),
  C2 = list(name_of_cluster_cell = "Immune1", size = 600,  shape = "Irregular",
            centre_loc = data.frame(x = 1500, y = 500), infiltration_types = c("Immune", "Others"),
            infiltration_proportions = c(0.1, 0.05)))
# can use any defined image as background image, here we use mix_bg defined in the previous section
clusters <- simulate_clusters(bg_sample = mix_bg,
                              n_clusters = 2,
                              bg_type = "Others",
                              cluster_properties = cluster_properties,
                              plot_image = TRUE,
                              plot_categories = c("Tumour" , "Immune", "Immune1", "Others"),
                              plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))
```

![](data:image/png;base64...)

The simulated image shows a tumour cluster and an immune cluster on a mixed background image. The primary cell type of the tumour cluster is “Tumour”, with some “Immune1” and “Others” cells also within the tumour cluster. The primary cell type of the immune cluster is “Immune1”, with some “Immune2” and “Others” cells also within the immune cluster.

### 2.1.4 Simulate immune rings

This function aims to simulate tumour clusters and an immune ring surrounding each of the clusters, which represent immune cells excluded to the tumor margin.

First, we specify the properties of immune rings such their primary (inner cluster) and secondary (outer ring) cell types, size, shape, width and location. Properties of cells infiltrating into the inner mass or outer ring can also be set.

If there are multiple cell types lying in the cluster and the immune ring, the assignment of identities to these cells is random, using the random number sampling technique.

```
immune_ring_properties <- list(
  I1 = list(name_of_cluster_cell = "Tumour", size = 500,
            shape = "Circle", centre_loc = data.frame(x = 930, y = 1000),
            infiltration_types = c("Immune1", "Immune2", "Others"),
            infiltration_proportions = c(0.15, 0.05, 0.05),
            name_of_ring_cell = "Immune1", immune_ring_width = 150,
            immune_ring_infiltration_types = c("Immune2", "Others"),
            immune_ring_infiltration_proportions = c(0.1, 0.15)))
rings <- simulate_immune_rings(
  bg_sample = bg,
  bg_type = "Others",
  n_ir = 1,
  ir_properties = immune_ring_properties,
  plot_image = TRUE,
  plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
  plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))
```

![](data:image/png;base64...)

spaSim also allows simulation of two shapes overlapping each other. An algorithm is then used to make the inner mass and outer rings of the different shapes cohesive. An example is shown below. Overlapping of shapes is also possible for clusters and double rings.

```
immune_ring_properties <- list(
  I1 = list(name_of_cluster_cell = "Tumour", size = 500,
            shape = "Circle", centre_loc = data.frame(x = 930, y = 1000),
            infiltration_types = c("Immune1", "Immune2", "Others"),
            infiltration_proportions = c(0.15, 0.05, 0.05),
            name_of_ring_cell = "Immune1", immune_ring_width = 150,
            immune_ring_infiltration_types = c("Immune2", "Others"),
            immune_ring_infiltration_proportions = c(0.1, 0.15)),
  I2 = list(name_of_cluster_cell = "Tumour", size = 400, shape = "Oval",
           centre_loc = data.frame(x = 1330, y = 1100),
           infiltration_types = c("Immune1",  "Immune2", "Others"),
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 150,
           immune_ring_infiltration_types = c("Immune2","Others"),
           immune_ring_infiltration_proportions = c(0.1, 0.15)))

rings <- simulate_immune_rings(bg_sample = bg,
                              bg_type = "Others",
                              n_ir = 2,
                              ir_properties = immune_ring_properties,
                              plot_image = TRUE,
                              plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
                              plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))
```

![](data:image/png;base64...)

### 2.1.5 Simulate double rings

This function aims to simulate tumour clusters with an inner ring (internal tumour margin) and an outer ring (external tumour margin).

First, we specify the properties of double rings such their primary (inner mass), secondary (inner ring), and tertiary (outer ring) cell types, size, shape, width and location. Properties of cells infiltrating into the inner mass or either ring can also be set. If there are multiple cell types lying in the tumour cluster and the double rings, the assignment of identities to the cells is random, using the random number sampling technique.

Similar to the above case, we are placing two double immune rings that overlap with each other to form a more complex shape.

```
double_ring_properties <- list(
 I1 = list(name_of_cluster_cell = "Tumour", size = 300, shape = "Circle",
           centre_loc = data.frame(x = 1000, y = 1000),
           infiltration_types = c("Immune1", "Immune2", "Others"),
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 80,
           immune_ring_infiltration_types = c("Tumour", "Others"),
           immune_ring_infiltration_proportions = c(0.1, 0.15),
           name_of_double_ring_cell = "Immune2", double_ring_width = 100,
           double_ring_infiltration_types = c("Others"),
           double_ring_infiltration_proportions = c( 0.15)),
 I2 = list(name_of_cluster_cell = "Tumour", size = 300, shape = "Oval",
           centre_loc = data.frame(x = 1200, y = 1200),
           infiltration_types = c("Immune1", "Immune2", "Others"),
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 80,
           immune_ring_infiltration_types = c("Tumour","Others"),
           immune_ring_infiltration_proportions = c(0.1,0.15),
           name_of_double_ring_cell = "Immune2", double_ring_width = 100,
           double_ring_infiltration_types = c("Others"),
           double_ring_infiltration_proportions = c(0.15)))
double_rings <- simulate_double_rings(bg_sample = bg1,
                                     bg_type = "Others",
                                     n_dr = 2,
                                     dr_properties = double_ring_properties,
                                     plot_image = TRUE,
                                     plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
                                     plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))
```

![](data:image/png;base64...)

The simulated image shows two layers of immune rings. The primary cell type in the inner ring (internal tumour margin) is coloured green, with some “Tumour” cells also lie in the inner ring. The outer ring (external tumour margin) is coloured blue, with some other “Others” cells also lie in the outer ring.

### 2.1.6 Simulate vessels

This function aims to simulate stripes of cells representing blood/lymphatic vessels.
First, we specify the properties of vessel structures such as the number present, their width, and the properties of their infiltrating cells. We then randomly assign ‘background cells’ which lie within these vessel structures to the specified cell identities in the specified proportions.

The locations of the vessels are stochastic.

```
properties_of_stripes <- list(
 S1 = list(number_of_stripes = 1, name_of_stripe_cell = "Immune1",
           width_of_stripe = 40, infiltration_types = c("Others"),
           infiltration_proportions = c(0.08)),
 S2 = list(number_of_stripes = 5, name_of_stripe_cell = "Immune2",
           width_of_stripe = 40, infiltration_types = c("Others"),
           infiltration_proportions = c(0.08)))
vessles <- simulate_stripes(bg_sample = bg1,
                           n_stripe_type = 2,
                           stripe_properties = properties_of_stripes,
                           plot_image = TRUE)
```

![](data:image/png;base64...)

### 2.1.7 Displaying the sequential construction of a simulated image

The `TIS` (**T**issue **I**mage **S**imulator) function simulates multiple patterns layer by layer and displays the pattern construction sequentially. The patterns are simulated in the order of: background cells, mixed background cells, clusters (tumour/immune), immune rings, double immune rings, and vessels.

Not all patterns are required for using this function. If a pattern is not needed, simply use `NULL` for the pattern arguments.
The example simulates a background sample with a tumour cluster and an immune ring on it (3 patterns: background image -> tumour cluster -> immune ring surrounding tumour cluster).

```
# First specify the cluster and immune ring properties
## tumour cluster properties
properties_of_clusters <- list(
 C1 = list( name_of_cluster_cell = "Tumour", size = 300, shape = "Oval",
            centre_loc = data.frame("x" = 500, "y" = 500),
            infiltration_types = c("Immune1", "Others"),
            infiltration_proportions = c(0.3, 0.05)))
## immune ring properties
immune_ring_properties <- list(
  I1 = list(name_of_cluster_cell = "Tumour", size = 300,
            shape = "Circle", centre_loc = data.frame(x = 1030, y = 1100),
            infiltration_types = c("Immune1", "Immune2", "Others"),
            infiltration_proportions = c(0.15, 0.05, 0.05),
            name_of_ring_cell = "Immune1", immune_ring_width = 150,
            immune_ring_infiltration_types = c("Others"),
            immune_ring_infiltration_proportions = c(0.15)),
  I2 = list(name_of_cluster_cell = "Tumour", size = 200, shape = "Oval",
           centre_loc = data.frame(x = 1430, y = 1400),
           infiltration_types = c("Immune1",  "Immune2", "Others"),
           infiltration_proportions = c(0.15, 0.05, 0.05),
           name_of_ring_cell = "Immune1", immune_ring_width = 150,
           immune_ring_infiltration_types = c("Others"),
           immune_ring_infiltration_proportions = c(0.15)))
# simulation
# no background sample is input, TIS simulates the background cells from scratch
# `n_cells`, `width`, `height`, `min_d` and `oversampling_rate` are parameters for simulating background cells
# `n_clusters`, `properties_of_clusters` are parameters for simulating clusters on top of the background cells
# `plot_image`, `plot_categories`, `plot_colours` are params for plotting
simulated_image <- TIS(bg_sample = NULL,
   n_cells = 5000,
   width = 2000,
   height = 2000,
   bg_method = "Hardcore",
   min_d = 10,
   oversampling_rate = 1.6,
   n_clusters = 1,
   properties_of_clusters = properties_of_clusters,
   n_immune_rings = 2,
   properties_of_immune_rings = immune_ring_properties,
   plot_image = TRUE,
   plot_categories = c("Tumour", "Immune1", "Immune2", "Others"),
   plot_colours = c("red", "darkgreen", "darkblue", "lightgray"))
```

![](data:image/png;base64...)![](data:image/png;base64...)

The results display the construction of a complex image with multiple patterns. It started from a background image with cells of no identities, then tumour a cluster is layered on the background image, and finally, an immune ring that surrounds a tumour cluster is layered on the very top.

## 2.2 Simulating a range of multiple images

In some cases simulations of a set of images that span a range of different properties of patterns are needed. Rather than simulating images individually, simulating these images in one go is desirable. The following functions create a quick interface to generate a range of images with different parameters/randomised elements.

### 2.2.1 Simulate multiple background images (multiple cell types) with different proportions of cell types.

This function aims to simulate a set of images that contain different proportions of specified cell types.

In this example we simulate 4 images with 10% Tumour cells and an increasing number of Immune cells. We first specify the cell types and the proportions of each cell type in each image.

```
#cell types present in each image
idents <- c("Tumour", "Immune", "Others")
# Each vector corresponds to each cell type in `idents`.
# Each element in each vector is the proportion of the cell type in each image.
# (4 images, so 4 elements in each vector)
Tumour_prop <- rep(0.1, 4)
Immune_prop <- seq(0, 0.3, 0.1)
Others_prop <- seq(0.9, 0.6, -0.1)
# put the proportion vectors in a list
prop_list <- list(Tumour_prop, Immune_prop, Others_prop)

# simulate
bg_list <-
 multiple_background_images(bg_sample = bg, idents = idents, props = prop_list,
                            plot_image = TRUE, plot_colours = c("red", "darkgreen", "lightgray"))
#> [1] "Immune cells were not found and not plotted."
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

### 2.2.2 Simulate multiple images with clusters of different properties.

This function aims to simulate a set of images that contain different tumour/immune clusters.

Note that in this function users cannot manually define the base shape and the primary cell type of the clusters. There are three options (`1`, `2`, and `3`) for the base shape available in the `cluster_shape` argument. `1` for a simple cluster where all cells are “Tumour”, `2` for a tumour cluster where the primary cell type is “Tumour” and there is infiltration of types “Immune” and “Others”, and `3` for an immune cluster where the primary cell type is “Immune” and the infiltration cell types are “Immune1” and “Others”.

Here we simulate 4 images with increasing tumour cluster sizes using the cluster shape `1`.

```
# if a property is fixed, use a number for that parameter.
# if a property spans a range, use a numeric vector for that parameter, e.g.
range_of_size <- seq(200, 500, 100)
cluster_list <-
 multiple_images_with_clusters(bg_sample = bg1,
                               cluster_shape = 1,
                               prop_infiltration = 0.1,
                               cluster_size = range_of_size,
                               cluster_loc_x = 0,
                               cluster_loc_y = 0,
                               plot_image = TRUE,
                               plot_categories = c("Tumour", "Immune", "Others"),
                               plot_colours = c("red", "darkgreen", "lightgray"))
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

We will also include one example for shape `2` and one example for shape `3`.

```
# shape "2" - Tumour cluster with more and more immune infiltration
range_of_infiltration <- c(0.1, 0.3, 0.5)
cluster_list <-
  multiple_images_with_clusters(bg_sample = bg1,
                                cluster_shape = 2,
                                prop_infiltration = range_of_infiltration,
                                cluster_size = 200,
                                cluster_loc_x = 0,
                                cluster_loc_y = 0,
                                plot_image = TRUE,
                                plot_categories = c("Tumour" , "Immune", "Others"),
                                plot_colours = c("red","darkgreen", "lightgray"))
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
# shape "3" - Immune cluster
cluster_list <-
  multiple_images_with_clusters(bg_sample = bg1,
                                 cluster_shape = 3,
                                 prop_infiltration = 0.1,
                                 cluster_size = 500,
                                 cluster_loc_x = 0,
                                 cluster_loc_y = 0,
                                 plot_image = TRUE,
                                 plot_categories = c("Immune", "Others"),
                                 plot_colours = c("darkgreen", "lightgray"))
```

![](data:image/png;base64...)

### 2.2.3 Simulate multiple images with immune rings of different properties

This function aims to simulate a set of images that contain different tumour clusters with immune rings.

Note that similar to `multiple_images_with_clusters`, in this function users cannot manually define the base shape and the primary cell type of the clusters or the immune rings. There are three options for the base shape (`1`, `2` and `3`) available in the `ring_shape` argument:

For `1` and `2`:
- primary cluster cell type is “Tumour”
- cluster infiltration cell types are “Immune” and “Others”
- primary ring cell type is “Immune”
- ring infiltration type is “Others”

For `3`:
- primary cluster cell type is “Tumour”
- cluster infiltration cell types are “Immune” and “Others”
- primary ring cell type is “Immune”
- ring infiltration type is “Tumour” and “Others”

The cluster size, infiltration proportions, cluster location, ring width, and ring infiltration proportions can be defined.

Here we show 3 images with increasingly wider immune rings. First define any parameter that has a range.

```
# if a property is to be fixed, use a number for that parameter.
# if a property is to span a range, use a numeric vector for that parameter, e.g.
range_ring_width <- seq(50, 120, 30)

# This example uses ring shape 1
par(mfrow=c(2,1))
immune_ring_list <-
 multiple_images_with_immune_rings(bg_sample = bg,
                                   cluster_size = 200,
                                   ring_shape = 1,
                                   prop_infiltration = 0,
                                   ring_width = range_ring_width,
                                   cluster_loc_x = 0,
                                   cluster_loc_y = 0,
                                   prop_ring_infiltration = 0.1,
                                   plot_image = TRUE,
                                   plot_categories = c("Tumour", "Immune", "Others"),
                                   plot_colours = c("red", "darkgreen", "lightgray"))
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

We will also include one example for ring shape `2` and one example for ring shape `3`.

```
# shape "2" - Immune ring at different locations
cluster_loc_x <- c(-300, 0, 300)
cluster_loc_y <- c(-300, 0, 300)
immune_ring_list <-
 multiple_images_with_immune_rings(bg_sample = bg,
                                   cluster_size = 200,
                                   ring_shape = 2,
                                   prop_infiltration = 0,
                                   ring_width = 70,
                                   cluster_loc_x = cluster_loc_x,
                                   cluster_loc_y = cluster_loc_y,
                                   prop_ring_infiltration = 0.1,
                                   plot_image = TRUE,
                                   plot_categories = c("Tumour", "Immune", "Others"),
                                   plot_colours = c("red", "darkgreen", "lightgray"))
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
# shape "3" - Immune ring has different "Tumour" proportions
prop_ring_infiltration <- c(0.1, 0.2, 0.3)
immune_ring_list <-
 multiple_images_with_immune_rings(bg_sample = bg,
                                   cluster_size = 200,
                                   ring_shape = 2,
                                   prop_infiltration = 0,
                                   ring_width = 70,
                                   cluster_loc_x = 0,
                                   cluster_loc_y = 0,
                                   prop_ring_infiltration = prop_ring_infiltration,
                                   plot_image = TRUE,
                                   plot_categories = c("Tumour", "Immune", "Others"),
                                   plot_colours = c("red", "darkgreen", "lightgray"))
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

## 2.3 Input simulated images into *[SPIAT](https://bioconductor.org/packages/3.22/SPIAT)* package.

As `SPIAT` uses SingleCellExperiment object as the basic data structure for image processing and analysis, the simulated images from `spaSim` can be directly used as input in `SPIAT` functions. Examples in `SPIAT` packages use the images simulated by `spaSim`.

Here is an example of using `SPIAT` function on `spaSim` image. We use `simulated_image` generated from one of the previous sections.

```
# The following code will not run as SPIAT is still not released yet. You can try out the dev version on Github~
# if (requireNamespace("SPIAT", quietly = TRUE)) {
#   # visualise
#   SPIAT::plot_cell_categories(sce_object = simulated_image,
#                               categories_of_interest = c("Tumour", "Immune1", "Immune2", "Others"),
#                               colour_vector = c("red", "darkgreen", "darkblue", "lightgray"),
#                               feature_colname = "Cell.Type")
#   # calculate average minimum distance of the cells
#   SPIAT::average_minimum_distance(sce_object = simulated_image)
#   # You can also try other functions :)
# }
```

# 3 Citation

Here is an example of you can cite the package.

* *[spaSim](https://bioconductor.org/packages/3.22/spaSim)* (Feng and Trigos, 2023)

# 4 Reproducibility

The *[spaSim](https://bioconductor.org/packages/3.22/spaSim)* package (Feng and Trigos, 2023) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("vignette.Rmd", "BiocStyle::html_document"))
## Extract the R code
library("knitr")
knit("vignette.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 02:40:19 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 1.157 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  backports              1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase                2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics           0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  deldir                 2.0-4   2024-02-28 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  generics               0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges          1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  IRanges                2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics         1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats            1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  polyclip               1.10-7  2024-07-23 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23  2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors              0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo                1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment   1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  spaSim               * 1.12.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  SpatialExperiment      1.20.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  spatstat.data          3.1-9   2025-10-18 [2] CRAN (R 4.5.1)
#>  spatstat.geom          3.6-0   2025-09-20 [2] CRAN (R 4.5.1)
#>  spatstat.random        3.4-2   2025-09-21 [2] CRAN (R 4.5.1)
#>  spatstat.univar        3.1-4   2025-07-13 [2] CRAN (R 4.5.1)
#>  spatstat.utils         3.2-0   2025-09-20 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment   1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmp8SzpVu/Rinst33814e75cfcab2
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025) with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-feng2023spasim)
Y. Feng and A. Trigos.
*spaSim: Spatial point data simulator for tissue images*.
R package version 1.3.1.
2023.
URL: <https://trigosteam.github.io/spaSim/>.

[[3]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[4]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[5]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.