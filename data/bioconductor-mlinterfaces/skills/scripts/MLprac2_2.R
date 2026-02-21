# Code example from 'MLprac2_2' vignette. See references/ for full tutorial.

## ----intro1-------------------------------------------------------------------
library("MASS") 
data("crabs") 
dim(crabs)
crabs[1:4,] 
table(crabs$sex)

## ----figbwplot, echo=FALSE, fig.cap="\\label{fig:figbwplot} Boxplots of RW, the rear width in mm, stratified by species('B' or 'O' for blue or orange) and sex ('F' and 'M')."----
library("lattice")
print(bwplot(RW~sp|sex, data=crabs))

## ----dop----------------------------------------------------------------------
m1 = glm(sp~RW, data=crabs, family=binomial)
summary(m1)

## ----domo, results='hide', fig.show="hide"------------------------------------
plot(predict(m1,type="response"), crabs$sp,)
table(predict(m1,type="response")>.5, crabs$sp)
m2 = update(m1, subset=(sex=="F"))
table(predict(m2,type="response")>.5, crabs$sp[crabs$sex=="F"])

## ----doml1, message=FALSE-----------------------------------------------------
library(MLInterfaces)
fcrabs = crabs[crabs$sex == "F", ] 
ml1 = MLearn( sp~RW, fcrabs,glmI.logistic(thresh=.5), c(1:30, 51:80), family=binomial) 
ml1
confuMat(ml1)

## ----doscra-------------------------------------------------------------------
set.seed(123) 
sfcrabs = fcrabs[ sample(nrow(fcrabs)), ]

## ----domods-------------------------------------------------------------------
sml1 = MLearn( sp~RW, sfcrabs, glmI.logistic(thresh=.5),c(1:30, 51:80),family=binomial)
confuMat(sml1)
smx1 = MLearn( sp~RW, sfcrabs, glmI.logistic(thresh=.5),xvalSpec("LOG", 5, function(data, clab, iternum) {which(rep(1:5, each=20) == iternum) }), family=binomial)
confuMat(smx1)

## ----figdopa,fig=TRUE,width=7,height=7, fig.cap="\\label{fig:figdopa}Pairs plot of the 5 quantitative features of the crabs data.Points are colored by species."----
pairs(crabs[,-c(1:3)], col=ifelse(crabs$sp=="B", "blue", "orange"))

## ----dopc, fig.cap="\\label{fig:figdopa}Pairs plot of the crabs data in principal component coordinates"----
pc1 = prcomp( crabs[,-c(1:3)] )
pairs(pc1$x, col=ifelse(crabs$sp=="B", "blue", "orange"))

## ----figdobi,fig=TRUE, fig.cap="\\label{fig:figdopa} Biplot of the principal component analysis of the crabs data."----
biplot(pc1, choices=2:3, col=c("#80808080", "red"))

## ----checkClaim,echo=FALSE----------------------------------------------------
stopifnot(eval(formals(heatmap)$scale)[1]=="row")

## ----figdohm,fig=TRUE,height=6.5,width=6.5, fig.cap="\\label{fig:figdopa}Heatmap plot of the crabs data, including dendrograms representing hierarchical clustering of the rows and columns."----
X = data.matrix(crabs[,-c(1:3)])
heatmap(t(X), ColSideColors=ifelse(crabs$sp=="O", "orange", "blue"), col =
colorRampPalette(c("blue", "white", "red"))(255)) 

## ----docl---------------------------------------------------------------------
cl = hclust(dist(X)) 
tr = cutree(cl,2)
table(tr)

## ----dos,fig=TRUE-------------------------------------------------------------
library(cluster) 
sil = silhouette( tr, dist(X) )
plot(sil) 

## ----newes--------------------------------------------------------------------
feat2 = t(data.matrix(crabs[, -c(1:3)])) 
pd2 =new("AnnotatedDataFrame", crabs[,1:2]) 
crES = new("ExpressionSet",exprs=feat2, phenoData=pd2)
crES$spsex = paste(crES$sp,crES$sex, sep=":")
table(crES$spsex)

## ----doper--------------------------------------------------------------------
set.seed(1234) 
crES = crES[ , sample(1:200, size=200, replace=FALSE)]

## ----dotr, message=FALSE------------------------------------------------------
library(rpart)
tr1 = MLearn(spsex~., crES, rpartI, 1:140)
tr1
confuMat(tr1) 

## ----doplTree,fig=TRUE--------------------------------------------------------
plot(RObject(tr1))
text(RObject(tr1)) 

## ----doccp,fig=TRUE-----------------------------------------------------------
plotcp(RObject(tr1)) 

## ----dorf, message=FALSE------------------------------------------------------
set.seed(124) 
library(randomForest)
crES$spsex = factor(crES$spsex) # needed 3/2020 as fails with 'do regression?' error 
rf1 = MLearn(spsex~., crES, randomForestI, 1:140 )
rf1
cm = confuMat(rf1)
cm 

## ----dold, message=FALSE------------------------------------------------------
ld1 = MLearn(spsex~., crES, ldaI, 1:140 ) 
ld1
confuMat(ld1)
xvld = MLearn( spsex~., crES, ldaI, xvalSpec("LOG", 5,balKfold.xvspec(5)))
confuMat(xvld)

## ----message=FALSE------------------------------------------------------------
nn1 = MLearn(spsex~., crES, nnetI, 1:140, size=3, decay=.1)
nn1 
RObject(nn1) 
confuMat(nn1)

## ----doxx, message=FALSE------------------------------------------------------
xvnnBAD = MLearn( spsex~., crES, nnetI, xvalSpec("LOG", 5, function(data, clab,iternum) which( rep(1:5,each=40) == iternum ) ), size=3,decay=.1 )
xvnnGOOD = MLearn( spsex~., crES, nnetI, xvalSpec("LOG", 5,balKfold.xvspec(5) ), size=3, decay=.1 )

## ----lktann-------------------------------------------------------------------
confuMat(xvnnBAD)
confuMat(xvnnGOOD)

## ----dnn, message=FALSE-------------------------------------------------------
sv1 = MLearn(spsex~., crES, svmI, 1:140) 
sv1 
RObject(sv1)
confuMat(sv1) 

## ----doxxs, message=FALSE-----------------------------------------------------
xvsv = MLearn( spsex~., crES,svmI, xvalSpec("LOG", 5, balKfold.xvspec(5)))

## ----lktasv-------------------------------------------------------------------
confuMat(xvsv) 

## ----setupALL,cache=TRUE------------------------------------------------------
library("ALL")
data("ALL") 
bALL = ALL[, substr(ALL$BT,1,1) == "B"]
fus = bALL[, bALL$mol.biol %in% c("BCR/ABL", "NEG")]
fus$mol.biol = factor(fus$mol.biol)
fus 

## ----getq---------------------------------------------------------------------
mads = apply(exprs(fus),1,mad) 
fusk = fus[ mads > sort(mads,decr=TRUE)[300], ] 
fcol =ifelse(fusk$mol.biol=="NEG", "green", "red")

## ----dohALL,fig=TRUE----------------------------------------------------------
heatmap(exprs(fusk), ColSideColors=fcol)

## ----dopcALL------------------------------------------------------------------
PCg = prcomp(t(exprs(fusk)))

## ----lkscre,fig=TRUE----------------------------------------------------------
plot(PCg)

## ----lkprALL,fig=TRUE---------------------------------------------------------
pairs(PCg$x[,1:5],col=fcol,pch=19)

## ----dobiALL,fig=TRUE---------------------------------------------------------
biplot(PCg) 

## ----dld1,cache=TRUE, message=FALSE-------------------------------------------
dld1 = MLearn( mol.biol~., fusk, dldaI, 1:40 )

## ----dld2---------------------------------------------------------------------
dld1 
confuMat(dld1) 

## ----dld3,cache=TRUE----------------------------------------------------------
nnALL = MLearn( mol.biol~., fusk, nnetI, 1:40, size=5, decay=.01, MaxNWts=2000 )

## ----dld4---------------------------------------------------------------------
confuMat(nnALL)

## ----dld5,cache=TRUE----------------------------------------------------------
rfALL = MLearn(
mol.biol~., fusk, randomForestI, 1:40 ) 

## ----dld6---------------------------------------------------------------------
rfALL
confuMat(rfALL)

## ----getko, message=FALSE-----------------------------------------------------
library(keggorthology) 
data(KOgraph) 
adj(KOgraph,nodes(KOgraph)[1])
EIP = getKOprobes("Environmental Information Processing")
GIP = getKOprobes("Genetic Information Processing")
length(intersect(EIP, GIP)) 
EIPi = setdiff(EIP, GIP) 
GIP = setdiff(GIP, EIP) 
EIP = EIPi
Efusk = fusk[ featureNames(fusk)  %in% EIP, ]
Gfusk = fusk[ featureNames(fusk)  %in% EIP, ]

## ----dofs, message=FALSE------------------------------------------------------
dldFS = MLearn( mol.biol~., fusk, dldaI, xvalSpec("LOG", 5, balKfold.xvspec(5), fs.absT(30) ))
dldFS 
confuMat(dld1)
confuMat(dldFS) 

## ----lksess-------------------------------------------------------------------
sessionInfo() 

