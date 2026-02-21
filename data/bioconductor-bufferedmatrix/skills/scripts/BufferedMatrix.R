# Code example from 'BufferedMatrix' vignette. See references/ for full tutorial.

### R code from vignette source 'BufferedMatrix.Rnw'

###################################################
### code chunk number 1: BufferedMatrix.Rnw:40-41
###################################################
library(BufferedMatrix)


###################################################
### code chunk number 2: BufferedMatrix.Rnw:55-56
###################################################
X <- createBufferedMatrix(10000)


###################################################
### code chunk number 3: BufferedMatrix.Rnw:59-60
###################################################
X


###################################################
### code chunk number 4: BufferedMatrix.Rnw:63-66
###################################################
AddColumn(X)
AddColumn(X)
X


###################################################
### code chunk number 5: BufferedMatrix.Rnw:70-71
###################################################
X <- createBufferedMatrix(10000,2)


###################################################
### code chunk number 6: BufferedMatrix.Rnw:94-95
###################################################
RowMode(X)


###################################################
### code chunk number 7: BufferedMatrix.Rnw:98-99
###################################################
ColMode(X)


###################################################
### code chunk number 8: BufferedMatrix.Rnw:104-105
###################################################
X <- createBufferedMatrix(10000,5,bufferrows=500,buffercols=1)


###################################################
### code chunk number 9: BufferedMatrix.Rnw:108-109
###################################################
set.buffer.dim(X,100,2)


###################################################
### code chunk number 10: BufferedMatrix.Rnw:115-125
###################################################
memory.usage(X)
disk.usage(X)
nrow(X)
ncol(X)
dim(X)
buffer.dim(X)
prefix(X)
directory(X)
is.RowMode(X)
is.ColMode(X)


###################################################
### code chunk number 11: BufferedMatrix.Rnw:129-133
###################################################
ReadOnlyMode(X)
is.ReadOnlyMode(X)
ReadOnlyMode(X)
is.ReadOnlyMode(X)


###################################################
### code chunk number 12: BufferedMatrix.Rnw:150-157
###################################################
X <- createBufferedMatrix(20,2)
X[1:20,] <- 1:40
B <- X[1:5,]
B
B[1:2,] <- B[1:2,]^2
B
X[1:5,]


###################################################
### code chunk number 13: BufferedMatrix.Rnw:161-163
###################################################
X[1:5,] <- B
X[1:5,]


###################################################
### code chunk number 14: BufferedMatrix.Rnw:167-171
###################################################
rownames(X)
colnames(X)
rownames(X) <- letters[1:20]
colnames(X) <- month.abb[1:2]


###################################################
### code chunk number 15: BufferedMatrix.Rnw:174-176
###################################################
X[c("a","b"),"Jan"]
X["t",2] <- 0


###################################################
### code chunk number 16: BufferedMatrix.Rnw:180-181
###################################################
X[rep(c(TRUE,FALSE),10),1]


###################################################
### code chunk number 17: BufferedMatrix.Rnw:193-195
###################################################
Y <- subBufferedMatrix(X,1:5,1:2)
Y


###################################################
### code chunk number 18: BufferedMatrix.Rnw:202-210
###################################################
X <- createBufferedMatrix(10,3)
X[1:10,] <- (1:30)^2
Max(X)
Min(X)
mean(X)
Sum(X)
Var(X)
Sd(X)


###################################################
### code chunk number 19: BufferedMatrix.Rnw:214-226
###################################################
rowMeans(X)
colMeans(X)
rowSums(X)
colSums(X)
rowVars(X)
colVars(X)
rowSd(X)
colSd(X)
rowMax(X)
colMax(X)
rowMin(X)
colMin(X)


###################################################
### code chunk number 20: BufferedMatrix.Rnw:232-236
###################################################
sum.cube.root <- function(x){
	sum(x^(1/3))
}
colApply(X,sum.cube.root)


###################################################
### code chunk number 21: BufferedMatrix.Rnw:239-243
###################################################
sum.arbitrary.power <- function(x,power=2){
	sum(x^power)
}
rowApply(X,sum.arbitrary.power,power=3)


###################################################
### code chunk number 22: BufferedMatrix.Rnw:249-251
###################################################
Y <- colApply(X,sort,decreasing=TRUE)
is(Y,"BufferedMatrix")


###################################################
### code chunk number 23: BufferedMatrix.Rnw:260-264
###################################################
exp(X)
log(X)
sqrt(X)
pow(X,2.0)


###################################################
### code chunk number 24: BufferedMatrix.Rnw:268-272
###################################################
my.function <- function(x){
  x^2 +3*abs(x) - 9
}
ewApply(X, my.function)


###################################################
### code chunk number 25: BufferedMatrix.Rnw:280-282
###################################################
Z <- as(X,"matrix")
class(Z)


###################################################
### code chunk number 26: BufferedMatrix.Rnw:286-288
###################################################
A <- as(Z,"BufferedMatrix")
class(A)


###################################################
### code chunk number 27: BufferedMatrix.Rnw:294-309
###################################################
X <- createBufferedMatrix(50,10)
X[1:50,] <- 1:500
Y <- as(X,"matrix")

my.function <- function(a.matrix){
  a.matrix[,1:10] <- a.matrix[,sample(1:10,10)] 
}

X[1:5,]
my.function(X)
X[1:5,]

Y[1:5,]
my.function(Y)
Y[1:5,]


###################################################
### code chunk number 28: BufferedMatrix.Rnw:316-327
###################################################
X <- createBufferedMatrix(50,10)
X[1:50,] <- 1:500
my.function <- function(my.bufmat){
  internal.bufmat <- duplicate(my.bufmat)
  internal.bufmat[,1:10] <- internal.bufmat[,sample(1:10,10)] 
}


X[1:5,]
my.function(X)
X[1:5,]


