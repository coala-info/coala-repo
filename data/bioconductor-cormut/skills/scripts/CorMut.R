# Code example from 'CorMut' vignette. See references/ for full tutorial.

### R code from vignette source 'CorMut.Rnw'

###################################################
### code chunk number 1: CorMut.Rnw:70-75
###################################################
library(CorMut)
examplefile=system.file("extdata","PI_treatment.aln",package="CorMut")
examplefile02=system.file("extdata","PI_treatment_naive.aln",package="CorMut")
example=seqFormat(examplefile)
example02= seqFormat(examplefile02)


###################################################
### code chunk number 2: CorMut.Rnw:78-81
###################################################
result=kaksCodon(example)
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 3: CorMut.Rnw:84-87
###################################################
result=kaksAA(example)
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 4: CorMut.Rnw:90-91
###################################################
result=ckaksCodon(example)


###################################################
### code chunk number 5: CorMut.Rnw:94-95
###################################################
plot(result)


###################################################
### code chunk number 6: CorMut.Rnw:98-100
###################################################
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 7: CorMut.Rnw:103-104
###################################################
result=ckaksAA(example)


###################################################
### code chunk number 8: CorMut.Rnw:107-108
###################################################
plot(result)


###################################################
### code chunk number 9: CorMut.Rnw:111-113
###################################################
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 10: CorMut.Rnw:118-119
###################################################
result=miCodon(example)


###################################################
### code chunk number 11: CorMut.Rnw:122-123
###################################################
plot(result)


###################################################
### code chunk number 12: CorMut.Rnw:126-128
###################################################
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 13: CorMut.Rnw:134-135
###################################################
result=miAA(example)


###################################################
### code chunk number 14: CorMut.Rnw:138-139
###################################################
plot(result)


###################################################
### code chunk number 15: CorMut.Rnw:142-144
###################################################
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 16: CorMut.Rnw:151-152
###################################################
result=jiAA(example)


###################################################
### code chunk number 17: CorMut.Rnw:155-156
###################################################
plot(result)


###################################################
### code chunk number 18: CorMut.Rnw:159-161
###################################################
fresult=filterSites(result)
head(fresult)


###################################################
### code chunk number 19: CorMut.Rnw:167-169
###################################################
biexample=biCkaksAA(example02,example)
result=biCompare(biexample)


###################################################
### code chunk number 20: CorMut.Rnw:173-174
###################################################
plot(result)


