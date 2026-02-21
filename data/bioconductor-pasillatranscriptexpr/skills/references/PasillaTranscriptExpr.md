Generation of transcript counts from pasilla
dataset with kallisto

Malgorzata Nowicka1, Mark Robinson

November 4, 2025

This vignette describes version 1.38.0 of the PasillaTranscriptExpr package.

Contents

1

2

3

4

5

A

B

Description of pasilla dataset .

Required software .

.

.

.

.

.

.

Downloading the pasilla data .

.

.

.

.

.

.

.

.

.

.

.

.

Downloading the reference genome .

Transcript quantification with kallisto .

APPENDIX .

.

.

.

.

.

Session information .

References .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

2

2

3

3

7

7

8

1

Description of pasilla dataset

The pasilla dataset was produced by Brooks et al. [1]. The aim of their study was
to identify exons that are regulated by pasilla protein, the Drosophila melanogaster
ortholog of mammalian NOVA1 and NOVA2 (well studied splicing factors). In their
RNA-seq experiment, the libraries were prepared from 7 biologically independent
samples: 4 control samples and 3 samples in which pasilla was knocked-down. The
libraries were sequenced on the Illumina Genome Analyzer II using single-end and
paired-end sequencing and different read lengths. The RNA-seq data can be down-
loaded from the NCBI’s Gene Expression Omnibus (GEO) under the accession number
GSE18508.

1gosia.nowicka@uzh.ch

Generation of transcript counts from pasilla dataset with kallisto

2

Required software

This work-flow can be run on a Unix-like operating system, i.e., Linux or MacOS
X with bash shell. All commands, including the one that could be run from termi-
nal window, are run from within R using system() function. The downloaded and
generated files will be saved in the current working directory.

Brooks et al. deposited their data in the Short Read Archive.
In order to convert
SRA data into fastq format, you need to install the SRA toolkit available on http:
//www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software.

For the transcript quantification, we use kallisto version 0.42.1 [2], which is an ex-
tremely fast program that quantifies abundances of transcripts. kallisto is based on
the novel idea of pseudoalignment to rapidly determine the compatibility of reads
with transcripts, without the need for alignment. Thus it works directly on fastq
files. The quantification is available in transcripts per million (TPM) and in expected
counts.
In this package, we make available the expected counts. kallisto can be
downloaded from http://pachterlab.github.io/kallisto/.

3

Downloading the pasilla data

We use an automated process to download the SRA files that correspond to 4 control
(Untreated) samples and 3 pasilla knocked-down (CG8144_RNAi) samples. All the
information about the pasilla assay can be found in the metadata file SraRunInfo.csv,
which can be downloaded from http://www.ncbi.nlm.nih.gov/sra?term=SRP001537
under Send to: → File → RunInfo → Create File. The same file is also available
within this package in the extdata directory.

library(PasillaTranscriptExpr)

data_dir <- system.file("extdata", package = "PasillaTranscriptExpr")

sri <- read.table(paste0(data_dir, "/SraRunInfo.csv"), stringsAsFactors = FALSE,

sep = ",", header = TRUE)

keep <- grep("CG8144|Untreated-", sri$LibraryName)

sri <- sri[keep, ]

sra_files <- basename(sri$download_path)

for(i in 1:nrow(sri))

download.file(sri$download_path[i], sra_files[i])

To convert the SRA files to fastq format, we use the fastq-dump command from the
SRA toolkit. Then, we compress the fastq files.

2

Generation of transcript counts from pasilla dataset with kallisto

cmd <- paste0("fastq-dump -O ./ --split-3 ", sra_files)

for(i in 1:length(cmd))

system(cmd[i])

system("gzip *.fastq")

4

Downloading the reference genome

To run kallisto, you need to download a FASTA formatted file of target sequences:

system("wget ftp://ftp.ensembl.org/pub/release-70/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP5.70.cdna.all.fa.gz")
system("gunzip Drosophila_melanogaster.BDGP5.70.cdna.all.fa.gz")

The output produced by kallisto contains only the transcript IDs. To add the corre-
sponding gene IDs, we need to download the gene model annotation in GTF format:

system("wget ftp://ftp.ensembl.org/pub/release-70/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP5.70.gtf.gz")
system("gunzip Drosophila_melanogaster.BDGP5.70.gtf.gz")

5

Transcript quantification with kallisto

We create a metadata file where each row corresponds to a collection of information
needed for a single call of kallisto. The pasilla data consists of paired-end and single-
end samples. When you run kallisto on single-end reads, you have to specify an -l
option which defines the average fragment length. It can be found in sri$avgLength.
There is one sample (GSM461179) which was sequenced using different read lengths.
Therefore, for this sample, we do the transcript quantification for each read length
separately and we add the resulting transcript counts in another step.

sri$LibraryName <- gsub("S2_DRSC_","",sri$LibraryName)
metadata <- unique(sri[,c("LibraryName", "LibraryLayout", "SampleName",

"avgLength")])

for(i in seq_len(nrow(metadata))){

indx <- sri$LibraryName == metadata$LibraryName[i]

if(metadata$LibraryLayout[i] == "PAIRED"){

metadata$fastq[i] <- paste0(sri$Run[indx], "_1.fastq.gz ",

sri$Run[indx], "_2.fastq.gz", collapse = " ")

}else{

metadata$fastq[i] <- paste0(sri$Run[indx], ".fastq.gz", collapse = " ")

}

3

Generation of transcript counts from pasilla dataset with kallisto

}

metadata$condition <- ifelse(grepl("CG8144_RNAi", metadata$LibraryName),

"KD", "CTL")

metadata$UniqueName <- paste0(1:nrow(metadata), "_", metadata$SampleName)

In the first step of kallisto work-flow, we build an index with kallisto index :

cDNA_fasta <- "Drosophila_melanogaster.BDGP5.70.cdna.all.fa"
index <- "Drosophila_melanogaster.BDGP5.70.cdna.all.idx"

cmd <- paste("kallisto index -i", index, cDNA_fasta, sep = " ")
cmd
## [1] "kallisto index -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx Drosophila_melanogaster.BDGP5.70.cdna.all.fa"

system(cmd)

The quantification is done with kallisto quant command:

out_dir <- metadata$UniqueName

cmd <- paste("kallisto quant -i", index, "-o", out_dir, "-b 0 -t 5",

ifelse(metadata$LibraryLayout == "SINGLE",

paste("--single -l", metadata$avgLength), ""), metadata$fastq)

cmd
## [1] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 1_GSM461176 -b 0 -t 5 --single -l 45 SRR031708.fastq.gz SRR031709.fastq.gz SRR031710.fastq.gz SRR031711.fastq.gz SRR031712.fastq.gz SRR031713.fastq.gz"
## [2] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 2_GSM461177 -b 0 -t 5
SRR031714_1.fastq.gz SRR031714_2.fastq.gz SRR031715_1.fastq.gz SRR031715_2.fastq.gz"
## [3] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 3_GSM461178 -b 0 -t 5 SRR031716_1.fastq.gz SRR031716_2.fastq.gz SRR031717_1.fastq.gz SRR031717_2.fastq.gz"
## [4] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 4_GSM461179 -b 0 -t 5 --single -l 45 SRR031718.fastq.gz SRR031719.fastq.gz SRR031720.fastq.gz SRR031721.fastq.gz SRR031722.fastq.gz SRR031723.fastq.gz"
## [5] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 5_GSM461179 -b 0 -t 5 --single -l 44 SRR031718.fastq.gz SRR031719.fastq.gz SRR031720.fastq.gz SRR031721.fastq.gz SRR031722.fastq.gz SRR031723.fastq.gz"
## [6] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 6_GSM461179 -b 0 -t 5 --single -l 40 SRR031718.fastq.gz SRR031719.fastq.gz SRR031720.fastq.gz SRR031721.fastq.gz SRR031722.fastq.gz SRR031723.fastq.gz"
## [7] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 7_GSM461180 -b 0 -t 5 SRR031724_1.fastq.gz SRR031724_2.fastq.gz SRR031725_1.fastq.gz SRR031725_2.fastq.gz"
## [8] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 8_GSM461181 -b 0 -t 5 SRR031726_1.fastq.gz SRR031726_2.fastq.gz SRR031727_1.fastq.gz SRR031727_2.fastq.gz"
## [9] "kallisto quant -i Drosophila_melanogaster.BDGP5.70.cdna.all.idx -o 9_GSM461182 -b 0 -t 5 --single -l 75 SRR031728.fastq.gz SRR031729.fastq.gz"

for(i in 1:length(cmd))

system(cmd[i])

We want to add the gene information and merge the expected transcript counts from
different samples into one table.

library(rtracklayer)

gtf_dir <- "Drosophila_melanogaster.BDGP5.70.gtf"

4

Generation of transcript counts from pasilla dataset with kallisto

gtf <- import(gtf_dir)

gt <- unique(mcols(gtf)[, c("gene_id", "transcript_id")])
rownames(gt) <- gt$transcript_id

samples <- unique(metadata$SampleName)

counts_list <- lapply(1:length(samples), function(i){
indx <- which(metadata$SampleName == samples[i])

if(length(indx) == 1){

abundance <- read.table(file.path(metadata$UniqueName[indx],

"abundance.txt"), header = TRUE, sep = "\t", as.is = TRUE)

}else{

abundance <- lapply(indx, function(j){

abundance_tmp <- read.table(file.path(metadata$UniqueName[j],
"abundance.txt"), header = TRUE, sep = "\t", as.is = TRUE)
abundance_tmp <- abundance_tmp[, c("target_id", "est_counts")]
abundance_tmp

})
abundance <- Reduce(function(...) merge(..., by = "target_id", all = TRUE,

sort = FALSE), abundance)

est_counts <- rowSums(abundance[, -1])
abundance <- data.frame(target_id = abundance$target_id,
est_counts = est_counts, stringsAsFactors = FALSE)

}

counts <- data.frame(abundance$target_id, abundance$est_counts,

stringsAsFactors = FALSE)

colnames(counts) <- c("feature_id", samples[i])
return(counts)

})

counts <- Reduce(function(...) merge(..., by = "feature_id", all = TRUE,

sort = FALSE), counts_list)

### Add gene IDs
counts$gene_id <- gt[counts$feature_id, "gene_id"]

At the end, we keep only the unique samples in our metadata file.

metadata <- unique(metadata[, c("LibraryName", "LibraryLayout", "SampleName",

"condition")])

metadata

##

LibraryName LibraryLayout SampleName condition

5

Generation of transcript counts from pasilla dataset with kallisto

## 156

Untreated-1

SINGLE

GSM461176

## 162

Untreated-3

PAIRED

GSM461177

Untreated-4
## 164
## 166 CG8144_RNAi-1
## 172 CG8144_RNAi-3
## 174 CG8144_RNAi-4
Untreated-6
## 176

PAIRED

GSM461178

SINGLE

GSM461179

PAIRED

GSM461180

PAIRED

GSM461181

SINGLE

GSM461182

CTL

CTL

CTL

KD

KD

KD

CTL

write.table(metadata, "metadata.txt", quote = FALSE, sep = "\t",

row.names = FALSE)

### Final counts with columns sorted as in metadata
counts <- counts[, c("feature_id", "gene_id", metadata$SampleName)]
write.table(counts, "counts.txt", quote = FALSE, sep = "\t", row.names = FALSE)

6

Generation of transcript counts from pasilla dataset with kallisto

APPENDIX

A

Session information

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

## other attached packages:
## [1] rtracklayer_1.70.0
## [3] Seqinfo_1.0.0
## [5] S4Vectors_0.48.0
## [7] generics_0.1.4
## [9] knitr_1.50
##

GenomicRanges_1.62.0
IRanges_2.44.0
BiocGenerics_0.56.0
PasillaTranscriptExpr_1.38.0

## loaded via a namespace (and not attached):
## [1] Matrix_1.7-4
## [3] compiler_4.5.1
## [5] rjson_0.2.23
## [7] crayon_1.5.3
## [9] Biobase_2.70.0
## [11] Rsamtools_2.26.0
## [13] Biostrings_2.78.0
## [15] BiocParallel_1.44.0
## [17] fastmap_1.2.0

BiocStyle_2.38.0
BiocManager_1.30.26
highr_0.11
SummarizedExperiment_1.40.0
GenomicAlignments_1.46.0
bitops_1.0-9
parallel_4.5.1
yaml_2.3.10
lattice_0.22-7

7

Generation of transcript counts from pasilla dataset with kallisto

## [19] R6_2.6.1
## [21] S4Arrays_1.10.0
## [23] XML_3.99-0.19
## [25] MatrixGenerics_1.22.0
## [27] xfun_0.54
## [29] cli_3.6.5
## [31] digest_0.6.37
## [33] cigarillo_1.0.0
## [35] abind_1.4-8
## [37] restfulr_0.0.16
## [39] httr_1.4.7
## [41] tools_4.5.1
## [43] htmltools_0.5.8.1

XVector_0.50.0
curl_7.0.0
DelayedArray_0.36.0
rlang_1.1.6
SparseArray_1.10.1
grid_4.5.1
evaluate_1.0.5
codetools_0.2-20
RCurl_1.98-1.17
rmarkdown_2.30
matrixStats_1.5.0
BiocIO_1.20.0

B

References

References

[1] A. N. Brooks, L. Yang, M. O. Duff, K. D. Hansen, J. W. Park, S. Dudoit, S. E.
Brenner, and B. R. Graveley, “Conservation of an RNA regulatory map between
Drosophila and mammals.,” Genome research, vol. 21, no. 2, pp. 193–202, 2011.

[2] N. L. Bray, H. Pimentel, P. Melsted, and L. Pachter, “Near-optimal RNA-Seq

quantification.”.

8

