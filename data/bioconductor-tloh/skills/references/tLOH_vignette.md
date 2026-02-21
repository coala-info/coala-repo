# tLOH

#### Michelle Webb

#### 5/5/2021

v1.5.6

tLOH: Assessment of evidence for loss of heterozygosity in spatial transcriptomics pre-processed data using Bayes factor calculations.

This tool requires data produced with the 10X Genomics Visium Spatial Gene Expression platform and processed to obtain a VCF with per-cluster allele count information at heterozygous SNP positions. The purpose of this R package is to perform Bayes calculations on the data from the VCF and plot the results. Examples of how to run this tool are below:

1. tLOHDataImport() is a function to import data for use by tLOHCalc(). The input is a VCF file, an example can be found in the inst/extdata folder.

```
exampleData <- tLOHDataImport('../inst/extdata/Example.vcf')
# The VCF file in inst/extdata must be decompressed before running this command
```

2. tLOHCalc() is the main calculation function. It requires the output directory from tLOHDataImport().

```
load("../data/humanGBMsampleAC.rda")
df <- tLOHCalc(humanGBMsampleAC)
head(df)
```

```
##         rsID CLUSTER TOTAL REF ALT   CHR       POS p(D|het) p(D|loh) p(het|D)
## 1    rs10001       8     1   0   1 chr19   7646335      0.5      0.5      0.5
## 2    rs10001       9     1   1   0 chr19   7646335      0.5      0.5      0.5
## 3    rs10001       2     1   1   0 chr19   7646335      0.5      0.5      0.5
## 4 rs10007201       8     1   1   0  chr4 100187175      0.5      0.5      0.5
## 5 rs10007201       3     1   1   0  chr4 100187175      0.5      0.5      0.5
## 6 rs10013040       1     1   1   0  chr4 177309998      0.5      0.5      0.5
##   p(loh|D) bayesFactors inverseBayes LogBayesFactors LogInverseBayes
## 1      0.5            1            1   -1.110223e-16    2.220446e-16
## 2      0.5            1            1   -3.330669e-16    4.440892e-16
## 3      0.5            1            1   -3.330669e-16    4.440892e-16
## 4      0.5            1            1   -3.330669e-16    4.440892e-16
## 5      0.5            1            1   -3.330669e-16    4.440892e-16
## 6      0.5            1            1   -3.330669e-16    4.440892e-16
##   Log10BayesFactors Log10InverseBayes AF CLUSTER_AF CHR_F
## 1     -4.821637e-17      9.643275e-17  1          9    19
## 2     -1.446491e-16      1.928655e-16  0          9    19
## 3     -1.446491e-16      1.928655e-16  0          2    19
## 4     -1.446491e-16      1.928655e-16  0          8     4
## 5     -1.446491e-16      1.928655e-16  0          3     4
## 6     -1.446491e-16      1.928655e-16  0          1     4
```

The column descriptions for the output dataframe are as follows - CHR: chromosome POS: position REF: reference allele counts ALT: alternative allele counts TOTAL: total counts p(D|het): probability of data given heterozygous event p(D|loh): probability of data given loh event p(het|D): probability of data given heterozygous event divided by the addition of p(D|het) and p(D|loh) p(loh|D): probability of data given loh event divided by the addition of p(D|het) and p(D|loh) bayesFactors: Bayes factor value K inverseBayes: 1/K LogBayesFactors: log of Bayes factor K LogInverseBayes: log of 1/K Log10BayesFactors: log 10 of Bayes factor K Log10InverseBayes: log 10 of 1/K AF: allele fraction Cluster: cluster number Cluster\_AF: cluster + AF for plotting y axis CHR\_F: chromosome factor

3. tLOH has two plotting functions, alleleFrequencyPlot() and aggregateCHRPlot(). Both require the output dataframe from running tLOHCalc, and a sample name for the plot title. Example images of these plots are available in inst/extdata.

```
alleleFrequencyPlot(df, "Example")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the tLOH package.
##   Please report the issue at <https://github.com/USCDTG/tLOH/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
aggregateCHRPlot(df, "Example")
```

![](data:image/png;base64...)