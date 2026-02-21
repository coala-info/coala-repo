# Code example from 'Formats' vignette. See references/ for full tutorial.

### R code from vignette source 'Formats.Rnw'

###################################################
### code chunk number 1: Formats.Rnw:170-178
###################################################
library(GWASTools)
library(SNPRelate)
bed.fn <- system.file("extdata", "plinkhapmap.bed.gz", package="SNPRelate")
fam.fn <- system.file("extdata", "plinkhapmap.fam.gz", package="SNPRelate")
bim.fn <- system.file("extdata", "plinkhapmap.bim.gz", package="SNPRelate")
gdsfile <- "snps.gds"
snpgdsBED2GDS(bed.fn, fam.fn, bim.fn, gdsfile, family=TRUE,
              cvt.chr="int", cvt.snpid="int", verbose=FALSE)


###################################################
### code chunk number 2: Formats.Rnw:188-215
###################################################
(gds <- GdsGenotypeReader(gdsfile, YchromCode=24L, XYchromCode=25L))
scanID <- getScanID(gds)
family <- getVariable(gds, "sample.annot/family")
father <- getVariable(gds, "sample.annot/father")
mother <- getVariable(gds, "sample.annot/mother")
sex <- getVariable(gds, "sample.annot/sex")
sex[sex == ""] <- NA # sex must be coded as M/F/NA
phenotype <- getVariable(gds, "sample.annot/phenotype")
scanAnnot <- ScanAnnotationDataFrame(data.frame(scanID, father, mother, 
                                                sex, phenotype,
                                                stringsAsFactors=FALSE))

snpID <- getSnpID(gds)
chromosome <- getChromosome(gds)
position <- getPosition(gds)
alleleA <- getAlleleA(gds)
alleleB <- getAlleleB(gds)
rsID <- getVariable(gds, "snp.rs.id")
snpAnnot <- SnpAnnotationDataFrame(data.frame(snpID, chromosome, position,
                                              rsID, alleleA, alleleB,
                                              stringsAsFactors=FALSE),
                                   YchromCode=24L, XYchromCode=25L)

genoData <- GenotypeData(gds, scanAnnot=scanAnnot, snpAnnot=snpAnnot)
getGenotype(genoData, snp=c(1,5), scan=c(1,5))

close(genoData)


###################################################
### code chunk number 3: Formats.Rnw:218-219
###################################################
unlink(gdsfile)


###################################################
### code chunk number 4: Formats.Rnw:228-233
###################################################
library(GWASTools)
library(SNPRelate)
vcffile <- system.file("extdata", "sequence.vcf", package="SNPRelate")
gdsfile <- "snps.gds"
snpgdsVCF2GDS(vcffile, gdsfile, verbose=FALSE)


###################################################
### code chunk number 5: Formats.Rnw:240-260
###################################################
(gds <- GdsGenotypeReader(gdsfile))
getScanID(gds)

snpID <- getSnpID(gds)
chromosome <- as.integer(getChromosome(gds))
position <- getPosition(gds)
alleleA <- getAlleleA(gds)
alleleB <- getAlleleB(gds)
rsID <- getVariable(gds, "snp.rs.id")
qual <- getVariable(gds, "snp.annot/qual")
filter <- getVariable(gds, "snp.annot/filter")
snpAnnot <- SnpAnnotationDataFrame(data.frame(snpID, chromosome, position,
                                              rsID, alleleA, alleleB,
                                              qual, filter,
                                              stringsAsFactors=FALSE))

genoData <- GenotypeData(gds, snpAnnot=snpAnnot)
getGenotype(genoData)

close(genoData)


###################################################
### code chunk number 6: Formats.Rnw:263-264
###################################################
unlink(gdsfile)


