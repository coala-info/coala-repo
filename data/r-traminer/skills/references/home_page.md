![TraMineR title](images/TraMineR-logo-roundcorners2.jpg)

* [[ home ]](index.shtml "Welcome page")
* [[ doc ]](documentation.shtml "Documentation")
* [[ preview ]](preview-main.shtml "Preview")
* [[ history ]](revisionhistory.shtml "History of TraMineR releases")
* [[ install ]](install.shtml "Download and install TraMineR")
* [[ help & contact ]](contrib.shtml "Contact us")

[![](images/fss_en.gif)](https://www.unige.ch/sciences-societe/en/presentation/)

### News

* Dec 14, 2025
* TraMineR 2.2-13.
  Look at [changes.](https://cran.r-project.org/web/packages/TraMineR/news.html)
* Jun 29, 2025
* TraMineR 2.2-12.
* Dec 8, 2024
* TraMineR 2.2-11.
* Aug 17, 2024
* TraMineRextras 0.6.8 ( [changes](https://cran.r-project.org/web/packages/TraMineRextras/news.html))
* May 21, 2024
* TraMineR 2.2-10.
* Jan 8, 2024
* TraMineR 2.2-9.
* Jan 8, 2024
* TraMineRextras 0.6.7.

+ Sep 18, 2023
+ TraMineR 2.2-8

- Mar 31, 2023
- TraMineR 2.2-7
- Mar 7, 2023
- TraMineRextras 0.6.6
- October 18, 2018
- Book [Sequence Analysis and Related Approaches](https://dx.doi.org/10.1007/978-3-319-95420-2)
- May 15, 2017
- TraMineR 2.0-5 Major update.
  Includes all dissimilarity measures addressed in [Studer and Ritschard (2016)](http://dx.doi.org/10.1111/rssa.12125).
- June 8-10, 2016
- [LaCOSA II](https://lacosa.lives-nccr.ch/) Conference.
- April 8, 2013
- "[traminer](http://stackoverflow.com/questions/tagged/traminer)" tag on StackOverflow
- August 28, 2012
- "[traminer](http://stats.stackexchange.com/questions/tagged/traminer)" tag on StackExchange CV
- Jul 15, 2008
- TraMineR 1.0 released on the CRAN.

## TraMineR: a Sequence Analysis Toolkit

TraMineR is a [R](http://www.r-project.org/)-package for manipulating, describing, visualizing, and analyzing
sequences of states or events, and more generally discrete sequence data. Its primary aim is the analysis of longitudinal data in the social sciences, such as data describing careers, family trajectories, and time-use. However, most of its features also apply to many other kinds of categorical sequence data. They include:

* Handling of longitudinal data and conversion between various sequence formats
* Plotting sequences (density plot, frequency plot, index plot and more)
* Individual longitudinal characteristics of sequences (length, time in each state, longitudinal entropy, turbulence, complexity, insecurity, and many more)
* Sequence of cross-sectional characteristics by time point (transversal state distribution, transversal entropy, modal state)
* Other aggregated characteristics (transition rates, average duration in each state, sequence frequency)
* Dissimilarities between pairs of sequences: Edit distances (Optimal matching and many variants of it, Hamming, ...), Metrics based on counts of common attributes (based on longest common subsequence, on number of matching subsequences, ...), Distances between state distributions (Chi-squared, Euclidean, ...)
* Multidomain/multichannel sequence analysis (multichannel distances, association between domains, multichannel plots)
* Medoid and heterogeneity measure of a set of sequences
* Discovering and plotting representative sequences
* ANOVA-like analysis of sequences
* Regression trees of sequences
* Parallel coordinate plot of state and event sequences
* Extracting frequent event subsequences
* Identifying most discriminating event subsequences
* Association rules between subsequences

Click [here for a short preview](preview-main.shtml) of what TraMineR can do for you!

## What does TraMineR stand for?

It is a contraction of Life Trajectory Miner for R (and was inspired by the authors' taste for Gewürztraminer wine).

## Who is developing TraMineR?

TraMineR is developed at
the [Institute of Demography and Socioeconomics (IDESO)](http://www.unige.ch/sciences-societe/ideso/),
[University of Geneva](http://www.unige.ch/), Switzerland. The package is currently maintained by

* [Gilbert Ritschard](http://mephisto.unige.ch/Gilbert/)
* [Matthias Studer](https://www.unige.ch/sciences-societe/ideso/membres/matthias-studer/)

TraMineR was originally created by [Alexis Gabadinho](https://www.researchgate.net/profile/Alexis-Gabadinho), [Gilbert Ritschard](http://mephisto.unige.ch/Gilbert/), [Matthias Studer](https://www.unige.ch/sciences-societe/ideso/membres/matthias-studer/), and Nicolas S. Müller within the project [Mining event histories](http://mephisto.unige.ch/biomining/) funded by the [Swiss National Foundation for Scientific Research](http://www.snf.ch/E/Pages/default.aspx) under grants FN-116416 and FN-122230. It later benefited from contributions of [Reto Bürgin](https://www.researchgate.net/profile/Reto-Buergin) and [Pierre-Alexandre Fonta](https://www.linkedin.com/in/pafonta/) thanks to support of the [NCCR LIVES - overcoming vulnerability: life course perspectives](https://www.lives-nccr.ch/en).

## Other R packages from the TraMineR team

* [TraMineRextras](https://CRAN.R-project.org/package%3DTraMineRextras), TraMineR ancillary functions
* [PST](https://CRAN.R-project.org/package%3DPST), Alexis Gabadinho's package for Probabilistic Suffix Trees
* [WeightedCluster](https://CRAN.R-project.org/package%3DWeightedCluster), Matthias Studer's clustering package
* [seqSHP](https://CRAN.R-project.org/package%3DseqSHP), building sequences from SHP waves
* [vcrpart](https://CRAN.R-project.org/package%3Dvcrpart), Reto Bürgin's package for Tree-based varying coefficients for ordinal mixed regression models and generalized linear regression models.

## Useful links

* The [Sequence Analysis Association](http://www.sequenceanalysis.org/) (SAA)
* R, [The R-Project for Statistical Computing](http://www.r-project.org/). R is the free open-source statistical environment used by TraMineR.
* For information about contributed R-packages look at the [CRAN](http://cran.r-project.org).
* [Journal of Statistical Software](http://www.jstatsoft.org/) publishes, among others, articles about R-packages.

|  |  |  |  |
| --- | --- | --- | --- |
| [![](http://traminer.unige.ch/images/UNIGE_noir.gif)](https://www.unige.ch/en/) | [Institute of Demography and Socioeconomics (IDESO)](http://www.unige.ch/sciences-societe/ideso/), [University of Geneva](http://www.unige.ch/), Switzerland | [![](../images/logo-livesnccr-en-trsp-small.gif)](https://www.lives-nccr.ch/en) | [![](http://traminer.unige.ch/images/snf_logo.gif)](http://www.snf.ch/en/) |