# Tutorials for the R/Bioconductor Package SNPRelate

#### Xiuwen Zheng (Department of Biostatistics, University of Washington – Seattle)

#### Mar 20, 2018

* [Overview](#overview)
* [Installation of the package SNPRelate](#installation-of-the-package-snprelate)
* [Preparing Data](#preparing-data)
  + [Data formats used in SNPRelate](#data-formats-used-in-snprelate)
  + [Create a GWAS SNP GDS File](#create-a-gwas-snp-gds-file)
    - [Using snpgdsCreateGeno()](#using-snpgdscreategeno)
    - [Using the gdsfmt package](#using-the-gdsfmt-package)
  + [Format conversion from PLINK text/binary files](#format-conversion-from-plink-textbinary-files)
  + [Format conversion from VCF files](#format-conversion-from-vcf-files)
  + [Format conversion from VCF files using SeqArray](#format-conversion-from-vcf-files-using-seqarray)
* [Data Analysis](#data-analysis)
  + [LD-based SNP pruning](#ld-based-snp-pruning)
  + [Principal Component Analysis (PCA)](#principal-component-analysis-pca)
  + [\(F\_{st}\) Estimation](#f_st-estimation)
  + [Relatedness Analysis](#relatedness-analysis)
    - [Estimating IBD Using PLINK method of moments (MoM)](#estimating-ibd-using-plink-method-of-moments-mom)
    - [Estimating IBD Using Maximum Likelihood Estimation (MLE)](#estimating-ibd-using-maximum-likelihood-estimation-mle)
    - [Relationship inference Using KING method of moments](#relationship-inference-using-king-method-of-moments)
  + [Identity-By-State Analysis](#identity-by-state-analysis)
* [Integration with SeqArray](#integration-with-seqarray)
* [Function List](#function-list)
* [Resources](#resources)
* [Session Information](#session-information)
* [References](#references)
* [Acknowledgements](#acknowledgements)

# Overview

Genome-wide association studies (GWAS) are widely used to help determine the genetic basis of diseases and traits, but they pose many computational challenges. We developed [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) and [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) (high-performance computing R packages for multi-core symmetric multiprocessing computer architectures) to accelerate two key computations in GWAS: principal component analysis (PCA) and relatedness analysis using identity-by-descent (IBD) measures1. The kernels of our algorithms are written in C/C++ and have been highly optimized. The calculations of the genetic covariance matrix in PCA and pairwise IBD coefficients are split into non-overlapping parts and assigned to multiple cores for performance acceleration, as shown in Figure 1.

GDS is also used by the R/Bioconductor package [GWASTools](http://www.bioconductor.org/packages/GWASTools) as one of its data storage formats2,3. [GWASTools](http://www.bioconductor.org/packages/GWASTools) provides many functions for quality control and analysis of GWAS, including statistics by SNP or scan, batch quality, chromosome anomalies, association tests, etc. The extended GDS format is implemented in the [SeqArray](http://www.bioconductor.org/packages/SeqArray) package to support the storage of single nucleotide variation (SNV), insertion/deletion polymorphism (indel) and structural variation calls. It is strongly suggested to use SeqArray for large-scale whole-exome and whole-genome sequencing variant data instead of SNPRelate.

![](data:image/svg+xml;base64...)

Flowchart

**Figure 1**: Flowchart of parallel computing for principal component analysis and identity-by-descent analysis.

~

R is the most popular statistical programming environment, but one not typically optimized for high performance or parallel computing which would ease the burden of large-scale GWAS calculations. To overcome these limitations we have developed a project named CoreArray (<http://corearray.sourceforge.net/>) that includes two R packages: [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) to provide efficient, platform independent memory and file management for genome-wide numerical data, and [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) to solve large-scale, numerically intensive GWAS calculations (i.e., PCA and IBD) on multi-core symmetric multiprocessing (SMP) computer architectures.

This vignette takes the user through the relatedness and principal component analysis used for genome wide association data. The methods in these vignettes have been introduced in the paper of Zheng *et al.* (2012)1. For replication purposes the data used here are taken from the HapMap Phase II project. These data were kindly provided by the Center for Inherited Disease Research (CIDR) at Johns Hopkins University and the Broad Institute of MIT and Harvard University (Broad). The data supplied here should not be used for any purpose other than this tutorial.

\(~\)

# Installation of the package SNPRelate

To install the package [SNPRelate](http://www.bioconductor.org/packages/SNPRelate), you need a current version (>=2.14.0) of [R](https://www.r-project.org) and the R package [gdsfmt](http://www.bioconductor.org/packages/gdsfmt). After installing [R](https://www.r-project.org) you can run the following commands from the [R](https://www.r-project.org) command shell to install the R package [SNPRelate](http://www.bioconductor.org/packages/SNPRelate).

Install the package from Bioconductor repository:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("gdsfmt")
BiocManager::install("SNPRelate")
```

Install the development version from Github:

```
library("devtools")
install_github("zhengxwen/gdsfmt")
install_github("zhengxwen/SNPRelate")
```

The `install_github()` approach requires that you build from source, i.e. `make` and compilers must be installed on your system – see the [R FAQ](https://cran.r-project.org/faqs.html) for your operating system; you may also need to install dependencies manually.

\(~\)

# Preparing Data

## Data formats used in SNPRelate

To support efficient memory management for genome-wide numerical data, the [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) package provides the genomic data structure (GDS) file format for array-oriented bioinformatic data, which is a container for storing annotation data and SNP genotypes. In this format each byte encodes up to four SNP genotypes thereby reducing file size and access time. The GDS format supports data blocking so that only the subset of data that is being processed needs to reside in memory. GDS formatted data is also designed for efficient random access to large data sets. A tutorial for the R/Bioconductor package [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) can be found: <http://corearray.sourceforge.net/tutorials/gdsfmt/>.

```
# Load the R packages: gdsfmt and SNPRelate
library(gdsfmt)
library(SNPRelate)
```

```
## SNPRelate -- supported by Streaming SIMD Extensions 2 (SSE2)
```

Here is a typical GDS file:

```
snpgdsSummary(snpgdsExampleFileName())
```

```
## The file name: /tmp/RtmpZPt4rp/Rinst3356681854b2b4/SNPRelate/extdata/hapmap_geno.gds
## The total number of samples: 279
## The total number of SNPs: 9088
## SNP genotypes are stored in SNP-major mode (Sample X SNP).
```

`snpgdsExampleFileName()` returns the file name of a GDS file used as an example in [SNPRelate](http://www.bioconductor.org/packages/SNPRelate), and it is a subset of data from the HapMap project and the samples were genotyped by the Center for Inherited Disease Research (CIDR) at Johns Hopkins University and the Broad Institute of MIT and Harvard University (Broad). `snpgdsSummary()` summarizes the genotypes stored in the GDS file. “Individual-major mode” indicates listing all SNPs for an individual before listing the SNPs for the next individual, etc. Conversely, “SNP-major mode” indicates listing all individuals for the first SNP before listing all individuals for the second SNP, etc. Sometimes “SNP-major mode” is more computationally efficient than “individual-major mode”. For example, the calculation of genetic covariance matrix deals with genotypic data SNP by SNP, and then “SNP-major mode” should be more efficient.

```
# Open a GDS file
(genofile <- snpgdsOpen(snpgdsExampleFileName()))
```

```
## File: /tmp/RtmpZPt4rp/Rinst3356681854b2b4/SNPRelate/extdata/hapmap_geno.gds (709.6K)
## +    [  ] *
## |--+ sample.id   { VStr8 279 ZIP(29.9%), 679B }
## |--+ snp.id   { Int32 9088 ZIP(34.8%), 12.3K }
## |--+ snp.rs.id   { VStr8 9088 ZIP(40.1%), 36.2K }
## |--+ snp.position   { Int32 9088 ZIP(94.7%), 33.6K }
## |--+ snp.chromosome   { UInt8 9088 ZIP(0.94%), 85B } *
## |--+ snp.allele   { VStr8 9088 ZIP(11.3%), 4.0K }
## |--+ genotype   { Bit2 279x9088, 619.0K } *
## \--+ sample.annot   [ data.frame ] *
##    |--+ family.id   { VStr8 279 ZIP(34.4%), 514B }
##    |--+ father.id   { VStr8 279 ZIP(31.5%), 220B }
##    |--+ mother.id   { VStr8 279 ZIP(30.9%), 214B }
##    |--+ sex   { VStr8 279 ZIP(17.0%), 95B }
##    \--+ pop.group   { VStr8 279 ZIP(6.18%), 69B }
```

The output lists all variables stored in the GDS file. At the first level, it stores variables *sample.id*, *snp.id*, etc. The additional information are displayed in the braces indicating data type, size, compressed or not + compression ratio. The second-level variables *sex* and *pop.group* are both stored in the folder of *sample.annot*. All of the functions in [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) require a minimum set of variables in the annotation data. The minimum required variables are

* *sample.id*, a unique identifier for each sample.
* *snp.id*, a unique identifier for each SNP.
* *snp.position*, the base position of each SNP on the chromosome, and 0 for unknown position; it does not allow NA.
* *snp.chromosome*, an integer or character mapping for each chromosome. Integer: numeric values 1-26, mapped in order from 1-22, 23=X, 24=XY (the pseudoautosomal region), 25=Y, 26=M (the mitochondrial probes), and 0 for probes with unknown positions; it does not allow NA. Character: “X”, “XY”, “Y” and “M” can be used here, and a blank string indicating unknown position.
* *genotype*, a SNP genotypic matrix (i.e., the number of A alleles). SNP-major mode: \(n\_{sample} \times n\_{snp}\), individual-major mode: \(n\_{snp} \times n\_{sample}\).

Users can define the numeric chromosome codes which are stored with the variable *snp.chromosome* as its attributes when *snp.chromosome* is numeric only. For example, *snp.chromosome* has the attributes of chromosome coding:

```
# Get the attributes of chromosome coding
get.attr.gdsn(index.gdsn(genofile, "snp.chromosome"))
```

```
## $autosome.start
## [1] 1
##
## $autosome.end
## [1] 22
##
## $X
## [1] 23
##
## $XY
## [1] 24
##
## $Y
## [1] 25
##
## $M
## [1] 26
##
## $MT
## [1] 26
```

*autosome.start* is the starting numeric code of autosomes, and *autosome.end* is the last numeric code of autosomes. `put.attr.gdsn()` can be used to add a new attribute or modify an existing attribute.

There are four possible values stored in the variable *genotype*: 0, 1, 2 and 3. For bi-allelic SNP sites, “0” indicates two B alleles, “1” indicates one A allele and one B allele, “2” indicates two A alleles, and “3” is a missing genotype. For multi-allelic sites, it is a count of the reference allele (3 meaning no call). “Bit2” indicates that each byte encodes up to four SNP genotypes since one byte consists of eight bits.

```
# Take out genotype data for the first 3 samples and the first 5 SNPs
(g <- read.gdsn(index.gdsn(genofile, "genotype"), start=c(1,1), count=c(5,3)))
```

```
##      [,1] [,2] [,3]
## [1,]    2    1    0
## [2,]    1    1    0
## [3,]    2    1    1
## [4,]    2    1    1
## [5,]    0    0    0
```

Or take out genotype data with sample and SNP IDs, and four possible values are returned 0, 1, 2 and NA (3 is replaced by NA):

```
g <- snpgdsGetGeno(genofile, sample.id=..., snp.id=...)
```

```
# Get the attribute of genotype
get.attr.gdsn(index.gdsn(genofile, "genotype"))
```

```
## $sample.order
## NULL
```

The returned value could be either “snp.order” or “sample.order”, indicating individual-major mode (snp is the first dimension) and SNP-major mode (sample is the first dimension) respectively.

```
# Take out snp.id
head(read.gdsn(index.gdsn(genofile, "snp.id")))
```

```
## [1] 1 2 3 4 5 6
```

```
# Take out snp.rs.id
head(read.gdsn(index.gdsn(genofile, "snp.rs.id")))
```

```
## [1] "rs1695824"  "rs13328662" "rs4654497"  "rs10915489" "rs12132314"
## [6] "rs12042555"
```

There are two additional and optional variables:

1. *snp.rs.id*, a character string for reference SNP ID that may not be unique.
2. *snp.allele*, it is not necessary for the analysis, but it is necessary when merging genotypes from different platforms. The format of *snp.allele* is “A allele/B allele”, like “T/G” where T is A allele and G is B allele.

The information of sample annotation can be obtained by the same function `read.gdsn()`. For example, population information. “VStr8” indicates a character-type variable.

```
# Read population information
pop <- read.gdsn(index.gdsn(genofile, path="sample.annot/pop.group"))
table(pop)
```

```
## pop
## CEU HCB JPT YRI
##  92  47  47  93
```

```
# Close the GDS file
snpgdsClose(genofile)
```

\(~\)

## Create a GWAS SNP GDS File

### Using snpgdsCreateGeno()

The function `snpgdsCreateGeno()` can be used to create a GDS file. The first argument should be a numeric matrix for SNP genotypes. There are possible values stored in the input genotype matrix: 0, 1, 2 and other values. “0” indicates two B alleles, “1” indicates one A allele and one B allele, “2” indicates two A alleles, and other values indicate a missing genotype. The SNP matrix can be either \(n\_{sample} \times n\_{snp}\) (*snpfirstdim=FALSE*, the argument in `snpgdsCreateGeno()`) or \(n\_{snp} \times n\_{sample}\) (*snpfirstdim=TRUE*).

For example,

```
# Load data
data(hapmap_geno)

# Create a gds file
snpgdsCreateGeno("test.gds", genmat = hapmap_geno$genotype,
    sample.id = hapmap_geno$sample.id, snp.id = hapmap_geno$snp.id,
    snp.chromosome = hapmap_geno$snp.chromosome,
    snp.position = hapmap_geno$snp.position,
    snp.allele = hapmap_geno$snp.allele, snpfirstdim=TRUE)

# Open the GDS file
(genofile <- snpgdsOpen("test.gds"))
```

```
## File: /tmp/RtmpZPt4rp/Rbuild335668464a1318/SNPRelate/vignettes/test.gds (79.0K)
## +    [  ] *
## |--+ sample.id   { Str8 279 ZIP_ra(31.2%), 715B }
## |--+ snp.id   { Str8 1000 ZIP_ra(43.7%), 4.4K }
## |--+ snp.position   { Int32 1000 ZIP_ra(95.9%), 3.8K }
## |--+ snp.chromosome   { Int32 1000 ZIP_ra(2.25%), 97B }
## |--+ snp.allele   { Str8 1000 ZIP_ra(14.1%), 571B }
## \--+ genotype   { Bit2 1000x279, 68.1K } *
```

```
# Close the GDS file
snpgdsClose(genofile)
```

### Using the gdsfmt package

In the following code, the functions `createfn.gds()`, `add.gdsn()`, `put.attr.gdsn()`, `write.gdsn()` and `index.gdsn()` are defined in the package [gdsfmt](http://www.bioconductor.org/packages/gdsfmt):

```
# Create a new GDS file
newfile <- createfn.gds("your_gds_file.gds")

# add a flag
put.attr.gdsn(newfile$root, "FileFormat", "SNP_ARRAY")

# Add variables
add.gdsn(newfile, "sample.id", sample.id)
add.gdsn(newfile, "snp.id", snp.id)
add.gdsn(newfile, "snp.chromosome", snp.chromosome)
add.gdsn(newfile, "snp.position", snp.position)
add.gdsn(newfile, "snp.allele", c("A/G", "T/C", ...))

#####################################################################
# Create a snp-by-sample genotype matrix

# Add genotypes
var.geno <- add.gdsn(newfile, "genotype",
    valdim=c(length(snp.id), length(sample.id)), storage="bit2")

# Indicate the SNP matrix is snp-by-sample
put.attr.gdsn(var.geno, "snp.order")

# Write SNPs into the file sample by sample
for (i in 1:length(sample.id))
{
    g <- ...
    write.gdsn(var.geno, g, start=c(1,i), count=c(-1,1))
}

#####################################################################
# OR, create a sample-by-snp genotype matrix

# Add genotypes
var.geno <- add.gdsn(newfile, "genotype",
    valdim=c(length(sample.id), length(snp.id)), storage="bit2")

# Indicate the SNP matrix is sample-by-snp
put.attr.gdsn(var.geno, "sample.order")

# Write SNPs into the file sample by sample
for (i in 1:length(snp.id))
{
    g <- ...
    write.gdsn(var.geno, g, start=c(1,i), count=c(-1,1))
}

# Get a description of chromosome codes
#   allowing to define a new chromosome code, e.g., snpgdsOption(Z=27)
option <- snpgdsOption()
var.chr <- index.gdsn(newfile, "snp.chromosome")
put.attr.gdsn(var.chr, "autosome.start", option$autosome.start)
put.attr.gdsn(var.chr, "autosome.end", option$autosome.end)
for (i in 1:length(option$chromosome.code))
{
    put.attr.gdsn(var.chr, names(option$chromosome.code)[i],
        option$chromosome.code[[i]])
}

# Add your sample annotation
samp.annot <- data.frame(sex = c("male", "male", "female", ...),
    pop.group = c("CEU", "CEU", "JPT", ...), ...)
add.gdsn(newfile, "sample.annot", samp.annot)

# Add your SNP annotation
snp.annot <- data.frame(pass=c(TRUE, TRUE, FALSE, FALSE, TRUE, ...), ...)
add.gdsn(newfile, "snp.annot", snp.annot)

# Close the GDS file
closefn.gds(newfile)
```

## Format conversion from PLINK text/binary files

The [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) package provides a function `snpgdsPED2GDS()` and `snpgdsBED2GDS()` for converting a PLINK text/binary file to a GDS file:

```
# The PLINK BED file, using the example in the SNPRelate package
bed.fn <- system.file("extdata", "plinkhapmap.bed.gz", package="SNPRelate")
fam.fn <- system.file("extdata", "plinkhapmap.fam.gz", package="SNPRelate")
bim.fn <- system.file("extdata", "plinkhapmap.bim.gz", package="SNPRelate")
```

Or, uses your PLINK files:

```
bed.fn <- "C:/your_folder/your_plink_file.bed"
fam.fn <- "C:/your_folder/your_plink_file.fam"
bim.fn <- "C:/your_folder/your_plink_file.bim"
```

```
# Convert
snpgdsBED2GDS(bed.fn, fam.fn, bim.fn, "test.gds")
```

```
## Start file conversion from PLINK BED to SNP GDS ...
##     BED file: '/tmp/RtmpZPt4rp/Rinst3356681854b2b4/SNPRelate/extdata/plinkhapmap.bed.gz'
##         SNP-major mode (Sample X SNP), 45.7K
##     FAM file: '/tmp/RtmpZPt4rp/Rinst3356681854b2b4/SNPRelate/extdata/plinkhapmap.fam.gz'
##     BIM file: '/tmp/RtmpZPt4rp/Rinst3356681854b2b4/SNPRelate/extdata/plinkhapmap.bim.gz'
## Thu Oct 30 02:36:21 2025     (store sample id, snp id, position, and chromosome)
##     start writing: 60 samples, 5000 SNPs ...
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## Thu Oct 30 02:36:21 2025     Done.
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file 'test.gds' (98.1K)
##     # of fragments: 38
##     save to 'test.gds.tmp'
##     rename 'test.gds.tmp' (97.8K, reduced: 240B)
##     # of fragments: 18
```

```
# Summary
snpgdsSummary("test.gds")
```

```
## The file name: /tmp/RtmpZPt4rp/Rbuild335668464a1318/SNPRelate/vignettes/test.gds
## The total number of samples: 60
## The total number of SNPs: 5000
## SNP genotypes are stored in SNP-major mode (Sample X SNP).
```

## Format conversion from VCF files

The [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) package provides a function `snpgdsVCF2GDS()` to reformat a VCF file. There are two options for extracting markers from a VCF file for downstream analyses: 1. to extract and store dosage of the reference allele only for biallelic SNPs 2. to extract and store dosage of the reference allele for all variant sites, including bi-allelic SNPs, multi-allelic SNPs, indels and structural variants.

```
# The VCF file, using the example in the SNPRelate package
vcf.fn <- system.file("extdata", "sequence.vcf", package="SNPRelate")
```

Or, uses your VCF file:

```
vcf.fn <- "C:/your_folder/your_vcf_file.vcf"
```

```
# Reformat
snpgdsVCF2GDS(vcf.fn, "test.gds", method="biallelic.only")
```

```
## Start file conversion from VCF to SNP GDS ...
## Method: extracting biallelic SNPs
## Number of samples: 3
## Parsing "/tmp/RtmpZPt4rp/Rinst3356681854b2b4/SNPRelate/extdata/sequence.vcf" ...
##  import 2 variants.
## + genotype   { Bit2 3x2, 2B } *
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file 'test.gds' (2.9K)
##     # of fragments: 46
##     save to 'test.gds.tmp'
##     rename 'test.gds.tmp' (2.6K, reduced: 312B)
##     # of fragments: 20
```

```
# Summary
snpgdsSummary("test.gds")
```

```
## The file name: /tmp/RtmpZPt4rp/Rbuild335668464a1318/SNPRelate/vignettes/test.gds
## The total number of samples: 3
## The total number of SNPs: 2
## SNP genotypes are stored in SNP-major mode (Sample X SNP).
```

## Format conversion from VCF files using SeqArray

The [SeqArray](http://www.bioconductor.org/packages/SeqArray) package provides a function `seqVCF2GDS()` to reformat a VCF file, and it allows merging multiple VCF files during format conversion. The genotypic and annotation data are stored in a compressed manner by default. SeqArray is suited for large-scale whole-exome and whole-genome sequencing variant data. See: [SeqArray R Integration](http://www.bioconductor.org/packages/devel/bioc/vignettes/SeqArray/inst/doc/SeqArray.html) for more details. It is strongly suggested to use SeqArray for large-scale whole-genome sequencing variant data.

```
library(SeqArray)

# the VCF file, using the example in the SeqArray package
vcf.fn <- seqExampleFileName("vcf")
# or vcf.fn <- "C:/YourFolder/Your_VCF_File.vcf.gz"

# convert, save in "tmp.gds" with the default lzma compression algorithm
seqVCF2GDS(vcf.fn, "test.gds")
```

```
## Tue Mar 20 13:53:38 2018
## Variant Call Format (VCF) Import:
##     file(s):
##         CEU_Exon.vcf.gz (226.0K)
##     file format: VCFv4.0
##     the number of sets of chromosomes (ploidy): 2
##     the number of samples: 90
##     genotype storage: bit2
##     compression method: LZMA_RA
## Output:
##     test.gds
## Parsing 'CEU_Exon.vcf.gz':
## + genotype/data   { Bit2 2x90x1348 LZMA_ra, 42B }
## Digests:
##     sample.id  [md5: ac460b05cf0de81d3a307259fb908238]
##     variant.id  [md5: c9602a5420b6a5a148f5a0120a8750e1]
##     position  [md5: a23801beb47fb2d7ca26b65d2b71e622]
##     chromosome  [md5: a46ad5529a68298eb581c7c66b31b99b]
##     allele  [md5: e65988a36b2675d1e4f6a9ad9d2774a9]
##     genotype  [md5: 318c71bd2c1878e7d05c6e4b8b3067ef]
##     phase  [md5: 4873107397a2eec80cca77d8fa09592b]
##     annotation/id  [md5: 164df6a971c24c99ad386bbaf8759cb2]
##     annotation/qual  [md5: ff3b3c516fe7081c406d4c26782b44e4]
##     annotation/filter  [md5: 5b09a6e58b307857c38e3d82284dfff0]
##     annotation/info/AA  [md5: 7bba129ada9e50a98db7451044abdde9]
##     annotation/info/AC  [md5: 79076139f25b3f78164182af5d86c680]
##     annotation/info/AN  [md5: b4c305461e62a78dc439f7a1df50e5fc]
##     annotation/info/DP  [md5: 9f358649989b5fd48fba25b6b50af02f]
##     annotation/info/HM2  [md5: 9b792cdd10840bdda63d77a1ce065588]
##     annotation/info/HM3  [md5: b936dc73a3ffa1241305dfdcc14d71e1]
##     annotation/info/OR  [md5: 6f6f800d686268b592ac50f10c5851b9]
##     annotation/info/GP  [md5: a1ccfb37b78edd2bb1204c8b9c901b0a]
##     annotation/info/BN  [md5: 0ac62828c0c8d3d27cbd15aa975532fd]
##     annotation/format/DP  [md5: d967efdfcb57f3327af2cbf1adc21bbb]
## Done.
## Tue Mar 20 13:53:39 2018
## Optimize the access efficiency ...
## Clean up the fragments of GDS file:
##     open the file 'test.gds' (163.3K)
##     # of fragments: 155
##     save to 'test.gds.tmp'
##     rename 'test.gds.tmp' (162.3K, reduced: 1.0K)
##     # of fragments: 66
## Tue Mar 20 13:53:39 2018
```

Get Data:

```
# open a GDS file
genofile <- seqOpen("test.gds")
```

It is suggested to use `seqGetData()` to take out data from the SeqArray file since this function can take care of variable-length data and multi-allelic genotypes, although users could also use `read.gdsn()` in the [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) package to read data.

```
# take out sample id
head(samp.id <- seqGetData(genofile, "sample.id"))
## [1] "NA06984" "NA06985" "NA06986" "NA06989" "NA06994" "NA07000"

# take out variant id
head(variant.id <- seqGetData(genofile, "variant.id"))
## [1] 1 2 3 4 5 6

# get "chromosome"
table(seqGetData(genofile, "chromosome"))
##   1  10  11  12  13  14  15  16  17  18  19   2  20  21  22   3   4   5   6   7   8   9
## 142  70  16  62  11  61  46  84 100  54 111  59  59  23  23  81  48  61  99  58  51  29

# get "allele"
head(seqGetData(genofile, "allele"))
## [1] "T,C" "G,A" "G,A" "T,C" "G,C" "C,T"

# get "annotation/info/GP"
head(seqGetData(genofile, "annotation/info/GP"))
## [1] "1:1115503" "1:1115548" "1:1120431" "1:3548136" "1:3548832" "1:3551737"

# get "sample.annotation/family"
head(seqGetData(genofile, "sample.annotation/family"))
## [1] "1328"  ""      "13291" "1328"  "1340"  "1340"
```

Users can set a filter to samples and/or variants by `seqSetFilter()`. For example, a subset consisting of three samples and four variants:

```
# set sample and variant filters
seqSetFilter(genofile, sample.id=samp.id[c(2,4,6)])
# or seqSetFilter(genofile, sample.sel=c(2,4,6))
## # of selected samples: 3
set.seed(100)
seqSetFilter(genofile, variant.id=sample(variant.id, 4))
# or seqSetFilter(genofile, variant.sel=...) # an integer vector
## # of selected variants: 4
# get "allele"
seqGetData(genofile, "allele")
## [1] "T,A" "G,A" "G,C" "A,G"
```

Get genotypic data, it is a 3-dimensional array with respect to allele, sample and variant. 0 refers to the reference allele (or the first allele in the variable allele), 1 for the second allele, and so on, while NA is missing allele.

```
# get genotypic data
seqGetData(genofile, "genotype")
## , , 1
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## , , 2
##       sample
## allele [,1] [,2] [,3]
##   [1,]    1    0    0
##   [2,]    0    0    0
##
## , , 3
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
##
## , , 4
##       sample
## allele [,1] [,2] [,3]
##   [1,]    0    0    0
##   [2,]    0    0    0
```

Get regular genotypes (i.e., genotype dosage, or the number of copies of reference allele), it is an integer matrix.

```
# get the dosage of reference allele
seqGetData(genofile, "$dosage")
##       variant
## sample [,1] [,2] [,3] [,4]
##   [1,]    2    1    2    2
##   [2,]    2    2    2    2
##   [3,]    2    2    2    2

# close the file
seqClose(genofile)
```

\(~\)

# Data Analysis

We developed [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) and [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) (high-performance computing R packages for multi-core symmetric multiprocessing computer architectures) to accelerate two key computations in GWAS: principal component analysis (PCA) and relatedness analysis using identity-by-descent (IBD) measures.

```
# Open the GDS file
genofile <- snpgdsOpen(snpgdsExampleFileName())
```

```
# Get population information
#   or pop_code <- scan("pop.txt", what=character())
#   if it is stored in a text file "pop.txt"
pop_code <- read.gdsn(index.gdsn(genofile, path="sample.annot/pop.group"))

table(pop_code)
```

```
## pop_code
## CEU HCB JPT YRI
##  92  47  47  93
```

```
# Display the first six values
head(pop_code)
```

```
## [1] "YRI" "YRI" "YRI" "YRI" "CEU" "CEU"
```

\(~\)

## LD-based SNP pruning

It is suggested to use a pruned set of SNPs which are in approximate linkage equilibrium with each other to avoid the strong influence of SNP clusters in principal component analysis and relatedness analysis.

```
set.seed(1000)

# Try different LD thresholds for sensitivity analysis
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2)
```

```
## SNP pruning based on LD:
## Excluding 365 SNPs on non-autosomes
## Excluding 689 SNPs (monomorphic: TRUE, MAF: 0.005, missing rate: 0.01)
##     # of samples: 279
##     # of SNPs: 8,034
##     using 1 thread/core
##     sliding window: 500,000 basepairs, Inf SNPs
##     |LD| threshold: 0.2
##     method: composite
## Chrom 1: |====================|====================|
##     70.25%, 503 / 716 (Thu Oct 30 02:36:21 2025)
## Chrom 2: |====================|====================|
##     69.14%, 513 / 742 (Thu Oct 30 02:36:21 2025)
## Chrom 3: |====================|====================|
##     70.28%, 428 / 609 (Thu Oct 30 02:36:21 2025)
## Chrom 4: |====================|====================|
##     67.62%, 380 / 562 (Thu Oct 30 02:36:21 2025)
## Chrom 5: |====================|====================|
##     72.79%, 412 / 566 (Thu Oct 30 02:36:21 2025)
## Chrom 6: |====================|====================|
##     69.73%, 394 / 565 (Thu Oct 30 02:36:21 2025)
## Chrom 7: |====================|====================|
##     71.61%, 338 / 472 (Thu Oct 30 02:36:21 2025)
## Chrom 8: |====================|====================|
##     65.78%, 321 / 488 (Thu Oct 30 02:36:21 2025)
## Chrom 9: |====================|====================|
##     72.12%, 300 / 416 (Thu Oct 30 02:36:21 2025)
## Chrom 10: |====================|====================|
##     69.57%, 336 / 483 (Thu Oct 30 02:36:21 2025)
## Chrom 11: |====================|====================|
##     72.48%, 324 / 447 (Thu Oct 30 02:36:21 2025)
## Chrom 12: |====================|====================|
##     70.96%, 303 / 427 (Thu Oct 30 02:36:21 2025)
## Chrom 13: |====================|====================|
##     72.97%, 251 / 344 (Thu Oct 30 02:36:21 2025)
## Chrom 14: |====================|====================|
##     71.99%, 203 / 282 (Thu Oct 30 02:36:21 2025)
## Chrom 15: |====================|====================|
##     70.99%, 186 / 262 (Thu Oct 30 02:36:21 2025)
## Chrom 16: |====================|====================|
##     67.63%, 188 / 278 (Thu Oct 30 02:36:21 2025)
## Chrom 17: |====================|====================|
##     70.53%, 146 / 207 (Thu Oct 30 02:36:21 2025)
## Chrom 18: |====================|====================|
##     70.30%, 187 / 266 (Thu Oct 30 02:36:21 2025)
## Chrom 19: |====================|====================|
##     78.33%, 94 / 120 (Thu Oct 30 02:36:21 2025)
## Chrom 20: |====================|====================|
##     66.81%, 153 / 229 (Thu Oct 30 02:36:21 2025)
## Chrom 21: |====================|====================|
##     70.63%, 89 / 126 (Thu Oct 30 02:36:21 2025)
## Chrom 22: |====================|====================|
##     68.97%, 80 / 116 (Thu Oct 30 02:36:21 2025)
## 6,129 markers are selected in total.
```

```
str(snpset)
```

```
## List of 22
##  $ chr1 : int [1:503] 1 2 3 5 7 10 11 14 15 16 ...
##  $ chr2 : int [1:513] 717 718 719 720 721 723 724 725 726 727 ...
##  $ chr3 : int [1:428] 1459 1461 1464 1466 1468 1469 1470 1472 1474 1476 ...
##  $ chr4 : int [1:380] 2068 2069 2070 2071 2072 2074 2076 2077 2078 2079 ...
##  $ chr5 : int [1:412] 2630 2631 2635 2636 2637 2638 2640 2642 2643 2645 ...
##  $ chr6 : int [1:394] 3196 3197 3198 3200 3201 3204 3205 3206 3207 3208 ...
##  $ chr7 : int [1:338] 3761 3762 3763 3766 3767 3768 3770 3771 3772 3773 ...
##  $ chr8 : int [1:321] 4233 4234 4235 4237 4238 4239 4240 4241 4242 4244 ...
##  $ chr9 : int [1:300] 4721 4722 4724 4727 4728 4730 4731 4733 4735 4736 ...
##  $ chr10: int [1:336] 5137 5139 5140 5143 5144 5145 5146 5147 5148 5149 ...
##  $ chr11: int [1:324] 5620 5623 5624 5625 5626 5628 5630 5631 5632 5633 ...
##  $ chr12: int [1:303] 6067 6068 6069 6070 6073 6074 6075 6077 6078 6079 ...
##  $ chr13: int [1:251] 6494 6497 6498 6499 6500 6501 6503 6505 6507 6509 ...
##  $ chr14: int [1:203] 6840 6841 6842 6843 6844 6845 6846 6847 6848 6850 ...
##  $ chr15: int [1:186] 7120 7121 7122 7124 7125 7126 7127 7128 7129 7130 ...
##  $ chr16: int [1:188] 7382 7383 7385 7387 7388 7389 7391 7392 7394 7395 ...
##  $ chr17: int [1:146] 7660 7661 7662 7663 7664 7665 7666 7667 7668 7669 ...
##  $ chr18: int [1:187] 7867 7868 7869 7870 7871 7872 7873 7874 7875 7876 ...
##  $ chr19: int [1:94] 8133 8135 8136 8137 8138 8139 8140 8141 8142 8144 ...
##  $ chr20: int [1:153] 8253 8257 8258 8259 8260 8261 8262 8265 8266 8267 ...
##  $ chr21: int [1:89] 8482 8484 8485 8486 8487 8488 8489 8490 8491 8492 ...
##  $ chr22: int [1:80] 8608 8609 8610 8612 8613 8614 8615 8617 8618 8625 ...
```

```
names(snpset)
```

```
##  [1] "chr1"  "chr2"  "chr3"  "chr4"  "chr5"  "chr6"  "chr7"  "chr8"  "chr9"
## [10] "chr10" "chr11" "chr12" "chr13" "chr14" "chr15" "chr16" "chr17" "chr18"
## [19] "chr19" "chr20" "chr21" "chr22"
```

```
# Get all selected snp id
snpset.id <- unlist(unname(snpset))
head(snpset.id)
```

```
## [1]  1  2  3  5  7 10
```

\(~\)

## Principal Component Analysis (PCA)

The functions in [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) for PCA include calculating the genetic covariance matrix from genotypes, computing the correlation coefficients between sample loadings and genotypes for each SNP, calculating SNP eigenvectors (loadings), and estimating the sample loadings of a new dataset from specified SNP eigenvectors.

```
# Run PCA
pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=2)
```

```
## Principal Component Analysis (PCA) on genotypes:
## Excluding 2,959 SNPs (non-autosomes or non-selection)
## Excluding 0 SNP (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 279
##     # of SNPs: 6,129
##     using 2 threads/cores
##     # of principal components: 32
## PCA:    the sum of all selected genotypes (0,1,2) = 1711002
## CPU capabilities: Double-Precision SSE2
## 2025-10-30 02:36:21    (internal increment: 11140)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2025-10-30 02:36:21    Begin (eigenvalues and eigenvectors)
## 2025-10-30 02:36:21    Done.
```

The code below shows how to calculate the percent of variation is accounted for by the top principal components. It is clear to see the first two eigenvectors hold the largest percentage of variance among the population, although the total variance accounted for is still less the one-quarter of the total.

```
# variance proportion (%)
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))
```

```
## [1] 10.31  5.65  1.02  0.99  0.88  0.78
```

In the case of no prior population information,

```
# make a data.frame
tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],    # the first eigenvector
    EV2 = pca$eigenvect[,2],    # the second eigenvector
    stringsAsFactors = FALSE)
head(tab)
```

```
##   sample.id         EV1          EV2
## 1   NA19152 -0.08055194  0.008311421
## 2   NA19139 -0.08552919  0.011338525
## 3   NA18912 -0.08320703  0.011996500
## 4   NA19160 -0.08435602  0.012500300
## 5   NA07034  0.03229719 -0.078475633
## 6   NA07055  0.03444019 -0.082666970
```

```
# Draw
plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")
```

![](data:image/png;base64...)

If there are population information,

```
# Get sample id
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))

# Get population information
#   or pop_code <- scan("pop.txt", what=character())
#   if it is stored in a text file "pop.txt"
pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group"))

# assume the order of sample IDs is as the same as population codes
head(cbind(sample.id, pop_code))
```

```
##      sample.id pop_code
## [1,] "NA19152" "YRI"
## [2,] "NA19139" "YRI"
## [3,] "NA18912" "YRI"
## [4,] "NA19160" "YRI"
## [5,] "NA07034" "CEU"
## [6,] "NA07055" "CEU"
```

```
# Make a data.frame
tab <- data.frame(sample.id = pca$sample.id,
    pop = factor(pop_code)[match(pca$sample.id, sample.id)],
    EV1 = pca$eigenvect[,1],    # the first eigenvector
    EV2 = pca$eigenvect[,2],    # the second eigenvector
    stringsAsFactors = FALSE)
head(tab)
```

```
##   sample.id pop         EV1          EV2
## 1   NA19152 YRI -0.08055194  0.008311421
## 2   NA19139 YRI -0.08552919  0.011338525
## 3   NA18912 YRI -0.08320703  0.011996500
## 4   NA19160 YRI -0.08435602  0.012500300
## 5   NA07034 CEU  0.03229719 -0.078475633
## 6   NA07055 CEU  0.03444019 -0.082666970
```

```
# Draw
plot(tab$EV2, tab$EV1, col=as.integer(tab$pop), xlab="eigenvector 2", ylab="eigenvector 1")
legend("bottomright", legend=levels(tab$pop), pch="o", col=1:nlevels(tab$pop))
```

![](data:image/png;base64...)

Plot the principal component pairs for the first four PCs:

```
lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")
pairs(pca$eigenvect[,1:4], col=tab$pop, labels=lbls)
```

![](data:image/png;base64...)

Parallel coordinates plot for the top principal components:

```
library(MASS)

datpop <- factor(pop_code)[match(pca$sample.id, sample.id)]
parcoord(pca$eigenvect[,1:16], col=datpop)
```

![](data:image/png;base64...)

To calculate the SNP correlations between eigenvactors and SNP genotypes:

```
# Get chromosome index
chr <- read.gdsn(index.gdsn(genofile, "snp.chromosome"))
CORR <- snpgdsPCACorr(pca, genofile, eig.which=1:4)
```

```
## SNP Correlation:
##     # of samples: 279
##     # of SNPs: 9,088
##     using 1 thread
## Correlation:    the sum of all selected genotypes (0,1,2) = 2553065
## 2025-10-30 02:36:23    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2025-10-30 02:36:23    Done.
```

```
savepar <- par(mfrow=c(2,1), mai=c(0.45, 0.55, 0.1, 0.25))
for (i in 1:2)
{
    plot(abs(CORR$snpcorr[i,]), ylim=c(0,1), xlab="", ylab=paste("PC", i),
        col=chr, pch="+")
}
```

![](data:image/png;base64...)

```
par(savepar)
```

\(~\)

## \(F\_{st}\) Estimation

Given two or more populations, \(F\_{st}\) can be estimated by the method of Weir & Cockerham (1984).

```
# Get sample id
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))

# Get population information
#   or pop_code <- scan("pop.txt", what=character())
#   if it is stored in a text file "pop.txt"
pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group"))

# Two populations: HCB and JPT
flag <- pop_code %in% c("HCB", "JPT")
samp.sel <- sample.id[flag]
pop.sel <- pop_code[flag]
v <- snpgdsFst(genofile, sample.id=samp.sel, population=as.factor(pop.sel),
    method="W&C84")
```

```
## Fst estimation on genotypes:
## Excluding 365 SNPs on non-autosomes
## Excluding 2,446 SNPs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 94
##     # of SNPs: 6,277
## Method: Weir & Cockerham, 1984
## # of Populations: 2
##     HCB (47), JPT (47)
```

```
v$Fst        # Weir and Cockerham weighted Fst estimate
```

```
## [1] 0.007510133
```

```
v$MeanFst    # Weir and Cockerham mean Fst estimate
```

```
## [1] 0.007051144
```

```
summary(v$FstSNP)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
## -0.010753 -0.008546 -0.001172  0.007051  0.012537  0.193880
```

```
# Multiple populations: CEU HCB JPT YRI
#   we should remove offsprings
father <- read.gdsn(index.gdsn(genofile, "sample.annot/father.id"))
mother <- read.gdsn(index.gdsn(genofile, "sample.annot/mother.id"))
flag <- (father=="") & (mother=="")
samp.sel <- sample.id[flag]
pop.sel <- pop_code[flag]
v <- snpgdsFst(genofile, sample.id=samp.sel, population=as.factor(pop.sel),
    method="W&C84")
```

```
## Fst estimation on genotypes:
## Excluding 365 SNPs on non-autosomes
## Excluding 567 SNPs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 219
##     # of SNPs: 8,156
## Method: Weir & Cockerham, 1984
## # of Populations: 4
##     CEU (62), HCB (47), JPT (47), YRI (63)
```

```
v$Fst        # Weir and Cockerham weighted Fst estimate
```

```
## [1] 0.1377965
```

```
v$MeanFst    # Weir and Cockerham mean Fst estimate
```

```
## [1] 0.1213132
```

```
summary(v$FstSNP)
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
## -0.009225  0.042926  0.092284  0.121313  0.168309  0.792465
```

\(~\)

## Relatedness Analysis

For relatedness analysis, identity-by-descent (IBD) estimation in [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) can be done by either the method of moments (MoM) (Purcell et al., 2007) or maximum likelihood estimation (MLE) (Milligan, 2003; Choi et al., 2009). For both of these methods it is preffered to use a LD pruned SNP set.

```
# YRI samples
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
YRI.id <- sample.id[pop_code == "YRI"]
```

### Estimating IBD Using PLINK method of moments (MoM)

```
# Estimate IBD coefficients
ibd <- snpgdsIBDMoM(genofile, sample.id=YRI.id, snp.id=snpset.id,
    maf=0.05, missing.rate=0.05, num.thread=2)
```

```
## IBD analysis (PLINK method of moment) on genotypes:
## Excluding 2,959 SNPs (non-autosomes or non-selection)
## Excluding 1,110 SNPs (monomorphic: TRUE, MAF: 0.05, missing rate: 0.05)
##     # of samples: 93
##     # of SNPs: 5,019
##     using 2 threads/cores
## PLINK IBD:    the sum of all selected genotypes (0,1,2) = 461841
## 2025-10-30 02:36:24    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2025-10-30 02:36:24    Done.
```

```
# Make a data.frame
ibd.coeff <- snpgdsIBDSelection(ibd)
head(ibd.coeff)
```

```
##       ID1     ID2        k0         k1    kinship
## 1 NA19152 NA19139 0.9538935 0.04610650 0.01152662
## 2 NA19152 NA18912 1.0000000 0.00000000 0.00000000
## 3 NA19152 NA19160 1.0000000 0.00000000 0.00000000
## 4 NA19152 NA18515 0.9483811 0.05161886 0.01290472
## 5 NA19152 NA19222 1.0000000 0.00000000 0.00000000
## 6 NA19152 NA18508 1.0000000 0.00000000 0.00000000
```

```
plot(ibd.coeff$k0, ibd.coeff$k1, xlim=c(0,1), ylim=c(0,1),
    xlab="k0", ylab="k1", main="YRI samples (MoM)")
lines(c(0,1), c(1,0), col="red", lty=2)
```

![](data:image/png;base64...)

### Estimating IBD Using Maximum Likelihood Estimation (MLE)

```
# Estimate IBD coefficients
set.seed(100)
snp.id <- sample(snpset.id, 1500)  # random 1500 SNPs
ibd <- snpgdsIBDMLE(genofile, sample.id=YRI.id, snp.id=snp.id,
    maf=0.05, missing.rate=0.05, num.thread=2)
```

```
## Identity-By-Descent analysis (MLE) on genotypes:
## Excluding 7,588 SNPs (non-autosomes or non-selection)
## Excluding 263 SNPs (monomorphic: TRUE, MAF: 0.05, missing rate: 0.05)
##     # of samples: 93
##     # of SNPs: 1,237
##     using 2 threads/cores
## MLE IBD:    the sum of all selected genotypes (0,1,2) = 111017
## MLE IBD: Thu Oct 30 02:36:25 2025    0%
```

```
# Make a data.frame
ibd.coeff <- snpgdsIBDSelection(ibd)

plot(ibd.coeff$k0, ibd.coeff$k1, xlim=c(0,1), ylim=c(0,1),
    xlab="k0", ylab="k1", main="YRI samples (MLE)")
lines(c(0,1), c(1,0), col="red", lty=2)
```

![](data:image/png;base64...)

### Relationship inference Using KING method of moments

Within- and between-family relationship could be inferred by [the KING-robust method](https://www.chen.kingrelatedness.com) in the presence of population stratification.

```
# Incorporate with pedigree information
family.id <- read.gdsn(index.gdsn(genofile, "sample.annot/family.id"))
family.id <- family.id[match(YRI.id, sample.id)]
table(family.id)
```

```
## family.id
## 101 105 112 117  12  13  16  17  18  23  24  28   4  40  42  43  45  47  48   5
##   3   3   3   4   4   3   3   3   3   3   4   3   3   3   3   3   3   3   3   3
##  50  51  56  58  60  71  72  74  77   9
##   3   3   3   3   3   3   3   3   3   3
```

```
ibd.robust <- snpgdsIBDKING(genofile, sample.id=YRI.id,
    family.id=family.id, num.thread=2)
```

```
## IBD analysis (KING method of moment) on genotypes:
## Excluding 365 SNPs on non-autosomes
## Excluding 1,730 SNPs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 93
##     # of SNPs: 6,993
##     using 2 threads/cores
## # of families: 30, and within- and between-family relationship are estimated differently.
## Relationship inference in the presence of population stratification.
## KING IBD:    the sum of all selected genotypes (0,1,2) = 648378
## CPU capabilities: Double-Precision SSE2
## 2025-10-30 02:36:35    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2025-10-30 02:36:35    Done.
```

```
names(ibd.robust)
```

```
## [1] "sample.id" "snp.id"    "afreq"     "IBS0"      "kinship"
```

```
# Pairs of individuals
dat <- snpgdsIBDSelection(ibd.robust)
head(dat)
```

```
##       ID1     ID2       IBS0      kinship
## 1 NA19152 NA19139 0.05705706 -0.012976190
## 2 NA19152 NA18912 0.05877306 -0.005356311
## 3 NA19152 NA19160 0.06292006 -0.032436329
## 4 NA19152 NA18515 0.05748606  0.008678990
## 5 NA19152 NA19222 0.06134706 -0.018821023
## 6 NA19152 NA18508 0.05791506 -0.001971243
```

```
plot(dat$IBS0, dat$kinship, xlab="Proportion of Zero IBS",
    ylab="Estimated Kinship Coefficient (KING-robust)")
```

![](data:image/png;base64...)

\(~\)

## Identity-By-State Analysis

For \(n\) study individuals, `snpgdsIBS()` can be used to create a \(n \times n\) matrix of genome-wide average IBS pairwise identities:

```
ibs <- snpgdsIBS(genofile, num.thread=2)
```

```
## Identity-By-State (IBS) analysis on genotypes:
## Excluding 365 SNPs on non-autosomes
## Excluding 684 SNPs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 279
##     # of SNPs: 8,039
##     using 2 threads/cores
## IBS:    the sum of all selected genotypes (0,1,2) = 2253891
## 2025-10-30 02:36:36    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2025-10-30 02:36:36    Done.
```

The heat map is shown:

```
# individulas in the same population are clustered together
pop.idx <- order(pop_code)

image(ibs$ibs[pop.idx, pop.idx], col=terrain.colors(16))
```

![](data:image/png;base64...)

To perform multidimensional scaling analysis on the \(n \times n\) matrix of genome-wide IBS pairwise distances:

```
loc <- cmdscale(1 - ibs$ibs, k = 2)
x <- loc[, 1]; y <- loc[, 2]
race <- as.factor(pop_code)

plot(x, y, col=race, xlab = "", ylab = "",
    main = "Multidimensional Scaling Analysis (IBS)")
legend("topleft", legend=levels(race), pch="o", text.col=1:nlevels(race))
```

![](data:image/png;base64...)

To perform cluster analysis on the \(n \times n\) matrix of genome-wide IBS pairwise distances, and determine the groups by a permutation score:

```
set.seed(100)
ibs.hc <- snpgdsHCluster(snpgdsIBS(genofile, num.thread=2))
```

```
## Identity-By-State (IBS) analysis on genotypes:
## Excluding 365 SNPs on non-autosomes
## Excluding 684 SNPs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 279
##     # of SNPs: 8,039
##     using 2 threads/cores
## IBS:    the sum of all selected genotypes (0,1,2) = 2253891
## 2025-10-30 02:36:36    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2025-10-30 02:36:36    Done.
```

```
# Determine groups of individuals automatically
rv <- snpgdsCutTree(ibs.hc)
```

```
## Determine groups by permutation (Z threshold: 15, outlier threshold: 5):
## Create 3 groups.
```

```
plot(rv$dendrogram, leaflab="none", main="HapMap Phase II")
```

![](data:image/png;base64...)

```
table(rv$samp.group)
```

```
##
## G001 G002 G003
##   93   94   92
```

Here is the population information we have known:

```
# Determine groups of individuals by population information
rv2 <- snpgdsCutTree(ibs.hc, samp.group=as.factor(pop_code))
```

```
## Create 4 groups.
```

```
plot(rv2$dendrogram, leaflab="none", main="HapMap Phase II")
legend("topright", legend=levels(race), col=1:nlevels(race), pch=19, ncol=4)
```

![](data:image/png;base64...)

```
# Close the GDS file
snpgdsClose(genofile)
```

\(~\)

# Integration with SeqArray

The extended GDS format is implemented in the SeqArray package to support the storage of single nucleotide variation (SNV), insertion/deletion polymorphism (indel) and structural variation calls. See: [SeqArray R Integration](http://www.bioconductor.org/packages/release/bioc/vignettes/SeqArray/inst/doc/SeqArray.html) 4.

\(~\)

# Function List

| Function | Description |
| --- | --- |
| **Data Format:** |  |
| snpgdsBED2GDS | Conversion from PLINK BED to GDS [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsBED2GDS.html) |
| snpgdsGEN2GDS | Conversion from Oxford GEN format to GDS [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsGEN2GDS.html) |
| snpgdsPED2GDS | Conversion from PLINK PED to GDS [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsPED2GDS.html) |
| snpgdsVCF2GDS | Reformat VCF file(s) [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsVCF2GDS.html) |
| **Principal Component Analysis:** |  |
| snpgdsPCA | Principal Component Analysis (PCA) [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsPCA.html) |
| snpgdsPCACorr | PC-correlated SNPs in PCA [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsPCACorr.html) |
| snpgdsPCASampLoading | Project individuals onto existing principal component axes [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsPCASampLoading.html) |
| snpgdsPCASNPLoading | SNP loadings in principal component analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsPCASNPLoading.html) |
| snpgdsEIGMIX | Eigen-analysis on SNP genotype data [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsEIGMIX.html) |
| snpgdsAdmixProp | Estimate ancestral proportions from the eigen-analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsAdmixProp.html) |
| **Identity By Descent:** |  |
| snpgdsIBDMLE | Maximum likelihood estimation (MLE) for the Identity-By-Descent (IBD) Analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIBDMLE.html) |
| snpgdsIBDMLELogLik | Log likelihood for MLE method in the Identity-By-Descent (IBD) Analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIBDMLELogLik.html) |
| snpgdsIBDMoM | PLINK method of moment (MoM) for the Identity-By-Descent (IBD) Analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIBDMoM.html) |
| snpgdsIBDKING | KING method of moment for the identity-by-descent (IBD) analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIBDKING.html) |
| snpgdsGRM | Genetic Relationship Matrix (GRM) for SNP genotype data [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsGRM.html) |
| snpgdsFst | F-statistics (fixation index) [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsFst.html) |
| snpgdsIndInb | Individual Inbreeding Coefficients [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIndInb.html) |
| snpgdsIndInbCoef | Individual Inbreeding Coefficient [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIndInbCoef.html) |
| **Clustering:** |  |
| snpgdsIBS | Identity-By-State (IBS) proportion [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIBS.html) |
| snpgdsIBSNum | Identity-By-State (IBS) [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsIBSNum.html) |
| snpgdsDiss | Individual dissimilarity analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsDiss.html) |
| snpgdsHCluster | Hierarchical cluster analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsHCluster.html) |
| snpgdsCutTree | Determine clusters of individuals [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsCutTree.html) |
| snpgdsDrawTree | Draw a dendrogram [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsDrawTree.html) |
| **Linkage Disequilibrium:** |  |
| snpgdsLDMat | Linkage Disequilibrium (LD) analysis [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsLDMat.html) |
| snpgdsLDpruning | LD-based SNP pruning [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsLDpruning.html) |
| snpgdsApartSelection | SNP pruning with a minimum basepair distance [»](https://rdrr.io/bioc/SNPRelate/man/snpgdsApartSelection.html) |
| […](http://rdrr.io/bioc/SNPRelate/man) |  |

\(~\)

# Resources

1. The CoreArray project: <http://corearray.sourceforge.net/>
2. [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) R package: <http://www.bioconductor.org/packages/gdsfmt>
3. [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) R package: <http://www.bioconductor.org/packages/SNPRelate>
4. Gene Environment Association Studies ([GENEVA](https://www.genome.gov/27541319/gene-environment-association-studes-geneva)) program
5. [GWASTools](http://www.bioconductor.org/packages/GWASTools): an R/Bioconductor package for quality control and analysis of Genome-Wide Association Studies

\(~\)

# Session Information

```
sessionInfo()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] MASS_7.3-65      SNPRelate_1.44.0 gdsfmt_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            fastmap_1.2.0
##  [4] xfun_0.53           cachem_1.1.0        knitr_1.50
##  [7] RhpcBLASctl_0.23-42 htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] crayon_1.5.3        rlang_1.1.6         jsonlite_2.0.0
```

\(~\)

# References

1. A High-performance Computing Toolset for Relatedness and Principal Component Analysis of SNP Data. Xiuwen Zheng; David Levine; Jess Shen; Stephanie M. Gogarten; Cathy Laurie; Bruce S. Weir. Bioinformatics 2012; doi: 10.1093/bioinformatics/bts606.
2. GWASTools: an R/Bioconductor package for quality control and analysis of Genome-Wide Association Studies. Stephanie M. Gogarten, Tushar Bhangale, Matthew P. Conomos, Cecelia A. Laurie, Caitlin P. McHugh, Ian Painter, Xiuwen Zheng, David R. Crosslin, David Levine, Thomas Lumley, Sarah C. Nelson, Kenneth Rice, Jess Shen, Rohit Swarnkar, Bruce S. Weir, and Cathy C. Laurie. Bioinformatics 2012.
3. Quality control and quality assurance in genotypic data for genome-wide association studies. Laurie CC, Doheny KF, Mirel DB, Pugh EW, Bierut LJ, Bhangale T, Boehm F, Caporaso NE, Cornelis MC, Edenberg HJ, Gabriel SB, Harris EL, Hu FB, Jacobs KB, Kraft P, Landi MT, Lumley T, Manolio TA, McHugh C, Painter I, Paschall J, Rice JP, Rice KM, Zheng X, Weir BS; GENEVA Investigators. Genet Epidemiol. 2010 Sep; 34(6): 591-602.
4. SeqArray – A storage-efficient high-performance data format for WGS variant calls. Zheng X, Gogarten S, Lawrence M, Stilp A, Conomos M, Weir BS, Laurie C, Levine D. Bioinformatics 2017. DOI: 10.1093/bioinformatics/btx145.

\(~\)

# Acknowledgements

The author would like to thank members of the ([GENEVA](https://www.genome.gov/27541319/gene-environment-association-studes-geneva)) consortium (2007-2012) for access to the data used for testing the [gdsfmt](http://www.bioconductor.org/packages/gdsfmt) and [SNPRelate](http://www.bioconductor.org/packages/SNPRelate) packages.