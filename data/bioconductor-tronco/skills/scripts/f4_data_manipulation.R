# Code example from 'f4_data_manipulation' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(TRONCO)
data(aCML)
data(crc_maf)
data(crc_gistic)
data(crc_plain)

## -----------------------------------------------------------------------------
dataset = rename.gene(aCML, 'TET2', 'new name')
dataset = rename.type(dataset, 'Ins/Del', 'new type')
as.events(dataset, type = 'new type')

## -----------------------------------------------------------------------------
dataset = join.events(aCML, 
    'gene 4',
    'gene 88',
    new.event='test',
    new.type='banana',
    event.color='yellow')

## -----------------------------------------------------------------------------
dataset = join.types(dataset, 'Nonsense point', 'Nonsense Ins/Del')
as.types(dataset)

## -----------------------------------------------------------------------------
dataset = delete.gene(aCML, gene = 'TET2')
dataset = delete.event(dataset, gene = 'ASXL1', type = 'Ins/Del')
dataset = delete.samples(dataset, samples = c('patient 5', 'patient 6'))
dataset = delete.type(dataset, type = 'Missense point')
view(dataset)

## -----------------------------------------------------------------------------
dataset = samples.selection(aCML, samples = as.samples(aCML)[1:3])
view(dataset)

## -----------------------------------------------------------------------------
dataset = events.selection(aCML,  filter.freq = .05, 
    filter.in.names = c('EZH1','EZH2'), 
    filter.out.names = 'SETBP1')

## -----------------------------------------------------------------------------
as.events(dataset)

## ----fig.width=7, fig.height=5.5, fig.cap="Multiple output from oncoprint can be captured as a gtable and composed via grid.arrange (package gridExtra). In this case we show  aCML data on top -- displayed after the as.alterations transformation -- versus a selected subdataset of events with a minimum frequency of 5%, force exclusion of SETBP1 (all events associated), and inclusion of EZH1 and EZH2.", results='hide'----
library(gridExtra)
grid.arrange(
    oncoprint(as.alterations(aCML, new.color = 'brown3'), 
        cellheight = 6, cellwidth = 4, gtable = TRUE,
        silent = TRUE, font.row = 6)$gtable,
    oncoprint(dataset, cellheight = 6, cellwidth = 4,
        gtable = TRUE, silent = TRUE, font.row = 6)$gtable, 
    ncol = 1)

