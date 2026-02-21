# Code example from 'f6_post_reconstruction' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(TRONCO)
data(aCML)
data(crc_maf)
data(crc_gistic)
data(crc_plain)
gene.hypotheses = c('KRAS', 'NRAS', 'IDH1', 'IDH2', 'TET2', 'SF3B1', 'ASXL1')
alterations = events.selection(as.alterations(aCML), filter.freq = .05)
aCML.clean = events.selection(aCML,
    filter.in.names=c(as.genes(alterations), gene.hypotheses))
aCML.clean = annotate.description(aCML.clean, 
    'CAPRI - Bionformatics aCML data (selected events)')
aCML.hypo = hypothesis.add(aCML.clean, 'NRAS xor KRAS', XOR('NRAS', 'KRAS'))
aCML.hypo = hypothesis.add(aCML.hypo, 'SF3B1 xor ASXL1', XOR('SF3B1', XOR('ASXL1')),
    '*')
as.events(aCML.hypo, genes = 'TET2') 
aCML.hypo = hypothesis.add(aCML.hypo,
    'TET2 xor IDH2',
    XOR('TET2', 'IDH2'),
    '*')
aCML.hypo = hypothesis.add(aCML.hypo,
    'TET2 or IDH2',
    OR('TET2', 'IDH2'),
    '*')
aCML.hypo = hypothesis.add.homologous(aCML.hypo)
aCML.hypo = annotate.description(aCML.hypo, '')
aCML.clean = annotate.description(aCML.clean, '')
model.capri = tronco.capri(aCML.hypo, boot.seed = 12345, nboot = 5)
model.capri = annotate.description(model.capri, 'CAPRI - aCML')
model.caprese = tronco.caprese(aCML.clean)
model.caprese = annotate.description(model.caprese, 'CAPRESE - aCML')
model.edmonds = tronco.edmonds(aCML.clean, nboot = 5, boot.seed = 12345)
model.edmonds = annotate.description(model.edmonds, 'MST Edmonds - aCML')
model.gabow = tronco.gabow(aCML.clean, nboot = 5, boot.seed = 12345)
model.gabow = annotate.description(model.gabow, 'MST Gabow - aCML')
model.chowliu = tronco.chowliu(aCML.clean, nboot = 5, boot.seed = 12345)
model.chowliu = annotate.description(model.chowliu, 'MST Chow Liu - aCML')
model.prim = tronco.prim(aCML.clean, nboot = 5, boot.seed = 12345)
model.prim = annotate.description(model.prim, 'MST Prim - aCML data')

## -----------------------------------------------------------------------------
view(model.capri)

## ----fig.width=4,fig.height=4,warning=FALSE-----------------------------------
tronco.plot(model.capri, 
    fontsize = 12, 
    scale.nodes = 0.6, 
    confidence = c('tp', 'pr', 'hg'), 
    height.logic = 0.25, 
    legend.cex = 0.35, 
    pathways = list(priors = gene.hypotheses), 
    label.edge.size = 10)

## ----fig.width=7,fig.height=7,warning=FALSE, fig.cap="aCML data processed model by algorithms to extract models from individual patients, we show the otput of  CAPRESE,  and all algorithms based on Minimum Spanning Trees (Edmonds, Chow Liu and Prim). Only the  model retrieved by Chow Liu has two different edge colors as it was regularized with two different strategies: AIC and BIC."----
par(mfrow = c(2,2))
tronco.plot(model.caprese, fontsize = 22, scale.nodes = 0.6, legend = FALSE)
tronco.plot(model.edmonds, fontsize = 22, scale.nodes = 0.6, legend = FALSE)
tronco.plot(model.chowliu, fontsize = 22, scale.nodes = 0.6, legend.cex = .7)
tronco.plot(model.prim, fontsize = 22, scale.nodes = 0.6, legend = FALSE)

## -----------------------------------------------------------------------------
as.data.frame(as.parameters(model.capri))
has.model(model.capri)
dataset = delete.model(model.capri)

## -----------------------------------------------------------------------------
str(as.adj.matrix(model.capri))

## -----------------------------------------------------------------------------
marginal.prob = as.marginal.probs(model.capri)
head(marginal.prob$capri_bic)

## -----------------------------------------------------------------------------
joint.prob = as.joint.probs(model.capri, models='capri_bic')
joint.prob$capri_bic[1:3, 1:3]

## -----------------------------------------------------------------------------
conditional.prob = as.conditional.probs(model.capri, models='capri_bic')
head(conditional.prob$capri_bic)

## -----------------------------------------------------------------------------
str(as.confidence(model.capri, conf = c('tp', 'pr', 'hg')))

## ----selective-advantage------------------------------------------------------
as.selective.advantage.relations(model.capri)

## -----------------------------------------------------------------------------
model.boot = tronco.bootstrap(model.capri, nboot = 3, cores.ratio = 0)
model.boot = tronco.bootstrap(model.boot, nboot = 3, cores.ratio = 0, type = 'statistical')

## ----fig.width=4, fig.height=4, warning=FALSE, fig.cap="aCML model reconstructed by CAPRI with AIC / BIC as regolarizators and annotated with both non-parametric and statistical bootstrap scores. Edge thickness is proportional to the non-parametric scores."----

tronco.plot(model.boot, 
    fontsize = 12, 
    scale.nodes = .6,   
    confidence=c('sb', 'npb'), 
    height.logic = 0.25, 
    legend.cex = .35, 
    pathways = list(priors= gene.hypotheses), 
    label.edge.size=10)

## -----------------------------------------------------------------------------
as.bootstrap.scores(model.boot)
view(model.boot)

## ----fig.width=7, fig.height=7, fig.cap="Heatmap of the bootstrap scores for the CAPRI aCML model (via AIC regularization)."----

pheatmap(keysToNames(model.boot, as.confidence(model.boot, conf = 'sb')$sb$capri_aic) * 100, 
           main =  'Statistical bootstrap scores for AIC model',
           fontsize_row = 6,
           fontsize_col = 6,
           display_numbers = TRUE,
           number_format = "%d"
           )

## -----------------------------------------------------------------------------
model.boot = tronco.kfold.eloss(model.boot)
model.boot = tronco.kfold.prederr(model.boot, runs = 2, cores.ratio = 0)
model.boot = tronco.kfold.posterr(model.boot, runs = 2, cores.ratio = 0)

## -----------------------------------------------------------------------------
as.kfold.eloss(model.boot)
as.kfold.prederr(model.boot)
as.kfold.posterr(model.boot)

## -----------------------------------------------------------------------------
tabular = function(obj, M){
    tab = Reduce(
        function(...) merge(..., all = TRUE), 
            list(as.selective.advantage.relations(obj, models = M),
                as.bootstrap.scores(obj, models = M),
                as.kfold.prederr(obj, models = M),
                as.kfold.posterr(obj,models = M)))
  
    # merge reverses first with second column
    tab = tab[, c(2,1,3:ncol(tab))]
    tab = tab[order(tab[, paste(M, '.NONPAR.BOOT', sep='')], na.last = TRUE, decreasing = TRUE), ]
    return(tab)
}

head(tabular(model.boot, 'capri_bic'))

## ----fig.width=4,fig.height=4, warning=FALSE, fig.cap="aCML model reconstructed by CAPRI with  AIC/BIC as regolarizators and annotated with  non-parametric, as well as with entropy loss, prediction and posterior classification errors computed via cross-validation. Edge thickness is proportional to the non-parametric  scores."----
tronco.plot(model.boot, 
    fontsize = 12, 
    scale.nodes = .6, 
    confidence=c('npb', 'eloss', 'prederr', 'posterr'), 
    height.logic = 0.25, 
    legend.cex = .35, 
    pathways = list(priors= gene.hypotheses), 
    label.edge.size=10)

