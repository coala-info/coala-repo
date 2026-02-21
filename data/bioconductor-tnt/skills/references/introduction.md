# Introduction to TnT

#### Jialin Ma

#### August 22, 2017

## Motivation

A common task in bioinformatics is to create visualization of genomic data along genomic coordinates, together with necessary genomic annotation features like genes and transcripts on the same coordinate, in order to make sense of those data.

Typically, this can be accomplished with a browser-based genome browser like UCSC genome browser or IGV, which requires to export the data from R. There are also R packages developed to address this issue but using static graphs, e.g. `Gviz` and `ggbio`.

While bioconductor have packages that excel at representing and analyzing such genomic data, there lacks a flexible and interactive way to view them. Sometimes there is no need for a full-functional genome browser but a fast and convenient way to view the data which are typically represented by a R object. It should also be interactive to aid exploration, for example it may be dragable and it may enable tooltips to get detailed information about a separate feature quickly.

This is just the motivation of TnT: it aims to provide an interactive and flexible approach to visualize genomic data right in R. In order to accomplish this goal, TnT wraps the [TnT javascript libraries](https://github.com/tntvis/) and provides bindings to common bioconductor classes (e.g. GRanges, TxDb) that represent genomic data. The [TnT javascript libraries](https://github.com/tntvis/) which the R package is based on are a set of javascript libraries for visualizing trees- and track-based annotations, which can be used to create a simple genome browser.

TnT is a new package, any feedback or suggestion would appreciated, please email to Jialin Ma < marlin-@gmx.cn >. You can also find the source repository at <https://github.com/marlin-na/TnT> and the documentation site at <http://tnt.marlin.pub> . This vignette will also be extended in the future to include more details.

## Install

You can install the stable version of TnT from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("TnT")
```

Or alternatively, install the devel version from github:

```
devtools::install_github("marlin-na/TnT")
```

Then attach the package.

```
suppressPackageStartupMessages(library(TnT))
```

This vignette will assume readers have experience with common data structures in bioconductor, especially `GRanges` class from `GenomicRanges` package.

## Track Constructors

Overall, the package works by constructing tracks from data (GRanges, TxDb, EnsDb, etc.), and then constructing a tnt board from a list of tracks.

So the first step is to choose a track constructor and use it to construct tracks from data. Different constructors have been provided by the package for different features and data types.

As a simple example, to construct a block track from GRanges object

```
gr <- GenomicRanges::GRanges("chr7",
    ranges = IRanges(
        start = c(26549019L, 26564119L, 26585667L, 26591772L, 26594192L, 26623835L,
                  26659284L, 26721294L, 26821518L, 26991322L),
        end =   c(26550183L, 26564500L, 26586158L, 26593309L, 26594570L, 26624150L,
                  26660352L, 26721717L, 26823297L, 26991841L)),
    ID = 1:10,
    Name = paste("My Range", 1:10)
)
btrack <- TnT::BlockTrack(gr)
btrack
```

```
## A BlockTrack
## | Label: gr
## | Background:    missing, use 'white'
## | Height:    30
## | Data:
## |     seqnames     start       end     width   strand tooltip.ID tooltip.Name
## |     <factor> <integer> <integer> <integer> <factor>  <integer>  <character>
## |  1      chr7  26549019  26550183      1165        *          1   My Range 1
## |  2      chr7  26564119  26564500       382        *          2   My Range 2
## |  3      chr7  26585667  26586158       492        *          3   My Range 3
## |  4      chr7  26591772  26593309      1538        *          4   My Range 4
## |  5      chr7  26594192  26594570       379        *          5   My Range 5
## |  6      chr7  26623835  26624150       316        *          6   My Range 6
## |  7      chr7  26659284  26660352      1069        *          7   My Range 7
## |  8      chr7  26721294  26721717       424        *          8   My Range 8
## |  9      chr7  26821518  26823297      1780        *          9   My Range 9
## |  10     chr7  26991322  26991841       520        *         10  My Range 10
## |           color       key
## |     <character> <integer>
## |  1         blue         1
## |  2         blue         2
## |  3         blue         3
## |  4         blue         4
## |  5         blue         5
## |  6         blue         6
## |  7         blue         7
## |  8         blue         8
## |  9         blue         9
## |  10        blue        10
```

As you can see, meta-columns of GRanges have been converted to the tooltip column in track data. This is the default argument behavior, see

```
args(TnT::BlockTrack)
```

```
## function (range, label = deparse(substitute(range)), tooltip = mcols(range),
##     color = "blue", background = NULL, height = 30)
## NULL
```

The `tooltip` can be given as a data frame parallel to the data, the `color` argument can also be a character vector parallel to the data setting colors for each individual range.

In order to view track, simply put that track into a TnTBoard/TnTGenome:

```
TnT::TnTGenome(btrack)
```

```
## - Missing argument `view.range`:
##   automatically select 26493666..27047193 on seqlevel chr7...
```

```
## - Missing argument `coord.range` and seqlength is unknown:
##   automatically set coordinate limit to 26454128..27086731 ...
```

You can drag to move, scroll to zoom and click on feature to see the tooltip.

Similarly, tracks of different features could be constructed with other constructors. Here is a table showing these constructors and their data sources. Links to examples of each track type are also provided and you are recommended to go through them.

| Constructor | Source | Feature type | Example |
| --- | --- | --- | --- |
| BlockTrack | GRanges | block | [Block Track](http://tnt.marlin.pub/articles/examples/tracktype-BlockTrack.html) |
| VlineTrack | Width-one GRanges | vline | [Vline Track](http://tnt.marlin.pub/articles/examples/tracktype-VlineTrack.html) |
| PinTrack | Width-one GRanges paired with values | pin | [Pin Track](http://tnt.marlin.pub/articles/examples/tracktype-PinTrack.html) |
| LineTrack | Width-one GRanges paired with values | line | [Line and Area Track](http://tnt.marlin.pub/articles/examples/tracktype-LineTrack-AreaTrack.html) |
| AreaTrack | Width-one GRanges paired with values | area | [Line and Area Track](http://tnt.marlin.pub/articles/examples/tracktype-LineTrack-AreaTrack.html) |
| GeneTrackFromTxDb | TxDb | gene | [Gene Track and Feature Track](http://tnt.marlin.pub/articles/examples/tracktype-GeneTrack.html) |
| FeatureTrack | GRanges | gene | [Gene Track and Feature Track](http://tnt.marlin.pub/articles/examples/tracktype-GeneTrack.html) |
| GroupFeatureTrack | GRangesList | tx | [Tx Track and GroupFeatureTrack](http://tnt.marlin.pub/articles/examples/tracktype-TxTrack.html) |
| TxTrackFromTxDb | TxDb | tx | [Tx Track and GroupFeatureTrack](http://tnt.marlin.pub/articles/examples/tracktype-TxTrack.html) |
| TxTrackFromGRanges | GRanges paired with ‘type’ and ‘tx\_id’ | tx | [Tx Track and GroupFeatureTrack](http://tnt.marlin.pub/articles/examples/tracktype-TxTrack.html) |
| merge | Two or more tracks | composite | [Composite Track](http://tnt.marlin.pub/articles/examples/track-CompositeTrack.html) |

It is worthwhile to mention CompositeTrack here: you can `merge` multiple tracks to construct a CompositeTrack so that different types of features can be shown within one track. See example [here](https://marlin-na/TnT/examples/track-CompositeTrack.html).

## Track Manipulation

Given a constructed track, we may want to access or modify its data and options.

There are three common options for all types of tracks, they are `background`, `height` and `label`. These three options can be accessed and modified via `trackSpec` and `trackSpec<-`. For example:

```
TnT::trackSpec(btrack, "background")
```

```
## NULL
```

```
btrack2 <- btrack
TnT::trackSpec(btrack2, "background") <- "blanchedalmond"
TnT::trackSpec(btrack2, "label")      <- "My Ranges"
TnT::trackSpec(btrack2, "height")     <- 50
```

Data of tracks are normally stored with a class that inherits `GRanges` (except CompositeTrack, in which the data is stored as a list of tracks), and can be accessed or modified via `trackData` or `trackData<-`. There are also convenience shortcuts `track$name` and `track$name <- value` for `trackData(track)$name` and `trackData(track)$name <- value`, respectively. As an example:

```
btrack2$color                     # Equivalent to `trackData(btrack2)$color`
```

```
##  [1] "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue" "blue"
```

```
btrack2$color <- "darkseagreen4"  # Equivalent to `trackData(btrack2)$color <- "darkseagreen4"`
```

As an example, let’s also modify the data:

```
TnT::trackData(btrack2) <- GenomicRanges::shift(TnT::trackData(btrack2), 10000)
```

Finally, we put the modified track and the original track together to see the difference.

```
TnT::TnTBoard(list(btrack, btrack2))
```

```
## - Missing argument `view.range`:
##   automatically select 26504916..27045943 on seqlevel chr7...
```

```
## - Missing argument `coord.range` and seqlength is unknown:
##   automatically set coordinate limit to 26451985..27098874 ...
```

Another thing we may want to modify is tooltip. By constructing the track via constructors (except those constructed from TxDb), tooltip can be given as a data frame parallel to the data. After the track is constructed, the tooltip can accessed via `tooltip(track)` which is an shortcut to `trackData(track)$tooltip`. For example:

```
TnT::tooltip(btrack2) <- cbind(TnT::tooltip(btrack2),
                               as.data.frame(TnT::trackData(btrack2)))
TnT::TnTGenome(btrack2, view.range = TnT::trackData(btrack2)[4] * .05)
```

```
## - Missing argument `coord.range` and seqlength is unknown:
##   automatically set coordinate limit to 26464128..27096731 ...
```

Try to click on the block to see the tooltip.

## TnTBoard and TnTGenome

In previous examples, we have already seen how to show tracks with a TnTBoard or TnTGenome. A TnTBoard stores a list of tracks and show them with the same coordinate. You may already have noticed the difference between TnTBoard and TnTGenome: TnTGenome is just a TnTBoard with axis and location label.

In this part, I will introduce some arguments that can be optionally provided to control the board. They are:

* `view.range`: GRanges, to set the initial view range.
* `coord.range`: IRanges or numeric, to set the cooordinate limit.
* `zoom.allow`: IRanges or numeric, to set the limit of extent when zooming in and out.
* `allow.drag`: Logical, if FALSE, the board will not be able to move or zoom.

In case that `view.range`, `coord.range` and `zoom.allow` not provided, TnT will take a guess on them. Some considerations are:

* `view.range`: Try to use the seqlevel on which all tracks have features and try to use intersection of ranges of all tracks.
* `coord.range`: If `seqinfo` of the tracks have `seqlengths` available, then use 1 to seqlength as coordinate range. If not, try to find based on ranges of features (i.e. to cover all features on that seqlevel).

An example using these arguments:

```
set.seed(6)
pintrack <- TnT::PinTrack(GRanges("chr7", IRanges(start = sample(26300000:27000000, 4), width = 1)),
                          value = c(1,3,2,4), color = c("blue", "yellow", "green", "red"))
TnT::TnTGenome(
    list(pintrack, btrack2),
    view.range = GRanges("chr7", IRanges(26550000, 26600000)),
    coord.range = IRanges(26350000, 27050000),
    zoom.allow = IRanges(50000, 200000)
)
```