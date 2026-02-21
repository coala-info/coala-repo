Package ‘MIGSAdata’

April 11, 2019

Title MIGSA vignette data

Version 1.6.0

Author Juan C. Rodriguez, Cristobal Fresno, Andrea S. Llera and Elmer

A. Fernandez

Maintainer Juan C. Rodriguez <jcrodriguez@bdmg.com.ar>

Description MIGSA vignette data. The MIGSAdata package provides
several data objects needed by MIGSA package to correctly
generate its vignette, and follow it step by step.

URL http://www.bdmg.com.ar/

biocViews ExperimentData, RepositoryData, ReproducibleResearch,

CancerData, BreastCancerData, MicroarrayData

License GPL (>= 2)

Depends R (>= 3.4)

Suggests BiocGenerics

RoxygenNote 5.0.1

git_url https://git.bioconductor.org/packages/MIGSAdata

git_branch RELEASE_3_8

git_last_commit 2fccd05

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

bcMigsaResAsList
.
.
mGSZspeedup .
.
.
.
MIGSAdata .
.
.
.
pbcmcData
.
.
.
.
tcgaMAdata .
tcgaRNAseqData .

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

Index

1

2
2
3
3
4
4

5

2

mGSZspeedup

bcMigsaResAsList

A MIGSA results object obtained from breast cancer data.

Description

A MIGSA results object obtained using the datasets:

• mainz (microarray).

• nki (microarray).

• tcga (microarray).

• tcga (RNAseq).

• transbig (microarray).

• unt (microarray).

• upp (microarray).

• vdx (microarray).

Format

A list with two main components to create the MIGSAres object

Details

Each dataset subjects were classiﬁed using the PAM50 algorithm. For this analysis only Basal and
Luminal A subjects were kept (this was the contrast used, i.e., Basal vs. LumA).

Datasets were tested for gene set enrichment over:

• the org.Hs.eg.db Gene Ontology gene sets, resulting in 14,291 as BP, 1,692 CC and 4,263 MF.

• KEGG gene sets downloaded from enrichr database resulting in 179 gene sets.

In order to get the MIGSAres object follow: library(MIGSAdata); library(MIGSA); data(bcMigsaResAsList);
bcMigsaRes <- MIGSA:::MIGSAres.data.table(bcMigsaResAsList$dframe, bcMigsaResAsList$genesRank);

mGSZspeedup

Speedup between mGSZ and MIGSAmGSZ.

Description

A list with several benchmark timings used to show MIGSAmGSZ’s speedup against mGSZ.

Format

A list with some timing bencharmks.

MIGSAdata

3

MIGSAdata

MIGSAdata package

Description

The MIGSAdata package provides several data objects needed by MIGSA package to correctly
generate its vignette, and follow it step by step.

Author(s)

Juan C. Rodriguez <jcrodriguez@bdmg.com.ar>, Cristobal Fresno <cfresno@bdmg.com.ar>, An-
drea S. Llera <allera@leloir.org.ar> and Elmer A. Fernandez <efernandez@bdmg.com.ar>

References

1. Rodriguez, J. C., Gonzalez, G. A., Fresno, C., Llera, A. S., & Fernandez, E. A. (2016). Im-
proving information retrieval in functional analysis. Computers in Biology and Medicine, 79,
10-20.

pbcmcData

Pbcmc breast cancer microarray data.

Description

Pbcmc package lets download breast cancer microarray datasets, for each, here we include its ex-
presion matrix and each subjects subtypes. Each dataset subjects were classiﬁed using the PAM50
algorithm. Only Basal and Luminal A subjects were kept. Datasets are:

• mainz.

• nki.

• transbig.

• unt.

• upp.

• vdx.

Details in how this datasets were obtained can be ﬁnd in MIGSA’s gettingPbcmcData vignette.

Format

A list containing six lists (one per dataset), each one contains gene expression as data.frame and
subtypes as vector.

4

tcgaRNAseqData

tcgaMAdata

TCGA breast cancer microarray data.

Description

TCGA breast cancer microarray expresion matrix and each subjects subtypes. Each dataset subjects
were classiﬁed using the PAM50 algorithm. Only Basal and Luminal A subjects were kept. Details
in how this dataset was obtained can be ﬁnd in MIGSA’s gettingTcgaData vignette.

Format

A list with gene expression as data.frame and subtypes as vector.

tcgaRNAseqData

TCGA breast cancer RNAseq data.

Description

TCGA breast cancer RNAseq expresion matrix and each subjects subtypes. Each dataset subjects
were classiﬁed using the PAM50 algorithm. Only Basal and Luminal A subjects were kept. Details
in how this dataset was obtained can be ﬁnd in MIGSA’s gettingTcgaData vignette.

Format

A list with gene expression as data.frame and subtypes as vector.

Index

∗Topic MIGSA
MIGSAdata, 3

∗Topic data

MIGSAdata, 3

∗Topic objects

MIGSAdata, 3

bcMigsaResAsList, 2

mGSZspeedup, 2
MIGSAdata, 3

pbcmcData, 3

tcgaMAdata, 4
tcgaRNAseqData, 4

5

