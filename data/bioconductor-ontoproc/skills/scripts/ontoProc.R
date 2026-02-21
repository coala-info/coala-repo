# Code example from 'ontoProc' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide",message=FALSE----------------------------
library(knitr)
library(ontoProc)

## ----lkbr---------------------------------------------------------------------
br = bioregistry_ols_resources()
library(DT)
datatable(br[,c(2,3)])

## ----dodemo11-----------------------------------------------------------------
aeo = owl2cache(url="http://purl.obolibrary.org/obo/aeo.owl") # localize OWL
aeoinr = setup_entities2(aeo)
set.seed(1234)
suppressWarnings({ # zero-length angle
onto_plot2(aeoinr, sample(grep("AEO", names(aeoinr$name), value=TRUE),12))
})

## ----lkor2srch----------------------------------------------------------------
ub = owl2cache(url="http://purl.obolibrary.org/obo/uberon.owl")
allv = search_labels(ub, "*vein*")
length(allv)
head(unlist(allv))

## ----lklk---------------------------------------------------------------------
kable(stab <- seur3kTab())

## ----lklklk, message=FALSE----------------------------------------------------
library(ontoProc)
cl = getOnto("cellOnto", "2023")
onto_plot2(cl, stab$tag)

## ----donew--------------------------------------------------------------------
#tmp = owl2cache(url="http://purl.obolibrary.org/obo/cl.owl") # ensure presence
#cl = quickOnto("cl.owl")
#onto_plot2(cl, gsub(":", "_", stab$tag))
#library(ontoProc)
clont_path = owl2cache(url="http://purl.obolibrary.org/obo/cl.owl")
tmp = readLines(clont_path)
bad = grep("STATO_0000416", tmp)[1:2]  # see https://github.com/obophenotype/cell-ontology/issues/3237
tmp = tmp[-bad]
bad = grep("STATO_0000663", tmp)[1:2]  # see https://github.com/obophenotype/cell-ontology/issues/3237
tmp = tmp[-bad]
tf = tempfile()
writeLines(tmp, tf)
cle = setup_entities2(tf)
ntag = gsub(":", "_", stab$tag)
onto_plot2(cle, ntag)

## ----lkmap--------------------------------------------------------------------
hpca_map = read.csv(system.file("extdata/hpca.csv", package="ontoProc"), strings=FALSE)
head(hpca_map)

## ----doren--------------------------------------------------------------------
names(hpca_map) = c("informal", "formal")  # obligatory for now

## ----gethpca, eval=TRUE, message=FALSE----------------------------------------
library(SummarizedExperiment)
library(SingleCellExperiment)
library(celldex)
hpca_sce = HumanPrimaryCellAtlasData()

## ----dobind, eval=TRUE--------------------------------------------------------
hpca_sce = bind_formal_tags(hpca_sce, "label.fine", hpca_map)
length(unique(hpca_sce$label.ont))

## ----justna, eval=TRUE--------------------------------------------------------
length(xx <- which(is.na(hpca_sce$label.ont)))
if (length(xx)>0) print(colData(hpca_sce)[xx,])
sum(hpca_sce$label.ont == "", na.rm=TRUE) # iPS and BM

## ----dosub, eval=TRUE---------------------------------------------------------
cell_onto = ontoProc::getOnto("cellOnto", "2023")
hpca_mono = subset_descendants( hpca_sce, cell_onto, "^monocyte$" )
table(hpca_mono$label.fine)
table(hpca_mono$label.ont) # not much diversity
hpca_tcell = subset_descendants( hpca_sce, cell_onto, "^T cell$" )
table(hpca_tcell$label.fine)
table(hpca_tcell$label.ont) # 
uu = unique(hpca_tcell$label.ont)
onto_plot2(cell_onto, uu)

## ----ontodiffex---------------------------------------------------------------
dO = getOnto("diseaseOnto")
dO2 = getOnto(ontoname = "diseaseOnto", year_added = "2021")
cl3k = c("DOID:0040064","DOID:0040076","DOID:0081127","DOID:0081126","DOID:0081131","DOID:0060034")
ontoDiff(dO,dO2,cl3k)

## ----lkefo--------------------------------------------------------------------
ef = getOnto("efoOnto")
alla <- grep("sthma", ef$name, value=TRUE) 
aa <- grep("obso", alla, invert=TRUE, value=TRUE)
onto_plot2(ef, names(aa))

## ----lkhdo,eval=FALSE---------------------------------------------------------
# hdo_2022_09 = get_OBO(
#   "https://github.com/DiseaseOntology/HumanDiseaseOntology/raw/main/src/ontology/HumanDO.obo",
#   extract_tags = "everything"
#   )

## ----lkasd--------------------------------------------------------------------
asdo = setup_entities2(system.file("owl", "asdpto.owl", package="ontoProc"))
onto_plot2(asdo, unique(c( "Class_777", "Class_466", "Class_454", "Class_467", 
    names(head(asdo$name,15)))), cex=.5)

