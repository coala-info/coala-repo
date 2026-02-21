# Code example from 'synaptome_db_query' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      collapse = TRUE,
                      comment = "#>"
)

## ----setup.show, include=FALSE------------------------------------------------
suppressMessages(library(synaptome.db))
suppressMessages(library(dplyr))
library(pander)
library(ggplot2)

## ----pre_histogram,fig.width=8,fig.height=8,fig.cap='Number of identified proteins in Presynaptic datasets',eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE,fig.show='hold'----
gp<-findGeneByCompartmentPaperCnt(1)

# presynaptic stats
presgp <- gp[gp$Localisation == "Presynaptic",]
syngp <- gp[gp$Localisation == "Synaptosome",]
presg <- getGeneInfoByIDs(presgp$GeneID)
mpres <- merge(presgp, presg, by = c("GeneID","Localisation"))
mmpres <- mpres[, c('GeneID',
                    'HumanEntrez.x',
                    'HumanName.x',
                    'Npmid',
                    'PaperPMID',
                    'Paper',
                    'Year')]
papers <- getPapers()
prespap <- papers[papers$Localisation == "Presynaptic",]
mmmpres <- mmpres[mmpres$PaperPMID %in% prespap$PaperPMID,]
mmmpres$found <- 0
for(i in 1:dim(mmmpres)[1]) {
    if (mmmpres$Npmid[i] == 1) {
        mmmpres$found[i] <- '1'
    } else if (mmmpres$Npmid[i] > 1 & mmmpres$Npmid[i] < 4) {
        mmmpres$found[i] <- '2-3'
    } else if (mmmpres$Npmid[i] >= 4 & mmmpres$Npmid[i] < 10) {
        mmmpres$found[i] <- '4-9'
    } else if (mmmpres$Npmid[i] >= 10) {
        mmmpres$found[i] <- '>10'
    }
}

mmmpres$found<- factor(mmmpres$found,
                        levels = c('1','2-3','4-9','>10'),
                        ordered=TRUE)
tp<-unique(mmmpres$Paper)
mmmpres$Paper<- factor(mmmpres$Paper,
                        levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)',
                                                        '\\1',tp)))],
                        ordered=TRUE)

ummpres<-unique(mmmpres[,c('GeneID','Paper','found')])
ggplot(ummpres) + geom_bar(aes(y = Paper, fill = found)) 

## ----post_histogram,fig.width=8,fig.height=8,fig.cap='Number of identified proteins in Postsynaptic datasets',eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE,fig.show='hold'----
#postsynaptic stats
pstgp <- gp[gp$Localisation == "Postsynaptic",]
postg <- getGeneInfoByIDs(pstgp$GeneID)
mpost <- merge(pstgp, postg, by = c("GeneID","Localisation"))
mmpost <- mpost[, c('GeneID',
                    'HumanEntrez.x',
                    'HumanName.x','Npmid',
                    'PaperPMID','Paper','Year')]
postspap <- papers[papers$Localisation == "Postsynaptic",]
mmmpost <- mmpost[mmpost$PaperPMID %in% postspap$PaperPMID,]
mmmpost$found <- 0
for(i in 1:dim(mmmpost)[1]) {
    if (mmmpost$Npmid[i] == 1) {
        mmmpost$found[i] <- '1'
    } else if (mmmpost$Npmid[i] > 1 & mmmpost$Npmid[i] < 4) {
        mmmpost$found[i] <- '2-3'
    } else if (mmmpost$Npmid[i] >= 4 & mmmpost$Npmid[i] < 10) {
        mmmpost$found[i] <- '4-9'
    } else if (mmmpost$Npmid[i] >= 10) {
        mmmpost$found[i] <- '>10'
    }
}
mmmpost$found<- factor(mmmpost$found,levels = c('1','2-3','4-9','>10'),
                        ordered=TRUE)
tp<-unique(mmmpost$Paper)
mmmpost$Paper<- factor(mmmpost$Paper,
                        levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)',
                                                        '\\1',tp)))],
                        ordered=TRUE)
ummpos<-unique(mmmpost[,c('GeneID','Paper','found')])
ggplot(ummpos) + geom_bar(aes(y = Paper, fill = found)) 

## ----sv_histogram,fig.width=8,fig.height=8,fig.cap='Number of identified proteins in Synaptic Vesicle datasets (note the difference in the color scale)',eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE,fig.show='hold'----
svgp <- gp[gp$Localisation == "Synaptic_Vesicle",]
svg <- getGeneInfoByIDs(svgp$GeneID)
mpost <- merge(svgp, svg, by = c("GeneID","Localisation"))
mpost$Paper<-paste0(mpost$Paper,ifelse('FULL'==mpost$Dataset,'','_SVR'))
mmpost <- mpost[, c('GeneID','HumanEntrez.x','HumanName.x','Npmid',
                    'PaperPMID','Paper','Year')]
postspap <- papers[papers$Localisation == "Synaptic_Vesicle",]
mmmpost <- mmpost[mmpost$PaperPMID %in% postspap$PaperPMID,]
mmmpost$found <- 0
for(i in 1:dim(mmmpost)[1]) {
    if (mmmpost$Npmid[i] == 1) {
        mmmpost$found[i] <- '1'
    } else if (mmmpost$Npmid[i] > 1 & mmmpost$Npmid[i] < 4) {
        mmmpost$found[i] <- '2-3'
    } else if (mmmpost$Npmid[i] >= 4 & mmmpost$Npmid[i] < 6) {
        mmmpost$found[i] <- '4-5'
    } else if (mmmpost$Npmid[i] >= 6) {
        mmmpost$found[i] <- '>6'
    }
}

mmmpost$found<- factor(mmmpost$found,levels = c('1','2-3','4-5','>6'),
                        ordered=TRUE)
tp<-unique(mmmpost$Paper)
mmmpost$Paper<- factor(mmmpost$Paper,
                        levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)_?.*',
                                                        '\\1',tp)))],
                        ordered=TRUE)

ummpos<-unique(mmmpost[,c('GeneID','Paper','found')])
g<-ggplot(ummpos) + geom_bar(aes(y = Paper, fill = found)) 
g

## ----utot_histogram,fig.width=8,fig.height=8,fig.cap='Number of identified proteins in different Brain Regions(stacked)',eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE,fig.show='hold'----
#brain region statistics
totg <- getGeneInfoByIDs(gp$GeneID)
mtot <- merge(gp, totg, by = c("GeneID","Localisation"))
mmptot <- mtot[, c('GeneID',
                    'HumanEntrez.x',
                    'HumanName.x',
                    'Localisation',
                    'Npmid',
                    'Paper',
                    'BrainRegion')]
untot<-unique(mmptot[,c('GeneID','BrainRegion','Localisation')])
loccolors<-c("#3D5B59","#B5E5CF","#FCB5AC", "#B99095")
loccolors<-loccolors[1:length(unique(untot$Localisation))]
ggplot(untot) + geom_bar(aes(y = BrainRegion, fill = Localisation)) + 
    scale_fill_manual(values = loccolors)

## ----grouped_histogram,fig.width=8,fig.height=4,fig.cap='Number of identified proteins in different Brain Regions(grouped)',eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE,fig.show='hold'----
table(untot$Localisation,untot$BrainRegion)-> m
as.data.frame(m)->udf
names(udf)<-c('Localisation','BrainRegion','value')
ggplot(udf, aes(fill=Localisation, y=value, x=BrainRegion)) + 
    geom_bar(position="dodge", stat="identity")+ 
    scale_fill_manual(values = loccolors) + 
    theme(axis.text.x = element_text(face="plain", 
                                        color="#993333", 
                                        angle=45,vjust = 1,
                                        hjust=1,size = rel(1.5)))

## ----gene_info----------------------------------------------------------------
t <- getGeneInfoByEntrez(1742) 
pander(head(t))

t <- getGeneInfoByName("CASK")
pander(head(t))

t <- getGeneInfoByName(c("CASK", "DLG2"))
pander(head(t))                      

## ----findIDs------------------------------------------------------------------
t <- findGenesByEntrez(c(1742, 1741, 1739, 1740))
pander(head(t))

t <- findGenesByName(c("SRC", "SRCIN1", "FYN"))
pander(head(t))

## ----disease------------------------------------------------------------------
t <- getGeneDiseaseByName (c("CASK", "DLG2", "DLG1"))
pander(head(t))

t <- getGeneDiseaseByEntres (c(8573, 1742, 1739))
pander(head(t))

## ----paper--------------------------------------------------------------------
p <- getPapers()
pander(head(p))

## ----gene_count---------------------------------------------------------------
#find all proteins in synaptic proteome identified 2 times or more
gp <- findGeneByPaperCnt(cnt = 2)
pander(head(gp))

## ----gene_papCount------------------------------------------------------------
spg <- findGeneByPapers(p$PaperPMID[1:5], cnt = 1)
pander(head(spg))

## ----gene_comp----------------------------------------------------------------
gcp <- findGeneByCompartmentPaperCnt(cnt = 2)
pander(head(gcp))
# Now user can select the specific compartment and proceed working with 
# obtained list of frequently found proteins
presgp <- gcp[gcp$Localisation == "Presynaptic",]
dim(presgp)
pander(head(presgp))

## ----PPI----------------------------------------------------------------------
t <- getPPIbyName(
    c("CASK", "DLG4", "GRIN2A", "GRIN2B","GRIN1"), 
    type = "limited")
pander(head(t))

t <- getPPIbyEntrez(c(1739, 1740, 1742, 1741), type='induced')
pander(head(t))
 #obtain PPIs for the list of frequently found genes in presynaptc compartment
t <- getPPIbyEntrez(presgp$HumanEntrez, type='induced')
pander(head(t))

## ----compPPI------------------------------------------------------------------
#getting the list of compartment
comp <- getCompartments()
pander(comp)

#getting all genes for postsynaptic compartment
gns <- getAllGenes4Compartment(compartmentID = 1) 
pander(head(gns))

#getting full PPI network for postsynaptic compartment
ppi <- getPPIbyIDs4Compartment(gns$GeneID,compartmentID =1, type = "induced")
pander(head(ppi))


## ----regPPI-------------------------------------------------------------------
#getting the full list of brain regions
reg <- getBrainRegions()
pander(reg)

#getting all genes for mouse Striatum
gns <- getAllGenes4BrainRegion(brainRegion = "Striatum",taxID = 10090)
pander(head(gns))

#getting full PPI network for postsynaptic compartment
ppi <- getPPIbyIDs4BrainRegion(
    gns$GeneID, brainRegion = "Striatum", 
    taxID = 10090, type = "limited")
pander(head(ppi))

## ----check_list---------------------------------------------------------------
#check which genes from 250 random EntrezIds are in the database
listG<-findGenesByEntrez(1:250) 
dim(listG)
head(listG)

#check which genes from subset identified as synaptic are presynaptic
getCompartments()
presG <- getGenes4Compartment(listG$GeneID, 2) 
dim(presG)
head(presG)

#check which genes from subset identified as synaptic are found in 
#human cerebellum
getBrainRegions()
listR <- getGenes4BrainRegion(listG$GeneID, 
                              brainRegion = "Cerebellum", taxID = 10090) 
dim(listR)
head(listR)


## ----PPI_igraph,fig.width=7,fig.height=7,out.width="70%",fig.align = "center"----
library(igraph)
g<-getIGraphFromPPI(
    getPPIbyIDs(c(48, 129,  975,  4422, 5715, 5835), type='lim'))
plot(g,vertex.label=V(g)$RatName,vertex.size=25)

## ----PPI_table----------------------------------------------------------------
tbl<-getTableFromPPI(getPPIbyIDs(c(48, 585, 710), type='limited'))
tbl

## ----pre_histogram, eval=FALSE, include=TRUE----------------------------------
# gp<-findGeneByCompartmentPaperCnt(1)
# 
# # presynaptic stats
# presgp <- gp[gp$Localisation == "Presynaptic",]
# syngp <- gp[gp$Localisation == "Synaptosome",]
# presg <- getGeneInfoByIDs(presgp$GeneID)
# mpres <- merge(presgp, presg, by = c("GeneID","Localisation"))
# mmpres <- mpres[, c('GeneID',
#                     'HumanEntrez.x',
#                     'HumanName.x',
#                     'Npmid',
#                     'PaperPMID',
#                     'Paper',
#                     'Year')]
# papers <- getPapers()
# prespap <- papers[papers$Localisation == "Presynaptic",]
# mmmpres <- mmpres[mmpres$PaperPMID %in% prespap$PaperPMID,]
# mmmpres$found <- 0
# for(i in 1:dim(mmmpres)[1]) {
#     if (mmmpres$Npmid[i] == 1) {
#         mmmpres$found[i] <- '1'
#     } else if (mmmpres$Npmid[i] > 1 & mmmpres$Npmid[i] < 4) {
#         mmmpres$found[i] <- '2-3'
#     } else if (mmmpres$Npmid[i] >= 4 & mmmpres$Npmid[i] < 10) {
#         mmmpres$found[i] <- '4-9'
#     } else if (mmmpres$Npmid[i] >= 10) {
#         mmmpres$found[i] <- '>10'
#     }
# }
# 
# mmmpres$found<- factor(mmmpres$found,
#                         levels = c('1','2-3','4-9','>10'),
#                         ordered=TRUE)
# tp<-unique(mmmpres$Paper)
# mmmpres$Paper<- factor(mmmpres$Paper,
#                         levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)',
#                                                         '\\1',tp)))],
#                         ordered=TRUE)
# 
# ummpres<-unique(mmmpres[,c('GeneID','Paper','found')])
# ggplot(ummpres) + geom_bar(aes(y = Paper, fill = found))

## ----post_histogram, eval=FALSE, include=TRUE---------------------------------
# #postsynaptic stats
# pstgp <- gp[gp$Localisation == "Postsynaptic",]
# postg <- getGeneInfoByIDs(pstgp$GeneID)
# mpost <- merge(pstgp, postg, by = c("GeneID","Localisation"))
# mmpost <- mpost[, c('GeneID',
#                     'HumanEntrez.x',
#                     'HumanName.x','Npmid',
#                     'PaperPMID','Paper','Year')]
# postspap <- papers[papers$Localisation == "Postsynaptic",]
# mmmpost <- mmpost[mmpost$PaperPMID %in% postspap$PaperPMID,]
# mmmpost$found <- 0
# for(i in 1:dim(mmmpost)[1]) {
#     if (mmmpost$Npmid[i] == 1) {
#         mmmpost$found[i] <- '1'
#     } else if (mmmpost$Npmid[i] > 1 & mmmpost$Npmid[i] < 4) {
#         mmmpost$found[i] <- '2-3'
#     } else if (mmmpost$Npmid[i] >= 4 & mmmpost$Npmid[i] < 10) {
#         mmmpost$found[i] <- '4-9'
#     } else if (mmmpost$Npmid[i] >= 10) {
#         mmmpost$found[i] <- '>10'
#     }
# }
# mmmpost$found<- factor(mmmpost$found,levels = c('1','2-3','4-9','>10'),
#                         ordered=TRUE)
# tp<-unique(mmmpost$Paper)
# mmmpost$Paper<- factor(mmmpost$Paper,
#                         levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)',
#                                                         '\\1',tp)))],
#                         ordered=TRUE)
# ummpos<-unique(mmmpost[,c('GeneID','Paper','found')])
# ggplot(ummpos) + geom_bar(aes(y = Paper, fill = found))

## ----sv_histogram, eval=FALSE, include=TRUE-----------------------------------
# svgp <- gp[gp$Localisation == "Synaptic_Vesicle",]
# svg <- getGeneInfoByIDs(svgp$GeneID)
# mpost <- merge(svgp, svg, by = c("GeneID","Localisation"))
# mpost$Paper<-paste0(mpost$Paper,ifelse('FULL'==mpost$Dataset,'','_SVR'))
# mmpost <- mpost[, c('GeneID','HumanEntrez.x','HumanName.x','Npmid',
#                     'PaperPMID','Paper','Year')]
# postspap <- papers[papers$Localisation == "Synaptic_Vesicle",]
# mmmpost <- mmpost[mmpost$PaperPMID %in% postspap$PaperPMID,]
# mmmpost$found <- 0
# for(i in 1:dim(mmmpost)[1]) {
#     if (mmmpost$Npmid[i] == 1) {
#         mmmpost$found[i] <- '1'
#     } else if (mmmpost$Npmid[i] > 1 & mmmpost$Npmid[i] < 4) {
#         mmmpost$found[i] <- '2-3'
#     } else if (mmmpost$Npmid[i] >= 4 & mmmpost$Npmid[i] < 6) {
#         mmmpost$found[i] <- '4-5'
#     } else if (mmmpost$Npmid[i] >= 6) {
#         mmmpost$found[i] <- '>6'
#     }
# }
# 
# mmmpost$found<- factor(mmmpost$found,levels = c('1','2-3','4-5','>6'),
#                         ordered=TRUE)
# tp<-unique(mmmpost$Paper)
# mmmpost$Paper<- factor(mmmpost$Paper,
#                         levels =tp[order(as.numeric(sub('^[^0-9]+_([0-9]+)_?.*',
#                                                         '\\1',tp)))],
#                         ordered=TRUE)
# 
# ummpos<-unique(mmmpost[,c('GeneID','Paper','found')])
# g<-ggplot(ummpos) + geom_bar(aes(y = Paper, fill = found))
# g

## ----utot_histogram, eval=FALSE, include=TRUE---------------------------------
# #brain region statistics
# totg <- getGeneInfoByIDs(gp$GeneID)
# mtot <- merge(gp, totg, by = c("GeneID","Localisation"))
# mmptot <- mtot[, c('GeneID',
#                     'HumanEntrez.x',
#                     'HumanName.x',
#                     'Localisation',
#                     'Npmid',
#                     'Paper',
#                     'BrainRegion')]
# untot<-unique(mmptot[,c('GeneID','BrainRegion','Localisation')])
# loccolors<-c("#3D5B59","#B5E5CF","#FCB5AC", "#B99095")
# loccolors<-loccolors[1:length(unique(untot$Localisation))]
# ggplot(untot) + geom_bar(aes(y = BrainRegion, fill = Localisation)) +
#     scale_fill_manual(values = loccolors)

## ----grouped_histogram, eval=FALSE, include=TRUE------------------------------
# table(untot$Localisation,untot$BrainRegion)-> m
# as.data.frame(m)->udf
# names(udf)<-c('Localisation','BrainRegion','value')
# ggplot(udf, aes(fill=Localisation, y=value, x=BrainRegion)) +
#     geom_bar(position="dodge", stat="identity")+
#     scale_fill_manual(values = loccolors) +
#     theme(axis.text.x = element_text(face="plain",
#                                         color="#993333",
#                                         angle=45,vjust = 1,
#                                         hjust=1,size = rel(1.5)))

## ----sessionInfo, echo=FALSE, results='asis', class='text', warning=FALSE-----
c<-devtools::session_info()
pander::pander(t(data.frame(c(c$platform))))
pander::pander(as.data.frame(c$packages)[,-c(4,5,10,11)])

