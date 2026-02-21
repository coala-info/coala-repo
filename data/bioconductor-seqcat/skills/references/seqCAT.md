# seqCAT: The High Throughput Sequencing Cell Authentication Toolkit

Erik Fasterius

#### 2025-10-30

#### Package

seqCAT 1.32.0

# 1 Introduction

This vignette describes the use of the *seqCAT* package for authentication,
characterisation and evaluation of two or more *High Throughput Sequencing*
samples (HTS; RNA-seq or whole genome sequencing). The principle of the method
is built upon previous work, where it was demonstrated that analysing the
entirety of the variants found in HTS data provides unprecedented statistical
power and great opportunities for functional evaluation of genetic similarities
and differences between biological samples *(Fasterius et al. [2017](#ref-Fasterius2017); Fasterius and Szigyarto [2018](#ref-Fasterius2018))*.

The seqCAT package work by creating *Single Nucelotide Variant* (SNV) profiles
of every sample of interest, followed by comparisons between each set to find
overall genetic similarity, in addition to detailed analyses of the
differences. By analysing your data with this workflow you will not only be
able to authenticate your samples to a high degree of confidence, but you will
also be able to investigate what genes and transcripts are affected by SNVs
differing between your samples, what biological effect they will have, and
more. The workflow consists of three separate steps:

```
1.  Creation of SNV profiles
2.  Comparisons of SNV profiles
3.  Authentication, characterisation and evaluation of profile comparisons
```

Each step has its own section(s) below demonstrating how to perform the
analyses. Input data should be in the form of [VCF files](https://software.broadinstitute.org/gatk/), *i.e*
output from variant callers such as the [Genome Analysis ToolKit](http://www.internationalgenome.org/wiki/Analysis/variant-call-format) and
optionally annotated with software such as [SnpEff](http://snpeff.sourceforge.net/).

## 1.1 Installation

The latest stable release of this package can be found on
[Bioconductor](http://bioconductor.org/) and installed with:

```
install.packages("BiocManager")
BiocManager::install("seqCAT")
```

This will also install any missing packages requires for full functionality,
should they not already exist in your system. If you haven’t installed
Bioconductor, you can do so by simply calling `BiocManager::install()` without
specifying a package, and it will be installed for you. You can read more about
this at Bioconductor’s [installation page](http://bioconductor.org/install/). You can also find the
development version of seqCAT on [GitHub](https://github.com/fasterius/seqCAT), which can be installed like
so:

```
install.packages("devtools")
devtools::install_github("fasterius/seqCAT")
```

# 2 Creation of SNV profiles

The first step of the workflow is to create the SNV profile of each sample,
which can then be compared to each other. The creation of a SNV profile
includes filtering of low-confidence variants, removal of variants below a
sequencing depth threshold (`10` by default), de-duplication of variants and an
optional removal of mitochondrial variants (`TRUE` by default). For annotated
VCF files, only records with the highest SNV impact (*i.e.* [impact](http://snpeff.sourceforge.net/SnpEff_manual.html#eff) on
protein function) for each variant is kept, as they are most likely to affect
the biology of the cells.

## 2.1 Create individual profiles

Throughout this vignette we will be using some example data, `example.vcf.gz`,
which comes from the initial publication of the general process of this method
*(Fasterius et al. [2017](#ref-Fasterius2017))*. It is a simplified multi-sample VCF file on a subset of
chromosome 12 (containing all variants up to position `25400000`, in order to
keep the file size low) for three different colorectal cancer cell lines:
*HCT116*, *HKE3* and *RKO*. The first step is to load the `seqCAT` package and
to create SNV profiles for each sample:

```
# Load the package
library("seqCAT")

# List the example VCF file
vcf <- system.file("extdata", "example.vcf.gz", package = "seqCAT")

# Create two SNV profiles
hct116 <- create_profile(vcf, "HCT116")
head(hct116)
```

```
##   chr   pos        rsID               gene          ENSGID          ENSTID REF
## 1  12 80385 rs370087224 ABC7-42389800N19.1 ENSG00000226210 ENST00000400706   C
## 2  12 80399        None ABC7-42389800N19.1 ENSG00000226210 ENST00000400706   G
## 3  12 80422 rs373297723 ABC7-42389800N19.1 ENSG00000226210 ENST00000400706   G
## 4  12 80729 rs375960073 ABC7-42389800N19.1 ENSG00000226210 ENST00000400706   A
## 5  12 83011 rs370570891 ABC7-42389800N19.1 ENSG00000226210 ENST00000400706   T
## 6  12 83012 rs374646339 ABC7-42389800N19.1 ENSG00000226210 ENST00000400706   C
##   ALT   impact         effect    feature                biotype DP AD1 AD2 A1
## 1   T MODIFIER intron_variant transcript unprocessed_pseudogene 10   8   2  C
## 2   A MODIFIER intron_variant transcript unprocessed_pseudogene 10   4   6  G
## 3   A MODIFIER intron_variant transcript unprocessed_pseudogene 15  11   4  G
## 4   G MODIFIER intron_variant transcript unprocessed_pseudogene 18  13   5  A
## 5   C MODIFIER intron_variant transcript unprocessed_pseudogene 10   3   7  T
## 6   G MODIFIER intron_variant transcript unprocessed_pseudogene 10   3   7  C
##   A2 FILTER warnings sample
## 1  T   PASS          HCT116
## 2  A   PASS          HCT116
## 3  A   PASS          HCT116
## 4  G   PASS          HCT116
## 5  C   PASS          HCT116
## 6  G   PASS          HCT116
```

The SNV profile lists all the variants present in the VCF file, in addition
to any annotations present. This means that information pertaining to the
genomic position (`chr` and `pos`), reference and alternative alleles (`REF`
and `ALT`), genotype (`A1` and `A2`) and depth (`DP`, variant depth; `AD1` and
`AD2`, allelic depth) are always going to be present in all profiles. The
profiles creates here also contain additional annotations from
[SnpEff](http://snpeff.sourceforge.net/), such as gene (`ENSGID`), variant [impact](http://snpeff.sourceforge.net/SnpEff_manual.html#eff) (`impact`)
and variant accession (`rsID`).

## 2.2 Variant filtration

The creation of SNV profiles include several optional variant filtration steps,
including criteria for sequencing depth, variant caller-specific thresholds,
mitochondrial variants, variants in non-standard chromosomes and variants
duplicated at either the gene-level or positional level. The `create_profile`
function performs all of these by default (with a sequencing depth of at least
10 and de-duplication at the gene-level), but you can omit or change these as
required, like so:

```
rko <- create_profile(vcf, "RKO", min_depth = 15, filter_gd = FALSE)
```

The profile of this sample (`RKO`) was created with a non-standard filter for
sequencing depth (`min_depth = 15`), which should only be done if you want a
stricter criteria for your profile (such as when you’re only interested in
higher-than-standard confidence variants).

You may also choose to not remove variants using the variant caller-specific
filtering criteria by passing `filter_vc = FALSE` when creating your profile,
although it is recommended to do so in most cases in order to minimise the
number of false positive variant calls. Mitochondrial variants are removed by
default, but may be kept by passing `filter_mt = FALSE`; the same goes for
non-standard chromosomes and the `filter_ns` parameter.

Duplicate variants can either be removed at the gene-level (`filter_gd = TRUE`
by default) or at the positional level (`filter_pd = FALSE` by default). The
former will remove variants that have more than one entry on a per-gene basis
(*i.e.* variants that affect more than one transcript for the same gene), but
keep multiple entries for variants affecting more than one gene; the impact is
used to determine which of the same-gene variants to keep. The latter will
remove duplicated variants purely by their position, regardless of the genes or
transcripts they affect. It is thus important to know what type of downstream
analyses you want to perform at this stage: if analysis of which genes or
transcripts are affected by the variants is desired, duplicates should either
be remove at the gene-level or not at all; if only not, variant duplicates may
be remove at the positional level.

Filtration can also be performed after the initial SNV profile creation, using
two separate functions:

```
# Filter on sequencing depth
rko_filtered <- filter_variants(rko, min_depth = 20)

# Filter position-level variants duplicates
rko_deduplicated <- filter_duplicates(rko, filter_pd = TRUE)
```

## 2.3 Create multiple profiles

The `create_profiles` function is a convenience wrapper for `create_profile`,
which will create SNV profiles for each VCF file in a given input directory and
return them as a list. You can use it for all the VCFs in a directory or a
subset specified by a string, like so:

```
# Directory with VCF files
vcf_dir <- system.file("extdata", package = "seqCAT")

# Create profiles for each VCF with "sample1" in its name
profiles <- create_profiles(vcf_dir, pattern = "sample1")
```

## 2.4 Create COSMIC profiles

It is also possible to to compare your samples’ variants to some external
source. Such a source is the *Catalogue of somatic mutations in cancer*, or
*COSMIC*. *(Forbes et al. [2015](#ref-Forbes2015))* COSMIC has over a thousand cell line-specific
mutational profiles as well as a comprehensive list of cancer mutations in
across many carcinoma samples, and is thus a very useful resource.

In order to use the COSMIC database, you need to sign up for an account at
their [website](http://cancer.sanger.ac.uk/cosmic) and get permission to download their files (which
is given free of charge to academia and non-profit organisation, but requires a
commersial license for for-profit organisations). SeqCAT can analyse both the
cell line-specific (the `CosmicCLP_MutantExport.tsv.gz` file) and cancer
mutation data (the `CosmicCompleteTargetedScreensMutantExport.tsv.gz` file)
that can be found [here](http://cancer.sanger.ac.uk/cell_lines/download). As redistributing this data is not
allowed, this package includes an extremely minimal subset of the original
files, only useful for examples in this vignette and unit testing. *Do not* use
these file for your own analyses, as your results will neither be complete nor
accurate!

Here we present an example of how to analyse some cell line-specific COSMIC
data. The first thing to check is to see if your specific cell line is
available in the database, which can be accomplished using the `list_cosmic`
function:

```
file <- system.file("extdata", "subset_CosmicCLP_MutantExport.tsv.gz",
                    package = "seqCAT")
cell_lines <- list_cosmic(file)
head(cell_lines)
```

```
## [1] "639V"  "A427"  "A549"  "AGS"   "AMO1"  "AN3CA"
```

This gives us a simple vector containing all the available sample names in the
COSMIC database (this version of the file is for the GRCh37 assembly). You can
search it for a cell line of your choice:

```
any(grepl("HCT116", cell_lines))
```

```
## [1] TRUE
```

All COSMIC-related functions perform some simplification of sample names (as
there is variation in the usage of dashes, dots and other symbols), and are
case-insensitive. When you have asserted that your sample of interest is
available, you can then read the profile for that sample using the
`read_cosmic` function:

```
cosmic <- read_cosmic(file, "HCT116")
head(cosmic)
```

```
##    chr      pos REF ALT A1 A2 gene          ENSTID gene_cds_length hgnc_id
## 43  12 25398281   C   T  C  T KRAS ENST00000311936             567    6407
##           sample id_sample id_tumour    primary_site site_subtype_1
## 43 COSMIC.HCT116    905936    823462 LARGE_INTESTINE          colon
##    site_subtype_2 site_subtype_3 primary_histology histology_subtype_1
## 43             NS             NS         carcinoma                  NS
##    histology_subtype_2 histology_subtype_3 genome_wide_screen      id     cds
## 43                  NS                  NS                  y COSM532 c.38G>A
##        aa             description loh grch snp fathmm_prediction fathmm_score
## 43 p.G13D Substitution - Missense   u   37   n        PATHOGENIC      0.97875
##                                  somatic_status verification_status pubmed_pmid
## 43 Reported in another cancer sample as somatic            Verified          NA
##    id_study                          institute
## 43      619 Developmental Therapeutics Program
##                               institute_address catalogue_number sample_source
## 43 National Cancer Institute,Frederick,MD 21701                      cell-line
##    tumour_origin age
## 43       primary  NA
```

You now have a small, COSMIC SNV profile for your cell line, which you can
compare to any other profile you may have data for (more on this below). You
can also check how many variants are listed in COSMIC for your particular cell:

```
nrow(cosmic)
```

```
## [1] 1
```

Here we only see a single variant for the HCT116 cell line, which is only
because of the extreme small subset of the COSMIC databse being used here.
HCT116 has, in fact, over 2000 listed COSMIC SNVs, making it one of the more
abundantly characterised cell lines available (as most cell lines has only a
few hundred SNVs listed in COSMIC). A COSMIC profile of a couple of hundred
variants is more common, though, and any analysis based only on COSMIC variants
is thus inherently limited.

## 2.5 Working with profiles on disk

While computation time is usually not an issue for simple binary comparisons
(*i.e.* comparisons with only two samples), this can quickly become a concern
for analyses where samples are compared to several others (A vs B, A vs C, …,
and so on); this is doubly true for annotated VCF files. It can thus be highly
useful to save profiles to disk in some cases, in order to facilitate
re-analysis at a later stage. This can be done with the `write_profile`
function:

```
write_profile(hct116, "hct116.profile.txt")
```

You may also store profiles in several other formats, including BED, GTF and
GFF; these are automatically detected based on the filename:

```
write_profile(hct116, "hct116.profile.bed")
```

The `write_profiles` function is a convenience-wrapper from `write_profile`,
which can save many profiles (stored in a list) to disk at the same time:

```
write_profiles(profiles, format = "GTF", directory = "./")
```

Profiles stored on disk may be read into R again at a later time using the
`read_profile` function:

```
hct116 <- read_profile("hct116.profile.txt")
```

The `read_profiles` function is a convenience-wrapper for `read_profile`, which
will automatically read all the profiles present in a given directory (based on
the `pattern` argument) and return them as a list.

```
profile_list <- read_profiles(profile_dir = "./", pattern = ".gtf")
head(profile_list[[1]])
```

```
##   chr   pos        rsID    gene          ENSGID          ENSTID REF ALT
## 1   1 16229        None DDX11L1 ENSG00000223972 ENST00000456328   C   A
## 2   1 16298 rs200451305 DDX11L1 ENSG00000223972 ENST00000456328   C   T
## 3   1 16495 rs141130360 DDX11L1 ENSG00000223972 ENST00000450305   G   C
## 4   1 16495 rs141130360  WASH7P ENSG00000227232 ENST00000423562   G   C
## 5   1 16534 rs201459529 DDX11L1 ENSG00000223972 ENST00000450305   C   T
## 6   1 16534 rs201459529  WASH7P ENSG00000227232 ENST00000423562   C   T
##     impact                  effect    feature
## 1 MODIFIER downstream_gene_variant transcript
## 2 MODIFIER downstream_gene_variant transcript
## 3 MODIFIER downstream_gene_variant transcript
## 4 MODIFIER          intron_variant transcript
## 5 MODIFIER downstream_gene_variant transcript
## 6 MODIFIER          intron_variant transcript
##                              biotype DP AD1 AD2 A1 A2 FILTER warnings  sample
## 1               processed_transcript 27  21   6  C  A   PASS          sample1
## 2               processed_transcript 19   8  11  C  T   PASS          sample1
## 3 transcribed_unprocessed_pseudogene 33  24   9  G  C   PASS          sample1
## 4             unprocessed_pseudogene 33  24   9  G  C   PASS          sample1
## 5 transcribed_unprocessed_pseudogene 22  13   9  C  T   PASS          sample1
## 6             unprocessed_pseudogene 22  13   9  C  T   PASS          sample1
```

# 3 Comparing SNV profiles

## 3.1 Comparing full profiles

Once each relevant sample has its own SNV profile the comparisons can be
performed. SNV profiles contain most of the relevant annotation data from the
original VCF file, including SNV impacts, gene/transcript IDs and mutational
(rs) ID. The `DP` (depth) field lists the total sequencing depth of this
variant, while the specific allelic depths can be found in `AD1` and `AD2`. The
alleles of each variant can be found in `A1` and `A2`.

Once each profile has been defined, the genotypes of the overlapping variants
between them can be compared using the `compare_profiles` function. Only
variants found in both profiles are considered to overlap by default, as
similarity calculations between profiles where some variants only have
confident calls in one of the samples may be inappropriate. An SNV is
considered a match if it has an identical genotype in both profiles.

```
hct116_rko <- compare_profiles(hct116, rko)
head(hct116_rko)
```

```
##   chr   pos sample_1 sample_2 match        rsID               gene
## 1  12 80729   HCT116      RKO match rs375960073 ABC7-42389800N19.1
## 2  12 83508   HCT116      RKO match rs374142069 ABC7-42389800N19.1
## 3  12 83560   HCT116      RKO match rs368663404 ABC7-42389800N19.1
## 4  12 83979   HCT116      RKO match rs369733672 ABC7-42389800N19.1
## 5  12 84000   HCT116      RKO match rs374158904 ABC7-42389800N19.1
## 6  12 84096   HCT116      RKO match rs376990822 ABC7-42389800N19.1
##            ENSGID          ENSTID REF ALT   impact         effect    feature
## 1 ENSG00000226210 ENST00000400706   A   G MODIFIER intron_variant transcript
## 2 ENSG00000226210 ENST00000400706   T   G MODIFIER intron_variant transcript
## 3 ENSG00000226210 ENST00000400706   G   T MODIFIER intron_variant transcript
## 4 ENSG00000226210 ENST00000400706   T   C MODIFIER intron_variant transcript
## 5 ENSG00000226210 ENST00000400706   C   G MODIFIER intron_variant transcript
## 6 ENSG00000226210 ENST00000400706   C   G MODIFIER intron_variant transcript
##                  biotype DP.HCT116 AD1.HCT116 AD2.HCT116 A1.HCT116 A2.HCT116
## 1 unprocessed_pseudogene        18         13          5         A         G
## 2 unprocessed_pseudogene        26         21          5         T         G
## 3 unprocessed_pseudogene        21         14          7         G         T
## 4 unprocessed_pseudogene        51         42          9         T         C
## 5 unprocessed_pseudogene        52         42         10         C         G
## 6 unprocessed_pseudogene        65         49         16         C         G
##   FILTER.HCT116 warnings.HCT116 DP.RKO AD1.RKO AD2.RKO A1.RKO A2.RKO FILTER.RKO
## 1          PASS                     15       8       7      A      G       PASS
## 2          PASS                     17       6      11      T      G       PASS
## 3          PASS                     16       4      12      G      T       PASS
## 4          PASS                     23      14       9      T      C       PASS
## 5          PASS                     18       9       9      C      G       PASS
## 6          PASS                     18      10       8      C      G       PASS
##   warnings.RKO
## 1
## 2
## 3
## 4
## 5
## 6
```

The resulting dataframe retains all the information from each input profile
(including any differing annotation, should they exist), and lists the depths
and alleles by adding the sample names as suffixes to the relevant column
names. An optional parameter, `mode`, can also be supplied: the default value
(`"intersection"`) discards any non-overlapping variants in the comparison,
while setting it to `"union"` will retain them.

```
hct116_rko_union <- compare_profiles(hct116, rko, mode = "union")
head(hct116_rko_union)
```

```
##   chr   pos sample_1 sample_2       match        rsID               gene
## 1  12 80385   HCT116      RKO HCT116_only rs370087224 ABC7-42389800N19.1
## 2  12 80399   HCT116      RKO HCT116_only        None ABC7-42389800N19.1
## 3  12 80422   HCT116      RKO HCT116_only rs373297723 ABC7-42389800N19.1
## 4  12 80610   HCT116      RKO    RKO_only        None ABC7-42389800N19.1
## 5  12 80729   HCT116      RKO       match rs375960073 ABC7-42389800N19.1
## 6  12 83011   HCT116      RKO HCT116_only rs374646339 ABC7-42389800N19.1
##            ENSGID          ENSTID REF ALT   impact         effect    feature
## 1 ENSG00000226210 ENST00000400706   C   T MODIFIER intron_variant transcript
## 2 ENSG00000226210 ENST00000400706   G   A MODIFIER intron_variant transcript
## 3 ENSG00000226210 ENST00000400706   G   A MODIFIER intron_variant transcript
## 4 ENSG00000226210 ENST00000400706   C   G MODIFIER intron_variant transcript
## 5 ENSG00000226210 ENST00000400706   A   G MODIFIER intron_variant transcript
## 6 ENSG00000226210 ENST00000400706   C   G MODIFIER intron_variant transcript
##                  biotype DP.HCT116 AD1.HCT116 AD2.HCT116 A1.HCT116 A2.HCT116
## 1 unprocessed_pseudogene        10          8          2         C         T
## 2 unprocessed_pseudogene        10          4          6         G         A
## 3 unprocessed_pseudogene        15         11          4         G         A
## 4 unprocessed_pseudogene
## 5 unprocessed_pseudogene        18         13          5         A         G
## 6 unprocessed_pseudogene        10          3          7         C         G
##   FILTER.HCT116 warnings.HCT116 DP.RKO AD1.RKO AD2.RKO A1.RKO A2.RKO FILTER.RKO
## 1          PASS
## 2          PASS
## 3          PASS
## 4                                   16      11       5      C      G       PASS
## 5          PASS                     15       8       7      A      G       PASS
## 6          PASS
##   warnings.RKO
## 1
## 2
## 3
## 4
## 5
## 6
```

## 3.2 Comparing to COSMIC profiles

If you only want to analyse a subset of your data or as a orthogonal method
complementary to others, you could compare your profile to a COSMIC profile.
This works in the same way as comparing to another full profile, but gives
slightly different output:

```
hct116_cosmic <- compare_profiles(hct116, cosmic)
head(hct116_cosmic)
```

```
##   chr      pos sample_1      sample_2 match        rsID          ENSGID
## 1  12 25398281   HCT116 COSMIC.HCT116 match rs112445441 ENSG00000133703
##     impact           effect    feature        biotype gene
## 1 MODERATE missense_variant transcript protein_coding KRAS
##                              ENSTID REF ALT DP.HCT116 AD1.HCT116 AD2.HCT116
## 1 [ENST00000256078,ENST00000311936]   C   T       180         96         84
##   A1.HCT116 A2.HCT116 FILTER.HCT116 warnings.HCT116 A1.COSMIC.HCT116
## 1         C         T          PASS                                C
##   A2.COSMIC.HCT116 gene_cds_length.COSMIC.HCT116 hgnc_id.COSMIC.HCT116
## 1                T                           567                  6407
##   id_sample.COSMIC.HCT116 id_tumour.COSMIC.HCT116 primary_site.COSMIC.HCT116
## 1                  905936                  823462            LARGE_INTESTINE
##   site_subtype_1.COSMIC.HCT116 site_subtype_2.COSMIC.HCT116
## 1                        colon                           NS
##   site_subtype_3.COSMIC.HCT116 primary_histology.COSMIC.HCT116
## 1                           NS                       carcinoma
##   histology_subtype_1.COSMIC.HCT116 histology_subtype_2.COSMIC.HCT116
## 1                                NS                                NS
##   histology_subtype_3.COSMIC.HCT116 genome_wide_screen.COSMIC.HCT116
## 1                                NS                                y
##   id.COSMIC.HCT116 cds.COSMIC.HCT116 aa.COSMIC.HCT116 description.COSMIC.HCT116
## 1          COSM532           c.38G>A           p.G13D   Substitution - Missense
##   loh.COSMIC.HCT116 grch.COSMIC.HCT116 snp.COSMIC.HCT116
## 1                 u                 37                 n
##   fathmm_prediction.COSMIC.HCT116 fathmm_score.COSMIC.HCT116
## 1                      PATHOGENIC                    0.97875
##                   somatic_status.COSMIC.HCT116
## 1 Reported in another cancer sample as somatic
##   verification_status.COSMIC.HCT116 pubmed_pmid.COSMIC.HCT116
## 1                          Verified
##   id_study.COSMIC.HCT116            institute.COSMIC.HCT116
## 1                    619 Developmental Therapeutics Program
##                institute_address.COSMIC.HCT116 catalogue_number.COSMIC.HCT116
## 1 National Cancer Institute,Frederick,MD 21701
##   sample_source.COSMIC.HCT116 tumour_origin.COSMIC.HCT116 age.COSMIC.HCT116
## 1                   cell-line                     primary
```

You can use all the functions for downstream analyses for comparisons with
COSMIC data, but your options for functional analyses will be limited, given
that the COSMIC database is biased towards well-known and characterised
mutations. It is, however, an excellent way to authenticate your cell lines and
to assert the status of the mutations that exist in the analysed cells.

# 4 Evaluating binary comparisons

## 4.1 Similarity and global statistics

When you have your matched, overlapping SNVs, it’s time to analyse and
characterise them. The first thing you might want to check are the global
similarities and summary statistics, which can be done with the
`calculate_similarity` function. The `concordance` is simply the number of
matching genotypes divided by the total number of overlapping variants, while
the `similarity score` is a weighted measure of the concordance in the form of
a binomial experiment, taking into account the number of overlapping variants
available:

\[Similarity = \frac{s + a}{n + a + b}\]

… where `s` is the number of matching genotypes, `n` is the total number of
overlapping SNVs, `a` and `b` being the parameters used to weigh the
concordance in favour of comparisons with more overlaps. The default
parameters of `1` and `5` were selected to yield an equivalent cutoff to one
suggested by Yu *et al.* (2015), which results in a lower limit 44 of perfectly
matching overlapping variants with a similarity score of 90. The similarity
score is thus a better measure of biological equivalency than just the
concordance.

```
similarity <- calculate_similarity(hct116_rko)
similarity
```

```
##   sample_1 sample_2 variants_1 variants_2 overlaps matches concordance
## 1   HCT116      RKO        259        259      259     181        69.9
##   similarity_score
## 1             68.7
```

Here, you can see a summary of the relevant statistics for your particular
comparison: the number of total variants from each profile (if the comparison
was done with `mode = "union"`, otherwise this number will just be equivalent
to the overlaps), the number of overlaps between your two samples, the number
of matching genotypes, their concordance as well as their similarity score. The
cutoff used by Yu *et al.* for cell line authenticity was `90 %` for their 48
SNP panel, something that could be considered the baseline for this method as
well. The score, `68.7`, is well below that cutoff, and we can thus be certain
that these two cells are indeed not the same (as expected). While hard
thresholds for similarity are inadvisable, a general guideline is that
comparisons with scores above `90` can be considered similar while those below
can be considered dissimilar. While a score just below `90` does not mean that
the cells definitely are different, it *does* mean that more rigorous
evaluation needs to be performed in order to ensure their biological
equivalency. Are there specific genes or regions that are of special interest,
for example? If so, it might be informative to specifically investigate the
similarity there (more on this [below](#evaluation-of-specific-chromosomes-regions-genes-and-transcripts)).

You may additionally change the parameters of the score (if you, for example,
want a stricter calculation). You may also supply the `calculate_similarity`
function with an existing dataframe with summary data produced previously, in
order to aggregate scores and statistics for an arbitrary number of
comparisons.

```
# Create and read HKE3 profile
hke3 <- create_profile(vcf, "HKE3")

# Compare HCT116 and HKE3
hct116_hke3 <- compare_profiles(hct116, hke3)

# Add HCT116/HKE3 similarities to HCT116/RKO similarities
similarities <- calculate_similarity(hct116_hke3, similarity, b = 10)
similarities
```

```
##   sample_1 sample_2 variants_1 variants_2 overlaps matches concordance
## 1   HCT116      RKO        259        259      259     181        69.9
## 2   HCT116     HKE3        493        493      493     475        96.3
##   similarity_score
## 1             68.7
## 2             94.4
```

Notice that the new `similarities` dataframe contains both the comparisons of
HCT116/RKO and HCT116/HKE3, and we can clearly see that HCT116 and HKE3 are
indeed very similar, as expected (HKE3 was derived from HCT116). This is true
even when using a higher value for the `b` parameter. Any number of samples can
be added using the `calculate_similarity` function, for use in further
downstream analyses.

## 4.2 Evaluation of SNV impacts

An SNV’s [impact](http://snpeff.sourceforge.net/SnpEff_manual.html#eff) represent the putative effect that variant may have on the
function of the resulting protein, and ranges from HIGH through MODERATE, LOW
and MODIFIER, in decreasing order of magnitude. HIGH impact variants may, for
example, lead to truncated proteins due to the introduction of a stop codon,
while MODIFIER variants have little to no effect on the protein at all. While
there is no guarantee that a specific phenotype arises from a HIGH rather than
a MODERATE impact variant (for example), it may be informative to look at the
impact distribution of the overlapping SNVs between two profiles. This can
easily be performed by the `plot_impacts` function:

```
impacts <- plot_impacts(hct116_rko)
```

```
## Warning: `separate_()` was deprecated in tidyr 1.2.0.
## ℹ Please use `separate()` instead.
## ℹ The deprecated feature was likely used in the seqCAT package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the seqCAT package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning in ggplot2::geom_bar(stat = "identity", position = "dodge", colour =
## "#000000", : Ignoring unknown parameters: `size`
```

```
impacts
```

![](data:image/png;base64...)

This function takes a comparison dataframe as input and plots the impact
distribution of the overlapping variants. It has a number of arguments with
defaults, such as if you want to add text with the actual numbers to the plot
(`annotate = TRUE` by default), if you want to show the legend (`legend = TRUE` by default) and what colours you want to plot the match-categories with
(`palette = c("#0D2D59", "#1954A6")` by default, two shades of blue). We can
see that most of the SNVs are present in the MODIFIER impact category, and that
there is not a single mismatched HIGH impact SNV. (You can also visualise the
impact distribution between your sample and the COSMIC database in exactly the
same way.)

You might also want to look at only a subset of variants, *e.g.* only the
variants with HIGH or MODERATE impacts, which is easily achieved with some data
manipulation:

```
hct116_rko_hm <- hct116_rko[hct116_rko$impact == "HIGH" |
                            hct116_rko$impact == "MODERATE", ]
nrow(hct116_rko_hm)
```

```
## [1] 19
```

## 4.3 Evaluation of specific chromosomes, regions, genes and transcripts

You might be interested in a specific chromosome or a region on a chromosome,
and it might be useful to work with data for only that subset. This operation
is easily performed on a comparison dataframe:

```
hct116_rko_region <- hct116_rko[hct116_rko$chr == 12 &
                                hct116_rko$pos >= 25000000 &
                                hct116_rko$pos <= 30000000, ]
head(hct116_rko_region)
```

```
##     chr      pos sample_1 sample_2 match      rsID  gene          ENSGID
## 247  12 25358650   HCT116      RKO match   rs12245 LYRM5 ENSG00000205707
## 248  12 25358828   HCT116      RKO match   rs12587 LYRM5 ENSG00000205707
## 249  12 25358943   HCT116      RKO match    rs8720 LYRM5 ENSG00000205707
## 250  12 25358969   HCT116      RKO match rs1137196 LYRM5 ENSG00000205707
## 251  12 25359328   HCT116      RKO match rs1137189 LYRM5 ENSG00000205707
## 252  12 25359352   HCT116      RKO match rs1137188 LYRM5 ENSG00000205707
##                                ENSTID REF ALT   impact                  effect
## 247 [ENST00000381356,ENST00000557540]   A   T MODIFIER downstream_gene_variant
## 248 [ENST00000381356,ENST00000557540]   T   G MODIFIER downstream_gene_variant
## 249 [ENST00000381356,ENST00000557540]   T   C MODIFIER downstream_gene_variant
## 250 [ENST00000381356,ENST00000557540]   T   G MODIFIER downstream_gene_variant
## 251 [ENST00000381356,ENST00000557540]   A   T MODIFIER downstream_gene_variant
## 252 [ENST00000381356,ENST00000557540]   G   A MODIFIER downstream_gene_variant
##        feature        biotype DP.HCT116 AD1.HCT116 AD2.HCT116 A1.HCT116
## 247 transcript protein_coding       351        196        155         A
## 248 transcript protein_coding       382        224        158         T
## 249 transcript protein_coding       380        223        157         T
## 250 transcript protein_coding       306        184        122         T
## 251 transcript protein_coding       436        282        154         A
## 252 transcript protein_coding       407        242        165         G
##     A2.HCT116 FILTER.HCT116 warnings.HCT116 DP.RKO AD1.RKO AD2.RKO A1.RKO
## 247         T          PASS                    414     217     197      A
## 248         G          PASS                    422     244     178      T
## 249         C          PASS                    420     238     182      T
## 250         G          PASS                    349     200     149      T
## 251         T          PASS                    508     297     211      A
## 252         A          PASS                    507     270     237      G
##     A2.RKO FILTER.RKO warnings.RKO
## 247      T       PASS
## 248      G       PASS
## 249      C       PASS
## 250      G       PASS
## 251      T       PASS
## 252      A       PASS
```

You might also be interested in a specific gene or transcript, of special
importance to your study:

```
hct116_rko_eps8_t <- hct116_rko[hct116_rko$ENSTID == "ENST00000281172", ]
hct116_rko_vamp1 <- hct116_rko[hct116_rko$ENSGID == "ENSG00000139190", ]
hct116_rko_ldhb <- hct116_rko[hct116_rko$gene == "LDHB", ]
head(hct116_rko_ldhb)
```

```
##     chr      pos sample_1 sample_2    match      rsID gene          ENSGID
## 243  12 21788465   HCT116      RKO mismatch      None LDHB ENSG00000111716
## 244  12 21797029   HCT116      RKO    match rs1650294 LDHB ENSG00000111716
##                                ENSTID REF ALT   impact
## 243 [ENST00000350669,ENST00000542765]   G   T MODIFIER
## 244 [ENST00000350669,ENST00000539782]   A   G      LOW
##                                            effect            feature
## 243 [3_prime_UTR_variant,non_coding_exon_variant]         transcript
## 244         [sequence_feature,synonymous_variant] [helix,transcript]
##                              biotype DP.HCT116 AD1.HCT116 AD2.HCT116 A1.HCT116
## 243 [protein_coding,retained_intron]      1353        754        599         G
## 244                   protein_coding      5157          2       5155         G
##     A2.HCT116 FILTER.HCT116 warnings.HCT116 DP.RKO AD1.RKO AD2.RKO A1.RKO
## 243         T          PASS                   1347    1347              G
## 244         G          PASS                   4253       2    4251      G
##     A2.RKO FILTER.RKO                     warnings.RKO
## 243      G       PASS
## 244      G       PASS WARNING_TRANSCRIPT_NO_STOP_CODON
```

Here we see two mutations in the LDHB gene, one mismatching MODIFIER variant
and one matching LOW variant. This is a good approach to check for known
mutations in your dataset. For example, the HCT116 cell line is supposed to
have a KRASG13D mutation. We might look for this using its known
`rsID` or position:

```
hct116_rko_kras <- hct116_rko[hct116_rko$rsID == "rs112445441", ]
hct116_rko_kras <- hct116_rko[hct116_rko$chr == 12 &
                              hct116_rko$pos == 25398281, ]
nrow(hct116_rko_kras)
```

```
## [1] 0
```

The reason that we don’t find this particular variant in the HCT116 vs. RKO
comparison is that it is not present in the RKO profile, either because it
isn’t a mutation in RKO or because there was no confident variant call for that
particular position. The `compare_profiles` function only looks at overlapping
positions by default, so we will have to look at the individual profiles
instead. `seqCAT` has two functions to help with this: `list_variants` and
`plot_variant_list`:

The `list_variants` function looks for the genotypes of each specified variant
in each provided SNV profile. First, let’s create a small set of interesting
variants we want to look closer at:

```
known_variants <- data.frame(chr  = c(12, 12, 12, 12),
                             pos  = c(25358650, 21788465, 21797029, 25398281),
                             gene = c("LYRM5", "LDHB", "LDHB", "KRAS"),
                             stringsAsFactors = FALSE)
known_variants
```

```
##   chr      pos  gene
## 1  12 25358650 LYRM5
## 2  12 21788465  LDHB
## 3  12 21797029  LDHB
## 4  12 25398281  KRAS
```

The minimum information needed are the `chr` and `pos` columns; any additional
columns (such as `gene`, here) will just be passed along for later use. We can
now pass this set (along with our SNV profiles) to the `list_variants`
function:

```
variant_list <- list_variants(list(hct116, rko), known_variants)
variant_list
```

```
##   chr      pos  gene HCT116 RKO
## 1  12 21788465  LDHB    G/T G/G
## 2  12 21797029  LDHB    G/G G/G
## 3  12 25358650 LYRM5    A/T A/T
## 4  12 25398281  KRAS    C/T   0
```

While this gives you a nice little list of the genotypes of your specified
variants, we can also visualise this using the `plot_variant_list` function. It
takes a slightly modified version of the output from the `list_variants`
function: it may only contain the genotype columns. We thus need to create row
names to identify the variants, like this:

```
# Set row names to "chr: pos (gene)"
row.names(variant_list) <- paste0(variant_list$chr, ":", variant_list$pos,
                                  " (", variant_list$gene, ")")

# Remove "chr", "pos" and "gene" columns
to_remove <- c("chr", "pos", "gene")
variant_list <- variant_list[, !names(variant_list) %in% to_remove]

# Plot the genotypes in a grid
genotype_grid <- plot_variant_list(variant_list)
```

```
## Warning: `gather_()` was deprecated in tidyr 1.2.0.
## ℹ Please use `gather()` instead.
## ℹ The deprecated feature was likely used in the seqCAT package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the seqCAT package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the seqCAT package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
genotype_grid
```

![](data:image/png;base64...)

This gives us an easily overviewed image of what variants are present in which
samples, and their precise genotype. We can see that the KRASG13D
mutation is indeed present in the HCT116, but not in RKO. We can also see that
RKO has a homozygous `G/G` genotype for one of the LDHB variants, while HCT116
is heterozygous (`T/G`) for the same. *(Please note that this data was aligned
and analysed using the GRCh37 / hg19 assembly and that listed positions might
not be accurate for other assemblies.)*

# 5 Evaluating multiple comparisons

Many scientific studies compare more than just two datasets, not to mention
meta-studies and large-scale comparisons. It is therefore important to be able
to characterise and evaluate many-to-one or many-to-many cases as well - the
`seqCAT` package provides a number of functions and procedures for doing so.

## 5.1 Performing multiple profile comparisons

The first step of such an analysis is to create and read SNV profiles for each
sample that is to be evaluated (please see [section 2](#creation-of-snv-profiles)). The example data used here has three different samples: HCT116,
HKE3 and RKO. The `compare_many` function is a helper function for creating
either one-to-many or many-to-many SNV profile comparisons, and returns a
`list` of the global similarities for all combinations of profiles and their
respective data (for downstream analyses):

```
# Create list of SNV profiles
profiles <- list(hct116, hke3, rko)

# Perform many-to-many comparisons
many <- compare_many(profiles)
many[[1]]
```

```
##   sample_1 sample_2 variants_1 variants_2 overlaps matches concordance
## 1   HCT116   HCT116        523        523      523     523       100.0
## 2   HCT116     HKE3        493        493      493     475        96.3
## 3   HCT116      RKO        259        259      259     181        69.9
## 4     HKE3     HKE3       1604       1604     1604    1604       100.0
## 5     HKE3      RKO        299        299      299     204        68.2
## 6      RKO      RKO        583        583      583     583       100.0
##   similarity_score
## 1             99.1
## 2             95.4
## 3             68.7
## 4             99.7
## 5             67.2
## 6             99.2
```

We can here see the summary statistics of all three combinations of the cell
lines in the example data. Notice that `compare_many` will only perform a
comparison that has not already been performed, *i.e.* it will not perform the
RKO vs. HCT116 comparison if it has already performed HCT116 vs. RKO.
Also notice that it does perform self-comparisons (*i.e.* HCT116 vs.
HCT116), which is useful for downstream visualisations.

The similarities are stored in the first element of the results (`many[[1]]`),
while the data for each comparison is stored in the second (`many[[2]]`). The
second element is itself also a list, whose indices correspond to the row names
of the similarity object. If we, for example, are interested in the HKE3
self-comparison, we can see that its row name is `4`. We can then access its
data like this:

```
hke3_hke3 <- many[[2]][[4]]
head(hke3_hke3)
```

```
##   chr   pos sample_1 sample_2 match        rsID         gene          ENSGID
## 1  12 73805     HKE3     HKE3 match rs375835195 RP11-598F7.1 ENSG00000249054
## 2  12 75190     HKE3     HKE3 match rs374099059   AC215219.1 ENSG00000238823
## 3  12 75308     HKE3     HKE3 match rs370314061   AC215219.1 ENSG00000238823
## 4  12 75337     HKE3     HKE3 match rs147539459   AC215219.1 ENSG00000238823
## 5  12 76316     HKE3     HKE3 match rs370768066   AC215219.1 ENSG00000238823
## 6  12 76349     HKE3     HKE3 match  rs71412503   AC215219.1 ENSG00000238823
##            ENSTID REF ALT   impact                  effect    feature biotype
## 1 ENST00000504074   G   C MODIFIER downstream_gene_variant transcript lincRNA
## 2 ENST00000458783   A   G MODIFIER   upstream_gene_variant transcript   miRNA
## 3 ENST00000458783   C   T MODIFIER   upstream_gene_variant transcript   miRNA
## 4 ENST00000458783   A   G MODIFIER   upstream_gene_variant transcript   miRNA
## 5 ENST00000458783   T   C MODIFIER   upstream_gene_variant transcript   miRNA
## 6 ENST00000458783   A   G MODIFIER   upstream_gene_variant transcript   miRNA
##   DP.HKE3 AD1.HKE3 AD2.HKE3 A1.HKE3 A2.HKE3 FILTER.HKE3 warnings.HKE3
## 1      15        8        7       G       C        PASS
## 2      45       39        6       A       G        PASS
## 3      38       38                C       C        PASS
## 4      38       27       11       A       G        PASS
## 5      63       46       17       T       C        PASS
## 6      44       35        9       A       G        PASS
```

You may also specify the `a` and `b` similarity score parameters, as above. If
you are interested in only a one-to-many comparison (for cases when you have a
“true” baseline profile to compare against), you can do this by also specifying
the `one = <profile>` parameter in the function call. This is useful if you
have a COSMIC profile to compare against, for example:

```
many_cosmic <- compare_many(profiles, one = cosmic)
many_cosmic[[1]]
```

```
##        sample_1      sample_2 variants_1 variants_2 overlaps matches
## 1 COSMIC.HCT116 COSMIC.HCT116          1          1        1       1
## 2 COSMIC.HCT116        HCT116          1          1        1       1
## 3 COSMIC.HCT116          HKE3          1          1        1       1
## 4 COSMIC.HCT116           RKO          1          1        0       0
##   concordance similarity_score
## 1         100             28.6
## 2         100             28.6
## 3         100             28.6
## 4         NaN             16.7
```

It is important to note that performing many comparisons like this may take
quite some time, depending on the number of profiles and how much data each
profile has. By returning all the data in a list you may then save each
comparison to a file, for later re-analysis without having to re-do the
comparisons.

## 5.2 Visualising multiple comparisons

A useful and straightforward way of visualising multiple profile comparisons is
to use a heatmap. We can use the summary statistics listed in the similarity
object from above as input to the function `plot_heatmap`, which gives you a
simple overview of all your comparisons:

```
heatmap <- plot_heatmap(many[[1]])
heatmap
```

![](data:image/png;base64...)

Here we see a blue colour gradient for the similarity score of the three cell
lines, which are clustered according to their similarity (using `cluster = TRUE`, as default). You may change the size of the text annotations using
`annotation_size = 5` (default) or suppress them entirely (`annotate = FALSE`).
You may also suppress the legend (`legend = FALSE`), change the main colour of
the gradient (`colour = "#1954A6"` by default) or change the limits of the
gradient (`limits = c(0, 50, 90, 100)` by default). The choice of gradient
limits are based on clarity (comparisons with a similarity score less than 50,
*i.e.* those that likely have too few overlapping variants to begin with, are
suppressed) and the previously mentioned 90 % concordance threshold
*(Yu et al. [2015](#ref-Yu2015))*.

This heatmap makes it clear that HCT116 and HKE3 are, indeed, very similar to
each other, while RKO differs from them both. These types of heatmaps can be
created for an arbitrary number of samples, which will then give a great
overview of the global similarities of all the samples studied. This can be
used to evaluate the quality of the datasets (*e.g.* to see which comparisons
have very few overlaps), find similarity clusters and potential unexpected
outliers. If a sample stands out in a heatmap such as this, that is grounds for
further investigation, using both the methods described above and more
classical evaluations of sequencing data (read quality, adapter contamination,
alignments, variant calling, and so on).

# Citation

If you are using seqCAT to analyse your data, please cite the
following article:

> **seqCAT: a Bioconductor R-package for variant analysis of high throughput**
> **sequencing data**
>
>  Fasterius E. and Al-Khalili Szigyarto C.
>
>  *F1000Research* (2018), 7:1466
>
>  <https://f1000research.com/articles/7-1466>

# Session info

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
##  [1] seqCAT_1.32.0               VariantAnnotation_1.56.0
##  [3] Rsamtools_2.26.0            Biostrings_2.78.0
##  [5] XVector_0.50.0              SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         dplyr_1.1.4              farver_2.1.2
##  [4] blob_1.2.4               S7_0.2.0                 bitops_1.0-9
##  [7] fastmap_1.2.0            RCurl_1.98-1.17          GenomicAlignments_1.46.0
## [10] XML_3.99-0.19            digest_0.6.37            lifecycle_1.0.4
## [13] KEGGREST_1.50.0          RSQLite_2.4.3            magrittr_2.0.4
## [16] compiler_4.5.1           rlang_1.1.6              sass_0.4.10
## [19] tools_4.5.1              yaml_2.3.10              rtracklayer_1.70.0
## [22] knitr_1.50               S4Arrays_1.10.0          labeling_0.4.3
## [25] bit_4.6.0                curl_7.0.0               DelayedArray_0.36.0
## [28] RColorBrewer_1.1-3       abind_1.4-8              BiocParallel_1.44.0
## [31] withr_3.0.2              purrr_1.1.0              grid_4.5.1
## [34] ggplot2_4.0.0            scales_1.4.0             tinytex_0.57
## [37] dichromat_2.0-0.1        cli_3.6.5                rmarkdown_2.30
## [40] crayon_1.5.3             httr_1.4.7               rjson_0.2.23
## [43] DBI_1.2.3                cachem_1.1.0             parallel_4.5.1
## [46] AnnotationDbi_1.72.0     BiocManager_1.30.26      restfulr_0.0.16
## [49] vctrs_0.6.5              Matrix_1.7-4             jsonlite_2.0.0
## [52] bookdown_0.45            bit64_4.6.0-1            magick_2.9.0
## [55] GenomicFeatures_1.62.0   jquerylib_0.1.4          tidyr_1.3.1
## [58] glue_1.8.0               codetools_0.2-20         gtable_0.3.6
## [61] GenomeInfoDb_1.46.0      BiocIO_1.20.0            UCSC.utils_1.6.0
## [64] tibble_3.3.0             pillar_1.11.1            htmltools_0.5.8.1
## [67] BSgenome_1.78.0          R6_2.6.1                 evaluate_1.0.5
## [70] lattice_0.22-7           png_0.1-8                cigarillo_1.0.0
## [73] memoise_2.0.1            bslib_0.9.0              Rcpp_1.1.0
## [76] SparseArray_1.10.0       xfun_0.53                pkgconfig_2.0.3
```

# 6 References

Fasterius, Erik, Cinzia Raso, Susan Kennedy, Nora Rauch, Pär Lundin, Walter Kolch, Mathias Uhlén, and Cristina Al-Khalili Szigyarto. 2017. “A novel RNA sequencing data analysis method for cell line authentication.” *PloS One* 12 (2): e0171435.

Fasterius, Erik, and Cristina Al-Khalili Szigyarto. 2018. “Analysis of public RNA- sequencing data reveals biological consequences of genetic heterogeneity in cell line populations.” *Scientific Reports* 8(1) (1): 1–11. [http://dx.doi.org/10.1038/s41598-018-29506-3 papers3://publication/doi/10.1038/s41598-018-29506-3](http://dx.doi.org/10.1038/s41598-018-29506-3%20papers3%3A//publication/doi/10.1038/s41598-018-29506-3).

Forbes, Simon A, David Beare, Prasad Gunasekaran, Kenric Leung, Nidhi Bindal, Harry Boutselakis, Minjie Ding, et al. 2015. “COSMIC: exploring the world’s knowledge of somatic mutations in human cancer.” *Nucleic Acids Research* 43 (Database issue): D805–11. [http://eutils.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi?dbfrom=pubmed{\&}id=25355519{\&}retmode=ref{\&}cmd=prlinks papers3://publication/doi/10.1093/nar/gku1075](http://eutils.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi?dbfrom=pubmed%7B\&%7Did=25355519%7B\&%7Dretmode=ref%7B\&%7Dcmd=prlinks%20papers3://publication/doi/10.1093/nar/gku1075).

Yu, Mamie, Suresh K Selvaraj, May M Y Liang-Chu, Sahar Aghajani, Matthew Busse, Jean Yuan, Genee Lee, et al. 2015. “A resource for cell line authentication, annotation and quality control.” *Nature* 520 (7547): 307–11.

# Appendix