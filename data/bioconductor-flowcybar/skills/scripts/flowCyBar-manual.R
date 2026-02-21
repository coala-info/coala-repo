# Code example from 'flowCyBar-manual' vignette. See references/ for full tutorial.

### R code from vignette source 'flowCyBar-manual.Rnw'

###################################################
### code chunk number 1: ReadExample (eval = FALSE)
###################################################
## # Type the path into the quotes
## setwd("") 
## # or in Windows use
## setwd(choose.dir(getwd(), "Choose the folder containing the data"))
## # Type the filename (including extension) the quotes
## # Example of reading the file Cell_number_sample.txt
## Cell_number_sample<-read.table("Cell_number_sample.txt",header=TRUE,sep="\t")  


###################################################
### code chunk number 2: loadPackage
###################################################
# Load package 
library(flowCyBar)


###################################################
### code chunk number 3: Cell_number
###################################################
# Load dataset
data(Cell_number_sample) 
# Show data
Cell_number_sample[,-1]


###################################################
### code chunk number 4: Normalize_mean (eval = FALSE)
###################################################
## # Normalize data, print 2 digits
## normalize(Cell_number_sample[,-1],digits=2) 


###################################################
### code chunk number 5: Normalize_first (eval = FALSE)
###################################################
## # Use method "first"
## normalize(Cell_number_sample[,-1],method="first",digits=2) 


###################################################
### code chunk number 6: Cell_number_sample
###################################################
# Show data 
Cell_number_sample


###################################################
### code chunk number 7: WriteNorm (eval = FALSE)
###################################################
## # Save normalized values
## normalized<-normalize(Cell_number_sample[,-1],digits=2) 
## # Write a new file containing the normalized values
## write.table(normalized,file="normalized.txt",row.names=TRUE,
## quote=FALSE,sep="\t")


###################################################
### code chunk number 8: CyBarPlotDefault
###################################################
# Load dataset
data(Cell_number_sample)
Normalized_mean<-normalize(Cell_number_sample[,-1],digits=2)
Normalized_mean<-data.frame(data.matrix(Normalized_mean))
# Plot with default parameters
cybar_plot(Normalized_mean,Cell_number_sample[,-1]) 


###################################################
### code chunk number 9: CyBarPlotFirst
###################################################
Normalized_first<-normalize(Cell_number_sample[,-1],method="first",digits=2)
Normalized_first<-data.frame(data.matrix(Normalized_first))
# Plot with default parameters
cybar_plot(Normalized_first,Cell_number_sample[,-1]) 


###################################################
### code chunk number 10: CyBarPlotFirstRange
###################################################
# Plot with changed range
cybar_plot(x=Normalized_first,to=3.5)


###################################################
### code chunk number 11: CyBarLabelOrder
###################################################
# Plot with different parameters
cybar_plot(Normalized_mean,Cell_number_sample[,-1],labels="vert",order="sim")


###################################################
### code chunk number 12: CyBarLabelOrderFirst
###################################################
# Plot with different parameters
cybar_plot(Normalized_first,Cell_number_sample[,-1],to=3.5,labels="vert",order="sim")


###################################################
### code chunk number 13: CyBarRowv
###################################################
# Barcode with ordered rows
cybar_plot(x=Normalized_mean,Rowv=TRUE,grad=15,dendrogram="both",
barmain="Normalized cell numbers")


###################################################
### code chunk number 14: CyBarSamples
###################################################
# Change row names
rownames(Normalized_mean)<-Cell_number_sample[,1]
# Plot
cybar_plot(Normalized_mean,Cell_number_sample[,-1],
barmain="Normalized cell numbers",labels="vert",order="sim",boxmain="Cell numbers")


###################################################
### code chunk number 15: NMDSDefault
###################################################
# NMDS plot of percental cell numbers
nmds(Cell_number_sample[,-1])


###################################################
### code chunk number 16: NMDSNormalized
###################################################
Normalized_mean<-normalize(Cell_number_sample[,-1],digits=2)
Normalized_mean<-data.frame(data.matrix(Normalized_mean))
# NMDS plot of normalized cel numbers
nmds(Normalized_mean)


###################################################
### code chunk number 17: NMDSChangeParam
###################################################
# NMDS plot with different parameters as described
nmds(Normalized_mean,main="NMDS plot of 
normalized cell numbers",type="b",pos=3,pch=2,col="red")


###################################################
### code chunk number 18: Groups
###################################################
# Create data frame with group assignments
groups<-data.frame("groups"=c(1,1,1,1,2,3,3,3,3,3))


###################################################
### code chunk number 19: NMDSGroups
###################################################
# NMDS plot with groups
nmds(Normalized_mean,group=groups,main="NMDS plot of 
normalized cell numbers")


###################################################
### code chunk number 20: Abiotic
###################################################
# Load dataset
data(Abiotic_data_sample)
# Show data
Abiotic_data_sample[,-1]


###################################################
### code chunk number 21: NMDSAbiotic
###################################################
# NMDS plot with groups and abiotic parameters
nmds(Normalized_mean,group=groups,main="NMDS plot of 
normalized cell numbers",abiotic=Abiotic_data_sample[,-1],verbose=TRUE)


###################################################
### code chunk number 22: NMDSSelect
###################################################
# NMDS plot of selected abiotic parameters
nmds(Normalized_mean,group=groups,main="NMDS plot of 
normalized cell numbers",abiotic=Abiotic_data_sample[,32:ncol(Abiotic_data_sample)],
verbose=TRUE)


###################################################
### code chunk number 23: NMDSSelectGates
###################################################
# NMDS plot with selected gates
nmds(Normalized_mean,group=groups,main="NMDS plot of 
normalized cell numbers",abiotic=Abiotic_data_sample[,2:31],verbose=TRUE)


###################################################
### code chunk number 24: NMDSAbioticChanged
###################################################
# NMDS plot 
nmds(Normalized_mean,group=groups,main="NMDS plot of 
normalized cell numbers",legend_pos="topright",abiotic=Abiotic_data_sample[,-1],
p.max=0.01,col_abiotic="darkred",verbose=TRUE)


###################################################
### code chunk number 25: NMDSSample
###################################################
# Load datasets
data(Abiotic_data_sample)
# Show data
Abiotic_data_sample


###################################################
### code chunk number 26: NMDSPlotSample
###################################################
# Change row names
rownames(Normalized_mean)<-Abiotic_data_sample[,1]
# NMDS plot with sample names
nmds(Normalized_mean,group=groups,main="NMDS plot of 
normalized cell numbers",legend_pos="topright",abiotic=Abiotic_data_sample[,-1],
p.max=0.01,col_abiotic="darkred",verbose=TRUE)


###################################################
### code chunk number 27: Correlation
###################################################
# Load dataset
data(Corr_data_sample)
# Show correlation values
Corr_data_sample[,-1]


###################################################
### code chunk number 28: CorrelationPlot
###################################################
# Run correlation analysis
correlation(Corr_data_sample[,-1])


###################################################
### code chunk number 29: CorrelationTopo
###################################################
# Plot with different parameters as described
correlation(Corr_data_sample[,-1],colkey=topo.colors(16),dendrogram="column")


###################################################
### code chunk number 30: CorrelationCM
###################################################
# Plot
correlation(Corr_data_sample[,-1],colkey=cm.colors(15),dendrogram="row")


###################################################
### code chunk number 31: CorrelationHeat
###################################################
# Plot
correlation(Corr_data_sample[,-1],colkey=heat.colors(11),dendrogram="none",
main="Correlation of Corr_data_sample")


###################################################
### code chunk number 32: CorrelationOrder
###################################################
# Plot
correlation(Corr_data_sample[,-1],Rowv=FALSE,Colv=FALSE,dendrogram="none")


###################################################
### code chunk number 33: CorrelationSample
###################################################
# Load dataset
data(Corr_data_sample)
# Show data
Corr_data_sample


###################################################
### code chunk number 34: CorrelationSelect
###################################################
# Select columns manually using concatenation
correlation(Corr_data_sample[,c(2:11,32:34,42:ncol(Corr_data_sample))])


###################################################
### code chunk number 35: CorrelationSelectNames
###################################################
# Select columns manually using concatenation of their names
correlation(Corr_data_sample[,c("G1","G2","G3","G4","G5","G6","G7",
"G8","G9","G10","delta_B1","delta_B2","delta_B3","pO2","pH","redox_pot")])


###################################################
### code chunk number 36: SaveList
###################################################
# Save list of results in new variable
cor<-correlation(Corr_data_sample[,-1],verbose=TRUE)


###################################################
### code chunk number 37: ShowEstPval
###################################################
# Show estimates
cor["est"]
# Show p-values
cor["pvals"]


###################################################
### code chunk number 38: WriteEst (eval = FALSE)
###################################################
## # Write a new file containing the estimates
## write.table(cor["est"],file="estimates.txt",row.names=TRUE,
## quote=FALSE,sep="\t")


