# Code example from 'GARS' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex(relative.path = TRUE)

## ----knitr, echo=FALSE, results="hide"-------------------------------------
library("knitr")
opts_chunk$set(
  tidy=FALSE,
  dev="png",
  fig.show="hide",
#  fig.width=4, fig.height=4.5,
  fig.width=10, fig.height=8,
  fig.pos="tbh",
  cache=TRUE,
  message=FALSE)

## ----chu_1, warning=FALSE--------------------------------------------------
library(MLSeq)
library(DaMiRseq)
library(GARS)

# load dataset
filepath <- system.file("extdata/cervical.txt", package = "MLSeq")
cervical <- read.table(filepath, header=TRUE)

# replace "wild-card" characters with other characters
rownames(cervical) <- gsub("*", "x", rownames(cervical), fixed = TRUE)
rownames(cervical) <- gsub("-", "_", rownames(cervical), fixed = TRUE)

# create the "class" vector
class_vector <- data.frame(gsub('[0-9]+', '', colnames(cervical)))
colnames(class_vector) <- "class"
rownames(class_vector) <- colnames(cervical)

# create a Summarized Experiment object
SE_obj <- DaMiR.makeSE(cervical, class_vector)

# filter and normalize the dataset
datanorm <- DaMiR.normalization(SE_obj)


## ----chu_2, dev="pdf"------------------------------------------------------
set.seed(123)
res_GA <- GARS_GA(data=datanorm,
                 classes = colData(datanorm),
                 chr.num = 100,
                 chr.len = 8,
                 generat = 20,
                 co.rate = 0.8,
                 mut.rate = 0.1,
                 n.elit = 10,
                 type.sel = "RW",
                 type.co = "one.p",
                 type.one.p.co = "II.quart",
                 n.gen.conv = 150,
                 plots="no",
                 verbose="yes")


## ----chu_2_bis, dev="pdf"--------------------------------------------------
# Plot Fitness Evolution
fitness_scores <- FitScore(res_GA)
GARS_PlotFitnessEvolution(fitness_scores)

#Plot the frequency of each features over the generations
Allfeat_names <- rownames(datanorm)
Allpopulations <- AllPop(res_GA)
GARS_PlotFeaturesUsage(Allpopulations,
                       Allfeat_names,
                       nFeat = 10)


## ----chu_3, dev="pdf"------------------------------------------------------

# expression data of selected features
data_reduced_GARS <- MatrixFeatures(res_GA)

# Classification
data_reduced_DaMiR <- as.data.frame(data_reduced_GARS)
classes_DaMiR <- as.data.frame(colData(datanorm))
colnames(classes_DaMiR) <- "class"
rownames(classes_DaMiR) <- rownames(data_reduced_DaMiR)

DaMiR.MDSplot(data_reduced_DaMiR,classes_DaMiR)
DaMiR.Clustplot(data_reduced_DaMiR,classes_DaMiR)

set.seed(12345)
Classification.res <- DaMiR.EnsembleLearning(data_reduced_DaMiR,
                                             as.factor(classes_DaMiR$class),
                                             iter=5)


## ----chu_4, dev="pdf"------------------------------------------------------

populs <- list()
k=1
for (ik in c(7,8,9)){
  set.seed(1)
  cat(ik, "features","\n")
  populs[[k]] <- GARS_GA(data=datanorm,
                        classes = colData(datanorm),
                        chr.num = 100,
                        chr.len = ik,
                        generat = 20,
                        co.rate = 0.8,
                        mut.rate = 0.1,
                        n.elit = 10,
                        type.sel = "RW",
                        type.co = "one.p",
                        type.one.p.co = "II.quart",
                        n.gen.conv = 150,
                        plots = "no",
                        verbose="no")

  k <- k +1

}

# find the maximum fitness for each case
max_fit <- 0

for (i in seq_len(length(populs))){
  max_fit[i] <- max(FitScore(populs[[i]]))
}
max_fit

best_popul <- populs[[which(max_fit == max(max_fit))]]

# number of features (best solution)
dim(MatrixFeatures(best_popul))[2]


## ----sessInfo, results="asis", echo=FALSE----------------------------------
toLatex(sessionInfo())

