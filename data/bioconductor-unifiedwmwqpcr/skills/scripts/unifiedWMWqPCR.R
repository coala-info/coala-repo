# Code example from 'unifiedWMWqPCR' vignette. See references/ for full tutorial.

### R code from vignette source 'unifiedWMWqPCR.Rnw'

###################################################
### code chunk number 1: unifiedWMWqPCR.Rnw:140-145
###################################################
library('unifiedWMWqPCR')
data(NBmat)
dim(NBmat)
table(NBgroups)
max(NBmat)


###################################################
### code chunk number 2: unifiedWMWqPCR.Rnw:157-158
###################################################
uWMW.out <- uWMW(NBmat, groups = NBgroups)


###################################################
### code chunk number 3: unifiedWMWqPCR.Rnw:160-161
###################################################
uWMW.out


###################################################
### code chunk number 4: unifiedWMWqPCR.Rnw:165-170
###################################################
uWMW.out[1:3]
uWMW.out[1:3,]
names.tmp <- rownames(NBmat)[1:3]
names.tmp
uWMW.out[names.tmp] 


###################################################
### code chunk number 5: unifiedWMWqPCR.Rnw:174-175
###################################################
uWMW.out


###################################################
### code chunk number 6: unifiedWMWqPCR.Rnw:181-185
###################################################
selection.miRNA <- c("hsa-mir-17-3p", "hsa-mir-17-5p", "hsa-mir-18a", 
"hsa-mir-18a#","hsa-mir-19a", "hsa-mir-19b",
"hsa-mir-20a","hsa-mir-92", "hsa-mir-181a", "hsa-mir-181b")
uWMW.out[selection.miRNA]


###################################################
### code chunk number 7: unifiedWMWqPCR.Rnw:188-191
###################################################
adj.pvalues <- p.adjust(uWMW.out@p.value, method = "BH")
selection.id <- match(selection.miRNA, names(uWMW.out))
adj.pvalues[selection.id]


###################################################
### code chunk number 8: unifiedWMWqPCR.Rnw:195-197
###################################################
uWMW.out["hsa-mir-92"]
adj.pvalues[match("hsa-mir-92", names(uWMW.out))]


###################################################
### code chunk number 9: unifiedWMWqPCR.Rnw:206-208
###################################################
housekeeping.miRNA <- rownames(NBmat)[1:2]
housekeeping.miRNA


###################################################
### code chunk number 10: unifiedWMWqPCR.Rnw:211-213
###################################################
uWMW.out2 <- uWMW(NBmat, groups = NBgroups, 
housekeeping.names = housekeeping.miRNA)


###################################################
### code chunk number 11: unifiedWMWqPCR.Rnw:215-216
###################################################
uWMW.out2


###################################################
### code chunk number 12: volcano
###################################################
volcanoplot(uWMW.out, add.ref = c("both"), ref.x = c(-log(2),log(2)), 
ref.y = -log10(0.001))


###################################################
### code chunk number 13: volcano
###################################################
volcanoplot(uWMW.out, add.ref = c("both"), ref.x = c(-log(2),log(2)), 
ref.y = -log10(0.001))


###################################################
### code chunk number 14: forest
###################################################
x.label <- expression("estimated "*P(Y[MNA] < Y[MNSC]))
forestplot(uWMW.out, estimate = "p", order = selection.id, xlab = x.label) 


###################################################
### code chunk number 15: forest
###################################################
x.label <- expression("estimated "*P(Y[MNA] < Y[MNSC]))
forestplot(uWMW.out, estimate = "p", order = selection.id, xlab = x.label) 


###################################################
### code chunk number 16: unifiedWMWqPCR.Rnw:271-273
###################################################
coef(uWMW.out)[1:3]
vcov(uWMW.out)[1:3,1:3]


