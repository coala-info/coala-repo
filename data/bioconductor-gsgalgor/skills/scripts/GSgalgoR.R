# Code example from 'GSgalgoR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    eval=TRUE,
    warning=FALSE,
    message = FALSE
)

## ----install, eval=FALSE------------------------------------------------------
# 
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("GSgalgoR")
# library(GSgalgoR)

## ----install-github, eval=FALSE-----------------------------------------------
# devtools::install_github("https://github.com/harpomaxx/GSgalgoR")
# library(GSgalgoR)

## ----datasets, eval=FALSE-----------------------------------------------------
# 
# BiocManager::install("breastCancerUPP",version = "devel")
# BiocManager::install("breastCancerTRANSBIG",version = "devel")
# 

## ----load_data, message=FALSE-------------------------------------------------

library(breastCancerTRANSBIG)
library(breastCancerUPP)


## ----libraries, message=FALSE-------------------------------------------------
library(GSgalgoR)
library(Biobase)
library(genefu)
library(survival)
library(survminer)
library(ggplot2)
data(pam50)

## ----load_data2---------------------------------------------------------------
data(upp)
Train<- upp
rm(upp)

data(transbig)
Test<- transbig
rm(transbig)

#To access gene expression data
train_expr<- exprs(Train)
test_expr<- exprs(Test)

#To access feature data
train_features<- fData(Train)
test_features<- fData(Test)

#To access clinical data
train_clinic <- pData(Train) 
test_clinic <- pData(Test) 


## ----drop duplicates----------------------------------------------------------

#Custom function to drop duplicated genes (keep genes with highest variance)

DropDuplicates<- function(eset, map= "Gene.symbol"){

    #Drop NA's
    drop <- which(is.na(fData(eset)[,map]))
    eset <- eset[-drop,]

    #Drop duplicates
    drop <- NULL
    Dup <- as.character(unique(fData(eset)[which(duplicated
            (fData(eset)[,map])),map]))
    Var <- apply(exprs(eset),1,var)
    for(j in Dup){
        pos <- which(fData(eset)[,map]==j)
        drop <- c(drop,pos[-which.max(Var[pos])])
    }

    eset <- eset[-drop,]

    featureNames(eset) <- fData(eset)[,map]
    return(eset)
}


## ----expandprobesets----------------------------------------------------------

# Custom function to expand probesets mapping to multiple genes
expandProbesets <- function (eset, sep = "///", map="Gene.symbol"){
    x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
    y<- lapply(as.character(fData(eset)[,map]), function(x) strsplit(x,sep))
    eset <- eset[order(sapply(x, length)), ]
    x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
    y<- lapply(as.character(fData(eset)[,map]), function(x) strsplit(x,sep))
    idx <- unlist(sapply(1:length(x), function(i) rep(i,length(x[[i]]))))
    idy <- unlist(sapply(1:length(y), function(i) rep(i,length(y[[i]]))))
    xx <- !duplicated(unlist(x))
    idx <- idx[xx]
    idy <- idy[xx]
    x <- unlist(x)[xx]
    y <- unlist(y)[xx]
    eset <- eset[idx, ]
    featureNames(eset) <- x
    fData(eset)[,map] <- x
    fData(eset)$gene <- y
    return(eset)
}


## ----adapted_expression-------------------------------------------------------
Train=DropDuplicates(Train)
Train=expandProbesets(Train)
#Drop NAs in survival
Train <- Train[,!is.na(
    survival::Surv(time=pData(Train)$t.rfs,event=pData(Train)$e.rfs))] 

Test=DropDuplicates(Test)
Test=expandProbesets(Test)
#Drop NAs in survival
Test <- 
    Test[,!is.na(survival::Surv(
        time=pData(Test)$t.rfs,event=pData(Test)$e.rfs))] 

#Determine common probes (Genes)
Int= intersect(rownames(Train),rownames(Test))

Train= Train[Int,]
Test= Test[Int,]

identical(rownames(Train),rownames(Test))


## ----reduced_expr-------------------------------------------------------------

#First we will get PAM50 centroids from genefu package

PAM50Centroids <- pam50$centroids
PAM50Genes <- pam50$centroids.map$probe
PAM50Genes<- featureNames(Train)[ featureNames(Train) %in% PAM50Genes]

#Now we sample 200 random genes from expression matrix

Non_PAM50Genes<- featureNames(Train)[ !featureNames(Train) %in% PAM50Genes]
Non_PAM50Genes <- sample(Non_PAM50Genes,200, replace=FALSE)

reduced_set <- c(PAM50Genes, Non_PAM50Genes)

#Now we get the reduced training and test sets

Train<- Train[reduced_set,]
Test<- Test[reduced_set,]


## ----robust_scaling-----------------------------------------------------------

exprs(Train) <- t(apply(exprs(Train),1,genefu::rescale,na.rm=TRUE,q=0.05))
exprs(Test) <- t(apply(exprs(Test),1,genefu::rescale,na.rm=TRUE,q=0.05))

train_expr <- exprs(Train)
test_expr <- exprs(Test)

## ----Surv---------------------------------------------------------------------
train_clinic <- pData(Train) 
test_clinic <- pData(Test)

train_surv <- survival::Surv(time=train_clinic$t.rfs,event=train_clinic$e.rfs)
test_surv <- survival::Surv(time=test_clinic$t.rfs,event=test_clinic$e.rfs)


## ----parameters, eval=TRUE----------------------------------------------------
# For testing reasons it is set to a low number but ideally should be above 100
population <- 30 
# For testing reasons it is set to a low number but ideally should be above 150
generations <-15
nCV <- 5                      
distancetype <- "pearson"     
TournamentSize <- 2
period <- 3650

## ----galgo_run, eval= TRUE,results='hide'-------------------------------------
set.seed(264)
output <- GSgalgoR::galgo(generations = generations, 
                        population = population, 
                        prob_matrix = train_expr, 
                        OS = train_surv,
                        nCV = nCV, 
                        distancetype = distancetype,
                        TournamentSize = TournamentSize, 
                        period = period)

## -----------------------------------------------------------------------------
print(class(output))

## ----to_list, eval= TRUE------------------------------------------------------
outputList <- to_list(output)
head(names(outputList))

## ----example_1, eval=TRUE-----------------------------------------------------
outputList[["Solution.1"]]

## ----to_dataframe, eval= TRUE-------------------------------------------------
outputDF <- to_dataframe(output)
head(outputDF)

## ----plot_pareto, eval=TRUE---------------------------------------------------
plot_pareto(output)

## ----classify, eval=TRUE------------------------------------------------------
#The reduced UPP dataset will be used as training set 
train_expression <- exprs(Train) 
train_clinic<- pData(Train)
train_features<- fData(Train)
train_surv<- survival::Surv(time=train_clinic$t.rfs,event=train_clinic$e.rfs)

#The reduced TRANSBIG dataset will be used as test set 

test_expression <- exprs(Test) 
test_clinic<- pData(Test)
test_features<- fData(Test)
test_surv<- survival::Surv(time=test_clinic$t.rfs,event=test_clinic$e.rfs)


#PAM50 centroids
centroids<- pam50$centroids
#Extract features from both data.frames
inBoth<- Reduce(intersect, list(rownames(train_expression),rownames(centroids)))

#Classify samples 

PAM50_train<- cluster_classify(train_expression[inBoth,],centroids[inBoth,],
                            method = "spearman")
table(PAM50_train)

PAM50_test<- cluster_classify(test_expression[inBoth,],centroids[inBoth,],
                            method = "spearman")
table(PAM50_test)

# Classify samples using genefu
#annot<- fData(Train)
#colnames(annot)[3]="Gene.Symbol"
#PAM50_train<- molecular.subtyping(sbt.model = "pam50",
#         data = t(train_expression), annot = annot,do.mapping = TRUE)


## ----pam50_surv_UPP, eval=TRUE------------------------------------------------
surv_formula <- 
    as.formula("Surv(train_clinic$t.rfs,train_clinic$e.rfs)~ PAM50_train")
tumortotal1 <- surv_fit(surv_formula,data=train_clinic)
tumortotal1diff <- survdiff(surv_formula)
tumortotal1pval<- pchisq(tumortotal1diff$chisq, length(tumortotal1diff$n) - 1,
                         lower.tail = FALSE) 

p<-ggsurvplot(tumortotal1,
            data=train_clinic,
            risk.table=TRUE,
            pval=TRUE,
            palette="dark2",
            title="UPP breast cancer \n PAM50 subtypes survival",
            surv.scale="percent",
            conf.int=FALSE, 
            xlab="time (days)", 
            ylab="survival(%)", 
            xlim=c(0,3650),
            break.time.by = 365, 
            ggtheme = theme_minimal(), 
            risk.table.y.text.col = TRUE, 
            risk.table.y.text = FALSE,censor=FALSE)
print(p)

## ----pam50_surv_TRANSBIG, eval=TRUE-------------------------------------------
surv_formula <- 
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ PAM50_test")
tumortotal2 <- surv_fit(surv_formula,data=test_clinic)
tumortotal2diff <- survdiff(surv_formula)
tumortotal2pval<- pchisq(tumortotal2diff$chisq, length(tumortotal2diff$n) - 1,
                        lower.tail = FALSE) 

p<-ggsurvplot(tumortotal2,
            data=test_clinic,
            risk.table=TRUE,
            pval=TRUE,
            palette="dark2",
            title="TRANSBIG breast cancer \n PAM50 subtypes survival",
            surv.scale="percent",
            conf.int=FALSE,
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,3650),
            break.time.by = 365,
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,
            censor=FALSE)
print(p)

## ----case_params, eval=TRUE---------------------------------------------------
population <- 15             
generations <-5             
nCV <- 5                      
distancetype <- "pearson"     
TournamentSize <- 2
period <- 3650

## ----galgo_train, results='hide'----------------------------------------------
output= GSgalgoR::galgo(generations = generations,
                    population = population,
                    prob_matrix = train_expression,
                    OS=train_surv,
                    nCV= nCV, 
                    distancetype=distancetype,
                    TournamentSize=TournamentSize,
                    period=period)
print(class(output))

## ----pareto_2,eval=TRUE, out.width='100%'-------------------------------------
plot_pareto(output)

## ----summary_results, eval=TRUE-----------------------------------------------

output_df<- to_dataframe(output)
NonDom_solutions<- output_df[output_df$Rank==1,]

# N of non-dominated solutions 
nrow(NonDom_solutions)

# N of partitions found
table(NonDom_solutions$k)

#Average N of genes per signature
mean(unlist(lapply(NonDom_solutions$Genes,length)))

#SC range
range(NonDom_solutions$SC.Fit)

# Survival fitnesss range
range(NonDom_solutions$Surv.Fit)


## ----best_perform, eval=TRUE--------------------------------------------------

RESULT<- non_dominated_summary(output=output,
                            OS=train_surv, 
                            prob_matrix= train_expression,
                            distancetype =distancetype 
                            )

best_sol=NULL
for(i in unique(RESULT$k)){
    best_sol=c(
    best_sol,
    RESULT[RESULT$k==i,"solution"][which.max(RESULT[RESULT$k==i,"C.Index"])])
}

print(best_sol)

## ----centroid_list------------------------------------------------------------
CentroidsList <- create_centroids(output, 
                                solution_names = best_sol,
                                trainset = train_expression)

## ----class--------------------------------------------------------------------

train_classes<- classify_multiple(prob_matrix=train_expression,
                                centroid_list= CentroidsList, 
                                distancetype = distancetype)

test_classes<- classify_multiple(prob_matrix=test_expression,
                                centroid_list= CentroidsList, 
                                distancetype = distancetype)


## ----pred_model---------------------------------------------------------------

Prediction.models<- list()

for(i in best_sol){

    OS<- train_surv
    predicted_class<- as.factor(train_classes[,i])
    predicted_classdf <- as.data.frame(predicted_class)
    colnames(predicted_classdf)<- i
    surv_formula <- as.formula(paste0("OS~ ",i))
    coxsimple=coxph(surv_formula,data=predicted_classdf)
    Prediction.models[[i]]<- coxsimple
}


## ----cindex-------------------------------------------------------------------

C.indexes<- data.frame(train_CI=rep(NA,length(best_sol)),
                    test_CI=rep(NA,length(best_sol)))
rownames(C.indexes)<- best_sol

for(i in best_sol){
    predicted_class_train<- as.factor(train_classes[,i])
    predicted_class_train_df <- as.data.frame(predicted_class_train)
    colnames(predicted_class_train_df)<- i
    CI_train<- 
        concordance.index(predict(Prediction.models[[i]],
                                predicted_class_train_df),
                                surv.time=train_surv[,1],
                                surv.event=train_surv[,2],
                                outx=FALSE)$c.index
    C.indexes[i,"train_CI"]<- CI_train
    predicted_class_test<- as.factor(test_classes[,i])
    predicted_class_test_df <- as.data.frame(predicted_class_test)
    colnames(predicted_class_test_df)<- i
    CI_test<- 
        concordance.index(predict(Prediction.models[[i]],
                                predicted_class_test_df),
                                surv.time=test_surv[,1],
                                surv.event=test_surv[,2],
                                outx=FALSE)$c.index
    C.indexes[i,"test_CI"]<- CI_test
    }

print(C.indexes)

best_signature<- best_sol[which.max(C.indexes$test_CI)]

print(best_signature)

## ----galgo_train_surv, eval=TRUE, out.width='100%'----------------------------

train_class <- train_classes[,best_signature]

surv_formula <- 
    as.formula("Surv(train_clinic$t.rfs,train_clinic$e.rfs)~ train_class")
tumortotal1 <- surv_fit(surv_formula,data=train_clinic)
tumortotal1diff <- survdiff(surv_formula)
tumortotal1pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal1diff$n) - 1,
                        lower.tail = FALSE) 

p<-ggsurvplot(tumortotal1,
            data=train_clinic,
            risk.table=TRUE,pval=TRUE,palette="dark2",
            title="UPP breast cancer \n Galgo subtypes survival",
            surv.scale="percent",
            conf.int=FALSE, xlab="time (days)", 
            ylab="survival(%)", xlim=c(0,3650),
            break.time.by = 365,
            ggtheme = theme_minimal(), 
            risk.table.y.text.col = TRUE, 
            risk.table.y.text = FALSE,censor=FALSE)
print(p)


## ----galgo_test_surv, eval=TRUE, out.width='100%'-----------------------------

test_class <- test_classes[,best_signature]

surv_formula <- 
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ test_class")
tumortotal1 <- surv_fit(surv_formula,data=test_clinic)
tumortotal1diff <- survdiff(surv_formula)
tumortotal1pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal1diff$n) - 1,
                        lower.tail = FALSE) 

p<-ggsurvplot(tumortotal1,
            data=test_clinic,
            risk.table=TRUE,
            pval=TRUE,palette="dark2",
            title="TRANSBIG breast cancer \n Galgo subtypes survival",
            surv.scale="percent",
            conf.int=FALSE, 
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,3650),
            break.time.by = 365, 
            ggtheme = theme_minimal(), 
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,
            censor=FALSE)
print(p)

## ----test_pam50, eval=TRUE, out.width='100%'----------------------------------

surv_formula1 <- 
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ test_class")
tumortotal1 <- surv_fit(surv_formula1,data=test_clinic)
tumortotal1diff <- survdiff(surv_formula1)
tumortotal1pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal1diff$n) - 1,
                        lower.tail = FALSE) 

surv_formula2 <- 
    as.formula("Surv(test_clinic$t.rfs,test_clinic$e.rfs)~ PAM50_test")
tumortotal2 <- surv_fit(surv_formula2,data=test_clinic)
tumortotal2diff <- survdiff(surv_formula2)
tumortotal2pval<- pchisq(tumortotal1diff$chisq,
                        length(tumortotal2diff$n) - 1,
                        lower.tail = FALSE) 

SURV=list(GALGO=tumortotal1,PAM50=tumortotal2 )
COLS=c(1:8,10)
par(cex=1.35, mar=c(3.8, 3.8, 2.5, 2.5) + 0.1)
p=ggsurvplot(SURV,
            combine=TRUE,
            data=test_clinic,
            risk.table=TRUE,
            pval=TRUE,
            palette="dark2",
            title="Galgo vs. PAM50 subtypes \n BRCA survival comparison",
            surv.scale="percent",
            conf.int=FALSE,
            xlab="time (days)",
            ylab="survival(%)",
            xlim=c(0,period),
            break.time.by = 365, 
            ggtheme = theme_minimal(),
            risk.table.y.text.col = TRUE,
            risk.table.y.text = FALSE,
            censor=FALSE)
print(p)


## ----sess_info, eval=TRUE-----------------------------------------------------
sessionInfo()

