# Code example from 'CNORfeeder-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'CNORfeeder-vignette.Rnw'

###################################################
### code chunk number 1: installBio (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite(c("RBGL","graph","minet","CellNOptR","igraph","catnet"))


###################################################
### code chunk number 2: installPackage (eval = FALSE)
###################################################
## source("http://bioconductor.org/biocLite.R")
## biocLite("CNORfeeder")


###################################################
### code chunk number 3: installPackage2 (eval = FALSE)
###################################################
## install.packages("path_to_CNORfeeder/CNORfeeder_1.0.0.tar.gz",
##     repos=NULL, type="source")


###################################################
### code chunk number 4: loadLib (eval = FALSE)
###################################################
## library(CellNOptR)
## library(CNORfeeder)


###################################################
### code chunk number 5: getData1 (eval = FALSE)
###################################################
## # load the data already formatted as CNOlist
## data(CNOlistDREAM,package="CellNOptR")
## # load the model (PKN) already in the CNO format
## data(DreamModel,package="CellNOptR")


###################################################
### code chunk number 6: getData2 (eval = FALSE)
###################################################
## BTable <- makeBTables(CNOlist=CNOlistDREAM, k=2, measErr=c(0.1, 0))


###################################################
### code chunk number 7: linkRank (eval = FALSE)
###################################################
## Lrank <- linksRanking(CNOlist=CNOlistDREAM, measErr=c(0.1, 0), savefile=FALSE)


###################################################
### code chunk number 8: getData3 (eval = FALSE)
###################################################
## model<-preprocessing(data=CNOlistDREAM, model=DreamModel)


###################################################
### code chunk number 9: integration (eval = FALSE)
###################################################
## modelIntegr <- mapBTables2model(BTable=BTable,model=model,allInter=TRUE)


###################################################
### code chunk number 10: integLinks (eval = FALSE)
###################################################
## modelIntegr$reacID[modelIntegr$indexIntegr]


###################################################
### code chunk number 11: plotData (eval = FALSE)
###################################################
## plotModel(model=modelIntegr, CNOlist=CNOlistDREAM, indexIntegr=modelIntegr$indexIntegr)


###################################################
### code chunk number 12: weight (eval = FALSE)
###################################################
## modelIntegrWeight <- weighting(modelIntegr=modelIntegr, PKNmodel=DreamModel,
##                                CNOlist=CNOlistDREAM, integrFac=10)


###################################################
### code chunk number 13: weightPPI (eval = FALSE)
###################################################
## data(PPINigraph,package="CNORfeeder")
## data(UniprotIDdream,package="CNORfeeder")
## modelIntegrWeight <- weighting(modelIntegr=modelIntegr, PKNmodel=DreamModel,
##                                CNOlist=CNOlistDREAM, integrFac=10,
##                                UniprotID=UniprotIDdream, PPI=PPINigraph)


###################################################
### code chunk number 14: train (eval = FALSE)
###################################################
## # training to data using genetic algorithm (run longer to obtain better results)
## DreamT1opt<-gaBinaryT1W(CNOlist=CNOlistDREAM, model=modelIntegrWeight,
##                         maxGens=2, popSize=5, verbose=FALSE)


###################################################
### code chunk number 15: results1 (eval = FALSE)
###################################################
## # model
## plotModel(model=modelIntegrWeight, CNOlist=CNOlistDREAM, bString=DreamT1opt$bString)
## # data
## cutAndPlotResultsT1(model=modelIntegrWeight, CNOlist=CNOlistDREAM,
##                     bString=DreamT1opt$bString)


###################################################
### code chunk number 16: results2 (eval = FALSE)
###################################################
## # loading the necessary packages
## library(CellNOptR)
## library(MEIGOR)
## library(CNORode)
## library(doParallel)
## library(readr)
## library(infotheo)
## library(igraph)
## library(OmnipathR)
## library(CNORfeeder)
## 
## # loading the model
## data(ToyModel_Gene, package="CNORfeeder")
## # loading the data
## data(CNOlistToy_Gene, package="CNORfeeder")
## # plotting the model and the data
## plotModel(model = model, CNOlist = cnolist)
## plotCNOlist(CNOlist = cnolist)


###################################################
### code chunk number 17: results3 (eval = FALSE)
###################################################
## ## Loading database
## data(database, package="CNORfeeder")
## ## Alternatively, users can download the database from Omnipath and retain only
## ## activatory/inhibitory interactions as shown below.
## ## Please note that OmniPath is in continuous update and new links are
## ## continuously added
## 
## # interactions <- import_Omnipath_Interactions(filter_databases=
## #                                               c("SignaLink3",
## #                                               "PhosphoSite",
## #                                               "Signor"))
## # interactions = interactions[which(interactions$is_stimulation+interactions$is_inhibition==1), ]
## # database = matrix(data = , nrow = nrow(interactions), ncol = 3)
## # database[, 1] = interactions$source_genesymbol
## # database[which(interactions$is_stimulation==1), 2] = "1"
## # database[which(interactions$is_inhibition==1), 2] = "-1"
## # database[, 3] = interactions$target_genesymbol


###################################################
### code chunk number 18: results4 (eval = FALSE)
###################################################
## # set initial parameters (here parameters k and tau are optimised and n fixed to 3)
## ode_parameters=createLBodeContPars(model, LB_n = 1, LB_k = 0,
##                                    LB_tau = 0, UB_n = 3, UB_k = 1, 
##                                    UB_tau = 1, default_n = 3,
##                                    default_k = 0.5, default_tau = 0.01, 
##                                    opt_n = FALSE, opt_k = TRUE,
##                                    opt_tau = TRUE, random = TRUE)
## ## Parameter Optimization
## # essm
## paramsSSm=defaultParametersSSm()
## paramsSSm$local_solver = "DHC"
## paramsSSm$maxtime = 60;
## paramsSSm$maxeval = Inf;
## paramsSSm$atol=1e-6;
## paramsSSm$reltol=1e-6;
## paramsSSm$nan_fac=1000;
## paramsSSm$dim_refset=30;
## paramsSSm$n_diverse=1000;
## paramsSSm$maxStepSize=Inf;
## paramsSSm$maxNumSteps=10000;
## paramsSSm$transfer_function = 4;
## paramsSSm$lambda_tau=0.1
## paramsSSm$lambda_k=0.01
## paramsSSm$bootstrap=F
## paramsSSm$SSpenalty_fac=0
## paramsSSm$SScontrolPenalty_fac=0
## ## Training of the initial model
## opt_pars=parEstimationLBode(CNOlistToy_Gene, model, method="essm",
##                             ode_parameters=ode_parameters, paramsSSm=paramsSSm)
## simData = plotLBodeFitness(cnolist = CNOlistToy_Gene, model = model,
##                            ode_parameters = opt_pars, transfer_function = 4)


###################################################
### code chunk number 19: results5 (eval = FALSE)
###################################################
## # Identifying the mis-fits (measurements with mse worse than 0.05)
## indices = identifyMisfitIndices(cnolist = CNOlistToy_Gene, model = model, 
##                                 simData = simData, mseThresh = 0.05)


###################################################
### code chunk number 20: results6 (eval = FALSE)
###################################################
## # Identifying the mis-fits (measurements with mse worse than 0.05)
## indices = identifyMisfitIndices(cnolist = CNOlistToy_Gene, model = model, simData = NULL)


###################################################
### code chunk number 21: results7 (eval = FALSE)
###################################################
## # interactions from the database and from the FEED algorithm which we want to integrate
## feederObject = buildFeederObjectDynamic(model = model, cnolist = CNOlistToy_Gene, 
##                                         indices = indices, database = database, 
##                                         DDN = TRUE, pathLength = 2) # max path-length=2 
##                                                                     # for database search
## 
## integratedModel = integrateLinks(feederObject = feederObject, cnolist = CNOlistToy_Gene, 
##                                  database = database)
## 
## plotModel(model = integratedModel$model, CNOlist = CNOlistToy_Gene, 
##           indexIntegr = integratedModel$integLinksIdx)


###################################################
### code chunk number 22: results8 (eval = FALSE)
###################################################
## # interactions from the database and from the FEED algorithm which we want to integrate
## ode_parameters=createLBodeContPars(integratedModel$model, LB_n = 1, 
##                                    LB_k = 0, LB_tau = 0, UB_n = 3, 
##                                    UB_k = 1, UB_tau = 1, default_n = 3,
##                                    default_k = 0.5, default_tau = 0.01, 
##                                    opt_n = FALSE, opt_k = TRUE,
##                                    opt_tau = TRUE, random = TRUE)
## 
## res1 = runDynamicFeeder(cnolist = CNOlistToy_Gene, integratedModel = integratedModel, 
##                         ode_parameters = ode_parameters, paramsSSm = paramsSSm,
##                         penFactor_k = 2, penFactorPIN_k = 0.1, penFactor_tau = 1)
## 
## plotLBodeFitness(cnolist = res1$CNOList, model = res1$`Integrated-Model`$model, 
##                  ode_parameters = res1$Parameters, transfer_function = 4)


###################################################
### code chunk number 23: results9 (eval = FALSE)
###################################################
## # interactions from the database and from the FEED algorithm which we want to integrate
## ode_parameters=createLBodeContPars(integratedModel$model, LB_n = 1, 
##                                    LB_k = 0, LB_tau = 0, UB_n = 3, 
##                                    UB_k = 1, UB_tau = 1, default_n = 3,
##                                    default_k = 0.5, default_tau = 0.01, 
##                                    opt_n = FALSE, opt_k = TRUE,
##                                    opt_tau = TRUE, random = TRUE)
## 
## res2 = runDynamicFeeder(cnolist = CNOlistToy_Gene, integratedModel = integratedModel, 
##                         ode_parameters = ode_parameters, paramsSSm = paramsSSm, 
##                         penFactor_k = 10000, penFactorPIN_k = 10000, 
##                         penFactor_tau = 10000)
## 
## plotLBodeFitness(cnolist = res2$CNOList, model = res2$`Integrated-Model`$model, 
##                  ode_parameters = res2$Parameters, transfer_function = 4)


