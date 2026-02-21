# Code example from 'DeepTarget_Vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    warning = FALSE,
    message = FALSE,
    cache = TRUE
)

## ----Data Loading and Preparation---------------------------------------------

library(DeepTarget)
data("OntargetM")
## "Below is the OnTargetM object containing a subset of public data downloading from depmap.org"
vapply(OntargetM,dim,FUN.VALUE = numeric(2))
## drug of interest.
drug.name <- c('atiprimod','AMG-232','pitavastatin','Ro-4987655','alexidine','RGFP966','dabrafenib','olaparib','CGM097','ibrutinib','palbociclib')
## data preparation for these drugs
## the secondary prism contain the response scores, where columns are cell lines and row names for Broad IDs of the drug.
## First, Obtain the broad ID for these interesting drug.
Broad.IDs <- OntargetM$DrugMetadata$broad_id_trimmed[which(OntargetM$DrugMetadata$name %in% drug.name)]
## the drug response has duplicated assays so we have 16 rows returned for 11 drugs.
sec.prism.f <- OntargetM$secondary_prism[which ( row.names(OntargetM$secondary_prism) %in% Broad.IDs), ]
KO.GES <- OntargetM$avana_CRISPR


## ----Computing a correlation between the every gene crispr KO vs each drug response for all interesting drugs----
List.sim <- NULL;
for (i in 1:nrow(sec.prism.f)){
    DRS <- as.data.frame(sec.prism.f[i,])
    DRS <- t(DRS)
    row.names(DRS) <- row.names(sec.prism.f)[i]
    out <- computeCor(row.names(sec.prism.f)[i],DRS,KO.GES)
    List.sim [[length(List.sim) + 1]] <- out
}
names(List.sim) <- row.names(sec.prism.f)


## ----section.cap="Predicting Similarity Across Known Targeted Genes and All Genes"----
metadata <- OntargetM$DrugMetadata
DrugTarcomputeCor <- PredTarget(List.sim,metadata)
DrugGeneMaxSim <- PredMaxSim(List.sim,metadata)


## ----section.cap="Computing the Interaction"----------------------------------
d.mt <- OntargetM$mutations_mat
d.expr <- OntargetM$expression_20Q4
out.MutantTarget <- NULL;
out.LowexpTarget <- NULL;
for (i in 1:nrow(sec.prism.f)){
    DRS=as.data.frame(sec.prism.f[i,])
    DRS <- t(DRS)
    row.names(DRS) <- row.names(sec.prism.f)[i]
    ## for mutant
    Out.M <- DoInteractMutant(DrugTarcomputeCor[i,],d.mt,DRS,KO.GES)
    TargetMutSpecificity <- data.frame(MaxTgt_Inter_Mut_strength=vapply(Out.M, function(x)  x[1],numeric(1)), MaxTgt_Inter_Mut_Pval=vapply(Out.M, function(x) x[2],numeric(1)))
    out.MutantTarget <- rbind(out.MutantTarget,TargetMutSpecificity)
    ## for expression.
    Out.Expr <- DoInteractExp(DrugTarcomputeCor[i,],d.expr,DRS,KO.GES,CutOff= 2)
    TargetExpSpecificity <- data.frame(
    MaxTgt_Inter_Exp_strength <- vapply(Out.Expr, function(x) x[1],numeric(1)),
    MaxTgt_Inter_Exp_Pval <- vapply(Out.Expr, function(x) x[2],numeric(1)))
    out.LowexpTarget <- rbind (out.LowexpTarget,TargetExpSpecificity)
}


## ----Interaction Assessment---------------------------------------------------
Whether_interaction_Ex_based= ifelse( out.LowexpTarget$MaxTgt_Inter_Exp_strength <0
& out.LowexpTarget$MaxTgt_Inter_Exp_Pval <0.2,TRUE,FALSE)
predicted_resistance_mut= ifelse(
out.MutantTarget$MaxTgt_Inter_Mut_Pval<0.1,TRUE,FALSE)


## ----Preparation for Output---------------------------------------------------
Pred.d <- NULL;
Pred.d <- cbind(DrugTarcomputeCor,DrugGeneMaxSim,out.MutantTarget,predicted_resistance_mut)
mutant.C <- vapply(Pred.d[,3],function(x)tryCatch(sum(d.mt[x,] ==1),error=function(e){NA}),FUN.VALUE = length(Pred.d[,3]))
Pred.d$mutant.C <- mutant.C
Low.Exp.C = vapply(Pred.d[,3],
function(x)tryCatch(sum(d.expr[x,] < 2),error=function(e){NA}),FUN.VALUE = length(Pred.d[,3]))
Pred.d <- cbind(Pred.d, out.LowexpTarget, Whether_interaction_Ex_based,Low.Exp.C)


## ----Identifying Drugs with low primary target expressing cell lines----------
Low.i <- which(Pred.d$Low.Exp.C >5)
Pred.d.f <- Pred.d[ Low.i,]
Low.Exp.G <- NULL;
for (i in 1:nrow(Pred.d.f)){
    Gene.i <- Pred.d.f[,3][i]
    Temp <- tryCatch(names(which(d.expr[Gene.i,]<2)),error=function(e){NA})
    Low.Exp.G [[length(Low.Exp.G) + 1]] <- Temp
}
names(Low.Exp.G) <- Pred.d.f[,3]
sim.LowExp <- NULL;
sec.prism.f.f <- sec.prism.f[Low.i,]
identical (row.names(sec.prism.f.f) ,Pred.d.f[,1])


## ----Calculating Drug KO Similarities in cell lines with low primary target----
for (i in 1:nrow(Pred.d.f)){
    DRS.L= sec.prism.f.f[i,Low.Exp.G[[unlist(Pred.d.f[i,3])]]]
    DRS.L <- t(as.data.frame(DRS.L))
    row.names(DRS.L) <- Pred.d.f[i,1]
    out <- computeCor(Pred.d.f[i,1],DRS.L,KO.GES)
    sim.LowExp [[length(sim.LowExp) + 1]] <- out
}
names(sim.LowExp) <- Pred.d.f[,1]


## ----Finding a primary target-------------------------------------------------
## This drug is unique in this Prediction data object.
DOI = 'AMG-232'
GOI = 'MDM2'
plotCor(DOI,GOI,Pred.d,sec.prism.f,KO.GES,plot=TRUE)
## Interpretation: The graph shows that there is a positive significant 
## correlation of MDM2 with drug AMG-232 (Correlation value: 0.54 
## and P val < 0.01)
DOI = 'dabrafenib'
GOI = 'BRAF'
## this drug has duplicated assay; which is row 4 and 5 in both Pred.d object and drug treatment.
## Here, let's look at the row 5 obtain the drug response for 'dabrafenib'
DRS <- as.data.frame(sec.prism.f[5,])
DRS <- t(DRS)
## set the rownames with the Broad ID of the DOI
row.names(DRS) <- row.names(sec.prism.f)[5]
identical ( Pred.d$DrugID, row.names(sec.prism.f))
## because the Pred.d and sec.prism.f have the same orders so we
plotCor(DOI,GOI,Pred.d[5,],DRS,KO.GES,plot=TRUE)
## Interpretation: The graph shows that there is a positive significant 
## correlation of BRAF with drug dabrafenib. (Correlation value(R): 0.58 and P val < 0.01)

## ----Predicting whether the drug specifically targets the wild-type or mutated target forms----
## preparing the data for mutation from Pred.d dataframe.
Pred.d.f <- Pred.d[,c(1:3,12:15)]
## only look at the mutated target forms.
Pred.d.f.f <- Pred.d.f[which (Pred.d.f$predicted_resistance_mut==TRUE), ]
## Let's start with CGM097, unique assay in row 3
DOI=Pred.d.f.f$drugName[3]
GOI=Pred.d.f.f$MaxTargetName[3]
DrugID <- Pred.d.f.f$DrugID[3]
DRS=as.data.frame(sec.prism.f[DrugID,])
DRS <- t(DRS)
row.names(DRS) <- DrugID
# let's take a look at the initial 5 outcomes pertaining to the first drug.
DRS[1,1:5]
out <- DMB(DOI,GOI,Pred.d.f.f[3,],d.mt,DRS,KO.GES,plot=TRUE)
print (out)
## Interpretation: The graph shows CGM097 is likely targeting both the mutant 
## form (R=0.81, P val <0.01) and the wild type form (R=0.49, P >0.01) of 
## the MDM2 gene.
## For dabrafenib, both assays suggest that BRAF is mutated target forms, we will choose one for visualization.
DOI ="dabrafenib"
GOI = "BRAF"
# because this has two assays in the drug response score matrix, we will visualize one of them.
# first check identity.
identical ( Pred.d.f$DrugID, row.names(sec.prism.f))
## we will choose the row 5.
DRS <- as.data.frame(sec.prism.f[5,])
DRS <- t(DRS)
row.names(DRS) <- row.names(sec.prism.f)[5]
out <- DMB(DOI,GOI,Pred.d.f[5,],d.mt,DRS,KO.GES,plot=TRUE)
print (out)
## Interpretation: The graph shows dabrafenib is likely targeting the mutant 
## form (R=0.66, P val <0.01) rather than the wild type form (R=-0.1, P >0.01) 
## of BRAF gene.


## ----Predicting secondary target----------------------------------------------
## This drug has two assays.
# The index is 14 in the order of the interesting drugs.
identical (Pred.d$DrugID, row.names(sec.prism.f))
DRS <- as.data.frame(sec.prism.f[14,])
DRS <- t(DRS)
row.names(DRS) <- row.names(sec.prism.f)[14]
####
DOI="ibrutinib"
GOI="BTK"
out <- DTR (DOI,GOI,Pred.d[14,],d.expr,DRS,KO.GES,CutOff= 2)
print(out)


## ----Predicting secondary target(s) that mediate its response when the primary target is not expressed----

sim.LowExp.Strength=vapply(sim.LowExp, function(x) x[,2],FUN.VALUE = numeric(nrow(sim.LowExp[[1]])))
dim(sim.LowExp.Strength)
sim.LowExp.Pval=vapply(sim.LowExp, function(x) x[,1], FUN.VALUE = numeric(nrow(sim.LowExp[[1]])))
head(sim.LowExp.Pval)
## Let's take a look at ibrutinib
par(mar=c(4,4,5,2), xpd=TRUE, mfrow=c(1,2));
plotSim(sim.LowExp.Pval[,8],sim.LowExp.Strength[,8],colorRampPalette(c("lightblue",'darkblue')),plot=TRUE)


## ----Conclusion---------------------------------------------------------------
DOI="ibrutinib"
GOI="EGFR"
out <- DTR (DOI,GOI,Pred.d[14,],d.expr,DRS,KO.GES,CutOff= 2)
print (out)


## ----session------------------------------------------------------------------
sessionInfo()

