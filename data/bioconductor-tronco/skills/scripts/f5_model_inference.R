# Code example from 'f5_model_inference' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(TRONCO)
data(aCML)
data(crc_maf)
data(crc_gistic)
data(crc_plain)

## -----------------------------------------------------------------------------
dataset = change.color(aCML, 'Ins/Del', 'dodgerblue4')
dataset = change.color(dataset, 'Missense point', '#7FC97F')
as.colors(dataset)

## -----------------------------------------------------------------------------
consolidate.data(dataset)

## -----------------------------------------------------------------------------
alterations = events.selection(as.alterations(aCML), filter.freq = .05)

## -----------------------------------------------------------------------------
gene.hypotheses = c('KRAS', 'NRAS', 'IDH1', 'IDH2', 'TET2', 'SF3B1', 'ASXL1')
aCML.clean = events.selection(aCML,
    filter.in.names=c(as.genes(alterations), gene.hypotheses))
aCML.clean = annotate.description(aCML.clean, 
    'CAPRI - Bionformatics aCML data (selected events)')

## ----fig.width=8, fig.height=5.5, fig.cap="Data selected for aCML reconstruction annotated with the events which are part of a pattern that we will input to CAPRI."----
oncoprint(aCML.clean, gene.annot = list(priors = gene.hypotheses), sample.id = TRUE)

## -----------------------------------------------------------------------------
aCML.hypo = hypothesis.add(aCML.clean, 'NRAS xor KRAS', XOR('NRAS', 'KRAS'))

## ----eval=FALSE---------------------------------------------------------------
# aCML.hypo = hypothesis.add(aCML.hypo, 'NRAS or KRAS',  OR('NRAS', 'KRAS'))

## ----fig.width=6, fig.height=1, fig.cap="Oncoprint output to show the perfect (hard) exclusivity among NRAS/KRAS mutations in aCML"----
oncoprint(events.selection(aCML.hypo,
    filter.in.names = c('KRAS', 'NRAS')),
    font.row = 8,
    ann.hits = FALSE)

## -----------------------------------------------------------------------------
aCML.hypo = hypothesis.add(aCML.hypo, 'SF3B1 xor ASXL1', XOR('SF3B1', XOR('ASXL1')),
    '*')

## -----------------------------------------------------------------------------
as.events(aCML.hypo, genes = 'TET2') 
aCML.hypo = hypothesis.add(aCML.hypo,
    'TET2 xor IDH2',
    XOR('TET2', 'IDH2'),
    '*')
aCML.hypo = hypothesis.add(aCML.hypo,
    'TET2 or IDH2',
    OR('TET2', 'IDH2'),
    '*')

## ----fig.width=7, fig.height=2, fig.cap="{oncoprint} output to show the soft exclusivity among NRAS/KRAS mutations in aCML"----
oncoprint(events.selection(aCML.hypo,
    filter.in.names = c('TET2', 'IDH2')),
    font.row = 8,
    ann.hits = FALSE)

## -----------------------------------------------------------------------------
aCML.hypo = hypothesis.add.homologous(aCML.hypo)

## -----------------------------------------------------------------------------
dataset = hypothesis.add.group(aCML.clean, OR, group = c('SETBP1', 'ASXL1', 'CBL'))

## ----fig.width=8, fig.height=6.5, fig.cap="oncoprint} output of the a dataset that has patterns that could be given as input to CAPRI to retrieve a progression model."----
oncoprint(aCML.hypo, gene.annot = list(priors = gene.hypotheses), sample.id = TRUE, 
    font.row=10, font.column=5, cellheight=15, cellwidth=4)

## -----------------------------------------------------------------------------
npatterns(dataset)
nhypotheses(dataset)

## -----------------------------------------------------------------------------
as.patterns(dataset)
as.events.in.patterns(dataset)
as.genes.in.patterns(dataset)
as.types.in.patterns(dataset)

## -----------------------------------------------------------------------------
head(as.hypotheses(dataset))
dataset = delete.hypothesis(dataset, event = 'TET2')
dataset = delete.pattern(dataset, pattern = 'OR_ASXL1_CBL')

## ----pattern-plot,fig.show='hide', fig.width=4, fig.height=2.2, fig.cap="Barplot to show an hypothesis: here we test genes SETBP1 and ASXL1 versus Missense point mutations of  CSF3R, which suggests that  that pattern does not 'capture' all the samples with  CSF3R mutations."----
tronco.pattern.plot(aCML,
    group = as.events(aCML, genes=c('SETBP1', 'ASXL1')),
    to = c('CSF3R', 'Missense point'),
    legend.cex=0.8,
    label.cex=1.0)

## ----pattern-plot-circos, fig.width=6, fig.height=6, fig.cap="Circos to show an hypothesis: here we test genes SETBP1 and ASXL1 versus Missense point mutations of  CSF3R. The combination of this and the previous  plots should allow to understand which pattern we shall write in an attempt to capture a potential causality relation between the pattern and the event."----
tronco.pattern.plot(aCML,
    group = as.events(aCML, genes=c('TET2', 'ASXL1')),
    to = c('CSF3R', 'Missense point'),
    legend = 1.0,
    label.cex = 0.8,
    mode='circos')

## -----------------------------------------------------------------------------
model.capri = tronco.capri(aCML.hypo, boot.seed = 12345, nboot = 5)
model.capri = annotate.description(model.capri, 'CAPRI - aCML')

## -----------------------------------------------------------------------------
model.caprese = tronco.caprese(aCML.clean)
model.caprese = annotate.description(model.caprese, 'CAPRESE - aCML')

## -----------------------------------------------------------------------------
model.edmonds = tronco.edmonds(aCML.clean, nboot = 5, boot.seed = 12345)
model.edmonds = annotate.description(model.edmonds, 'MST Edmonds - aCML')

## -----------------------------------------------------------------------------
model.gabow = tronco.gabow(aCML.clean, nboot = 5, boot.seed = 12345)
model.gabow = annotate.description(model.gabow, 'MST Gabow - aCML')

## -----------------------------------------------------------------------------
model.chowliu = tronco.chowliu(aCML.clean, nboot = 5, boot.seed = 12345)
model.chowliu = annotate.description(model.chowliu, 'MST Chow Liu - aCML')

## -----------------------------------------------------------------------------
model.prim = tronco.prim(aCML.clean, nboot = 5, boot.seed = 12345)
model.prim = annotate.description(model.prim, 'MST Prim - aCML data')

