# Code example from 'SELEX' vignette. See references/ for full tutorial.

### R code from vignette source 'SELEX.Rnw'

###################################################
### code chunk number 1: Load.Package
###################################################
options(java.parameters="-Xmx1500M")
library(SELEX) 


###################################################
### code chunk number 2: Init
###################################################
workDir = "./cache/"
selex.config(workingDir=workDir, maxThreadNumber=4)


###################################################
### code chunk number 3: Load.Data
###################################################
# Extract example data from package, including XML annotation
exampleFiles = selex.exampledata(workDir)

# Load all sample files using XML database
selex.loadAnnotation(exampleFiles[3])


###################################################
### code chunk number 4: Display.Samples
###################################################
selex.sampleSummary()


###################################################
### code chunk number 5: Make.Sample.Handles
###################################################
r0train = selex.sample(seqName="R0.libraries", 
            sampleName="R0.barcodeGC", round=0)
r0test = selex.sample(seqName="R0.libraries", 
           sampleName="R0.barcodeCG", round=0)
r2 = selex.sample(seqName="R2.libraries", 
       sampleName="ExdHox.R2", round=2)


###################################################
### code chunk number 6: Find.Kmax
###################################################
kmax.value = selex.kmax(sample=r0test)


###################################################
### code chunk number 7: Build.MM
###################################################
mm = selex.mm(sample=r0train, order=NA, 
       crossValidationSample=r0test, Kmax=kmax.value)


###################################################
### code chunk number 8: Show.R2
###################################################
selex.mmSummary()


###################################################
### code chunk number 9: R2-Plot
###################################################
mm.r2 = selex.mmSummary()
idx = which(mm.r2$R==max(mm.r2$R))
colstring = rep('BLUE',nrow(mm.r2))
colstring[idx]='RED'
barplot(height=mm.r2$R,names.arg=(mm.r2$Order), ylim=c(.98,1), xpd=FALSE, col=colstring, 
        xlab="Markov Model Order", ylab=expression(Markov ~ Model ~ R^{2}))


###################################################
### code chunk number 10: Calc.IG
###################################################
selex.infogain(sample=r2,markovModel=mm)


###################################################
### code chunk number 11: Display.IG
###################################################
selex.infogainSummary()[,1:3]


###################################################
### code chunk number 12: Plot-IG
###################################################
infoscores = selex.infogainSummary()
idx = which(infoscores$InformationGain==max(infoscores$InformationGain))
colstring = rep('BLUE', nrow(infoscores))
colstring[idx] = 'RED'
barplot(height=infoscores$InformationGain, names.arg=infoscores$K, col=colstring,
        xlab="Oligonucleotide Length (bp)", ylab="Information Gain (bits)")
optimalLength = infoscores$K[idx]


###################################################
### code chunk number 13: Count.Table
###################################################
table = selex.counts(sample=r2, k=optimalLength, 
          markovModel=mm)


###################################################
### code chunk number 14: View.Table
###################################################
head(table)


###################################################
### code chunk number 15: Aff.Table
###################################################
aff = selex.affinities(sample=r2, k=optimalLength, 
        markovModel=mm)


###################################################
### code chunk number 16: Disp.Aff
###################################################
head(aff)[,1:4]


###################################################
### code chunk number 17: Disp.Aff.2
###################################################
head(aff)[,5:6]


