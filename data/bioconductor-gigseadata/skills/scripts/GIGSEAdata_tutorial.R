# Code example from 'GIGSEAdata_tutorial' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(GIGSEAdata)
data(org.Hs.eg.GO)
class(org.Hs.eg.GO)
names(org.Hs.eg.GO)
dim(org.Hs.eg.GO$net)
head(colnames(org.Hs.eg.GO$net))
head(rownames(org.Hs.eg.GO$net))
head(org.Hs.eg.GO$annot)
head(org.Hs.eg.GO$net[,1:30])

