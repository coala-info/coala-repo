# Code example from 'GSgalgoR_callbacks' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# galgo(...,
#     start_galgo_callback = callback_default,# `galgo()` is about to start.
#     end_galgo_callback = callback_default,  # `galgo()` is about to finish.
#     start_gen_callback = callback_default, # At the beginning of each generation
#     end_gen_callback = callback_default,    # At the end of each generation
#     report_callback = callback_default,     # In the middle of the generation,
#                                             #  right after the new mating pool
#                                             #  have been created.
#     ...)

## -----------------------------------------------------------------------------
library(GSgalgoR)

## -----------------------------------------------------------------------------


my_callback <-
    function(userdir = "",
        generation,
            pop_pool,
            pareto,
            prob_matrix,
            current_time) {
    # code starts  here
    if (generation%%2 == 0)
        message(paste0("generation: ",generation,
                    " current_time: ",current_time))
    }

## ----message=FALSE------------------------------------------------------------
library(breastCancerTRANSBIG)

## -----------------------------------------------------------------------------
data(transbig)
train <- transbig
rm(transbig)
expression <- Biobase::exprs(train)
clinical <- Biobase::pData(train)
OS <- survival::Surv(time = clinical$t.rfs, event = clinical$e.rfs)
# use a reduced dataset for the example
expression <- expression[sample(1:nrow(expression), 100), ]
# scale the expression matrix
expression <- t(scale(t(expression)))

## ----message=FALSE------------------------------------------------------------
library(GSgalgoR)

## -----------------------------------------------------------------------------
# Running galgo
GSgalgoR::galgo(generations = 6, 
            population = 15, 
            prob_matrix = expression, 
            OS = OS,
    start_galgo_callback = GSgalgoR::callback_default, 
    end_galgo_callback = GSgalgoR::callback_default,
    report_callback = my_callback,      # call `my_callback()` in the mile 
                                        # of each generation/iteration.
    start_gen_callback = GSgalgoR::callback_default,
    end_gen_callback = GSgalgoR::callback_default) 


## -----------------------------------------------------------------------------
my_save_pop_callback <-
    function(userdir = "",
            generation,
            pop_pool,
            pareto,
            prob_matrix,
            current_time) {
        directory <- paste0(tempdir(), "/")
        if (!dir.exists(directory)) {
            dir.create(directory, recursive = TRUE)
        }
        filename <- paste0(directory, generation, ".rda")
        if (generation%%2 == 0){
            save(file = filename, pop_pool)
        }
        message(paste("solution file saved in",filename))
    }

## -----------------------------------------------------------------------------
# Running galgo
GSgalgoR::galgo(
    generations = 6, 
    population = 15, 
    prob_matrix = expression, 
    OS = OS,
    start_galgo_callback = GSgalgoR::callback_default, 
    end_galgo_callback = GSgalgoR::callback_default,   
    report_callback = my_callback,# call `my_callback()` 
                                #  in the middle of each generation/iteration.
    start_gen_callback = GSgalgoR::callback_default,
    end_gen_callback = my_save_pop_callback # call `my_save_pop_callback()` 
                                            # at the end of each 
                                            #   generation/iteration
    ) 

## -----------------------------------------------------------------------------
# Running galgo
GSgalgoR::galgo(
    generations = 6, 
    population = 15, 
    prob_matrix = expression, 
    OS = OS,
    start_galgo_callback = GSgalgoR::callback_default, 
    end_galgo_callback = my_save_pop_callback,
    report_callback = my_callback,  # call `my_callback()` 
                                    # in the middle of each generation/iteration
    start_gen_callback = GSgalgoR::callback_default,
    end_gen_callback = GSgalgoR::callback_default
    ) 


## ----eval=FALSE---------------------------------------------------------------
# 
# another_callback <-
#     function(userdir = "",
#             generation,
#             pop_pool,
#             pareto,
#             prob_matrix,
#             current_time) {
#     # code starts  here
# 
#     # code ends here
#     callback_base_return_pop(userdir,
#                             generation,
#                             pop_pool,
#                             prob_matrix,
#                             current_time)
#     }

## ----sess_info, eval=TRUE-----------------------------------------------------
sessionInfo()

