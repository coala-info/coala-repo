# Population reference dataset GDS files

Pascal Belleau, Astrid Deschênes and Alexander Krasnitz

#### 30 October 2025

# Contents

* [1 Population Reference GDS File](#population-reference-gds-file)
* [2 Population Reference Annotation GDS file](#population-reference-annotation-gds-file)
* [3 Pre-processed files, from 1000 Genomes in hg38, are available](#pre-processed-files-from-1000-genomes-in-hg38-are-available)
* [4 Session info](#session-info)
* [References](#references)

**Package**: *RAIDS*
**Authors**: Pascal Belleau [cre, aut] (ORCID:
<https://orcid.org/0000-0002-0802-1071>),
Astrid Deschênes [aut] (ORCID: <https://orcid.org/0000-0001-7846-6749>),
David A. Tuveson [aut] (ORCID: <https://orcid.org/0000-0002-8017-2712>),
Alexander Krasnitz [aut]
**Version**: 1.8.0
**Compiled date**: 2025-10-30
**License**: Apache License (>= 2)

This vignette explains, in further details, the format of the population
reference files that are required to run the ancestry inference tool.

Two different files are generated from a reference dataset:

* The Population Reference GDS File
* The Population Reference SNV Annotation GDS file

# 1 Population Reference GDS File

The *Population Reference GDS file* should contain the genome-wide SNV
information related to the population data set with known genetic ancestry.
This reference data set will be used to generate the simulated samples. It is
also used to generate the PCA on which the samples of interest are going to
be projected.

The *Population Reference GDS file* is a GDS object of class
[SNPGDSFileClass](https://www.bioconductor.org/packages/release/bioc/vignettes/) from [SNPRelate](https://www.bioconductor.org/packages/release/bioc/html/SNPRelate.html)
package (Zheng et al. [2012](#ref-Zheng2012)).

Beware that related profiles should be flagged in the *Population Reference GDS file* files.

```
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)
library(SNPRelate)

pathRef <- system.file("extdata/", package="RAIDS")

fileReferenceGDS <- file.path(pathRef, "PopulationReferenceDemo.gds")

gdsRef <- snpgdsOpen(fileReferenceGDS)

## Show the file format
print(gdsRef)
## File: /tmp/Rtmp5VoMVy/Rinst274f874da9e9be/RAIDS/extdata/PopulationReferenceDemo.gds (3.2K)
## +    [  ]
## |--+ sample.id   { Str8 10, 80B }
## |--+ sample.annot   [ data.frame ] *
## |  |--+ sex   { Str8 10, 20B }
## |  |--+ pop.group   { Str8 10, 40B }
## |  |--+ superPop   { Str8 10, 40B }
## |  \--+ batch   { Float64 10, 80B }
## |--+ snp.id   { Str8 7, 21B }
## |--+ snp.chromosome   { UInt16 7, 14B }
## |--+ snp.position   { Int32 7, 28B }
## |--+ snp.allele   { Str8 7, 28B }
## |--+ snp.AF   { PackedReal24 7, 21B }
## |--+ snp.EAS_AF   { PackedReal24 7, 21B }
## |--+ snp.EUR_AF   { PackedReal24 7, 21B }
## |--+ snp.AFR_AF   { PackedReal24 7, 21B }
## |--+ snp.AMR_AF   { PackedReal24 7, 21B }
## |--+ snp.SAS_AF   { PackedReal24 7, 21B }
## |--+ genotype   { Bit2 7x10, 18B }
## \--+ sample.ref   { Bit1 10, 2B }

closefn.gds(gdsRef)
```

This output lists all variables stored in the *Population Reference GDS file*.
At the first level, it stores variables *sample.id*, *snp.id*, etc.
The additional information displayed in the braces indicate the data type,
size, compressed or not with compression ratio.

The mandatory fields are:

* **sample.id**: a *character* string (saved in *Str8* format) used as unique identifier for each sample
* **sample.annot**: a *data.frame* where each row correspond to a sample and containing those columns:
  + **sex**: a *character* string (saved in *Str8* format) used as identifier of the sex of the sample
  + **pop.Group**: a *character* string (saved in *Str8* format) representing the sub-population ancestry of the sample (ex:GBR, etc)
  + **superPop**: a *character* string (saved in *Str8* format) representing the super-population ancestry of the sample (ex:EUR, AFR, EAS, SAS, AMR)
  + **batch**: an *integer* (saved in *Float64* format) representing the batch of provenance of the sample
* **snp.id**: a a *character* string (saved in *Str8* format) used as unique identifier for each SNV
* **snp.chromosome**: an *integer* or *character* (saved in *UInt16*  format) mapping for each chromosome. Integer: numeric values 1-26, mapped in order from 1-22, 23=X, 24=XY (the pseudoautosomal region), 25=Y, 26=M (the mitochondrial probes), and 0 for probes with unknown positions; it does not allow NA. Character: “X”, “XY”, “Y” and “M” can be used here, and a blank string indicating unknown position
* **snp.position**: an *integer* (saved in *Int32* format) representing the base position of each SNV on the chromosome, and 0 for unknown position; it does not allow NA.
* **snp.allele**: a *character* string (saved as *Str8* format) representing the reference allele and alternative allele for each of the SNVs present in the *snp.id* field
* **snp.AF**: a *numeric* value between 0 and 1 (saved as *PackedReal24* format) representing the allelic frequency of the alternative allele in the general population for each of the SNVs present in the *snp.id* field
* **snp.EAS\_AF**: a *numeric* value between 0 and 1 (saved as *PackedReal24* format) representing the allelic frequency of the alternative allele in the East Asian population for each of the SNVs present in the *snp.id* field
* **snp.EUR\_AF**: a *numeric* value between 0 and 1 (saved as *PackedReal24* format) representing the allelic frequency of the alternative allele in the European population for each of the SNVs present in the *snp.id* field
* **snp.AFR\_AF**: a *numeric* value between 0 and 1 (saved as *PackedReal24* format) representing the allelic frequency of the alternative allele in the African population for each of the SNVs present in the *snp.id* field
* **snp.AMR\_AF**: a *numeric* value between 0 and 1 (saved as *PackedReal24* format) representing the allelic frequency of the alternative allele in the American population for each of the SNVs present in the *snp.id* field
* **snp.SAS\_AF**: a *numeric* value between 0 and 1 (saved as *PackedReal24* format) representing the allelic frequency of the alternative allele in the South Asian population for each of the SNVs present in the *snp.id* field
* **genotype**: a SNV genotypic *matrix* of *integer* values (saved in *Bit2* format) (i.e., the number of A alleles) with SNVs as rows and samples as columns (number of SNVs × number of Samples)
* **sample.ref**: an *integer* (saved in *Bit1* format) indicating if the sample is retained to be used as reference (=1) or removed (=0) as related samples have to be discarded

This following example shows how to create a *Population GDS Reference file*.
This example is for demonstration purpose only and use hard coded values.
A working *Population GDS Reference file* would have to contain multiple
samples from
each continental population and would also have to contain the SNVs from the
entire genome.

To generate a real *Population GDS Reference file*, the pipeline to process
the information would depend of the selected source.
If the source files are in VCF format, you can use Bioconductor
[VariationAnnotation](https://bioconductor.org/packages/release/bioc/html/VariantAnnotation.html)
package to extract the genotypic information (beware it may use a lot of
memory).
Often, you will need to parse metadata files to get information such as the
sex and population of the profiles. In addition, the Bioconductor
[GENESIS](https://bioconductor.org/packages/release/bioc/html/GENESIS.html)
package can
be used to compute kinship coefficients to identify the unrelated profiles.

```
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)
library(SNPRelate)
library(gdsfmt)

## Create a temporary GDS Reference file in the temporary directory
fileNewReferenceGDS <- file.path(tempdir(), "reference_DEMO.gds")

gdsRefNew <- createfn.gds(fileNewReferenceGDS)

## The entry 'sample.id' contain the unique identifiers of 10 samples
## that constitute the reference dataset
sample.id <- c("HG00243", "HG00150", "HG00149", "HG00246", "HG00138",
                    "HG01334", "HG00268", "HG00275", "HG00290", "HG00364")
add.gdsn(node=gdsRefNew, name="sample.id", val=sample.id,
            storage="string", check=TRUE)

## A data frame containing the information about the 10 samples
## (in the same order than in the 'sample.id') is created and added to
## the 'sample.annot' entry
## The data frame must contain those columns:
##     'sex': '1'=male, '2'=female
##     'pop.group': acronym for the population (ex: GBR, CDX, MSL, ASW, etc..)
##     'superPop': acronym for the super-population (ex: AFR, EUR, etc...)
##     'batch': number identifying the batch of provenance
sampleInformation <- data.frame(sex=c("1", "2", "1", "1", "1",
        "1", "2", "2", "1", "2"), pop.group=c(rep("GBR", 6), rep("FIN", 4)),
        superPop=c(rep("EUR", 10)), batch=rep(0, 10), stringsAsFactors=FALSE)
add.gdsn(node=gdsRefNew, name="sample.annot", val=sampleInformation,
            check=TRUE)

## The identifier of each SNV is added in the 'snp.id' entry
snvID <- c("s29603", "s29605", "s29633", "s29634", "s29635", "s29637",
            "s29638", "s29663", "s29664", "s29666", "s29667", "s29686",
            "s29687", "s29711", "s29741", "s29742", "s29746", "s29750",
            "s29751", "s29753")
add.gdsn(node=gdsRefNew, name="snp.id", val=snvID, check=TRUE)

## The chromosome of each SNV is added to the 'snp.chromosome' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvChrom <- c(rep(1, 20))
add.gdsn(node=gdsRefNew, name="snp.chromosome", val=snvChrom, storage="uint16",
            check=TRUE)

## The position on the chromosome of each SNV is added to
## the 'snp.position' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvPos <- c(3467333, 3467428, 3469375, 3469387, 3469502, 3469527,
                    3469737, 3471497, 3471565, 3471618)
add.gdsn(node=gdsRefNew, name="snp.position", val=snvPos, storage="int32",
            check=TRUE)

## The allele information of each SNV is added to the 'snp.allele' entry
## The order of the SNVs is the same than in the 'snp.allele' entry
snvAllele <- c("A/G", "C/G", "C/T", "C/T", "T/G", "C/T",
                    "G/A", "A/G", "G/A", "G/A")
add.gdsn(node=gdsRefNew, name="snp.allele", val=snvAllele, storage="string",
            check=TRUE)

## The allele frequency in the general population (between 0 and 1) of each
## SNV is added to the 'snp.AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.86, 0.01, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.01)
add.gdsn(node=gdsRefNew, name="snp.AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the East Asian population (between 0 and 1) of each
## SNV is added to the 'snp.EAS_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.80, 0.00, 0.00, 0.01, 0.00, 0.00, 0.01, 0.00, 0.02, 0.00)
add.gdsn(node=gdsRefNew, name="snp.EAS_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the European population (between 0 and 1) of each
## SNV is added to the 'snp.EUR_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.91, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.03)
add.gdsn(node=gdsRefNew, name="snp.EUR_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the African population (between 0 and 1) of each
## SNV is added to the 'snp.AFR_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.85, 0.04, 0.00, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00)
add.gdsn(node=gdsRefNew, name="snp.AFR_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the American population (between 0 and 1) of each
## SNV is added to the 'snp.AMR_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.83, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.02)
add.gdsn(node=gdsRefNew, name="snp.AMR_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the South Asian population (between 0 and 1) of each
## SNV is added to the 'snp.SAS_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.89, 0.00, 0.00, 0.00, 0.05, 0.00, 0.00, 0.01, 0.00, 0.00)
add.gdsn(node=gdsRefNew, name="snp.SAS_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The genotype of each SNV for each sample is added to the 'genotype' entry
## The genotype correspond to the number of A alleles
## The rows represent the SNVs is the same order than in 'snp.id' entry
## The columns represent the samples is the same order than in 'sample.id' entry
genotypeInfo <- matrix(data=c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                        0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0), nrow=10, byrow=TRUE)
add.gdsn(node=gdsRefNew, name="genotype", val=genotypeInfo,
            storage="bit2", check=TRUE)

## The entry 'sample.ref' is filled with 1 indicating that all 10
## samples are retained to be used as reference
## The order of the samples is the same than in the 'sample.id' entry
add.gdsn(node=gdsRefNew, name="sample.ref", val=rep(1L, 10),
            storage="bit1", check=TRUE)

## Show the file format
print(gdsRefNew)
## File: /tmp/RtmpurB6nU/reference_DEMO.gds (1.6K)
## +    [  ]
## |--+ sample.id   { Str8 10, 80B }
## |--+ sample.annot   [ data.frame ] *
## |  |--+ sex   { Str8 10, 20B }
## |  |--+ pop.group   { Str8 10, 40B }
## |  |--+ superPop   { Str8 10, 40B }
## |  \--+ batch   { Float64 10, 80B }
## |--+ snp.id   { Str8 20, 140B }
## |--+ snp.chromosome   { UInt16 20, 40B }
## |--+ snp.position   { Int32 10, 40B }
## |--+ snp.allele   { Str8 10, 40B }
## |--+ snp.AF   { PackedReal24 10, 30B }
## |--+ snp.EAS_AF   { PackedReal24 10, 30B }
## |--+ snp.EUR_AF   { PackedReal24 10, 30B }
## |--+ snp.AFR_AF   { PackedReal24 10, 30B }
## |--+ snp.AMR_AF   { PackedReal24 10, 30B }
## |--+ snp.SAS_AF   { PackedReal24 10, 30B }
## |--+ genotype   { Bit2 10x10, 25B }
## \--+ sample.ref   { Bit1 10, 2B }

closefn.gds(gdsRefNew)

unlink(fileNewReferenceGDS, force=TRUE)
```

# 2 Population Reference Annotation GDS file

The *Population Reference Annotation GDS file* contains phase information
and block group information for all the SNVs present in
*Population Reference GDS file*.

```
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)
library(SNPRelate)

pathReference <- system.file("extdata/tests", package="RAIDS")

fileReferenceAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")

gdsRefAnnot <- openfn.gds(fileReferenceAnnotGDS)

## Show the file format
print(gdsRefAnnot)
## File: /tmp/Rtmp5VoMVy/Rinst274f874da9e9be/RAIDS/extdata/tests/ex1_good_small_1KG.gds (830.0K)
## +    [  ] *
## |--+ sample.id   { Str8 156, 1.2K }
## |--+ sample.annot   [ data.frame ] *
## |  |--+ sex   { Str8 156, 312B }
## |  |--+ pop.group   { Str8 156, 624B }
## |  |--+ superPop   { Str8 156, 624B }
## |  \--+ batch   { Float64 156, 1.2K }
## |--+ snp.id   { Str8 11000, 103.5K }
## |--+ snp.chromosome   { UInt16 11000, 21.5K }
## |--+ snp.position   { Int32 11000, 43.0K }
## |--+ snp.allele   { Str8 11000, 43.0K }
## |--+ snp.AF   { PackedReal24 11000, 32.2K }
## |--+ snp.EAS_AF   { PackedReal24 11000, 32.2K }
## |--+ snp.EUR_AF   { PackedReal24 11000, 32.2K }
## |--+ snp.AFR_AF   { PackedReal24 11000, 32.2K }
## |--+ snp.AMR_AF   { PackedReal24 11000, 32.2K }
## |--+ snp.SAS_AF   { PackedReal24 11000, 32.2K }
## |--+ genotype   { Bit2 11000x156, 418.9K }
## \--+ sample.ref   { Bit1 156, 20B }

closefn.gds(gdsRefAnnot)
```

This output lists all variables stored in
the *Population Reference Annotation GDS file*.
At the first level, it stores variables *phase*, *block.annot*, etc.
The additional information displayed in the braces indicate the data type,
size, compressed or not + compression ratio.

The mandatory fields are:

* **phase**: a *integer* (saved in *Bit2* format) representing the phase of the SNVs in the *Population Annotation GDS file*; 0 means the first allele is a reference; 1 means the first allele is the alternative and 3 means unknown. The first allele combine with the genotype of the variant determine the phase for a biallelic variant. The SNVs (rows) and samples (columns) in phase are in the same order as in the *Population Annotation GDS file*.
* **block.annot**: a *data.frame* containing those columns:
  + **block.id**: a *character* string (saved in *Str8* format) representing an identifier of block group. A block can be linkage disequilibrium block relative to a population or a gene.
  + **block.desc**: a *character* string (saved in *Str8* format) describing the block group.
* **bloc**: a *matrix* of *integer* values (saved in *Int32* format) where each row representing a SNV in the *Population Annotation GDS file* in the same order. The columns are the block groups described in *block.annot*. Each *integer* in the *matrix* representing a specific block.

This following example shows how to create a
*Population Reference Annotation GDS file*.
This example is for demonstration purpose only. A working
*Population Reference Annotation GDS file* would have to contain multiple
samples from each continental population and would also have to contain
the SNVs from the entire genome.

```
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)
library(gdsfmt)

## Create a temporary GDS Reference file in the temporary directory
fileNewReferenceAnnotGDS <-
        file.path(tempdir(), "reference_SNV_Annotation_DEMO.gds")

gdsRefAnnotNew <- createfn.gds(fileNewReferenceAnnotGDS)

## The entry 'phase' contain the phase of the SNVs in the
## Population Annotation GDS file
## 0 means the first allele is a reference; 1 means the first allele is
## the alternative and 3 means unknown
## The SNVs (rows) and samples (columns) in phase are in the same order as
## in the Population Annotation GDS file.
phase <- matrix(data=c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                        0, 0, 0, 1, 1, 0, 0, 0, 1, 1,
                        0, 0, 0, 1, 1, 0, 0, 0, 0, 1,
                        1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                        0, 1, 0, 1, 1, 0, 1, 1, 1, 1,
                        0, 1, 0, 1, 1, 0, 1, 1, 1, 1,
                        0, 0, 1, 0, 0, 0, 0, 1, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 1, 0, 1, 1, 0, 1, 1, 1, 1), ncol=10, byrow=TRUE)
add.gdsn(node=gdsRefAnnotNew, name="phase", val=phase, storage="bit2",
                check=TRUE)

## The entry 'blockAnnot' contain the information for each group of blocks
## that are present in the 'block' entry.
blockAnnot <- data.frame(block.id=c("EAS.0.05.500k", "EUR.0.05.500k",
                    "AFR.0.05.500k", "AMR.0.05.500k", "SAS.0.05.500k"),
                block.desc=c(
                    "EAS populationblock base on SNP 0.05 and windows 500k",
                    "EUR populationblock base on SNP 0.05 and windows 500k",
                    "AFR populationblock base on SNP 0.05 and windows 500k",
                    "AMR populationblock base on SNP 0.05 and windows 500k",
                    "SAS populationblock base on SNP 0.05 and windows 500k"),
                stringsAsFactors=FALSE)
add.gdsn(node=gdsRefAnnotNew, name="block.annot", val=blockAnnot, check=TRUE)

## The entry 'block' contain the block information for the SNVs in the
## Population Annotation GDS file.
## The SNVs (rows) are in the same order as in
## the Population Annotation GDS file.
## The block groups (columns) are in the same order as in
## the 'block.annot' entry.
block <- matrix(data=c(-1, -1, -1, -1, -1,
                        -2, -2,  1, -2, -2,
                        -2,  1,  1,  1, -2,
                        -2,  1,  1,  1, -2,
                        -2, -3, -2, -3, -2,
                         1,  2,  2,  2,  1,
                         1,  2,  2,  2,  1,
                        -3, -4, -3, -4, -3,
                         2, -4,  3, -4, -3,
                         2, -4,  3, -4, -3), ncol=5, byrow=TRUE)
add.gdsn(node=gdsRefAnnotNew, name="block", val=block, storage="int32",
            check=TRUE)

## Show the file format
print(gdsRefAnnotNew)
## File: /tmp/RtmpurB6nU/reference_SNV_Annotation_DEMO.gds (427B)
## +    [  ]
## |--+ phase   { Bit2 10x10, 25B }
## |--+ block.annot   [ data.frame ] *
## |  |--+ block.id   { Str8 5, 70B }
## |  \--+ block.desc   { Str8 5, 270B }
## \--+ block   { Int32 10x5, 200B }

closefn.gds(gdsRefAnnotNew)

unlink(fileNewReferenceAnnotGDS, force=TRUE)
```

# 3 Pre-processed files, from 1000 Genomes in hg38, are available

Pre-processed files used in the RAIDS associated publication, are
available at this address:

<https://labshare.cshl.edu/shares/krasnitzlab/aicsPaper>

Beware that some of those files are voluminous.

# 4 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] RAIDS_1.8.0          Rsamtools_2.26.0     Biostrings_2.78.0
##  [4] XVector_0.50.0       GenomicRanges_1.62.0 IRanges_2.44.0
##  [7] S4Vectors_0.48.0     Seqinfo_1.0.0        BiocGenerics_0.56.0
## [10] generics_0.1.4       dplyr_1.1.4          GENESIS_2.40.0
## [13] SNPRelate_1.44.0     gdsfmt_1.46.0        knitr_1.50
## [16] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] shape_1.4.6.1               magrittr_2.0.4
##   [5] TH.data_1.1-4               estimability_1.5.1
##   [7] jomo_2.7-6                  GenomicFeatures_1.62.0
##   [9] farver_2.1.2                logistf_1.26.1
##  [11] nloptr_2.2.1                rmarkdown_2.30
##  [13] BiocIO_1.20.0               vctrs_0.6.5
##  [15] memoise_2.0.1               minqa_1.2.8
##  [17] RCurl_1.98-1.17             quantsmooth_1.76.0
##  [19] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [21] curl_7.0.0                  broom_1.0.10
##  [23] pROC_1.19.0.1               SparseArray_1.10.0
##  [25] mitml_0.4-5                 sass_0.4.10
##  [27] bslib_0.9.0                 sandwich_3.1-1
##  [29] emmeans_2.0.0               zoo_1.8-14
##  [31] cachem_1.1.0                GenomicAlignments_1.46.0
##  [33] lifecycle_1.0.4             iterators_1.0.14
##  [35] pkgconfig_2.0.3             Matrix_1.7-4
##  [37] R6_2.6.1                    fastmap_1.2.0
##  [39] rbibutils_2.3               MatrixGenerics_1.22.0
##  [41] digest_0.6.37               GWASTools_1.56.0
##  [43] AnnotationDbi_1.72.0        RSQLite_2.4.3
##  [45] httr_1.4.7                  abind_1.4-8
##  [47] mgcv_1.9-3                  compiler_4.5.1
##  [49] bit64_4.6.0-1               S7_0.2.0
##  [51] backports_1.5.0             BiocParallel_1.44.0
##  [53] DBI_1.2.3                   pan_1.9
##  [55] MASS_7.3-65                 quantreg_6.1
##  [57] DelayedArray_0.36.0         rjson_0.2.23
##  [59] DNAcopy_1.84.0              tools_4.5.1
##  [61] lmtest_0.9-40               nnet_7.3-20
##  [63] glue_1.8.0                  restfulr_0.0.16
##  [65] nlme_3.1-168                grid_4.5.1
##  [67] gtable_0.3.6                operator.tools_1.6.3
##  [69] BSgenome_1.78.0             formula.tools_1.7.1
##  [71] class_7.3-23                tidyr_1.3.1
##  [73] ensembldb_2.34.0            data.table_1.17.8
##  [75] GWASExactHW_1.2             stringr_1.5.2
##  [77] foreach_1.5.2               pillar_1.11.1
##  [79] splines_4.5.1               lattice_0.22-7
##  [81] survival_3.8-3              rtracklayer_1.70.0
##  [83] bit_4.6.0                   SparseM_1.84-2
##  [85] tidyselect_1.2.1            SeqVarTools_1.48.0
##  [87] reformulas_0.4.2            bookdown_0.45
##  [89] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
##  [91] RhpcBLASctl_0.23-42         xfun_0.53
##  [93] Biobase_2.70.0              matrixStats_1.5.0
##  [95] stringi_1.8.7               UCSC.utils_1.6.0
##  [97] lazyeval_0.2.2              yaml_2.3.10
##  [99] boot_1.3-32                 evaluate_1.0.5
## [101] codetools_0.2-20            cigarillo_1.0.0
## [103] tibble_3.3.0                BiocManager_1.30.26
## [105] cli_3.6.5                   rpart_4.1.24
## [107] xtable_1.8-4                Rdpack_2.6.4
## [109] jquerylib_0.1.4             dichromat_2.0-0.1
## [111] GenomeInfoDb_1.46.0         Rcpp_1.1.0
## [113] coda_0.19-4.1               png_0.1-8
## [115] XML_3.99-0.19               parallel_4.5.1
## [117] MatrixModels_0.5-4          ggplot2_4.0.0
## [119] blob_1.2.4                  AnnotationFilter_1.34.0
## [121] bitops_1.0-9                lme4_1.1-37
## [123] glmnet_4.1-10               SeqArray_1.50.0
## [125] mvtnorm_1.3-3               VariantAnnotation_1.56.0
## [127] scales_1.4.0                purrr_1.1.0
## [129] crayon_1.5.3                rlang_1.1.6
## [131] KEGGREST_1.50.0             multcomp_1.4-29
## [133] mice_3.18.0
```

# References

Zheng, Xiuwen, David Levine, Jess Shen, Stephanie M. Gogarten, Cathy Laurie, and Bruce S. Weir. 2012. “A high-performance computing toolset for relatedness and principal component analysis of SNP data.” *Bioinformatics* 28 (24): 3326–8. <https://doi.org/10.1093/bioinformatics/bts606>.