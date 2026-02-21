# Code example from 'flowCHICmanual' vignette. See references/ for full tutorial.

### R code from vignette source 'flowCHICmanual.Rnw'

###################################################
### code chunk number 1: loadPackage
###################################################
# Load package
library(flowCHIC)


###################################################
### code chunk number 2: GetChannels (eval = FALSE)
###################################################
## # Set the working directory to the path where your FCS files are located
## # Type the path into the quotes
## setwd("") 
## # Or in Windows use
## setwd(choose.dir(getwd(), "Choose the folder containing the FCS files"))
## # Get a list of the filenames of the FCS files located in your working directory
## files <- list.files(getwd(),full=TRUE,pattern="*.fcs")
## # Get a list of the filenames of the FCS files included to the package
## files <- list.files(system.file("extdata",package="flowCHIC"),
## full=TRUE,pattern="*.fcs")
## # Read the first FCS file as flowFrame
## frame <- read.FCS(files[1],alter.names=TRUE,transformation=FALSE) 
## # Get a list of the parameter/channel names
## unname(frame@parameters@data$name)


###################################################
### code chunk number 3: CreateImage (eval = FALSE)
###################################################
## # Create the histogram images using default parameters
## fcs_to_img(files)
## # Create the histogram images using different channels
## # Not working for the FCS files attached to the package
## fcs_to_img(files,ch1="SS.Log",ch2="FL.1.Log")


###################################################
### code chunk number 4: CreateSubset (eval = FALSE)
###################################################
## # Create the histogram image subsets using default parameters
## img_sub(files,ch1="FS.Log",ch2="FL.4.Log")


###################################################
### code chunk number 5: CreateChangedSubset (eval = FALSE)
###################################################
## # Create the histogram images using different boundaries for the x/y axis
## # and a different value for the maximal value set to black
## # These values work well for the first downloadable dataset and 
## # the FCS files included to the package
## img_sub(files,x_start=200,x_end=3500,y_start=1000,y_end=3000,maxv=160)


###################################################
### code chunk number 6: CalculateXorOver (eval = FALSE)
###################################################
## # Save the names of all subset images as a list
## subsets <- list.files(path=paste(getwd(),"chic_subset",sep="/"),full=TRUE,pattern="*.png")
## # Calculate overlap and XOR images and write values to two new files
## results<-calculate_overlaps_xor(subsets)


###################################################
### code chunk number 7: CalculateXorOver_files (eval = FALSE)
###################################################
## # Save the names of all subset images as a list
## subsets <- list.files(path=paste(getwd(),"chic_subset",sep="/"),full=TRUE,pattern="*.png")
## # Calculate overlap and XOR images and write values to two new files
## calculate_overlaps_xor(subsets,verbose=TRUE)


###################################################
### code chunk number 8: NMDSXorOverlapList (eval = FALSE)
###################################################
## # Show a NMDS plot of the samples
## plot_nmds(results$overlap,results$xor) 


###################################################
### code chunk number 9: readOverXor (eval = FALSE)
###################################################
## # Type the filename of the overlap data (including extension) into the quotes
## Results_overlaps<-read.table("Results_overlaps.txt",header=TRUE,sep="\t")  
## # Type the filename of the XOR data (including extension) into the quotes
## Results_xor<-read.table("Results_xor.txt",header=TRUE,sep="\t")  


###################################################
### code chunk number 10: NMDSXorOverlapRead (eval = FALSE)
###################################################
## # Show a NMDS plot of the samples
## plot_nmds(Results_overlaps,Results_xor) 


###################################################
### code chunk number 11: plotDefault
###################################################
# Load datasets
data(Results_overlaps)
data(Results_xor)
# Show a NMDS plot of the samples
plot_nmds(Results_overlaps,Results_xor) 


###################################################
### code chunk number 12: plotDefaultChanged
###################################################
# Change default parameters
plot_nmds(Results_overlaps,Results_xor,main="NMDS plot",pos=3,pch=2,col_nmds="red")


###################################################
### code chunk number 13: overlapsmix
###################################################
# Load dataset
data(Results_overlaps_mix) 
# Show data (first five lines)
Results_overlaps_mix[1:5,]


###################################################
### code chunk number 14: xormix
###################################################
# Load dataset
data(Results_xor_mix)
# Show data (first five lines)
Results_xor_mix[1:5,]


###################################################
### code chunk number 15: plotDefault_mix
###################################################
# Plot
plot_nmds(Results_overlaps_mix,Results_xor_mix)


###################################################
### code chunk number 16: overlapsincol
###################################################
# Load dataset
data(Results_overlaps_incol) 
# Show data (first five lines)
Results_overlaps_incol[1:5,]


###################################################
### code chunk number 17: xorincol
###################################################
# Load dataset
data(Results_xor_incol)
# Show data (first five lines)
Results_xor_incol[1:5,]


###################################################
### code chunk number 18: plotDefault_incol
###################################################
# Plot
plot_nmds(Results_overlaps_incol,Results_xor_incol)


###################################################
### code chunk number 19: Groups
###################################################
# Create data frame with group assignments
groups<-data.frame("groups"=c(15,19,19,19,15,22,19,15,22,15,15,22,22,22,22,19,19))


###################################################
### code chunk number 20: plotGroup_incol
###################################################
# Plot
plot_nmds(Results_overlaps_incol,Results_xor_incol,group=groups)


###################################################
### code chunk number 21: abioticincol
###################################################
# Load dataset
data(abiotic_incol)
# Show data (first five lines)
abiotic_incol[1:5,]


###################################################
### code chunk number 22: plotAbiotic_incol
###################################################
# Plot
plot_nmds(Results_overlaps_incol,Results_xor_incol,
          abiotic=abiotic_incol[,-1])


###################################################
### code chunk number 23: plotAbioticGroup_incol
###################################################
# Plot
plot_nmds(Results_overlaps_incol,Results_xor_incol,group=groups,abiotic=abiotic_incol[,-1])


###################################################
### code chunk number 24: plotAbioticGroup_incolchanged
###################################################
# Plot
plot_nmds(Results_overlaps_incol,Results_xor_incol,group=groups,
          legend_pos="topright",abiotic=abiotic_incol[,-1],
          p.max=0.01,col_abiotic="darkred")


###################################################
### code chunk number 25: plotAbioticGroup_incolchanged_cluster
###################################################
# Plot
plot_nmds(Results_overlaps_incol,Results_xor_incol,show_cluster=TRUE,group=groups,
          legend_pos="topright",abiotic=abiotic_incol[,-1],
          p.max=0.01,col_abiotic="darkred")


###################################################
### code chunk number 26: plotAbioticGroup_incolchanged_verbose (eval = FALSE)
###################################################
## # Plot and print results
## plot_nmds(Results_overlaps_incol,Results_xor_incol,show_cluster=TRUE,group=groups,
##           legend_pos="topright",abiotic=abiotic_incol[,-1],
##           p.max=0.01,col_abiotic="darkred",verbose=TRUE)


