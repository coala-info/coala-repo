# CoRegFlux

#### Pauline Trébulle, Daniel Trejo-Banos, Mohamed Elati

#### December 2018

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Data requirement](#data-requirement)
* [4 User guide](#user-guide)
  + [4.1 Computing Influence using *CoRegNet* package function](#computing-influence-using-coregnet-package-function)
  + [4.2 Predict gene state/gene expression level from a condition specific experiment using a linear model](#predict-gene-stategene-expression-level-from-a-condition-specific-experiment-using-a-linear-model)
  + [4.3 Simulations](#simulations)
  + [4.4 Constraining the model](#constraining-the-model)
  + [4.5 From observations to fluxes](#from-observations-to-fluxes)
  + [4.6 Calibration: identifying the softplus parameter using bayesian optimization](#calibration-identifying-the-softplus-parameter-using-bayesian-optimization)
* [5 Session Info](#session-info)

This Vignette accompanies the CoRegFlux package. It can be used either to get some additional information about the methods or to get examples of the use of the functions. Feel free to ask any question to the package maintainer (coregflux at gmail dot com).

# 1 Installation

Install CoRegFlux:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("CoRegFlux")
```

Load CoRegFlux:

```
library(CoRegFlux)
```

# 2 Introduction

The CoRegFlux package aims at providing tools to integrate reverse engineered gene regulatory networks and gene-expression into metabolic models to improve prediction of phenotypes, both for metabolic engineering, through transcription factor or gene (TF) knock-out or overexpression in various conditions as well as to improve our understanding of the interactions and cell inner-working. The following figure summarize the different functions available in the package to constraint the genome-scale metabolic model with gene expression for wild-type or mutants or to run a complete simulation using those constraints.

![Summary of CoRegFlux functions and features](data:image/png;base64...)

# 3 Data requirement

To use *all* CoRegFlux features you will need:

1. A genome-scale metabolic model for your model organism as a modelOrg object (see sybilSBML for import) containing gene-association rules for reactions
2. Condition-specific gene expression data / gene states for which the transcription factor influence, a statistical value estimating the TF activity in each sample, will be calculated
3. A gene regulatory network (GRN) as a coregnet objet (see the *CoRegNet* package for more information about network inference)
4. A large gene expression matrix to train the model

Examples data are provided with the package, including genome-scale metabolic model iMM904 for *Saccharomyces Cerevisiae* (SC), a gene regulatory network build for SC from the m3D database as described in *Trejo Banos et al., “Integrating transcriptional activity in genome-scale models of metabolism”, BMC Systems Biology 2017*, as well as a subset of the m3D dataset to train the model and provide gene expression data. To study others organims or another regulatory network, you will need to build a GRN using the *CoRegNet* package and/or choose relevant datasets.

# 4 User guide

## 4.1 Computing Influence using *CoRegNet* package function

```
data("SC_GRN_1")
data("SC_EXP_DATA")
data("SC_Test_data")

Testing_influence_matrix <- CoRegNet::regulatorInfluence(SC_GRN_1,SC_Test_data)
experiment_influence<- Testing_influence_matrix[,1]
```

Here are the main functionalities of *CoRegFlux*

## 4.2 Predict gene state/gene expression level from a condition specific experiment using a linear model

```
data("aliases_SC")
data("iMM904")
PredictedGeneState <- predict_linear_model_influence(network = SC_GRN_1,
experiment_influence = experiment_influence,
train_expression = SC_EXP_DATA,
min_Target = 4,
model = iMM904,
aliases = aliases_SC)

GeneState<-data.frame("Name" = names(PredictedGeneState),
"State" = unname(PredictedGeneState))
```

## 4.3 Simulations

For each simulation step, the function receives a metabolic model and performs:

* update fluxes by metabolites concentrations
* update fluxes by coregnet and influence value
* update fluxes by gene state from the GRN simulator

The simulation result is a list containing:

* objective\_history: time series of objective function value for the linear program
* metabolites: metabolites concentrations over time
* fluxes\_history: time series of the fluxes values for all the time series
* metabolites\_concentration\_history: time series of metabolite concentrations
* metabolites\_fluxes\_history: time series of the metabolites fluxes during the simulation
* rate\_history: time series of the growth rate values for all simulation
* time: vector containing the simulation times
* gene\_state\_history: list containing the values for the gene state during the simulation

The fluxes for the simulation time are stored in a matrix which row names are the fluxes reaction id.

```
data("aliases_SC")
data("iMM904")
metabolites<-data.frame("names" = c("D-Glucose","Ethanol"),
"concentrations" = c(16.6,0))

Simulation1<-Simulation(model = iMM904,
time = seq(1,20,by = 1),
metabolites = metabolites,
initial_biomass = 0.45,
aliases = aliases_SC)
# Default biomass flux index use is 1577 corresponding to  Biomass SC5 notrace
# Joining by: metabolites_id
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step
# simulation step

Simulation1$fluxes_history[1:10,1:5]
#                 [,1]    [,2]          [,3]       [,4]       [,5]
# 13BGH     0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
# 13BGHe    0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
# 13GS      0.32667000 0.32667  2.063497e-01 0.03309391 0.03309391
# 16GS      0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
# 23CAPPD   0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
# 2DDA7Ptm -0.07608291 0.00000  0.000000e+00 0.00000000 0.00000000
# 2DHPtm    0.00000000 0.00000 -1.136868e-13 0.00000000 0.00000000
# 2DOXG6PP  0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
# 2HBO      0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
# 2HBt2     0.00000000 0.00000  0.000000e+00 0.00000000 0.00000000
```

To have access to the gprRules users can use the sybil package, which returns a vector of size equal to the number of fluxes and the associated genes.

```
library(sybil)
gpr(iMM904)[1:5]
# [1] "YGR282C"
# [2] "(YDR261C or YOR190W or YLR300W)"
# [3] "((YLR342W and YCR034W and YMR307W) or (YLR342W and YCR034W and YMR215W) or (YMR306W and YCR034W and YLR343W) or (YMR306W and YCR034W and YOL030W) or (YGR032W and YCR034W and YOL030W) or (YLR342W and YCR034W and YOL132W) or (YGR032W and YCR034W and YMR215W) or (YGR032W and YCR034W and YLR343W) or (YMR306W and YCR034W and YMR215W) or (YMR306W and YCR034W and YOL132W) or (YLR342W and YCR034W and YOL030W) or (YLR342W and YCR034W and YLR343W) or (YGR032W and YCR034W and YOL132W) or (YGR032W and YCR034W and YMR307W) or (YMR306W and YCR034W and YMR307W))"
# [4] "(YPR159W or YGR143W)"
# [5] "YGR247W"
```

If you only wish to know which gene affects which reaction; the sybil objects have a slot for obtaining the flux-gene matrix.

```
rxnGeneMat(iMM904)[1:10,1:10]
# 10 x 10 sparse Matrix of class "lgCMatrix"
#
#  [1,] | . . . . . . . . .
#  [2,] . | | | . . . . . .
#  [3,] . . . . | | | | | |
#  [4,] . . . . . . . . . .
#  [5,] . . . . . . . . . .
#  [6,] . . . . . . . . . .
#  [7,] . . . . . . . . . .
#  [8,] . . . . . . . . . .
#  [9,] . . . . . . . . . .
# [10,] . . . . . . . . . .
```

### 4.3.1 Simulate a dFBA over time (here 20h) without constraint

```
metabolites<-data.frame("names" = c("D-Glucose","Ethanol"),
"concentrations" = c(16.6,0))

Simulation1<-Simulation(model = iMM904,
time = seq(1,20,by = 1),
metabolites = metabolites,
initial_biomass = 0.45,
aliases = aliases_SC)

Simulation1$biomass_history
#  [1] 0.4500000 0.6001102 0.8002939 0.9598884 0.9882935 1.0175393 1.0476505
#  [8] 1.0786527 1.1105724 1.1434366 1.1772734 1.2121114 1.2479804 1.2849109
# [15] 1.3229342 1.3620827 1.4023896 1.4175428 1.4175428 1.4175428
Simulation1$met_concentration_history
#           [,1]      [,2]      [,3]     [,4]     [,5]     [,6]     [,7]
# D-Glucose 16.6 11.385409  4.431344  0.00000  0.00000  0.00000  0.00000
# Ethanol    0.0  8.247123 19.245307 26.42949 24.77683 23.07527 21.32335
#               [,8]     [,9]    [,10]    [,11]    [,12]    [,13]    [,14]
# D-Glucose  0.00000  0.00000  0.00000  0.00000  0.00000 0.000000 0.000000
# Ethanol   19.51959 17.66245 15.75036 13.78168 11.75474 9.667829 7.519157
#              [,15]    [,16]     [,17] [,18] [,19] [,20]
# D-Glucose 0.000000 0.000000 0.0000000     0     0     0
# Ethanol   5.306901 3.029179 0.6840547     0     0     0
```

## 4.4 Constraining the model

When provided with different kind of constraints, CoRegFlux process the given information in the following order:

* Gene expression is first integrated
* TF KO or OV is carried out, starting with the first line in the regulator table and going along the rows.
* Gene KO or OV is carried out. starting with the first line in the gene table and going along the rows. Thus order in the regulator table and gene table might play a role and potentially give different results.

The different functions used by CoRegFlux to constraint the model are individually accessible to allow the combination of CoRegFlux’s models with other algorithms and parameters, provided by sybil for instance. A model can be constrain iteratively through the different function. In that case, the recommended order is as follows: uptake constraint, gene expression, TF KO or OV, gene KO or OV.

```
regulator_table <- data.frame("regulator" = c("MET32","CAT8"),
"influence" =  c(-1.20322,-2.4),
"expression" = c(0,0),
stringsAsFactors = FALSE)

model_TF_KO_OV_constraints <- update_fluxes_constraints_influence(model= iMM904,
coregnet = SC_GRN_1,
regulator_table = regulator_table,
aliases = aliases_SC )

sol<-sybil::optimizeProb(model_TF_KO_OV_constraints)
#Additional parameters from sybil can then be integrated such as the chosen
# algorithms

sol
# solver:                                   glpkAPI
# method:                                   simplex
# algorithm:                                fba
# number of variables:                      1577
# number of constraints:                    1226
# return value of solver:                   solution process was successful
# solution status:                          solution is optimal
# value of objective function (fba):        0.287866
# value of objective function (model):      0.287866
```

### 4.4.1 Simulate a dFBA with gene expression as a constraint

```
Simulation2<-Simulation(model = iMM904,
time = seq(1,20,by = 1),
metabolites = metabolites,
initial_biomass = 0.45,
aliases = aliases_SC,
gene_state_function = function(a,b){GeneState})

Simulation2$biomass_history
#  [1] 0.4500000 0.5248670 0.6121898 0.7140405 0.8328362 0.9713961 1.0679966
#  [8] 1.0996010 1.1321406 1.1656430 1.2001369 1.2356516 1.2722172 1.2729969
# [15] 1.2729969 1.2729969 1.2729969 1.2729969 1.2729969 1.2729969
Simulation2$met_concentration_history
#           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]     [,7]
# D-Glucose 16.6 14.477830 12.002591  9.115544  5.748176  1.820576  0.00000
# Ethanol    0.0  3.005114  6.510192 10.598414 15.366798 20.928504 22.88805
#               [,8]     [,9]   [,10]    [,11]    [,12]     [,13] [,14]
# D-Glucose  0.00000  0.00000  0.0000  0.00000 0.000000 0.0000000     0
# Ethanol   17.76373 15.87053 13.9213 11.91439 6.156059 0.2273263     0
#           [,15] [,16] [,17] [,18] [,19] [,20]
# D-Glucose     0     0     0     0     0     0
# Ethanol       0     0     0     0     0     0
```

### 4.4.2 Simulate a dFBA with TF knock-out (KO) while constraining the model with gene expression

If the simulated mutant have several TFs KO or OV, CoRegFlux will constrain the model according to the order of the TFs in the regulator table. While this example also constraint the model with gene expression, it is possible to run the simulation without such constraints.

```
regulator_table <- data.frame("regulator" = "MET32",
"influence" =  -1.20322,
"expression" = 0,
stringsAsFactors = FALSE)

SimulationTFKO<-Simulation(model = iMM904,
time = seq(1,20,by = 1),
metabolites = metabolites,
initial_biomass = 0.45,
aliases = aliases_SC,
coregnet = SC_GRN_1,
regulator_table = regulator_table ,
gene_state_function = function(a,b){GeneState})

SimulationTFKO$biomass_history ## This KO is predicted as non-lethal
#  [1] 0.4500000 0.5248670 0.6121898 0.7140405 0.8328362 0.8574816 0.8828564
#  [8] 0.9089820 0.9358807 0.9635755 0.9920898 1.0214478 1.0515062 1.0515062
# [15] 1.0515062 1.0515062 1.0515062 1.0515062 1.0515062 1.0515062
```

### 4.4.3 Simulate a dFBA with TF over-expression (OV) while constraining the model with gene expression

If the simulated mutant have several TFs KO or OV, CoRegFlux will constrain the model according to the order of the TFs in the regulator table. While this example also constraint the model with gene expression, it is possible to run the simulation without such constraints.

```
regulator_table <- data.frame("regulator" = "MET32",
"influence" = -1.20322 ,
"expression" = 3,
stringsAsFactors = FALSE)

SimulationTFOV<-Simulation(model = iMM904,
time = seq(1,20,by = 1),
metabolites = metabolites,
initial_biomass = 0.45,
aliases = aliases_SC,
coregnet = SC_GRN_1,
regulator_table = regulator_table,
gene_state_function = function(a,b){GeneState})

SimulationTFOV$biomass_history ## This OV is predicted as non-lethal
#  [1] 0.4500000 0.5248670 0.6121898 0.7140405 0.8328362 0.9276605 0.9551120
#  [8] 0.9833758 1.0124761 1.0424374 1.0424374 1.0424374 1.0424374 1.0424374
# [15] 1.0424374 1.0424374 1.0424374 1.0424374 1.0424374 1.0424374
```

### 4.4.4 Simulate a dFBA with gene(s) knock-out or over-expression simulation while constraining the model with gene expression

If the simulated mutant have several gene KO or gene OV, CoRegFlux will constrain the model according to the order of the genes in the gene table. While this example also constraint the model with gene expression, it is possible to run the simulation without such constraints.

```
gene_table <- data.frame("gene" = c("YJL026W","YIL162W"),
"expression" =c(2,0),
stringsAsFactors = FALSE)

SimulationGeneKO_OV<-Simulation(model = iMM904,
time = seq(1,20,by = 1),
metabolites = metabolites,
initial_biomass = 0.45,
aliases = aliases_SC,
coregnet = SC_GRN_1,
gene_table = gene_table,
gene_state_function = function(a,b){GeneState})

SimulationGeneKO_OV$biomass_history ## This OV is predicted as non-lethal
#  [1] 0.4500000 0.5248670 0.6121898 0.7140405 0.8328362 0.8574816 0.8828564
#  [8] 0.9089820 0.9358807 0.9635755 0.9920898 1.0214478 1.0516747 1.0516747
# [15] 1.0516747 1.0516747 1.0516747 1.0516747 1.0516747 1.0516747
```

### 4.4.5 Constraining the model according to gene expression, TF KO or OV, gene KO or OV to run various FBA using sybil

The different functions used by CoRegFlux to constraint the model are individually accessible to allow the combination of CoRegFlux’s models with other algorithms and parameters, provided by sybil for instance. A model can be constrain iteratively through the different function. In that case, the recommended order is as follows: uptake constraint, gene expression, TF KO or OV, gene KO or OV.

```
metabolites_rates <- data.frame("name"=c("D-Glucose"),
"concentrations"=c(16.6),
"rates"=c(-2.81))

model_uptake_constraints <- adjust_constraints_to_observed_rates(model = iMM904,
metabolites_with_rates = metabolites_rates)

model_gene_constraints <- coregflux_static(model= iMM904,
predicted_gene_expression =
PredictedGeneState,
aliases = aliases_SC)$model

model_TF_KO_OV_constraints <- update_fluxes_constraints_influence(model= iMM904,
coregnet = SC_GRN_1,
regulator_table = regulator_table,
aliases = aliases_SC )

model_gene_KO_OV_constraints <- update_fluxes_constraints_geneKOOV(
model= iMM904,
gene_table =  gene_table,
aliases = aliases_SC)

sol <- sybil::optimizeProb(model_TF_KO_OV_constraints)

sol
# solver:                                   glpkAPI
# method:                                   simplex
# algorithm:                                fba
# number of variables:                      1577
# number of constraints:                    1226
# return value of solver:                   solution process was successful
# solution status:                          solution is optimal
# value of objective function (fba):        0.287866
# value of objective function (model):      0.287866
```

## 4.5 From observations to fluxes

Here we will compute the fluxes from the observed growth rates (which can be obtained directly from the growth curves)

Assuming we have an observed growth rate of 0.3

```
fluxes_obs <-
get_fba_fluxes_from_observations(iMM904,0.3)
fluxes_obs[1:10,]
#    13BGH   13BGHe     13GS     16GS  23CAPPD 2DDA7Ptm   2DHPtm 2DOXG6PP
#  0.00000  0.00000  0.32667  0.00000  0.00000  0.00000  0.00000  0.00000
#     2HBO    2HBt2
#  0.00000  0.00000
```

Given that the fba solution is not unique, if you wish to see the intervals of maximum and minimum allowed fluxes for a reaction, flux variability analysis should be used

```
fluxes_intervals_obs <-
get_fva_intervals_from_observations(iMM904,0.3)
# calculating 3154 optimizations ...
#
# |            :            |            :            | 100 %
# |===================================================| :-)
# OK
# Done.
fluxes_intervals_obs[1:10,]
#                    min          max
# 13BGH     0.000000e+00 2.962010e-05
# 13BGHe    0.000000e+00 0.000000e+00
# 13GS      3.266692e-01 3.266988e-01
# 16GS      0.000000e+00 0.000000e+00
# 23CAPPD   0.000000e+00 0.000000e+00
# 2DDA7Ptm -7.609314e-02 0.000000e+00
# 2DHPtm    0.000000e+00 5.558111e-06
# 2DOXG6PP  0.000000e+00 0.000000e+00
# 2HBO     -1.880648e-05 0.000000e+00
# 2HBt2    -1.880648e-05 0.000000e+00
```

It worth noting that none of the two methods guarantee that the observed growth rate will be reached.

```
fluxes_obs[get_biomass_flux_position(iMM904),]
# BIOMASS_SC5_notrace
#           0.2878657
fluxes_intervals_obs[get_biomass_flux_position(iMM904),]
#       min       max
# 0.2878650 0.2878657
```

This could mean that the uptake rates for the limiting substrates (most commonly glucose uptake rate) does not allow for higher growth.

To constraint the model using the substrate uptake rate, the user must also provide the metabolites\_rates argument

```
metabolites_rates <- data.frame("name"=c("D-Glucose","Ethanol"),
"rates"=c(-10,-1))
fluxes_obs <-
get_fba_fluxes_from_observations(
model = iMM904,
observed_growth_rate =  0.3,
metabolites_rates = metabolites_rates)
# Joining by: metabolites_id

fluxes_obs[get_biomass_flux_position(iMM904),]
# BIOMASS_SC5_notrace
#           0.2878657

fluxes_interval_obs <-
get_fva_intervals_from_observations(
model = iMM904,
observed_growth_rate =0.3,
metabolites_rates = metabolites_rates)
# Joining by: metabolites_id
# calculating 3154 optimizations ...
#
# |            :            |            :            | 100 %
# |===================================================| :-)
# OK
# Done.
fluxes_interval_obs[get_biomass_flux_position(iMM904),]
#       min       max
# 0.2878650 0.2878657
```

### 4.5.1 Adjusting the fluxes bounds based on observed growth rates, and visualized its effects on metabolic genes

*During this step, you might get a message from R.cache to choose where the cached files should be saved. Since those files are only temporary files, you can create a dedicated folder in your working directory which you can remove afterward, or pick a location near the installation folder of the R.cache package.*

```
FBA_bounds_from_growthrate<- get_fba_fluxes_from_observations(
model = iMM904,observed_growth_rate = 0.3,
metabolites_rates = metabolites_rates)

FVA_bounds_from_growthrate<- get_fva_intervals_from_observations(
model = iMM904,observed_growth_rate = 0.3,
metabolites_rates = metabolites_rates)
#
# |            :            |            :            | 100 %
# |===================================================| :-)
```

```
ODs<-seq.int(0.099,1.8,length.out = 5)
times = seq(0.5,2,by=0.5)

ODcurveToMetCurve<- ODCurveToMetabolicGeneCurves(times = times,
ODs = ODs,
model = iMM904,
aliases = aliases_SC,
metabolites_rates = metabolites_rates)
#
# |            :            |            :            | 100 %
# |===================================================| :-)
#
# |            :            |            :            | 100 %
# |===================================================| :-)
#
# |            :            |            :            | 100 %
# |===================================================| :-)

visMetabolicGeneCurves(ODcurveToMetCurve,genes = "YJR077C")
```

![](data:image/png;base64...)

```
ODtoflux<-ODCurveToFluxCurves(model = iMM904,
ODs = ODs,
times = times,
metabolites_rates = metabolites_rates)
#
# |            :            |            :            | 100 %
# |===================================================| :-)
#
# |            :            |            :            | 100 %
# |===================================================| :-)
#
# |            :            |            :            | 100 %
# |===================================================| :-)

visFluxCurves(ODtoflux, genes ="ADK3")
```

![](data:image/png;base64...)

## 4.6 Calibration: identifying the softplus parameter using bayesian optimization

To translate the gene expression to fluxes in the GEM, CoRegFlux use the softplus function

![](data:image/png;base64...)

where \(\theta\) is the softplus parameter applied to all fluxes, \(gpr\_{i}\left(X\right)\) is the result of evaluating the gene-protein-reaction rules for a set of gene expression levels of the metabolic genes \(X\). These rules relate genes to reactions and are logical form. CoRegflux transform these rules as follows

* AND are substitued by MIN()
* OR are substituted by SUM().

Given a known growth rate and predicted gene expressions obtained through the function predict\_linear\_model\_influence, the users have the possibility to adjust the softplus parameter \(\theta\) to calibrate the integration of the gene expression in the GEM. This step requires the installation of the package rBayesianOptimization.

```
library(rBayesianOptimization)
gRates <- 0.1

opF<-function(p){
CoRegFlux_model<-coregflux_static(model = model_uptake_constraints,
gene_parameter = p,
predicted_gene_expression =
PredictedGeneState)
ts<-optimizeProb(CoRegFlux_model$model)
list(Score=-1*log(abs(lp_obj(ts)-gRates)/gRates),Pred=0)
}

result<-BayesianOptimization(FUN = opF,
bounds = list(p = c(-10,10)),
data.frame(p = seq(-10,10,by =  0.5)),
n_iter = 10,
verbose = TRUE)
```

# 5 Session Info

```
sessionInfo()
# R version 3.6.0 (2019-04-26)
# Platform: x86_64-pc-linux-gnu (64-bit)
# Running under: Ubuntu 18.04.2 LTS
#
# Matrix products: default
# BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
# LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
#
# locale:
#  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#  [9] LC_ADDRESS=C               LC_TELEPHONE=C
# [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base
#
# other attached packages:
#  [1] ggplot2_3.1.1   glpkAPI_1.3.1   latex2exp_0.4.0 sybil_2.1.5
#  [5] lattice_0.20-38 CoRegNet_1.22.0 arules_1.6-3    Matrix_1.2-17
#  [9] shiny_1.3.2     igraph_1.2.4.1  CoRegFlux_1.0.0
#
# loaded via a namespace (and not attached):
#  [1] Rcpp_1.0.1        pillar_1.3.1      compiler_3.6.0
#  [4] later_0.8.0       plyr_1.8.4        R.methodsS3_1.7.1
#  [7] R.utils_2.8.0     tools_3.6.0       digest_0.6.18
# [10] tibble_2.1.1      evaluate_0.13     gtable_0.3.0
# [13] R.cache_0.13.0    rlang_0.3.4       pkgconfig_2.0.2
# [16] yaml_2.2.0        parallel_3.6.0    xfun_0.6
# [19] withr_2.1.2       dplyr_0.8.0.1     stringr_1.4.0
# [22] knitr_1.22        tidyselect_0.2.5  grid_3.6.0
# [25] glue_1.3.1        R6_2.4.0          rmarkdown_1.12
# [28] purrr_0.3.2       magrittr_1.5      scales_1.0.0
# [31] promises_1.0.1    htmltools_0.3.6   assertthat_0.2.1
# [34] colorspace_1.4-1  mime_0.6          xtable_1.8-4
# [37] httpuv_1.5.1      labeling_0.3      stringi_1.4.3
# [40] lazyeval_0.2.2    munsell_0.5.0     crayon_1.3.4
# [43] R.oo_1.22.0
```