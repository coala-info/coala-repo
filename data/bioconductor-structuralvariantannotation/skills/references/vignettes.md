# StructuralVariantAnnotation Quick Overview

#### Ruining Dong, Daniel Cameron

#### 2025-10-30

## Introduction

This vignette outlines parsing and annotation of structural variants from Variant Call Format (VCF) using the `StructuralVariantAnnotation` package. `StructuralVariantAnnotation` contains useful helper functions for reading, comparing, and interpreting structural variant calls. `StructuralVariantAnnotation` The package contains functions for parsing VCFs from a number of popular callers, dealing with breakpoints involving two separate genomic loci encoded as `GRanges` objects, as well as identifying various biological phenomena.

## Installation

The *StructuralVariationAnnotation* package can be installed from *Bioconductor* as follows:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    #install.packages("BiocManager")
BiocManager::install("StructuralVariantAnnotation")
library(StructuralVariantAnnotation)
```

## Representing structural variants in VCF

The [VCF standard](https://samtools.github.io/hts-specs/VCFv4.3.pdf) allows for four different structural variant notations. Here, we shall us a simple deletion as an example of the available notations:

```
CGTGTtgtagtaCCGTAA  chr sequence
     -------        deleted bases
```

* Direct sequence notation

```
chr 5   sequence    TTGTAGTA    T   .   .
```

This is the format that most users will be familar with. It is the format used for small insertions and deletions. Unfortunately, it does not scale well to large events since both the `REF` and `ALT` sequences must be specified in full. For this reason, most structural variant callers will report events in a different notation.

* Symbolic notation

```
chr 5   symbolic    T   <DEL>   .   .   SVTYPE=DEL;SVLEN=-7;END=12
```

In symbolic notation, the `ALT` is replaced with a special symbolic allele, optionally with a sub-type (e.g. `<DEL:ME>` for a deletion known to be a mobile element deletion). The size of the event is determined via the `SVLEN` and `END` fields. The VCF specifications recognises `<DEL>`, `<DUP>`, `<INS>`, `<INV>`, and `<CNV>` as top-level symoblic structural variant alleles with all other values taking on non-standard implementation-defined meaning.

There are two problems with this representation. Firstly, it is ambiguous whether a caller reporting an event is making a breakpoint claim, a copy number change, or both. Secondly, this notation does not allow inter-chromosomal events to be represented. These require yet another notation

* Breakend notation

```
chr 5   breakpoint1 T   T[chr:13[   .   .   SVTYPE=BND;MATEID=breakpoint2
chr 13  breakpoint2 C   ]chr:5]C    .   .   SVTYPE=BND;MATEID=breakpoint1
```

In this notation, a breakpoint is represented by a pair of breakend records, each containing the location of the two breakends and linked by their `ID` using the `MATEID` `INFO` field. Arbitrary rearrangements can be represented using breakend notation, including special-case syntax to represent the termination of a chromosome.

Finally, the VCF specifications support one additional notation for structural variants: single breakends.

* Single breakend notation

```
chr 5   breakend    T   T.  .   .   SVTYPE=BND
```

Single breakends are breakpoints in which only one side can be unambiguously determined. This can be due to one breakend being unable to be uniquely placed (e.g. a breakpoint into centromeric sequence), or due to the sequence of one side being novel with respect to the reference (e.g. a viral integration breakpoint).

## Using GRanges for structural variants: a breakend-centric data structure

Unlike breakpoint-centric data structures such as the `Pairs` object that `rtracklayer` uses to load BEDPE files, this package uses a breakend-centric notation. Breakends are stored in a GRanges object with strand used to indicate orientation and is consistent with VCF breakend notation. The position in the GRanges indicates the position of the base immediately adjacent to the breakpoint. `+` indicates that the breakpoint orientation is “forward” the derivative chromosome consists of the bases at and before the break position. `-` indicates that the breakpoint orientation is “backwards” the derivative chromosome consists of the bases at and after the break position. Breakpoints are represented using the `partner` field. The `partner` field contains the GRanges row name of the breakend at the other side of the breakpoint. Single breakends have an `NA` `partner` since the other side is unknown.

This notation has a number of advantages over other repentation formations. Firstly, it allows both breakpoints and single breakends to be represented in a single data structure. Secondly, it simplifies annotation as most genomic annotations are for a genomic position, or a contiguous genomic region (e.g. genes, introns, exons, repeats, mappability). Finally, it provides a unified representation format regardless of the format used to represent the variant.

Using our previous example, we can see that the direct sequence and symbolic representations require multiple rows to represent:

```
suppressPackageStartupMessages(library(StructuralVariantAnnotation))
vcf <- VariantAnnotation::readVcf(system.file("extdata", "representations.vcf", package = "StructuralVariantAnnotation"))
gr <- c(breakpointRanges(vcf), breakendRanges(vcf))
gr
#> GRanges object with 7 ranges and 13 metadata columns:
#>                seqnames    ranges strand | paramRangeID         REF         ALT
#>                   <Rle> <IRanges>  <Rle> |     <factor> <character> <character>
#>   sequence_bp1      chr         5      + |           NA    TTGTAGTA           T
#>   sequence_bp2      chr        13      - |           NA    TTGTAGTA           T
#>   symbolic_bp1      chr         5      + |           NA           T       <DEL>
#>   symbolic_bp2      chr        13      - |           NA           T       <DEL>
#>    breakpoint1      chr         5      + |           NA           T   T[chr:13[
#>    breakpoint2      chr        13      - |           NA           C    ]chr:5]C
#>       breakend      chr         5      + |           NA           T          T.
#>                     QUAL      FILTER    sourceId      partner      svtype
#>                <numeric> <character> <character>  <character> <character>
#>   sequence_bp1        NA           .    sequence sequence_bp2        <NA>
#>   sequence_bp2        NA           .    sequence sequence_bp1        <NA>
#>   symbolic_bp1        NA           .    symbolic symbolic_bp2         DEL
#>   symbolic_bp2        NA           .    symbolic symbolic_bp1         DEL
#>    breakpoint1        NA           . breakpoint1  breakpoint2         BND
#>    breakpoint2        NA           . breakpoint2  breakpoint1         BND
#>       breakend        NA           .    breakend         <NA>         BND
#>                    svLen      insSeq    insLen       event    HOMLEN
#>                <numeric> <character> <numeric> <character> <numeric>
#>   sequence_bp1        -7                     0        <NA>         0
#>   sequence_bp2        -7                     0        <NA>         0
#>   symbolic_bp1        -7        <NA>         0        <NA>         0
#>   symbolic_bp2        -7        <NA>         0        <NA>         0
#>    breakpoint1        -7                     0        <NA>         0
#>    breakpoint2        -7                     0        <NA>         0
#>       breakend        NA                     0        <NA>         0
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome
```

These rows are linked backed to their originating VCF row through the `sourceId` field. All 3 breakpoint notations are identical when represented using the StructuralVariantAnnotation GRanges breakpoint notation.

## Loading data from VCF

StructuralVariantAnnotation is built on top of the Bioconductor package `VariantAnnotation`. VCF files are loaded using `VariantAnnotation::readVcf`, and converted to breakpoint GRanges notation using `breakpointRanges` Any non-structural variants such as single nucleotide variants in a VCF will be silently ignored by StructuralVariantAnnotation. More information about `VCF` objects can be found by consulting the vignettes in the VariantAnnotation package with `browseVignettes("VariantAnnotation")`.

### Non-compliant VCFs

StructuralVariantAnnotation has additional parsing logic to enable reading VCF from popular callers that do not conform to VCF specifications. Specically, StructuralVariantAnnotation supports the following:

* `SVTYPE=RPL`. Used by Pindel to represent deletion-with-insertion events.
* `INV3`, `INV5`. Used Manta and DELLY to indicate that an `<INV>` inversion call only includes one of the breakpoints required for an actual inversion.
* `SVTYPE=TRA`/`CHR2`/`CT` Used by DELLY (and others) to indicate an inter-chromosomal breakpoint.
* `SVTYPE=CTX`. BreakDancer-style notation used by TIGRA to indicate an inter-chromosomal breakpoint.

## Ambiguous breakpoint positions

A structural variant call can be ambiguous for one of two reasons. Firstly, a discordant read pair or read depth based caller can make `IMPRECISE` call as the caller itself is unsure of the breakpoint position. Second, homology at the breakpoint can result (See [Section 5.4.8 of the VCF version 4.3 specifications](https://samtools.github.io/hts-specs/VCFv4.3.pdf#page=22)) in multiple possible breakpoint positions resulting in identical sequence. This ambiguity is intrinsic to the call itself.

StructuralVariantAnnotation incorporates both forms of ambiguity using both `CIPOS` and `HOMPOS` VCF fields into the GRanges breakend intervals. Breakend with ambiguity will have their `start` and `end` positions.

These breakpoint positional ambiguity bounds can be removed by specifying `nominalPosition=FALSE` when calling `breakpointRanges`.

## Creating a breakpoint GRanges object

```
library(StructuralVariantAnnotation)
vcf <- VariantAnnotation::readVcf(system.file("extdata", "gridss.vcf", package = "StructuralVariantAnnotation"))
gr <- breakpointRanges(vcf)
```

`partner()` returns the breakpoint `GRanges` object with the order rearranged such that the partner breakend on the other side of each breakpoint corresponds with the local breakend.

```
partner(gr)
#> GRanges object with 4 ranges and 13 metadata columns:
#>             seqnames    ranges strand | paramRangeID         REF
#>                <Rle> <IRanges>  <Rle> |     <factor> <character>
#>    gridss2h    chr12  84963533      - |           NA           G
#>   gridss39h    chr12   4886681      + |           NA           T
#>   gridss39o    chr12     84350      - |           NA           G
#>    gridss2o     chr1  18992158      + |           NA           C
#>                            ALT      QUAL                 FILTER    sourceId
#>                    <character> <numeric>            <character> <character>
#>    gridss2h  ]chr1:18992158]AG     55.00 LOW_QUAL;SINGLE_ASSE..    gridss2h
#>   gridss39h     T[chr12:84350[    627.96                      .   gridss39h
#>   gridss39o   ]chr12:4886681]G    627.96                      .   gridss39o
#>    gridss2o CA[chr12:84963533[     55.00 LOW_QUAL;SINGLE_ASSE..    gridss2o
#>                 partner      svtype     svLen      insSeq    insLen       event
#>             <character> <character> <numeric> <character> <integer> <character>
#>    gridss2h    gridss2o         BND        NA           A         1     gridss2
#>   gridss39h   gridss39o         BND   4802330                     0    gridss39
#>   gridss39o   gridss39h         BND   4802330                     0    gridss39
#>    gridss2o    gridss2h         BND        NA           A         1     gridss2
#>                HOMLEN
#>             <numeric>
#>    gridss2h         0
#>   gridss39h         0
#>   gridss39o         0
#>    gridss2o         0
#>   -------
#>   seqinfo: 84 sequences from an unspecified genome
```

Single breakends are loaded using the `breakendRanges()` function. The `GRanges` object is of the same form as `breakpointRanges()` but as the breakend partner is not specified, the partner is NA. A single GRanges object can contain both breakend and breakpoint variants.

```
colo829_vcf <- VariantAnnotation::readVcf(system.file("extdata", "COLO829T.purple.sv.ann.vcf.gz", package = "StructuralVariantAnnotation"))
colo829_bpgr <- breakpointRanges(colo829_vcf)
colo829_begr <- breakendRanges(colo829_vcf)
colo829_gr <- sort(c(colo829_begr, colo829_bpgr))
colo829_gr[seqnames(colo829_gr) == "6"]
#> GRanges object with 10 ranges and 13 metadata columns:
#>                    seqnames              ranges strand | paramRangeID
#>                       <Rle>           <IRanges>  <Rle> |     <factor>
#>     gridss36_2106o        6            26194117      + |           NA
#>     gridss36_2106h        6            26194406      + |           NA
#>   gridss37_233635b        6            65298376      + |           NA
#>    gridss38_18403o        6   94917253-94917268      + |           NA
#>      gridss40_299o        6 138774180-138774182      + |           NA
#>     gridss41_7816o        6 168570432-168570448      + |           NA
#>    gridss17_45233h        6   26194039-26194041      - |           NA
#>    gridss38_18403h        6   94917320-94917335      - |           NA
#>    gridss40_35285o        6           138774059      - |           NA
#>     gridss41_7816h        6 168570465-168570481      - |           NA
#>                            REF                    ALT      QUAL      FILTER
#>                    <character>            <character> <numeric> <character>
#>     gridss36_2106o           G          G]6:26194406]   2500.79        PASS
#>     gridss36_2106h           A          A]6:26194117]   2500.79        PASS
#>   gridss37_233635b           G GTGTTTTTTTCTCTGTGTTG..   2871.65        PASS
#>    gridss38_18403o           T          T[6:94917327[    411.40         PON
#>      gridss40_299o           T         T]15:23712618]   3009.75        PASS
#>     gridss41_7816o           G         G[6:168570473[   4495.46         PON
#>    gridss17_45233h           A          [3:26431918[A   3842.54        PASS
#>    gridss38_18403h           T          ]6:94917260]T    411.40         PON
#>    gridss40_35285o           T [15:23717166[GTATATT..   2213.96        PASS
#>     gridss41_7816h           T         ]6:168570440]T   4495.46         PON
#>                            sourceId      svtype     svLen
#>                         <character> <character> <numeric>
#>     gridss36_2106o   gridss36_2106o         BND       288
#>     gridss36_2106h   gridss36_2106h         BND       288
#>   gridss37_233635b gridss37_233635b         BND        NA
#>    gridss38_18403o  gridss38_18403o         BND       -66
#>      gridss40_299o    gridss40_299o         BND        NA
#>     gridss41_7816o   gridss41_7816o         BND       -32
#>    gridss17_45233h  gridss17_45233h         BND        NA
#>    gridss38_18403h  gridss38_18403h         BND       -66
#>    gridss40_35285o  gridss40_35285o         BND        NA
#>     gridss41_7816h   gridss41_7816h         BND       -32
#>                                    insSeq    insLen           event    HOMLEN
#>                               <character> <integer>     <character> <numeric>
#>     gridss36_2106o                                0   gridss36_2106         0
#>     gridss36_2106h                                0   gridss36_2106         0
#>   gridss37_233635b TGTTTTTTTCTCTGTGTTGT..       683 gridss37_233635         0
#>    gridss38_18403o                                0  gridss38_18403        15
#>      gridss40_299o                                0    gridss40_299         2
#>     gridss41_7816o                                0   gridss41_7816        16
#>    gridss17_45233h                                0  gridss17_45233         2
#>    gridss38_18403h                                0  gridss38_18403        15
#>    gridss40_35285o             GTATATTATC        10  gridss40_35285         0
#>     gridss41_7816h                                0   gridss41_7816        16
#>                            partner
#>                        <character>
#>     gridss36_2106o  gridss36_2106h
#>     gridss36_2106h  gridss36_2106o
#>   gridss37_233635b            <NA>
#>    gridss38_18403o gridss38_18403h
#>      gridss40_299o   gridss40_299h
#>     gridss41_7816o  gridss41_7816h
#>    gridss17_45233h gridss17_45233o
#>    gridss38_18403h gridss38_18403o
#>    gridss40_35285o gridss40_35285h
#>     gridss41_7816h  gridss41_7816o
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome
```

### Ensuring breakpoint consistency

Functions such as `findBreakpointOverlaps()` require the `GRanges` object to be consistent. Subsetting a breakpoint `GRanges` object can result in one side of a breakpoint getting filtered with the remaining orphaned record no longer valid as its partner no longer exists. Such records need to be be filtered

```
colo828_chr6_breakpoints <- colo829_gr[seqnames(colo829_gr) == "6"]
# A call to findBreakpointOverlaps(colo828_chr6_breakpoints, colo828_chr6_breakpoints)
# will fail as there are a) single breakends, and b) breakpoints with missing partners
colo828_chr6_breakpoints <- colo828_chr6_breakpoints[hasPartner(colo828_chr6_breakpoints)]
# As expected, each call on chr6 only overlaps with itself
countBreakpointOverlaps(colo828_chr6_breakpoints, colo828_chr6_breakpoints)
#> [1] 1 1 1 1 1 1
```

Note that if you did want to include inter-chromosomal breakpoints involving chromosome 6, you would need to update the filtering criteria to include records with chr6 on either side. In such cases, the filtering logic can be simplified by the `selfPartnerSingleBreakends` parameter of `partner()`. When `selfPartnerSingleBreakends=TRUE`, the partner of single breakend events is considered to be the single breakend itself.

```
colo828_chr6_breakpoints <- colo829_gr[
  seqnames(colo829_gr) == "6" |
    seqnames(partner(colo829_gr, selfPartnerSingleBreakends=TRUE)) == "6"]
# this way we keep the chr3<->chr6 breakpoint and don't create any orphans
head(colo828_chr6_breakpoints, 1)
#> GRanges object with 1 range and 13 metadata columns:
#>                   seqnames            ranges strand | paramRangeID         REF
#>                      <Rle>         <IRanges>  <Rle> |     <factor> <character>
#>   gridss17_45233o        3 26431917-26431919      - |           NA           T
#>                             ALT      QUAL      FILTER        sourceId
#>                     <character> <numeric> <character>     <character>
#>   gridss17_45233o [6:26194040[T   3882.79        PASS gridss17_45233o
#>                        svtype     svLen      insSeq    insLen          event
#>                   <character> <numeric> <character> <integer>    <character>
#>   gridss17_45233o         BND        NA                     0 gridss17_45233
#>                      HOMLEN         partner
#>                   <numeric>     <character>
#>   gridss17_45233o         2 gridss17_45233h
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome
```

### Breakpoint Overlaps

`findBreakpointOverlaps()` and `countBreakpointOverlaps()` are functions for finding and counting overlaps between breakpoint objects. All breakends must have their partner breakend included in the GRanges. A valid overlap requires that breakends on boths sides overlap.

To demonstrate the `countBreakpointOverlaps()` function, we use a small subset of data from our structural variant caller benchmarking paper to construct precision recall curves for a pair of callers.

```
truth_vcf <- readVcf(system.file("extdata", "na12878_chr22_Sudmunt2015.vcf", package = "StructuralVariantAnnotation"))
truth_svgr <- breakpointRanges(truth_vcf)
truth_svgr <- truth_svgr[seqnames(truth_svgr) == "chr22"]
crest_vcf <- readVcf(system.file("extdata", "na12878_chr22_crest.vcf", package = "StructuralVariantAnnotation"))
# Some SV callers don't report QUAL so we need to use a proxy
VariantAnnotation::fixed(crest_vcf)$QUAL <- info(crest_vcf)$left_softclipped_read_count + info(crest_vcf)$left_softclipped_read_count
crest_svgr <- breakpointRanges(crest_vcf)
crest_svgr$caller <- "crest"
hydra_vcf <- readVcf(system.file("extdata", "na12878_chr22_hydra.vcf", package = "StructuralVariantAnnotation"))
hydra_svgr <- breakpointRanges(hydra_vcf)
hydra_svgr$caller <- "hydra"
svgr <- c(crest_svgr, hydra_svgr)
svgr$truth_matches <- countBreakpointOverlaps(svgr, truth_svgr,
  # read pair based callers make imprecise calls.
  # A margin around the call position is required when matching with the truth set
  maxgap=100,
  # Since we added a maxgap, we also need to restrict the mismatch between the
  # size of the events. We don't want to match a 100bp deletion with a
  # 5bp duplication. This will happen if we have a 100bp margin but don't also
  # require an approximate size match as well
  sizemargin=0.25,
  # We also don't want to match a 20bp deletion with a 20bp deletion 80bp away
  # by restricting the margin based on the size of the event, we can make sure
  # that simple events actually do overlap
  restrictMarginToSizeMultiple=0.5,
  # HYDRA makes duplicate calls and will sometimes report a variant multiple
  # times with slightly different bounds. countOnlyBest prevents these being
  # double-counted as multiple true positives.
  countOnlyBest=TRUE)
```

Once we know which calls match the truth set, we can generate Precision-Recall and ROC curves for each caller using one of the many ROC R packages, or directly with dplyr.

```
suppressPackageStartupMessages(require(dplyr))
suppressPackageStartupMessages(require(ggplot2))
ggplot(as.data.frame(svgr) %>%
  dplyr::select(QUAL, caller, truth_matches) %>%
  dplyr::group_by(caller, QUAL) %>%
  dplyr::summarise(
    calls=dplyr::n(),
    tp=sum(truth_matches > 0)) %>%
  dplyr::group_by(caller) %>%
  dplyr::arrange(dplyr::desc(QUAL)) %>%
  dplyr::mutate(
    cum_tp=cumsum(tp),
    cum_n=cumsum(calls),
    cum_fp=cum_n - cum_tp,
    Precision=cum_tp / cum_n,
    Recall=cum_tp/length(truth_svgr))) +
  aes(x=Recall, y=Precision, colour=caller) +
  geom_point() +
  geom_line() +
  labs(title="NA12878 chr22 CREST and HYDRA\nSudmunt 2015 truth set")
#> `summarise()` has grouped output by 'caller'. You can override using the
#> `.groups` argument.
```

![](data:image/png;base64...)

## Equivalent variants

Converting to a breakpoint-centric notation does not fully resolve the problem of identical variants reported in different VCF notations. There are two additional commonly encountered notations that required additional handling, especially when comparing short and long read caller variant calls.

### Insertion - Duplication equivalence

Tandem duplications under 1,000bp are usually reported as insertion events by long read callers, but as duplication events by short read caller. These notations are equivalent but typical variant comparisons such as `findBreakpointOverlaps()` will not match these variants. The `findInsDupOverlaps()` function can be used to identify duplications and insertions that are equivalent.

### Transitive breakpoints

Transitive breakpoints are breakpoints that can be explained by multiple breakpoints. Identifying transitive breakpoints is important not only for matching short and long read call sets but also for the correct downstream interpretation of genomic rearrangements. Call sets that contain both transitive breakpoints and their constituent breakpoints are internally inconsistent which in turn causes incorrect downstream karyotype reconstructions.

There are two type of transitive breakpoints:

* Imprecise breakpoints that span one or more small DNA fragments.

For example If DNA segments A, B, C are rearranged in an A-B-C configuration and the B segment is short, a short read caller may report an A-C breakpoints. This imprecise A-C breakpoint supported only by read pairs, can be explained by the precise A-B and B-C breakpoints.

* Precise breakpoints with breakpoint inserted sequence

These are similar in form to imprecise breakpoints in that a complex A-B-C rearrangement is reported as an A-C breakpoint. The different between imprecise and precise transitive breakpoints is that for precise breakpoints, the B segments is not missing, but is reported as inserted sequence between the breakpoints. This is a relatively common occurrence in long read call sets as long read aligners are unable to place short DNA segments due to the high indel error rate of long read calling.

For example, NanoSV calling of Nanopore sequencing of the COLO829 cell line, results in multiple transitive SV calls:

```
colo829_truth_bpgr  <- breakpointRanges(readVcf(system.file("extdata", "truthset_somaticSVs_COLO829.vcf", package = "StructuralVariantAnnotation")))
colo829_nanosv_bpgr <- breakpointRanges(readVcf(system.file("extdata", "colo829_nanoSV_truth_overlap.vcf", package = "StructuralVariantAnnotation")), inferMissingBreakends=TRUE, ignoreUnknownSymbolicAlleles=TRUE)
findTransitiveCalls(colo829_nanosv_bpgr, colo829_truth_bpgr)
#> DataFrame with 4 rows and 4 columns
#>   transitive_breakpoint_name total_distance  traversed_breakpoint_names
#>                  <character>      <integer>             <CharacterList>
#> 1                    2294973            200 truthset_52_1,truthset_53_2
#> 2                    5621450            184  truthset_43_1,truthset_7_2
#> 3            svrecord102_bp2            200 truthset_53_1,truthset_52_2
#> 4            svrecord149_bp2            184  truthset_7_1,truthset_43_2
#>   distance_to_traversed_breakpoint
#>                      <IntegerList>
#> 1                            0,200
#> 2                            0,184
#> 3                            0,200
#> 4                            0,184
```

Note that since `StructuralVariantAnnotation` treats both breakends equally, each transitive path will have two results. One for the path traversing from one breakend, another for the traversal in the opposite direction.

## Converting between BEDPE, Pairs, and breakpoint GRanges

The package supports converting GRanges objects to BEDPE files. The BEDPE format is defined by [`bedtools`](https://bedtools.readthedocs.io/en/latest/content/general-usage.html). This is achieved using `breakpointgr2pairs` and `pairs2breakpointgr` functions to convert to and from the GRanges `Pairs` notation used by `rtracklayer`.

```
suppressPackageStartupMessages(require(rtracklayer))
# Export to BEDPE
rtracklayer::export(breakpointgr2pairs(gr), con="example.bedpe")

# Import to BEDPE
bedpe.gr  <- pairs2breakpointgr(rtracklayer::import("example.bedpe"))
```

## Visualising breakpoint pairs via circos plots

One way of visualising paired breakpoints is by circos plots.

Here, we use the plotting package `ggbio` which provides flexible track functions which bind with `ggplot2` objects. It takes `GRanges` objects as input and supports circos plots. To plot structural variant breakpoints in a circos plot using `ggbio`, we need to first prepare the breakpoint GRanges. The function requires a special column, indicating the end of the link using GRanges format.

```
suppressPackageStartupMessages(require(ggbio))
gr.circos <- colo829_bpgr[seqnames(colo829_bpgr) %in% seqlevels(biovizBase::hg19sub)]
seqlevels(gr.circos) <- seqlevels(biovizBase::hg19sub)
mcols(gr.circos)$to.gr <- granges(partner(gr.circos))
```

We can then plot the breakpoints against reference genomes.

```
p <- ggbio() +
    circle(gr.circos, geom="link", linked.to="to.gr") +
    circle(biovizBase::hg19sub, geom='ideo', fill='gray70') +
    circle(biovizBase::hg19sub, geom='scale', size=2) +
    circle(biovizBase::hg19sub, geom='text', aes(label=seqnames), vjust=0, size=3)
#> Warning in recycleSingleBracketReplacementValue(value, x, nsbs): number of
#> values supplied is not a sub-multiple of the number of values to be replaced
p
```

![](data:image/png;base64...)

## SessionInfo

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] ggbio_1.58.0                       ggplot2_4.0.0
#>  [3] dplyr_1.1.4                        StructuralVariantAnnotation_1.26.0
#>  [5] VariantAnnotation_1.56.0           Rsamtools_2.26.0
#>  [7] Biostrings_2.78.0                  XVector_0.50.0
#>  [9] SummarizedExperiment_1.40.0        Biobase_2.70.0
#> [11] MatrixGenerics_1.22.0              matrixStats_1.5.0
#> [13] rtracklayer_1.70.0                 GenomicRanges_1.62.0
#> [15] Seqinfo_1.0.0                      IRanges_2.44.0
#> [17] S4Vectors_0.48.0                   BiocGenerics_0.56.0
#> [19] generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3                bitops_1.0-9             RBGL_1.86.0
#>  [4] gridExtra_2.3            rlang_1.1.6              magrittr_2.0.4
#>  [7] biovizBase_1.58.0        compiler_4.5.1           RSQLite_2.4.3
#> [10] GenomicFeatures_1.62.0   png_0.1-8                vctrs_0.6.5
#> [13] reshape2_1.4.4           ProtGenerics_1.42.0      stringr_1.5.2
#> [16] pwalign_1.6.0            pkgconfig_2.0.3          crayon_1.5.3
#> [19] fastmap_1.2.0            backports_1.5.0          labeling_0.4.3
#> [22] rmarkdown_2.30           graph_1.88.0             UCSC.utils_1.6.0
#> [25] bit_4.6.0                xfun_0.53                cachem_1.1.0
#> [28] cigarillo_1.0.0          GenomeInfoDb_1.46.0      jsonlite_2.0.0
#> [31] blob_1.2.4               DelayedArray_0.36.0      BiocParallel_1.44.0
#> [34] parallel_4.5.1           cluster_2.1.8.1          R6_2.6.1
#> [37] bslib_0.9.0              stringi_1.8.7            RColorBrewer_1.1-3
#> [40] rpart_4.1.24             jquerylib_0.1.4          Rcpp_1.1.0
#> [43] assertthat_0.2.1         knitr_1.50               base64enc_0.1-3
#> [46] Matrix_1.7-4             nnet_7.3-20              tidyselect_1.2.1
#> [49] rstudioapi_0.17.1        dichromat_2.0-0.1        abind_1.4-8
#> [52] yaml_2.3.10              codetools_0.2-20         curl_7.0.0
#> [55] lattice_0.22-7           tibble_3.3.0             plyr_1.8.9
#> [58] withr_3.0.2              KEGGREST_1.50.0          S7_0.2.0
#> [61] evaluate_1.0.5           foreign_0.8-90           BiocManager_1.30.26
#> [64] pillar_1.11.1            checkmate_2.3.3          OrganismDbi_1.52.0
#> [67] RCurl_1.98-1.17          ensembldb_2.34.0         scales_1.4.0
#> [70] glue_1.8.0               lazyeval_0.2.2           Hmisc_5.2-4
#> [73] tools_4.5.1              BiocIO_1.20.0            data.table_1.17.8
#> [76] BSgenome_1.78.0          GenomicAlignments_1.46.0 XML_3.99-0.19
#> [79] grid_4.5.1               colorspace_2.1-2         AnnotationDbi_1.72.0
#> [82] htmlTable_2.4.3          restfulr_0.0.16          Formula_1.2-5
#> [85] cli_3.6.5                S4Arrays_1.10.0          AnnotationFilter_1.34.0
#> [88] gtable_0.3.6             sass_0.4.10              digest_0.6.37
#> [91] SparseArray_1.10.0       rjson_0.2.23             htmlwidgets_1.6.4
#> [94] farver_2.1.2             memoise_2.0.1            htmltools_0.5.8.1
#> [97] lifecycle_1.0.4          httr_1.4.7               bit64_4.6.0-1
```