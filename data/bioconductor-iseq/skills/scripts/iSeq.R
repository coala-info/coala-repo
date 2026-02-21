# Code example from 'iSeq' vignette. See references/ for full tutorial.

### R code from vignette source 'iSeq.Rnw'

###################################################
### code chunk number 1: iSeq.Rnw:88-91
###################################################
library(iSeq)
data(nrsf)
names(nrsf)


###################################################
### code chunk number 2: iSeq.Rnw:96-100
###################################################
chip = rbind(nrsf$chipFC1592,nrsf$chipFC1862,nrsf$chipFC2002)
mock = rbind(nrsf$mockFC1592,nrsf$mockFC1862,nrsf$mockFC2002)
print(chip[1:2,])
print(mock[1:2,])


###################################################
### code chunk number 3: iSeq.Rnw:107-111
###################################################
chip[,2] = chip[,2]+12
mock[,2] = mock[,2]+12
print(chip[1:2,])
print(mock[1:2,])


###################################################
### code chunk number 4: iSeq.Rnw:128-130
###################################################
tagct = mergetag(chip=chip,control=mock,maxlen=80,minlen=10,ntagcut=10)
print(tagct[1:3,])


###################################################
### code chunk number 5: iSeq.Rnw:144-149
###################################################
tagct22 = tagct[tagct[,1]=="chr22",]  #chr22 data 
reg0 = peakreg(chrpos=tagct22[,1:3],count=(tagct22[,5:6]-tagct22[,7:8]),
               pp=(tagct22[,4]>10),cutoff=0,method="ppcut",maxgap=200)
print(dim(reg0)) 
print(reg0[1:3,]) # each row contain the information for an enriched region


###################################################
### code chunk number 6: iSeq.Rnw:158-160
###################################################
reg0 = reg0[order(reg0$sym,reg0$ct12,decreasing = TRUE),]
print(reg0[1:5,]) # Top five regions


###################################################
### code chunk number 7: iSeq.Rnw:169-172
###################################################
set.seed(777)
res1 = iSeq1(Y=tagct22[,1:4],gap=200,burnin=200,sampling=1000,ctcut=0.95,
     a0=1,b0=1,a1=5,b1=1,k0=3,mink=0,maxk=10,normsd=0.1,verbose=FALSE)


###################################################
### code chunk number 8: iSeq.Rnw:182-187
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
hist(res1$pp)
plot(res1$kappa, pch=".", xlab="Iterations", ylab="kappa")
plot(res1$lambda0, pch=".", xlab="Iterations", ylab="lambda0")
plot(res1$lambda1, pch=".", xlab="Iterations", ylab="lambda1")


###################################################
### code chunk number 9: iSeq.Rnw:201-205
###################################################
reg1 = peakreg(chrpos=tagct22[,1:3],count=(tagct22[,5:6]-tagct22[,7:8]),pp=res1$pp,
     cutoff=0.5,method="ppcut",maxgap=200)
print(dim(reg1))
print(reg1[1:3,])


###################################################
### code chunk number 10: iSeq.Rnw:211-216
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
for(i in 1:4){
  ID = (reg1[i,4]):(reg1[i,5])
  plotreg(tagct22[ID,2:3],tagct22[ID,5:6],tagct22[ID,7:8],peak=reg1[i,6])
}


###################################################
### code chunk number 11: iSeq.Rnw:223-228
###################################################
reg2 = peakreg(tagct22[,1:3],tagct22[,5:6]-tagct22[,7:8],res1$pp,0.05,
     method="fdrcut",maxgap=200)
print(dim(reg2))
print(reg2[1:3,])



###################################################
### code chunk number 12: iSeq.Rnw:235-236
###################################################
bed = data.frame(chr=reg2[,1],gstart=reg2[,6]-100,gend=reg2[,6]+100)


###################################################
### code chunk number 13: iSeq.Rnw:252-254
###################################################
res2 = iSeq2(Y=tagct22[,1:4],gap=200, burnin=100,sampling=500,winsize=2,
     ctcut=0.95,a0=1,b0=1,a1=5,b1=1,k=1.0,verbose=FALSE)


###################################################
### code chunk number 14: iSeq.Rnw:261-265
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
hist(res2$pp)
plot(res2$lambda0, pch=".", xlab="Iterations", ylab="lambda0")
plot(res2$lambda1, pch=".", xlab="Iterations", ylab="lambda1")


###################################################
### code chunk number 15: iSeq.Rnw:270-273
###################################################
reg2 = peakreg(tagct22[,1:3],tagct22[,5:6],res2$pp,0.5,method="ppcut",maxgap=200)
print(dim(reg2))
print(reg2[1:3,])


###################################################
### code chunk number 16: iSeq.Rnw:279-284
###################################################
par(mfrow=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
for(i in 1:4){
  ID = (reg2[i,4]):(reg2[i,5])
  plotreg(tagct22[ID,2:3],tagct22[ID,5:6],tagct22[ID,7:8],peak=reg2[i,6])
}


###################################################
### code chunk number 17: iSeq.Rnw:292-298
###################################################
tagctY = tagct[tagct[,1]=="chrY",]
print(table(tagctY[,4]))
res1 = iSeq1(Y=tagctY[,1:4],gap=200,burnin=1000,sampling=5000,ctcut=0.95,
     a0=1,b0=1,a1=5,b1=1,k0=3,mink=0,maxk=10,normsd=0.5,verbose=FALSE)
res2 = iSeq2(Y=tagctY[,1:4],gap=200, burnin=1000,sampling=5000,winsize=2,ctcut=0.95,
  a0=1,b0=1,a1=5,b1=1,k=3.0,verbose=FALSE)


###################################################
### code chunk number 18: iSeq.Rnw:302-307
###################################################
par(mfcol=c(2,2), mar=c(4.1, 4.1, 2.0, 1.0))
hist(res1$pp)
plot(res1$lambda1, pch=".", xlab="Iterations", ylab="lambda1")
hist(res2$pp)
plot(res2$lambda1, pch=".", xlab="Iterations", ylab="lambda1")


###################################################
### code chunk number 19: iSeq.Rnw:360-361
###################################################
sessionInfo()


