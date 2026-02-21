# Running LACE

Daniele Ramazzotti, Fabrizio Angaroni, Davide Maspero, Alex Graudenxi, Luca De Sano and Gianluca Ascolani

#### October 30, 2025

#### Package

LACE 2.14.0

## 0.1 Setup the environement

We now present an example of longitudinal analysis of cancer evolution with *LACE* using single-cell data obtained from Rambow, Florian, et al. “Toward minimal residual disease-directed therapy in melanoma.” Cell 174.4 (2018): 843-855.

As a first step, we load single-cell data for a skin melanoma. The data comprises point mutations for four
time points: (1) before treatment, (2) 4 days treatment, (3) 28 days treatment and finally (4) 57 days treatment.

```
library("LACE")
data(longitudinal_sc_variants)
names(longitudinal_sc_variants)
```

```
## [1] "T1_before_treatment"  "T2_4_days_treatment"  "T3_28_days_treatment"
## [4] "T4_57_days_treatment"
```

We setup the main parameter in oder to perform the inference. First of all, as the four data points may potentially provide sequencing for an unbalanced
number of cells, we weight each time point proportionally to the sample sizes as follow. We refer to the paper for details.

```
lik_weights = c(0.2308772,0.2554386,0.2701754,0.2435088)
```

The second main parameter to be defined as input is represented by the false positive and false negative error rates, i.e., alpha and beta. We can specify a
different rate per time point as a list of rates. When multiple set of rates are provided, *LACE* performs a grid search in order to estimate the best set of error rates.

```
alpha = list()
alpha[[1]] = c(0.02,0.01,0.01,0.01)
alpha[[2]] = c(0.10,0.05,0.05,0.05)
beta = list()
beta[[1]] = c(0.10,0.05,0.05,0.05)
beta[[2]] = c(0.10,0.05,0.05,0.05)
head(alpha)
```

```
## [[1]]
## [1] 0.02 0.01 0.01 0.01
##
## [[2]]
## [1] 0.10 0.05 0.05 0.05
```

```
head(beta)
```

```
## [[1]]
## [1] 0.10 0.05 0.05 0.05
##
## [[2]]
## [1] 0.10 0.05 0.05 0.05
```

## 0.2 Inference

We can now perform the inference as follow.

```
inference = LACE(D = longitudinal_sc_variants,
    lik_w = lik_weights,
    alpha = alpha,
    beta = beta,
    keep_equivalent = TRUE,
    num_rs = 5,
    num_iter = 10,
    n_try_bs = 5,
    num_processes = NA,
    seed = 12345,
    verbose = FALSE)
```

```
## [1] "B is already binary"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_1"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_2"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_3"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_4"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_5"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_6"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_1"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_2"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_3"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_4"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_5"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_6"
```

```
## Log is not open.
```

```
## [1] "nodes in B are sprouting from a single node"
```

```
## Log is not open.
```

```
## [1] "B is a full-rank matrix."
```

```
## Log is not open.
```

```
## [1] "Root Root 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_1 1"
```

```
## Log is not open.
```

```
## [1] "Root Clone_2 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_3 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_4 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_1 1"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_2 1"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_3 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_4 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_2 1"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_3 1"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_4 1"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_3 1"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_4 1"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_4 Clone_4 1"
```

```
## Log is not open.
```

```
## [1] "Clone_4 Clone_5 1"
```

```
## Log is not open.
```

```
## [1] "Clone_4 Clone_6 1"
```

```
## Log is not open.
```

```
## [1] "Clone_5 Clone_5 1"
```

```
## Log is not open.
```

```
## [1] "Clone_5 Clone_6 1"
```

```
## Log is not open.
```

```
## [1] "Clone_6 Clone_6 1"
```

```
## Log is not open.
```

```
##      [,1]
## [1,]    0
## [2,]    1
## [3,]    1
## [4,]    1
## [5,]    1
## [6,]    1
## [7,]    1
```

```
## Log is not open.
```

```
##      [,1]
## [1,]    0
## [2,]    1
## [3,]    1
## [4,]    1
## [5,]    1
## [6,]    1
## [7,]    1
```

```
## Log is not open.
```

```
## [1] TRUE
```

```
## Log is not open.
```

```
## [1] "B represents a forest"
```

```
## Log is not open.
```

```
## [1] "B has a forest like structure"
```

```
## Log is not open.
```

```
## [1] "Root Root 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_1 1"
```

```
## Log is not open.
```

```
## [1] "Root Clone_2 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_3 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_4 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Root Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_1 1"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_2 1"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_3 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_4 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Clone_1 Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_2 1"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_3 1"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_4 1"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Clone_2 Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_3 1"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_4 1"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_5 0"
```

```
## Log is not open.
```

```
## [1] "Clone_3 Clone_6 0"
```

```
## Log is not open.
```

```
## [1] "Clone_4 Clone_4 1"
```

```
## Log is not open.
```

```
## [1] "Clone_4 Clone_5 1"
```

```
## Log is not open.
```

```
## [1] "Clone_4 Clone_6 1"
```

```
## Log is not open.
```

```
## [1] "Clone_5 Clone_5 1"
```

```
## Log is not open.
```

```
## [1] "Clone_5 Clone_6 1"
```

```
## Log is not open.
```

```
## [1] "Clone_6 Clone_6 1"
```

```
## Log is not open.
```

```
##      [,1]
## [1,]    0
## [2,]    1
## [3,]    1
## [4,]    1
## [5,]    1
## [6,]    1
## [7,]    1
```

```
## Log is not open.
```

```
##      [,1]
## [1,]    0
## [2,]    1
## [3,]    1
## [4,]    1
## [5,]    1
## [6,]    1
## [7,]    1
```

```
## Log is not open.
```

```
## [1] TRUE
```

```
## Log is not open.
```

```
## [1] "B represents a forest"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_1"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_2"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_3"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_4"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_5"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_6"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_1"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_2"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_3"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_4"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_5"
```

```
## Log is not open.
```

```
## [1] "Root is parent of Clone_6"
```

```
## Log is not open.
```

```
## [1] "B is a binary matrix"
```

```
## Log is not open.
```

```
## [1] "B is a square matrix"
```

```
## Log is not open.
```

```
## [1] "B is a full rank matrix"
```

```
## Log is not open.
```

```
## [1] "B is a forest "
```

```
## Log is not open.
```

```
## [1] "B has single root"
```

```
## Log is not open.
```

```
## [1] "all checks done!"
```

```
## Log is not open.
```

```
## [1] "continue..."
```

```
## Log is not open.
```

```
## [1] "clonal tree:"
```

```
## Log is not open.
```

```
##                        Root ARPC2_2_218249894_C_T PRAME_22_22551005_T_A
## Root                      0                     1                     0
## ARPC2_2_218249894_C_T     0                     0                     1
## PRAME_22_22551005_T_A     0                     0                     0
## HNRNPC_14_21211843_C_T    0                     0                     0
## COL1A2_7_94422978_C_A     0                     0                     0
## RPL5_1_92837514_C_G       0                     0                     0
## CCT8_21_29063389_G_A      0                     0                     0
##                        HNRNPC_14_21211843_C_T COL1A2_7_94422978_C_A
## Root                                        0                     0
## ARPC2_2_218249894_C_T                       0                     0
## PRAME_22_22551005_T_A                       1                     1
## HNRNPC_14_21211843_C_T                      0                     0
## COL1A2_7_94422978_C_A                       0                     0
## RPL5_1_92837514_C_G                         0                     0
## CCT8_21_29063389_G_A                        0                     0
##                        RPL5_1_92837514_C_G CCT8_21_29063389_G_A
## Root                                     0                    0
## ARPC2_2_218249894_C_T                    0                    0
## PRAME_22_22551005_T_A                    0                    0
## HNRNPC_14_21211843_C_T                   0                    0
## COL1A2_7_94422978_C_A                    1                    1
## RPL5_1_92837514_C_G                      0                    0
## CCT8_21_29063389_G_A                     0                    0
```

```
## Log is not open.
```

```
##         Root ARPC2_2_218249894_C_T PRAME_22_22551005_T_A HNRNPC_14_21211843_C_T
## Root       1                     0                     0                      0
## Clone_1    1                     1                     0                      0
## Clone_2    1                     1                     1                      0
## Clone_3    1                     1                     1                      1
## Clone_4    1                     1                     1                      0
## Clone_5    1                     1                     1                      0
## Clone_6    1                     1                     1                      0
##         COL1A2_7_94422978_C_A RPL5_1_92837514_C_G CCT8_21_29063389_G_A
## Root                        0                   0                    0
## Clone_1                     0                   0                    0
## Clone_2                     0                   0                    0
## Clone_3                     0                   0                    0
## Clone_4                     1                   0                    0
## Clone_5                     1                   1                    0
## Clone_6                     1                   0                    1
```

```
## Log is not open.
```

```
## [1] "No incongruences found due to the chronological order"
```

```
## Log is not open.
```

```
## [1] "first time mutation occurrences based the chronological order of samples:"
```

```
## Log is not open.
```

```
##    Root Clone_1 Clone_2 Clone_3 Clone_4 Clone_5 Clone_6
##       1       1       1       1       1       1       1
```

```
## Log is not open.
```

```
## [1] "adjacent matrix with first time occurrences:"
```

```
## Log is not open.
```

```
##            Root_t1 Clone_1_t1 Clone_2_t1 Clone_3_t1 Clone_4_t1 Clone_5_t1
## Root_t1          0          1          0          0          0          0
## Clone_1_t1       0          0          1          0          0          0
## Clone_2_t1       0          0          0          1          1          0
## Clone_3_t1       0          0          0          0          0          0
## Clone_4_t1       0          0          0          0          0          1
## Clone_5_t1       0          0          0          0          0          0
## Clone_6_t1       0          0          0          0          0          0
##            Clone_6_t1
## Root_t1             0
## Clone_1_t1          0
## Clone_2_t1          0
## Clone_3_t1          0
## Clone_4_t1          1
## Clone_5_t1          0
## Clone_6_t1          0
```

```
## Log is not open.
```

```
## [1] "time=" "1"
```

```
## Log is not open.
```

```
## [1] "1st Root_t1->Root_t1=1, prev_Root_t1=0.143835616438356: Root_t1->Root_t2=2"
```

```
## Log is not open.
```

```
## [1] "1st Root_t1->Root_t2=2, prev_Root_t2=0.162162162162162: Root_t2->Root_t3=2"
```

```
## Log is not open.
```

```
## [1] "1st Root_t1->Clone_1_t1=1, prev_Clone_1_t1=0.150684931506849: Clone_1_t1->Clone_1_t2=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_1_t1->Clone_1_t2=2, prev_Clone_1_t2=0.225225225225225: Clone_1_t2->Clone_1_t3=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_1_t1->Clone_2_t1=1, prev_Clone_2_t1=0.184931506849315: Clone_2_t1->Clone_2_t2=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_2_t1->Clone_2_t2=2, prev_Clone_2_t2=0.243243243243243: Clone_2_t2->Clone_2_t3=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_2_t1->Clone_3_t1=1, prev_Clone_3_t1=0.0753424657534247: Clone_3_t1->Clone_3_t2=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_2_t1->Clone_4_t1=1, prev_Clone_4_t1=0.205479452054795: Clone_4_t1->Clone_4_t2=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_3_t1->Clone_3_t2=2, prev_Clone_3_t2=0.108108108108108: Clone_3_t2->Clone_3_t3=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_4_t1->Clone_4_t2=2, prev_Clone_4_t2=0.135135135135135: Clone_4_t2->Clone_4_t3=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_4_t1->Clone_5_t1=1, prev_Clone_5_t1=0.143835616438356: Clone_5_t1->Clone_5_t2=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_4_t1->Clone_6_t1=1, prev_Clone_6_t1=0.0958904109589041: Clone_6_t1->Clone_6_t2=2"
```

```
## Log is not open.
```

```
## [1] "Clone_5_t1->Clone_5_t2=2, prev_Clone_5_t2=0: Clone_5_t1->Clone_5_t2=3"
```

```
## Log is not open.
```

```
## [1] "Clone_5_t1->Clone_5_t2=3, prev_Clone_5_t2=0: Clone_5_t2->Clone_5_t3=3"
```

```
## Log is not open.
```

```
## [1] "1st Clone_6_t1->Clone_6_t2=2, prev_Clone_6_t2=0.126126126126126: Clone_6_t2->Clone_6_t3=2"
```

```
## Log is not open.
```

```
## [1] "time=" "2"
```

```
## Log is not open.
```

```
## [1] "1st Root_t2->Root_t3=2, prev_Root_t3=0.133333333333333: Root_t3->Root_t4=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_1_t2->Clone_1_t3=2, prev_Clone_1_t3=0.166666666666667: Clone_1_t3->Clone_1_t4=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_2_t2->Clone_2_t3=2, prev_Clone_2_t3=0.177777777777778: Clone_2_t3->Clone_2_t4=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_3_t2->Clone_3_t3=2, prev_Clone_3_t3=0.0555555555555556: Clone_3_t3->Clone_3_t4=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_4_t2->Clone_4_t3=2, prev_Clone_4_t3=0.222222222222222: Clone_4_t3->Clone_4_t4=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_5_t2->Clone_5_t3=3, prev_Clone_5_t3=0.0333333333333333: Clone_5_t3->Clone_5_t4=2"
```

```
## Log is not open.
```

```
## [1] "1st Clone_6_t2->Clone_6_t3=2, prev_Clone_6_t3=0.211111111111111: Clone_6_t3->Clone_6_t4=2"
```

```
## Log is not open.
```

```
## [1] "time=" "3"
```

```
## Log is not open.
```

```
## [1] "time=" "4"
```

```
## Log is not open.
```

```
## [1] "time=" "3"
```

```
## Log is not open.
```

```
## [1] "time=" "2"
```

```
## Log is not open.
```

```
## [1] "time=" "1"
```

```
## Log is not open.
```

```
## [1] "idx"     "Clone_1"
```

```
## Log is not open.
```

```
## [1] "idx"     "Clone_2"
```

```
## Log is not open.
```

```
## [1] "idx"     "Clone_3"
```

```
## Log is not open.
```

```
## [1] "idx"     "Clone_4"
```

```
## Log is not open.
```

```
## [1] "idx"     "Clone_5"
```

```
## Log is not open.
```

```
## [1] "idx"     "Clone_6"
```

```
## Log is not open.
```

```
## [1] "/tmp/RtmpmLCqbg/Rbuild12579817e5265/LACE/vignettes"
```

```
## Log is not open.
```

```
## [1] "info"
```

```
## Log is not open.
```

```
## [1] ""
```

```
## Log is not open.
```

We notice that the inference resulting on the command above should be considered only as an example; the parameters num\_rs, num\_iter and n\_try\_bs representing the number of
steps perfomed during the inference are downscaled to reduce execution time. We refer to the Manual for discussion on default values. We provide within the package results
of inferences performed with correct parameters as RData.

```
data(inference)
print(names(inference))
```

```
## [1] "B"                    "C"                    "corrected_genotypes"
## [4] "clones_prevalence"    "relative_likelihoods" "joint_likelihood"
## [7] "clones_summary"       "equivalent_solutions" "error_rates"
```

*LACE* returns a list of nine elements as results. Namely, B and C provide respectively the maximum likelihood longitudinal tree and cells attachments; corrected\_genotypes the corrected genotypes, clones\_prevalence, the estimated prevalence of any observed clone; relative\_likelihoods and joint\_likelihood the estimated likelihoods for each time point and the weighted likelihood; clones\_summary provide a summary of association of mutations to clones. In equivalent\_solutions, solutions (B and C) with likelihood equivalent to the best solution are returned; notice that in the example we disabled this feature by
setting equivalent\_solutions parameter to FALSE. Finally, error rates provide the best error rates (alpha and beta) as estimated by the grid search.

## 0.3 Plot

We can plot the inferred model using the function longitudinal.tree.plot.

```
clone_labels = c("ARPC2","PRAME","HNRNPC","COL1A2","RPL5","CCT8")
longitudinal.tree = longitudinal.tree.plot(inference = inference,
                                           labels_show = "clones",
                                           clone_labels = clone_labels,
                                           legend_position = "topright")
```

![Inferred model](data:image/png;base64...)

Figure 1: Inferred model