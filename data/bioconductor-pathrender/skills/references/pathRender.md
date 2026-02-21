pathRender: KEGG and Biocarta pathway
visualization

VJ Carey (document)/Li Long (software)

October 30, 2025

1

Introduction

Pathways are useful for organizing knowledge about molecular biological processes. Sev-
eral major catalogs of pathways are available, and this package addresses the visual-
ization of pathways from KEGG and Biocarta. Ultimately we want to be able to link
statistical data to pathway representations to aid interpretation. This package addresses
only the graph structures, annotation, and rendering of pathway diagrams. Much work
remains to be done to harvest in a scalable and customizable way the information pro-
vided on pathways.

2 Quick illustrations

As of 9/15/2007 it is not clear why some of the symbols are not translated to molecule

or interaction terms.

1

> library(pathRender)
> plot(G1 <- graphcMAP("p53pathway"))
> G1
> nodes(G1)[1:5]

Figure 1: A rendering of the p53 pathway according to Biocarta.

2

p53101472transcriptionBCL−2transcriptionp21transcriptionRB/E2F−1CDK4/CYCLIN D1/PCNARBE2F−1modificationCDK2/CYCLIN E/PCNAmodification100127modification101176transcription101473CYCLIN D1100515modification> plot(G2 <- graphcMAP("raspathway"))

Figure 2: A rendering of the Ras pathway according to Biocarta. The height and width
of the plotting surface are set to 12in each.

3

100781100169modificationcdc42modificationCaspase 9AKTmodificationphospholipase dARHAmodificationapoptosis101186RASmodification100048modificationPDK−1PIP3modificationAFXapoptosis100906modificationPI3KmodificationRac GEFsmodificationBCL−XLmodification101187modification1,2−diacyl−sn−glycero−3−phosphocholinePhosphatidic acidmodificationcell growth and/or maintenanceIKK−alphamodificationmodificationPIP2modificationmodificationmodificationmodification