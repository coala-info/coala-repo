# Code example from 'CNORode-vignette' vignette. See references/ for full tutorial.

## ----preliminaries, eval=TRUE, results='hide', include=FALSE, echo=FALSE----
options(width=70, useFancyQuotes="UTF-8", prompt=" ", continue="  ")

## ----installCNOR, eval=FALSE, pgf=TRUE, echo=TRUE-------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# if (!requireNamespace("CNORode", quietly=TRUE))
# 	BiocManager::install("CNORode")

## ----installMEIGOR, eval=FALSE--------------------------------------
# # MEIGOR is deprecated in Bioc in 3.18
# #BiocManager::install("MEIGOR")
# if (!requireNamespace("MEIGOR", quietly=TRUE))
#     remotes::install_github("https://github.com/jaegea/MEIGOR/tree/RELEASE_3_18")

## ----installCNORode2, eval=TRUE-------------------------------------
library(CNORode)

## ----quickstart, eval=TRUE, results='hide'--------------------------
	library(CNORode)
	model=readSIF(system.file("extdata", "ToyModelMMB_FeedbackAnd.sif",
		package="CNORode",lib.loc = .libPaths()));
	cno_data=readMIDAS(system.file("extdata", "ToyModelMMB_FeedbackAnd.csv",
		package="CNORode",lib.loc = .libPaths()));
	cnolist=makeCNOlist(cno_data,subfield=FALSE);

## -------------------------------------------------------------------
	ode_parameters=createLBodeContPars(model, LB_n = 1, LB_k = 0.1,
		LB_tau = 0.01, UB_n = 5, UB_k = 0.9, UB_tau = 10, default_n = 3,
		default_k = 0.5, default_tau = 1, opt_n = TRUE, opt_k = TRUE,
		opt_tau = TRUE, random = FALSE)

## -------------------------------------------------------------------
	print(ode_parameters)

## ----label=plotModelSim,include=TRUE,fig=TRUE-----------------------
modelSim=plotLBodeModelSim(cnolist = cnolist, model, ode_parameters,
 	timeSignals=seq(0,2,0.5));

## ----eval=TRUE, results='hide',fig.keep = "last"--------------------
initial_pars=createLBodeContPars(model, LB_n = 1, LB_k = 0.1,
	LB_tau = 0.01, UB_n = 5, UB_k = 0.9, UB_tau = 10, random = TRUE)
#Visualize initial solution
simulatedData=plotLBodeFitness(cnolist, model,initial_pars)

## ----eval=TRUE, results='hide',fig.keep = "last"--------------------
paramsGA = defaultParametersGA()
paramsGA$maxStepSize = 1
paramsGA$popSize = 50
paramsGA$iter = 100
paramsGA$transfer_function = 2
paramsGA$monitor = FALSE
opt_pars=parEstimationLBode(cnolist,model,ode_parameters=initial_pars,
	paramsGA=paramsGA)

## ----eval=TRUE, results='hide',fig.keep = "last"--------------------
#Visualize fitted solution
simulatedData=plotLBodeFitness(cnolist, model,ode_parameters=opt_pars)

## ----eval=FALSE, results='hide'-------------------------------------
# 
# requireNamespace("MEIGOR")
# 
# 
# initial_pars=createLBodeContPars(model,
# 	LB_n = 1, LB_k = 0.1, LB_tau = 0.01, UB_n = 5,
# 	UB_k = 0.9, UB_tau = 10, random = TRUE)
# #Visualize initial solution
# 
# fit_result_ess =
# 	parEstimationLBodeSSm(cnolist = cnolist,
# 						  model = model,
# 						  ode_parameters = initial_pars,
# 						  maxeval = 1e5,
# 						  maxtime = 20,
# 						  local_solver = "DHC",
# 						  transfer_function = 3
# 	)
# #Visualize fitted solution
# # simulatedData=plotLBodeFitness(cnolist, model,ode_parameters=fit_result_ess)

## ----label=plotInit,include=TRUE,fig=TRUE---------------------------
	simulatedData=plotLBodeFitness(cnolist, model,
								   initial_pars,
								   transfer_function = 3)

## ----label=plotFinalFit_fit,eval = FALSE----------------------------
# 	simulatedData=plotLBodeFitness(cnolist, model,
# 								   ode_parameters=fit_result_ess,
# 								   transfer_function = 3)

## ----eval=FALSE-----------------------------------------------------
# library(MEIGOR)
# f_hepato<-getLBodeContObjFunction(cnolist, model, initial_pars, indices=NULL,
#  time = 1, verbose = 0, transfer_function = 2, reltol = 1e-05, atol = 1e-03,
# maxStepSize = Inf, maxNumSteps = 1e4, maxErrTestsFails = 50, nan_fac = 1)
# n_pars=length(initial_pars$LB);
# 
# problem<-list(f=f_hepato, x_L=initial_pars$LB[initial_pars$index_opt_pars],
# 	x_U=initial_pars$UB[initial_pars$index_opt_pars]);
# 
# #Source a function containing the options used in the CeSSR publication
#  source(system.file("benchmarks","get_paper_settings.R",package="MEIGOR"))
# #Set max time as 20 seconds per iteration
# opts<-get_paper_settings(20);
# Results<-CeSSR(problem,opts,Inf,Inf,3,TRUE,global_save_list=c('cnolist','model',
# 'initial_pars'))

## ----eval=FALSE-----------------------------------------------------
# library(CellNOptR)
# library(CNORode)
# library(MEIGOR)
# 
# # MacNamara et al. 2012 case study:
# data(PKN_ToyPB, package="CNORode")
# data(CNOlist_ToyPB, package="CNORode")
# 
# # original and preprocessed network
# plotModel(pknmodel, cnodata)
# model = preprocessing(data = cnodata, model = pknmodel,
#                       compression = T, expansion = T)
# plotModel(model, cnodata)
# plotCNOlist(CNOlist = cnodata)
# 
# # set initial parameters
# ode_parameters=createLBodeContPars(model, LB_n = 1, LB_k = 0,
#                                    LB_tau = 0, UB_n = 4, UB_k = 1,
#                                    UB_tau = 1, default_n = 3, default_k = 0.5,
#                                    default_tau = 0.01, opt_n = FALSE, opt_k = TRUE,
#                                    opt_tau = TRUE, random = TRUE)
# 
# ## Parameter Optimization
# # essm
# paramsSSm=defaultParametersSSm()
# paramsSSm$local_solver = "DHC"
# paramsSSm$maxtime = 600;
# paramsSSm$maxeval = Inf;
# paramsSSm$atol=1e-6;
# paramsSSm$reltol=1e-6;
# paramsSSm$nan_fac=0;
# paramsSSm$dim_refset=30;
# paramsSSm$n_diverse=1000;
# paramsSSm$maxStepSize=Inf;
# paramsSSm$maxNumSteps=10000;
# transferFun=4;
# paramsSSm$transfer_function = transferFun;
# 
# paramsSSm$lambda_tau=0
# paramsSSm$lambda_k=0
# paramsSSm$bootstrap=F
# paramsSSm$SSpenalty_fac=0
# paramsSSm$SScontrolPenalty_fac=0
# 
# # run the optimisation algorithm
# opt_pars=parEstimationLBode(cnodata,model, method="essm",
#                             ode_parameters=ode_parameters, paramsSSm=paramsSSm)
# plotLBodeFitness(cnolist = cnodata, model = model,
#                  ode_parameters = opt_pars, transfer_function = 4)
# 
# # 10-fold crossvalidation using T1 data
# # We use only T1 data for crossvalidation, because data
# # in the T0 matrix is not independent.
# # All rows of data in T0 describes the basal condition.
# 
# # Crossvalidation produce some text in the command window:
# library(doParallel)
# registerDoParallel(cores=3)
# R=crossvalidateODE(CNOlist = cnodata, model = model,
#                    type="datapoint", nfolds=3, parallel = TRUE,
#                    ode_parameters = ode_parameters, paramsSSm = paramsSSm)

