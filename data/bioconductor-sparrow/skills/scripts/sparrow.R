# Code example from 'sparrow' vignette. See references/ for full tutorial.

## ----init, include=FALSE, echo=FALSE, message=FALSE, warning=FALSE------------
knitr::opts_chunk$set(
  echo=TRUE, warning=FALSE, message=FALSE, error=FALSE) #, dpi=150)

# TODO:
# 1. update text to favor overrepresentation analysis method `ora`
# 2. describe how its data.frame input works (ora)
# 3. provide a brief comparison to its performance vs goseq, with and without
#    accounting for bias). You can take the code for that from the
#    enrichtest/goseq PAC unit test.

## ----sparrow-methods, echo=FALSE, message=FALSE, warning=FALSE----------------
dplyr::select(sparrow::sparrow_methods(), method, test_type, package)

## ----init-env, warning=FALSE, message=FALSE-----------------------------------
library(sparrow)
library(magrittr)
library(dplyr)
library(ggplot2)
library(ComplexHeatmap)
library(circlize)
library(edgeR)
library(data.table)
theme_set(theme_bw())

## ----data-setup, eval=!exists('y.all'), results='hide'------------------------
vm <- exampleExpressionSet(dataset = "tumor-subtype", do.voom = TRUE)

## -----------------------------------------------------------------------------
vm$targets %>%
  select(Patient_ID, Cancer_Status, PAM50subtype)

## -----------------------------------------------------------------------------
vm$design

## ----contrast-setup-----------------------------------------------------------
(cm <- makeContrasts(BvH=Basal - Her2, levels=vm$design))

## ----dge-analysis-------------------------------------------------------------
fit <- lmFit(vm, vm$design) %>%
  contrasts.fit(cm) %>%
  eBayes
tt <- topTable(fit, 'BvH', n=Inf, sort.by='none')

## ----build-gdb----------------------------------------------------------------
gdb <- getMSigGeneSetDb("H", "human", id.type = "entrez")

## ----geneSets-accessor--------------------------------------------------------
geneSets(gdb) %>%
  head %>%
  select(1:4)

## ----run-multi-GSEA, results='hide', warning=FALSE----------------------------
mg <- seas(
  vm, gdb, c('camera', 'fry', 'ora'),
  design = vm$design, contrast = cm[, 'BvH'],
  # these parameters define which genes are differentially expressed
  feature.max.padj = 0.05, feature.min.logFC = 1,
  # for camera:
  inter.gene.cor = 0.01,
  # specifies the numeric covariate to bias-correct for
  # "size" is found in the vm$genes data.frame, which makes its way to the
  # internal DGE statistics table ... more on that later
  feature.bias = "size")

## ----logFC-results------------------------------------------------------------
lfc <- logFC(mg)
lfc %>%
  select(symbol, entrez_id, logFC, t, pval, padj) %>%
  head

## ----compare-dge-t-stats------------------------------------------------------
comp <- tt %>%
  select(entrez_id, logFC, t, pval=P.Value, padj=adj.P.Val) %>%
  inner_join(lfc, by='entrez_id', suffix=c('.tt', '.mg'))
all.equal(comp$t.tt, comp$t.mg)

## ----mg-res-------------------------------------------------------------------
mg

## ----resultnames--------------------------------------------------------------
resultNames(mg)

## ----gsea-res-----------------------------------------------------------------
cam.res <- result(mg, 'camera')
cam.go.res <- results(mg, c('camera', 'ora.up'))

## ----camera-summary-----------------------------------------------------------
cam.res %>%
  filter(padj < 0.1, collection == 'H') %>%
  arrange(desc(mean.logFC)) %>%
  select(name, n, mean.logFC, padj) %>%
  head

## ----geneset-result-----------------------------------------------------------
geneSet(mg, name = 'HALLMARK_WNT_BETA_CATENIN_SIGNALING') %>%
  select(symbol, entrez_id, logFC, pval, padj) %>% 
  head()

## ----iplot-wnt-beta, fig.asp=1, eval=FALSE------------------------------------
# iplot(mg, 'HALLMARK_WNT_BETA_CATENIN_SIGNALING',
#       type = 'boxplot', value = 'logFC')

## ----iplot-wnt-beta-density, fig.asp=1, eval=FALSE----------------------------
# iplot(mg, 'HALLMARK_WNT_BETA_CATENIN_SIGNALING',
#       type = 'density', value = 'logFC')

## ----iplot-wnt-beta-gsea, fig.asp=1, eval=FALSE, message=FALSE, warning=FALSE----
# iplot(mg, 'HALLMARK_WNT_BETA_CATENIN_SIGNALING',
#       type = 'gsea', value = 'logFC')

## ----ssgenesets---------------------------------------------------------------
sig.res <- cam.res %>%
  filter(padj < 0.05 & (grepl("HALLMARK", name) | abs(mean.logFC) >= 2))
gdb.sub <- gdb[geneSets(gdb)$name %in% sig.res$name]

## ----subset-exprs-------------------------------------------------------------
vm.bh <- vm[, vm$targets$PAM50subtype %in% c("Basal", "Her2")]

## ----ssscore, warning=FALSE---------------------------------------------------
scores <- scoreSingleSamples(gdb.sub, vm.bh,
                             methods = c('ewm', 'ssgsea', 'zscore'),
                             ssgsea.norm = TRUE, unscale=FALSE, uncenter=FALSE,
                             as.dt = TRUE)

## ----sss-pairs, warning=FALSE-------------------------------------------------
# We miss you, reshape2::acast
sw <- dcast(scores, name + sample_id ~ method, value.var="score")
corplot(sw[, -(1:2), with = FALSE], cluster=TRUE)

## ----warning=FALSE------------------------------------------------------------
ewmu <- scoreSingleSamples(gdb.sub, vm.bh,methods = "ewm",
                           unscale = TRUE, uncenter = TRUE, as.dt = TRUE)
ewmu[, method := "ewm_unscale"]
scores.all <- rbind(scores, ewmu)
swa <- dcast(scores.all, name + sample_id ~ method, value.var="score")
corplot(swa[, -(1:2), with = FALSE], cluster=TRUE)

## ----anno-scores--------------------------------------------------------------
all.scores <- scores.all %>%
  inner_join(select(vm.bh$targets, sample_id=Sample_ID, subtype=PAM50subtype),
             by = "sample_id")

some.scores <- all.scores %>%
  filter(name %in% head(unique(all.scores$name), 5))

ggplot(some.scores, aes(subtype, score)) +
  geom_boxplot(outlier.shape=NA) +
  geom_jitter(width=0.25) +
  facet_grid(name ~ method)

## ----gheatmap, fig.height=8, fig.width=4--------------------------------------
gs.sub <- geneSets(gdb.sub)
gdb.2 <- gdb.sub[geneSets(gdb.sub)$name %in% head(gs.sub$name, 2)]

col.anno <- HeatmapAnnotation(
  df = vm.bh$targets[, 'PAM50subtype', drop = FALSE],
  col = list(PAM50subtype = c(Basal = "gray", Her2 = "black")))

mgheatmap(vm.bh, gdb.2, aggregate.by = "none", split = TRUE,
          show_row_names = FALSE, show_column_names = FALSE,
          recenter = TRUE, top_annotation = col.anno, zlim = c(-3, 3))

## ----gshm2, fig.height = 2.5, fig.width = 8-----------------------------------
mgheatmap(vm.bh, gdb.2, aggregate.by = "ewm", split = FALSE,
          show_row_names = TRUE, show_column_names = FALSE,
          top_annotation = col.anno)

## ----gshm-all, fig.height = 6, fig.width = 8----------------------------------
mgheatmap(vm.bh, gdb.sub,
          aggregate.by = 'ewm', split=TRUE, recenter = TRUE,
          show_row_names=TRUE, show_column_names=FALSE,
          top_annotation=col.anno, zlim = c(-2.5, 2.5))

## -----------------------------------------------------------------------------
as.data.frame(gdb)[c(1:5, 201:205),]

## ----eval=FALSE---------------------------------------------------------------
# msigdb <- getMSigGeneSetDb('H', 'human')
# goslimdb <- getPantherGeneSetDb('goslim', 'human')
# gdb.uber <- combine(msigdb, goslimdb)

## ----subset-gdb-by-metadata---------------------------------------------------
keep <- geneSets(gdb)$N < 100
gdb.sub <- gdb[keep]
geneSets(gdb.sub) |> head()

## ----subset-gdb---------------------------------------------------------------
gdb.sub2 <- subsetByFeatures(gdb, c('3417', '4609'))
nrow(gdb); nrow(gdb.sub2)

## -----------------------------------------------------------------------------
gdbc <- conform(gdb, vm, min.gs.size=10, max.gs.size=100)
head(geneSets(gdbc, active.only=FALSE))

## -----------------------------------------------------------------------------
missed <- setdiff(
  featureIds(gdbc, 'H', 'HALLMARK_WNT_BETA_CATENIN_SIGNALING', active.only=FALSE),
  featureIds(gdbc, 'H', 'HALLMARK_WNT_BETA_CATENIN_SIGNALING', active.only=TRUE))
missed

## -----------------------------------------------------------------------------
gdbc %>%
  geneSet('H', 'HALLMARK_WNT_BETA_CATENIN_SIGNALING', active.only = FALSE) %>%
  subset(feature_id %in% missed)

## -----------------------------------------------------------------------------
vm <- exampleExpressionSet()
vms <- renameRows(vm, "symbol")
head(cbind(rownames(vm), rownames(vms)))

## ----eval=FALSE---------------------------------------------------------------
# mg <- seas(vm, gdb, "goseq", design = vm$design, cm[, 'BvH'],
#            treat.lfc=log2(1.5),
#            ## feature length vector required for goseq
#            feature.bias=setNames(vm$genes$size, rownames(vm)))

## ----eval=FALSE---------------------------------------------------------------
# mgx <- seas(vm, gdb, c('camera', 'roast'),
#             design = vm$design, contrast = cm[, 'BvH'],
#             inter.gene.cor = 0.04, nrot = 500)

## ----session-info-------------------------------------------------------------
sessionInfo()

