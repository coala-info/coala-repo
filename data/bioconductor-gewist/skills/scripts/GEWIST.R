# Code example from 'GEWIST' vignette. See references/ for full tutorial.

### R code from vignette source 'GEWIST.rnw'

###################################################
### code chunk number 1: GEWIST.rnw:57-58
###################################################
options(width= 70)


###################################################
### code chunk number 2: GEWIST.rnw:62-68
###################################################
library(GEWIST)
optim_result <- gewistLevene(p=0.2, N=10000, theta_gc=0.002,
 theta_c=0.15, M = 250000, K = 20000, verbose = FALSE)

class(optim_result)
print(optim_result)


###################################################
### code chunk number 3: GEWIST.rnw:86-88
###################################################
optim_ver <- gewistLevene(p=0.2, N=10000, theta_gc=0.002,
theta_c=0.2, M = 250000, K = 20000, verbose = TRUE)


###################################################
### code chunk number 4: GEWIST.rnw:91-95
###################################################
plot(optim_ver, xlab = "Levene's test p-value threshold",
       ylab = "Variance prioritization Power" ,pch = 20)
abline(h = optim_ver[1000,2], col= "blue")
mtext("Figure 1",cex=2)      


###################################################
### code chunk number 5: GEWIST.rnw:122-126
###################################################
weibull_exp1 <- effectPDF(distribution = "weibull", parameter1 = 0.8, parameter2 = 0.3,
parameter3 = NULL, p = 0.1 ,N = 10000, theta_c = 0.1, M = 350000, K = 10000, nb_incr = 50, range = c(0.025/100,0.3/100), verbose = FALSE)

print(weibull_exp1)


###################################################
### code chunk number 6: GEWIST.rnw:142-146
###################################################
weibull_exp2 <- effectPDF(distribution = "weibull", parameter1 = 0.8, parameter2 = 0.3,
parameter3 = NULL, p = 0.1 ,N = 10000, theta_c = 0.1, M = 350000,
K = 10000, nb_incr = 50, range = c(0.025/100,0.3/100), verbose = T)



###################################################
### code chunk number 7: GEWIST.rnw:149-153
###################################################
plot(weibull_exp2, xlab = "Levene's test p-value threshold",
	ylab = "Expected variance prioritization power" ,pch = 20)
abline(h = weibull_exp2[,2][1000], col= "blue")	  
mtext("Figure 2",cex=2)      


###################################################
### code chunk number 8: GEWIST.rnw:163-209
###################################################

##### simulating SNPs 

# number of SNPs

	nb_SNPs <- 100
	MAF <- round(sample(seq(0.05,0.5,length.out= nb_SNPs)),2)
 	SNPset <- data.frame(SNPname = paste("SNP", seq(1: nb_SNPs)), MAF)
 
## genotype

# number of individuals
	N <- 10000

	genotype.gen <- function(maf,n){
	
	n0 <- round(n*(1-maf)^2)
	n1 <- round(n*maf*(1-maf)*2)
	n2 <- n-n0-n1	
	
	c(n0,n1,n2)}

GenoSet <- matrix(rep(NA,N*nb_SNPs),N,nb_SNPs)

for (i in 1:nb_SNPs){ 
GenoSet[,i] <- sample(rep(0:2,genotype.gen(SNPset[i,2],N)))
}

##### simulating Traits
error <- rnorm(N)
COV <-rnorm(N)

b3 <- matrix(sample(c(sample(seq(0.01,0.1,0.01),20, replace=T),rep(0,nb_SNPs-20))),nb_SNPs,1)
b2 <- 0.4

Trait <-  as.vector((COV*GenoSet)%*%b3) + COV*b2 + error

##### estimated theta_gc and theta_c

INTSNPs <- which(as.vector(b3)!=0)

num <- (as.vector(b3)[INTSNPs])^2*2*SNPset[INTSNPs,2]*(1-SNPset[INTSNPs,2])
dem <- (num+b2^2+1)

theta_c <- b2^2/mean(dem)
theta_gc <-   mean(num/dem)


###################################################
### code chunk number 9: GEWIST.rnw:228-240
###################################################
n  <- dim(GenoSet)[1]
m <- dim(GenoSet)[2]

library(car)

levene_pval <- NA

	for (i in 1: m) {
		
		levene_pval[i] <- leveneTest(Trait, as.factor(GenoSet[,i]),center = mean)[1,3]
		
			   }


###################################################
### code chunk number 10: GEWIST.rnw:252-262
###################################################

optimal_pval <- NA

for ( i in 1: m){
	
optimal_pval[i] <- gewistLevene(p = SNPset[i,2], N = n, theta_gc = theta_gc, 
theta_c = theta_c, M = m )$Optimal_pval
		
			    }
			    


###################################################
### code chunk number 11: GEWIST.rnw:276-288
###################################################

SNPind <- which(levene_pval < optimal_pval)

 Reduced <- GenoSet[,SNPind]
 
 intPval <- NA
 
 	for (j in 1: length(SNPind)) {
 
 		intPval[j] <- summary(lm(Trait~ Reduced[,j] * COV ))$coef[4,4]
		
 						}


