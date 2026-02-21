# Code example from 'IPPD' vignette. See references/ for full tutorial.

### R code from vignette source 'IPPD.Rnw'

###################################################
### code chunk number 1: setup
###################################################

options(prompt = "R> ", continue = " ", warn = -1, width = 90)                                       



###################################################
### code chunk number 2: loadmyo500
###################################################

library(IPPD) 
data(myo500)
x <- myo500[,"mz"]
y <- myo500[,"intensities"]
y <- y[x <= 2500]
x <- x[x <= 2500]


###################################################
### code chunk number 3: plotmyo500first1000
###################################################

layout(matrix(c(1,2), 1, 2))

plot(x[1:1000], y[1:1000], xlab = expression(x[1]~~ldots~~x[1000]), 
     cex.lab = 1.5, cex.axis = 1.25, ylab = expression(y))

plot(x[x >= 804 & x <= 807], y[x >= 804 & x <= 807], 
     xlab = "x: 804 <= x <= 807", 
     cex.lab = 1.5, cex.axis = 1.25, ylab = expression(y), type = "b")

layout(matrix(1))



###################################################
### code chunk number 4: fitGauss
###################################################

fitGauss <- fitModelParameters(mz = x, intensities = y,
                   model = "Gaussian", fitting = "model", formula.sigma = formula(~mz),
                   control = list(window = 6, threshold = 200))


###################################################
### code chunk number 5: fitEMG
###################################################

fitEMG <- fitModelParameters(mz = x, intensities = y,
                   model = "EMG", fitting = "model",
                           formula.alpha = formula(~mz),
                           formula.sigma = formula(~mz),
                           formula.mu = formula(~1),
                           control = list(window = 6, threshold = 200))


###################################################
### code chunk number 6: assessfit
###################################################

show(fitEMG)
mse.EMG <- data.frame(mse = slot(fitEMG,"peakfitresults")[,"rss"] 
                      / slot(fitEMG,"peakfitresults")[,"datapoints"], 
                      peakshape = rep("EMG", nrow( slot(fitEMG,"peakfitresults"))))
mse.Gauss <- data.frame(mse = slot(fitGauss,"peakfitresults")[,"rss"] 
                        / slot(fitGauss,"peakfitresults")[,"datapoints"], 
                        peakshape = rep("Gaussian", nrow( slot(fitGauss,"peakfitresults"))))
mses <- rbind(mse.EMG, mse.Gauss)
with(mses, boxplot(mse ~ peakshape, cex.axis = 1.5, cex.lab = 1.5, ylab = "MSE"))



###################################################
### code chunk number 7: assessfitEMGpeak
###################################################
visualize(fitEMG, type = "peak", cex.lab = 1.5, cex.axis = 1.25)


###################################################
### code chunk number 8: assessfit2
###################################################

visualize(fitEMG, type = "model", modelfit = TRUE, 
          parameters = c("sigma", "alpha"), 
          cex.lab = 1.5, cex.axis = 1.25)



###################################################
### code chunk number 9: getlist
###################################################

EMGlist <- getPeaklist(mz = x, intensities = y, model = "EMG",
model.parameters = fitEMG, 
loss = "L2", trace = FALSE,
control.localnoise = list(factor.place = 2),
control.basis = list(charges = c(1, 2)),
control.postprocessing = list(ppm = 200))

show(EMGlist)



###################################################
### code chunk number 10: showlist
###################################################

threshold(EMGlist, threshold = 3, refit = TRUE, trace = FALSE)



###################################################
### code chunk number 11: plot1
###################################################

visualize(EMGlist, x, y, lower= 963, upper = 973,
           fit = FALSE, fittedfunction = TRUE, fittedfunction.cut = TRUE,
           localnoise = TRUE, quantile = 0.5,
           cutoff.functions = 3)



###################################################
### code chunk number 12: plot2
###################################################


visualize(EMGlist, x, y, lower= 1502, upper = 1510,
           fit = FALSE, fittedfunction = TRUE, fittedfunction.cut = TRUE,
           localnoise = TRUE, quantile = 0.5,
           cutoff.functions = 2)




###################################################
### code chunk number 13: plot3
###################################################

visualize(EMGlist, x, y, lower= 1360, upper = 1364,
          fit = FALSE, fittedfunction = TRUE, fittedfunction.cut = TRUE,
          localnoise = TRUE, quantile = 0.5, 
          cutoff.functions = 2)



###################################################
### code chunk number 14: clear
###################################################

rm(list = ls())



###################################################
### code chunk number 15: mzXML
###################################################

directory <- system.file("data", package = "IPPD")

download.file("http://www.ml.uni-saarland.de/code/IPPD/CytoC_1860-2200_500-600.mzXML",
              destfile = paste(directory, "/samplefile", sep = ""),
              quiet = TRUE)

data <- read.mzXML(paste(directory, "/samplefile", sep = ""))



###################################################
### code chunk number 16: sweepline (eval = FALSE)
###################################################
## 
## processLCMS <- analyzeLCMS(data, 
##                      arglist.getPeaklist = list(control.basis = list(charges = c(1,2,3))),
##                      arglist.threshold = list(threshold = 10),
##                      arglist.sweepline = list(minboxlength = 20))
## 
## boxes <- processLCMS$boxes


###################################################
### code chunk number 17: loadresults
###################################################

directory <- system.file("data", package = "IPPD")
filename <- file.path(directory, "examples_boxes.txt") 
boxes <- as.matrix(read.table(filename, header = TRUE))



###################################################
### code chunk number 18: displaysweepline
###################################################

print(boxes)

rtlist <- lapply(data$scan, function(x)
                 as.numeric(sub("([^0-9]*)([0-9|.]+)([^0-9]*)", "\\2", x$scanAttr)))

rt <- unlist(rtlist)

nscans <- length(rt)

npoints <- length(data$scan[[1]]$mass)

Y <- matrix(unlist(lapply(data$scan, function(x) x$peaks)),
            nrow = nscans, 
            ncol = npoints,
            byrow = TRUE)




contour(rt, data$scan[[1]]$mass, Y, xlab = "t", ylab = "mz", 
        levels = 10^(seq(from = 5, to = 6.75, by = 0.25)),
        drawlabels = FALSE)

for(i in 1:nrow(boxes))
  lines(c(boxes[i,"rt_begin"], boxes[i,"rt_end"]), rep(boxes[i,"loc"], 2), col = "red")




