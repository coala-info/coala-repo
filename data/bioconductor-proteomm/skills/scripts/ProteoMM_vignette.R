# Code example from 'ProteoMM_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library('ProteoMM')
set.seed(135)

## ----eval=FALSE---------------------------------------------------------------
# source("https://bioconductor.org/biocLite.R")
# biocLite("ProteoMM")
# library(ProteoMM)

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("YuliyaLab/ProteoMM")
# library(ProteoMM)

## ----fig.cap="Numbers of missing values in each of the Human samples."--------
# Load data for human, then mouse 
data("hs_peptides") # loads variable hs_peptides
dim(hs_peptides)  # 695 x 13   
intsCols = 8:13   # column indices that contain intensities
m_logInts = make_intencities(hs_peptides, intsCols)  

# replace 0's with NA's, NA's are more appropriate for analysis & log2 transform
m_logInts = convert_log2(m_logInts) 
metaCols = 1:7 # column indices for metadata such as protein IDs and sequences
m_prot.info = make_meta(hs_peptides, metaCols)

# m_prot.info - 2+ column data frame with peptide IDs and protein IDs
head(m_prot.info) 
dim(m_logInts) # 695 x 6
grps = as.factor(c('CG','CG','CG', 'mCG','mCG','mCG')) # 3 samples for CG & mCG

# check the number of missing values
m_nummiss = sum(is.na(m_logInts)) 
m_nummiss
m_numtot = dim(m_logInts)[1] * dim(m_logInts)[2] #  total # of observations
m_percmiss = m_nummiss/m_numtot  # % missing observations
m_percmiss # 38.29% missing values, representative of the true larger dataset
# plot number of missing values for each sample
par(mfcol=c(1,1))
barplot(colSums(is.na(m_logInts)), 
        main="Numbers of missing values in Human samples (group order)")

## ----results = FALSE, fig.cap="Eigentrends for raw and residual peptide intensities in Human samples. Dots at positions 1-6 correspond to the 6 samples. The top trend in the raw data (left panel) shows a pattern representative of the differences between the two groups. Top trend in the Residual Data (right panel) shows that sample 2 and 5 have higher similarity to each other, as well as, 1, 3, 4 and 6 whereas in reality samples 1-3 are from the same treatment group and 3-6 are from the other."----
hs_m_ints_eig1 = eig_norm1(m=m_logInts,treatment=grps,prot.info=m_prot.info)

## -----------------------------------------------------------------------------
names(hs_m_ints_eig1)

## -----------------------------------------------------------------------------
hs_m_ints_eig1$h.c

## ----results = FALSE, fig.cap="Eigetrends for raw and normalized peptide intensities in Human samples. Dots at positions 1-6 correspond to the 6 samples. Top trend in the normalized data (right panel) shows a pattern representative of the differences between the two groups (eigen trends can be rotated around the x-axis)."----
hs_m_ints_norm_1bt = eig_norm2(rv=hs_m_ints_eig1) 

## -----------------------------------------------------------------------------
names(hs_m_ints_eig1)
# how many peptides with no missing values (complete) are in the data? 
dim(hs_m_ints_eig1$complete)# bias trend identification is based on 196 peptides

## -----------------------------------------------------------------------------
hs_m_ints_eig1$h.c = 2 # visually there are more than 1 bias trend, set to 2

## ----results = FALSE, fig.cap="Eigetrends for raw and normalized peptide intensities in Human samples with the effects of two bias trends removed. Dots at positions 1-6 correspond to the 6 samples. Top trend in the Normalized Data (Figure 4, right panel) shows a pattern representative of the differences between the two groups (eigen trends can be rotated around x-axis)."----
hs_m_ints_norm = eig_norm2(rv=hs_m_ints_eig1)  

## ----results='asis', echo=FALSE-----------------------------------------------
cat("\\newpage")

## ----fig.cap="Numbers of missing values in each of the Human samples. mCG treatment group has more missing values."----
data("mm_peptides") # loads variable mm_peptides
dim(mm_peptides)

dim(mm_peptides) # 1102 x 13  
head(mm_peptides) 

intsCols = 8:13 # may differ for each dataset, users need to adjust  
m_logInts = make_intencities(mm_peptides, intsCols)  # reuse the name m_logInts
m_logInts = convert_log2(m_logInts) 
metaCols = 1:7 
m_prot.info = make_meta(mm_peptides, metaCols)

head(m_prot.info) 
dim(m_logInts)# 1102 x 6

# check numbers of missing values in Mouse samples
m_nummiss = sum(is.na(m_logInts)) 
m_nummiss
m_numtot = dim(m_logInts)[1] * dim(m_logInts)[2] #  total observations
m_percmiss = m_nummiss/m_numtot  # % missing observations
m_percmiss # 40.8% missing values, representative of the true larger dataset
# plot number of missing values for each sample
par(mfcol=c(1,1))
barplot(colSums(is.na(m_logInts)), 
        main="Numbers of missing values in Mouse samples (group order)")

## ----results = FALSE, fig.cap="Eigentrends for raw and residual peptide intensities in mouse samples. Dots at positions 1-6 correspond to the 6 samples. The top trend in the normalized data (right panel) shows a pattern representative of the differences between the two groups (eigen trends can be rotated around x-axis)."----
mm_m_ints_eig1 = eig_norm1(m=m_logInts,treatment=grps,prot.info=m_prot.info)

## -----------------------------------------------------------------------------
mm_m_ints_eig1$h.c 

## ----results = FALSE, fig.cap="Eigentrends for raw and normalized peptide intensities in mouse samples with the effects of one bias trends removed. Dots at positions 1-6 correspond to the 6 samples. The top trend in the normalized data (Figure 7, right panel) shows a pattern representative of the differences between the two groups."----
mm_m_ints_norm_1bt = eig_norm2(rv=mm_m_ints_eig1) 

## -----------------------------------------------------------------------------
mm_m_ints_eig1$h.c = 2

## ----results = FALSE, fig.cap="Eigentrends for raw and normalized peptide intensities in mouse samples with the effects of two bias trends removed. Dots at positions 1-6 correspond to the 6 samples. Top trend in the Normalized Data (right panel) shows a pattern representative of the differences between the two groups."----
mm_m_ints_norm = eig_norm2(rv=mm_m_ints_eig1)  
# 190 petides with no missing values were used to id bais trends ($complete)

## -----------------------------------------------------------------------------
length(mm_m_ints_eig1$prot.info$MatchedID)          # 1102 - correct
length(hs_m_ints_eig1$prot.info$MatchedID)          # 695 - can normalize all
length(unique(mm_m_ints_eig1$prot.info$MatchedID) ) # 69
length(unique(hs_m_ints_eig1$prot.info$MatchedID) ) # 69

# 787 peptides were normalized, rest eliminated due to low # of observations
dim(mm_m_ints_norm$norm_m) 
dim(hs_m_ints_norm$norm_m) # 480 peptides were normalized

## ----results='asis', echo=FALSE-----------------------------------------------
cat("\\newpage")

## -----------------------------------------------------------------------------
hs_prot.info = hs_m_ints_norm$normalized[,metaCols]
hs_norm_m =  hs_m_ints_norm$normalized[,intsCols]
head(hs_prot.info)
head(hs_norm_m)
dim(hs_norm_m) # 480 x 6, raw: 695, 215 peptides were eliminated due to lack of 
               # observations
length(unique(hs_prot.info$MatchedID)) # 59
length(unique(hs_prot.info$ProtID))    # 59

## ----warning=FALSE, message=FALSE, results = FALSE----------------------------
imp_hs = MBimpute(hs_norm_m, grps, prot.info=hs_prot.info, pr_ppos=3, 
                  my.pi=0.05, compute_pi=FALSE) # use default pi
# historically pi=.05 has been representative of the % missing 
# observations missing completely at random

## ----fig.cap="All peptides within protein Prot32 in raw, normalized, and imputed form."----
# check some numbers after the imputation
length(unique(imp_hs$imp_prot.info$MatchedID)) # 59 - MatchedID IDs
length(unique(imp_hs$imp_prot.info$ProtID))    # 59 - Protein IDs
length(unique(imp_hs$imp_prot.info$GeneID))    # 59 

dim(imp_hs$imp_prot.info) # 480 x 7 imputed peptides
dim(imp_hs$y_imputed)     # 480 x 6 


# plot one of the protiens to check normalization and imputation visually
mylabs = c( 'CG','CG','CG', 'mCG','mCG','mCG') # same as grps this is a string
prot_to_plot = 'Prot32' # 43
gene_to_plot = 'Gene32'  
plot_3_pep_trends_NOfile(as.matrix(hs_m_ints_eig1$m), hs_m_ints_eig1$prot.info, 
                         as.matrix(hs_norm_m), hs_prot.info, imp_hs$y_imputed,
                         imp_hs$imp_prot.info, prot_to_plot, 3, gene_to_plot, 
                         4, mylabs)
                          

## -----------------------------------------------------------------------------
mm_prot.info = mm_m_ints_norm$normalized[,1:7]
mm_norm_m =  mm_m_ints_norm$normalized[,8:13]
head(mm_prot.info)
head(mm_norm_m)
dim(mm_norm_m) # 787 x 6, raw had: 1102 peptides/rows

length(unique(mm_prot.info$MatchedID)) # 56 
length(unique(mm_prot.info$ProtID))    # 56

## ----warning=FALSE, results = FALSE-------------------------------------------
set.seed(12131) # set random number generator seed for reproducibility, 
# otherwise will get various imputed values for repeated attempts
# as for Human, impute based on ProtID - position in the matrix for the Protein Identifier 
imp_mm = MBimpute(mm_norm_m, grps, prot.info=mm_prot.info, pr_ppos=3, 
                  my.pi=0.05, compute_pi=FALSE) 
                  # pi =.05 is usually a good estimate

## -----------------------------------------------------------------------------
dim(imp_mm$imp_prot.info) # 787 x 7 - imputed peptides & 787 were normalized
dim(imp_mm$y_imputed)     # 787 x 6

## ----results='asis', echo=FALSE-----------------------------------------------
cat("\\newpage")

## -----------------------------------------------------------------------------
# make parallel lists to pass as parameters  
mms = list()
treats = list()
protinfos = list()
mms[[1]] = imp_mm$y_imputed
mms[[2]] = imp_hs$y_imputed 
treats[[1]] = grps
treats[[2]] = grps
 
protinfos[[1]] = imp_mm$imp_prot.info 
protinfos[[2]] = imp_hs$imp_prot.info

subset_data = subset_proteins(mm_list=mms, prot.info=protinfos, 'MatchedID')
names(subset_data)

mm_dd_only = subset_data$sub_unique_prot.info[[1]]
hs_dd_only = subset_data$sub_unique_prot.info[[2]] 

ugene_mm_dd = unique(mm_dd_only$MatchedID) 
ugene_hs_dd = unique(hs_dd_only$MatchedID)
length(ugene_mm_dd) # 24 - in Mouse only
length(ugene_hs_dd) # 27 - Human only

nsets = length(mms)
nperm = 50   # number of permutations should be 500+ for publication quality

## ----warning=FALSE, results = FALSE-------------------------------------------
ptm = proc.time()
set.seed=(12357)
comb_MBDE = prot_level_multi_part(mm_list=mms, treat=treats,prot.info=protinfos, 
                                  prot_col_name='ProtID', nperm=nperm, 
                                  dataset_suffix=c('MM', 'HS'))
proc.time() - ptm  # shows how long it takes to run the test

## ----fig.cap="P-value distributions for unadjusted and adjusted p-values. Adjusted p-values (top right) look as expected according to the theory with a peak near 0 and an approximately uniform distribution throughout the interval [0 1]. Benjamini-Hochberg adjusted p-values (bottom left) do not look according to the theoretical distribution, thus Benjamini-Hochberg adjusted may not be appropriate."----
mybreaks = seq(0,1, by=.05)
# adjustment for permutation test is done by stretching out values on the 
# interval [0 1]  as expected in a theoretical p-value distribution
par(mfcol=c(1,3)) # always check out p-values
# bunched up on interval [0 .5]
hist(comb_MBDE$P_val, breaks=mybreaks, xlab='unadjusted p-values', main='') 
# adjusted p-values look good
hist(comb_MBDE$BH_P_val, breaks=mybreaks, xlab='adjusted p-values', main='') 
# bunched up on interval [0 .5]
hist(p.adjust(comb_MBDE$P_val, method='BH'), breaks=mybreaks, 
     xlab='BH adjusted p-values', main='') 


## ----fig.cap="Distribution of p-values and fold changes for combined multi-matrix analysis of Mouse and Human."----
# horizontal streaks correspond to where a permutation test produces 0 or 
# very small value, these are reset to improve visualization
par(mfcol=c(1,1)) # Volcano generally look better for larger dataset... 
plot_volcano_wLab(comb_MBDE$FC, comb_MBDE$BH_P_val, comb_MBDE$GeneID, 
                  FC_cutoff=1.2, PV_cutoff=.05, 'CG vs mCG')  

## ----warning=FALSE, fig.cap="Distribution of p-values and fold changes for differential expression analysis in Mouse."----
# subset_data contains "sub_unique_mm_list"  "sub_unique_prot.info" lists 
# for each dataset in the order provided to subset function
mms_mm_dd = subset_data$sub_unique_mm_list[[1]] # Mouse
dim(mms_mm_dd)  # 258 x 6, 
protinfos_mm_dd = subset_data$sub_unique_prot.info[[1]] 

length(unique(protinfos_mm_dd$ProtID))    # 24
length(unique(protinfos_mm_dd$GeneID))    # 24
length(unique(protinfos_mm_dd$MatchedID)) # 24

DE_mCG_CG_mm_dd = peptideLevel_DE(mms_mm_dd, grps, prot.info=protinfos_mm_dd, 
                                  pr_ppos=2) 

# volcano plot
FCval = 1.2 # change this value for alternative fold change cutoff
plot_volcano_wLab(DE_mCG_CG_mm_dd$FC, DE_mCG_CG_mm_dd$BH_P_val, 
                  DE_mCG_CG_mm_dd$GeneID, FC_cutoff=FCval, 
                  PV_cutoff=.05, 'Mouse specific - CG vs mCG') 

## ----results='asis', echo=FALSE-----------------------------------------------
cat("\\newpage")

## -----------------------------------------------------------------------------
# make data structures suitable for get_presAbs_prots() function
raw_list = list()
norm_imp_prot.info_list = list()
raw_list[[1]] = mm_m_ints_eig1$m
raw_list[[2]] = hs_m_ints_eig1$m
norm_imp_prot.info_list[[1]] = mm_m_ints_eig1$prot.info
norm_imp_prot.info_list[[2]] = hs_m_ints_eig1$prot.info

protnames_norm_list = list()
protnames_norm_list[[1]] = unique(mm_m_ints_norm$normalized$MatchedID) #56/69 
protnames_norm_list[[2]] = unique(hs_m_ints_norm$normalized$MatchedID) #59 

presAbs_dd = get_presAbs_prots(mm_list=raw_list, 
                               prot.info=norm_imp_prot.info_list, 
                               protnames_norm=protnames_norm_list, 
                               prot_col_name=2)
ints_presAbs = list()
protmeta_presAbs = list()
ints_presAbs[[1]] = presAbs_dd[[1]][[1]] # Mouse
ints_presAbs[[2]] = presAbs_dd[[1]][[2]] # HS
protmeta_presAbs[[1]] = presAbs_dd[[2]][[1]] 
protmeta_presAbs[[2]] = presAbs_dd[[2]][[2]]

dim(protmeta_presAbs[[2]]) # 32 x 7 peptides
length(unique(protmeta_presAbs[[2]]$MatchedID))  # 10 - proteins 
dim(protmeta_presAbs[[1]]) # 30 x 7 peptides
length(unique(protmeta_presAbs[[1]]$MatchedID))  # 13 - proteins 

 # grps are the same for all analyses
subset_presAbs = subset_proteins(mm_list=ints_presAbs,
                                 prot.info=protmeta_presAbs,'MatchedID') 
names(subset_presAbs)
dim(subset_presAbs$sub_unique_prot.info[[1]])
dim(subset_presAbs$sub_unique_prot.info[[2]]) 
dim(subset_presAbs$sub_prot.info[[1]]) 
dim(subset_presAbs$sub_prot.info[[2]])  

## ----results = FALSE----------------------------------------------------------
nperm = 50  # set to 500+ for publication 
ptm = proc.time()
set.seed=(123372)
presAbs_comb=prot_level_multiMat_PresAbs(mm_list=subset_presAbs$sub_mm_list,
                                         treat=treats, 
                                         prot.info=subset_presAbs$sub_prot.info, 
                                         prot_col_name='MatchedID', nperm=nperm,
                                         dataset_suffix=c('MM', 'HS') )
proc.time() - ptm

## ----fig.cap="Distribution of p-values and fold changes for differential expression in the combined analysis of Human and Mouse data in CG context."----
plot_volcano_wLab(presAbs_comb$FC, presAbs_comb$BH_P_val, presAbs_comb$GeneID, 
                  FC_cutoff=.5, PV_cutoff=.05, 'Combined Pres/Abs CG vs mCG') 

## -----------------------------------------------------------------------------
# just checking the numbers here
dim(subset_presAbs$sub_unique_mm_list[[1]]) 
dim(subset_presAbs$sub_unique_mm_list[[2]]) 

unique(subset_presAbs$sub_unique_prot.info[[1]]$ProtID)# 8 
unique(subset_presAbs$sub_unique_prot.info[[2]]$ProtID)# 5 

## ----fig.cap="Distribution of p-values and fold changes for the presence/absence analysis in Mouse data in CG context."----
mm_presAbs = peptideLevel_PresAbsDE(subset_presAbs$sub_unique_mm_list[[1]], 
                                    treats[[1]], 
                                    subset_presAbs$sub_unique_prot.info[[1]], 
                                    pr_ppos=3) 

plot_volcano_wLab(mm_presAbs$FC, mm_presAbs$BH_P_val, mm_presAbs$GeneID, 
                  FC_cutoff=.5, PV_cutoff=.05, 'MM Pres/Abs CG vs mCG') 

## ----Distribution of p-values and fold changes for the presence/absence analysis in Human data in CG context.----
hs_presAbs = peptideLevel_PresAbsDE(subset_presAbs$sub_unique_mm_list[[2]], 
                                    treats[[2]], 
                                    subset_presAbs$sub_unique_prot.info[[2]], 
                                    pr_ppos=3) 

plot_volcano_wLab(hs_presAbs$FC, hs_presAbs$BH_P_val, hs_presAbs$GeneID, 
                  FC_cutoff=.5, PV_cutoff=.05, 'HS Pres/Abs CG vs mCG') 


## -----------------------------------------------------------------------------
sessionInfo()

