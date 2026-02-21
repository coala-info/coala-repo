# Code example from 'intansvOverview' vignette. See references/ for full tutorial.

### R code from vignette source 'intansvOverview.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=72)


###################################################
### code chunk number 2: biocManager (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("intansv")


###################################################
### code chunk number 3: initialize
###################################################
library("intansv")


###################################################
### code chunk number 4: read in results of BreakDancer
###################################################
breakdancer.file.path <- system.file("extdata/ZS97.breakdancer.sv",
                               package="intansv")
breakdancer.file.path
breakdancer <- readBreakDancer(breakdancer.file.path)
str(breakdancer)


###################################################
### code chunk number 5: read in results of cnvnator
###################################################
cnvnator.dir.path <- system.file("extdata/cnvnator", package="intansv")
cnvnator.dir.path
cnvnator <- readCnvnator(cnvnator.dir.path)
str(cnvnator)


###################################################
### code chunk number 6: read in results of SVseq2
###################################################
svseq.dir.path <- system.file("extdata/svseq2", package="intansv")
svseq.dir.path
svseq <- readSvseq(svseq.dir.path)
str(svseq)


###################################################
### code chunk number 7: read in results of DELLY
###################################################
delly.file.path <- system.file("extdata/ZS97.DELLY.vcf", package="intansv")
delly.file.path
delly <- readDelly(delly.file.path)
str(delly)


###################################################
### code chunk number 8: read in results of Pindel
###################################################
pindel.dir.path <- system.file("extdata/pindel", package="intansv")
pindel.dir.path
pindel <- readPindel(pindel.dir.path)
str(pindel)


###################################################
### code chunk number 9: read in results of Lumpy
###################################################
lumpy.file.path <- system.file("extdata/ZS97.LUMPY.vcf",
                   package="intansv")
lumpy.file.path
lumpy <- readLumpy(lumpy.file.path)
str(lumpy)


###################################################
### code chunk number 10: read in results of softSearch
###################################################
softSearch.file.path <- system.file("extdata/ZS97.softsearch", package="intansv")
softSearch.file.path
softSearch <- readSoftSearch(softSearch.file.path)
str(softSearch)


###################################################
### code chunk number 11: MethodsMerge
###################################################
sv_all_methods <- methodsMerge(breakdancer, pindel, cnvnator, delly, svseq)
str(sv_all_methods)


###################################################
### code chunk number 12: MethodsMerge
###################################################
sv_all_methods.nopindel <- methodsMerge(breakdancer,cnvnator,delly,svseq)
str(sv_all_methods.nopindel)


###################################################
### code chunk number 13: read in annotation file into R
###################################################
anno.file.path <- system.file("extdata/chr05_chr10.anno.txt", package="intansv")
anno.file.path
msu_gff_v7 <- read.table(anno.file.path, head=TRUE, as.is=TRUE)
head(msu_gff_v7)


###################################################
### code chunk number 14: sv annotation
###################################################
sv_all_methods.anno <- llply(sv_all_methods,svAnnotation,
                             genomeAnnotation=msu_gff_v7)
names(sv_all_methods.anno)
head(sv_all_methods.anno$del)


###################################################
### code chunk number 15: genomic_distribution
###################################################
genome.file.path <- system.file("extdata/chr05_chr10.genome.txt", package="intansv")
genome.file.path
genome <- read.table(genome.file.path, head=TRUE, as.is=TRUE)
plotChromosome(genome, sv_all_methods,1000000)


###################################################
### code chunk number 16: region_visualization
###################################################
head(msu_gff_v7, n=3)
plotRegion(sv_all_methods,msu_gff_v7, "chr05", 1, 200000)


###################################################
### code chunk number 17: intansvOverview.Rnw:309-310
###################################################
sessionInfo()


