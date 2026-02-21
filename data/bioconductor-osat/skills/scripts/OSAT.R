# Code example from 'OSAT' vignette. See references/ for full tutorial.

### R code from vignette source 'OSAT.Rnw'

###################################################
### code chunk number 1: initialize
###################################################
library(OSAT)
inPath <- system.file('extdata', package='OSAT')
pheno <- read.table(file.path(inPath, 'samples.txt'), 
                    header=TRUE, sep="\t", colClasses="factor")


###################################################
### code chunk number 2: tbl1
###################################################
library(xtable)
print(xtable(summary(pheno), caption="Example Data", label = "tbl:tbl1"), table.placement = "tbp",caption.placement = "top")


###################################################
### code chunk number 3: pheno2 (eval = FALSE)
###################################################
## with(pheno, as.data.frame(table(SampleType, Race, AgeGrp)))


###################################################
### code chunk number 4: tbl2
###################################################
print(xtable(with(pheno, as.data.frame(table(SampleType, Race, AgeGrp))), caption="Data distribution", label = "tbl:tbl2"), table.placement = "tbp",
caption.placement = "top")


###################################################
### code chunk number 5: gs
###################################################
gs <- setup.sample(pheno, optimal=c("SampleType", "Race", "AgeGrp"))


###################################################
### code chunk number 6: container
###################################################
gc <- setup.container(IlluminaBeadChip96Plate, 6, batch='plates')


###################################################
### code chunk number 7: gSetup
###################################################
set.seed(123)    # to create reproducible result
# demonstration only. nSim=5000 or more are commonly used.
gSetup <- create.optimized.setup(sample=gs, container=gc, nSim=1000)


###################################################
### code chunk number 8: csvSetup
###################################################
write.csv(get.experiment.setup(gSetup), 
          file="gSetup.csv", row.names=FALSE)


###################################################
### code chunk number 9: csvMSA
###################################################
out <- map.to.MSA(gSetup, MSA4.plate)
write.csv(out, "MSAsetup.csv", row.names = FALSE)


###################################################
### code chunk number 10: MSA
###################################################
head(out)


###################################################
### code chunk number 11: QC (eval = FALSE)
###################################################
## QC(gSetup)


###################################################
### code chunk number 12: fig1
###################################################
QC(gSetup)


###################################################
### code chunk number 13: optblock
###################################################
gs2 <- setup.sample(pheno,  strata=c("SampleType"), 
          optimal=c("SampleType", "Race", "AgeGrp") )
set.seed(123)    # to create reproducible result
# demonstration only. nSim=5000 or more are commonly used.
gSetup2 <- create.optimized.setup("optimal.block", 
          sample=gs2, container=gc, nSim=1000)


###################################################
### code chunk number 14: optQC (eval = FALSE)
###################################################
## QC(gSetup2)


###################################################
### code chunk number 15: fig2
###################################################
QC(gSetup2)


###################################################
### code chunk number 16: random
###################################################
set.seed(397)        # an unfortunate choice
c1 <- getLayout(gc)  # available wells
c1 <- c1[order(runif(nrow(c1))),] # shuffle randomly
randomSetup <- cbind(pheno, c1[1:nrow(pheno), ]) 
     # create a sample assignment


###################################################
### code chunk number 17: randomfig (eval = FALSE)
###################################################
## multi.barplot(randomSetup, grpVar='plates', 
##       varList=c("SampleType", "Race", "AgeGrp"), 
##       main="A bad random case")


###################################################
### code chunk number 18: fig3
###################################################
multi.barplot(randomSetup, grpVar='plates', 
      varList=c("SampleType", "Race", "AgeGrp"), 
      main="A bad random case")


###################################################
### code chunk number 19: random2
###################################################
multi.chisq.test(randomSetup, grpVar='plates', 
      varList=c("SampleType", "Race", "AgeGrp"))


###################################################
### code chunk number 20: gsNew
###################################################
gs <- setup.sample(pheno, optimal=c("SampleType", "Race", "AgeGrp"),
           strata=c("SampleType"))
gs


###################################################
### code chunk number 21: gcNew
###################################################
gc <- setup.container(IlluminaBeadChip96Plate, 6, 
          batch='plates')
gc


###################################################
### code chunk number 22: pre1
###################################################
IlluminaBeadChip


###################################################
### code chunk number 23: own1
###################################################
myChip <- new("BeadChip", nRows=6, nColumns=2, byrow=FALSE, 
      comment="Illumina Bead Chip have 6 rows and 2 columns.")
myChip 


###################################################
### code chunk number 24: own2
###################################################
identical(myChip, IlluminaBeadChip)


###################################################
### code chunk number 25: own3
###################################################
myPlate <- new("BeadPlate", chip=IlluminaBeadChip,
      nRows=2L, nColumns=4L,
      comment="Illumina BeadChip Plate with 8 chips and 96 wells")
myPlate
identical(myPlate, IlluminaBeadChip96Plate)


###################################################
### code chunk number 26: s1
###################################################
gSetup0 <- create.experiment.setup(gs, gc)
myAssignment <- get.experiment.setup(gSetup0)


###################################################
### code chunk number 27: extra1 (eval = FALSE)
###################################################
## # for demonstration, assume 10 bad samples
## badSample <- sample(576, 10, replace=FALSE)  
## # create sample object using available samples
## gs3 <- setup.sample(pheno[-badSample, ], 
##       optimal=c("SampleType", "Race", "AgeGrp"), 
##       strata=c("SampleType") )
## # use the same container setup as before
## # demonstration only. nSim=5000 or more are commonly used.
## gSetup3 <- create.optimized.setup(sample=gs3, 
##         container=gc, nSim=1000)


###################################################
### code chunk number 28: extra2
###################################################
excludedWells <- data.frame(plates=1:6, chips=rep(1,6), 
                 wells=rep(1,6))


###################################################
### code chunk number 29: extra3
###################################################
ex2 <- data.frame(wells=1)


###################################################
### code chunk number 30: extra4
###################################################
gc3 <- setup.container(IlluminaBeadChip96Plate, 6, 
            batch='plates', exclude=excludedWells)


###################################################
### code chunk number 31: extra5
###################################################
cnt <- setup.container(IlluminaBeadChip96Plate, 2, batch='chips')


###################################################
### code chunk number 32: pair1
###################################################
# create mock chip. each row represent one individual
newChip <- new("BeadChip",  nRows=6, nColumns=1, byrow=FALSE, 
   comment="mock chip")
# a mock plate based on above chip, same physical layout
newPlate <- new("BeadPlate", chip=newChip,
   nRows=2L, nColumns=4L, 
   comment="mock plate")
# create containers based on above mock chip/plate
gcNew <- setup.container(newPlate, 12, batch="plates")

# assign pairs into locations on the mock chip
# this will take some time
set.seed(12345)
# demonstration only. nSim=5000 or more are commonly used.
gPaired <- create.optimized.setup("optimal.block", sample=gs, 
           container=gcNew, nSim=1000)


###################################################
### code chunk number 33: pair2
###################################################
set.seed(456)
out1 <- get.experiment.setup(gPaired)
out1$Replica <- FALSE
idx <- sample(nrow(out1), ceiling(nrow(out1)/2), replace=FALSE)
     # randomly decided if the first specimen is placed in column 1
out1[idx, "Replica"] <- TRUE


###################################################
### code chunk number 34: pair3
###################################################
out2 <- out1
out2$columns <- 2          # specimen placed in the second column
out2$wells <- out2$wells+6 # correct well number
out2$Replica <- !out1$Replica          # indicate second specimen 

out3 <- rbind(out1, out2)  # all specimens

# sort to order on plates/chips/rows
idx1 <- with(out3, order(plates, chips,  rows, columns, wells))
out3 <- out3[idx1,]  # sort to order on plates/chips/wells


###################################################
### code chunk number 35: pair4
###################################################
## shuffle within chip
set.seed(789)
idx2 <- with(out3, order(plates, chips, runif(nrow(out3))))
out4 <- cbind(out3[, 1:8], out3[idx2, 9:11], Replica=out3[, 12])

# sort to order on plates/chips/wells
idx3 <- with(out4, order(plates,  chips, wells))
out4 <- out4[idx3,]


###################################################
### code chunk number 36: pair5 (eval = FALSE)
###################################################
## # SampleType and replica distribution by plate
## ftable(xtabs( ~plates +SampleType+ Replica, out3))


###################################################
### code chunk number 37: pairfig (eval = FALSE)
###################################################
## multi.barplot(out3, grpVar='plates', varList=c("SampleType", "Replica", 
##               "Race", "AgeGrp"), main="paired sample")


###################################################
### code chunk number 38: figPair
###################################################
multi.barplot(out3, grpVar='plates', varList=c("SampleType", "Replica", 
              "Race", "AgeGrp"), main="paired sample")


###################################################
### code chunk number 39: pair2
###################################################
multi.chisq.test(out3, grpVar='plates', varList=c("SampleType", "Replica", 
              "Race", "AgeGrp"))


###################################################
### code chunk number 40: sessioninfo
###################################################
sessionInfo()


