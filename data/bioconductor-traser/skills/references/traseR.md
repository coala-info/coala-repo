traseR: TRait-Associated SNP EnRichment

analyses

Li Chen, Zhaohui S.Qin

[1em]Department of Biostatistics and Bioinformatics

Emory University

Atlanta, GA 303022
[1em] li.chen@emory.edu,zhaohui.qin@emory.edu

October 30, 2025

Contents

1

2

Introduction .

.

.

Data collection .

.

.

.

.

Obtain taSNPs .

2.1

2.2

2.3

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Obtain linkage disequilibrium taSNPs from 1000 Genome Project

Obtain background SNPs from 1000 Genome Project .

3

Using traseR .

.

.

.

.

.

.

3.1

Background selection .

.

.

3.1.1 Whole genome .

3.1.2

All SNPs .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3.2

Hypothesis testing .

.
.
χ2 test and Fisher’s exact test .

.

.

.

.

.

.

3.2.1

3.2.2

3.2.3

Binomial test

.

.

.

Nonparametric Test

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

4

Choose appropriate statistical test method .

4.1

4.2

Example .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Exploratory and visualization functions .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

2

3

4

4

4

4

5

5

6

6

6

6

6

8

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

traseR: TRait-Associated SNP EnRichment analyses

5

6

Conclusion .

Session Info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

13

13

Abstract

This vignette introduces the use of traseR (TRait-Associated SNPEnRichment analyses,
which is designed to provide quantitative assessment whether a selected genomic interval(s)
is likely to be functionally connected with certain traits or diseases. traseR consists of several
modules, all written in R, to perform hypothesis testing, exploration and visualization of trait-

associated SNPs(taSNPs). It also assembles the up-to-date taSNPs from dbGaP and NHGRI,

SNPs from 1000 Genome Project CEU population with linkage disequilibrium greater than

0.8 within 100 kb of taSNPs, and all SNPs of CEU population from 1000 Genome project

into its built-in database, which could be directly loaded when performing analyses.

1

Introduction

Genome-wide association study (GWAS) have successfully identified many sequence variants

that are significantly associated with common diseases and traits. Tens of thousands of such

trait-associated SNPs have already been cataloged which we believe are great resources for

genomic research. However, no tools existing utilizes those resources in a comprehensive and

convenient way. In this study, we show the collection of taSNPs can be exploited to indicate

whether a query genomic interval(s) is likely to be functionally connected with certain traits
or diseases. A R Bioconductor package named traseR has been developed to carry out such
analyses.

2

Data collection

One great feature of traseR is the built-in database that collects various public SNP resources.
Common public SNP databases include Association Result Browser and 1000 Genome Project.

We briefly introduce the procedures to process those public available SNP resources

2.1

Obtain taSNPs

Association Results Browser (http://www.ncbi.nlm.nih.gov/projects/gapplusprev/sgap_plus.

htm) combines identified taSNPs from dbGaP and NHGRI, which together provide 44,078

SNP-trait associations, 48,936 SNP-trait class associations, 30,553 unique taSNPs, 573

unique traits and 33 unique trait classes. This resource has been built into GRanges ob-
ject taSNP and could be loaded into R console by typing data(taSNP).

2

traseR: TRait-Associated SNP EnRichment analyses

traseR need to specify the collection of trait-associated SNPs in particular format before we
carry out enrichment analyses. The format starts with the columns,

1. Trait: Description of disease/trait examined in the study

2. Trait_Class: Trait class which is formed based on the phenotype tree. Close traits are

grouped together to form one class.

3. SNP_ID: SNP rs number

4. p.value: GWAS reported p-values

5. seqnames: Chromosome number associated with rs number

6. ranges: Chromosomal position, in base pairs, associated with rs number

7. Context: SNP functional class

8. GENE_NAME: Genes reported to be associated with SNPs

9. GENE_START: Chromosome start position of genes

10. GENE_END: Chromosome end position of genes

11. GENE_STRAND: Chromosome strand associated with SNPs

Currently, the traseR package automatically synchronize trait-associated SNPs from Associ-
ation Results Browser, which collects up-to-date GWAS results from dbGaP NHGRI GWAS

catalog.

2.2

Obtain linkage disequilibrium taSNPs from 1000 Genome Project

We first download CEU vcf files from (ftp://share.sph.umich.edu/1000genomes/fullProject/

2012.03.14/) that contain all sequence variants information. The followed two steps are used

to identify linkage disequilibrium SNPs >0.8 and located within 100kb of taSNPs. Firstly,
we use vcftools to convert the vcf file format to PLINK format. Then we use PLINK to call
the LD taSNPs by specifying options that limit the linkage disequilibrium SNPs >0.8 (–ld-

window-r2 0.8) and within 100kb of taSNP (–ld-window-kb 100). The detailed commands

are listed below,

vcftools -vcf vcf.file -out plink.file -plink plink -file plink.file -r2 -inter-chr

-ld-snp-list snps.txt -ld-window-r2 0.8 -ld-window-kb 100 -out output.file -noweb
Finally, we have 90,700 SNP-trait associations and 78,247 unique linkage disequilibrium trait-

associated SNP. We also build linkage disequilibrium taSNP into another GRanges object
taSNPLD, which could be loaded into R console by typing data(taSNPLD).
The format of taSNPLD is,

1. seqnames: Chromosome number associated with rs number

2. SNP_ID: SNP rs number

3

traseR: TRait-Associated SNP EnRichment analyses

3. ranges: Chromosomal position, in base pairs, associated with rs number

4. Trait: Description of disease/trait examined in the study

5. Trait_Class: Trait class which is formed based on the phenotype tree. Close traits are

grouped together to form one class.

2.3

Obtain background SNPs from 1000 Genome Project

We use the command plink -file plink.file -freq -out chr to retrieve all SNPs with
corresponding MAF (minor allele frequency) from the CEU vcf files downloaded. There are

totally 6,571,512 SNPs (MAF>0.05) excluding variants on Y chromosome. Those SNPs

could serve as background in hypothesis testing. We build those SNPs into the built-in
GRanges subject CEU into the package.
The format of CEU is,

1. seqnames: Chromosome number associated with rs number

2. SNP_ID: SNP rs number

3. ranges: Chromosomal position, in base pairs, associated with rs number

3

Using traseR

To assess the enrichment level of trait-associated SNPs in given genomic interval(s) using
traseR, one needs to follow the simple steps below.

1. Prepare the genomic intervals in R object of either data frame format with column

names chr,start,end or GRanges object

2. Query a given a set of genomic interval(s) against all the taSNPs in the collection,

perform statistical analyses

3. Explore genes/SNPs of particular interest

3.1

Background selection

3.1.1 Whole genome

The assumption is each base could be possibly be the taSNP. Based on the assumption, with

the number of taSNPs inside and outside the genomic interval(s), the number of bases inside

and outside of the genomic interval(s), we could classify all bases based on the fact that one

base is taSNP or not and in genomic intervals or not.

4

traseR: TRait-Associated SNP EnRichment analyses

3.1.2 All SNPs

The assumption is each SNP could possibly be the taSNP. Based on the assumption, with

the number of taSNPs inside and outside the genomic interval(s), the non-taSNPs inside and

outside of the genomic interval(s), we could classify all SNPs based on the fact that one SNP

is taSNP or not and in genomic intervals or not.

3.2

Hypothesis testing

traseR provides differential hypothesis testing methods in core function traseR, together
with other functions for exploring and visualizing the results. The genomic interval(s) could
be a data frame with three columns as chr(chromosome), start(genomic start position) and
end(genomic end position) or a GRanges object. traseR offers either including LD SNPs or
excluding LD SNPs as the taSNPs and either using the whole genome or all SNPs as the

background for hypothesis testing.

If using whole genome as background, the command line is:

> x=traseR(snpdb=taSNP,region=Tcell)

> print(x)

If including the LD SNPs, the command line is:

> x=traseR(snpdb=taSNPLD,region=Tcell)

> print(x)

If using all SNPs as background, the command line is:

> x=traseR(snpdb=taSNP,region=Tcell,snpdb.bg=CEU)

For the above commands, region is the data frame; snpdb is taSNPs or including LD SNPs;
snpdb.bg is background SNPs; If rankby is set as "pvalue", all traits will be sorted by p-
value in increasing order; ifrankby is set as "odds.ratio", all traits will be sorted by odds
ratio in decreasing order. There are four options for test.method including "binomial",
"chisq", "fisher", and "nonparametric"to perform binomial test, χ2 test, Fisher’s exact test
If alternative is set to "greater", traseR will perform
and nonparametric respectively.
hypothesis testing on whether genomic intervals are enriched of taSNPs than the background;
If alternative is set to "less",traseR will perform hypothesis testing on whether genomic
intervals are depleted of taSNPs than the background.

5

traseR: TRait-Associated SNP EnRichment analyses

3.2.1

χ2 test and Fisher’s exact test

Based on which background we choose, we could construct the 2 by 2 contingency table. then,
we could perform χ2 test on the table to assess the difference of proportions of taSNPs inside
and outside of genomic intervals(s). We could also assume taSNPs inside genomic intervals

follows hypergeometric distribution and calculate p-value directly using Fisher’s exact test.

3.2.2 Binomial test

The assumption is the probability of observing a single base/SNP being a taSNP is the same

inside and outside of genomic intervals. The probability of observing a single base/SNPs being

a taSNP in genomic intervals could be estimated by using total number of taSNPs divided

by the genome size/number of all SNPs. Then corresponding p-value could be calculated

directly by Binomial test.

3.2.3 Nonparametric Test

Instead of imposing any assumption, the matched genomic interval(s) are generated by per-
muting the genomic intervals randomly N times and overlap with taSNPs in each time.
Then we could calculate the empirical p-value directly by counting how many taSNP hits

larger/smaller than the observed taSNP hits.

4

Choose appropriate statistical test method

Depending on the characteristics of the test statistics, we suggest to choose appropriate

statistical test method under different scenarios,

• χ2 test: the numbers in the contingency table is fairly large and balanced

• Fisher’s exact test: the numbers of the contingency table is relatively small, e.g. no

more than 20

• Nonparametric test: the number of query genomic intervals are small, e.g. no more

than 1000

• Binomial test: default test method, not limited by sample size, distribution assumption

and computational time

4.1

Example

To further illustrate the usage of traseR R package, we download H3K4me1 peak regions
in peripheral blood T cell from Roadmap Epigenomics. Those peak regions are deemed the

genomic intervals. Since the degree of enrichment level is measured by p-value, we could

6

traseR: TRait-Associated SNP EnRichment analyses

rank traits/trait classes based on p-value in an increasing order. We choose Binomial test are
the default option for test.method, use whole genome as background and over-enrichment
as hypothesis testing direction.

> library(traseR)

> data(taSNP)

> data(Tcell)

> x=traseR(taSNP,Tcell)

> print(x)

Trait

p.value odds.ratio taSNP.hits taSNP.num

1

All 3.788373e-233

2.134717

2625

30553

Trait

p.value

q.value odds.ratio

Behcet Syndrome 4.400406e-23 2.521433e-20

6.306579

Diabetes Mellitus, Type 1 1.704981e-11 4.884769e-09

5.045263

67

172

340 Lupus Erythematosus, Systemic 6.159346e-09 1.176435e-06

3.902195

49

379

62

67

172

340

49

379

62

17

Arthritis, Rheumatoid 1.442123e-07 2.065841e-05

5.126637

Multiple Sclerosis 1.644125e-05 1.884167e-03

2.905210

Autoimmune Diseases 5.201529e-05 4.967461e-03

15.892575

taSNP.hits taSNP.num

59

33

32

20

26

6

274

185

223

112

236

15

Trait_Class

p.value

q.value odds.ratio

Immune System Diseases 3.729169e-35 1.143835e-33

3.658860

31 Skin and Connective Tissue Diseases 6.932335e-35 1.143835e-33

3.916319

32

14

11

7

13

24

21

23

16

22

30

Stomatognathic Diseases 1.041455e-22 1.145601e-21

5.675922

Eye Diseases 3.479491e-18 2.870580e-17

3.313308

Digestive System Diseases 4.362324e-14 2.879134e-13

3.040672

Cardiovascular Diseases 3.008551e-11 1.654703e-10

1.602762

Endocrine System Diseases 6.933337e-09 3.268573e-08

2.068149

Nutritional and Metabolic Diseases 4.763509e-08 1.964948e-07

2.068673

Musculoskeletal Diseases 3.118359e-05 1.143398e-04

2.716680

Nervous System Diseases 5.549981e-05 1.831494e-04

1.495744

Hemic and Lymphatic Diseases 1.649261e-04 4.947782e-04

3.596622

Neoplasms 3.372076e-04 9.273210e-04

1.580636

Respiratory Tract Diseases 6.507770e-04 1.651972e-03

2.121839

7

traseR: TRait-Associated SNP EnRichment analyses

taSNP.hits taSNP.num

155

142

63

87

74

253

89

79

27

122

15

76

29

1122

970

318

689

633

3850

1076

956

260

1988

115

1181

349

17

31

32

14

11

7

13

24

21

23

16

22

30

4.2

Exploratory and visualization functions

Plot the distribution of SNP functional class

> plotContext(snpdb=taSNP,region=Tcell,keyword="Autoimmune")

8

traseR: TRait-Associated SNP EnRichment analyses

Plot the distribution of p-value of trait-associated SNPs

> plotPvalue(snpdb=taSNP,region=Tcell,keyword="autoimmune",plot.type="densityplot")

9

Intergenic 17%Intron 50%Missense 17%NearGene−5 17%Pie Chart of ContexttraseR: TRait-Associated SNP EnRichment analyses

Plot SNPs or genes given genomic interval

> plotInterval(snpdb=taSNP,data.frame(chr="chrX",start=152633780,end=152737085))

10

010203040500.00.20.40.6−log10Pvalue DistributionSNP(all)SNP(keyword)SNP(overlapped)traseR: TRait-Associated SNP EnRichment analyses

Query trait-associated SNPs by key word,

> x=queryKeyword(snpdb=taSNP,region=Tcell,keyword="autoimmune",returnby="SNP")

> head(x)

SNP_ID

Chr Position Trait.num

Trait.name

4343 rs11203203 chr21 43836186

1 Autoimmune Diseases

4341

rs1876518 chr2 65608909

1 Autoimmune Diseases

4348

rs1953126 chr9 123640500

1 Autoimmune Diseases

4342

rs2298428 chr22 21982892

1 Autoimmune Diseases

4345

rs7579944 chr2 30445026

1 Autoimmune Diseases

4338

rs864537 chr1 167411384

1 Autoimmune Diseases

Query trait-associated SNPs by gene name,

11

chrX position (bp)152623780152685432152747085024−log10Pvaluers928952(Body Weight)ZFP92traseR: TRait-Associated SNP EnRichment analyses

> x=queryGene(snpdb=taSNP,genes=c("AGRN","UBE2J2","SSU72"))

> x

GRanges object with 3 ranges and 5 metadata columns:

seqnames

ranges strand |

GENE_NAME Trait.num

[1]

[2]

[3]

[1]

[2]

<Rle>

<IRanges> <Rle> | <character> <integer>

chr1

955502-991491

chr1 1477052-1510261

chr1 1189291-1209233

+ |

- |

- |

AGRN

SSU72

UBE2J2

1

1

1

Trait.name taSNP.num

taSNP.name

<character> <integer> <character>

Body Mass Index

Glucose

[3] Waist Circumference

-------

1

1

1

rs3934834

rs880051

rs11804831

seqinfo: 23 sequences from an unspecified genome; no seqlengths

Query trait-associated SNPs by SNP name,

> x=querySNP(snpdb=taSNP,snpid=c("rs3766178","rs880051"))

> x

GRanges object with 2 ranges and 9 metadata columns:

seqnames

ranges strand |

Trait

SNP_ID

p.value

<Rle> <IRanges> <Rle> | <character> <character> <numeric>

42234

42127

chr1

1478180

chr1

1493727

* |

* |

Glucose

rs3766178

3.26e-05

Glucose

rs880051

6.44e-05

Context

GENE_NAME GENE_START

GENE_END GENE_STRAND

<character> <character> <integer> <integer> <character>

42234

42127

Intron

Intron

SSU72

1477052

1510261

SSU72

1477052

1510261

-

-

Trait_Class

<character>

42234 Chemicals and Drugs ..

42127 Chemicals and Drugs ..

-------

seqinfo: 23 sequences from an unspecified genome; no seqlengths

12

traseR: TRait-Associated SNP EnRichment analyses

5

Conclusion

traseR provides methods to assess the enrichment level of taSNPs in a given sets of genomic
intervals. Moreover, it provides other functionalities to explore and visualize the results.

6

Session Info

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)

Platform: x86_64-pc-linux-gnu

Running under: Ubuntu 24.04.3 LTS

Matrix products: default

BLAS:

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8

[3] LC_TIME=en_GB

LC_NUMERIC=C

LC_COLLATE=C

[5] LC_MONETARY=en_US.UTF-8

LC_MESSAGES=en_US.UTF-8

[7] LC_PAPER=en_US.UTF-8

LC_NAME=C

[9] LC_ADDRESS=C

LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York

tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics grDevices utils

datasets

methods

[8] base

other attached packages:

[1] traseR_1.40.0

[3] BSgenome_1.78.0

[5] BiocIO_1.20.0

[7] XVector_0.50.0

[9] Seqinfo_1.0.0

[11] S4Vectors_0.48.0

BSgenome.Hsapiens.UCSC.hg19_1.4.3

rtracklayer_1.70.0

Biostrings_2.78.0

GenomicRanges_1.62.0

IRanges_2.44.0

BiocGenerics_0.56.0

13

traseR: TRait-Associated SNP EnRichment analyses

[13] generics_0.1.4

loaded via a namespace (and not attached):

[1] Matrix_1.7-4

[3] compiler_4.5.1

[5] rjson_0.2.23

BiocStyle_2.38.0

BiocManager_1.30.26

crayon_1.5.3

[7] SummarizedExperiment_1.40.0 Biobase_2.70.0

[9] Rsamtools_2.26.0

bitops_1.0-9

[11] GenomicAlignments_1.46.0

parallel_4.5.1

[13] BiocParallel_1.44.0

yaml_2.3.10

[15] fastmap_1.2.0

[17] R6_2.6.1

[19] curl_7.0.0

lattice_0.22-7

S4Arrays_1.10.0

knitr_1.50

[21] XML_3.99-0.19

DelayedArray_0.36.0

[23] MatrixGenerics_1.22.0

rlang_1.1.6

[25] xfun_0.53

[27] cli_3.6.5

[29] digest_0.6.37

[31] cigarillo_1.0.0

[33] abind_1.4-8

[35] restfulr_0.0.16

[37] httr_1.4.7

[39] tools_4.5.1

SparseArray_1.10.0

grid_4.5.1

evaluate_1.0.5

codetools_0.2-20

RCurl_1.98-1.17

rmarkdown_2.30

matrixStats_1.5.0

htmltools_0.5.8.1

References

[1] Welter D, MacArthur J, Morales J, Burdett T, Hall P, Junkins H,

Klemm A, Flicek P, Manolio T, Hindorff L et al (2010). The NHGRI
GWAS Catalog, a curated resource of SNP-trait associations. Nucleic Acid Research,
42, D1001-1006.

[2] Roadmap Epigenomics C, Kundaje A, Meuleman W, Ernst J, Bilenky

M, Yen A, Heravi-Moussavi A, Kheradpour P, Zhang Z, Wang J et al.
(2015). Integrative analysis of 111 reference human epigenomes Nature, 7539,
317-330

[3]

http://www.ncbi.nlm.nih.gov/projects/gapplusprev/sgap_plus.htm Association
Results Browser

[4]

ftp://share.sph.umich.edu/1000genomes/fullProject/2012.03.14/ 1000Genome EUR

14

