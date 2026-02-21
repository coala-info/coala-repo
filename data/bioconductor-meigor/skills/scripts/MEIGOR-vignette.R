# Code example from 'MEIGOR-vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installMEIGO2, eval=FALSE, pgf=TRUE, echo=TRUE---------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
#      BiocManager::install("CellNOptR")

## ----load_package, eval=TRUE, pgf=TRUE, echo=FALSE,results='hide',warning=FALSE, message=FALSE----
library(MEIGOR)

## ----quickProblem, eval=FALSE, pgf=TRUE, echo=TRUE----------------------------
# library(MEIGOR)
# problem<-list(f=objective, x_L=rep(-1,2), x_U=rep(1,2))
# opts<-list(maxeval=500, local_solver='DHC')

## ----quickProblemSolve, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'---------
ex3<-function(x,k1,k2,k3,k4){
f=-x[4]
# Equality constraints (declared before the inequality ones)
g<-rep(0,5);
g[1]=x[4]-x[3]+x[2]-x[1]+k4*x[4]*x[6]
g[2]=x[1]-1+k1*x[1]*x[5]
g[3]=x[2]-x[1]+k2*x[2]*x[6]
g[4]=x[3]+x[1]-1+k3*x[3]*x[5]

# Inequality constraint
g[5]=x[5]^0.5+x[6]^0.5
return(list(f=f,g=g))
}

## ----invokeex3, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'-----------------
ex3(c(1,1,1,1,1,1),0.2,0.5,-0.1,0.9)

## ----multiStart, eval=FALSE, pgf=TRUE, echo=TRUE------------------------------
# Results_multistart<-MEIGO(problem,opts,algorithm="MULTISTART",p1,p2,...)

## ----unConstrainedF, eval=TRUE, pgf=TRUE, echo=TRUE, results='hide'-----------
ex1 <- function(x){
y<-4*x[1]*x[1]-2.1*x[1]^4+1/3*x[1]^6+x[1]*x[2]-4*x[2]*x[2]+4*x[2]^4;
return(y)
}

## ----unConstrainedSolve, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'--------
#=========================
#PROBLEM SPECIFICATIONS
# ========================
problem<-list(f="ex1",x_L=rep(-1,2),x_U=rep(1,2))
opts<-list(maxeval=500, ndiverse=40, local_solver='DHC',
local_finish='LBFGSB', local_iterprint=1)
#===============================
# END OF PROBLEM SPECIFICATIONS
#===============================
Results<-MEIGO(problem,opts,algorithm="ESS")

## ----ex2F, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'----------------------
ex2<-function(x){
F=-x[1]-x[2]
g<-rep(0,2)
g[1]<-x[2]-2*x[1]^4+8*x[1]^3-8*x[1]^2
g[2]<-x[2]-4*x[1]^4+32*x[1]^3-88*x[1]^2+96*x[1]
return(list(F=F,g=g))
}

## ----ex2Solve, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'------------------
#=========================
#PROBLEM SPECIFICATIONS
#=========================
problem<-list(f="ex2",x_L=rep(0,2),x_U=c(3,4),
c_L=rep(-Inf,2), c_U=c(2,36))
opts<-list(maxeval=750, local_solver="DHC", local_n1=2, local_n2=3)
#=============================
#END OF PROBLEM SPECIFICATIONS
# ============================
Results<-MEIGO(problem,opts,algorithm="ESS")

## ----ex3f, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'----------------------
ex3<-function(x,k1,k2,k3,k4){
f=-x[4]
#Equality constraints
	g<-rep(0,5)
	g[1]=x[4]-x[3]+x[2]-x[1]+k4*x[4]*x[6]
	g[2]=x[1]-1+k1*x[1]*x[5]
	g[3]=x[2]-x[1]+k2*x[2]*x[6]
	g[4]=x[3]+x[1]-1+k3*x[3]*x[5]

#Inequality constraint
	g[5]=x[5]^0.5+x[6]^0.5
	return(list(f=f,g=g))
}

## ----ex2Solve3, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide', warning=FALSE----
#=========================
#PROBLEM SPECIFICATIONS
#=========================
problem<-list(f="ex3",x_L=rep(0,6),x_U=c(rep(1,4),16,16),
neq=4, c_L=-Inf, c_U=4)
opts<-list(maxtime=5, local_solver='solnp')
#=============================
#END OF PROBLEM SPECIFICATIONS
#=============================
k1=0.09755988
k3=0.0391908
k2=0.99*k1
k4=0.9*k3
Results<-MEIGO(problem,opts,algorithm="ESS",k1,k2,k3,k4)

## ----ex4f, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'----------------------
	ex4<-function(x){
		F = x[2]^2 + x[3]^2 + 2.0*x[1]^2 + x[4]^2 - 5.0*x[2] - 5.0*x[3] - 21.0*x[1] + 7.0*x[4]
		g<-rep(0,3)
		g[1] = x[2]^2 + x[3]^2 + x[1]^2 + x[4]^2 + x[2] - x[3] + x[1] - x[4]
		g[2] = x[2]^2 + 2.0*x[3]^2 + x[1]^2 + 2.0*x[4]^2 - x[2] - x[4]
		g[3] = 2.0*x[2]^2 + x[3]^2 + x[1]^2 + 2.0*x[2] - x[3] - x[4]
		return(list(F=F, g=g))
	}

## ----ex4main, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'-------------------
#========================= PROBLEM SPECIFICATIONS ===========================
problem<-list(f="ex4", x_L=rep(0,4), x_U=rep(10,4), x_0=c(3,4,5,1),
int_var=3, c_L=rep(-Inf,3), c_U=c(8,10,5))
opts<-list(maxtime=2)
#========================= END OF PROBLEM SPECIFICATIONS =====================
Results<-MEIGO(problem,opts,algorithm="ESS")

## ----ex3solve, eval=FALSE, pgf=TRUE, echo=TRUE,results='hide'-----------------
# #=========================
# #PROBLEM SPECIFICATIONS
# #=========================
# problem<-list(f="ex3",x_L=rep(0,6),x_U=c(rep(1,4),16,16),
# neq=4, c_L=-Inf, c_U=4)
# opts<-list(ndiverse=10, local_solver='SOLNP', local_tol=3)
# #=============================
# #END OF PROBLEM SPECIFICATIONS
#  #============================
# k1=0.09755988
# k3=0.0391908
# k2=0.99*k1
# k4=0.9*k3
# Results<-MEIGO(problem,opts,algorithm="multistart",k1,k2,k3,k4)

## ----sourceRosen10, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'-------------
rosen10<-function(x){
		f<-0
		n=length(x)
		for (i in 1:(n-1)){
			f <- f + 100*(x[i]^2 - x[i+1])^2 + (x[i]-1)^2
		}
		return(f)
	}

nvar<-10

## ----rosen10settings, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'-----------
problem<-list(f="rosen10", x_L=rep(-5,nvar), x_U=rep(1,nvar))

## ----algVNS, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'--------------------
algorithm="VNS"

## ----vnsOPts, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'-------------------
opts<-list(maxeval=2000, maxtime=3600*69, use_local=1,
	 aggr=0, local_search_type=1, decomp=1, maxdist=0.5)

## ----vnsCallMEIGO, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide'--------------
Results<-MEIGO(problem,opts,algorithm)

## ----options, eval=FALSE, pgf=TRUE, echo=TRUE---------------------------------
# opts=list();
# opts[[1]]$maxeval<-value1
# opts[[2]]$maxeval<-value2
# opts[[3]]$maxeval<-value3

## ----ceSSexample, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide', warning=FALSE, message=FALSE----
rosen10<-function(x){
	f<-0
	n=length(x)
	for (i in 1:(n-1)){
		 f <- f + 100*(x[i]^2 - x[i+1])^2 + (x[i]-1)^2
	}
	return(f)
}

nvar=20
problem<-list(f=rosen10, x_L=rep(-1000,nvar), x_U=rep(1000,nvar))

#Set 1 nodes and 2 cpu's per node
n_nodes=1
n_cpus_per_node=3

#Set different values for dim_refset, bal and n2
#for each of the 10 cpu's to be used
dim1 = 23;     bal1 = 0;     n2_1 = 0;
dim2 = 33;     bal2 = 0;     n2_2 = 0;
dim3 = 46;     bal3 = 0;     n2_3 = 2;
dim4 = 56;     bal4 = 0;     n2_4 = 4;
dim5 = 72;     bal5 = 0.25;  n2_5 = 7;
dim6 = 72;     bal6 = 0.25;  n2_6 = 10;
dim7 = 88;     bal7 = 0.25;  n2_7 = 15;
dim8 = 101;    bal8 = 0.5;   n2_8 = 20;
dim9 = 111;    bal9 = 0.25;  n2_9 = 50;
dim10 = 123;   bal10 = 0.25; n2_10 = 100;

opts_dim=c(dim1,dim2,dim3,dim4,dim5,dim6,dim7,dim8,dim9,dim10)
opts_bal=c(bal1,bal2,bal3,bal4,bal5,bal6,bal7,bal8,bal9,bal10)
opts_n2=c(n2_1,n2_2,n2_3,n2_4,n2_5,n2_6,n2_7,n2_8,n2_9,n2_10)
D=10

#Initialize counter and options
counter=0
opts=list()
hosts=c()

for(i in 1:n_nodes){
  for(j in 1:n_cpus_per_node){

    counter=counter+1

    #Set the name of every thread
    if(i<10)hosts=c(hosts,paste('node0',i,sep=""))
    if(i>=10 && i<100)hosts=c(hosts,paste('node',i,sep=""))

    opts[[counter]]=list()

    #Set specific options for each thread
    opts[[counter]]$local_balance  	=	opts_bal[counter]
    opts[[counter]]$dim_refset     	= 	opts_dim[counter]
    opts[[counter]]$local_n2		=	opts_n2[counter]

    #Set common options for each thread

    opts[[counter]]$maxeval			=	10000
    opts[[counter]]$local_solver	=	"dhc"

    #Options not set will take default values for every thread

  }
}

#Set the address of each machine, defined inside the 'for' loop
opts$hosts=c('localhost','localhost','localhost')

#Do not define the additional options for cooperative methods (e.g., ce_maxtime, ce_isparallel, etc..)
#They will take their default values
opts$ce_niter=5
opts$ce_type="SOCKS"
opts$ce_isparallel=TRUE

#Call the solver
Results<-MEIGO(problem,opts,algorithm="CeSSR")

## ----ceVNSexample, eval=TRUE, pgf=TRUE, echo=TRUE,results='hide', warning=FALSE, message=FALSE----
rosen10<-function(x){
		f<-0
		n=length(x)
		for (i in 1:(n-1)){
			f <- f + 100*(x[i]^2 - x[i+1])^2 + (x[i]-1)^2
		}
		return(f)
	}

nvar=20

problem<-list(f=rosen10, x_L=rep(-1000,nvar), x_U=rep(1000,nvar))

opts=list()
opts[[1]]=list(use_local=1,aggr=1,local_search=1,decomp=1,maxdist=0.8,maxeval=2000)
opts[[2]]=list(use_local=1,aggr=0,local_search=2,decomp=0,maxdist=0.5,maxeval=2000)
opts[[3]]=list(use_local=1,aggr=0,local_search=2,decomp=0,maxdist=0.5,maxeval=2000)
opts[[4]]=list(use_local=1,aggr=0,local_search=2,decomp=0,maxdist=0.5,maxeval=2000)

opts$hosts=c('localhost','localhost','localhost','localhost')

opts$ce_niter=10
opts$ce_type="SOCKS"
opts$ce_isparallel= TRUE

Results=MEIGO(problem,opts, algorithm="CeVNSR")

## ----CNORodeExampleFig,include=TRUE,echo=TRUE,results='hide', message=FALSE, fig.align = 'center', fig.cap = "Plot of the experimental data for the CNORode example."----
library(MEIGOR)
library(CNORode)
data("CNORodeExample",package="MEIGOR")
plotCNOlist(cnolist)

## ----CNORodeExampleFigModel,include=TRUE,echo=FALSE,results='hide', fig.align = 'center', fig.cap = "The model structure for the CNORode example."----
plotModel(model, cnolist)

## ----CNORodeExampleInitial, include=TRUE, echo=FALSE,results='hide', warning = FALSE, fig.align = 'center', fig.cap = "Fit for the initial (random) solution provided to the optimization solver. The simulation is ploted against the experimental data."----
initial_pars=createLBodeContPars(model, LB_n = 1, LB_k = 0.09,
	LB_tau = 0.1, UB_n = 5, UB_k = 0.95, UB_tau = 10, random = TRUE)

simData=plotLBodeFitness(cnolist, model,initial_pars,
		reltol = 1e-05, atol = 1e-03, maxStepSize = 0.01)

## ----CNORodeExamplePptimize, eval=TRUE,echo=TRUE,results='hide'---------------
f_hepato<-getLBodeContObjFunction(cnolist, model, initial_pars, indices=NULL,
 time = 1, verbose = 0, transfer_function = 3, reltol = 1e-04, atol = 1e-03,
maxStepSize =Inf, maxNumSteps = 1e4, maxErrTestsFails = 50, nan_fac = 5)

## ----CNORodeExampleDefineProb, eval=TRUE,echo=TRUE,results='hide'-------------
n_pars=length(initial_pars$LB)
problem<-list(f=f_hepato, x_L=initial_pars$LB[initial_pars$index_opt_pars],
	x_U=initial_pars$UB[initial_pars$index_opt_pars],x_0=initial_pars$LB[initial_pars$index_opt_pars])

## ----CNORodeExampleDefineOpts, eval=TRUE,echo=TRUE,results='hide'-------------
opts<-list(maxeval=100, local_solver=0,ndiverse=10,dim_refset=6)

## ----CNORodeExample2, eval=TRUE,echo=TRUE,results='hide'----------------------
Results<-MEIGO(problem,opts,algorithm="ESS")

## ----CNORodeExampleOptPlot,include=TRUE,echo=FALSE,results='hide', warning=FALSE, fig.align = 'center', fig.cap = "Fitness of the solution obtained by the eSS in the CNORode parameter estimation problem."----
opt_pars=initial_pars;
opt_pars$parValues=Results$xbest;
simData=plotLBodeFitness(cnolist, model,opt_pars,
	reltol = 1e-05, atol = 1e-03, maxStepSize = 0.01)

## ----CellNOptRExampleCnolist, include=TRUE,echo=FALSE,results='hide',warning=FALSE, fig.align = 'center', fig.cap = "Pseudo-experimental data for the CellNOptR (Boolean logic) example. Each row corresponds to a different experiment upon pertubation with different stimuli and inhibitors."----
library(MEIGOR)
library(CellNOptR)
data("CellNOptR_example",package="MEIGOR")
cnolist=CNOlist(cnolist_cellnopt)
plotCNOlist(cnolist)

## ----CellNOptRExampleFig,include=TRUE,echo=FALSE,results='hide', warning=FALSE, fig.align = 'center', fig.cap = "The expanded model for the CellNOptR (Boolean logic) example. This representation contains all possible logic gates where each binary decision variable corrersponds to an hyperedge/logical disjunction."----
model <- preprocessing(cnolist, model_cellnopt, expansion=TRUE, compression=TRUE, verbose=FALSE)
plotModel(model, cnolist)

## ----CellNOptRPrepFigModel, eval=TRUE, pgf=TRUE, echo=TRUE, results='hide'----
get_fobj<- function(cnolist,model){

	f<-function(x,model1=model,cnolist1=cnolist){
		simlist=prep4sim(model1)
		score=computeScoreT1(cnolist1, model1, x)
		return(score)
	}
}
fobj=get_fobj(cnolist,model)

## ----CellNOptRPrep3, eval=TRUE, pgf=TRUE, echo=TRUE, results='hide'-----------
nvar=16

problem<-list(f=fobj, x_L=rep(0,nvar), x_U=rep(1,nvar))
opts<-list(maxeval=2000, maxtime=30, use_local=1,
	aggr=0, local_search_type=1, decomp=1, maxdist=0.5)

## ----CellNOptR4, eval=TRUE, pgf=TRUE, echo=TRUE, results='hide'---------------
Results<-MEIGO(problem,opts,"VNS")

## ----CellNOptRExamplePlotOptModel,include=TRUE,echo=FALSE,results='hide', warning=FALSE, fig.align = 'center', fig.cap = "The Boolean logic model obtained after optimization with VNS."----
optModel=cutModel(model,Results$xbest)
plotModel(optModel,cnolist)

