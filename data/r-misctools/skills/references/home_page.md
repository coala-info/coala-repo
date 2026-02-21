# The "micEcon" project

## Tools for microeconomic analysis and microeconomic modelling in [R](http://www.r-project.org)

### News

* A [style guide
  for the code in the micEcon project](micEconStyle.html) is now available.
* [Further news](https://r-forge.r-project.org/news/?group_id=257)
  about the micEcon project are available at the
  [project's R-Forge site](http://r-forge.r-project.org/projects/micecon/).

### What is micEcon?

* **micEcon** is an extension package for the "language and environment for statistical computing and graphics" called [R](http://www.r-project.org).
* **micEcon** provides functions for microeconomic analysis and microeconomic modelling.

### Which [R](http://www.r-project.org) packages are developed within the micEcon project?

* **micEcon: Microeconomic Analysis and Modelling.**
  This is the base package.
  It provides tools for microeconomic analysis and microeconomic modelling, e.g.
  + analysis with **Translog functions**,
    e.g. econometric estimation,
    calculation of derivatives with respect to regressors,
    calculation of (bordered) Hessian matrices with respect to regressors,
    checking monotonicity (positive or negative),
    checking curvature (quasiconcavity, concavity,
    quasiconvexity, convexity), and
    creating a matrix that can be used to impose monotonicity
    using a two-step procedure.
  + analysis with **quadratic functions**,
    e.g. econometric estimation and
    calculation of derivatives with respect to regressors.
* **micEconAids: Demand Analysis with the "Almost Ideal Demand System" (AIDS).**
  The AIDS is the most popular demand system in empirical demand analysis.
  This package provides functions for:
  + econometric estimation using the popular but inaccurate "Linear Approximation" (LA-AIDS) and the accurate "Iterated Linear Least Squares Estimator" (ILLE)
  + searching for the intercept of the translog price index (alpha\_0) that gives the best fit to the model
  + optional imposition homogeneity and symmetry
  + checking for monotonicity and concavity
  + predicted quantities and expenditure shares
  + Marshallian (uncompensated) price elasticities, Hicksian (compensated) price elasticities, income elasticities, and their standard errors
* **micEconCES: Analysis with the "Constant Elasticity of Scale"
  (CES) function.**
  Tools for economic analysis and economic modelling with a Constant Elasticity of Scale (CES) function.
* **micEconNP: Microeconomic Analysis with Non-Parametric Methods.**
  Tools for microeconomic analysis and microeconomic modelling with non-parametric methods.
* **micEconSNQP: "Symmetric Normalized Quadratic"
  (SNQ) profit function.**
  Tools for production analysis with the Symmetric Normalized Quadratic (SNQ)
  profit function.
  The SNQ profit function is often used in microeconomic production models
  because it allows for the imposition of global convexity.
  This package provides functions for:
  + econometric estimation
  + imposition of global convexity using a recent two-step estimation procedure
  + price elasticities of inputs and outputs and their standard errors
  + fixed factor elasticities
  + shadow prices of fixed factors
  + Hessian matrix and its derivatives with respect to coefficients
  + predicted profits and netput quantities including the standard errors and the confidence limits of prediction
* **miscTools: Miscellanneous Tools and Utilities.**
  This package provides miscellanneous small tools and utilities, e.g. for
  + inserting additional rows and columns into matrices
  + creating symmetric and triangular matrices
  + conversion between a symmetric matrix and a vector of its linear independent values
  + tests for positive and negative semidefiniteness

### Who has written the packages in the micEcon project?

* [Arne Henningsen](http://www.arne-henningsen.name)
* [Ott Toomet](http://www.obs.ee/~siim/)
* [Geraldine Henningsen](http://www.dtu.dk/English/Service/Phonebook.aspx?lg=showcommon&type=publications&id=66311)

### Where can I get the officially released versions micEcon?

The officially released versions of these packages,
including documentation, source code, etc.,
are available from the Comprehensive R Archive Network (CRAN):

* **micEcon**: [http://cran.r-project.org/package=micEcon](http://cran.r-project.org/package%3DmicEcon)
* **micEconAids**: [http://cran.r-project.org/package=micEconAids](http://cran.r-project.org/package%3DmicEconAids)
* **micEconCES**: [http://cran.r-project.org/package=micEconCES](http://cran.r-project.org/package%3DmicEconCES)
* **micEconNP**: not yet on CRAN
* **micEconSNQP**: [http://cran.r-project.org/package=micEconSNQP](http://cran.r-project.org/package%3DmicEconSNQP)
* **miscTools**: [http://cran.r-project.org/package=miscTools](http://cran.r-project.org/package%3DmiscTools)

You can install theese packages by the [R](http://www.r-project.org)
command (if you have internet access):

```
 install.packages( "packageName" )
```

### Where can I get the latest development versions micEcon?

The (potentially unstable) latest development versions of these packages are available
from [R-Forge](http://r-forge.r-project.org):

* [https://r-forge.r-project.org/R/?group\_id=257](http://r-forge.r-project.org/R/?group_id=257)

You can install theese packages by the [R](http://www.r-project.org)
command (if you have internet access):

```
 install.packages( "packageName", repos="http://R-Forge.R-project.org" )
```

### Under which license are the packages within the micEcon project released?

* Under the [GNU General Public License (GPL)](http://www.gnu.org/licenses/gpl.html)

### Where can I ask questions, report bugs, or suggest new features?

* Please use a forum or "tracker" at the
  [project's R-Forge site](http://r-forge.r-project.org/projects/micecon/).

[![Valid XHTML 1.0!](images/vxhtml10.png)](http://validator.w3.org/check/referer)

Last Update: 19 July 2015