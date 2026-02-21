# Code example from 'CORREP' vignette. See references/ for full tutorial.

### R code from vignette source 'CORREP.Rnw'

###################################################
### code chunk number 1: CORREP.Rnw:221-228
###################################################
library(CORREP)
data(gal_all)
##Take average
gal_avg <- apply(gal_all, 1, function(x) c(mean(x[1:4]), mean(x[5:8]), mean(x[9:12]), mean(x[13:16]), mean(x[17:20]), mean(x[21:24]), mean(x[25:28]), mean(x[29:32]), mean(x[33:36]), mean(x[37:40]), mean(x[41:44]), mean(x[45:48]),
mean(x[49:52]), mean(x[53:56]), mean(x[57:60]), mean(x[61:64]), mean(x[65:68]), mean(x[69:72]), mean(x[73:76]), mean(x[77:80])))
##Estimate routine correlation based on average profile
M1 <- cor(gal_avg)


###################################################
### code chunk number 2: CORREP.Rnw:238-252
###################################################
##Take the first row and format
x <- gal_all[1,]
x <- cbind(t(x[1:4]),t(x[5:8]),t(x[9:12]),t(x[13:16]),t(x[17:20]),t(x[21:24]),t(x[25:28]),t(x[29:32]),t(x[33:36]),t(x[37:40]),t(x[41:44]),t(x[45:48]),t(x[49:52]),t(x[53:56]),t(x[57:60]),t(x[61:64]),t(x[65:68]),t(x[69:72]),t(x[73:76]),t(x[77:80]))
##Loop through to format each row
for(j in 2:205)
{
y <- gal_all[j,]
y <- cbind(t(y[1:4]),t(y[5:8]),t(y[9:12]),t(y[13:16]),t(y[17:20]),t(y[21:24]),t(y[25:28]),t(y[29:32]),t(y[33:36]),t(y[37:40]),t(y[41:44]),t(y[45:48]),t(y[49:52]),t(y[53:56]),t(y[57:60]),t(y[61:64]),t(y[65:68]),t(y[69:72]),t(y[73:76]),t(y[77:80]))
x <- rbind(x,y)
}
boxplot(cor(x))
rawdata <- x
stddata <- apply(rawdata, 1, function(x) x/sd(x))
stddata <- t(stddata)


###################################################
### code chunk number 3: CORREP.Rnw:260-261
###################################################
M <- cor.balance(stddata, m = 4, G= 205)


###################################################
### code chunk number 4: CORREP.Rnw:267-269
###################################################
row.names(M) <- row.names(M1)
colnames(M) <- colnames(M1)


###################################################
### code chunk number 5: CORREP.Rnw:273-277
###################################################
M.rep <- 1-M
M.avg <- 1-M1
d.rep <- as.dist(M.rep)
d.avg <- as.dist(M.avg)


###################################################
### code chunk number 6: CORREP.Rnw:281-286
###################################################
library(e1071)
library(cluster)
data(true.member)
g.rep <- diana(d.rep)
g.avg <- diana(d.avg)


###################################################
### code chunk number 7: CORREP.Rnw:294-296
###################################################
h.rep <- hclust(d.rep, method = "complete")
h.avg <- hclust(d.avg, method = "complete")


###################################################
### code chunk number 8: CORREP.Rnw:302-306
###################################################
member.rep.k4 <- cutree(g.rep, k = 4)
member.avg.k4 <- cutree(g.avg, k = 4)
classAgreement(table(member.avg.k4, as.matrix(true.member)))
classAgreement(table(member.rep.k4, as.matrix(true.member)))


###################################################
### code chunk number 9: CORREP.Rnw:321-325
###################################################
sil.rep4 <- silhouette(member.rep.k4, d.rep)
sil.avg4 <- silhouette(member.avg.k4, d.avg)
plot(sil.rep4, nmax = 80, cex.names = 0.5)
plot(sil.avg4, nmax = 80, cex.names = 0.5)


