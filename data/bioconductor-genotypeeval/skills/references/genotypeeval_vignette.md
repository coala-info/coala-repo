# genotypeeval\_vignette

#### *Jennifer Tom*

#### *2017-01-27*

# Introduction

This package addresses the need to evaluate the quality of human sequence data using the genotypes and associated meta-data in a VCF. It is often useful to QC the VCF for sequence quality, instead of the more traditionally assessed BAM or FASTQ file(s), as the VCF is generally a reasonable sized file (~ 8 Gb for 30x human genome). The VCF file contains adequate information to determine if the sample data is of acceptable quality. This package makes it easy to QC VCF files in batch, quickly identify VCF files of questionable quality, and flag these files via user defined thresholds. This package is compatible with gVCF files but requires the use of R devel.

This package depends on external data sources and some guidance will be given in this vignette on how to prepare these datasets if the user wishes to provide reference data.

Let’s get started on the analysis. First load the package.

```
library(genotypeeval)
```

# Data

We have included a slice of chromosome 22 as an example VCF file. This example is a not meant to give biologically interpretable results but meant simply to demonstrate the tools in this package. ReadVCFData is a wrapper around ReadVCFAsVRanges – it will scan the header to check which INFO fields are available for QC, convert seqlevels to “NCBI”, remove indels, etc.

```
vcffn <- system.file("ext-data", "chr22.GRCh38.vcf.gz", package="genotypeeval")
mydir <- paste(dirname(vcffn), "/", sep="")
myfile <-basename(vcffn)
vcf <- ReadVCFData(mydir, myfile, "GRCh38")
```

```
## Reading VCF ...
```

Evaluation of the VCF quality relies on three datasets and “gold” standards such as [1000 Genomes](http://www.1000genomes.org/data) or [dbSNP](http://www.ncbi.nlm.nih.gov/SNP/). This data is optional though the most utility will come from this package if external data sources are used. In this vignette we will collect example reference data for GRCh38.

We will first get the data for our coding track which will be passed in as cds.ref. We can get this through the package TxDb.Hsapiens.UCSC.hg38.knownGene. This is used to calculate the transition-transversion ratio in and out of the coding regions which is useful because transition-transversion ratio in the exonic regions (~3 - 3.5) is known to be much higher than that in the non-coding region (~ 2.0 - 2.1) (DePristo et al. 2011–5AD). For consistency, only chromosomes 1-22, X, and Y are retained, the chromosomes are numeric (eg 1 instead of chr1), and the genome must be set at “GRCh38” to be consistent with the example VCF file.

If you do not have the following libraries (TxDb.Hsapiens.UCSC.hg38.knownGene and dbSNP141 installed yet run the following chunk of code:

```
source("https://bioconductor.org/biocLite.R")
biocLite("TxDb.Hsapiens.UCSC.hg38.knownGene")
biocLite("SNPlocs.Hsapiens.dbSNP141.GRCh38")
```

```
suppressWarnings(library("TxDb.Hsapiens.UCSC.hg38.knownGene"))
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
cds <- cds(txdb)
seqlevelsStyle(cds) = "NCBI"
genome(cds) <- "GRCh38"
```

Also included in this package is an option to include masked regions or regions that generally cause difficulty when calling variants. This includes, for example, [self-chain regions](https://genome.ucsc.edu/goldenPath/help/chain.html) from UCSC which essentially assigns a similarity score after mapping the genome to itself. Calls are much more difficult to make in these self-chain regions due to mapping errors, making it a useful criteria for evaluating a VCF file. Other tracks one may include here are paralogs or repeat masked regions. This track should be formatted as a GRanges.

We can compare our VCF against known data sources (gold standards) such as [1000 Genomes](http://www.1000genomes.org/data) or dbSNP. We load this in as a gold standard. Let’s use dbSNP build 141 (available as source package).

```
suppressWarnings(library("SNPlocs.Hsapiens.dbSNP141.GRCh38"))
snps <- SNPlocs.Hsapiens.dbSNP141.GRCh38
dbsnp.ch22 <- snplocs(snps, "ch22", as.GRanges=TRUE)
seqlevelsStyle(dbsnp.ch22) = "NCBI"
gold.param = GoldDataParam(percent.confirmed=0.8)
gold <- GoldDataFromGRanges("GRCh38", dbsnp.ch22, gold.param)
```

```
##  Gold Data Constructor ...
```

We now have the gold file comparator read in. This object contains the gold file as a GRanges and uses the allele frequencies (AF), if present, to generate another “rare” GRanges with allele frequency less than 1%. In addition, the gold file has params associated with it. For example, percent.confirmed is the percent of the VCF file SNP calls confirmed in the gold file. We have set here a threshold of 80.0% – in order for this sample to pass, at least 80.0% of the calls need to be present in the gold comparator file. All param variables are documented and can be accessed with help(GoldDataParam). There are many different params available that have default values meant to always pass a sample. Samples will only fail on params that the user has specified thresholds for.

Finally we need an admixture.ref object. A great resource for this is the 1000 genomes superpopulation allele frequencies available at [1000 Genomes](http://www.1000genomes.org/data). A subsample of around 200,000 SNPs from 1000 genomes is sufficient. When subsampling the file, allele frequencies should be selected to be informative (different between the populations). The most recent released files can be downloaded and subsampled here: ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/. As the name of this object implies, the allele depth of the superpopulations East Asian (EAS), African (AFR), and European (EUR) are used to estimate ancestry proportions. Many of the metrics calculated on the VCF files depend on ethnic background (Kidd et al. 2012) so it would be unwise to fail samples without accounting for the population of the sample. Ancestry estimation is done via the supervised ADMIXTURE algorithm (Alexander, Novembre, and Lange 2009). I will show at the end of this document how to download 1000 genomes data within R. This is optional and as the data set is large, will take some time to load.

For the purposes of this tutorial we will create simulated allele frequencies based on our example VCF file. These mock allele frequencies confer East Asian ancestry on this individual. We use the genotype calls and the coordinates from the example file to set the AF accordingly. We infer ancestry proportions EAS, AFR, and EUR on a scale from zero to one and the three ancestry proportions add up to one.

```
    admix.var <- getVR(vcf)[getVR(vcf)$GT %in% c("0|1", "1|0", "1|1"),][,1:2]
    admix.var$EAS_AF <- ifelse(admix.var$GT %in% c("1|1"), 1, .5)
    admix.var$AFR_AF<- 0
    admix.var$EUR_AF<- 0
    admix.hom <- getVR(vcf)[getVR(vcf)$GT %in% c("0|0"),][,1:2]
    admix.hom$EAS_AF<- 0
    admix.hom$AFR_AF<- 1
    admix.hom$EUR_AF<- 1
    admix.ref <- c(admix.var, admix.hom)
```

# Analysis

Now that we have our reference data, we can get started on the analysis.

We can set lower and upper thresholds for the params of interest in our VCF file. For example, say we are interested in setting a lower bound on the total number of counts in the file. We can set a lower limit at 3 billion for the human genome. Similarly we set lower and upper thresholds for transition-transversion ratio in coding and noncoding regions. Thresholds again will only be applied on the params that the user specified. We have set the limits here on a small subset of the params available. To see all the params available use help(VCFQAParam)

```
vcfparams <- VCFQAParam(count.limits=c(3e9, Inf), titv.noncoding=c(1.99, 4),
                        titv.coding=c(2.8, 4))
```

Next we evaluate the file by calling VCFEvaluate. This function calculate a list of metrics of interest based on the fields present in the header of the VCF file. If we didn’t have any reference data we could still look at some basic stats of the VCF file.

```
ev.noref <- VCFEvaluate(vcf, vcfparams)
```

```
##  Evaluating File ...
```

However since we prepared the reference data, we’ll have a look with the reference data.

```
ev <- VCFEvaluate(vcf, vcfparams, gold.ref=gold, cds.ref=cds, admixture.ref = admix.ref)
```

```
##  Evaluating File ...
```

# Results

First we check if our sample passed. We can get a list of the individual metrics the sample passed for as well as an overall TRUE (passed) or FALSE (failed). A sample must pass all criteria the user defined in order to pass.

```
didSamplePassOverall(ev)
```

```
## Sample Status
```

```
## [1] "Fail"
```

Looks like our sample failed. If we look in more detail we see that the numberCalls didn’t pass. We set the threshold at about 3 billion for the human genome but since we are just analyzing part of chromosome 22, there were not enough calls to pass. If we were analyzing a whole genome sample, a low number of total counts could imply VCF truncation.

```
head(didSamplePass(ev))
```

```
##   Sample Status                                     Description
## 1          Pass            Number of Homozygous Reference Calls
## 2          Fail Total Number of Calls (Hom Ref + Hom Alt + Het)
## 3          Pass                               Median Read Depth
## 4          Pass              Percent in Target Read Depth Range
## 5          Pass                      Percent Heterozygote Calls
## 6          Pass                                    numberOfHets
```

We can look in more detail at the numeric values of our metrics. In this sample we have a median read depth at our genotype calls of 30. We didn’t supply the target read depth in the VCFParams so percentInTarget was not calculated. We can see the total number of calls (1206) falls far short of the number of calls in the human genome. Many of the results are NA because the other chromosomes are not present in this file. Again, all of the metrics are documented and can be accessed with help(VCFQAParam).

```
head(getResults(ev))
```

```
##          Value                                     Description
## 1 1.000000e+00                                   admixture.EAS
## 2 1.130141e-08                                   admixture.AFR
## 3 1.118628e-08                                   admixture.EUR
## 4 3.480000e+02            Number of Homozygous Reference Calls
## 5 3.924800e+04 Total Number of Calls (Hom Ref + Hom Alt + Het)
## 6 3.000000e+01                               Median Read Depth
```

We see in the first three values are the results of our ancestry estimation which shows, as we set up for our example, the individual is likely of EAS descent.

Finally we can take a look at a few of the plots generated. Here we have calls broken down by variant type. We see that there are phased heterozygous calls and homozygous alternative calls.

```
getPlots(ev)$variant_type
```

![](data:image/png;base64...)

One very useful plot is the number of heterozygous and homozygous alternative calls by chromosome which detects one of the most frequent problems we encounter with VCFs that aren’t detected from the BAM – truncation of the VCF.

```
getPlots(ev)$chr
```

![](data:image/png;base64...)

If the user is interested in running this package in batch, it can easily be integrated with the R package BatchJobs. It requires about five times the size of the VCF file for memory. When running in batch, the user may want to take advantage of multi-core. This can be done with the function ReadVCFDataChunk. This option will read in the VCF file using the numcores that you specify. This option will speed the reading of the VCF file and also reduce the memory footprint. It requires the admixture file as it only retains the homozygous reference calls for processing that are present in the admixture file. Please refer to the documentation for this function prior to using it. Hope this helps your QC efforts.

# Bibliography

# Bibliography

Alexander, David H., John Novembre, and Kenneth Lange. 2009. “Fast Model-Based Estimation of Ancestry in Unrelated Individuals.” *Genome Research*. doi:[10.1101/gr.094052.109](https://doi.org/10.1101/gr.094052.109).

DePristo, Mark A, Eric Banks, Ryan Poplin, Kiran V Garimella, Jared R Maguire, Christopher Hartl, Anthony A Philippakis, et al. 2011–5AD. “A Framework for Variation Discovery and Genotyping Using Next-Generation DNA Sequencing Data.” *Nat Genet* 43 (5). Nature Publishing Group, a division of Macmillan Publishers Limited. All Rights Reserved.: 491–98. <http://dx.doi.org/10.1038/ng.806>.

Kidd, Jeffrey M., Simon Gravel, Jake Byrnes, Andres Moreno-Estrada, Shaila Musharoff, Katarzyna Bryc, Jeremiah D. Degenhardt, et al. 2012. “Population Genetic Inference from Personal Genome Data: Impact of Ancestry and Admixture on Human Genomic Variation.” *The American Journal of Human Genetics* 91 (4): 660–71. doi:[http://dx.doi.org/10.1016/j.ajhg.2012.08.025](https://doi.org/http%3A//dx.doi.org/10.1016/j.ajhg.2012.08.025).