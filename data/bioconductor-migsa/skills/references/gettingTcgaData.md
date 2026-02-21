MIGSA: Getting TCGA datasets

Juan C Rodriguez
CONICET
Universidad Cat´olica de C´ordoba
Universidad Nacional de C´ordoba

Crist´obal Fresno
Instituto Nacional de Medicina Gen´omica

Andrea S Llera
CONICET
Fundaci´on Instituto Leloir

Elmer A Fern´andez
CONICET
Universidad Cat´olica de C´ordoba
Universidad Nacional de C´ordoba

Abstract

In this vignette we are going to show how we got the RData tcgaMAdata.RData which
can be loaded via the MIGSAdata package using data(tcgaMAdata) and tcgaRNAseq-
Data.RData which can be loaded using data(tcgaRNAseqData).

Keywords: singular enrichment analysis, over representation analysis, gene set enrichment
analysis, functional class scoring, big omics data.

1. Getting the data

From the TCGA data portal the breast invasive carcinoma (BRCA) microarray and RNAseq
datasets present at the date were downloaded. PAM50 subtypes Basal vs. Luminal A were
evaluated. With these subjects, tcgaMAdata.RData and tcgaRNAseqData.RData were built.

1.1. Basal-like subjects

Basal-like TCGA subjects identiﬁers used:

> library(MIGSAdata);
> data(tcgaMAdata);
> names(tcgaMAdata$subtypes)[ tcgaMAdata$subtypes == "Basal" ];

[1] "TCGA-BH-A0E0-01A-11R-A056-07" "TCGA-AO-A0JL-01A-11R-A056-07"
[3] "TCGA-B6-A0RE-01A-11R-A056-07" "TCGA-BH-A0B3-01A-11R-A056-07"
[5] "TCGA-AN-A0AL-01A-11R-A00Z-07" "TCGA-A2-A0YJ-01A-11R-A109-07"
[7] "TCGA-AR-A0U4-01A-11R-A109-07" "TCGA-B6-A0WX-01A-11R-A109-07"
[9] "TCGA-A2-A0YM-01A-11R-A109-07" "TCGA-A2-A0YE-01A-11R-A109-07"
[11] "TCGA-B6-A0X1-01A-11R-A109-07" "TCGA-AR-A0TU-01A-31R-A109-07"
[13] "TCGA-BH-A0WA-01A-11R-A109-07" "TCGA-AN-A0XU-01A-11R-A109-07"

2

MIGSA: Getting TCGA datasets

[15] "TCGA-AR-A0U0-01A-11R-A109-07" "TCGA-E2-A108-01A-13R-A10J-07"
[17] "TCGA-AO-A124-01A-11R-A10J-07" "TCGA-AO-A128-01A-11R-A10J-07"
[19] "TCGA-AO-A129-01A-21R-A10J-07" "TCGA-BH-A0BG-01A-11R-A115-07"
[21] "TCGA-BH-A0DL-01A-11R-A115-07" "TCGA-AO-A12F-01A-11R-A115-07"
[23] "TCGA-C8-A131-01A-11R-A115-07" "TCGA-E2-A14R-01A-11R-A115-07"
[25] "TCGA-BH-A0BL-01A-11R-A115-07" "TCGA-AR-A0U1-01A-11R-A115-07"
[27] "TCGA-A2-A04U-01A-11R-A115-07" "TCGA-C8-A12K-01A-21R-A115-07"
[29] "TCGA-C8-A134-01A-11R-A115-07" "TCGA-D8-A142-01A-11R-A115-07"
[31] "TCGA-E2-A14X-01A-11R-A115-07" "TCGA-C8-A12V-01A-11R-A115-07"
[33] "TCGA-D8-A143-01A-11R-A115-07" "TCGA-BH-A0AV-01A-31R-A115-07"
[35] "TCGA-BH-A0BW-01A-11R-A115-07" "TCGA-A7-A0DA-01A-31R-A115-07"
[37] "TCGA-D8-A147-01A-11R-A115-07" "TCGA-BH-A0BW-11A-12R-A115-07"
[39] "TCGA-AR-A0TS-01A-11R-A115-07" "TCGA-D8-A13Z-01A-11R-A115-07"
[41] "TCGA-A8-A08H-01A-21R-A00Z-07" "TCGA-A2-A0D0-01A-11R-A00Z-07"
[43] "TCGA-AN-A0FJ-01A-11R-A00Z-07" "TCGA-A8-A07O-01A-11R-A00Z-07"
[45] "TCGA-AN-A0AT-01A-11R-A034-07" "TCGA-A2-A0CM-01A-31R-A034-07"
[47] "TCGA-A2-A04T-01A-21R-A034-07" "TCGA-A7-A0CE-01A-11R-A00Z-07"
[49] "TCGA-AO-A03R-01A-21R-A034-07" "TCGA-AN-A04D-01A-21R-A034-07"
[51] "TCGA-AQ-A04J-01A-02R-A034-07" "TCGA-A2-A04P-01A-31R-A034-07"
[53] "TCGA-A2-A04Q-01A-21R-A034-07" "TCGA-A8-A07C-01A-11R-A034-07"
[55] "TCGA-A8-A07R-01A-21R-A034-07" "TCGA-A8-A07U-01A-11R-A034-07"
[57] "TCGA-A8-A08R-01A-11R-A034-07" "TCGA-A2-A0D2-01A-21R-A034-07"
[59] "TCGA-BH-A0E6-01A-11R-A034-07" "TCGA-AN-A0FL-01A-11R-A034-07"
[61] "TCGA-AN-A0FX-01A-11R-A034-07" "TCGA-AN-A0G0-01A-11R-A034-07"
[63] "TCGA-B6-A0I2-01A-11R-A034-07" "TCGA-B6-A0I6-01A-11R-A034-07"
[65] "TCGA-B6-A0IJ-01A-11R-A034-07" "TCGA-AO-A0J4-01A-11R-A034-07"
[67] "TCGA-AO-A0J6-01A-11R-A034-07" "TCGA-B6-A0IQ-01A-11R-A034-07"
[69] "TCGA-BH-A0RX-01A-21R-A084-07" "TCGA-A2-A0ST-01A-12R-A084-07"
[71] "TCGA-B6-A0RU-01A-11R-A084-07" "TCGA-A1-A0SO-01A-22R-A084-07"
[73] "TCGA-A2-A0T0-01A-22R-A084-07" "TCGA-A1-A0SP-01A-11R-A084-07"
[75] "TCGA-A1-A0SK-01A-12R-A084-07" "TCGA-A2-A0SX-01A-12R-A084-07"
[77] "TCGA-B6-A0RT-01A-21R-A084-07" "TCGA-AR-A0TP-01A-11R-A084-07"
[79] "TCGA-A7-A0DB-11A-33R-A089-07" "TCGA-A2-A0T2-01A-11R-A084-07"
[81] "TCGA-AR-A1AH-01A-11R-A12D-07" "TCGA-E2-A158-01A-11R-A12D-07"
[83] "TCGA-BH-A18V-01A-11R-A12D-07" "TCGA-E2-A14Y-01A-21R-A12D-07"
[85] "TCGA-E2-A150-01A-11R-A12D-07" "TCGA-BH-A18G-01A-11R-A12D-07"
[87] "TCGA-BH-A18Q-01A-12R-A12D-07" "TCGA-A7-A13D-01A-13R-A12P-07"
[89] "TCGA-AR-A1AO-01A-11R-A12P-07" "TCGA-A7-A13E-01A-11R-A12P-07"
[91] "TCGA-AR-A1AY-01A-21R-A12P-07" "TCGA-AR-A1AQ-01A-11R-A12P-07"
[93] "TCGA-AR-A1AR-01A-31R-A137-07" "TCGA-E2-A14N-01A-31R-A137-07"
[95] "TCGA-BH-A1F0-01A-11R-A137-07"

1.2. Luminal A subjects

Luminal A TCGA subjects identiﬁers used:

> library(MIGSAdata);

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

3

> data(tcgaMAdata);
> names(tcgaMAdata$subtypes)[ tcgaMAdata$subtypes == "LumA" ];

[1] "TCGA-BH-A0BA-01A-11R-A056-07" "TCGA-BH-A0DS-01A-11R-A056-07"
[3] "TCGA-BH-A0H6-01A-21R-A056-07" "TCGA-AO-A0JJ-01A-11R-A056-07"
[5] "TCGA-A8-A0A6-01A-12R-A056-07" "TCGA-BH-A0BJ-01A-11R-A056-07"
[7] "TCGA-BH-A0DP-01A-21R-A056-07" "TCGA-A8-A08O-01A-21R-A056-07"
[9] "TCGA-A8-A0AD-01A-11R-A056-07" "TCGA-BH-A0BM-01A-11R-A056-07"
[11] "TCGA-BH-A0HF-01A-11R-A056-07" "TCGA-A7-A0D9-01A-31R-A056-07"
[13] "TCGA-BH-A0HK-01A-11R-A056-07" "TCGA-BH-A0GZ-01A-11R-A056-07"
[15] "TCGA-AO-A0JF-01A-11R-A056-07" "TCGA-B6-A0WT-01A-11R-A109-07"
[17] "TCGA-AN-A0XV-01A-11R-A109-07" "TCGA-AN-A0XO-01A-11R-A109-07"
[19] "TCGA-AN-A0XP-01A-11R-A109-07" "TCGA-A2-A0YD-01A-11R-A109-07"
[21] "TCGA-BH-A0W4-01A-11R-A109-07" "TCGA-B6-A0WZ-01A-11R-A109-07"
[23] "TCGA-AN-A0XS-01A-22R-A109-07" "TCGA-BH-A0W5-01A-11R-A109-07"
[25] "TCGA-AN-A0XT-01A-11R-A109-07" "TCGA-B6-A0X4-01A-11R-A109-07"
[27] "TCGA-AO-A12G-01A-11R-A10J-07" "TCGA-AO-A125-01A-11R-A10J-07"
[29] "TCGA-AO-A126-01A-11R-A10J-07" "TCGA-BH-A0B2-01A-11R-A10J-07"
[31] "TCGA-A2-A0YI-01A-31R-A10J-07" "TCGA-E2-A10E-01A-21R-A10J-07"
[33] "TCGA-AO-A12C-01A-11R-A10J-07" "TCGA-E2-A10F-01A-11R-A10J-07"
[35] "TCGA-AO-A12E-01A-11R-A10J-07" "TCGA-E2-A106-01A-11R-A10J-07"
[37] "TCGA-B6-A0X7-01A-11R-A10J-07" "TCGA-AN-A0XL-01A-11R-A10J-07"
[39] "TCGA-AO-A03V-01A-11R-A115-07" "TCGA-BH-A0H5-01A-21R-A115-07"
[41] "TCGA-A2-A04N-01A-11R-A115-07" "TCGA-AO-A12H-01A-11R-A115-07"
[43] "TCGA-C8-A132-01A-31R-A115-07" "TCGA-D8-A141-01A-11R-A115-07"
[45] "TCGA-E2-A15P-01A-11R-A115-07" "TCGA-BH-A0BP-01A-11R-A115-07"
[47] "TCGA-A2-A0CS-01A-11R-A115-07" "TCGA-B6-A0IH-01A-11R-A115-07"
[49] "TCGA-BH-A0BQ-01A-21R-A115-07" "TCGA-A2-A0CV-01A-31R-A115-07"
[51] "TCGA-B6-A0WS-01A-11R-A115-07" "TCGA-BH-A0EA-01A-11R-A115-07"
[53] "TCGA-B6-A0X0-01A-21R-A115-07" "TCGA-D8-A145-01A-11R-A115-07"
[55] "TCGA-BH-A0B0-01A-21R-A115-07" "TCGA-A2-A0D3-01A-11R-A115-07"
[57] "TCGA-BH-A0EI-01A-11R-A115-07" "TCGA-A1-A0SD-01A-11R-A115-07"
[59] "TCGA-C8-A12N-01A-11R-A115-07" "TCGA-D8-A146-01A-31R-A115-07"
[61] "TCGA-AO-A12A-01A-21R-A115-07" "TCGA-E2-A15D-01A-11R-A115-07"
[63] "TCGA-BH-A0DE-01A-11R-A115-07" "TCGA-A2-A0EW-01A-21R-A115-07"
[65] "TCGA-A8-A08T-01A-21R-A00Z-07" "TCGA-A7-A0CH-01A-21R-A00Z-07"
[67] "TCGA-A8-A07J-01A-11R-A00Z-07" "TCGA-A8-A06Y-01A-21R-A00Z-07"
[69] "TCGA-A8-A09A-01A-11R-A00Z-07" "TCGA-A8-A091-01A-11R-A00Z-07"
[71] "TCGA-A8-A09B-01A-11R-A00Z-07" "TCGA-A7-A0CD-01A-11R-A00Z-07"
[73] "TCGA-A7-A0DB-01A-11R-A00Z-07" "TCGA-A8-A09V-01A-11R-A034-07"
[75] "TCGA-A8-A0A2-01A-11R-A034-07" "TCGA-A2-A0CP-01A-11R-A034-07"
[77] "TCGA-A2-A0CQ-01A-21R-A034-07" "TCGA-A8-A06P-01A-11R-A00Z-07"
[79] "TCGA-A8-A093-01A-11R-A00Z-07" "TCGA-A7-A0DC-01A-11R-A00Z-07"
[81] "TCGA-AN-A046-01A-21R-A034-07" "TCGA-AN-A04A-01A-21R-A034-07"
[83] "TCGA-A8-A07G-01A-11R-A034-07" "TCGA-BH-A0E7-01A-11R-A034-07"
[85] "TCGA-A2-A0EM-01A-11R-A034-07" "TCGA-A2-A0EX-01A-21R-A034-07"
[87] "TCGA-BH-A0EB-01A-11R-A034-07" "TCGA-BH-A0HO-01A-11R-A034-07"

4

MIGSA: Getting TCGA datasets

[89] "TCGA-B6-A0I5-01A-11R-A034-07" "TCGA-B6-A0I8-01A-11R-A034-07"
[91] "TCGA-A2-A0EO-01A-11R-A034-07" "TCGA-A2-A0EV-01A-11R-A034-07"
[93] "TCGA-AN-A0FS-01A-11R-A034-07" "TCGA-BH-A0HQ-01A-11R-A034-07"
[95] "TCGA-AN-A0FN-01A-11R-A034-07" "TCGA-A7-A0CG-01A-12R-A056-07"
[97] "TCGA-AO-A0J8-01A-21R-A034-07" "TCGA-B6-A0IP-01A-11R-A034-07"
[99] "TCGA-AR-A0TR-01A-11R-A084-07" "TCGA-BH-A0DH-01A-11R-A084-07"
[101] "TCGA-AO-A0JG-01A-31R-A084-07" "TCGA-B6-A0RV-01A-11R-A084-07"
[103] "TCGA-BH-A0DQ-01A-11R-A084-07" "TCGA-B6-A0RN-01A-12R-A084-07"
[105] "TCGA-A2-A0EN-01A-13R-A084-07" "TCGA-B6-A0RO-01A-22R-A084-07"
[107] "TCGA-BH-A0HI-01A-11R-A084-07" "TCGA-A1-A0SE-01A-11R-A084-07"
[109] "TCGA-A2-A0SU-01A-11R-A084-07" "TCGA-A1-A0SH-01A-11R-A084-07"
[111] "TCGA-A2-A0T5-01A-21R-A084-07" "TCGA-B6-A0RP-01A-21R-A084-07"
[113] "TCGA-A2-A0T6-01A-11R-A084-07" "TCGA-BH-A0HP-01A-12R-A084-07"
[115] "TCGA-A2-A0SY-01A-31R-A084-07" "TCGA-BH-A18I-01A-11R-A12D-07"
[117] "TCGA-E2-A14Q-01A-11R-A12D-07" "TCGA-BH-A0BO-01A-23R-A12D-07"
[119] "TCGA-BH-A18S-01A-11R-A12D-07" "TCGA-E2-A15E-06A-11R-A12D-07"
[121] "TCGA-BH-A0DO-01B-11R-A12D-07" "TCGA-BH-A0DT-01A-21R-A12D-07"
[123] "TCGA-BH-A18M-01A-11R-A12D-07" "TCGA-E2-A15C-01A-31R-A12D-07"
[125] "TCGA-BH-A18N-01A-11R-A12D-07" "TCGA-C8-A133-01A-32R-A12D-07"
[127] "TCGA-E2-A15G-01A-11R-A12D-07" "TCGA-BH-A18H-01A-11R-A12D-07"
[129] "TCGA-E2-A153-01A-12R-A12D-07" "TCGA-E2-A15J-01A-11R-A12P-07"
[131] "TCGA-BH-A0AZ-01A-21R-A12P-07" "TCGA-E2-A1B4-01A-11R-A12P-07"
[133] "TCGA-BH-A0BS-01A-11R-A12P-07" "TCGA-BH-A0H3-01A-11R-A12P-07"
[135] "TCGA-AR-A1AN-01A-11R-A12P-07" "TCGA-BH-A0BT-01A-11R-A12P-07"
[137] "TCGA-BH-A0HA-01A-11R-A12P-07" "TCGA-BH-A1EU-01A-11R-A137-07"
[139] "TCGA-E2-A15I-01A-21R-A137-07" "TCGA-BH-A1EW-11B-33R-A137-07"
[141] "TCGA-BH-A1ET-01A-11R-A137-07" "TCGA-C8-A1HI-01A-11R-A137-07"

2. Getting the data with TCGAbiolinks R package

All the subject’s data mentioned in section 1 was downloaded by means of the TCGAbiolinks
R package, however, at the present this library had been greatly refactored, causing that this
code does not work unless some ﬁles are present in your hard drive, these ﬁles are available
upon request as they weigh too much. Below we show the code used to get both RDatas.

> ## Not run:
>
> library(TCGAbiolinks);
> R.Version()$version.string;
> # [1] "R version 3.2.3 (2015-12-10)"
> packageVersion("TCGAbiolinks");
> # [1] ‘1.0.10’
>
> query <- TCGAquery(tumor="BRCA");
> matSamples <- TCGAquery_integrate(query);

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

5

level=3);

level=3);

> # subjects in both microarray and RNAseq data
> matSamples["AgilentG4502A_07_3", "IlluminaHiSeq_RNASeq"];
> # [1] 495
>
> # we filter only microarray data
> geneExprSubjects <- TCGAquery(tumor="BRCA", platform="AgilentG4502A_07_3",
+
> # we filter only RNAseq data
> rnaSeqSubjects <- TCGAquery(tumor="BRCA", platform="IlluminaHiSeq_RNASeq",
+
> geneExprbarcodes <- geneExprSubjects$barcode;
> geneExprbarcodes <- strsplit(geneExprbarcodes, ",");
> geneExprbarcodes <- Reduce(union, geneExprbarcodes);
> rnaSeqbarcodes <- rnaSeqSubjects$barcode;
> rnaSeqbarcodes <- strsplit(rnaSeqbarcodes, ",");
> rnaSeqbarcodes <- Reduce(union, rnaSeqbarcodes);
> commonSubjects <- intersect(geneExprbarcodes, rnaSeqbarcodes);
> rm(geneExprbarcodes); rm(rnaSeqbarcodes);
> length(commonSubjects);
> # [1] 547
>
> # we filter microarray and RNAseq data (but just common subjects)
> geneExprSubjects <- TCGAquery(tumor="BRCA", platform="AgilentG4502A_07_3",
+
> rnaSeqSubjects <- TCGAquery(tumor="BRCA", platform="IlluminaHiSeq_RNASeq",
+
> #### this lines are the ones which are not working any more (TCGAdownload)
> # TCGAdownload(geneExprSubjects, path="geneExpr/", samples=commonSubjects);
> # TCGAdownload(rnaSeqSubjects,
> #
>
> ## However, we can provide you necessary files to skip the TCGAdownload step.
>
> ## type is any of:
> # RNASeq:
> #
> #
> # genome_wide_snp_6: hg18.seg
> #
> #
>
> geneExpr <- TCGAprepare(geneExprSubjects, dir="geneExpr/");
> rnaSeq <- TCGAprepare(rnaSeqSubjects, dir="rnaSeq/",
+
> library(SummarizedExperiment);
> assays(geneExpr);
> # names(1): raw_counts

exon.quantification
spljxn.quantification
gene.quantification

hg19.seg,nocnv_hg18.seg
nocnv_hg19.seg

samples=commonSubjects, level=3);

samples=commonSubjects, level=3);

type="gene.quantification");

type="gene.quantification");

samples=commonSubjects,

path="rnaSeq/",

6

MIGSA: Getting TCGA datasets

’

n=nrow(rnaSeq));

s get subjects subtypes

>
> # It would be a better way of conversion
> geneExpr <- head(assay(geneExpr, "raw_counts"), n=nrow(geneExpr));
> assays(rnaSeq);
> # names(3): raw_counts median_length_normalized RPKM
> rnaSeq_raw <- head(assay(rnaSeq, "raw_counts"), n=nrow(rnaSeq));
> rnaSeq_medianNorm <- head(assay(rnaSeq, "median_length_normalized"),
+
> rnaSeq_rpkm <- head(assay(rnaSeq, "RPKM"), n=nrow(rnaSeq));
> ## checking if we have the same subjects in every experiment
> stopifnot(all(colnames(geneExpr) %in% colnames(rnaSeq_raw)));
> stopifnot(all(colnames(rnaSeq_raw) %in% colnames(rnaSeq_medianNorm)));
> stopifnot(all(colnames(rnaSeq_medianNorm) %in% colnames(rnaSeq_rpkm)));
> stopifnot(all(colnames(rnaSeq_rpkm) %in% colnames(geneExpr)));
> mapping <- do.call(rbind, strsplit(rownames(rnaSeq_raw), "|", fixed=!F));
> colnames(mapping) <- c("Symbol", "Entrez");
> #### Now let
>
> library(genefu);
> rnaSeq <- rnaSeq_rpkm;
> rm(rnaSeq_rpkm);
> ## Also request this file!
> pam50Annot <- read.csv("pam50_annotation.txt",sep="\t");
> library(limma);
> dim(geneExpr);
> geneExpr <- avereps(geneExpr);
> dim(geneExpr);
> rownames(rnaSeq) <- mapping[, "Symbol" ];
> dim(rnaSeq);
> rnaSeq <- rnaSeq[ mapping[, "Symbol" ] != "?" , ];
> dim(rnaSeq);
> rnaSeq <- avereps(rnaSeq);
> dim(rnaSeq);
> geneExpr <- geneExpr[as.character(pam50Annot$GeneName),, drop=F];
> dim(geneExpr);
> rnaSeq <- rnaSeq[as.character(pam50Annot$GeneName),, drop=F];
> dim(rnaSeq);
> rnaSeq <- log(rnaSeq);
> pam50Annot <- pam50Annot[,c("GeneName", "EntrezGene")];
> colnames(pam50Annot) <- c("probe", "EntrezGene.ID");
> pam50Annot$probe <- as.character(pam50Annot$probe);
> ## get subtypes
> dataset <- apply(geneExpr, 1, as.numeric);
> rownames(dataset) <- colnames(geneExpr);
> subtypesGeneExpr <- intrinsic.cluster.predict(sbt.model=pam50.scale,
+
+

data=dataset, annot=pam50Annot, do.mapping=!F, do.prediction.strength=!F,
verbose=!F);

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

7

137

157

2
72

Her2
77

Her2
81

LumA
165

LumA
150

LumB Normal
62

LumB Normal
63

Basal
Her2
LumA
LumB
Normal

data=dataset, annot=pam50Annot, do.mapping=!F, do.prediction.strength=!F,
verbose=!F);

Basal Her2 LumA LumB Normal
1
1
3
1
57

> ## get subtypes
> dataset <- apply(rnaSeq, 1, as.numeric);
> rownames(dataset) <- colnames(rnaSeq);
> subtypesRnaSeq <- intrinsic.cluster.predict(sbt.model=pam50.scale,
+
+
> table(subtypesGeneExpr$subtype);
> # Basal
101
> #
>
> table(subtypesRnaSeq$subtype);
> # Basal
101
> #
>
> subtypesGeneExpr <- subtypesGeneExpr$subtype;
> subtypesRnaSeq <- subtypesRnaSeq$subtype[names(subtypesGeneExpr)];
> ## how many subjects got the same subtype between microarray and RNAseq data
> concSubtypes <- table(subtypesGeneExpr, subtypesRnaSeq);
> concSubtypes;
> #
1
> #
0
> #
0 142
> #
7
> #
> #
0
> sum(diag(concSubtypes)) / sum(concSubtypes);
> # [1] 0.9012797 # 90% of concordant subjects
>
> stopifnot(all(names(subtypesGeneExpr) == names(subtypesRnaSeq)));
> ## I am going to use the subjects that got the same classification in both
> subtypes <- subtypesGeneExpr[subtypesGeneExpr == subtypesRnaSeq];
> length(subtypes);
> # [1] 493
>
> #### Now just translate GeneSymbols to EntrezGene IDs
>
> ## Also request this file!
> annotAgi <- read.csv("AgilentG4502A_07_3.csv", sep="|");
> geneExprSymbol <- rownames(geneExpr);
> # we first search into Agilent annotation file
> geneExprEntrez <- annotAgi[ match(geneExprSymbol, annotAgi[, "Symbol"]),
+
> sum(is.na(geneExprEntrez));
> # [1] 796
> # then we look into the mapping given by RNASeq TCGA data
> geneExprEntrez[ is.na(geneExprEntrez) ] <- mapping[ match(geneExprSymbol[
+

is.na(geneExprEntrez) ], mapping[, "Symbol"]), "Entrez" ];

2
4
4
19 127
0

95
0
1
3
2

"Entrez" ];

3

8

MIGSA: Getting TCGA datasets

fixed=!F))[,2];

> sum(is.na(geneExprEntrez));
> # [1] 772
>
> geneExpr <- geneExpr[ !is.na(geneExprEntrez), ];
> rownames(geneExpr) <- geneExprEntrez[ !is.na(geneExprEntrez) ];
> dim(geneExpr);
> geneExpr <- avereps(geneExpr);
> dim(geneExpr);
> rownames(rnaSeq) <- do.call(rbind, strsplit(rownames(rnaSeq), "|",
+
> dim(rnaSeq);
> rnaSeq <- avereps(rnaSeq);
> dim(rnaSeq);
> load("rnaSeq_raw.RData");
> rownames(rnaSeq_raw) <- do.call(rbind, strsplit(rownames(rnaSeq_raw), "|",
+
> dim(rnaSeq_raw);
> rnaSeq_raw <- avereps(rnaSeq_raw);
> dim(rnaSeq_raw);
> #### And keep only Basal and Luminal A subjects
> rnaSeq_raw <- rnaSeq_raw[, names(subtypes)[subtypes %in% c("Basal", "LumA")] ];
> geneExpr <- geneExpr[, names(subtypes)[subtypes %in% c("Basal", "LumA")] ];
> subtypes <- subtypes[subtypes %in% c("Basal", "LumA")];
> ## And these are the two data objects used.
> tcgaRNAseqData <- list(rnaSeq=rnaSeq_raw, subtypes=subtypes);
> tcgaMAdata <- list(geneExpr=geneExpr, subtypes=subtypes);
> ## End(Not run)

fixed=!F))[,2];

Session Info

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C

Juan C Rodriguez, Crist´obal Fresno, Andrea S Llera, Elmer A Fern´andez

9

[9] LC_ADDRESS=C

LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:

[1] pbcmc_1.9.0
[4] e1071_1.7-0
[7] pamr_1.55

[10] mclust_5.4.1
[13] survival_2.43-1
[16] MIGSA_1.6.0
[19] mgcv_1.8-25
[22] limma_3.38.0
[25] GSEABase_1.44.0
[28] XML_3.98-1.16
[31] S4Vectors_0.20.0

genefu_2.14.0
iC10_1.4.2
cluster_2.0.7-1
survcomp_1.32.0
edgeR_3.24.0
mGSZ_1.0
nlme_3.1-137
GSA_1.03
graph_1.60.0
AnnotationDbi_1.44.0
Biobase_2.42.0

AIMS_1.14.0
iC10TrainingData_1.3.1
biomaRt_2.38.0
prodlim_2018.04.18
MIGSAdata_1.5.0
ismev_1.42
MASS_7.3-51
BiocParallel_1.16.0
annotate_1.60.0
IRanges_2.16.0
BiocGenerics_0.28.0

loaded via a namespace (and not attached):

[1] survivalROC_1.0.3
[3] breastCancerUNT_1.19.0
[5] matrixStats_0.54.0
[7] httr_1.3.1
[9] Rgraphviz_2.26.0

[11] R6_2.3.0
[13] KernSmooth_2.23-15
[15] lazyeval_0.2.1
[17] rmeta_3.0
[19] gridExtra_2.3
[21] tidyselect_0.2.5
[23] compiler_3.5.1
[25] breastCancerNKI_1.19.0
[27] labeling_0.3
[29] genefilter_1.64.0
[31] stringr_1.3.1
[33] breastCancerVDX_1.19.0
[35] pkgconfig_2.0.2
[37] RSQLite_2.1.1
[39] bindr_0.1.1
[41] dplyr_0.7.7
[43] magrittr_1.5
[45] futile.logger_1.4.3
[47] Rcpp_0.12.19
[49] stringi_1.2.4
[51] org.Hs.eg.db_3.7.0

Category_2.48.0
bitops_1.0-6
bit64_0.9-7
progress_1.2.0
tools_3.5.1
vegan_2.5-3
DBI_1.0.0
colorspace_1.3-2
permute_0.9-4
prettyunits_1.0.2
bit_1.1-14
formatR_1.5
ggdendro_0.1-20
scales_1.0.0
RBGL_1.58.0
digest_0.6.18
AnnotationForge_1.24.0
rlang_0.3.0.1
SuppDists_1.1-9.4
GOstats_2.48.0
RCurl_1.95-4.11
GO.db_3.7.0
Matrix_1.2-14
munsell_0.5.0
RJSONIO_1.3-0
plyr_1.8.4

10

MIGSA: Getting TCGA datasets

[53] breastCancerUPP_1.19.0
[55] blob_1.1.1
[57] crayon_1.3.4
[59] cowplot_0.9.3
[61] hms_0.4.2
[63] pillar_1.3.0
[65] futile.options_1.0.1
[67] lambda.r_1.2.3
[69] bootstrap_2017.2
[71] purrr_0.2.5
[73] assertthat_0.2.0
[75] xtable_1.8-3
[77] tibble_1.4.2
[79] bindrcpp_0.2.2
[81] breastCancerMAINZ_1.19.0

grid_3.5.1
breastCancerTRANSBIG_1.19.0
lattice_0.20-35
splines_3.5.1
locfit_1.5-9.1
reshape2_1.4.3
glue_1.3.0
data.table_1.11.8
gtable_0.2.0
amap_0.8-16
ggplot2_3.1.0
class_7.3-14
memoise_1.1.0
lava_1.6.3

Aﬃliation:

Juan C Rodriguez & Elmer A Fern´andez
Bioscience Data Mining Group
Facultad de Ingenier´ıa
Universidad Cat´olica de C´ordoba - CONICET
X5016DHK C´ordoba, Argentina
E-mail: jcrodriguez@bdmg.com.ar, efernandez@bdmg.com.ar
URL: http://www.bdmg.com.ar/

