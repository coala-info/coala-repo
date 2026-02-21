# Code example from 'gatom-tutorial' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# # if (!require("BiocManager", quietly = TRUE))
# #     install.packages("BiocManager")
# #
# # BiocManager::install("gatom")

## ----message=FALSE------------------------------------------------------------
library(gatom)
library(data.table)
library(igraph)
library(mwcsr)

## ----message=FALSE------------------------------------------------------------
data("gene.de.rawEx")
print(head(gene.de.rawEx))
data("met.de.rawEx")
print(head(met.de.rawEx))

## -----------------------------------------------------------------------------
data("networkEx")
data("met.kegg.dbEx")
data("org.Mm.eg.gatom.annoEx")

## -----------------------------------------------------------------------------
str(networkEx, max.level=1, give.attr = FALSE)

## -----------------------------------------------------------------------------
str(met.kegg.dbEx, max.level=2, give.attr = FALSE)

## -----------------------------------------------------------------------------
str(org.Mm.eg.gatom.annoEx, max.level=2, give.attr = FALSE)

## -----------------------------------------------------------------------------
g <- makeMetabolicGraph(network=networkEx, 
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx, 
                        gene.de=gene.de.rawEx,
                        met.db=met.kegg.dbEx, 
                        met.de=met.de.rawEx)
print(g)

## ----message=FALSE, warning=FALSE---------------------------------------------
gs <- scoreGraph(g, k.gene = 25, k.met = 25)

## -----------------------------------------------------------------------------
solver <- rnc_solver()

## ----message=FALSE, warning=FALSE---------------------------------------------
set.seed(42)
res <- solve_mwcsp(solver, gs)
m <- res$graph

## -----------------------------------------------------------------------------
print(m)
head(E(m)$label)
head(V(m)$label)

## -----------------------------------------------------------------------------
createShinyCyJSWidget(m)

## -----------------------------------------------------------------------------
write_graph(m, file = file.path(tempdir(), "M0.vs.M1.graphml"), format = "graphml")

## ----message=FALSE------------------------------------------------------------
saveModuleToHtml(module = m, file = file.path(tempdir(), "M0.vs.M1.html"), 
                 name="M0.vs.M1")

## -----------------------------------------------------------------------------
saveModuleToDot(m, file = file.path(tempdir(), "M0.vs.M1.dot"), name = "M0.vs.M1")

## ----eval=FALSE---------------------------------------------------------------
# system(paste0("neato -Tsvg ", file.path(tempdir(), "M0.vs.M1.dot"),
#               " > ", file.path(tempdir(), "M0.vs.M1.svg")),
#        ignore.stderr=TRUE)

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
set.seed(42)
saveModuleToPdf(m, file = file.path(tempdir(), "M0.vs.M1.pdf"), name = "M0.vs.M1", 
                n_iter=100, force=1e-5)

## ----message=FALSE------------------------------------------------------------
library(R.utils)
library(data.table)

## ----message=FALSE------------------------------------------------------------
met.de.raw <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GAM/Ctrl.vs.MandLPSandIFNg.met.de.tsv.gz")
gene.de.raw <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GAM/Ctrl.vs.MandLPSandIFNg.gene.de.tsv.gz")

## -----------------------------------------------------------------------------
network.combined <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.combined.rds"))
met.combined.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.combined.db.rds"))

org.Mm.eg.gatom.anno <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/org.Mm.eg.gatom.anno.rds"))

## -----------------------------------------------------------------------------
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.combined.mmu.eg.tsv", colClasses="character")

## -----------------------------------------------------------------------------
cg <- makeMetabolicGraph(network=network.combined,
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=gene.de.raw,
                         met.db=met.combined.db,
                         met.de=met.de.raw,
                         gene2reaction.extra=gene2reaction.extra)

cgs <- scoreGraph(cg, k.gene = 50, k.met = 50)

solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, cgs)
cm <- sol$graph
cm

## ----message=FALSE, warning=FALSE---------------------------------------------
createShinyCyJSWidget(cm)

## -----------------------------------------------------------------------------
network <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.kegg.rds"))
met.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.kegg.db.rds"))

## -----------------------------------------------------------------------------
kg <- makeMetabolicGraph(network=network, 
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.anno, 
                        gene.de=gene.de.raw,
                        met.db=met.db, 
                        met.de=met.de.raw)

kgs <- scoreGraph(kg, k.gene = 50, k.met = 50)

solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, kgs) 
km <- sol$graph
km

## ----message=FALSE, warning=FALSE---------------------------------------------
createShinyCyJSWidget(km)

## -----------------------------------------------------------------------------
network.rhea <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.rhea.rds"))
met.rhea.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.rhea.db.rds"))

## -----------------------------------------------------------------------------
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.rhea.mmu.eg.tsv", colClasses="character")

## -----------------------------------------------------------------------------
rg <- makeMetabolicGraph(network=network.rhea,
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=gene.de.raw,
                         met.db=met.rhea.db,
                         met.de=met.de.raw,
                         gene2reaction.extra=gene2reaction.extra)

rgs <- scoreGraph(rg, k.gene = 50, k.met = 50)

solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, rgs)
rm <- sol$graph
rm

## ----message=FALSE, warning=FALSE---------------------------------------------
createShinyCyJSWidget(rm)

## -----------------------------------------------------------------------------
network.lipids <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.rhea.lipids.rds"))
met.lipids.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.lipids.db.rds"))

## -----------------------------------------------------------------------------
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.rhea.mmu.eg.tsv", colClasses="character")

## -----------------------------------------------------------------------------
met.de.lipids <- fread("https://artyomovlab.wustl.edu/publications/supp_materials/GATOM/Ctrl.vs.HighFat.lipid.de.csv")

## -----------------------------------------------------------------------------
lg <- makeMetabolicGraph(network=network.lipids,
                         topology="metabolites",
                         org.gatom.anno=org.Mm.eg.gatom.anno,
                         gene.de=NULL,
                         met.db=met.lipids.db,
                         met.de=met.de.lipids,
                         gene2reaction.extra=gene2reaction.extra)

lgs <- scoreGraph(lg, k.gene = NULL, k.met = 50)

solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, lgs)
lm <- sol$graph
lm

## ----message=FALSE, warning=FALSE---------------------------------------------
createShinyCyJSWidget(lm)

## ----message=FALSE, warning=FALSE---------------------------------------------
lm1 <- abbreviateLabels(lm, orig.names = TRUE, abbrev.names = TRUE)

createShinyCyJSWidget(lm1)

## -----------------------------------------------------------------------------
network.combined <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/network.combined.rds"))
met.combined.db <- readRDS(url("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/met.combined.db.rds"))
gene2reaction.extra <- fread("http://artyomovlab.wustl.edu/publications/supp_materials/GATOM/gene2reaction.combined.mmu.eg.tsv", colClasses="character")

gg <- makeMetabolicGraph(network=network.combined, 
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno, 
                         gene.de=gene.de.raw,
                         met.db=met.combined.db, 
                         met.de=met.de.raw, 
                         gene2reaction.extra=gene2reaction.extra)
gg

## -----------------------------------------------------------------------------
ge <- makeMetabolicGraph(network=network.combined, 
                         topology="atoms",
                         org.gatom.anno=org.Mm.eg.gatom.anno, 
                         gene.de=gene.de.raw,
                         met.db=met.combined.db, 
                         met.de=met.de.raw, 
                         gene2reaction.extra=gene2reaction.extra, 
                         keepReactionsWithoutEnzymes=TRUE)
ge

## ----eval=FALSE---------------------------------------------------------------
# vsolver <- virgo_solver(cplex_dir=Sys.getenv("CPLEX_HOME"),
#                         threads=4, penalty=0.001, log=1)
# sol <- solve_mwcsp(vsolver, gs)
# m <- sol$graph

## -----------------------------------------------------------------------------
g <- makeMetabolicGraph(network=networkEx, 
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx, 
                        gene.de=gene.de.rawEx,
                        met.db=met.kegg.dbEx, 
                        met.de=NULL)
gs <- scoreGraph(g, k.gene = 50, k.met = NULL)

## -----------------------------------------------------------------------------
g <- makeMetabolicGraph(network=networkEx, 
                        topology="atoms",
                        org.gatom.anno=org.Mm.eg.gatom.annoEx, 
                        gene.de=NULL,
                        met.db=met.kegg.dbEx, 
                        met.de=met.de.rawEx)
gs <- scoreGraph(g, k.gene = NULL, k.met = 50)

## -----------------------------------------------------------------------------
gm <- makeMetabolicGraph(network=network, 
                        topology="metabolite",
                        org.gatom.anno=org.Mm.eg.gatom.anno, 
                        gene.de=gene.de.raw,
                        met.db=met.db, 
                        met.de=met.de.raw)

gms <- scoreGraph(gm, k.gene = 50, k.met = 50)

solver <- rnc_solver()
set.seed(42)
sol <- solve_mwcsp(solver, gms) 
mm <- sol$graph
mm

## -----------------------------------------------------------------------------
foraRes <- fgsea::fora(pathways=org.Mm.eg.gatom.anno$pathways,
                       genes=E(km)$gene,
                       universe=unique(E(kg)$gene),
                       minSize=5)
foraRes[padj < 0.05]

## -----------------------------------------------------------------------------
mainPathways <- fgsea::collapsePathwaysORA(
  foraRes[padj < 0.05],
  pathways=org.Mm.eg.gatom.anno$pathways,
  genes=E(km)$gene,
  universe=unique(E(kg)$gene))
foraRes[pathway %in% mainPathways$mainPathways]

## -----------------------------------------------------------------------------
sessionInfo()

