# Code example from 'differentialExpression' vignette. See references/ for full tutorial.

## ----setup_data, message=FALSE---------------------------------------------
library(adaptest)
data(simpleArray)
set.seed(1234)
Y <- simulated_array
A <- simulated_treatment

## ----adaptest_eval, message=FALSE------------------------------------------
adaptest_out <- adaptest(Y = Y,
                         A = A,
                         W = NULL,
                         n_top = 35,
                         n_fold = 5,
                         learning_library = c("SL.glm", "SL.mean"),
                         parameter_wrapper = adaptest::rank_DE,
                         absolute = FALSE,
                         negative = FALSE)

## ----get_comp_small--------------------------------------------------------
get_composition(object = adaptest_out, type = "small")

## ----get_comp_big----------------------------------------------------------
get_composition(object = adaptest_out, type = "big")

## ----plot------------------------------------------------------------------
plot(adaptest_out)

## ----sum_exp, message=FALSE------------------------------------------------
library(SummarizedExperiment)
library(airway)
data(airway)

## ----augment_se------------------------------------------------------------
genes_sub <- order(sample(seq_len(1000)))
air_reduced <- airway[genes_sub, ]

## ----augment_airway--------------------------------------------------------
simple_air <- cbind(air_reduced, air_reduced)

## ----make_tx_var-----------------------------------------------------------
# use a binary treatment variable (must be 0/1 only)
dex_var = as.numeric(as.matrix(colData(simple_air))[, 3] - 1)

## ----bioadaptest-----------------------------------------------------------
airway_out <- bioadaptest(data_in = simple_air,
                          var_int = dex_var,
                          cntrl_set = NULL,
                          n_top = 5,
                          n_fold = 2,
                          parameter_wrapper = rank_DE)

## ----session_info, echo=FALSE----------------------------------------------
sessionInfo()

