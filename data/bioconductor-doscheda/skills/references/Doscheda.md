# Doscheda: A DownStream Chemo-Proteomics Analysis Pipeline

Bruno Contrino and Piero Ricchiuto

#### 29 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 ChemoProtSet class](#chemoprotset-class)
* [3 Setting Parameters](#setting-parameters)
* [4 Importing Data](#importing-data)
  + [4.1 Data requirements](#data-requirements)
* [5 Intensities or Fold-Changes](#intensities-or-fold-changes)
  + [5.1 Peptide Removal Process](#peptide-removal-process)
* [6 Normalizing the Data](#normalizing-the-data)
* [7 Fitting a Model](#fitting-a-model)
* [8 Plotting Results](#plotting-results)
* [9 Example](#example)
* [10 Shiny Application](#shiny-application)
* [11 References](#references)
* **Appendix**

# 1 Introduction

Quantitative chemical proteomics (Bantscheff M, 2012) and MS-Cellular Thermal Shift Assay (MS-CETSA) (Martinez MD, 2016) have been recently deployed in drug discovery to aid understanding of selectivity of therapeutic agents, for target deconvolution in the contest of phenotypic screens, to elucidate drugs’ mechanisms of action and evaluation of drug re-purposing. (Schirle M, 2012)
A generous number of computational tools has been developed for MS-spectral analysis and protein quantification, such as Proteome Discoverer (<https://www.thermofisher.com/>), MaxQuant (Cox J, 2008) or PEAKS (<http://www1.bioinfor.com>) for de-novo peptide sequencing. However, the increasing variety of MS based approaches for drug target deconvolution can produce data that need dedicated downstream analysis platforms for facilitating the biological interpretation of results.
The Doscheda package focuses on quantitative chemoproteomics used to determine protein interaction profiles of small molecules from whole cell or tissue lysates. Chemoproteomics includes inverse competition-based experiments that, in combination with quantitative MS (e.g. tandem mass tags (TMT) or isobaric tag for relative quantification (iTRAQ)), are used for rank-ordering of small molecule-protein interactions by binding affinity. (Bantscheff M, 2012)
Doscheda is designed to facilitate chemoproteomics data analysis with a simple pipeline and a Shiny application that will allow scientists with limited computational background to carry out their own analysis.

This package has been developed as a supplement to the original Doscheda shiny app. For detailed documentation on the app please visit:
<https://brunocontrino.github.io/DOSCHEDA_APP/>

# 2 ChemoProtSet class

The main pipeline relies on storing all the data, parameters and other variables required in a ‘`ChemoProtSet`’ S4 class object. The object contains several slots which will help partition all the required elements in an ordered fashion. The slots can contain several different data types and are as follows

* **input**: The input data that will be used for the pipeline, this must be a data frame with the requirements discussed in the next section of the vignette.
* **normData**: An intermediate stage of the pipeline which can be used to produce some preliminary plots, no model information is stored in this slot
* **finalData**: The final stage of the pipeline will produce a data frame with all the model coefficients and p-values including the data values used in the pipeline. This is the most important slot as it will be used for several plots and also contains the results.
* **parameters**: All the parameters required to run and customize the pipeline are stored in this slot. The user can view this slot to see the options selected. These can be edited using the `setParamters` method.

  + ***chansVal*** number of channels / concentrations in experiment
  + ***repsVal*** number of replicates in experiment
  + ***dataTypeStr*** string describing the data type of input data set. This can be ‘LFC’ for log fold-changes, ‘FC’ for fold-changes and ‘intensity’ for peptide intensities
    modelTypeStr string describing the type of model applied. This can be ‘linear’ for a linear model or ‘sigmoid’ for a sigmoidal model
  + ***PDBool*** boolean value indicating if the input data is from Proteome Discoverer 2.1 or not
  + ***removePepsBool*** boolean value indicating if peptide removal will take place. Only valid if input data is peptide intensities
  + ***incPDofPDBool*** Boolean value indicating if the input data contains a pull-down of pull-down column
  + ***PDofPDname*** string with the same name as column containing pull-down of pull-down data. NA if this is not applicable
  + ***incGeneFileBool*** Boolean value indicating if the data requires a protein accession to gene ID conversion file
  + ***organismStr*** string giving the name of organism. the options are: ‘H.sapiens’, ‘D. melanogaster’, ‘C. elegans’, ‘R. norvegicus’, ‘M. musculus’. This is only needed if PDbool is FALSE
  + ***sigmoidConc*** vector of numerical values for concentrations of channels in the case of a sigmoidal fit
  + ***pearsonThrshVal*** numerical value between -1 and 1 which determines the cut-off used to discard peptides during peptide removal
* **datasets**

# 3 Setting Parameters

After attaching the data to the `ChemoProtSet` object one must ensure all their parameters are correct for their experiment. To do so one can use `setParamters` to assign the correct values for each parameter correctly. For a full list of parameters please refer to the **ChemoProtSet class** section.

```
library(Doscheda)

 channelNames <- c("Abundance..F1..126..Control..REP_1",
"Abundance..F1..127..Sample..REP_1",  "Abundance..F1..128..Sample..REP_1",
  "Abundance..F1..129..Sample..REP_1",  "Abundance..F1..130..Sample..REP_1",
"Abundance..F1..131..Sample..REP_1",  "Abundance..F2..126..Control..REP_2",
 "Abundance..F2..127..Sample..REP_2", "Abundance..F2..128..Sample..REP_2",
"Abundance..F2..129..Sample..REP_2",  "Abundance..F2..130..Sample..REP_2",
"Abundance..F2..131..Sample..REP_2")
ex <- new('ChemoProtSet')
ex<- setParameters(x = ex,chansVal = 6, repsVal = 2,
dataTypeStr = 'intensity', modelTypeStr = 'linear',
  PDBool = FALSE,removePepsBool = FALSE,incPDofPDBool = FALSE,
   incGeneFileBool = FALSE,organismStr = 'H.sapiens',
    pearsonThrshVal = 0.4)
```

# 4 Importing Data

To run the pipeline one must attach a data set to the input slot of a `ChemoProtSet` object. To do so the data set can be read into the global R environment. The user should ensure that the data is of class ‘data.frame’ then the setData method called on the data set.

```
ex<- setData(x = ex, dataFrame = Doscheda::doschedaData,
  dataChannels = channelNames,
  accessionChannel = "Master.Protein.Accessions",
   sequenceChannel = 'Sequence',
   qualityChannel = "Qvality.PEP" )
```

## 4.1 Data requirements

The data must have specific columns in order to run the pipeline successfully, Table 1 shows the required columns based on the type of analysis.

|  | Input |
| --- | --- |
| **Peptide Intensities** | Peptide Qvality Score, Protein Accessions, Peptide Sequences, Intensities (several columns) |
| **Fold Changes / Log Fold Changes** | Protein Accessions, protein Fold Changes (several columns), Gene id (optional), Unique Peptides |

# 5 Intensities or Fold-Changes

The package can handle two types of chemo-proteomics data, peptide intensities or fold changes of protein intensities. These two data types can be exported by most mass-spec technologies, the package has been optimized to use outputs from Proteome Discoverer 2.1. For Doscheda the difference between using the two data types is, if there are two replicates, one can carry out a peptide removal process if using the peptide intensities. This is not available if one uses fold changes. When using peptide intensities, the pipeline will convert the data to fold changes once each protein is summarized by a sum of its peptides as seen in the standard Proteome Discoverer 2.1 output.

## 5.1 Peptide Removal Process

The peptide removal process gives the option to remove some noise from the data by removing peptides that do not have similar relationships between replicates by using a Pearson correlation of the same peptide between the two replicates. The main assumption made is that, between replicates and for the same concentration, the peptide intensities have a linear relationship. We calculate the Pearson correlation between the peptides in the two replicates and based on the user pre-specified correlation coefficient (or R2 threshold) any peptide that doesn’t meet the correlation cut off is discarded.

If there is a disparity between the replicates of the number of the same peptide associated with a protein, then the mean of each concentration, of the replicate that has less counts of the peptide, will be used to even out the peptide counts such that they are the same between both replicates. This will then be used to calculate the Pearson correlation of the peptide between the two replicates.

```
ex <- removePeptides(ex,removePeps = FALSE)
```

# 6 Normalizing the Data

The user can choose to normalise the data: the main methods used to normalise are a median normalisation and a loess normalisation. To choose the type of normalisation the user can pass the following strings in the `normalise` argument of the `runNormalisation` method: `'loess'`, `'median'` or `'none'`.

The `'loess'` normalisation is calculated with the `loess.normalize` function of the affy package
in R. Loess has been shown compared to other methods that performs systematically well in the differential expression analysis (Välikangas et al, 2016).

The median fold change normalisation is a simple function we developed in Doscheda that
computes the median of each column of the input data and this is used to divide each
protein fold change of the corresponding column from which the median was derived.
The median fold change normalisation scales each condition to its median and it would simply move the data so that the median difference is 0 and it will not correct for any non-linear bias.

# 7 Fitting a Model

In the Doscheda package, the user can fit two different types of model: A linear fit or a sigmoidal fit. If possible it is recommended that one fit a sigmoidal curve to the data given that there are enough concentrations for the appropriate protein dose-response. The method for fitting a model to the data is `fitModel` on the `ChemoProtSet` object that has been set up using the previous steps above. The final results of the pipeline will be accessible in the `finalData` slot of the returned object.

##Linear model

The linear model can be fitted on experiments with three or more concentrations and will fit the following regression to the data \(y = ax^{2} + bx + c\) where we calculate \(a,b,c\). The reason for fitting this model to each protein is that we can gain some insight in how the protein is binding across concentrations by looking at its coefficients and whether they are significant or not. For example, if a protein has a peak in binding in a middle concentration, we will expect that there is a significant quadratic coefficient. This model can be extended to as many concentrations as one requires.

##Sigmoidal model

The sigmoidal can currently be fitted on experiments with one replicate and more than 5 concentrations, this is because we require a certain amount of data to fit the sigmoidal curve to the data. The reason for fitting a sigmoidal curve is that each protein should follow a dose response curve, which should have a sigmoidal shape. There are four parameters that are estimated for each protein. These are, the top of the sigmoidal curve, the bottom, the RB50 and the slope of the sigmoidal curve.
One can analyse the significance of each parameter by looking at its associated coefficient p-values. The half maximal residual binding (RB50) is a measure of the effectiveness of a drug in binding to a protein. Thus, this quantitative measure indicates how much of a drug or small molecule is needed to saturate binding to a protein by half, and can be used to compare drug-protein profiles. The RB50 values are typically expressed as molar concentration and are computed in the sigmoidal pipeline for each protein within DOSCHEDA. Furthermore, the corrected RB50, according to Daub et. al. (Daub H, 2015) corresponds to the ratio (r) of the proteins enriched in the second incubation (supernatant) versus those retained in the first incubation (DMSO or blank) with the affinity matrix. This pulldown of pulldown or depletion factor (r) enables the calculation of a corrected Kd. In order to do this the user must provide a pull down of pull down column to their data. This can be done by setting `incPDofPD = TRUE` in the `setParameters` method and will result in a corrected RB50 column in the final analysed data. Note that this is only possible when applying a sigmoidal model.

##runDoscheda
This is a wrapper function which will carry out the entire Doscheda pipeline without the user having to do all the steps explained above, however this will not have the same level of flexibility and will re-run the entire pipeline every time it is run.

```
 channelNames <- c("Abundance..F1..126..Control..REP_1",
"Abundance..F1..127..Sample..REP_1",  "Abundance..F1..128..Sample..REP_1",
"Abundance..F1..129..Sample..REP_1",  "Abundance..F1..130..Sample..REP_1",
"Abundance..F1..131..Sample..REP_1",  "Abundance..F2..126..Control..REP_2",
"Abundance..F2..127..Sample..REP_2", "Abundance..F2..128..Sample..REP_2",
"Abundance..F2..129..Sample..REP_2",  "Abundance..F2..130..Sample..REP_2",
 "Abundance..F2..131..Sample..REP_2")

ex <- runDoscheda(dataFrame = doschedaData, dataChannels = channelNames,
 chansVal = 6, repsVal = 2,dataTypeStr = 'intensity',
 modelTypeStr = 'linear',PDBool = FALSE,removePepsBool = FALSE,
 accessionChannel = "Master.Protein.Accessions",
 sequenceChannel = 'Sequence',qualityChannel = "Qvality.PEP",
 incPDofPDBool = FALSE, incGeneFileBool = FALSE,
  organismStr = 'H.sapiens', pearsonThrshVal = 0.4)

runDoscheda()
```

##makeReport

This function is used to generate a custom report for the object in question. The report will contain some of the crucial parameters selected as well as descriptive plots of the data explained above. The output is a HTML report.

# 8 Plotting Results

Once `fitModel` has been run on the `ChemoProtSet` object, the plotting functions within Doscheda can be implemented to visualize the results of the analysis.

##plot

The default plotting function will give the following plots:
- **Linear Model:** The distribution of the coefficient p-values for each of the model coeffcients

* **Sigmoidal Model:** The top 15 proteins ordered by p-value of the parameter coeffcients. Note that the user will need to pass an argument called sigmoidCoef, indicating which parameter they would like to choose: ‘difference’, ‘rb50’ or ‘slope’.

```
plot(ex)
```

```
## Warning: The dot-dot notation (`..count..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(count)` instead.
## ℹ The deprecated feature was likely used in the Doscheda package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Use of `data.merged$P.Value_slope` is discouraged.
## ℹ Use `P.Value_slope` instead.
```

```
## Warning: Use of `data.merged$P.Value_intercept` is discouraged.
## ℹ Use `P.Value_intercept` instead.
```

```
## Warning: Use of `data.merged$P.Value_quadratic` is discouraged.
## ℹ Use `P.Value_quadratic` instead.
```

![](data:image/png;base64...)

##boxPlot

The boxplot shows the interquartile ranges and median of all the channels that are present in the analysis.

```
boxplot(ex)
```

![](data:image/png;base64...)

##corrPlot

This function plots the pearson correlation between all the channels in the data giving an idea of how correlated the channels are between each other.

```
corrPlot(ex)
```

```
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
## Warning in graphics::par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

##densityPlot

This function produces two plots of the data:

* The density plot of ranked proteins.
* The desnsity distribution of each channel.

##pcaPlot

This function shows all the channels of the data shown in their first two principal components. This can be an indicator to the quality of the data, for example having an isolated point can indicate a ‘bad’ channel.

```
pcaPlot(ex)
```

```
## Warning: Use of `DTA$as.numeric.t.su...1.length.index........pca.x...1..` is
## discouraged.
## ℹ Use `as.numeric.t.su...1.length.index........pca.x...1..` instead.
```

```
## Warning: Use of `DTA$as.numeric.t.su...1.length.index........pca.x...2..` is
## discouraged.
## ℹ Use `as.numeric.t.su...1.length.index........pca.x...2..` instead.
```

![](data:image/png;base64...)

##replicatePlot

This function plots two replicates against each other at a single concentration. Note that the concentration value is consistent with the column names of the data.

```
replicatePlot(ex,conc = 0, repIndex1 = 1, repIndex2 = 2)
```

![](data:image/png;base64...)

##volcanoPlot

The distribution of proteins by their mean and standard deviation coloured by their p-values, there is a plot for each coefficient in the linear model.

```
volcanoPlot(ex)
```

![](data:image/png;base64...)

##meanSdPlot

This plot shows the ranked means of each protein with a running median calculated with a window size of 10%. This helps visualising whether the variance is constant or not.

```
meanSdPlot(ex)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the vsn package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

# 9 Example

To supplement this package, a fabricated data set has been produced. This example is supposed to be the ‘longest’ version of the pipeline. That is, it uses peptide intensities and therefore requires summarising these intensities. The `doschedaData` is used in this vignette and one can see all of the parameters needed by reading the example below.

```
 channelNames <- c("Abundance..F1..126..Control..REP_1",
"Abundance..F1..127..Sample..REP_1",  "Abundance..F1..128..Sample..REP_1",
  "Abundance..F1..129..Sample..REP_1",  "Abundance..F1..130..Sample..REP_1",
"Abundance..F1..131..Sample..REP_1",  "Abundance..F2..126..Control..REP_2",
 "Abundance..F2..127..Sample..REP_2", "Abundance..F2..128..Sample..REP_2",
"Abundance..F2..129..Sample..REP_2",  "Abundance..F2..130..Sample..REP_2",
"Abundance..F2..131..Sample..REP_2")
 ex <- new('ChemoProtSet')
 ex<- setParameters(x = ex,chansVal = 6, repsVal = 2,dataTypeStr = 'intensity',
  modelTypeStr = 'linear',PDBool = FALSE,removePepsBool = FALSE,
  incPDofPDBool = FALSE,incGeneFileBool = FALSE,organismStr = 'H.sapiens', pearsonThrshVal = 0.4)
 ex<- setData(x = ex, dataFrame = doschedaData, dataChannels = channelNames,
 accessionChannel = "Master.Protein.Accessions",
               sequenceChannel = 'Sequence', qualityChannel = "Qvality.PEP" )
ex <- removePeptides(ex,removePeps = FALSE)
ex <- runNormalisation(ex)
ex <- fitModel(ex)
ex
```

# 10 Shiny Application

By running `doschedaApp()` the original shiny application that the package is based on. To view detailed documentation on the application please visit: <https://brunocontrino.github.io/DOSCHEDA_APP/>

# 11 References

# Appendix

Bantscheff, M., Lemeer, S., Savitski, M.M. and Kuster, B., 2012. Quantitative mass spectrometry in proteomics: critical review update from 2007 to the present. ***Analytical and bioanalytical chemistry***, pp.1-27.

Martinez Molina, D. and Nordlund, P., 2016. The cellular thermal shift assay: a novel biophysical assay for in situ drug target engagement and mechanistic biomarker studies. ***Annual review of pharmacology and toxicology***, 56, pp.141-161.

Schirle, M. and Jenkins, J.L., 2016. Identifying compound efficacy targets in phenotypic drug discovery. ***Drug discovery today***, 21(1), pp.82-89.

Cox, J. and Mann, M., 2008. MaxQuant enables high peptide identification rates, individualized ppb-range mass accuracies and proteome-wide protein quantification. ***Nature biotechnology***, 26(12), pp.1367-1372.

Bantscheff, M., Lemeer, S., Savitski, M.M. and Kuster, B., 2012. Quantitative mass spectrometry in proteomics: critical review update from 2007 to the present. ***Analytical and bioanalytical chemistry***, pp.1-27.

Tebbe, A., Klammer, M., Sighart, S., Schaab, C. and Daub, H., 2015. Systematic evaluation of label‐free and super‐SILAC quantification for proteome expression analysis. Rapid Communications in Mass Spectrometry, 29(9), pp.795-801.

Välikangas, T., Suomi, T. and Elo, L.L., 2016. A systematic evaluation of normalization methods in quantitative label-free proteomics. Briefings in bioinformatics, p.bbw095.