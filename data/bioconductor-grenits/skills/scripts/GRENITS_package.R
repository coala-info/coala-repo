# Code example from 'GRENITS_package' vignette. See references/ for full tutorial.

### R code from vignette source 'GRENITS_package.Rnw'

###################################################
### code chunk number 1: GRENITS_package.Rnw:27-28
###################################################
library(GRENITS)


###################################################
### code chunk number 2: GRENITS_package.Rnw:35-37
###################################################
data(Athaliana_ODE)
dim(Athaliana_ODE)


###################################################
### code chunk number 3: GRENITS_package.Rnw:42-47
###################################################
# Load A. thaliana circadian clock ODE generated data
plot.ts( t(Athaliana_ODE), plot.type = "single", col = 1:5,  xlim = c(0,65),
	main = "Circadian Clock Network \n ODE simulated data",
	 xlab = "Time (h)",  ylab = "Expression")
legend("topright", rownames(Athaliana_ODE), lty = 1, col = 1:5)


###################################################
### code chunk number 4: GRENITS_package.Rnw:54-56
###################################################
output.folder <- paste(tempdir(), "/Example_LinearNet", sep="")
LinearNet(output.folder, Athaliana_ODE)


###################################################
### code chunk number 5: GRENITS_package.Rnw:62-64
###################################################
# Analyse raw results, place analysis plots and files in output.folder
analyse.output(output.folder)


###################################################
### code chunk number 6: GRENITS_package.Rnw:67-68
###################################################
dir(output.folder)


###################################################
### code chunk number 7: GRENITS_package.Rnw:78-85
###################################################
chain1 <- read.chain(output.folder,1)
chain2 <- read.chain(output.folder,2)
gamma1 <- colMeans(chain1$gamma)
gamma2 <- colMeans(chain2$gamma)
plot(x = gamma1, y = gamma2, xlab = "chain1", ylab = "chain2", 
main = "Convergence plot for link probabilities", xlim = c(0,1), ylim = c(0,1), cex = 1.5, cex.lab = 1.6, cex.main = 1.6)
lines(c(0,1), c(0,1), col = "red")


###################################################
### code chunk number 8: GRENITS_package.Rnw:94-97
###################################################
prob.file <- paste(output.folder, "/NetworkProbability_Matrix.txt", sep = "")
prob.mat  <- read.table(prob.file)
print(prob.mat)


###################################################
### code chunk number 9: GRENITS_package.Rnw:102-104
###################################################
inferred.net <- 1*(prob.mat > 0.8)
print(inferred.net)


###################################################
### code chunk number 10: GRENITS_package.Rnw:112-125
###################################################
library(network)
inferred.net <- network(inferred.net)
par(mfrow = c(1,2), cex = 1.76, cex.lab = 1.3, cex.main = 1.4)
# Plot cut off
prob.vec <- sort(as.vector(as.matrix(prob.mat)), T)
# Remove self interaction (last 5 elements)
prob.vec <- prob.vec[4:0 - length(prob.vec)]
plot(x = prob.vec, y = 1:length(prob.vec), xlim = c(0,1), main = "Connections included vs threshold", 
xlab = "Probability threshold", ylab = "Connections included")
lines(c(0.8,0.8), c(0, 30), col = "red", lty = 2, lwd = 2)
# Plot Network
plot(inferred.net, label = network.vertex.names(inferred.net), main = "A. thaliana Inferred Network", 
mode = "circle", vertex.cex=7, arrowhead.cex = 2,vertex.col="green")


###################################################
### code chunk number 11: GRENITS_package.Rnw:131-135
###################################################
prob.list.file <- paste(output.folder, "/NetworkProbability_List.txt", sep = "")
prob.list      <- read.table(prob.list.file, header = T)
above.08       <- (prob.list[,3] > 0.8)
print(prob.list[above.08,])


