# Data manipulation

Luca De Sano, Daniele Ramazzotti, Giulio Caravagna, Alex Graudenxi and Marco Antoniotti

#### October 30, 2025

#### Package

TRONCO 2.42.0

All examples in this section will be done with the the aCML dataset as reference.

## 0.1 Modifying events and samples

TRONCO provides functions for renaming the events that were included in a dataset, or the type associated to a set of events (e.g., a `Mutation` could be renamed to a `Missense Mutation`).

```
dataset = rename.gene(aCML, 'TET2', 'new name')
dataset = rename.type(dataset, 'Ins/Del', 'new type')
as.events(dataset, type = 'new type')
```

```
##        type       event
## gene 4 "new type" "new name"
## gene 5 "new type" "EZH2"
## gene 6 "new type" "CBL"
## gene 7 "new type" "ASXL1"
```

and return a modified TRONCO object. More complex operations are also possible. For instance, two events with the same signature – i.e., appearing in the same samples – can be joined to a new event (see also Data Consolidation in Model Inference) with the same signature and a new name.

```
dataset = join.events(aCML,
    'gene 4',
    'gene 88',
    new.event='test',
    new.type='banana',
    event.color='yellow')
```

```
## *** Binding events for 2 datasets.
```

where in this case we also created a new event type, with its own color.

In a similar way we can decide to join all the events of two distinct types, in this case if a gene *x* has signatures for both type of events, he will get a unique signature with an alteration present if it is either of the second *or* the second type

```
dataset = join.types(dataset, 'Nonsense point', 'Nonsense Ins/Del')
```

```
## *** Aggregating events of type(s) { Nonsense point, Nonsense Ins/Del }
## in a unique event with label " new.type ".
## Dropping event types Nonsense point, Nonsense Ins/Del for 6 genes.
## ......
## *** Binding events for 2 datasets.
```

```
as.types(dataset)
```

```
## [1] "Ins/Del"        "Missense point" "banana"         "new.type"
```

TRONCO also provides functions for deleting specific events, samples or types.

```
dataset = delete.gene(aCML, gene = 'TET2')
dataset = delete.event(dataset, gene = 'ASXL1', type = 'Ins/Del')
dataset = delete.samples(dataset, samples = c('patient 5', 'patient 6'))
dataset = delete.type(dataset, type = 'Missense point')
view(dataset)
```

```
## Description: CAPRI - Bionformatics aCML data.
## -- TRONCO Dataset: n=62, m=8, |G|=7, patterns=0.
## Events (types): Ins/Del, Nonsense Ins/Del, Nonsense point.
## Colors (plot): #7FC97F, #FDC086, #fab3d8.
## Events (5 shown):
##   gene 5 : Ins/Del EZH2
##   gene 6 : Ins/Del CBL
##   gene 66 : Nonsense Ins/Del WT1
##   gene 69 : Nonsense Ins/Del RUNX1
##   gene 77 : Nonsense Ins/Del CEBPA
## Genotypes (5 shown):
```

## 0.2 Modifying patterns

TRONCO provides functions to edit patterns, pretty much as for any other type of events. Patterns however have a special denotation and are supported only by CAPRI algorithm – see Model Reconstruction with CAPRI to see a practical application of that.

## 0.3 Subsetting a dataset

It is very often the case that we want to subset a dataset by either selecting only some of its samples, or some of its events. Function `samples.selection` returns a dataset with only some selected samples.

```
dataset = samples.selection(aCML, samples = as.samples(aCML)[1:3])
view(dataset)
```

```
## Description: CAPRI - Bionformatics aCML data.
## -- TRONCO Dataset: n=3, m=31, |G|=23, patterns=0.
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

Function `events.selection`, instead, performs selection according to a filter of events. With this function, we can subset data according to a frequency, and we can force inclusion/exclusion of certain events by specifying their name. For instance, here we pick all events with a minimum frequency of 5%, force exclusion of SETBP1 (all events associated), and inclusion of EZH1 and EZH2.

```
dataset = events.selection(aCML,  filter.freq = .05,
    filter.in.names = c('EZH1','EZH2'),
    filter.out.names = 'SETBP1')
```

```
## *** Events selection: #events =  31 , #types =  4 Filters freq|in|out = { TRUE ,  TRUE ,  TRUE }
## Minimum event frequency:  0.05  ( 3  alterations out of  64  samples).
## ...............................
## Selected  9  events.
##
## [filter.in] Genes hold:  EZH1, EZH2  ...  [ 1 / 2  found].
## [filter.out] Genes dropped:  SETBP1  ...  [ 1 / 1  found].
## Selected  10  events, returning.
```

```
as.events(dataset)
```

```
##         type             event
## gene 4  "Ins/Del"        "TET2"
## gene 5  "Ins/Del"        "EZH2"
## gene 7  "Ins/Del"        "ASXL1"
## gene 30 "Missense point" "NRAS"
## gene 32 "Missense point" "TET2"
## gene 33 "Missense point" "EZH2"
## gene 55 "Missense point" "CSF3R"
## gene 88 "Nonsense point" "TET2"
## gene 89 "Nonsense point" "EZH2"
## gene 91 "Nonsense point" "ASXL1"
```

An example visualization of the data before and after the selection process can be obtained by combining the `gtable` objects returned by . We here use `gtable = T` to get access to have a GROB table returned, and `silent = T` to avoid that the calls to the function display on the device; the call to `grid.arrange` displays the captured `gtable` objects.

```
library(gridExtra)
grid.arrange(
    oncoprint(as.alterations(aCML, new.color = 'brown3'),
        cellheight = 6, cellwidth = 4, gtable = TRUE,
        silent = TRUE, font.row = 6)$gtable,
    oncoprint(dataset, cellheight = 6, cellwidth = 4,
        gtable = TRUE, silent = TRUE, font.row = 6)$gtable,
    ncol = 1)
```

![Multiple output from oncoprint can be captured as a gtable and composed via grid.arrange (package gridExtra). In this case we show  aCML data on top -- displayed after the as.alterations transformation -- versus a selected subdataset of events with a minimum frequency of 5%, force exclusion of SETBP1 (all events associated), and inclusion of EZH1 and EZH2.](data:image/png;base64...)

Figure 1: Multiple output from oncoprint can be captured as a gtable and composed via grid.arrange (package gridExtra)
In this case we show aCML data on top – displayed after the as.alterations transformation – versus a selected subdataset of events with a minimum frequency of 5%, force exclusion of SETBP1 (all events associated), and inclusion of EZH1 and EZH2.