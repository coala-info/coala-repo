# Code example from 'manta' vignette. See references/ for full tutorial.

### R code from vignette source 'manta.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: foo
###################################################
options(keep.source = TRUE, width = 60)
foo <- packageDescription("manta")


###################################################
### code chunk number 2: loadlib
###################################################
library(manta)


###################################################
### code chunk number 3: manta.Rnw:72-79
###################################################

cts.path <- system.file("extdata","PapaGO-BWA.counts-diatoms.tab", package="manta")
cts <- read.delim(cts.path)
samples <- makeSampleDF(cts)
obj.simple <- manta(counts= cts, samples = samples)
print(obj.simple)



###################################################
### code chunk number 4: counts2manta
###################################################
cts.path <- system.file("extdata","PapaGO-BWA.counts-diatoms.tab", package="manta")
cts <- read.delim(cts.path)
cts.annot.path <- system.file("extdata","PapaGO-BWA.annot-diatoms.tab", package="manta")
cts.annot <- read.delim(cts.annot.path, stringsAsFactors=FALSE)

obj <- counts2manta(cts, annotation=cts.annot,
                    a.merge.clmn='query_seq', agg.clmn='what_def', meta.clmns=c('family','genus_sp'),
                    gene.clmns=c('what_def','kid','pathway'))


###################################################
### code chunk number 5: align2manta
###################################################
align.path <- system.file("extdata","PapaGO-BLAST.results-diatoms.tab", package="manta")
annot.diatoms <- read.delim(align.path, stringsAsFactors=FALSE)
obj <- align2manta(annot.diatoms, cond.clmn='treatment', agg.clmn='what_def',
			gene.clmns=c('what_def','kid','pathway'), 
			meta.clmns=c('family','genus_sp'))


###################################################
### code chunk number 6: readSeastar
###################################################
conditions <- caroline::nv(factor(x=1:2, labels=c('ambient','plusFe')),c('ref','obs'))
ss.names <- caroline::nv(paste('Pgranii-',conditions,'.seastar', sep=''), conditions)
ss.paths <- system.file("extdata",ss.names, package="manta")

df <- readSeastar(ss.paths[1])



###################################################
### code chunk number 7: pplacer2manta
###################################################
KOG.SQLite.repo <- system.file("extdata","pplacer", package="manta")
obj.KOG <- pplacer2manta(dir=KOG.SQLite.repo, 
 	                 groups=c('coastal','costal','DCM','surface','upwelling'),
 	                 norm=FALSE, disp=FALSE
 	                 )



###################################################
### code chunk number 8: compbiasPlot
###################################################
compbiasPlot(obj, pair=conditions, meta.lev='genus_sp', meta.lev.lim=7)


###################################################
### code chunk number 9: fig1
###################################################
compbiasPlot(obj, pair=conditions, meta.lev='genus_sp', meta.lev.lim=7)


###################################################
### code chunk number 10: compbiasTest
###################################################

compbiasTest(obj, meta.lev='genus_sp')


###################################################
### code chunk number 11: compbiasTest2
###################################################
annot.diatoms.sub <- subset(annot.diatoms,  !genus_sp %in% paste('Pseudo-nitzschia',c('granii','australis')))
obj.sub <- align2manta(annot.diatoms.sub, cond.clmn='treatment', agg.clmn='what_def',
				gene.clmns=c('what_def','kid','pathway'), 
				meta.clmns=c('family','genus_sp'))
compbiasTest(obj.sub, meta.lev='genus_sp')


###################################################
### code chunk number 12: dispersion2
###################################################
obj.sub <- calcNormFactors(obj.sub)
obj.sub <- estimateCommonDisp(obj.sub) 


###################################################
### code chunk number 13: dispersion2manual
###################################################
obj.sub <- estimateGLMCommonDisp(obj.sub, method="deviance", robust=TRUE , subset=NULL)
obj.sub$common.dispersion


###################################################
### code chunk number 14: exacttest
###################################################
test <- exactTest(obj.sub)  # edgeR


###################################################
### code chunk number 15: outliers
###################################################
topTags(test, n=5)
out <- outGenes(test) 


###################################################
### code chunk number 16: plotmanta
###################################################
obj.sub$nr <- nf2nr(x=obj.sub, pair=conditions)

plot(obj.sub, main='Diatom Gene Expression\n at Ocean Station Papa', meta.lev='genus_sp', pair=conditions, lgd.pos='bottomright')


###################################################
### code chunk number 17: fig2
###################################################
obj.sub$nr <- nf2nr(x=obj.sub, pair=conditions)

plot(obj.sub, main='Diatom Gene Expression\n at Ocean Station Papa', meta.lev='genus_sp', pair=conditions, lgd.pos='bottomright')


###################################################
### code chunk number 18: plotdetest
###################################################
with(test$table, plot(logCPM, logFC))



###################################################
### code chunk number 19: fig3
###################################################
with(test$table, plot(logCPM, logFC))



###################################################
### code chunk number 20: hyperplot
###################################################
caroline::hyperplot(obj, annout=out, browse=FALSE) 


