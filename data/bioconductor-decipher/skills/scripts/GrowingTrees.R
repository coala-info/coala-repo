# Code example from 'GrowingTrees' vignette. See references/ for full tutorial.

### R code from vignette source 'GrowingTrees.Rnw'

###################################################
### code chunk number 1: GrowingTrees.Rnw:51-53
###################################################
options(continue=" ")
options(width=80)


###################################################
### code chunk number 2: expr1
###################################################
library(DECIPHER)

# specify the path to your sequence file:
fas <- "<<path to FASTA file>>"
# OR find the example sequence file used in this tutorial:
fas <- system.file("extdata", "Streptomyces_ITS_aligned.fas", package="DECIPHER")

seqs <- readDNAStringSet(fas) # use readAAStringSet for amino acid sequences
seqs # the aligned sequences


###################################################
### code chunk number 3: expr2
###################################################
seqs <- unique(seqs) # remove duplicated sequences

ns <- gsub("^.*Streptomyces( subsp\\. | sp\\. | | sp_)([^ ]+).*$",
	"\\2",
	names(seqs))
names(seqs) <- ns # name by species (or any other preferred names)
seqs <- seqs[!duplicated(ns)] # remove redundant sequences from the same species
seqs


###################################################
### code chunk number 4: expr3
###################################################
MODELS


###################################################
### code chunk number 5: expr4
###################################################
set.seed(123) # set the random number seed

treeME <- Treeline(seqs, verbose=FALSE, processors=1)

set.seed(NULL) # reset the seed


###################################################
### code chunk number 6: expr5
###################################################
treeME

attributes(treeME)

str(treeME, max.level=4)


###################################################
### code chunk number 7: expr6
###################################################
getOption("SweaveHooks")[["fig"]]()
set.seed(123) # set the random number seed

tree <- Treeline(seqs,
	method="ML",
	model="GTR+G4",
	maxTime=0.01,
	verbose=FALSE,
	processors=1)

set.seed(NULL) # reset the seed

plot(tree)


###################################################
### code chunk number 8: expr7
###################################################
attr(tree, "members") # number of leaves below this (root) node
attr(tree, "height") # height of the node (in this case, the midpoint root)
attr(tree, "score") # best score (in this case, the -LnL)
attr(tree, "model") # either the specified or automatically select transition model
attr(tree, "parameters") # the free model parameters (or NA if unoptimized)
attr(tree, "midpoint") # center of the edge (for plotting)


###################################################
### code chunk number 9: expr8
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(dendrapply(tree,
	function(x) {
		s <- attr(x, "probability") # choose "probability" (aBayes)
		if (!is.null(s) && !is.na(s)) {
			s <- formatC(as.numeric(s), digits=2, format="f")
			attr(x, "edgetext") <- paste(s, "\n")
		}
		attr(x, "edgePar") <- list(p.col=NA, p.border=NA, t.col="#CC55AA", t.cex=0.7)
		if (is.leaf(x))
			attr(x, "nodePar") <- list(lab.font=3, pch=NA)
		x
	}),
	horiz=TRUE,
	yaxt='n')
# add a scale bar (placed manually)
arrows(2, 0, 2.4, 0, code=3, angle=90, len=0.05, xpd=TRUE)
text(2.2, 0, "0.4 subs./site", pos=3, xpd=TRUE)


###################################################
### code chunk number 10: expr9
###################################################
set.seed(123) # set the random number seed

tree_UniformCosts <- Treeline(seqs,
	method="MP",
	reconstruct=TRUE,
	verbose=FALSE,
	processors=1)

set.seed(NULL) # reset the seed


###################################################
### code chunk number 11: expr10
###################################################
mat <- attr(tree_UniformCosts, "transitions")
mat # count of state transitions

mat <- mat + t(mat) # make symmetric
mat <- mat/(sum(mat)/2) # normalize
mat <- -log2(mat) # convert to bits
diag(mat) <- 0 # reset diagonal
mat # a derived cost matrix


###################################################
### code chunk number 12: expr11
###################################################
getOption("SweaveHooks")[["fig"]]()
set.seed(123) # set the random number seed

tree_NonUniformCosts <- Treeline(seqs,
	method="MP",
	costMatrix=mat,
	reconstruct=TRUE,
	verbose=FALSE,
	processors=1)

set.seed(NULL) # reset the seed

splits <- function(x) {
	y <- sapply(x, function(x) paste(sort(unlist(x)), collapse=" "))
	if (!is.leaf(x))
		y <- c(y, splits(x[[1]]), splits(x[[2]]))
	y
}
splits_UniformCosts <- splits(tree_UniformCosts)
splits_NonUniformCosts <- splits(tree_NonUniformCosts)

dashEdges <- function(x, splits) {
	y <- paste(sort(unlist(x)), collapse=" ")
	if (!y %in% splits)
		attr(x, "edgePar") <- list(lty=2)
	x
}

layout(matrix(1:2, nrow=1))
plot(dendrapply(tree_UniformCosts, dashEdges, splits_NonUniformCosts),
	main="MP uniform costs")
plot(dendrapply(tree_NonUniformCosts, dashEdges, splits_UniformCosts),
	main="MP non-uniform costs")


###################################################
### code chunk number 13: expr12
###################################################
getOption("SweaveHooks")[["fig"]]()
new_tree <- MapCharacters(tree_NonUniformCosts, labelEdges=TRUE)
plot(new_tree, edgePar=list(p.col=NA, p.border=NA, t.col="#55CC99", t.cex=0.7))
attr(new_tree[[1]], "change") # state changes on first branch left of (virtual) root


###################################################
### code chunk number 14: expr13
###################################################
reps <- 100 # number of bootstrap replicates

tree1 <- Treeline(seqs, verbose=FALSE, processors=1)

partitions <- function(x) {
	if (is.leaf(x))
		return(NULL)
	x0 <- paste(sort(unlist(x)), collapse=" ")
	x1 <- partitions(x[[1]])
	x2 <- partitions(x[[2]])
	return(list(x0, x1, x2))
}

pBar <- txtProgressBar()
bootstraps <- vector("list", reps)
for (i in seq_len(reps)) {
	r <- sample(width(seqs)[1], replace=TRUE)
	at <- IRanges(r, width=1)
	seqs2 <- extractAt(seqs, at)
	seqs2 <- lapply(seqs2, unlist)
	seqs2 <- DNAStringSet(seqs2)
	
	temp <- Treeline(seqs2, verbose=FALSE)
	bootstraps[[i]] <- unlist(partitions(temp))
	setTxtProgressBar(pBar, i/reps)
}
close(pBar)


###################################################
### code chunk number 15: expr14
###################################################
getOption("SweaveHooks")[["fig"]]()
bootstraps <- table(unlist(bootstraps))
original <- unlist(partitions(tree1))
hits <- bootstraps[original]
names(hits) <- original
w <- which(is.na(hits))
if (length(w) > 0)
	hits[w] <- 0
hits <- round(hits/reps*100)

labelEdges <- function(x) {
	if (is.null(attributes(x)$leaf)) {
		part <- paste(sort(unlist(x)), collapse=" ")
		attr(x, "edgetext") <- as.character(hits[part])
	}
	return(x)
}
tree2 <- dendrapply(tree1, labelEdges)
attr(tree2, "edgetext") <- NULL # remove text from (virtual) root branch

plot(tree2, edgePar=list(t.cex=0.5), nodePar=list(lab.cex=0.7, pch=NA))


###################################################
### code chunk number 16: expr15
###################################################
rapply(tree, attr, which="label") # label of each leaf (left to right)
labels(tree) # alternative
rapply(tree, attr, which="height") # height of each leaf (left to right)
italicize <- function(x) {
	if(is.leaf(x)) 
		attr(x, "label") <- as.expression(substitute(italic(leaf),
			list(leaf=attr(x, "label"))))
	x
}
rapply(tree, italicize, how="replace") # italicize leaf labels


###################################################
### code chunk number 17: expr16
###################################################
getOption("SweaveHooks")[["fig"]]()
d <- DistanceMatrix(seqs, correction="F81+F", verbose=FALSE, processors=1)
exclusive <- function(x) {
	if (!is.leaf(x)) { # leaves are trivially exclusive
		leaves <- unlist(x)
		max_dist <- max(d[leaves, leaves]) # max within group
		if (all(max_dist < d[-leaves, leaves]))
			attr(x, "edgePar") <- list(col="orange")
	}
	x
}
plot(dendrapply(tree, exclusive))


###################################################
### code chunk number 18: expr17
###################################################
Spp <- c("coelicolor", "lividans", "AA4", "Mg1", "scabiei") # species to retain

extractClade <- function(x) {
	if (is.leaf(x)) {
		if (sum(Spp %in% labels(x)) > 0L) {
			labels(x)
		} else {
			NULL
		}
	} else {
		x <- lapply(x, extractClade)
		x <- x[lengths(x) > 0]
		if (length(x) == 1)
			x <- x[[1]]
		x
	}
}

extractClade(tree)


###################################################
### code chunk number 19: expr18
###################################################
freqs <- alphabetFrequency(seqs, baseOnly=TRUE)
head(freqs)
# summarize the number of non-base characters (gaps/ambiguities)
summary(freqs) # "other" is non-base characters

# index of sequence with the most non-base characters
which.max(freqs[, "other"])

freqs <- freqs[, DNA_BASES]
background <- colMeans(freqs)
background

# look for sequences deviating from background frequencies
chi2 <- colSums((t(freqs) - background)^2/background)
pval <- pchisq(chi2, length(background) - 1, lower.tail=FALSE)
w <- which(pval < 0.05)
seqs[w] # outlier sequences
freqs[w,] # frequencies of outliers

# get sequence index of any very distant outlier sequences
D <- DistanceMatrix(seqs, verbose=FALSE, processors=1)
t <- table(which(D > 0.9, arr.ind=TRUE)) # choose a cutoff
head(sort(t, decreasing=TRUE)) # index of top outliers, if any


###################################################
### code chunk number 20: expr19
###################################################
getOption("SweaveHooks")[["fig"]]()
P <- Cophenetic(treeME) # patristic distances
D <- as.dist(D) # conver to 'dist' object

plot(D, P, xlab="Pairwise distance", ylab="Patristic distance", log="xy")
abline(a=0, b=1)

# for ME trees we want explained variance > 0.9
V <- 1 - sum((P - D)^2)/sum((D - mean(D))^2)
V # check the input data if V << 1

cor(P, D) # should be >> 0
cor(log(P), log(D)) # should be >> 0


###################################################
### code chunk number 21: expr20
###################################################
WriteDendrogram(tree, file="")


###################################################
### code chunk number 22: expr21
###################################################
params <- attr(tree, "parameters")
cat("[", paste(names(params), params, sep="=", collapse=","), "]",
	sep="", append=TRUE, file="")


###################################################
### code chunk number 23: sessinfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


