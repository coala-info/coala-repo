# ensemblVEP: using the REST API with Bioconductor

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Acquire annotation on variants from a VCF file](#acquire-annotation-on-variants-from-a-vcf-file)
* [3 Transforming the API response to GRanges](#transforming-the-api-response-to-granges)
* [4 Further work](#further-work)
* [References](#references)

# 1 Introduction

Ensembl’s Variant Effect Predictor is described in McLaren et al. ([2016](#ref-McLaren2016)).

Prior to Bioconductor 3.19, the ensemblVEP package provided
access to Ensembl’s predictions
through an interface between Perl and MySQL.

In 3.19 VariantAnnotation supports the use of the VEP component
of the REST API at [https://rest.ensembl.org](https://rest.ensembl.org/).

# 2 Acquire annotation on variants from a VCF file

The function `vep_by_region` will accept
a VCF object as defined in *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)*.

```
library(VariantAnnotation)
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
r22 = readVcf(fl)
r22
```

```
## class: CollapsedVCF
## dim: 10376 5
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 22 columns: LDAF, AVGPOST, RSQ, ERATE, THETA, CIEND, CIPOS,...
## info(header(vcf)):
##              Number Type    Description
##    LDAF      1      Float   MLE Allele Frequency Accounting for LD
##    AVGPOST   1      Float   Average posterior probability from MaCH/Thunder
##    RSQ       1      Float   Genotype imputation quality from MaCH/Thunder
##    ERATE     1      Float   Per-marker Mutation rate from MaCH/Thunder
##    THETA     1      Float   Per-marker Transition rate from MaCH/Thunder
##    CIEND     2      Integer Confidence interval around END for imprecise var...
##    CIPOS     2      Integer Confidence interval around POS for imprecise var...
##    END       1      Integer End position of the variant described in this re...
##    HOMLEN    .      Integer Length of base pair identical micro-homology at ...
##    HOMSEQ    .      String  Sequence of base pair identical micro-homology a...
##    SVLEN     1      Integer Difference in length between REF and ALT alleles
##    SVTYPE    1      String  Type of structural variant
##    AC        .      Integer Alternate Allele Count
##    AN        1      Integer Total Allele Count
##    AA        1      String  Ancestral Allele, ftp://ftp.1000genomes.ebi.ac.u...
##    AF        1      Float   Global Allele Frequency based on AC/AN
##    AMR_AF    1      Float   Allele Frequency for samples from AMR based on A...
##    ASN_AF    1      Float   Allele Frequency for samples from ASN based on A...
##    AFR_AF    1      Float   Allele Frequency for samples from AFR based on A...
##    EUR_AF    1      Float   Allele Frequency for samples from EUR based on A...
##    VT        1      String  indicates what type of variant the line represents
##    SNPSOURCE .      String  indicates if a snp was called when analysing the...
## geno(vcf):
##   List of length 3: GT, DS, GL
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
##    DS 1      Float  Genotype dosage from MaCH/Thunder
##    GL G      Float  Genotype Likelihoods
```

In this example we confine attention to single nucleotide variants.

There is a limit of 200 locations in a request, and 55000 requests per hour.
We’ll base our query on 100 positions in the chr22 VCF.

```
dr = which(width(rowRanges(r22))!=1)
r22s = r22[-dr]
res = vep_by_region(r22[1:100], snv_only=FALSE, chk_max=FALSE)
jans = toJSON(content(res))
```

There are various ways to work with the result of this query to the API.
We’ll use the *[rjsoncons](https://CRAN.R-project.org/package%3Drjsoncons)* JSON processing infrastructure
to dig in and understand aspects of the API behavior.

First, the top-level concepts produced for each variant can
be retrieved using

```
library(rjsoncons)
names(jsonlite::fromJSON(jmespath(jans, "[*]")))
```

```
##  [1] "start"                           "assembly_name"
##  [3] "strand"                          "transcript_consequences"
##  [5] "id"                              "allele_string"
##  [7] "seq_region_name"                 "end"
##  [9] "input"                           "most_severe_consequence"
## [11] "colocated_variants"              "regulatory_feature_consequences"
```

Annotation of the most severe consequence known will typically
be of interest:

```
table(jsonlite::fromJSON(jmespath(jans, "[*].most_severe_consequence")))
```

```
##
##   5_prime_UTR_variant        intron_variant splice_region_variant
##                    22                    76                     2
```

There is variability in the structure of data returned for each query.

```
head(fromJSON(jmespath(jans, "[*].regulatory_feature_consequences")))
```

```
## [[1]]
##   regulatory_feature_id variant_allele   impact      biotype consequence_terms
## 1          ENSR22_5....              T MODIFIER CTCF_bin....      regulato....
```

Furthermore, the content of the motif feature consequences field seems
very peculiar.

```
table(unlist(fromJSON(jmespath(jans, "[*].motif_feature_consequences"))))
```

```
## < table of extent 0 >
```

# 3 Transforming the API response to GRanges

We’ll consider the following approach to converting
the API response to a GenomicRanges GRanges instance. Eventually
this may become part of the package.

```
library(GenomicRanges)
.make_GRanges = function( vep_response ) {
  stopifnot(inherits(vep_response, "response"))  # httr
  nested = fromJSON(toJSON(content(vep_response)))
  ini = GRanges(seqnames = unlist(nested$seq_region_name),
    IRanges(start=unlist(nested$start), end=unlist(nested$end)))
  dr = match(c("seq_region_name", "start", "end"), names(nested))
  mcols(ini) = DataFrame(nested[,-dr])
  ini
}
tstg = .make_GRanges( res )
tstg[,1]  # full print is unwieldy
```

```
## GRanges object with 100 ranges and 1 metadata column:
##         seqnames    ranges strand | assembly_name
##            <Rle> <IRanges>  <Rle> |        <list>
##     [1]       22  50300078      * |        GRCh38
##     [2]       22  50300086      * |        GRCh38
##     [3]       22  50300101      * |        GRCh38
##     [4]       22  50300113      * |        GRCh38
##     [5]       22  50300166      * |        GRCh38
##     ...      ...       ...    ... .           ...
##    [96]       22  50304748      * |        GRCh38
##    [97]       22  50304805      * |        GRCh38
##    [98]       22  50304935      * |        GRCh38
##    [99]       22  50304943      * |        GRCh38
##   [100]       22  50305084      * |        GRCh38
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
names(mcols(tstg))
```

```
## [1] "assembly_name"                   "strand"
## [3] "transcript_consequences"         "id"
## [5] "allele_string"                   "input"
## [7] "most_severe_consequence"         "colocated_variants"
## [9] "regulatory_feature_consequences"
```

Now information about variants can be retrieved with
range operations. Deep annotation
requires nested structure of the metadata columns.

```
mcols(tstg)[1, "transcript_consequences"]
```

```
## [[1]]
##    consequence_terms transcript_id      gene_id   hgnc_id variant_allele
## 1       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 2       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 3       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 4       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 5       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 6       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 7       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 8       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 9       intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 10      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 11      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 12      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 13      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 14      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 15      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 16      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 17      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 18      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 19      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 20      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 21      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 22      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 23      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 24      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 25      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
## 26      intron_v....  ENST0000.... ENSG0000.... HGNC:9104              G
##         biotype   impact strand gene_symbol gene_symbol_source      flags
## 1  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 2  protein_.... MODIFIER     -1      PLXNB2               HGNC cds_end_NF
## 3  protein_.... MODIFIER     -1      PLXNB2               HGNC cds_end_NF
## 4  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 5  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 6  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 7  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 8  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 9  protein_.... MODIFIER     -1      PLXNB2               HGNC
## 10 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 11 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 12 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 13 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 14 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 15 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 16 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 17 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 18 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 19 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 20 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 21 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 22 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 23 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 24 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 25 protein_.... MODIFIER     -1      PLXNB2               HGNC
## 26 protein_.... MODIFIER     -1      PLXNB2               HGNC
```

# 4 Further work

An important element of prior work in ensemblVEP supports
feeding annotation back into the VCF used to generate
the effect prediction query. This seems feasible but
concrete use cases are of interest.

# References

McLaren, William, Laurent Gil, Sarah E. Hunt, Harpreet Singh Riat, Graham R. S. Ritchie, Anja Thormann, Paul Flicek, and Fiona Cunningham. 2016. “The Ensembl Variant Effect Predictor.” *Genome Biology* 17 (1): 122. <https://doi.org/10.1186/s13059-016-0974-4>.