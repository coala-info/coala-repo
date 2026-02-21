# Code example from 'timecourse' vignette. See references/ for full tutorial.

### R code from vignette source 'timecourse.Rnw'

###################################################
### code chunk number 1: timecourse.Rnw:72-73
###################################################
library(timecourse) # load timecourse library


###################################################
### code chunk number 2: timecourse.Rnw:118-122
###################################################
data(fruitfly)
dim(fruitfly)
colnames(fruitfly)
gnames <- rownames(fruitfly)


###################################################
### code chunk number 3: timecourse.Rnw:129-132
###################################################
assay <- rep(c("A", "B", "C"), each=12)
time.grp <- rep(c(1:12), 3)
size <- rep(3, 2000)


###################################################
### code chunk number 4: timecourse.Rnw:136-138
###################################################
out1 <- mb.long(fruitfly, times=12, reps=size)
out2 <- mb.long(fruitfly, times=12, reps=size, rep.grp=assay, time.grp=time.grp)


###################################################
### code chunk number 5: timecourse.Rnw:151-183
###################################################
SS <- matrix(c( 1e-02, -8e-04, -0.003,  7e-03,  2e-03,
               -8e-04,  2e-02,  0.002, -4e-04, -1e-03,
               -3e-03,  2e-03,  0.030, -5e-03, -9e-03,
                7e-03, -4e-04, -0.005,  2e-02,  8e-04,
                2e-03, -1e-03, -0.009,  8e-04,  7e-02), ncol=5)

sim.Sigma <- function()
{
    S <- matrix(rep(0,25),ncol=5)
    x <- mvrnorm(n=10, mu=rep(0,5), Sigma=10*SS)
    for(i in 1:10)
       S <- S+crossprod(t(x[i,]))

       solve(S)

}


sim.data2 <- function(x, indx=1)
{
    mu <- rep(runif(1,8,x[1]),5)
    if(indx==1)
       res <- c(as.numeric(t(mvrnorm(n=3, mu=mu+rnorm(5,sd=5), Sigma=sim.Sigma()))),
                  as.numeric(t(mvrnorm(n=3, mu=mu+rnorm(5,sd=3.2), Sigma=sim.Sigma()))))

     if(indx==0) res <- as.numeric(t(mvrnorm(n=6, mu=mu+rnorm(5,sd=3), Sigma=sim.Sigma())))
       res 
}

M2 <- matrix(rep(14,1000*30), ncol=30)
M2[1:20,] <- t(apply(M2[1:20,],1,sim.data2))
M2[21:1000,] <- t(apply(M2[21:1000,],1,sim.data2, 0)) 


###################################################
### code chunk number 6: timecourse.Rnw:193-198
###################################################
trt <- rep(c("wt","mt"),each=15)
assay <- rep(rep(c("rep1","rep2","rep3"),each=5),2)
size <- matrix(3, nrow=1000, ncol=2)
MB.paired <- mb.long(M2, method="paired", times=5, reps=size, condition.grp=trt, rep.grp=assay)
genenames <- as.character(1:1000)


###################################################
### code chunk number 7: timecourse.Rnw:203-204
###################################################
MB.2D <- mb.long(M2, method="2", times=5, reps=size, condition.grp=trt, rep.grp=assay)


###################################################
### code chunk number 8: timecourse.Rnw:215-230
###################################################
sim.data <- function(x, indx=1)
{
   mu <- rep(runif(1,8,x[1]),5)
   if(indx==1)
     res <- c(as.numeric(t(mvrnorm(n=3, mu=mu+rnorm(5,sd=5), Sigma=sim.Sigma()))),
             as.numeric(t(mvrnorm(n=4, mu=mu+rnorm(5,sd=3.2), Sigma=sim.Sigma()))),
             as.numeric(t(mvrnorm(n=2, mu=mu+rnorm(5,sd=2), Sigma=sim.Sigma()))))

   if(indx==0) res <- as.numeric(t(mvrnorm(n=9, mu=mu+rnorm(5,sd=3), Sigma=sim.Sigma())))
   res
}

M <- matrix(rep(14,500*45), ncol=45)
M[1:10,] <- t(apply(M[1:10,],1,sim.data))
M[11:500,] <- t(apply(M[11:500,],1,sim.data, 0))


###################################################
### code chunk number 9: timecourse.Rnw:235-242
###################################################
assay <- rep(c("1.2.04","2.4.04","3.5.04","5.21.04","7.17.04","9.10.04","12.1.04","1.2.05","4.1.05"),each=5)
trt <- c(rep(c("wildtype","mutant1"),each=15),rep("mutant1",5), rep("mutant2", 10))

# Caution: since "mutant1" < "mutant2" < "wildtype", the sample sizes should be in the order of 4,2,3,
# but NOT 3,4,2.
size <- matrix(c(4,2,3), byrow=TRUE, nrow=500, ncol=3)
MB.multi <- mb.MANOVA(M, times=5, D=3, size=size, rep.grp=assay, condition.grp=trt)


###################################################
### code chunk number 10: timecourse.Rnw:263-267
###################################################
fruitfly[6, 13:24] <- NA  # The 6th gene has 1 missing replicate
size <- rep(3, 2000)
size[6] <- 2
MB.missing <- mb.long(fruitfly, times=12, reps=size, HotellingT2.only=FALSE)


###################################################
### code chunk number 11: timecourse.Rnw:296-298
###################################################
## plots the no. 1 gene
plotProfile(out2, type="b", gnames=gnames, legloc=c(2,15), pch=c("A","B","C"), xlab="Hour")


###################################################
### code chunk number 12: timecourse.Rnw:306-308
###################################################
## plots the no. 100 gene
plotProfile(out2, type="b", gnames=gnames, pch=c("A","B","C"), xlab="Hour", ranking=100)


###################################################
### code chunk number 13: timecourse.Rnw:315-318
###################################################
## plots the gene 141404_at
plotProfile(out2, type="b", gnames=gnames, pch=c("A","B","C"), xlab="Hour", gid="141404_at")



###################################################
### code chunk number 14: timecourse.Rnw:326-327
###################################################
plotProfile(MB.paired,type="b", gnames=genenames)


###################################################
### code chunk number 15: timecourse.Rnw:335-336
###################################################
plotProfile(MB.2D,type="b", gnames=genenames)


###################################################
### code chunk number 16: timecourse.Rnw:343-344
###################################################
plotProfile(MB.multi, stats="MB", type="b")


###################################################
### code chunk number 17: timecourse.Rnw:351-353
###################################################
plotProfile(MB.missing, stats="MB", type="b", gid="141205_at", 
gnames=gnames,pch=c("A","B","C"))


