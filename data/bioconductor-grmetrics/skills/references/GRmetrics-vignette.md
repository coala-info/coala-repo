# Contents

* [1 Background](#background)
* [2 Installation](#installation)
* [3 Examples](#examples)

# 1 Background

Quantifying drug response is the cornerstone of many pharmacological
experiments ranging from pharmacogenomics studies to small-scale analyses of
drug resistance. In general, cells are grown in the presence or absence of
drugs for a few days and the endpoint cell count values (or a surrogate) is
compared. From the relative cell count, metrics of drug sensitivity such as
IC50 or Emax values are evaluated. In cases where the untreated control
cells grow over the course of the assay, these traditional metrics are
confounded by
the number of divisions that take place over the course of an assay. In
particular, for drugs that impact growth rate and block cell division,
slow-growing cell lines will appear more resistant than fast-growing lines
although the biological effect on a per-division basis may be the same.

Hafner
et al. recently proposed alterative drug-response metrics based on growth rate
inhibition (GR metrics) that are robust to differences in nominal division rate
and assay duration. Using these metrics requires only to know the number of
cells (or a surrogate) at the time of treatment; note that this value may also
be inferred from the nominal division rate and the value of an untreated
sample at the endpoint.

To facilitate the use of these GR metrics, we have developed
an R package that provides functions to analyze and visualize drug response
data with these new metrics across multiple conditions and cell lines.

# 2 Installation

The **GRmetrics** package can be installed through Bioconductor

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("GRmetrics")
```

#References:
Hafner, M., Niepel, M. Chung, M. and Sorger, P.K., *Growth Rate Inhibition
Metrics Correct For Confounders In Measuring Sensitivity To Cancer Drugs*.
Nature Methods 13.6 (2016): 521-527.
(<http://dx.doi.org/10.1038/nmeth.3853>)

Corresponding MATLAB and Python scripts available on repo:

<https://github.com/sorgerlab/gr50_tools>.

Note: Most, but not all of these scripts have been reproduced in this R
package. Namely, this package does not contain code for “Case B” of the
MATLAB scripts nor does it contain an R script to generate the example input
data. The python script for generating the example data can be found in the
“inst/scripts/” directory.

Browser interface and online tools: <http://www.grcalculator.org>

Much of the description below has been adapted from:

<https://github.com/datarail/gr_metrics/blob/master/README.md>.

#Input data
The main function of the package is **GRfit**, which takes in a data frame
containing information about concentration, cell counts over time, and
additional grouping variables for a dose-response assay and calculates
growth-rate inhibition (GR) metrics for each experiment in the dataset.

There are two cases of data input accepted by the **GRfit** function.
They are described in detail below. Case “A” is the default option.

##Case A: a single file with control values assigned to treated measurements
The control values (both control and time 0 cell counts) are pre-computed by
the user and assigned to each treatment (row) in appropriate columns in the
input file. Control cell counts should be in a column labeled
*cell\_count\_\_ctrl* and the time 0 cell counts in a column labeled
*cell\_count\_\_time0*.

An example input data frame for “Case A”, named “inputCaseA”, is contained
within the package.
To access it, use the following code:

```
library(GRmetrics)
data(inputCaseA)
```

**The mandatory inputs for Case “A” are:**

* **inputData** - the name of an input data frame with the following columns
  as well as other grouping columns
  1. **concentration** - column with concentration values
     (not log transformed) of the perturbagen on which dose-response curves will be
     evaluated
  2. **cell\_count** - column with the measure of cell number
     (or a surrogate of cell number) after treatment
  3. **cell\_count\_\_time0** - column with initial (Time 0) cell
     counts - the measure of cell number in untreated wells grown in parallel
     until the time of treatment
  4. **cell\_count\_\_ctrl** - column with the Control cell
     count: the measure of cell number in control (e.g. untreated or
     DMSO-treated) wells from the same plate

All other columns will be treated as additional keys on which the data will be
grouped (e.g. *cell\_line*, *drug*, *time*, *replicate*)

##Case C: a single file with control values stacked with treated measurements
In the most general case, the control cell counts are in the same file and
format as the treated cell counts. Control cell counts will be averaged (using
a 50%-trimmed mean) and automatically matched to the treated cell counts based
on the keys (columns in the data file). The control cell count values must
have a value of 0 for *concentration* and a value for *time* that matches the
treated measurements. The time 0 cell count values must have value of 0 for
*time*. If the structure of the data is complex, the provided scripts may
inappropriately match control and treated cell counts, so users instead should
format their data as described in case A.

An example input data frame for “Case C”, named “inputCaseC”, is contained
within the package.
To access it, use the following code:

```
library(GRmetrics)
data(inputCaseC)
```

**The mandatory inputs for Case “C” are:**

* **inputData** - the name of an input data frame with the following columns
  as well as other grouping columns
  1. **concentration** - column with concentration values
     (not log transformed) of the perturbagen on which dose-response curves
     will be evaluated
  2. **cell\_count** - column with the measure of cell number
     (or a surrogate of cell number)
  3. **time** - column with the time at which a cell count is
     observed

All other columns will be treated as additional keys on which the data will be
grouped (e.g. *cell\_line*, *drug*, *replicate*)

##Functions
The package contains 3 visualization functions: **GRdrawDRC**, **GRscatter**,
and **GRbox**.

All of these functions take in an object created by **GRfit** as well as
additional arguments. The results can be viewed in a static ggplot image or an
interactive plotly (turned on/off by the *plotly* parameter).

* **GRdrawDRC** this function draws the (growth-rate inhibition)
  dose-response curve using the parameters calculated by the **GRfit** function.
  If *points* is set to TRUE, then it will also plot the points used to fit each
  curve.
* **GRscatter** this function draws a scatterplot of a given GR metric
  (GR50, GRmax, etc.) with the *xaxis* value(s) plotted against the *yaxis*
  value(s).
* **GRbox** this function draws boxplots of a given GR metric
  (GR50, GRmax, etc.) for values of a given grouping variable. It overlays the
  points used to make these boxplots and can color them according to another
  grouping variable.

The package also contains 4 accessor functions, which extract data from the
SummarizedExperiment object created by **GRfit**. These functions are:
**GRgetMetrics**, **GRgetDefs**, **GRgetValues**, and **GRgetGroupVars**.

* **GRgetMetrics** this function returns a table of GR metrics and
  traditional metrics along with goodness of fit measures. It also identifies
  each fit as flat or sigmoidal.
* **GRgetDefs** this function returns a table containing the definition of
  each GR metric, traditional metric, and goodness of fit measure calculated.
* **GRgetValues** this function returns a table of the original data (in the
  form of “Case A”) with columns for GR values and relative cell counts.
* **GRgetGroupVars** this function returns a vector of the grouping
  variables used to create the object. These are the variables in the dataset
  that are not averaged over.

# 3 Examples

Load example data (Case A)

```
data(inputCaseA)
```

```
head(inputCaseA)
```

```
##   cell_line agent perturbation replicate time concentration cell_count
## 1    MCF10A drugA            0         1   48      0.001000       1131
## 2    MCF10A drugA            0         1   48      0.003162       1205
## 3    MCF10A drugA            0         1   48      0.010000       1021
## 4    MCF10A drugA            0         1   48      0.031620        743
## 5    MCF10A drugA            0         1   48      0.100000        459
## 6    MCF10A drugA            0         1   48      0.316200        318
##   cell_count__ctrl cell_count__time0
## 1           1212.5             299.5
## 2           1212.5             299.5
## 3           1212.5             299.5
## 4           1212.5             299.5
## 5           1212.5             299.5
## 6           1212.5             299.5
```

Calculate GR values and solve for GR metrics parameters (i.e. fit curves)

```
drc_output = GRfit(inputCaseA, groupingVariables = c('cell_line','agent'))
```

See overview of output data (SummarizedExperiment object)

```
drc_output
```

```
## class: SummarizedExperiment
## dim: 19 12
## metadata(2): '' ''
## assays(1): ''
## rownames(19): ctrl_cell_doublings GR50 ... pval_rel_cell
##   flat_fit_rel_cell
## rowData names(2): Metric Description
## colnames(12): BT20 drugA BT20 drugB ... MCF7 drugC MCF7 drugD
## colData names(6): cell_line agent ... experiment concentration_points
```

Review output table of GR metrics parameters

```
head(GRgetMetrics(drc_output))
```

```
##              cell_line agent  fit_GR fit_rel_cell   experiment
## BT20 drugA        BT20 drugA sigmoid      sigmoid   BT20 drugA
## BT20 drugB        BT20 drugB    flat         flat   BT20 drugB
## BT20 drugC        BT20 drugC sigmoid      sigmoid   BT20 drugC
## BT20 drugD        BT20 drugD sigmoid      sigmoid   BT20 drugD
## MCF10A drugA    MCF10A drugA sigmoid      sigmoid MCF10A drugA
## MCF10A drugB    MCF10A drugB sigmoid      sigmoid MCF10A drugB
##              concentration_points ctrl_cell_doublings       GR50       GRmax
## BT20 drugA                      9            1.256578 0.09080477  0.03305683
## BT20 drugB                      9            1.256578        Inf  0.99059876
## BT20 drugC                      9            1.256578 0.24800535 -0.71018761
## BT20 drugD                      9            1.256578 0.02215168 -0.05039563
## MCF10A drugA                    9            2.121869 0.03964474 -0.06533159
## MCF10A drugB                    9            2.121869 1.73502021  0.05502585
##                  GR_AOC      GEC50       GRinf      h_GR        r2_GR
## BT20 drugA   0.50926262 0.08715113  0.02267627 1.1301507  0.968621411
## BT20 drugB   0.02209509 0.00000000  0.99059876 0.0100000 -0.004378014
## BT20 drugC   0.56226401 0.58512184 -0.78533762 1.0999555  0.977472706
## BT20 drugD   0.67647820 0.02363744 -0.04032884 1.1948823  0.976877384
## MCF10A drugA 0.62559226 0.04496553 -0.06702646 0.9988893  0.986610798
## MCF10A drugB 0.22076112 2.41460135 -0.18764462 0.9641436  0.971364003
##                   pval_GR flat_fit_GR       IC50      Emax       AUC       EC50
## BT20 drugA   2.096868e-80          NA 0.55085523 0.4482145 0.7052483 0.08039928
## BT20 drugB   1.000000e+00   0.9757885        Inf 0.9864435 0.9847035 0.00000000
## BT20 drugC   4.938309e-88          NA 0.56550564 0.1029963 0.6905482 0.49386992
## BT20 drugD   1.967703e-87          NA 0.09308940 0.4062678 0.6118821 0.02197710
## MCF10A drugA 2.731585e-66          NA 0.05331866 0.2166405 0.5080238 0.03076491
## MCF10A drugB 9.815911e-55          NA 2.27507203 0.2721915 0.8128093 1.56574961
##                    Einf        h r2_rel_cell pval_rel_cell flat_fit_rel_cell
## BT20 drugA   0.44184478 1.117968  0.88748193  5.185369e-51                NA
## BT20 drugB   0.98644353 0.010000 -0.01158457  1.000000e+00         0.9834633
## BT20 drugC   0.07154552 1.140094  0.98373427  1.575768e-95                NA
## BT20 drugD   0.41098367 1.195509  0.88438881  2.182698e-50                NA
## MCF10A drugA 0.21427553 1.017582  0.94713334  2.048170e-45                NA
## MCF10A drugB 0.15621884 1.002558  0.96108795  4.497222e-50                NA
```

View descriptions of each GR metric (or goodness of fit measure)

```
View(GRgetDefs(drc_output))
```

Review output table of GR values

```
head(GRgetValues(drc_output))
```

```
##   cell_line agent perturbation replicate time concentration cell_count
## 1    MCF10A drugA            0         1   48      0.001000       1131
## 2    MCF10A drugA            0         1   48      0.003162       1205
## 3    MCF10A drugA            0         1   48      0.010000       1021
## 4    MCF10A drugA            0         1   48      0.031620        743
## 5    MCF10A drugA            0         1   48      0.100000        459
## 6    MCF10A drugA            0         1   48      0.316200        318
##   cell_count__ctrl cell_count__time0 log10_concentration    GRvalue
## 1           1212.5             299.5          -3.0000000 0.93219264
## 2           1212.5             299.5          -2.5000381 0.99385806
## 3           1212.5             299.5          -2.0000000 0.83663626
## 4           1212.5             299.5          -1.5000381 0.56891172
## 5           1212.5             299.5          -1.0000000 0.23569217
## 6           1212.5             299.5          -0.5000381 0.03015641
##   rel_cell_count ctrl_cell_doublings   experiment
## 1      0.9327835            2.017357 MCF10A drugA
## 2      0.9938144            2.017357 MCF10A drugA
## 3      0.8420619            2.017357 MCF10A drugA
## 4      0.6127835            2.017357 MCF10A drugA
## 5      0.3785567            2.017357 MCF10A drugA
## 6      0.2622680            2.017357 MCF10A drugA
```

View grouping variables used for calculation

```
GRgetGroupVars(drc_output)
```

```
## [1] "cell_line" "agent"
```

You can also export your results. Here are two examples:

```
# Write GR metrics parameter table to tab-separated text file
write.table(GRgetMetrics(drc_output), file = "filename.tsv", quote = FALSE,
sep = "\t", row.names = FALSE)
# Write original data plus GR values to comma-separated file
write.table(GRgetValues(drc_output), file = "filename.csv", quote = FALSE,
sep = ",", row.names = FALSE)
```

#Visualizations
You can draw GR dose-response curves with plotly or with ggplot2. You can also
specify the range of the graph.

```
# Draw dose-response curves
GRdrawDRC(drc_output)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the GRmetrics package.
##   Please report the issue at <https://github.com/uc-bd2k/GRmetrics/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
GRdrawDRC(drc_output, experiments = c('BT20 drugA', 'MCF10A drugA',
                                      'MCF7 drugA'))
```

```
GRdrawDRC(drc_output, experiments = c('BT20 drugA', 'MCF10A drugA',
                                      'MCF7 drugA'),
          min = 10^(-4), max = 10^2)
```

```
GRdrawDRC(drc_output, plotly = FALSE)
```

![](data:image/png;base64...)

You can also draw scatterplots and boxplots of GR metrics with plotly or
ggplot2.
Here is an example using example data in the format of Case C.

```
## Case C (scatterplot and boxplot examples)
data(inputCaseC)
```

```
head(inputCaseC)
```

```
##   cell_line agent perturbation replicate time concentration cell_count
## 1    MCF10A     -            0       NaN    0             0        294
## 2    MCF10A     -            0       NaN    0             0        318
## 3    MCF10A     -            0       NaN    0             0        287
## 4    MCF10A     -            0       NaN    0             0        296
## 5    MCF10A     -            0       NaN    0             0        291
## 6    MCF10A     -            0       NaN    0             0        286
```

```
output1 = GRfit(inputData = inputCaseC, groupingVariables =
c('cell_line','agent', 'perturbation', 'replicate', 'time'), case = "C")
```

```
# Draw scatterplots
GRscatter(output1, 'GR50', 'agent', c('drugA','drugD'), 'drugB')
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the GRmetrics package.
##   Please report the issue at <https://github.com/uc-bd2k/GRmetrics/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Coordinate system already present.
## ℹ Adding new coordinate system, which will replace the existing one.
```

```
GRscatter(output1, 'GR50', 'agent', c('drugA','drugD'), 'drugB',
          plotly = FALSE)
```

```
## Coordinate system already present.
## ℹ Adding new coordinate system, which will replace the existing one.
```

![](data:image/png;base64...)

```
# Draw boxplots
GRbox(output1, metric ='GRinf', groupVariable = 'cell_line',
      pointColor = 'agent')
```

```
GRbox(output1, metric ='GRinf', groupVariable = 'cell_line',
      pointColor = 'agent',
      factors = c('BT20', 'MCF10A'))
```

```
GRbox(output1, metric ='GRinf', groupVariable = 'cell_line',
      pointColor = 'agent',
      factors = c('BT20', 'MCF10A'), plotly = FALSE)
```

![](data:image/png;base64...)

```
GRbox(output1, metric ='GR50', groupVariable = 'cell_line',
      pointColor = 'agent', wilA = 'BT20', wilB = c('MCF7', 'MCF10A'),
      plotly = FALSE)
```

![](data:image/png;base64...)

#GR metric details
We have developed scripts to calculate normalized growth rate inhibition (GR)
values and corresponding metrics (GR50, GRmax, …) based on cell counts
measured in dose-response experiments. Users provide a tab-separated data file
in which each row represents a separate treatment condition and the columns
specify the keys that define the treatment condition (e.g. cell line, drug or
other perturbagen, perturbagen concentration, treatment time, replicate) and
the measured cell counts (or surrogate). The experimentally measured cell
counts that are required for GR metric calculation are as follows:
- measured cell counts after perturbagen treatment (*cell\_count*, *x(c)*)
- measured cell counts of control (e.g. untreated or DMSO-treated) wells on
the same plate (*cell\_count\_\_ctrl*, *x\_ctrl*)
- measured cell counts from an untreated sample grown in parallel until the
time of treatment (*cell\_count\_\_time0*, *x\_0*)

The provided GR scripts compute over the user’s data to calculate GR values
individually for each treatment condition (cell line, time, drug,
concentration, …) using the formula:

```
GR(c) = 2 ^ ( log2(x(c)/x_0) / log2(x_ctrl/x_0) ) - 1
```

Based on a set of GR values across a range of concentrations, the data are
fitted with a sigmoidal curve:

```
GR(c) = GRinf + (1-GRinf)/(1 + (c/(GEC50))^Hill )
```

The following GR metrics are calculated:

* **GR50**, the concentration at which the effect reaches a GR value of 0.5
  based on interpolation of the fitted curve.
* **GRmax**, the effect at the highest tested concentration. Note that
  *GRmax* can differ from *GRinf* if the dose-response does not reach its
  plateau value. For robustness, we take this as the minimum mean GR value at
  the two highest concentrations.
* **GR\_AOC**, the area over the dose-response curve, which is the integral of
  *1-GR(c)* over the range of concentrations tested, normalized by the range of
  concentration.
* **GEC50**, the drug concentration at half-maximal effect, which reflects the
  potency of the drug.
* **GRinf**, GR(c->inf), which reflects asymptotic drug efficacy.
* **h\_GR**, The Hill coefficient of the fitted (GR) curve, which reflects how steep the dose response curve is
* **r2\_GR**, The coefficient of determination - essentially how well the (GR) curve fits to the data points
* **pval\_GR**, The p-value of the F-test comparing the fit of the (GR) curve to a horizontal line fit
* **flat\_fit\_GR**, For data that doesn’t significantly fit better to a curve than a horizontal line fit (p > 0.05), the y value (GR) of the flat line

The following traditional metrics are calculated:

* **IC50**, The concentration at which relative cell count = 0.5
* **Emax**, The maximal effect of the drug (minimal relative cell count value).
  For robustness, we take this as the minimum mean relative cell count at the
  two highest concentrations.
* **AUC**, The ‘Area Under the Curve’ - The area below the fitted (traditional) dose response curve
* **EC50**, The concentration at half-maximal effect (not growth rate normalized)
* **Einf**, The asymptotic effect of the drug (not growth rate normalized)
* **h**, The Hill coefficient of the fitted (traditional) dose response curve, which - reflects how steep the dose response curve is
* **r2\_rel\_cell**, The coefficient of determination - essentially how well the (traditional) curve fits to the data points
* **pval\_rel\_cell**, The p-value of the F-test comparing the fit of the (traditional) curve to a horizontal line fit
* **flat\_fit\_rel\_cell**, For data that doesn’t significantly fit better to a curve than a horizontal line fit (p > 0.05), the y value (relative cell count) of the flat line

In addition to the metrics, the scripts report the r-squared of the fit and
evaluate the significance of the sigmoidal fit based on an F-test. If the fit
is not significant (p > 0.05), the sigmoidal fit is replaced
by a constant value (flat fit). This can be circumvented by using the “force”
option in the *GRfit* function. Additional information and considerations
are described in the supplemental material of the manuscript referred above.