# Code example from 'GlobalTest' vignette. See references/ for full tutorial.

### R code from vignette source 'GlobalTest.Rnw'

###################################################
### code chunk number 1: make data
###################################################
set.seed(1)
Y <- rnorm(20)
X <- matrix(rnorm(200), 20, 10)
X[,1:3] <- X[,1:3] + Y
colnames(X) <- LETTERS[1:10]


###################################################
### code chunk number 2: GlobalTest.Rnw:101-102
###################################################
library(globaltest)


###################################################
### code chunk number 3: options
###################################################
gt.options(trace=FALSE, max.print=45)


###################################################
### code chunk number 4: full formula simple
###################################################
gt(Y~1, Y~A+B+C, data = X)


###################################################
### code chunk number 5: full formula
###################################################
gt(Y~D, Y~A+B+C+D, data = X)


###################################################
### code chunk number 6: summary
###################################################
summary(gt(Y~A, Y~A+B+C, data = X))


###################################################
### code chunk number 7: GlobalTest.Rnw:143-148
###################################################
res <- gt(Y~A, Y~A+B+C, data = X)
p.value(res)
z.score(res)
result(res)
size(res)


###################################################
### code chunk number 8: GlobalTest.Rnw:159-160 (eval = FALSE)
###################################################
## gt(Y~A, ~B+C, data = X)


###################################################
### code chunk number 9: GlobalTest.Rnw:165-166
###################################################
gt(Y~A+B+C, data = X)


###################################################
### code chunk number 10: GlobalTest.Rnw:170-171
###################################################
gt(Y~A, ~., data = X)


###################################################
### code chunk number 11: GlobalTest.Rnw:176-177
###################################################
gt(Y, X)


###################################################
### code chunk number 12: null design
###################################################
designA <- cbind(1, X[,"A"])
gt(Y, X, designA)


###################################################
### code chunk number 13: poisson
###################################################
P <- rpois(20, lambda=2)
gt(P~A, ~., data=X, model = "Poisson")
gt(P~A, ~., data=X, model = "linear")


###################################################
### code chunk number 14: survival data
###################################################
time <- rexp(20,1/100)
status <- rbinom(20,1,0.5)
str <- rbinom(20,1,0.5)


###################################################
### code chunk number 15: GlobalTest.Rnw:218-219
###################################################
gt(Surv(time,status), ~A+B+strata(str), ~strata(str), data=X)


###################################################
### code chunk number 16: GlobalTest.Rnw:223-224
###################################################
gt(Surv(time,status), ~A+B, ~strata(str), data=X)


###################################################
### code chunk number 17: GlobalTest.Rnw:233-234
###################################################
status <- status * (rbinom(20,1,0.5) + 1)


###################################################
### code chunk number 18: GlobalTest.Rnw:239-248
###################################################
library(mstate)
survdat <- data.frame(X, "time.01" = time, "time.02" = time,
                      "status.01" = ifelse(status == 1, 1, 0),
                      "status.02" = ifelse(status == 2, 1, 0))
survdat <- msprep(time = c(NA, "time.01","time.02"), 
                  status = c(NA, 'status.01','status.02'),
                  data = survdat, trans = trans.comprisk(2),
                  keep=c("A","B"))
survdat <- expand.covs(survdat, c("A","B"))


###################################################
### code chunk number 19: GlobalTest.Rnw:253-254
###################################################
gt(Surv(time,status), ~A.1+B.1+A.2+B.2, ~strata(trans), data=survdat)


###################################################
### code chunk number 20: permutations
###################################################
gt(Y,X)
gt(Y,X, permutations=1e4)


###################################################
### code chunk number 21: GlobalTest.Rnw:276-277
###################################################
hist(gt(Y,X, permutations=1e4))


###################################################
### code chunk number 22: GlobalTest.Rnw:286-289
###################################################
A <- X[,"A"]
gt(Y,X,A)
gt(Y,X,~A)


###################################################
### code chunk number 23: no intercept
###################################################
gt(Y~0+A, ~ B+C, data = X)


###################################################
### code chunk number 24: alternative intercept
###################################################
IC <- rep(1, 20)
gt(Y~0+A, ~ IC+B+C, data = X)


###################################################
### code chunk number 25: factors
###################################################
set.seed(1234)
YY <- rnorm(6)
FF <- factor(rep(letters[1:2], 3))
GG <- factor(rep(letters[3:5], 2))
model.matrix(gt(YY ~ FF + GG, x = TRUE))$alternative


###################################################
### code chunk number 26: ordinal
###################################################
GG <- ordered(GG)
model.matrix(gt(YY ~ GG, x = TRUE))$alternative


###################################################
### code chunk number 27: alternative contrasts
###################################################
R1 <- matrix(c(0,1,1,0,1,1,0,0,1,0,0,1),6,2,dimnames=list(1:6,c("GGd","GGe")))
R2 <- matrix(c(-1,0,0,-1,0,0,0,0,1,0,0,1),6,2,dimnames=list(1:6,c("GGc","GGe")))
R3 <- matrix(c(-1,0,0,-1,0,0,-1,-1,0,-1,-1,0),6,2,dimnames=list(1:6,c("GGc","GGd")))


###################################################
### code chunk number 28: ordinal gt
###################################################
gt(YY ~ GG)
gt(YY, alternative=R1)


###################################################
### code chunk number 29: ordinal gt no intercept
###################################################
gt(YY, alternative=R1, null=~0)


###################################################
### code chunk number 30: ordinal gt no intercept variant
###################################################
gt(YY ~ GG, null=~0)


###################################################
### code chunk number 31: weights
###################################################
res <- gt(Y, X)
weights(res)


###################################################
### code chunk number 32: GlobalTest.Rnw:366-368
###################################################
res <- gt(Y,X, standardize=TRUE)
weights(res)


###################################################
### code chunk number 33: GlobalTest.Rnw:372-374 (eval = FALSE)
###################################################
## gt(Y, X[,c("A","A","B")], weights=c(.5,.5,1))
## gt(Y, X[,c("A","B")])


###################################################
### code chunk number 34: GlobalTest.Rnw:381-382
###################################################
gt(Y, X, directional = TRUE)


###################################################
### code chunk number 35: GlobalTest.Rnw:393-394
###################################################
gt(Y~A+B+C,data=X, test.value=c(.2,.2,.2))


###################################################
### code chunk number 36: GlobalTest.Rnw:399-401
###################################################
os <- X[,1:3]%*%c(.2,.2,.2)
gt(Y~offset(os), ~A+B+C, data=X)


###################################################
### code chunk number 37: covariates preparation
###################################################
gt(Y~A+B, data=X)
gt(Y~A, data=X)
gt(Y~B, data=X)


###################################################
### code chunk number 38: covariates
###################################################
covariates(gt(Y,X))


###################################################
### code chunk number 39: covariatesW
###################################################
covariates(gt(Y,X), what="w")


###################################################
### code chunk number 40: covariates output
###################################################
res <- covariates(gt(Y,X))
res[1:10]


###################################################
### code chunk number 41: covariates leafNodes
###################################################
leafNodes(res, alpha=0.10)


###################################################
### code chunk number 42: extract
###################################################
extract(res)


###################################################
### code chunk number 43: covariates_zoom
###################################################
covariates(gt(Y,X), zoom=TRUE)


###################################################
### code chunk number 44: GlobalTest.Rnw:490-491
###################################################
subjects(gt(Y,X))


###################################################
### code chunk number 45: GlobalTest.Rnw:498-499
###################################################
subjects(gt(Y,X), what="s", mirror=FALSE)


###################################################
### code chunk number 46: subset
###################################################
set <- LETTERS[1:3]
gt(Y,X, subsets = set)


###################################################
### code chunk number 47: many sets
###################################################
sets <- list(one=LETTERS[1:3], two=LETTERS[4:6])
gt(Y,X, subsets = sets)


###################################################
### code chunk number 48: subsets method
###################################################
res <- gt(Y,X, subsets = sets)
subsets(res)


###################################################
### code chunk number 49: many weights
###################################################
wts <- list(up = 1:10, down = 10:1)
gt(Y,X,weights=wts)


###################################################
### code chunk number 50: single weight many subsets
###################################################
gt(Y,X, subsets=sets, weights=1:10)


###################################################
### code chunk number 51: subsets and weights
###################################################
gt(Y,X, subsets=sets, weights=wts)
gt(Y,X, subsets=sets, weights=list(1:3,7:5))


###################################################
### code chunk number 52: alias
###################################################
res <- gt(Y,X, weights=wts, alias = c("one", "two"))
alias(res)
alias(res) <- c("ONE", "TWO")


###################################################
### code chunk number 53: sort
###################################################
res[1]
sort(res)


###################################################
### code chunk number 54: p.adjust
###################################################
p.adjust(res)
p.adjust(res, "BH")
p.adjust(res, "BY")


###################################################
### code chunk number 55: focuslevel set structure
###################################################
level1 <- as.list(LETTERS[1:10])
names(level1) <- letters[1:10]
level2 <- list(abc = LETTERS[1:3], cde  = LETTERS[3:5],
                     fgh = LETTERS[6:8], hij = LETTERS[8:10])
level3 <- list(all = LETTERS[1:10])
dag <- c(level1, level2, level3)


###################################################
### code chunk number 56: focus level choice
###################################################
fl <- names(level2)
fl <- findFocus(dag, maxsize=8)


###################################################
### code chunk number 57: focus level
###################################################
res <- gt(Y,X)
res <- focusLevel(res, sets = dag, focus=fl)
sort(res)


###################################################
### code chunk number 58: focus level leaf nodes
###################################################
leafNodes(res)


###################################################
### code chunk number 59: draw
###################################################
draw(res, names=TRUE)


###################################################
### code chunk number 60: draw legend (eval = FALSE)
###################################################
## legend <- draw(res)


###################################################
### code chunk number 61: inheritance set structure
###################################################
level1 <- as.list(LETTERS[1:10])
names(level1) <- letters[1:10]
level2 <- list(ab = LETTERS[1:2], cde = LETTERS[3:5], fg = LETTERS[6:7], hij = LETTERS[8:10])
level3 <- list(all = LETTERS[1:10])
tree <- c(level1, level2, level3)


###################################################
### code chunk number 62: inheritance
###################################################
res <- gt(Y,X)
resI <- inheritance(res, tree)
resI


###################################################
### code chunk number 63: inheritance
###################################################
hc <- hclust(dist(t(X)))
resHC <- inheritance(res, hc)
resHC


###################################################
### code chunk number 64: inheritance leaf nodes
###################################################
leafNodes(resI)
leafNodes(resHC)


###################################################
### code chunk number 65: inheritance_draw
###################################################
draw(resHC, names=TRUE)


###################################################
### code chunk number 66: inheritance covariates (eval = FALSE)
###################################################
## covariates(res)


###################################################
### code chunk number 67: transpose option (eval = FALSE)
###################################################
## gt.options(transpose=TRUE)


###################################################
### code chunk number 68: load Golub
###################################################
library(golubEsets)
data(Golub_Train)


###################################################
### code chunk number 69: vsn
###################################################
library(vsn)
exprs(Golub_Train) <- exprs(vsn2(Golub_Train))


###################################################
### code chunk number 70: overall
###################################################
gt(ALL.AML, Golub_Train)


###################################################
### code chunk number 71: Source
###################################################
gt(ALL.AML ~ Source, Golub_Train)


###################################################
### code chunk number 72: transpose option (eval = FALSE)
###################################################
## gt.options(transpose=TRUE)


###################################################
### code chunk number 73: trim option (eval = FALSE)
###################################################
## gt.options(trim=TRUE)


###################################################
### code chunk number 74: gtKEGG
###################################################
gtKEGG(ALL.AML, Golub_Train, id = "04110")


###################################################
### code chunk number 75: KEGG organism package
###################################################
eg <- as.list(hu6800ENTREZID)
gtKEGG(ALL.AML, Golub_Train, id="04110", probe2entrez = eg, annotation="org.Hs.eg.db")


###################################################
### code chunk number 76: gtKEGG multtest
###################################################
gtKEGG(ALL.AML, Golub_Train, id=c("04110","04210"), multtest="BH")


###################################################
### code chunk number 77: testKEGG (eval = FALSE)
###################################################
## gtKEGG(ALL.AML, Golub_Train)


###################################################
### code chunk number 78: gtGO
###################################################
gtGO(ALL.AML, Golub_Train, id="GO:0007049")


###################################################
### code chunk number 79: GO organism package
###################################################
eg <- as.list(hu6800ENTREZID)
gtGO(ALL.AML, Golub_Train, id="GO:0007049", probe2entrez = eg, annotation="org.Hs.eg")


###################################################
### code chunk number 80: testBP (eval = FALSE)
###################################################
## gtGO(ALL.AML, Golub_Train, ontology="BP", minsize = 10, maxsize = 500)


###################################################
### code chunk number 81: gtGO multtest
###################################################
gtGO(ALL.AML, Golub_Train, id=c("GO:0007049","GO:0006915"), multtest="BH")


###################################################
### code chunk number 82: focusGO
###################################################
descendants <- get("GO:0007049", GOBPOFFSPRING)
res <- gtGO(ALL.AML, Golub_Train, id = c("GO:0007049", descendants), multtest = "focus")
leafNodes(res)


###################################################
### code chunk number 83: significantGO1 (eval = FALSE)
###################################################
## draw(res, interactive=TRUE)
## legend <- draw(res)


###################################################
### code chunk number 84: significantGO2
###################################################
draw(res)


###################################################
### code chunk number 85: getBroadSets (eval = FALSE)
###################################################
## broad <- getBroadSets("your/path/to/msigdb_v.2.5.xml")


###################################################
### code chunk number 86: gtBroad (eval = FALSE)
###################################################
## gtBroad(ALL.AML, Golub_Train, id = "chr5q33", collection=broad)


###################################################
### code chunk number 87: Broad organism package (eval = FALSE)
###################################################
## eg <- as.list(hu6800ENTREZID)
## gtBroad(ALL.AML, Golub_Train, id = "chr5q33", collection=broad, probe2entrez = eg, annotation="org.Hs.eg.db")


###################################################
### code chunk number 88: gtBroad multtest (eval = FALSE)
###################################################
## gtBroad(ALL.AML, Golub_Train, id=c("chr5q33","chr5q34"), multtest="BH", collection=broad)


###################################################
### code chunk number 89: Broad c1 (eval = FALSE)
###################################################
## gtBroad(ALL.AML, Golub_Train, category="c1", collection=broad)


###################################################
### code chunk number 90: gtConcept (eval = FALSE)
###################################################
## gtConcept(ALL.AML, Golub_Train, conceptmatrix="Body System.txt")


###################################################
### code chunk number 91: gtConcept organism package (eval = FALSE)
###################################################
## eg <- as.list(hu6800ENTREZID)
## gtConcept(ALL.AML, Golub_Train, conceptmatrix="Body System.txt", probe2entrez = eg, annotation="org.Hs.eg.db")


###################################################
### code chunk number 92: gtConcept multtest (eval = FALSE)
###################################################
## gtConcept(ALL.AML, Golub_Train, conceptmatrix="Body System.txt", multtest="BH")


###################################################
### code chunk number 93: KEGG_covariates
###################################################
res <- gtKEGG(ALL.AML, Golub_Train, id = "04110")
features(res, alias=hu6800SYMBOL)


###################################################
### code chunk number 94: LeafNodes geneplot
###################################################
ft <- features(res, alias=hu6800SYMBOL)
leafNodes(ft)


###################################################
### code chunk number 95: subsets leafNodes (eval = FALSE)
###################################################
## subsets(leafNodes(ft))


###################################################
### code chunk number 96: KEGG_covariates_zoom
###################################################
res <- gtKEGG(ALL.AML, Golub_Train, id = "04110")
features(res, alias=hu6800SYMBOL, zoom=TRUE)


###################################################
### code chunk number 97: extract geneset
###################################################
ft <- features(res, alias=hu6800SYMBOL, plot=FALSE)
extract(ft)


###################################################
### code chunk number 98: pdf covariates (eval = FALSE)
###################################################
## res_all <- gtKEGG(ALL.AML, Golub_Train)
## features(res_all[1:5], pdf="KEGGcov.pdf", alias=hu6800SYMBOL)


###################################################
### code chunk number 99: KEGG_subjects
###################################################
res <- gt(ALL.AML, Golub_Train)
subjects(res)


###################################################
### code chunk number 100: pdf covariates (eval = FALSE)
###################################################
## res_all <- gtKEGG(ALL.AML, Golub_Train)
## subjects(res_all[1:25], pdf="KEGGsubj.pdf")


###################################################
### code chunk number 101: lungExpression
###################################################
library(lungExpression)
data(michigan)
gt(Surv(TIME..months., death==1), michigan)


###################################################
### code chunk number 102: comparative
###################################################
res <- gtKEGG(ALL.AML, Golub_Train, id = "04110")
comparative(res)


###################################################
### code chunk number 103: faults
###################################################
require("boot")
data(cloth)
Z <- matrix(diag(nrow(cloth)), ncol = nrow(cloth), dimnames = list(NULL, 1:nrow(cloth)))
gt(y ~ log(x), alternative = Z, data = cloth, model = "poisson")


###################################################
### code chunk number 104: litters
###################################################
library("survival")
data(rats)
nlitters<-length(unique(rats$litter))
Z<-matrix(NA,dim(rats)[1],nlitters, dimnames=list(NULL,1:nlitters))
for (i in 1:nlitters) Z[,i]<-(rats[,1]==i)*1
gt(Surv(time,status)~rx,alternative=Z,data=rats,model="cox")


###################################################
### code chunk number 105: anscombe
###################################################
data(anscombe)
set.seed(0)
X<-anscombe$x2
Y<-anscombe$y2 + rnorm(length(X),0,3)
gtPS(Y~X)


###################################################
### code chunk number 106: reparamZ
###################################################
Z<-bbase(X,bdeg=3,nint=10)
P<-reparamZ(Z,pord=2)
gt(Y~X,alternative=P)


###################################################
### code chunk number 107: Uspan
###################################################
U<-reparamZ(Z,pord=2, returnU=TRUE)$U
lm(Y~X+U)$coefficients


###################################################
### code chunk number 108: arg pord
###################################################
gtPS(Y~X, pord=list(Z=0,P=2))


###################################################
### code chunk number 109: arg robust
###################################################
rob<-gtPS(Y~X, pord=list(Z=0,P=2), robust=TRUE)
rob@result


###################################################
### code chunk number 110: cbind weights
###################################################
comb<-gt(Y~X, alternative=cbind(Z,P))
comb@result


###################################################
### code chunk number 111: robust weights
###################################################
colrange<-list(Z=1:ncol(Z), P=(ncol(Z)+1):(ncol(Z)+ncol(P)))
sapply(list(combined=comb,robust=rob), function(x){sapply(colrange,
function(y){sum(weights(x)[y])/sum(weights(x))})})


###################################################
### code chunk number 112: kyphosis
###################################################
require("rpart")
data("kyphosis")
fit0<-glm(Kyphosis~., data = kyphosis, family="binomial")
res<-gtPS(fit0)
res@result


###################################################
### code chunk number 113: sterms
###################################################
sterms(res)


###################################################
### code chunk number 114: penalized fit
###################################################
require("penalized")
Z<-gtPS(fit0, returnZ=TRUE)$Z
fit1<-penalized(Kyphosis, penalized=~ Z, unpenalized=~Age+Number+Start, data = kyphosis, model="logistic", lambda2 = 0.086, trace=FALSE)


###################################################
### code chunk number 115: goodness_kyphosis
###################################################
bd=3
ni=10
po=2
covnames<-names(kyphosis)[-1]
d<-bd+ni-po
gammas<-fit1@penalized
betas<-fit1@unpenalized
l<-length(covnames)
cd<-c(0,cumsum(rep(d,l)))
op <- par(mfrow = c(2, 2))
for (i in 1:3){
x<-kyphosis[,covnames[i]]
sx<-sort(x,index.return=T)
ind<-vector("list", l)
ind[[i]]<-(cd[i]+1):(cd[i+1])
plot(sx$x, (Z[sx$ix,ind[[i]]]%*%gammas[ind[[i]]] ), type="b",ylim=c(-1.7,0.7), xlab=covnames[i], ylab=paste("s(",covnames[i],")", sep=""))
lines(abline(h=0,lty="dotted"))
rug(x)
}
par(op)


###################################################
### code chunk number 116: arg covs
###################################################
gtPS(fit0, covs=c("Age","Start"))


###################################################
### code chunk number 117: arg nint
###################################################
gtPS(fit0,covs=c("Age","Number","Start"), nint=list(a=5, b=c(5,1,1)), pord=0)


###################################################
### code chunk number 118: cbind GAM
###################################################
covs=c("Age","Number","Start")
bd=c(3,3,3);ni=c(10,10,10);po=c(2,2,2);cs<-c(0,cumsum(bd+ni-po))
X0<-model.matrix(fit0)[,]
combZ<-do.call(cbind,lapply(1:length(covs),function(x){reparamZ(bbase(kyphosis[,covs[x]], nint=ni[x], bdeg=bd[x]), pord=po[x])}))
comb<-gt(Kyphosis~., alternative=combZ, data = kyphosis, model="logistic")
comb@result


###################################################
### code chunk number 119: cbind weights GAM
###################################################
range<-lapply(1:length(covs),function(x){(cs[x]+1):(cs[x+1])})
names(range)<-covs
sapply(range,function(x){sum(weights(comb)[x])/sum(weights(comb))})


###################################################
### code chunk number 120: reweighZ
###################################################
rwgtZ<-do.call(cbind,lapply(1:length(covs),function(x){reweighZ(reparamZ(bbase(kyphosis[,covs[x]], nint=ni[x], bdeg=bd[x]), pord=po[x]),fit0)}))
rwgt<-gt(Kyphosis~., alternative=rwgtZ, data = kyphosis, model="logistic")
sapply(range,function(x){sum(weights(rwgt)[x])/sum(weights(rwgt))})


###################################################
### code chunk number 121: lake
###################################################
library(gss)
data(LakeAcidity)
fit0<-lm(ph~log10(cal)+lat+lon, data=LakeAcidity)
res<-gtKS(fit0)
res@result
sterms(res)


###################################################
### code chunk number 122: trace
###################################################
gtKS(fit0, quant=seq(.01,.99,.02), data=LakeAcidity, termlabels=TRUE, robust=T)


###################################################
### code chunk number 123: goodness_trace
###################################################
p<-sapply(seq(.01,.99,.02),function(x){gtKS(fit0, termlabels=T,quant=x, data=LakeAcidity)@result[,1]})
plot(seq(.01,.99,.02),p, type="s", xlab="quant", ylab="p-value", ylim=c(0,.5), xlim=c(0,1))
abline(h=gtKS(ph~log10(cal)+lat+lon, quant=seq(.01,.99,.02), data=LakeAcidity, robust=T, termlabels=T)@result[,1], lty="dotted")


###################################################
### code chunk number 124: btensor
###################################################
fit0<-lm(ph~lat*lon, data=LakeAcidity)
res<-gtPS(fit0, covs=c("lat","lon"), interact=TRUE, data=LakeAcidity)
res@result
sterms(res)


###################################################
### code chunk number 125: goodness_lake
###################################################
Z<-gtPS(fit0, returnZ=TRUE, interact=TRUE)$Z
fit1<-penalized(ph, penalized=Z, unpenalized=~lat*lon, data = LakeAcidity, lambda2 = 1, trace=FALSE)
lon<-seq(79,85,length=50)
lat<-seq(33,38,length=50)
new<-data.frame(expand.grid(lon=lon, lat=lat))
Znew<-btensor(new, bdeg=c(3,3), nint=c(10,10), pord=c(2,2))
fitted<-matrix(predict(fit1,unpenalized=~lat*lon, penalized=Znew, data=new)[,1],50,50)
persp(lon,lat,fitted,theta=-25)


###################################################
### code chunk number 126: anova type
###################################################
Z1<-reweighZ(reparamZ(bbase(LakeAcidity$lat, bdeg=3, nint=10), pord=2), fit0)
Z2<-reweighZ(reparamZ(bbase(LakeAcidity$lon, bdeg=3, nint=10), pord=2), fit0)
Z12<-reweighZ(btensor(cbind(LakeAcidity$lat, LakeAcidity$lon),bdeg=c(3,3),nint=c(10,10),pord=c(2,2)), fit0)
gt(ph~lat*lon, alternative=cbind(Z1,Z2,Z12), data=LakeAcidity)


###################################################
### code chunk number 127: varying
###################################################
data(nox)
sE<-bbase(nox$equi, bdeg=3, nint=10)
sEbyC<-model.matrix(~0+sE:factor(comp), data=nox)[,]
gt(nox~equi*factor(comp), alternative=cbind(sE,sEbyC), data=nox)


###################################################
### code chunk number 128: boston
###################################################
library(MASS)
data(Boston)
res<-gtLI(medv~., data=Boston)
res@result
round(weights(res)/sum(weights(res)),4)


###################################################
### code chunk number 129: GlobalTest.Rnw:1327-1329
###################################################
gtLI(medv~., data=Boston, standardize=T)
gtLI(medv~., data=scale(Boston))


