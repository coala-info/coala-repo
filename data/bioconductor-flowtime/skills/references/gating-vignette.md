# Yeast gating

#### R Clay Wright

#### 2025-10-30

This vignette walks through visualization and creation of gate sets and schemes used to measure the dynamic responses of yeast synthetic signaling pathways by flow cytometry.

Budding yeast cultures contain a wide range of cell size and granularity due to bud growth and scarring. Size and granularity are roughly measured by the forward and side scatter area parameters, FSC-A and SSC-A. Throughout this vignette these parameters with dashes and dots will be used interchangeably–i.e. FSC-A = FSC.A–as within R code `FSC-A` is read as “FSC minus A”.

Let’s read in some example data to see what an FSC.A vs SSC.A plot typically looks like.

```
data <- read.flowSet(path = system.file("extdata", "ss_example", package = "flowTime"),
    alter.names = TRUE)
annotation <- read.csv(system.file("extdata", "ss_example.csv", package = "flowTime"))
adat <- annotateFlowSet(yourFlowSet = data, annotation_df = annotation, mergeBy = "name")
```

To plot flow data we will use the `ggcyto` package, and to define gates we will use the `flowStats`, `flowClust` and `openCyto` packages. To build our gate set we will use the `flowWorkspace` package, which is automatically imported by `openCyto`. Let’s load these and I will also comment out some lines linking you to the relevant vignettes in these packages for your reference.

```
# library(BiocManager) BiocManager::install('openCyto')
# BiocManager::install('ggcyto')

library("openCyto")
library("ggcyto")
#> Loading required package: ncdfFlow
#> Loading required package: BH
#> Loading required package: flowWorkspace
#> As part of improvements to flowWorkspace, some behavior of
#> GatingSet objects has changed. For details, please read the section
#> titled "The cytoframe and cytoset classes" in the package vignette:
#>
#>   vignette("flowWorkspace-Introduction", "flowWorkspace")
library("flowClust")
#>
#> Attaching package: 'flowClust'
#> The following object is masked from 'package:graphics':
#>
#>     box
#> The following object is masked from 'package:base':
#>
#>     Map

# vignette('flowWorkspace-Introduction', 'flowWorkspace')
# vignette('HowToAutoGating', package = 'openCyto')
```

Now what was that plot we wanted to make? FSC.A vs SSC.A, roughly representing the Size vs. Granularity of each cell (or event).

```
autoplot(data[21:24], x = "FSC-A", y = "SSC-A")
#> Warning: `aes_()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`
#> ℹ The deprecated feature was likely used in the ggcyto package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

Notice how most of the events are clustered very close to the origin, but a few outlier events with FSC.A and/or SSC.A values 10 times that of the average are stretching out our axis. Some of the events collected may be junk in the media! Debris, clumps of cells, dead cells, flotsam, jetsam, dust, who-knows. We don’t want to include this in our analysis, we only want to measure cells.

Cytometry allows us to rationally remove this noise from our data, by only selecting the cells within a boundary called a gate. We can define gates in any parameter space and almost any area within that space. We can apply a series of gates in order to define specific cells we want to analyze.

So in this case we want to remove those high FSC-A events, as they are not likely cells. To gate out the high FSC-A junk, we can define a vertical line on the FSC.A axis and only carry forward the majority of cells on the left-hand side of that line. To define the location of this line in a reproducible way we can measure the percentage of events on that side and aim for a particular number, typically 99% or 99.5%, but this will depend on your conditions and equipment.

Let’s use only the lower 99th quantile of the data to define our gate automatically via the `openCyto::gate_quantile` function. We can use the `autoplot` function to see how much of the tail of our event distribution we have removed.

```
Debris <- gate_quantile(fr = data[[3]], channel = "FSC.A", probs = 0.99, filterId = "Debris")
autoplot(data[[3]], x = "FSC-A") + geom_gate(Debris)
#> Warning: Using the `size` aesthetic with geom_segment was deprecated in ggplot2 3.4.0.
#> ℹ Please use the `linewidth` aesthetic instead.
#> ℹ The deprecated feature was likely used in the ggcyto package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

We can also view this gate on any other axes, and create a table summarizing the proportion of events in this gate for several frames.

```
autoplot(data[21:24], x = "FSC-A", "SSC-A") + geom_gate(Debris)
```

![](data:image/png;base64...)

```
toTable(summary(filter(data[c(3, 21:24)], !Debris)))
#> filter summary for frame 'A03.fcs'
#>  not Debris+: 824 of 833 events (98.92%)
#>
#> filter summary for frame 'F01.fcs'
#>  not Debris+: 828 of 833 events (99.40%)
#>
#> filter summary for frame 'F02.fcs'
#>  not Debris+: 828 of 833 events (99.40%)
#>
#> filter summary for frame 'F03.fcs'
#>  not Debris+: 829 of 833 events (99.52%)
#>
#> filter summary for frame 'F04.fcs'
#>  not Debris+: 828 of 833 events (99.40%)
#>    sample  population  percent count true false         p           q
#> 1 A03.fcs not Debris+ 98.91957   833  824     9 0.9891957 0.010804322
#> 2 F01.fcs not Debris+ 99.39976   833  828     5 0.9939976 0.006002401
#> 3 F02.fcs not Debris+ 99.39976   833  828     5 0.9939976 0.006002401
#> 4 F03.fcs not Debris+ 99.51981   833  829     4 0.9951981 0.004801921
#> 5 F04.fcs not Debris+ 99.39976   833  828     5 0.9939976 0.006002401
```

While this gate which was determined based on one timepoint (or frame) doesn’t look bad it might be good to define gates based on a whole flowSet that covers the range of phenotypic diversity between strains, growth conditions, and time. To do this, let’s make a big frame contain the whole flowSet.

```
# Initialize the single frame
data.1frame <- data[[1]]
# fill the single frame with the exprs data from each frame in the flow set
exprs(data.1frame) <- fsApply(data, function(x) {
    x <- exprs(x)
    return(x)
})

autoplot(data.1frame, x = "FSC-A", "SSC-A")
```

![](data:image/png;base64...)

We also want to remove junk at the lower end of the FSC and SSC scales. To get a better view of what is going on towards the origin of this plot we can use a log or biexponential transform, but on the of the most useful transforms is the logicle transform, which is an generalization of a hyperbolic sine transformation. We can plot our data on this scale by simply adding `scale_x_logicle`.

```
autoplot(data.1frame, x = "FSC-A", "SSC-A") + scale_x_logicle() + scale_y_logicle()
```

![](data:image/png;base64...)

Let’s go ahead and apply this transformation to the data so that we can build a gate to remove debris on this scale.

```
chnls <- c("FSC.A", "SSC.A", "FSC.H", "SSC.H")
trans <- estimateLogicle(data.1frame, channels = chnls)
inv.trans <- inverseLogicleTransform(trans)
data.1frame <- transform(data.1frame, trans)
autoplot(data.1frame, x = "FSC-A", "SSC-A")
```

![](data:image/png;base64...)

Now instead of defining cutoffs based on quantiles, we can define an ellipse containing 95% of this data representing our entire flowSet. To do this we will use the `gate_flowclust_2d` function.

```
yeast <- gate_flowClust_2d(data.1frame, xChannel = "FSC.A", yChannel = "SSC.A", K = 1,
    quantile = 0.95, min = c(0, 0))
#> Warning in gate_flowClust_2d(data.1frame, xChannel = "FSC.A", yChannel = "SSC.A", : 'gate_flowClust_2d' is deprecated.
#> Use 'gate_flowclust_2d' instead.
#> See help("Deprecated")
#> The prior specification has no effect when usePrior=no
#> Using the serial version of flowClust
autoplot(data.1frame, x = "FSC-A", y = "SSC-A") + geom_gate(yeast)
```

![](data:image/png;base64...)

To apply this gate across our whole flowSet, we need to either transform the whole flowSet, or reverse transform the gate we created. We will also reverse transform the single frame dataset so we can use it to make a singlet gate.

```
yeast <- transform(yeast, inv.trans)
data.1frame <- transform(data.1frame, inv.trans)
```

```
autoplot(data[c(1, 8, 16, 24, 32)], "FSC.A", "SSC.A") + geom_gate(yeast)
```

![](data:image/png;base64...)

```
# invisible(capture.output( we have to use this to prevent summary from
# printing
f <- summary(filter(data, yeast))  #))
#> filter summary for frame 'A01.fcs'
#>  defaultEllipsoidGate+: 821 of 833 events (98.56%)
#>
#> filter summary for frame 'A02.fcs'
#>  defaultEllipsoidGate+: 819 of 833 events (98.32%)
#>
#> filter summary for frame 'A03.fcs'
#>  defaultEllipsoidGate+: 816 of 833 events (97.96%)
#>
#> filter summary for frame 'A04.fcs'
#>  defaultEllipsoidGate+: 822 of 833 events (98.68%)
#>
#> filter summary for frame 'B01.fcs'
#>  defaultEllipsoidGate+: 812 of 833 events (97.48%)
#>
#> filter summary for frame 'B02.fcs'
#>  defaultEllipsoidGate+: 817 of 833 events (98.08%)
#>
#> filter summary for frame 'B03.fcs'
#>  defaultEllipsoidGate+: 807 of 833 events (96.88%)
#>
#> filter summary for frame 'B04.fcs'
#>  defaultEllipsoidGate+: 813 of 833 events (97.60%)
#>
#> filter summary for frame 'C01.fcs'
#>  defaultEllipsoidGate+: 823 of 833 events (98.80%)
#>
#> filter summary for frame 'C02.fcs'
#>  defaultEllipsoidGate+: 816 of 833 events (97.96%)
#>
#> filter summary for frame 'C03.fcs'
#>  defaultEllipsoidGate+: 817 of 833 events (98.08%)
#>
#> filter summary for frame 'C04.fcs'
#>  defaultEllipsoidGate+: 820 of 833 events (98.44%)
#>
#> filter summary for frame 'D01.fcs'
#>  defaultEllipsoidGate+: 812 of 833 events (97.48%)
#>
#> filter summary for frame 'D02.fcs'
#>  defaultEllipsoidGate+: 817 of 833 events (98.08%)
#>
#> filter summary for frame 'D03.fcs'
#>  defaultEllipsoidGate+: 813 of 833 events (97.60%)
#>
#> filter summary for frame 'D04.fcs'
#>  defaultEllipsoidGate+: 822 of 833 events (98.68%)
#>
#> filter summary for frame 'E01.fcs'
#>  defaultEllipsoidGate+: 818 of 833 events (98.20%)
#>
#> filter summary for frame 'E02.fcs'
#>  defaultEllipsoidGate+: 820 of 833 events (98.44%)
#>
#> filter summary for frame 'E03.fcs'
#>  defaultEllipsoidGate+: 822 of 833 events (98.68%)
#>
#> filter summary for frame 'E04.fcs'
#>  defaultEllipsoidGate+: 813 of 833 events (97.60%)
#>
#> filter summary for frame 'F01.fcs'
#>  defaultEllipsoidGate+: 821 of 833 events (98.56%)
#>
#> filter summary for frame 'F02.fcs'
#>  defaultEllipsoidGate+: 817 of 833 events (98.08%)
#>
#> filter summary for frame 'F03.fcs'
#>  defaultEllipsoidGate+: 818 of 833 events (98.20%)
#>
#> filter summary for frame 'F04.fcs'
#>  defaultEllipsoidGate+: 820 of 833 events (98.44%)
#>
#> filter summary for frame 'G01.fcs'
#>  defaultEllipsoidGate+: 823 of 833 events (98.80%)
#>
#> filter summary for frame 'G02.fcs'
#>  defaultEllipsoidGate+: 826 of 833 events (99.16%)
#>
#> filter summary for frame 'G03.fcs'
#>  defaultEllipsoidGate+: 816 of 833 events (97.96%)
#>
#> filter summary for frame 'G04.fcs'
#>  defaultEllipsoidGate+: 823 of 833 events (98.80%)
#>
#> filter summary for frame 'H01.fcs'
#>  defaultEllipsoidGate+: 820 of 833 events (98.44%)
#>
#> filter summary for frame 'H02.fcs'
#>  defaultEllipsoidGate+: 809 of 833 events (97.12%)
#>
#> filter summary for frame 'H03.fcs'
#>  defaultEllipsoidGate+: 818 of 833 events (98.20%)
#>
#> filter summary for frame 'H04.fcs'
#>  defaultEllipsoidGate+: 822 of 833 events (98.68%)
# Now we can print our summary as a table
toTable(f)
#>     sample            population  percent count true false         p
#> 1  A01.fcs defaultEllipsoidGate+ 98.55942   833  821    12 0.9855942
#> 2  A02.fcs defaultEllipsoidGate+ 98.31933   833  819    14 0.9831933
#> 3  A03.fcs defaultEllipsoidGate+ 97.95918   833  816    17 0.9795918
#> 4  A04.fcs defaultEllipsoidGate+ 98.67947   833  822    11 0.9867947
#> 5  B01.fcs defaultEllipsoidGate+ 97.47899   833  812    21 0.9747899
#> 6  B02.fcs defaultEllipsoidGate+ 98.07923   833  817    16 0.9807923
#> 7  B03.fcs defaultEllipsoidGate+ 96.87875   833  807    26 0.9687875
#> 8  B04.fcs defaultEllipsoidGate+ 97.59904   833  813    20 0.9759904
#> 9  C01.fcs defaultEllipsoidGate+ 98.79952   833  823    10 0.9879952
#> 10 C02.fcs defaultEllipsoidGate+ 97.95918   833  816    17 0.9795918
#> 11 C03.fcs defaultEllipsoidGate+ 98.07923   833  817    16 0.9807923
#> 12 C04.fcs defaultEllipsoidGate+ 98.43938   833  820    13 0.9843938
#> 13 D01.fcs defaultEllipsoidGate+ 97.47899   833  812    21 0.9747899
#> 14 D02.fcs defaultEllipsoidGate+ 98.07923   833  817    16 0.9807923
#> 15 D03.fcs defaultEllipsoidGate+ 97.59904   833  813    20 0.9759904
#> 16 D04.fcs defaultEllipsoidGate+ 98.67947   833  822    11 0.9867947
#> 17 E01.fcs defaultEllipsoidGate+ 98.19928   833  818    15 0.9819928
#> 18 E02.fcs defaultEllipsoidGate+ 98.43938   833  820    13 0.9843938
#> 19 E03.fcs defaultEllipsoidGate+ 98.67947   833  822    11 0.9867947
#> 20 E04.fcs defaultEllipsoidGate+ 97.59904   833  813    20 0.9759904
#> 21 F01.fcs defaultEllipsoidGate+ 98.55942   833  821    12 0.9855942
#> 22 F02.fcs defaultEllipsoidGate+ 98.07923   833  817    16 0.9807923
#> 23 F03.fcs defaultEllipsoidGate+ 98.19928   833  818    15 0.9819928
#> 24 F04.fcs defaultEllipsoidGate+ 98.43938   833  820    13 0.9843938
#> 25 G01.fcs defaultEllipsoidGate+ 98.79952   833  823    10 0.9879952
#> 26 G02.fcs defaultEllipsoidGate+ 99.15966   833  826     7 0.9915966
#> 27 G03.fcs defaultEllipsoidGate+ 97.95918   833  816    17 0.9795918
#> 28 G04.fcs defaultEllipsoidGate+ 98.79952   833  823    10 0.9879952
#> 29 H01.fcs defaultEllipsoidGate+ 98.43938   833  820    13 0.9843938
#> 30 H02.fcs defaultEllipsoidGate+ 97.11885   833  809    24 0.9711885
#> 31 H03.fcs defaultEllipsoidGate+ 98.19928   833  818    15 0.9819928
#> 32 H04.fcs defaultEllipsoidGate+ 98.67947   833  822    11 0.9867947
#>              q
#> 1  0.014405762
#> 2  0.016806723
#> 3  0.020408163
#> 4  0.013205282
#> 5  0.025210084
#> 6  0.019207683
#> 7  0.031212485
#> 8  0.024009604
#> 9  0.012004802
#> 10 0.020408163
#> 11 0.019207683
#> 12 0.015606242
#> 13 0.025210084
#> 14 0.019207683
#> 15 0.024009604
#> 16 0.013205282
#> 17 0.018007203
#> 18 0.015606242
#> 19 0.013205282
#> 20 0.024009604
#> 21 0.014405762
#> 22 0.019207683
#> 23 0.018007203
#> 24 0.015606242
#> 25 0.012004802
#> 26 0.008403361
#> 27 0.020408163
#> 28 0.012004802
#> 29 0.015606242
#> 30 0.028811525
#> 31 0.018007203
#> 32 0.013205282
```

So this conservative gating strategy gets rid of many large particles in the earlier timepoints/frames.

As mentioned above we are using budding yeast, which divide by growing new smaller cells called buds periodically. These budding cells, as well as dividing mammalian cells or fission yeast cells or two cells stuck together, are called doublets in flow cytometry lingo. Because dividing cells are devoting much of their energy to dividing this can introduce more noise in our measurements of signaling pathways and the proteins in them. So we want to gate out only the singlet cells, that don’t have significant buds.

To find the singlet cells we will compare the size of events, the FSC-A (forward scatter area) parameter again, to the forward scatter height parameter. If two cells pass through the path of the laser immediately next to each other they will generate a pulse that is twice as wide, but equally as high, as a single cell. So doublets will have twice the area of singlets, and singlets will fall roughly on the line FSC-A = FSC-H. The `flowStats::gate_singlet` function provides a convenient, reproducible, data-driven method for gating singlets.

```
autoplot(Subset(data.1frame, yeast), "FSC-A", "FSC-H")
```

![](data:image/png;base64...)

```
library(flowStats)
#> Warning: replacing previous import 'flowViz::contour' by 'graphics::contour'
#> when loading 'flowStats'
chnl <- c("FSC-A", "FSC-H")
singlets <- gate_singlet(x = Subset(data.1frame, yeast), area = "FSC.A", height = "FSC.H",
    prediction_level = 0.999, maxit = 20)
autoplot(Subset(data.1frame, yeast), "FSC-A", "FSC-H") + geom_gate(singlets)
```

![](data:image/png;base64...)

Now lets look at how this plays out for several frames

```
autoplot(data[c(1:4, 29:32)], x = "FSC-A", y = "FSC-H") + geom_gate(singlets) + facet_wrap("name",
    ncol = 4)
```

![](data:image/png;base64...)

```
autoplot(Subset(data[c(1:4, 29:32)], yeast & singlets), x = "FL1-A") + facet_wrap("name",
    ncol = 4)
```

![](data:image/png;base64...)

This looks very consistent across the course of this experiment!

Let’s get some stats to see just how consistent this gate is. Since the samples were collected in alphanumeric order according to the sample name we can also plot the percent of events in our gates vs time/sample, to look for any trends.

```
invisible(capture.output(d <- summary(filter(data, yeast & singlets))))
(e <- toTable(d))
#>     sample                        population  percent count true false
#> 1  A01.fcs defaultEllipsoidGate and singlet+ 90.51621   833  754    79
#> 2  A02.fcs defaultEllipsoidGate and singlet+ 93.03721   833  775    58
#> 3  A03.fcs defaultEllipsoidGate and singlet+ 91.35654   833  761    72
#> 4  A04.fcs defaultEllipsoidGate and singlet+ 93.27731   833  777    56
#> 5  B01.fcs defaultEllipsoidGate and singlet+ 91.95678   833  766    67
#> 6  B02.fcs defaultEllipsoidGate and singlet+ 91.83673   833  765    68
#> 7  B03.fcs defaultEllipsoidGate and singlet+ 88.11525   833  734    99
#> 8  B04.fcs defaultEllipsoidGate and singlet+ 92.07683   833  767    66
#> 9  C01.fcs defaultEllipsoidGate and singlet+ 93.87755   833  782    51
#> 10 C02.fcs defaultEllipsoidGate and singlet+ 93.51741   833  779    54
#> 11 C03.fcs defaultEllipsoidGate and singlet+ 90.63625   833  755    78
#> 12 C04.fcs defaultEllipsoidGate and singlet+ 91.59664   833  763    70
#> 13 D01.fcs defaultEllipsoidGate and singlet+ 93.39736   833  778    55
#> 14 D02.fcs defaultEllipsoidGate and singlet+ 93.03721   833  775    58
#> 15 D03.fcs defaultEllipsoidGate and singlet+ 91.59664   833  763    70
#> 16 D04.fcs defaultEllipsoidGate and singlet+ 92.79712   833  773    60
#> 17 E01.fcs defaultEllipsoidGate and singlet+ 94.23770   833  785    48
#> 18 E02.fcs defaultEllipsoidGate and singlet+ 92.43697   833  770    63
#> 19 E03.fcs defaultEllipsoidGate and singlet+ 91.95678   833  766    67
#> 20 E04.fcs defaultEllipsoidGate and singlet+ 92.91717   833  774    59
#> 21 F01.fcs defaultEllipsoidGate and singlet+ 93.51741   833  779    54
#> 22 F02.fcs defaultEllipsoidGate and singlet+ 92.55702   833  771    62
#> 23 F03.fcs defaultEllipsoidGate and singlet+ 92.91717   833  774    59
#> 24 F04.fcs defaultEllipsoidGate and singlet+ 94.47779   833  787    46
#> 25 G01.fcs defaultEllipsoidGate and singlet+ 93.99760   833  783    50
#> 26 G02.fcs defaultEllipsoidGate and singlet+ 94.59784   833  788    45
#> 27 G03.fcs defaultEllipsoidGate and singlet+ 92.19688   833  768    65
#> 28 G04.fcs defaultEllipsoidGate and singlet+ 95.07803   833  792    41
#> 29 H01.fcs defaultEllipsoidGate and singlet+ 93.87755   833  782    51
#> 30 H02.fcs defaultEllipsoidGate and singlet+ 93.87755   833  782    51
#> 31 H03.fcs defaultEllipsoidGate and singlet+ 92.67707   833  772    61
#> 32 H04.fcs defaultEllipsoidGate and singlet+ 94.35774   833  786    47
#>            p          q
#> 1  0.9051621 0.09483794
#> 2  0.9303721 0.06962785
#> 3  0.9135654 0.08643457
#> 4  0.9327731 0.06722689
#> 5  0.9195678 0.08043217
#> 6  0.9183673 0.08163265
#> 7  0.8811525 0.11884754
#> 8  0.9207683 0.07923169
#> 9  0.9387755 0.06122449
#> 10 0.9351741 0.06482593
#> 11 0.9063625 0.09363745
#> 12 0.9159664 0.08403361
#> 13 0.9339736 0.06602641
#> 14 0.9303721 0.06962785
#> 15 0.9159664 0.08403361
#> 16 0.9279712 0.07202881
#> 17 0.9423770 0.05762305
#> 18 0.9243697 0.07563025
#> 19 0.9195678 0.08043217
#> 20 0.9291717 0.07082833
#> 21 0.9351741 0.06482593
#> 22 0.9255702 0.07442977
#> 23 0.9291717 0.07082833
#> 24 0.9447779 0.05522209
#> 25 0.9399760 0.06002401
#> 26 0.9459784 0.05402161
#> 27 0.9219688 0.07803121
#> 28 0.9507803 0.04921969
#> 29 0.9387755 0.06122449
#> 30 0.9387755 0.06122449
#> 31 0.9267707 0.07322929
#> 32 0.9435774 0.05642257
e <- left_join(e, pData(data), by = c(sample = "name"))
ggplot(data = e, mapping = aes(x = as.factor(sample), y = percent)) + geom_point()
```

![](data:image/png;base64...)

This looks quite good. As we might expect as the growth enters exponential phase as time progresses (and well numbers get higher) more of our population is captured in the yeast and singlet gates. Based on the periodicity of this it also looks like there is some dependence on the strain. Now we can either go ahead and apply these gates to the data, and summarize the data with `summarizeFlow` setting the `gated` argument to `TRUE`.

```
data <- Subset(data, yeast & singlets)
data_sum <- summarizeFlow(data, channel = c("FL1.A", "FL4.A"), gated = TRUE)
```

Or we can save these as a gateSet and use the `ploidy` and `only` arguments to specify how the flowSet should be gated. Within the current version of flowTime these gates are just saved as separate objects within a single `.Rdata` file using the saveGates function. The gates we can define within this function are `yeastGate` defining the population of yeast cells from junk, `dipsingletGate` defining the singlets of your diploid yeast strain, `dipdoubletGate` defining the population of diploid doublet cells, and similarly `hapsingletGate` and `hapdoubletGate` for haploid cells. *Make sure these gates are specified in the same transformation that your dataset is in.*

This example data set was collected using a diploid strain, so we will only create these gates.

```
saveGates(yeastGate = yeast, dipsingletGate = singlets, fileName = "PSB_Accuri_W303.RData")
loadGates(gatesFile = "PSB_Accuri_W303.RData")
data_sum <- summarizeFlow(data, channel = c("FL1.A", "FL4.A"), ploidy = "diploid",
    only = "singlets")
```