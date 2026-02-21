# Code example from 'vignette_GxE' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette_GxE.Rnw'

###################################################
### code chunk number 1: TPED files
###################################################
geno.file <- system.file("sampleData", "geno_data.tped.gz", package="CGEN")
subject.file <- system.file("sampleData", "geno_data.tfam", package="CGEN")
geno.file
subject.file


###################################################
### code chunk number 2: start
###################################################
library(CGEN)


###################################################
### code chunk number 3: TPED subject.list
###################################################
subject.list <- list(file=subject.file, id.var=1:2, header=0, delimiter=" ")
subject.list <- subject.file


###################################################
### code chunk number 4: snp.list
###################################################
snp.list <- list(file=geno.file, format="tped", subject.list=subject.list)


###################################################
### code chunk number 5: TPED pheno.list
###################################################
pheno.file <- system.file("sampleData", "pheno.txt", package="CGEN")
pheno.list <- list(file=pheno.file, id.var=c("Family", "Subject"),
              file.type=3, delimiter="\t",
              response.var="CaseControl", strata.var="Study",
              main.vars=c("Gender", "Exposure", "Smoke_CURRENT", "Smoke_FORMER"),
              int.vars="Exposure")


###################################################
### code chunk number 6: options list
###################################################
out.file <- paste(getwd(), "/GxE.out", sep="")
op <- list(out.file=out.file)


###################################################
### code chunk number 7: TPED scan
###################################################
GxE.scan(snp.list, pheno.list, op=op)
x <- read.table(out.file, header=1, as.is=TRUE, sep="\t")
x[1:5, ]


###################################################
### code chunk number 8: myscan
###################################################
myscan <- function(data, lists) {

 # Call snp.logistic
 fit <- snp.logistic(data, "CaseControl", "SNP", main.vars=~Gender + Exposure, 
                     int.vars=~Exposure, strata.var="Study")

 # Extract the CML log-odds ratio and standard error
 temp <- fit$CML
 beta <- temp$parms["SNP:Exposure"]
 se   <- sqrt(temp$cov["SNP:Exposure", "SNP:Exposure"]) 

 # Compute the odds-ratio and 95 percent confidence interval
 or   <- exp(beta)
 l    <- round(exp(beta - 1.96*se), digits=4)
 u    <- round(exp(beta + 1.96*se), digits=4)
 ci   <- paste("(", l, ", ", u, ")", sep="")

 # Return list. The names "Odds.Ratio" and "OR.95.CI" will be column names in the output file.
 list(Odds.Ratio=or, OR.95.CI=ci)

} 


###################################################
### code chunk number 9: Data lists
###################################################
geno.file <- system.file("sampleData", "geno_data.tped.gz", package="CGEN")
subject.file <- system.file("sampleData", "geno_data.tfam", package="CGEN")
subject.list <- subject.file
snp.list <- list(file=geno.file, format="tped", subject.list=subject.list)
pheno.file <- system.file("sampleData", "pheno.txt", package="CGEN")
pheno.list <- list(file=pheno.file, id.var=c("Family", "Subject"),
              file.type=3, delimiter="\t",
              response.var="CaseControl", strata.var="Study",
              main.vars=c("Gender", "Exposure", "Smoke_CURRENT", "Smoke_FORMER"),
              int.vars="Exposure")


###################################################
### code chunk number 10: set options
###################################################
op <- list(out.file=out.file, model=0, scan.func="myscan", geno.counts=0)


###################################################
### code chunk number 11: user-defined scan
###################################################
GxE.scan(snp.list, pheno.list, op=op)
x <- read.table(out.file, header=1, as.is=TRUE, sep="\t")
x[1:5, ]


###################################################
### code chunk number 12: scan.setup.func
###################################################
mysetup <- function(data, lists) {

  # data      Data frame containing all the data except the genotype data.
  # lists     A list containing pheno.list and possibly scan.func.op

  pheno.list <- lists$pheno.list
  op.list    <- lists[["scan.func.op", exact=TRUE]]
  if (is.null(op.list)) op.list <- list()
  svar       <- pheno.list$strata.var
  svec       <- data[, svar]

  # Add indicator variables for study to data 
  data[, "Study_A"] <- as.integer(svec %in% "A")
  data[, "Study_B"] <- as.integer(svec %in% "B")

  # Include one of the indeicators as a main effect
  mvars <- pheno.list$main.vars
  pheno.list$main.vars <- c(mvars, "Study_A")

  # Create a formula to fit a NULL model
  str  <- paste(pheno.list$main.vars, collapse=" + ", sep="")
  str  <- paste(pheno.list$response.var, " ~ ", str, sep="")
  form <- as.formula(str)

  # Fit the base model
  fit <- glm(form, data=data, family=binomial()) 
  print(summary(fit))

  # Save the formula string. This will be used in the scan function.
  op.list$form.str <- str

  # Save the log-likelihood and rank for LRT tests
  op.list$rank.base    <- fit$rank
  op.list$loglike.base <- (2*fit$rank - fit$aic)/2
  
  # Return modified lists and data
  list(data=data, pheno.list=pheno.list, scan.func.op=op.list)
}


###################################################
### code chunk number 13: myscan2
###################################################
myscan2 <- function(data, lists) {

 # data      Data frame containing all the data except the genotype data.
 # lists     A list containing pheno.list and possibly scan.func.op

 plist    <- lists$pheno.list
 op       <- lists$scan.func.op

 # By default, the SNP variable snp.var is called "SNP"
 snp.var  <- plist$snp.var 
 int.vars <- plist$int.vars
 
 # Change genetic.model depending on the MAF
 snp     <- data[, snp.var]
 missing <- is.na(snp)
 nmiss   <- sum(missing)
 MAF     <- 0.5*mean(snp, na.rm=TRUE)
 if (MAF < op$MAF.cutoff) {
   gmodel <- 1
   str    <- "Dominant"
 } else {
   gmodel <- 0
   str    <- "Additive"
 }
 
 # Fit full model  
 fit <- snp.logistic(data, plist$response.var, snp.var, 
         main.vars=plist$main.vars, int.vars=int.vars, 
         strata.var=plist$strata.var, 
         op=list(genetic.model=gmodel))

 # Get the log-likelihood and rank for likelihood ratio tests.
 loglike.full <- fit$UML$loglike
 rank.full    <- length(fit$UML$parms) 

 # If the SNP had missing values, refit the base model.
 if (nmiss) {
   subset <- !missing
   form   <- as.formula(op$form.str)
   fit0   <- glm(form, data=data, family=binomial(), subset=subset)
   rank.base    <- fit0$rank
   loglike.base <- (2*fit0$rank - fit0$aic)/2
 } else {
   # No missing values, use saved values from scan.setup.func
   rank.base    <- op$rank.base
   loglike.base <- op$loglike.base
 }

 # Compute the likelihood reatio test and p-value
 LRT   <- 2*(loglike.full - loglike.base) 
 LRT.p <- pchisq(LRT, rank.full-rank.base, lower.tail=FALSE)

 # Compute a Wald test of the main effect of SNP and interaction using the EB estimates.
 vars  <- c(snp.var, paste(snp.var, ":", int.vars, sep=""))
 temp  <- getWaldTest(fit, vars, method="EB")
 EB.p  <- temp$p
 EB.df <- temp$df
 EB.t  <- temp$test

 # Define the return vector. 
 ret <- c(str, LRT, LRT.p, EB.t, EB.p, EB.df)
 names(ret) <- c("Genetic.Model", "UML.LRT", "UML.LRT.Pvalue",
                 "EB.Wald.Test", "EB.Wald.Pvalue", "DF")

 ret
}


###################################################
### code chunk number 14: scan.func.op
###################################################
myoptions <- list(MAF.cutoff=0.05)


###################################################
### code chunk number 15: GxE.scan.op
###################################################
op <- list(out.file=out.file, model=0, scan.func="myscan2", scan.setup.func="mysetup",
        scan.func.op=myoptions, geno.counts=0, geno.MAF=0, geno.missRate=0)


###################################################
### code chunk number 16: user-defined scan 2
###################################################
GxE.scan(snp.list, pheno.list, op=op)


###################################################
### code chunk number 17: output for scan 2
###################################################
x <- read.table(out.file, header=1, as.is=TRUE, sep="\t")
x[1:5, ]


###################################################
### code chunk number 18: sessionInfo
###################################################
sessionInfo()


