# Code example from 'bigmelon' vignette. See references/ for full tutorial.

### R code from vignette source 'bigmelon.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: code-block
###################################################
library(bigmelon)
data(melon)
# Convert methylumiset or methylset objects to .gds
gfile <- es2gds(melon, 'melon.gds')
# 'melon.gds' file created in current working directory
dir()
# Access data with:
betas(gfile)
# OR
index.gdsn(gfile, 'betas')
# Get betas with '[' notation
betas(gfile)[1:5,1:5]
# Or call from gfile
gfile[1:5, 1:5, node = 'methylated']
# Preprocess data with pfilter and dasen
pfilter(gfile)
dasen(gfile)
# Note you do not have to store the output
# because the functions make changes to disk

# Use apply.gdsn (or clusterApply.gdsn) to perform apply-like operations
meth <- methylated(gfile)
apply.gdsn(meth, 2, median, as.is='double', na.rm = TRUE)

# Calculating Horvath's epigenetic ages with agep
data(coef)
agep(gfile, coeff=coef)

# Close .gds file
closefn.gds(gfile)
# Open a .gds file
gfile <- openfn.gds('melon.gds')


###################################################
### code chunk number 3: UnseenCodeAndOutput
###################################################
closefn.gds(gfile)
unlink('melon.gds', force = TRUE)


###################################################
### code chunk number 4: UnevaluatedCode (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install('wateRmelon', 'gdsfmt')


###################################################
### code chunk number 5: UnevaluatedCode (eval = FALSE)
###################################################
## install.packages('bigmelon_0.99.11.tar.gz', repos = NULL, type = 'source')


###################################################
### code chunk number 6: UnevaluatedCode (eval = FALSE)
###################################################
## # read in an IDAT file with barcode 'sentrixid_rnncnn'
## gfile <- iadd('sentrixid_rnncnn', gds = 'melon.gds')
## gfile <- iadd2('Data/IDATLocations/dataset', gds = 'melon.gds', chunksize = 100)


###################################################
### code chunk number 7: code-block
###################################################
data(melon)
gfile <- es2gds(melon, 'melon.gds')


###################################################
### code chunk number 8: UnevaluatedCode (eval = FALSE)
###################################################
## library(methylumi)
## # read Illumina methylation data into a MethyLumiSet object
## melon <- methyLumiR('finalreport.txt')
## # read Illumina methylation final report into a gds.class object.
## gfile <- finalreport2gds('finalreport.txt', gds='melon.gds')


###################################################
### code chunk number 9: UnevaluatedCode (eval = FALSE)
###################################################
## # convert a MethyLumiSet object to a gds.class object
## gfile <- es2gds(melon, 'melon.gds')


###################################################
### code chunk number 10: UnevaluatedCode (eval = FALSE)
###################################################
## # Closing File
## closefn.gds(gfile)
## 
## # Opening File
## gfile <- openfn.gds('melon.gds')


###################################################
### code chunk number 11: code-block
###################################################
print(gfile)


###################################################
### code chunk number 12: code-block
###################################################
index.gdsn(gfile, 'betas')
class(index.gdsn(gfile, 'betas'))
# Access nodes with additional nodes inside
index.gdsn(gfile, 'fData/TargetID')


###################################################
### code chunk number 13: code-block
###################################################
betas(gfile)
class(betas(gfile))


###################################################
### code chunk number 14: code-block
###################################################
ls.gdsn(gfile)
# Look into nodes with additional nodes
ls.gdsn(index.gdsn(gfile, 'fData'))


###################################################
### code chunk number 15: code-block
###################################################
# Call a gdsn.class node
anode <- betas(gfile)
anode
class(anode)
# All data
dat <- read.gdsn(anode)
dim(dat)
head(dat)
# Subset!
datsub <- readex.gdsn(anode, sel = list(1:5, 1:3))
dim(datsub)
datsub


###################################################
### code chunk number 16: code-block
###################################################
# Re-using node from previous example
anode
datsub <- anode[1:5,1:3]
dim(datsub)
datsub
# Additionally, the row and col names can be disabled
anode[1:5, 1:3, name = FALSE]


###################################################
### code chunk number 17: code-block
###################################################
# Logical Indexing
anode[1:5,c(TRUE,FALSE,FALSE)]
# Ordering calls
anode[c(5,9,1,500,345), c(8,4,1,3)]
# Indexing by characters (and drop functionality)
anode[c('cg00000029', 'cg00000236'), '6057825008_R02C01', drop = FALSE]
# Loading entire data (no indexing)
dat <- anode[ , ] # Not recommended for large data.
dim(dat)


###################################################
### code chunk number 18: code-block
###################################################
gfile[1:5, 1:3, node = 'betas', name = TRUE]
gfile[1:5, 1:3, node = 'methylated', name = TRUE]


###################################################
### code chunk number 19: code-block
###################################################
read.gdsn(index.gdsn(gfile, "paths"))
head(read.gdsn(index.gdsn(gfile, "fData/TargetID")))
head(read.gdsn(index.gdsn(gfile, "pData/sampleID")))


###################################################
### code chunk number 20: code-block
###################################################
rawmet <- methylated(gfile)[,]
rawume <- unmethylated(gfile)[,]


###################################################
### code chunk number 21: IncludeGraphic
###################################################
boxplot(log(rawmet), las=2, cex.axis=0.8)


###################################################
### code chunk number 22: IncludeGraphic1
###################################################
boxplot(log(rawume), las=2, cex.axis=0.8)


###################################################
### code chunk number 23: code-block
###################################################
rawbet <- betas(gfile)[,]


###################################################
### code chunk number 24: IncludeGraphic2
###################################################
outlyx(rawbet, plot = TRUE)


###################################################
### code chunk number 25: IncludeGraphic3
###################################################
outlyx(gfile, plot = TRUE, perc = 0.01)


###################################################
### code chunk number 26: code-block
###################################################
pfilter(gfile)


###################################################
### code chunk number 27: code-block
###################################################
backup.gdsn(gds = NULL, node = index.gdsn(gfile, 'betas'))
ls.gdsn(index.gdsn(gfile, 'backup'))


###################################################
### code chunk number 28: code-block
###################################################
f <- createfn.gds('melon2.gds')
backup.gdsn(gds = f, node = index.gdsn(gfile, 'betas'))
f
copyto.gdsn(node = f, source = index.gdsn(gfile, 'betas'), name = 'betacopy')
f
copyto.gdsn(node = gfile, source = index.gdsn(gfile, 'betas'), name='betacopy')
# Close File
closefn.gds(f)


###################################################
### code chunk number 29: UnseenCodeAndOutput
###################################################
unlink('melon2.gds')


###################################################
### code chunk number 30: code-block
###################################################
dasen(gfile)
# Alternatively it is possible to store normalized betas to a separate node
# If you want to keep the raw data
dasen(gfile, node="normbeta")
index.gdsn(gfile, "normbeta")


###################################################
### code chunk number 31: code-block
###################################################
# Example of apply.gdsn
apply.gdsn(betas(gfile), margin = 2, as.is='double', FUN = function(x,y){
mean(x, na.rm=y)
}, y = TRUE)


###################################################
### code chunk number 32: code-block
###################################################
# Age Prediction
data(coef) # Load up a set of coefficient (horvaths)
agep(gfile, coef) 
# Alternatively
agep(betas(gfile), coef) # or index.gdsn(gfile, 'foobar') for a different matrix


###################################################
### code chunk number 33: code-block
###################################################
gds2mlumi(gfile)
gds2mset(gfile, anno="450k")


###################################################
### code chunk number 34: code-block
###################################################
# Closing the connection
closefn.gds(gfile)


###################################################
### code chunk number 35: UnseenCodeAndOutput
###################################################
unlink('melon.gds', force = TRUE)


###################################################
### code chunk number 36: code-block
###################################################
sessionInfo()


