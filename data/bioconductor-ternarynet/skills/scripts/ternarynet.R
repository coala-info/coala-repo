# Code example from 'ternarynet' vignette. See references/ for full tutorial.

### R code from vignette source 'ternarynet.Rnw'

###################################################
### code chunk number 1: ternarynet.Rnw:44-45
###################################################
library(ternarynet)


###################################################
### code chunk number 2: ternarynet.Rnw:116-191
###################################################

library(ternarynet)

i_exp <- as.integer(c(0,0,0, 0,0,0, 0,0,0, 0,0,0,
                        1,1,1, 1,1,1, 1,1,1, 1,1,1,
                        2,2,2, 2,2,2, 2,2,2, 2,2,2,
                        3,3,3, 3,3,3, 3,3,3, 3,3,3,
                        4,4,4, 4,4,4, 4,4,4, 4,4,4,
                        5,5,5, 5,5,5, 5,5,5, 5,5,5,
                        6,6,6, 6,6,6, 6,6,6, 6,6,6,
                        7,7,7, 7,7,7, 7,7,7, 7,7,7))

i_node <- as.integer(c(0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3,
                        0,0,0, 1,1,1, 2,2,2, 3,3,3))

outcome <- as.integer(c(-1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1,
                        -1,0,1, -1,0,1, -1,0,1, -1,0,1))

value <- c(0,1,2, 0,1,2, 0,1,2, 0,1,2,
            2,1,0, 0,1,2, 0,1,2, 0,1,2,
            2,1,0, 2,1,0, 0,1,2, 0,1,2,
            2,1,0, 2,1,0, 2,1,0, 0,1,2,
            2,1,0, 2,1,0, 2,1,0, 2,1,0,
            0,1,2, 2,1,0, 2,1,0, 2,1,0,
            0,1,2, 0,1,2, 2,1,0, 2,1,0,
            0,1,2, 0,1,2, 0,1,2, 2,1,0)

is_perturbation <- 
c(TRUE,TRUE,TRUE,  FALSE,FALSE,FALSE, FALSE,FALSE,FALSE, FALSE,FALSE,FALSE,
    FALSE,FALSE,FALSE,  TRUE,TRUE,TRUE, FALSE,FALSE,FALSE, FALSE,FALSE,FALSE,
    FALSE,FALSE,FALSE,  FALSE,FALSE,FALSE, TRUE,TRUE,TRUE, FALSE,FALSE,FALSE,
    FALSE,FALSE,FALSE,  FALSE,FALSE,FALSE, FALSE,FALSE,FALSE, TRUE,TRUE,TRUE,
    TRUE,TRUE,TRUE,  FALSE,FALSE,FALSE, FALSE,FALSE,FALSE, FALSE,FALSE,FALSE,
    FALSE,FALSE,FALSE,  TRUE,TRUE,TRUE, FALSE,FALSE,FALSE, FALSE,FALSE,FALSE,
    FALSE,FALSE,FALSE,  FALSE,FALSE,FALSE, TRUE,TRUE,TRUE, FALSE,FALSE,FALSE,
    FALSE,FALSE,FALSE,  FALSE,FALSE,FALSE, FALSE,FALSE,FALSE, TRUE,TRUE,TRUE)

indata <- data.frame(i_exp,i_node,outcome,value,is_perturbation)

results <- parallelFit(indata,
                        max_parents=1,
                        n_cycles=100000,
                        n_write=10,
                        T_lo=0.001,
                        T_hi=2.0,
                        target_score=0,
                        n_proc=1,
                        logfile='try.log')

lowest_temp_results <- results[[1]]

print('Unnormalized score:')
print(lowest_temp_results$unnormalized_score)

print('Normalized score:')
print(lowest_temp_results$normalized_score)

print('Parents:')
print(lowest_temp_results$parents)

print('Outcomes:')
print(lowest_temp_results$outcomes)



###################################################
### code chunk number 3: ternarynet.Rnw:199-225
###################################################
results <- parallelFit(indata,
                        max_parents=1,
                        n_cycles=10,
                        n_write=10,
                        T_lo=0.001,
                        T_hi=2.0,
                        target_score=0,
                        n_proc=1,
                        logfile='try.log',
                        init_parents=lowest_temp_results$parents,
                        init_outcomes=lowest_temp_results$outcomes)

lowest_temp_results <- results[[1]]

print('Unnormalized score:')
print(lowest_temp_results$unnormalized_score)

print('Normalized score:')
print(lowest_temp_results$normalized_score)

print('Parents:')
print(lowest_temp_results$parents)

print('Outcomes:')
print(lowest_temp_results$outcomes)



###################################################
### code chunk number 4: ternarynet.Rnw:229-230
###################################################
sessionInfo()


