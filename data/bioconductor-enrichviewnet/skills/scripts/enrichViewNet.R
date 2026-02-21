# Code example from 'enrichViewNet' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'hide', warning=FALSE, message=FALSE------
BiocStyle::markdown()

suppressPackageStartupMessages({
    library(knitr)
    library(enrichViewNet)
    library(gprofiler2)
    library(ggplot2)
    library(igraph)
    library(ggtangle)
    library(ggrepel)
})

## Set it globally
options(ggrepel.max.overlaps = 100)

set.seed(1214)

## ----graphDemo01, echo = FALSE, fig.align="center", fig.cap="A network where significant GO terms and genes are presented as nodes while edges connect each gene to its associated term(s).", out.width = '90%'----
knitr::include_graphics("demo01.jpeg")

## ----graphDemo02, echo=FALSE, fig.align="center", fig.cap="An enrichment map using significant Kegg terms where edges are connecting terms with overlapping genes.", out.width = '95%'----
knitr::include_graphics("demo_KEGG_emap_v03.jpg")

## ----installDemo01, eval=FALSE, warning=FALSE, message=FALSE------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#         install.packages("BiocManager")
# 
# BiocManager::install("enrichViewNet")

## ----graphWorkflow, echo=FALSE, fig.align="center", fig.cap="The enrichViewNet general workflow", out.width = '100%'----
knitr::include_graphics("Figure_enrichViewNet_workflow_v05.jpg")

## ----graphListToGraph01, echo = FALSE, fig.align="left", fig.cap="From an enrichment list (A) to a Cytoscape network (B).", out.width = '100%'----
knitr::include_graphics("FromListToGraph_v03.jpg")

## ----gprofiler, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE----

## Required library
library(gprofiler2)

## The dataset of differentially expressed genes done between 
## napabucasin treated and DMSO control parental (Froeling et al 2019)
## All genes tested are present
data("parentalNapaVsDMSODEG")

## Retain significant results 
## (absolute fold change superior to 1 and adjusted p-value inferior to 0.05)
retained <- which(abs(parentalNapaVsDMSODEG$log2FoldChange) > 1 & 
                            parentalNapaVsDMSODEG$padj < 0.05)
signRes <-  parentalNapaVsDMSODEG[retained, ]

## Run one functional enrichment analysis using all significant genes
## The species is homo sapiens ("hsapiens")
## The g:SCS multiple testing correction method (Raudvere U et al 2019)
## The WikiPathways database is used
## Only the significant results are retained (significant=TRUE)
## The evidence codes are included in the results (evcodes=TRUE)
## A custom background included the tested genes is used
gostres <- gprofiler2::gost(
                query=list(parental_napa_vs_DMSO=unique(signRes$EnsemblID)),
                organism="hsapiens",
                correction_method="g_SCS",
                sources=c("WP"),
                significant=TRUE,
                evcodes=TRUE,
                custom_bg=unique(parentalNapaVsDMSODEG$EnsemblID))

## ----gostResult, echo=TRUE, eval=TRUE-----------------------------------------
## The 'gostres' object is a list of 2 entries
## The 'result' entry contains the enrichment results
## The 'meta' entry contains the metadata information

## Some columns of interest in the results
gostres$result[1:4, c("query", "p_value", "term_size", 
                    "query_size", "intersection_size", "term_id")]

## The term names can be longer than the one shown
gostres$result[19:22, c("term_id", "source", "term_name")]


## ----cytoscapeLogo01, echo = FALSE, fig.align="center", fig.cap="Cytoscape software logo.", out.width = '55%'----
knitr::include_graphics("cy3sticker.png")

## ----runCreateNetwork, echo=TRUE, eval=TRUE, message=FALSE--------------------
## Load saved enrichment results between parental Napa vs DMSO
data("parentalNapaVsDMSOEnrichment")

## Create network for REACTOME significant terms
## The 'removeRoot=TRUE' parameter removes the root term from the network
## The network will either by created in Cytoscape (if the application is open)
## or a CX file will be created in the temporary directory
createNetwork(gostObject=parentalNapaVsDMSOEnrichment,  source="REAC", 
        removeRoot=TRUE, title="REACTOME_All", 
        collection="parental_napa_vs_DMSO", 
        fileName=file.path(tempdir(), "parentalNapaVsDMSOEnrichment.cx"))

## ----networkInCytoscape, echo=FALSE, fig.align="center", fig.cap="All reactome terms in a gene-term network loaded in Cytoscape.", out.width = '110%'----
knitr::include_graphics("cytoscape_reactome_all_parental_napa_vs_DMSO.png")

## ----runCreateNetworkSelected, echo=TRUE, eval=TRUE, message=FALSE------------
## Load saved enrichment results between parental Napa vs DMSO
data("parentalNapaVsDMSOEnrichment")

## List of terms of interest
reactomeSelected <- c("REAC:R-HSA-9031628", "REAC:R-HSA-198725", 
                        "REAC:R-HSA-9614085", "REAC:R-HSA-9617828",
                        "REAC:R-HSA-9614657", "REAC:R-HSA-73857",
                        "REAC:R-HSA-74160", "REAC:R-HSA-381340")

## All enrichment results
results <- parentalNapaVsDMSOEnrichment$result

## Retain selected results
selectedRes <- results[which(results$term_id %in% reactomeSelected), ]

## Print the first selected terms
selectedRes[, c("term_name")]


## ----runCreateNetworkSelected2, echo=TRUE, eval=TRUE, message=FALSE, fig.align="center", fig.cap="Enrichment map."----

## Create network for REACTOME selected terms
## The 'source="TERM_ID"' parameter enable to specify a personalized 
## list of terms of interest
## The network will either by created in Cytoscape (if the application is open)
## or a CX file will be created in the temporary directory
createNetwork(gostObject=parentalNapaVsDMSOEnrichment,  source="TERM_ID", 
        termIDs=selectedRes$term_id, title="REACTOME_Selected", 
        collection="parental_napa_vs_DMSO",
        fileName=file.path(tempdir(), "parentalNapaVsDMSO_REACTOME.cx"))

## ----networkInCytoscapeSelected, echo=FALSE, fig.align="center", fig.cap="Selected Reactome terms in a gene-term network loaded in Cytoscape.", out.width = '110%'----
knitr::include_graphics("cytoscape_with_selected_REACTOME_v01.png")

## ----networkFinalReactome, echo=FALSE, fig.align="center", fig.cap="Final Reactome network after customization inside Cytoscape.", out.width = '100%'----
knitr::include_graphics("REACTOME_Selected.jpeg")

## ----gprofiler2, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE----

## Required library
library(gprofiler2)

## The dataset of differentially expressed genes done between 
## napabucasin treated and DMSO control parental (Froeling et al 2019)
## All genes tested are present
data("parentalNapaVsDMSODEG")

## Retain significant results 
## (absolute fold change superior to 1 and adjusted p-value inferior to 0.05)
retained <- which(abs(parentalNapaVsDMSODEG$log2FoldChange) > 1 & 
                        parentalNapaVsDMSODEG$padj < 0.05)
signRes <- parentalNapaVsDMSODEG[retained, ]

## Run one functional enrichment analysis using all significant genes
## The species is homo sapiens ("hsapiens")
## The g:SCS multiple testing correction method (Raudvere U et al 2019)
## The WikiPathways database is used
## Only the significant results are retained (significant=TRUE)
## The evidence codes are included in the results (evcodes=TRUE)
## A custom background included the tested genes is used
gostres <- gprofiler2::gost(
                query=list(parental_napa_vs_DMSO=unique(signRes$EnsemblID)),
                organism="hsapiens",
                correction_method="g_SCS",
                sources=c("WP"),
                significant=TRUE,
                evcodes=TRUE,
                custom_bg=unique(parentalNapaVsDMSODEG$EnsemblID))

## ----gostResult2, echo=TRUE, eval=TRUE----------------------------------------
## The 'gostres' object is a list of 2 entries
## The 'result' entry contains the enrichment results
## The 'meta' entry contains the metadata information

## Some columns of interest in the results
gostres$result[1:4, c("query", "p_value", "term_size", 
                    "query_size", "intersection_size", "term_id")]

## The term names can be longer than the one shown
gostres$result[19:22, c("term_id", "source", "term_name")]


## ----runCreateEmap01, echo=TRUE, eval=TRUE, fig.cap="A Kegg enrichment map where terms with overlapping genes cluster together.", fig.align="center"----

## Load saved enrichment results between parental Napa vs DMSO
data(parentalNapaVsDMSOEnrichment)

## Create network for all Kegg terms
## All terms will be shown even if there is overlapping
createEnrichMap(gostObject=parentalNapaVsDMSOEnrichment, 
                    query="parental_napa_vs_DMSO", source="KEGG")
    

## ----runCreateEmapTerms, echo=TRUE, eval=TRUE, fig.cap="An enrichment map showing only the user selected terms.", fig.align="center"----

## Load saved enrichment results between parental Napa vs DMSO
data(parentalNapaVsDMSOEnrichment)

## The term IDs must correspond to the IDs present in the "term_id" column
head(parentalNapaVsDMSOEnrichment$result[, c("query", "term_id", "term_name")], 
     n=3)

## List of selected terms from different sources
termID <- c("KEGG:04115", "WP:WP4963", "KEGG:04010", 
                "REAC:R-HSA-5675221", "REAC:R-HSA-112409", "WP:WP382")

## Create network for all selected terms
createEnrichMap(gostObject=parentalNapaVsDMSOEnrichment, 
                    query="parental_napa_vs_DMSO", 
                    source="TERM_ID", termIDs=termID)
    

## ----runCreateEmap03, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, fig.cap="An enrichment map with personalized colors.", fig.align="center"----

## The ggplot2 library is required
library(ggplot2)
## Create network for all Kegg terms
graphKegg <- createEnrichMap(gostObject=parentalNapaVsDMSOEnrichment, 
                    query="parental_napa_vs_DMSO", source="KEGG")

## Nodes with lowest p-values will be in orange and highest p-values in black
## The title of the legend is also modified
graphKegg + scale_color_continuous(name="P-value adjusted", low="orange", 
                                    high="black")
    

## ----runCreateEmapIgraph01, echo=TRUE, eval=TRUE, fig.cap="A Reactome (12 top terms) enrichment map where terms with overlapping  genes cluster together.", fig.align="center"----

## Load saved enrichment results between parental Napa vs DMSO
data(parentalNapaVsDMSOEnrichment)

## Create network for all Reactome terms
## All terms will be shown even if there is overlapping
## The similarity cut off is set to 0.3
## The top 10 terms with best p-values are shown
emapGraph <- createEnrichMapAsIgraph(gostObject=parentalNapaVsDMSOEnrichment, 
                    query="parental_napa_vs_DMSO", similarityCutOff=0.3,
                    source="REAC", showCategory=12)

## Set seed to ensure reproducible results
set.seed(121)

## The igraph library is required
library(igraph)

## Use library igraph to create the visual representation
plot(emapGraph, layout=layout_with_fr, vertex.label.cex=0.5, 
        vertex.label.color="black", vertex.color="lightblue2")   

## ----runCreateEmapIgraph02, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, fig.cap="An enrichment map with a different seed.", fig.align="center"----

## Set seed to ensure reproducible results
set.seed(12)

## The igraph library is required
library(igraph)

## Use library igraph to create the visual representation
plot(emapGraph, layout=layout_with_fr, vertex.label.cex=0.5, 
        vertex.label.color="black", vertex.color="lightblue2")   

## ----runCreateEmapIgraph03, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, fig.cap="An enrichment map with personalized visualization options.", fig.align="center"----

## The required libraries
library(igraph)
library(ggplot2)
library(ggtangle)
library(ggrepel)

## Create network for all Reactome terms
## Minimum similarity to have a edge is set to 0.4
## Only the top 15 terms with the bestp-values are shown 
graphReac <- createEnrichMapAsIgraph(gostObject=parentalNapaVsDMSOEnrichment, 
                    query="parental_napa_vs_DMSO", similarityCutOff=0.4,
                    source="REAC", showCategory=10)

## Set seed to ensure reproducible results
set.seed(92)

## Using ggplot2 to generate a ggplot graph
graphEmap <- ggplot(graphReac, layout=layout_with_fr)

## Move right the node related to Signal Transduction
graphEmap$data$x[graphEmap$data$label == 
            "Signal Transduction"] <- 2.3

## Using ggtangle and ggrepel libraries to personalize output
## Set the color of the text, the nodes and the edges 
## Set the node size using size value present in the igraph object
## The edge width is associated to the similarity value
## the coord_fixed() function is used to fix 1:1 ratio
graphEmap + geom_edge(aes(linewidth=weight), color="blue1") + 
    geom_point(aes(size=size), colour="gray40") +
    geom_text_repel(aes(x=x, y=y, label=label), nudge_x=0.5, 
                 nudge_y=0.2, col="darkviolet", min.segment.length=0.1, 
                 max.overlaps=10) +
    scale_size_continuous(range=c(4, 12)) + 
    scale_linewidth_binned(range=c(1, 3)) + coord_fixed() 
    

## ----emapMulti01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg enrichment results for 2 different experiments.", fig.align="center"----

## Set seed to ensure reproducible results
set.seed(2121)

## The dataset of functional enriched terms for two experiments:
## napabucasin treated and DMSO control parental and
## napabucasin treated and DMSO control expressing Rosa26 control vector
## (Froeling et al 2019)
data("parentalNapaVsDMSOEnrichment")
data("rosaNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
gostObjectList <- list(parentalNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment)

## The queryList is a list of query names retained for each of the enrichment 
## object (same order). Beware that a enrichment object can contain more than 
## one query.
query_01 <- unique(parentalNapaVsDMSOEnrichment$result$query)[1]
query_02 <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]
queryList <- list(query_01, query_02)

## Enrichment map where the groups are the KEGG results for the 2 different
## experiments
createEnrichMapMultiBasic(gostObjectList=gostObjectList,
    queryList=queryList, source="KEGG", removeRoot=TRUE)
    


## ----emapMultiCustom, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map using KEGG terms from two enrichment analyses with personalized colors and legend."----

## Required library
library(ggplot2)

## Enrichment map where the groups are the KEGG results for the 2 different
## experiments
createEnrichMapMultiBasic(gostObjectList=gostObjectList,
    queryList=queryList, source="KEGG", removeRoot=TRUE) +
        scale_fill_manual(name="Groups",
                breaks=queryList,
                values=c("cyan4", "bisque3"),
                labels=c("parental", "rosa")) +
        theme(legend.title=element_text(face="bold"))


## ----emapMultiAsIgraph01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing GO Molecular Function enrichment results (top 10) for 2 different experiments.", fig.align="center"----

## Set seed to ensure reproducible results
set.seed(2121)

## The dataset of functional enriched terms for two experiments:
## napabucasin treated and DMSO control parental and
## napabucasin treated and DMSO control expressing Rosa26 control vector
## (Froeling et al 2019)
data("parentalNapaVsDMSOEnrichment")
data("rosaNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
gostObjectList <- list(parentalNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment)

## The queryList is a list of query names retained for each of the enrichment 
## object (same order). Beware that a enrichment object can contain more than 
## one query.
query_01 <- unique(parentalNapaVsDMSOEnrichment$result$query)[1]
query_02 <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]
queryList <- list(query_01, query_02)

## Enrichment map where the groups are the GO Molecular Function results 
## for the 2 different experiments
## Only the top 10 terms for each experiments (based on p-value) are shown
## Minimum Jaccard coefficient between 2 nodes is set to 0.6
emapGraph <- createEnrichMapMultiBasicAsIgraph(gostObjectList=gostObjectList,
    queryList=queryList, source="GO:MF", removeRoot=TRUE, showCategory=5,
    similarityCutOff=0.6)
    
library(igraph)
plot(emapGraph)


## ----emapMultiAsIgraph02, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map using GO Molecular Function terms from two enrichment analyses with personalized colors and legend."----

## The required libraries
library(igraph)
library(ggplot2)
library(ggtangle)
library(ggrepel)
library(scatterpie)

set.seed(11)

graphEmap <- ggplot(emapGraph, layout=layout_with_fr) 

## Extract information from igraph object about group associated to each node
pieInfo <- as.data.frame(do.call(rbind, V(emapGraph)$pie))
colnames(pieInfo) <- V(emapGraph)$pieName[[1]]

## Add information into the ggplot object to be able to color nodes
for (i in seq_len(ncol(pieInfo))) {
    graphEmap$data[colnames(pieInfo)[i]] <- pieInfo[, i]
}

## Colors selected for the groups
groupColor <- c("darkorange", "darkviolet")

## Using ggtangle, scatterpie and ggrepel libraries to personalize output
## geom_scatterpie() allows to have scatter pie plot
## geom_text_repel() allows to have minimum overlying terms
## scale_fill_manual() allows to personalize the color of the nodes
## coord_fixed() forces the plot to have a 1:1 aspect ratio
graphEmap + geom_edge(aes(linewidth=weight), color="black") +
    geom_scatterpie(aes(x=x, y=y, r=size/100), 
            cols=c(colnames(pieInfo)), legend_name="Group", color=NA) +
    geom_scatterpie_legend(radius=graphEmap$data$size/100, n=4, 
            x=max(graphEmap$data$x)+1, y=min(graphEmap$data$y)-0.5,
            labeller=function(x) {round(x*100)}, label_position="right") +
    scale_fill_manual(values=groupColor) +
    scale_size_continuous(range=c(2, 8)) + 
    scale_linewidth_binned(range=c(1, 3)) +
    geom_text_repel(aes(x=x, y=y, label=label), color="blue2", 
            max.overlaps=10) +
    coord_fixed()

## ----emapMultiComplex01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg and Reactome results from the rosa Napa vs DMSO analysis.", fig.align="center"----

## Set seed to ensure reproducible results
set.seed(3221)

## The dataset of functional enriched terms for one experiment:
## napabucasin treated and DMSO control expressing Rosa26 control vector
## (Froeling et al 2019)
data("rosaNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
## In this case, the same enrichment object is used twice
gostObjectList <- list(rosaNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment)

## Extract the query name from the enrichment object
query_01 <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]

## The query information is a data frame containing the information required 
##   to extract the specific terms for each enrichment object.
## The number of rows must correspond to the number of enrichment objects/
## The query name must be present in the enrichment object.
## The source can be: "GO:BP" for Gene Ontology Biological Process, 
##   "GO:CC" for Gene Ontology Cellular Component, "GO:MF" for Gene Ontology 
##   Molecular Function, "KEGG" for Kegg, "REAC" for Reactome, 
##   "TF" for TRANSFAC, "MIRNA" for miRTarBase, "CORUM" for CORUM database, 
##   "HP" for Human phenotype ontology and "WP" for WikiPathways or 
##   "TERM_ID" when a list of terms is specified.
## The termsIDs is an empty string except when the source is set to "TERM_ID".
## The group names are going to be used in the legend and should be unique to 
##  each group.
queryInfo <- data.frame(queryName=c(query_01, query_01), 
                            source=c("KEGG", "REAC"),
                            removeRoot=c(TRUE, TRUE),
                            termIDs=c("", ""), 
                            groupName=c("Kegg", "Reactome"),
                            stringsAsFactors=FALSE)

## Enrichment map where the groups are the KEGG and Reactome results for the 
## same experiment
createEnrichMapMultiComplex(gostObjectList=gostObjectList, 
        queryInfo=queryInfo)
    

## ----emapMultiCustom2, echo=TRUE, warning=FALSE, message=FALSE, collapse=FALSE, eval=TRUE, fig.cap="An enrichment map using selected terms related to MAP kinases and interleukin in two different experiments."----

## Set seed to ensure reproducible results
set.seed(28)

## The datasets of functional enriched terms for the two experiments:
## napabucasin treated and DMSO control expressing Rosa26 control vector and
## napabucasin treated and DMSO control parental MiaPaCa2 cells
## (Froeling et al 2019)
data("rosaNapaVsDMSOEnrichment")
data("parentalNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
## In this case, the same enrichment object is used twice
## The order of the objects must respect the order on the queryInfo data frame
## In this case: 
##   1. rosa dataset (for MAP kinases)
##   2. parental dataset (for MAP kinases)
##   3. rosa dataset (for interleukin)
##   4. parental dataset (for interleukin)
gostObjectList <- list(rosaNapaVsDMSOEnrichment, parentalNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment, parentalNapaVsDMSOEnrichment)

## Extract the query name from the enrichment object
query_rosa <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]
query_parental <- unique(parentalNapaVsDMSOEnrichment$result$query)[1]


## List of selected terms that will be shown in each group
rosa_mapk <- "GO:0017017,GO:0033549,KEGG:04010,WP:WP382"
rosa_il <- "KEGG:04657,WP:WP4754" 
parental_mapk <- paste0("GO:0017017,GO:0033549,KEGG:04010,", 
                            "REAC:R-HSA-5675221,REAC:R-HSA-112409,WP:WP382")
parental_il <- "WP:WP4754,WP:WP395"


## The query information is a data frame containing the information required 
## to extract the specific terms for each enrichment object
## The number of rows must correspond to the number of enrichment objects
## The query name must be present in the enrichment object
## The source is set to "TERM_ID" so that the terms present in termIDs column 
##  will be used
## The group name will be used for the legend, the same name cannot be 
##  used twice
queryInfo <- data.frame(queryName=c(query_rosa, query_parental, 
                    query_rosa, query_parental), 
        source=c("TERM_ID", "TERM_ID", "TERM_ID", "TERM_ID"),
        removeRoot=c(FALSE, FALSE, FALSE, FALSE),
        termIDs=c(rosa_mapk, parental_mapk, rosa_il, parental_il),
        groupName=c("rosa - MAP kinases", "parental - MAP kinases", 
                        "rosa - Interleukin", "parental - Interleukin"),
        stringsAsFactors=FALSE)

## Enrichment map where the groups TODO
createEnrichMapMultiComplex(gostObjectList=gostObjectList, 
        queryInfo=queryInfo)


## ----emapMultiComplexIgraph01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg and Reactome results from the rosa Napa vs DMSO analysis.", fig.align="center"----

## The dataset of functional enriched terms for one experiment:
## napabucasin treated and DMSO control expressing Rosa26 control vector
## (Froeling et al 2019)
data("rosaNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
## In this case, the same enrichment object is used twice
gostObjectList <- list(rosaNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment)

## Extract the query name from the enrichment object
query_01 <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]

## The query information is a data frame containing the information required 
##   to extract the specific terms for each enrichment object.
## The number of rows must correspond to the number of enrichment objects/
## The query name must be present in the enrichment object.
## The source can be: "GO:BP" for Gene Ontology Biological Process, 
##   "GO:CC" for Gene Ontology Cellular Component, "GO:MF" for Gene Ontology 
##   Molecular Function, "KEGG" for Kegg, "REAC" for Reactome, 
##   "TF" for TRANSFAC, "MIRNA" for miRTarBase, "CORUM" for CORUM database, 
##   "HP" for Human phenotype ontology and "WP" for WikiPathways or 
##   "TERM_ID" when a list of terms is specified.
## The termsIDs is an empty string except when the source is set to "TERM_ID".
## The group names are going to be used in the legend and should be unique to 
##  each group.
queryInfo <- data.frame(queryName=c(query_01, query_01), 
                            source=c("KEGG", "REAC"),
                            removeRoot=c(TRUE, TRUE),
                            termIDs=c("", ""), 
                            groupName=c("Kegg", "Reactome"),
                            stringsAsFactors=FALSE)


## Enrichment map where the groups are the KEGG and Reactome results for the 
## same experiment
## Minimum similarity coefficient to have 2 terms linked is set to 0.5
emapGraph <- createEnrichMapMultiComplexAsIgraph(gostObjectList=gostObjectList, 
        queryInfo=queryInfo, similarityCutOff=0.5)

## The igraph library is required
library(igraph)

## Set seed to ensure reproducible results
set.seed(3221)

## Use library igraph to create the visual representation
plot(emapGraph, layout=layout_with_fr, vertex.label.cex=0.5, 
        vertex.label.color="black")   
    

## ----changeSeedIgraph02, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg and Reactome results from the rosa Napa vs DMSO analysis with a different seed.", fig.align="center"----

## The igraph library is required
library(igraph)

## Set seed to ensure reproducible results
set.seed(911)

## Use library igraph to create the visual representation
plot(emapGraph, layout=layout_with_fr, vertex.label.cex=0.5, 
        vertex.label.color="black")  


## ----personalizedIgraph01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg and Reactome results from the rosa Napa vs DMSO and parental vs DMSO analyses as a ggplot graph.", fig.align="center"----

## Visualization libraries is required
library(igraph)
library(ggplot2)
library(ggtangle)
library(ggrepel)
library(scatterpie)

## Set seed to ensure reproducible results
set.seed(21)

## Using ggplot2 to generate a ggplot graph
graphEmap <- ggplot(emapGraph, layout=layout_with_fr) 

## Extract information about group associated to each node
pieInfo <- as.data.frame(do.call(rbind, V(emapGraph)$pie))
colnames(pieInfo) <- V(emapGraph)$pieName[[1]]

## Add information into the ggplot object to be able to color nodes
for (i in seq_len(ncol(pieInfo))) {
    graphEmap$data[colnames(pieInfo)[i]] <- pieInfo[, i]
}

## Colors selected for the groups
groupColor <- c("blue", "darkviolet")
    
## Using scatterpie, ggtangle and ggrepel libraries to personalize output
## geom_scatterpie() allows to have scatter pie plot
## geom_text_repel() allows to have minimum overlying terms
## scale_fill_manual() allows to personalize the color of the nodes
## coord_fixed() forces the plot to have a 1:1 aspect ratio
graphEmap + geom_edge(aes(linewidth=weight), color="lightblue3") +
    geom_scatterpie(aes(x=x, y=y, r=size/50), 
            cols=c(colnames(pieInfo)), legend_name="Group", color=NA) +
    geom_scatterpie_legend(radius=graphEmap$data$size/50, n=3, 
            x=max(graphEmap$data$x)+0.5, y=min(graphEmap$data$y)-0.5,
            labeller=function(x) {round(x*50)}, label_position="right") +
    scale_fill_manual(values=groupColor) +
    scale_size_continuous(range=c(2, 8)) + 
    scale_linewidth_binned(range=c(1, 3)) +
    geom_text_repel(aes(x=x, y=y, label=label), color="black", 
            max.overlaps=10) +
    coord_fixed()


## ----createEnrichMapMultiComplexAsIgraph01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg and Reactome results from the rosa Napa vs DMSO, and parenteal vs DMSO analyses.", fig.align="center"----

## The dataset of functional enriched terms for two experiments:
## napabucasin treated and DMSO control expressing Rosa26 control vector
## (Froeling et al 2019)
data("rosaNapaVsDMSOEnrichment")
data("parentalNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
## In this case, each enrichment object is used twice
gostObjectList <- list(rosaNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment, parentalNapaVsDMSOEnrichment, 
    parentalNapaVsDMSOEnrichment)

## Extract the query name from the enrichment object
query_01 <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]
query_02 <- unique(parentalNapaVsDMSOEnrichment$result$query)[1]

## The query information is a data frame containing the information required 
##   to extract the specific terms for each enrichment object.
## The number of rows must correspond to the number of enrichment objects/
## The query name must be present in the enrichment object.
## The source can be: "GO:BP" for Gene Ontology Biological Process, 
##   "GO:CC" for Gene Ontology Cellular Component, "GO:MF" for Gene Ontology 
##   Molecular Function, "KEGG" for Kegg, "REAC" for Reactome, 
##   "TF" for TRANSFAC, "MIRNA" for miRTarBase, "CORUM" for CORUM database, 
##   "HP" for Human phenotype ontology and "WP" for WikiPathways or 
##   "TERM_ID" when a list of terms is specified.
## The termsIDs is an empty string except when the source is set to "TERM_ID".
## The group names are going to be used in the legend and should be unique to 
##  each group.
queryInfo <- data.frame(queryName=c(query_01, query_01, query_02, query_02), 
                            source=c("GO:BP", "GO:CC", "GO:BP", "GO:CC"),
                            removeRoot=c(TRUE, TRUE, TRUE, TRUE),
                            termIDs=c("", "", "", ""), 
                            groupName=c("GO:BP - Napa", "GO:CC - Napa",
                                    "GO:BP - Parental", "GO:CC - Parental"),
                            stringsAsFactors=FALSE)


## Enrichment map where there are 2 groups generated from each 
## experiment
## Minimum similarity coefficient to have 2 terms linked is set to 0.5
## The 10 terms with the best p-value are selected for each group
emapGraph <- createEnrichMapMultiComplexAsIgraph(gostObjectList=gostObjectList, 
        queryInfo=queryInfo, similarityCutOff=0.5, showCategory=10)

## The igraph library is required
library(igraph)

## Set seed to ensure reproducible results
set.seed(3221)

## Use library igraph to create the visual representation
## Unfortunately, the output does not generate a scatter pie plot
## See next topic to generate a scatter pie plot
plot(emapGraph, layout=layout_with_fr, vertex.label.cex=0.5, 
        vertex.label.color="black")   
    

## ----personalized01, echo=TRUE, warning=FALSE, message=FALSE, collapse=F, eval=TRUE, fig.cap="An enrichment map containing Kegg and Reactome results from the rosa Napa vs DMSO and parental vs DMSO analyses as a ggplot graph.", fig.align="center"----

## Visualization libraries is required
library(igraph)
library(ggplot2)
library(ggtangle)
library(ggrepel)
library(scatterpie)

## The dataset of functional enriched terms for two experiments:
## napabucasin treated and DMSO control expressing Rosa26 control vector
## (Froeling et al 2019)
data("rosaNapaVsDMSOEnrichment")
data("parentalNapaVsDMSOEnrichment")

## The gostObjectList is a list containing all 
## the functional enrichment objects
## In this case, each enrichment object is used twice
gostObjectList <- list(rosaNapaVsDMSOEnrichment, 
    rosaNapaVsDMSOEnrichment, parentalNapaVsDMSOEnrichment, 
    parentalNapaVsDMSOEnrichment)

## Extract the query name from the enrichment object
query_01 <- unique(rosaNapaVsDMSOEnrichment$result$query)[1]
query_02 <- unique(parentalNapaVsDMSOEnrichment$result$query)[1]

## The query information is a data frame containing the information required 
##   to extract the specific terms for each enrichment object.
## The number of rows must correspond to the number of enrichment objects/
## The query name must be present in the enrichment object.
## The source can be: "GO:BP" for Gene Ontology Biological Process, 
##   "GO:CC" for Gene Ontology Cellular Component, "GO:MF" for Gene Ontology 
##   Molecular Function, "KEGG" for Kegg, "REAC" for Reactome, 
##   "TF" for TRANSFAC, "MIRNA" for miRTarBase, "CORUM" for CORUM database, 
##   "HP" for Human phenotype ontology and "WP" for WikiPathways or 
##   "TERM_ID" when a list of terms is specified.
## The termsIDs is an empty string except when the source is set to "TERM_ID".
## The group names are going to be used in the legend and should be unique to 
##  each group.
queryInfo <- data.frame(queryName=c(query_01, query_01, query_02, query_02), 
                            source=c("KEGG", "REAC", "KEGG", "REAC"),
                            removeRoot=c(TRUE, TRUE, TRUE, TRUE),
                            termIDs=c("", "", "", ""), 
                            groupName=c("Kegg - Rosa", "Reactome - Rosa",
                                "Kegg - Parental", "Reactome - Parental"),
                            stringsAsFactors=FALSE)

## Enrichment map where the groups are the KEGG and Reactome results for 
## two enrichment analyses
## Minimum similarity coefficient to have 2 terms linked is set to 0.3
## Only the 7 terms with best p-value are going to be shown in each group
emapIgraph <- createEnrichMapMultiComplexAsIgraph(gostObjectList=gostObjectList, 
        queryInfo=queryInfo, showCategory=5, similarityCutOff=0.3)

## Set seed to ensure reproducible results
set.seed(21)

## Using ggplot2 to generate a ggplot graph
graphEmap <- ggplot(emapIgraph, layout=layout_with_fr) 

## Extract information about group associated to each node
pieInfo <- as.data.frame(do.call(rbind, V(emapIgraph)$pie))
colnames(pieInfo) <- V(emapIgraph)$pieName[[1]]

## Add information into the ggplot object to be able to color nodes
for (i in seq_len(ncol(pieInfo))) {
    graphEmap$data[colnames(pieInfo)[i]] <- pieInfo[, i]
}

## Colors selected for the groups
groupColor <- c("darkorange", "violet", "darkorange4", "darkviolet")
    
## Using scatterpie, ggtangle and ggrepel libraries to personalize output
## geom_scatterpie() allows to have scatter pie plot
## geom_text_repel() allows to have minimum overlying terms
## scale_fill_manual() allows to personalize the color of the nodes
## coord_fixed() forces the plot to have a 1:1 aspect ratio
graphEmap + geom_edge(aes(linewidth=weight), color="blue3") +
    geom_scatterpie(aes(x=x, y=y, r=size/50), 
            cols=c(colnames(pieInfo)), legend_name="Group", color=NA) +
    geom_scatterpie_legend(radius=graphEmap$data$size/50, n=3, 
            x=max(graphEmap$data$x)+0.5, y=min(graphEmap$data$y)-0.5,
            labeller=function(x) {round(x*50)}, label_position="right") +
    scale_fill_manual(values=groupColor) +
    scale_size_continuous(range=c(2, 8)) + 
    scale_linewidth_binned(range=c(1, 2)) +
    geom_text_repel(aes(x=x, y=y, label=label), color="black", 
            max.overlaps=10) +
    coord_fixed()


## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

