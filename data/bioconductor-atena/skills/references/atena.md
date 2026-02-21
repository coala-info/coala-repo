# An introduction to the atena package

Beatriz Calvo-Serra1\* and Robert Castelo1\*\*

1Dept. of Experimental and Health Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*beatriz.calvo@upf.edu
\*\*robert.castelo@upf.edu

#### 4 December 2025

#### Abstract

The `atena` package provides methods to quantify the expression of transposable elements within R and Bioconductor.

#### Package

atena 1.16.1

# 1 What are transposable elements

Transposable elements (TEs) are autonomous mobile genetic elements. They are
DNA sequences that have, or once had, the ability to mobilize within the genome
either directly or through an RNA intermediate (Payer and Burns [2019](#ref-payer2019transposable)). TEs
can be categorized into two classes based on the intermediate substrate
propagating insertions (RNA or DNA). Class I TEs, also called retrotransposons,
first transcribe an RNA copy that is then reverse transcribed to cDNA before
inserting in the genome. In turn, these can be divided into long terminal repeat
(LTR) retrotransposons, which refer to endogenous retroviruses (ERVs), and
non-LTR retrotransposons, which include long interspersed element class 1
(LINE-1 or L1) and short interspersed elements (SINEs). Class II TEs, also known
as DNA transposons, directly excise themselves from one location before
reinsertion. TEs are further split into families and subfamilies depending on
various structural features (Goerner-Potvin and Bourque [2018](#ref-goerner2018computational); Guffanti et al. [2018](#ref-guffanti2018novel)).

Most TEs have lost the capacity for generating new insertions over their
evolutionary history and are now fixed in the human population. Their insertions
have resulted in a complex distribution of interspersed repeats comprising
almost half (50%) of the human genome (Payer and Burns [2019](#ref-payer2019transposable)).

TE expression has been observed in association with physiological processes in
a wide range of species, including humans where it has been described to be
important in early embryonic pluripotency and development. Moreover, aberrant TE
expression has been associated with diseases such as cancer, neurodegenerative
disorders, and infertility (Payer and Burns [2019](#ref-payer2019transposable)).

# 2 Currently available methods for quantifying TE expression

The study of TE expression faces one main challenge: given their repetitive
nature, the majority of TE-derived reads map to multiple regions of the genome
and these multi-mapping reads are consequently discarded in standard RNA-seq
data processing pipelines. For this reason, specific software packages for the
quantification of TE expression have been developed (Goerner-Potvin and Bourque [2018](#ref-goerner2018computational)),
such as TEtranscripts (Jin et al. [2015](#ref-jin2015tetranscripts)), ERVmap (Tokuyama et al. [2018](#ref-tokuyama2018ervmap)) and
Telescope (Bendall et al. [2019](#ref-bendall2019telescope)). The main differences between these three
methods are the following:

* [TEtranscripts](https://github.com/mhammell-laboratory/TEtranscripts)
  (Jin et al. [2015](#ref-jin2015tetranscripts)) reassigns multi-mapping reads to TEs proportionally
  to their relative abundance, which is estimated using an
  expectation-maximization (EM) algorithm.
* [ERVmap](https://github.com/mtokuyama/ERVmap) (Tokuyama et al. [2018](#ref-tokuyama2018ervmap)) is based
  on selective filtering of multi-mapping reads. It applies filters that consist
  in discarding reads when the ratio of sum of hard and soft clipping to the
  length of the read (base pair) is greater than or equal to 0.02, the ratio of
  the edit distance to the sequence read length (base pair) is greater or equal
  to 0.02 and/or the difference between the alignment score from BWA (field AS)
  and the suboptimal alignment score from BWA (field XS) is less than 5.
* [Telescope](https://github.com/mlbendall/telescope) (Bendall et al. [2019](#ref-bendall2019telescope))
  reassigns multi-mapping reads to TEs using their relative abundance, which
  like in TEtranscripts, is also estimated using an EM algorithm. The main
  differences with respect to TEtranscripts are: (1) Telescope works with an
  additional parameter for each TE that estimates the proportion of
  multi-mapping reads that need to be reassigned to that TE; (2) that
  reassignment parameter is optimized during the EM algorithm jointly with the
  TE relative abundances, using a Bayesian maximum a posteriori (MAP) estimate
  that allows one to use prior values on these two parameters; and (3) using
  the final estimates on these two parameters, multi-mapping reads can be
  flexibly reassigned to TEs using different strategies, where the default one
  is to assign a multi-mapping read to the TE with largest estimated abundance
  and discard those multi-mapping reads with ties on those largest abundances.

Because these tools were only available outside R and Bioconductor, the `atena`
package provides a complete re-implementation in R of these three methods to
facilitate the integration of TE expression quantification into Bioconductor
workflows for the analysis of RNA-seq data.

# 3 TEs annotations

Another challenge in TE expression quantification is the lack of complete TE
annotations due to the difficulty to correctly place TEs in genome assemblies
(Goerner-Potvin and Bourque [2018](#ref-goerner2018computational)). One of the main sources of TE annotations are
RepeatMasker annotations, available for instance at the RepeatMasker track of
the UCSC Genome Browser. `atena` can fetch RepeatMasker annotations with the
function `annotaTEs()` and flexibly parse them by using a parsing function
provided through the parameter `parsefun`. Examples of `parsefun` included in
`atena` are:

* `rmskidentity()`: returns RepeatMasker annotations without any modification.
* `rmskbasicparser()`: filters out non-TE repeats and elements without strand
  information from RepeatMasker annotations. Then assigns a unique id to each
  elements based on their repeat name.
* `OneCodeToFindThemAll()`: implementation of the “One Code To Find Them All”
  algorithm by Bailly-Bechet, Haudry, and Lerat ([2014](#ref-bailly2014one)), for parsing RepeatMasker output files.
* `rmskatenaparser()`: attempts to reconstruct fragmented TEs by assembling
  together fragments from the same TE that are close enough. For LTR class TEs,
  tries to reconstruct full-length and partial TEs following the LTR - internal
  region - LTR structure.

Both, the `rmskatenaparser()` and `OneCodeToFindThemAll()` parser functions
attempt to address the annotation fragmentation present in the output files of
the RepeatMasker software (i.e. presence of multiple hits, such as
homology-based matches, corresponding to a unique copy of an element). This is
highly frequent for TEs of the LTR class, where the consensus sequences are
split separately into the LTR and internal regions, causing RepeatMasker to
also report these two regions of the TE as two separate elements. These two
functions try to identify these and other cases of fragmented annotations and
assemble them together into single elements. To do so, the assembled elements
must satisfy certain criteria. These two parser functions differ in those
criteria, as well as in the approach for finding equivalences between LTR and
internal regions to reconstruct LTR retrotransposons. The `rmskatenaparser()`
function is also much faster than `OneCodeToFindThemAll()`.

## 3.1 Retrieving and parsing TE annotations

As an example, let’s retrieve TE annotations for *Drosophila melanogaster*
*dm6* genome version. By setting `rmskidentity()` as argument to the
`parsefun` parameter, RepeatMasker annotations are retrieved intact as a
`GRanges` object.

```
library(atena)
library(BiocParallel)

rmskann <- annotaTEs(genome="dm6", parsefun=rmskidentity)
rmskann
GRanges object with 137555 ranges and 11 metadata columns:
                   seqnames    ranges strand |   swScore  milliDiv  milliDel
                      <Rle> <IRanges>  <Rle> | <integer> <numeric> <numeric>
       [1]            chr2L     2-154      + |       778       167         7
       [2]            chr2L   313-408      + |       296       174       207
       [3]            chr2L   457-612      + |       787       170         7
       [4]            chr2L   771-866      + |       296       174       207
       [5]            chr2L  915-1070      + |       787       170         7
       ...              ...       ...    ... .       ...       ...       ...
  [137551] chrUn_DS486004v1    99-466      - |      3224        14         0
  [137552] chrUn_DS486005v1    1-1001      + |       930        48         0
  [137553] chrUn_DS486008v1     1-488      + |      4554         0         0
  [137554] chrUn_DS486008v1   489-717      - |      2107         9         0
  [137555] chrUn_DS486008v1  717-1001      - |      2651         3         0
            milliIns  genoLeft      repName      repClass     repFamily
           <numeric> <integer>  <character>   <character>   <character>
       [1]        20 -23513558     HETRP_DM     Satellite     Satellite
       [2]        42 -23513304     HETRP_DM     Satellite     Satellite
       [3]        19 -23513100     HETRP_DM     Satellite     Satellite
       [4]        42 -23512846     HETRP_DM     Satellite     Satellite
       [5]        19 -23512642     HETRP_DM     Satellite     Satellite
       ...       ...       ...          ...           ...           ...
  [137551]         3      -535 ROVER-LTR_DM           LTR         Gypsy
  [137552]         1         0  (TATACATA)n Simple_repeat Simple_repeat
  [137553]         0      -513    NOMAD_LTR           LTR         Gypsy
  [137554]         0      -284   ACCORD_LTR           LTR         Gypsy
  [137555]         0         0       DMRT1A          LINE            R1
            repStart    repEnd   repLeft
           <integer> <integer> <integer>
       [1]      1519      1669      -203
       [2]      1519      1634      -238
       [3]      1516      1669      -203
       [4]      1519      1634      -238
       [5]      1516      1669      -203
       ...       ...       ...       ...
  [137551]         0       367         1
  [137552]         1      1000         0
  [137553]        31       518         0
  [137554]      -123       435       207
  [137555]         0      5183      4899
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome
```

We can see that we obtained annotations for 137555 elements. Now,
let’s fetch the same RepeatMasker annotations, but process them using the
`OneCodeToFindThemAll` parser function (Bailly-Bechet, Haudry, and Lerat [2014](#ref-bailly2014one)). We set the parameter
`strict=FALSE` to avoid applying a filter of minimum 80% identity with the
consensus sequence and minimum 80 bp length. The `insert` parameter is set to
500, meaning that two elements with the same name are merged if they are closer
than 500 bp in the annotations. The `BPPARAM` parameter allows one to run
calculations in parallel using the functionality of the
[BiocParallel](https://bioconductor.org/packages/BiocParallel) Bioconductor
package. In this particular example, we are setting the `BPPARAM` parameter
to `SerialParam(progress=FALSE)` to disable parallel calculations and progress
reporting, but a common setting if we want to run calculations in parallel
would be `BPPARAM=Multicore(workers=ncores, progress=TRUE)`, which would use
`ncores` parallel threads of execution and report progress on the calculations.

```
teann <- annotaTEs(genome="dm6", parsefun=OneCodeToFindThemAll, strict=FALSE,
                   insert=500, BPPARAM=SerialParam(progress=FALSE))
length(teann)
[1] 22538
teann[1]
GRangesList object of length 1:
$IDEFIX_LTR.1
GRanges object with 1 range and 11 metadata columns:
      seqnames    ranges strand |   swScore  milliDiv  milliDel  milliIns
         <Rle> <IRanges>  <Rle> | <integer> <numeric> <numeric> <numeric>
  [1]    chr2L 9726-9859      + |       285       235        64        15
       genoLeft     repName    repClass   repFamily  repStart    repEnd
      <integer> <character> <character> <character> <integer> <integer>
  [1] -23503853  IDEFIX_LTR         LTR       Gypsy       425       565
        repLeft
      <integer>
  [1]        29
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome
```

As expected, we get a lower number of elements in the annotations, because
repeats that are not TEs have been removed. Furthermore, some fragmented
regions of TEs have been assembled together.

This time, the resulting `teann` object is of class `GRangesList`. Each
element of the list represents an assembled TE containing a `GRanges` object of
length one, if the TE could not be not assembled with another element, or of
length greater than one, if two or more fragments were assembled together into a
single TE.

We can get more information of the parsed annotations by accessing the
metadata columns with `mcols()`:

```
mcols(teann)
DataFrame with 22538 rows and 3 columns
                               Status RelLength       Class
                          <character> <numeric> <character>
IDEFIX_LTR.1                      LTR  0.225589         LTR
DNAREP1_DM.2                    noLTR  0.419192         DNA
LINEJ1_DM.3                     noLTR  0.997211        LINE
DNAREP1_DM.4                    noLTR  0.861953         DNA
BS2.5                           noLTR  0.126880        LINE
...                               ...       ...         ...
QUASIMODO_I-int.22534           noLTR 0.0882838         LTR
ROVER-I_DM.22535      partialLTR_down 0.0636786         LTR
NOMAD_LTR.22536                 noLTR 0.9420849         LTR
ACCORD_LTR.22537                noLTR 0.4103943         LTR
DMRT1A.22538                    noLTR 0.0549875        LINE
```

There is information about the reconstruction status of the TE (*Status*
column), the relative length of the reconstructed TE (*RelLength*) and the
repeat class of the TE (*Class*). The relative length is calculated by adding
the length (in base pairs) of all fragments from the same assembled TE, and
dividing that sum by the length (in base pairs) of the consensus sequence. For
full-length and partially reconstructed LTR TEs, the consensus sequence length
used is the one resulting from adding twice the consensus sequence length of
the long terminal repeat (LTR) and the one from the corresponding internal
region. For solo-LTRs, the consensus sequence length of the long terminal
repeat is used.

We can get an insight into the composition of the assembled annotations using
the information from the *status* column. Let’s look at the absolute
frequencies of the status and class of TEs in the annotations.

![Composition of parsed TE annotations.](data:image/png;base64...)

Figure 1: Composition of parsed TE annotations

Here, *full-lengthLTR* are reconstructed LTR retrotransposons following the
LTR - internal region (int) - LTR structure. Partially reconstructed LTR TEs
are *partialLTR\_down* (internal region followed by a downstream LTR) and
*partialLTR\_up* (LTR upstream of an internal region). *int* and *LTR*
correspond to internal and solo-LTR regions, respectively. Finally, the
*noLTR* refers to TEs of other classes (not LTR), as well as TEs of class LTR
which could not be identified as either internal or long terminal repeat
regions based on their name.

Moreover, the `atena` package provides getter functions to retrieve TEs of a
specific class, using a specific relative length threshold. Those TEs with
higher relative lengths are more likely to have intact open reading frames,
making them more interesting for expression quantification and functional
analyses. For example, to get LINEs with a minimum of 0.9 relative length, we
can use the `getLINEs()` function. We use the TE annotations in `teann` we
obtained before and set the `relLength` to 0.9.

```
rmskLINE <- getLINEs(teann, relLength=0.9)
length(rmskLINE)
[1] 355
rmskLINE[1]
GRangesList object of length 1:
$LINEJ1_DM.3
GRanges object with 1 range and 11 metadata columns:
      seqnames      ranges strand |   swScore  milliDiv  milliDel  milliIns
         <Rle>   <IRanges>  <Rle> | <integer> <numeric> <numeric> <numeric>
  [1]    chr2L 47514-52519      + |     43674         5         0         0
       genoLeft     repName    repClass   repFamily  repStart    repEnd
      <integer> <character> <character> <character> <integer> <integer>
  [1] -23461193   LINEJ1_DM        LINE      Jockey         2      5007
        repLeft
      <integer>
  [1]        13
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome
```

To get LTR retrotransposons, we can use the function `getLTRs()`. This function
also allows to get one or more specific types of reconstructed TEs. To get
full-length, partial LTRs and other fragments that could not be reconstructed,
we can:

```
rmskLTR <- getLTRs(teann, relLength=0.8, fullLength=TRUE, partial=TRUE,
                   otherLTR=TRUE)
length(rmskLTR)
[1] 1408
rmskLTR[1]
GRangesList object of length 1:
$`ROO_I-int.11`
GRanges object with 4 ranges and 11 metadata columns:
      seqnames        ranges strand |   swScore  milliDiv  milliDel  milliIns
         <Rle>     <IRanges>  <Rle> | <integer> <numeric> <numeric> <numeric>
  [1]    chr2L 976935-977362      + |      3968         5         0         0
  [2]    chr2L 977363-983449      + |     54257         1        13         1
  [3]    chr2L 983448-984084      + |      5412         5        19         0
  [4]    chr2L 984085-984512      + |      3968         5         0         0
       genoLeft     repName    repClass   repFamily  repStart    repEnd
      <integer> <character> <character> <character> <integer> <integer>
  [1] -22536350     ROO_LTR         LTR         Pao         1       428
  [2] -22530263   ROO_I-int         LTR         Pao         1      6166
  [3] -22529628   ROO_I-int         LTR         Pao      7608      8256
  [4] -22529200     ROO_LTR         LTR         Pao         1       428
        repLeft
      <integer>
  [1]         0
  [2]      2090
  [3]         0
  [4]         0
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome
```

To obtain DNA transposons and SINEs, one can use the `getDNAtransposons()` and
`getSINEs()` functions, respectively.

# 4 TE expression quantification

Quantification of TE expression with `atena` consists in the following two
steps:

1. Building of a parameter object for one of the available quantification
   methods.
2. Calling the TE expression quantification method `qtex()` using the
   previously built parameter object.

The dataset that will be used to illustrate how to quantify TE expression with
`atena` is a published RNA-seq dataset of *Drosophila melanogaster* available
at the National Center for Biotechnology Information (NCBI) Gene Expression
Omnibus (GEO) under accession
[GSE47006](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE47006)).
The two selected samples are: a piwi knockdown and a piwi control (GSM1142845
and GSM1142844). These files have been subsampled. The piwi-associated
silencing complex (piRISC) silences TEs in the *Drosophila* ovary, hence the
knockdown of piwi causes the de-repression of TEs. Here we show how the
expression of full-length LTR retrotransposons present in `rmskLTR` can be
easily quantified using `atena`.

## 4.1 Building a parameter object

A parameter object is build calling a specific function for the quantification
method we want to use. Independenty of each method, all parameter object
constructor functions require that the first two arguments specify the BAM
files and the TE annotation, respectively.

### 4.1.1 ERVmap

To use the ERVmap method in `atena` we should first build an object of the
class `ERVmapParam` using the function `ERVmapParam()`. The `singleEnd`
parameter is set to `TRUE` since the example BAM files are single-end. The
`ignoreStrand` parameter works analogously to the same parameter in the
function `summarizeOverlaps()` from package *[GenomicAlignments](https://bioconductor.org/packages/3.22/GenomicAlignments)*
and should be set to `TRUE` whenever the RNA library preparation protocol was
stranded.

One of the filters applied by the ERVmap method compares the alignment score of
a given primary alignment, stored in the `AS` tag of a SAM record, to the
largest alignment score among every other secondary alignment, known as the
suboptimal alignment score. The original ERVmap software assumes that input BAM
files are generated using the Burrows-Wheeler Aligner (BWA) software
(Li and Durbin [2009](#ref-li2009fast)), which stores suboptimal alignment scores in the `XS` tag.
Although `AS` is an optional tag, most short-read aligners provide this tag
with alignment scores in BAM files. However, the suboptimal alignment score,
stored in the `XS` tag by BWA, is either stored in a different tag or not
stored at all by other short-read aligner software, such as STAR
(Dobin et al. [2013](#ref-dobin2013star)).

To enable using ERVmap on BAM files produced by short-read aligner software
other than BWA, `atena` allows the user to set the argument
`suboptimalAlignmentTag` to one of the following three possible values:

* The name of a tag different to `XS` that stores the suboptimal alignment
  score.
* The value “none”, which will trigger the calculation of the suboptimal
  alignment score by searching for the largest value stored in the `AS` tag
  among all available secondary alignments.
* The value “auto” (default), by which `atena` will first extract the name of
  the short-read aligner software from the BAM file and if that software is
  BWA, then suboptimal alignment scores will be obtained from the `XS` tag.
  Otherwise, it will trigger the calculation previously explained for
  `suboptimalAlignemntTag="none"`.

Finally, this filter is applied by comparing the difference between alignment
and suboptimal alignment scores to a cutoff value, which by default is 5 but
can be modified using the parameter `suboptimalAlignmentCutoff`. The default
value 5 is the one employed in the original ERVmap software that assumes the
BAM file was generated with BWA and for which lower values are interpreted as
“equivalent to second best match has one or more mismatches than the best
match” (Tokuyama et al. [2018](#ref-tokuyama2018ervmap), pg. 12571). From a different perspective, in BWA
the mismatch penalty has a value of 4 and therefore, a
`suboptimalAlignmentCutoff` value of 5 only retains those reads where the
suboptimal alignment has at least 1 mismatch more than the best match.
Therefore, the `suboptimalAlignmentCutoff` value is specific to the short-read
mapper software and we recommend to set this value according to the mismatch
penalty of that software. Another option is to set
`suboptimalAlignmentCutoff=NA`, which prevents the filtering of reads based on
this criteria, as set in the following example.

```
bamfiles <- list.files(system.file("extdata", package="atena"),
                       pattern="*.bam", full.names=TRUE)
empar <- ERVmapParam(bamfiles,
                     teFeatures=rmskLTR,
                     singleEnd=TRUE,
                     ignoreStrand=TRUE,
                     suboptimalAlignmentCutoff=NA)
ℹ Locating BAM files
ℹ Processing features
✔ Parameter object successfully created
empar
ERVmapParam object
# BAM files (2): control_KD.bam, piwi_KD.bam
# features (1408): ACCORD2_I-int.18752, ..., ZAM_LTR.21390
# single-end, unstranded
```

In the case of paired-end BAM files (`singleEnd=FALSE`), two additional
arguments can be specified, `strandMode` and `fragments`:

* `strandMode` defines the behavior of the strand getter when internally
  reading the BAM files with the `GAlignmentPairs()` function. See the help
  page of `strandMode` in the *[GenomicAlignments](https://bioconductor.org/packages/3.22/GenomicAlignments)* package for
  further details.
* `fragments` controls how read filtering and counting criteria are applied to
  the read mates in a paired-end read. To use the original ERVmap algorithm
  (Tokuyama et al. [2018](#ref-tokuyama2018ervmap)) one should set `fragments=TRUE` (default when
  `singleEnd=FALSE`), which filters and counts each mate of a paired-end read
  independently (i.e., two read mates overlapping the same feature count twice
  on that feature, treating paired-end reads as if they were single-end). On
  the other hand, when `fragments=FALSE`, if the two read mates pass the
  filtering criteria and overlap the same feature, they count once on that
  feature. If either read mate fails to pass the filtering criteria, then both
  read mates are discarded.

An additional functionality with respect to the original ERVmap software is the
integration of gene and TE expression quantification. The original ERVmap
software doesn’t quantify TE and gene expression coordinately and this can
potentially lead to counting twice reads that simultaneously overlap a gene and
a TE. In `atena`, gene expression is quantified based on the approach used in
the TEtranscripts software (Jin et al. [2015](#ref-jin2015tetranscripts)): unique reads are preferably
assigned to genes, whereas multi-mapping reads are preferably assigned to TEs.

In case that a unique read does not overlap a gene or a multi-mapping read does
not overlap a TE, `atena` searches for overlaps with TEs or genes,
respectively. Given the different treatment of unique and multi-mapping reads,
`atena` requires the information regarding the *unique* or *multi-mapping*
status of a read. This information is obtained from the presence of secondary
alignments in the BAM file or, alternatively, from the `NH` tag in the BAM file
(number of reported alignments that contain the query in the current SAM
record). Therefore, either secondary alignments or the `NH` tag need to be
present for gene expression quantification.

The original ERVmap approach does not discard any read overlapping gene
annotations. However, this can be changed using the parameter `geneCountMode`,
which by default `geneCountMode="all"` and follows the behavior in the original
ERVmap method. On the contrary, by setting `geneCountMode="ervmap"`, `atena`
also applies the filtering criteria employed to quantify TE expression to the
reads overlapping gene annotations.

Finally, `atena` also allows one to aggregate TE expression quantifications. By
default, the names of the input `GRanges` or `GRangesList` object given in the
`teFeatures` parameter are used to aggregate quantifications. However, the
`aggregateby` parameter can be used to specify other column names in the
feature annotations to be used to aggregate TE counts, for example at the
sub-family level.

### 4.1.2 Telescope

To use the Telescope method for TE expression quantification, the
`TelescopeParam()` function is used to build a parameter object of the class
`TelescopeParam`.

As in the case of `ERVmapParam()`, the `aggregateby` argument, which should be
a character vector of column names in the annotation, determines the columns to
be used to aggregate TE expression quantifications. This way, `atena` provides
not only quantifications at the subfamily level, but also allows to quantify
TEs at the desired level (family, class, etc.), including locus based
quantifications. For such a use case, the object with the TE annotations should
include a column with unique identifiers for each TE locus and the
`aggregateby` argument should specify the name of that column. When
`aggregateby` is not specified, the `names()` of the object containing TE
annotations are used to aggregate quantifications.

Here, TE quantifications will be aggregated according to the `names()` of the
`rmskLTR` object.

```
bamfiles <- list.files(system.file("extdata", package="atena"),
                       pattern="*.bam", full.names=TRUE)
tspar <- TelescopeParam(bfl=bamfiles,
                        teFeatures=rmskLTR,
                        singleEnd=TRUE,
                        ignoreStrand=TRUE)
ℹ Locating BAM files
ℹ Processing features
✔ Parameter object successfully created
tspar
TelescopeParam object
# BAM files (2): control_KD.bam, piwi_KD.bam
# features (CompressedGRangesList length 1408): ACCORD2_I-int.18752, ..., ZAM_LTR.21390
# single-end; unstranded
```

In case of paired-end data (`singleEnd=FALSE`), the argument usage is similar
to that of `ERVmapParam()`. In relation to the BAM file, Telescope follows the
same approach as the ERVmap method: when `fragments=FALSE`, only *mated read
pairs* from opposite strands are considered, while when `fragments=TRUE`,
same-strand pairs, singletons, reads with unmapped pairs and other fragments
are also considered by the algorithm. However, there is one important
difference with respect to the counting approach followed by ERVmap: when
`fragments=TRUE` *mated read pairs* mapping to the same element are counted
once, whereas in the ERVmap method they are counted twice.

As in the ERVmap method from `atena`, the gene expression quantification method
in Telescope is based on the approach of the TEtranscripts software
(Jin et al. [2015](#ref-jin2015tetranscripts)). This way, `atena` provides the possibility to
integrate TE expression quantification by Telescope with gene expression
quantification. As in the case of the ERVmap method implemented in `atena`,
either secondary alignments or the `NH` tag are required for gene expression
quantification.

### 4.1.3 TEtranscripts

Finally, the third method available is TEtranscripts. First, the
`TEtranscriptsParam()` function is called to build a parameter object of the
class `TEtranscriptsParam`. The usage of the `aggregateby` argument is the same
as in `TelescopeParam()` and `ERVmapParam()`. Locus based quantifications in
the TEtranscripts method from `atena` is possible because the TEtranscripts
algorithm actually computes TE quantifications at the locus level and then sums
up all instances of each TE subfamily to provide expression at the subfamily
level. By avoiding this last step, `atena` can provide TE expression
quantification at the locus level using the TEtranscripts method. For such a
use case, the object with the TE annotations should include a column with
unique identifiers for each TE and the `aggregateby` argument should specify
the name of that column.

In this example, the `aggregateby` argument will be set to
`aggregateby="repName"` in order to aggregate quantifications at the repeat
name level. Moreover, gene expression will also be quantified. To do so, gene
annotations are loaded from a *TxDb* object.

```
library(TxDb.Dmelanogaster.UCSC.dm6.ensGene)

txdb <- TxDb.Dmelanogaster.UCSC.dm6.ensGene
gannot <- exonsBy(txdb, by="gene")
length(gannot)
[1] 17807
```

```
bamfiles <- list.files(system.file("extdata", package="atena"),
                       pattern="*.bam", full.names=TRUE)
ttpar <- TEtranscriptsParam(bamfiles,
                            teFeatures=rmskLTR,
                            geneFeatures=gannot,
                            singleEnd=TRUE,
                            ignoreStrand=TRUE,
                            aggregateby="repName")
ℹ Locating BAM files
ℹ Processing features
✔ Parameter object successfully created
ttpar
TEtranscriptsParam object
# BAM files (2): control_KD.bam, piwi_KD.bam
# features (CompressedGRangesList length 19215): ACCORD2_I-int.18752, ..., ZAM_LTR.21390
# aggregated by: repName
# single-end; unstranded
```

For paired-end data, where would set `singleEnd=FALSE`, the `fragments`
parameter has the same purpose as in `TelescopeParam()`. We can also
extract the TEs and gene combined feature set using the `features()`
function on the parameter object. A metadata column called `isTE` is added
to enable distinguishing TEs from gene annotations.

```
features(ttpar)
GRangesList object of length 19215:
$`ACCORD2_I-int.18752`
GRanges object with 5 ranges and 15 metadata columns:
                      seqnames          ranges strand |   swScore  milliDiv
                         <Rle>       <IRanges>  <Rle> | <integer> <numeric>
  ACCORD2_I-int.18752     chrY 2683299-2683474      - |      1419         0
  ACCORD2_I-int.18752     chrY 2683475-2685353      - |      8817        30
  ACCORD2_I-int.18752     chrY 2685348-2688057      - |     22228        20
  ACCORD2_I-int.18752     chrY 2688056-2689854      - |      6698        75
  ACCORD2_I-int.18752     chrY 2689855-2690073      - |      1821         5
                       milliDel  milliIns  genoLeft       repName    repClass
                      <numeric> <numeric> <integer>   <character> <character>
  ACCORD2_I-int.18752         6        23   -983878   ACCORD2_LTR         LTR
  ACCORD2_I-int.18752        98         0   -981999 ACCORD2_I-int         LTR
  ACCORD2_I-int.18752         1         0   -979295 ACCORD2_I-int         LTR
  ACCORD2_I-int.18752        57        41   -977498 ACCORD2_I-int         LTR
  ACCORD2_I-int.18752         0        18   -977279   ACCORD2_LTR         LTR
                        repFamily  repStart    repEnd   repLeft   exon_id
                      <character> <integer> <integer> <integer> <integer>
  ACCORD2_I-int.18752       Gypsy        42       173         1      <NA>
  ACCORD2_I-int.18752       Gypsy         9      7203      5142      <NA>
  ACCORD2_I-int.18752       Gypsy      2371      4841      2128      <NA>
  ACCORD2_I-int.18752       Gypsy      5197      2015         1      <NA>
  ACCORD2_I-int.18752       Gypsy         0       215         1      <NA>
                        exon_name        type  isTE
                      <character> <character> <Rle>
  ACCORD2_I-int.18752        <NA>        <NA>  TRUE
  ACCORD2_I-int.18752        <NA>        <NA>  TRUE
  ACCORD2_I-int.18752        <NA>        <NA>  TRUE
  ACCORD2_I-int.18752        <NA>        <NA>  TRUE
  ACCORD2_I-int.18752        <NA>        <NA>  TRUE
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome

$`ACCORD2_I-int.18766`
GRanges object with 6 ranges and 15 metadata columns:
                      seqnames          ranges strand |   swScore  milliDiv
                         <Rle>       <IRanges>  <Rle> | <integer> <numeric>
  ACCORD2_I-int.18766     chrY 2737073-2737248      - |      1521         0
  ACCORD2_I-int.18766     chrY 2737249-2739132      - |      9404        31
  ACCORD2_I-int.18766     chrY 2739127-2741836      - |     23688        20
  ACCORD2_I-int.18766     chrY 2741835-2742273      - |      2682        64
  ACCORD2_I-int.18766     chrY 2742370-2743581      - |      5660        69
  ACCORD2_I-int.18766     chrY 2743582-2743800      - |      1947         5
                       milliDel  milliIns  genoLeft       repName    repClass
                      <numeric> <numeric> <integer>   <character> <character>
  ACCORD2_I-int.18766         6        23   -930104   ACCORD2_LTR         LTR
  ACCORD2_I-int.18766        97         1   -928220 ACCORD2_I-int         LTR
  ACCORD2_I-int.18766         2         0   -925516 ACCORD2_I-int         LTR
  ACCORD2_I-int.18766        32        46   -925079 ACCORD2_I-int         LTR
  ACCORD2_I-int.18766        20        42   -923771 ACCORD2_I-int         LTR
  ACCORD2_I-int.18766         0        18   -923552   ACCORD2_LTR         LTR
                        repFamily  repStart    repEnd   repLeft   exon_id
                      <character> <integer> <integer> <integer> <integer>
  ACCORD2_I-int.18766       Gypsy        42       173         1      <NA>
  ACCORD2_I-int.18766       Gypsy         6      7206      5142      <NA>
  ACCORD2_I-int.18766       Gypsy      2371      4841      2128      <NA>
  ACCORD2_I-int.18766       Gypsy      5197      2015      1583      <NA>
  ACCORD2_I-int.18766       Gypsy      5845      1367         1      <NA>
  ACCORD2_I-int.18766       Gypsy         0       215         1      <NA>
                        exon_name        type  isTE
                      <character> <character> <Rle>
  ACCORD2_I-int.18766        <NA>        <NA>  TRUE
  ACCORD2_I-int.18766        <NA>        <NA>  TRUE
  ACCORD2_I-int.18766        <NA>        <NA>  TRUE
  ACCORD2_I-int.18766        <NA>        <NA>  TRUE
  ACCORD2_I-int.18766        <NA>        <NA>  TRUE
  ACCORD2_I-int.18766        <NA>        <NA>  TRUE
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome

$`ACCORD2_I-int.2712`
GRanges object with 7 ranges and 15 metadata columns:
                     seqnames          ranges strand |   swScore  milliDiv
                        <Rle>       <IRanges>  <Rle> | <integer> <numeric>
  ACCORD2_I-int.2712    chr2R 2204406-2204447      + |       246       119
  ACCORD2_I-int.2712    chr2R 2204527-2207748      + |     15834        93
  ACCORD2_I-int.2712    chr2R 2207743-2208758      + |      6631        72
  ACCORD2_I-int.2712    chr2R 2208789-2209734      + |      2458        83
  ACCORD2_I-int.2712    chr2R 2209729-2211681      + |     12355        81
  ACCORD2_I-int.2712    chr2R 2211689-2211834      + |       556       102
  ACCORD2_I-int.2712    chr2R 2212158-2212233      + |       475       107
                      milliDel  milliIns  genoLeft       repName    repClass
                     <numeric> <numeric> <integer>   <character> <character>
  ACCORD2_I-int.2712         0         0 -23082489 ACCORD2_I-int         LTR
  ACCORD2_I-int.2712        62        18 -23079188 ACCORD2_I-int         LTR
  ACCORD2_I-int.2712        65         8 -23078178 ACCORD2_I-int         LTR
  ACCORD2_I-int.2712       103         7 -23077202 ACCORD2_I-int         LTR
  ACCORD2_I-int.2712        57         9 -23075255 ACCORD2_I-int         LTR
  ACCORD2_I-int.2712        30       123 -23075102   ACCORD2_LTR         LTR
  ACCORD2_I-int.2712         0        13 -23074703   ACCORD2_LTR         LTR
                       repFamily  repStart    repEnd   repLeft   exon_id
                     <character> <integer> <integer> <integer> <integer>
  ACCORD2_I-int.2712       Gypsy      1326      1367      5845      <NA>
  ACCORD2_I-int.2712       Gypsy      1522      4950      2262      <NA>
  ACCORD2_I-int.2712       Gypsy      5159      6236       976      <NA>
  ACCORD2_I-int.2712       Gypsy      3851      4950      2262      <NA>
  ACCORD2_I-int.2712       Gypsy      5159      7209         3      <NA>
  ACCORD2_I-int.2712       Gypsy         1       132        83      <NA>
  ACCORD2_I-int.2712       Gypsy       141       215         0      <NA>
                       exon_name        type  isTE
                     <character> <character> <Rle>
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  ACCORD2_I-int.2712        <NA>        <NA>  TRUE
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome

...
<19212 more elements>
mcols(features(ttpar))
DataFrame with 19215 rows and 4 columns
                             Status RelLength       Class      isTE
                        <character> <numeric> <character> <logical>
ACCORD2_I-int.18752  full-lengthLTR  0.887595         LTR      TRUE
ACCORD2_I-int.18766  full-lengthLTR  0.868882         LTR      TRUE
ACCORD2_I-int.2712  partialLTR_down  0.968464         LTR      TRUE
ACCORD2_I-int.6123   full-lengthLTR  1.000000         LTR      TRUE
ACCORD2_LTR.19682             noLTR  1.000000         LTR      TRUE
...                             ...       ...         ...       ...
TRANSPAC_I-int.8329  full-lengthLTR  0.999810         LTR      TRUE
TRANSPAC_I-int.9501  full-lengthLTR  1.000000         LTR      TRUE
ZAM_I-int.2573       full-lengthLTR  0.998459         LTR      TRUE
ZAM_I-int.7530       full-lengthLTR  0.861987         LTR      TRUE
ZAM_LTR.21390                 noLTR  0.957627         LTR      TRUE
table(mcols(features(ttpar))$isTE)

FALSE  TRUE
17807  1408
```

Regarding gene expression quantification, `atena` has implemented the approach
of the original TEtranscripts software (Jin et al. [2015](#ref-jin2015tetranscripts)). As in the case
of the ERVmap and Telescope methods from `atena`, either secondary alignments
or the `NH` tag are required.

Following the gene annotation processing present in the TEtranscripts
algorithm, in case that `geneFeatures` contains a metadata column named “type”,
only the elements with `type="exon"` are considered for quantification. If
those elements are grouped through a `GRangesList` object, then counts are
aggregated at the level of those `GRangesList` elements, such as genes or
transcripts. This also applies to the ERVmap and Telescope methods implemented
in `atena` when gene features are present. Let’s see an example of this
processing:

```
## Create a toy example of gene annotations
geneannot <- GRanges(seqnames=rep("2L", 8),
                     ranges=IRanges(start=c(1,20,45,80,110,130,150,170),
                                    width=c(10,20,35,10,5,15,10,25)),
                     strand="*",
                     type=rep("exon",8))
names(geneannot) <- paste0("gene",c(rep(1,3),rep(2,4),rep(3,1)))
geneannot
GRanges object with 8 ranges and 1 metadata column:
        seqnames    ranges strand |        type
           <Rle> <IRanges>  <Rle> | <character>
  gene1       2L      1-10      * |        exon
  gene1       2L     20-39      * |        exon
  gene1       2L     45-79      * |        exon
  gene2       2L     80-89      * |        exon
  gene2       2L   110-114      * |        exon
  gene2       2L   130-144      * |        exon
  gene2       2L   150-159      * |        exon
  gene3       2L   170-194      * |        exon
  -------
  seqinfo: 1 sequence from an unspecified genome; no seqlengths
ttpar2 <- TEtranscriptsParam(bamfiles,
                             teFeatures=rmskLTR,
                             geneFeatures=geneannot,
                             singleEnd=TRUE,
                             ignoreStrand=TRUE)
ℹ Locating BAM files
ℹ Processing features
✔ Parameter object successfully created
mcols(features(ttpar2))
DataFrame with 1411 rows and 4 columns
                             Status RelLength       Class      isTE
                        <character> <numeric> <character> <logical>
ACCORD2_I-int.18752  full-lengthLTR  0.887595         LTR      TRUE
ACCORD2_I-int.18766  full-lengthLTR  0.868882         LTR      TRUE
ACCORD2_I-int.2712  partialLTR_down  0.968464         LTR      TRUE
ACCORD2_I-int.6123   full-lengthLTR  1.000000         LTR      TRUE
ACCORD2_LTR.19682             noLTR  1.000000         LTR      TRUE
...                             ...       ...         ...       ...
ZAM_I-int.7530       full-lengthLTR  0.861987         LTR      TRUE
ZAM_LTR.21390                 noLTR  0.957627         LTR      TRUE
gene1                            NA        NA          NA     FALSE
gene2                            NA        NA          NA     FALSE
gene3                            NA        NA          NA     FALSE
features(ttpar2)[!mcols(features(ttpar2))$isTE]
GRangesList object of length 3:
$gene1
GRanges object with 3 ranges and 13 metadata columns:
        seqnames    ranges strand |   swScore  milliDiv  milliDel  milliIns
           <Rle> <IRanges>  <Rle> | <integer> <numeric> <numeric> <numeric>
  gene1    chr2L      1-10      * |      <NA>        NA        NA        NA
  gene1    chr2L     20-39      * |      <NA>        NA        NA        NA
  gene1    chr2L     45-79      * |      <NA>        NA        NA        NA
         genoLeft     repName    repClass   repFamily  repStart    repEnd
        <integer> <character> <character> <character> <integer> <integer>
  gene1      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
  gene1      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
  gene1      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
          repLeft        type  isTE
        <integer> <character> <Rle>
  gene1      <NA>        exon FALSE
  gene1      <NA>        exon FALSE
  gene1      <NA>        exon FALSE
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome

$gene2
GRanges object with 4 ranges and 13 metadata columns:
        seqnames    ranges strand |   swScore  milliDiv  milliDel  milliIns
           <Rle> <IRanges>  <Rle> | <integer> <numeric> <numeric> <numeric>
  gene2    chr2L     80-89      * |      <NA>        NA        NA        NA
  gene2    chr2L   110-114      * |      <NA>        NA        NA        NA
  gene2    chr2L   130-144      * |      <NA>        NA        NA        NA
  gene2    chr2L   150-159      * |      <NA>        NA        NA        NA
         genoLeft     repName    repClass   repFamily  repStart    repEnd
        <integer> <character> <character> <character> <integer> <integer>
  gene2      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
  gene2      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
  gene2      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
  gene2      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
          repLeft        type  isTE
        <integer> <character> <Rle>
  gene2      <NA>        exon FALSE
  gene2      <NA>        exon FALSE
  gene2      <NA>        exon FALSE
  gene2      <NA>        exon FALSE
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome

$gene3
GRanges object with 1 range and 13 metadata columns:
        seqnames    ranges strand |   swScore  milliDiv  milliDel  milliIns
           <Rle> <IRanges>  <Rle> | <integer> <numeric> <numeric> <numeric>
  gene3    chr2L   170-194      * |      <NA>        NA        NA        NA
         genoLeft     repName    repClass   repFamily  repStart    repEnd
        <integer> <character> <character> <character> <integer> <integer>
  gene3      <NA>        <NA>        <NA>        <NA>      <NA>      <NA>
          repLeft        type  isTE
        <integer> <character> <Rle>
  gene3      <NA>        exon FALSE
  -------
  seqinfo: 1870 sequences (1 circular) from dm6 genome
```

### 4.1.4 Quantifying expression

Finally, to quantify TE expression we call the `qtex()` method using one of the
previously defined parameter objects (`ERVmapParam`, `TEtranscriptsParam` or
`TelescopeParam`) according to the quantification method we want to use. As with
the `OneCodeToFindThemAll()` function described before, here we can also use the
`BPPARAM` parameter to perform calculations in parallel.

The `qtex()` method returns a `SummarizedExperiment` object containing the
resulting quantification of expression in an assay slot. Additionally, when a
`data.frame`, or `DataFrame`, object storing phenotypic data is passed to the
`qtex()` function through the `phenodata` parameter, this will be included as
column data in the resulting `SummarizedExperiment` object and the row names of
these phenotypic data will be set as column names in the output
`SummarizedExperiment` object.

In the current example, the call to quantify TE expression using the ERVmap
method would be the following:

```
emq <- qtex(empar)
Warning in call_new_fun_in_cigarillo("explodeCigarOpLengths", "explode_cigar_oplens", : explodeCigarOpLengths() is formally deprecated in GenomicAlignments >= 1.45.5
  and replaced with the explode_cigar_oplens() function from the new cigarillo
  package
Warning in call_new_fun_in_cigarillo("explodeCigarOpLengths", "explode_cigar_oplens", : explodeCigarOpLengths() is formally deprecated in GenomicAlignments >= 1.45.5
  and replaced with the explode_cigar_oplens() function from the new cigarillo
  package
```

```
emq
class: RangedSummarizedExperiment
dim: 1408 2
metadata(0):
assays(1): counts
rownames(1408): ACCORD2_I-int.18752 ACCORD2_I-int.18766 ...
  ZAM_I-int.7530 ZAM_LTR.21390
rowData names(4): Status RelLength Class isTE
colnames(2): control_KD piwi_KD
colData names(0):
colSums(assay(emq))
control_KD    piwi_KD
        95         75
```

In the case of the Telescope method, the call would be as follows:

```
tsq <- qtex(tspar)
```

```
tsq
class: RangedSummarizedExperiment
dim: 1408 2
metadata(0):
assays(1): counts
rownames(1408): ACCORD2_I-int.18752 ACCORD2_I-int.18766 ...
  ZAM_I-int.7530 ZAM_LTR.21390
rowData names(4): Status RelLength Class isTE
colnames(2): control_KD piwi_KD
colData names(0):
colSums(assay(tsq))
control_KD    piwi_KD
       144          3
```

For the TEtranscripts method, TE expression is quantified by using the
following call:

```
ttq <- qtex(ttpar)
```

```
ttq
class: RangedSummarizedExperiment
dim: 17917 2
metadata(0):
assays(1): counts
rownames(17917): ACCORD2_I-int ACCORD2_LTR ... FBgn0286940 FBgn0286941
rowData names(4): Status RelLength Class isTE
colnames(2): control_KD piwi_KD
colData names(0):
colSums(assay(ttq))
control_KD    piwi_KD
       149        133
```

As mentioned, TE expression quantification is provided at the repeat name
level.

# 5 Accesing expression quantifications and metadata

The `qtex()` function returns a `SummarizedExperiment` object that, on the
one hand, stores the quantified expression in its assay data.

```
head(assay(ttq))
              control_KD piwi_KD
ACCORD2_I-int          0       0
ACCORD2_LTR            0       0
ACCORD_LTR             0       0
BATUMI_I-int           0       0
BATUMI_LTR             0       0
BEL_I-int              0       0
```

On the other hand, it contains metadata about the features that may be useful
to select subsets of the quantified data and extract and explore the feature
annotations, using the function `rowData()` on this `SummarizedExperiment`
object.

```
rowData(ttq)
DataFrame with 17917 rows and 4 columns
                                    Status RelLength       Class      isTE
                           <CharacterList> <numeric> <character> <logical>
ACCORD2_I-int              partialLTR_down  0.968464         LTR      TRUE
ACCORD2_LTR           full-lengthLTR,noLTR  0.928405         LTR      TRUE
ACCORD_LTR            full-lengthLTR,noLTR  0.879776         LTR      TRUE
BATUMI_I-int     int,partialLTR_down,noLTR  0.934641         LTR      TRUE
BATUMI_LTR    full-lengthLTR,partialLTR_up  0.963187         LTR      TRUE
...                                    ...       ...         ...       ...
FBgn0286937                             NA        NA          NA     FALSE
FBgn0286938                             NA        NA          NA     FALSE
FBgn0286939                             NA        NA          NA     FALSE
FBgn0286940                             NA        NA          NA     FALSE
FBgn0286941                             NA        NA          NA     FALSE
```

Because we have aggregated quantifications by `RepName` the number of TE
quantified features has been substantially reduced with respect to the original
number of TE features.

```
table(rowData(ttq)$isTE)

FALSE  TRUE
17807   110
```

Let’s say we want to select full-length LTRs features, this could be a way of
doing it.

```
temask <- rowData(ttq)$isTE
fullLTRs <- rowData(ttq)$Status == "full-lengthLTR"
fullLTRs <- (sapply(fullLTRs, sum, na.rm=TRUE) == 1) &
            (lengths(rowData(ttq)$Status) == 1)
sum(fullLTRs)
[1] 14
rowData(ttq)[fullLTRs, ]
DataFrame with 14 rows and 4 columns
                       Status RelLength       Class      isTE
              <CharacterList> <numeric> <character> <logical>
BEL_LTR        full-lengthLTR  0.969638         LTR      TRUE
BLASTOPIA_LTR  full-lengthLTR  0.990062         LTR      TRUE
BLOOD_LTR      full-lengthLTR  0.991468         LTR      TRUE
BURDOCK_LTR    full-lengthLTR  0.982514         LTR      TRUE
Chouto_LTR     full-lengthLTR  0.972210         LTR      TRUE
...                       ...       ...         ...       ...
Gypsy6_LTR     full-lengthLTR  0.899885         LTR      TRUE
Gypsy8_LTR     full-lengthLTR  1.000000         LTR      TRUE
Gypsy9_LTR     full-lengthLTR  0.975136         LTR      TRUE
Invader3_LTR   full-lengthLTR  0.989059         LTR      TRUE
TRANSPAC_LTR   full-lengthLTR  0.999943         LTR      TRUE
```

Note also that since we restricted expression quantification to LTRs, we do
have only quantification for that TE class.

```
table(rowData(ttq)$Class[temask])

LTR
110
```

# 6 Session information

```
sessionInfo()
R version 4.5.2 (2025-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] TxDb.Dmelanogaster.UCSC.dm6.ensGene_3.12.0
 [2] GenomicFeatures_1.62.0
 [3] AnnotationDbi_1.72.0
 [4] RColorBrewer_1.1-3
 [5] BiocParallel_1.44.0
 [6] atena_1.16.1
 [7] SummarizedExperiment_1.40.0
 [8] Biobase_2.70.0
 [9] GenomicRanges_1.62.0
[10] Seqinfo_1.0.0
[11] IRanges_2.44.0
[12] S4Vectors_0.48.0
[13] BiocGenerics_0.56.0
[14] generics_0.1.4
[15] MatrixGenerics_1.22.0
[16] matrixStats_1.5.0
[17] knitr_1.50
[18] BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
 [4] filelock_1.0.3           Biostrings_2.78.0        bitops_1.0-9
 [7] fastmap_1.2.0            RCurl_1.98-1.17          BiocFileCache_3.0.0
[10] GenomicAlignments_1.46.0 XML_3.99-0.20            digest_0.6.39
[13] lifecycle_1.0.4          KEGGREST_1.50.0          RSQLite_2.4.5
[16] magrittr_2.0.4           compiler_4.5.2           rlang_1.1.6
[19] sass_0.4.10              tools_4.5.2              yaml_2.3.11
[22] rtracklayer_1.70.0       S4Arrays_1.10.1          bit_4.6.0
[25] curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8
[28] withr_3.0.2              purrr_1.2.0              grid_4.5.2
[31] tinytex_0.58             cli_3.6.5                rmarkdown_2.30
[34] crayon_1.5.3             httr_1.4.7               rjson_0.2.23
[37] DBI_1.2.3                cachem_1.1.0             parallel_4.5.2
[40] BiocManager_1.30.27      XVector_0.50.0           restfulr_0.0.16
[43] vctrs_0.6.5              Matrix_1.7-4             jsonlite_2.0.0
[46] bookdown_0.45            bit64_4.6.0-1            magick_2.9.0
[49] jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20
[52] BiocVersion_3.22.0       GenomeInfoDb_1.46.2      BiocIO_1.20.0
[55] UCSC.utils_1.6.0         tibble_3.3.0             pillar_1.11.1
[58] rappdirs_0.3.3           htmltools_0.5.9          R6_2.6.1
[61] dbplyr_2.5.1             httr2_1.2.1              sparseMatrixStats_1.22.0
[64] evaluate_1.0.5           lattice_0.22-7           AnnotationHub_4.0.0
[67] png_0.1-8                Rsamtools_2.26.0         cigarillo_1.0.0
[70] memoise_2.0.1            SQUAREM_2021.1           bslib_0.9.0
[73] Rcpp_1.1.0               SparseArray_1.10.6       xfun_0.54
[76] pkgconfig_2.0.3
```

# References

Bailly-Bechet, Marc, Annabelle Haudry, and Emmanuelle Lerat. 2014. “‘One Code to Find Them All’: A Perl Tool to Conveniently Parse Repeatmasker Output Files.” *Mobile DNA* 5 (1): 1–15.

Bendall, Matthew L, Miguel De Mulder, Luis Pedro Iñiguez, Aarón Lecanda-Sánchez, Marcos Pérez-Losada, Mario A Ostrowski, R Brad Jones, et al. 2019. “Telescope: Characterization of the Retrotranscriptome by Accurate Estimation of Transposable Element Expression.” *PLoS Computational Biology* 15 (9): e1006453.

Dobin, Alexander, Carrie A Davis, Felix Schlesinger, Jorg Drenkow, Chris Zaleski, Sonali Jha, Philippe Batut, Mark Chaisson, and Thomas R Gingeras. 2013. “STAR: Ultrafast Universal Rna-Seq Aligner.” *Bioinformatics* 29 (1): 15–21.

Goerner-Potvin, Patricia, and Guillaume Bourque. 2018. “Computational Tools to Unmask Transposable Elements.” *Nature Reviews Genetics* 19 (11): 688–704.

Guffanti, Guia, Andrew Bartlett, Torsten Klengel, Claudia Klengel, Richard Hunter, Gennadi Glinsky, and Fabio Macciardi. 2018. “Novel Bioinformatics Approach Identifies Transcriptional Profiles of Lineage-Specific Transposable Elements at Distinct Loci in the Human Dorsolateral Prefrontal Cortex.” *Molecular Biology and Evolution* 35 (10): 2435–53.

Jin, Ying, Oliver H Tam, Eric Paniagua, and Molly Hammell. 2015. “TEtranscripts: A Package for Including Transposable Elements in Differential Expression Analysis of Rna-Seq Datasets.” *Bioinformatics* 31 (22): 3593–9.

Li, Heng, and Richard Durbin. 2009. “Fast and Accurate Short Read Alignment with Burrows–Wheeler Transform.” *Bioinformatics* 25 (14): 1754–60.

Payer, Lindsay M, and Kathleen H Burns. 2019. “Transposable Elements in Human Genetic Disease.” *Nature Reviews Genetics* 20 (12): 760–72.

Tokuyama, Maria, Yong Kong, Eric Song, Teshika Jayewickreme, Insoo Kang, and Akiko Iwasaki. 2018. “ERVmap Analysis Reveals Genome-Wide Transcription of Human Endogenous Retroviruses.” *Proceedings of the National Academy of Sciences* 115 (50): 12565–72.