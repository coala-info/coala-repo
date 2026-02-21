# BaalChIP: Bayesian analysis of allele-specific transcription factor binding in cancer genomes

\
Ines de Santiago, Wei Liu, Ke Yuan, Florian Markowetz.\
University of Cambridge, Cancer Research UK Cambridge Institute

#### 2025-10-29

# Contents

* [1 Citation](#citation)
* [2 Introduction](#introduction)
* [3 Standard workflow](#standard-workflow)
  + [3.1 Quick start: example 1 (with pre-computed RAF scores)](#quick-start-example-1-with-pre-computed-raf-scores)
  + [3.2 Quick start: example 1 with more control over the input options](#quick-start-example-1-with-more-control-over-the-input-options)
  + [3.3 Quick start: example 2 (with gDNA BAM files)](#quick-start-example-2-with-gdna-bam-files)
  + [3.4 Input data](#input-data)
    - [3.4.1 The sample sheet](#the-sample-sheet)
    - [3.4.2 The hets files](#the-hets-files)
    - [3.4.3 The gDNA BAM files](#the-gdna-bam-files)
  + [3.5 Constructing a BaalChIP object](#constructing-a-baalchip-object)
  + [3.6 Obtaining allele-specific counts for BAM files](#obtaining-allele-specific-counts-for-bam-files)
  + [3.7 QCfilter: A filter to exclude SNPs in regions of known problematic read alignment](#qcfilter-a-filter-to-exclude-snps-in-regions-of-known-problematic-read-alignment)
  + [3.8 filterIntbias: A simulation-based filtering to exclude SNPs with intrinsic bias](#filterintbias-a-simulation-based-filtering-to-exclude-snps-with-intrinsic-bias)
    - [3.8.1 skipScriptRun](#skipscriptrun)
  + [3.9 Merge allele counts per group](#merge-allele-counts-per-group)
  + [3.10 Removing possible homozygous SNPs](#removing-possible-homozygous-snps)
  + [3.11 Identifying allele-specific binding events](#identifying-allele-specific-binding-events)
    - [3.11.1 The reference mapping (RM) bias](#the-reference-mapping-rm-bias)
    - [3.11.2 The relative allele frequency (RAF) bias](#the-relative-allele-frequency-raf-bias)
  + [3.12 Exporting the results](#exporting-the-results)
    - [3.12.1 BaalChIP.report](#baalchip.report)
* [4 Sumarizing and plotting data](#sumarizing-and-plotting-data)
  + [4.1 The ENCODE data set](#the-encode-data-set)
  + [4.2 The FAIREseq data set](#the-faireseq-data-set)
  + [4.3 summaryQC: summary of QC result.](#summaryqc-summary-of-qc-result.)
  + [4.4 plotQC: Plot filtering results](#plotqc-plot-filtering-results)
  + [4.5 Plot simulation results](#plot-simulation-results)
  + [4.6 Exporting the table of assayed SNPs and their allelic counts](#exporting-the-table-of-assayed-snps-and-their-allelic-counts)
  + [4.7 summaryASB function](#summaryasb-function)
  + [4.8 Allelic ratios density plot](#allelic-ratios-density-plot)
  + [4.9 Retrieving the RM and RAF scores estimated by BaalChIP](#retrieving-the-rm-and-raf-scores-estimated-by-baalchip)
  + [4.10 Exporting the final ASB results with BaalChIP.report](#exporting-the-final-asb-results-with-baalchip.report)
  + [4.11 Bugs/Feature requests](#bugsfeature-requests)
* [5 Session Information](#session-information)
* [References](#references)

# 1 Citation

If you use *[BaalChIP](https://bioconductor.org/packages/3.22/BaalChIP)* in published research, please cite [[1](#ref-desantiago2016)].

```
de Santiago I, Liu W, Yuan K, O'Reilly M, Chilamakuri CS, Ponder BJ, Meyer K, Markowetz F.
BaalChIP: Bayesian analysis of allele-specific transcription factor binding in cancer genomes.
Genome Biology 2017 18(1):39.
```

# 2 Introduction

BaalChIP is a rigorous statistical method to identify allele-specific binding of transcription factors, which is important, for example, to understand the functional consequences of the many disease-risk associated SNPs occurring in non-coding DNA.
*[BaalChIP](https://bioconductor.org/packages/3.22/BaalChIP)* (Bayesian Analysis of Allelic imbalances from ChIP-seq data) comprehensively combines a strict filtering and quality-control pipeline for quality control with a Bayesian statistical model that corrects for biases introduced by overdispersion, biases towards the reference allele, and most importantly, differences in allele frequencies due to copy number changes (Figure 1).

![](data:image/png;base64...)
**Figure 1: Description of BaalChIP model frame work.** **(a)** The basic inputs for Baal are the ChIP-seq raw read counts in a standard BAM alignment format, a BED file with the genomic regions of interest (such as ChIP-seq peaks) and a set of heterozygous SNPs in a tab-delimited text file. Optionally, genomic DNA (gDNA) BAM files can be specified for RAF computation, alternatively, the user can specify the pre-computed RAF scores for each variant. **(b)** The first module of BaalChIP consists of (1) computing allelic read counts for each heterozygous SNP in peak regions and (2) a round of filters to exclude heterozygous SNPs that are susceptible to generating artifactual allele-specific binding effects. (3) the Reference Mapping (RM) bias and the Reference Allele Frequency (RAF) are computed internally and the output consists of a data matrix where RM and RAF scores are included alongside the information of allele counts for each heterozygous SNP. The column ‘Peak’ contains binary data used to state the called peaks.
**(c)** The second module of BaalChIP consists of calling ASB binding events. (4) BaalChIP uses a beta-binomial Bayesian model to consider RM and RAF bias when detecting the ASB events. **(d)** The output from BaalChIP is a posterior distribution for each SNP. A threshold to identify SNPs with allelic bias is specified by the user (default value is a 95% interval). (5) Finally, a credible interval (‘Lower’ and ‘Upper’) calculated based on the posterior distribution. This interval corresponds to the true allelic ratio in read counts (i.e. after correcting for RM and RAF biases). An ASB event is called if the lower and upper limits of the interval are outside the 0.4-0.6 interval.

# 3 Standard workflow

## 3.1 Quick start: example 1 (with pre-computed RAF scores)

The first example dataset consists of ChIP-seq data obtained from two cell lines: A cancer cell-line (MCF7) and a normal cell line (GM12891). In this example dataset, pre-computed reference allele frequency (RAF) scores are used to correct the allelic read counts for biases caused by copy number alterations.

The first step in a BaalChIP analysis pipeline is to construct a *BaalChIP* class object:

```
wd <- system.file("test",package="BaalChIP") #system directory

samplesheet <- file.path(wd, "exampleChIP1.tsv")
hets <- c("MCF7"="MCF7_hetSNP.txt", "GM12891"="GM12891_hetSNP.txt")
res <- BaalChIP(samplesheet=samplesheet, hets=hets)
```

Given a new BaalChIP object, to run a BaalChIP analysis and identify allele-specific binding events, type:

```
res <- BaalChIP(samplesheet=samplesheet, hets=hets)
res <- BaalChIP.run(res, cores=4, verbose=TRUE) #cores for parallel computing
```

> Note that the example data in this vignette does not reveal real biology and was build only for demonstration purposes.

## 3.2 Quick start: example 1 with more control over the input options

We have shown a typical analysis pipeline performed with the wrapper function `BaalChIP.run`.
If you wish to have more control over the input options, the same analysis above can be performed with various commands as follows:

```
#create BaalChIP object
samplesheet <- file.path(wd, "exampleChIP1.tsv")
hets <- c("MCF7"="MCF7_hetSNP.txt", "GM12891"="GM12891_hetSNP.txt")
res <- BaalChIP(samplesheet=samplesheet, hets=hets)

#Now, load some data
data(blacklist_hg19)
data(pickrell2011cov1_hg19)
data(UniqueMappability50bp_hg19)

#run one at the time (instead of BaalChIP.run)
res <- alleleCounts(res, min_base_quality=10, min_mapq=15, verbose=FALSE)
res <- QCfilter(res,
                RegionsToFilter=c("blacklist_hg19", "pickrell2011cov1_hg19"),
                RegionsToKeep="UniqueMappability50bp_hg19",
                verbose=FALSE)
res <- mergePerGroup(res)
res <- filter1allele(res)
res <- getASB(res,
              Iter=5000,
              conf_level=0.95,
              cores=4, RMcorrection = TRUE,
              RAFcorrection=TRUE)
```

The following sections describe all these steps in more detail.

## 3.3 Quick start: example 2 (with gDNA BAM files)

The second dataset contains ChIP-seq and genomic DNA (gDNA) data obtained from two ChIP-seq studies. In this example, the allelic-ratios obtained from the sequenced gDNA samples are used to correct the allelic read counts for biases caused by copy number alterations.

First, we create a named list of filenames for the ‘.bam’ gDNA files to be used. The names in the list (“TaT1” and “AMOVC”) should correspond to *group\_name* strings in the samplesheet.

```
gDNA <- list("TaT1"=
               c(file.path(wd, "bamFiles/TaT1_1_gDNA.test.bam"),
                 file.path(wd, "bamFiles/TaT1_2_gDNA.test.bam")),
              "AMOVC"=
               c(file.path(wd, "bamFiles/AMOVC_1_gDNA.test.bam"),
                 file.path(wd, "bamFiles/AMOVC_2_gDNA.test.bam")))
```

Now we can run BaalChIP pipeline as before. Note that we include the path to the gDNA files in the `CorrectWithgDNA` argument:

```
wd <- system.file("test",package="BaalChIP") #system directory

samplesheet <- file.path(wd, "exampleChIP2.tsv")
hets <- c("TaT1"="TaT1_hetSNP.txt", "AMOVC"="AMOVC_hetSNP.txt")
res2 <- BaalChIP(samplesheet=samplesheet, hets=hets, CorrectWithgDNA=gDNA)
res2 <- BaalChIP.run(res2, cores=4, verbose=TRUE) #cores for parallel computing
```

> Note that the example data in this vignette does not reveal real biology and was build only for demonstration purposes.

## 3.4 Input data

### 3.4.1 The sample sheet

In order to run BaalChIP, one needs to generate a *sample sheet* describing the samples and the groups within each study. This file should be saved as a tab-delimited file. The extension of this file is not important, for example it can be *.txt* as long as it is a tab-delimited file.
Two example *.tsv* sample sheets have been included in this vignette and can be assessed as follows:

```
samplesheet <- read.delim(file.path(wd,"exampleChIP1.tsv"))
samplesheet
```

```
##    group_name target replicate_number                       bam_name
## 1        MCF7   cFOS                1    bamFiles/MCF7_cFOS_Rep1.bam
## 2        MCF7   cFOS                2    bamFiles/MCF7_cFOS_Rep2.bam
## 3        MCF7   cMYC                1    bamFiles/MCF7_cMYC_Rep1.bam
## 4        MCF7   cMYC                2    bamFiles/MCF7_cMYC_Rep2.bam
## 5        MCF7   POL2                1    bamFiles/MCF7_POL2_Rep1.bam
## 6        MCF7   POL2                2    bamFiles/MCF7_POL2_Rep2.bam
## 7        MCF7  STAT3                1   bamFiles/MCF7_STAT3_Rep1.bam
## 8        MCF7  STAT3                2   bamFiles/MCF7_STAT3_Rep2.bam
## 9     GM12891   POL2                1 bamFiles/GM12891_POL2_Rep1.bam
## 10    GM12891   POL2                2 bamFiles/GM12891_POL2_Rep2.bam
## 11    GM12891   PAX5                1 bamFiles/GM12891_PAX5_Rep1.bam
## 12    GM12891   PAX5                2 bamFiles/GM12891_PAX5_Rep2.bam
## 13    GM12891    PU1                1  bamFiles/GM12891_PU1_Rep1.bam
## 14    GM12891    PU1                2  bamFiles/GM12891_PU1_Rep2.bam
## 15    GM12891   TAF1                1 bamFiles/GM12891_TAF1_Rep1.bam
## 16    GM12891   TAF1                2 bamFiles/GM12891_TAF1_Rep2.bam
##                     bed_name
## 1     bedFiles/MCF7_cFOS.bed
## 2     bedFiles/MCF7_cFOS.bed
## 3     bedFiles/MCF7_cMYC.bed
## 4    bedFiles//MCF7_cMYC.bed
## 5     bedFiles/MCF7_POL2.bed
## 6     bedFiles/MCF7_POL2.bed
## 7    bedFiles/MCF7_STAT3.bed
## 8    bedFiles/MCF7_STAT3.bed
## 9  bedFiles/GM12891_POL2.bed
## 10 bedFiles/GM12891_POL2.bed
## 11 bedFiles/GM12891_PAX5.bed
## 12 bedFiles/GM12891_PAX5.bed
## 13  bedFiles/GM12891_PU1.bed
## 14  bedFiles/GM12891_PU1.bed
## 15 bedFiles/GM12891_TAF1.bed
## 16 bedFiles/GM12891_TAF1.bed
```

This sample sheet details the metadata for ChIP-seq studies in MCF7 and GM12891 cell lines. For each study, ChIP-seq data exists for four transcription factors and 2 replicates each (hence, 16 BAM files).

1. The first column `group_name` identifies the group label of each study (MCF7, GM12891).
2. The second column `target` corresponds to the name of the transcription factor.
3. The column `replicate_number` shows that there are two biological replicates for each ChIP-seq factor.
4. `bam_name` corresponds to the file paths to the BAM files with the aligned reads.
5. `bed_name` corresponds to the file paths to the BED files with the genomic regions of signal enrichment that the user is interested in (typically these are the ChIP-seq peaks files). For each TF ChIP-seq sample, BaalChIP will only test SNPs overlapping these defined genomic intervals of interest.

Here is another example sample sheet:

```
samplesheet <- read.delim(file.path(wd,"exampleChIP2.tsv"))
samplesheet
```

```
##   group_name  target replicate_number                  bam_name
## 1       TaT1 regions                1  bamFiles/TaT1_1.test.bam
## 2       TaT1 regions                2  bamFiles/TaT1_2.test.bam
## 3      AMOVC regions                1 bamFiles/AMOVC_1.test.bam
## 4      AMOVC regions                2 bamFiles/AMOVC_2.test.bam
##                           bed_name
## 1  bedFiles/TaT1_peaks_example.bed
## 2  bedFiles/TaT1_peaks_example.bed
## 3 bedFiles/AMOVC_peaks_example.bed
## 4 bedFiles/AMOVC_peaks_example.bed
```

This sample sheet details the metadata for ChIP-seq studies in TaT1 and AMOVC experimental groups. For each study, ChIP-seq data exists for one transcription factors and 2 replicates each (hence, 4 BAM files).

### 3.4.2 The hets files

BaalChIP requires a *variant file* containing the list of heterozygous variants to be analysed. As an example, *hets* files have been included in this vignette and can be assessed as follows:

```
head(read.delim(file.path(system.file("test",package="BaalChIP"),"MCF7_hetSNP.txt")))
```

```
##           ID CHROM       POS REF ALT       RAF
## 1 rs10169169  chr2 191412889   T   G 0.4870296
## 2  rs1021813  chr3  59413060   T   C 0.4689580
## 3  rs1025641 chr10 128307192   T   C 0.4077530
## 4 rs10444404 chr12  15114751   T   G 0.5195654
## 5  rs1048347 chr10 124096061   A   C 0.4852518
## 6 rs10495062  chr1 217804955   T   C 0.3654244
```

The information in the variant file includes:

1. `ID` column with a unique identifier string per variant.
2. (1-based) genomic coordinates `CHROM, POS`.
3. A,C,G,T bases for the reference `REF` and the non-reference alternate `ALT` allele.
4. The final column `RAF` is optional. RAF scores consist of values ranging from 0 to 1 for each variant denoting the reference allele frequency. A value between 0.5 and 1 denotes a bias to the reference allele, and a value between 0 and 0.5 a bias to the alternate allele. This column is optional, and will not be necessary if ask BaalChIP to calculate the RAF values from the input gDNA libraries (by using `CorrectWithgDNA` argument of the BaalChIP-class constructor function `BaalChIP` - see below).

### 3.4.3 The gDNA BAM files

The gDNA BAM files are input genomic DNA sequencing files for the corresponding groups in the ChIP-seq test data. These BAM files are passed to BaalChIP through the `CorrectWithgDNA` argument of the BaalChIP-class constructor function `BaalChIP`.

Allelic read counts from all gDNA files will be pooled together to generate the background allelic ratios directly from input data.

## 3.5 Constructing a BaalChIP object

The first step is to generate a BaalChIP object. The function `BaalChIP` accepts the following arguments:

1. `samplesheet`: A character string indicating the file name for a tab-delimited file.
2. `hets`: A named vector with filenames for the variant files to be used. The names in the vector should correspond to the `group_name` strings in the samplesheet.
3. `CorrectWithgDNA`: An optional named list with filenames for the BAM gDNA files to be used. The names in the vector should correspond to `group_name` strings in the samplesheet. If the `CorrectWithgDNA` argument is missing or set to NULL, BaalChIP will try to read the reference allelic ratios from the information in the RAF column of the *hets* files indicated by the `hets` argument. If both (RAF column and `CorrectWithgDNA`) are missing, BaalChIP will not correct for copy-number bias.

```
samplesheet <- file.path(wd,"exampleChIP1.tsv")
hets <- c("MCF7"="MCF7_hetSNP.txt", "GM12891"="GM12891_hetSNP.txt")
res <- BaalChIP(samplesheet=samplesheet, hets=hets)
res
```

```
##  Type : BaalChIP
```

```
##  Samples                 :   16
##  Experiments             :   MCF7 GM12891
##  Filtering and QC        :   None
##  Run allele-specific     :   None
```

The *samplesheet* and *hets* information are saved in the `samples` slot of a BaalChIP object:

```
BaalChIP.get(res, what="samples")
```

```
## $samples
##    group_name target replicate_number
## 1        MCF7   cFOS                1
## 2        MCF7   cFOS                2
## 3        MCF7   cMYC                1
## 4        MCF7   cMYC                2
## 5        MCF7   POL2                1
## 6        MCF7   POL2                2
## 7        MCF7  STAT3                1
## 8        MCF7  STAT3                2
## 9     GM12891   POL2                1
## 10    GM12891   POL2                2
## 11    GM12891   PAX5                1
## 12    GM12891   PAX5                2
## 13    GM12891    PU1                1
## 14    GM12891    PU1                2
## 15    GM12891   TAF1                1
## 16    GM12891   TAF1                2
##                                                                            bam_name
## 1     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_cFOS_Rep1.bam
## 2     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_cFOS_Rep2.bam
## 3     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_cMYC_Rep1.bam
## 4     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_cMYC_Rep2.bam
## 5     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_POL2_Rep1.bam
## 6     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_POL2_Rep2.bam
## 7    /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_STAT3_Rep1.bam
## 8    /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/MCF7_STAT3_Rep2.bam
## 9  /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_POL2_Rep1.bam
## 10 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_POL2_Rep2.bam
## 11 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_PAX5_Rep1.bam
## 12 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_PAX5_Rep2.bam
## 13  /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_PU1_Rep1.bam
## 14  /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_PU1_Rep2.bam
## 15 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_TAF1_Rep1.bam
## 16 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bamFiles/GM12891_TAF1_Rep2.bam
##                                                                       bed_name
## 1     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_cFOS.bed
## 2     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_cFOS.bed
## 3     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_cMYC.bed
## 4    /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles//MCF7_cMYC.bed
## 5     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_POL2.bed
## 6     /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_POL2.bed
## 7    /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_STAT3.bed
## 8    /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/MCF7_STAT3.bed
## 9  /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_POL2.bed
## 10 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_POL2.bed
## 11 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_PAX5.bed
## 12 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_PAX5.bed
## 13  /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_PU1.bed
## 14  /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_PU1.bed
## 15 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_TAF1.bed
## 16 /tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/bedFiles/GM12891_TAF1.bed
##          sampleID
## 1     MCF7_cFOS_1
## 2     MCF7_cFOS_2
## 3     MCF7_cMYC_1
## 4     MCF7_cMYC_2
## 5     MCF7_POL2_1
## 6     MCF7_POL2_2
## 7    MCF7_STAT3_1
## 8    MCF7_STAT3_2
## 9  GM12891_POL2_1
## 10 GM12891_POL2_2
## 11 GM12891_PAX5_1
## 12 GM12891_PAX5_2
## 13  GM12891_PU1_1
## 14  GM12891_PU1_2
## 15 GM12891_TAF1_1
## 16 GM12891_TAF1_2
##
## $hets
##                                                                   MCF7
##    "/tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/MCF7_hetSNP.txt"
##                                                                GM12891
## "/tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/GM12891_hetSNP.txt"
```

## 3.6 Obtaining allele-specific counts for BAM files

The next step is to compute for each SNP the number of reads carrying the reference (REF) and alternative (ALT) alleles. The `alleleCounts` function will read and scan all BAM files within the `samples` slot of a BaalChIP object and compute the read coverage at each allele. Allele counts are computed using the `pileup` function of the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* package [[2](#ref-morganrsamtools)].

Note that for each BAM file, it will only consider heterozygous SNPs overlapping the genomic regions in the corresponding BED files.

Two arguments can be manipulated by the user:

1. `min_mapq` refers to the minimum “MAPQ” value for an alignment to be included in pileup (default is 15).
2. `min_base_quality` refers to the minimum “QUAL” value for each nucleotide in an alignment (default is 10).

```
#run alleleCounts
res <- alleleCounts(res, min_base_quality=10, min_mapq=15, verbose=FALSE)
```

## 3.7 QCfilter: A filter to exclude SNPs in regions of known problematic read alignment

After computing the read counts per allele, the next step in the BaalChIP pipeline is an extensive quality control to consider technical biases that may contribute to the false identification of regulatory SNPs.

The function `QCfilter` is used to excluded sites susceptible to allelic mapping bias in regions of known problematic read alignment [[3](#ref-fujita2010ucsc)] [[4](#ref-pickrell2011false)] [[5](#ref-castel2015tools)] [[6](#ref-carroll2014impact)].

This function accepts two arguments:

1. `RegionsToFilter` a named list of GRanges objects with the genomic regions to be excluded
2. `RegionsToKeep` a named list GRanges object with the genomic regions to be kept. This works in an opposite way to ‘RegionstoFilter’, variants NOT overlapping these regions will be removed

Sets of filtering regions used in this step are fully customized and additional sets can be added by the user as *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* objects [[7](#ref-lawrence2013software)].

Three sets of regions are included with BaalChIP package for the hg19 reference of the human genome:

```
data(blacklist_hg19)
data(pickrell2011cov1_hg19)
data(UniqueMappability50bp_hg19)
```

1. `blacklist_hg19` contains blacklisted genomic regions downloaded from the mappability track of the UCSC Genome Browser [[3](#ref-fujita2010ucsc)] (hg19, wgEncodeDacMapabilityConsensusExcludable and wgEncodeDukeMapabilityRegionsExcludable tables). These correspond to artifact regions that tend to show artificially high signal (excessive unstructured anomalous reads mapping). These regions should be used as `RegionsToFilter` so that variants overlapping these regions will be removed. Note that these blacklists are applicable to functional genomic data (e.g. ChIP-seq, MNase-seq, DNase-seq, FAIRE-seq) of short reads (20-100bp reads). These are not applicable to RNA-seq or other transcriptome data types.
2. `pickrell2011cov1_hg19` contains collapsed repeat regions at the 0.1% threshold [[4](#ref-pickrell2011false)]. These regions should also be used as `RegionsToFilter`.
3. `UniqueMappability50bp_hg19` contains unique regions with genomic mappability score of 1, selected from DUKE uniqueness mappability track of the UCSC genome browser generated using a window size of 50bp (hg19, wgEncodeCrgMapabilityAlign50mer table). These regions should be used as `RegionsToKeep` so that variants NOT overlapping these regions will be removed. No applicable to longer reads (> 50bp)

```
#run QC filter
res <- QCfilter(res,
                RegionsToFilter=list("blacklist"=blacklist_hg19, "highcoverage"=pickrell2011cov1_hg19),
                RegionsToKeep=list("UniqueMappability"=UniqueMappability50bp_hg19),
                verbose=FALSE)
res <- mergePerGroup(res)
res <- filter1allele(res)
```

## 3.8 filterIntbias: A simulation-based filtering to exclude SNPs with intrinsic bias

The function `filterIntbias` can be used to apply a simulation-based filtering to exclude SNPs with intrinsic bias to one of the alleles [[8](#ref-degner2009effect)] [[9](#ref-pickrell2010understanding)].
This bias occurs due to intrinsic characteristics of the genome that translate into different probabilities of read mapping.
Even when reads differ only in one location, reads carrying one of the alleles may have a higher chance of matching multiple locations (i.e. have many repeats in the genome) and may therefore be mapped to an incorrect locus.
This, in turn, results in the underestimation of read counts and may cause both false-positive and false-negative inferences of ASB.

This filter performs the following steps:

1. Performs simulations of reads of the same length as the original ChIP-seq reads. For each heterozygous site, BaalChIP simulates every possible read overlapping the site in four possible combinations - reads carrying the reference allele (plus and minus strand), and reads carrying the alternative allele (plus and minus strand). The simulated reads are constructed based on published methodology [[8](#ref-degner2009effect)] (scripts shared by the author upon request) without taking into consideration different qualities at each base in the read or different read depth of coverage. As described by [[8](#ref-degner2009effect)] these parameters were sufficient to predict the SNPs that show an inherent bias.
2. Simulated reads are aligned to the reference genome and generates BAM files. The pipeline used to generate and align simulated reads is given by an external script file and it is available under the file name `run_simulations.sh` found in the folder `extra` of the BaalChIP R package. The alignment pipeline can be fully customized by the user (e.g. with other aligners, etc)
3. Allelic read counts are computed using the `pileup` function of the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* package [[2](#ref-morganrsamtools)].
4. SNPs with incorrect number of read alignments are eliminated (i.e SNPs with allelic counts different than twice the read length for each allele).

The default `run_simulations.sh` script can be found here:

/tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/extra/simulation\_run.sh

> Note: Since we are using an artificial example dataset, this filter will not give meaningful results.

This is how the command to run this filtering step would look like:

```
res <- filterIntbias(res,
                     simul_output="directory_name",
                     tmpfile_prefix="prefix_name",
                     simulation_script = "local",
                     alignmentSimulArgs=c("picard-tools-1.119",
                                          "bowtie-1.1.1",
                                          "genomes_test/male.hg19",
                                          "genomes_test/maleByChrom")
                     verbose=FALSE)
```

The function accepts three arguments:

1. `simul_output` allows the user to specify the name of the directory of where to save the generated simulated FASTQ and BAM files. if NULL or missing, a random directory under the current working directory will be generated
2. `tmpfile_prefix` argument is a character vector giving the initial part of the name of the FASTQ and BAM files generated by the function. If NULL or missing, a random prefix name will be generated.
3. `simulation_script` the file path for simulation script containing the instructions of simulation and alignment commands. If set to ‘local’, the default simulation script distributed with BaalChIP (‘extra/simulation\_run.sh’) will be used. Otherwise the user can specify the path to their own simulation scripts.
4. `alignmentSimulArgs` this is a vector of character with arguments passed to the sumulation\_run.sh script. There are four arguments: the complete path to the picard software, the complete path to the bowtie aligner, the basename of the indexed genome files, and finally A path to the folder containing gzipped files of the genome, separated by chromosome and named as: chr1.fa.gz, chr2.fa.gz, chr3.fa.gz, etc.

### 3.8.1 skipScriptRun

For demonstration purposes, we have saved the output of the previous command in a external folder:

/tmp/RtmpZPzDjL/Rinst341f9a61bee8fc/BaalChIP/test/simuloutput

We can have a look at the saved files:

```
preComputed_output <- system.file("test/simuloutput",package="BaalChIP")
list.files(preComputed_output)
```

```
##  [1] "c67c6ec6c433_aln32.bam"         "c67c6ec6c433_aln32.bam.bai"
##  [3] "c67c6ec6c433_aln32.fasta"       "c67c6ec6c433_aln32.fasta.sam"
##  [5] "c67c6ec6c433_aln32_snplist.txt" "c67c6ec6c433_aln34.bam"
##  [7] "c67c6ec6c433_aln34.bam.bai"     "c67c6ec6c433_aln34.fasta"
##  [9] "c67c6ec6c433_aln34.fasta.sam"   "c67c6ec6c433_aln36.bam"
## [11] "c67c6ec6c433_aln36.bam.bai"     "c67c6ec6c433_aln36.fasta"
## [13] "c67c6ec6c433_aln36.fasta.sam"   "c67c6ec6c433_snplist.txt"
```

By specifying `skipScriptRun=TRUE`, BaalChIP will take the simulated reads allelic ratios directly from the pre-computed simulated datasets and use them for further filtering. This way, the simulation (step 1) and alignment (step 2) steps will be skipped.

For this particular example we can run:

```
res <- filterIntbias(res, simul_output=preComputed_output,
                     tmpfile_prefix="c67c6ec6c433",
                     skipScriptRun=TRUE,
                     verbose=FALSE)
```

## 3.9 Merge allele counts per group

The function `mergePerGroup` is used select those SNPs that pass all filters in all replicated samples, provided that replicated samples exist. This QC step will mainly remove SNPs in regions where the ChIP-seq signal is not consistently detected across all replicates (for instance when coverage is zero in one of the replicates).

```
res <- mergePerGroup(res)
```

## 3.10 Removing possible homozygous SNPs

The final filtering step consists of removing possible homozygous SNPs by removing any site where only one allele is observed [[10](#ref-lappalainen2013transcriptome)] [[11](#ref-kilpinen2013coordinated)]. The function `filter1allele` will perform this step by pooling ChIP-seq reads from all examined samples and then eliminating those SNPs that contain no data (zero counts) for one of the alleles.

```
res <- filter1allele(res)
```

## 3.11 Identifying allele-specific binding events

BaalChIP uses a Bayesian framework to infer allelic imbalance from read counts data while integrating copy number and technical bias information. BaalChIP applies a beta-binomial distribution to model read count data therefore accounting for extra variability (over-dispersion) in allelic counts, a phenomenon that is often observed in sequencing data [[9](#ref-pickrell2010understanding)] [[12](#ref-skelly2011powerful)].

To run the ASB detection step type:

```
res <- getASB(res, Iter=5000, conf_level=0.95, cores = 4,
              RMcorrection = TRUE,
              RAFcorrection=TRUE)
```

At this step, BaalChIP considers two additional biases that may lead to inaccurate estimates of ASB: the reference mapping (RM) and the reference allele frequency (RAF) biases.

### 3.11.1 The reference mapping (RM) bias

The RM bias occurs because the reference genome only represents a single “reference” allele at each SNP position.
Reads that carry the “non-reference allele” have an extra mismatch to the reference sequence. Previous work has shown that this creates a marked bias in favor of the alignment of reads that contain the reference genome and could therefore affect the accuracy of allele-specific binding estimates [[8](#ref-degner2009effect)].
The reference mapping bias is calculated as described in [[10](#ref-lappalainen2013transcriptome)] and [[11](#ref-kilpinen2013coordinated)].

This bias correction can be turned on/off by using the argument `RMcorrection=TRUE` or `RMcorrection=FALSE` of the `getASB` function

### 3.11.2 The relative allele frequency (RAF) bias

The RAF bias occurs due to alterations in the background abundance of each allele (e.g. in regions of copy-number alterations) and the correction for this bias is one of the key features of BaalChIP.

RAF values at each heterozygous variant are used in the model likelihood to correct of the observed ChIP-seq read counts relative to the amount of the reference allele.
These are given as relative measures from 0 to 1, where values between 0.5 and 1 denote an underlying bias to the reference allele, and a value between 0 and 0.5 to the alternative allele.

This bias correction can be turned on/off by using the argument `RAFcorrection=TRUE` or `RAFcorrection=FALSE` of the `getASB` function

## 3.12 Exporting the results

### 3.12.1 BaalChIP.report

The output of BaalChIP is a posterior distribution of the estimated allelic balance ratio in read counts observed after considering all sources of underlying biases

```
res
```

```
##  Type : BaalChIP
##  Samples                 :   16
##  Experiments             :   MCF7 GM12891
##  Filtering and QC        :   6 filter(s) applied
##  Run allele-specific     :   Yes: run BaalChIP.report(object)
```

The function `BaalChIP.report` outputs a list with a table per group with the final results:

```
result <- BaalChIP.report(res)
head(result[["MCF7"]])
```

```
##           ID CHROM       POS REF ALT REF.counts ALT.counts Total.counts
## 1 rs10169169  chr2 191412889   T   G          4         19           23
## 2  rs1021813  chr3  59413060   T   C          3         18           21
## 3 rs10444404 chr12  15114751   T   G          1         14           15
## 4 rs10495062  chr1 217804955   T   C          2         13           15
## 5 rs10502400 chr18  10353940   A   G          4         17           21
## 6 rs10512030  chr9  76484346   T   C          1         15           16
##           AR    RMbias       RAF Bayes_lower Bayes_upper Corrected.AR isASB
## 1 0.17391304 0.4946235 0.4870296  0.09275682   0.3900729    0.2414148  TRUE
## 2 0.14285714 0.4946235 0.4689580  0.07535283   0.3808823    0.2281176  TRUE
## 3 0.06666667 0.4946235 0.5195654  0.02347753   0.2964224    0.1599500  TRUE
## 4 0.13333333 0.4946235 0.3654244  0.08792807   0.5073374    0.2976327 FALSE
## 5 0.19047619 0.4946235 0.4670719  0.10302328   0.4302656    0.2666444 FALSE
## 6 0.06250000 0.4946235 0.4328198  0.02752114   0.3427208    0.1851210  TRUE
```

The reported data frame contains the following columns:

1. `ID`: unique identifier string per analysed variant.
2. `CHROM`: chromosome identifier from the reference genome per variant.
3. `POS`: the reference position (1-based).
4. `REF`: reference base. Each base must be one of A,C,G,T in uppercase.
5. `ALT`: alternate non-reference base. Each base must be one of A,C,G,T in uppercase.
6. `REF.counts`: pooled counts of all reads with the reference allele.
7. `ALT.counts`: pooled counts of all reads with the non-reference allele.
8. `Total.counts`: pooled counts of all reads (REF + ALT).
9. `AR`: allelic ratio calculated directly from sequencing reads (REF / TOTAL).
10. `RMbias`: numerical value indicating the value estimated and applied by BaalChIP for the reference mapping bias. A value between 0.5 and 1 denotes a bias to the reference allele, and a value between 0 and 0.5 a bias to the alternative allele.
11. `RAF`: numerical value indicating the value applied by BaalChIP for the relative allele frequency (RAF) bias correction. A value between 0.5 and 1 denotes a bias to the reference allele, and a value between 0 and 0.5 a bias to the alternative allele.
12. `Bayes_lower`: lower interval for the estimated allelic ratio (allelic ratio is given by REF / TOTAL).
13. `Bayes_upper`: upper interval for the estimated allelic ratio (allelic ratio is given by REF / TOTAL).
14. `Corrected.AR`: average estimated allelic ratio (average between Bayes\_lower and Bayes\_upper). A value between 0.5 and 1 denotes a bias to the reference allele, and a value between 0 and 0.5 a bias to the alternative allele.
15. `isASB`: logical value indicating BaalChIP’s classification of variants into allele-specific.

# 4 Sumarizing and plotting data

## 4.1 The ENCODE data set

We applied BaalChIP to 548 samples from the ENCODE project [[13](#ref-encode2012integrated)]. In total 271 ChIP-seq experiments were analyzed, assaying a total of 8 cancer and 6 non-cancer cell lines representing different tissues. The data contained either 2 or 3 replicates per experiment and 4 to 42 DNA-binding proteins per cell line.

To load the ENCODEexample object type:

```
data(ENCODEexample)
ENCODEexample
```

```
##  Type : BaalChIP
##  Samples                 :   548
##  Experiments             :   A549 HL60 MCF7 SKNSH T47D IMR90 GM12891 GM12892 MCF10 GM12878 H1hESC HeLa HepG2 K562
##  Filtering and QC        :   6 filter(s) applied
##  Run allele-specific     :   Yes: run BaalChIP.report(object)
```

## 4.2 The FAIREseq data set

To demonstrate the generality of our approach, we applied BaalChIP to targeted FAIRE-sequencing data obtained from two breast-cancer cell lines, MDA-MB-134 and T-47D.
In this dataset, the sequenced gDNA samples were used for the RAF correction step, i.e. allelic ratios at each SNP position were calculated directly from gDNA samples and used for bias correction.

## 4.3 summaryQC: summary of QC result.

To ensure a reliable set of heterozygous SNPs we applied the BaalChIP QC step with the default parameters and options.
The summary of the QC result can be viewed with the `summaryQC` function:

```
a <- summaryQC(ENCODEexample)
```

This function outputs a list of two elements:

`filtering_stats` shows the number of variants that were filtered out in each filter category and the total number that ‘pass’ all filters

```
summaryQC(ENCODEexample)[["filtering_stats"]]
```

```
##         blacklist highcov mappability intbias replicates_merged Only1Allele
## A549            2       6          30     282              1076         341
## HL60            2       5          27     354               654         205
## MCF7            1       7          17     294               875         417
## SKNSH           0       8          37     457              1127         460
## T47D            1       2           7     127               290         132
## IMR90          10      26         110    1693              4361        1453
## GM12891         1      13          57     435               478         228
## GM12892         1      11          50     400               492         191
## MCF10           5      22          69    1126              4869        1451
## GM12878         8      32         118     923              1790         532
## H1hESC          9      22          93     694              1731         542
## HeLa           14      10          61    2124              3097         994
## HepG2          11      12          60     652              1391         496
## K562            6      12          37     528              1055         454
##          pass
## A549     3025
## HL60     4228
## MCF7     4446
## SKNSH    8203
## T47D     1636
## IMR90   12097
## GM12891  4058
## GM12892  3826
## MCF10    6974
## GM12878  9734
## H1hESC   8120
## HeLa     6310
## HepG2    6943
## K562     5806
```

`average_stats` shows the average number and average percentage of variants in each filter category, averaged across all analysed groups

```
summaryQC(ENCODEexample)[["average_stats"]]
```

```
##            variable  value.mean        perc
## 1         blacklist    5.071429  0.05056683
## 2           highcov   13.428571  0.14638725
## 3       mappability   55.214286  0.60780096
## 4           intbias  720.642857  7.40425914
## 5 replicates_merged 1663.285714 16.37614213
## 6       Only1Allele  564.000000  5.82107554
## 7              pass 6100.428571 69.59376814
```

The `average_stats` shows that on average 69.59% of SNPs pass all filters, meaning that BaalChIP removed an average of 30.41% of all SNPs (with slight variation between cell lines).

## 4.4 plotQC: Plot filtering results

We can visualize the summary of the QC step with three different plots.

`barplot_per_group` plots the number of variants that were filtered out per group.

```
plotQC(ENCODEexample, what="barplot_per_group")
```

![](data:image/png;base64...)

`boxplot_per_filter` plots the number of variants that were filtered out per filter category.

```
plotQC(ENCODEexample, what="boxplot_per_filter")
```

![](data:image/png;base64...)

`overall_pie` plots the average percentage of variants in each filter category (averaged across all groups analysed).

```
plotQC(ENCODEexample, what="overall_pie")
```

![](data:image/png;base64...)

## 4.5 Plot simulation results

The function `plotSimul` produces a plot of the proportion of SNPs that displayed the correct number of mapped simulated reads for the different read lengths considered in the ENCODE data set (28mer to 50mer). The percentage of correct calls increases with the sequencing length of the simulated reads.

```
plotSimul(ENCODEexample)
```

![](data:image/png;base64...)

## 4.6 Exporting the table of assayed SNPs and their allelic counts

The filtered SNPs and their allelic read counts are merged into a table with the total number of read counts in the reference (REF) and alternative (ALT) alleles.
No data is entered (missing data, NA) if a SNP did not pass the previously applied QC step for that sample

This is the table that is used in the final allele-specific binding test.

```
#ENCODE example
a <- BaalChIP.get(ENCODEexample, "assayedVar")[["MCF7"]]
a[1:5,1:5]
```

```
##           ID CEBPB.score CEBPB.REF.1 CEBPB.ALT.1 CEBPB.REF.2
## 1  rs1002823           1           1           3           3
## 2 rs10094283           1          10           2           3
## 3 rs10095930           1           2           4           0
## 4 rs10104421           1          13           4           4
## 5 rs10107713           1           1           0           1
```

```
#FAIRE exmaple
a <- BaalChIP.get(FAIREexample, "assayedVar")[["MDA134"]]
a[1:5,]
```

```
##           ID FAIREseq.score FAIREseq.REF.1 FAIREseq.ALT.1 FAIREseq.REF.2
## 1 rs10004808              1            130             92            142
## 2 rs10007915              1            126            116            117
## 3 rs10010281              1            168            137            131
## 4 rs10010325              1            124            124            150
## 5 rs10014102              1            205            208            216
##   FAIREseq.ALT.2 FAIREseq.REF.3 FAIREseq.ALT.3
## 1            131              9             17
## 2            105             87             77
## 3            124             98             60
## 4            101             52             37
## 5            227             17             22
```

## 4.7 summaryASB function

The summary of the ASB Bayesian test can be obtained with the `summaryASB` function

This function outputs matrix containing the total number of allele-specific variants (TOTAL) and the number of variants allele-specific for the reference (REF) and alternate alleles (ALT).

```
summaryASB(ENCODEexample)
```

```
##         Ref Alt Total
## A549     47  26    73
## HL60     46  44    90
## MCF7    202 182   384
## SKNSH   229 200   429
## T47D     28  25    53
## IMR90   110  91   201
## GM12891  52  45    97
## GM12892  25  15    40
## MCF10    67  76   143
## GM12878 176 180   356
## H1hESC  110  82   192
## HeLa    102  82   184
## HepG2   123  96   219
## K562     84  77   161
```

For the FAIRE-seq dataset, we identified a total of 21 and 9 ASB SNPs in MDA-MB-134 and T-47D cells, respectively:

```
summaryASB(FAIREexample)
```

```
##        Ref Alt Total
## MDA134  14   7    21
## T47D     3   6     9
```

## 4.8 Allelic ratios density plot

The function `adjustmentBaalPlot` produces a density plot of the distribution of allelic ratios (REF/TOTAL) before and after BaalChIP adjustment for RM and RAF biases.

We observed that after correction the allelic ratios become more evenly distributed around an average of 0.5.
This effect is particularly notable in data obtained from cancer cell lines:

```
adjustmentBaalPlot(ENCODEexample)
```

![](data:image/png;base64...)

```
adjustmentBaalPlot(FAIREexample)
```

![](data:image/png;base64...)

The colours of the plot can be controlled with the `col` argument

```
adjustmentBaalPlot(FAIREexample, col=c("cyan4","chocolate3"))
```

![](data:image/png;base64...)

## 4.9 Retrieving the RM and RAF scores estimated by BaalChIP

You can access the final `biasTable` with the estimated RM and RAF scores per variant and per group\_name. These are the final scores used in BaalChIP’s Bayesian model:

```
biastable <- BaalChIP.get(ENCODEexample, "biasTable")
head(biastable[["K562"]])
```

```
##           ID    RMbias       RAF
## 1  rs1000222 0.5071065 0.3939502
## 2 rs10002917 0.5060070 0.6170638
## 3 rs10013543 0.4991121 0.3891030
## 4  rs1001609 0.5071065 0.3762078
## 5 rs10026790 0.5071065 0.6381971
## 6 rs10028122 0.5071065 0.3908245
```

```
biastable <- BaalChIP.get(FAIREexample, "biasTable")
head(biastable[["T47D"]])
```

```
##           ID    RMbias       RAF
## 1 rs10055224 0.5077201 0.4915612
## 2 rs10056564 0.5036859 0.7273567
## 3 rs10061757 0.5052540 0.5744681
## 4 rs10061900 0.5077201 0.7382199
## 5 rs10067225 0.5052540 0.7715356
## 6 rs10067607 0.5077201 0.7379576
```

## 4.10 Exporting the final ASB results with BaalChIP.report

The function `BaalChIP.report` generates a data.frame per group with all variants and a label for all identified allele-specific binding (ASB) variants.

For instance, to see the final results for the T47D cell line in the FAIRE-seq dataset:

```
result <- BaalChIP.report(FAIREexample)[["T47D"]]

#show ASB SNPs
result[result$isASB==TRUE,]
```

```
##               ID CHROM       POS REF ALT REF.counts ALT.counts Total.counts
## 148  rs111929748    11  69379287   G   T        418        894         1312
## 367   rs12939887    17  53162672   A   G        283        142          425
## 637  rs200312388     7 144115704   T   G         57         47          104
## 639  rs200496470     8 128323987   A   G          1          8            9
## 642  rs201314815     7 144115683   C   T         60         47          107
## 648  rs201949580     7 144115698   T   G         59         47          106
## 718    rs2373062     2 218322137   G   C          7        184          191
## 1574   rs9292122     5  56087910   G   A          5          1            6
## 1590   rs9682063     3   4737842   A   G        479        351          830
##              AR    RMbias        RAF Bayes_lower Bayes_upper Corrected.AR isASB
## 148  0.31859756 0.5052540 0.50300300   0.2862789   0.3514170    0.3188479  TRUE
## 367  0.66588235 0.5058305 0.49084249   0.6184696   0.7169737    0.6677217  TRUE
## 637  0.54807692 0.5052540 0.75200000   0.2157593   0.3717822    0.2937708  TRUE
## 639  0.11111111 0.5058305 0.67857143   0.0169950   0.2927423    0.1548686  TRUE
## 642  0.56074766 0.5036859 0.76562500   0.2050884   0.3632804    0.2841844  TRUE
## 648  0.55660377 0.5052540 0.75200000   0.2173652   0.3757916    0.2965784  TRUE
## 718  0.03664921 0.5052540 0.01052632   0.6290066   0.8850246    0.7570156  TRUE
## 1574 0.83333333 0.5038678 0.28571429   0.6343983   0.9807300    0.8075642  TRUE
## 1590 0.57710843 0.5058305 0.73159509   0.2985035   0.3773395    0.3379215  TRUE
```

## 4.11 Bugs/Feature requests

If you have any, [let me know](https://github.com/InesdeSantiago/BaalChIP/issues).

# 5 Session Information

Here is the output of `sessionInfo()` on the system on which this document was compiled:

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
##  [1] BaalChIP_1.36.0      Rsamtools_2.26.0     Biostrings_2.78.0
##  [4] XVector_0.50.0       GenomicRanges_1.62.0 Seqinfo_1.0.0
##  [7] IRanges_2.44.0       S4Vectors_0.48.0     BiocGenerics_0.56.0
## [10] generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                S7_0.2.0
##  [5] bitops_1.0-9                fastmap_1.2.0
##  [7] GenomicAlignments_1.46.0    digest_0.6.37
##  [9] lifecycle_1.0.4             Deriv_4.2.0
## [11] magrittr_2.0.4              compiler_4.5.1
## [13] rlang_1.1.6                 sass_0.4.10
## [15] tools_4.5.1                 yaml_2.3.10
## [17] knitr_1.50                  S4Arrays_1.10.0
## [19] labeling_0.4.3              DelayedArray_0.36.0
## [21] plyr_1.8.9                  RColorBrewer_1.1-3
## [23] abind_1.4-8                 BiocParallel_1.44.0
## [25] withr_3.0.2                 purrr_1.1.0
## [27] grid_4.5.1                  ggplot2_4.0.0
## [29] scales_1.4.0                iterators_1.0.14
## [31] MASS_7.3-65                 dichromat_2.0-0.1
## [33] tinytex_0.57                SummarizedExperiment_1.40.0
## [35] cli_3.6.5                   rmarkdown_2.30
## [37] crayon_1.5.3                httr_1.4.7
## [39] modelr_0.1.11               reshape2_1.4.4
## [41] cachem_1.1.0                stringr_1.5.2
## [43] parallel_4.5.1              BiocManager_1.30.26
## [45] matrixStats_1.5.0           vctrs_0.6.5
## [47] boot_1.3-32                 Matrix_1.7-4
## [49] jsonlite_2.0.0              bookdown_0.45
## [51] magick_2.9.0                foreach_1.5.2
## [53] jquerylib_0.1.4             tidyr_1.3.1
## [55] glue_1.8.0                  codetools_0.2-20
## [57] cowplot_1.2.0               stringi_1.8.7
## [59] gtable_0.3.6                GenomeInfoDb_1.46.0
## [61] UCSC.utils_1.6.0            tibble_3.3.0
## [63] pillar_1.11.1               htmltools_0.5.8.1
## [65] doBy_4.7.0                  R6_2.6.1
## [67] microbenchmark_1.5.0        doParallel_1.0.17
## [69] evaluate_1.0.5              lattice_0.22-7
## [71] Biobase_2.70.0              backports_1.5.0
## [73] cigarillo_1.0.0             broom_1.0.10
## [75] bslib_0.9.0                 Rcpp_1.1.0
## [77] coda_0.19-4.1               SparseArray_1.10.0
## [79] xfun_0.53                   MatrixGenerics_1.22.0
## [81] pkgconfig_2.0.3
```

# References

1. deSantiago I, Liu W, Yuan K, O’Reilly M, Chilamakuri C, Ponder B, Meyer K, Markowetz F: **BaalChIP: Bayesian analysis of allele-specific transcription factor binding in cancer genomes**. *in press* 2016.

2. Morgan M, Pagès H, Obenchain V, Hayden N: **Rsamtools: Binary alignment (bam), fasta, variant call (bcf), and tabix file import. R package version 1.18. 2**..

3. Fujita PA, Rhead B, Zweig AS, Hinrichs AS, Karolchik D, Cline MS, Goldman M, Barber GP, Clawson H, Coelho A, others: **The ucsc genome browser database: Update 2011**. *Nucleic acids research* 2010:gkq963.

4. Pickrell JK, Gaffney DJ, Gilad Y, Pritchard JK: **False positive peaks in chip-seq and other sequencing-based functional assays caused by unannotated high copy number regions**. *Bioinformatics* 2011, **27**:2144–2146.

5. Castel SE, Levy-Moonshine A, Mohammadi P, Banks E, Lappalainen T: **Tools and best practices for data processing in allelic expression analysis**. *Genome biology* 2015, **16**:1.

6. Carroll TS, Liang Z, Salama R, Stark R, Santiago I de: **Impact of artifact removal on chip quality metrics in chip-seq and chip-exo data**. *Front Genet* 2014, **5**:75.

7. Lawrence M, Huber W, Pages H, Aboyoun P, Carlson M, Gentleman R, Morgan MT, Carey VJ: **Software for computing and annotating genomic ranges**. *PLoS Comput Biol* 2013, **9**:e1003118.

8. Degner JF, Marioni JC, Pai AA, Pickrell JK, Nkadori E, Gilad Y, Pritchard JK: **Effect of read-mapping biases on detecting allele-specific expression from rna-sequencing data**. *Bioinformatics* 2009, **25**:3207–3212.

9. Pickrell JK, Marioni JC, Pai AA, Degner JF, Engelhardt BE, Nkadori E, Veyrieras J-B, Stephens M, Gilad Y, Pritchard JK: **Understanding mechanisms underlying human gene expression variation with rna sequencing**. *Nature* 2010, **464**:768–772.

10. Lappalainen T, Sammeth M, Friedländer MR, ACÔt Hoen P, Monlong J, Rivas MA, Gonzàlez-Porta M, Kurbatova N, Griebel T, Ferreira PG, others: **Transcriptome and genome sequencing uncovers functional variation in humans**. *Nature* 2013, **501**:506–511.

11. Kilpinen H, Waszak SM, Gschwind AR, Raghav SK, Witwicki RM, Orioli A, Migliavacca E, Wiederkehr M, Gutierrez-Arcelus M, Panousis NI, others: **Coordinated effects of sequence variation on dna binding, chromatin structure, and transcription**. *Science* 2013, **342**:744–747.

12. Skelly DA, Johansson M, Madeoy J, Wakefield J, Akey JM: **A powerful and flexible statistical framework for testing hypotheses of allele-specific gene expression from rna-seq data**. *Genome research* 2011, **21**:1728–1737.

13. Consortium EP: **An integrated encyclopedia of dna elements in the human genome**. *Nature* 2012, **489**:57–74.