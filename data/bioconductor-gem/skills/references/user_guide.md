# GEM: fast association study for the interplay of Gene, Environment and Methylation

#### Hong Pan

#### 2025-10-30

## Introduction

The **GEM** package provides a highly efficient R tool suite for performing epigenome wide association studies (EWAS). GEM provides three major functions named `GEM_Emodel`, `GEM_Gmodel` and `GEM_GxEmodel` to study the interplay of Gene, Environment and Methylation (GEM). Within GEM, the existing “Matrix eQTL” package is utilized and extended to study methylation quantitative trait loci (methQTL) and the interaction of genotype and environment (GxE) to determine DNA methylation variation, using matrix based iterative correlation and memory-efficient data analysis. GEM can facilitate reliable genome-wide methQTL and GxE analysis on a standard laptop computer within minutes.

The input data to this package are normal text files presenting methylation profiles, genotype variants and environmental factors including covariates. Each row presents one CpG probe or SNP position or an environment measure, while each column represents one sample.

If you are using Rpackage GEM in a publication, please cite [1]. Rpackage GEM adopted the matrix operation method, which is described in [2]. Some of the sample data were from [3].

## Getting Started

### 1. Install and load the Package

#### Installation

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("GEM")
```

#### Loading

```
require(GEM)
```

```
## Loading required package: GEM
```

#### Launch the GUI

GEM package provides a user friendly GUI for runing GEM package easily and quickly. Launch the GUI with following codes:

```
GEM_GUI()
```

GUI for selection models:

![](data:image/png;base64...)

Run the model analysis:

![](data:image/png;base64...)

### 2. Desctiption of input data

User can find the demo data with codes below:

```
DATADIR = system.file('extdata',package='GEM')
dir(path = DATADIR)
```

```
## [1] "cov.txt"         "env.txt"         "gxe.txt"         "methylation.txt"
## [5] "snp.txt"
```

The format of input files for GEM are explained as below:

2.1 **cov.txt** - Artificial covariate data for GEM sample code.

Artificial data set with 1 covariate, for example, gender (encoded as 1 for male and 2 for female), across 237 samples. Columns of the file must match to those of the methylation and genotype data sets. In practical use, covariate data can contain multiple covariates, with each row representing one covariate and columns must match those in methylation and genotype data sets. Data in this file is the “covt” in `GEM_Emodel` `lm (M ~ E + covt)` and `GEM_Gmodel` `lm(M ~ G + covrt)`.

Format:

```
##        S1 S2 S3 S4 S5 S6 S7 S8 S9 S10
## Gender  2  2  2  1  2  1  1  2  1   1
```

2.2 **env.txt** - Artificial environment factor for GEM sample code.

Artificial data set with 1 environmental factor. Environmental factor can be one of the phenotypes, or maternal conditions or birth outcomes that is studied the association with methylation or genotype variants, for example, gestational age (GA) from 28 to 41 weeks across 237 samples. Columns of the file must match to those of the methylation and genotype data sets. Data in this file is the “E” in `GEM_Emodel` `lm (M ~ E + covt)`.

Format:

```
##     S1 S2 S3 S4 S5 S6 S7 S8 S9 S10
## env 28 29 28 34 25 31 33 30 28  28
```

2.3 **gxe.txt** - Artificial covariate and environment data for GEM sample code.

Artificial data set with 1 covariate and 1 environmental factor across 237 samples. Columns of the file must match to those of the methylation and genotype data sets. In practical use, it can contain n covariates and 1 environmental factor, just need to put the environmental factor as the last covariates at the last row. Data in this file combines both environment (E) and covariates (covt) in `GEM_GxEmodel` `lm (M ~ G x E + covt)`.

Format:

```
##        S1 S2 S3 S4 S5 S6 S7 S8 S9 S10
## Gender  2  2  2  1  2  1  1  2  1   1
## env    28 29 28 34 25 31 33 30 28  28
```

2.4 **methylation.txt** - A subset of methylation data for GEM sample code.

A subset of DNA methylation profiles ranged in [0,1] for 100 CpGs across 237 real clinical samples. Each row represents one CpG’s profile across all 237 samples. Columns of the file must match to those of the covariate and genotype data sets. Data in this file is “M” used in `GEM_Emodel`, `GEM_Gmodel`, and `GEM_GxEmodel`.

Format:

```
##     ID       S1       S2       S3       S4       S5       S6
## 1 CpG1 0.257156 0.276115 0.226727 0.209648 0.424285 0.307873
## 2 CpG2 0.474323 0.262313 0.374242 0.401164 0.652304 0.301403
## 3 CpG3 0.635235 0.769377 0.657936 0.639285 0.669690 0.710200
## 4 CpG4 0.454893 0.439979 0.251926 0.292658 0.365113 0.217411
## 5 CpG5 0.878137 0.843197 0.679204 0.890284 0.686224 0.764305
```

2.5 **snp.txt** - A subset of genotype data for GEM sample code.

A subset with genotype data encoded as 1,2,3 for major allele homozygote (AA), heterozygote (AB) and minor allele homozygote (BB) for 100 SNPs across 237 real clinical samples. Each row represents one SNP profile across 237 samples. Columns of the file must match to those of the covariate and methylation data sets. Data in this file is “G” used in `GEM_Gmodel` and `GEM_GxEmodel`.

Format:

```
##     ID S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14
## 1 SNP1  3  3  2  3  1  3  3  3  2   3   2   2   2   2
## 2 SNP2  1  1  2  1  2  1  2  2  1   1   2   2   1   1
## 3 SNP3  1  1  2  3  3  3  2  3  3   2   3   3   2   3
## 4 SNP4  2  3  3  3  3  3  3  3  3   3   2   3   3   3
## 5 SNP5  2  3  2  1  3  3  3  3  3   2   2   2   3   3
```

### 3. Work flow and result demonstration

3.1 GEM\_Emodel:

```
env_file_name = paste(DATADIR, "env.txt", sep = .Platform$file.sep)
covariate_file_name = paste(DATADIR, "cov.txt", sep = .Platform$file.sep)
methylation_file_name = paste(DATADIR, "methylation.txt", sep = .Platform$file.sep)
Emodel_pv = 1
Emodel_result_file_name = "Result_Emodel.txt"
Emodel_qqplot_file_name = "QQplot_Emodel.jpg"
GEM_Emodel(env_file_name, covariate_file_name, methylation_file_name, Emodel_pv, Emodel_result_file_name, Emodel_qqplot_file_name, savePlot=FALSE)
```

```
## 100.00% done, 100 CpGs
## Analysis done in:  0.032  seconds
```

![](data:image/png;base64...)

Results:

```
##     cpg         beta     stats      pvalue       FDR
## 1 CpG99  0.002820575  2.779243 0.005891264 0.5891264
## 2 CpG32  0.003551990  2.008946 0.045691601 0.9345452
## 3 CpG21  0.001896850  1.886230 0.060502399 0.9345452
## 4 CpG66  0.001602048  1.866568 0.063212780 0.9345452
## 5 CpG75 -0.001969172 -1.696740 0.091075634 0.9345452
## 6 CpG34  0.003809056  1.688606 0.092627076 0.9345452
```

3.2 GEM\_Gmodel:

```
snp_file_name = paste(DATADIR, "snp.txt", sep = .Platform$file.sep)
covariate_file_name = paste(DATADIR, "cov.txt", sep = .Platform$file.sep)
methylation_file_name = paste(DATADIR, "methylation.txt", sep = .Platform$file.sep)
Gmodel_pv = 1e-04
Gmodel_result_file_name = "Result_Gmodel.txt"

GEM_Gmodel(snp_file_name, covariate_file_name, methylation_file_name, Gmodel_pv, Gmodel_result_file_name)
```

```
## 100.00% done, 144 methQTL
## Analysis done in:  0.081  seconds
```

Results:

```
##     cpg    snp        beta     stats        pvalue           FDR
## 1 CpG32 SNP962  0.17808859  42.28204 1.482360e-111 1.482360e-106
## 2 CpG94 SNP700 -0.21534752 -18.43573  1.761554e-47  8.807769e-43
## 3 CpG14 SNP578 -0.15171656 -16.70323  9.169281e-42  3.056427e-37
## 4 CpG81 SNP690  0.10567235  13.47239  5.237893e-31  1.309473e-26
## 5 CpG75 SNP589  0.07781375  13.07099  1.112935e-29  2.225870e-25
## 6 CpG94 SNP703  0.13979006  12.55871  5.390763e-28  8.984606e-24
```

3.3 GEM\_GxEmodel:

```
snp_file_name = paste(DATADIR, "snp.txt", sep = .Platform$file.sep)
covariate_file_name = paste(DATADIR, "gxe.txt", sep = .Platform$file.sep)
methylation_file_name = paste(DATADIR, "methylation.txt", sep = .Platform$file.sep)
GxEmodel_pv = 1
GxEmodel_result_file_name = "Result_GxEmodel.txt"
GEM_GxEmodel(snp_file_name, covariate_file_name, methylation_file_name, GxEmodel_pv, GxEmodel_result_file_name, topKplot = 1, savePlot=FALSE)
```

```
## 100.00% done, 100,000 cpg-snp pairs
## Analysis done in:  0.113  seconds
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the GEM package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

Results:

```
##     cpg    snp         beta     stats       pvalue       FDR
## 1 CpG25 SNP991  0.007363396  4.424023 1.490302e-05 0.8948726
## 2 CpG70 SNP232 -0.007460388 -4.341772 2.112071e-05 0.8948726
## 3 CpG83  SNP77 -0.006540673 -4.130645 5.051351e-05 0.8948726
## 4 CpG66  SNP44  0.007428030  4.043966 7.155883e-05 0.8948726
## 5 CpG59 SNP592  0.025209578  4.042911 7.186018e-05 0.8948726
## 6 CpG30 SNP847 -0.005175795 -4.031095 7.532016e-05 0.8948726
```

## References

[1] Pan H, Holbrook JD, Karnani N, Kwoh CK (2016). “**Gene, Environment and Methylation (GEM): A tool suite to efficiently navigate large scale epigenome wide association studies and integrate genotype and interaction between genotype and environment.**” BMC Bioinformatics (submitted).

[2] Shabalin AA. (2012). “**Matrix eQTL: ultra fast eQTL analysis via large matrix operations.**” Bioinformatics 28(10): 1353-1358.

[3] Teh AL, Pan H, Chen L, Ong ML, Dogra S, Wong J, MacIsaac JL, Mah SM, McEwen LM, Saw SM et al(2014): “**The effect of genotype and in utero environment on interindividual variation in neonate DNA methylomes**”. Genome research, 24(7):1064-1074.