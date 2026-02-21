# Code example from 'mgsa' vignette. See references/ for full tutorial.

### R code from vignette source 'mgsa.Rnw'

###################################################
### code chunk number 1: set_width
###################################################
options( width = 80 )


###################################################
### code chunk number 2: loadex
###################################################
library(mgsa)
data("example")
example_go
example_o


###################################################
### code chunk number 3: fitex
###################################################
set.seed(0)
fit = mgsa(example_o, example_go)
fit


###################################################
### code chunk number 4: plotex
###################################################
plot(fit)


###################################################
### code chunk number 5: setsResults
###################################################
res = setsResults(fit)
subset(res, estimate > 0.5)


###################################################
### code chunk number 6: readGAF
###################################################
readGAF(
	system.file(
		"example_files/gene_association_head.sgd",
		package="mgsa"
	)
)


###################################################
### code chunk number 7: mgsa_custom_set
###################################################
mgsa( c("A", "B"), list(set1=LETTERS[1:3], set2=LETTERS[2:5]) ) 


###################################################
### code chunk number 8: mgsa_custom_set
###################################################
myset = new( "MgsaSets", sets=list(set1=LETTERS[1:3], set2=LETTERS[2:5]) )
mgsa(c("A", "B"), myset)
mgsa(c("B", "C"), myset)


