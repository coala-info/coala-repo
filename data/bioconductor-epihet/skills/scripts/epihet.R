# Code example from 'epihet' vignette. See references/ for full tutorial.

## ----include=FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----eval=FALSE----------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#  BiocManager::install("epihet")

## ----eval=FALSE----------------------------------------------------------
#  BiocManager::install("TheJacksonLaboratory/epihet")

## ----eval=FALSE,message=FALSE--------------------------------------------
#  library(epihet)

## ----echo=FALSE----------------------------------------------------------
  options(continue = ' ')

## ------------------------------------------------------------------------
files = c(system.file("extdata","D-2238.chr22.region.methClone_out.gz",package = "epihet"),
          system.file("extdata","D-2668.chr22.region.methClone_out.gz",package = "epihet"),
          system.file("extdata","N-1.chr22.region.methClone_out.gz",package = "epihet"),
          system.file("extdata","N-2.chr22.region.methClone_out.gz",package = "epihet"))
ids = epihet::splitn(basename(files),"[.]",1)

## ------------------------------------------------------------------------
GR.List = epihet::makeGR(files = files, ids = ids,
                         cores = 1, sve = FALSE)

## ----results='hide'------------------------------------------------------
comp.Matrix = epihet::compMatrix(epi.gr = GR.List, outprefix = NULL,
                                 readNumber = 60, p = 1,
                                 cores = 1, sve = FALSE)

## ------------------------------------------------------------------------
GR.Object = epihet::readGR(files = files, ids = ids, n = 3)

## ------------------------------------------------------------------------
summary = epihet::summarize(gr1 = GR.List[[1]], gr2 = GR.List[[2]],
                            value1 = 'pdr', value2 = 'epipoly',
                            cutoff1 = 10, cutoff2 = 60)

## ------------------------------------------------------------------------
subtype = data.frame(Type= c(rep('CEBPA_sil', 2), rep('Normal', 2)),
                     row.names = names(GR.List),stringsAsFactors = FALSE)

## ----results='hide'------------------------------------------------------
epihet::epiBox(compare.matrix = comp.Matrix, value = 'epipoly',
               type = subtype, box.colors = NULL, add.points = FALSE,
               points.colors = NULL, pdf.height = 10, pdf.width = 10,
               sve = TRUE)

## ------------------------------------------------------------------------
pmap = epihet::epiMap(compare.matrix = comp.Matrix,
                      value = 'epipoly',annotate = subtype,
                      clustering_distance_rows = "euclidean",
                      clustering_distance_cols = "euclidean",
                      clustering_method = "complete",annotate.colors = NA,
                      color= colorRampPalette(c("blue","white","red"))(1000),
                      loci.percent = 1, show.rows = FALSE,
                      show.columns = TRUE, font.size = 15,
                      pdf.height = 10, pdf.width = 10, sve = TRUE)

## ------------------------------------------------------------------------
  box.colors=c("orange","forestgreen")
  names(box.colors)=c("CEBPA_sil","Normal")
  annotate.colors = list(Type=box.colors)

## ------------------------------------------------------------------------
library(ggfortify)
epihet::epiPCA(compare.matrix = comp.Matrix, value = 'epipoly',
               type = subtype, points.colors = NULL,
               frames = FALSE, frames.colors = NULL,
               probability = FALSE, pdf.height = 10,
               pdf.width = 10, sve = TRUE)

## ----results='hide'------------------------------------------------------
set.seed(42)
epihet::epiTSNE(compare.matrix = comp.Matrix, value = 'epipoly',
                type = subtype, points.colors = NULL, theta = 0.5,
                perplexity = 1, max_iter = 1000, pdf.height = 10,
                pdf.width = 10, sve = TRUE)

## ------------------------------------------------------------------------
samples=data.frame(Sample=colnames(comp.Matrix)[1:(length(comp.Matrix)-2)],
                   Genotype=c(rep ("CEBPA_sil", 2), rep ("Normal", 2)),
                   stringsAsFactors = FALSE)
rownames(samples)=samples$Sample
seed = sample(1:1e+06, 1)
set.seed(seed)
diff.het.matrix = epihet::diffHet(compare.matrix = comp.Matrix,
                                  value = 'epipoly', group1 = 'CEBPA_sil',
                                  group2 = 'Normal', subtype = samples,
                                  het.dif.cutoff = 0.20,
                                  permutations = 1000,
                                  p.adjust.method = 'fdr', cores = 1)

## ----results='hide'------------------------------------------------------
data(diffhetmatrix,package="epihet")
epihet::epiMA(pval.matrix = diff.het.matrix, padjust.cutoff = 0.05,
              pch = ".", sve = TRUE)

## ----results='hide'------------------------------------------------------
library(GenomicRanges)
library(doParallel)
registerDoParallel(cores=1)
data(sharedmatrix,package="epihet")
data(DEH,package = "epihet")
data(datTraits,package = "epihet")
data(promoter,package = "epihet")
classes=data.frame(Sample=
                  c(colnames(sharedmatrix)[1:(length(sharedmatrix)-2)],
                  paste("N",1:14,sep = "-")),group=c(rep("CEBPA_sil",6),
                  rep("Normal",14)),stringsAsFactors = FALSE)
rownames(classes)=classes$Sample
epi.network=epihet::epiNetwork(node.type = "gene",DEH,sharedmatrix,
                               value = "epipoly",group="CEBPA_sil",
                               subtype=classes,datTraits = datTraits,
                               promoter,networktype = "signed",
                               method = "pearson",prefix="epipoly",
                               mergeCutHeight = 0.25,minModuleSize = 30)

## ----results='hide'------------------------------------------------------
load("epipoly-block.1.RData")
module.topology=epihet::moduleVisual(TOM,
                                     value.matrix=epi.network$epimatrix,
                                     moduleColors=epi.network$module$color,
                                     mymodule="turquoise",cutoff=0.02,
                                     prefix='CEBPA_sil_epipoly',sve = TRUE)

## ----results='hide'------------------------------------------------------
library(clusterProfiler)
gene=unique(epi.network$module$gene)
entrez=bitr(gene,fromType = "REFSEQ",toType = "ENTREZID",
            OrgDb = "org.Hs.eg.db")
genelist=epi.network$module
head(genelist)
genelist=merge(genelist,entrez,by.x="gene",by.y="REFSEQ")
genelist=unique(genelist[,c(4,2,3)])
head(genelist)
pathway = epihet::epiPathway(genelist,cutoff = 0.05,
                             prefix="CEBPA_sil",pdf.height = 10,
                             pdf.width = 10)

## ----results='hide'------------------------------------------------------
data(DEG,package = "epihet")
data(background,package = "epihet")
module.annotation=epihet::moduleAnno(DEG$refseq,background$gene,
                                     module.gene=epi.network$module,
                                     cutoff=0.1,adjust.method = "fdr",
                                     prefix='epipoly',pdf.height = 3,
                                     pdf.width = 3, sve = TRUE)

## ----results='hide'------------------------------------------------------
data(modulesil,package = "epihet")
data(moduledm,package = "epihet")
sim.score=epihet::moduleSim(module.subtype1=modulesil,
                            module.subtype2=moduledm,
                            pdf.height = 3,pdf.width = 3,
                            sve = TRUE)

## ----sessionInfo---------------------------------------------------------

  sessionInfo()


