# Code example from 'semisup' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------
options(width=60)
knitr::knit_hooks$set(document = function(x) {sub('\\usepackage[]{color}', '\\usepackage{xcolor}', x, fixed = TRUE)})

## ----eval=FALSE-------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("semisup")

## ---------------------------------------------------------
library(semisup)

## ----eval=FALSE-------------------------------------------
# attach(toydata)

## ----echo=FALSE-------------------------------------------
names <- names(toydata)
for(i in seq_along(names)){
    assign(names[i],toydata[[i]])
}
rm(names)

## ----eval=FALSE-------------------------------------------
# help(semisup)
# ?semisup

## ----echo=FALSE,fig.width='\\linewidth',fig.height=3------
par(mar=(c(2,4,1,5)))
plot.new()
plot.window(xlim=c(1,length(y)),ylim=range(y))
box()
axis(side=2)
title(ylab="y")
mtext(text="labelled",at=25,side=1)
mtext(text="unlabelled",at=75,side=1)
abline(v=50.5,lty=2)
points(y,col=rep(c("blue","black"),each=50))

## ---------------------------------------------------------
fit <- mixtura(y,z)

## ----echo=FALSE-------------------------------------------
mean0 <- round(fit$estim1$mean0,0)
sd0 <- round(fit$estim1$sd0,0)
mean1 <- round(fit$estim1$mean1,0)
sd1 <- round(fit$estim1$sd1,0)
tau <- round(fit$estim1$p1,2)

## ----results='hide'---------------------------------------
class <- round(fit$posterior)

## ----echo=FALSE,fig.width='\\linewidth',fig.height=3------
par(mar=(c(2,4,1,5)))
plot.new()
plot.window(xlim=c(1,length(y)),ylim=range(y))
box()
axis(side=2)
title(ylab="y")
mtext(text="labelled",side=1,at=25)
mtext(text="unlabelled",side=1,at=75)
abline(v=50.5,lty=2)
points(y,col=ifelse(class,"red","blue"))

# component zero
text <- paste("N(",mean0,",",sd0,")",sep="")
mtext(text=text,side=4,at=0,line=0.5,las=1,col="blue")

# mixing proportion
text <- bquote(tau==.(tau))
mtext(text=text,side=4,at=2,line=0.5,las=2)

# component one
text <- paste("N(",mean1,",",sd1,")",sep="")
mtext(text=text,side=4,at=4,line=0.5,las=1,col="red")

## ----results='hide'---------------------------------------
fit$estim1

## ----results='hide'---------------------------------------
fit$estim0

## ----echo=FALSE,fig.width='\\linewidth',fig.height=3------
par(mar=(c(2,4,1,5)))
plot.new()
plot.window(xlim=c(1,length(y)),ylim=range(y))
box()
axis(side=2)
title(ylab="y")
mtext(text="labelled",side=1,at=25)
mtext(text="unlabelled",side=1,at=75)
abline(v=50.5,lty=2)
points(y,col="blue")

# estimates
mean0 <- round(fit$estim0$mean0,0)
sd0 <- round(fit$estim0$sd0,0)

# component zero
text <- paste("N(",mean0,",",sd0,")",sep="")
mtext(text=text,side=4,at=0,line=0.5,las=1,col="blue")

# mixing proportion
text <- bquote(tau==0)
mtext(text=text,side=4,at=2,line=0.5,las=2)

# component one
text <- paste("N(-,-)",sep="")
mtext(text=text,side=4,at=4,line=0.5,las=1,col="red")

## ----eval=FALSE-------------------------------------------
# scrutor(y,z)

## ----eval=FALSE-------------------------------------------
# n <- length(snp)
# 
# 
# z <- rep(NA,times=n)
# z[snp==0] <- 0

## ----eval=FALSE-------------------------------------------
# n <- nrow(SNPs)
# p <- ncol(SNPs)
# 
# Z <- matrix(NA,nrow=n,ncol=p)
# Z[SNPs==0] <- 0

## ----eval=FALSE-------------------------------------------
# scrutor(y,z)

## ----eval=FALSE-------------------------------------------
# scrutor(y,Z)

## ----eval=FALSE-------------------------------------------
# scrutor(Y,z)

## ----eval=FALSE-------------------------------------------
# scrutor(Y,Z)

