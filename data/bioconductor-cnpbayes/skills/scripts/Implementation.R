# Code example from 'Implementation' vignette. See references/ for full tutorial.

## ----lib, message=FALSE----------------------------------------------------
library(CNPBayes)
library(ggplot2)

## ----McmcParams------------------------------------------------------------
mp <- McmcParams(iter=1000, burnin=100, thin=1, nStarts=4)

## ----hyperparameters-------------------------------------------------------
  Hyperparameters()
  HyperparametersMultiBatch()

## ----hplist----------------------------------------------------------------
hp.list <- hpList()
names(hp.list)
hp.list[["SB"]] ## hyperparameters for SB model
hp.list <- hpList(k=3) ## each object will have hyperparameters for a 3-component mixture model
k(hp.list[["SB"]])

## ----graph-marginal, echo=FALSE--------------------------------------------
library(grid)
bayesianGrob <- function(x, r=unit(0.25, "inches")){
  tg <- textGrob(x)
  cg <- circleGrob(r=r)
  boxedText <- gTree(children=gList(tg, cg))
}

grobY <- bayesianGrob(expression(y[i]))
grobThetas <- bayesianGrob(expression(theta[h]))
grobSigma2 <- bayesianGrob(expression(sigma[h]^2))
grobH <- bayesianGrob(expression(z[i]))
grobNu0 <- bayesianGrob(expression(nu[0]))
grobSigma02 <- bayesianGrob(expression(sigma[0]^2))
grobPi <- bayesianGrob(expression(pi[h]))
grobMu <- bayesianGrob(expression(mu[h]))
grobTau2 <- bayesianGrob(expression(tau[h]^2))

h <- unit(0.25, "inches")
e <- unit(0.05, "inches")
d <- unit(0.025, "inches")

ar <- arrow(ends="last", length=unit(0.075, "inches"), type="closed")
grid.newpage()
y.x <- 0.5; y.y <- 0.1
h.x <- 0.1; h.y <- 0.3
theta.x <- 0.5; theta.y <- 0.3
sigma2.x <- 0.7; sigma2.y <- 0.3
pi.x <- 0.1; pi.y <- 0.5
mu.x <- 0.45; mu.y <- 0.5
tau2.x <- 0.55; tau2.y <- 0.5
nu0.x <- 0.65; nu0.y <- 0.5
s20.x <- 0.75; s20.y <- 0.5
grid.draw(editGrob(grobY, vp=viewport(y.x, y.y), gp=gpar(fill="gray")))
grid.draw(editGrob(grobY, vp=viewport(y.x, y.y), gp=gpar(fill="transparent")))
grid.draw(editGrob(grobH, vp=viewport(h.x, h.y)))

grid.draw(editGrob(grobThetas, vp=viewport(theta.x, theta.y)))
grid.draw(editGrob(grobSigma2, vp=viewport(sigma2.x, sigma2.y)))

## theta -> y
grid.move.to(unit(theta.x, "npc"), unit(theta.y, "npc") - h)
grid.line.to(unit(y.x, "npc"), unit(y.y, "npc") + h, arrow=ar,
             gp=gpar(fill="black"))
## sigma2 -> y
grid.move.to(unit(sigma2.x, "npc") - e, unit(sigma2.y, "npc") -h)
grid.line.to(unit(y.x, "npc") + h, unit(y.y, "npc") + h, arrow=ar,
             gp=gpar(fill="black"))

## h -> theta
grid.move.to(unit(h.x, "npc") + h, unit(h.y, "npc") - h)
grid.line.to(unit(y.x, "npc") - h, unit(y.y, "npc") + h,  arrow=ar,
             gp=gpar(fill="black"))

##pi
grid.draw(editGrob(grobPi, vp=viewport(pi.x, pi.y)))
## pi -> h
grid.move.to(x=unit(pi.x, "npc"), y=unit(pi.y, "npc") - h)
grid.line.to(x=unit(h.x, "npc"),
             y=unit(h.y, "npc")+h, arrow=ar,
             gp=gpar(fill="black"))


## mu_h
grid.draw(editGrob(grobMu, vp=viewport(mu.x, mu.y)))
## mu_h -> theta
grid.move.to(x=unit(mu.x, "npc")+e, y=unit(mu.y, "npc") - h)
grid.line.to(x=unit(theta.x, "npc")-e, y=unit(theta.y, "npc")+h, arrow=ar,
             gp=gpar(fill="black"))


## sigma2_h
grid.draw(editGrob(grobTau2, vp=viewport(tau2.x, tau2.y)))
## sigma2_h -> theta_h
grid.move.to(x=unit(tau2.x, "npc")-e, y=unit(tau2.y, "npc") - h)
grid.line.to(x=unit(theta.x, "npc")+e, y=unit(theta.y, "npc")+h, arrow=ar,
             gp=gpar(fill="black"))

grid.draw(editGrob(grobNu0, vp=viewport(nu0.x, nu0.y)))
## nu_0 -> sigma2_0
grid.move.to(x=unit(nu0.x, "npc")+e, y=unit(nu0.y, "npc") - h)
grid.line.to(x=unit(sigma2.x, "npc")-e, y=unit(sigma2.y, "npc")+h, arrow=ar,
             gp=gpar(fill="black"))

grid.draw(editGrob(grobSigma02, vp=viewport(s20.x, s20.y)))
## nu_0 -> sigma2_0
grid.move.to(x=unit(s20.x, "npc")-e, y=unit(s20.y, "npc") - h)
grid.line.to(x=unit(sigma2.x, "npc")+e, y=unit(sigma2.y, "npc")+h, arrow=ar,
             gp=gpar(fill="black"))

## ----simulateData----------------------------------------------------------
set.seed(123)
sim.data <- simulateData(N=1000, p=rep(1/3, 3),
                         theta=c(-1, 0, 1),
                         sds=rep(0.1, 3))

## ----batch-----------------------------------------------------------------
## Create McmcParams for batch model
mp <- McmcParams(iter=600, burnin=100, thin=1, nStarts=4)
model.list <- gibbs(model="SB", dat=y(sim.data), k_range=c(3, 3), mp=mp)

## ----model_selection-------------------------------------------------------
round(sapply(model.list, marginal_lik), 1)
names(model.list)[1]

## ----bic-------------------------------------------------------------------
round(sapply(model.list, bic), 1)

## ----mapComponents---------------------------------------------------------
model <- model.list[[1]]
cn.model <- CopyNumberModel(model)
mapping(cn.model)

## ----mapping---------------------------------------------------------------
ggMixture(cn.model)

## ----probCopyNumber--------------------------------------------------------
head(probCopyNumber(cn.model))

## ----mapping_manual--------------------------------------------------------
cn.model2 <- cn.model
mapping(cn.model2) <- c("1", "1", "2")
head(probCopyNumber(cn.model2))

## ----ggMixture-------------------------------------------------------------
ggMixture(cn.model2)

## ----collapseBatch, eval=FALSE---------------------------------------------
#  k <- 3
#  nbatch <- 3
#  means <- matrix(c(-1.2, -1.0, -1.0,
#                  -0.2, 0, 0,
#                  0.8, 1, 1), nbatch, k, byrow=FALSE)
#  sds <- matrix(0.1, nbatch, k)
#  N <- 500
#  sim.data <- simulateBatchData(N=N,
#                                batch=rep(letters[1:3], length.out=N),
#                                theta=means,
#                                sds=sds,
#                                p=c(1/5, 1/3, 1-1/3-1/5))
#  ggMixture(sim.data)

## ----MBP, eval=FALSE-------------------------------------------------------
#  gibbs(model=MBP, k_range=c(3, 3))

## ----fit_many, eval=FALSE--------------------------------------------------
#  model.list <- gibbs(model=c("SBP", "MBP"), k_range=c(1, 5),
#                      dat=y(sim.data),
#                      batches=batches, mp=mp)

