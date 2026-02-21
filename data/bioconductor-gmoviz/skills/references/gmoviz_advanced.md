# gmoviz: seamless visualisation of complex genomic variations in GMOs and edited cell lines – Advanced usage

Kathleen Zeglinski, Arthur Hsu, Constantinos Koutsakis and Monther Alhamdoosh

#### 2025-10-30

# Contents

* [1 Introduction](#advanced_guide)
* [2 Incremental plotting steps](#manual_plotting)
  + [2.1 Dataset](#dataset)
  + [2.2 Initialisation & Ideograms](#initialisation)
    - [2.2.1 Reading in the ideogram data](#get_ideogram)
    - [2.2.2 Initialising the graph](#initialising-the-graph)
  + [2.3 Adding tracks](#tracks)
    - [2.3.1 Feature track](#feature_track)
    - [2.3.2 Numeric data tracks](#numeric_tracks)
  + [2.4 Finishing touches](#finishing_touches)
    - [2.4.1 Legends](#legends)
    - [2.4.2 Arranging legends alongside plots](#arranging)
* [3 Other features and hints](#other-features-and-hints)
  + [3.1 `gmoviz` colour sets](#colours)
  + [3.2 Adding to plots using circlize functions](#using_circlize)
* [Session Info](#session-info)
* [References](#references)

# 1 Introduction

![](data:image/jpeg;base64...)

gmoviz logo

This vignette will guide you through the more advanced uses of `gmoviz`, such
as the [incremental apporach to generating plots](#manual_plotting) and
[making finer modifications](#using_circlize). It is **highly recommended**
that you have read the [basic overview of `gmoviz`](gmoviz_overview.html)
before this vignette.

# 2 Incremental plotting steps

As well as [high-level functions](gmoviz_overview.html#higher_level) functions,
`gmoviz` contains many lower-level functions that can be used to construct a
plot track-by-track for more flexibility.

## 2.1 Dataset

This section will use the `rBiocpkg("pasillaBamSubset")` package for example
data, so please ensure you have it installed before proceeding:

```
if (!require("pasillaBamSubset")) {
    if (!require("BiocManager"))
        install.packages("BiocManager")
    BiocManager::install("GenomicAlignments")
}
library(pasillaBamSubset)
```

## 2.2 Initialisation & Ideograms

The first step in creating a circular plot is to initialise it. This involves
creating the ideogram (the rectangles that represent each sequence), which lays
out the sectors for data to be plotted into. To do this, we need some
**ideogram data**, in one of the following formats:

* A `GRanges`, with one range for each sector you’d like to plot.
* A `data.frame`, with three columns: `chr` (sector’s name), `start` and
  `end`.

For example, the following two ideogram data are equivalent:

```
ideogram_1 <- GRanges(seqnames = c("chrA", "chrB", "chrC"),
                 ranges = IRanges(start = rep(0, 3), end = rep(1000, 3)))
ideogram_2 <- data.frame(chr = c("chrA", "chrB", "chrC"),
                    start = rep(0, 3),
                    end = rep(1000, 3))
print(ideogram_1)
#> GRanges object with 3 ranges and 0 metadata columns:
#>       seqnames    ranges strand
#>          <Rle> <IRanges>  <Rle>
#>   [1]     chrA    0-1000      *
#>   [2]     chrB    0-1000      *
#>   [3]     chrC    0-1000      *
#>   -------
#>   seqinfo: 3 sequences from an unspecified genome; no seqlengths
print(ideogram_2)
#>    chr start  end
#> 1 chrA     0 1000
#> 2 chrB     0 1000
#> 3 chrC     0 1000
```

Both of the higher level functions `featureDiagram` and `insertionDiagram` do
this as their first step.

### 2.2.1 Reading in the ideogram data

Of course, typing this manually each time is troublesome. `gmoviz` provides the
function `getIdeogramData` which creates a `GRanges` of the ideogram data
from either a *.bam* file, single *.fasta* file or a folder containing many
*.fasta* files.111 Note that reading in from a *.bam* file is significantly faster than from
a *.fasta* file. This function can be used as follows:

```
## from a .bam file
fly_ideogram <- getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4())

## from a single .fasta file
fly_ideogram_chr4_only <- getIdeogramData(
  fasta_file = pasillaBamSubset::dm3_chr4())
```

But what if we wanted to read in just the chr3L? Luckily `getIdeogramData` has
filters to select the specific sequences you want.

#### 2.2.1.1 Filtering ideogram data

When reading in the ideogram data from file, there are often sequences in the
*.bam* file or *.fasta* file folder that are not necessary for the plot. Thus,
the `getIdeogramData` function provides three filters to allow you to only
read in the sequences you want.222 These filters only work on the `bam_file` and `fasta_folder` input
methods. Using a `fasta_file` means that filtering is not possible (although
you can of course edit the ideogram GRanges after it is generated).

If we want only a single chromosome/sequence, we can supply it to
`wanted_chr`:

```
getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                wanted_chr = "chr4")
#> GRanges object with 1 range and 0 metadata columns:
#>       seqnames    ranges strand
#>          <Rle> <IRanges>  <Rle>
#>   [1]     chr4 0-1351857      *
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Alternatively, if we want all chromosomes/sequences expect one, we can supply
it to `unwanted_chr`:

```
getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                unwanted_chr = "chrM")
#> GRanges object with 7 ranges and 0 metadata columns:
#>       seqnames     ranges strand
#>          <Rle>  <IRanges>  <Rle>
#>   [1]    chr2L 0-23011544      *
#>   [2]    chr2R 0-21146708      *
#>   [3]    chr3L 0-24543557      *
#>   [4]    chr3R 0-27905053      *
#>   [5]     chr4  0-1351857      *
#>   [6]     chrX 0-22422827      *
#>   [7]  chrYHet   0-347038      *
#>   -------
#>   seqinfo: 7 sequences from an unspecified genome; no seqlengths
```

Finally, you can supply any regex pattern to `just_pattern` to create your own
custom filter:

```
getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                just_pattern = "R$")
#> GRanges object with 2 ranges and 0 metadata columns:
#>       seqnames     ranges strand
#>          <Rle>  <IRanges>  <Rle>
#>   [1]    chr2R 0-21146708      *
#>   [2]    chr3R 0-27905053      *
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Of course, for these filters to work the spelling of the filter must exactly
match the spelling of the *.fasta* file names or the sequences in the *.bam*
file.

### 2.2.2 Initialising the graph

Now that we have the ideogram data, we can initialise the graph. For this
example, we will just focus on chromosome 4.

```
gmovizInitialise(fly_ideogram_chr4_only, track_height = 0.15)
```

![](data:image/jpeg;base64...)

We can see that a rectangle has been plotted and labelled to indicate chr4.
Changing a few visual settings, we can create a better looking ideogram:

```
gmovizInitialise(fly_ideogram_chr4_only,
                 space_between_sectors = 25, # bigger space between start & end
                 start_degree = 78, # rotate the circle
                 sector_label_size = 1, # bigger label
                 track_height = 0.15, # thicker rectangle
                 xaxis_spacing = 30) # label every 30 degrees on the x axis
```

![](data:image/jpeg;base64...)

However, these small tweaks are not the only way we can enhance the appearance
of our plot. `gmovizInitialise` can also display
[coverage data](#coverage_rectangles) and [labels](#labels), as well as
supporting [zooming and alteration of sector widths](#changing_sector_widths).

#### 2.2.2.1 ‘Coverage rectangles’

As demonstrated with the `insertionDiagram` and `featureDiagram` functions, we
can supply some `coverage_data` to enhance the ideogram and change the regular
rectangles into line graphs which display the coverage (‘coverage
rectangles’). This then allows the easy identification of deletions,
duplications and other events which alter the coverage.

##### 2.2.2.1.1 Reading in coverage data

To do this, we must first read in the coverage information from the *.bam*
file. This can be done with the `getCoverage` function:

```
chr4_coverage <- getCoverage(
  regions_of_interest = "chr4",
  bam_file = pasillaBamSubset::untreated3_chr4(),
  window_size = 350, smoothing_window_size = 400)
```

Here, we get the smoothed and windowed coverage for chr4.333 See below the section on [smoothing and windowing](#smooth_window)
for the effect of each of these arguments As we wanted the
coverage for the entire chr4, we could simply make
`regions_of_interest = "chr4"`. However, we could also have supplied a GRanges
describing that area instead. Whichever input is used, it is really important
that the sequence names match **exactly**. For example, the following will t
hrow an error, because there is no sequence named “4” or “Chr4” in the *.bam*
file:

```
getCoverage(regions_of_interest = "4",
            bam_file = pasillaBamSubset::untreated3_chr4(),
            window_size = 300, smoothing_window_size = 400)
#> Error in getCoverage(regions_of_interest = "4", bam_file = pasillaBamSubset::untreated3_chr4(), : Make sure all of the chromsomes in regions_of_interest are in
#>                 the bam file and spelled exactly the same as in the bam
getCoverage(regions_of_interest = "Chr4",
            bam_file = pasillaBamSubset::untreated3_chr4(),
            window_size = 300, smoothing_window_size = 400)
#> Error in getCoverage(regions_of_interest = "Chr4", bam_file = pasillaBamSubset::untreated3_chr4(), : Make sure all of the chromsomes in regions_of_interest are in
#>                 the bam file and spelled exactly the same as in the bam
```

##### 2.2.2.1.2 Plotting coverage

Now that we have the coverage data, we can plot the ideogram again using this
information. To draw a ‘coverage rectangle’ we need to firstly specifiy the
`coverage_data` to be used (as either a GRanges or a data frame) and then also
supply to `coverage_rectangle` a vector of the sector names to plot the
coverage data for.444 This means that you can have the coverage of multiple sequences/regions
in the same GRanges but choose to plot only some of them.

```
gmovizInitialise(ideogram_data = fly_ideogram_chr4_only,
                 coverage_rectangle = "chr4",
                 coverage_data = chr4_coverage,
                 xaxis_spacing = 30)
```

![](data:image/jpeg;base64...)
As you can see, the chr4 ideogram rectangle is replaced with a line graph
showing the coverage over the entire chromosome. The coloured area represents
the coverage, allowing easy identification of high and low coverage areas.

##### 2.2.2.1.3 Smoothing and windowing coverage data

When reading in the coverage data, there are two additional parameters
`window_size` and `smoothing_window_size` that modify the values.

* `window_size` controls the window size over which coverage is calculated
  (where a window size of 1 is per base coverage. A larger window size will
  reduce the time taken to read in, smooth and plot the coverage. It will also
  remove some of the variation in the coverage, although this is not its primary
  aim. If you have more than 10-15,000 points, it is **highly recommended** to
  use a larger window size, as this will take a long time to plot.
* `smoothing_window_size` controls the window used for moving average
  smoothing, as carried out by the *[pracma](https://CRAN.R-project.org/package%3Dpracma)* package. It **does not**
  reduce the number of points and so offers **no speed improvement** (in fact, it
  increases the time taken to read in the coverage data). It does, however,
  reduce the variation to produce a smoother, more attractive plot.

For example, try running the following:

```
# default window size (per base coverage)
system.time({getCoverage(regions_of_interest = "chr4",
                         bam_file = pasillaBamSubset::untreated3_chr4())})

# window size 100
system.time({getCoverage(regions_of_interest = "chr4",
                         bam_file = pasillaBamSubset::untreated3_chr4(),
                         window_size = 100)})

# window size 500
system.time({getCoverage(regions_of_interest = "chr4",
                         bam_file = pasillaBamSubset::untreated3_chr4(),
                         window_size = 500)})
```

Notice how going from the default window size of 1 (per base coverage) to a
relatively modest window size of 100 dramatically reduces the time needed to
read in the coverage data.

In terms of the appearance of the plot:
(**note:** for speed, we will plot only a subset of the chromosome: from
70000-72000bp)

```
# without smoothing
chr4_region <- GRanges("chr4", IRanges(70000, 72000))
chr4_region_coverage <- getCoverage(regions_of_interest = chr4_region,
                          bam_file = pasillaBamSubset::untreated3_chr4())
gmovizInitialise(ideogram_data = chr4_region, coverage_rectangle = "chr4",
                 coverage_data = chr4_region_coverage, custom_ylim = c(0,4))

# with moderate smoothing
chr4_region_coverage <- getCoverage(regions_of_interest = chr4_region,
                          bam_file = pasillaBamSubset::untreated3_chr4(),
                          smoothing_window_size = 10)
gmovizInitialise(ideogram_data = chr4_region, coverage_rectangle = "chr4",
                 coverage_data = chr4_region_coverage, custom_ylim = c(0,4))

# with strong smoothing
chr4_region_coverage <- getCoverage(regions_of_interest = chr4_region,
                          bam_file = pasillaBamSubset::untreated3_chr4(),
                          smoothing_window_size = 75)
gmovizInitialise(ideogram_data = chr4_region, coverage_rectangle = "chr4",
                 coverage_data = chr4_region_coverage, custom_ylim = c(0,4))
```

![](data:image/jpeg;base64...)
Notice how adding smoothing dramatically improves the appearance of the plot.
It also slightly reduces the time taken, because there are less extreme points.
However, it does result in the loss of the finer detail of the coverage data.
Thus, it is recommended that you play around with the values of
`smoothing_window_size` and `window_size` and choose a value that is best
suited to your own data.

#### 2.2.2.2 Adding labels

One more functionality of `gmovizInitialise` is the ability to add labels to
the outside of the plot. These can be used to identify regions of interest,
such as genes or exons. The format of this should be:

* A `GRanges`, with one range for each label & the label’s text as a metadata
  column `label`
* A `data.frame`, with columns: `chr` (sector’s name), `start` and `end`
  that represent the position of the label and `label` that contains the label’s
  text

For example:

```
label <- GRanges(seqnames = "chr4",
                 ranges = IRanges(start = 240000, end = 280000),
                 label = "region A")
gmovizInitialise(fly_ideogram_chr4_only, label_data = label,
                 space_between_sectors = 25, start_degree = 78,
                 sector_label_size = 1, xaxis_spacing = 30)
```

![](data:image/jpeg;base64...)
This is the same as how the labels in `insertionDiagram` and `featureDiagram`
are implemented.

These labels can be manually specified as above, or read in from a .gff file,
which also gives the option of colour coding the labels.555 This works simply by supplying a vector of colours (with the same length
as the number of labels) to `label_colour` rather than just a single colour.
You don’t have to have the colours as a part of the label data, it’s just a
bit easier to keep track of that way. :

```
labels_from_file <- getLabels(
  gff_file = system.file("extdata", "example.gff3", package = "gmoviz"),
  colour_code = TRUE)
gmovizInitialise(fly_ideogram_chr4_only,
                 label_data = labels_from_file,
                 label_colour = labels_from_file$colour,
                 space_between_sectors = 25, start_degree = 78,
                 sector_label_size = 1, xaxis_spacing = 30)
```

![](data:image/jpeg;base64...)
#### Changing sector sizes {#changing\_sector\_widths}
By default, when using `gmovizInitialise`, each sector is sized to match its
length relative to all of the other sectors on the plot to faciliate accurate
representation of the scale. However, when a plot includes sectors that differ
greatly in size, this can lead to problems. For example:

```
fly_ideogram <- getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                                unwanted_chr = "chrM")
gmovizInitialise(fly_ideogram)
```

![](data:image/jpeg;base64...)
Notice that chr4 and chrYHet are much shorter than the other chromosomes.
Thus, when we try to plot it, those three shorter sectors are so small that
they are barely visible and their labels overlap leading to confusion.

We can deal with this in one of two ways: firstly by manually specifying the
width (size) of each sector and secondly by zooming.

##### 2.2.2.2.1 Setting custom sector widths

One way to manipulate the width/size of the sectors is to specify a
`custom_sector_width` (custom sector width) vector. This vector should be the
same length as the number of sectors. For example:

```
gmovizInitialise(fly_ideogram,
                 custom_sector_width = c(0.2, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1))
```

![](data:image/jpeg;base64...)
Notice that the `custom_sector_width` vector had length 7, because this is how
many sectors there are. `custom_sector_width` can also be used for the
`insertionDiagram` and `featureDiagram` functions in the same way.

##### 2.2.2.2.2 Zooming

Whilst it is quite easy to set custom sector widths when there are only a few
sectors, it can be quite troublesome for entire genomes. Also, using this
method loses the relative sizing of all sectors, potentially leading to
misinterpretation.

We can solve this problem by using the zooming functionality of
`gmovizInitialise`. Doing this is relatively easy, all we need to do is
supply the names of sector(s) to zoom to the `zoom_sectors` argument:

```
gmovizInitialise(fly_ideogram, zoom_sectors = c("chr4", "chrYHet"),
                 zoom_prefix = "z_")
```

![](data:image/jpeg;base64...)
Now, chr4 and chrYHet are clearly visible alongside the rest of the sectors.
Notice that chrYHet is still around 1/4 of the size of chr4, as is expected
from their relative sizes (347038bp and 1351857bp, respectively). Also, all of
the other chromosomes are still proportional. Another advantage of using the
zooming is that the `zoom_prefix` applied to the start of the zoomed sector
label makes it clear which sectors have been zoomed and which have not.

## 2.3 Adding tracks

After initialising the graph, the next step is to add tracks containing data.
The two main types of track are the [feature track](#feature_track) and the
[numeric tracks](#numeric_tracks), which can be combined as desired to create
a customised plot.

### 2.3.1 Feature track

The ‘feature’ track, plots regions of interest just like the
[featureDiagram](gmoviz_overview.html#feature_diagram) function (in fact,
`featureDiagram` is just a convenient combination of `gmovizInitialise` and
`drawFeatureTrack`). If you only want to plot features, then using
`featureDiagram` is probably easier, but taking a track-by-track approach with
`drawFeatureTrack` allows the combination of feature tracks with numeric data
(see [here](#numeric_tracks) for an example).

Just like `featureDiagram`, `drawFeatureTrack` requires *feature\_data*. See
[here](gmoviz_overview.html#feature_diagram) for an explanation of the format.

#### 2.3.1.1 Reading in the feature data

Feature data can be read in from a *.gff* file using the `getFeatures`
function.

```
features <- getFeatures(
  gff_file = system.file("extdata", "example.gff3", package = "gmoviz"),
  colours = gmoviz::rich_colours)
```

Here, we have set the `colours` parameter to `rich_colours`, one of the five
colour sets provided by `gmoviz` (see [here](#colours) for a description of
each colour set) This means that the features will be allocated a colour from
this set based on the ‘type’ field of the *.gff* file.

Once the feature data is read in, it is highly recommended to take a look and
tweak it, if necessary.

#### 2.3.1.2 Adding a feature track

Once we have the feature data, we can add a feature track to our plot. As we
are only adding one track, increasing `track_height` to 0.18 gives us a bit
more room to draw the features.

```
## remember to initialise first
gmovizInitialise(fly_ideogram_chr4_only, space_between_sectors = 25,
                 start_degree = 78, xaxis_spacing = 30, sector_label_size = 1)
drawFeatureTrack(features, feature_label_cutoff = 80000, track_height = 0.18)
```

![](data:image/jpeg;base64...)
Notice that the *geneY* label was drawn inside the arrow whilst the others were
drawn further into the circle. This is because we set `feature_label_cutoff` to
80000, so any features less than 80000bp long have their labels drawn outside,
so that the label isn’t hanging off the end of the feature. See below for a
detailed discussion of this concept.

#### 2.3.1.3 Label plotting and cutoffs for features

When using the `featureDiagram` and `drawFeatureTrack` functions, you
may have noticed that the position of the labels changes based on the size of
the feature being plotted. For example, in the following plot, the second ‘ins’
label is drawn outside the feature, further towards the centre of the circle.
This is because the size of the feature is less than the
`feature_label_cutoff`.

```
## the data
plasmid_ideogram <- GRanges("plasmid", IRanges(start = 0, end = 3000))
plasmid_features <- getFeatures(
  gff_file = system.file("extdata", "plasmid.gff3", package="gmoviz"),
  colour_by_type = FALSE, # colour by name rather than type of feature
  colours = gmoviz::rich_colours) # choose colours from rich_colours (see ?colourSets)

## the plot
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17)
```

![](data:image/jpeg;base64...)

Of course, you can specify your own cutoff. At 1, all labels will be plotted
inside their respective features.

```
## smallest label cutoff
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17,
               feature_label_cutoff = 1)
```

![](data:image/jpeg;base64...)

### 2.3.2 Numeric data tracks

As well as the feature track, `gmoviz` also contains more traditional numeric
data tracks: the scatterplot and the line graph.

To showcase these tracks, we will generate some example data:

```
numeric_data <- GRanges(seqnames = rep("chr4", 50),
                       ranges = IRanges(start = sample(0:1320000, 50),
                                        width = 1),
                       value = runif(50, 0, 25))
```

Scatterplot tracks can be plotted with `drawScatterplotTrack` and line graphs
with `drawLinegraphTrack`:

```
## remember to initialise first
gmovizInitialise(fly_ideogram_chr4_only,
                 space_between_sectors = 25, start_degree = 78,
                 sector_label_size = 1, xaxis_spacing = 30)
## scatterplot
drawScatterplotTrack(numeric_data)

## line graph
drawLinegraphTrack(sort(numeric_data), gridline_colour = NULL)
```

![](data:image/jpeg;base64...)
Note that for the line graph track, the data should be sorted in ascending
order before plotting.

These numeric tracks can then be combined with feature tracks, as desired:

```
gmovizInitialise(fly_ideogram_chr4_only, space_between_sectors = 25,
                 start_degree = 78, xaxis_spacing = 30, sector_label_size = 1)
drawScatterplotTrack(numeric_data, track_height = 0.14, yaxis_increment = 12)
drawFeatureTrack(features, feature_label_cutoff = 80000, track_height = 0.15)
```

![](data:image/jpeg;base64...)

## 2.4 Finishing touches

### 2.4.1 Legends

Like *[circlize](https://CRAN.R-project.org/package%3Dcirclize)*, `gmoviz` relies on the package
*[ComplexHeatmap](https://bioconductor.org/packages/3.22/ComplexHeatmap)* (Gu, Eils, and Schlesner [2016](#ref-Gu_2016)) to generate its legends. More
information about how this works can be found
[here](https://jokergoo.github.io/circlize_book/book/legends.html), but for
simplicity, `gmoviz` provides the `makeLegends` function to create legend
objects without requiring an understanding of how the `ComplexHeatmap` package
works.

Here, we will make a legend for the plot shown just previously.

```
legend <- makeLegends(
    feature_legend = TRUE, feature_data = features,
    feature_legend_title = "Regions of interest", scatterplot_legend = TRUE,
    scatterplot_legend_title = "Numeric data",
    scatterplot_legend_labels = "value")
```

`legend` is a legend object that can be plotted alongside a circos plot using
the `gmovizPlot` function:

### 2.4.2 Arranging legends alongside plots

As explained [here](https://jokergoo.github.io/circlize_book/book/legends.html)
the legends of `ComplexHeatmap` are generated using grid graphics whilst the
circular plots of `circlize` use base graphics. Thus, combining the two
requires the use of the *[gridBase](https://CRAN.R-project.org/package%3DgridBase)* package. More information can
be found at the aforementioned link, but `gmoviz` provides the `gmovizPlot`
function to conveniently combine these two elements.

The `gmovizPlot` function generates a plot based on the code supplied to the
`plotting_functions` parameter and saves it as an image, alongside and optional
title and legend.666 The legend object can be either one generated using `makeLegends` or
directly made using the functionality of the `ComplexHeatmap` package.

```
gmovizPlot(file_name = "example.svg", file_type = "svg",
           plotting_functions = {
    gmovizInitialise(
        fly_ideogram_chr4_only, space_between_sectors = 25, start_degree = 78,
        xaxis_spacing = 30, sector_label_size = 1)
    drawScatterplotTrack(
        numeric_data, track_height = 0.14, yaxis_increment = 12)
    drawFeatureTrack(
        features, feature_label_cutoff = 80000, track_height = 0.15)
}, legends = legend, title = "Chromosome 4", background_colour = "white",
width = 8, height = 5.33, units = "in")
#> pdf
#>   2
```

![](data:image/svg+xml;base64...)

gmovizPlot example

`gmovizPlot` also supports .svg and .ps outputs, as well as .png. Using a
vectorised output (.svg or .ps) is recommended as it allows you to easily edit
the plot in Illustrator or similar software.

# 3 Other features and hints

## 3.1 `gmoviz` colour sets

Often 20+ sectors will be plotted during the initialisation of an entire
genome. Thus, `gmoviz` includes five different colour sets each containing 34
colours in order to make it easier to give each of these sectors a unique,
beautiful colour. Many of the colours in these sets are from or are heavily
inspired by
[colorBrewer](http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3).
The colour sets are:

* `nice_colours`: The default colour set. Medium brightness, light colours
  designed for use on a white background.
* `pastel_colours`: A set of subdued/pastel colours (a less saturated version
  of the `nice_colours` set), designed for use on a white backgorund.
* `rich_colours`: A set of bright, vibrant colours (though not neon, like the
  `bright_colours_transparent`) designed for use on both white and black
  backgrounds.
* `bright_colours_transparent`: A set of very bright/neon colours
  **with slight transparency** designed for use on a black background.
* `bright_colours_opaque`: A set of very bright/neon colours
  **without transparency** designed for use on a black background.

Using `bright_colours_transparent` as the fill and `bright_colours_opaque` as
the outline gives a nice effect on black backgrounds.

## 3.2 Adding to plots using circlize functions

As mentioned, `gmoviz` is based on the *[circlize](https://CRAN.R-project.org/package%3Dcirclize)* (Gu et al. [2014](#ref-Gu_2014))
package by Zuguang Gu. Thus, `circlize` functions can be used alongside those
from `gmoviz` to further customise plots.

Internally, `gmoviz` calls `circos.clear()` **when initialising plots** (at the
beginning of the `gmovizInitialise`, `featureDiagram` and `insertionDiagram`
functions) not at the end of functions. This means that, after you have run a
`gmoviz` plotting function, you can use any `circlize` function to make
further additions to the plot.
For an example, we will further annotate the `insertionDiagram` plot produced
in the basic overview vignette [here](gmoviz_overview.html#insertion_diagram):

```
## the data
example_insertion <- GRanges(seqnames = "chr12",
                      ranges = IRanges(start = 70905597, end = 70917885),
                      name = "plasmid", colour = "#7270ea", length = 12000,
                      in_tandem = 11, shape = "forward_arrow")

## the original plot
insertionDiagram(example_insertion, either_side = c(70855503, 71398284),
                 start_degree = 45, space_between_sectors = 20)

## annotate with text
circos.text(x = 81000, y = 0.25, sector.index = "plasmid", track.index = 1,
            facing = "bending.inside", labels = "(blah)", cex = 0.75)

## annotate with a box
circos.rect(xleft = 0, xright = 12000, ytop = 1, ybottom = 0,
            track.index = 2, sector.index = "plasmid", border = "red")
```

![](data:image/jpeg;base64...)
Of course, use of `circlize` functions is not just limited to small
annotations. Functions such as `circos.trackPlotRegion()` and `circos.track()`
can be used to add additional tracks to plots generated with `gmoviz` and
likewise the `gmoviz` track functions (*e.g.* `drawFeatureTrack`) can be used
to add to plots previously generated with `circlize`. For more information
about using `circlize`, see the comprehensive book
[here](https://jokergoo.github.io/circlize_book/book/)

**Warning:** this also means that if you want to use `circlize` to generate a
new plot after using `gmoviz`, you will need to use `circos.clear()` to reset.

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

Gu, Zuguang, Roland Eils, and Matthias Schlesner. 2016. “Complex Heatmaps Reveal Patterns and Correlations in Multidimensional Genomic Data.” *Bioinformatics*.

Gu, Zuguang, Lei Gu, Roland Eils, Matthias Schlesner, and Benedikt Brors. 2014. “Circlize Implements and Enhances Circular Visualization in R.” *Bioinformatics* 30 (19): 2811–2. <https://doi.org/10.1093/bioinformatics/btu393>.