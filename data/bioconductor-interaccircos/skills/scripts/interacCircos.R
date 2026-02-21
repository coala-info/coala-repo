# Code example from 'interacCircos' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(interacCircos)
Circos(width = 700,height = 550)

## ----screenshot.force = FALSE-------------------------------------------------
library(interacCircos)
Circos(zoom = TRUE,genome=list("Example1"=100,"Example2"=200,
      "Example3"=300),genomeFillColor = c("red","blue","green"),
      width = 700,height = 550)

## ----screenshot.force = FALSE-------------------------------------------------
library(interacCircos)
set.seed(1)
Circos(zoom = FALSE,genome=list("Example1"=100,"Example2"=200,
      "Example3"=300),genomeFillColor = "Blues",
      width = 700,height = 550)


## ----screenshot.force = FALSE-------------------------------------------------
library(interacCircos)

histogramData <- histogramExample
Circos(moduleList=CircosHistogram('HISTOGRAM01', data = histogramData,
      fillColor= "#ff7f0e",maxRadius = 210,minRadius = 175,
      animationDisplay = TRUE),genome=list("2L"=23011544,"2R"=21146708,"3L"=24543557,"3R"= 27905053,"X"=22422827,"4"=1351857),
      outerRadius = 220, width = 700,height = 550)

## ----screenshot.force = FALSE-------------------------------------------------
library(interacCircos)

snpData <- snpExample
Circos(moduleList=CircosSnp('SNP01', minRadius =150, 
      maxRadius = 190, data = snpExample,SNPFillColor= "#9ACD32", 
      circleSize= 2, SNPAxisColor= "#B8B8B8", SNPAxisWidth= 0.5, 
      animationDisplay=TRUE,animationTime= 2000, animationDelay= 0, 
      animationType= "linear") + 
      CircosBackground('BG01',minRadius = 145,maxRadius = 200),
      width = 700,height = 550)


## ----screenshot.force = FALSE-------------------------------------------------
sessionInfo()

