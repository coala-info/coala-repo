# Code example from 'SearchForResearch' vignette. See references/ for full tutorial.

### R code from vignette source 'SearchForResearch.Rnw'

###################################################
### code chunk number 1: SearchForResearch.Rnw:51-53
###################################################
options(continue=" ")
options(width=80)


###################################################
### code chunk number 2: startup
###################################################
library(DECIPHER)


###################################################
### code chunk number 3: expr1
###################################################
# specify the path to your file of pattern (query) sequences:
fas1 <- "<<path to pattern FASTA file>>"
# OR use the example protein sequences:
fas1 <- system.file("extdata",
	"PlanctobacteriaNamedGenes.fas.gz",
	package="DECIPHER")
# read the sequences into memory
pattern <- readAAStringSet(fas1)
pattern


###################################################
### code chunk number 4: expr2
###################################################
# specify the path to your file of subject (target) sequences:
fas2 <- "<<path to subject FASTA file>>"
# OR use the example subject genome:
fas2 <- system.file("extdata",
	"Chlamydia_trachomatis_NC_000117.fas.gz",
	package="DECIPHER")
# read the sequences into memory
genome <- readDNAStringSet(fas2)
genome
genome <- c(genome, reverseComplement(genome)) # two strands
subject <- subseq(rep(genome, each=3), rep(1:3, 2)) # six frames
subject <- suppressWarnings(translate(subject)) # 6-frame translation
subject


###################################################
### code chunk number 5: expr3
###################################################
index <- IndexSeqs(subject,
	sensitivity=0.99,
	percentIdentity=70,
	patternLength=300,
	processors=1)
index


###################################################
### code chunk number 6: expr4
###################################################
hits <- SearchIndex(pattern,
	index,
	perPatternLimit=100,
	processors=1)
dim(hits)
head(hits)


###################################################
### code chunk number 7: expr5
###################################################
getOption("SweaveHooks")[["fig"]]()
layout(matrix(1:4, nrow=2))
hist(hits$Score,
	breaks=100, xlab="Score", main="Distribution of scores")
plot(NA, xlim=c(0, max(width(subject))), ylim=c(1, 6),
	xlab="Genome position", ylab="Genome frame",
	main="Location of k-mer matches")
segments(sapply(hits$Position, `[`, i=3), # third row
	hits$Subject,
	sapply(hits$Position, `[`, i=4), # fourth row
	hits$Subject)
plot(hits$Score,
	sapply(hits$Position, function(x) sum(x[2,] - x[1,] + 1)),
	xlab="Score", ylab="Sum of k-mer matches",
	main="Matches versus score", log="xy")
plot(table(tabulate(hits$Pattern, nbins=length(pattern))),
	xlab="Hits per pattern sequence", ylab="Frequency",
	main="Number of hits per query")


###################################################
### code chunk number 8: expr6
###################################################
w <- which.max(tabulate(hits$Pattern))
hits[hits$Pattern == w,]
names(pattern)[w]


###################################################
### code chunk number 9: expr7
###################################################
aligned <- AlignPairs(pattern=pattern,
	subject=subject,
	pairs=hits,
	processors=1)
head(aligned)


###################################################
### code chunk number 10: expr8
###################################################
getOption("SweaveHooks")[["fig"]]()
PID1 <- aligned$Matches/(aligned$Matches + aligned$Mismatches)
PID2 <- aligned$Matches/aligned$AlignmentLength
layout(matrix(1:4, ncol=2))
plot(hits$Score, PID2,
	xlab="Hit score",
	ylab="Matches / (Aligned length)")
plot(hits$Score, aligned$Score,
	xlab="Hit score",
	ylab="Aligned score")
plot(aligned$Score, PID1,
	xlab="Aligned score",
	ylab="Matches / (Matches + Mismatches)")
plot(PID1, PID2,
	xlab="Matches / (Matches + Mismatches)",
	ylab="Matches / (Aligned length)")


###################################################
### code chunk number 11: expr9
###################################################
alignments <- AlignPairs(pattern=pattern,
	subject=subject,
	pairs=hits,
	type="both",
	processors=1)
patterns <- alignments[[2]]
subjects <- alignments[[3]]
c(patterns[1], subjects[1]) # view the first pairwise alignment


###################################################
### code chunk number 12: expr10
###################################################
revhits <- SearchIndex(reverse(pattern), # reverse the query
	index, # keep the same target database
	minScore=10, # set low to get many hits
	processors=1)
dim(revhits)


###################################################
### code chunk number 13: expr11
###################################################
getOption("SweaveHooks")[["fig"]]()
X <- 10:100 # score bins
Y <- tabulate(.bincode(revhits$Score, X), length(X) - 1)
Y <- Y/length(pattern) # average per query
w <- which(Y > 0) # needed to fit in log-space
plot(X[w], Y[w],
	log="y",
	xlab="Score",
	ylab="Average false positives per query")
fit <- function(rate) # integrate from bin start to end
	sum(abs((log((exp(-X[w]*rate) -
		exp(-X[w + 1]*rate))*length(subject)) -
		log(Y[w]))))
o <- optimize(fit, c(0.01, 2)) # optimize rate
lines(X[-length(X)], (exp(-X[-length(X)]*o$minimum) -
	exp(-(X[-1])*o$minimum))*length(subject))
rate <- o$minimum
print(rate)


###################################################
### code chunk number 14: expr12
###################################################
# convert each Score to an E-value
Evalue <- exp(-rate*hits$Score)*length(subject)*length(pattern)
# determine minimum Score for up to 1 false positive hit expected
log(1/length(subject)/length(pattern))/-rate


###################################################
### code chunk number 15: expr13
###################################################
# determine minimum Score for 0.05 (total) false positive hits expected
threshold <- log(0.05/length(subject)/length(pattern))/-rate
hits <- hits[hits$Score > threshold,]
dim(hits)


###################################################
### code chunk number 16: expr14
###################################################
FDR <- 0.001 # maximum allowed false discovery rate
N <- nrow(hits)
ranking <- order(c(hits$Score, revhits$Score), decreasing=TRUE)
ranking <- ranking[cumprod(cumsum(ranking > N) <= seq_along(ranking)*FDR) == 1L]
hits <- hits[sort(ranking[ranking <= N]),] # filtered hits
nrow(hits) # number of search hits after controlling FDR


###################################################
### code chunk number 17: expr15
###################################################
# include the target sequences to increase search sensitivity
hits <- SearchIndex(pattern,
	index,
	subject, # optional parameter
	perPatternLimit=100,
	processors=1)
dim(hits)
head(hits)


###################################################
### code chunk number 18: expr16
###################################################
index <- IndexSeqs(genome,
	K=11,
	maskRepeats=FALSE,
	maskLCRs=FALSE,
	processors=1)
index


###################################################
### code chunk number 19: expr17
###################################################
fas3 <- system.file("extdata",
	"Simulated_ONT_Long_Reads.fas.gz",
	package="DECIPHER")
reads <- readDNAStringSet(fas3)
head(names(reads))


###################################################
### code chunk number 20: expr18
###################################################
maps <- SearchIndex(reads,
	index,
	perPatternLimit=2, # two hits per read
	perSubjectLimit=0, # unlimited
	maskRepeats=FALSE,
	maskLCRs=FALSE,
	processors=1)
dim(maps)
head(maps)

# when > 1 hit, subtract 2nd highest score from top hit
o <- order(maps$Pattern, maps$Score, decreasing=TRUE)
w <- which(duplicated(maps$Pattern[o]))
maps$Score[o[w - 1]] <- maps$Score[o[w - 1]] - maps$Score[o[w]]
maps <- maps[-o[w],] # remove 2nd best hits
nrow(maps) == length(reads)


###################################################
### code chunk number 21: expr19
###################################################
pos <- sapply(maps$Position, function(x) x[3] - x[1] + 1)
offset <- abs(pos - as.integer(names(reads)))
table(offset)
maps$Score[which.max(offset)]


###################################################
### code chunk number 22: sessinfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


