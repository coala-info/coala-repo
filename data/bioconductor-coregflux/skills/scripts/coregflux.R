# Code example from 'coregflux' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
	warning = FALSE,
	collapse = TRUE,
	comment = "#"
)

library(CoRegFlux)
library(CoRegNet)
library(sybil)
library(latex2exp)

data("SC_GRN_1")
data("SC_EXP_DATA")
data("SC_experiment_influence")
data("SC_Test_data")
data("aliases_SC")
data("iMM904")
metabolites<-data.frame("names" = c("D-Glucose","Ethanol"),
                        "concentrations" = c(16.6,0))

metabolites_rates<- data.frame("name"=c("D-Glucose"),
                               "concentrations"=c(16.6),
                               "rates"=c(-2.81))

model_uptake_constraints <- adjust_constraints_to_observed_rates(model = iMM904,
                            metabolites_with_rates = metabolites_rates)

Testing_influence_matrix <- CoRegNet::regulatorInfluence(SC_GRN_1,SC_Test_data)
experiment_influence<- Testing_influence_matrix[,1]

PredictedGeneState <- predict_linear_model_influence(network = SC_GRN_1,
                    experiment_influence = experiment_influence,
                    train_expression = SC_EXP_DATA,
                    min_Target = 4,
                    model = iMM904,
                    aliases = aliases_SC)

Simulation1<-Simulation(model = iMM904,
                        time = seq(1,20,by = 1),
                        metabolites = metabolites,
                        initial_biomass = 0.45,
                        aliases = aliases_SC)

## ----warning = FALSE, eval = FALSE---------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("CoRegFlux")

## ----warning = FALSE, eval = FALSE---------------------------------------
#  library(CoRegFlux)

## ----warning = FALSE-----------------------------------------------------
data("SC_GRN_1")
data("SC_EXP_DATA")
data("SC_Test_data")

Testing_influence_matrix <- CoRegNet::regulatorInfluence(SC_GRN_1,SC_Test_data)
experiment_influence<- Testing_influence_matrix[,1]

## ---- warning= FALSE-----------------------------------------------------
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

## ------------------------------------------------------------------------
data("aliases_SC")
data("iMM904")
metabolites<-data.frame("names" = c("D-Glucose","Ethanol"),
                        "concentrations" = c(16.6,0))

Simulation1<-Simulation(model = iMM904,
                        time = seq(1,20,by = 1),
                        metabolites = metabolites,
                        initial_biomass = 0.45,
                        aliases = aliases_SC)

Simulation1$fluxes_history[1:10,1:5]

## ------------------------------------------------------------------------
library(sybil)
gpr(iMM904)[1:5]

## ------------------------------------------------------------------------
rxnGeneMat(iMM904)[1:10,1:10]

## ---- warning = FALSE,message = FALSE------------------------------------

metabolites<-data.frame("names" = c("D-Glucose","Ethanol"),
                        "concentrations" = c(16.6,0))

Simulation1<-Simulation(model = iMM904,
                        time = seq(1,20,by = 1),
                        metabolites = metabolites,
                        initial_biomass = 0.45,
                        aliases = aliases_SC)
	
Simulation1$biomass_history
Simulation1$met_concentration_history

## ------------------------------------------------------------------------

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

## ---- message = FALSE----------------------------------------------------
Simulation2<-Simulation(model = iMM904,
	                    time = seq(1,20,by = 1),
                        metabolites = metabolites,
                        initial_biomass = 0.45,
	                    aliases = aliases_SC,
                        gene_state_function = function(a,b){GeneState})
	
Simulation2$biomass_history
Simulation2$met_concentration_history


## ----message = FALSE-----------------------------------------------------
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

## ----message =FALSE------------------------------------------------------
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

## ----message =FALSE------------------------------------------------------
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

## ----message =FALSE,warnings=FALSE---------------------------------------

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

## ------------------------------------------------------------------------
fluxes_obs <- 
  get_fba_fluxes_from_observations(iMM904,0.3)
fluxes_obs[1:10,]

## ------------------------------------------------------------------------
fluxes_intervals_obs <-
  get_fva_intervals_from_observations(iMM904,0.3) 
fluxes_intervals_obs[1:10,]

## ------------------------------------------------------------------------
fluxes_obs[get_biomass_flux_position(iMM904),]
fluxes_intervals_obs[get_biomass_flux_position(iMM904),]

## ---- result="hide"------------------------------------------------------
metabolites_rates <- data.frame("name"=c("D-Glucose","Ethanol"),
                               "rates"=c(-10,-1))
fluxes_obs <- 
  get_fba_fluxes_from_observations(
    model = iMM904,
    observed_growth_rate =  0.3,
    metabolites_rates = metabolites_rates) 

fluxes_obs[get_biomass_flux_position(iMM904),]

fluxes_interval_obs <- 
  get_fva_intervals_from_observations(
    model = iMM904,
    observed_growth_rate =0.3,
    metabolites_rates = metabolites_rates) 
fluxes_interval_obs[get_biomass_flux_position(iMM904),]


## ---- message = FALSE, warnings = FALSE----------------------------------

FBA_bounds_from_growthrate<- get_fba_fluxes_from_observations(
    model = iMM904,observed_growth_rate = 0.3,
    metabolites_rates = metabolites_rates)

FVA_bounds_from_growthrate<- get_fva_intervals_from_observations(
    model = iMM904,observed_growth_rate = 0.3,
    metabolites_rates = metabolites_rates)

## ---- message= FALSE, warning=FALSE--------------------------------------
ODs<-seq.int(0.099,1.8,length.out = 5)
times = seq(0.5,2,by=0.5)

ODcurveToMetCurve<- ODCurveToMetabolicGeneCurves(times = times,
                             ODs = ODs,
                             model = iMM904,
                             aliases = aliases_SC,
                             metabolites_rates = metabolites_rates) 

visMetabolicGeneCurves(ODcurveToMetCurve,genes = "YJR077C")

ODtoflux<-ODCurveToFluxCurves(model = iMM904,
                              ODs = ODs,
                              times = times,
                              metabolites_rates = metabolites_rates)

visFluxCurves(ODtoflux, genes ="ADK3")

## ----echo=FALSE,warning=FALSE,tidy=TRUE----------------------------------
library(ggplot2)
library(latex2exp)
eq_title<-latex2exp::TeX('$v_{i}\\leq\\ln\\left(1+ \\exp\\left(\\theta+gpr_{i}\\left(X\\right)\\right)\\right)$')
fun_1 <- function(x)log(1+exp(x))

p <- ggplot2::ggplot(data = data.frame(x = 0), mapping = ggplot2::aes(x = x))
p + ggplot2::stat_function(fun = fun_1,colour="red") + ggplot2::xlim(-5,5)  + 
    ggplot2::geom_vline(xintercept = 0) + ggplot2::geom_hline(yintercept = 0) + ggplot2::ggtitle(eq_title)

## ---- message =FALSE, eval=FALSE-----------------------------------------
#  library(rBayesianOptimization)
#  gRates <- 0.1
#  
#  opF<-function(p){
#          CoRegFlux_model<-coregflux_static(model = model_uptake_constraints,
#                                            gene_parameter = p,
#                                            predicted_gene_expression =
#                                                PredictedGeneState)
#          ts<-optimizeProb(CoRegFlux_model$model)
#          list(Score=-1*log(abs(lp_obj(ts)-gRates)/gRates),Pred=0)
#      }
#  
#  result<-BayesianOptimization(FUN = opF,
#                               bounds = list(p = c(-10,10)),
#                               data.frame(p = seq(-10,10,by =  0.5)),
#                               n_iter = 10,
#                               verbose = TRUE)
#  

## ------------------------------------------------------------------------
sessionInfo()

