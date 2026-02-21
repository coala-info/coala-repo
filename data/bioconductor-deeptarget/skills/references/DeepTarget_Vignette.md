# Workflow Demonstration for Deep characterization of cancer drugs

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Part I: Core Analysis](#part-i-core-analysis)
  + [2.1 Data Loading and Preparation](#data-loading-and-preparation)
  + [2.2 Computing Similarity Between Drug Treatment and Gene Knockout](#computing-similarity-between-drug-treatment-and-gene-knockout)
  + [2.3 Predicting Similarity Across Known Targeted Genes and All Genes](#predicting-similarity-across-known-targeted-genes-and-all-genes)
  + [2.4 Computing the Interaction](#computing-the-interaction)
  + [2.5 Interaction Assessment](#interaction-assessment)
  + [2.6 Preparation for Output](#preparation-for-output)
  + [2.7 In addition to the output of prediction object, we also identify drugs with low primary target expressing cell lines](#in-addition-to-the-output-of-prediction-object-we-also-identify-drugs-with-low-primary-target-expressing-cell-lines)
  + [2.8 Calculating Drug KO Similarities in cell lines with low primary target](#calculating-drug-ko-similarities-in-cell-lines-with-low-primary-target)
* [3 Part II: Application](#part-ii-application)
  + [3.1 Finding and visualizing a drug primary target](#finding-and-visualizing-a-drug-primary-target)
  + [3.2 Predicting whether the drug specifically targets the wild-type or mutated target forms](#predicting-whether-the-drug-specifically-targets-the-wild-type-or-mutated-target-forms)
  + [3.3 Predicting secondary target(s) that mediate its response when the primary target is not expressed](#predicting-secondary-targets-that-mediate-its-response-when-the-primary-target-is-not-expressed)
* [4 Part III: Conclusion](#part-iii-conclusion)
* [5 Session info](#session-info)

# 1 Introduction

This vignette will guide users how to integrate large-scale genetic and
drug screens to do association analysis and use this information to both
predict the drug’s primary target(s) or secondary target and investigate
whether the primary target specifically targets the wild-type or mutated
target forms. This will be done by three parts: Core Analysis, and
application, and conclusion. The result from core analysis will be used for the
application part. We also give an example for interpreting the result in
the conclusion part.

# 2 Part I: Core Analysis

The core analysis includes loading the necessary data, performing the
core analysis, and saving the results. Specifically, for a given drug,
the core analysis includes generating a similarity score between the
viability after drug treatment and each gene knockout,and computing if
the drug may differential bind to the known drug target mutant form or
WT form, by calculating this similarity in cell lines with known target
WT vs. mutant form, and finally, finding the secondary targets of the
drug by repeating this analysis in the cell lines where the primary
target is not expressed.

Below is the step-by-step scripts for this Core analysis part:

## 2.1 Data Loading and Preparation

Users can use the Depmap2DeepTarget function to obtain the data needed.
Please note that you are required to agree to the terms and conditions of
DepMap portal (<https://depmap.org/portal/>). Some of these terms and conditions
are problematic for U.S. Federal Government employees, and they should consult their technology transfer office/legal office before agreeing to such terms and conditions.
Here, the script loads OntargetM object and prepare the matrices for the drug response scores (secondary\_prism ) and CRISPR Gene Effect scores. We will use these two matrices to obtain the correlation information. This OntargetM object only contains a small subset of data across common cell lines for demonstration purpose.

secondary\_prism: row names is the drug ID and column names are cell
lines. The values are the response scores.
avana\_CRISPR: row names are the gene’s names and column are cell lines. The values are the effect scores of KO method.

```
library(DeepTarget)
data("OntargetM")
## "Below is the OnTargetM object containing a subset of public data downloading from depmap.org"
vapply(OntargetM,dim,FUN.VALUE = numeric(2))
#>      DrugMetadata secondary_prism avana_CRISPR mutations_mat expression_20Q4
#> [1,]           11              16          487           476             550
#> [2,]            5             392          392           392             392
## drug of interest.
drug.name <- c('atiprimod','AMG-232','pitavastatin','Ro-4987655','alexidine','RGFP966','dabrafenib','olaparib','CGM097','ibrutinib','palbociclib')
## data preparation for these drugs
## the secondary prism contain the response scores, where columns are cell lines and row names for Broad IDs of the drug.
## First, Obtain the broad ID for these interesting drug.
Broad.IDs <- OntargetM$DrugMetadata$broad_id_trimmed[which(OntargetM$DrugMetadata$name %in% drug.name)]
## the drug response has duplicated assays so we have 16 rows returned for 11 drugs.
sec.prism.f <- OntargetM$secondary_prism[which ( row.names(OntargetM$secondary_prism) %in% Broad.IDs), ]
KO.GES <- OntargetM$avana_CRISPR
```

## 2.2 Computing Similarity Between Drug Treatment and Gene Knockout

The script computes the similarity Between Drug Treatment and Gene
Knockout using computeCor function. We assign the correlation values as
similarity scores.

Input: Drug Response Scores (DRS) and Knock-out Gene Expression Scores
from CRIPSR method ( KO.GES). Output: a list of ID drugs where each drug
contains a matrix of their correlation, p val, and FDR values.

```
List.sim <- NULL;
for (i in 1:nrow(sec.prism.f)){
    DRS <- as.data.frame(sec.prism.f[i,])
    DRS <- t(DRS)
    row.names(DRS) <- row.names(sec.prism.f)[i]
    out <- computeCor(row.names(sec.prism.f)[i],DRS,KO.GES)
    List.sim [[length(List.sim) + 1]] <- out
}
names(List.sim) <- row.names(sec.prism.f)
```

## 2.3 Predicting Similarity Across Known Targeted Genes and All Genes

The script predicts similarity Across Known Targeted Genes and All Genes
using PredTarget and PredMaxSim functions.
Input: List.sim: the list of similarity scores obtained above.
meta data: drug information.
Output:
PredTarget(): a data frame contain the drug name and the max similarity
scores among their targeted proteins. For example, if there are two
proteins targeted for the same drug, the one has higher correlation will
be likely the most targeted for that drug.
PredMaxSim (): a data frame
contain the drug name and the protein with the max similarity scores
across all genes. For example, within a drug, the protein A with the
highest similarity score will be assigned as best target for that drug.

```
metadata <- OntargetM$DrugMetadata
DrugTarcomputeCor <- PredTarget(List.sim,metadata)
DrugGeneMaxSim <- PredMaxSim(List.sim,metadata)
```

## 2.4 Computing the Interaction

The script computes the interaction between the drug and knockout (KO)
gene expression in terms of both mutant vs non-mutant and lower vs
higher expression using DoInteractExp function and DoInteractMutant
function.
Input: Mutation matrix, expression matrix, drug response scores.
Mutation matrix: row names are gene names and column names are
cell lines. The values are mutant or non mutant (0 and 1)
Expression matrix: row names are gene names and column names are cell lines.
The values are gene expression.
Drug response scores: The output from PredTarget(). We only focus on
learning more about the interaction of these drugs with their best targets.
output:
DoInteractMutant(): a data frame contains the
drug name and their strength from linear model function from drug
response and gene expression scores in term of mutant/non-mutant group.

DoInteractExp(): a data frame contains the drug name and their strength
from linear model function from drug response and gene expression scores
in term of expression group based on cut-off values from expression values.

```
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
```

## 2.5 Interaction Assessment

This part of the script assesses whether the interaction result is true
or false based on a certain cut-off, and the p-value from the above
part.

```
Whether_interaction_Ex_based= ifelse( out.LowexpTarget$MaxTgt_Inter_Exp_strength <0
& out.LowexpTarget$MaxTgt_Inter_Exp_Pval <0.2,TRUE,FALSE)
predicted_resistance_mut= ifelse(
out.MutantTarget$MaxTgt_Inter_Mut_Pval<0.1,TRUE,FALSE)
```

## 2.6 Preparation for Output

Lastly, the script gathers the results into a final data frame and
writes it to a CSV file to be used for the application part.

```
Pred.d <- NULL;
Pred.d <- cbind(DrugTarcomputeCor,DrugGeneMaxSim,out.MutantTarget,predicted_resistance_mut)
mutant.C <- vapply(Pred.d[,3],function(x)tryCatch(sum(d.mt[x,] ==1),error=function(e){NA}),FUN.VALUE = length(Pred.d[,3]))
Pred.d$mutant.C <- mutant.C
Low.Exp.C = vapply(Pred.d[,3],
function(x)tryCatch(sum(d.expr[x,] < 2),error=function(e){NA}),FUN.VALUE = length(Pred.d[,3]))
Pred.d <- cbind(Pred.d, out.LowexpTarget, Whether_interaction_Ex_based,Low.Exp.C)
```

## 2.7 In addition to the output of prediction object, we also identify drugs with low primary target expressing cell lines

For the drugs where the primary target is not expressed in at least five
cell lines, we will identify their secondary target below. This section
identifies primary target genes that are not expressed in at least 5
cell lines.

```
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
#> [1] TRUE
```

## 2.8 Calculating Drug KO Similarities in cell lines with low primary target

The following script performs calculations to determine DKS score in
cell lines with low primary target expression. This DKS score is called
Secondary DKS Score and denotes the secondary target probability.

```
for (i in 1:nrow(Pred.d.f)){
    DRS.L= sec.prism.f.f[i,Low.Exp.G[[unlist(Pred.d.f[i,3])]]]
    DRS.L <- t(as.data.frame(DRS.L))
    row.names(DRS.L) <- Pred.d.f[i,1]
    out <- computeCor(Pred.d.f[i,1],DRS.L,KO.GES)
    sim.LowExp [[length(sim.LowExp) + 1]] <- out
}
names(sim.LowExp) <- Pred.d.f[,1]
```

# 3 Part II: Application

For this section, we will use the information obtained above.
First, we find a drug’s primary target(s) and visualize them.
Next, we predict whether the drug specifically targets the wild-type or
mutated target forms. We then predict the secondary target(s) that
mediate its response when the primary target is not expressed. For more
detail, please refer to the paper from this link:
<https://www.biorxiv.org/content/10.1101/2022.10.17.512424v1>

## 3.1 Finding and visualizing a drug primary target

The script below generates the correlation plots for primary targets BRAF
and MDM2 for the drugs Dabrafenib and AMG-232 respectively.

```
## This drug is unique in this Prediction data object.
DOI = 'AMG-232'
GOI = 'MDM2'
plotCor(DOI,GOI,Pred.d,sec.prism.f,KO.GES,plot=TRUE)
```

![](data:image/png;base64...)

```
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
#> [1] TRUE
## because the Pred.d and sec.prism.f have the same orders so we
plotCor(DOI,GOI,Pred.d[5,],DRS,KO.GES,plot=TRUE)
```

![](data:image/png;base64...)

```
## Interpretation: The graph shows that there is a positive significant
## correlation of BRAF with drug dabrafenib. (Correlation value(R): 0.58 and P val < 0.01)
```

## 3.2 Predicting whether the drug specifically targets the wild-type or mutated target forms

The script below shows whether the drugs, CGM097 and Dabrafenib, target
the wild-type or mutated target forms of MDM2 and BRAF respectively from
the Prediction object and then generates plots for visualization.

```
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
#> ACH-000461 ACH-000528 ACH-000792 ACH-000570 ACH-000769
#>  1.4119483         NA         NA  1.2725917  0.9051468
out <- DMB(DOI,GOI,Pred.d.f.f[3,],d.mt,DRS,KO.GES,plot=TRUE)
print (out)
```

![](data:image/png;base64...)

```
## Interpretation: The graph shows CGM097 is likely targeting both the mutant
## form (R=0.81, P val <0.01) and the wild type form (R=0.49, P >0.01) of
## the MDM2 gene.
## For dabrafenib, both assays suggest that BRAF is mutated target forms, we will choose one for visualization.
DOI ="dabrafenib"
GOI = "BRAF"
# because this has two assays in the drug response score matrix, we will visualize one of them.
# first check identity.
identical ( Pred.d.f$DrugID, row.names(sec.prism.f))
#> [1] TRUE
## we will choose the row 5.
DRS <- as.data.frame(sec.prism.f[5,])
DRS <- t(DRS)
row.names(DRS) <- row.names(sec.prism.f)[5]
out <- DMB(DOI,GOI,Pred.d.f[5,],d.mt,DRS,KO.GES,plot=TRUE)
print (out)
```

![](data:image/png;base64...)

```
## Interpretation: The graph shows dabrafenib is likely targeting the mutant
## form (R=0.66, P val <0.01) rather than the wild type form (R=-0.1, P >0.01)
## of BRAF gene.
```

## 3.3 Predicting secondary target(s) that mediate its response when the primary target is not expressed

As an example, let’s look at the drug ‘ibrutinib’ from the Prediction
object. Ibrutinib is a well-known covalent target of BTK. Please note
that for this drug, there are two assays. We selected only one of them for
this example.

```
## This drug has two assays.
# The index is 14 in the order of the interesting drugs.
identical (Pred.d$DrugID, row.names(sec.prism.f))
#> [1] TRUE
DRS <- as.data.frame(sec.prism.f[14,])
DRS <- t(DRS)
row.names(DRS) <- row.names(sec.prism.f)[14]
####
DOI="ibrutinib"
GOI="BTK"
out <- DTR (DOI,GOI,Pred.d[14,],d.expr,DRS,KO.GES,CutOff= 2)
print(out)
```

![](data:image/png;base64...)

We find above that Ibrutinib’s response is only correlated with the BTK
gene in cell lines where BTK is expressed and not in cell lines where
BTK is not expressed. Next, let’s look at the correlation between the
BTK gene KO and this drug response in no BTK cell lines to predict the
secondary targets for this drug.

```
sim.LowExp.Strength=vapply(sim.LowExp, function(x) x[,2],FUN.VALUE = numeric(nrow(sim.LowExp[[1]])))
dim(sim.LowExp.Strength)
#> [1] 487   8
sim.LowExp.Pval=vapply(sim.LowExp, function(x) x[,1], FUN.VALUE = numeric(nrow(sim.LowExp[[1]])))
head(sim.LowExp.Pval)
#>        K09951645 K09951645 K38527262 K38527262  K51313569   K51313569
#> ABL2   0.5203398 0.6532451 0.4546755 0.6748665 0.70309015 0.784197282
#> ACAT2  0.6228084 0.2572060 0.4111495 0.7786084 0.08316226 0.310792296
#> ACCSL  0.0314582 0.2940887 0.7352730 0.1760980 0.02018384 0.140217499
#> ACTA1  0.9826104 0.0947502 0.7332240 0.1568970 0.33076606 0.002059387
#> ACTC1  0.2011062 0.9738262 0.5093903 0.3664459 0.46104791 0.117628092
#> ADAM21 0.9809521 0.2507671 0.5503414 0.6394241 0.61500343 0.168134195
#>          K70301465  K70301465
#> ABL2   0.001592559 0.04049965
#> ACAT2  0.788591872 0.54284370
#> ACCSL  0.188292668 0.08214740
#> ACTA1  0.572693296 0.09773104
#> ACTC1  0.762020918 0.76487976
#> ADAM21 0.469027451 0.26970046
## Let's take a look at ibrutinib
par(mar=c(4,4,5,2), xpd=TRUE, mfrow=c(1,2));
plotSim(sim.LowExp.Pval[,8],sim.LowExp.Strength[,8],colorRampPalette(c("lightblue",'darkblue')),plot=TRUE)
```

![](data:image/png;base64...)

# 4 Part III: Conclusion

We observe below that Ibrutinib response is strongly correlated with
EGFR knockout (KO) in cell lines where Bruton tyrosine kinase (BTK) is
not expressed. However, this correlation is not observed in cell lines
where BTK is expressed. Among the top predicted genes, there are more
layers of evidence that Ibrutinib binds physically to EGFR. Thus, let’s
focus further on EGFR.

```
DOI="ibrutinib"
GOI="EGFR"
out <- DTR (DOI,GOI,Pred.d[14,],d.expr,DRS,KO.GES,CutOff= 2)
print (out)
```

![](data:image/png;base64...)

# 5 Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] DeepTarget_1.4.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3            pROC_1.19.0.1        httr2_1.2.1
#>   [4] rlang_1.1.6          magrittr_2.0.4       compiler_4.5.1
#>   [7] RSQLite_2.4.3        mgcv_1.9-3           png_0.1-8
#>  [10] vctrs_0.6.5          stringr_1.5.2        pkgconfig_2.0.3
#>  [13] crayon_1.5.3         fastmap_1.2.0        magick_2.9.0
#>  [16] backports_1.5.0      dbplyr_2.5.1         XVector_0.50.0
#>  [19] labeling_0.4.3       rmarkdown_2.30       tzdb_0.5.0
#>  [22] tinytex_0.57         depmap_1.23.0        purrr_1.1.0
#>  [25] bit_4.6.0            xfun_0.53            cachem_1.1.0
#>  [28] jsonlite_2.0.0       blob_1.2.4           BiocParallel_1.44.0
#>  [31] broom_1.0.10         parallel_4.5.1       R6_2.6.1
#>  [34] bslib_0.9.0          stringi_1.8.7        RColorBrewer_1.1-3
#>  [37] car_3.1-3            jquerylib_0.1.4      Rcpp_1.1.0
#>  [40] Seqinfo_1.0.0        bookdown_0.45        knitr_1.50
#>  [43] readr_2.1.5          IRanges_2.44.0       Matrix_1.7-4
#>  [46] splines_4.5.1        tidyselect_1.2.1     dichromat_2.0-0.1
#>  [49] abind_1.4-8          yaml_2.3.10          codetools_0.2-20
#>  [52] curl_7.0.0           lattice_0.22-7       tibble_3.3.0
#>  [55] Biobase_2.70.0       withr_3.0.2          KEGGREST_1.50.0
#>  [58] S7_0.2.0             evaluate_1.0.5       BiocFileCache_3.0.0
#>  [61] ExperimentHub_3.0.0  Biostrings_2.78.0    pillar_1.11.1
#>  [64] BiocManager_1.30.26  ggpubr_0.6.2         filelock_1.0.3
#>  [67] carData_3.0-5        stats4_4.5.1         generics_0.1.4
#>  [70] BiocVersion_3.22.0   S4Vectors_0.48.0     hms_1.1.4
#>  [73] ggplot2_4.0.0        scales_1.4.0         glue_1.8.0
#>  [76] tools_4.5.1          AnnotationHub_4.0.0  data.table_1.17.8
#>  [79] fgsea_1.36.0         ggsignif_0.6.4       fastmatch_1.1-6
#>  [82] cowplot_1.2.0        grid_4.5.1           tidyr_1.3.1
#>  [85] AnnotationDbi_1.72.0 nlme_3.1-168         Formula_1.2-5
#>  [88] cli_3.6.5            rappdirs_0.3.3       dplyr_1.1.4
#>  [91] gtable_0.3.6         rstatix_0.7.3        sass_0.4.10
#>  [94] digest_0.6.37        BiocGenerics_0.56.0  farver_2.1.2
#>  [97] memoise_2.0.1        htmltools_0.5.8.1    lifecycle_1.0.4
#> [100] httr_1.4.7           bit64_4.6.0-1
```