# Code example from 'decompTumor2Sig' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
library(BiocStyle)

## ----echo = FALSE-------------------------------------------------------------
library(knitr)

## ----results='hide', message=FALSE--------------------------------------------
library(decompTumor2Sig)

## ----message=FALSE, warning=FALSE---------------------------------------------
signatures <- readAlexandrovSignatures()
length(signatures)
signatures[1]

## ----eval=FALSE---------------------------------------------------------------
# signatures <- readAlexandrovSignatures(file="<signature_file>")

## -----------------------------------------------------------------------------
# take the example signature flat files provided with decompTumor2Sig
sigfiles <- system.file("extdata",
                 paste0("Nik-Zainal_PMID_22608084-pmsignature-sig",1:4,".tsv"),
                 package="decompTumor2Sig")

# read the signature flat files
signatures <- readShiraishiSignatures(files=sigfiles)
signatures[1]

## -----------------------------------------------------------------------------
# load example signatures for breast cancer genomes from Nik-Zainal et al
# (PMID: 22608084) in the format produced by pmsignature (PMID: 26630308)
pmsigdata <- system.file("extdata",
          "Nik-Zainal_PMID_22608084-pmsignature-Param.Rdata", 
          package="decompTumor2Sig")
load(pmsigdata)
 
# extract the signatures from the pmsignature 'Param' object
signatures <- getSignaturesFromEstParam(Param)
signatures[1]

## ----message=FALSE, warning=FALSE---------------------------------------------
sign_a <- readAlexandrovSignatures()
sign_s <- convertAlexandrov2Shiraishi(sign_a)
sign_s[1]

## ----message=FALSE, warning=FALSE---------------------------------------------
# get Alexandrov signatures from COSMIC
signatures <- readAlexandrovSignatures()

signatures$Signature.1[1:5]


# get gene annotation for the default reference genome (hg19)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# get a GRanges object for gene promoters (-2000 to +200 bases from TSS)
library(GenomicRanges)
regionsTarget <- promoters(txdb, upstream=2000, downstream=200)

# adjust signatures according to nucleotide frequencies in this subset of
# the genome
sign_adj <-
   adjustSignaturesForRegionSet(signatures,
            regionsTarget, regionsOriginal=NULL,
            refGenome=BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19)

sign_adj$Signature.1[1:5]

## -----------------------------------------------------------------------------
isAlexandrovSet(sign_a)
isSignatureSet(sign_a)
isShiraishiSet(sign_s)
isSignatureSet(sign_s)
sameSignatureFormat(sign_a, sign_s)

## -----------------------------------------------------------------------------
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take the six breast cancer genomes from Nik-Zainal et al (PMID: 22608084) 
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz",
                     package="decompTumor2Sig")

# read the cancer genomes in VCF format
genomes <- readGenomesFromVCF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)
length(genomes)
genomes[1:2]

## -----------------------------------------------------------------------------
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take the six breast cancer genomes from Nik-Zainal et al (PMID: 22608084) 
gfile <- system.file("extdata", "Nik-Zainal_PMID_22608084-MPF.txt.gz", 
                     package="decompTumor2Sig")

# read the cancer genomes in MPF format
genomes <- readGenomesFromMPF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)

## -----------------------------------------------------------------------------
# get breast cancer genomes from Nik-Zainal et al (PMID: 22608084) 
# in the format produced by pmsignature (PMID: 26630308)
pmsigdata <- system.file("extdata", 
                         "Nik-Zainal_PMID_22608084-pmsignature-G.Rdata", 
                         package="decompTumor2Sig")
load(pmsigdata)

# extract the genomes from the pmsignature 'G' object
genomes <- getGenomesFromMutFeatData(G, normalize=TRUE)
genomes[1]

## ----message=FALSE------------------------------------------------------------
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take six breast cancer genomes from Nik-Zainal et al (PMID: 22608084) 
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz", 
                     package="decompTumor2Sig")

# get the corresponding VRanges object (using the VariantAnnotation package)
library(VariantAnnotation)
vr <- readVcfAsVRanges(gfile, genome="hg19")

# convert the VRanges object to the decompTumor2Sig format
genomes <- convertGenomesFromVRanges(vr, numBases=5, type="Shiraishi",
                                     trDir=TRUE, refGenome=refGenome,
                                     transcriptAnno=transcriptAnno,
                                     verbose=FALSE)

## -----------------------------------------------------------------------------
signatures <- readAlexandrovSignatures()
plotMutationDistribution(signatures[[1]])

## -----------------------------------------------------------------------------
sigfiles <- system.file("extdata",
                 paste0("Nik-Zainal_PMID_22608084-pmsignature-sig",1:4,".tsv"), 
                 package="decompTumor2Sig")
signatures <- readShiraishiSignatures(files=sigfiles)

plotMutationDistribution(signatures[[1]])

## ----echo=FALSE---------------------------------------------------------------
include_graphics("example-sign-Shiraishi.png")

## -----------------------------------------------------------------------------
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz", 
                     package="decompTumor2Sig")
genomes <- readGenomesFromVCF(gfile, numBases=3, type="Alexandrov",
         trDir=FALSE, refGenome=refGenome, verbose=FALSE)

plotMutationDistribution(genomes[[1]])

## -----------------------------------------------------------------------------
# load the 15 Shiraishi signatures obtained from 
# 435 tumor genomes from Alexandrov et al.
sfile <- system.file("extdata",
              "Alexandrov_PMID_23945592_435_tumors-pmsignature-15sig.Rdata", 
              package="decompTumor2Sig")
load(sfile)
length(signatures)
signatures[1]

## -----------------------------------------------------------------------------
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take six breast cancer genomes from Nik-Zainal et al (PMID: 22608084) 
gfile <- system.file("extdata",
                     "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz", 
                     package="decompTumor2Sig")

# read the cancer genomes in VCF format
genomes <- readGenomesFromVCF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)

## ----fig.asp=1----------------------------------------------------------------
plotExplainedVariance(genomes[[1]], signatures, minExplainedVariance=0.9,
                                    minNumSignatures=2, maxNumSignatures=NULL,
                                    greedySearch=TRUE)

## -----------------------------------------------------------------------------
exposure <- decomposeTumorGenomes(genomes[1], signatures)

## -----------------------------------------------------------------------------
exposure

## ----message=FALSE, warning=FALSE, fig.asp=1----------------------------------
plotDecomposedContribution(exposure)

## -----------------------------------------------------------------------------
exposures <- decomposeTumorGenomes(genomes, signatures)
length(exposures)
exposures[1:2]

## -----------------------------------------------------------------------------
isExposureSet(exposures)

## -----------------------------------------------------------------------------
exposures <- decomposeTumorGenomes(genomes[1], signatures,
                                   minExplainedVariance=0.9,
                                   minNumSignatures=2, maxNumSignatures=NULL,
                                   greedySearch=FALSE, verbose=TRUE)

## -----------------------------------------------------------------------------
exposures

## ----fig.asp=1----------------------------------------------------------------
plotDecomposedContribution(exposures[[1]])

## ----fig.asp=1----------------------------------------------------------------
exposures <- decomposeTumorGenomes(genomes[1], signatures,
                                   minExplainedVariance=0.95,
                                   minNumSignatures=2, maxNumSignatures=NULL,
                                   greedySearch=TRUE, verbose=TRUE)

exposures

plotDecomposedContribution(exposures[[1]])

## ----echo=FALSE---------------------------------------------------------------
# load the reference genome and the transcript annotation database
refGenome <- BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <-
           TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene

# take the 15 Shiraishi signatures obtained from
# 435 tumor genomes from Alexandrov et al.
sfile <- system.file("extdata",
              "Alexandrov_PMID_23945592_435_tumors-pmsignature-15sig.Rdata", 
              package="decompTumor2Sig")
load(sfile)

gfile <- system.file("extdata",
              "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz", 
              package="decompTumor2Sig")

# read the cancer genomes in VCF format
genomes <- readGenomesFromVCF(gfile, numBases=5, type="Shiraishi",
                              trDir=TRUE, refGenome=refGenome,
                              transcriptAnno=transcriptAnno, verbose=FALSE)

## -----------------------------------------------------------------------------
exposures <- decomposeTumorGenomes(genomes, signatures)
computeExplainedVariance(exposures, signatures, genomes)

## -----------------------------------------------------------------------------
genomes_predicted <- composeGenomesFromExposures(exposures, signatures)
genomes_predicted[1:2]

## -----------------------------------------------------------------------------
evaluateDecompositionQuality(exposures[[1]], signatures,
                             genomes[[1]], plot=FALSE)

## ----fig.asp=1----------------------------------------------------------------
evaluateDecompositionQuality(exposures[[1]], signatures,
                             genomes[[1]], plot=TRUE)

## -----------------------------------------------------------------------------
# get 4 Shiraishi signatures from 21 breast cancers from
# Nik-Zainal et al (PMID: 22608084)
sigfiles <- system.file("extdata",
                 paste0("Nik-Zainal_PMID_22608084-pmsignature-sig",1:4,".tsv"), 
                 package="decompTumor2Sig")
sign_s4 <- readShiraishiSignatures(files=sigfiles)


# get 15 Shiraishi signatures obtained from
# 435 tumor genomes from Alexandrov et al.
sfile <- system.file("extdata",
              "Alexandrov_PMID_23945592_435_tumors-pmsignature-15sig.Rdata", 
              package="decompTumor2Sig")
load(sfile)
sign_s15 <- signatures

## -----------------------------------------------------------------------------
determineSignatureDistances(fromSignature=sign_s4[[1]], toSignatures=sign_s15,
                            method="frobenius")

## -----------------------------------------------------------------------------
mapSignatureSets(fromSignatures=sign_s4, toSignatures=sign_s15,
                 method="frobenius", unique=FALSE)

## ----message=FALSE, warning=FALSE---------------------------------------------
sign_a <- readAlexandrovSignatures()
sign_a2s <- convertAlexandrov2Shiraishi(sign_a)

## -----------------------------------------------------------------------------
sign_sdown <- downgradeShiraishiSignatures(sign_s15, numBases=3,
                                           removeTrDir=TRUE)
sign_s15[1]
sign_sdown[1]

## -----------------------------------------------------------------------------
mapSignatureSets(fromSignatures=sign_sdown, toSignatures=sign_a2s,
                 method="frobenius", unique=TRUE)

