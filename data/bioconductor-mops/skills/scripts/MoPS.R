# Code example from 'MoPS' vignette. See references/ for full tutorial.

### R code from vignette source 'MoPS.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: MoPS.Rnw:46-47
###################################################
library(MoPS)


###################################################
### code chunk number 2: MoPS.Rnw:55-57
###################################################
y = 2*sin(seq(0,6*pi,length.out=50))
y.noise = y+rnorm(50,sd=1)


###################################################
### code chunk number 3: MoPS.Rnw:60-61
###################################################
res = fit.periodic(y.noise)


###################################################
### code chunk number 4: MoPS.Rnw:64-65
###################################################
predicted = predictTimecourses(res)


###################################################
### code chunk number 5: MoPS.Rnw:68-71
###################################################
plot(y.noise,type="l",col="red")
points(y,type="l")
points(predicted,type="l",lwd=2.5,col="limegreen")


###################################################
### code chunk number 6: MoPS.Rnw:83-85
###################################################
data(basic)
dim(basic)


###################################################
### code chunk number 7: MoPS.Rnw:88-91
###################################################
par(mfrow=c(2,1))
plot(basic[1,],type="l",main="time course No. 1",xlab="",ylab="[arb. units]")
plot(basic[10,],type="l",main="time course No. 2",xlab="",ylab="[arb. units]")


###################################################
### code chunk number 8: MoPS.Rnw:100-102
###################################################
res = fit.periodic(basic)
result.as.dataframe(res)


###################################################
### code chunk number 9: MoPS.Rnw:108-115
###################################################
fitted.mat = predictTimecourses(res)
dim(fitted.mat)
par(mfrow=c(2,1))
plot(basic[1,],type="l",main="time course No. 1",xlab="",ylab="[arb. units]")
points(fitted.mat[1,],type="l",col="limegreen",lwd=2)
plot(basic[10,],type="l",main="time course No. 2",xlab="",ylab="[arb. units]")
points(fitted.mat[10,],type="l",col="limegreen",lwd=2)


###################################################
### code chunk number 10: MoPS.Rnw:188-189
###################################################
res$fitted[[1]] 


###################################################
### code chunk number 11: MoPS.Rnw:192-193
###################################################
res[2:6]


###################################################
### code chunk number 12: MoPS.Rnw:201-202
###################################################
head(result.as.dataframe(res))


###################################################
### code chunk number 13: MoPS.Rnw:221-223
###################################################
data(ccycle)
timepoints = seq(5,205,5)


###################################################
### code chunk number 14: MoPS.Rnw:247-253
###################################################
phi = seq(5,80,5)
lambda = seq(40,80,5)
sigma = seq(4,8,1)
res = fit.periodic(ccycle,timepoints=timepoints,phi=phi,lambda=lambda,sigma=sigma)
res.df = result.as.dataframe(res)
head(res.df)


###################################################
### code chunk number 15: MoPS.Rnw:260-262
###################################################
time.courses = predictTimecourses(res)
dim(time.courses)


###################################################
### code chunk number 16: MoPS.Rnw:266-272
###################################################
id = "YPL133C"
t = time.courses[id,]

plot(timepoints,t,type="l",col="limegreen",lwd=2.5,main=id,
		xlab="time [min]",ylab="expression",ylim=c(220,580))
points(timepoints,ccycle[id,],type="l",col="black")


###################################################
### code chunk number 17: MoPS.Rnw:280-284
###################################################
lambda.global = median(res.df$lambda[res.df$score > 0])
lambda.global
sigma.global = median(res.df$sigma[res.df$score > 0])
sigma.global


###################################################
### code chunk number 18: MoPS.Rnw:304-306
###################################################
periodic.ids = res.df$ID[res.df$score > 0]
ccycle = ccycle[periodic.ids,]


###################################################
### code chunk number 19: MoPS.Rnw:310-317
###################################################
phi = seq(5,80,2.5)
res.shape = fit.periodic(ccycle,timepoints=timepoints,
	phi=phi,
	lambda=lambda.global,
	sigma=sigma.global,
	psi=2)
time.courses.shape = predictTimecourses(res.shape)


###################################################
### code chunk number 20: MoPS.Rnw:324-332
###################################################
t = time.courses.shape[id,]
predicted.phase = phi[which(t == max(t))]
plot(timepoints,ccycle[id,],type="l",lwd=2,ylim=c(220,580),
		xlab="time [min]",ylab="expression",
		main=paste(id,"| peak at",predicted.phase,"min"))
new.timepoints = seq(5,205,2.5)  
points(new.timepoints,t,type="l",col="limegreen",lwd=3)
abline(v=predicted.phase,col="limegreen",lwd=3)


