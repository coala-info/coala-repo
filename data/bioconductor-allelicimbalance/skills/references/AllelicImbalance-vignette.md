AllelicImbalance Vignette

Jesper R. Gadin and Lasse Folkersen

2025-10-29

Contents

1

ASEset .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1.1

1.2

1.3

1.4

1.5

1.6

1.7

1.8

4.1

4.2

4.3

5.1

5.2

5.3

Simple example of building an ASEset object

Building an ASEset object using Bcf or Vcf files .

Using strand information .

.

Two useful helper functions .

Adding phenotype data .

.

.

.

.

.

Adding genotype information .

Adding phase information .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Adding reference and alternative allele information.

2

3

4

Tests .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2.1

Statistical analysis of an ASEset object

Summary functions .

Base graphics .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Plotting of an ASEset object

5

Grid graphics .

Plot with annotation.

locationplot .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

gbarplot

.

glocationplot .

Custom location plots .

6

7

8

Important notifications .

6.1

Update old objects .

Conclusion .

Links .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3

3

4

5

6

6

6

7

8

9

9

10

12

12

14

16

17

17

18

18

20

20

20

20

AllelicImbalance Vignette

9

Session Info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

20

2

AllelicImbalance Vignette

#Introduction This AllelicImbalance package contains functions for investigating allelic
imbalance effects in RNA-seq data. Maternal and paternal alleles could be expected to show
identical transcription rate, resulting in a 50%-50% mix of maternal and paternal mRNA in a
sample. However, this turns out to sometimes not be the case. The most extreme example is
the X-chromosome inactivation in females, but many autosomal genes also have deviations
from identical transcription rate. The causes of this are not always known, but one likely
cause is the difference in DNA, namely heterozygous SNPs, affecting enhancers, promoter
regions, splicing and stability. Identifying this allelic imbalance is therefore of interest to the
characterization of the genome and the aim of the AllelicImbalance package is to facilitate
this.

Load AllelicImbalance

library(AllelicImbalance)

1

ASEset

The ASEset object is the central class of objects in the AllelicImbalance package. The ASEset
object has the RangedSummarizedExperiment from the SummarizedExperiment package as
parent class, and all functions you can apply on this class you can also apply on an ASEset.

1.1

Simple example of building an ASEset object
In this section we will walk through the various ways an ASEset object can be created.
Although the preprocessing of RNA-seq data is not the primary focus of this package, it is a
necessary step before analysis. There exists several different methods for obtaining a bam
file, and this section should just be considered an example. For further details we refer to the
web-pages of tophat, bowtie, bwa and samtools found in the links section at the end of this
document.

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR009/ERR009135/*
bowtie -q --best --threads 5 --sam hg19 +

>

-1 ERR009135_1.fastq.gz -2 ERR009135_2.fastq.gz "ERR009135.sam"

samtools view -S -b ERR009135.sam > ERR009135.bam

In the above code one paired-end RNA sequencing sample is downloaded and aligned to the
human genome, then converted to bam using samtools. The resulting bam files can be the
direct input to the AllelicImbalance package. Other aligners can be used as well, as long as
bam files are provided as input. The example code following illustrates how to use the import
mechanism on a chromosome 17-located subset of 20 RNA-seq experiments of HapMap
samples. The output is an ASEset object containing allele counts for all heterozygote coding
SNPs in the region.

searchArea <- GRanges(seqnames = c("17"), ranges = IRanges(79478301, 79478361))
pathToFiles <- system.file("extdata/ERP000101_subset",

package = "AllelicImbalance")

reads <- impBamGAL(pathToFiles, searchArea, verbose = FALSE)

heterozygotePositions <- scanForHeterozygotes(reads, verbose = FALSE)

countList <- getAlleleCounts(reads, heterozygotePositions, verbose = FALSE)

a.simple <- ASEsetFromCountList(heterozygotePositions, countList)

a.simple

3

AllelicImbalance Vignette

## class: ASEset

## dim: 3 20

## metadata(0):

## assays(3): countsPlus mapBias phase
## rownames(3): chr17_79478287 chr17_79478331 chr17_79478334
## rowData names(0):

## colnames(20): ERR009097.bam ERR009102.bam ... ERR009160.bam

##

ERR009167.bam

## colData names(0):

1.2

Building an ASEset object using Bcf or Vcf files
If more than a few genes and a few samples are analyzed we recommend that a SNP-call is
instead made using the samtools mpileup function (see links section). The scanForHeterozy-
gotes function is merely a simple SNP-caller and it is not as computationally optimized as
e.g. mpileup. In this bash code we download reference sequence for chromosome 17 and show
how to generate mpileup calls on one of the HapMap samples that were described above.

#download the reference chromosome in fasta format

wget ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr17.fa.gz

#Vcf format

samtools mpileup -uf hg19.fa ERR009135.bam > ERR009135.vcf

#Bcf format

samtools mpileup --BCF --fasta-ref hg19.fa \

--output ERR009135.bcf ERR009135.bam

Samtools mpileup generates by default a Vcf file which contains SNP and short INDEL
positions. Piping the output to bcftools we get its binary equivalent (Bcf), which takes less
space and can be queried more effective.

The Vcf file is a text file that stores information about positions in the genome. In addition
to the location, stored informationn could for example be genotype, phase, reference and
alternative alleles for a collection of samples. More detailed information can be found following
this link.

In the VariantAnnotation package there is a lot of useful tools to handle Vcf files. The
readVcf function reads Vcf data into R, which can be subset to only ranges by granges to get
a GRanges object that is the object type required by the getAlleleCounts function.

library(VariantAnnotation)

##

## Attaching package: 'VariantAnnotation'

## The following object is masked from 'package:base':

##

##

tabulate

pathToVcf <- paste(pathToFiles,"/ERP000101.vcf",sep="")

VCF <- readVcf(pathToVcf,"hg19")

gr <- granges(VCF)

#only use bi-allelic positions

4

AllelicImbalance Vignette

gr.filt <- gr[width(mcols(gr)[,"REF"]) == 1 |

unlist(lapply(mcols(gr)[,"ALT"],width))==1]

countList <- getAlleleCounts(reads, gr.filt, verbose=FALSE)

a.vcf <- ASEsetFromCountList(rowRanges = gr, countList)

With the Bcf files the process of generating an ASEset object starts with a call to the
impBcfGR function instead. This function will import the Bcf file containing all SNP calls
that were generated with the samtools mpileup function.

BcfGR <- impBcfGR(pathToFiles,searchArea,verbose=FALSE)

countListBcf <- getAlleleCounts(reads, BcfGR,verbose=FALSE)

a.bcf <- ASEsetFromCountList(BcfGR, countListBcf)

1.3

Using strand information
Many RNA-seq experiments do not yield useful information on the strand from which a given
read was made. This is because they involve a step in which a double-stranded cDNA is
created without tracking strand-information. Some RNA-seq setups do however give this
information and in those cases it is important to keep track of strand in the ASE-experiment.
The example data from above is from an experiment which created double-stranded cDNA
before labelling and so the ‘+’ and ‘-’ information in it is arbitrary. However, if we assume
that the information has strand information, then the correct procedure is as follows:

plus <- getAlleleCounts(reads, heterozygotePositions, strand="+",verbose=F)

minus <- getAlleleCounts(reads, heterozygotePositions, strand="-",verbose=F)

a.stranded <-

ASEsetFromCountList(

heterozygotePositions,

countListPlus=plus,

countListMinus=minus

)

a.stranded

## class: ASEset

## dim: 3 20

## metadata(0):

## assays(4): countsPlus countsMinus mapBias phase
## rownames(3): chr17_79478287 chr17_79478331 chr17_79478334
## rowData names(0):

## colnames(20): ERR009097.bam ERR009102.bam ... ERR009160.bam

##

ERR009167.bam

## colData names(0):

The main effect of doing this, is in the plotting functions which will separate reads from
different strands if they are specified as done here. It is important, however, to make sure that
the imported RNA-seq experiment does in fact have proper labeling and tracking of strand
information before proceeding with this method.

5

AllelicImbalance Vignette

1.4

Two useful helper functions
At this stage it is worth highlighting two useful helper functions that both uses existing BioC
annotation objects. One is the getAreaFromGeneNames which quickly retrieves the above
mentioned searchArea when given just genesymbols as input, and relies on org.Hs.eg.db. The
other other is the getSnpIdFromLocation function which attempts to rename location-based
SNP names to established rs-IDs in case they exist. These functions work as follows:

#Getting searchArea from genesymbol

library(org.Hs.eg.db )

searchArea<-getAreaFromGeneNames("ACTG1",org.Hs.eg.db)

#Getting rs-IDs

library(SNPlocs.Hsapiens.dbSNP144.GRCh37)

## Warning: replacing previous import 'utils::findMatches' by

## 'S4Vectors::findMatches' when loading 'SNPlocs.Hsapiens.dbSNP144.GRCh37'

gr <- rowRanges(a.simple)

updatedGRanges<-getSnpIdFromLocation(gr, SNPlocs.Hsapiens.dbSNP144.GRCh37)

rowRanges(a.simple)<-updatedGRanges

1.5

Adding phenotype data
Typically an RNA-seq experiment will include additional information about each sample. It is
an advantage to include this information when creating an ASEset because it can be used for
subsequent highlights or subsetting in plotting and analysis functions.

#simulate phenotype data

pdata <- DataFrame(

Treatment=sample(c("ChIP", "Input"),length(reads),replace=TRUE),

Gender=sample(c("male", "female"),length(reads),replace=TRUE),

row.names=paste("individual",1:length(reads),sep=""))

#make new ASEset with pdata

a.new <- ASEsetFromCountList(

heterozygotePositions,

countList,

colData=pdata)

#add to existing object

colData(a.simple) <- pdata

1.6

Adding genotype information
The genotype of the coding SNPs can be set by the command genotype(x) <- value. If the
genotype information is not available it can be inferred from the allele counts. The major allele
will then be the allele with most counts and minor with second most counts. The notation is
major/minor and for the example G/C, The G allele would be the major and C the minor allele.
To be able to infer and store the genotype information it is required to first declare reference
alleles. In cases when it is not important to know which allele is reference, the reference allele
can be inferred from allele counts, by random takingone of the most expressed alleles.

6

AllelicImbalance Vignette

#infer and add genotype require declaration of the reference allele

ref(a.simple) <- randomRef(a.simple)

genotype(a.simple) <- inferGenotypes(a.simple)

#access to genotype information requires not only the information about the

#reference allele but also the alternative allele

alt(a.simple) <- inferAltAllele(a.simple)

genotype(a.simple)[,1:4]

##

[,1] [,2] [,3] [,4]

## [1,] "G/A" "G/A" NA

"G/A"

## [2,] "T/G" "T/G" "T/G" "T/G"

## [3,] "C/G" "C/G" "C/G" "C/G"

1.7

Adding phase information
For some functionality phase information is necessary. Phasing can be obtained from many
external sources e.g. samtools. The phase information is often present in VCF-files. The lines
below show how to access that information and transfer it to an ASEset. The ASEset follows
the VCF-conventions on how to describe the phase, i.e. each patients phase will be described
by the established notation of the form “1|0”,“1|1” or “1/0”. There the left number is the
description of the maternal allele and the right number is the description of the paternal
allele. If it is 0 the allele is the same as the reference allele, and if it is 1 it is the alternative
allele. For “|” the phase is known and for “/” the phase is not known. Note, that in the
AllelicImbalance package only bi-allelic expression is allowed.

The phase can be manually added by constructing a user-generated matrix, or transforming
the data into a matrix from an external source. The most convenient way of importing phase
information is probably by reading it from a Vcf file, which is commonly used to store phase
information. The readGT function from the VariantAnnotation package will return a matrix
ready to just attach to an ASEset object.

#construct an example phase matrix

set.seed(1)

rows <-nrow(a.simple)

cols <- ncol(a.simple)
p1 <- matrix(sample(c(1,0),replace=TRUE, size=rows*cols), nrow=rows, ncol=cols)
p2 <- matrix(sample(c(1,0),replace=TRUE, size=rows*cols), nrow=rows, ncol=cols)
phase.mat <- matrix(paste(p1,sample(c("|","|","/"), size=rows*cols,

replace=TRUE), p2, sep=""), nrow=rows, ncol=cols)

phase(a.simple) <- phase.mat

#load VariantAnnotation and use the phase information from a Vcf file
pathToVcf <- system.file("extdata/ERP000101_subset/ERP000101.vcf",

package = "AllelicImbalance")

p <- readGT(pathToVcf)

#The example Vcf file contains only 19 out of our 20 samples

#So we have to subset and order

a.subset <- a.simple[,colnames(a.simple) %in% colnames(p)]

p.subset <- p[, colnames(p) %in% colnames(a.subset)]

p.ordered <- p.subset[ , match(colnames(a.subset), colnames(p.subset))]

7

AllelicImbalance Vignette

1.8

Adding reference and alternative allele information
Having the information of reference and alternative allele is important to investigate any
presence of mapping bias. It is also important to be able to use phasing information. The
reference and alternative alleles are stored in the meta-columns and can be accessed and set
through the mcols() function. All functions that require reference or alternative allele will
visit the meta-columns “ref” or “alt” to extract that information.

#from simulated data

ref(a.simple) <- c("G","T","C")

#infer and set alternative allele

alt <- inferAltAllele(a.simple)

alt(a.simple) <- alt

#from reference genome

data(ASEset.sim)

fasta <- system.file('extdata/hg19.chr17.subset.fa', package='AllelicImbalance')

ref <- refAllele(ASEset.sim,fasta=fasta)

ref(ASEset.sim) <- ref

Using reference allele information when measuring the impact of mapping bias globally, can
be done by measuring the average reference allele fraction from a representative set of SNPs.
Below the simulated example uses 1000 SNPs to assess any presence of mapping bias. Any
deviations from 0.5 suggests a bias favouring one or the other allele. The most likely outcome
is a value higher than 0.5 and is probably due to mapping bias, i.e., the reference allele actually
has mapped more often than the alternative allele.

#make an example countList including a global sample of SNPs

set.seed(1)

countListUnknown <- list()

samples <- paste(rep("sample",10),1:10,sep="")

snps <- 1000

for(snp in 1:snps){

count<-matrix(0, nrow=length(samples), ncol=4,

dimnames=list(samples, c('A','T','G','C')))

alleles <- sample(1:4, 2)

for(sample in 1:length(samples)){

count[sample, alleles] <- as.integer(rnorm(2,mean=50,sd=10))

}

countListUnknown[[snp]] <- count

}

#make example rowRanges for the corresponding information

gr <- GRanges(

seqnames = Rle(sample(paste("chr",1:22,sep=""),snps, replace=TRUE)),

ranges = IRanges(1:snps, width = 1, names= paste("snp",1:snps,sep="")),
strand="*"

)

#make ASEset

a <- ASEsetFromCountList(gr, countListUnknown=countListUnknown)

8

AllelicImbalance Vignette

#set a random allele as reference

ref(a) <- randomRef(a)

genotype(a) <- inferGenotypes(a)

#get the fraction of the reference allele

refFrac <- fraction(a, top.fraction.criteria="ref")

#check mean

mean(refFrac)

## [1] 0.5003092

The reference fraction mean mean(refFrac) is in this case very close to 0.5, and suggests
that the mapbias globally is low if present. However, in this example we randomly assigned
the reference genome to one of the two most expressed alleles by the randomRef function, so
it should not have any mapbias.

2

2.1

Tests

Statistical analysis of an ASEset object
One of the simplest statistical test for use in allelic imbalance analysis is the chi-square test.
This test assumes that the uncertainty of ASE is represented by a normal distribution around
an expected mean (i.e 0.5 for equal expression). A significant result suggests an ASE event.
Every SNP, every sample, and every strand is tested independently.

#set ref allele

ref(a.stranded) <- c("G","T","C")

#binomial test

binom.test(a.stranded[,5:8], "+")

##

## ERR009115.bam

chr17_79478287 chr17_79478331 chr17_79478334
NaN

NaN

NaN

## ERR009122.bam

0.7265625000

0.006610751

2.668457e-01

## ERR009126.bam

0.0004882813

0.107752144

1.907349e-06

## ERR009127.bam

0.2500000000

0.500000000

1.000000e+00

#chi-square test

chisq.test(a.stranded[,5:8], "-")

##

## [1,]

## [2,]

## [3,]

## [4,]

chr17_79478287 chr17_79478331 chr17_79478334
NA

NA

NA

0.7962534

NA

NA

NA

NA

NA

NA

NA

NA

9

AllelicImbalance Vignette

3

Summary functions

The regionSummary function can be used to investigate if there is a consistent imbalance in
the same direction over a region (e.g. a transcript). Besides providing the user with information
of how many AI:s are up or down, the function returns several descriptive statistics for the
result. The list below explains the acronyms retrieved using the ‘basic’ accessor:

• hets the number of heterozygote SNPs
• homs the number of homozygote SNPs
• mean.fr the mean of fractions for all hets
• sd.fr the standard deviation for the fractions for all hets
• mean.delta the mean of the delta fractions for all hets
• sd.delta the standard deviation for the delta fractions for all hets
• ai.up the number of hets significantly up-regulated in one allele.
• ai.down the number of hets significantly down-regulated in one allele.

# in this example every snp is on separate exons

region <- granges(a.simple)

rs <- regionSummary(a.simple, region)

rs

## class: RegionSummary

## dim: 3 20

## metadata(0):

## assays(1): rs1

## rownames(3): 1 2 3

## rowData names(4): ASEsetIndex regionIndex regionIndexName ASEsetMeta

## colnames(20): individual1 individual2 ... individual19 individual20

## colData names(2): Treatment Gender

basic(rs)
## $`1`
##

## individual1

## individual2

## individual3

## individual4

## individual5

## individual6

## individual7

## individual8

## individual9

## individual10

## individual11

## individual12

## individual13

## individual14

## individual15

## individual16

## individual17

## individual18

## individual19

## individual20

##

hets homs mean.fr sd.fr mean.delta sd.delta ai.up ai.down

0

1

1

0

0

0

1

1

0

1

1

0

1

1

1

1

0

0

1

1

1

0

0

1

1

1

0

0

1

0

0

1

0

0

0

0

1

1

0

0

NaN

NaN

0

NaN

NaN

NaN

NaN

1

0

0

NaN

NaN

NaN

NaN

1

0

NaN

NaN

0

NaN

NaN

0

NaN

NaN

1

1

0

1

NaN

NaN

0

1

1

1

0

1

NaN

NaN

0

1

NaN

0.5

NaN

NaN

NaN

NaN

0.5

0.5

NaN

0.5

NaN

NaN

0.5

0.5

0.5

0.5

NaN

NaN

0.5

0.5

NaN

0.5

NaN

NaN

NaN

NaN

0.5

0.5

NaN

0.5

NaN

NaN

0.5

0.5

0.5

0.5

NaN

NaN

0.5

0.5

0

0

0

0

0

0

1

0

0

0

0

0

1

1

0

1

0

0

0

1

0

1

0

0

0

0

0

1

0

1

0

0

0

0

1

0

0

0

1

0

10

AllelicImbalance Vignette

## $`2`
##

## individual1

## individual2

## individual3

## individual4

## individual5

## individual6

## individual7

## individual8

## individual9

## individual10

## individual11

## individual12

## individual13

## individual14

## individual15

## individual16

## individual17

## individual18

## individual19

## individual20

##
## $`3`
##

## individual1

## individual2

## individual3

## individual4

## individual5

## individual6

## individual7

## individual8

## individual9

## individual10

## individual11

## individual12

## individual13

## individual14

## individual15

## individual16

## individual17

## individual18

## individual19

## individual20

hets homs

mean.fr

sd.fr mean.delta

sd.delta ai.up ai.down

0

0

0

1

0

0

1

0

1

0

1

0

1

0

1

1

0

1

1

0

1

1

1

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

0 0.0000000 0.0000000

0.5000000 0.5000000

1

1

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

0 0.3090909 0.3090909

0.1909091 0.1909091

1

0

1

0

1

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

0 0.0000000 0.0000000

0.5000000 0.5000000

1

NaN

NaN

NaN

NaN

0 0.8039216 0.8039216

0.3039216 0.3039216

0 1.0000000 1.0000000

0.5000000 0.5000000

1

NaN

NaN

NaN

NaN

0 0.9375000 0.9375000

0.4375000 0.4375000

0 0.2272727 0.2272727

0.2727273 0.2727273

1

NaN

NaN

NaN

NaN

0

0

0

0

0

0

0

0

0

0

0

0

0

0

1

1

0

1

0

0

0

0

0

1

0

0

1

0

0

0

0

0

1

0

0

0

0

0

1

0

hets homs

mean.fr

sd.fr mean.delta

sd.delta ai.up ai.down

1

1

0

1

0

1

1

0

1

0

1

0

0

0

1

0

1

0

0

1

0 0.1923077 0.1923077

0.3076923 0.3076923

0 0.0000000 0.0000000

0.5000000 0.5000000

1

NaN

NaN

NaN

NaN

0 0.0000000 0.0000000

0.5000000 0.5000000

1

NaN

NaN

NaN

NaN

0 0.8615385 0.8615385

0.3615385 0.3615385

0 0.3571429 0.3571429

0.1428571 0.1428571

1

0

1

0

1

1

1

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

0 0.8292683 0.8292683

0.3292683 0.3292683

1

0

1

1

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

NaN

0 0.1836735 0.1836735

0.3163265 0.3163265

0

0

0

0

0

1

0

0

0

0

0

0

0

0

1

0

0

0

0

0

1

1

0

1

0

0

1

0

0

0

0

0

0

0

0

0

0

0

0

1

11

AllelicImbalance Vignette

4

4.1

Base graphics

Plotting of an ASEset object
The barplot function for ASEset objects plots the read count of each allele in each sample.
This is useful for getting a detailed view of individual SNPs in few samples.

barplot(a.stranded[2], strand="+", xlab.text="", legend.interspace=2)

Figure 1: The red bars show how many reads with the G-allele that overlaps the snp at position
chr17:79478331, and the green bars show how many reads with the T allele that overlaps.

As can be seen in figure 1 several samples from the HapMap data show a strong imbalance at
the chr17:79478331 position on the plus strand. By default the p-value is calculated by a
chi-square test, and when the counts for one allele are below 5 for one allele the chi-square test
returns NA, which is why there is no P-value above the first bar in the figure 1. The default
p-values can be substitued by other test results via the arguments testValue and testValue2.

#use another source of p-values

btp <- binom.test(a.stranded[1],"+")

barplot(a.stranded[2], strand="+", testValue=t(btp), xlab.text="",

legend.interspace=2)

In the figure 2 the binomial test has been used instead of the default chi-square test. At low
counts the P-value can differ, but as can be seen in the table below the difference matters
less with more read counts.

init <- c(15,20)

for(i in c(1,2,4,6)){

bp <- signif(binom.test(init*i, p=0.5)$p.value,3)
cp <- signif(chisq.test(init*i, p=c(0.5,0.5))$p.value, 3)
cat(paste("A: ", init[1]*i , " B: ", init[2]*i, " binom p: ", bp, "chisq p: ", cp,"\n"))

}

## A: 15 B: 20 binom p: 0.5 chisq p:

0.398

## A: 30 B: 40 binom p: 0.282 chisq p:

0.232

12

0510152025ERR009097.bamERR009102.bamERR009103.bamERR009113.bamERR009115.bamERR009122.bamERR009126.bamERR009127.bamERR009129.bamERR009135.bamERR009141.bamERR009142.bamERR009144.bamERR009146.bamERR009147.bamERR009154.bamERR009157.bamERR009159.bamERR009160.bamERR009167.bamchr17_794783310.0040.070.010.050.0070.01GTreadsAllelicImbalance Vignette

Figure 2: Here the default chi-square p-values have been replaced by p-values from binomial tests.

## A:

60 B: 80 binom p: 0.108 chisq p:

0.091

## A:

90 B: 120 binom p: 0.0451 chisq p:

0.0384

Another type of barplot can be invoked by the argument type=“fraction”. This plotting
mechanism is useful to illustrate more SNPs and more samples, using less space than the
standard barplot with the default type=“counts”.

barplot(a.simple[2], type="fraction", cex.main = 0.7)

Figure 3: A barplot with type=’fraction’. Each bar represents one sample and by default the most ex-
pressed allele over all samples is on the top, here in green. The black line denotes 1:1 expression of the
alleles.

A typical question would be to ask why certain heterozygote samples have allele specific
expression. The arguments sampleColour.top and sampleColour.bot allows for different
highligts such as illustrated here below for gender. This could also be used to highlight based
on genotype of proximal non-coding SNPs if available.

13

0510152025ERR009097.bamERR009102.bamERR009103.bamERR009113.bamERR009115.bamERR009122.bamERR009126.bamERR009127.bamERR009129.bamERR009135.bamERR009141.bamERR009142.bamERR009144.bamERR009146.bamERR009147.bamERR009154.bamERR009157.bamERR009159.bamERR009160.bamERR009167.bamchr17_794783310.060.060.060.060.060.060.060.060.060.060.060.060.060.060.060.060.060.060.060.06GTreads25%50%75%chr17_79478331samplesfractionAllelicImbalance Vignette

#top and bottom colour

sampleColour.top <-rep("palevioletred",ncol(a.simple))

sampleColour.top[colData(a.simple)[,"Gender"]%in%"male"] <- "darkgreen"

sampleColour.bot <- rep("blue",ncol(a.simple))

sampleColour.bot[colData(a.simple)[,"Gender"]%in%"male"] <- "seashell2"

barplot(a.simple[2], type="fraction", sampleColour.top=sampleColour.top,

sampleColour.bot=sampleColour.bot, cex.main = 0.7)

Figure 4: A barplot with allele fractions, additionally colored by gender.

4.2

Plot with annotation
It is often of interest to combine the RNA sequencing data with genomic annotation information
from online databases. For this purpose there is a function to extract variant specific annotation
such as gene, exon, transcript and CDS.

library(org.Hs.eg.db)

barplot(a.simple[1],OrgDb=org.Hs.eg.db,

cex.main = 0.7,

xlab.text="",

ypos.annotation = 0.08,

annotation.interspace=1.3,

legend.interspace=1.5

)

##Top allele criteria The barplot with type=‘fraction’ can be visualized according to three
different allele sorting criteria. The default behaviour is just to shown the allele with highest
overall abundance in the upper half of the plot. This works well for most single SNP
investigations. For more complex situations, however, it can be essential to keep track of
phase information. This is done either through the reference allele sorting function, or even
better, through consistently showing the maternal allele on top. When phase is know, this is
essential to compare effect-directions of different coding SNPs

#load data

data(ASEset)

14

25%50%75%chr17_79478331samplesfractionAllelicImbalance Vignette

Figure 5: A barplot with Gene information extracted from the org.Hs.eg.db package

#using reference and alternative allele information

alt(ASEset) <- inferAltAllele(ASEset)

barplot(ASEset[1], type="fraction", strand="+", xlab.text="",

top.fraction.criteria="ref", cex.main=0.7)

Figure 6: A barplot with the reference allele as top fraction, top.fraction.criteria=’ref’

#using phase information

phase(ASEset) <- phase.mat

barplot(ASEset[1], type="fraction", strand="+", xlab.text="",

top.fraction.criteria="phase", cex.main=0.7)

15

0102030405060individual1individual2individual3individual4individual5individual6individual7individual8individual9individual10individual11individual12individual13individual14individual15individual16individual17individual18individual19individual20rs22301590.5Plus−strandsymbol: NAMinus−strandRBFOX3 :symbolGAreads25%50%75%chr17_79478331fractionAllelicImbalance Vignette

Figure 7: A barplot with the maternal phase as top fraction, top.fraction.criteria=’phase’

4.3

locationplot
Finally a given gene or set of proximal genes will often have several SNPs close to each other.
It is of interest to investigate all of them together, in connection with annotation information.
This can be done using the locationplot function. This function in its simplest form just plot
all the SNPs in an ASEset distributed by genomic location. Additionally it contains methods
for including gene-map information through the arguments OrgDb and TxDb.

The overview offers the possibility to view consistency of SNP fractions over consecutive
exons which is important to assess the reliability of the measured SNPs. In the best case all
fractions deviates with the same magnitude for every SNP in the same gene for an individual.
To be able to inspect that the direction is right, it is possible to use the top.fraction.criteria
and use phase information as explained earlier.

# locationplot using count type

a.stranded.sorted <- sort(a.stranded, decreasing=FALSE)

locationplot(a.stranded.sorted, type="count", cex.main=0.7, cex.legend=0.4)

Figure 8: A locationplot with countbars displaying a region of SNPs

16

25%50%75%chr17_79478331fraction79478280794782907947830079478310794783207947833079478340genomic position on chromosome 170102030405060chr17_79478287GA010203040506070chr17_79478331TG020406080chr17_79478334CGAllelicImbalance Vignette

# locationplot annotation

library(TxDb.Hsapiens.UCSC.hg19.knownGene)

locationplot(a.stranded.sorted, OrgDb=org.Hs.eg.db,

TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene)

Figure 9: A locationplot with Gene and Transcript information extracted from the org.Hs.eg.db and
TxDb.Hsapiens.UCSC.hg19.knownGene packages

5

Grid graphics

To make use of the extra graphical flexibility that comes with grid graphics, the AllelicImbalance
package now has functions that can be integrated in the grid environment. The low level grid
functions are located in the grid package, but higher level functions based on grid can be
found in popular packages such as e.g. lattice, ggplot2. The benefits using grid graphics is a
better control over different graphical regions and coordinate systems, how to construct and
redirect graphical output, such as lines, points, etc and their appearance.

One particular reason for the AllelicImbalance to use grid graphics is the Gviz package, which
uses grids functionality to construct tracks to visualize genomic regions in a smart way. The
AllelicImbalance package has grid based barplots and functionality to create Gviz tracks.
Observe the extra “g” prefix for the bar- and locationplot versions using the grid, see examples
below.

5.1

gbarplot
The standard barplot functions for ASEset objects have at the moment much more parameters
that can be set by the user than the gbarplot. Base graphics also produce graphs faster than
the grid environment. The advantage of the gbarplot is instead the possiblity to integrate
into the Gviz package and other grid based environments.

#gbarplots with type "count"

gbarplot(ASEset, type="count")

17

79478280794782907947830079478310794783207947833079478340genomic position on chromosome 1725%50%75%25%50%75%25%50%75%RBFOX3AllelicImbalance Vignette

# gbarplots with type "fraction"

gbarplot(ASEset, type="fraction")

5.2

glocationplot
The glocationplot is a wrapper to quickly get an overview of ASE in a region, similar to
locationplot(), but built with the grid graphics track system from the Gviz package.

#remember to set the genome

genome(ASEset) <- "hg19"

glocationplot(ASEset, strand='+')

Figure 10: A glocationplot, showing the ASE of SNPs within a defined region

5.3

Custom location plots
More flexibility and functionality from the Gviz package is accessed if the tracks are constructed
separately. This is useful to evalute AI in respect to for example read coverage or transcript
annotation. An inconsistency of AI could potentially be explained by an uneven coverage
over the exons, or lack of coverage. Below is an example using two samples from the ASEset
and the corresponding reads. Ensuring and setting the seqlevels equal is a security measure,
for the internal overlap calculations that otherwise might throw a warning. The GR object
is defining the region that we want to plot. The ASEDAnnotationTrack will create a track
based on the gbarplots and the CoverageDataTrack a track based on read coverage. The
different tracks are then collected in a list with the first element appearing at the top in the
final plotting by the plotTracks function. The sizes vector defines the vertical space assigned
to each track. To use transcript annotation, more detailed information can be found in the
Gviz vignette

18

deTrack fractionAllelicImbalance Vignette

#load Gviz package

library(Gviz)

#subset ASEset and reads

x <- ASEset[,1:2]

r <- reads[1:2]

seqlevels(r, pruning.mode="coarse") <- seqlevels(x)

GR <- GRanges(seqnames=seqlevels(x),

ranges=IRanges(start=min(start(x)), end=max(end(x))),

strand='+', genome=genome(x))

deTrack <- ASEDAnnotationTrack(x, GR=GR, type='fraction', strand='+')

covTracks <- CoverageDataTrack(x, BamList=r, strand='+')

lst <- c(deTrack,covTracks)

sizes <- c(0.5,rep(0.5/length(covTracks),length(covTracks)))

plotTracks(lst, from=min(start(x)), to=max(end(x)), sizes=sizes,

col.line = NULL, showId = FALSE, main = 'main', cex.main = 1,

title.width = 1, type = 'histogram')

Figure 11: A custom built Gviz plot using the ASEDAnnotationTrack, showing the ASE of SNPs within a
defined region together with read coverage information

19

maindeTrack fraction010203040ERR009097.bam0246ERR009102.bamAllelicImbalance Vignette

6

6.1

Important notifications

Update old objects
Due to changes in the RangedSummarizedExperiment class from the SummarizedExperiment
package, all RangedSummarizedExperiment objects prior the release of Bioconductor 3.2
needs to be updated. The ASEset is based on the RangedSummarizedExperiment class and
solely needs to be updated as well.

data(ASEset.old)

## Warning in data(ASEset.old): data set 'ASEset.old' not found

#this command doesnt work anymore, for some reason(Will ask the mail-list)

#ASEset.new <- updateObject(ASEset.old)

7

Conclusion

In conclusion we hope that you will find this package useful in the investigation of the genetics
of RNA-seq experiments. The various import functions should assist in the task of actually
retrieving allele counts for specific nucleotide positions from all RNA-seq reads, including
the non-trivial cases of intron-spanning reads. Likewise, the statistical analysis and plotting
functions should be helpful in discovering any allele specific expression patterns that might be
found in your data.

8

Links

Bowtie link

BWA link

Samtools link

Samtools pileup link

Grid graphics link

9

Session Info

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB

LC_NUMERIC=C
LC_COLLATE=C

20

AllelicImbalance Vignette

##

##

[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

##

## attached base packages:

## [1] stats4

## [8] methods

grid

base

##

stats

graphics

grDevices utils

datasets

## other attached packages:

##

##

##

##

##

##

##

##

[1] Gviz_1.54.0
[2] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
[3] GenomicFeatures_1.62.0
[4] SNPlocs.Hsapiens.dbSNP144.GRCh37_0.99.20
[5] BSgenome_1.78.0
[6] rtracklayer_1.70.0
[7] BiocIO_1.20.0
[8] org.Hs.eg.db_3.22.0
[9] AnnotationDbi_1.72.0
##
## [10] VariantAnnotation_1.56.0
## [11] AllelicImbalance_1.48.0
## [12] GenomicAlignments_1.46.0
## [13] Rsamtools_2.26.0
## [14] Biostrings_2.78.0
## [15] XVector_0.50.0
## [16] SummarizedExperiment_1.40.0
## [17] Biobase_2.70.0
## [18] MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0
## [20] GenomicRanges_1.62.0
## [21] Seqinfo_1.0.0
## [22] IRanges_2.44.0
## [23] S4Vectors_0.48.0
## [24] BiocGenerics_0.56.0
## [25] generics_0.1.4
## [26] BiocStyle_2.38.0
##

##

##

##

##

##

## loaded via a namespace (and not attached):
bitops_1.0-9
httr2_1.2.1
magrittr_2.0.4
compiler_4.5.1
vctrs_0.6.5
pkgconfig_2.0.3
backports_1.5.0
UCSC.utils_1.6.0
xfun_0.53
cigarillo_1.0.0

[1] DBI_1.2.3
[4] gridExtra_2.3
[7] rlang_1.1.6
[10] biovizBase_1.58.0
[13] png_0.1-8
[16] stringr_1.5.2
[19] fastmap_1.2.0
[22] rmarkdown_2.30
[25] bit_4.6.0
[28] seqinr_4.2-36

##

##

##

##

##

deldir_2.0-4
biomaRt_2.66.0
ade4_1.7-23
RSQLite_2.4.3
ProtGenerics_1.42.0
crayon_1.5.3
dbplyr_2.5.1
tinytex_0.57
cachem_1.1.0
GenomeInfoDb_1.46.0

21

AllelicImbalance Vignette

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[31] jsonlite_2.0.0
[34] DelayedArray_0.36.0
[37] parallel_4.5.1
[40] R6_2.6.1
[43] rpart_4.1.24
[46] knitr_1.50
[49] nnet_7.3-20
[52] dichromat_2.0-0.1
[55] codetools_0.2-20
[58] tibble_3.3.0
[61] evaluate_1.0.5
[64] pillar_1.11.1
[67] checkmate_2.3.3
[70] hms_1.1.4
[73] glue_1.8.0
[76] tools_4.5.1
[79] XML_3.99-0.19
[82] nlme_3.1-168
[85] Formula_1.2-5
[88] S4Arrays_1.10.0
[91] gtable_0.3.6
[94] rjson_0.2.23
[97] memoise_2.0.1

##
## [100] httr_1.4.7

progress_1.2.3
BiocParallel_1.44.0
prettyunits_1.2.0
stringi_1.8.7
Rcpp_1.1.0
base64enc_0.1-3
tidyselect_1.2.1
abind_1.4-8
curl_7.0.0
KEGGREST_1.50.0
foreign_0.8-90
BiocManager_1.30.26
RCurl_1.98-1.17
ggplot2_4.0.0
lazyeval_0.2.2
interp_1.1-6
latticeExtra_0.6-31
htmlTable_2.4.3
cli_3.6.5
dplyr_1.1.4
digest_0.6.37
htmlwidgets_1.6.4
htmltools_0.5.8.1
MASS_7.3-65

blob_1.2.4
jpeg_0.1-11
cluster_2.1.8.1
RColorBrewer_1.1-3
bookdown_0.45
Matrix_1.7-4
rstudioapi_0.17.1
yaml_2.3.10
lattice_0.22-7
S7_0.2.0
BiocFileCache_3.0.0
filelock_1.0.3
ensembldb_2.34.0
scales_1.4.0
Hmisc_5.2-4
data.table_1.17.8
colorspace_2.1-2
restfulr_0.0.16
rappdirs_0.3.3
AnnotationFilter_1.34.0
SparseArray_1.10.0
farver_2.1.2
lifecycle_1.0.4
bit64_4.6.0-1

22

