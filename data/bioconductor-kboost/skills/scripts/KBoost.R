# Code example from 'KBoost' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(KBoost)

data(D4_multi_1)

grn = kboost(D4_multi_1)

grn$GRN[91:93,2:5]

## ----message=FALSE------------------------------------------------------------
library(KBoost)

data(D4_multi_1)

# Matrix of size 100x100 with all values set to 0.5
prior_weights = matrix(0.5,100,100)

# For this example assume we know from previous experiments that TF2 regulates the gene in row 91
prior_weights[91,2] = 0.8

grn = kboost(X=D4_multi_1, prior_weights=prior_weights)

# Note that the first entry now has a slightly higher probability than in the 
# previous example, as a result of adding the prior
grn$GRN[91:93,2:5]

## ----message=FALSE------------------------------------------------------------
library(KBoost)

# A random 10x5 numerical matrix
X = rnorm(50,0,1)
X = matrix(X,10,5)

# Gene names corresponding to the columns of X
gen_names = c("TP53","YY1","CTCF","MDM2","ESR1")

grn = KBoost_human_symbol(X,gen_names,pos_weight=0.6, neg_weight=0.4)

# TFs are taken from Lambert et al., 4 columns in the output network indicates 4 of the genes are TFs.
grn$GRN

# Look at the prior weights based on the Gerstein network.
# Output indicates the YY1-TP53 edge is present in the Gerstein network.
grn$prior_weights

## ----message=FALSE------------------------------------------------------------
library(KBoost)
data(D4_multi_1)
Net = kboost(D4_multi_1)
dist = net_dist_bin(Net$GRN,Net$TFs,0.1)

## ----message=FALSE------------------------------------------------------------
library(KBoost)
data(D4_multi_1)
Net = kboost(D4_multi_1)
Net_Summary = net_summary_bin(Net$GRN)

## ----message=FALSE------------------------------------------------------------
data(D4_multi_1)

## ----message=FALSE------------------------------------------------------------
data(G_D4_multi_1)

## ----message=FALSE------------------------------------------------------------
data(Gerstein_Prior_ENET_2)

## ----message=FALSE------------------------------------------------------------
data(Human_TFs)

