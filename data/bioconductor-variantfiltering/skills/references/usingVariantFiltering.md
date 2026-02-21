VariantFiltering: filtering of coding and non-
coding genetic variants

Dei M. Elurbe 1,2 and Robert Castelo 3,4

October 30, 2025

1CIBER de Enfermedades Raras (CIBERER), Barcelona, Spain
2Present address: CMBI, Radboud University Medical Centre, Nijmegen, The Netherlands.
2Department of Experimental and Health Sciences, Universitat Pompeu Fabra, Barcelona, Spain.
3Research Program on Biomedical Informatics (GRIB), Hospital del Mar Medical Research Institute, Barcelona,

Spain.

1

Overview

The aim of this software package is to facilitate the filtering and annotation of coding and
non-coding genetic variants from a group of unrelated individuals, or a family of related
ones among which at least one of them is affected by a genetic disorder. When working
with related individuals, VariantFiltering can search for variants from the affected individuals
that segregate according to a particular inheritance model acting on autosomes (dominant,
recessive homozygous or recessive heterozygous -also known as compound heterozygous) or
on allosomes (X-linked), or that occur de novo. When working with unrelated individuals,
no mode of inheritance is used for filtering but it can be used to search for variants shared
among individuals affected by a common genetic disorder.

The main input is a multisample Variant Call Format (VCF) file which is parsed using the
R/Bioconductor infrastructure, and particularly the functionality from the VariantAnnotation
package for that purpose. This infrastructure also allows VariantFiltering to stream over large
VCF files to reduce the memory footprint and to annotate the input variants with diverse
functional information.

A core set of functional data are annotated by VariantFiltering but this set can be modified
and extended using Bioconductor annotation packages such as MafDb.1Kgenomes.phase3.hs37d5 ,
which stores and exposes to the user minor allele frequency (MAF) values frozen from the
latest realease of the 1000 Genomes project.

The package contains a toy data set to illustrate how it works through this vignette, and it
consists of a multisample VCF file with variants from chromosomes 20, 21, 22 and allosomes
X, Y from a trio of CEU individuals of the 1000 Genomes project. To further reduce the
execution time of this vignette, only the code for the first analysis is actually evaluated and
its results reported.

2

Setting up the analysis

To start using VariantFiltering the user should consider installing the packages listed in the
Suggests: field from its DESCRIPTION file. After loading VariantFiltering the first step is to
build a parameter object, of class VariantFilteringParam which requires at least a character
string with the input VCF filename, as follows:

VariantFiltering: filtering of coding and non-coding genetic variants

> library(VariantFiltering)

> CEUvcf <- file.path(system.file("extdata", package="VariantFiltering"),

+

"CEUtrio.vcf.bgz")

> vfpar <- VariantFilteringParam(CEUvcf)

> class(vfpar)

[1] "VariantFilteringParam"

attr(,"package")

[1] "VariantFiltering"

> vfpar

VariantFiltering parameter object

VCF file(s): CEUtrio.vcf.bgz

Genome version(s): hg19(NCBI)

Number of individuals: 3 (NA12878, NA12891, NA12892)

Genome-centric annotation package: BSgenome.Hsapiens.1000genomes.hs37d5 (1000genomes hs37d5)

Variant-centric annotation package: SNPlocs.Hsapiens.dbSNP144.GRCh37 (dbSNP Human BUILD 144)

Transcript-centric annotation package: TxDb.Hsapiens.UCSC.hg19.knownGene

Gene-centric annotation package: org.Hs.eg.db
Radical/Conservative AA changes: AA_chemical_properties_HanadaGojoboriLi2006.tsv
Codon usage table: humanCodonUsage.txt

Regions to annotate: CodingVariants, IntronVariants, FiveSpliceSiteVariants, ThreeSpliceSiteVariants, PromoterVariants, FiveUTRVariants, ThreeUTRVariants

Other annotation pkg/obj: MafDb.1Kgenomes.phase1.hs37d5,

PolyPhen.Hsapiens.dbSNP131,

SIFT.Hsapiens.dbSNP137,

phastCons100way.UCSC.hg19,

humanGenesPhylostrata

All transcripts: FALSE

The display of the VariantFilteringParam object indicates a number of default values which
can be overriden when calling the construction function. To quickly see all the available
arguments and their default values we should type:

> args(VariantFilteringParam)

function (vcfFilename, pedFilename = NA_character_, bsgenome = "BSgenome.Hsapiens.1000genomes.hs37d5",

orgdb = "org.Hs.eg.db", txdb = "TxDb.Hsapiens.UCSC.hg19.knownGene",

snpdb = "SNPlocs.Hsapiens.dbSNP144.GRCh37", weightMatricesFilenames = NA,

weightMatricesLocations = rep(list(variantLocations()), length(weightMatricesFilenames)),

weightMatricesStrictLocations = rep(list(FALSE), length(weightMatricesFilenames)),

radicalAAchangeFilename = file.path(system.file("extdata",

package = "VariantFiltering"), "AA_chemical_properties_HanadaGojoboriLi2006.tsv"),

codonusageFilename = file.path(system.file("extdata", package = "VariantFiltering"),

"humanCodonUsage.txt"), geneticCode = getGeneticCode("SGC0"),

allTranscripts = FALSE, regionAnnotations = list(CodingVariants(),

IntronVariants(), FiveSpliceSiteVariants(), ThreeSpliceSiteVariants(),

PromoterVariants(), FiveUTRVariants(), ThreeUTRVariants()),

intergenic = FALSE, otherAnnotations = c("MafDb.1Kgenomes.phase1.hs37d5",

"PolyPhen.Hsapiens.dbSNP131", "SIFT.Hsapiens.dbSNP137",

"phastCons100way.UCSC.hg19", "humanGenesPhylostrata"),

geneKeytype = NA_character_, yieldSize = NA_integer_)

2

VariantFiltering: filtering of coding and non-coding genetic variants

NULL

The manual page of VariantFilteringParam contains more information about these argu-
ments and their default values.

3

Annotating variants

After setting up the parameters object, the next step is to annotate variants. This can be
done using upfront an inheritance model that will substantially filter and reduce the number
of variants and annotations or, as we illustrate here below, calling the function unrelatedIn
dividuals() that just annotates the variants without filtering out any of them:

> uind <- unrelatedIndividuals(vfpar)

> class(uind)

[1] "VariantFilteringResults"

attr(,"package")

[1] "VariantFiltering"

> uind

VariantFiltering results object

Genome version(s): "hg19"(NCBI)

Number of individuals: 3 (NA12878, NA12891, NA12892)

Variants segregate according to a(n) unrelated individuals inheritance model

Quality filters

PASS INDELQual

LowQual

SNPQual

TRUE

TRUE

TRUE

TRUE

Functional annotation filters

variantType

FALSE

codonusageFC

FALSE

genePhyloStratum

FALSE

dbSNP

FALSE

OMIM

FALSE

SOterms

FALSE

location

consequence

FALSE

aaChangeType

FALSE

FALSE

maxMAF

FALSE

The resulting object belongs to the VariantFilteringResults class of objects, defined within
VariantFiltering, whose purpose is to ease the task of filtering and prioritizing the annotated
variants. The display of the object just tells us the genome version of the input VCF file, the
number of individuals, the inheritance model and what variant filters are activated.

To get a summary of the number of variants annotated to a particular feature we should use
the function summary():

> summary(uind)

SOID

1

2

3

4

SO:0002012

SO:0001631

SO:0001624

SO:0001623

Description Nr. Variants % Variants
start_lost
upstream_gene_variant
3_prime_UTR_variant
5_prime_UTR_variant

26.54

0.23

5.26

2.52

116

23

11

1

3

VariantFiltering: filtering of coding and non-coding genetic variants

5

6

7

8

9

SO:0001587

SO:0001583

SO:0001589

frameshift_variant
stop_gained
missense_variant
splice_donor_variant
SO:0001575
SO:0001574 splice_acceptor_variant
intron_variant
synonymous_variant

10 SO:0001627

11 SO:0001819

2

1

18

4

8

361

17

0.46

0.23

4.12

0.92

1.83

82.61

3.89

The default setting of the summary() function is to provide feature annotations in terms
of Sequence Ontology (SO) terms. The reported number of variants refer to the number
of different variants in the input VCF file annotated to the feature while the percentage of
variants refers to the fraction of this number over the total number of different variants in
the input VCF file.

We can also obtain a summary based on the Bioconductor feature annotations provided by
the functions locateVariants() and predictCoding() from the VariantAnnotation package,
as follows:

> summary(uind, method="bioc")

BIOCID Nr. Variants % Variants

2

3

4

5

7

8

9

10

11

12

13

intron

fiveUTR

threeUTR

coding

promoter

fiveSpliceSite

threeSpliceSite

frameshift

nonsense

nonsynonymous

synonymous

361

11

23

37

116

4

8

2

1

18

17

82.61

2.52

5.26

8.47

26.54

0.92

1.83

0.46

0.23

4.12

3.89

Since SO terms are organized hierarchically, we can use this structure to aggregate feature
annotations into more coarse-grained SO terms using the argument method="SOfull":

> uindSO <- summary(uind, method="SOfull")

> uindSO

SOID Level

1

2

3

4

5

6

7

8

9

SO:0002012

SO:0001582

SO:0001819

SO:0001631

SO:0001628

SO:0001624

SO:0001623

SO:0001622

SO:0001589

10 SO:0001587

11 SO:0001906

12 SO:0001583

13 SO:0001992

9

8

8

5

4

8

8

7

9

5

4

11

10

1

1

17

116

3.89

0.23

0.23

Description Nr. Variants % Variants
start_lost
initiator_codon_variant
synonymous_variant
upstream_gene_variant
intergenic_variant
3_prime_UTR_variant
5_prime_UTR_variant
UTR_variant
frameshift_variant
stop_gained
feature_truncation
missense_variant
nonsynonymous_variant

26.54

26.54

4.35

4.12

5.26

2.52

7.78

0.46

0.23

0.23

116

18

19

23

11

34

1

1

2

4

VariantFiltering: filtering of coding and non-coding genetic variants

14 SO:0001650

15 SO:0001818

16 SO:0001580

17 SO:0001968

18 SO:0001791

19 SO:0001575

20 SO:0001574

21 SO:0001629

22 SO:0001627

23 SO:0001568

24 SO:0001576

25 SO:0001564

26 SO:0001878

27 SO:0001537

28 SO:0001060

29 SO:0002072

7

8

8

inframe_variant
9
8 protein_altering_variant
coding_sequence_variant
7
6 coding_transcript_variant
exon_variant
6
splice_donor_variant
splice_acceptor_variant
splice_site_variant
intron_variant
splicing_variant
transcript_variant
gene_variant
feature_variant
structural_variant
sequence_variant
sequence_comparison

6

6

5

4

3

2

1

0

19

21

37

61

61

4

8

12

361

12

401

401

437

437

437

437

4.35

4.81

8.47

13.96

13.96

0.92

1.83

2.75

82.61

2.75

91.76

91.76

100.00

100.00

100.00

100.00

Here the Level column refers to the shortest-path distance to the most general SO term
sequence_variant within the SO ayclic digraph. We can use this level value to interrogate
the annotations on a specific granularity:

> uindSO[uindSO$Level == 6, ]

SOID Level

Description Nr. Variants % Variants

17 SO:0001968

18 SO:0001791

22 SO:0001627

23 SO:0001568

6 coding_transcript_variant
exon_variant
6
intron_variant
splicing_variant

6

6

61

61

361

12

13.96

13.96

82.61

2.75

Variants are stored internally in a VRanges object. We can retrieve the variants as a Vranges
object with the function allVariants():

> allVariants(uind)

VRangesList of length 3

names(3): NA12878 NA12891 NA12892

This function in fact returns a VRangesList object with one element per sample by default.
We can change the grouping of variants with the argument groupBy specifying the annotation
column we want to use to group variants. If the specified column does not exist, then it will
return a single VRanges object with all annotated variants.

Using the following code we can obtain a graphical display of a variant, including the aligned
reads and the running coverage, to have a visual representation of its support. For this
purpose we need to have the BAM files used to perform the variant calling. In this case we
are using toy BAM files stored along with the VariantFiltering package, which for practical
reasons only include a tiny subset of the aligned reads.

> path2bams <- file.path(system.file("extdata", package="VariantFiltering"),

+

paste0(samples(uind), ".subset.bam"))

> bv <- BamViews(bamPaths=path2bams,

+

bamSamples=DataFrame(row.names=samples(uind)))

> bamFiles(uind) <- bv

5

VariantFiltering: filtering of coding and non-coding genetic variants

> bamFiles(uind)

BamViews dim: 0 ranges x 3 samples

names: NA12878 NA12891 NA12892

detail: use bamPaths(), bamSamples(), bamRanges(), ...

> plot(uind, what="rs6130959", sampleName="NA12892")

Figure 1: Browser-like display of a variant.

4

Filters and cutoffs

In the case of having run the unrelatedIndividuals() annotation function we can filter
variants by restricting the samples involved in the analysis, as follows:

> samples(uind)

[1] "NA12878" "NA12891" "NA12892"

> samples(uind) <- c("NA12891", "NA12892")

> uind

VariantFiltering results object

Genome version(s): "hg19"(NCBI)

Number of individuals: 2 (NA12891, NA12892)

Variants segregate according to a(n) unrelated individuals inheritance model

Quality filters

PASS INDELQual

LowQual

SNPQual

TRUE

TRUE

TRUE

TRUE

Functional annotation filters

variantType

FALSE

codonusageFC

FALSE

dbSNP

FALSE

OMIM

FALSE

location

consequence

FALSE

aaChangeType

FALSE

FALSE

maxMAF

FALSE

6

44.50144 mb44.50145 mb44.50146 mb44.50147 mbUCSCGenes0246AlignmentsTrackGAAGGGGACCACCCCCGCACTGTGCACACAATAGGTACAGACACTCTVariantFiltering: filtering of coding and non-coding genetic variants

genePhyloStratum

FALSE

SOterms

FALSE

> uindSO2sam <- summary(uind, method="SOfull")

> uindSO2sam[uindSO2sam$Level == 6, ]

SOID Level

Description Nr. Variants % Variants

17 SO:0001968

18 SO:0001791

22 SO:0001627

23 SO:0001568

6 coding_transcript_variant
exon_variant
6
intron_variant
splicing_variant

6

6

54

54

308

9

14.29

14.29

81.48

2.38

As we can see, restricting the samples for filtering variants results in fewer variants. We can
set the original samples back with the function resetSamples():

> uind <- resetSamples(uind)

> uind

VariantFiltering results object

Genome version(s): "hg19"(NCBI)

Number of individuals: 3 (NA12878, NA12891, NA12892)

Variants segregate according to a(n) unrelated individuals inheritance model

Quality filters

PASS INDELQual

LowQual

SNPQual

TRUE

TRUE

TRUE

TRUE

Functional annotation filters

variantType

FALSE

codonusageFC

FALSE

genePhyloStratum

FALSE

dbSNP

FALSE

OMIM

FALSE

SOterms

FALSE

location

consequence

FALSE

aaChangeType

FALSE

FALSE

maxMAF

FALSE

The rest of the filtering operations we can perform on a VariantFilteringResults objects
are implemented through the FilterRules class which implements a general mechanism for
generating logical masks to filter vector-like objects; consult its manual page at the IRanges
package for full technical details.

The Variantfiltering package provides a number of default filters, which can be extended by
the user. To see which are these filters we just have to use the filters() function:

> filters(uind)

FilterRules of length 15

names(15): PASS INDELQual LowQual SNPQual ... maxMAF genePhyloStratum SOterms

Filters may be active or inactive. Only active filters will participate in the filtering process
when we interrogate for variants. To know what filters are active we should use the active()
function as follows:

> active(filters(uind))

PASS

TRUE

INDELQual

TRUE

LowQual

TRUE

SNPQual

TRUE

7

VariantFiltering: filtering of coding and non-coding genetic variants

variantType

FALSE

codonusageFC

FALSE

dbSNP

FALSE

OMIM

FALSE

maxMAF genePhyloStratum

FALSE

FALSE

location

consequence

FALSE

aaChangeType

FALSE

SOterms

FALSE

FALSE

maxMAF

FALSE

By default, all filters are always inactive. To activate all of them, we can simply type:

> active(filters(uind)) <- TRUE

> active(filters(uind))

PASS

TRUE

variantType

TRUE

codonusageFC

TRUE

INDELQual

TRUE

dbSNP

TRUE

OMIM

TRUE

maxMAF genePhyloStratum

TRUE

TRUE

> summary(uind)

LowQual

TRUE

SNPQual

TRUE

location

consequence

TRUE

aaChangeType

TRUE

SOterms

TRUE

TRUE

maxMAF

TRUE

SOID

Description Nr. Variants % Variants

1 SO:0001631 upstream_gene_variant
3_prime_UTR_variant
2 SO:0001624
missense_variant
3 SO:0001583
4 SO:0001575 splice_donor_variant
intron_variant
5 SO:0001627
synonymous_variant

6 SO:0001819

3

2

1

1

4

15

20.0

13.3

6.7

6.7

26.7

100.0

To deactivate all of them back and selectively activate one of them, we should use the bracket
[] notation, as follows:

> active(filters(uind)) <- FALSE

> active(filters(uind))["dbSNP"] <- TRUE

> summary(uind)

1

2

3

4

5

6

7

8

9

1

122

0.20

SOID

SO:0002012

SO:0001631

SO:0001624

SO:0001623

Description Nr. Variants % Variants
start_lost
upstream_gene_variant
3_prime_UTR_variant
5_prime_UTR_variant
stop_gained
missense_variant
splice_donor_variant
SO:0001575
SO:0001574 splice_acceptor_variant
intron_variant
SO:0001627
synonymous_variant

SO:0001587

SO:0001583

23.87

83.56

0.20

5.28

1.96

0.59

4.11

3.52

1.37

427

27

10

21

18

1

3

7

10 SO:0001819

8

VariantFiltering: filtering of coding and non-coding genetic variants

The previous filter just selects variants with an annotated dbSNP identifier. However, other
filters may require cutoff values to decide what variants pass the filter. To set those values
we can use the function cutoffs(). For instance, in the case of the SOterms filter, we should
use set the cutoff values to select variants annotated to specific SO terms. Here we select,
for instance, those annotated in UTR regions:

> change(cutoffs(uind), "SOterms") <- "UTR_variant"
> active(filters(uind))["SOterms"] <- TRUE

> summary(uind)

[1] SOID

Description Nr. Variants % Variants

<0 rows> (or 0-length row.names)

> summary(uind, method="SOfull")

SOID Level

Description Nr. Variants % Variants

1

2

3

4

5

6

7

8

9

SO:0001624

SO:0001623

SO:0001622

SO:0001968

SO:0001791

SO:0001576

SO:0001564

SO:0001878

SO:0001537

10 SO:0001060

11 SO:0002072

8

8

3_prime_UTR_variant
5_prime_UTR_variant
UTR_variant
7
6 coding_transcript_variant
exon_variant
6
transcript_variant
gene_variant
feature_variant
structural_variant
sequence_variant
sequence_comparison

5

4

3

2

1

0

27

10

36

36

36

36

36

36

36

36

36

75

28

100

100

100

100

100

100

100

100

100

Note that the first call to summary() did not report any variant since there are no variants an-
notated to the SO term UTR_variant. However, when using the argument method="SOfull",
all variants annotated to more specific SO terms in the hierarchy will be reported.

The methods filters() and cutoffs() can be employed to extend the filtering functionality.
Here we show a simple example in which we add a filter to detect the loss of the codon that
initiates translation. This constitutes already a feature annotated by VariantFiltering so that
we can verify that it works:

> startLost <- function(x) {

mask <- start(allVariants(x, groupBy="nothing")$CDSLOC) == 1 &

as.character(allVariants(x, groupBy="nothing")$REFCODON) == "ATG" &

as.character(allVariants(x, groupBy="nothing")$VARCODON) != "ATG"

mask

+

+

+

+

+ }

> filters(uind)$startLost <- startLost

> active(filters(uind)) <- FALSE

> active(filters(uind))["startLost"] <- TRUE

> active(filters(uind))

PASS

FALSE

variantType

FALSE

codonusageFC

FALSE

INDELQual

FALSE

dbSNP

FALSE

OMIM

FALSE

maxMAF genePhyloStratum

LowQual

FALSE

SNPQual

FALSE

location

consequence

FALSE

aaChangeType

FALSE

SOterms

FALSE

maxMAF

FALSE

startLost

9

VariantFiltering: filtering of coding and non-coding genetic variants

FALSE

FALSE

FALSE

TRUE

> summary(uind)

SOID

Description Nr. Variants % Variants
start_lost
1 SO:0002012
2 SO:0001631 upstream_gene_variant
5_prime_UTR_variant
3 SO:0001623
missense_variant
4 SO:0001583
5 SO:0001575 splice_donor_variant
intron_variant
6 SO:0001627

100

100

100

100

100

100

1

1

1

1

1

1

As we can see, our filter works as expected and selects the only variant which was annotated
with the SO term start_lost. Note that there is also an additional annotation indicating
this variant belongs to an UTR region resulting from an alternative CDS.

Properly updating cutoff values may be problematic if we do not know how exactly are they
employed by the corresponding filters. To facilitate setting the right cutoff values we use the
change() method and we illustrate it on the filter of minor allele frequency (MAF) values:

> active(filters(uind)) <- FALSE

> active(filters(uind))["maxMAF"] <- TRUE

> cutoffs(uind)$maxMAF

CutoffsList of length 2

names(2): popmask maxvalue

> cutoffs(uind)$maxMAF$popmask

AFKGp1 AFR_AFKGp1 AMR_AFKGp1 ASN_AFKGp1 EUR_AFKGp1
TRUE
TRUE

TRUE

TRUE

TRUE

> cutoffs(uind)$maxMAF$maxvalue

[1] 0.5

> change(cutoffs(uind)$maxMAF, "popmask") <- FALSE

> cutoffs(uind)$maxMAF$popmask

AFKGp1 AFR_AFKGp1 AMR_AFKGp1 ASN_AFKGp1 EUR_AFKGp1
FALSE
FALSE
FALSE

FALSE

FALSE

> change(cutoffs(uind)$maxMAF, "popmask") <- c(AFKGp1=TRUE)

> cutoffs(uind)$maxMAF$popmask

AFKGp1 AFR_AFKGp1 AMR_AFKGp1 ASN_AFKGp1 EUR_AFKGp1
FALSE
FALSE

FALSE

FALSE

TRUE

> change(cutoffs(uind)$maxMAF, "maxvalue") <- 0.01

> summary(uind)

SOID

SO:0001631

SO:0001624

SO:0001623

SO:0001589

SO:0001587

SO:0001583

1

2

3

4

5

6

Description Nr. Variants % Variants

upstream_gene_variant
3_prime_UTR_variant
5_prime_UTR_variant
frameshift_variant
stop_gained
missense_variant

55

30.05

6

3

1

1

8

3.28

1.64

0.55

0.55

4.37

10

VariantFiltering: filtering of coding and non-coding genetic variants

7

8

9

splice_donor_variant
SO:0001575
SO:0001574 splice_acceptor_variant
intron_variant
SO:0001627
synonymous_variant

10 SO:0001819

2

3

157

4

1.09

1.64

85.79

2.19

In this case we selected variants with MAF< 0.01 in the global population of the 1000
Genomes project. If we are interested in retrieving the actual set of filtered variants, we can
do it using the function filteredVariants():

> filteredVariants(uind)

VRangesList of length 3

names(3): NA12878 NA12891 NA12892

To further understand how to manipulate Vranges and VRangesList objects, please consult
the package VariantAnnotation.

5

Inheritance models

We can filter upfront variants that do not segregate according to a given inheritance model.
In such a case, we also need to provide a PED file at the time we build the parameter object,
as follows:

> CEUped <- file.path(system.file("extdata", package="VariantFiltering"),

+

"CEUtrio.ped")

> param <- VariantFilteringParam(vcfFilenames=CEUvcf, pedFilename=CEUped)

Here we are using a PED file included in the VariantFiltering package and specifying infor-
mation about the CEU trio employed int his vignette.

To use an inherintance model we need to replace the previous call to unrelatedIndividuals()
by one specific to the inheritance model. The VariantFiltering package offers 5 possible ones:

• Autosomal recessive inheritance analysis: Homozygous.

Homozygous variants responsible for a recessive trait in the affected individuals can
be identified calling the autosomalRecessiveHomozygous() function. This function
selects homozygous variants that are present in all the affected individuals and occur
in heterozygosity in the unaffected ones.

• Autosomal recessive inheritance analysis: Heterozygous.

To filter by this mode of inheritance, also known as compound heterozygous, we need
two unaffected parents/ancestors and at least one affected descendant. Variants are
filtered in five steps: 1. select heterozygous variants in one of the parents and homozy-
gous in the other; 2. discard previously selected variants that are common between the
two parents; 3. group variants by gene; 4. select those genes, and the variants that
occur within them, which have two or more variants and there is at least one from
each parent; 5. from the previously selected variants, discard those that do not occur
in the affected descendants. This is implemented in the function autosomalRecessive
Heterozygous().

• Autosomal dominant inheritance analysis.

11

VariantFiltering: filtering of coding and non-coding genetic variants

The function autosomalDominant() identifies variants present in all the affected indi-
vidual(s) discarding the ones that also occur in at least one of the unaffected subjects.

• X-Linked inheritance analysis.

The function xLinked() identifies variants that appear only in the X chromosome of the
unaffected females as heterozygous, don’t appear in the unaffected males analyzed and
finally are present (as homozygous) in the affected male(s). This function is currently
restricted to affected males, and therefore, it cannot search for X-linked segregating
variants affecting daughters.

• De Novo variants analysis

The function deNovo() searches for de novo variants which are present in one de-
scendant and present in both parents/ancestors.
It is currently restricted to a trio of
individuals.

6

Create a report from the filtered variants

The function reportVariants() allows us to easily create a report from the filtered variants
into a CSV or a TSV file as follows:

> reportVariants(uind, type="csv", file="uind.csv")

The default value on the type argument ("shiny") starts a shiny web app which allows one
to interactively filter the variants, obtaining an udpated VariantFilteringResults object and
downloading the filtered variants and the corresponding full reproducible R code, if necessary.

Figure 2: Snapshot of the shiny web app run from VariantFiltering with the function reportVariants().
Some of the parameters has been filled for illustrative purposes.

12

VariantFiltering: filtering of coding and non-coding genetic variants

7

Using the package with parallel execution

Functions in VariantFiltering to annotate and filter variants leverage the functionality of the
Bioconductor package BiocParallel to perform in parallel some of the tasks and calculations
and reduce the overall execution time. These functions have an argument called BPPARAM that
allows the user to control how this parallelism is exploited. In particular the user must give
as value to this argument the result from a call to the function bpparam(), which actually
is its default behavior. Here below we modify that behavior to force a call being executed
without parallelism. The interested reader should consult the help page of bpparam() and
the vignette of the BiocParallel for further information.

8

Session information

> toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: AnnotationDbi 1.72.0, BSgenome 1.78.0,

BSgenome.Hsapiens.1000genomes.hs37d5 0.99.1, Biobase 2.70.0,
BiocGenerics 0.56.0, BiocIO 1.20.0, Biostrings 2.78.0, GenomicFeatures 1.62.0,
GenomicRanges 1.62.0, GenomicScores 2.22.0, IRanges 2.44.0,
MafDb.1Kgenomes.phase1.hs37d5 3.10.0, MatrixGenerics 1.22.0,
PolyPhen.Hsapiens.dbSNP131 1.0.2, RSQLite 2.4.3, Rsamtools 2.26.0,
S4Vectors 0.48.0, SIFT.Hsapiens.dbSNP137 1.0.0,
SNPlocs.Hsapiens.dbSNP144.GRCh37 0.99.20, Seqinfo 1.0.0,
SummarizedExperiment 1.40.0, TxDb.Hsapiens.UCSC.hg19.knownGene 3.22.1,
VariantAnnotation 1.56.0, VariantFiltering 1.46.0, XVector 0.50.0, generics 0.1.4,
matrixStats 1.5.0, org.Hs.eg.db 3.22.0, phastCons100way.UCSC.hg19 3.7.2,
rtracklayer 1.70.0

• Loaded via a namespace (and not attached): AnnotationFilter 1.34.0,
AnnotationHub 4.0.0, BiocFileCache 3.0.0, BiocManager 1.30.26,
BiocParallel 1.44.0, BiocStyle 2.38.0, BiocVersion 3.22.0, DBI 1.2.3, DT 0.34.0,
DelayedArray 0.36.0, Formula 1.2-5, GenomeInfoDb 1.46.0,
GenomicAlignments 1.46.0, Gviz 1.54.0, HDF5Array 1.38.0, Hmisc 5.2-4,
KEGGREST 1.50.0, Matrix 1.7-4, ProtGenerics 1.42.0, R6 2.6.1, RBGL 1.86.0,

13

VariantFiltering: filtering of coding and non-coding genetic variants

RColorBrewer 1.1-3, RCurl 1.98-1.17, Rcpp 1.1.0, Rhdf5lib 1.32.0, S4Arrays 1.10.0,
S7 0.2.0, SparseArray 1.10.0, UCSC.utils 1.6.0, XML 3.99-0.19, abind 1.4-8,
backports 1.5.0, base64enc 0.1-3, biomaRt 2.66.0, biovizBase 1.58.0, bit 4.6.0,
bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4, cachem 1.1.0, checkmate 2.3.3,
cigarillo 1.0.0, cli 3.6.5, cluster 2.1.8.1, codetools 0.2-20, colorspace 2.1-2,
compiler 4.5.1, crayon 1.5.3, curl 7.0.0, data.table 1.17.8, dbplyr 2.5.1, deldir 2.0-4,
dichromat 2.0-0.1, digest 0.6.37, dplyr 1.1.4, ensembldb 2.34.0, evaluate 1.0.5,
farver 2.1.2, fastmap 1.2.0, filelock 1.0.3, foreign 0.8-90, ggplot2 4.0.0, glue 1.8.0,
graph 1.88.0, grid 4.5.1, gridExtra 2.3, gtable 0.3.6, h5mread 1.2.0, hms 1.1.4,
htmlTable 2.4.3, htmltools 0.5.8.1, htmlwidgets 1.6.4, httpuv 1.6.16, httr 1.4.7,
httr2 1.2.1, interp 1.1-6, jpeg 0.1-11, jsonlite 2.0.0, knitr 1.50, later 1.4.4,
lattice 0.22-7, latticeExtra 0.6-31, lazyeval 0.2.2, lifecycle 1.0.4, magrittr 2.0.4,
memoise 2.0.1, mime 0.13, nnet 7.3-20, otel 0.2.0, parallel 4.5.1, pillar 1.11.1,
pkgconfig 2.0.3, png 0.1-8, prettyunits 1.2.0, progress 1.2.3, promises 1.4.0,
rappdirs 0.3.3, restfulr 0.0.16, rhdf5 2.54.0, rhdf5filters 1.22.0, rjson 0.2.23,
rlang 1.1.6, rmarkdown 2.30, rpart 4.1.24, rstudioapi 0.17.1, scales 1.4.0,
shiny 1.11.1, shinyTree 0.3.1, shinyjs 2.1.0, shinythemes 1.2.0, stringi 1.8.7,
stringr 1.5.2, tibble 3.3.0, tidyselect 1.2.1, tools 4.5.1, vctrs 0.6.5, xfun 0.53,
xtable 1.8-4, yaml 2.3.10

14

