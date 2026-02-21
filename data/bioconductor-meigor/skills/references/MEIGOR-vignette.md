# MEIGOR: a software suite based on metaheuristics for global optimization in systems biology and bioinformatics

Jose A. Egea1\*, David Henriques2, Thomas Cokelaer3, Alejandro F. Villaverde4, Julio R. Banga5\*\* and Julio Saez-Rodriguez6\*\*\*

1Centro de Edafología y Biología Aplicada del Segura, Murcia, Spain
2Instituto de Investigaciones Marinas-CSIC, Vigo, Spain
3Institute Pasteur, Paris, France
4University of Vigo, Vigo, Spain
5Misión Biolóxica de Galicia, Pontevedra, Spain
6Universität Heidelberg, Heidelberg, Germany

\*jaegea@cebas.csic.es
\*\*j.r.banga@csic.es
\*\*\*pub.saez@uni-heidelberg.de

#### 30/10/2025

#### Package

MEIGOR 1.44.0

# Contents

* [1 Introduction](#introduction)
* [2 Installing *MEIGOR*](#installing-meigor)
* [3 Continuous and mixed-integer problems: Enhanced Scatter Search (*eSSR*)](#continuous-and-mixed-integer-problems-enhanced-scatter-search-essr)
  + [3.1 Quick start: How to carry out an optimization with *SSR*](#quick-start-how-to-carry-out-an-optimization-with-ssr)
  + [3.2 *eSSR* usage](#ess-usage)
    - [3.2.1 Problem definition](#problem-definition)
    - [3.2.2 User options](#user-options)
    - [3.2.3 Global options](#global-options)
    - [3.2.4 Local options](#localopts)
    - [3.2.5 Output](#essroutput)
    - [3.2.6 Guidelines for using *eSSR*](#guidelines-for-using-essr)
    - [3.2.7 Extra tool: *essR\_multistart*](#extra-tool-essr_multistart)
  + [3.3 Examples](#examples)
    - [3.3.1 Unconstrained problem](#unconstrained-problem)
    - [3.3.2 Constrained problem](#constrained-problem)
    - [3.3.3 Constrained problem with equality constraints](#useparam1)
    - [3.3.4 Mixed integer problem](#mixed-integer-problem)
    - [3.3.5 *essR\_multistart* application](#essr_multistart-application)
* [4 Integer optimization: Variable Neighbourhood Search (*VNSR*)](#integer-optimization-variable-neighbourhood-search-vnsr)
  + [4.1 Quick start: How to carry out an optimization with *VNSR*](#quick-start-how-to-carry-out-an-optimization-with-vnsr)
  + [4.2 *VNSR* usage](#vns-usage)
    - [4.2.1 Problem definition](#vns-problem)
    - [4.2.2 *VNSR* options](#vns-options)
    - [4.2.3 Output](#vnsr-output)
  + [4.3 Guidelines for using *VNSR*](#guidelines-for-using-vnsr)
  + [4.4 Application example](#application-example)
* [5 Parallel computation in *MEIGO*](#parallel-computation-in-meigo)
  + [5.1 Quick notes about the parallel computing packages](#quick-notes-about-the-parallel-computing-packages)
    - [5.1.1 Snowfall](#snowfall)
  + [5.2 Usage](#usage)
    - [5.2.1 Options](#options)
    - [5.2.2 Output](#output)
  + [5.3 *CeSSR* application example](#cessr-application-example)
* [6 *CeVNSR* application example](#cevnsr-application-example)
* [7 Applications from Systems Biology](#applications-from-systems-biology)
  + [7.1 Using eSS to fit a dynamic model](#using-ess-to-fit-a-dynamic-model)
  + [7.2 Using VNS to optimize logic models](#using-vns-to-optimize-logic-models)
* [References](#references)

# 1 Introduction

*MEIGO* is an optimization suite programmed in R which implements metaheuristics for solving different nonlinear optimization problems in both continuous and integer domains arising in systems biology, bioinformatics and other areas. It consists of two main metaheuristics: the enhanced scatter search method, *eSSR* (Egea et al. [2009](#ref-Egea_et_al:09); Egea, Martí, and Banga [2010](#ref-Egea_et_al:10)) for continuous and mixed-integer problems, and the variable neighbourhood search metaheuristic (Hansen, Mladenović, and Moreno-Pérez [2010](#ref-Hansen_Mladenovic_Moreno-Perez:10)), for integer problems.

Metaheuristics are useful for solving problems that due to its complexity cannot be solved by deterministic global optimization solvers or where the usage of a local solver systematically converges to a local solutions. Metaheuristics do not guarantee optimality but are usually efficient in locating the vicinity of the global solution in modest computational time.

Both *eSS* and *VNS* are hybrid solvers. This means that the stochastic optimization methods are combined with local solvers to improve the efficiency. They have been implemented in R and can be invoked within the *MEIGO* framework. This manual describes both methods, their corresponding parallelizable versions, and guides the users to implement their own optimization problems and to choose the best set of options for a particular instance.

# 2 Installing *MEIGOR*

MEIGOR can be installed from Bioconductor by typing:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
     BiocManager::install("CellNOptR")
```

# 3 Continuous and mixed-integer problems: Enhanced Scatter Search (*eSSR*)

*eSSR* is an R implementation of the enhanced scatter search method (Egea et al. [2009](#ref-Egea_et_al:09); Egea, Martí, and Banga [2010](#ref-Egea_et_al:10)) which is part of the *MEIGO* toolbox for global optimization in bioinformatics. It is a metaheuristic which seeks the global minimum of mixed-integer nonlinear programming (MINLP) problems specified by

\[\begin{equation}
\min\limits\_{x}f(x,p\_1,p\_2,...,p\_n)
\end{equation}\]

subject to

\begin{aligned}
c\_{eq}=0 \
c\_Lc(x)c\_U\
x\_Lxx\_U
\end{aligned}

where \(x\) is the vector of decision variables, and \(x\_L\) and \(x\_U\) its respective bounds. \(p\_1,\ldots,p\_n\) are optional extra input parameters to be passed to the objective function (see example in Section [3.3.3](#useparam1)). \(c\_{eq}\) is a set of equality constraints. \(c(x)\) is a set of inequality constraints with lower and upper bounds, \(c\_L\) and \(c\_U\). Finally, \(f(x,p\_1,p\_2,...,p\_n)\) is the objective function to be minimized.

## 3.1 Quick start: How to carry out an optimization with *SSR*

```
library(MEIGOR)
problem<-list(f=objective, x_L=rep(-1,2), x_U=rep(1,2))
opts<-list(maxeval=500, local_solver='DHC')
```

Type **`Results<-MEIGO(problem,opts,algorithm="ESS"`** If your problem has additional constant parameters to be passed to the objective function, they are declared as input parameters after “opts”(e.g., type **`Results<-MEIGO(problem,opts,algorithm="ESS",p1,p2)`** if your model has two extra input parameters, \(p\_1\) and \(p\_2\)).

Regarding the objective function, the input parameter is the decision vector (with extra parameters \(p\_1, p\_2,\ldots, p\_n\) if they were defined before calling the solver). The objective function must provide a scalar output parameter (the objective function value) and, for constrained problems, a second output parameter, which is a vector containing the values of the constraints. For problems containing equality constraints (\(=0\)), they must be defined before the inequality constraints. For a quick reference, consider the following example which will be later extended in section [3.3.3](#useparam1).

\begin{aligned}
\_{x}f(x)=-x\_4
\end{aligned}

subject to

\begin{aligned}
x\_4 - x\_3 + x\_2 - x\_1 + k\_4x\_4x\_6 = 0\
x\_1 - 1 + k\_1x\_1x\_5 = 0\
x\_2 - x\_1 + k\_2x\_2x\_6 = 0\
x\_3 + x\_1 - 1 + k\_3x\_3x\_5 = 0\
x\_5^{0.5} + x\_6^{0.5} 4\
0 x\_1, x\_2, x\_3, x\_4 1\
0 x\_5, x\_6 16
\end{aligned}

with \(k\_1\), \(k\_2\), \(k\_3\), \(k\_4\) being extra parameters defined before calling the solver. The objective function for this problem would be:

```
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
```

This objective function can be invoked like the code below. Let us assume that \(x\) has dimension 6 and we want the value 1 for each dimension. We also define the 4 extra input parameter \(k\_1\) to \(k\_4\) with values `0.2, 0.5, -0.1, 0.9`, respectively.

```
ex3(c(1,1,1,1,1,1),0.2,0.5,-0.1,0.9)
```

## 3.2 *eSSR* usage

### 3.2.1 Problem definition

To solve an optimization problem with *eSSR*, a list (named **problem** here) containing the following fields must be defined:

* **f**: String containing the name of the objective function.
* **x\_L**: Vector containing the lower bounds of the variables.
* **x\_U**: Vector containing the upper bounds of the variables.

Besides, there are two optional fields

* **x\_0**: Vector or matrix containing the given initial point(s).
* **f\_0**: Function values of the initial point(s). These values MUST correspond to feasible points.
* **vtr**: Objective function value to be reached.

If the problem contains additional constraints and/or integer or binary variables, the following fields should also be defined:

* **neq**111 In problems with equality constraints they must be declared first before inequality constraints (See example [3.3.3](#useparam1)): Number of equality (\(=0\)) constraints.
* **c\_L**: Vector defining the lower bounds of the inequality constraints.
* **c\_U**: Vector defining the upper bounds of the inequality constraints.
* **int\_var**222 For mixed integer problems, the variables must be defined in the following order: [cont., int., bin.]: Number of integer variables.
* **bin\_var**: Number of binary variables.

### 3.2.2 User options

The user may define a set of different options related to the optimization problem. They are defined in another list (named **opts** here) which has the following fields:

* **maxeval**: Maximum number of function evaluations (default: 1000).
* **maxtime**: Maximum CPU time in seconds (default: 60).
* **iterprint**: Print information on the screen after each iteration. 0: Deactivated; 1: Activated (default: 1).
* **weight**: Weight that multiplies the penalty term added to the objective function in constrained problems (default: \(10^6\)).
* **log\_var**: Indexes of the variables which will be analyzed using a logarithmic distribution instead of a uniform one333 Useful when the bounds of a decision variables have different orders of magnitude and they are both positive. (default: numeric(0)).
* **tolc**: Maximum constraint violation allowed. This is also used as a tolerance for the local search (default: \(10^{-5}\)).
* **prob\_bound**: Probability (0-1) of biasing the search towards the bounds. 0: Never bias to bounds; 1: Always bias to bounds (default: 0.5).
* **save\_results**: Saves final results in . 0: deactivated; 1: activated (default: 1).
* **inter\_save**: Saves results of intermediate iterations in . Useful for very long runs. 0: deactivated; 1: activated (default: 0).

### 3.2.3 Global options

A set of options related to the global search phase of the algorithm may also be defined also within the list **opts**:

* **dim\_refset**: Number of elements \(d\) in *RefSet* (default: *“auto”*, \(\frac{d^2-d}{10\cdot nvar} \geq 0\)).
* **ndiverse**: Number of solutions generated by the diversificator in the initial stage (default: **“auto”**, \(10\cdot nvar\)).
* **combination**: Type of combination of elements. 1: Hyper-rectangles combinations; 2: Linear combinations (default: 1).

### 3.2.4 Local options

*eSSR* is a global optimization method which performs local searches from selected initial points to accelerate the convergence to optimal solutions. Some options regarding the local search can be defined in the **opts** list, as follows:

* **local\_solver**: Local solver to perform the local search. Different solvers available and their names must be introduced as strings. Please note that at the moment no local solver for mixed-integer problems is available within *eSSR*:

  + *NM*: Nelder and Mead method for unconstrained problems (Nelder and Mead [1965](#ref-Nelder_Mead:65)).
  + *BFGS*: Quasi-Newton method for unconstrained problems (Broyden [1970](#ref-Broyden:70)).
  + *CG*:Conjugate gradients method for unconstrained problems (Fletcher and Reeves [1964](#ref-Fletcher_Reeves:64)).
  + *LBFGSB*: Quasi-Newton method which allows box constraints (Byrd et al. [1995](#ref-Byrd_et_al:95)).
  + *SA*:444 Methods *NM*, *BFGS*, *CG*, *LBFGSB* and *SA* are included in the R *optim* function (<http://stat.ethz.ch/R-manual/R-devel/library/stats/html/optim.html>) Variant of simulated annealing for unconstrained problems (Belisle [1992](#ref-Belisle:92)).
  + *SOLNP*: The SQP method555 Implemented by Alexios Ghalanos and Stefan Theussl (Ghalanos and Theussl [2012](#ref-Ghalanos_Theussl:12)). Requires the packages **Rsolnp** and **truncnorm** (<http://cran.r-project.org/web/packages/Rsolnp/index.html>) by (Ye [1987](#ref-Ye:87)).
  + *DHC*: Direct search method (de la Maza, M. and Yuret [1994](#ref-de-la-Maza_Yuret:94)).
* **local\_tol**: Level of tolerance in local search. 1: Relaxed; 2: Medium; 3: Tight (default: 2 in intermediate searches and 3 in the final stage).
* **local\_iterprint**: Print each iteration of local solver on screen (only for local solvers that allow it). 0: Deactivated; 1: Activated (default: 0).
* **local\_n1**: Number of iterations before applying the local search for the first time (default: 1).
* **local\_n2**: Number of function iterations in the global phase between two consecutive local searches (default: 10).
* **local\_finish**: Chooses the local solver to apply a final refinement to the best solution found once the optimization is finished (default: same as **local\_solver**).
* **local\_bestx**: If activated (i.e., positive value), applies the local search only when the algorithm finds a solution better than the current best solution. 0: Deactivated; 1: Activated (default: 0).
* **local\_balance**: Balances between quality (=0) and diversity (=1) for choosing initial points for the local search (default 0.5).

Note that, for some problems, the local search may be inefficient, spending a high computation time to provide low quality solutions. This is the case of many noisy or ill-posed problems. In these instances, the local search may be deactivated by user by defining the value of the field **solver** as zero (0).

### 3.2.5 Output

*eSSR*’s output is a list (called *Results* here) containing the following fields:

* **Results$fbest**: Best objective function value found after the optimization.
* **Results$xbest**: Vector providing the best function value found.
* **Results$cpu\_time**: CPU Time (in seconds) consumed in the optimization.
* **Results$f**: Vector containing the best objective function value after each iteration.
* **Results$x**: Matrix containing the best vector after each iteration.
* **Results$time**: Vector containing the CPU time consumed after each iteration.
* **Results$neval**: Vector containing the number of evaluations after each iteration.
* **Results$numeval**: Total number of function evaluations.
* **Results$local\_solutions**: Matrix of local solutions found.
* **Results$local\_solutions\_values**: Function values of the local solutions.
* **Results$Refset$x**: Matrix of solutions in the final *Refset* after the optimization.
* **Results$Refset$f**: Objetive function values of the final *Refset* members after the optimization.
* **Results$Refset$fpen**: Penalized objetive function values of the final *Refset* members after the optimization. The values for feasible solutions will coincide with their corresponding **Results\(Refset\)f** values.
* **Results$Refset$const**: Matrix containing the values of the constraints (those whose bounds are defined in **problem$c\_L** and/or **problem$c\_U**) for each of the solutions in the final *Refset* after the optimization.
* **Results$end\_crit**: Criterion to finish the optimization:
  + 1: Maximum number of function evaluations achieved.
  + 2: Maximum allowed CPU time achieved.
  + 3: Value to reach achieved.The list **Results** as well as **problem** and **opts** are stored and saved in a file called **eSSR\_report.RData**.

### 3.2.6 Guidelines for using *eSSR*

Although *eSSR* default options have been chosen to be robust for a high number of problems, the tuning of some parameters may help increase the efficiency for a particular problem. Here is presented a list of suggestions for parameter choice depending on the type of problem the user has to face.

* If the problem is likely to be convex, an early local search can find the optimum in short time. For that it is recommended to set the parameter **opts$local\_n1 = 1**. Besides, setting **opts$local\_n2 = 1** too, the algorithm increases the local search frequency, becoming an “intelligent” multistart.
* When the bounds differ in several orders of magnitude, the decision variables indexes may be included in **log\_var**.
* For problems with discontinuities and/or noise, the local search should either be deactivated or performed by a direct search method. In those cases, activating the option **opts$local\_bestx = 1** may help reduce the computation time wasted in useless local searches by performing a local search only when the best solution found has been improved.
* When the function values are very high in absolute value, the weight (**opts$weight**) should be increased to be at least 3 orders of magnitude higher than the mean function value of the solutions found.
* When the search space is very big compared to the area in which the global solution may be located, a first investment in diversification may be useful. For that, a high value of **opts$ndiverse** can help finding good initial solutions to create the initial *RefSet*. A preliminary run with aggressive options can locate a set of good initial solutions for a subsequent optimization with more robust settings. This aggressive search can be performed by reducing the size of the *RefSet* (**opts$dim\_refset**). A more robust search is produced increasing the *RefSet* size.
* If local searches are very time-consuming, their tolerance can be relaxed by reducing the value of **opts$local\_tol** not to spend a long time in local solution refinements.
* When there are many local solutions close to the global one, the option **opts$local\_balance** should be set close to 0.

### 3.2.7 Extra tool: *essR\_multistart*

This tool allows the user to perform a multistart optimization procedure with any of the local solvers implemented in *eSSR* using the same problem declaration. *essR\_multistart* can be invoked within *MEIGO* using the same structure setting the parameter **`algorithm="MULTISTART"`**.

```
Results_multistart<-MEIGO(problem,opts,algorithm="MULTISTART",p1,p2,...)
```

The list **problem** has the same fields as in *essR* (except **problem$vtr** which does not apply here).

The list **opts** has only a few fields compared with *essR* (i.e.,**opts$ndiverse**, **opts$local\_solver**, **opts$iterprint**, **opts$local\_tol** and **opts$local\_iterprint**). They all work like in *essR* except **opts$ndiverse**, which indicates the number of initial points chosen for the multistart procedure. A histogram with the final solutions obtained and their frequency is presented at the end of the procedure.

The output list **Results\_multistart** contains the following fields:

* **$fbest**: Best objective function value found after the multistart optimization.
* **$xbest**: Vector providing the best function value.
* **$x0**: Matrix containing the vectors used for the multistart optimization.
* **$f0**: Vector containing the objective function values of the vectors in **Results\_multistart$x0**.
* **$func**: Vector containing the objective function values obtained after every local search.
* **$xxx**: Matrix containing the vectors provided by the local optimizations.
* **$no\_conv**: Matrix containing the initial points that did not converge to any solution.
* **$nfuneval**: Matrix containing the number of function evaluations performed in every optimization.

The lists **problem**, **opts** and **Results\_multistart** are saved in a file called **Results\_multistart.RData**.

## 3.3 Examples

In this section we will illustrate the usage of *eSSR* within *MEIGO* for solving different instances.

### 3.3.1 Unconstrained problem

\begin{aligned}
\_{x}f(x)=4x\_1^2 - 2.1x\_1^4 + x\_1^6 + x\_1x\_2 - 4x\_2^2 + 4x\_2^4
\end{aligned}

subject to

\begin{aligned}
-1x\_1, x\_21
\end{aligned}

The objective function is defined in **ex1.R**. Note that being an unconstrained problem, there is only one output argument, \(f\).

```
ex1 <- function(x){
y<-4*x[1]*x[1]-2.1*x[1]^4+1/3*x[1]^6+x[1]*x[2]-4*x[2]*x[2]+4*x[2]^4;
return(y)
}
```

The solver is called in **`main_ex1.R`**. This problem has two known global optima in \(x^\*=(0.0898, -0.7127)\) and \(x^\*=(-0.0898, 0.7127)\) with \(f(x^\*)= -1.03163\).

Options set:

* Maximum number of function evaluations set to 500.
* Maximum number of initial diverse solutions set to 40.
* Local solver chosen: *DHC*.
* Local solver for final refinement: *LBFGSB*.
* Show the information provided by local solvers on screen.

```
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
```

### 3.3.2 Constrained problem

\begin{aligned}
\_{x}f(x)=-x\_1-x\_2
\end{aligned}

subject to

\begin{aligned}
x\_2 2x\_1^4 - 8x\_1^3 + 8x\_1^2 + 2\
x\_2 4x\_1^4 - 32x\_1^3 + 88x\_1^2 - 96x\_1 + 36\
0x\_13\
0x\_24\
\end{aligned}

The objective function is defined in **ex2.R**. Note that being a constrained problem, there are two output arguments, \(f\) and \(g\).

```
ex2<-function(x){
F=-x[1]-x[2]
g<-rep(0,2)
g[1]<-x[2]-2*x[1]^4+8*x[1]^3-8*x[1]^2
g[2]<-x[2]-4*x[1]^4+32*x[1]^3-88*x[1]^2+96*x[1]
return(list(F=F,g=g))
}
```

The solver is called in **`main_ex2.R`**. The global optimum for this problem is located in \(x^\*=[2.32952, 3.17849]\) with \(f(x^\*)=-5.50801\).

Options set:

* Maximum number of function evaluations set to 750.
* Local solver chosen: *DHC*.
* Increase frequency of local solver calls. The first time the solver is called after 2 iterations. From that moment, the local solver will be called every 3 iterations.

```
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
```

### 3.3.3 Constrained problem with equality constraints

\begin{aligned}
\_{x}f(x)=-x\_4
\end{aligned}

subject to

\begin{aligned}
x\_4 - x\_3 + x\_2 - x\_1 + k\_4x\_4x\_6 = 0\
x\_1 - 1 + k\_1x\_1x\_5 = 0\
x\_2 - x\_1 + k\_2x\_2x\_6 = 0\
x\_3 + x\_1 - 1 + k\_3x\_3x\_5 = 0\
x\_5^{0.5} + x\_6^{0.5} 4\
0 x\_1, x\_2, x\_3, x\_4 1\
0 x\_5, x\_6 16
\end{aligned}

with \(k\_1 = 0.09755988\), \(k\_3 = 0.0391908\) \(k\_2 = 0.99k\_1\) and \(k\_4 = 0.9k\_3\). The objective function is defined in **ex3.R**. Note that equality constraints must be declared before inequality constraints. Parameters \(k\_1,\ldots, k\_4\) are passed to the objective function through the main script, therefore they do not have to be calculated in every function evaluation. See the input arguments below.

```
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
```

The solver is called in **`main_ex3.R`**. The global optimum for this problem is located in \(x^\*=[0.77152, 0.516994, 0.204189, 0.388811, 3.0355, 5.0973]\) with \(f(x^\*)= -0.388811\).

Options set:

* Number of equality constraints set to 4 in **problem$neq**..
* Fields **problem$c\_L** and **problem$c\_U** only contain bounds for inequality constraints.
* Maximum computation time set to 5 seconds.
* Local solver chosen: *solnp*. It requires the R packages *Rsonlp* and *truncnorm*.
* Parameters \(k\_1,\ldots, k\_4\) are passed to the main routine as input arguments.

```
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
```

### 3.3.4 Mixed integer problem

\begin{aligned}
\_{x}f(x)=x\_2^2 + x\_3^2 + 2x\_1^2 + x\_4^2 - 5x\_2 - 5x\_3 - 21x\_1 + 7x\_4
\end{aligned}

subject to

\begin{aligned}
x\_2^2 + x\_3^2 + x\_1^2 + x\_4^2 + x\_2 - x\_3 + x\_1 - x\_4 8\
x\_2^2 + 2x\_3^2 + x\_1^2 + 2x\_4^2 - x\_2 - x\_4 10\
2x\_2^2 + x\_3^2 + x\_1^2 + 2x\_2 - x\_3 - x\_4 5\
0 x\_i 10 i \end{aligned}

Integer variables: \(x\_2\), \(x\_3\) and \(x\_4\). In the function declaration **ex4.R** they must have the last indexes.

```
    ex4<-function(x){
        F = x[2]^2 + x[3]^2 + 2.0*x[1]^2 + x[4]^2 - 5.0*x[2] - 5.0*x[3] - 21.0*x[1] + 7.0*x[4]
        g<-rep(0,3)
        g[1] = x[2]^2 + x[3]^2 + x[1]^2 + x[4]^2 + x[2] - x[3] + x[1] - x[4]
        g[2] = x[2]^2 + 2.0*x[3]^2 + x[1]^2 + 2.0*x[4]^2 - x[2] - x[4]
        g[3] = 2.0*x[2]^2 + x[3]^2 + x[1]^2 + 2.0*x[2] - x[3] - x[4]
        return(list(F=F, g=g))
    }
```

The solver is called in **`main_ex4.R`**. The global optimum for this problem is located in \(x^\*=[2.23607, 0, 1, 0]\) with \(f(x^\*)=-40.9575\).

Options set:

* An initial point is specified.
* The number of integer variables is specified (mandatory).
* No local solver is available for mixed-integer problems at the moment.
* Stop criterion determined by the CPU time (2 seconds).

```
#========================= PROBLEM SPECIFICATIONS ===========================
problem<-list(f="ex4", x_L=rep(0,4), x_U=rep(10,4), x_0=c(3,4,5,1),
int_var=3, c_L=rep(-Inf,3), c_U=c(8,10,5))
opts<-list(maxtime=2)
#========================= END OF PROBLEM SPECIFICATIONS =====================
Results<-MEIGO(problem,opts,algorithm="ESS")
```

### 3.3.5 *essR\_multistart* application

An application of *essR\_multistart* within *MEIGO* on the problem *ex3* using *solnp* as local solver is presented in the script **`main_multistart_ex3.R`**. The number of initial points chosen is 10.

```
#=========================
#PROBLEM SPECIFICATIONS
#=========================
problem<-list(f="ex3",x_L=rep(0,6),x_U=c(rep(1,4),16,16),
neq=4, c_L=-Inf, c_U=4)
opts<-list(ndiverse=10, local_solver='SOLNP', local_tol=3)
#=============================
#END OF PROBLEM SPECIFICATIONS
 #============================
k1=0.09755988
k3=0.0391908
k2=0.99*k1
k4=0.9*k3
Results<-MEIGO(problem,opts,algorithm="multistart",k1,k2,k3,k4)
```

# 4 Integer optimization: Variable Neighbourhood Search (*VNSR*)

*VNSR* is an R implementation of the Variable Neighbourhood Search (VNS) metaheuristic which is part of the *MEIGO* toolbox for global optimization in bioinformatics. VNS was first proposed by (Mladenović and Hansen [1997](#ref-Mladenovic_Hansen:97)) for solving combinatorial and/or global optimization problems. The method guides a trial solution to search for an optimum in a certain area. After this optimum is located, the trial solution is perturbed to start searching in a new area (or neighbourhood). New neighbourhoods are defined following a distance criterion in order to achieve a good diversity in the search. Different variants of the method have been published in recent years in order to adapt it to different types of problems (Hansen, Mladenović, and Moreno-Pérez [2010](#ref-Hansen_Mladenovic_Moreno-Perez:10)). *VNSR* implements some of this variants by means of different tunning parameters. *VNSR* seeks the global minimum of integer programming (IP) problems specified by

\begin{aligned}
\_{x}f(x,p\_1,p\_2,…,p\_n)
\end{aligned}

subject to

\begin{aligned}
x\_Lxx\_U \
\end{aligned}

where \(x\) is the vector of (integer) decision variables, and \(x\_L\) and \(x\_U\) its respective bounds. \(p\_1,\ldots,p\_n\) are optional extra input parameters to be passed to the objective function, \(f\), to be minimized. The current *VNSR* version does not handle constraints apart from bound constrained, so that the user should formulate his/her own method (i.e., a penalty function) to solve constrained problems.

## 4.1 Quick start: How to carry out an optimization with *VNSR*

* Define your problem and options (see the following sections)
* Type **`Results<-MEIGO(problem,opts, algorithm="VNS")`**. If your problem has additional constant parameters to be passed to the objective function, they are declared as input parameters after “opts” (e.g., type **`Results<-MEIGO(problem,opts,algortim="VNS",p1,p2)`** if your model has two extra input parameters, \(p\_1\) and \(p\_2\)).

Regarding the objective function, the input parameter is the decision vector (with extra parameters \(p\_1, p\_2,\ldots, p\_n\) if they were defined before calling the solver). The objective function must provide a scalar output parameter (the objective function value).

## 4.2 *VNSR* usage

### 4.2.1 Problem definition

A list named **problem** containing the following fields must be defined for running *VNSR*:

* **f**: String containing the name of the objective function.
* **x\_L**: Vector containing the lower bounds of the variables.
* **x\_U**: Vector containing the upper bounds of the variables.
* **x\_0**: Vector containing the initial solution to start the search. If this field is not defined then the algorithm will choose an initial point randomly chosen within the bounds.

### 4.2.2 *VNSR* options

The user may define a set of different options related to the integer optimization problem. They are defined in another list (named **opts** here) which has the following fields.

* **maxeval**: Maximum number of function evaluations (default: 1000).
* **maxtime**: Maximum CPU time in seconds (default: 60).
* **iterprint**: Print information on the screen after each iteration. 0: Deactivated; 1: Activated (default: 1).
* **maxdist**: Percentage of the problem dimension which will be perturbed in the furthest neighborhood (vary between 0-1, default: 0.5).
* **use\_local**: Uses local search (1) or not (0). Default:1.

The following options only apply when the local search is activated (i.e., **opts$use\_local**=1)

* **aggr**: Aggressive search. The local search is only applied when the best solution has been improved (1=aggressive search, 0=non-aggressive search, default:0).
* **local\_search\_type**: Applies a first (=1) or a best (=2) improvement scheme for the local search (Default: 1).
* **decomp**: Decompose the local search (=1) using only the variables perturbed in the global phase. Default: 1.

### 4.2.3 Output

*VNSR* output is a list (called **Results** here) containing the following fields:

* **Results$fbest**: Best objective function value found after the optimization.
* **Results$xbest**: Vector providing the best function value found.
* **Results$cpu\_time**: CPU Time (in seconds) consumed in the optimization.
* **Results$func**: Vector containing the best objective function value after each improvement
* **Results$x**: Matrix containing the best vector after each improvement (in rows).
* **Results$time**: Vector containing the CPU time consumed after each improvement.
* **Results$neval**: Vector containing the number of evaluations after each improvement.
* **Results$numeval**: Total number of function evaluations.

The list **Results** as well as **problem** and **opts** are stored and saved in a file called **VNSR\_report.RData**.

## 4.3 Guidelines for using *VNSR*

Parameter tuning in *VNSR* may help increase the efficiency for a particular problem. Here is presented an explanation of the influence of each parameter and suggestions for tuning.

* **opts$use\_local**: It is activated (=1) by default but it might be deactivated for a first quick run in which a feasible or a good solution is required in a short computation time, or when the problem dimension is so high that local searches involve high computational times.
* **opts$aggr**: This option uses the aggressive scheme in which the local searh is only applied when the best solution has been improved within the local search. The activation of this options makes the method visit many different neighborhoods but without refining the solutions unless a very good one is found. It might be a good option to locate promising areas or to discard poor areas and constraint the search space later.
* **opts$local\_search\_type**: There are two types of local searches implemented in the method. One is the first improvement, which perturbs all the decision variables in a random order, changing one unit per dimension and stopping when the intial solution has been outperformed even if there are variables still not perturbed. The second option is a best improvement, which perturbs all the decision variables and then chooses the best solution among the perturbed solution to replace (or not) the initial solution. The best improvement produces a more exhaustive search than the first improvement, but it may be highly time consuming for large-scale problems. The first improvement scheme allows a more dynamic search but can miss refined high quality solutions. In both cases the principle is applied: If a solution has been improved by perturbing one dimension, we repeat the perturbation following the same direction since it is considered as a promising search direction.
* **opts$decomp**: Performing a local search over all the decision variables might be computationally inefficient in the case of large-scale problems. The Variable Neighbourhood Decomposition Search (VNDS, (Hansen, Mladenović, and Pérez-Brito [2001](#ref-Hansen_Mladenovic_Perez-Brito:01))) decomposes the problem into a smaller sized one by just performing the local search over the perturbed decision variables instead of all of them. The number of perturbed decision variables is determined by the problem dimension and by the options **opts$maxdist** (see below).
* **opts$maxdist**: This option chooses the percentage (between 0 and 1), of decision variables which are perturbed simultaneously in the search. In other words, it controls the distance between the current solution and the furthest neighborhood to explore. A high percentage (e.g., 100% of the variables) produces a more exhaustive search but is more time consuming. It has been empirically proven that for many instances a low percentage of perturbed variables is efficient to locate global solutions.

## 4.4 Application example

To illustrate the use of *VNSR* we choose the 10 dimensional Rosenbrock function with integer decision variables as an example. The code of the Rosenbrock function is available inside the installation directory of the *MEIGO* package, under the benchmarks folder. Source the objective function and assign it to the problem list.

```
rosen10<-function(x){
        f<-0
        n=length(x)
        for (i in 1:(n-1)){
            f <- f + 100*(x[i]^2 - x[i+1])^2 + (x[i]-1)^2
        }
        return(f)
    }

nvar<-10
```

Define the problem settings:

```
problem<-list(f="rosen10", x_L=rep(-5,nvar), x_U=rep(1,nvar))
```

Define the algorithm to be used:

```
algorithm="VNS"
```

Define the options for *VNSR*:

```
opts<-list(maxeval=2000, maxtime=3600*69, use_local=1,
     aggr=0, local_search_type=1, decomp=1, maxdist=0.5)
```

Call MEIGO:

```
Results<-MEIGO(problem,opts,algorithm)
```

# 5 Parallel computation in *MEIGO*

*MEIGO* allows the user to exploit multi core computation with either of the implemented methods by means of their corresponding parallelizable versions: *CeSSR* and *CeVNS*. The following sections include and introduction to the parallel computing packages needed to exploit this features as well as application examples to implement the methods.

## 5.1 Quick notes about the parallel computing packages

In order to launch multiple threads of *eSSR* and/or *VNSR* we use the **snow** package, available in the CRAN repository. Installing and using this package in a cluster might not be entirely trivial and therefore we will start by adding a few notes about this.

### 5.1.1 Snowfall

The **snowfall** package is based in the **snow** package to ease cluster programming. Detailed information can be found at <https://cran.r-project.org/web/packages/snowfall/index.html>. In *MEIGO* we allow the use of two mechanisms:

* **Socket-connection**: Socket-connection is the simplest option and is what we recommend for a quick-start. Socket connections are made over TCP/IP and do not require the installation of any additional software. If working in a cluster you will have to specify the address of the machines you want connect to. If you are running in a local machine (preferentially but no necessarily with multiple cores) the R instances will be launched in your machine. More details on how to configure this options will be provided further ahead in this manual.

* **MPI**: The Message Parsing Interface option depends on your ability to install and use the package Rmpi in your cluster. Detailed information on how to this can be found at <http://www.stats.uwo.ca/faculty/yu/Rmpi/>.

## 5.2 Usage

### 5.2.1 Options

The corresponding cooperative method for either of the algorithms included in *MEIGO* (i.e., *CeSSR* and *CeVNSR*), is invoked using the same problem declaration and options (see sections [3.2](#ess-usage) and [4.2](#vns-usage)). To select the cooperative version of each method, the field `algorithm` must contain either `CeSSR` or `CeVNSR`. The list **opts** must now be a vector for each field instead of a scalar. For example, if we want to use *CeSSR* with 3 different threads, we would define the options of maximum number of evaluations as

```
opts=list();
opts[[1]]$maxeval<-value1
opts[[2]]$maxeval<-value2
opts[[3]]$maxeval<-value3
```

The first *n* fields should contain the options for the *n* threads that are going to be used. The field *n+1* should be named hosts. **opts$hosts** should be a vector containing as many elements as threads you want to launch in parallel. In case you are using the ‘SOCKS’ mechanism from snowfall each element of this vector should be a string with the address of the machines where you want to launch the optimization. For instance, `opts$hosts('node1','node1','node2','node2','node5','localhost','127.0.0.1')` will use 7 threads for each iteration; two at ‘node1’, two at ‘node2’, one in ‘node5’ and two in your local machine (‘localhost’ and ‘127.0.0.1’).

Additionally, a set of extra options must be defined in the list **opts**. These extra options are the following:

* **ce\_maxeval**: The maximum number of evaluations. By default this is set to infinity leaving the stopping criterion to the number of iterations.
* **ce\_maxtime**: The maximum time to be spent in the cooperative search. By default this is set to infinity leaving the stopping criterion to the number of cooperative iterations. Notice that although you can specify its value, this stopping criterion will only be checked at the end of each iteration. Therefore if a cooperative iteration takes long it is expected that the cooperative method takes a bit longer to finish than what you have specified.
* **ce\_niter**: The number of times the threads will stop to exchange information. The default is 1, meaning that there will be an initial iteration (iteration 0) where the threads will stop to exchange the best solutions found and start a new optimization round. This value can also be set to 0 meaning that you will run multiple or runs in parallel without any exchange of information from the threads.
* **ce\_isparallel**: By default this is set to true. Otherwise each thread will be executed sequentially.
* **ce\_type**: The type of mechanism used for parallelization. The ‘SOCKS’ mechanism is incorporated through the **snowfall** package), In this case, it is important to define the addresses of **opts$hosts** properly. Additionally, the ‘MPI’ (from **snowfall**) is also available.

  ```
        <!-- \item \textbf{global\_save\_list}: This field should contain the names of the global variables to be exported. -->
  ```

### 5.2.2 Output

The *CeSSR* / *CeVNSR* output is a list containing the following fields:

* **f\_mean**: Contains the mean value of the objective function at each iteration.
* **fbest**: Contains the lowest value found by the objective function at each iteration.
* **iteration\_res**: Contains the results returned by each *CeSSR* / *CeVNSR* thread at the end of an iteration. Check sections [3.2.5](#essroutput) and [4.2.3](#vnsr-output) for more information.
* **numeval**: The number of evaluations at the end of each iteration.
* **time**: The computation time at the end of each iteration.

## 5.3 *CeSSR* application example

*CeSSR* is an R implementation of the Cooperative enhanced Scatter Search method which is part of the *MEIGO* toolbox for global optimization in bioinformatics. The *CeSS* strategy (Villaverde, Egea, and Banga [2012](#ref-Villaverde_et_al:12)) is a general purpose technique for global optimization, suited for a computing environment with several processors. Its key feature is the cooperation between the different programs (“threads”) that run in parallel in different processors. Each thread implements the enhanced Scatter Search metaheuristic (*eSS*) (Egea et al. [2009](#ref-Egea_et_al:09); Egea, Martí, and Banga [2010](#ref-Egea_et_al:10)), which is also available in *MEIGO*.

To illustrate the use of *CeSSR* we choose the D/2m-group Shifted and m-rotated Rastrigin’s function (f10) from the LSGO benchmarks (Tang, Yang, and Weise [2012](#ref-Tang_et_al:12)) as an example. The code of f10 is available inside the installation directory of the *MEIGO* package, under the benchmarks folder. Source the objective function and assign it to the problem list, defining the bounds for the decision variables:

```
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
    opts[[counter]]$local_balance   =   opts_bal[counter]
    opts[[counter]]$dim_refset      =   opts_dim[counter]
    opts[[counter]]$local_n2        =   opts_n2[counter]

    #Set common options for each thread

    opts[[counter]]$maxeval         =   10000
    opts[[counter]]$local_solver    =   "dhc"

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
```

# 6 *CeVNSR* application example

*CeVNSR* is an extension of *VNSR* which makes use of parallel computation packages available in R to reduce the time needed to solve a given integer programming problem (IP). This implementation builds on the ideas explored by (Villaverde, Egea, and Banga [2012](#ref-Villaverde_et_al:12)) which showed (in a nonlinear programming context) that, at least for a set of benchmarks, cooperative instances of an optimization algorithm exchanging information from time to time produced better results than running same instances in an independent fashion with an equivalent computational cost.

Next we show an example function that illustrates how to configure the list of options used by *CeVNSR*. This example calls two cpu’s of our local machine to solve the integer *Rosenbrock* problem. It can be found in the script **main\_CeVNSR\_example.R** in the benchmarks folder.

```
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
```

# 7 Applications from Systems Biology

In this section we provide examples for two systems biology problems related with the use and calibration of logic models for modeling cell signaling pathways.

## 7.1 Using eSS to fit a dynamic model

In this section we use eSS to calibrate a model of ordinary differential equations. Here the dynamics are simulated with the CNORode package **CNORode** (Henriques and Cokelaer [2012](#ref-CNORode)) which is part of the **CellNOptR**
package (T.Cokelaer et al. [2012](#ref-CellNOptR); Terfve et al. [2012](#ref-terfve2012cellnoptr)).

The model shown here is toy pathway for illustrative purposes. A detailed description on the biological
problem and published case studies can be found in <http://www.cellnopt.org/>. Briefly, CNORode uses a technique called multivariate polynomial interpolation (Krumsiek et al. [2010](#ref-krumsiek2010odefy)) in order to transform a logic model into a system of ordinary differential equations. The final goal of the package is to calibrate such model (its parameters) by means of optimization strategies where the objective is to minimize the squared difference between the model predictions and the experimental data.

In this example, we start by loading the package and the necessary model and experimental data:

```
library(MEIGOR)
library(CNORode)
data("CNORodeExample",package="MEIGOR")
plotCNOlist(cnolist)
```

![Plot of the experimental data for the CNORode example.](data:image/png;base64...)

Figure 1: Plot of the experimental data for the CNORode example

This data was generated *in silico* and added \(5\%\) of Gaussian noise to simulate the experimental error. Figure [1](#fig:CNORodeExampleFig) shows the plot of the experimental data.

In order to visualize the logic model we can use the CellNOptR package (see Figure [2](#fig:CNORodeExampleFigModel))

![The model structure for the CNORode example.](data:image/png;base64...)

Figure 2: The model structure for the CNORode example

The models generated by CNORode typically produce a large number of continuous parameters. To automatically generate a list containing the set of continuous parameters and additional information (e.g. the parameters names) for this model we can use the *createLBodeContPars* function. Here we set the option `random` to `TRUE` in order to generate a random initial solution for our problem and plot the simulation results against the experimental data (see Figure [3](#fig:CNORodeExampleInitial)).

![Fit for the initial (random) solution provided to the optimization solver. The simulation is ploted against the experimental data.](data:image/png;base64...)

Figure 3: Fit for the initial (random) solution provided to the optimization solver
The simulation is ploted against the experimental data.

The CNORode packages allows the generation of an objective function that can be used by optimization solvers. Basically this function computes the squared difference between the experimental data and the simulation results:

```
f_hepato<-getLBodeContObjFunction(cnolist, model, initial_pars, indices=NULL,
 time = 1, verbose = 0, transfer_function = 3, reltol = 1e-04, atol = 1e-03,
maxStepSize =Inf, maxNumSteps = 1e4, maxErrTestsFails = 50, nan_fac = 5)
```

In *eSSR* an optimization problem is defined by a list that should contain at least the objective function and the upper and lower bound of the variables under study:

```
n_pars=length(initial_pars$LB)
problem<-list(f=f_hepato, x_L=initial_pars$LB[initial_pars$index_opt_pars],
    x_U=initial_pars$UB[initial_pars$index_opt_pars],x_0=initial_pars$LB[initial_pars$index_opt_pars])
```

Finally, the options for the solver must be defined. Please note that the settings used here do not provide the necessary computational effort to solve this problem and are chosen such that the examples can be executed quickly. To improve the performance increase **maxeval**, **ndiverse** and **dim\_refset**
and use a local solver:

```
opts<-list(maxeval=100, local_solver=0,ndiverse=10,dim_refset=6)
```

To start the optimization procedure call *MEIGO*:

```
Results<-MEIGO(problem,opts,algorithm="ESS")
```

After the optimization we can use the obtained results to plot and plot the model fitness with CNORode (see Figure [4](#fig:CNORodeExampleOptPlot)):

![Fitness of the solution obtained by the eSS in the CNORode parameter estimation problem.](data:image/png;base64...)

Figure 4: Fitness of the solution obtained by the eSS in the CNORode parameter estimation problem

## 7.2 Using VNS to optimize logic models

In (Saez-Rodriguez et al. [2009](#ref-saez2009discrete)) it is shown how to use a genetic algorithm to optimize a logic model against experimental data. From the optimization point of view, this corresponds to a binary decision problem that can be tackled by *VNS*.

The basic idea is that each binary decision variable corresponds to a logic disjuntion (an AND gate) from the Boolean point of view or to an hyperedge (an edge with multiple inputs) from the graph perspective. The **CellNOptR** software (Terfve et al. [2012](#ref-terfve2012cellnoptr)) provides the necessary framework to simulate such models
and obtain an objective function that can be used by *VNS*.

The example provided here is a synthetic pathway, meaning that, both the data and the network structure shown here were engineered for illustrative purposes. Note that a detailed description of the biological problem and published case studies can be found in <http://www.cellnopt.org/>.

The first step in this example is to load the **CellNOptR** package and a list (the *cnolist*) containing the data for several experiments under different pertubation conditions of upstream network stimuli (typically ligands) and downstream inhibitors (typically small molecule inhibitiors). Also, **CellNOptR** is used to visualize such data (see Figure [5](#fig:CellNOptRExampleCnolist)):

![Pseudo-experimental data for the CellNOptR (Boolean logic) example. Each row corresponds to a different experiment upon pertubation with different stimuli and inhibitors.](data:image/png;base64...)

Figure 5: Pseudo-experimental data for the CellNOptR (Boolean logic) example
Each row corresponds to a different experiment upon pertubation with different stimuli and inhibitors.

The original prior-knowledge network (a signed directed graph) can be expanded into an hypergraph containing all possible Boolean gates. CellNOptR can then be used to visualize the obtained network (see Figure [6](#fig:CellNOptRExampleFig)).

![The expanded model for the CellNOptR (Boolean logic) example. This representation contains all possible logic gates where each binary decision variable corrersponds to an hyperedge/logical disjunction.](data:image/png;base64...)

Figure 6: The expanded model for the CellNOptR (Boolean logic) example
This representation contains all possible logic gates where each binary decision variable corrersponds to an hyperedge/logical disjunction.

After loading the experimental data and the prior-knowledge network, we need to define an objective function that can be used by VNS. In order to compute the fitness of the model we will need to perform a simulation and compute the model fitness. Again, **CellNOptR** automates most of this process and thus our objective function can be defined as follows:

```
get_fobj<- function(cnolist,model){

    f<-function(x,model1=model,cnolist1=cnolist){
        simlist=prep4sim(model1)
        score=computeScoreT1(cnolist1, model1, x)
        return(score)
    }
}
fobj=get_fobj(cnolist,model)
```

After defining the objective function we need to define the optimization problem and the options for the solver:

```
nvar=16

problem<-list(f=fobj, x_L=rep(0,nvar), x_U=rep(1,nvar))
opts<-list(maxeval=2000, maxtime=30, use_local=1,
    aggr=0, local_search_type=1, decomp=1, maxdist=0.5)
```

Finally we call *MEIGO* using the *VNS* algorithm in order to solve the problem:

```
Results<-MEIGO(problem,opts,"VNS")
```

Once the optimization procedure is finished we plot the obtained solution (see Figure [7](#fig:CellNOptRExamplePlotOptModel)):

![The Boolean logic model obtained after optimization with VNS.](data:image/png;base64...)

Figure 7: The Boolean logic model obtained after optimization with VNS

# References

Belisle, C. J. P. 1992. “Convergence Theorems for a Class of Simulated Annealing Algorithms.” *J. Applied Probability* 29: 885–95.

Broyden, C. G. 1970. “The Convergence of a Class of Double-Rank Minimization Algorithms.” *Journal of the Institute of Mathematics and Its Applications* 6: 76–90.

Byrd, R. H., P. Lu, J. Nocedal, and C. Zhu. 1995. “A Limited Memory Algorithm for Bound Constrained Optimization.” *SIAM J. Scientific Computing* 16: 1190–1208.

de la Maza, M., and D. Yuret. 1994. “Dynamic Hill Climbing.” *AI Expert* 9 (3): 26–31.

Egea, J. A., E. Balsa-Canto, M.-S.G. García, and J. R. Banga. 2009. “Dynamic Optimization of Nonlinear Processes with an Enhanced Scatter Search Method.” *Industrial & Engineering Chemistry Research* 48 (9): 4388–4401.

Egea, J. A., R. Martí, and J. R. Banga. 2010. “An Evolutionary Algorithm for Complex Process Optimization.” *Computers & Operations Research* 37 (2): 315–24.

Fletcher, R., and C. M. Reeves. 1964. “Function Minimization by Conjugate Gradients.” *Computer Journal* 7: 148–54.

Ghalanos, Alexios, and Stefan Theussl. 2012. *Rsolnp: General Non-Linear Optimization Using Augmented Lagrange Multiplier Method. R Package Version 1.12*.

Hansen, P., N. Mladenović, and J. A. Moreno-Pérez. 2010. “Variable Neighbourhood Search: Methods and Applications.” *Annals of Operations Research* 175 (1): 367–407.

Hansen, P., N. Mladenović, and D Pérez-Brito. 2001. “Variable Neighborhood Decomposition Search.” *Journal of Heuristics* 7 (4): 335–50.

Henriques, David, and Thomas Cokelaer. 2012. *CNORode: ODE Add-on to Cellnoptr*.

Krumsiek, Jan, Sebastian Pölsterl, Dominik Wittmann, and Fabian Theis. 2010. “Odefy-from Discrete to Continuous Models.” *BMC Bioinformatics* 11 (1): 233.

Mladenović, N., and P. Hansen. 1997. “Variable Neighborhood Search.” *Computers and Operations Research* 24: 1097–1100.

Nelder, J. A., and R. Mead. 1965. “A Simplex Algorithm for Function Minimization.” *Computer Journal* 7: 308–13.

Saez-Rodriguez, Julio, Leonidas G Alexopoulos, Jonathan Epperlein, Regina Samaga, Douglas A Lauffenburger, Steffen Klamt, and Peter K Sorger. 2009. “Discrete Logic Modelling as a Means to Link Protein Signalling Networks with Functional Analysis of Mammalian Signal Transduction.” *Molecular Systems Biology* 5 (1).

Tang, K., Z. Yang, and T. Weise. 2012. “Competition on Large Scale Global Optimization.” *IEEE World Congress on Computational Intelligence* <http://staff.ustc.edu.cn/~ketang/cec2012/lsgo_competition.htm>.

T.Cokelaer, F.Eduati, A.MacNamara, S.Schrier, and C.Terfve. 2012. *CellNOptR: Training of Boolean Logic Models of Signalling Networks Using Prior Knowledge Networks and Perturbation Data.*

Terfve, Camille, Thomas Cokelaer, David Henriques, Aidan MacNamara, Emanuel Goncalves, Melody K Morris, Martijn van Iersel, Douglas A Lauffenburger, and J Saez-Rodrigues. 2012. “CellNOptR: A Flexible Toolkit to Train Protein Signaling Networks to Data Using Multiple Logic Formalisms.” *BMC Syst Biol* 6 (1): 133.

Villaverde, A. F., J. A. Egea, and J. R. Banga. 2012. “A Cooperative Strategy for Parameter Estimation in Large Scale Systems Biology Models.” *BMC Systems Biology* 6: 75.

Ye, Y. 1987. “Interior Algorithms for Linear, Quadratic and Linearly Constrained Non-Linear Programming.” PhD thesis, Stanford University.