# Code example from 'bgafun' vignette. See references/ for full tutorial.

### R code from vignette source 'bgafun.rnw'

###################################################
### code chunk number 1: bgafun.rnw:46-49
###################################################
library(bgafun)
LDH <- read.alignment(file = system.file("sequences/LDH-MDH-PF00056.fasta", package = "bgafun"), format = "fasta")
class(LDH)


###################################################
### code chunk number 2: bgafun.rnw:55-63
###################################################
library(bgafun)
data(LDH)
LDH.amino=convert_aln_amino(LDH)
LDH.groups=rownames(LDH.amino)
LDH.groups[grep("LDH",LDH.groups)]="LDH"
LDH.groups[grep("MDH",LDH.groups)]="MDH"
LDH.groups=as.factor(LDH.groups)
LDH.groups


###################################################
### code chunk number 3: bgafun.rnw:78-85
###################################################
library(bgafun)
data(LDH)
data(LDH.groups)
LDH.amino=convert_aln_amino(LDH)
dim(LDH.amino)
LDH.amino.gapless=remove_gaps_groups(LDH.amino,LDH.groups)
dim(LDH.amino.gapless)


###################################################
### code chunk number 4: bgafun.rnw:91-95
###################################################
library(bgafun)
data(LDH.amino.gapless)
LDH.pseudo=LDH.amino.gapless+1
dim(LDH.pseudo)


###################################################
### code chunk number 5: bgafun.rnw:98-102
###################################################
library(bgafun)
data(LDH.amino.gapless)
LDH.pseudo=add_pseudo_counts(LDH.amino.gapless,LDH.groups)
dim(LDH.pseudo)


###################################################
### code chunk number 6: bgafun.rnw:119-126
###################################################
library(bgafun)
data(LDH)
data(LDH.groups)
LDH.aap=convert_aln_AAP(LDH)
dim(LDH.aap)
LDH.aap.ave=average_cols_aap(LDH.aap,LDH.groups)
dim(LDH.aap.ave)


###################################################
### code chunk number 7: bgafun.rnw:135-143
###################################################
library(bgafun)
data(LDH)
data(LDH.groups)
data(LDH.amino.gapless)
data(LDH.aap.ave)
LDH.aap.ave.bga=run_between_pca(LDH.amino.gapless,LDH.aap.ave,LDH.groups)
class(LDH.aap.ave.bga)



###################################################
### code chunk number 8: bgafun.rnw:147-151
###################################################
library(bgafun)
data(LDH.groups)
data(LDH.amino.gapless)
LDH.binary.bga=bga(t(LDH.amino.gapless+1),LDH.groups)


###################################################
### code chunk number 9: PCAplot
###################################################
plot(LDH.aap.ave.bga)


###################################################
### code chunk number 10: bgafun.rnw:172-174
###################################################
top_res=top_residues_2_groups(LDH.binary.bga)
names(top_res)=sub("X","",names(top_res))


###################################################
### code chunk number 11: bgafun.rnw:181-184
###################################################
LDH.profiles=create_profile_strings(LDH.amino,LDH.groups)
LDH.profiles[, colnames(LDH.profiles) %in% names(top_res)]



