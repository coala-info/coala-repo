Package ‘CVE’

April 11, 2018

Title Cancer Variant Explorer

Version 1.4.0

Author Andreas Mock [aut, cre]

Maintainer Andreas Mock <mock.science@gmail.com>

Description Shiny app for interactive variant prioritisation in precision oncology. The in-

put ﬁle for CVE is the output ﬁle of the recently released Oncotator Variant Annotation tool sum-
marising variant-centric information from 14 different publicly available resources rele-
vant for cancer researches. Interactive priortisation in CVE is based on known germline and can-
cer variants, DNA repair genes and functional prediction scores. An optional fea-
ture of CVE is the exploration of the tumour-speciﬁc pathway context that is facilitated using co-
expression modules generated from publicly available transcriptome data. Finally druggabil-
ity of prioritised variants is assessed using the Drug Gene Interaction Database (DGIdb).

Depends R (>= 3.4.0)

Imports shiny, ConsensusClusterPlus, RColorBrewer, gplots, plyr,

ggplot2, jsonlite, ape, WGCNA

License GPL-3

Encoding UTF-8

LazyData true

RoxygenNote 6.0.1

Suggests knitr, rmarkdown, RTCGAToolbox, testthat, BiocStyle

VignetteBuilder knitr

biocViews BiomedicalInformatics

NeedsCompilation no

R topics documented:

.

.

.

.
.
crcCase .
genes_WGCNA .
.
get.oncotator.anno .
.
.
GS_lscore .
.
.
.
GS_pmet
.
GS_survival .
.
.
GS_UV .
.
.
GS_Vem .
.
.
label_order

.
.
.
.
.
.

.
.
.
.
.
.

.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
2
3
3
3
3
3
4

1

2

get.oncotator.anno

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4
4
4
4
5
5
5
5
5
6
6
6
6
6
7

8

Example Oncotator output for the single-patient colorectal cancer
sample

.

melanomaCase .
.
METree_GO .
.
.
.
.
.
.
MM .
.
.
.
modules .
.
.
MS_lscore .
.
.
.
MS_lscore_bar
.
.
.
MS_pmet
.
MS_pmet_bar .
MS_survival .
.
.
MS_survival_bar
.
.
MS_UV .
.
MS_UV_bar .
MS_vem .
.
.
MS_Vem_bar .
.
openCVE .

.
.
.
.
.

.

.

.

Index

crcCase

Description

An Oncotator MAF ﬁle

genes_WGCNA

Top 5000 most variant genes in TCGA RNAseq data

Description

A dataset containing the top 5000 most variant genes in TCGA RNAseq data for WGCNAmelanoma
extension

get.oncotator.anno

Open Cancer Variant Explorer (CVE) Shiny app

Description

The get.oncotator.anno retrieves annotation from the Oncotator database.

Usage

get.oncotator.anno(x)

Arguments

x

A matrix containing the columns chromosome, start, end, reference_allele and
observed_allele.

GS_lscore

Examples

exCase <- data.frame(chr = rep(10, 3),

start = c("100894110", "100985376", "101137905"),
end = c("100894110", "100985376", "101137905"),
ref_allele = c("T", "C", "G"),
obs_allele = c("G", "A", "A"))

get.oncotator.anno(exCase)

3

GS_lscore

Lymphocyte score gene signiﬁcance (GS)

Description

A dataset containing the lymphocyte score gene signﬁcance for WGCNAmelanoma extension

GS_pmet

Primary vs metastasis gene signiﬁcance (GS)

Description

A dataset containing the primary vs metastases gene signﬁcance for WGCNAmelanoma extension

GS_survival

Survival gene signiﬁcance (GS)

Description

A dataset containing the survival gene signﬁcance for WGCNAmelanoma extension

GS_UV

UV signature gene signiﬁcance (GS)

Description

A dataset containing the UV signature gene signﬁcance for WGCNAmelanoma extension

GS_Vem

Vemurafenib resistance gene signiﬁcance (GS)

Description

A dataset containing the vemurafenib resistance gene signﬁcance for WGCNAmelanoma extension

4

modules

label_order

Label order of co-expression modules

Description

A dataset containing the label order of co-expression modules for WGCNAmelanoma extension

melanomaCase

Example Oncotator output for the melanoma cohort study described
in the paper

Description

An Oncotator MAF ﬁle

METree_GO

Gene tree of co-expression network

Description

A dataset containing the gene tree of co-expression network for WGCNAmelanoma extension

MM

Module membership

Description

A dataset containing the module membership for WGCNAmelanoma extension

modules

Module assignment of top 5000 most variant genes in TCGA RNAseq
data

Description

A dataset containing the module assignment top 5000 most variant genes in TCGA RNAseq data
for WGCNAmelanoma extension

MS_lscore

5

MS_lscore

Lymphocyte score module signiﬁcance (MS)

Description

A dataset containing the lymphocyte score module signﬁcance for WGCNAmelanoma extension

MS_lscore_bar

Lymphocyte score module signiﬁcance scaled for barplot

Description

A dataset containing the lymphocyte score module signﬁcance scaled for barplot for WGCNAme-
lanoma extension

MS_pmet

Primary vs metastasis module signiﬁcance (MS)

Description

A dataset containing the primary vs metastases module signﬁcance for WGCNAmelanoma exten-
sion

MS_pmet_bar

Primary vs metastasis module signiﬁcance scaled for barplot

Description

A dataset containing the primary vs metastases module signﬁcance scaled for barplot for WGC-
NAmelanoma extension

MS_survival

Survival module signiﬁcance (MS)

Description

A dataset containing the survival module signﬁcance for WGCNAmelanoma extension

6

MS_Vem_bar

MS_survival_bar

Survival module signiﬁcance scaled for barplot

Description

A dataset containing the survival module signﬁcance scaled for barplot for WGCNAmelanoma
extension

MS_UV

UV signature module signiﬁcance (MS)

Description

A dataset containing the UV signature module signﬁcance for WGCNAmelanoma extension

MS_UV_bar

UV signature module signiﬁcance scaled for barplot

Description

A dataset containing the UV signature module signﬁcance scaled for barplot for WGCNAmelanoma
extension

MS_vem

Vemurafenib resistance module signiﬁcance (MS)

Description

A dataset containing the vemurafenib resistance module signﬁcance for WGCNAmelanoma exten-
sion

MS_Vem_bar

Vemurafenib resistance module signiﬁcance scaled for barplot

Description

A dataset containing the vemurafenib resistance module signﬁcance scaled for barplot for WGC-
NAmelanoma extension

openCVE

7

openCVE

Open Cancer Variant Explorer (CVE) Shiny app

Description

The openCVE function opens the CVE Shiny app. The function to supplement the R package with
the Shiny app was suggested by Dean Attali (http://deanattali.com). Currently, the only extension
available is a melanoma co-expression network (WGCNAmelanoma).

Usage

openCVE(x, sample_names = NULL, extension = FALSE)

Arguments

x

A dataframe (for single ﬁle) or list (for multiple oncotator output ﬁles)

sample_names

A character vector with sample name(s)

extension

A character vector of extention name

Examples

openCVE(crcCase,"case study")
openCVE(melanomaCase,"case study WGCNA",extension="WGCNAmelanoma")

Index

∗Topic datasets

crcCase, 2
genes_WGCNA, 2
GS_lscore, 3
GS_pmet, 3
GS_survival, 3
GS_UV, 3
GS_Vem, 3
label_order, 4
melanomaCase, 4
METree_GO, 4
MM, 4
modules, 4
MS_lscore, 5
MS_lscore_bar, 5
MS_pmet, 5
MS_pmet_bar, 5
MS_survival, 5
MS_survival_bar, 6
MS_UV, 6
MS_UV_bar, 6
MS_vem, 6
MS_Vem_bar, 6

crcCase, 2

genes_WGCNA, 2
get.oncotator.anno, 2
GS_lscore, 3
GS_pmet, 3
GS_survival, 3
GS_UV, 3
GS_Vem, 3

label_order, 4

melanomaCase, 4
METree_GO, 4
MM, 4
modules, 4
MS_lscore, 5
MS_lscore_bar, 5
MS_pmet, 5
MS_pmet_bar, 5

MS_survival, 5
MS_survival_bar, 6
MS_UV, 6
MS_UV_bar, 6
MS_vem, 6
MS_Vem_bar, 6

openCVE, 7

8

