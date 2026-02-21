# Code example from 'CellMapper' vignette. See references/ for full tutorial.

### R code from vignette source 'CellMapper.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: CellMapper.Rnw:66-69 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("CellMapper")


###################################################
### code chunk number 3: CellMapper.Rnw:84-88
###################################################
library("ExperimentHub")
hub <- ExperimentHub()
x <- query(hub, "CellMapperData")
x


###################################################
### code chunk number 4: CellMapper.Rnw:97-99
###################################################
BrainAtlas <- hub[["EH170"]]
BrainAtlas


###################################################
### code chunk number 5: CellMapper.Rnw:193-194
###################################################
library(CellMapper)


###################################################
### code chunk number 6: CellMapper.Rnw:208-211
###################################################
library(ExperimentHub)
hub <- ExperimentHub()
query(hub, "CellMapperData")


###################################################
### code chunk number 7: CellMapper.Rnw:217-218
###################################################
BrainAtlas <- hub[["EH170"]]


###################################################
### code chunk number 8: CellMapper.Rnw:226-227
###################################################
query <- "2571"


###################################################
### code chunk number 9: CellMapper.Rnw:234-235
###################################################
GABAergic <- CMsearch(BrainAtlas, query.genes = query)


###################################################
### code chunk number 10: CellMapper.Rnw:242-243
###################################################
head(GABAergic)


###################################################
### code chunk number 11: CellMapper.Rnw:248-249 (eval = FALSE)
###################################################
## write.csv(GABAergic, file = "CellMapper analysis for GABAergic neurons.csv")


###################################################
### code chunk number 12: CellMapper.Rnw:261-264
###################################################
Engreitz <- hub[["EH171"]]
Lukk <- hub[["EH172"]]
ZhengBradley <- hub[["EH173"]]


###################################################
### code chunk number 13: CellMapper.Rnw:275-280
###################################################
query2 <- "3856"

SimpleEpithelia <- CMsearch(list(Engreitz, Lukk, ZhengBradley), query.genes = 
query2)
head(SimpleEpithelia)


###################################################
### code chunk number 14: CellMapper.Rnw:310-312
###################################################
library(ALL)
data(ALL)


###################################################
### code chunk number 15: CellMapper.Rnw:317-318
###################################################
prepped.data <- CMprep(ALL)


###################################################
### code chunk number 16: CellMapper.Rnw:328-329 (eval = FALSE)
###################################################
## save(prepped.data, file = "Custom Data for CellMapper.Rdata")


###################################################
### code chunk number 17: CellMapper.Rnw:334-335 (eval = FALSE)
###################################################
## load("Custom Data for CellMapper.Rdata")


###################################################
### code chunk number 18: CellMapper.Rnw:346-348
###################################################
out <- CMsearch(prepped.data, query.genes = "1000_at")
head(out)


###################################################
### code chunk number 19: CellMapper.Rnw:383-384
###################################################
query(hub, "HumanAffyData")


###################################################
### code chunk number 20: CellMapper.Rnw:389-391
###################################################
E.MTAB.62 <- hub[["EH177"]]
E.MTAB.62


###################################################
### code chunk number 21: CellMapper.Rnw:400-401
###################################################
pDat <- pData(E.MTAB.62)


###################################################
### code chunk number 22: CellMapper.Rnw:409-410
###################################################
unique(pDat$OrganismPart)[1:30]


###################################################
### code chunk number 23: CellMapper.Rnw:418-420
###################################################
samples <- which(pDat$OrganismPart %in% c("colon", "colon mucosa",
"Small intestine"))


###################################################
### code chunk number 24: CellMapper.Rnw:426-427
###################################################
Lukk_unprocessed.gut <- exprs(E.MTAB.62)[, samples] 


###################################################
### code chunk number 25: CellMapper.Rnw:435-436
###################################################
Lukk.gut <- CMprep(Lukk_unprocessed.gut)


###################################################
### code chunk number 26: CellMapper.Rnw:444-446
###################################################
GSE64985 <- hub[["EH176"]]
pDat <- pData(GSE64985)


###################################################
### code chunk number 27: CellMapper.Rnw:455-461
###################################################
keywords <- c("colon", "intestin")

select = grepl(paste(keywords, collapse = "|"),
	pDat$title, ignore.case = TRUE) | 
	grepl(paste(keywords, collapse = "|"), 
	pDat$description, ignore.case = TRUE)


###################################################
### code chunk number 28: CellMapper.Rnw:469-470
###################################################
Engreitz_unprocessed.gut = exprs(GSE64985)[,select]


###################################################
### code chunk number 29: CellMapper.Rnw:475-476
###################################################
Engreitz.gut = CMprep(Engreitz_unprocessed.gut)


###################################################
### code chunk number 30: CellMapper.Rnw:483-487
###################################################
query = "1113"
EECs <- CMsearch(list(Lukk = Lukk.gut, Engreitz = Engreitz.gut), query.genes = 
	query)
head(EECs)


