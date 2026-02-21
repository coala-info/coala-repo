# Introduction to TVTB

Kévin Rue-Albrecht1,2\*

1Department of Medicine, Imperial College London, UK
2Nuffield Department of Medicine, University of Oxford, UK

\*kevinrue67@gmail.com

#### 30 October 2025

#### Abstract

The VCF Tool Box (*[TVTB](https://bioconductor.org/packages/3.22/TVTB)*) provides S4 classes and methods to filter, summarise and visualise genetic variation data stored in VCF files pre-processed by the Ensembl Variant Effect Predictor (VEP). In particular, the package extends the *FilterRules* class (*[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* package) to define news classes of filter rules applicable to the various slots of `VCF` objects. A Shiny web-application, the Shiny Variant Explorer (*tSVE*), provides a convenient interface to demonstrate those functionalities integrated in a programming-free environment.

#### Package

TVTB 1.36.0

# 1 Introduction

The VCF Tool Box (*[TVTB](https://bioconductor.org/packages/3.22/TVTB)*) offers S4 classes and methods
to filter, summarise and visualise genetic variation data
stored in VCF files pre-processed by the
[Ensembl Variant Effect Predictor](http://www.ensembl.org/info/docs/tools/vep)
(VEP) (McLaren et al. [2010](#ref-RN1)).
An [RStudio/Shiny](http://shiny.rstudio.com) web-application,
the Shiny Variant Explorer (*tSVE*),
provides a convenient interface to demonstrate those
functionalities integrated in a programming-free environment.

Currently, major functionalities in the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package include:

**A class to store recurrent parameters of genetic analyses**

* List of reference homozygote, heterozygote, and alternate homozygote
  genotype encodings
* Key of the INFO field where Ensembl VEP predictions are stored
  in the VCF file
* Suffix of the INFO fields where calculated data will be stored
* List of genomic ranges to analyse and visualise
* Parameters for parallel calculations (using *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*)

**Genotype counts and allele frequencies**

* Calculated from the data of an `ExpandedVCF` objects
  (*i.e.* bi-allelic records)
* Stored in INFO fields defined by the above suffixes
  + overall counts and frequencies (*i.e.* across all samples)
  + counts and frequencies within level(s) of phenotype(s)

**Classes of VCF filter rules**

* Filter rules applicable to the `fixed` slot of an `VCF` object
* Filter rules applicable to the `info` slot of an `VCF` object
* Filter rules applicable to Ensembl VEP predictions stored in a
  given INFO field
* A container for combinations of filter rules listed above
* Subset `VCF` objects using the above filter rules

# 2 Installation

Instructions to install the VCF Tool Box are available [here](http://bioconductor.org/packages/TVTB/).

Once installed, the package can be loaded and attached as follows:

```
library(TVTB)
```

# 3 Recurrent settings: TVTBparam

Most functionalities in *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* require recurrent information
such as:

* Genotype encoding (homozygote reference, heterozygote, homozygote alternate),
* INFO key that contains the Ensembl VEP predictions in the VCF file,
* List of genomic ranges within which data must be summarised or visualised
  + affecting the genomic ranges to import from the VCF file
* Suffixes of INFO keys where counts and frequencies of genotypes must be
  stored:
  + Counts and frequencies may be calculated for individual levels of
    selected phenotypes, in which case the data will be stored
    under INFO keys formed as `<phenotype>_<level>_<suffix>`,
  + Counts and frequencies across all samples are stored in INFO keys
    simply named `<suffix>`.
* Settings for parallel calculations.

To reduce the burden of repetition during programming, and to
facilitate analyses using consistent sets of parameters,
*[TVTB](https://bioconductor.org/packages/3.22/TVTB)* implements the `TVTBparam` class.
The `TVTBparam` class offer a container for parameters recurrently used
across the package.
A `TVTBparam` object may be initialised as follows:

```
tparam <- TVTBparam(Genotypes(
    ref = "0|0",
    het = c("0|1", "1|0", "0|2", "2|0", "1|2", "2|1"),
    alt = c("1|1", "2|2")),
    ranges = GenomicRanges::GRangesList(
        SLC24A5 = GenomicRanges::GRanges(
            seqnames = "15",
            IRanges::IRanges(
                start = 48413170, end = 48434757)
            )
        )
    )
```

`TVTBparam` objects have a convenient summary view and accessor methods:

```
tparam
```

```
## class: TVTBparam
## @genos: class: Genotypes
##     @ref (hom. ref.): "REF" {0|0}
##     @het (heter.): "HET" {0|1, 1|0, 0|2, 2|0, 1|2, 2|1}
##     @alt (hom. alt.): "ALT" {1|1, 2|2}
##   @ranges: 1 GRanges on 1 sequence(s)
##   @aaf (alt. allele freq.): "AAF"
##   @maf (minor allele freq.): "MAF"
##   @vep (Ensembl VEP key): "CSQ"
##   @svp: <ScanVcfParam object>
##   @bp: <SerialParam object>
```

In this example:

* **Genotypes**
  + Accessor: `genos(x)`
  + Class: `Genotypes`
  + Homozygote reference genotype is encoded `"0|0"`.
  + Counts of reference genotypes are stored in INFO keys suffixed with
    `"REF"`.
  + Heterozygote genotypes are encoded as
    `"0|1"`, `"1|0"`, `"0|2"`, `"2|0"`, `"1|2"`, and `"2|1"`.
  + Counts of heterozygote genotypes are stored in INFO keys suffixed with
    `"HET"`.
  + Homozygote alternate genotype is encoded `"1|1"`.
  + Counts of alternate genotypes are stored in INFO keys suffixed with
    `"ALT"`.
* **Genomic ranges**
  + Accessor: `ranges(x)`
  + Class: `GRangesList`
  + A gene-coding region on chromosome `"15"`.
* **Alternate allele frequency**
  + Accessor: `aaf(x)`
  + Calculated values will be stored under INFO keys suffixed with `"AAF"`.
* **Minor allele frequency**
  + Accessor: `maf(x)`
  + Calculated values will be stored under INFO keys suffixed with `"MAF"`.
* **Ensembl VEP predictions**
  + Accessor: `vep(x)`
  + Information will be imported from the INFO field `"CSQ"`.
* **Parallel calculations**
  + Accessor: `bp(x)`
  + Class: `BiocParallelParam`
  + Serial evaluation (*i.e.* do not run parallel code)
* **VCF scan parameters**
  + Accessor: `svp(x)`
  + Class: `ScanVcfParam`
  + `which` slot automatically populated with `reduce(unlist(ranges(x)))`

Default values are provided for all slots except genotypes, as these may vary
more frequently from one data set to another (*e.g.* phased, unphased,
imputed).

# 4 Data import

## 4.1 Genetic variants

Functionalities in *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* support
`CollapsedVCF` and `ExpandedVCF` objects
(both extending the virtual class `VCF`) of the
*[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package.

Typically, `CollapsedVCF` objects are produced by the
*[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* `readVcf` method after parsing a VCF file,
and `ExpandedVCF` objects result of the
*[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* `expand` method applied to
a `CollapsedVCF` object.

Any information that users deem relevant for the analysis may be
imported from VCF files and stored in
`VCF` objects passed to *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* methods.
However, to enable the key functionalities of the package,
the slots of a `VCF` object should include
at least the following information:

* `fixed(x)`
  + fields `"REF"` and `"ALT"`.
* `info(x)`
  + field `<vep>`: where `<vep>` stands for the INFO key where
    the Ensembl VEP predictions are stored in the `VCF` object.
* `geno(x)`
  + `GT`: genotypes.
* `colData(x)`: phenotypes.

## 4.2 List of genomic ranges

In the near future, *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* functionalities are expected to
produce summary statistics and plots faceted by meta-features,
each potentially composed of multiple genomic ranges.

For instance, burden tests may be performed on a set of transcripts,
considering only variants in their respective sets of exons.
The *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* `GRangesList` class is an ideal container
in example,
as each `GRanges` in the `GRangesList` would represent a transcript,
and each element in the `GRanges` would represent an exon.

Furthermore, `TVTBparam` objects may be supplied as the `param`
argument of the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* `readVcf`. In this case, the
`TVTBparam` object is used to import only variants overlapping
the relevant genomic regions.
Moreover, the `readVcf` method also ensured that the `vep` slot of the
`TVTBparam` object is present in the header of the VCF file.

```
svp <- as(tparam, "ScanVcfParam")
svp
```

```
## class: ScanVcfParam
## vcfWhich: 1 elements
## vcfFixed: character() [All]
## vcfInfo:
## vcfGeno:
## vcfSamples:
```

## 4.3 Phenotypes

Although `VCF` objects may be constructed without attached phenotype data,
phenotype information is critical to interpret and compare genetic variants
between groups of samples
(*e.g.* burden of damaging variants in different phenotype levels).

`VCF` objects accept phenotype information
(as *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* `DataFrame`) in the `colData` slot.
This practice has the key advantage of keeping phenotype and genetic
information synchronised through operation such as subsetting and re-ordering,
limiting workspace [entropy](https://en.wikipedia.org/wiki/Software_entropy)
and confusion.

## 4.4 Example

An `ExpandedVCF` object that contains the minimal data necessary for the rest
of the vignette can be created as follows:

**Step 1:** Import phenotypes

```
phenoFile <- system.file(
    "extdata", "integrated_samples.txt", package = "TVTB")
phenotypes <- S4Vectors::DataFrame(
    read.table(file = phenoFile, header = TRUE, row.names = 1))
```

**Step 2:** Define the VCF file to parse

```
vcfFile <- system.file(
    "extdata", "chr15.phase3_integrated.vcf.gz", package = "TVTB")
tabixVcf <- Rsamtools::TabixFile(file = vcfFile)
```

**Step 3:** Define VCF import parameters

```
VariantAnnotation::vcfInfo(svp(tparam)) <- vep(tparam)
VariantAnnotation::vcfGeno(svp(tparam)) <- "GT"
svp(tparam)
```

```
## class: ScanVcfParam
## vcfWhich: 1 elements
## vcfFixed: character() [All]
## vcfInfo: CSQ
## vcfGeno: GT
## vcfSamples:
```

Of particular interest in the above chunk of code:

* The `TVTBparam` constructor previously populated the `which` slot of `svp`
  with “reduced” (*i.e.* non-overlapping)
  genomic ranges defined in the `ranges` slot.
* Only the INFO key defined in the `vep` slot will be imported
* Only the matrix of called genotypes will be imported

**Step 4:** Import and pre-process variants

```
# Import variants as a CollapsedVCF object
vcf <- VariantAnnotation::readVcf(
    tabixVcf, param = tparam, colData = phenotypes)
# Expand into a ExpandedVCF object (bi-allelic records)
vcf <- VariantAnnotation::expand(x = vcf, row.names = TRUE)
```

Of particular interest in the above chunk of code, the `readVcf` method is
given:

* `TVTBparam` parameters, invoking the corresponding method signature
* phenotypes
  + The `rownames` of those phenotypes defines the sample identifiers that
    are queried from the VCF file.
  + Those phenotypes are stored in the `colData` slot of the resulting
    `VCF` object.

The result is an `ExpandedVCF` object that includes variants
in the targeted genomic range(s) and samples:

```
## class: ExpandedVCF
## dim: 481 2504
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 1 column: CSQ
## info(header(vcf)):
##        Number Type   Description
##    CSQ .      String Consequence annotations from Ensembl VEP. Format: Allel...
## geno(vcf):
##   List of length 1: GT
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
```

# 5 Adding allele frequencies

Although interesting figures and summary tables may be obtained
as soon as the first `ExpandedVCF` object is created
(see section [Summarising Ensembl VEP predictions](#Summarise)),
those methods may benefit from information added to additional INFO keys
after data import, either manually by the user, or through various
methods implemented in the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package.

## 5.1 Adding overall frequencies

For instance, the method `addOverallFrequencies` uses the
reference homozoygote (*REF*), heterozygote (*HET*),
and homozygote alternate (*ALT*) genotypes defined in the `TVTBparam` object
stored in the `VCF` metadata
to obtain the count of each genotype in an `ExpandedVCF` object.
Immediately thereafter, the method uses those counts to calculate
alternate allele frequency (*AAF*) and minor allele frequency (*MAF*).
Finally, the method stores the five calculated values
(*REF*, *HET*, *ALT*, *AAF*, and *MAF*)
in INFO keys defined by suffixes also declared in the `TVTBparam` object.

```
initialInfo <- colnames(info(vcf))
vcf <- addOverallFrequencies(vcf = vcf)
setdiff(colnames(info(vcf)), initialInfo)
```

```
## [1] "REF" "HET" "ALT" "AAF" "MAF"
```

Notably, the `addOverallFrequencies` method is synonym to the `addFrequencies`
method missing the argument `phenos`:

```
vcf <- addFrequencies(vcf = vcf, force = TRUE)
```

## 5.2 Adding frequencies within phenotype level(s)

Similarly, the method `addPhenoLevelFrequencies` obtains the count of each
genotype in samples associated with given level(s) of given phenotype(s),
and stores the calculated values in INFO keys defined as
`<pheno>_<level>_<suffix>`, with suffixes defined in the `TVTBparam` object
stored in the `VCF` metadata.

```
initialInfo <- colnames(info(vcf))
vcf <- addPhenoLevelFrequencies(
    vcf = vcf, pheno = "super_pop", level = "AFR")
setdiff(colnames(info(vcf)), initialInfo)
```

```
## [1] "super_pop_AFR_REF" "super_pop_AFR_HET" "super_pop_AFR_ALT"
## [4] "super_pop_AFR_AAF" "super_pop_AFR_MAF"
```

Notably, the `addPhenoLevelFrequencies` method is synonym
to the `addFrequencies`
method called with the argument `phenos` given as a list where `names` are
phenotypes, and values are `character` vectors of levels to
process within each phenotype:

```
initialInfo <- colnames(info(vcf))
vcf <- addFrequencies(
    vcf,
    list(super_pop = c("EUR", "SAS", "EAS", "AMR"))
)
setdiff(colnames(info(vcf)), initialInfo)
```

```
##  [1] "super_pop_EUR_REF" "super_pop_EUR_HET" "super_pop_EUR_ALT"
##  [4] "super_pop_EUR_AAF" "super_pop_EUR_MAF" "super_pop_SAS_REF"
##  [7] "super_pop_SAS_HET" "super_pop_SAS_ALT" "super_pop_SAS_AAF"
## [10] "super_pop_SAS_MAF" "super_pop_EAS_REF" "super_pop_EAS_HET"
## [13] "super_pop_EAS_ALT" "super_pop_EAS_AAF" "super_pop_EAS_MAF"
## [16] "super_pop_AMR_REF" "super_pop_AMR_HET" "super_pop_AMR_ALT"
## [19] "super_pop_AMR_AAF" "super_pop_AMR_MAF"
```

In addition, the `addFrequencies` method can be given a `character` vector
of phenotypes as the `phenos` argument, in which case frequencies are
calculated for *all* levels of the given phenotypes:

```
vcf <- addFrequencies(vcf, "pop")
head(grep("^pop_[[:alpha:]]+_REF", colnames(info(vcf)), value = TRUE))
```

```
## [1] "pop_GBR_REF" "pop_FIN_REF" "pop_CHS_REF" "pop_PUR_REF" "pop_CDX_REF"
## [6] "pop_CLM_REF"
```

# 6 Filtering variants

Although `VCF` objects are straightforward to subset
using either indices and row names
(as they inherit from the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*
`RangedSummarizedExperiment` class),
users may wish to identify variants that pass combinations of criteria based on
information in their `fixed` slot, `info` slot, and Ensembl VEP predictions,
a non-trivial task due to those pieces of information being stored in
different slots of the `VCF` object, and the *1:N* relationship
between variants and EnsemblVEP predictions.

## 6.1 Definition of VCF filter rules

To facilitate the definition of VCF filter rules, and their application to
`VCF` objects, *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* extends the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)*
`FilterRules` class in four new classes of filter rules:

Motivation for each of the new classes extending `FilterRules`,
to define VCF filter rules.

| Class | Motivation |
| --- | --- |
| `VcfFixedRules` | Filter rules applied to the `fixed` slot of a `VCF` object. |
| `VcfInfoRules` | Filter rules applied to the `info` slot of a `VCF` object. |
| `VcfVepRules` | Filter rules applied to the Ensembl VEP predictions stored in a given INFO key of a `VCF` object. |
| `VcfFilterRules` | Combination of `VcfFixedRules`, `VcfInfoRules`, and `VcfVepRules` applicable to a `VCF` object. |

Note that `FilterRules` objects themselves are applicable to `VCF` objects,
with two important difference from the above specialised classes:

* Expressions must explicitely refer to the `VCF` slots
* As a consequence, a single expression can refer to fields from different
  `VCF` slots, for instance:

```
S4Vectors::FilterRules(list(
    mixed = function(x){
        VariantAnnotation::fixed(x)[,"FILTER"] == "PASS" &
            VariantAnnotation::info(x)[,"MAF"] >= 0.05
    }
))
```

```
## FilterRules of length 1
## names(1): mixed
```

Instances of those classes may be initialised as follows:

**VcfFixedRules**

```
fixedR <- VcfFixedRules(list(
    pass = expression(FILTER == "PASS"),
    qual = expression(QUAL > 20)
))
fixedR
```

```
## VcfFixedRules of length 2
## names(2): pass qual
```

**VcfInfoRules**

```
infoR <- VcfInfoRules(
    exprs = list(
        rare = expression(MAF < 0.01 & MAF > 0),
        common = expression(MAF > 0.05),
        mac_ge3 = expression(HET + 2*ALT >= 3)),
    active = c(TRUE, TRUE, FALSE)
)
infoR
```

```
## VcfInfoRules of length 3
## names(3): rare common mac_ge3
```

The above code chunk illustrates useful features of `FilterRules`:

* `FilterRules` are initialised in an active state by default
  (evaluating an *inactive* rule returns `TRUE` for all items)
  The `active` argument may be used to initialise specific filter rules in
  an inactive state.
* A single rule `expression` (or `function`) may refer to multiple columns of
  the relevant slot in the `VCF` object.
* Rules may include calculations, allowing filtering on values not necessarily
  stored as such in any slot of the `VCF` object.

**VcfVepRules**

```
vepR <- VcfVepRules(exprs = list(
    missense = expression(Consequence %in% c("missense_variant")),
    CADD_gt15 = expression(CADD_PHRED > 15)
    ))
vepR
```

```
## VcfVepRules of length 2
## names(2): missense CADD_gt15
```

**VcfFilterRules**

`VcfFilterRules` combine VCF filter rules of different types
in a single object.

```
vcfRules <- VcfFilterRules(fixedR, infoR, vepR)
vcfRules
```

```
## VcfFilterRules of length 7
## names(7): pass qual rare common mac_ge3 missense CADD_gt15
```

This vignette offers only a brief peek into the utility and flexibility of
VCF filter rules. More (complex) examples are given in a separate
vignette, including filter rules using functions and pattern matching.
The documentation of the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* package—where the parent
class `FilterRules` is defined—can also be a source of inspiration.

## 6.2 Control of VCF filter rules

As the above classes of *VCF filter rules* inherit
from the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* `FilterRules` class,
they also benefit from its accessors and methods.
For instance, VCF filter rules can easily be toggled
between active and inactive states:

```
active(vcfRules)["CADD_gt15"] <- FALSE
active(vcfRules)
```

```
##      pass      qual      rare    common   mac_ge3  missense CADD_gt15
##      TRUE      TRUE      TRUE      TRUE     FALSE      TRUE     FALSE
```

A separate vignette describes in greater detail the use of classes
that contain *VCF filter rules*.

## 6.3 Evaluation of VCF filter rules

Once defined, the above filter rules can be applied to `ExpandedVCF` objects,
in the same way as `FilterRules` are evaluated in a given environment
(see the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* documentation):

```
summary(eval(expr = infoR, envir = vcf))
```

```
##    Mode   FALSE
## logical     481
```

```
summary(eval(expr = vcfRules, envir = vcf))
```

```
##    Mode   FALSE
## logical     481
```

```
summary(evalSeparately(expr = vcfRules, envir = vcf))
```

```
##    pass           qual            rare           common        mac_ge3
##  Mode:logical   Mode:logical   Mode :logical   Mode :logical   Mode:logical
##  TRUE:481       TRUE:481       FALSE:45        FALSE:453       TRUE:481
##                                TRUE :436       TRUE :28
##   missense       CADD_gt15
##  Mode :logical   Mode:logical
##  FALSE:454       TRUE:481
##  TRUE :27
```

# 7 Visualising data

## 7.1 Visualise INFO data by phenotype level on a genomic axis

Let us show the alternate allele frequency (AAF) of common variants,
estimated in each super-population, in the context of the transcripts
ovelapping the region of interest.

In the `MAF` track:

* the points represent the MAF in each super-population on a common Y axis.
* the heatmap represents the MAF as the color intensity, given a row for each
  super-population.

```
plotInfo(
        subsetByFilter(vcf, vcfRules["common"]), "AAF",
        range(GenomicRanges::granges(vcf)),
        EnsDb.Hsapiens.v75::EnsDb.Hsapiens.v75,
        "super_pop",
        zero.rm = FALSE
    )
```

![](data:image/png;base64...)

Alternatively, the minor allele frequency (MAF) of missense variants
(as estimated from the entire data set) may be visualised in the same manner.
However, due to the nature of those variants, the `zero.rm` argument may be
set to `TRUE` to hide all data points showing a MAF of `0`; thereby
variants actually detected in each super-population are emphasised
even at low frequencies.

```
plotInfo(
        subsetByFilter(vcf, vcfRules["missense"]), "MAF",
        range(GenomicRanges::granges(vcf)),
        EnsDb.Hsapiens.v75::EnsDb.Hsapiens.v75,
        "super_pop",
        zero.rm = TRUE
    )
```

![](data:image/png;base64...)

# 8 Pairwise comparison of INFO data between phenotype levels

Using the *[GGally](https://CRAN.R-project.org/package%3DGGally)* `ggpairs` method,
let us make a matrix of plots for common variants, showing:

* in the *lower* triangle, pairwise scatter plots of the alternate allele
  frequency estimated each super-population
* on the *diagonal*, the density plot for each super-population shown on the
  diagonal
* in the *upper* triangle, the correlation111 Pearson, by default value

```
pairsInfo(subsetByFilter(vcf, vcfRules["common"]), "AAF", "super_pop")
```

![](data:image/png;base64...)

Note that the ellipsis `...` allows a high degree of customisation,
as it passes additional arguments to the underlying `ggpairs` method.

# 9 A taste of future…

This section presents upcoming features.

## 9.1 Summarising Ensembl VEP predictions

As soon as genetic and phenotypic information are imported
into an `ExpandedVCF` object,
or after the object was extended with additional information,
the scientific value of the data may be revealed by
a variety of summary statistics and graphical representations.
This section will soon present several ideas *being implemented* in
*[TVTB](https://bioconductor.org/packages/3.22/TVTB)*, for instance:

* Count of discrete Ensembl VEP predictions
  + by phenotype level
  + by genomic feature affected (*i.e.* transcript)
* Distribution of continuous Ensembl VEP predictions
  + by phenotype level
  + by genomic feature affected (*i.e.* transcript)

# 10 Acknowledgement

Dr. Stefan Gräf and Mr. Matthias Haimel
for advice on the VCF file format and the Ensembl VEP script.
Prof. Martin Wilkins for his trust and support.
Dr. Michael Lawrence for his helpful code review and suggestions.

Last but not least, the amazing collaborative effort of the `rep("many",n)`
[Bioconductor](http://bioconductor.org) developers whose hard work
appears through the dependencies of this package.

# 11 Session info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] TVTB_1.36.0      knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] magick_2.9.0                GenomicFeatures_1.62.0
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] BiocIO_1.20.0               vctrs_0.6.5
##  [11] memoise_2.0.1               Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17             base64enc_0.1-3
##  [15] tinytex_0.57                htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0             progress_1.2.3
##  [19] curl_7.0.0                  SparseArray_1.10.0
##  [21] Formula_1.2-5               sass_0.4.10
##  [23] bslib_0.9.0                 htmlwidgets_1.6.4
##  [25] plyr_1.8.9                  Gviz_1.54.0
##  [27] httr2_1.2.1                 cachem_1.1.0
##  [29] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [31] pkgconfig_2.0.3             Matrix_1.7-4
##  [33] R6_2.6.1                    fastmap_1.2.0
##  [35] MatrixGenerics_1.22.0       digest_0.6.37
##  [37] colorspace_2.1-2            GGally_2.4.0
##  [39] AnnotationDbi_1.72.0        S4Vectors_0.48.0
##  [41] Hmisc_5.2-4                 GenomicRanges_1.62.0
##  [43] RSQLite_2.4.3               labeling_0.4.3
##  [45] filelock_1.0.3              httr_1.4.7
##  [47] abind_1.4-8                 compiler_4.5.1
##  [49] withr_3.0.2                 bit64_4.6.0-1
##  [51] pander_0.6.6                htmlTable_2.4.3
##  [53] S7_0.2.0                    backports_1.5.0
##  [55] BiocParallel_1.44.0         DBI_1.2.3
##  [57] ggstats_0.11.0              biomaRt_2.66.0
##  [59] rappdirs_0.3.3              DelayedArray_0.36.0
##  [61] rjson_0.2.23                tools_4.5.1
##  [63] foreign_0.8-90              nnet_7.3-20
##  [65] glue_1.8.0                  restfulr_0.0.16
##  [67] grid_4.5.1                  checkmate_2.3.3
##  [69] reshape2_1.4.4              cluster_2.1.8.1
##  [71] generics_0.1.4              gtable_0.3.6
##  [73] BSgenome_1.78.0             tidyr_1.3.1
##  [75] ensembldb_2.34.0            data.table_1.17.8
##  [77] hms_1.1.4                   XVector_0.50.0
##  [79] BiocGenerics_0.56.0         pillar_1.11.1
##  [81] stringr_1.5.2               limma_3.66.0
##  [83] dplyr_1.1.4                 BiocFileCache_3.0.0
##  [85] lattice_0.22-7              deldir_2.0-4
##  [87] rtracklayer_1.70.0          bit_4.6.0
##  [89] EnsDb.Hsapiens.v75_2.99.0   biovizBase_1.58.0
##  [91] tidyselect_1.2.1            Biostrings_2.78.0
##  [93] gridExtra_2.3               bookdown_0.45
##  [95] IRanges_2.44.0              Seqinfo_1.0.0
##  [97] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
##  [99] stats4_4.5.1                xfun_0.53
## [101] Biobase_2.70.0              statmod_1.5.1
## [103] matrixStats_1.5.0           stringi_1.8.7
## [105] UCSC.utils_1.6.0            lazyeval_0.2.2
## [107] yaml_2.3.10                 evaluate_1.0.5
## [109] codetools_0.2-20            cigarillo_1.0.0
## [111] interp_1.1-6                tibble_3.3.0
## [113] BiocManager_1.30.26         cli_3.6.5
## [115] rpart_4.1.24                jquerylib_0.1.4
## [117] dichromat_2.0-0.1           Rcpp_1.1.0
## [119] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [121] png_0.1-8                   XML_3.99-0.19
## [123] parallel_4.5.1              ggplot2_4.0.0
## [125] blob_1.2.4                  prettyunits_1.2.0
## [127] jpeg_0.1-11                 latticeExtra_0.6-31
## [129] AnnotationFilter_1.34.0     bitops_1.0-9
## [131] VariantAnnotation_1.56.0    scales_1.4.0
## [133] purrr_1.1.0                 crayon_1.5.3
## [135] rlang_1.1.6                 KEGGREST_1.50.0
```

# 12 References

McLaren, W., B. Pritchard, D. Rios, Y. Chen, P. Flicek, and F. Cunningham. 2010. “Deriving the Consequences of Genomic Variants with the Ensembl API and SNP Effect Predictor.” Journal Article. *Bioinformatics* 26 (16): 2069–70. <https://doi.org/10.1093/bioinformatics/btq330>.

# Appendix