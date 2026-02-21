# GAprediction

#### Jon Bohlin

#### 2025-10-30

## Introduction

GAprediction is an R package that facilitates prediction of gestational age, in days from conception, from blood based on DNA methylation data from the Illumina HumanMethylation450 arrays. At its core is a Lasso-regression model trained using estimated ultrasound gestational ages. predictGA takes a CpG matrix of beta values between 0 and 1 and uses these to infer gestational age. To see how it works we provide a simple example with a mock-dataset.

```
require(GAprediction)
```

```
## Loading required package: GAprediction
```

```
## Create a mock Illumina CpG dataset
cpgs <- extractSites( type="se" )
allcpgs <- extractSites( type="all" )
numsamples <- 100
mlmatr <- matrix( NA, ncol=length( allcpgs ), nrow=numsamples )
mlmatr <- data.frame( mlmatr )

## The CpGs needed for prediction can not contain NA's
for( i in cpgs )
  mlmatr[,i] <- runif( numsamples, min=0, max=1 )
```

## Details

The glmnet Lasso-regression object requires a set of CpG sites with beta values between 0 and 1 to function. There are two similar models that can be chosen for gestational age prediction. The first (and default) sets the Lasso penalty parameter lambda to be within one standard error of minimum. The second model uses the minimum lambda. While the latter of these two models might give slightly improved predictions, the former requires fewer CpGs. Since the quality of the gestational age predictions is practically the same for both models the model that retains less CpGs is default (i.e. type=“se”).

```
mypred <- predictGA( mlmatr )
```

```
## Predicting GA...
```

```
head( mypred )
```

```
##         GA
## 1 231.5588
## 2 253.1263
## 3 217.1046
## 4 267.5280
## 5 252.9003
## 6 237.3045
```

## Requirement

The CpGs required for predictGA must be fully compliant with the Illumina HumanMethylation450 arrays otherwise the function will not work. To examine which CpGs are essential for prediction have a look at the extractSites() function:

```
cpgs <- extractSites( type="se" )
cpgs[1:10]
```

```
##  [1] "cg00153101" "cg00602416" "cg00711496" "cg01190109" "cg01281797"
##  [6] "cg01635555" "cg01833485" "cg02324006" "cg02405476" "cg02567958"
```

## Note

The word ‘prediction’ used in the present context of gestational age estimation is really a mis-nomer. predictGA will estimate gestational ages based on DNA methylation patterns extracted from blood. The word ‘prediction’ is used to underline the statistical ‘nature’ of the model. That is, the Lasso-regression model is trained on one methylation dataset with ultrasound-estimated gestational ages and give statistical predictions of gestational ages on methylation datasets where no such estimates are available.