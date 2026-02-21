An Introduction to exomePeak

Jia Meng, PhD

Modiﬁed: 21 Dec, 2015. Compiled: December 18, 2017

1

Introduction

The exomePeak R-package has been developed based on the MATLAB exome-
Peak package, for the analysis of RNA epitranscriptome sequencing data with
aﬃnity-based shotgun sequencing approach, such as MeRIP-Seq or m6A-Seq.
The exomePeak package is under active development, please don’t hesitate to
contact me @ jia.meng@hotmail if you have any questions. The inputs of the
main function exomepeak are the IP BAM ﬁles and input control BAM ﬁles with
optional gene annotation ﬁle. The exomePeak package fullﬁlls the following two
key functions:

(cid:136) Conduct peak calling to identify the RNA methylation sites under a spe-

ciﬁc condition

(cid:136) Conduct peak calling to identify the RNA methylation sites and then iden-
tify the diﬀerential methylation site which can be diﬀerentially regulated
at epitranscriptomic layer by RNA modiﬁcations.

Gene annotation can be provided as a GTF ﬁle, a TxDb object, or automatically
downloaded from UCSC through the internet.

We will in the next see how the two main functions can be accomplished in

a single command.

2 Peak Calling

Let us ﬁrstly load the package and get the toy data (came with the package)
ready.

> library("exomePeak")
> gtf <- system.file("extdata", "example.gtf", package="exomePeak")
> f1 <- system.file("extdata", "IP1.bam", package="exomePeak")
> f2 <- system.file("extdata", "IP2.bam", package="exomePeak")
> f3 <- system.file("extdata", "IP3.bam", package="exomePeak")
> f4 <- system.file("extdata", "IP4.bam", package="exomePeak")
> f5 <- system.file("extdata", "Input1.bam", package="exomePeak")

1

> f6 <- system.file("extdata", "Input2.bam", package="exomePeak")
> f7 <- system.file("extdata", "Input3.bam", package="exomePeak")

The ﬁrst main function of exomePeak R-package is to call peaks (enriched
binding sites) to detect RNA methylation sites on the exome. Inputs are the
gene annotation GTF ﬁle, IP and Input control samples in BAM format. This
function is used when data from only one condition is available.

> result <- exomepeak(GENE_ANNO_GTF=gtf,
+
+

IP_BAM=c(f1,f2,f3,f4),
INPUT_BAM=c(f5,f6,f7))

[1] "Divide transcriptome into chr-gene-batch sections ..."
[1] "Get Reads Count ..."
[1] "This step may take a few hours ..."
[1] "100 %"
[1] "Get all the peaks ..."
[1] "Get the consistent peaks ..."
[1] "---------------------------------"
[1] "The bam files used:"
[1] "4 IP replicate(s)"
[1] "3 Input replicate(s)"
[1] "---------------------------------"
[1] "Peak calling result: "
[1] "13 peaks detected on merged data."
[1] "Please check
[1] "10 consistent peaks detected on every replicates. (Recommended list)"
[1] "Please check

con_peak.bed/xls

peak.bed/xls

’

’

’

’

under /tmp/RtmpP3mhfd/Rbuild3d8b10b94329/exomePeak/vignettes/exomePeak_output"

under /tmp/RtmpP3mhfd/Rbuild3d8b10b94329/exomePeak/vignettes/exomePeak_output"

> names(result)

[1] "all_peaks" "con_peaks"

The results will be saved in the speciﬁed output directory, including the iden-
tiﬁed peaks and consistent peaks in BED or XLS (tab-delimited) format. The
BED format can be visualized in genome browser directly and the peaks may
span one or multiple introns. The diﬀerence between peak and consistent peak
is that, the peaks in the con |peak ﬁle are consitently enriched in all the IP
replicates, so indicates higher re-producability.

The ﬁrst 12 columns in both the BED and the XLS are the same as a stan-
dard BED12 format: http://genome.ucsc.edu/FAQ/FAQformat.html#format1

(cid:136) chrom - The name of the chromosome (e.g. chr3, chrY, chr2 random) or

scaﬀold (e.g. scaﬀold10671).

(cid:136) chromStart - The starting position of the methylation site in the chromo-

some or scaﬀold.

2

(cid:136) chromEnd - The ending position of the RNA methylation site in the chro-

mosome or scaﬀold.

(cid:136) name - Deﬁnes the name of gene on which the RNA methylation site

locates

(cid:136) score - p-value of the peak
(cid:136) strand - Deﬁnes the strand - either ’+’ or ’-’. This is inferred based on

gene annotation.

(cid:136) thickStart - The same as ”chromStart”. The starting position of the methy-

lation site in the chromosome or scaﬀold.

(cid:136) thickEnd - The same as ”chromEnd”. The ending position of the methy-

lation site in the chromosome or scaﬀold.

(cid:136) itemRgb - always 0
(cid:136) blockCount - The number of blocks (exons) the RNA methylation site

spans.

(cid:136) blockSizes - A comma-separated list of the block sizes. The number of

items in this list should correspond to blockCount.

(cid:136) blockStarts - A comma-separated list of block starts. All of the blockStart
positions should be calculated relative to chromStart. The number of items
in this list should correspond to blockCount.

The meaning of the last 3 columns of the xls ﬁle is:
(cid:136) lg.p - log10(p-value) of the peak, indicating the signiﬁcance of the peak as

an RNA methylation site

(cid:136) lg.fdr - log10(fdr) of the peak, indicating the signiﬁcance of the peak as

an RNA methylation site after multiple hypothesis correction

(cid:136) fold enrichment - fold enrichment within the peak in the IP sample com-

pared with the input sample.

> recommended_peaks <- result$con_peaks # consistent peaks (Recommended!)
> peaks_info <- mcols(recommended_peaks) # information of the consistent peaks
> head(peaks_info)

DataFrame with 6 rows and 3 columns

lg.p

<numeric> <numeric>
-46.5
-14.0
-13.9
-219.0
-13.6
-161.0

-47.8
-15.1
-15.0
-221.0
-14.6
-163.0

lg.fdr fold_enrchment
<numeric>
8.05
9.55
3.78
15.50
5.81
17.50

1
2
3
4
5
6

3

or to get all the peak detected (some of them do not consistently appear on

all replicates:

> all_peaks <- result$all_peaks # get all peaks
> peaks_info <- mcols(all_peaks) # information of all peaks
> head(peaks_info)

DataFrame with 6 rows and 3 columns

lg.p

<numeric> <numeric>
-6.04
-46.50
-13.90
-219.00
-13.60
-161.00

-6.9
-47.8
-15.0
-221.0
-14.6
-163.0

lg.fdr fold_enrchment
<numeric>
2.66
9.55
3.78
15.50
5.81
17.50

1
2
3
4
5
6

3 Peak Calling and Diﬀerential Methylation Anal-

ysis

When there are MeRIP-Seq data available from two experimental conditions,
the exomePeak function may can unveil the dynamics in post-transcriptional
regulation of the RNA methylome. In the following example, the function will
report the sites that are post-transcriptional diﬀerentially methylated between
the two tested conditions (TREATED vs. UNTREATED).

Again, let us ﬁrstly load the package and get the toy data (came with the

package) ready.

> library("exomePeak")
> gtf <- system.file("extdata", "example.gtf", package="exomePeak")
> f1 <- system.file("extdata", "IP1.bam", package="exomePeak")
> f2 <- system.file("extdata", "IP2.bam", package="exomePeak")
> f3 <- system.file("extdata", "IP3.bam", package="exomePeak")
> f4 <- system.file("extdata", "IP4.bam", package="exomePeak")
> f5 <- system.file("extdata", "Input1.bam", package="exomePeak")
> f6 <- system.file("extdata", "Input2.bam", package="exomePeak")
> f7 <- system.file("extdata", "Input3.bam", package="exomePeak")
> f8 <- system.file("extdata", "treated_IP1.bam", package="exomePeak")
> f9 <- system.file("extdata", "treated_Input1.bam", package="exomePeak")

Please note that, this time we have two additional bam ﬁles obtained under

a diﬀerent ”Treated” condition, i.e., f8 and f9.

> result <- exomepeak(GENE_ANNO_GTF=gtf,
+
+

IP_BAM=c(f1,f2,f3,f4),
INPUT_BAM=c(f5,f6,f7),

4

+
+

TREATED_IP_BAM=c(f8),
TREATED_INPUT_BAM=c(f9))

[1] "Divide transcriptome into chr-gene-batch sections ..."
[1] "Get Reads Count ..."
[1] "This step may take a few hours ..."
[1] "100 %"
[1] "Comparing two conditions ..."
[1] "Get all the peaks ..."
[1] "Get the consistent peaks ..."
[1] "---------------------------------"
[1] "The bam files used:"
[1] "4 IP replicate(s)"
[1] "3 Input replicate(s)"
[1] "1 TREATED IP replicate(s)"
[1] "1 TREATED Input replicate(s)"
[1] "---------------------------------"
[1] "Peak calling and differential analysis result: "
[1] "13 peaks detected."
[1] "Please check
[1] "---------------------------------"
[1] "0 significantly differential methylated peaks are detected."
[1] "Please check
[1] "---------------------------------"
[1] "0 consistent significantly differential methylated peaks are detected.(Recommended list) "
[1] "Please check
[1] "---------------------------------"

con_sig_diff_peak.bed/xls

sig_diff_peak.bed/xls

diff_peak.bed/xls

’

’

’

’

’

’

under /tmp/RtmpP3mhfd/Rbuild3d8b10b94329/exomePeak/vignettes/exomePeak_output"

under /tmp/RtmpP3mhfd/Rbuild3d8b10b94329/exomePeak/vignettes/exomePeak_output"

under /tmp/RtmpP3mhfd/Rbuild3d8b10b94329/exomePeak/vignettes/exomePeak_output"

The algorithm will ﬁrstly identify reads enriched binding sites or peaks, and
then check whether the sites are diﬀerentially methylated between the two exper-
imental conditions. The results will be saved in the speciﬁed output directory,
including the identiﬁed (consistent) peaks in BED and tab-delimited formats,
along with the diﬀerential information indicating whether the site is hyper- or
hypo-methylated under the treated condition. Similar to the peak calling case,
the BED format can be visualized in genome browser directly and the peaks
may span one or multiple introns.

Similar to the peak calling case, the function will report a set of consistent dif-
ferentially methylated peaks (con sig diﬀ peak.xls) saved in the speciﬁed folder,
which is the recommended set.

(cid:136) diﬀ peak.xls - all the detected peaks and their diﬀerential methylation

information

(cid:136) sig diﬀ peak.xls - all the diﬀerentially methylated peaks

(cid:136) con sig diﬀ peak.xls - all the consistently diﬀerentially methylated peaks.
There are peaks are consistently diﬀerentially methylated among all repli-

5

cates, indicating highly conﬁdence. This set of diﬀerential methylation
peaks is highly suggested.

Along with the XLS ﬁles, the matched BED ﬁles are also generated for visual-
ization purpose.

Similar to before,
(cid:136) The ﬁrst 12 columns in both the BED and the XLS are the same following

the standard BED12 format: http://genome.ucsc.edu/FAQ/FAQformat.html#format1
For more details, please previous section for detailed description of the ﬁrst
12 columns.

(cid:136) lg.p, lg.fdr, fold enrchment are results from peak detection step, i.e., log10(pvalue),

log10(fdr) and fold enrichment of the detected peak as a true methyla-
tion site. Speciﬁcally, when dealing with two experimental conditions, the
fold enrichment indicates whether reads are more enriched in the pooled
IP sample under both conditions than in the pooled Input sample under
both conditions. The enrichment change needs to be greater than 1 to be
considered being enriched as an RNA methylation site.

(cid:136) diﬀ.lg.fdr, diﬀ.lg.p, diﬀ.log2.fc are results from diﬀerential methylation
analysis, i.e., log10(fdr), log10(pvalue) and log2(odds ratio) of the peak
as a diﬀerential methylation site between the two experimental conditions
tested. If diﬀ.log2.fc is larger than 0, the site is hypermethylated under
the treated condition, otherwise if smaller than 0, it is hypomethylated
under the treated condition.

The function also returns 3 GRangesList object, containing all the peaks,
the diﬀerentially methylated peaks with the given threshold on the merged data,
consistently diﬀerentially methylated peaks. The consistent diﬀerentially methy-
lated peaks in the last appear to be diﬀerential for all the replicates and is thus
recommended. The information of the identiﬁed peaks and the diﬀerential anal-
ysis are stored as metadata, which can be extracted.

> names(result)

[1] "diff_peaks"
[3] "con_sig_diff_peaks"

"sig_siff_peaks"

> is.na(result$con_sig_diff_peaks) # no reported consistent differnetial peaks

[1] TRUE

Unfortunately, there is no reported consistent diﬀernetial peaks on the toy
data, to get the information of all the peaks and the diﬀerential analysis infor-
mation:

> diff_peaks <- result$diff_peaks # consistent differential peaks (Recommended!)
> peaks_info <- mcols(diff_peaks) # information of the consistent peaks
> head(peaks_info[,1:3]) # peak calling information

6

DataFrame with 6 rows and 3 columns

lg.p

<numeric> <numeric>
-5.05
-49.50
-23.50
-220.00
-14.40
-170.00

-5.91
-50.70
-24.70
-222.00
-15.40
-171.00

lg.fdr fold_enrchment
<numeric>
2.47
9.19
5.00
14.40
5.97
14.70

1
2
3
4
5
6

> head(peaks_info[,4:6]) # differential analysis information

DataFrame with 6 rows and 3 columns

diff.lg.fdr diff.lg.p diff.log2.fc
<numeric>
-1.180
0.775
1.780
-1.750
-1.050
-1.450

<numeric> <numeric>
-0.402
-0.296
-0.689
-2.090
-0.342
-2.200

-0.262
-0.262
-0.274
-1.280
-0.262
-1.280

1
2
3
4
5
6

4 Download Gene Annotation Directly from In-

ternet

Gene annotation may be alternatively downloaded directly from internet, but
will take a really long time due to the downloading time and huge transcriptome
needed to be scanned.

> result <- exomepeak(GENOME="hg19",
+
+
+
+

IP_BAM=c(f1,f2,f3,f4),
INPUT_BAM=c(f5,f6,f7),
TREATED_IP_BAM=c(f8),
TREATED_INPUT_BAM=c(f9))

Please make sure to use the right genome assembly.

5 Handling Paired-end Reads

Unfortunately, exomePeak currently supports pair-end data in a na??ve mode,
i.e., treat pair of reads as two independent reads rather than a single fragment.
”treat pair of reads as two independent reads rather than a single fragment”
refers to the internal process of exomePeak package, not how you align the
reads. Even if the paired end data is aligned as paired end data, the pairing
information will still be ignored when analyzed by exomePeak.

7

6 Session Information

> sessionInfo()

R version 3.4.3 (2017-11-30)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[6] utils

parallel stats
datasets methods

graphics grDevices
base

other attached packages:

GenomicAlignments_1.14.1

[1] exomePeak_2.13.2
[3] SummarizedExperiment_1.8.1 DelayedArray_0.4.1
rtracklayer_1.38.2
[5] matrixStats_0.52.2
AnnotationDbi_1.40.0
[7] GenomicFeatures_1.30.0
Rsamtools_1.30.0
[9] Biobase_2.38.0
XVector_0.18.0
GenomeInfoDb_1.14.0
S4Vectors_0.16.0

[11] Biostrings_2.46.0
[13] GenomicRanges_1.30.0
[15] IRanges_2.12.0
[17] BiocGenerics_0.24.0

loaded via a namespace (and not attached):
compiler_3.4.3
bitops_1.0-6
zlibbioc_1.24.0
biomaRt_2.34.1
bit_1.1-12
RSQLite_2.0
tibble_1.3.4
rlang_0.1.4
DBI_0.7

[1] Rcpp_0.12.14
[3] prettyunits_1.0.2
[5] tools_3.4.3
[7] progress_1.1.2
[9] digest_0.6.13
[11] lattice_0.20-35
[13] memoise_1.1.0
[15] pkgconfig_2.0.1
[17] Matrix_1.2-12
[19] GenomeInfoDbData_1.0.0 stringr_1.2.0

8

[21] httr_1.3.1
[23] bit64_0.9-7
[25] XML_3.98-1.9
[27] BiocParallel_1.12.0
[29] magrittr_1.5
[31] stringi_1.1.6

grid_3.4.3
R6_2.2.2
RMySQL_0.10.13
blob_1.1.0
assertthat_0.2.0
RCurl_1.95-4.8

9

