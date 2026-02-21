# Code example from 'gprege_quick' vignette. See references/ for full tutorial.

### R code from vignette source 'gprege_quick.Rnw'

###################################################
### code chunk number 1: gprege_quick.Rnw:31-32
###################################################
  options(width = 60)


###################################################
### code chunk number 2: gprege_quick.Rnw:47-50 (eval = FALSE)
###################################################
##   if (!requireNamespace("BiocManager", quietly=TRUE))
##       install.packages("BiocManager")
##   BiocManager::install("gprege")


###################################################
### code chunk number 3: gprege_quick.Rnw:57-58
###################################################
  library(gprege)


###################################################
### code chunk number 4: gprege_quick.Rnw:63-64 (eval = FALSE)
###################################################
##   data(FragmentDellaGattaData)


###################################################
### code chunk number 5: gprege_quick.Rnw:69-73 (eval = FALSE)
###################################################
##   # Download full Della Gatta dataset.
##   load(url('https://github.com/alkalait/gprege-datasets/raw/master/R/DellaGattaData.RData'))
##   # OR
##   data(FullDellaGattaData)


###################################################
### code chunk number 6: gprege_quick.Rnw:81-92
###################################################
  # Download full Della Gatta dataset.
  ## con <- url('https://github.com/alkalait/gprege-datasets/raw/master/R/DellaGattaData.RData')
  ## attempts = 0
  ## while(!exists('DGdata') && attempts < 3) {
  ##  try(load(con),TRUE) #  close.connection(con)
  ##  attempts = attempts + 1
  ## }
  data(FullDellaGattaData)
  # Timepoints / GP inputs.
  tTrue = matrix(seq(0,240,by=20), ncol=1)
  gpregeOptions <- list()


###################################################
### code chunk number 7: gprege_quick.Rnw:95-98 (eval = FALSE)
###################################################
##   data(FullDellaGattaData)
##   # Set index range so that only a top few targets suggested by TSNI be explored.
##   gpregeOptions$indexRange <- which(DGatta_labels_byTSNItop100)[1:2]


###################################################
### code chunk number 8: gprege_quick.Rnw:101-106
###################################################
  # Load installed fragment-dataset.
  data(FragmentDellaGattaData)
  # Fragment dataset is comprised of top-ranked targets suggested by TSNI.
  # Explore only the first few.
  gpregeOptions$indexRange <- 1:2


###################################################
### code chunk number 9: gprege_quick.Rnw:109-130
###################################################
  # Explore individual profiles in interactive mode.
  gpregeOptions$explore <- TRUE
  # Exhaustive plot resolution of the LML function.
  gpregeOptions$exhaustPlotRes <- 30
  # Exhaustive plot contour levels.
  gpregeOptions$exhaustPlotLevels <- 10
  # Exhaustive plot maximum lengthscale.
  gpregeOptions$exhaustPlotMaxWidth <- 100
  # Noisy ground truth labels: which genes are in the top 786 ranks of the TSNI ranking.
  gpregeOptions$labels <- DGatta_labels_byTSNItop100 
  # SCG optimisation: maximum number of iterations.
  gpregeOptions$iters <- 100
  # SCG optimisation: no messages.
  gpregeOptions$display <- FALSE
  # Matrix of different hyperparameter configurations as rows:
  # [inverse-lengthscale   percent-signal-variance   percent-noise-variance].
  gpregeOptions$inithypers <-
    matrix( c(  1/1000,	1e-3,	0.999,
                1/30,	0.999,	1e-3,
                1/80,	2/3, 1/3
  ), ncol=3, byrow=TRUE)


###################################################
### code chunk number 10: gprege_quick.Rnw:133-134
###################################################
  gpregeOutput<-gprege(data=exprs_tp63_RMA,inputs=tTrue,gpregeOptions=gpregeOptions)


###################################################
### code chunk number 11: gprege_quick.Rnw:136-156
###################################################
  for (i in 1:length(gpregeOptions$indexRange)) {
    cat("\\begin{figure}[H]")
    cat("\\centering")
#     cat("\\subfigure[]{")
    cat("\\includegraphics[width=0.7\\linewidth]{",  paste("gpPlot",i,".pdf",sep=""), "}\n\n",  sep="")
#     cat("\\label{fig:seqfig", i, "}", sep = "")
    cat("\\caption{GP fit with different initialisations on profile \\#", gpregeOptions$indexRange[i], ".}", sep="")
    cat("\\label{fig:gpPlot", i, "}", sep = "")
    cat("\\end{figure}")
    
    cat("\\begin{figure}[H]")
    cat("\\centering")
    cat("\\subfigure[]{")
    cat("\\includegraphics[page=1,width=.7\\linewidth]{",paste("exhaustivePlot",i,".pdf",sep=""),"}}\n\n", sep="")
    cat("\\subfigure[]{")
    cat("\\includegraphics[page=2,width=.7\\linewidth]{",paste("exhaustivePlot",i,".pdf",sep=""),"}}\n\n", sep="")
    cat("\\caption{Profile \\#", gpregeOptions$indexRange[i], " : (a) Log-marginal likelihood (LML) contour. (b) GP fit with maximum LML hyperparameters from the exhaustive search.}", sep = "")
    cat("\\label{fig:exPlot", i, "}", sep = "")
    cat("\\end{figure}")
  }


###################################################
### code chunk number 12: gprege_quick.Rnw:163-185
###################################################
  # Load fragment dataset.
  data(FragmentDellaGattaData)
  data(DGdat_p63)
  # Download BATS rankings (Angelini, 2007)
  # Case 1: Delta error prior, case 2: Inverse Gamma error prior,
  #  case 3: Double Exponential error prior.
  BATSranking = matrix(0, length(DGatta_labels_byTSNItop100), 3)
  ##for (i in 1:3){
  ##  # Read gene numbers.
  ##  tmp = NULL
  ##  con <- url(paste('https://github.com/alkalait/gprege-datasets/raw/master/R/DGdat_p63_case',i,'_GL.txt',sep=''))
  ##  while(is.null(tmp)) try(tmp <- read.table(con, skip=1), TRUE)
  ##  genenumbers <- as.numeric(lapply( as.character(tmp[,2]), function(x) x=substr(x,2,nchar(x))))
  ##  # Sort rankqings by gene numbers.
  ##  BATSranking[,i] <- tmp[sort(genenumbers, index.return=TRUE)$ix, 4]
  ##}
  genenumbers <- as.numeric(lapply(as.character(DGdat_p63_case1_GL[,2]), function(x) x=substr(x,2,nchar(x))))
  BATSranking[,1] <- DGdat_p63_case1_GL[sort(genenumbers, index.return=TRUE)$ix, 4]
  genenumbers <- as.numeric(lapply(as.character(DGdat_p63_case2_GL[,2]), function(x) x=substr(x,2,nchar(x))))
  BATSranking[,2] <- DGdat_p63_case2_GL[sort(genenumbers, index.return=TRUE)$ix, 4]
  genenumbers <- as.numeric(lapply(as.character(DGdat_p63_case3_GL[,2]), function(x) x=substr(x,2,nchar(x))))
  BATSranking[,3] <- DGdat_p63_case3_GL[sort(genenumbers, index.return=TRUE)$ix, 4]


###################################################
### code chunk number 13: gprege_quick.Rnw:189-196
###################################################
  # The smaller a BATS-rank metric is, the better the rank of the gene
  # reporter. Invert those rank metrics to compare on a common ground
  # with gprege.
  BATSranking = 1/BATSranking
  compareROC(output=gpregeOutput$rankingScores,
          groundTruthLabels=DGatta_labels_byTSNItop100,
          compareToRanking=BATSranking)


###################################################
### code chunk number 14: gprege_quick.Rnw:208-237 (eval = FALSE)
###################################################
##   # Download full Della Gatta dataset.
##   #con <- url('https://github.com/alkalait/gprege-datasets/raw/master/R/DellaGattaData.RData')
##   #while(!exists('DGdata')) try(load(con),TRUE); close.connection(con)
##   data(FullDellaGattaData)
##   # Timepoints / GP inputs.
##   tTrue = matrix(seq(0,240,by=20), ncol=1)
##   gpregeOptions <- list()
##   # Explore individual profiles in interactive mode.
##   gpregeOptions$explore <- FALSE
##   # Exhaustive plot resolution of the LML function.
##   gpregeOptions$exhaustPlotRes <- 30
##   # Exhaustive plot contour levels.
##   gpregeOptions$exhaustPlotLevels <- 10
##   # Exhaustive plot maximum lengthscale.
##   gpregeOptions$exhaustPlotMaxWidth <- 100
##   # Noisy ground truth labels: which genes are in the top 786 ranks of the TSNI ranking.
##   gpregeOptions$labels <- DGatta_labels_byTSNItop100 
##   # SCG optimisation: maximum number of iterations.
##   gpregeOptions$iters <- 100
##   # SCG optimisation: no messages.
##   gpregeOptions$display <- FALSE
##   # Matrix of different hyperparameter configurations as rows:
##   # [inverse-lengthscale   percent-signal-variance   percent-noise-variance].
##   gpregeOptions$inithypers <-
##     matrix( c(  1/1000,  1e-3,	0.999,
##                 1/8,	0.999,	1e-3,
##                 1/80,	2/3, 1/3
##   ), ncol=3, byrow=TRUE)
##   gpregeOutput<-gprege(data=exprs_tp63_RMA,inputs=tTrue,gpregeOptions=gpregeOptions)


