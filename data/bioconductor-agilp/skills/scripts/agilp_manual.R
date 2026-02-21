# Code example from 'agilp_manual' vignette. See references/ for full tutorial.

### R code from vignette source 'agilp_manual.Rnw'

###################################################
### code chunk number 1: agilp_manual.Rnw:27-28
###################################################
options(width=60)


###################################################
### code chunk number 2: agilp_manual.Rnw:36-37
###################################################
file.path(system.file(package="agilp"))


###################################################
### code chunk number 3: agilp_manual.Rnw:46-50
###################################################
library(agilp)
inputdir<-file.path(system.file(package="agilp"),"extdata","scanner/","", fsep = .Platform$file.sep)
outputdir<-file.path(system.file(package="agilp"),"output/", "", fsep = .Platform$file.sep)
AAProcess(input = inputdir, output = outputdir, s = 9)


###################################################
### code chunk number 4: agilp_manual.Rnw:54-56
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 5: agilp_manual.Rnw:65-69
###################################################
library(agilp) 
inputdir<-file.path(system.file(package="agilp"),"extdata","raw/","", fsep = .Platform$file.sep)
outputdir<-file.path(system.file(package="agilp"),"output/", "", fsep = .Platform$file.sep)
filenamex(input=inputdir,output=outputdir)


###################################################
### code chunk number 6: agilp_manual.Rnw:72-74
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 7: agilp_manual.Rnw:79-84
###################################################
library(agilp)
inputdir<-file.path(system.file(package="agilp"),"extdata","raw/","", fsep = .Platform$file.sep)
outputbase<-file.path(system.file(package="agilp"),"output", "testbase.txt", fsep = .Platform$file.sep)
template<-file.path(system.file(package="agilp"),"extdata","sample_template.txt", fsep = .Platform$file.sep)
Baseline(NORM="LOG",allfiles="TRUE",r=2,A=2,B=3,input=inputdir, baseout=outputbase, t = template)


###################################################
### code chunk number 8: agilp_manual.Rnw:88-89
###################################################
Baseline(NORM="FALSE",allfiles="FALSE",r=2,A=2,B=5,input=inputdir, baseout=outputbase, t = template)


###################################################
### code chunk number 9: agilp_manual.Rnw:93-95
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 10: agilp_manual.Rnw:100-106
###################################################
inputdir<-file.path(system.file(package="agilp"),"extdata","raw/","", fsep = .Platform$file.sep)
outputdir<-file.path(system.file(package="agilp"),"output/", "", fsep = .Platform$file.sep)
template<-file.path(system.file(package="agilp"),"extdata","sample_template.txt",
fsep = .Platform$file.sep)

Loader(input=inputdir,output=outputdir,t=template,f="TRUE",r=2,A=2,B=5)


###################################################
### code chunk number 11: agilp_manual.Rnw:110-112
###################################################
Loader(input=inputdir,output=outputdir,t=template,f="FALSE",r=2,A=2,B=5)
dim(dataout)


###################################################
### code chunk number 12: agilp_manual.Rnw:115-117
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 13: agilp_manual.Rnw:126-130
###################################################
inputdir<-file.path(system.file(package="agilp"),"extdata","raw/","", fsep = .Platform$file.sep)
outputdir<-file.path(system.file(package="agilp"),"output/", "", fsep = .Platform$file.sep)
baselinedir<-file.path(system.file(package="agilp"),"extdata","testbase.txt", fsep = .Platform$file.sep)
AALoess(input=inputdir, output=outputdir, baseline = baselinedir, LOG="TRUE") 


###################################################
### code chunk number 14: agilp_manual.Rnw:135-136
###################################################
AALoess(input=inputdir, output=outputdir, baseline = baselinedir, LOG="FALSE")


###################################################
### code chunk number 15: agilp_manual.Rnw:139-141
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 16: agilp_manual.Rnw:146-151
###################################################
inputdir<-file.path(system.file(package="agilp"),"extdata","raw/","", fsep = .Platform$file.sep)
outputdir<-file.path(system.file(package="agilp"),"output/", "", fsep = .Platform$file.sep)
annotation<-file.path(system.file(package="agilp"),"extdata","annotations_sample.txt", fsep = .Platform$file.sep)
IDswop(input=inputdir,output=outputdir,annotation=annotation,source_ID="ProbeID",
target_ID="EnsemblID", ERR=0.2)


###################################################
### code chunk number 17: agilp_manual.Rnw:155-157
###################################################
IDswop(input=inputdir,output=outputdir,annotation=annotation,source_ID="ProbeID",
target_ID="EnsemblID", ERR=1)


###################################################
### code chunk number 18: agilp_manual.Rnw:163-165
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 19: agilp_manual.Rnw:171-174
###################################################
inputdir<-file.path(system.file(package="agilp"),"extdata","raw/","", fsep = .Platform$file.sep)
outputdir<-file.path(system.file(package="agilp"),"output/", "", fsep = .Platform$file.sep)
Equaliser(input = inputdir, output = outputdir)


###################################################
### code chunk number 20: agilp_manual.Rnw:178-180
###################################################
unlink(file.path(system.file(package="agilp"),"output","","*.*", 
fsep = .Platform$file.sep), recursive=FALSE)


###################################################
### code chunk number 21: agilp_manual.Rnw:186-187
###################################################
file.path(system.file(package="agilp"))


