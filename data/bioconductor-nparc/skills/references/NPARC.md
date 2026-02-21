# Analysing thermal proteome profiling data with the NPARC package

Dorothee Childs and Nils Kurzawa

#### 30 October 2025, 01:26:39

#### Package

NPARC 1.22.0

# Contents

* [1 Introduction](#introduction)
* [2 Preparation](#preparation)
* [3 Data import](#data-import)
* [4 Data preprocessing and exploration](#data-preprocessing-and-exploration)
* [5 Illustrative example](#illustrative-example)
  + [5.1 Select data](#select-data)
  + [5.2 Define function for model fitting](#define-function-for-model-fitting)
  + [5.3 Fit and plot null models](#fit-and-plot-null-models)
  + [5.4 Fit and plot alternative models](#fit-and-plot-alternative-models)
  + [5.5 Compute RSS values](#compute-rss-values)
* [6 Extend the analysis to all proteins](#extend-the-analysis-to-all-proteins)
  + [6.1 Start fitting](#start-fitting)
  + [6.2 Check example](#check-example)
* [7 Compute test statistics](#compute-test-statistics)
  + [7.1 Why we need to estimate the degrees of freedom](#why-we-need-to-estimate-the-degrees-of-freedom)
  + [7.2 How to estimate the degrees of freedom](#how-to-estimate-the-degrees-of-freedom)
* [8 Detect significantly shifted proteins](#detect-significantly-shifted-proteins)
* [9 Session info](#session-info)
* [Bibliography](#bibliography)

# 1 Introduction

This vignette shows how to reproduce the analysis described by [Childs, Bach, Franken et al. (2019): Non-parametric analysis of thermal proteome profiles reveals novel drug-binding proteins](https://doi.org/10.1101/373845) using the `NPARC` package.

# 2 Preparation

Load necessary packages.

```
library(dplyr)
library(magrittr)
library(ggplot2)
library(broom)
library(knitr)
library(NPARC)
```

# 3 Data import

First, we load data from a staurosporine TPP experiment (Savitski et al. [2014](#ref-Savitski2014)). The necessary ETL (extract, transform, load) steps have already been conducted, including download from the supplements of the respective publication and conversion into tidy format.

```
data("stauro_TPP_data_tidy")
```

Before applying any further transformations and filters we create a copy of the imported data.

```
df <- stauro_TPP_data_tidy
```

Let’s perform a first check of the imported data:

```
df %>%
  mutate(compoundConcentration = factor(compoundConcentration),
         replicate = factor(replicate),
         dataset = factor(dataset)) %>%
  summary()
```

```
##           dataset         uniqueID          relAbundance      temperature
##  Staurosporine:307080   Length:307080      Min.   :  0.000   Min.   :40.0
##                         Class :character   1st Qu.:  0.169   1st Qu.:46.0
##                         Mode  :character   Median :  0.573   Median :53.5
##                                            Mean   :  0.576   Mean   :53.5
##                                            3rd Qu.:  0.951   3rd Qu.:61.0
##                                            Max.   :394.981   Max.   :67.0
##                                            NA's   :70990
##  compoundConcentration replicate  uniquePeptideMatches
##  0 :153540             1:153540   Min.   :  0.00
##  20:153540             2:153540   1st Qu.:  2.00
##                                   Median :  6.00
##                                   Mean   : 10.36
##                                   3rd Qu.: 13.00
##                                   Max.   :351.00
##                                   NA's   :63400
```

The displayed data contains the following columns:

* `dataset`: The dataset containing the measurements of several TMT-10 experiments. In each experiment, cells were treated with a vehicle or with the compound in one or two concentrations, and measured at ten different temperatures.
* `uniqueID`: The unique identifier for each protein. In the given dataset, it contains the gene symbol concatenated by IPI id. Example: 15 KDA PROTEIN.\_IPI00879051, 16 KDA PROTEIN.\_IPI00903282, 17 KDA PROTEIN.\_IPI00878120, 17 KDA PROTEIN.\_IPI00736161, 176 KDA PROTEIN.\_IPI00894060, 18 KDA PROTEIN.\_IPI00644570 .
* `relAbundance`: The relative signal intensity of the protein in each experiment, scaled to the intensity at the lowest temperature.
* `temperature`: The temperatures corresponding to each of the ten measurements in a TMT experiment.
* `compoundConcentration` The concentration of the administered compound in \(\mu M\).
* `replicate`: The replicate number in each experimental group. Each pair of vehicle and treatment experiments was conducted in two replicates.
* `uniquePeptideMatches`: The number of unique peptides with which a protein was identified.

# 4 Data preprocessing and exploration

The imported data contains **307080** rows with entries for **7677** proteins.

First, we remove all abundances that were not found with at least one unique peptide, or for which a missing value was recorded.

```
df %<>% filter(uniquePeptideMatches >= 1)
df %<>% filter(!is.na(relAbundance))
```

Next, we ensure that the dataset only contains proteins reproducibly observed with full melting curves in both replicates and treatment groups per dataset.
A full melting curve is defined by the presence of measurements at all 10 temperatures for the given experimental group.

```
# Count full curves per protein
df %<>%
  group_by(dataset, uniqueID) %>%
  mutate(n = n()) %>%
  group_by(dataset) %>%
  mutate(max_n = max(n)) %>%
  ungroup

table(distinct(df, uniqueID, n)$n)
```

```
##
##   10   20   30   40
##  992  809  993 4505
```

We see that the majority of proteins contain 40 measurements. This corresponds to two full replicate curves per experimental group. We will focus on these in the current analysis.

```
# Filter for full curves per protein:
df %<>%
  filter(n == max_n) %>%
  dplyr::select(-n, -max_n)
```

The final data contains **180200** rows with entries for **4505** proteins.
This number coincides with the value reported in Table 1 of the corresponding publication (Childs et al. [2019](#ref-Childs2019)).

# 5 Illustrative example

We first illustrate the principles of nonparametric analysis of response curves (NPARC) on an example protein (STK4) from the staurosporine dataset. The same protein is shown in Figures 1 and 2 of the paper.

## 5.1 Select data

We first select all entries belonging to the desired protein and dataset:

```
stk4 <- filter(df, uniqueID == "STK4_IPI00011488")
```

The table `stk4` has 40 rows with measurements of four experimental groups. They consist of two treatment groups (vehicle: \(0~\mu M\) staurosporine, treatment: \(20~\mu M\) staurosporine) with two replicates each. Let us look at the treatment group of replicate 1 for an example:

```
stk4 %>% filter(compoundConcentration == 20, replicate == 1) %>%
  dplyr::select(-dataset) %>% kable(digits = 2)
```

| uniqueID | relAbundance | temperature | compoundConcentration | replicate | uniquePeptideMatches |
| --- | --- | --- | --- | --- | --- |
| STK4\_IPI00011488 | 1.00 | 40 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 1.03 | 43 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 1.06 | 46 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 1.03 | 49 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 0.92 | 52 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 0.93 | 55 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 0.78 | 58 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 0.44 | 61 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 0.21 | 64 | 20 | 1 | 8 |
| STK4\_IPI00011488 | 0.12 | 67 | 20 | 1 | 8 |

To obtain a first impression of the measurements in each experimental group, we generate a plot of the measurements:

```
stk4_plot_orig <- ggplot(stk4, aes(x = temperature, y = relAbundance)) +
  geom_point(aes(shape = factor(replicate), color = factor(compoundConcentration)), size = 2) +
  theme_bw() +
  ggtitle("STK4") +
  scale_color_manual("staurosporine (mu M)", values = c("#808080", "#da7f2d")) +
  scale_shape_manual("replicate", values = c(19, 17))

print(stk4_plot_orig)
```

![](data:image/png;base64...)

We will show how to add the fitted curves to this plot in the following steps.

## 5.2 Define function for model fitting

To assess whether there is a significant difference between both treatment groups, we will fit a null model and an alternative models to the data. The null model fits a sigmoid melting curve through all data points irrespective of experimental condition. The alternative model fits separate melting curves per experimental group .

## 5.3 Fit and plot null models

We use the `NPARC` package function `fitSingleSigmoid` to fit the null model:

```
nullFit <- NPARC:::fitSingleSigmoid(x = stk4$temperature, y = stk4$relAbundance)
```

The function returns an object of class `nls`:

```
summary(nullFit)
```

```
##
## Formula: y ~ (1 - Pl)/(1 + exp((b - a/x))) + Pl
##
## Parameters:
##    Estimate Std. Error t value Pr(>|t|)
## Pl   0.0000     0.1795   0.000  1.00000
## a  692.6739   226.9107   3.053  0.00419 **
## b   12.5048     4.4989   2.780  0.00851 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 0.1814 on 37 degrees of freedom
##
## Algorithm "port", convergence message: relative convergence (4)
```

The function `augment` from the `broom` package provides a convenient way to obtain the predictions and residuals at each temperature in tabular format. By appending the returned predictions and residuals to our measurements, we ensure that relevant data is collected in the same table and can be added to the plot for visualization. The residuals will be needed later for construction of the test statistic:

```
nullPredictions <- broom::augment(nullFit)
```

Let us look at the values returned by `augment` at two consecutive temperatures. Note that, while the predictions will be the same for each experiment at a given temperature, the residuals will differ because they were computed by comparing the predictions to the actual measurements:

```
nullPredictions %>% filter(x %in% c(46, 49)) %>% kable()
```

| x | y | .fitted | .resid |
| --- | --- | --- | --- |
| 46 | 1.0591140 | 0.9278000 | 0.1313139 |
| 49 | 1.0333794 | 0.8363683 | 0.1970111 |
| 46 | 0.9449568 | 0.9278000 | 0.0171568 |
| 49 | 0.9187253 | 0.8363683 | 0.0823571 |
| 46 | 0.8661451 | 0.9278000 | -0.0616550 |
| 49 | 0.7139894 | 0.8363683 | -0.1223788 |
| 46 | 0.8717407 | 0.9278000 | -0.0560594 |
| 49 | 0.7068211 | 0.8363683 | -0.1295471 |

Now we can append these values to our data frame and show the predicted curve in the plot:

```
stk4$nullPrediction <- nullPredictions$.fitted
stk4$nullResiduals <- nullPredictions$.resid

stk4_plot <- stk4_plot_orig + geom_line(data = stk4, aes(y = nullPrediction))

print(stk4_plot)
```

![](data:image/png;base64...)

## 5.4 Fit and plot alternative models

Next we fit the alternative model. Again, we compute the predicted values and the corresponding residuals by the `broom::augment()` function. To take the compound concentration as a factor into account, we iterate over both concentrations and fit separate models to each subset. We implement this by first grouping the data using the function `dplyr::group_by()`, and starting the model fitting by `dplyr::do()`.

```
alternativePredictions <- stk4 %>%
# Fit separate curves per treatment group:
  group_by(compoundConcentration) %>%
  do({
    fit = NPARC:::fitSingleSigmoid(x = .$temperature, y = .$relAbundance, start=c(Pl = 0, a = 550, b = 10))
    broom::augment(fit)
  }) %>%
  ungroup %>%
  # Rename columns for merge to data frame:
  dplyr::rename(alternativePrediction = .fitted,
                alternativeResiduals = .resid,
                temperature = x,
                relAbundance = y)
```

Add the predicted values and corresponding residuals to our data frame:

```
stk4 <- stk4 %>%
  left_join(alternativePredictions,
            by = c("relAbundance", "temperature",
                   "compoundConcentration")) %>%
  distinct()
```

```
## Warning in left_join(., alternativePredictions, by = c("relAbundance", "temperature", : Detected an unexpected many-to-many relationship between `x` and `y`.
## ℹ Row 1 of `x` matches multiple rows in `y`.
## ℹ Row 21 of `y` matches multiple rows in `x`.
## ℹ If a many-to-many relationship is expected, set `relationship =
##   "many-to-many"` to silence this warning.
```

Add the curves predicted by the alternative model to the plot. Conceptually, it corresponds to the plot shown in Figures 2 (A)/(B) of the paper.

```
stk4_plot <- stk4_plot +
  geom_line(data = distinct(stk4, temperature, compoundConcentration, alternativePrediction),
            aes(y = alternativePrediction, color = factor(compoundConcentration)))

print(stk4_plot)
```

![](data:image/png;base64...)

This plot summarizes Figures 2(A) and 2(B) in the corresponding publication (Childs et al. [2019](#ref-Childs2019)).

## 5.5 Compute RSS values

In order to quantify the improvement in goodness-of-fit of the alternative model relative to the null model, we compute the sum of squared residuals (RSS):

```
rssPerModel <- stk4 %>%
  summarise(rssNull = sum(nullResiduals^2),
            rssAlternative = sum(alternativeResiduals^2))

kable(rssPerModel, digits = 4)
```

| rssNull | rssAlternative |
| --- | --- |
| 1.2181 | 0.0831 |

These values will be used to construct the \(F\)-statistic according to

\[\begin{equation}
\label{eq:f\_stat}
{F} = \frac{{d}\_{2}}{{d}\_{1}} \cdot \frac{{RSS}^{0} - {RSS}^{1}}{{RSS}^{1}}.
\end{equation}\]

To compute this statistic and to derive a p-value, we need the degrees of freedom \({d}\_{1}\) and \({d}\_{2}\). As described in the paper, they cannot be analytically derived due to the correlated nature of the measurements. The paper describes how to estimate these values from the RSS-values of all proteins in the dataset. In the following Section, we illustrate how to repeat the model fitting for all proteins of a dataset and how to perform hypothesis testing on these models.

# 6 Extend the analysis to all proteins

This section describes the different steps of the NPARC workflow for model fitting and hyothesis testing. Note that the package also provides a function `runNPARC()` that performs all of the following steps with one single function call.

## 6.1 Start fitting

In order to analyze all datasets as described in the paper, we fit null and alternative models to all proteins using the package function `NPARCfit`:

```
BPPARAM <- BiocParallel::SerialParam(progressbar = FALSE)
```

```
fits <- NPARCfit(x = df$temperature,
                 y = df$relAbundance,
                 id = df$uniqueID,
                 groupsNull = NULL,
                 groupsAlt = df$compoundConcentration,
                 BPPARAM = BPPARAM,
                 returnModels = FALSE)
```

```
## Starting model fitting...
```

```
## ... complete
```

```
## Elapsed time: 27.39 secs
```

```
## Flagging successful model fits...
```

```
## ... complete.
```

```
## Evaluating model fits...
```

```
## Evaluating models ...
```

```
## ... complete.
```

```
## Computing model predictions and residuals ...
```

```
## ... complete.
```

```
## Starting model fitting...
```

```
## ... complete
```

```
## Elapsed time: 57.93 secs
```

```
## Flagging successful model fits...
```

```
## ... complete.
```

```
## Evaluating model fits...
```

```
## Evaluating models ...
```

```
## ... complete.
```

```
## Computing model predictions and residuals ...
```

```
## ... complete.
```

```
str(fits, 1)
```

```
## List of 2
##  $ predictions: tibble [360,055 × 7] (S3: tbl_df/tbl/data.frame)
##  $ metrics    : tibble [13,515 × 15] (S3: tbl_df/tbl/data.frame)
```

The returned object `fits` contains two tables. The table `metrics` contains the fitted parameters and goodness-of-fit measures for the null and alternative models per protein and group. The table `predictions` contains the corresponding predicted values and residuals per model.

```
fits$metrics %>%
  mutate(modelType = factor(modelType), nCoeffs = factor(nCoeffs), nFitted = factor(nFitted), group = factor((group))) %>%
  summary
```

```
##        modelType         id                  tm               a
##  alternative:9010   Length:13515       Min.   : 43.56   Min.   :    0.0
##  null       :4505   Class :character   1st Qu.: 50.21   1st Qu.:  837.1
##                     Mode  :character   Median : 52.85   Median : 1103.0
##                                        Mean   : 54.10   Mean   : 1432.5
##                                        3rd Qu.: 56.30   3rd Qu.: 1489.3
##                                        Max.   :298.81   Max.   :15000.0
##                                        NA's   :786      NA's   :15
##        b                   pl               aumc          resid_sd
##  Min.   :  0.00001   Min.   :0.00000   Min.   : 4.87   Min.   :0.007522
##  1st Qu.: 16.12065   1st Qu.:0.05276   1st Qu.:11.56   1st Qu.:0.035041
##  Median : 21.44579   Median :0.07970   Median :14.46   Median :0.049796
##  Mean   : 27.01317   Mean   :0.14056   Mean   :15.03   Mean   :0.064141
##  3rd Qu.: 28.40278   3rd Qu.:0.14417   3rd Qu.:18.06   3rd Qu.:0.074622
##  Max.   :250.00000   Max.   :1.50000   Max.   :37.42   Max.   :1.896479
##  NA's   :15          NA's   :15        NA's   :15      NA's   :15
##       rss                loglik           tm_sd           nCoeffs
##  Min.   : 0.001131   Min.   :-70.47   Min.   :0.000e+00   3   :13500
##  1st Qu.: 0.029214   1st Qu.: 27.32   1st Qu.:0.000e+00   NA's:   15
##  Median : 0.063605   Median : 37.21   Median :0.000e+00
##  Mean   : 0.198927   Mean   : 40.00   Mean   :5.764e+12
##  3rd Qu.: 0.150666   3rd Qu.: 49.53   3rd Qu.:1.000e+00
##  Max.   :79.398036   Max.   :123.31   Max.   :5.529e+16
##  NA's   :15          NA's   :15       NA's   :787
##  nFitted        conv          group
##  20  :8998   Mode :logical   0   :4505
##  40  :4502   FALSE:15        20  :4505
##  NA's:  15   TRUE :13500     NA's:4505
##
##
##
##
```

```
fits$predictions %>%
  mutate(modelType = factor(modelType), group = factor((group))) %>%
  summary
```

```
##        modelType           id                  x              y
##  alternative:179972   Length:360055      Min.   :40.0   Min.   :0.0000
##  null       :180083   Class :character   1st Qu.:46.0   1st Qu.:0.1563
##                       Mode  :character   Median :53.5   Median :0.5782
##                                          Mean   :53.5   Mean   :0.5643
##                                          3rd Qu.:61.0   3rd Qu.:0.9570
##                                          Max.   :67.0   Max.   :8.2379
##                                          NA's   :15     NA's   :15
##     .fitted            .resid            group
##  Min.   :0.01099   Min.   :-1.1555855   0   : 89967
##  1st Qu.:0.15957   1st Qu.:-0.0252715   20  : 90005
##  Median :0.58435   Median : 0.0003108   NA's:180083
##  Mean   :0.55996   Mean   : 0.0043727
##  3rd Qu.:0.96271   3rd Qu.: 0.0281145
##  Max.   :1.50000   Max.   : 7.2402768
##  NA's   :15        NA's   :15
```

## 6.2 Check example

The results of the STK4 example from earlier can be selected from this object as follows.

First, we check the RSS values of the null and alterantive models:

```
stk4Metrics <- filter(fits$metrics, id == "STK4_IPI00011488")

rssNull <- filter(stk4Metrics, modelType == "null")$rss
rssAlt <- sum(filter(stk4Metrics, modelType == "alternative")$rss) # Summarize over both experimental groups

rssNull
```

```
## [1] 1.218132
```

```
rssAlt
```

```
## [1] 0.08314745
```

Next, we plot the predicted curves per model and experimental group:

```
stk4Predictions <- filter(fits$predictions, modelType == "alternative", id == "STK4_IPI00011488")

stk4_plot_orig +
  geom_line(data = filter(stk4Predictions, modelType == "alternative"),
            aes(x = x, y = .fitted, color = factor(group))) +
    geom_line(data = filter(stk4Predictions, modelType == "null"),
            aes(x = x, y = .fitted))
```

![](data:image/png;base64...)

# 7 Compute test statistics

## 7.1 Why we need to estimate the degrees of freedom

In order to compute \(F\)-statistics per protein and dataset according to Equation (), we need to know the degrees of freedom of the corresponding null distribution. If we could assume independent and identically distributed (iid) residuals, we could compute them from the number of fitted values and model parameters. In the following, we will show why this simple equation is not appropriate for the curve data we are working with.

First, we compute the test statistics and p-values with theoretical degrees of freedom. These would be true for the case of iid residuals:

```
modelMetrics <- fits$metrics
fStats <- NPARCtest(modelMetrics, dfType = "theoretical")
```

Let us take a look at the computed degrees of freedom:

```
fStats %>%
  filter(!is.na(pAdj)) %>%
  distinct(nFittedNull, nFittedAlt, nCoeffsNull, nCoeffsAlt, df1, df2) %>%
  kable()
```

| nFittedNull | nFittedAlt | nCoeffsNull | nCoeffsAlt | df1 | df2 |
| --- | --- | --- | --- | --- | --- |
| 40 | 40 | 3 | 6 | 3 | 34 |

We plot the \(F\)-statistics against the theoretical \(F\)-distribution to check how well the null distribution is approximated now:

```
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_density(aes(x = fStat), fill = "steelblue", alpha = 0.5) +
  geom_line(aes(x = fStat, y = df(fStat, df1 = df1, df2 = df2)), color = "darkred", size = 1.5) +
  theme_bw() +
  # Zoom in to small values to increase resolution for the proteins under H0:
  xlim(c(0, 10))
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 178 rows containing non-finite outside the scale range
## (`stat_density()`).
```

```
## Warning: Removed 178 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![](data:image/png;base64...)

The densities of the theoretical \(F\)-distribution (red) do not fit the observed values (blue) very well. While the theoretical distribution tends to overestimate the number of proteins with test statistics smaller than 2.5, it appears to underestimate the amount of proteins with larger values. This would imply that even for highly specific drugs, we observe many more significant differences than we would expect by chance. This hints at an anti-conservative behaviour of our test with the calculated degree of freedom parameters. This is reflected in the p-value distributions. If the distribution assumptions were met, we would expect the null cases to follow a uniform distribution, with a peak on the left for the non-null cases. Instead, we observe a tendency to obtain fewer values than expected in the middle range (around 0.5), but distinct peaks to the left.

```
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_histogram(aes(x = pVal, y = ..density..), fill = "steelblue", alpha = 0.5, boundary = 0, bins = 30) +
  geom_line(aes(x = pVal, y = dunif(pVal)), color = "darkred", size = 1.5) +
  theme_bw()
```

```
## Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(density)` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

## 7.2 How to estimate the degrees of freedom

In the paper, we describe an alternative way to estimate the degrees of freedom by fitting \(\chi^2\) distributions to the numerator and denominator across all proteins in a dataset. To enable fitting of the distributions, we first need to re-scale the variables by a scaling factor. Because the scaling factors are characteristic for each dataset (it depends on the variances of the residuals in the respective dataset), we estimate them from the data according to:

\[\begin{align} \label{eq:scale-param}
\sigma\_0^2 &= \frac{1}{2} \frac{V}{M},
\end{align}\]

where \(V\) is the variance of the distribution, and \(M\) is the mean of the distribution.

The following functin estimates \(V\) and \(M\) from the empirical distributions of the RSS differences \(({RSS}^1 - {RSS}^0)\). To increase robustness, it estimate \(M\) and \(V\) by their D-estimates Marazzi ([2002](#ref-Marazzi2002)) (median and median absolute deviation).
It then scales the numerator and denominator of the \(F\)-statistic by these scaling factors and estimate the degree of freedom parameters by fitting unscaled \(\chi^2\) distributions. Finally, it fits the degrees of freedom parameters numerically, computes the test statistics according to Equation () and derives p-values.

```
modelMetrics <- fits$metrics
fStats <- NPARCtest(modelMetrics, dfType = "empirical")
```

We plot the \(F\)-statistics against the theoretical \(F\)-distribution to check how well the null distribution is approximated now:

```
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_density(aes(x = fStat), fill = "steelblue", alpha = 0.5) +
  geom_line(aes(x = fStat, y = df(fStat, df1 = df1, df2 = df2)), color = "darkred", size = 1.5) +
  theme_bw() +
  # Zoom in to small values to increase resolution for the proteins under H0:
  xlim(c(0, 10))
```

```
## Warning: Removed 111 rows containing non-finite outside the scale range
## (`stat_density()`).
```

```
## Warning: Removed 111 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![](data:image/png;base64...)

Also check the p-value histograms. We expect the null cases to follow a uniform distribution, with a peak on the left for the non-null cases:

```
ggplot(filter(fStats, !is.na(pAdj))) +
  geom_histogram(aes(x = pVal, y = ..density..), fill = "steelblue", alpha = 0.5, boundary = 0, bins = 30) +
  geom_line(aes(x = pVal, y = dunif(pVal)), color = "darkred", size = 1.5) +
  theme_bw()
```

![](data:image/png;base64...)

The \(F\)-statistics and p-values approximate the expected distributions substantially closer when based on the estimated degrees of freedom than when based on the theoretical degrees of freedom.

# 8 Detect significantly shifted proteins

Finally, we can select proteins that are significantly shifted by putting a threshold on the Benjamini-Hochberg corrected p-values.

```
topHits <- fStats %>%
  filter(pAdj <= 0.01) %>%
  dplyr::select(id, fStat, pVal, pAdj) %>%
  arrange(-fStat)
```

The table `topHits` contains **80** proteins with Benjamini-Hochberg corrected p-values \(\leq 0.01\).

Let us look at the targets detected in each dataset. The same proteins are shown in Fig. S3, S4, S6, and S7 of the paper.

```
knitr::kable(topHits)
```

| id | fStat | pVal | pAdj |
| --- | --- | --- | --- |
| CDK5\_IPI00023530 | 368.52827 | 0.0000000 | 0.0000000 |
| MAP2K2\_IPI00003783 | 148.00924 | 0.0000000 | 0.0000000 |
| CSK\_IPI00013212 | 138.22071 | 0.0000000 | 0.0000000 |
| PMPCA\_IPI00166749 | 136.71923 | 0.0000000 | 0.0000000 |
| AURKA\_IPI00298940 | 130.73864 | 0.0000000 | 0.0000000 |
| FECH\_IPI00554589 | 128.23943 | 0.0000000 | 0.0000000 |
| IRAK4\_IPI00007641 | 121.86405 | 0.0000000 | 0.0000000 |
| CAMKK2\_IPI00290239 | 116.31330 | 0.0000000 | 0.0000000 |
| PAK4\_IPI00014068 | 112.98293 | 0.0000000 | 0.0000000 |
| STK4\_IPI00011488 | 102.06728 | 0.0000000 | 0.0000000 |
| STK38\_IPI00027251 | 99.37605 | 0.0000000 | 0.0000000 |
| PDPK1\_IPI00002538 | 96.60541 | 0.0000000 | 0.0000000 |
| GSK3B\_IPI00216190 | 92.73935 | 0.0000000 | 0.0000001 |
| ADRBK1\_IPI00012497 | 82.16647 | 0.0000000 | 0.0000002 |
| BMP2K\_IPI00337426 | 74.41067 | 0.0000000 | 0.0000003 |
| FER\_IPI00029263 | 70.17755 | 0.0000000 | 0.0000005 |
| MAP2K1\_IPI00219604 | 62.05374 | 0.0000000 | 0.0000012 |
| MAP2K7\_IPI00302112 | 59.57484 | 0.0000000 | 0.0000015 |
| MAP4K2\_IPI00149094 | 57.20287 | 0.0000000 | 0.0000020 |
| MAPK12\_IPI00296283 | 55.58917 | 0.0000000 | 0.0000024 |
| PRKCE\_IPI00024539 | 54.38360 | 0.0000000 | 0.0000026 |
| ADK\_IPI00290279 | 54.32264 | 0.0000000 | 0.0000026 |
| STK3\_IPI00411984 | 53.13742 | 0.0000000 | 0.0000029 |
| MAPK8\_IPI00220306 | 49.97133 | 0.0000000 | 0.0000042 |
| MAPKAPK5\_IPI00160672 | 49.95133 | 0.0000000 | 0.0000042 |
| PKN1\_IPI00412672 | 49.85288 | 0.0000000 | 0.0000042 |
| PTK2\_IPI00413961 | 49.17708 | 0.0000000 | 0.0000044 |
| AAK1\_IPI00916402 | 49.16716 | 0.0000000 | 0.0000044 |
| CHEK2\_IPI00423156 | 46.38891 | 0.0000000 | 0.0000066 |
| CDK2\_IPI00031681 | 45.13670 | 0.0000001 | 0.0000078 |
| MAP2K4\_IPI00024674 | 44.13633 | 0.0000001 | 0.0000087 |
| CPOX\_IPI00093057 | 44.09253 | 0.0000001 | 0.0000087 |
| PHKG2\_IPI00012891 | 42.87681 | 0.0000001 | 0.0000105 |
| TNIK\_IPI00514275 | 42.30456 | 0.0000001 | 0.0000112 |
| VRK1\_IPI00019640 | 41.23110 | 0.0000001 | 0.0000132 |
| MAPKAPK2\_IPI00026054 | 37.87981 | 0.0000002 | 0.0000241 |
| MARK2\_IPI00555838 | 37.66602 | 0.0000002 | 0.0000244 |
| CAMK2G\_IPI00908444 | 36.05743 | 0.0000003 | 0.0000327 |
| GSK3A\_IPI00292228 | 35.91920 | 0.0000003 | 0.0000328 |
| PRKAR2B\_IPI00554752 | 35.68543 | 0.0000003 | 0.0000335 |
| RIOK2\_IPI00306406 | 35.16129 | 0.0000003 | 0.0000364 |
| PRKACA\_IPI00396630 | 33.77649 | 0.0000004 | 0.0000467 |
| RPS6KA3\_IPI00020898 | 33.73842 | 0.0000004 | 0.0000467 |
| MAPK3\_IPI00018195 | 33.16875 | 0.0000005 | 0.0000516 |
| STK24\_IPI00872754 | 32.10230 | 0.0000006 | 0.0000638 |
| MARK3\_IPI00183118 | 29.95166 | 0.0000010 | 0.0001020 |
| TTK\_IPI00151170 | 29.36817 | 0.0000012 | 0.0001146 |
| MKNK1\_IPI00304048 | 25.93732 | 0.0000028 | 0.0002649 |
| PDCD10\_IPI00298558 | 25.71959 | 0.0000030 | 0.0002748 |
| OSBPL3\_IPI00023555 | 25.44789 | 0.0000032 | 0.0002894 |
| HEBP1\_IPI00148063 | 25.03731 | 0.0000036 | 0.0003168 |
| RPS6KA1\_IPI00477982 | 24.26357 | 0.0000044 | 0.0003839 |
| PIK3CD\_IPI00384817 | 23.99278 | 0.0000048 | 0.0004061 |
| MAP3K2\_IPI00513803 | 23.77377 | 0.0000051 | 0.0004238 |
| SGK3\_IPI00655852 | 23.26318 | 0.0000059 | 0.0004809 |
| PRKCB\_IPI00219628 | 22.93066 | 0.0000065 | 0.0005196 |
| IRAK1\_IPI00293652 | 22.84563 | 0.0000066 | 0.0005232 |
| CAMK1D\_IPI00170508 | 22.02666 | 0.0000084 | 0.0006538 |
| POLR2K\_IPI00023975 | 21.36203 | 0.0000103 | 0.0007850 |
| LYN\_IPI00298625 | 20.58339 | 0.0000131 | 0.0009815 |
| CDC42BPA\_IPI00903296 | 20.07904 | 0.0000154 | 0.0011282 |
| PRKCQ\_IPI00029196 | 20.03813 | 0.0000156 | 0.0011282 |
| ALDH6A1\_IPI00024990 | 19.81662 | 0.0000167 | 0.0011919 |
| NEDD4L\_IPI00304945 | 19.68073 | 0.0000175 | 0.0012258 |
| CCNB2\_IPI00028266 | 19.40436 | 0.0000191 | 0.0013202 |
| PRKCD\_IPI00329236 | 17.76369 | 0.0000332 | 0.0022530 |
| PRCP\_IPI00399307 | 17.72712 | 0.0000336 | 0.0022530 |
| XPOT\_IPI00306290 | 17.40894 | 0.0000376 | 0.0024813 |
| MAPK14\_IPI00221141 | 17.26239 | 0.0000396 | 0.0025753 |
| CYCS\_IPI00465315 | 16.00977 | 0.0000624 | 0.0040017 |
| STK10\_IPI00304742 | 15.87868 | 0.0000655 | 0.0041400 |
| FAM96A\_IPI00030985 | 15.84366 | 0.0000664 | 0.0041400 |
| DDX54\_IPI00152510 | 14.02991 | 0.0001348 | 0.0082940 |
| RPS6KB1\_IPI00216132 | 13.98528 | 0.0001373 | 0.0083319 |
| PCTK2\_IPI00376955 | 13.89428 | 0.0001425 | 0.0085321 |
| MAP4K5\_IPI00294842 | 13.81119 | 0.0001474 | 0.0087117 |
| LLGL1\_IPI00105532 | 13.54757 | 0.0001644 | 0.0095885 |
| NQO2\_IPI00219129 | 13.51352 | 0.0001667 | 0.0096007 |
| ROCK2\_IPI00307155 | 13.39601 | 0.0001751 | 0.0099041 |
| TLK2\_IPI00385652 | 13.37849 | 0.0001764 | 0.0099041 |

# 9 Session info

```
devtools::session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package      * version date (UTC) lib source
##  backports      1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
##  BiocManager    1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel   1.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle    * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bookdown       0.45    2025-10-03 [2] CRAN (R 4.5.1)
##  broom        * 1.0.10  2025-09-13 [2] CRAN (R 4.5.1)
##  bslib          0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
##  cachem         1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
##  cli            3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
##  codetools      0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
##  crayon         1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
##  devtools       2.4.6   2025-10-03 [2] CRAN (R 4.5.1)
##  dichromat      2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
##  digest         0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
##  dplyr        * 1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
##  ellipsis       0.3.2   2021-04-29 [2] CRAN (R 4.5.1)
##  evaluate       1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
##  farver         2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap        1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
##  fs             1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
##  generics       0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
##  ggplot2      * 4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
##  glue           1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
##  gtable         0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
##  htmltools      0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
##  jquerylib      0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite       2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
##  knitr        * 1.50    2025-03-16 [2] CRAN (R 4.5.1)
##  labeling       0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
##  lifecycle      1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
##  magick         2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
##  magrittr     * 2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
##  MASS           7.3-65  2025-02-28 [3] CRAN (R 4.5.1)
##  memoise        2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
##  NPARC        * 1.22.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  pillar         1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
##  pkgbuild       1.4.8   2025-05-26 [2] CRAN (R 4.5.1)
##  pkgconfig      2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
##  pkgload        1.4.1   2025-09-23 [2] CRAN (R 4.5.1)
##  purrr          1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
##  R6             2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer   1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp           1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
##  remotes        2.5.0   2024-03-17 [2] CRAN (R 4.5.1)
##  rlang          1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown      2.30    2025-09-28 [2] CRAN (R 4.5.1)
##  S7             0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
##  sass           0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
##  scales         1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
##  sessioninfo    1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
##  tibble         3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
##  tidyr          1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
##  tidyselect     1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
##  tinytex        0.57    2025-04-15 [2] CRAN (R 4.5.1)
##  usethis        3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
##  vctrs          0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
##  withr          3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
##  xfun           0.53    2025-08-19 [2] CRAN (R 4.5.1)
##  yaml           2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpyofpbM/Rinst1f111861ba1d15
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────
```

# Bibliography

Childs, Dorothee, Karsten Bach, Holger Franken, Simon Anders, Nils Kurzawa, Marcus Bantscheff, Mikhail Savitski, and Wolfgang Huber. 2019. “Non-Parametric Analysis of Thermal Proteome Profiles Reveals Novel Drug-Binding Proteins.” *Molecular & Cellular Proteomics*, October. <https://doi.org/10.1074/mcp.TIR119.001481>.

Marazzi, A. 2002. “Bootstrap Tests for Robust Means of Asymmetric Distributions with Unequal Shapes.” *Computational Statistics & Data Analysis* 39 (4): 503–28.

Savitski, Mikhail M, Friedrich B M Reinhard, Holger Franken, Thilo Werner, Maria Fälth Savitski, Dirk Eberhard, Daniel Martinez Molina, et al. 2014. “Tracking Cancer Drugs in Living Cells by Thermal Profiling of the Proteome.” *Science* 346 (6205): 1255784.