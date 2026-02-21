# Code example from 'SIM' vignette. See references/ for full tutorial.

### R code from vignette source 'SIM.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(continue="  ")
options(width=40)


###################################################
### code chunk number 2: SIM.Rnw:113-114 (eval = FALSE)
###################################################
## help(package="SIM")


###################################################
### code chunk number 3: SIM.Rnw:119-120
###################################################
library(SIM)


###################################################
### code chunk number 4: SIM.Rnw:125-128
###################################################
data(expr.data)
data(acgh.data)
data(samples)  


###################################################
### code chunk number 5: SIM.Rnw:133-135
###################################################
names(expr.data)
names(acgh.data)    


###################################################
### code chunk number 6: SIM.Rnw:140-147
###################################################
acgh.data.only <- acgh.data[, 5:ncol(acgh.data)] 
expr.data.only <- expr.data[, 5:ncol(expr.data)] 
acgh.data.s <- acgh.data.only[, order(colnames(acgh.data.only))] 
expr.data.s <- expr.data.only[, order(colnames(expr.data.only))] 
sum(colnames(expr.data.s) == colnames(acgh.data.s))
acgh.data <- cbind(acgh.data[, 1:4], acgh.data.s) 
expr.data <- cbind(expr.data[, 1:4], expr.data.s)  


###################################################
### code chunk number 7: SIM.Rnw:158-172
###################################################
assemble.data(dep.data = acgh.data, 
              indep.data = expr.data, 
              dep.ann = colnames(acgh.data)[1:4], 
              indep.ann = colnames(expr.data)[1:4], 
              dep.id = "ID", 
              dep.chr = "CHROMOSOME", 
              dep.pos = "STARTPOS", 
              dep.symb = "Symbol", 
              indep.id = "ID", 
              indep.chr = "CHROMOSOME", 
              indep.pos = "STARTPOS", 
              indep.symb = "Symbol", 
              overwrite = TRUE, 
              run.name = "chr8q")


###################################################
### code chunk number 8: SIM.Rnw:203-208
###################################################
integrated.analysis(samples = samples, 
                    input.regions = "8q", 
                    zscores = TRUE, 
                    method = "full", 
                    run.name = "chr8q")  


###################################################
### code chunk number 9: SIM.Rnw:221-224
###################################################
sim.plot.pvals.on.genome(input.regions = "8q", 
                         adjust.method = "BY", 
                         run.name = "chr8q")


###################################################
### code chunk number 10: SIM.Rnw:241-246
###################################################
tabulate.pvals(input.regions = "8q", 
               adjust.method = "BY", 
               bins = c(0.001, 0.005, 0.01, 0.025, 0.05, 0.075, 0.1, 0.2, 1), 
               significance.idx=8, 
               run.name = "chr8q")


###################################################
### code chunk number 11: SIM.Rnw:253-254
###################################################
sim.plot.pvals.on.region(input.regions = "8q", adjust.method = "BY", run.name = "chr8q") 


###################################################
### code chunk number 12: SIM.Rnw:278-279
###################################################
opar <- par(no.readonly = TRUE)


###################################################
### code chunk number 13: SIM.Rnw:282-297
###################################################
library(RColorBrewer)
sim.plot.zscore.heatmap(input.regions="8q", 
                        method="full", 
                        significance=0.005, 
                        z.threshold=3, 
                        colRamp=brewer.pal(11, "RdYlBu"), 
                        add.colRamp=rainbow(10),
                        show.names.indep=TRUE, 
                        show.names.dep=TRUE,
                        adjust.method="BY",                         
                        add.plot="smooth",
                        add.scale=c(-1, 3),
                        pdf=TRUE, 
                        run.name="chr8q")



###################################################
### code chunk number 14: SIM.Rnw:301-302
###################################################
par(opar)


###################################################
### code chunk number 15: SIM.Rnw:321-325
###################################################
table.dep <- tabulate.top.dep.features(input.regions = "8q",                                      
                                       adjust.method = "BY", 
                                       run.name = "chr8q")
head(table.dep[["8q"]])                  


###################################################
### code chunk number 16: SIM.Rnw:328-332
###################################################
table.indep <- tabulate.top.indep.features(input.regions = "8q", 
                                           adjust.method = "BY", 
                                           run.name = "chr8q")
head(table.dep[["8q"]])                        


###################################################
### code chunk number 17: SIM.Rnw:337-346
###################################################
sim.plot.overlapping.indep.dep.features(input.regions="8q", 
                                        adjust.method="BY", 
                                        significance=0.1, 
                                        z.threshold= c(-1,1),                                        
                                        log=TRUE,   
                                        summarize="consecutive",                                        
                                        pdf=TRUE, 
                                        method="full",
                                        run.name="chr8q")       


###################################################
### code chunk number 18: SIM.Rnw:380-381
###################################################
toLatex(sessionInfo())


