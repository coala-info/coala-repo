# Data visualization

Luca De Sano, Daniele Ramazzotti, Giulio Caravagna, Alex Graudenxi and Marco Antoniotti

#### October 30, 2025

#### Package

TRONCO 2.42.0

All examples in this section will be done with the the aCML dataset as reference.

## 0.1 Summary report for a dataset and boolean queries

We use the function `view` to get a short summary of a dataset that we loaded in TRONCO; this function reports on the number of samples and events, plus some meta information that could be displayed graphically.

```
view(aCML)
```

```
## Description: CAPRI - Bionformatics aCML data.
## -- TRONCO Dataset: n=64, m=31, |G|=23, patterns=0.
## Events (types): Ins/Del, Missense point, Nonsense Ins/Del, Nonsense point.
## Colors (plot): #7FC97F, #4483B0, #FDC086, #fab3d8.
## Events (5 shown):
##   gene 4 : Ins/Del TET2
##   gene 5 : Ins/Del EZH2
##   gene 6 : Ins/Del CBL
##   gene 7 : Ins/Del ASXL1
##   gene 29 : Missense point SETBP1
## Genotypes (5 shown):
```

## 0.2 Creating views with the `as` functions

Several functions are available to create views over a dataset, with a set of parameter which can constraint the view – as in the SELECT/JOIN approaches in databases. In the following examples we show their execution with the default parameters, but shorten their output to make this document readable.

The main `as` functions are here documented. `as.genotypes`, that we can use to get the matrix of *genotypes* that we imported.

```
as.genotypes(aCML)[1:10,5:10]
```

```
##            gene 29 gene 30 gene 31 gene 32 gene 33 gene 34
## patient 1        1       0       0       0       0       0
## patient 2        1       0       0       0       0       1
## patient 3        1       1       0       0       0       0
## patient 4        1       0       0       0       0       1
## patient 5        1       0       0       0       0       0
## patient 6        1       0       0       0       0       0
## patient 7        1       0       0       0       0       0
## patient 8        1       0       0       0       0       0
## patient 9        1       0       0       0       0       0
## patient 10       1       0       0       0       0       0
```

Differently, `as.events` and `as.events.in.samples`, that show tables with the events that we are processing in all dataset or in a specific sample that we want to examine.

```
as.events(aCML)[1:5, ]
```

```
##         type             event
## gene 4  "Ins/Del"        "TET2"
## gene 5  "Ins/Del"        "EZH2"
## gene 6  "Ins/Del"        "CBL"
## gene 7  "Ins/Del"        "ASXL1"
## gene 29 "Missense point" "SETBP1"
```

```
as.events.in.sample(aCML, sample = 'patient 2')
```

```
##         type             event
## gene 29 "Missense point" "SETBP1"
## gene 34 "Missense point" "CBL"
## gene 91 "Nonsense point" "ASXL1"
```

Concerning genes, `as.genes` shows the mnemonic names of the genes (or chromosomes, cytobands, etc.) that we included in our dataset.

```
as.genes(aCML)[1:8]
```

```
## [1] "TET2"   "EZH2"   "CBL"    "ASXL1"  "SETBP1" "NRAS"   "KRAS"   "IDH2"
```

And `as.types` shows the types of alterations (e.g., mutations, amplifications, etc.) that we have find in our dataset, and function `as.colors` shows the list of the colors which are associated to each type.

```
as.types(aCML)
```

```
## [1] "Ins/Del"          "Missense point"   "Nonsense Ins/Del" "Nonsense point"
```

```
as.colors(aCML)
```

```
##          Ins/Del   Missense point Nonsense Ins/Del   Nonsense point
##        "#7FC97F"        "#4483B0"        "#FDC086"        "#fab3d8"
```

A function `as.gene` can be used to display the alterations of a specific gene across the samples

```
head(as.gene(aCML, genes='SETBP1'))
```

```
##           Missense point SETBP1
## patient 1                     1
## patient 2                     1
## patient 3                     1
## patient 4                     1
## patient 5                     1
## patient 6                     1
```

Views over samples can be created as well. `as.samples` and `which.samples` list all the samples in the data, or return a list of samples that harbour a certain alteration. The former is

```
as.samples(aCML)[1:10]
```

```
##  [1] "patient 1"  "patient 2"  "patient 3"  "patient 4"  "patient 5"
##  [6] "patient 6"  "patient 7"  "patient 8"  "patient 9"  "patient 10"
```

and the latter is

```
which.samples(aCML, gene='TET2', type='Nonsense point')
```

```
## [1] "patient 12" "patient 13" "patient 26" "patient 29" "patient 40"
## [6] "patient 57" "patient 62"
```

A slightly different function, which manipulates the data, is `as.alterations`, which transforms a dataset with events of different type to events of a unique type, labeled *Alteration*.

```
dataset = as.alterations(aCML)
```

```
## *** Aggregating events of type(s) { Ins/Del, Missense point, Nonsense Ins/Del, Nonsense point }
## in a unique event with label " Alteration ".
## Dropping event types Ins/Del, Missense point, Nonsense Ins/Del, Nonsense point for 23 genes.
## .......................
## *** Binding events for 2 datasets.
```

```
view(dataset)
```

```
## -- TRONCO Dataset: n=64, m=23, |G|=23, patterns=0.
## Events (types): Alteration.
## Colors (plot): khaki.
## Events (5 shown):
##   G1 : Alteration TET2
##   G2 : Alteration EZH2
##   G3 : Alteration CBL
##   G4 : Alteration ASXL1
##   G5 : Alteration SETBP1
## Genotypes (5 shown):
```

When samples are enriched with stage information function `as.stages` can be used to create a view over such table. Views over patterns can be created as well – see Model Inference with CAPRI.

## 0.3 Dataset size

A set of functions allow to get the number of genes, events, samples, types and patterns in a dataset.

```
ngenes(aCML)
```

```
## [1] 23
```

```
nevents(aCML)
```

```
## [1] 31
```

```
nsamples(aCML)
```

```
## [1] 64
```

```
ntypes(aCML)
```

```
## [1] 4
```

```
npatterns(aCML)
```

```
## [1] 0
```

## 0.4 Oncoprints

Oncoprints are the most effective data-visualization functions in TRONCO. These are heatmaps where rows represent variants, and columns samples (*the reverse* of the input format required by TRONCO), and are annotated and displayed/sorted to enhance which samples have which mutations etc.

By default `oncoprint` will try to sort samples and events to enhance exclusivity patterns among the events.

```
oncoprint(aCML)
```

```
## *** Oncoprint for "CAPRI - Bionformatics aCML data"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
## Setting automatic row font (exponential scaling): 8.1
```

![This plot gives a graphical visualization of the events that are in the dataset -- with a color per event type. It sorts samples to enhance exclusivity patterns among the events](data:image/png;base64...)

Figure 1: This plot gives a graphical visualization of the events that are in the dataset – with a color per event type
It sorts samples to enhance exclusivity patterns among the events

But the sorting mechanism is bypassed if one wants to cluster samples or events, or if one wants to split samples by cluster (not shown). In the clustering case, the ordering is given by the dendrograms. In this case we also show the annotation of some groups of events via parameter `gene.annot`.

```
oncoprint(aCML,
    legend = FALSE,
    samples.cluster = TRUE,
    gene.annot = list(one = list('NRAS', 'SETBP1'), two = list('EZH2', 'TET2')),
    gene.annot.color = 'Set2',
    genes.cluster = TRUE)
```

```
## *** Oncoprint for "CAPRI - Bionformatics aCML data"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
## Annotating genes with RColorBrewer color palette Set2 .
## Setting automatic row font (exponential scaling): 8.1
## Clustering samples and showing dendogram.
## Clustering alterations and showing dendogram.
```

![This plot gives a graphical visualization of the events that are in the dataset -- with a color per event type. It it clusters samples/events](data:image/png;base64...)

Figure 2: This plot gives a graphical visualization of the events that are in the dataset – with a color per event type
It it clusters samples/events

Oncoprints can be annotated; a special type of annotation is given by stage data. As this is not available for the aCML dataset, we create it randomly, just for the sake of showing how the oncoprint is enriched with this information. This is the random stage map that we create – if some samples had no stage a NA would be added automatically.

```
stages = c(rep('stage 1', 32), rep('stage 2', 32))
stages = as.matrix(stages)
rownames(stages) = as.samples(aCML)
dataset = annotate.stages(aCML, stages = stages)
has.stages(aCML)
```

```
## [1] FALSE
```

```
head(as.stages(dataset))
```

```
##             stage
## patient 1 stage 1
## patient 2 stage 1
## patient 3 stage 1
## patient 4 stage 1
## patient 5 stage 1
## patient 6 stage 1
```

The `as.stages` function can now be used to create a view over stages.

```
head(as.stages(dataset))
```

```
##             stage
## patient 1 stage 1
## patient 2 stage 1
## patient 3 stage 1
## patient 4 stage 1
## patient 5 stage 1
## patient 6 stage 1
```

After that the data is annotated via `annotate.stages` function, we can again plot an oncoprint – which this time will detect that the dataset has also stages associated, and will diplay those

```
oncoprint(dataset, legend = FALSE)
```

```
## *** Oncoprint for "CAPRI - Bionformatics aCML data"
## with attributes: stage = TRUE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
## Annotating stages with RColorBrewer color palette YlOrRd
## Setting automatic row font (exponential scaling): 8.1
```

![](data:image/png;base64...)

If one is willing to display samples grouped according to some variable, for instance after a sample clustering task, he can use `group.samples` parameter of `oncoprint` and that will override the mutual exclusivity ordering. Here, we make the trick of using the stages as if they were such clustering result.

```
oncoprint(dataset, group.samples = as.stages(dataset))
```

```
## *** Oncoprint for "CAPRI - Bionformatics aCML data"
## with attributes: stage = TRUE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
## Grouping samples according to input groups (group.samples).
## Annotating stages with RColorBrewer color palette YlOrRd
## Grouping labels: stage 1, stage 2
## Setting automatic row font (exponential scaling): 8.1
```

![Example    exttt{oncoprint} output for aCML data with randomly annotated stages, in left, and samples clustered by group assignment in right -- for simplicity the group variable is again the stage annotation.](data:image/png;base64...)

Figure 3: Example exttt{oncoprint} output for aCML data with randomly annotated stages, in left, and samples clustered by group assignment in right – for simplicity the group variable is again the stage annotation

## 0.5 Groups visualization (e.g., pathways)

TRONCO provides functions to visualize groups of events, which in this case are called pathways – though this could be any group that one would like to define. Aggregation happens with the same rational as the `as.alterations` function, namely by merging the events in the group.

We make an example of a pathway called *MyPATHWAY* involving genes SETBP1, EZH2 and WT1; we want it to be colored in red, and we want to have the genotype of each event to be maintened in the dataset. We proceed as follows (R’s output is omitted).

```
pathway = as.pathway(aCML,
    pathway.genes = c('SETBP1', 'EZH2', 'WT1'),
    pathway.name = 'MyPATHWAY',
    pathway.color = 'red',
    aggregate.pathway = FALSE)
```

```
## *** Extracting events for pathway:  MyPATHWAY .
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  SETBP1, EZH2, WT1  ...  [ 3 / 3  found].
## Selected  5  events, returning.
## Pathway extracted succesfully.
## *** Binding events for 2 datasets.
```

Which we then visualize with an `oncoprint`

```
oncoprint(pathway, title = 'Custom pathway',  font.row = 8, cellheight = 15, cellwidth = 4)
```

```
## *** Oncoprint for "Custom pathway"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
```

![Oncoprint output of a custom pathway called MyPATHWAY involving genes SETBP1, EZH2 and WT1; the genotype of each event is shown.](data:image/png;base64...)

Figure 4: Oncoprint output of a custom pathway called MyPATHWAY involving genes SETBP1, EZH2 and WT1; the genotype of each event is shown

In TRONCO there is also a function which creates the pathway view and the corresponding oncoprint to multiple pathways, when these are given as a list. We make here a simple example of two custom pathways.

```
pathway.visualization(aCML,
    pathways=list(P1 = c('TET2', 'IRAK4'),  P2=c('SETBP1', 'KIT')),
    aggregate.pathways=FALSE,
    font.row = 8)
```

```
## Annotating pathways with RColorBrewer color palette Set2 .
## *** Processing pathways: P1, P2
##
## [PATHWAY "P1"] TET2, IRAK4
## *** Extracting events for pathway:  P1 .
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  TET2, IRAK4  ...  [ 2 / 2  found].
## Selected  4  events, returning.
## Pathway extracted succesfully.
## *** Binding events for 2 datasets.
##
##
## [PATHWAY "P2"] SETBP1, KIT
## *** Extracting events for pathway:  P2 .
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  SETBP1, KIT  ...  [ 2 / 2  found].
## Selected  2  events, returning.
## Pathway extracted succesfully.
## *** Binding events for 2 datasets.
## *** Binding events for 2 datasets.
## *** Oncoprint for "Pathways: P1, P2"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
```

![Oncoprint output of a custom pair of pathways, with events shown](data:image/png;base64...)

Figure 5: Oncoprint output of a custom pair of pathways, with events shown

```
## NULL
```

If we had to visualize just the signature of the pathway, we could set `aggregate.pathways=T`.

```
pathway.visualization(aCML,
    pathways=list(P1 = c('TET2', 'IRAK4'),  P2=c('SETBP1', 'KIT')),
    aggregate.pathways = TRUE,
    font.row = 8)
```

```
## Annotating pathways with RColorBrewer color palette Set2 .
## *** Processing pathways: P1, P2
##
## [PATHWAY "P1"] TET2, IRAK4
## *** Extracting events for pathway:  P1 .
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  TET2, IRAK4  ...  [ 2 / 2  found].
## Selected  4  events, returning.
## Pathway extracted succesfully.
##
##
## [PATHWAY "P2"] SETBP1, KIT
## *** Extracting events for pathway:  P2 .
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { FALSE ,  TRUE ,  FALSE }
## [filter.in] Genes hold:  SETBP1, KIT  ...  [ 2 / 2  found].
## Selected  2  events, returning.
## Pathway extracted succesfully.
## *** Binding events for 2 datasets.
## *** Oncoprint for "Pathways: P1, P2"
## with attributes: stage = FALSE, hits = TRUE
## Sorting samples ordering to enhance exclusivity patterns.
```

![Oncoprint output of a custom pair of pathways, with events hidden](data:image/png;base64...)

Figure 6: Oncoprint output of a custom pair of pathways, with events hidden

```
## NULL
```

The same operation could have been done using [WikiPathways](https://wikipathways.org). We can query WikiPathways and collect HGNC gene symbols and titles for pathways of interest as follows. (R’s output is omitted).

```
library(rWikiPathways)
# quotes inside query to require both terms
my.pathways <- findPathwaysByText('SETBP1 EZH2 TET2 IRAK4 SETBP1 KIT')
human.filter <- lapply(my.pathways, function(x) x$species == "Homo sapiens")
my.hs.pathways <- my.pathways[unlist(human.filter)]
# collect pathways idenifiers
my.wpids <- sapply(my.hs.pathways, function(x) x$id)

pw.title<-my.hs.pathways[[1]]$name
pw.genes<-getXrefList(my.wpids[1],"H")
```

Now `pw.genes` and `pw.title` can be used as input for the function `as.pathway`.
It is also possible to view and edit these pathways at WikiPathways using the following commands to open tabs in your default browser.

```
browseURL(getPathwayInfo(my.wpids[1])[2])
browseURL(getPathwayInfo(my.wpids[2])[2])
browseURL(getPathwayInfo(my.wpids[3])[2])
```