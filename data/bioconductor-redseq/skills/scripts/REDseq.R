# Code example from 'REDseq' vignette. See references/ for full tutorial.

### R code from vignette source 'REDseq.Rnw'

###################################################
### code chunk number 1: REDseq.Rnw:35-39
###################################################
	library(REDseq)
	REpatternFilePath = system.file("extdata", "examplePattern.fa", package="REDseq")
	library(BSgenome.Celegans.UCSC.ce2)
	myMap = buildREmap( REpatternFilePath, BSgenomeName=Celegans, outfile="example.REmap")


###################################################
### code chunk number 2: REDseq.Rnw:48-66
###################################################
	data(example.REDseq)
	data(example.map)
	r.unique = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1, 
	seq.length = 36, allowed.offset = 5, min.FragmentLength = 60, 
	max.FragmentLength = 300, partitionMultipleRE = "unique")
	r.best= assignSeq2REsite(example.REDseq, example.map, 
	cut.offset = 1, seq.length = 36, allowed.offset = 5, 
	min.FragmentLength = 60, max.FragmentLength = 300, partitionMultipleRE = "best")
	r.random = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1, 
	seq.length = 36, allowed.offset = 5, min.FragmentLength = 60, 
	max.FragmentLength = 300, partitionMultipleRE = "random")
	r.average = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1, 
	seq.length = 36, allowed.offset = 5, min.FragmentLength = 60,
	 max.FragmentLength = 300, partitionMultipleRE = "average")
	r.estimate = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1, 
	seq.length = 36, allowed.offset = 5, min.FragmentLength = 60, 
	max.FragmentLength = 300, partitionMultipleRE = "estimate")
	head(r.estimate$passed.filter)


###################################################
### code chunk number 3: REDseq.Rnw:76-77
###################################################
data(example.assignedREDseq)


###################################################
### code chunk number 4: fig1
###################################################
plotCutDistribution(example.assignedREDseq,example.map, chr="2",
xlim =c(3012000, 3020000))


###################################################
### code chunk number 5: fig2
###################################################
distanceHistSeq2RE(example.assignedREDseq,ylim=c(0,25))


###################################################
### code chunk number 6: REDseq.Rnw:111-112
###################################################
REsummary  =summarizeByRE(example.assignedREDseq,by="Weight")


###################################################
### code chunk number 7: REDseq.Rnw:119-120
###################################################
binom.test.REDseq(REsummary)


###################################################
### code chunk number 8: REDseq.Rnw:127-130
###################################################
x= cbind(c("RE1", "RE2", "RE3", "RE4"), c(10,1,100, 0),c(5,5,50, 40))
colnames(x) = c("REid", "control", "treated")
compareREDseq(x)


###################################################
### code chunk number 9: REDseq.Rnw:147-148
###################################################
sessionInfo()


