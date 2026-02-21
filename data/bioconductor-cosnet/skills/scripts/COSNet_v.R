# Code example from 'COSNet_v' vignette. See references/ for full tutorial.

### R code from vignette source 'COSNet_v.Rnw'

###################################################
### code chunk number 1: a1
###################################################
library(COSNet);
library(bionetdata)
data(Yeast.STRING.data)
dim(Yeast.STRING.data)
rownames(Yeast.STRING.data)[1:10]


###################################################
### code chunk number 2: a2
###################################################
data(Yeast.STRING.FunCat)
dim(Yeast.STRING.FunCat)
rownames(Yeast.STRING.FunCat)[1:10]
colnames(Yeast.STRING.FunCat)[1:10]


###################################################
### code chunk number 3: a3
###################################################
## excluding the dummy "00" root
to.be.excl <- which(colnames(Yeast.STRING.FunCat) == "00")
Yeast.STRING.FunCat <- Yeast.STRING.FunCat[, -to.be.excl]
## choosing the first 35 classes
labeling <- Yeast.STRING.FunCat[, 1:35] 
## number of positive labels
colSums(labeling)       
Yeast.STRING.FunCat[Yeast.STRING.FunCat == 0] <- -1


###################################################
### code chunk number 4: a4
###################################################
out <- cosnet.cross.validation(labeling, Yeast.STRING.data, 5, cost=0)


###################################################
### code chunk number 5: a5
###################################################
out.r <- cosnet.cross.validation(labeling, Yeast.STRING.data, 5, cost=0.0001)


###################################################
### code chunk number 6: a6
###################################################
predictions <- out$predictions
scores <- out$scores;
labels <- out$labels;
predictions.r <- out.r$predictions
scores.r <- out.r$scores;
labels.r <- out.r$labels;


###################################################
### code chunk number 7: a7
###################################################
library(PerfMeas);
## computing F-score 
Fs <- F.measure.single.over.classes(labels, predictions);
## Average F-score 
Fs$average[4]
Fs.r <- F.measure.single.over.classes(labels.r, predictions.r);
# Average F-score for the regularized version of COSNet
Fs.r$average[4]
## Computing AUC
labels[labels <= 0] <- 0;
labels.r[labels.r <= 0] <- 0;
auc <- AUC.single.over.classes(labels, scores);
## AUC averaged across classes
auc$average
auc.r <- AUC.single.over.classes(labels.r, scores.r);
## AUC averaged across classes for the regularized version of COSNet
auc.r$average
## Computing precision at different recall levels
PXR <- precision.at.multiple.recall.level.over.classes(labels, 
scores, seq(from=0.1, to=1, by=0.1));
## average PxR
PXR$avgPXR
PXR.r <- precision.at.multiple.recall.level.over.classes(labels.r, 
        scores.r, seq(from=0.1, to=1, by=0.1));
## average PxR for the regularized version of COSNet
PXR.r$avgPXR


###################################################
### code chunk number 8: a8
###################################################
## reading similarity network W
W <- 
as.matrix(read.table(file=paste(sep="", "http://frasca.di.unimi.it/",
 "cosnetdata/u.sum.fly.txt"), sep=" "))
## reading GO annotations
GO.ann.sel <- 
as.matrix(read.table(file=paste(sep="", "http://frasca.di.unimi.it/",
"cosnetdata/GO.ann.fly.15.5.13.3_300.txt"), sep = " ",))
GO.classes <- colnames(GO.ann.sel)
## changing "." to ":"
GO.classes <- unlist(lapply(GO.classes, function(x){
                substr(x, 3, 3) <- ":"; return(x)}))
colnames(GO.ann.sel) <- GO.classes;      


###################################################
### code chunk number 9: a9
###################################################
n<-nrow(W);
## selecting some classes to be predicted
classes <- c("GO:0009605", "GO:0022414", "GO:0032504",
            "GO:0002376", "GO:0009888", "GO:0065003");
labels <- GO.ann.sel[, classes]
## for COSNet negative labels must be -1
labels[labels <= 0] <- -1;
## Determining a random partition for the class GO:0009605 in 3 folds
##    ensuring that each fold has a similar proportion of positives 
folds <- find.division.strat(labels[, 1], 1:n, 3)
## hiding the labels of the test set (the fold of index 1)
labels[folds[[1]], ] <- 0;
## predicting the hidden labels for each class with COSNet
res <- apply(labels, 2, function(x, W, cost){
        return(COSNet(W, x, cost))},
        W = W, cost = 0.0001);


###################################################
### code chunk number 10: a10
###################################################
library(PerfMeas);
## last predicted term
term.ind <- 6;
scores <- res[[term.ind]]$scores;
test.genes <- names(scores);
test.labels <- as.vector(GO.ann.sel[test.genes, term.ind]);
pos.labels <- sum(test.labels > 0)
pos.labels
alpha <- res[[term.ind]]$alpha
gamma <- res[[term.ind]]$c
alpha
gamma
AUC <- AUC.single(scores, test.labels)
AUC
P10R <- precision.at.recall.level(scores, test.labels,
rec.level = 0.1)
P10R


###################################################
### code chunk number 11: a11
###################################################
library(bionetdata);
## similarity matrix DD.chem.data
data(DD.chem.data); 
## label matrix DrugBank.Cat
data(DrugBank.Cat); 


###################################################
### code chunk number 12: a12
###################################################
n <- nrow(DD.chem.data);
drugs <- rownames(DD.chem.data);
drug.category <- c("Cephalosporins");
labels <- as.vector(DrugBank.Cat[, drug.category]);
names(labels) <- rownames(DrugBank.Cat);
## Determining a random partition in 5 folds ensuring that each 
##    fold has a similar proportion of positives
folds <- find.division.strat(labels, 1:n, 5)
labels[labels <= 0] <- -1;
## hiding the test labels (the fold of index 1)
test.drugs <- folds[[1]];
training.drugs <- setdiff(1:n, test.drugs);
labels[test.drugs] <- 0;


###################################################
### code chunk number 13: a13
###################################################
points <- generate_points(DD.chem.data, test.drugs, labels);
str(points)
opt_parameters <- optimizep(points$pos_vect[training.drugs],
                points$neg_vect[training.drugs], labels[training.drugs]);


###################################################
### code chunk number 14: a14
###################################################
## alpha parameter
alpha <- opt_parameters$alpha;
## gamma parameter
gamma <- opt_parameters$c;
## optimal F-score achieved during learning phase 
    ## procedure (see Frasca et al. 2013)
Fscore <- opt_parameters$Fscore;
res <- runSubnet(DD.chem.data, labels, alpha, gamma, cost=0.035);


###################################################
### code chunk number 15: a15
###################################################
library(PerfMeas)
str(res)
res$iter
labels <- as.vector(DrugBank.Cat[, drug.category]);
names(labels) <- rownames(DrugBank.Cat);
test.names <- names(res$scores);
AUC <- AUC.single(res$scores, labels[test.names]);
AUC;
P10R <- precision.at.recall.level(res$scores, 
        labels[test.names], rec.level=0.1);
P10R;
Fs <- F.measure.single(res$state, labels[test.names]);
Fs


###################################################
### code chunk number 16: a16
###################################################
library(bionetdata);
data(DD.chem.data); 
data(DrugBank.Cat); 
labels <- DrugBank.Cat;
labels[labels <= 0] <- -1;
out <- cosnet.cross.validation(labels, DD.chem.data,
        5, cost=0.035);
Fs <- F.measure.single.over.classes(labels, out$predictions);
Fs$average[4];
labels[labels <= 0] <- 0;
auc <- AUC.single.over.classes(labels, out$scores);
auc$average
PXR <- precision.at.multiple.recall.level.over.classes(labels,
        out$scores, seq(from=0.1, to=1, by=0.1));
PXR$avgPXR


