[![gamlss2](https://www.gamlss.com/wp-content/uploads/2023/05/gamlss2.png)![gamlss2](https://www.gamlss.com/wp-content/uploads/2023/05/gamlss2.png)![gamlss2](https://www.gamlss.com/wp-content/uploads/2023/05/gamlss2.png)![gamlss2](https://www.gamlss.com/wp-content/uploads/2023/05/gamlss2.png)](https://www.gamlss.com "gamlss")

* [Home](https://www.gamlss.com/)
* More on Gamlss
  + [Books & Vignettes](https://www.gamlss.com/books-vignettes/)
  + [Distributions](https://www.gamlss.com/distributions/)
  + [Additive Terms](https://www.gamlss.com/additive-terms/)
  + [The R packages](https://www.gamlss.com/the-r-packages/)
  + [Centile Estimation](https://www.gamlss.com/centile-estimation/)
  + [Short Courses And Talks](https://www.gamlss.com/short-courses-and-talks/)
* [The Team](https://www.gamlss.com/the-team/)
* Information
  + [Centile Information](/information/centile-estimation/)
  + [The Books](/information/the-books)
  + [Additive Terms](/information/additive-terms)
  + [R Packages](/information/r-packages)
  + [Distributions](/information/distributions)
  + [Diagnostics](/information/diagnostics)
* [Blog](https://www.gamlss.com/blog/)

[Contact](/contact)

✕

![Slide](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png "Home")
![](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png)
GAMLSS are implemented in R

There are more than 100 different distributions and several different additive terms which can be used
![](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png)

![Slide](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png "Home")
![](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png)
GAMLSS are statistical models where the location, scale, skewness and kurtosis parameters for the distribution of the response variable can be modelled explicitly as functions of the explanatory
![](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png)

![Slide](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png "Home")
![](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png)
The WHO Multicentre Growth Reference Study adopted GAMLSS and the BCPE distributions for the construction of the WHO Child Growth Standards
![](//www.gamlss.com/wp-content/plugins/revslider/sr6/assets/assets/dummy.png)

## Generalized Additive Models for Location, Scale and Shape

#### Statistical modelling at its best

##### ABOUT GAMLSS

---

##### 01. What is GAMLSS

GAMLSS are **distributional regression** models. In classical regression models, the explanatory variables, **X**, affect the expected value of the response **y,**  **X** -> E(**y**). In a distributional regression the **X**'s effects all parts of the distribution of **y**,  i.e.  **X** -> D(**y**). The  GAMLSS models are appropriate when the focus of the study is not only shifts in  the mean (or location) of the distribution for **y** but possibly other parts like the variance (volatility),  the skewness, the kurtosis (heavy tails),  the quantiles. **All** aspects of the the distribution of the response  can be modelled as functions of the explanatory variables. The majority  of GAMLSS models are **interpretable**.

##### 02. How to use GAMLSS

GAMLSS are implemented in **R**. The  basic packages **gamlss, gamlss.data, gamlss.dist** containing (penalised) likelihood fitting algorithms, data and distributions, respectively. The package **gamboostLSS** fits GAMLSS using boosting. The package **bamlss** fits GAMLSS using Bayesian MCMC. Other packages connect GAMLSS with  machine learning methodologies like neural networks, regression trees, LASSO, principal component regression (PCR), and with the Grammar of Graphics (**ggplot2**).  A faster and extended  version **gamlss2 i**s under preparation and can be downloaded [**here**](https://gamlss-dev.r-universe.dev/builds). It will be released in CRAN soon.

##### 03. What distributions can be used within GAMLSS

The [**gamlss.dist**](https://cran.r-project.org/web/packages/gamlss.dist/index.html) package provides over **100** *continuous*, *discrete* and *mixed* distributions for modelling the target variable. Truncated, censored (interval response), log and logit transformed and finite mixture versions of these distributions can be also used. The book  [***Distributions for Modelling Location, Scale, and Shape: Using GAMLSS in R***](https://www.routledge.com/Distributions-for-Modeling-Location-Scale-and-Shape-Using-GAMLSS-in-R/Rigby-Stasinopoulos-Heller-Bastiani/p/book/9781032089423), is a comprehensive review of all the distributions used within GAMLSS. Because of the distributional assumption for the response  GAMLSS provides **interval forecasting** and also **z-scores** for the identification of probmematic observations.

##### 04. What additive terms can be used within GAMLSS

**Machine Learning** techniques can be use within GAMLSS to model **all** distribution **parameters**. Which machine learning technique is appropriate  depends on the amount of explanatory power is required. For **additive** smoothing terms; *P-splines, Cubic smoothing splines, regression spines and  loess are available. For **dimensionality reduction**  ridge, LASSO, and**principle component regression (PCR) can be used .* For modelling **interactions,** *regression trees, random forests and neural networks*. For simpler interactions *varying coefficient* models*.*

##### 05. Who's is using GAMLSS

The main beneficiaries from GAMLSS are practitioners who have to deal with highly skewed and kurtotic data. Such data sets are very common in  **medicine**  i.e.  growth curve fitting (centile estimation), **environmental** studies and in the **financial** community. The World Health Organisation (WHO), the Global Lung Function Initiative, the International Monetary Fund (IMF), the Bank of England, the Bank of America, (BoA), European parliament, and the Great Barrier Reef Marine Park Authority all have used GAMLSS to analyse their data.

##### 06. How to learn more about GAMLSS

The following books on GAMLSS are available: i) [**Flexible Regression and Smoothing: Using GAMLSS in R**](https://www.routledge.com/Flexible-Regression-and-Smoothing-Using-GAMLSS-in-R/Stasinopoulos-Rigby-Heller-Voudouris-Bastiani/p/book/9780367658069) (April 2017) ii) [**Distributions for Modelling Location, Scale, and Shape: Using GAMLSS in R**](https://www.routledge.com/Distributions-for-Modeling-Location-Scale-and-Shape-Using-GAMLSS-in-R/Rigby-Stasinopoulos-Heller-Bastiani/p/book/9781032089423) (October 2019) iii) [**Generalized Additive Models for Location, Scale and Shape; A Distributional Regression Approach, with Applications**](https://www.cambridge.org/us/universitypress/subjects/statistics-probability/statistical-theory-and-methods/generalized-additive-models-location-scale-and-shape-distributional-regression-approach-applications?format=HB&utm_source=SFMC&utm_medium=email&utm_content=Generalized+Additive+Models+for+Location%2c+Scale+and+Shape&utm_campaign=JWM_IOC_CS_BK%3bJL%3b_STAT%3b_APR%3bCPC%3bJPR%3b_Statistics+and+Probability_FEB24_Global&WT.mc_id=JWM_IOC_CS_BK%3bJL%3b_STAT%3b_APR%3bCPC%3bJPR%3b_Statistics+and+Probability_FEB24_Global) (February 2024)

S**hort courses** on GAMLSS are held regularly.  See the page "*More on GAMLSS/ Short Courses And Talks"*  for current information.

.

### Information

* [![](https://www.gamlss.com/wp-content/uploads/2023/06/centiles-2-940x346-1.jpg)](https://www.gamlss.com/information/centile-estimation/)

  ##### [Centile estimation](https://www.gamlss.com/information/centile-estimation/)
* [![](https://www.gamlss.com/wp-content/uploads/2023/06/Bookimage-670x257-1.png)](https://www.gamlss.com/information/the-books/)

  ##### [The Books](https://www.gamlss.com/information/the-books/)
* [![](https://www.gamlss.com/wp-content/uploads/2023/06/Additive-Terms-Main.jpg)](https://www.gamlss.com/information/additive-terms/)

  ##### [Additive Terms](https://www.gamlss.com/information/additive-terms/)
* [![](https://www.gamlss.com/wp-content/uploads/2023/06/R-packages-Main.jpg)](https://www.gamlss.com/information/r-packages/)

  ##### [R packages](https://www.gamlss.com/information/r-packages/)
* [![](https://www.gamlss.com/wp-content/uploads/2023/06/Distributions-Main.jpg)](https://www.gamlss.com/information/distributions/)

  ##### [Distributions](https://www.gamlss.com/information/distributions/)
* [![](https://www.gamlss.com/wp-content/uploads/2023/06/Diagnostics-Main.jpg)](https://www.gamlss.com/information/diagnostics/)

  ##### [Diagnostics](https://www.gamlss.com/information/diagnostics/)

###### Gamlss

## Blogs & Latest News

December 3, 2015

[![](https://www.gamlss.com/wp-content/uploads/2023/06/Screen-Shot-2015-02-20-at-08.33.44-621x257-1.png)](https://www.gamlss.com/version-4-3-3/)

Published by  [admin](https://www.gamlss.com/author/admin/) on  December 3, 2015

## [Version 4.3-3](https://www.gamlss.com/version-4-3-3/)

1. package: gamlss i) The glim.fit() function within gamlss() has a line added to prevent the iterative weighs wt to go to Inf. ii) The tp() […]

Do you like it?

[Read more](https://www.gamlss.com/version-4-3-3/)

January 21, 2014

[![](https://www.gamlss.com/wp-content/uploads/2014/01/Munich-670x257-1.jpeg)](https://www.gamlss.com/version-4-2-7/)

Published by  [admin](https://www.gamlss.com/author/admin/) on  January 21, 2014

## [Version 4.2-7](https://www.gamlss.com/version-4-2-7/)

Version 4.2-7 i) gamlss gamlssML(): now allows the fitting binomial data (sorry it never checked before) and the use of formula in the specification of the model […]

Do you like it?

[Read more](https://www.gamlss.com/version-4-2-7/)

June 24, 2013

[![](https://www.gamlss.com/wp-content/uploads/2013/06/LikelihoodScematic-670x257-1.jpeg)](https://www.gamlss.com/version-4-2-6/)

Published by  [admin](https://www.gamlss.com/author/admin/) on  June 24, 2013

## [Version 4.2-6](https://www.gamlss.com/version-4-2-6/)

This version is released on the 22–6-2013 and it is the first time that robust (sandwich) standard errors are introduce  in gamlss models.  Of course those standard […]

Do you like it?

[Read more](https://www.gamlss.com/version-4-2-6/)

May 24, 2013

[![](https://www.gamlss.com/wp-content/uploads/2013/05/RentAreaPlot-small-499x257-1.jpeg)](https://www.gamlss.com/version-4-2-5/)

Published by  [admin](https://www.gamlss.com/author/admin/) on  May 24, 2013

## [Version 4.2.5](https://www.gamlss.com/version-4-2-5/)

Version 4.2-5 The most important change in this version of gamlss is the way that the standard errors are calculated. In  previous version the vcov() function was calculated using a […]

Do you like it?

[Read more](https://www.gamlss.com/version-4-2-5/)

## What Did They Say

* ![](https://www.gamlss.com/wp-content/uploads/2023/06/Testimonial-Logo-150x150.jpg)

  > All models are wrong but some are useful.

  ##### George Box
* ![](https://www.gamlss.com/wp-content/uploads/2023/06/Testimonial-Logo-150x150.jpg)

  > Far better an approximate answer to the right question, which is often vague, than an exact answer to the wrong question, which can always be made precise.

  ##### John W. Tukey
* ![](https://www.gamlss.com/wp-content/uploads/2023/06/Testimonial-Logo-150x150.jpg)

  > No matter how beautiful your theory, no matter how clever you are or what your name is, if it disagrees with experiment, it’s wrong.

  ##### Richard Feynman
* ![](https://www.gamlss.com/wp-content/uploads/2023/06/Testimonial-Logo-150x150.jpg)

  > Entities should not be multiplied beyond necessity.

  ##### Occam’s Razor
* ![](https://www.gamlss.com/wp-content/uploads/2023/06/Testimonial-Logo-150x150.jpg)

  > The type of statistical inference used may be less important to the conclusions than choosing a suitable model in the first place.

  ##### The GAMLSS team

![](https://www.gamlss.com/wp-content/uploads/2023/05/gamlss2.png)

Generalized Additive Models for Location, Scale and Shape

#### Recent Posts

* [Version 4.3-3](https://www.gamlss.com/version-4-3-3/)
* [Version 4.2-7](https://www.gamlss.com/version-4-2-7/)
* [Version 4.2-6](https://www.gamlss.com/version-4-2-6/)

Copyright 2026 Gamlss | Created by [You Media](http://www.youmedia.online)

[Contact](/contact)

![Home](https://www.gamlss.com/wp-content/themes/betheme/images/cookies.png)

This website uses cookies to improve your experience. By using this website you agree to our [Data Protection Policy](/privacy-policy).

[Read more](https://www.gamlss.com/privacy-policy/)Accept all