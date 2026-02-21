# Code example from 'DEsubs' vignette. See references/ for full tutorial.

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
if (.Platform[['OS.type']] == 'unix') 
{ 
    options('DEsubs_CACHE'=file.path(path.expand("~"), 'DEsubs') ) 
}
if (.Platform[['OS.type']] == 'windows') 
{ 
    options('DEsubs_CACHE'=file.path(
            gsub("\\\\", "/", Sys.getenv("USERPROFILE")), "AppData/DEsubs"))
}

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# library('DEsubs')
# 
# load(system.file('extdata', 'data.RData', package='DEsubs'))

## ----setup, echo=FALSE, include=FALSE-----------------------------------------
# set global chunk options: 

if (.Platform[['OS.type']] == 'unix') 
{ 
    options('DEsubs_CACHE'=file.path(path.expand("~"), 'DEsubs') ) 
}
if (.Platform[['OS.type']] == 'windows') 
{ 
    options('DEsubs_CACHE'=file.path(
            gsub("\\\\", "/", Sys.getenv("USERPROFILE")), "AppData/DEsubs"))
}

library(knitr)
library('DEsubs')
load(system.file('extdata', 'data.RData', package='DEsubs'))

## ----eval=TRUE, echo=FALSE----------------------------------------------------


DEsubs.run <- DEsubs(   org='hsa', 
                        mRNAexpr=mRNAexpr, 
                        mRNAnomenclature='entrezgene', 
                        pathways='All', 
                        DEtool=NULL, 
                        DEpar=0.05,
                        CORtool='pearson', 
                        CORpar=0.7, 
                        subpathwayType=NULL,
                        rankedList=rankedList, verbose=FALSE)

## ----eval=TRUE, echo=FALSE, out.height='235px', fig.align='center', fig.cap=cap, fig.pos='h', out.extra=''----

cap <- paste0(
    'Stream, neighborhood and cascade types build each subpathway ',
    '(blue nodes) by starting from a gene of interest (red nodes). ',
    'Components and communities are densely linked group of genes with the ',
    'difference that the genes sharing common properties are maintained ',
    'within the graph (green nodes).')

knitr::include_graphics('figures/fig1.png')

## ----eval=TRUE, echo=TRUE-----------------------------------------------------

DEsubs.run <- DEsubs(
                    org='hsa', 
                    mRNAexpr=mRNAexpr, 
                    mRNAnomenclature='entrezgene', 
                    pathways='All', 
                    DEtool=NULL, DEpar=0.05, 
                    CORtool='pearson', CORpar=0.7,
                    subpathwayType='community.walktrap',
                    rankedList=rankedList, 
                    verbose=FALSE)

## ----eval=TRUE, echo=FALSE, out.height='575px', fig.align='center', fig.cap=cap----

cap <- paste0(
    'Subpathway extraction options consist of five main categories. ', 
    'The three of them (cascade, neighborhood, stream) are sub-categorized ', 
    'according to features (topological or functional) and the direction of ',
    'propagation (forward or backward) of the gene of interest where each ',
    'subpathway is starting. The other two (component, community) are ',
    'sub-categorized according to various topological properties.')

knitr::include_graphics('figures/fig2.png')

## ----eval=TRUE, echo=FALSE, out.height='385px', fig.align='center', fig.cap=cap, fig.pos='h', out.extra=''----

cap <- paste0(
    'Bar plots show the genes with the best Q-value from the user-selected ',
    'DE analysis tool (the user defines the desired gene number). ',
    'Heat maps show the genes with the highest values either in our ',
    'topological or functional measures (see Table 6). ',
    'Each extracted subpathway is illustrated though a directed graph by ',
    'imprinting the degree of DE and correlation among the respective gene ',
    'members. Subpathway enrichment in association with biological and ',
    'pharmacological features (such as pathway terms, gene ontologies, ',
    'regulators, diseases and drug targets) is depicted through circular ',
    'diagrams. The total picture of the enriched subpathways is performed ', 
    'with dot plots.')

knitr::include_graphics('figures/fig3.png')

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# 
# res <- geneVisualization(
#             DEsubs.out=DEsubs.out, top=10,
#             measures.topological=c( 'degree', 'betweenness', 'closeness',
#                                     'eccentricity', 'page_rank'),
#             measures.functional=c(  'KEGG', 'GO_bp','GO_cc', 'GO_mf',
#                                     'Disease_OMIM', 'Disease_GAD',
#                                     'Drug_DrugBank','miRNA', 'TF'),
#             size.topological=c(5,4),
#             size.functional=c(7,4),
#             size.barplot=c(5,6),
#             export='plot', verbose=FALSE)

## ----echo=FALSE, fig.width=6.2, fig.height=5.2, fig.cap=cap, fig.pos='h', out.extra=''----

cap <- 'Bars illustrate the genes with the highest Q-values.'

res <- geneVisualization(  
            DEsubs.out=DEsubs.out, 
            top=10,
            measures.topological=NULL,
            measures.functional=NULL,
            measures.barplot=TRUE,
            size.barplot=c(5,6), 
            export='plot',
            verbose=FALSE)

## ----echo=FALSE, fig.width=7, fig.height=4, fig.align='center', fig.cap=cap----

cap <- 'Heat map represents the twelve genes with the highest values of 
functional measures. The values are scaled and the red graduation indicates 
the value degree.'

res <- geneVisualization(  
            DEsubs.out=DEsubs.out, 
            top=12,
            measures.topological=NULL,
            measures.functional=c(  'KEGG', 'GO_bp','GO_cc', 'GO_mf', 
                                    'Disease_OMIM', 'Disease_GAD', 
                                    'Drug_DrugBank','miRNA', 'TF'),
            measures.barplot=FALSE,
            size.functional=c(7,4), 
            export='plot',
            verbose=FALSE)

## ----echo=FALSE, fig.width=5, fig.height=4, fig.align="center", fig.cap=cap----

cap <- 'Heat map represents the twelve genes with the highest values of 
topological measures. The values are scaled and the red graduation indicates 
the value degree.'

res <- geneVisualization(  
            DEsubs.out=DEsubs.out, 
            top=12,
            measures.topological=c( 'degree', 'betweenness', 'closeness',
                                    'eccentricity', 'page_rank'),
            measures.functional=NULL,
            measures.barplot=FALSE,
            size.topological=c(5,4), 
            export='plot',
            verbose=FALSE)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# 
# res <- subpathwayToGraph(
#                     DEsubs.out=DEsubs.out,
#                     submethod='community.walktrap',
#                     subname='sub6', verbose=FALSE,
#                     export='plot' )

## ----echo=FALSE, fig.width=3.5, fig.height=3.5, fig.align='center', fig.cap=cap, fig.pos='h', out.extra=''----

library('DEsubs')
load(system.file('extdata', 'data.RData', package='DEsubs'))

cap <- 'Graph illustrates the links of a subpathway. Red graduation 
in nodes indicate the Q-value degree, the edge width indicates the correlation
degree between the respective genes. Green or red color in edges indicates 
the positive or negative correlation respectively'

res <- subpathwayToGraph( 
                    DEsubs.out=DEsubs.out, 
                    submethod='community.walktrap', 
                    subname='sub6', 
                    verbose=FALSE,
                    export='plot' )

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# 
# res <- subpathwayVisualization(
#                     DEsubs.out=DEsubs.out,
#                     references=c('GO', 'TF'),
#                     submethod='community.walktrap',
#                     subname='sub1',
#                     scale=c(1, 1),
#                     export='plot',
#                     verbose=FALSE)
# 

## ----echo=FALSE, fig.width=3.8, fig.height=3.8, fig.align='center', fig.cap=cap----

cap <- 'Circular Diagram shows the associations among genes including in a 
subpathway and Gene Ontology terms where are enriched'

library('DEsubs')
load(system.file('extdata', 'data.RData', package='DEsubs'))

res <- subpathwayVisualization( 
                    DEsubs.out=DEsubs.out,  
                    references='GO', 
                    submethod='community.walktrap', 
                    subname='sub1', 
                    scale=1, 
                    export='plot', 
                    verbose=FALSE)

## ----echo=FALSE, fig.width=4.0, fig.height=4.0, fig.align='center', fig.cap=cap----

cap <- 'Circular Diagram shows the associations among genes included in a 
subpathway and enriched Transcription Factors.'


res <- subpathwayVisualization( 
                    DEsubs.out=DEsubs.out,  
                    references='TF', 
                    submethod='community.walktrap', 
                    subname='sub1', 
                    scale=1.0, 
                    export='plot', 
                    verbose=FALSE)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# 
# res <- organismVisualization(
#                     DEsubs.out=DEsubs.out,
#                     references='KEGG',
#                     topSubs=10,
#                     topTerms=20,
#                     export='plot',
#                     verbose=FALSE)

## ----echo=FALSE, fig.width=7.4, fig.height=6, fig.align='center', fig.cap=cap, fig.pos='h', out.extra=''----

cap <- 'Dot plot shows the enriched associations among experiment-specific 
extracted subpathways and pathwaysfrom KEGG database. 
Twenty pathways were selected as the desired number of terms.'


res <- organismVisualization( 
            DEsubs.out=DEsubs.out, 
            references='KEGG', 
            topSubs=10, topTerms=20, 
            export='plot', verbose=FALSE)

