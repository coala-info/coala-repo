# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----start--------------------------------------------------------------------
library(ASSET)

## ----data file----------------------------------------------------------------
datafile <- system.file("sampleData", "vdata.rda", package="ASSET")

## ----load data----------------------------------------------------------------
load(datafile)
data1[1:5, ]

SNPs    <- paste("SNP", 1:3, sep="")
nSNP    <- length(SNPs)
studies <- paste("STUDY", 1:4, sep="") 
nStudy  <- length(studies)

## ----ncase ncontrol-----------------------------------------------------------
case    <- matrix(data=NA, nrow=nSNP, ncol=nStudy) 
control <- matrix(data=NA, nrow=nSNP, ncol=nStudy) 

for (i in 1:nStudy) {
  data <- eval(parse(text=paste("data", i, sep="")))
  caseVec <- data[, "CC"] == 1
  controlVec <- !caseVec
  for (j in 1:nSNP) {
    temp <- !is.na(data[, SNPs[j]])
    case[j, i] <- sum(caseVec & temp, na.rm=TRUE)
    control[j, i] <- sum(controlVec & temp, na.rm=TRUE)
  }
}
case
control

## ----log reg------------------------------------------------------------------
beta  <- matrix(data=NA, nrow=nSNP, ncol=nStudy) 
sigma <- matrix(data=NA, nrow=nSNP, ncol=nStudy) 
for (i in 1:nStudy) {
  data <- eval(parse(text=paste("data", i, sep="")))
  for (j in 1:nSNP) {
    data[, "SNP"] <- data[, SNPs[j]]
    fit <- glm(CC ~ AGE + SNP, data=data, family=binomial())
    coef <- summary(fit)$coefficients
    beta[j, i] <- coef["SNP", 1]
    sigma[j, i] <- coef["SNP", 2]
  }
}
beta
sigma


## ----h.traits-----------------------------------------------------------------
res <- h.traits(SNPs, studies, beta, sigma, case, control, meta=TRUE)

## ----summary table------------------------------------------------------------
h.summary(res)

## ----subset function----------------------------------------------------------
sub.def <- function(logicalVec) {
  sum <- sum(logicalVec)  
  ret <- all(logicalVec[1:sum])
  ret
}

## ----h.traits 2---------------------------------------------------------------
res <- h.traits(SNPs, studies, beta, sigma, case, control, meta=TRUE, 
         zmax.args=list(sub.def=sub.def), pval.args=list(sub.def=sub.def))

## ----summary table 2----------------------------------------------------------
h.summary(res)

## ----combine data-------------------------------------------------------------
data <- NULL
for (i in 1:nStudy) {
  temp <- eval(parse(text=paste("data", i, sep="")))
  temp[, "STUDY"]  <- i
  data <- rbind(data, temp)
}

## ----dummy vars---------------------------------------------------------------
for (i in 1:nStudy) {
  dvar <- paste("STUDY_", i, sep="")
  data[, dvar] <- as.numeric(data[, "STUDY"] %in% i)
}

## ----variables----------------------------------------------------------------
snp.vars <- paste("SNP", 1:3, sep="")
adj.vars <- c("AGE", "STUDY_1", "STUDY_2", "STUDY_3")
types.lab <- paste("TYPE_", 1:3, sep="")

## ----h.types------------------------------------------------------------------
ret <- h.types(data, "TYPE", snp.vars, adj.vars, types.lab, "CONTROL",
               logit=TRUE)

## ----h.types summary----------------------------------------------------------
h.summary(ret)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

