# Code example from 'triform' vignette. See references/ for full tutorial.

### R code from vignette source 'triform.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: Loading triform
###################################################
library(triform)


###################################################
### code chunk number 2: Preprocessing BED files using configuration file
###################################################
config.file.path = system.file("extdata", "config.yml", package="triform")
data.file.path = system.file("extdata", package="triform")
preprocess(config.file.path, params=list(READ.PATH=data.file.path, COVER.PATH=data.file.path))


###################################################
### code chunk number 3: <Running triform using configuration file
###################################################
  triform(config.file.path, params=list(COVER.PATH=data.file.path))


###################################################
### code chunk number 4: session info
###################################################
  sessionInfo()


