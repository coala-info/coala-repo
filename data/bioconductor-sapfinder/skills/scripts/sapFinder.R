# Code example from 'sapFinder' vignette. See references/ for full tutorial.

### R code from vignette source 'sapFinder.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: createdb
###################################################
library(sapFinder)
vcf <- system.file("extdata/sapFinder_test.vcf",
                    package="sapFinder")
annotation <- system.file("extdata/sapFinder_test_ensGene.txt",
                    package="sapFinder")
refseq <- system.file("extdata/sapFinder_test_ensGeneMrna.fa",
                    package="sapFinder")
xref       <- system.file("extdata/sapFinder_test_BioMart.Xref.txt",
                    package="sapFinder")
outdir <- "db_dir"
prefix <- "sapFinder_test"
db.files <- dbCreator(vcf=vcf, annotation=annotation,
                    refseq=refseq, outdir=outdir,
                    prefix=prefix,xref=xref)


###################################################
### code chunk number 3: databasesearching
###################################################
outdir<-"."
mgf.path <- system.file("extdata/sapFinder_test.mgf",
                    package="sapFinder")
protein.db <- db.files[1]
xml.path <- runTandem(spectra=mgf.path, fasta=protein.db, 
                    outdir = outdir,tol=10, tolu="ppm", 
                    itol=0.1, itolu="Daltons")


###################################################
### code chunk number 4: parserGear
###################################################
parserGear(file=xml.path, db=db.files[1],
            outdir='parser_outdir', prefix=prefix)


###################################################
### code chunk number 5: mascotParser (eval = FALSE)
###################################################
## dat_file<-"mascot_raw.dat"
## parserGear(file=dat_file, db=db.files[1],
##             outdir='parser_outdir', prefix=prefix)


###################################################
### code chunk number 6: reportg
###################################################
reportCreator(indir="parser_outdir", 
                db= db.files[1], varInfor=db.files[2],prefix=prefix)


###################################################
### code chunk number 7: auto
###################################################
vcf        <- system.file("extdata/sapFinder_test.vcf",
                        package="sapFinder")
annotation <- system.file("extdata/sapFinder_test_ensGene.txt",
                        package="sapFinder")
refseq     <- system.file("extdata/sapFinder_test_ensGeneMrna.fa",
                        package="sapFinder")
mgf.path   <- system.file("extdata/sapFinder_test.mgf",
                        package="sapFinder")
xref       <- system.file("extdata/sapFinder_test_BioMart.Xref.txt",
                        package="sapFinder")
easyRun(vcf=vcf,annotation=annotation,refseq=refseq,
        outdir="test",prefix="sapFinder_test",
        spectra=mgf.path,cpu=0,tol=10, tolu="ppm", 
        itol=0.1,itolu="Daltons",xref=xref)


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo())


