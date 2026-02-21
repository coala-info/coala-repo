# Code example from 'BioNAR_overview' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(knitr)
library(BioNAR)
library(ggplot2)
library(pander)
library(ggrepel)
library(randomcoloR)

## ----network_from_scratch-----------------------------------------------------
file <- system.file("extdata", "PPI_Presynaptic.csv", package = "BioNAR")
tbl <- read.csv(file, sep="\t")
head(tbl)
gg <- buildNetwork(tbl)
summary(gg)


## ----net_predefind------------------------------------------------------------
file <- system.file("extdata", "PPI_Presynaptic.gml", package = "BioNAR")
gg1 <- igraph::read_graph(file,format="gml")
summary(gg1)

## ----cluster_predefind, include=FALSE-----------------------------------------
file <- system.file("extdata", "PPI_cluster.gml", package = "BioNAR")
ggCluster <- igraph::read_graph(file,format="gml")
summary(ggCluster)

## ----annotate_net-------------------------------------------------------------
gg<-annotateGeneNames(gg)
summary(gg)
head(V(gg))
head(V(gg)$GeneName)

## ----check_genenames_na-------------------------------------------------------
any(is.na(V(gg)$GeneName))

## ----fix.GRPEL1, eval=any(is.na(V(gg)$GeneName))------------------------------
# idx <- which(V(gg)$name == '80273')
# V(gg)$GeneName[idx]<-'GRPEL1'

## ----annotate_topOnto---------------------------------------------------------
afile<-system.file("extdata", "flatfile_human_gene2HDO.csv", package = "BioNAR")
dis <- read.table(afile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
gg <- annotateTopOntoOVG(gg, dis)
summary(gg)


## ----annotate_Shanno----------------------------------------------------------
sfile<-system.file("extdata", "SCH_flatfile.csv", package = "BioNAR")
shan<- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg<-annotateSCHanno(gg,shan)
summary(sgg)

## ----annotate_Chua, eval=FALSE------------------------------------------------
# sfile<-system.file("extdata", "PresynAn.csv", package = "BioNAR")
# pres <- read.csv(sfile,skip=1,header=FALSE,strip.white=TRUE,quote="")
# sgg <- annotatePresynaptic(gg, pres)
# summary(sgg)

## ----annotate_go--------------------------------------------------------------

ggGO <- annotateGOont(gg)

## ----annotate_file_go---------------------------------------------------------
#however, functionality from GO: BP, MF,CC can be added

sfile<-system.file("extdata", "flatfile.go.BP.csv", package = "BioNAR")
goBP <- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotateGoBP(gg, goBP)
summary(sgg)

sfile<-system.file("extdata", "flatfile.go.MF.csv", package = "BioNAR")
goMF <- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotateGoMF(gg, goMF)
summary(sgg)

sfile<-system.file("extdata", "flatfile.go.CC.csv", package = "BioNAR")
goCC <- read.table(sfile,sep="\t",skip=1,header=FALSE,strip.white=TRUE,quote="")
sgg <- annotateGoCC(gg, goCC)
summary(sgg)


## ----graph_cent---------------------------------------------------------------
gg <- calcCentrality(gg)
summary(gg)

## ----matrix_cent--------------------------------------------------------------
mc <- getCentralityMatrix(gg)
head(mc)

## ----powerLaw,fig.height=8,fig.width=8,dpi=56---------------------------------
pFit <- fitDegree( as.vector(igraph::degree(graph=gg)),threads=1,Nsim=5,
                    plot=TRUE,WIDTH=2480, HEIGHT=2480)

## ----ent_rate,fig.height=8,fig.width=8,dpi=56---------------------------------
ent <- getEntropyRate(gg)
ent
SRprime <- getEntropy(gg, maxSr = NULL)
head(SRprime)
plotEntropy(SRprime, subTIT = "Entropy", SRo = ent$SRo, maxSr = ent$maxSr)

## ----norm_mod-----------------------------------------------------------------
nm<-normModularity(gg,alg='louvain')
nm

## ----cluster.mem--------------------------------------------------------------
# choose one algorithm from the list
alg = "louvain"
mem <- calcMembership(gg, alg)
pander(head(mem))

## ----cluster.mem2-------------------------------------------------------------
mem2 <- calcMembership(gg, alg)
idx<-match(mem$names,mem2$names)
idnx<-which(as.character(mem$membership)!=as.character(mem2$membership[idx]))
pander(head(cbind(mem[idnx,],mem2[idx[idnx],])))

## ----cluster------------------------------------------------------------------
gg <- calcClustering(gg, alg)
summary(gg)

## ----get.attr-----------------------------------------------------------------
mem.df<-data.frame(names=V(gg)$name,membership=factor(V(gg)$louvain))

## ----calcAllClustering,eval=FALSE---------------------------------------------
# ggc <- calcAllClustering(gg)

## ----calcAllClustering.hid,eval=TRUE,include=FALSE----------------------------
ggc <- ggCluster

## ----clusterSummary,eval=TRUE-------------------------------------------------
m<-clusteringSummary(ggc,att=c('lec','wt','fc',
                                'infomap','louvain',
                                'sgG1','sgG2','sgG5'))
pander(m)

## ----plot.color.graph,fig.height=8,fig.width=8,dpi=56-------------------------
palette <- distinctColorPalette(max(as.numeric(mem.df$membership)))
plot(gg,vertex.size=3,layout=layout_nicely,
        vertex.label=NA,
        vertex.color=palette[as.numeric(mem.df$membership)],
        edge.color='grey95')
legend('topright',legend=names(table(mem.df$membership)),
        col=palette,pch=19,ncol = 2)

## ----plot.clusterwise.graph,fig.height=8,fig.width=8,dpi=56-------------------
lay<-layoutByCluster(gg,mem.df,layout = layout_nicely)
plot(gg,vertex.size=3,layout=lay,
        vertex.label=NA,
        vertex.color=palette[as.numeric(mem.df$membership)],
        edge.color='grey95')
legend('topright',legend=names(table(mem.df$membership)),
        col=palette,pch=19,ncol = 2)

## ----ploc.cluster.communities,fig.height=8,fig.width=8,dpi=56-----------------
idx<-match(V(gg)$name,mem.df$names)
cgg<-getCommunityGraph(gg,mem.df$membership[idx])
D0 = unname(degree(cgg))
plot(cgg, vertex.size=sqrt(V(cgg)$size), vertex.cex = 0.8,
vertex.color=round(log(D0))+1,layout=layout_with_kk,margin=0)

## ----recluster----------------------------------------------------------------
remem<-calcReclusterMatrix(gg,mem.df,alg,10)
head(remem)

## ----plot.recluster.layout,fig.height=8,fig.width=8,dpi=56--------------------
lay<-layoutByRecluster(gg,remem,layout_nicely)
plot(gg,vertex.size=3,layout=lay,
        vertex.label=NA,
        vertex.color=palette[as.numeric(mem.df$membership)],
        edge.color='grey95')
legend('topright',legend=names(table(mem.df$membership)),
        col=palette,pch=19,ncol = 2)

## ----cons_mat-----------------------------------------------------------------
#Build consensus matrix for louvain clustering
conmat <- makeConsensusMatrix(gg, N=5,
                                alg = alg, type = 2, 
                                mask = 10,reclust = FALSE, 
                                Cnmax = 10)


## ----plot.conmat.ecdf,fig.height=8,fig.width=8,dpi=56-------------------------
steps <- 100
Fn  <- ecdf(conmat[lower.tri(conmat)])
X<-seq(0,1,length.out=steps+1)
cdf<-Fn(X)
dt<-data.frame(cons=X,cdf=cdf)
ggplot(dt,aes(x=cons,y=cdf))+geom_line()+
        theme(            
        axis.title.x=element_text(face="bold",size=rel(2.5)),
        axis.title.y=element_text(face="bold",size=rel(2.5)),
        legend.title=element_text(face="bold",size=rel(1.5)),
        legend.text=element_text(face="bold",size=rel(1.5)),
        legend.key=element_blank())+
    theme(panel.grid.major = element_line(colour="grey40",linewidth=0.2),
            panel.grid.minor = element_line(colour="grey40",linewidth=0.1),
            panel.background = element_rect(fill="white"),
            panel.border = element_rect(linetype="solid",fill=NA))

## ----clcons-------------------------------------------------------------------
clrob<-getRobustness(gg, alg = alg, conmat)
pander(clrob)

## ----get.bridge---------------------------------------------------------------
br<-getBridgeness(gg,alg = alg,conmat)
pander(head(br))

## ----calc.bridge--------------------------------------------------------------
gg<-calcBridgeness(gg,alg = alg,conmat)
vertex_attr_names(gg)

## ----plot.bridgeness,fig.height=8,fig.width=8,dpi=56--------------------------
g<-plotBridgeness(gg,alg = alg,
               VIPs=c('8495','22999','8927','8573',
                      '26059','8497','27445','8499'),
               Xatt='SL',
               Xlab = "Semilocal Centrality (SL)",
               Ylab = "Bridgeness (B)",
               bsize = 3,
               spsize =7,
               MainDivSize = 0.8,
               xmin = 0,
               xmax = 1,
               ymin = 0,
               ymax = 1,
               baseColor="royalblue2",
               SPColor="royalblue2")
g

## ----plotly,fig.height=6,fig.width=6------------------------------------------
library(plotly)
g<-plotBridgeness(gg,alg = alg,
               VIPs=c('8495','22999','8927','8573',
                      '26059','8497','27445','8499'),
               Xatt='SL',
               Xlab = "Semilocal Centrality (SL)",
               Ylab = "Bridgeness (B)",
               bsize = 1,
               spsize =2,
               MainDivSize = 0.8,
               xmin = 0,
               xmax = 1,
               ymin = 0,
               ymax = 1,
               baseColor="royalblue2",
               SPColor="royalblue2")
ggplotly(g)

## ----disPairs,warning=FALSE,message=FALSE-------------------------------------
p <- calcDiseasePairs(
    gg,
    name = "TopOnto_OVG_HDO_ID",
    diseases = c("DOID:10652","DOID:3312"),
    permute = "r"
)
pander(p$disease_separation)

r <- runPermDisease(
    gg,
    name = "TopOnto_OVG_HDO_ID",
    diseases = c("DOID:10652","DOID:3312"),
    Nperm = 100,
    alpha = c(0.05, 0.01, 0.001)
)

pander(r$Disease_overlap_sig)

## ----ora,warning=FALSE,message=FALSE------------------------------------------
ora <- clusterORA(gg, alg, name = 'TopOnto_OVG_HDO_ID', vid = "name",
                  alpha = 0.1, col = COLLAPSE)

## ----sessionInfo, echo=FALSE, results='asis', class='text', warning=FALSE-----
library(devtools)
si<-devtools::session_info()
cat('Platform\n\n')
pander::pander(si$platform)
cat('Packages\n\n')
knitr::kable(as.data.frame(si$packages)[,c('ondiskversion',
                                            'loadedversion','date',
                                            'source')],align = c('l','l'))

