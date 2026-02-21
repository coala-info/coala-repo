# Code example from 'ceu1kgv' vignette. See references/ for full tutorial.

### R code from vignette source 'ceu1kgv.Rnw'

###################################################
### code chunk number 1: lkd
###################################################
dochrGr = function(chrn, ids, which, genome="hg19",
 path2vcf = "/proj/rerefs/reref00/1000Genomes_Phase1_v3/ALL/") {
Require(VariantAnnotation)
Require(snpStats)
 allvc = dir(path2vcf, patt="ALL.*gz$",
  full=TRUE)
 f_ind = grep(paste0(chrn, "\\."), allvc)
 cpath = allvc[f_ind]
 stopifnot(file.exists(cpath))
 stopifnot(length(cpath)==1)
 vp = ScanVcfParam( info=NA, geno="GT", fixed="ALT", samples=ids,
        which=which )
 tmp = readVcf( cpath, genome=genome, param=vp )
 sz = prod(dim(tmp))
 if (sz == 0) return(NULL)
 genotypeToSnpMatrix(tmp)$genotypes
}


###################################################
### code chunk number 2: get22
###################################################
library(GGBase)
c22 = getSS("ceu1kgv", "chr22")
c22


###################################################
### code chunk number 3: lksess
###################################################
sessionInfo()


