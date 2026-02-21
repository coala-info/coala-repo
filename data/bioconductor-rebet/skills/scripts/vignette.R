# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: start
###################################################
library(REBET)


###################################################
### code chunk number 2: geno file
###################################################
genofile  <- system.file("sampleData", "geno_impute.txt.gz", package="REBET")
subfile   <- system.file("sampleData", "subjects.txt.gz", package="REBET")
phenofile <- system.file("sampleData", "pheno.txt.gz", package="REBET")


###################################################
### code chunk number 3: pheno data
###################################################
data <- read.table(phenofile, header=1, sep="\t")
data[1:5, ]


###################################################
### code chunk number 4: add dummy var
###################################################
data[, "MALE"] <- as.numeric(data[, "Gender"] %in% "MALE")


###################################################
### code chunk number 5: sub-regions
###################################################
subRegions <- rbind(c(87654800, 87661050),
                    c(87661051, 87668870),
                    c(87668871, 87671945),
                    c(87671946, 87673200))
rownames(subRegions) <- paste("SR", 1:4, sep="")
subRegions


###################################################
### code chunk number 6: min max pos
###################################################
min.loc <- min(subRegions)
max.loc <- max(subRegions)


###################################################
### code chunk number 7: subject file
###################################################
geno.subs  <- scan(subfile, what="character")


###################################################
### code chunk number 8: match ids
###################################################
tmp   <- data[, "Subject"] %in% geno.subs
data  <- data[tmp, ]
order <- match(data[, "Subject"], geno.subs)


###################################################
### code chunk number 9: initialize
###################################################
upper.n <- 100
G       <- matrix(data=NA, nrow=nrow(data), ncol=upper.n)
snps    <- rep("", upper.n)
locs    <- rep(NA, upper.n)


###################################################
### code chunk number 10: prob vectors
###################################################
id1 <- seq(from=1, to=3*length(geno.subs), by=3)
id2 <- id1 + 1
id3 <- id1 + 2


###################################################
### code chunk number 11: read geno file
###################################################
index <- 0
fid   <- gzfile(genofile, "r")
while(1) {
  vec <- scan(fid, what="character", sep=" ", quiet=TRUE, nlines=1)
  if (!length(vec)) break
  snp <- vec[2]
  loc <- as.numeric(vec[3])
  if ((loc >= min.loc) & (loc <= max.loc)) {
    geno.probs  <- as.numeric(vec[-(1:5)])
    probs1      <- geno.probs[id1]
    probs2      <- geno.probs[id2]
    probs3      <- geno.probs[id3]
    dosage      <- probs2 + 2*probs3

    # Check for missing genotypes
    tmp <- (probs1 == 0) & (probs2 == 0) & (probs3 == 0)
    tmp[is.na(tmp)] <- TRUE
    if (any(tmp)) dosage[tmp] <- NA

    index       <- index + 1
    G[, index]  <- dosage[order]
    snps[index] <- snp
    locs[index] <- loc
  }
}
close(fid)


###################################################
### code chunk number 12: subset
###################################################
G    <- G[, 1:index, drop=FALSE]
snps <- snps[1:index]
locs <- locs[1:index]
colnames(G) <- snps


###################################################
### code chunk number 13: Y and X
###################################################
Y   <- as.numeric(data[, "Response"])
X   <- as.matrix(data[, c("Age", "MALE")])


###################################################
### code chunk number 14: E
###################################################
E <- rep("", index)
for (i in 1:nrow(subRegions)) {
  tmp <- (locs >= subRegions[i, 1]) & (locs <= subRegions[i, 2])
  tmp[is.na(tmp)] <- FALSE
  if (any(tmp)) E[tmp] <- rownames(subRegions)[i]
}


###################################################
### code chunk number 15: call rebet
###################################################
ret <- rebet(Y, G, E, covariates=X)


###################################################
### code chunk number 16: rebet summary
###################################################
print(h.summary(ret))


###################################################
### code chunk number 17: sessionInfo
###################################################
sessionInfo()


