# Packages for graphical modelling with R

This page describes some of the [R](http://www.R-project.org) packages for graphical modelling that I have been involved with. There are many more packages for grapical modelling, and the CRAN Task View [Graphical Models](https://cran.r-project.org/web/views/GraphicalModels.html) lists many of these.

## Packages

### [gRain](https://cran.r-project.org/web/packages/gRain/index.html)

* Probability propagation in Bayesian networks (graphical independence networks).
* The reference to gRain is: Højsgaard, S. (2012) [Graphical Independence Networks with the gRain Package for R](https://www.jstatsoft.org/article/view/v046i10). Journal of Statistical Software Vol. 46, No. 10. 1-26
* See also Højsgaard, Edwards, Lauritzen (2012) [Graphical Modelling with R](https://www.springer.com/gp/book/9781461422983). Springers UseR! series.

### [gRim](https://cran.r-project.org/web/packages/gRim/index.html)

* Graphical interaction models (graphical log-linear models for discrete data, Gaussian graphical models for continuous data and Mixed interaction models for mixed data).
* See Højsgaard, Edwards, Lauritzen (2012) [Graphical Modelling with R](https://www.springer.com/gp/book/9781461422983). Springers UseR! series.

### [gRbase](https://cran.r-project.org/web/packages/gRbase/index.html)

* Efficient graph algorithms, functions for easy creation of graphs, functions for manipulation of highdimensional tables, data relevant to graphical models.
* Many graph modelling packages depend on gRbase, but gRbase itself provides only limited modelling facilities.
* The reference to gRbase is: Dethlefsen, C., Højsgaard, S. (2005) [A Common Platform for Graphical Models in R: The gRbase Package](http://www.jstatsoft.org/v14/i17). Journal of Statistical Software Vol. 14, No. 17.

### [gRc](https://cran.r-project.org/web/packages/gRc/index.html)

* Inference in Graphical Gaussian Models with Edge and Vertex Symmetries.
* The reference to gRc is: Højsgaard, S., Lauritzen, S. (2007) [Inference in Graphical Gaussian Models with Edge and Vertex Symmetries with the gRc Package for R](http://www.jstatsoft.org/v23/i06). Journal of Statistical Software, Vol. 23, No. 6, 2007.
* See also Højsgaard, S., Lauritzen, S. (2008) [Graphical Gaussian models with edge and vertex symmetries](http://www.stats.ox.ac.uk/~steffen/papers/rcoxrssb.pdf). Journal of the Royal Statistical Society; Series B: Statistical Methodology, Vol. 70, No. 5, p. 1005-102

## Development versions

Development versions of the packages reside on github. To use these versions, PLEASE install the [CRAN](http://cran.r-project.org) versions FIRST (see section on [installation](#installation)) to get dependencies right and then AFTERWARDS install the development versions using:

```
remotes::install_github("hojsgaard/gRbase")
```

* Notice that for this to succeed you will need tools for building R packages from sources on your computer. For windows users this translates to that you will have to install [Rtools](https://cran.r-project.org/bin/windows/Rtools). Just follow the suggestions of the installer.
* Notice that the packages are interdependent: For example, gRain depends on gRbase. Therefore, to use the development version of e.g. gRain you must (most likely) also install the development version of gRbase.

## Books

* Højsgaard, Edwards, Lauritzen (2012) [Graphical Modelling with R](https://www.springer.com/gp/book/9781461422983). Springers UseR! series. The book contains several illustrations of the use of the gRbase, gRain and gRim packages.
* Errata list for [Graphical Modelling with R](gmwr-errata.txt).
* See also Lauritzen (1996) Graphical Models. Oxford University Press

## Examples, scripts and notes

* An example where [gRain](http://cran.r-project.org/web/packages/gRain/index.html) has been used in [genetics](http://www.r-bloggers.com/grain-genetics-example-2/). See also [here](http://ggorjan.blogspot.dk/2011/04/grain-genetics-example.html).
* Another example is [here](https://rstudio-pubs-static.s3.amazonaws.com/59013_03264ec8deae4f05a713446ad4ac06e4.html).

## FAQ (frequently asked questions)

* Q: Is it possible to specify likelihood evidence (also called virtual evidence) in [gRain](http://cran.r-project.org/web/packages/gRain/index.html)?
* A: Yes, as of version 1.1-2 this has been implemented. The function to use is setEvidence(). A vignette on the topic has also been added.
  Please report unexpected behaviour.
* Q: I want to build a Bayesian network with 80.000 nodes. Can I do so with [gRain](http://cran.r-project.org/web/packages/gRain/index.html)?
* A: Work has been done on supporting large networks. Please report sucesses and failures.
* Q: Does [gRain](http://cran.r-project.org/web/packages/gRain/index.html) have support for Bayesian networks for variables that are (multivariate) normal? Or for mixtures of discrete and normal variables?
* A: No. Implementation for the multivariate normal distribution is - at least in principle - straight forward although there can non-trivial numerical issues.
* Q: Does [gRain](http://cran.r-project.org/web/packages/gRain/index.html) have support for Bayesian networks for variables that are not discrete (and with a finite state space)?
* A: Not in full generality. However, using the likelihood evidence facilities, one can work with some types of non-discrete variables.

## Reporting bugs etc.

When reporting unexpected behaviours, bugs etc. PLEASE supply:

* A small reproducible example in terms of a short code fragment.
* The data. The preferred way of sending the data “mydata” is to copy and paste the result from running dput(mydata).
* The result of running the sessionInfo() function.