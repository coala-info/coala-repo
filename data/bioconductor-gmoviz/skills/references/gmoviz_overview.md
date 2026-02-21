# gmoviz: seamless visualisation of complex genomic variations in GMOs and edited cell lines – An overview

Kathleen Zeglinski, Arthur Hsu, Constantinos Koutsakis and Monther Alhamdoosh

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
  + [1.1 How to read Circos plots](#how-to-read-circos-plots)
* [2 Installation](#installation)
  + [2.1 Bioconductor](#bioconductor)
  + [2.2 GitHub](#github)
  + [2.3 R package dependencies](#r-package-dependencies)
* [3 Quick start](#quick_start)
  + [3.1 Higher-level plotting steps](#higher_level)
    - [3.1.1 Insertion diagram](#insertion_diagram)
    - [3.1.2 Plotting many insertions throughout the genome](#aobf)
    - [3.1.3 Feature diagram](#feature_diagram)
* [Session Info](#session-info)
* [References](#references)

# 1 Introduction

![](data:image/jpeg;base64...)

gmoviz logo

Genetically modified organisms (GMOs) and cell lines are widely used models in
many aspects of biological research. As part of characterising these models,
DNA sequencing technology and bioinformatic analyses are used systematically to
study their genomes. Large volumes of data are generated and various algorithms
are applied to analyse this data, which introduces a challenge with regards to
representing all findings in an informative and concise manner. Scientific
visualisation can be used to facilitate the explanation of complex genomic
editing events such as intergration events, deletions, insertions, etc.
However, current visualisation tools tend to focus on numerical data, ignoring
the need to visualise editing events on a large yet biologically-relevant
scale.

`gmoviz` is an R package designed to extend traditional bioinformatics
workflows used for genomic characterisation with powerful visualisation
capabilities based on the Circos (Krzywinski et al. [2009](#ref-Krzywinski_2009)) plotting
framework, as implemented in *[circlize](https://CRAN.R-project.org/package%3Dcirclize)* (Gu et al. [2014](#ref-Gu_2014)). `gmoviz`
offers the following key features (summarised in the diagram below):

* Visualise complex structural variations, particularly relating to tandem
  insertions
* Generate plots in a single function call, or build them piece by piece for
  finer customisation
* Integration with existing Bioconductor data structures

![](data:image/svg+xml;base64...)

Flowchart summarising the usage and key functions of gmoviz

## 1.1 How to read Circos plots

Circos plots have two key components: sectors and tracks. Each sector
represents a sequence of interest (such as a chromosome, gene or any other
region). Tracks on the other hand are used to display data. For example:
![](data:image/jpeg;base64...)
In the figure above, red boxes have been drawn around each of the sectors. In
the next panel, blue boxes have been drawn around each of the tracks

# 2 Installation

`gmoviz` can be installed from [bioconductor.org](http://bioconductor.org/) or
its [GitHub repository](https://github.com/malhamdoosh/gmoviz)

## 2.1 Bioconductor

To install `gmoviz` via the `BiocManager`, type in R console:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("gmoviz")
```

## 2.2 GitHub

To install the development version of `gmoviz` from GitHub, type in the R
console:

```
BiocManager::install("malhamdoosh/gmoviz")
```

## 2.3 R package dependencies

`gmoviz` depends on several packages from the
[CRAN](https://cran.r-project.org/) and
[Bioconductor](https://bioconductor.org/) repositories:

* *[circlize](https://CRAN.R-project.org/package%3Dcirclize)* provides the lower-level functions used to generate
  the circular plots. To install it, type in the R console:

```
BiocManager::install("circlize")
```

* *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* and *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* are required for the
  GRanges data structure that is used to store information for plotting. To
  install them, type in the R console:

```
BiocManager::install(c("GenomicRanges", "IRanges"))
```

* *[gridBase](https://CRAN.R-project.org/package%3DgridBase)* faciliates the use of the circular plots (which are
  generated using base graphics) with the grid graphics system. To install it,
  type in the R console:

```
BiocManager::install("gridBase")
```

* *[ComplexHeatmap](https://bioconductor.org/packages/3.22/ComplexHeatmap)* is used to generate legends. To install it,
  type in the R console:

```
BiocManager::install("ComplexHeatmap")
```

* *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* is used to read information about the sequence
  names, lengths and coverage from *.bam* files. To install it, type in the R
  console:

```
BiocManager::install("Rsamtools")
```

* *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* is used to read information about the sequence
  names and lengths from *.fasta* files. To install it, type in the R console:

```
BiocManager::install("Biostrings")
```

* *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* is used to read information on genomic features
  from *.gff* files. To install it, type in the R console:

```
BiocManager::install("rtracklayer")
```

* *[pracma](https://CRAN.R-project.org/package%3Dpracma)* is used to apply moving-average smoothing to the
  coverage data. To install it, type in the R console:

```
BiocManager::install("pracma")
```

* *[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)* is used to support the many Bioconductor data
  structures and functions used in `gmoviz` To install it, type in the R console:

```
BiocManager::install("BiocGenerics")
```

* *[Seqinfo](https://bioconductor.org/packages/3.22/Seqinfo)* and *[GenomicAlignments](https://bioconductor.org/packages/3.22/GenomicAlignments)* are used to
  read in the coverage data from *.bam* files. To install them, type in the
  R console:

```
BiocManager::install(c("Seqinfo", "GenomicAlignments"))
```

# 3 Quick start

This section will walk through the basic usage of `gmoviz`. For more advanced
usage, such as the incremental apporach to generating plots and making
finer modifications, please see the advanced guide [here](gmoviz_advanced.html).

## 3.1 Higher-level plotting steps

### 3.1.1 Insertion diagram

`insertionDiagram` is the ‘star’ function of `gmoviz`, designed to make it
easier to plot (and thus show the copy number of) tandem insertion events.
It requires only one input: insertion\_data (either a GRanges or a data frame)
with the following columns.111 If using a GRanges these should be the metadata columns and each range
should correspond to the start/end of the insertion site. For data frame input,
use the columns `chr`, `start` and `end` to describe the insertion site’s
location. :

* **name** A character string indicating the name of the insert. Each insert
  must have a unique name.
* **colour** A character string of a colour to use. Supports hex colours like
  `#000000` and named R colours like `red`
* **shape** The shape that will be used to represent the insert:

  + `rectangle` is a rectangle (the default)
  + `forward_arrow` is a forwards-facing arrow
  + `reverse_arrow` is a backwards (reverse) facing arrow
* **length** The length **of a single copy** of the insert, **in bp**
* **in\_tandem** The number of tandem copies of the insert (defaults to 1 if not
  supplied)

Note that *in\_tandem*, *shape* and *colour* are all optional: if any of
these columns are not supplied the inserts will still be plotted and default
values will be allocated.

`insertionDiagram` will plot the tandem insert(s) on one sector, and use a
‘link’ to show the position they have inserted into in their target
sequence (the other sector).222 A link is a semi-transparent shape which connects two sectors in the
circle. It is very useful for demonstrating insertion events, or to indicate
zooming into a particular part of the sector. :

```
example_insertion <- GRanges(seqnames = "chr12",
                      ranges = IRanges(start = 70905597, end = 70917885),
                      name = "plasmid", colour = "#7270ea", length = 12000,
                      in_tandem = 11, shape = "forward_arrow")
insertionDiagram(insertion_data = example_insertion,
                 space_between_sectors = 20, xaxis_spacing = 45)
```

![](data:image/jpeg;base64...)
The above diagram shows the insertion of 11 tandem copies of ‘plasmid’ at the
site chr12:70905597-70917885.

#### 3.1.1.1 Alternate styles

There are four different styles of `insertionDiagram`: above was style 1: the
emphasis was placed on the inserted sequence(s) and a rectangle was drawn for
the inserted sequences to highlight that they are inserted as one long tandem
group.

The same diagram can be plotted with the emphasis on the target sequence
**(style 2)**:

```
insertionDiagram(example_insertion, space_between_sectors = 20, style = 2)
```

![](data:image/jpeg;base64...)
Notice how the target sequence (chr12) is now larger than the inserted sequence

Additionally, the rectangle outside of the inserted sequences can be removed,
using styles 3 and 4 (which, like styles 1 and 2 differ only in the relative
sizes of the target and inserted sequences)

Styles 3 & 4 are recommended for single-copy insertions, like the following:

```
single_copy_insertion <- GRanges(seqnames = "chr12",
                       ranges = IRanges(start = 70905597, end = 70917885),
                       name = "plasmid", length = 12000)
insertionDiagram(single_copy_insertion, space_between_sectors = 20, style = 3)
insertionDiagram(single_copy_insertion, space_between_sectors = 20, style = 4)
```

![](data:image/jpeg;base64...)
Notice how we were able to omit the `in_tandem`, `colour` and `shape` columns
from the insertion data, because we were happy with the default values.

#### 3.1.1.2 Multiple insertion sites

Additionally, the `insertionDiagram` is capable of showing multiple integration
sites. To do this, simply add another row to the insertion data:

```
multi_insertions <- GRanges(seqnames = "chr12",
                       ranges = IRanges(start = 70910000, end = 70920000),
                       name = "plasmid2", length = 10000)
multiple_insertions <- c(single_copy_insertion, multi_insertions)

## plot it
insertionDiagram(multiple_insertions)
```

![](data:image/jpeg;base64...)
Note that adding multiple insertion sites across different chromosomes using
`insertionDiagram` is currently **not** supported; it simply becomes too messy
and crowded on a single circle. If you are interested in showing many
insertions throughout the genome, please see the `multipleInsertionDiagram`
function [here](#aobf) which uses multiple circles to avoid this problem

#### 3.1.1.3 Adding more information

The `insertionDiagram` function (and also the `featureDiagram` function which
works in a similar way) is also able to accept two optional inputs: labels
(for example to indicate genes, exons or other genomic regions of interest)
and coverage data.333 more information on adding labels to plots including colour coding and
reading in label data from file can be found
[here](gmoviz_advanced.html#labels). This section will explain how to add this information
to a plot.

Firstly, labels:

```
nearby_genes <- GRanges(seqnames = c("chr12", "chr12"),
                        ranges = IRanges(start = c(70901000, 70911741),
                                         end = c(70910000, 70919000)),
                        label = c("Gene A", "Gene B"))
insertionDiagram(insertion_data = example_insertion,
                 label_data = nearby_genes,
                 either_side = nearby_genes,
                 space_between_sectors = 20,
                 xaxis_spacing = 75, # one x axis label per 75 degrees
                 label_size = 0.8, # smaller labels so they fit
                 track_height = 0.1) # smaller shapes so the labels fit
```

![](data:image/jpeg;base64...)
The labels for genes A and B have now been plotted on the insertion diagram.
Importantly, we not only supplied our `nearby_genes` GRanges to the
`label_data` argument, we also used it for `either_side`.444 Using a GRanges is only one of the ways to set `either_side`. Please see
[here](#either_side) for more information about controlling the amount of
sequence shown either side of the integration site. This means that,
unlike the previous figure which only plotted the area immediately around the
integration site, this figure extends to cover the genes that we want to
label.

Finally, we might like to also plot the coverage around the integration site:
To do this, we need some `coverage_data` which can be read in from a *.bam*
file (see [here](gmoviz_advanced.html#get_coverage) for how to do this),
although for now we will just use simulated data.

```
## simulated coverage
coverage <- GRanges(seqnames = rep("chr12", 400),
                    ranges = IRanges(start = seq(from = 70901000,
                                                 to = 70918955, by = 45),
                                     end = seq(from = 70901045,
                                               to = 70919000, by = 45)),
                    coverage = c(runif(210, 10, 15), rep(0, 190)))

## plot with coverage
insertionDiagram(insertion_data = example_insertion,
                 coverage_data = coverage,
                 coverage_rectangle = "chr12",
                 either_side = nearby_genes,
                 space_between_sectors = 20,
                 xaxis_spacing = 75) # one x axis label per 75 degrees
```

![](data:image/jpeg;base64...)
Notice how the rectangle representing chr12 has been replaced by a line graph
of the coverage. This allows us to see that there has been a deletion of gene
B in addition to the insertion of 11 tandem copies of the plasmid.

**Note:** As well as supplying the coverage data to the `coverage_data`
argument, it is vital that you also provide the sector(s) that you want to plot
coverage for to `coverage_rectangle`.

#### 3.1.1.4 How to set `either_side`

The `either_side` argument of `insertionDiagram` controls how much of the
target sequence is shown either side of the insertion site. It can take four
sorts of values:

* `"default"` takes an extra 15% either side of the insertion site.
* a single number *e.g.* `8000` will take that many bp either side of the
  insertion site
* a vector of length two will set the start and end points for that sector.
  This allows you to show the gene(s) or other regions of interest near the
  insertion site in full
* a GRanges object can also be used, for example the GRanges used to find the
  coverage over a region with `getCoverageData` or to hold gene labels.

For example:

```
## default
insertionDiagram(example_insertion, start_degree = 45,
                 space_between_sectors = 20)
## single number
insertionDiagram(example_insertion, either_side = 10000, start_degree = 45,
                 space_between_sectors = 20)
```

![](data:image/jpeg;base64...)

```
## vector length 2
insertionDiagram(example_insertion, either_side = c(70855503, 71398284),
start_degree = 45, space_between_sectors = 20)
```

![](data:image/jpeg;base64...)

### 3.1.2 Plotting many insertions throughout the genome

The `multipleInsertionDiagram` is an extension of the `insertionDiagram`. It
displays many (up to 8) insertions throughout the genome by drawing multiple
`insertionDiagram` figures around a central whole genome circle like so:
![](data:image/jpeg;base64...)

Here, two insertions (one in chr1 and one in chr5) are depicted as their own
diagrams, connected to the central genome with a ‘link’.

Drawing these diagrams is relatively straightforward (and very similar to the
use of `insertionDiagram`) as only two inputs are necessary:

* ***insertion\_data***: Insertion data in the same format as for
  `insertionDiagram`.
* **genome\_ideogram\_data**: A GRanges (or data frame) that contains the name,
  start and end of each of the chromosomes in the genome (see
  [here](gmoviz_advanced.html#get_coverage) for how to import this from file)

For example, to generate the plot shown above:

```
ideogram_data <- GRanges(
  seqnames = paste0("chr", 1:6),
  ranges = IRanges(start = rep(0, 6), end = rep(12000, 6)))
insertion_data <- GRanges(
  seqnames = c("chr1", "chr5"),
  ranges = IRanges(start = c(4000, 2000), end = c(4100, 2200)),
  name = c("ins1", "ins5"), length = c(100, 200))
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         colour_set = rich_colours)
```

![](data:image/jpeg;base64...)
One key difference to note about `multipleInsertionDiagram` (as opposed to the
regular `insertionDiagram`) is that rather than specifying colours for the
sectors and links separately, you are only able to provide one ‘set’ (vector)
of colours from which the sector and link colours will be assigned. `gmoviz`
provides 5 sets of colours (more information [here](#colours)) or you can
supply your own (but note that you **must** have at least 1 colour per row of
`genome_ideogram_data`). Otherwise, save the figure as a vector image and open
it in vector image editing programs to have finer control over the colour of
each little bit of the diagram.

#### 3.1.2.1 Customising your multiple insertion diagram

Just like `insertionDiagram`, `multipleInsertionDiagram` is able to display
more information, like coverage and labels. These work just like for the
[regular insertion diagram](#cnd_more_info):

```
## example coverage and labels
example_coverage <- GRanges(
seqnames = c(rep("chr1", 100), rep("chr5", 100)),
ranges = IRanges(start = c(seq(3985, 4114, length.out = 100),
                           seq(1970, 2229, length.out = 100)),
                 end = c(seq(3986, 4115, length.out = 100),
                         seq(1971, 2230, length.out = 100))),
                 coverage = c(runif(100, 0, 25), runif(100, 0, 15)))

 example_labels <- GRanges(seqnames = c("chr1", "chr5"),
                           ranges = IRanges(start = c(4000, 2000),
                           end = c(4120, 2200)),
                           label = c("Gene A", "Gene B"),
                           colour = c("red", "blue"))

## plot with coverage and labels
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         coverage_rectangle = c("chr1", "chr5"),
                         coverage_data = example_coverage,
                         label_data = example_labels,
                         label_colour = example_labels$colour)
```

![](data:image/jpeg;base64...)
As shown above, it’s perfectly fine to mix the labels and coverage data for
different insertion events in the same GRanges/data frame.

For the arguments `either_side` and `style` however, this function differs
slightly. These can be set overall (by a single value):

```
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         either_side = 1000, style = 2)
```

![](data:image/jpeg;base64...)

However, it is usually best (especially for `either_side`) to choose a value
that suits the particular event. This can be done with a named vector (for
`style`) or a named list (for `either_side`):

```
## it's even possible to use GRanges in this way
either_side_GRange <- GRanges("chr5", IRanges(1000, 3200))
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         either_side = list("ins1" = 1000,
                                            "ins5" = either_side_GRange),
                         style = c("ins1" = 2, "ins5" = 4))
```

![](data:image/jpeg;base64...)
**Warning**: When specifying the events for `either_side` and `style` you need
to use the **event names, not the chromosome names** (as there can be more
than one event per chromosome, but each event must have a unique name)

### 3.1.3 Feature diagram

The function `featureDiagram` is more general than `insertionDiagram`; it is
capable of displaying any ‘feature’ (a region of interest, for example a gene,
exon or inserted sequence). Each feature is represented as a colour-coded
shape, the exact nature of which is specified by the `feature_data` (see below
for details).

Feature data should be a GRanges (or data frame including the `chr`, `start` &
`end` columns as previously discussed) with the following columns:

* **label** A character string which will be used to label the feature. If
  possible this should be relatively short due to the limited space within the
  circle. See [here](gmoviz_advanced.html#feature_labels) for a detailed
  discussion of the labelling of features.
* **colour** A character string of a colour to use. Supports hex colours like
  `#000000` and named R colours like `red`
* **shape** The shape that will be used to represent the feature:

  + `rectangle` is a rectangle (the default)
  + `forward_arrow` is a forwards-facing arrow
  + `reverse_arrow` is a backwards (reverse) facing arrow
  + `upwards_triangle` is a triangle pointing up (out of the circle)
  + `downwards_triangle` is a triangle pointing down (into the circle)
    It is recommended to use `forward_arrow` and `reverse_arrow` for features on
    the + and - strands, respectively. `rectangle` is the default, and recommended
    for features that are not stranded.
* **track** The index of the track on which to plot the feature

  + `0` represents the outermost track, where the ideogram rectangles are
    plotted
  + `1` is the default track: one track in from the ideogram
  + `2` and `3` and so on are further into the centre of the circle
    Please try to keep the number of tracks below 3 if possible, otherwise there
    may not be enough space in the circle for all of them.
* **type** A character string describing the type of the feature (for example
  a gene or inserted sequence). This is only used for generating a legend for
  the features based on colour-coding by type and is thus completely optional.

Note that *track*, *shape*, *colour* and *label* are also optional: if any of
these columns are not supplied the features will still be plotted and default
values will be allocated.

The following examples highlight the diverse range of figures
that can be plotted with `featureDiagram`:

#### 3.1.3.1 Plasmid map

The circos plots generated by `gmoviz` are a great way to plot circular
sequences like plasmids. In this example, we will generate a plasmid map.
Firstly, we need two key inputs:

* the `ideogram_data` (a GRanges describing the name, start and end positions
  of the plasmid).555 More details about `ideogram_data` including how to specify it using
  a data frame rather than a GRanges can be found
  [here](gmoviz_advanced.html#initialisation)
* the `feature_data` (a GRanges or describing at least the location of each
  feature, and optionally specifying a label, shape, colour and track with
  which to plot). For now we will just use the defaults that are assigned by
  the `getFeatures` when reading in features from a .gff file (more details
  on this [here](gmoviz_advanced.html#get_features))

```
## the data
plasmid_ideogram <- GRanges("plasmid", IRanges(start = 0, end = 3000))
plasmid_features <- getFeatures(
  gff_file = system.file("extdata", "plasmid.gff3", package="gmoviz"),
  colour_by_type = FALSE, # colour by name rather than type of feature
  colours = rich_colours) # choose colours from rich_colours (see ?colourSets)

## the plot
## plot plasmid map with coverage
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17,
               label_track_height = 0.11,
               space_between_sectors = 0, # continuous circle
               xaxis_spacing = 30, # x axis label every 30 degrees
               start_degree = 90) # start from 90 degrees (12 o'clock)
```

![](data:image/jpeg;base64...)
Another great addition to the plasmid map is the coverage data, which can show
us which part(s) of the plasmid were inserted into the target genome. As
before, we will use simulated coverage data:

```
## make some simulated coverage data
coverage <- GRanges(seqnames = rep("plasmid", 200),
                    ranges = IRanges(start = seq(from = 0, to = 2985, by = 15),
                                     end = seq(from = 15, to = 3000, by = 15)),
                    coverage = c(runif(110, 10, 15), rep(0, 90)))
## plot plasmid map with coverage
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17,
               coverage_rectangle = "plasmid", # don't forget this!
               coverage_data = coverage,
               label_track_height = 0.11, space_between_sectors = 0,
               xaxis_spacing = 30, start_degree = 90)
```

![](data:image/jpeg;base64...)
As we can see, there is relatively uniform coverage on the first half of the
plasmid, whilst there is none for the second half. This suggests that our
promoter, gene and GFP have been inserted, but the ampR and rest of the plasmid
sequence have not.

#### 3.1.3.2 Insertion of a complex construct

While `insertionDiagram` is great for showing the copy number in tandem
insertions, `featureDiagram` is better for displaying the insertion of
complex constructs. In this example, we will draw a complex gene editing
design, in which one sector will display the inserted construct and the other
sector will be the target sequence.

Firstly, we will read in the necessary data: the ideogram\_data, exon\_label (a
label indicating the exon that will be targeted by the gene editing event) and
of course the feature\_data.

```
## the data
complex_ideogram <- GRanges(seqnames = c("Gene X", "Template"),
                            ranges = IRanges(start = c(5000, 0),
                                             end = c(6305, 3788)))
## exon label
exon_label <- GRanges("Gene X", IRanges(5500, 5960), label = "Exon 2")

## features
complex_features <- getFeatures(
  gff_file = system.file("extdata", "complex_insertion.gff3",
                         package="gmoviz"),
  colours = rich_colours)
```

Before we plot, we will make a few changes to the `complex_features` GRanges:
by default the `getFeatures` function will only assign features to ‘track 1’
(the track that is closest to the outside of the circle) and shapes will be
either arrows (for genes) or rectangles (for other features).666 Again, this is described in detail in the [features](#feature_diagram)
section.

In this case, it will look better if our cut sites are drawn as triangles and
are set slightly away from the remaining features on the second track:

```
## make a few edits to the feature_data:
complex_features$track[c(3,4)] <- 2 # cut sites on the next track in
complex_features$shape[c(3,4)] <- "upwards_triangle" # triangles

## plot the diagram
featureDiagram(ideogram_data = complex_ideogram,
               feature_data = complex_features,
               label_data = exon_label, custom_sector_width = c(0.6, 0.4),
               sector_colours = c("#6fc194", "#84c6d6"),
               sector_border_colours = c("#599c77", "#84c6d6"),
               space_between_sectors = 25, start_degree = 184,
               label_size = 1.1)
```

![](data:image/jpeg;base64...)

As for `insertionDiagram` it is possible to add both labels and coverage data
to a graphic produced with `featureDiagram`. However, `featureDiagram` also
accepts one other optional input: the `link_data`. This can be used to draw a
link (like the one used to show the integration event in `insertionDiagram`)
but in this case the link can be positioned wherever you desire.

To make the fact that the template is inserted into gene X a bit clearer, we
can use a **link**. To draw a link, we need to supply a `data.frame`
containing the link information. It should have **2 rows**, one for each end of
the link.777 Note that this same method can be used to add links to any `gmoviz` plot
using the `circlize` functions `circos.link` and `circos.genomicLink`.
For more information on how to use `circlize` functions to further customise
`gmoviz` plots, please see [here](gmoviz_advanced.html#using_circlize). For example, the following link goes from 5600-5706bp on gene X
to 0-3788bp on the template.

```
# link data
link <- data.frame(chr = c("Gene X", "Template"),
                   start = c(5600, 0),
                   end = c(5706, 3788))
featureDiagram(ideogram_data = complex_ideogram,
               feature_data = complex_features, label_data = exon_label,
               custom_sector_width = c(0.6, 0.4),
               sector_colours = c("#6fc194", "#84c6d6"),
               sector_border_colours = c("#599c77", "#84c6d6"),
               space_between_sectors = 25, start_degree = 184,
               label_size = 1.1, link_data = link)
```

![](data:image/jpeg;base64...)
This clearly indicates that connection between the template and gene X sectors.

# Session Info

This vignette was rendered in the following environment:

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] pasillaBamSubset_0.47.0 knitr_1.50              gmoviz_1.22.0
#>  [4] GenomicRanges_1.62.0    Seqinfo_1.0.0           IRanges_2.44.0
#>  [7] S4Vectors_0.48.0        BiocGenerics_0.56.0     generics_0.1.4
#> [10] circlize_0.4.16         BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gridBase_0.4-7              blob_1.2.4
#>  [3] Biostrings_2.78.0           bitops_1.0-9
#>  [5] fastmap_1.2.0               RCurl_1.98-1.17
#>  [7] pracma_2.4.6                GenomicAlignments_1.46.0
#>  [9] XML_3.99-0.19               digest_0.6.37
#> [11] lifecycle_1.0.4             cluster_2.1.8.1
#> [13] KEGGREST_1.50.0             RSQLite_2.4.3
#> [15] magrittr_2.0.4              compiler_4.5.1
#> [17] rlang_1.1.6                 sass_0.4.10
#> [19] tools_4.5.1                 yaml_2.3.10
#> [21] rtracklayer_1.70.0          S4Arrays_1.10.0
#> [23] bit_4.6.0                   curl_7.0.0
#> [25] DelayedArray_0.36.0         RColorBrewer_1.1-3
#> [27] abind_1.4-8                 BiocParallel_1.44.0
#> [29] grid_4.5.1                  colorspace_2.1-2
#> [31] iterators_1.0.14            tinytex_0.57
#> [33] SummarizedExperiment_1.40.0 cli_3.6.5
#> [35] rmarkdown_2.30              crayon_1.5.3
#> [37] httr_1.4.7                  rjson_0.2.23
#> [39] DBI_1.2.3                   cachem_1.1.0
#> [41] parallel_4.5.1              AnnotationDbi_1.72.0
#> [43] BiocManager_1.30.26         XVector_0.50.0
#> [45] restfulr_0.0.16             matrixStats_1.5.0
#> [47] vctrs_0.6.5                 Matrix_1.7-4
#> [49] jsonlite_2.0.0              bookdown_0.45
#> [51] GetoptLong_1.0.5            bit64_4.6.0-1
#> [53] clue_0.3-66                 GenomicFeatures_1.62.0
#> [55] magick_2.9.0                foreach_1.5.2
#> [57] jquerylib_0.1.4             codetools_0.2-20
#> [59] shape_1.4.6.1               BiocIO_1.20.0
#> [61] ComplexHeatmap_2.26.0       htmltools_0.5.8.1
#> [63] R6_2.6.1                    doParallel_1.0.17
#> [65] evaluate_1.0.5              lattice_0.22-7
#> [67] Biobase_2.70.0              png_0.1-8
#> [69] Rsamtools_2.26.0            cigarillo_1.0.0
#> [71] memoise_2.0.1               bslib_0.9.0
#> [73] Rcpp_1.1.0                  SparseArray_1.10.0
#> [75] xfun_0.53                   MatrixGenerics_1.22.0
#> [77] GlobalOptions_0.1.2
```

# References

Gu, Zuguang, Lei Gu, Roland Eils, Matthias Schlesner, and Benedikt Brors. 2014. “Circlize Implements and Enhances Circular Visualization in R.” *Bioinformatics* 30 (19): 2811–2. <https://doi.org/10.1093/bioinformatics/btu393>.

Krzywinski, M., J. Schein, I. Birol, J. Connors, R. Gascoyne, D. Horsman, S. J. Jones, and M. A. Marra. 2009. “Circos: An Information Aesthetic for Comparative Genomics.” *Genome Research* 19 (9): 1639–45. <https://doi.org/10.1101/gr.092759.109>.