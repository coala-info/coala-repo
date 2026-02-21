# Code example from 'rHVDM' vignette. See references/ for full tutorial.

### R code from vignette source 'rHVDM.Rnw'

###################################################
### code chunk number 1: foo
###################################################
options(keep.source = TRUE, width = 60)
foo <- packageDescription("rHVDM")


###################################################
### code chunk number 2: loading
###################################################
library(rHVDM) ##the three other packages also get loaded


###################################################
### code chunk number 3: loadingdata
###################################################
data(HVDMexample)


###################################################
### code chunk number 4: quickanddirtymeaserrors
###################################################
anothereset<-assayDataElementReplace(fiveGyMAS5,'se.exprs',5 + exprs(fiveGyMAS5)*0.1)


###################################################
### code chunk number 5: calculateerrors
###################################################
anothereset<-estimerrors(eset=fiveGyMAS5,plattid="affy_HGU133A")


###################################################
### code chunk number 6: deletedirtyset
###################################################
rm(anothereset)


###################################################
### code chunk number 7: trypdatacommand
###################################################
pData(fiveGyMAS5)


###################################################
### code chunk number 8: HVDMcheckcommand
###################################################
HVDMcheck(fiveGyMAS5)


###################################################
### code chunk number 9: createnewpdata
###################################################
norepl3<-pData(fiveGyMAS5)
norepl3<-norepl3[norepl3$replicate!=3,]


###################################################
### code chunk number 10: checknewpdata
###################################################
HVDMcheck(fiveGyMAS5,pdata=norepl3)


###################################################
### code chunk number 11: garbagecollection
###################################################
rm(norepl3)


###################################################
### code chunk number 12: training
###################################################
tHVDMp53<-training(eset=fiveGyMAS5,genes=p53traingenes,
				degrate=0.8,actname="p53")


###################################################
### code chunk number 13: trainigunanchored
###################################################
tHVDMp53na<-training(eset=fiveGyMAS5,genes=p53traingenes,actname="p53")


###################################################
### code chunk number 14: trainingbadgene
###################################################
tHVDMp53b<-training(eset=fiveGyMAS5,genes=c(p53traingenes,"202688_at"),
				degrate=0.8,actname="p53")


###################################################
### code chunk number 15: garbagecollectionagain
###################################################
rm(tHVDMp53na,tHVDMp53b)


###################################################
### code chunk number 16: agoodgene
###################################################
gHVDMCD38<-fitgene(eset=fiveGyMAS5,gene="205692_s_at",tHVDM=tHVDMp53)


###################################################
### code chunk number 17: thesamegene
###################################################
gHVDMCD38<-fitgene(eset=fiveGyMAS5,gene="205692_s_at",tHVDM=tHVDMp53,
				firstguess=gHVDMCD38)


###################################################
### code chunk number 18: badgene
###################################################
gHVDMtnf10l<-fitgene(eset=fiveGyMAS5,gene="202688_at",tHVDM=tHVDMp53)


###################################################
### code chunk number 19: screenall
###################################################
sHVDMp53<-screening(eset=fiveGyMAS5,genes=genestoscreen[1:5],HVDM=tHVDMp53)


###################################################
### code chunk number 20: targetlist
###################################################
p53targets<-sHVDMp53$results[sHVDMp53$results$class1,]


###################################################
### code chunk number 21: newscreen
###################################################
sHVDMp53<-screening(HVDM=sHVDMp53,cl1modelscorehigh=80.0,
			cl1zscorelow=3.5)


###################################################
### code chunk number 22: extractavalue
###################################################
tHVDMp53$dm$signal[paste("202284_s_at","5Gy","2",6,sep=".")]


###################################################
### code chunk number 23: extractanactivitytimepoint
###################################################
tHVDMp53$par$parameters[paste("p53","5Gy","2",6,sep=".")]


###################################################
### code chunk number 24: extractaparameter
###################################################
tHVDMp53$par$parameters[paste("203409_at","Dj",sep=".")]


###################################################
### code chunk number 25: knownvalues
###################################################
tHVDMp53$distribute$known


###################################################
### code chunk number 26: freeparams
###################################################
tHVDMp53$par$parameters[tHVDMp53$distribute$free]


###################################################
### code chunk number 27: scoreobject
###################################################
tHVDMp53$scores$withintc[[1]]$score


###################################################
### code chunk number 28: differentialoperator
###################################################
tHVDMp53$tc[[1]]$A


###################################################
### code chunk number 29: confidenceintervalsfortraining
###################################################
vcov<-solve(tHVDMp53$results$hessian)
sdev<-1.96*diag(vcov)^0.5 #compute half confidence interval in 
			#transformed domain
work<-tHVDMp53 #create a copy of the example to work with
central<-.exportfree(work) #extract transformed, fitted values
nams<-names(central) #extract vector of labels
upperbounds<-
  (.importfree(HVDM=work,x=central[nams]+sdev[nams]))$par$parameters
  
  #.importfree() imports the transformed values for the upper bound
  #into the "work" object and performs the inverse transform (here, an 
  #exponential) upon import, a new HVDM object is returned by this 
  #command. The $par$parameters suffix extracts the parameter vector. 
  #Note that the upperbounds vector will contain all parameter values, 
  #ie not only those fitted in LM.
  
lowerbounds<-
  (.importfree(HVDM=work,x=central[nams]-sdev[nams]))$par$parameters
  
  #a similar command is used to extract the lower bounds.
  
rm(work) #get rid of this no longer needed object


