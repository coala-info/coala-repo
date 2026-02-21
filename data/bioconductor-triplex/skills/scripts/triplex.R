# Code example from 'triplex' vignette. See references/ for full tutorial.

### R code from vignette source 'triplex.Rnw'

###################################################
### code chunk number 1: triplex.Rnw:54-55
###################################################
library(triplex)


###################################################
### code chunk number 2: triplex.Rnw:83-85
###################################################
seq <- DNAString("TTGGGGAAAGCAATGCCAGGCAGGGGGTTCCTTTCGTTACGGTCCGTCCC")
triplex.search(seq)


###################################################
### code chunk number 3: triplex.Rnw:106-107
###################################################
triplex.search(seq, type=1)


###################################################
### code chunk number 4: triplex.Rnw:135-136
###################################################
triplex.search(seq, min_len=10, max_len=20)


###################################################
### code chunk number 5: triplex.Rnw:156-157
###################################################
triplex.search(seq, iso_pen=2)


###################################################
### code chunk number 6: triplex.Rnw:179-180
###################################################
triplex.search(seq, min_score=14)


###################################################
### code chunk number 7: triplex.Rnw:224-226
###################################################
t <- triplex.search(seq)
t


###################################################
### code chunk number 8: triplex.Rnw:235-236
###################################################
triplex.alignment(t[1])


###################################################
### code chunk number 9: triplex.Rnw:249-250
###################################################
triplex.diagram(t[1])


###################################################
### code chunk number 10: triplex.Rnw:264-265 (eval = FALSE)
###################################################
## triplex.3D(t[1])


###################################################
### code chunk number 11: triplex.Rnw:268-269
###################################################
triplex.alignment(t[1])


###################################################
### code chunk number 12: triplex.Rnw:299-301
###################################################
gr <- as(t, "GRanges")
gr


###################################################
### code chunk number 13: triplex.Rnw:310-312
###################################################
library(rtracklayer)
export(gr,"test.gff", version="3")


###################################################
### code chunk number 14: triplex.Rnw:318-320
###################################################
text <- readLines("test.gff",n=10)
cat(strwrap(text, width=80, exdent=3),sep="\n")


###################################################
### code chunk number 15: triplex.Rnw:334-336
###################################################
dss <- as(t, "DNAStringSet")
dss


###################################################
### code chunk number 16: triplex.Rnw:341-342
###################################################
writeXStringSet(dss, file="test.fa", format="fasta")


###################################################
### code chunk number 17: triplex.Rnw:347-349
###################################################
text <- readLines("test.fa",n=10)
cat(text,sep="\n")


###################################################
### code chunk number 18: triplex.Rnw:376-378
###################################################
library(triplex) 
library(BSgenome.Celegans.UCSC.ce10) 


###################################################
### code chunk number 19: triplex.Rnw:383-385
###################################################
t <- triplex.search(Celegans[["chrX"]][1:100000],min_score=17,min_len=8)
t


###################################################
### code chunk number 20: triplex.Rnw:391-393
###################################################
ts <- t[order(score(t),decreasing=TRUE)]
ts


###################################################
### code chunk number 21: triplex.Rnw:401-402
###################################################
triplex.diagram(ts[1])


###################################################
### code chunk number 22: triplex.Rnw:410-411 (eval = FALSE)
###################################################
## triplex.3D(ts[1])


###################################################
### code chunk number 23: triplex.Rnw:414-415
###################################################
triplex.alignment(ts[1])


###################################################
### code chunk number 24: triplex.Rnw:429-431
###################################################
library(rtracklayer)
export(as(t, "GRanges"),"test.gff", version="3")


###################################################
### code chunk number 25: triplex.Rnw:436-438
###################################################
text <- readLines("test.gff",n=10)
cat(strwrap(text, width=80, exdent=3),sep="\n")


###################################################
### code chunk number 26: triplex.Rnw:443-444
###################################################
writeXStringSet(as(t, "DNAStringSet"), file="test.fa", format="fasta")


###################################################
### code chunk number 27: triplex.Rnw:449-451
###################################################
text <- readLines("test.fa",n=20)
cat(text,sep="\n")


###################################################
### code chunk number 28: triplex.Rnw:456-457
###################################################
hist(score(t), breaks=20)


###################################################
### code chunk number 29: triplex.Rnw:462-463
###################################################
plot(coverage(ts[0:length(t)]), type="s", col="grey75")


