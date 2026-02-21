# Code example from 'ACE_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
library(ACE)
library(Biobase)
library(QDNAseq)
library(ggplot2)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# # BiocManager::install()
# BiocManager::install("ACE")

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("devtools")
# devtools::install_github("tgac-vumc/ACE")

## ----eval = FALSE-------------------------------------------------------------
# # specify the directory containing your bam-files
# userpath <- tempdir()
# # if you do not want the output in the same directory, use argument outputdir
# runACE(userpath, filetype='bam', binsizes = c(100, 1000),
#        ploidies = c(2,4), imagetype='png')

## ----eval = FALSE-------------------------------------------------------------
# data("copyNumbersSegmented")
# # specify the directory in which to create the output
# userpath <- tempdir()
# saveRDS(file.path(userpath,"copyNumbersSegmented.rds"))
# runACE(userpath, filetype='rds', ploidies = c(2,4), imagetype='png')

## -----------------------------------------------------------------------------
data("copyNumbersSegmented")
object <- copyNumbersSegmented
model1 <- singlemodel(object, QDNAseqobjectsample = 1)
bestfit1 <- model1$minima[tail(which(model1$rerror==min(model1$rerror)), 1)]
besterror1 <- min(model1$rerror)
lastfit1 <- tail(model1$minima, 1)
lasterror1 <- tail(model1$rerror, 1)
singleplot(object, QDNAseqobjectsample = 1, cellularity = bestfit1, 
           error = besterror1, standard = model1$standard, 
           title = "sample1 - binsize 1000 kbp - 379776 reads - 2N fit 1")
singleplot(object, QDNAseqobjectsample = 1, cellularity = lastfit1, 
           error = lasterror1, standard = model1$standard, 
           title = "sample1 - binsize 1000 kbp - 379776 reads - 2N fit 7")
model1$errorplot + ggtitle("sample1 - errorlist") + 
  theme(plot.title = element_text(hjust = 0.5))
model2 <- singlemodel(object, QDNAseqobjectsample = 2)
singleplot(object, QDNAseqobjectsample = 2, 0.38, 0.183, 
           title = "sample2 - binsize 1000 kbp - 369331 reads - 2N fit 3")
singleplot(object, QDNAseqobjectsample = 2, 0.94, 0.998, 
           title = "sample2 - binsize 1000 kbp - 369331 reads - 2N fit 6")
model2$errorplot +	ggtitle("sample2 - errorlist") + 
  theme(plot.title = element_text(hjust = 0.5))

## -----------------------------------------------------------------------------
data("copyNumbersSegmented")
object <- copyNumbersSegmented
# Since you're convinced the mode is 3N, you can run the singlemodel function to
# fit at ploidy = 3
model <- singlemodel(object, QDNAseqobjectsample = 2, ploidy = 3)
ls(model)
model$minima
model$rerror
model$errorplot
# Examining the errors can give you a feel for the fits. Experience tells
# us the last fit is probably the right one, so let's check out the copy number 
# plot. Specify the same parameters, now including the cellularity derived from 
# the model.
singleplot(object, QDNAseqobjectsample = 2, cellularity = 0.46, ploidy = 3)
# That is actually a very nice fit, let's run with it!
# You can now save the plot however you like. 

## -----------------------------------------------------------------------------
# To use data from QDNAseq-objects, ACE parses it into data frames referred to
# as "templates". Because we will look at sample2 several times, we can just
# create a variable with this data frame.
template <- objectsampletotemplate(object, index = 2)
head(template)
head(na.exclude(template))
# The template has the raw data from QDNAseq
median(na.exclude(template$segments))
# That number looks familiar ... but suppose I am not happy with it?
# You could find the values of all segments by doing
unique(na.exclude(template$segments))
# Personally I like the rle function, because it also shows you the "length" of
# a segment
segmentdata <- rle(as.vector(na.exclude(template$segments)))
plot(rep(segmentdata$values, segmentdata$lengths))
# Yes, it can be that easy to make something resembling a copy number plot :-) 
# Let's say we are sure that the segment with value 0.8105095 is 2N, we can use
# that number as new standard. First we need to find a good model that fits with
# this hypothesis
model <- singlemodel(template, ploidy = 2, standard = 0.8105095)
data.frame(model$minima, model$rerror)
singleplot(template, cellularity = 0.46, ploidy = 2, standard = 0.8105095)
# Choosing a lower standard shifts the absolute copy numbers up
# As a result we ended up with the exact same model as the 3N fit
# Note that I can directly use the template for the singlemodel and singleplot functions

## -----------------------------------------------------------------------------
# Let's continue with the template we made for sample 2, and just see what happens...
# Since the output of this one is pretty big, I'm saving it to a variable
sqmodel <- squaremodel(template)
ls(sqmodel)
# Yes, you get a lot of bang for your buck. You get back the parameters it used,
# but also the errors of all combinations tested in both a matrix and a
# dataframe, and where minima are found. But the fun comes in form of the
# matrixplot.
sqmodel$matrixplot + ggtitle("Sky on fire")
# You can find your minima of interest in the minimadf
# Note that the minima are sorted by their relative error
head(sqmodel$minimadf, 10)
# Guess I was warned about this ... squaremodel is a bit fithappy; time to put
# the thumbscrews on the fit
squaremodel(template, penalty = 0.5, penploidy = 0.5)$matrixplot
# Much better. Additionally you can play around with the range and resolution
sqmodel <- squaremodel(template, prows = 150, ptop = 3.3, pbottom = 1.8, 
                       penalty = 0.5, penploidy = 0.5)
sqmodel$matrixplot
# Going for higher ploidy resolution is not recommended! Not only will it take
# much longer to run, it will start distinguishing minima that correspond with
# basically the same model.
head(sqmodel$minimadf, 10)
singleplot(template, cellularity = 0.41, ploidy = 2.08)
# Perhaps this fit is a little bit better than our original 2N fit, 
# but the difference is negligible.

## -----------------------------------------------------------------------------
# Let's use the template dataframe we already created in the previous section
# for sample2. For cellularity and ploidy I'll use the original 2N fit
segmentdf <- getadjustedsegments(template, cellularity = 0.38)
head(segmentdf)

## -----------------------------------------------------------------------------
# Luck has it, we actually have mutation data for these samples. Bad luck has
# it, quality was very low, so calculated mutant copies are not very precise. 
# We use the segment data frame created in the previous section. 
# Mutation data can be provided as a file or as a data frame. The result will be 
# printed to file or returned as a supplemented data frame respectively.
# I will create the mutation data frame manually here.
Gene <- c("CASP8", "CDKN2A", "TP53")
Chromosome <- c(2, 9, 17)
Position <- c(202149589, 21971186, 7574003)
Frequency <- c(47.46, 36.28, 43.48)
variantdf <- data.frame(Gene, Chromosome, Position, Frequency)
linkvariants(variantdf, segmentdf, cellularity = 0.38, 
                 chrindex = 2, posindex = 3, freqindex = 4)

## -----------------------------------------------------------------------------
analyzegenomiclocations(segmentdf, Chromosome = 1, Position = 26365569)

## -----------------------------------------------------------------------------
chr <- c(1,2,3)
pos <- c(2000000,4000000,6000000)
analyzegenomiclocations(segmentdf, Chromosome = chr, Position = pos)

## -----------------------------------------------------------------------------
freq <- c(38,19,0)
analyzegenomiclocations(segmentdf=segmentdf, cellularity = 0.38, 
                        Chromosome = chr, Position = pos, Frequency = freq)

## ----eval = FALSE-------------------------------------------------------------
# # Set the correct path
# userpath <- tempdir()
# # This function needs a models-file, which should like like this
# sample <- c("sample1", "sample2")
# cellularity <- c(0.79, 0.38)
# ploidy <- c(2, 2)
# standard <- c(1, 1)
# models <- data.frame(sample, cellularity, ploidy, standard)
# write.table(models, file.path(userpath, "models.tsv"), quote = FALSE,
#             sep = "\t", na = "", row.names = FALSE)
# # Let's make sure we have some mutation data to analyze
# # For simplicity, I will just use the same mutation data for both samples
# write.table(mutationdf, file.path(userpath, "sample1_mutations.tsv"),
#             quote = FALSE, sep = "\t", na = "", row.names = FALSE)
# write.table(mutationdf, file.path(userpath, "sample2_mutations.tsv"),
#             quote = FALSE, sep = "\t", na = "", row.names = FALSE)
# # Let's go!
# postanalysisloop(object, inputdir = userpath, postfix = "_mutations",
#                  chrindex = 2, posindex = 3, freqindex = 4,
#                  outputdir = file.path(userpath,"output_loop"), imagetype = 'png')
# # note that mutation data is optional!

## -----------------------------------------------------------------------------
ACEcall(object, 2, cellularity = 0.39)$calledplot

## -----------------------------------------------------------------------------
# I don't think these two samples are very much related
tsc <- twosamplecompare(object, index1 = 1, index2 = 2, 
                        cellularity1 = 0.79, cellularity2 = 0.39)
tsc$compareplot

## -----------------------------------------------------------------------------
# Let's see some more fits for sample1!
sms <- squaremodelsummary(object, QDNAseqobjectsample = 1, 
                          squaremodel(object, 1, penalty = 0.5, penploidy = 0.5),
                          printplots = FALSE)
sms[[3]]

## -----------------------------------------------------------------------------
# I like squaremodels
lsm <- loopsquaremodel(object, printplots = FALSE, printobjectsummary = FALSE, 
                       penalty = 0.5, penploidy = 0.5, returnmodels = TRUE)
class(lsm)
length(lsm)
class(lsm[[1]])
ls(lsm[[1]])
lsm[[1]]$samplename
lsm[[1]]$matrixplot

## -----------------------------------------------------------------------------
sessionInfo()

