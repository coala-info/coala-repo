# VCF filter rules

Kévin Rue-Albrecht1,2\*

1Department of Medicine, Imperial College London, UK
2Nuffield Department of Medicine, University of Oxford, UK

\*kevinrue67@gmail.com

#### 30 October 2025

#### Abstract

Currently, `VCF` objects of the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package may be subsetted by indices or names of variant records. The *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package extends `FilterRules` of the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* package to provide filter rules readily applicable to individual slots of `VCF` objects. These new classes of filter rules provide containers for powerful expressions and functions to facilitate filtering of variants using combinations of filters applicable to FIXED fields, INFO fields, and Ensembl VEP predictions stored in a given INFO field of VCF files.

#### Package

TVTB 1.36.0

# 1 Motivation

## 1.1 Background

`VCF` objects of the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package contain a
plethora of information imported from specific fields of source VCF files and
stored in dedicated slots (*e.g.* `fixed`, `info`, `geno`),
as well as optional Ensembl VEP predictions (McLaren et al. [2010](#ref-RN1))
stored under a given key of their INFO slot.

This information may be used to identify and filter variants of interest
for further analysis.
However, the size of genetic data sets and the variety of filter
rules—and their combinatorial explosion—create
considerable challenges in terms of workspace memory and entropy
(*i.e.* size and number of objects in the workspace, respectively).

The `FilterRules` class implemented in the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* package
provides a powerful tool to create flexible
and lightweight filter rules defined in the form of
`expression` and `function` objects that can be evaluated
within given environments.
The *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package extends this `FilterRules` class
into novel classes of *VCF filter rules*,
applicable to information stored in the distinct slots of `VCF`
objects (*i.e.* `CollapsedVCF` and `ExpandedVCF` classes),
as described below:

Motivation for each of the new classes extending `FilterRules`,
to define VCF filter rules.

| Class | Motivation |
| --- | --- |
| `VcfFixedRules` | Filter rules applied to the `fixed` slot of a `VCF` object. |
| `VcfInfoRules` | Filter rules applied to the `info` slot of a `VCF` object. |
| `VcfVepRules` | Filter rules applied to the Ensembl VEP predictions stored in a given INFO key of a `VCF` object. |
| `VcfFilterRules` | Combination of `VcfFixedRules`, `VcfInfoRules`, and `VcfVepRules` applicable to a `VCF` object. |

Table: Motivation for each of the new classes extending `FilterRules`
to define *VCF filter rules*.

Note that `FilterRules` objects themselves are applicable to `VCF` objects,
with two important difference from the above specialised classes:

* Expressions must explicitely refer to the different `VCF` slots
* As a consequence, a single expression can refer to fields from different
  `VCF` slots, for instance:

```
fr <- S4Vectors::FilterRules(list(
    mixed = function(x){
        VariantAnnotation::fixed(x)[,"FILTER"] == "PASS" &
            VariantAnnotation::info(x)[,"MAF"] >= 0.05
    }
))
fr
```

```
## FilterRules of length 1
## names(1): mixed
```

## 1.2 Features

As they inherit from the `FilterRules` class,
these new classes benefit from accessors and methods defined for their
parent class, including:

* *VCF filter rules* can be toggled individually between an active and
  an inactive states
* *VCF filter rules* can be subsetted, edited, replaced, and deleted

To account for the more complex structure of `VCF` objects, some of the new
*VCF filter rules* classes implemented in the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package
require additional information stored in new dedicated slots,
associated with the appropriate accessors and setters.
For instance:

* `VcfVepRules` require the INFO key where predictions of the
  Ensembl Variant Effect Predictor are stored in a `VCF` object.
  The `vep` accessor method may be used to access this slot.
* `VcfFilterRules`—which may combine any number of filter rules stored in
  `FixedRules`, `VcfFixedRules`, `VcfInfoRules`, `VcfVepRules`, and other
  `VcfFilterRules` objects—
  mark each filter rule with their type in the combined
  object. The information is stored in the `type` slot, which may be
  accessed using the *read-only* accessor method `type`.

# 2 Demonstration data

For the purpose of demonstrating the utility and usage of *VCF filter rules*,
a set of variants and associated phenotype information was
obtained from the
[1000 Genomes Project](http://www.1000genomes.org) Phase 3 release.
It can be imported as a `CollapsedVCF` object using the following code:

```
library(TVTB)
extdata <- system.file("extdata", package = "TVTB")
vcfFile <- file.path(extdata, "chr15.phase3_integrated.vcf.gz")
tabixVcf <- Rsamtools::TabixFile(file = vcfFile)
vcf <- VariantAnnotation::readVcf(file = tabixVcf)
```

VCF filter rules may be applied to `ExpandedVCF` objects equally:

```
evcf <- VariantAnnotation::expand(x = vcf, row.names = TRUE)
```

## 2.1 CollapsedVCF and ExpandedVCF

As described in the documentation of the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)*
package, the key difference between `CollapsedVCF` and `ExpandedVCF` objects
—both extending the `VCF` class—is
the expansion of multi-allelic records into bi-allelic records, respectively.
In other words (quoting the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* documentation):

> “`CollapsedVCF` objects contains the ALT data as a
> `DNAStringSetList` allowing for multiple alleles per variant.
> In contrast, the `ExpandedVCF` stores the ALT data as a `DNAStringSet`
> where the ALT column has been expanded to create a flat form of the data
> with one row per variant-allele combination.”

This difference has implications for filter rules using the `"ALT"` field
of the `info` slot, as demonstrated in a [later section](#AltField).

# 3 Fields available for the definition of filter rules

First, let us examine which fields (*i.e.* column names)
are available in the `VCF` objects to create *VCF filter rules*:

```
fixedVcf <- colnames(fixed(vcf))
fixedVcf
```

```
## [1] "REF"    "ALT"    "QUAL"   "FILTER"
```

```
infoVcf <- colnames(info(vcf))
infoVcf
```

```
##  [1] "CIEND"         "CIPOS"         "CS"            "END"
##  [5] "IMPRECISE"     "MC"            "MEINFO"        "MEND"
##  [9] "MLEN"          "MSTART"        "SVLEN"         "SVTYPE"
## [13] "TSD"           "AC"            "AF"            "NS"
## [17] "AN"            "EAS_AF"        "EUR_AF"        "AFR_AF"
## [21] "AMR_AF"        "SAS_AF"        "DP"            "AA"
## [25] "VT"            "EX_TARGET"     "MULTI_ALLELIC" "CSQ"
```

```
csq <- parseCSQToGRanges(x = evcf)
vepVcf <- colnames(mcols(csq))
vepVcf
```

```
##  [1] "Allele"             "Consequence"        "IMPACT"
##  [4] "SYMBOL"             "Gene"               "Feature_type"
##  [7] "Feature"            "BIOTYPE"            "EXON"
## [10] "INTRON"             "HGVSc"              "HGVSp"
## [13] "cDNA_position"      "CDS_position"       "Protein_position"
## [16] "Amino_acids"        "Codons"             "Existing_variation"
## [19] "DISTANCE"           "STRAND"             "FLAGS"
## [22] "VARIANT_CLASS"      "SYMBOL_SOURCE"      "HGNC_ID"
## [25] "CANONICAL"          "TSL"                "APPRIS"
## [28] "CCDS"               "ENSP"               "SWISSPROT"
## [31] "TREMBL"             "UNIPARC"            "GENE_PHENO"
## [34] "SIFT"               "PolyPhen"           "DOMAINS"
## [37] "HGVS_OFFSET"        "GMAF"               "AFR_MAF"
## [40] "AMR_MAF"            "EAS_MAF"            "EUR_MAF"
## [43] "SAS_MAF"            "AA_MAF"             "EA_MAF"
## [46] "ExAC_MAF"           "ExAC_Adj_MAF"       "ExAC_AFR_MAF"
## [49] "ExAC_AMR_MAF"       "ExAC_EAS_MAF"       "ExAC_FIN_MAF"
## [52] "ExAC_NFE_MAF"       "ExAC_OTH_MAF"       "ExAC_SAS_MAF"
## [55] "CLIN_SIG"           "SOMATIC"            "PHENO"
## [58] "PUBMED"             "MOTIF_NAME"         "MOTIF_POS"
## [61] "HIGH_INF_POS"       "MOTIF_SCORE_CHANGE" "CADD_PHRED"
## [64] "CADD_RAW"
```

# 4 Usage of VCF filter rules

## 4.1 Filter rules using a single field

The value of a particular field can be used to define expressions
that represent simple filter rules based on that value alone.
Multiple rules may be stored in any one `FilterRules` objects.
Ideally, *VCF filter rules* should be named
to facilitate their use,
but also as a reminder of the purpose of each particular rule.
For instance, in the chunk of code below, two filter rules are defined
using fields of the `fixed` slot:

* A rule named `"pass"` identifies variants for which the value in the
  `FILTER` field is `"PASS"`
* A rule named `"qual20"` identifies variants where the value in the `QUAL`
  field is greater than or equal to `20`

```
fixedRules <- VcfFixedRules(exprs = list(
    pass = expression(FILTER == "PASS"),
    qual20 = expression(QUAL >= 20)
))
active(fixedRules)["qual20"] <- FALSE
summary(evalSeparately(fixedRules, vcf))
```

```
##    pass          qual20
##  Mode:logical   Mode:logical
##  TRUE:479       TRUE:479
```

In the example above, all variants pass the active `"pass"` filter,
while the deactivated rules `"qual20"`) automatically returns `TRUE`
for all variants.

## 4.2 Filter rules using multiple fields

It is also possible for *VCF filter rules* to use multiple fields
(of the same `VCF` slot) in a single expression.
In the chunk of code below, the *VCF filter rule* identifies variants
for which both the `"REF"` and `"ALT"` values (in the INFO slot)
are one of the four nucleotides
(*i.e.* a simple definition of single nucleotide polymorphisms; SNPs):

```
nucleotides <- c("A", "T", "G", "C")
SNPrule <- VcfFixedRules(exprs = list(
    SNP = expression(
    as.character(REF) %in% nucleotides &
        as.character(ALT) %in% nucleotides)
))
summary(evalSeparately(SNPrule, evcf, enclos = .GlobalEnv))
```

```
##     SNP
##  Mode :logical
##  FALSE:14
##  TRUE :467
```

Some considerations regarding the above filter rule:

* considering that the filter rule requires the `nucleotides` character vector,
  the global environment must be supplied as the enclosing environment to
  successfully evaluate the expression
* `"REF"` and `"ALT"` are stored as `DNAStringSet` in `CollapsedVCF` objects
  and must be converted to `character`
  in order to successfully apply the method `%in%`.

## 4.3 Calculations in filter rules

Expressions that define filter rules may also include calculations.
In the chunk of code below, two simple *VCF filter rules* are defined
using fields of the `info` slot:

* A rule named `"samples"` identifies variants where at least 90% of samples
  have data (*i.e.* the `NS` value is greater than or equal to `0.9`
  times the total number of samples)
* A rule named `"avgSuperPopAF"` calculates the average of the allele
  frequencies calculated in each the five super-populations
  (available in several INFO fields), and
  subsequently identifies variants with an average value greater than `0.05`.

```
infoRules <- VcfInfoRules(exprs = list(
    samples = expression(NS > (0.9 * ncol(evcf))),
    avgSuperPopAF = expression(
        (EAS_AF + EUR_AF + AFR_AF + AMR_AF + SAS_AF) / 5 > 0.05
    )
))
summary(evalSeparately(infoRules, evcf, enclos = .GlobalEnv))
```

```
##  samples        avgSuperPopAF
##  Mode:logical   Mode :logical
##  TRUE:481       FALSE:452
##                 TRUE :29
```

## 4.4 Functions in filter rules

It may be more convenient to define filters as `function` objects.
For instance, the chunk of code below:

* first, defines a function that:
  + expects the `info` slot of a `VCF` object as input
  + identifies variants where at least two thirds of the super-populations
    show an allele frequency greater than 5%
* next, defines a *VCF filter rule* using the above function

```
AFcutoff <- 0.05
popCutoff <- 2/3
filterFUN <- function(envir){
    # info(vcf) returns a DataFrame; rowSums below requires a data.frame
    df <- as.data.frame(envir)
    # Identify fields storing allele frequency in super-populations
    popFreqCols <- grep("[[:alpha:]]{3}_AF", colnames(df))
    # Count how many super-population have an allele freq above the cutoff
    popCount <- rowSums(df[,popFreqCols] > AFcutoff)
    # Convert the cutoff ratio to a integer count
    popCutOff <- popCutoff * length(popFreqCols)
    # Identifies variants where enough super-population pass the cutoff
    testRes <- (popCount > popCutOff)
    # Return a boolean vector, required by the eval method
    return(testRes)
}
funFilter <- VcfInfoRules(exprs = list(
    commonSuperPops = filterFUN
))
summary(evalSeparately(funFilter, evcf))
```

```
##  commonSuperPops
##  Mode :logical
##  FALSE:464
##  TRUE :17
```

Notably, the `filterFUN` function may also be applied separately to the
`info` slot of `VCF` objects:

```
summary(filterFUN(info(evcf)))
```

```
##    Mode   FALSE    TRUE
## logical     464      17
```

## 4.5 Pattern matching in filter rules

The `grepl` function is particularly suited for the purpose of `FilterRules`
as they return a `logical` vector:

```
missenseFilter <- VcfVepRules(
    exprs = list(
        exact = expression(Consequence == "missense_variant"),
        grepl = expression(grepl("missense", Consequence))
        ),
    vep = "CSQ")
summary(evalSeparately(missenseFilter, evcf))
```

```
##    exact           grepl
##  Mode :logical   Mode :logical
##  FALSE:454       FALSE:452
##  TRUE :27        TRUE :29
```

In the above chunk of code:

* the filter rule named `"exact"` matches only the given value, associated
  with `27` variants,
* the filter rule named `"grepl"` also matches an extra two variants
  associated with the value `"missense_variant&splice_region_variant"`
  matched by the given pattern. By deduction, the two rules indicate
  together that those two variants were not assigned the
  `"missense_variant"` prediction.

# 5 Using ALT data in the `fixed` slot of `VCF` objects

As detailed in an earlier section introducing the
[demonstration data](#VcfClasses), and more thoroughly in the documentation of
the *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package,
`CollapsedVCF` and `ExpandedVCF` classes differ in the class of data
stored in the `"ALT"` field of their respective `fixed` slot.
As as result, *VCF filter rules* using
data from this field must take into account the `VCF` class in order to
handle the data appropriately:

## 5.1 `ExpandedVCF` objects

A key aspect of `ExpandedVCF` objects is that the `"ALT"` field of their
`fixed` slot may store only a single allele per record as a `DNAStringSet`
object.

For instance, in an earlier section that demonstrated
[Filter rules using multiple raw fields](#MultipleFieldsFilter),
ALT data of the `fixed` slot in an `ExpandedVCF` object had to be re-typed
from `DNAStringSet` to `character` before the `%in%` function could be applied.

Nevertheless, *VCF filter rules* may also make use of methods associated with
the `DNAStringSet` class.
For instance, genetic insertions may be identified
using the fields `"REF"` and `"ALT"` fields of the `fixed` slot:

```
fixedInsertionFilter <- VcfFixedRules(exprs = list(
    isInsertion = expression(
        Biostrings::width(ALT) > Biostrings::width(REF)
    )
))
evcf_fixedIns <- subsetByFilter(evcf, fixedInsertionFilter)
as.data.frame(fixed(evcf_fixedIns)[,c("REF", "ALT")])
```

```
##   REF ALT
## 1   A  AC
## 2   A  AT
## 3   C  CA
## 4   T  TA
```

Here, the above `VcfFixedRules` is synonym to a distinct
`VcfVepRules` using the Ensembl VEP prediction `"VARIANT_CLASS"`:

```
vepInsertionFilter <- VcfVepRules(exprs = list(
    isInsertion = expression(VARIANT_CLASS == "insertion")
))
evcf_vepIns <- subsetByFilter(evcf, vepInsertionFilter)
as.data.frame(fixed(evcf_vepIns)[,c("REF", "ALT")])
```

```
##   REF ALT
## 1   A  AC
## 2   A  AT
## 3   C  CA
## 4   T  TA
```

## 5.2 `CollapsedVCF` objects

In contrast to `ExpandedVCF`, `CollapsedVCF` may contain more than one allele
per record in their `"ALT"` field (`fixed` slot),
represented by a `DNAStringSetList` object.

As a result, *VCF filter rules* using the `"ALT"` field of
the `info` slot in `CollapsedVCF` objects
may use methods dedicated to `DNAStringSetList` to handle the data.
For instance,
multi-allelic variants may be identified by the following `VcfFixedRules`:

```
multiallelicFilter <- VcfFixedRules(exprs = list(
    multiallelic = expression(lengths(ALT) > 1)
))
summary(eval(multiallelicFilter, vcf))
```

```
##    Mode   FALSE    TRUE
## logical     477       2
```

# 6 Combination of multiple types of *VCF filter rules*

Any number of `VcfFixedRules`, `VcfInfoRules`, and `VcfVepRules`—or
even `VcfFilterRules` themselves—may
be combined into a larger object of class `VcfFilterRules`.
Notably, the *active* state of each filter rule is transferred to the
combined object.
Even though the `VcfFilterRules` class acts as a container for multiple types
of *VCF filter rules*, the resulting `VcfFilterRules` object
also extends the `FilterRules` class, and as a result
can be evaluated and used to subset `VCF` objects identically to any of
the specialised more specialised classes.

During the creation of `VcfFixedRules` objects, each *VCF filter rule*
being combined is marked with a *type* value,
indicating the VCF slot in which the filter rule must be evaluated.
This information is stored in the new `type` slot of `VcfFixedRules` objects.
For instance, it is possible to combine two `VcfFixedRules`
(containing two and one filter rules, respectively), one
`VcfInfoRules`, and one `VcfVepRules` defined earlier in this vignette:

```
vignetteRules <- VcfFilterRules(
    fixedRules,
    SNPrule,
    infoRules,
    vepInsertionFilter
)
vignetteRules
```

```
## VcfFilterRules of length 6
## names(6): pass qual20 SNP samples avgSuperPopAF isInsertion
```

```
active(vignetteRules)
```

```
##          pass        qual20           SNP       samples avgSuperPopAF
##          TRUE         FALSE          TRUE          TRUE          TRUE
##   isInsertion
##          TRUE
```

```
type(vignetteRules)
```

```
##          pass        qual20           SNP       samples avgSuperPopAF
##       "fixed"       "fixed"       "fixed"        "info"        "info"
##   isInsertion
##         "vep"
```

```
summary(evalSeparately(vignetteRules, evcf, enclos = .GlobalEnv))
```

```
##    pass          qual20           SNP          samples        avgSuperPopAF
##  Mode:logical   Mode:logical   Mode :logical   Mode:logical   Mode :logical
##  TRUE:481       TRUE:481       FALSE:14        TRUE:481       FALSE:452
##                                TRUE :467                      TRUE :29
##  isInsertion
##  Mode :logical
##  FALSE:477
##  TRUE :4
```

Clearly111 This statement below would be more evident if the `summary` method
was displaying the result of `evalSeparately` in this vignette as it does it
in an R session., the *VCF filter rules* `SNP` and `isInsertion` are
mutually exclusive, which explains the final `0` variants left after filtering.
Conveniently, either of these rules may be deactivated before evaluating the
remaining active filter rules:

```
active(vignetteRules)["SNP"] <- FALSE
summary(evalSeparately(vignetteRules, evcf, enclos = .GlobalEnv))
```

```
##    pass          qual20          SNP          samples        avgSuperPopAF
##  Mode:logical   Mode:logical   Mode:logical   Mode:logical   Mode :logical
##  TRUE:481       TRUE:481       TRUE:481       TRUE:481       FALSE:452
##                                                              TRUE :29
##  isInsertion
##  Mode :logical
##  FALSE:477
##  TRUE :4
```

As a result, the deactivated filter rule (`"SNP"`) now returns `TRUE`
for all variants, leaving a final `2` variants222 Again, this statement would benefit from the result of `evalSeparately`
being displayed identically to an R session. pass the remaining
active filter rules:

* INFO/FILTER equal to `"PASS"`
* INFO/NS greater than 90% of the number of samples in the data set
* Average of super-population allele frequencies greater than `0.05`
* Ensembl VEP prediction `VARIANT_CLASS` equal to `"insertion"`

Finally, the following chunk of code demonstrates how
`VcfFilterRules` may also be created from the
combination of `VcfFilterRules`, either with themselves
or with any of the classes that define more specific *VCF filter rules*.
Notably, when `VcfFilterRules` objects are combined,
the `type` and `active` value of each filter rule is transferred to
the combined object:

**Combine `VcfFilterRules` with `VcfVepRules`**

```
combinedFilters <- VcfFilterRules(
    vignetteRules, # VcfFilterRules
    missenseFilter # VcfVepRules
)
type(vignetteRules)
```

```
##          pass        qual20           SNP       samples avgSuperPopAF
##       "fixed"       "fixed"       "fixed"        "info"        "info"
##   isInsertion
##         "vep"
```

```
type(combinedFilters)
```

```
##          pass        qual20           SNP       samples avgSuperPopAF
##       "fixed"       "fixed"       "fixed"        "info"        "info"
##   isInsertion         exact         grepl
##         "vep"         "vep"         "vep"
```

```
active(vignetteRules)
```

```
##          pass        qual20           SNP       samples avgSuperPopAF
##          TRUE         FALSE         FALSE          TRUE          TRUE
##   isInsertion
##          TRUE
```

```
active(missenseFilter)
```

```
## exact grepl
##  TRUE  TRUE
```

```
active(combinedFilters)
```

```
##          pass        qual20           SNP       samples avgSuperPopAF
##          TRUE         FALSE         FALSE          TRUE          TRUE
##   isInsertion         exact         grepl
##          TRUE          TRUE          TRUE
```

**Combine multiple `VcfFilterRules` with `VcfFilterRules` (and more)**

To demonstrate this action, another `VcfFilterRules` must first be created.
This can be achieve by simply re-typing a `VcfVepRules` defined earlier:

```
secondVcfFilter <- VcfFilterRules(missenseFilter)
secondVcfFilter
```

```
## VcfFilterRules of length 2
## names(2): exact grepl
```

It is now possible to combine the two `VcfFilterRules`.
Let us even combine another `VcfInfoRules` object in the same step:

```
manyRules <- VcfFilterRules(
    vignetteRules, # VcfFilterRules
    secondVcfFilter, # VcfFilterRules
    funFilter # VcfInfoRules
)
manyRules
```

```
## VcfFilterRules of length 9
## names(9): pass qual20 SNP samples avgSuperPopAF isInsertion exact grepl commonSuperPops
```

```
active(manyRules)
```

```
##            pass          qual20             SNP         samples   avgSuperPopAF
##            TRUE           FALSE           FALSE            TRUE            TRUE
##     isInsertion           exact           grepl commonSuperPops
##            TRUE            TRUE            TRUE            TRUE
```

```
type(manyRules)
```

```
##            pass          qual20             SNP         samples   avgSuperPopAF
##         "fixed"         "fixed"         "fixed"          "info"          "info"
##     isInsertion           exact           grepl commonSuperPops
##           "vep"           "vep"           "vep"          "info"
```

```
summary(evalSeparately(manyRules, evcf, enclos = .GlobalEnv))
```

```
##    pass          qual20          SNP          samples        avgSuperPopAF
##  Mode:logical   Mode:logical   Mode:logical   Mode:logical   Mode :logical
##  TRUE:481       TRUE:481       TRUE:481       TRUE:481       FALSE:452
##                                                              TRUE :29
##  isInsertion       exact           grepl         commonSuperPops
##  Mode :logical   Mode :logical   Mode :logical   Mode :logical
##  FALSE:477       FALSE:454       FALSE:452       FALSE:464
##  TRUE :4         TRUE :27        TRUE :29        TRUE :17
```

Critically, users must be careful to combine rules **all** compatible with
the class of `VCF` object in which it will be evaluated
(*i.e.* `CollapsedVCF` or `ExpandedVCF`).

# 7 Session info

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

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

# 8 References

McLaren, W., B. Pritchard, D. Rios, Y. Chen, P. Flicek, and F. Cunningham. 2010. “Deriving the Consequences of Genomic Variants with the Ensembl API and SNP Effect Predictor.” Journal Article. *Bioinformatics* 26 (16): 2069–70. <https://doi.org/10.1093/bioinformatics/btq330>.

# Appendix