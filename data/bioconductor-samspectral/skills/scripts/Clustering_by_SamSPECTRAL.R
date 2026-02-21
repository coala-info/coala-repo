# Code example from 'Clustering_by_SamSPECTRAL' vignette. See references/ for full tutorial.

### R code from vignette source 'Clustering_by_SamSPECTRAL.Rnw'

###################################################
### code chunk number 1: f_example
###################################################
library(SamSPECTRAL)
set.seed(4)
data(small_data)
full <- small

L <- SamSPECTRAL(full,dimension=c(1,2,3),normal.sigma = 200,
                 separation.factor = 0.39)   
plot(full, pch='.', col= L)


###################################################
### code chunk number 2: f_example
###################################################
## Computing the frequency:
plot(full, pch='.', col= L)
frequency <- c()	
minimum.frequency <- 0.01	
## components smaller than this threshould
## will not be aprear in the legend statistics.
freq.large <- c()	
labels <- as.character(unique(L))
for(label in labels){
  if(!is.na(label)){
    frequency[label] <- length(which(L==label))/length(L)
    if(frequency[label] > minimum.frequency)
      freq.large[label] <- frequency[label]
  }
}	
print(frequency)	

## Adding legend 
legend(x="topleft",as.character(round(freq.large,3)),
       col=names(freq.large),pch=19)


###################################################
### code chunk number 3: ReadFiles2
###################################################

data(small_data)
full <- small


###################################################
### code chunk number 4: ReadFiles2
###################################################
run.live <- FALSE


###################################################
### code chunk number 5: ReadFiles2
###################################################
## Parameters:
m <- 3000; 
community.weakness.threshold <-1; precision <- 6; 
maximum.number.of.clusters <- 30    


###################################################
### code chunk number 6: ReadFiles2
###################################################
for (i.column in 1:dim(full)[2]){#For all columns
  ith.col <- full[,i.column]
  full[,i.column] <- (ith.col-min(ith.col)) /(max(ith.col) - min(ith.col) )  
  ##^ This is the scaled column.
}#End for (i.column.
## Therefore, 	
space.length <- 1


###################################################
### code chunk number 7: f_sampling
###################################################
## Sample the data and build the communities 
society <- 
    Building_Communities(full,m, space.length, community.weakness.threshold)
plot(full[society$representatives, ], pch=20)


###################################################
### code chunk number 8: f_small
###################################################
normal.sigma <- 10
## Compute conductance between communities
conductance <- Conductance_Calculation(full, normal.sigma, space.length, 
                                       society, precision)
## Compute the eigenspace:
if (run.live){
  clust_result.10 <- 
      Civilized_Spectral_Clustering(full, maximum.number.of.clusters, 
                                    society, conductance,stabilizer=1)    
  eigen.values.10 <- clust_result.10@eigen.space$values
} else 
  data("eigen.values.10")		
plot(eigen.values.10[1:50])


###################################################
### code chunk number 9: f_large
###################################################
normal.sigma <- 1000
## Compute conductance between communities
conductance <- Conductance_Calculation(full, normal.sigma, space.length, society, precision)
## Compute the eigenspace:
if (run.live){
  clust_result.1000 <- 
      Civilized_Spectral_Clustering(full, maximum.number.of.clusters, 
                                    society, conductance,stabilizer=1)    
  eigen.values.1000 <- clust_result.1000@eigen.space$values
} else 
  data("eigen.values.1000")		
plot(eigen.values.1000[1:50])


###################################################
### code chunk number 10: f_appropriate
###################################################
normal.sigma <- 250
## Compute conductance between communities
conductance <- Conductance_Calculation(full, normal.sigma, space.length, 
                                       society, precision)
## Compute the eigenspace:
clust_result.250 <- 
    Civilized_Spectral_Clustering(full, maximum.number.of.clusters, 
                                  society, conductance,stabilizer=1)    
eigen.values.250 <- clust_result.250@eigen.space$values
plot(eigen.values.250[1:50])


###################################################
### code chunk number 11: f_lines
###################################################
## Fitting two lines:
clust_result.250 <- 
    Civilized_Spectral_Clustering(full, maximum.number.of.clusters, 
                                  society, conductance,stabilizer=1,
                                  eigenvalues.num=50)    


###################################################
### code chunk number 12: f_line
###################################################
## Fitting one line:
clust_result.250 <- 
    Civilized_Spectral_Clustering(full, maximum.number.of.clusters, 
                                  society, conductance,stabilizer=1,
                                  eigenvalues.num=50, one.line=TRUE)


###################################################
### code chunk number 13: f_sep1
###################################################
## Extracting labels:
labels.for_num.of.clusters <- clust_result.250@labels.for_num.of.clusters
number.of.clusters <- clust_result.250@number.of.clusters
L33 <- labels.for_num.of.clusters[[number.of.clusters]]
## Setting septation factor:
separation.factor <- 0.1
## post-processing:
component.of <- 
    Connecting(full, society, conductance, number.of.clusters, 
               labels.for_num.of.clusters, separation.factor)$label
## ploting:
plot(full, pch='.', col= component.of)


###################################################
### code chunk number 14: f_sep2
###################################################
## Setting septation factor:
separation.factor <- 0.5
## post-possesing:
component.of <- 
    Connecting(full, society, conductance, number.of.clusters, 
               labels.for_num.of.clusters, separation.factor)$label
## ploting:
plot(full, pch='.', col= component.of)


