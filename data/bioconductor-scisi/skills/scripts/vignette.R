# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################
library("ScISI")


###################################################
### code chunk number 2: getGOInfo
###################################################
goECodes = c("IEA", "NAS", "ND", "NR")
go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType=NULL, 
               eCode = goECodes, wantAllComplexes = TRUE)


###################################################
### code chunk number 3: getGOInfoToGrep
###################################################
toBeParsed = list()
toBeParsed$pattern = "\\Bsomal\\b"
goGrep = getGOInfo(wantDefault = TRUE, toGrep = toBeParsed, parseType = "grep",
                   eCode = NULL, wantAllComplexes = TRUE)
getGOTerm(setdiff(names(goGrep), names(go)))



###################################################
### code chunk number 4: getGOInfoOut
###################################################
class(go)
names(go)[1:5]
go$"GO:0005830"


###################################################
### code chunk number 5: createGOMatrix
###################################################
goM = list2Matrix(go)


###################################################
### code chunk number 6: getMipsInfo
###################################################
mips = getMipsInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL, 
                   eCode = NULL, wantSubComplexes = TRUE, ht=FALSE)


###################################################
### code chunk number 7: getMipsInfoToGrep
###################################################
toBeParsed = list()
toBeParsed$pattern = "\\Bsomal\\b"
mipsGrep = getMipsInfo(wantDefault = TRUE, toGrep = toBeParsed, parseType = "grep",
                       eCode = NULL, wantSubComplexes = TRUE)
#mNm = setdiff(names(mipsGrep$Mips), names(mips$Mips))
#mId = strsplit(mNm, split = "-")
#sapply(mId, function(q) mipsGrep$DESC[q[2]])


###################################################
### code chunk number 8: mipsInfo
###################################################
class(mips)
names(mips)


###################################################
### code chunk number 9: getMipsInfoMips
###################################################
class(mips)
names(mips)[1:10]
mips$Mips$"MIPS-510.40"


###################################################
### code chunk number 10: getMipsInfoDESC
###################################################
names(mips$DESC)[1:5]
mips$DESC["510.40"]


###################################################
### code chunk number 11: createMipsMatrix
###################################################
mipsM = list2Matrix(mips)


###################################################
### code chunk number 12: ppiData
###################################################
library("ppiData")
get("Gavin2006BPGraph")


###################################################
### code chunk number 13: runCompareComplex
###################################################
mips2mips = runCompareComplex(mipsM, mipsM)
go2go = runCompareComplex(goM, goM)  
mips2go = runCompareComplex(mipsM, goM)
names(mips2go)


###################################################
### code chunk number 14: runCompareComplexJC
###################################################
all(diag(mips2mips[["JC"]]) == 1)


###################################################
### code chunk number 15: runCompareComplexMaxInterSect
###################################################
names(mips2go$maxIntersect)


###################################################
### code chunk number 16: runCompareComplexMImaxComp
###################################################

mips2go$maxIntersect$maximize$row[1:3]
mips2go$maxIntersect$maxComp$row[1:3]



###################################################
### code chunk number 17: runCompareComplexEqual
###################################################
length(mips2go$equal)
names(mips2go$equal[[1]])
mips2go$equal[[1]]


###################################################
### code chunk number 18: runCompareComplexEqualMips
###################################################
ind = which(sapply(mips2mips$equal, function(w) w$BG1Comp != w$BG2Comp))
mips2mips$equal[ind]


###################################################
### code chunk number 19: runCompareComplexSubC
###################################################
mips2mips$toBeRmSubC[1:3]
mips2go$toBeRmSubC[1:3]


###################################################
### code chunk number 20: saveData
###################################################
save(mips2go, file="mips2go.rda", compress=TRUE)


###################################################
### code chunk number 21: mergeBGMat
###################################################
  dim(mipsM)
  dim(goM)
  ISI = mergeBGMat(mipsM, goM, toBeRm = c(mips2go$toBeRm, mips2mips$toBeRm, go2go$toBeRm))
 


###################################################
### code chunk number 22: dimISI
###################################################
dim(ISI)


###################################################
### code chunk number 23: distPlot
###################################################
par(mfrow = c(1,2))
cS <- table(colSums(ISI))
size <- as.numeric(names(cS))
repet <- as.vector(cS)
freq = rep(size, repet)
hist(freq, xlab = "ScISI Protein Complex Cardinality", ylab = "Frequency",
     main = "Complex Cardinality")

rS <- table(rowSums(ISI))
size <- as.numeric(names(rS))
repet <- as.vector(rS)
freq = rep(size, repet)
hist(freq, xlab = "Complex Membership per Protein", ylab = "Frequency",
     main = "Complex Membership")
par(mfrow = c(1,1))


###################################################
### code chunk number 24: testStuff
###################################################
data("redundantM")
data("subCompM")


###################################################
### code chunk number 25: redundant
###################################################
library("xtable")
xtable(redundantM, display = c("s","d","d","d","d","d"), label = "ta:Repetitions", 
caption="Number of repetitive Protein Complexes")



###################################################
### code chunk number 26: subComp
###################################################

xtable(subCompM, display = c("s","d","d","d","d","d"), label = "ta:subComplexes", 
caption = "Number of Protein Sub-Complexes")



###################################################
### code chunk number 27: createDataFrame
###################################################
goDF = createGODataFrame(go, goM)
mipsDesc <- sapply(mips, function(x) {attr(x, "desc")})
mipsDF = createMipsDataFrame(mipsDesc, mipsM)


###################################################
### code chunk number 28: dataFrameOut
###################################################
#head(mipsDF)


###################################################
### code chunk number 29: createYeastDataObj
###################################################
mipsOb = createYeastDataObj(mipsDF)
goOb = createYeastDataObj(goDF)


###################################################
### code chunk number 30: yeastDataMethods
###################################################
ID(mipsOb, "MIPS-510.40")
Desc(mipsOb, "MIPS-510.40")
getURL(mipsOb, "MIPS-510.40")


###################################################
### code chunk number 31: ScISI2html
###################################################
mipsNames = colnames(mipsM)
mipsCompOrder = colSums(mipsM)
url = vector(length = length(mipsNames))
linkNames = vector(length = length(mipsNames))
for(i in 1:length(mipsNames)){
url[i] = getURL(mipsOb, mipsNames[i])
linkNames[i] = Desc(mipsOb, mipsNames[i])
}
ScISI2html(urlVect = url, linkName = linkNames, filename = "mips.html", 
           title = "MIPS Protein Complex", compSize = mipsCompOrder)

goNames = as.character(goDF[,1])
goCompOrder = colSums(goM[,goNames])
url = vector(length = length(goNames))
linkNames = vector(length = length(goNames))
for(i in 1:length(goNames)){
    print(i)
    url[i] = getURL(goOb, goNames[i])
    linkNames[i] = Desc(goOb, goNames[i])
}
ScISI2html(urlVect = url, linkName = linkNames, filename = "go.html", 
           title = "GO Protein Complex", compSize = goCompOrder)


###################################################
### code chunk number 32: unWantedComp
###################################################

#ISI2 = unWantedComp(ISI, unwantedComplex =
#                         c("GO:0000262",
#                           "GO:0000228",
#                           "GO:0000775",
#                           "GO:0010008",
#                           "GO:0005792",
#                           "GO:0005768",
#                           "GO:0005769",
#                           "GO:0005770",
#                           "GO:0005777",
#                           "GO:0005844",
#                           "GO:0001400"))

data(ScISIC)
identical(ISI, ScISIC)



###################################################
### code chunk number 33: checking
###################################################



