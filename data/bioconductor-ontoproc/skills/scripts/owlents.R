# Code example from 'owlents' vignette. See references/ for full tutorial.

## ----getcl,message=FALSE------------------------------------------------------
library(ontoProc)
clont_path = owl2cache(url="http://purl.obolibrary.org/obo/cl.owl")
tmp = readLines(clont_path)
bad = grep("STATO_0000416", tmp)[1:2]  # see https://github.com/obophenotype/cell-ontology/issues/3237
tmp = tmp[-bad]
bad = grep("STATO_0000663", tmp)[1:2]  # see https://github.com/obophenotype/cell-ontology/issues/3237
tmp = tmp[-bad]
tf = tempfile()
writeLines(tmp, tf)
cle = setup_entities2(tf)
cle

## ----lkcl---------------------------------------------------------------------
sel = c("CL_0000492", "CL_0001054", "CL_0000236", 
"CL_0000625", "CL_0000576", 
"CL_0000623", "CL_0000451", "CL_0000556")
onto_plot2(cle, sel)

## ----gethp--------------------------------------------------------------------
hpont_path = owl2cache(url="http://purl.obolibrary.org/obo/hp.owl")
hpents = setup_entities2(hpont_path)
kp = grep("UBER", names(hpents$name), value=TRUE)[21:30]
onto_plot2(hpents, kp)

## ----lkta---------------------------------------------------------------------
t(t(table(sapply(strsplit(names(hpents$name), "_"), "[", 1))))

