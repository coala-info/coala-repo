# Code example from 'GAprediction' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----predictGA----------------------------------------------------------------

require(GAprediction)

## Create a mock Illumina CpG dataset
cpgs <- extractSites( type="se" )
allcpgs <- extractSites( type="all" )
numsamples <- 100
mlmatr <- matrix( NA, ncol=length( allcpgs ), nrow=numsamples )
mlmatr <- data.frame( mlmatr )

## The CpGs needed for prediction can not contain NA's
for( i in cpgs )
  mlmatr[,i] <- runif( numsamples, min=0, max=1 )

## ----predictGA2---------------------------------------------------------------
mypred <- predictGA( mlmatr )
head( mypred )

## ----extractSites2------------------------------------------------------------
cpgs <- extractSites( type="se" )
cpgs[1:10]

