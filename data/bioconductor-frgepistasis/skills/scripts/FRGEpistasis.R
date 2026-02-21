# Code example from 'FRGEpistasis' vignette. See references/ for full tutorial.

### R code from vignette source 'FRGEpistasis.Rnw'

###################################################
### code chunk number 1: FRGEpistasis.Rnw:72-74
###################################################
geno_info <- read.table(system.file("extdata", "simGeno-chr2.raw", package="FRGEpistasis"),header=TRUE)
geno_info[1:5,1:9]


###################################################
### code chunk number 2: FRGEpistasis.Rnw:80-83
###################################################
map_info <- read.table(system.file("extdata", "chr2.map", package="FRGEpistasis"))
map_info[1:5,]



###################################################
### code chunk number 3: FRGEpistasis.Rnw:89-91
###################################################
pheno_info <- read.csv(system.file("extdata", "phenotype.csv", package="FRGEpistasis"),header=TRUE)
pheno_info[1:5,]


###################################################
### code chunk number 4: FRGEpistasis.Rnw:98-100
###################################################
gene.list<-read.csv(system.file("extdata", "gene.list.csv", package="FRGEpistasis"))
gene.list


###################################################
### code chunk number 5: FRGEpistasis.Rnw:108-110
###################################################
geno_files<-read.table(system.file("extdata", "list_geno.txt", package="FRGEpistasis"))
geno_files


###################################################
### code chunk number 6: FRGEpistasis.Rnw:113-115
###################################################
map_files<-read.table(system.file("extdata", "list_map.txt", package="FRGEpistasis"))
map_files


###################################################
### code chunk number 7: FRGEpistasis.Rnw:129-159
###################################################
library("FRGEpistasis")
work_dir <-paste(system.file("extdata", package="FRGEpistasis"),"/",sep="")
##read the list of genotype files
geno_files<-read.table(system.file("extdata", "list_geno.txt", package="FRGEpistasis"))
##read the list of map files
mapFiles<-read.table(system.file("extdata", "list_map.txt", package="FRGEpistasis"))
##read the phenotype file
phenoInfo <- read.csv(system.file("extdata", "phenotype.csv", package="FRGEpistasis"),header=TRUE)
##read the gene annotation file
gLst<-read.csv(system.file("extdata", "gene.list.csv", package="FRGEpistasis"))
##define the extension scope of gene region
rng=0
fdr=0.05
## output data structure
out_epi <- data.frame( )

##log transformation
phenoInfo [,2]=log(phenoInfo [,2])

##rank transformation
#c=0.5
#phenoInfo[,2]=rankTransPheno(phenoInfo[,2],c)
# test epistasis with Functional Regression Model
out_epi = fRGEpistasis(work_dir,phenoInfo,geno_files,mapFiles,gLst,fdr,rng)
## output the result to physical file
write.csv(out_epi,"Output_Pvalues_Epistasis_Test.csv ")
##if you want to test epistasis with PCA method and pointwise method then
##implement the following command. This method is more slow than FRG method.
#out_pp <- data.frame( )
#out_pp <- pCAPiontwiseEpistasis(wDir,out_epi,phenoInfo,gnoFiles,mapFiles,gLst,rng)


