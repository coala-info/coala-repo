# ggcyto : Visualize `Cytometry` data with `ggplot`

```
library(ggcyto)
dataDir <- system.file("extdata",package="flowWorkspaceData")
```

## 1: support `3` types of plot constructor

* represent different levels of complexity and flexibility
* meet the needs of various plot applications
* suitable for users at different levels of coding skills.

### low level: `ggplot`

The overloaded `fority` methods empower `ggplot` to work with all the major Cytometry data structures right away, which allows users to do all kinds of highly customized and versatile plots.

#### `GatingSet`

```
gs <- load_gs(list.files(dataDir, pattern = "gs_manual",full = TRUE))
attr(gs, "subset") <- "CD3+"
ggplot(gs, aes(x = `<B710-A>`, y = `<R780-A>`)) + geom_hex(bins = 128) + scale_fill_gradientn(colours = gray.colors(9))
```

![](data:image/png;base64...)

#### `flowSet/ncdfFlowSet/flowFrame`

```
fs <- gs_pop_get_data(gs, "CD3+")
ggplot(fs, aes(x = `<B710-A>`)) + geom_density(fill = "blue", alpha= 0.5)
```

![](data:image/png;base64...)

#### `gates`

```
gates <- filterList(gs_pop_get_gate(gs, "CD8"))
ggplot(gs, aes(x = `<B710-A>`, y = `<R780-A>`)) + geom_hex(bins = 128) + geom_polygon(data = gates, fill = NA, col = "purple")
```

![](data:image/png;base64...)

### medium level: `ggcyto`

`ggcyto` constructor along with overloaded `+` operator encapsulate lots of details that might be tedious and intimidating for many users.

```
ggcyto(gs, aes(x = CD4, y = CD8)) + geom_hex(bins = 128) + geom_gate("CD8")
```

![](data:image/png;base64...)

It simplies the plotting by: \* add a default scale\_fill\_gradientn for you \* fuzzy-matching in `aes` by either detector or fluorochromes names \* determine the `parent` popoulation automatically \* exact and plot the gate object by simply referring to the `child` population name

### top level: `autoplot`

Inheriting the spirit from ggplot’s `Quick plot`, it further simply the plotting job by hiding more details from users and taking more assumptions for the plot.

* when plotting `flowSet`, it determines `geom` type automatically by the number of `dim` supplied
* for `GatingSet`, it further skip the need of `dim` by guessing it from the `children` gate

```
#1d
autoplot(fs, "CD4")
```

![](data:image/png;base64...)

```
#2d
autoplot(fs, "CD4", "CD8", bins = 64)
```

![](data:image/png;base64...)

```
autoplot(gs, c("CD4", "CD8"), bins = 64)
```

![](data:image/png;base64...)

## 2: in-line transformation

It is done by different `scales` layers speically designed for `cytometry`

```
data(GvHD)
fr <- GvHD[[1]]
p <- autoplot(fr, "FL1-H")
p #raw scale
```

![](data:image/png;base64...)

```
p + scale_x_logicle() #flowCore logicle scale
```

![](data:image/png;base64...)

```
p + scale_x_flowJo_fasinh() # flowJo fasinh
```

![](data:image/png;base64...)

```
p + scale_x_flowJo_biexp() # flowJo biexponential
```

![](data:image/png;base64...)

## 3: generic `geom_gate` layer

It hides the complex details pf plotting different geometric shapes

```
fr <- fs[[1]]
p <- autoplot(fr,"CD4", "CD8") + ggcyto_par_set(limits = "instrument")
#1d gate vertical
gate_1d_v <- openCyto::gate_mindensity(fr, "<B710-A>")
p + geom_gate(gate_1d_v)
```

![](data:image/png;base64...)

```
#1d gate horizontal
gate_1d_h <- openCyto::gate_mindensity(fr, "<R780-A>")
p + geom_gate(gate_1d_h)
```

![](data:image/png;base64...)

```
#2d rectangle gate
gate_rect <- rectangleGate("<B710-A>" = c(gate_1d_v@min, 4e3), "<R780-A>" = c(gate_1d_h@min, 4e3))
p + geom_gate(gate_rect)
```

![](data:image/png;base64...)

```
#ellipsoid Gate
gate_ellip <- gh_pop_get_gate(gs[[1]], "CD4")
class(gate_ellip)
```

```
## [1] "ellipsoidGate"
## attr(,"package")
## [1] "flowCore"
```

```
p + geom_gate(gate_ellip)
```

![](data:image/png;base64...)

## 4: `geom_stats`

```
p <- ggcyto(gs, aes(x = "CD4", y = "CD8"), subset = "CD3+") + geom_hex()
p + geom_gate("CD4") + geom_stats()
```

![](data:image/png;base64...)

```
p + geom_gate("CD4") + geom_stats(type = "count") #display cell counts
```

![](data:image/png;base64...)

## 5: `axis_inverse_trans`

It can display the `log` scaled data in the original value

```
p # axis display the transformed values
```

![](data:image/png;base64...)

```
p + axis_x_inverse_trans() # restore the x axis to the raw values
```

![](data:image/png;base64...)

It currently only works with `GatingSet`.

## 6: auto limits

Optionally you can set limits by `instrument` or `data` range

```
p <- p + ggcyto_par_set(limits = "instrument")
p
```

![](data:image/png;base64...)

## 7: labs\_cyto

You can choose between `marker` and `channel` names (or `both` by default)

```
p + labs_cyto("markers")
```

![](data:image/png;base64...)

## 8: `ggcyto_par_set`

It aggregates the different settings in one layer

```
#put all the customized settings in one layer
mySettings <- ggcyto_par_set(limits = "instrument"
                             , facet = facet_wrap("name")
                             , hex_fill = scale_fill_gradientn(colours = rev(RColorBrewer::brewer.pal(11, "Spectral")))
                            , lab = labs_cyto("marker")
                            )
# and use it repeatly in the plots later (similar to the `theme` concept)
p + mySettings
```

![](data:image/png;base64...)

Currently we only support `4` settings, but will add more in future.

## 9: `as.ggplot`

It allows user to convert `ggcyto` objects to pure `ggplot` objects for further the manipulating jobs that can not be done within `ggcyto` framework.

```
class(p) # may not fully compatile with all the `ggplot` functions
```

```
## [1] "ggcyto_GatingSet" "ggcyto_flowSet"   "ggcyto"           "ggplot2::ggplot"
## [5] "ggplot"           "ggplot2::gg"      "S7_object"        "gg"
```

```
p1 <- as.ggplot(p)
class(p1) # a pure ggplot object, thus can work with all the `ggplot` features
```

```
## [1] "ggcyto"          "ggplot2::ggplot" "ggplot"          "ggplot2::gg"
## [5] "S7_object"       "gg"
```

## 10: ggcyto\_layout

Layout many gate plots on the same page

When plooting a `GatingHierarchy`, multiple cell populations with their asssociated gates can be plotted in different panels of the same plot.

```
gh <- gs[[1]]
nodes <- gs_get_pop_paths(gh, path = "auto")[c(3:9, 14)]
nodes
```

```
## [1] "singlets"    "CD3+"        "CD4"         "CD4/38- DR+" "CD4/38+ DR+"
## [6] "CD4/38+ DR-" "CD4/38- DR-" "CD8"
```

```
p <- autoplot(gh, nodes, bins = 64)
class(p)
```

```
## [1] "ggcyto_GatingLayout"
## attr(,"package")
## [1] "ggcyto"
```

```
p
```

![](data:image/png;base64...)

As you see, this generates a special `ggcyto_GatingLayout` object which is a container storing multiple `ggcyto` objects. You can do more about the plot layout with the helper function `ggcyto_arrange`. For example, to arrange it as one-row gtable object

```
gt <- ggcyto_arrange(p, nrow = 1)
class(gt)
```

```
## [1] "gtable" "gTree"  "grob"   "gDesc"
```

```
plot(gt)
```

![](data:image/png;base64...)

or even combine it with other `ggcyto_GatingLayout` objects(or any `gtable` objects) and print it on the sampe page

```
p2 <- autoplot(gh_pop_get_data(gh, "CD3+")[,5:8]) # some density plot
p2@arrange.main <- ""#clear the default title
gt2 <- ggcyto_arrange(p2, nrow = 1)

gt3 <- gridExtra::gtable_rbind(gt, gt2)
plot(gt3)
```

![](data:image/png;base64...)